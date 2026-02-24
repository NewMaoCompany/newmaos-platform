-- ============================================================
-- COMPLETE CLEANUP SCRIPT
-- Run ALL statements below in Supabase SQL Editor
-- ============================================================

-- STEP 1: Delete ALL old [Practice - Review] notifications (junk + read ones)
DELETE FROM public.notifications 
WHERE text LIKE '[Practice - Review]%';

-- STEP 2: Delete ALL algorithmic session progress (reset PracticeHub to "Start" state)
-- This clears the polluted currentIncorrectIds data
DELETE FROM public.user_section_progress 
WHERE entity_type = 'algorithmic';

-- STEP 3: Re-run the bulk notification generator
-- (This won't generate Practice Review notifications anymore since we just deleted the progress data)
-- But it will regenerate check-in and analysis notifications if applicable
SELECT public.generate_daily_notifications_bulk();

-- STEP 4: Verify cleanup
SELECT 'notifications' as table_name, count(*) as remaining 
FROM public.notifications WHERE text LIKE '[Practice%'
UNION ALL
SELECT 'algorithmic_sessions', count(*) 
FROM public.user_section_progress WHERE entity_type = 'algorithmic';
