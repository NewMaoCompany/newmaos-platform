-- ==============================================================================
-- FIX V3: THE HIDDEN BLOCKER
-- Purpose: Fix forum_channels (creator_id) which was set to NO ACTION.
-- This was identified via the diagnostic script.
-- ==============================================================================

-- 1. FIX forum_channels (Blocks deletion if user created a channel)
-- Decision: SET NULL (Keep the channel, just remove the creator link)
ALTER TABLE public.forum_channels
DROP CONSTRAINT IF EXISTS forum_channels_creator_id_fkey;

ALTER TABLE public.forum_channels
ADD CONSTRAINT forum_channels_creator_id_fkey
FOREIGN KEY (creator_id) REFERENCES auth.users(id)
ON DELETE SET NULL;

-- 2. SAFETY CHECK: Ensure any other commonly missed "created_by" fields are covered
-- (Based on common patterns, just in case)

-- If 'questions' table 'created_by' was not already SET NULL (it appeared so in screenshot, but good to ensure)
DO $$
BEGIN
    IF EXISTS (
        SELECT 1 FROM pg_constraint WHERE conname = 'questions_created_by_fkey'
    ) THEN
        ALTER TABLE public.questions
        DROP CONSTRAINT questions_created_by_fkey;

        ALTER TABLE public.questions
        ADD CONSTRAINT questions_created_by_fkey
        FOREIGN KEY (created_by) REFERENCES auth.users(id)
        ON DELETE SET NULL;
    END IF;
END $$;
