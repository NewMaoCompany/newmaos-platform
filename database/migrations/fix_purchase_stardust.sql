-- Fix purchase_stardust RPC
-- 1. Use 'user_points' table instead of missing 'points_ledger_balance' view
-- 2. Use 'manual_adjustment' for points_ledger type (as 'SPEND' is not in CHECK constraint)
-- 3. Correctly update user_points balance

CREATE OR REPLACE FUNCTION purchase_stardust(amount_coins INT)
RETURNS JSONB
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
    v_user_id UUID;
    v_current_balance INT;
    v_new_stardust INT;
BEGIN
    v_user_id := auth.uid();
    -- 1 Coin = 10 Stardust
    v_new_stardust := amount_coins * 10;

    -- 1. Check Balance from REAL table (user_points)
    SELECT balance INTO v_current_balance 
    FROM public.user_points 
    WHERE user_id = v_user_id;
    
    -- Handle case where user has no entry in user_points yet
    IF v_current_balance IS NULL THEN
        v_current_balance := 0;
    END IF;

    IF v_current_balance < amount_coins THEN
        RETURN jsonb_build_object('success', false, 'message', 'Insufficient coins');
    END IF;

    -- 2. Deduct Coins from user_points
    UPDATE public.user_points
    SET balance = balance - amount_coins,
        updated_at = NOW()
    WHERE user_id = v_user_id;

    -- 3. Record in points_ledger
    -- Using 'manual_adjustment' as it is a valid enum/check value. 
    -- 'SPEND' was invalid.
    INSERT INTO public.points_ledger (user_id, amount, type, description)
    VALUES (v_user_id, -amount_coins, 'manual_adjustment', 'Purchased Stardust');

    -- 4. Add Stardust to user_prestige
    INSERT INTO public.user_prestige (user_id, current_stardust, total_stardust_collected)
    VALUES (v_user_id, v_new_stardust, v_new_stardust)
    ON CONFLICT (user_id) DO UPDATE
    SET 
        current_stardust = user_prestige.current_stardust + EXCLUDED.current_stardust,
        total_stardust_collected = user_prestige.total_stardust_collected + EXCLUDED.total_stardust_collected,
        updated_at = NOW();

    -- Return success
    RETURN jsonb_build_object('success', true, 'new_stardust', v_new_stardust);
END;
$$;
