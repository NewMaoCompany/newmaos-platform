-- ============================================================
-- Fix permissions and RPC logic for pending points claim system
-- Run this script to resolve "Failed to claim points" error
-- ============================================================

-- 1. Grant explicit table permissions to authenticated users
GRANT SELECT, INSERT, UPDATE, DELETE ON public.pending_points TO authenticated;
GRANT ALL ON public.pending_points TO postgres, service_role;

-- 2. Ensure RLS is enabled and policies are correct and permissive enough for the flow
ALTER TABLE public.pending_points ENABLE ROW LEVEL SECURITY;

-- Re-create policies
DROP POLICY IF EXISTS "Users can view own pending points" ON public.pending_points;
CREATE POLICY "Users can view own pending points" ON public.pending_points
    FOR SELECT USING (auth.uid() = user_id);

DROP POLICY IF EXISTS "System can insert pending points" ON public.pending_points;
CREATE POLICY "System can insert pending points" ON public.pending_points
    FOR INSERT WITH CHECK (true);

DROP POLICY IF EXISTS "System can update pending points" ON public.pending_points;
CREATE POLICY "System can update pending points" ON public.pending_points
    FOR UPDATE USING (true) WITH CHECK (true);

-- 3. Redefine the function with robust error handling and explicit security context
CREATE OR REPLACE FUNCTION claim_pending_points()
RETURNS TABLE(claimed_amount INTEGER, claimed_count INTEGER) AS $$
DECLARE
    v_user_id UUID;
    v_total_amount INTEGER;
    v_count INTEGER;
BEGIN
    v_user_id := auth.uid();
    
    IF v_user_id IS NULL THEN
        RAISE EXCEPTION 'Not authenticated';
    END IF;
    
    -- Calculate total
    SELECT COALESCE(SUM(amount), 0), COUNT(*)
    INTO v_total_amount, v_count
    FROM pending_points
    WHERE user_id = v_user_id AND claimed = FALSE;
    
    -- If items exist, attempt claim
    IF v_total_amount > 0 THEN
        -- Wrap award_points in block to catch specific errors
        BEGIN
            PERFORM award_points(
                v_user_id,
                v_total_amount,
                'batch_claim',
                'pending_batch_' || NOW()::TEXT,
                'Claimed pending rewards',
                'batch_claim_' || v_user_id || '_' || EXTRACT(EPOCH FROM NOW())::TEXT
            );
        EXCEPTION WHEN OTHERS THEN
            RAISE EXCEPTION 'Failed to award points (award_points error): %', SQLERRM;
        END;
        
        -- Update status
        UPDATE pending_points
        SET claimed = TRUE, claimed_at = NOW()
        WHERE user_id = v_user_id AND claimed = FALSE;
    END IF;
    
    RETURN QUERY SELECT v_total_amount, v_count;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- 4. Grant execute permissions explicitly
GRANT EXECUTE ON FUNCTION claim_pending_points() TO authenticated;
GRANT EXECUTE ON FUNCTION get_pending_points_detail() TO authenticated;

-- 5. Verify award_points exists (just a check, won't fail script if it exists)
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_proc WHERE proname = 'award_points') THEN
        RAISE NOTICE 'WARNING: award_points function not found! Claim will likely fail.';
    END IF;
END $$;
