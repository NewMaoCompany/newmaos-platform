-- ============================================================
-- Migration: Add 'gift_claim' to points_ledger type CHECK constraint
-- ============================================================

-- Drop the existing CHECK constraint on the 'type' column
ALTER TABLE public.points_ledger DROP CONSTRAINT IF EXISTS points_ledger_type_check;

-- Re-create with 'gift_claim' included
ALTER TABLE public.points_ledger ADD CONSTRAINT points_ledger_type_check 
    CHECK (type IN (
        'practice_complete', 'unit_test_complete', 'error_correction',
        'daily_checkin', 'checkin_bonus',
        'like_received', 'comment_received', 'follower_gained', 'friend_added',
        'pro_redeem', 'manual_adjustment',
        'gift_claim'
    ));
