-- 1. Update points_ledger constraint to include streak_repair
ALTER TABLE public.points_ledger DROP CONSTRAINT IF EXISTS points_ledger_type_check;
ALTER TABLE public.points_ledger ADD CONSTRAINT points_ledger_type_check CHECK (type IN (
    'practice_complete', 'unit_test_complete', 'error_correction',
    'daily_checkin', 'checkin_bonus',
    'like_received', 'comment_received', 'follower_gained', 'friend_added',
    'pro_redeem', 'manual_adjustment', 'streak_repair'
));

-- 2. Update use_monthly_repair RPC
CREATE OR REPLACE FUNCTION public.use_monthly_repair(user_uuid UUID)
RETURNS JSONB
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
    v_balance INTEGER;
    v_cost INTEGER := 100;
    v_prev_streak INTEGER;
    v_current_streak INTEGER;
BEGIN
    -- Get current balance and streak info
    SELECT up.balance, upr.prev_streak_days, upr.streak_days
    INTO v_balance, v_prev_streak, v_current_streak
    FROM public.user_profiles upr
    JOIN public.user_points up ON up.user_id = upr.id
    WHERE upr.id = user_uuid;

    -- 1. Check if there is a streak to repair
    -- (Usually if streak is 1 or last_login was missed)
    IF v_prev_streak IS NULL OR v_prev_streak <= 0 THEN
         RETURN jsonb_build_object('success', false, 'message', 'No streak found to repair.');
    END IF;

    -- 2. Check points balance
    IF v_balance < v_cost THEN
        RETURN jsonb_build_object(
            'success', false, 
            'reason', 'insufficient_points',
            'message', 'Insufficient points. Need 100 points to repair streak.',
            'shortfall', v_cost - v_balance
        );
    END IF;

    -- 3. Deduct points
    UPDATE public.user_points
    SET balance = balance - v_cost,
        updated_at = NOW()
    WHERE user_id = user_uuid;

    -- 4. Record in ledger
    INSERT INTO public.points_ledger (user_id, amount, type, description)
    VALUES (user_uuid, -v_cost, 'streak_repair', 'Streak Restoration Fee');

    -- 5. Restore streak (prev + 1 for today)
    UPDATE public.user_profiles
    SET streak_days = v_prev_streak + 1,
        prev_streak_days = 0, -- consume backup
        last_repair_at = now(),
        last_login_at = now() -- Update login time so it doesn't break again immediately
    WHERE id = user_uuid;

    RETURN jsonb_build_object(
        'success', true, 
        'new_streak', v_prev_streak + 1,
        'new_balance', v_balance - v_cost
    );
END;
$$;
