-- ====================================================================
-- Backfill Script: Populate Explicit Skill Columns from Legacy Array
-- 
-- PROBLEM: 
-- Newly added columns (primary_skill_id, supporting_skill_ids) are NULL 
-- for all questions created BEFORE the V3 script.
--
-- SOLUTION:
-- This script Iterates through all questions where primary_skill_id is NULL
-- and populates it using the first element of the legacy `skill_tags` array.
-- It puts the remaining elements into `supporting_skill_ids`.
-- ====================================================================

UPDATE public.questions
SET 
    -- 1. Primary Skill = The FIRST element of the legacy array (index 1 in Postgres 1-based arrays)
    primary_skill_id = skill_tags[1],
    
    -- 2. Supporting Skills = The REST of the array (slice from 2 to end)
    --    Note: If array has only 1 item, this returns empty or NULL properly handled below
    supporting_skill_ids = CASE 
        WHEN array_length(skill_tags, 1) > 1 THEN skill_tags[2:array_length(skill_tags, 1)]
        ELSE '{}'::text[]
    END,
    
    -- 3. Set Default Weights for these backfilled rows
    weight_primary = 0.8,
    weight_supporting = 0.2

WHERE 
    -- Only update rows that haven't been migrated yet
    primary_skill_id IS NULL 
    AND skill_tags IS NOT NULL 
    AND array_length(skill_tags, 1) > 0;

-- Optional: Verify the update
-- SELECT id, title, skill_tags, primary_skill_id, supporting_skill_ids FROM public.questions LIMIT 20;
