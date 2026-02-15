-- ============================================================
-- FIX CLAIM ERROR V2 - ULTIMATE FIX
-- ============================================================

-- 1. Explicitly Grant permissions to the table
GRANT ALL ON public.pending_points TO postgres, service_role, authenticated;

-- 2. Drop existing function to ensure clean slate
DROP FUNCTION IF EXISTS public.claim_pending_points();

-- 3. Re-create the function with SECURITY DEFINER and robust logic
CREATE OR REPLACE FUNCTION public.claim_pending_points()
RETURNS TABLE(claimed_amount INTEGER, claimed_count INTEGER) AS $$
DECLARE
    v_user_id UUID;
    v_total_amount INTEGER;
    v_count INTEGER;
    v_batch_id TEXT;
BEGIN
    -- Get current user ID
    v_user_id := auth.uid();
    
    IF v_user_id IS NULL THEN
        RAISE EXCEPTION 'Not authenticated';
    END IF;
    
    -- Calculate total pending amount
    SELECT COALESCE(SUM(amount), 0), COUNT(*)
    INTO v_total_amount, v_count
    FROM public.pending_points
    WHERE user_id = v_user_id AND claimed = FALSE;
    
    -- If nothing to claim, return 0
    IF v_total_amount = 0 THEN
        RETURN QUERY SELECT 0, 0;
        RETURN;
    END IF;

    -- Generate a unique batch ID for this transaction
    v_batch_id := 'claim_' || v_user_id || '_' || EXTRACT(EPOCH FROM NOW())::TEXT;

    -- Execute award_points
    -- We use PERFORM to discard the result
    -- We wrap in a block to catch any potential errors from award_points
    BEGIN
        PERFORM public.award_points(
            v_user_id,             -- p_user_id
            v_total_amount,        -- p_amount
            'manual_adjustment',   -- p_type (using a known valid ENUM type from points_ledger)
            'pending_claim',       -- p_source_id (can be anything)
            'Claimed ' || v_count || ' rewards', -- p_description
            v_batch_id             -- p_idempotency_key
        );
    EXCEPTION WHEN OTHERS THEN
        -- Log error but re-raise to notify frontend
        RAISE EXCEPTION 'Failed to award points: %', SQLERRM;
    END;
        
    -- Mark as claimed
    UPDATE public.pending_points
    SET claimed = TRUE, 
        claimed_at = NOW()
    WHERE user_id = v_user_id AND claimed = FALSE;
    
    -- Return result
    RETURN QUERY SELECT v_total_amount, v_count;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- 4. Grant Execute permissions
GRANT EXECUTE ON FUNCTION public.claim_pending_points() TO authenticated;
GRANT EXECUTE ON FUNCTION public.claim_pending_points() TO service_role;
GRANT EXECUTE ON FUNCTION public.get_pending_points_detail() TO authenticated;

-- 5. Add 'batch_claim' to points_ledger type check if missing (optional, safe to run)
DO $$
BEGIN
    ALTER TABLE public.points_ledger DROP CONSTRAINT IF EXISTS points_ledger_type_check;
    ALTER TABLE public.points_ledger ADD CONSTRAINT points_ledger_type_check 
        CHECK (type IN (
            'practice_complete', 'unit_test_complete', 'error_correction',
            'daily_checkin', 'checkin_bonus',
            'like_received', 'comment_received', 'follower_gained', 'friend_added',
            'pro_redeem', 'manual_adjustment',
            'gift_claim', 'batch_claim' 
        ));
EXCEPTION WHEN OTHERS THEN
    NULL; -- Ignore if fails, we used 'manual_adjustment' in the function above to be safe
END $$;
