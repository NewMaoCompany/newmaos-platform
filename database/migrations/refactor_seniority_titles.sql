-- Migration: Refactor 1-10 Year Titles from 'streak' to 'seniority'

-- 1. Add 'seniority' to titles category check constraint
-- First, identify the constraint name (usually automatically named, but let's be safe and just replace it)
DO $$
BEGIN
    ALTER TABLE public.titles DROP CONSTRAINT IF EXISTS titles_category_check;
    ALTER TABLE public.titles ADD CONSTRAINT titles_category_check 
        CHECK (category IN ('streak', 'mastery_unit', 'mastery_course', 'social', 'influence', 'seniority'));
END $$;

-- 2. Update existing 1-10 Year titles to the 'seniority' category and upgrade names/descriptions
-- Thresholds: 1Y=365, 2Y=730, 3Y=1095, 4Y=1460, 5Y=1825, 6Y=2190, 7Y=2555, 8Y=2920, 9Y=3285, 10Y=3650

-- Update 1 Year
UPDATE public.titles SET 
    name = 'Senior Scholar (1Y)', 
    description = 'Dedicated member of NewMaoS for 1 year.', 
    category = 'seniority' 
WHERE id = 'streak_365';

-- Update 2 Year
UPDATE public.titles SET 
    name = 'Advanced Scholar (2Y)', 
    description = 'Dedicated member of NewMaoS for 2 years.', 
    category = 'seniority' 
WHERE id = 'streak_730';

-- Update 3 Year
UPDATE public.titles SET 
    name = 'Honorary Scholar (3Y)', 
    description = 'Elite member of NewMaoS for 3 years.', 
    category = 'seniority' 
WHERE id = 'streak_1095';

-- Update 4 Year
UPDATE public.titles SET 
    name = 'Distinguished Scholar (4Y)', 
    description = 'Distinguished member of NewMaoS for 4 years.', 
    category = 'seniority' 
WHERE id = 'streak_1460';

-- Update 5 Year
UPDATE public.titles SET 
    name = 'Established Sage (5Y)', 
    description = 'Pillar of the NewMaoS community for 5 years.', 
    category = 'seniority' 
WHERE id = 'streak_1825';

-- Update 6 Year
UPDATE public.titles SET 
    name = 'Senior Sage (6Y)', 
    description = 'Wise elder of the community for 6 years.', 
    category = 'seniority' 
WHERE id = 'streak_2190';

-- Update 7 Year
UPDATE public.titles SET 
    name = 'Eminent Scholar (7Y)', 
    description = 'Highly respected member for 7 years.', 
    category = 'seniority' 
WHERE id = 'streak_2555';

-- Update 8 Year
UPDATE public.titles SET 
    name = 'Grandmaster Scholar (8Y)', 
    description = 'Reaching mastery over 8 years of dedication.', 
    category = 'seniority' 
WHERE id = 'streak_2920';

-- Update 9 Year
UPDATE public.titles SET 
    name = 'Legendary Mentor (9Y)', 
    description = 'A legend within NewMaoS for 9 years.', 
    category = 'seniority' 
WHERE id = 'streak_3285';

-- Update 10 Year
UPDATE public.titles SET 
    name = 'Eternal Hall of Fame (10Y)', 
    description = 'Untouchable legend. 10 years in the Hall of Fame.', 
    category = 'seniority' 
WHERE id = 'streak_3650';

-- 3. Rename IDs for clarity (Optional but good for data integrity)
-- We'll keep old IDs to avoid breaking user_titles references, 
-- but we could migrate them if we had a script. 
-- For now, keeping IDs but changing logic is safest.
