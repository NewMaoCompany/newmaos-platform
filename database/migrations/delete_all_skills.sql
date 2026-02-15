-- Deletes all data from skills and error_tags tables
-- Run this in your Supabase SQL Editor

DELETE FROM public.question_skills;
DELETE FROM public.question_error_patterns;
DELETE FROM public.user_skill_mastery;
DELETE FROM public.skills; 
-- DELETE FROM public.error_tags; -- Uncomment if you want to delete error tags too

-- Reset sequences if necessary (though text IDs don't use sequences)
