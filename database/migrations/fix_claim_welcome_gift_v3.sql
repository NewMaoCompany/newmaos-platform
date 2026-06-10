-- ============================================================
-- FIX: claim_welcome_gift RPC
-- Uses has_claimed_welcome_gift flag (not user_points_transactions)
-- Uses points_ledger for award (matching award_points RPC)
-- ============================================================

CREATE OR REPLACE FUNCTION public.claim_welcome_gift()
RETURNS JSONB AS $$
DECLARE
    v_user_id UUID;
    v_already_claimed BOOLEAN;
BEGIN
    v_user_id := auth.uid();
    IF v_user_id IS NULL THEN
        RETURN jsonb_build_object('success', false, 'reason', 'not_authenticated');
    END IF;

    -- Check if gift already claimed via profile flag
    SELECT COALESCE(has_claimed_welcome_gift, false) 
    INTO v_already_claimed
    FROM public.user_profiles 
    WHERE id = v_user_id;

    IF v_already_claimed THEN
        RETURN jsonb_build_object('success', false, 'reason', 'already_claimed');
    END IF;

    -- Ensure user_points row exists
    INSERT INTO public.user_points (user_id, balance, lifetime_earned)
    VALUES (v_user_id, 0, 0)
    ON CONFLICT (user_id) DO NOTHING;

    -- Award 200 coins via points_ledger (idempotent)
    INSERT INTO public.points_ledger (user_id, amount, type, source_id, description, idempotency_key)
    VALUES (v_user_id, 200, 'manual_adjustment', 'welcome_gift', 'Welcome Gift', 'welcome_gift_' || v_user_id::TEXT)
    ON CONFLICT (idempotency_key) DO NOTHING;

    -- Update balance in user_points
    UPDATE public.user_points
    SET balance = balance + 200,
        lifetime_earned = lifetime_earned + 200
    WHERE user_id = v_user_id;

    -- Mark as claimed in profile
    UPDATE public.user_profiles
    SET has_claimed_welcome_gift = true
    WHERE id = v_user_id;

    RETURN jsonb_build_object('success', true, 'amount', 200);

EXCEPTION WHEN OTHERS THEN
    -- If points_ledger doesn't have idempotency_key or other issues, fall back to direct insert
    BEGIN
        -- Simpler fallback: just update points and mark claimed
        INSERT INTO public.user_points (user_id, balance, lifetime_earned)
        VALUES (v_user_id, 200, 200)
        ON CONFLICT (user_id) DO UPDATE
            SET balance = user_points.balance + 200,
                lifetime_earned = user_points.lifetime_earned + 200;

        UPDATE public.user_profiles
        SET has_claimed_welcome_gift = true
        WHERE id = v_user_id;

        RETURN jsonb_build_object('success', true, 'amount', 200, 'fallback', true);
    EXCEPTION WHEN OTHERS THEN
        RETURN jsonb_build_object('success', false, 'reason', SQLERRM);
    END;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
