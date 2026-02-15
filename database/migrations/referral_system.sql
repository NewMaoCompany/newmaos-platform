-- ============================================================
-- Referral System Migration
-- Adds referral_code and referred_by to user_profiles
-- Auto-generates referral codes and awards 100 pts on referral
-- ============================================================

-- 1. Add columns
ALTER TABLE public.user_profiles ADD COLUMN IF NOT EXISTS referral_code TEXT UNIQUE;
ALTER TABLE public.user_profiles ADD COLUMN IF NOT EXISTS referred_by UUID REFERENCES public.user_profiles(id);

-- 2. Generate referral codes for existing users who don't have one
UPDATE public.user_profiles
SET referral_code = upper(substr(md5(id::text || random()::text), 1, 6))
WHERE referral_code IS NULL;

-- 3. Function to auto-generate referral_code on new user insert
CREATE OR REPLACE FUNCTION generate_referral_code()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.referral_code IS NULL THEN
        NEW.referral_code := upper(substr(md5(NEW.id::text || random()::text), 1, 6));
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_generate_referral_code ON public.user_profiles;
CREATE TRIGGER trg_generate_referral_code
    BEFORE INSERT ON public.user_profiles
    FOR EACH ROW
    EXECUTE FUNCTION generate_referral_code();

-- 4. Function to award referral points when referred_by is set
CREATE OR REPLACE FUNCTION award_referral_points()
RETURNS TRIGGER AS $$
BEGIN
    -- Only fire when referred_by is newly set (was NULL, now has a value)
    IF NEW.referred_by IS NOT NULL AND (OLD.referred_by IS NULL OR TG_OP = 'INSERT') THEN
        INSERT INTO public.pending_points (user_id, amount, type, source_id, description)
        VALUES (
            NEW.referred_by,
            100,
            'referral',
            NEW.id::TEXT,
            'A friend you invited joined NewMaoS! 🎉'
        );
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

DROP TRIGGER IF EXISTS trg_award_referral_points ON public.user_profiles;
CREATE TRIGGER trg_award_referral_points
    AFTER INSERT OR UPDATE OF referred_by ON public.user_profiles
    FOR EACH ROW
    EXECUTE FUNCTION award_referral_points();

-- 5. RPC function to process referral (bypasses RLS timing issues)
-- Called from frontend after new user signs up and verifies email
CREATE OR REPLACE FUNCTION public.process_referral(p_referral_code TEXT)
RETURNS JSONB AS $$
DECLARE
    v_referrer_id UUID;
    v_current_user_id UUID;
    v_already_referred BOOLEAN;
BEGIN
    v_current_user_id := auth.uid();
    
    IF v_current_user_id IS NULL THEN
        RETURN jsonb_build_object('success', false, 'error', 'Not authenticated');
    END IF;

    -- Check if user was already referred
    SELECT (referred_by IS NOT NULL) INTO v_already_referred
    FROM public.user_profiles
    WHERE id = v_current_user_id;

    IF v_already_referred THEN
        RETURN jsonb_build_object('success', false, 'error', 'Already referred');
    END IF;

    -- Look up referrer by code
    SELECT id INTO v_referrer_id
    FROM public.user_profiles
    WHERE referral_code = upper(p_referral_code);

    IF v_referrer_id IS NULL THEN
        RETURN jsonb_build_object('success', false, 'error', 'Invalid referral code');
    END IF;

    -- Don't allow self-referral
    IF v_referrer_id = v_current_user_id THEN
        RETURN jsonb_build_object('success', false, 'error', 'Cannot refer yourself');
    END IF;

    -- Set referred_by on new user
    UPDATE public.user_profiles
    SET referred_by = v_referrer_id
    WHERE id = v_current_user_id;

    -- Award 100 points to referrer
    INSERT INTO public.pending_points (user_id, amount, type, source_id, description)
    VALUES (v_referrer_id, 100, 'referral', v_current_user_id::TEXT, 'A friend you invited joined NewMaoS! 🎉');

    RETURN jsonb_build_object('success', true, 'referrer_id', v_referrer_id);
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
