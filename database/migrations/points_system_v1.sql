-- ============================================================
-- Points Economy System v1
-- Creates: user_points, points_ledger tables + core RPCs
-- ============================================================

-- 1. POINTS BALANCE TABLE
CREATE TABLE IF NOT EXISTS public.user_points (
    user_id UUID PRIMARY KEY REFERENCES public.user_profiles(id) ON DELETE CASCADE,
    balance INTEGER NOT NULL DEFAULT 0,
    lifetime_earned INTEGER NOT NULL DEFAULT 0,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- 2. POINTS LEDGER (Transaction Log)
CREATE TABLE IF NOT EXISTS public.points_ledger (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES public.user_profiles(id) ON DELETE CASCADE,
    amount INTEGER NOT NULL,
    type TEXT NOT NULL CHECK (type IN (
        'practice_complete', 'unit_test_complete', 'error_correction',
        'daily_checkin', 'checkin_bonus',
        'like_received', 'comment_received', 'follower_gained', 'friend_added',
        'pro_redeem', 'manual_adjustment'
    )),
    source_id TEXT,
    description TEXT NOT NULL DEFAULT '',
    idempotency_key TEXT UNIQUE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_points_ledger_user ON public.points_ledger(user_id);
CREATE INDEX IF NOT EXISTS idx_points_ledger_type ON public.points_ledger(user_id, type);
CREATE INDEX IF NOT EXISTS idx_points_ledger_created ON public.points_ledger(user_id, created_at DESC);

-- Enable RLS
ALTER TABLE public.user_points ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.points_ledger ENABLE ROW LEVEL SECURITY;

-- RLS Policies: Users can read their own data
CREATE POLICY "Users can view own points" ON public.user_points
    FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY "Users can view own ledger" ON public.points_ledger
    FOR SELECT USING (auth.uid() = user_id);

-- ============================================================
-- 3. RPC: award_points (Idempotent Points Award)
-- ============================================================
CREATE OR REPLACE FUNCTION public.award_points(
    p_user_id UUID,
    p_amount INTEGER,
    p_type TEXT,
    p_source_id TEXT DEFAULT NULL,
    p_description TEXT DEFAULT '',
    p_idempotency_key TEXT DEFAULT NULL
)
RETURNS JSONB AS $$
DECLARE
    v_new_balance INTEGER;
BEGIN
    -- Idempotency check: if key already exists, return existing record
    IF p_idempotency_key IS NOT NULL THEN
        IF EXISTS (SELECT 1 FROM public.points_ledger WHERE idempotency_key = p_idempotency_key) THEN
            RETURN jsonb_build_object('success', false, 'reason', 'duplicate', 'message', 'Points already awarded for this action');
        END IF;
    END IF;

    -- Validate amount
    IF p_amount = 0 THEN
        RETURN jsonb_build_object('success', false, 'reason', 'zero_amount');
    END IF;

    -- Ensure user_points row exists
    INSERT INTO public.user_points (user_id, balance, lifetime_earned)
    VALUES (p_user_id, 0, 0)
    ON CONFLICT (user_id) DO NOTHING;

    -- Atomic update: balance + ledger entry
    IF p_amount > 0 THEN
        UPDATE public.user_points
        SET balance = balance + p_amount,
            lifetime_earned = lifetime_earned + p_amount,
            updated_at = NOW()
        WHERE user_id = p_user_id;
    ELSE
        -- Deduction (e.g., pro_redeem)
        UPDATE public.user_points
        SET balance = balance + p_amount,  -- p_amount is negative
            updated_at = NOW()
        WHERE user_id = p_user_id;
    END IF;

    -- Record in ledger
    INSERT INTO public.points_ledger (user_id, amount, type, source_id, description, idempotency_key)
    VALUES (p_user_id, p_amount, p_type, p_source_id, p_description, p_idempotency_key);

    -- Get new balance
    SELECT balance INTO v_new_balance FROM public.user_points WHERE user_id = p_user_id;

    RETURN jsonb_build_object('success', true, 'new_balance', v_new_balance, 'awarded', p_amount);
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- ============================================================
-- 4. RPC: redeem_pro_with_points (1999 Points -> Pro Monthly)
-- ============================================================
CREATE OR REPLACE FUNCTION public.redeem_pro_with_points(p_user_id UUID)
RETURNS JSONB AS $$
DECLARE
    v_balance INTEGER;
    v_cost INTEGER := 199;
    v_period_end TIMESTAMPTZ;
    v_idem_key TEXT;
BEGIN
    -- Get current balance
    SELECT balance INTO v_balance FROM public.user_points WHERE user_id = p_user_id;

    IF v_balance IS NULL OR v_balance < v_cost THEN
        RETURN jsonb_build_object(
            'success', false,
            'reason', 'insufficient_points',
            'balance', COALESCE(v_balance, 0),
            'cost', v_cost,
            'shortfall', v_cost - COALESCE(v_balance, 0)
        );
    END IF;

    -- Calculate new period end (1 month from now, or extend existing)
    SELECT subscription_period_end INTO v_period_end FROM public.user_profiles WHERE id = p_user_id;
    IF v_period_end IS NOT NULL AND v_period_end > NOW() THEN
        v_period_end := v_period_end + INTERVAL '1 month';
    ELSE
        v_period_end := NOW() + INTERVAL '1 month';
    END IF;

    -- Idempotency key: one redemption per month
    v_idem_key := 'pro_redeem_' || p_user_id || '_' || to_char(NOW(), 'YYYY-MM');

    -- Check if already redeemed this month
    IF EXISTS (SELECT 1 FROM public.points_ledger WHERE idempotency_key = v_idem_key) THEN
        RETURN jsonb_build_object('success', false, 'reason', 'already_redeemed_this_month');
    END IF;

    -- Deduct points
    UPDATE public.user_points
    SET balance = balance - v_cost, updated_at = NOW()
    WHERE user_id = p_user_id;

    -- Record in ledger
    INSERT INTO public.points_ledger (user_id, amount, type, description, idempotency_key)
    VALUES (p_user_id, -v_cost, 'pro_redeem', 'Pro Monthly Subscription', v_idem_key);

    -- Upgrade user to Pro
    UPDATE public.user_profiles
    SET subscription_tier = 'pro',
        subscription_period_end = v_period_end
    WHERE id = p_user_id;

    RETURN jsonb_build_object(
        'success', true,
        'new_balance', (SELECT balance FROM public.user_points WHERE user_id = p_user_id),
        'period_end', v_period_end
    );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- ============================================================
-- 5. RPC: get_points_summary (Balance + Recent Ledger)
-- ============================================================
CREATE OR REPLACE FUNCTION public.get_points_summary(p_user_id UUID)
RETURNS JSONB AS $$
DECLARE
    v_balance INTEGER;
    v_lifetime INTEGER;
    v_recent JSONB;
BEGIN
    -- Ensure row exists
    INSERT INTO public.user_points (user_id, balance, lifetime_earned)
    VALUES (p_user_id, 0, 0)
    ON CONFLICT (user_id) DO NOTHING;

    SELECT balance, lifetime_earned INTO v_balance, v_lifetime
    FROM public.user_points WHERE user_id = p_user_id;

    SELECT COALESCE(jsonb_agg(row_to_json(t)), '[]'::jsonb) INTO v_recent
    FROM (
        SELECT amount, type, description, created_at
        FROM public.points_ledger
        WHERE user_id = p_user_id
        ORDER BY created_at DESC
        LIMIT 20
    ) t;

    RETURN jsonb_build_object(
        'balance', COALESCE(v_balance, 0),
        'lifetime_earned', COALESCE(v_lifetime, 0),
        'recent_transactions', v_recent
    );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
