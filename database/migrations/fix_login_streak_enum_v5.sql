-- ============================================================
-- BACKEND FIX: Allow 'login_streak' in points_ledger type
-- ============================================================
-- ⚠️ IMPORTANT: Run this in Supabase SQL Editor to fix the 
-- "400 Error" during Daily Login Check-ins.
-- ============================================================

DO $$
DECLARE
    curr_def TEXT;
BEGIN
    -- Get the current CHECK constraint definition
    SELECT pg_get_constraintdef(oid) INTO curr_def 
    FROM pg_constraint 
    WHERE conname = 'points_ledger_type_check' 
    AND conrelid = 'public.points_ledger'::regclass;

    -- If the constraint exists and doesn't already have 'login_streak'
    IF curr_def IS NOT NULL AND curr_def NOT LIKE '%''login_streak''%' THEN
        
        -- The definition looks like: CHECK (type = ANY (ARRAY['a'::text, 'b'::text...]))
        -- Rather than string manipulation which can fail, we can just replace the definition 
        -- with a new definition that includes our type OR the old logic.
        
        curr_def := replace(curr_def, 'CHECK', ''); -- remove the word CHECK
        EXECUTE 'ALTER TABLE public.points_ledger DROP CONSTRAINT points_ledger_type_check;';
        
        -- Add new constraint with previous check OR allowing 'login_streak'
        EXECUTE 'ALTER TABLE public.points_ledger ADD CONSTRAINT points_ledger_type_check CHECK ( (' || curr_def || ') OR type = ''login_streak'' );';
        
        RAISE NOTICE 'Appended login_streak to points_ledger_type_check successfully.';
    ELSE
        RAISE NOTICE 'Constraint already includes login_streak or does not exist (likely already fixed).';
    END IF;
END $$;
