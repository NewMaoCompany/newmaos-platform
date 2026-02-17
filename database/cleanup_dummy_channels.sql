
-- Cleanup Dummy Channels
-- This script removes the test channels created for UI verification.

DELETE FROM public.forum_channels
WHERE slug LIKE 'dummy-channel-%';

-- Optional: Verify count
DO $$
DECLARE
    count INTEGER;
BEGIN
    SELECT COUNT(*) INTO count FROM public.forum_channels WHERE category IN ('User', 'Official', 'Custom');
    RAISE NOTICE 'Remaining browsable channels: %', count;
END $$;
