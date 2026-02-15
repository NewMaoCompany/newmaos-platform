-- Refactor Title System to 6 Tiers Per Category
-- This script replaces the 10-tier system with a more distinct 6-tier system.

-- 1. Clean up existing titles to prevent duplicates or orphaned tiers
TRUNCATE public.titles CASCADE;

-- 2. Insert 6-Tiered Titles
INSERT INTO public.titles (id, name, description, category, threshold) VALUES
    -- 1. Seniority (6 Tiers: 90d, 1y, 2y, 4y, 7y, 10y)
    ('seniority_90', 'Novice Scholar', 'Member for 90 days.', 'seniority', 90),
    ('seniority_365', 'Senior Scholar', 'Member for 1 year.', 'seniority', 365),
    ('seniority_730', 'Honorary Scholar', 'Member for 2 years.', 'seniority', 730),
    ('seniority_1460', 'Distinguished Member', 'Member for 4 years.', 'seniority', 1460),
    ('seniority_2555', 'Eminent Sage', 'Member for 7 years.', 'seniority', 2555),
    ('seniority_3650', 'Eternal Hall of Fame', 'Legendary member for 10 years.', 'seniority', 3650),

    -- 2. Streak (6 Tiers: 1, 7, 30, 100, 180, 365 days)
    ('streak_1', 'Pathfinder', 'Started the journey.', 'streak', 1),
    ('streak_7', 'Weekly Warrior', '7-day momentum.', 'streak', 7),
    ('streak_30', 'Monthly Vanguard', 'A month of dedication.', 'streak', 30),
    ('streak_100', 'Centurion', '100 days of mastery.', 'streak', 100),
    ('streak_180', 'Pillar of Hope', 'Unstoppable half-year streak.', 'streak', 180),
    ('streak_365_s', 'Streak Immortal', '365 days of unbroken learning.', 'streak', 365),

    -- 3. Unit Mastery (6 Tiers: Unit 1, 2, 4, 6, 8, 10)
    ('mastery_unit_1', 'Limits Whisperer', 'Mastered Unit 1.', 'mastery_unit', 1),
    ('mastery_unit_2', 'Derivative Apprentice', 'Mastered Unit 2.', 'mastery_unit', 2),
    ('mastery_unit_4', 'Rate Specialist', 'Mastered Unit 4.', 'mastery_unit', 4),
    ('mastery_unit_6', 'Integration Initiate', 'Mastered Unit 6.', 'mastery_unit', 6),
    ('mastery_unit_8', 'Area Architect', 'Mastered Unit 8.', 'mastery_unit', 8),
    ('mastery_unit_10', 'Series Sovereign', 'Mastered Unit 10 (BC).', 'mastery_unit', 10),

    -- 4. Course Mastery (AB and BC) - Keep these as special 2-tier markers but visually map to high tiers
    ('mastery_course_ab', 'AB Syllabus Conqueror', 'Complete 100% of AP Calculus AB.', 'mastery_course', 1),
    ('mastery_course_bc', 'BC Syllabus Dominator', 'Complete 100% of AP Calculus BC.', 'mastery_course', 2),

    -- 5. Social (6 Tiers: 1, 10, 30, 50, 100, 200 friends)
    ('social_1', 'First Peer', 'Added 1 friend.', 'social', 1),
    ('social_10', 'Socialite', 'Added 10 friends.', 'social', 10),
    ('social_30', 'Connected', 'Added 30 friends.', 'social', 30),
    ('social_50', 'Popular Scholar', 'Added 50 friends.', 'social', 50),
    ('social_100', 'Network Master', 'Added 100 friends.', 'social', 100),
    ('social_200', 'Social Legend', 'Added 200 friends.', 'social', 200),

    -- 6. Influence (6 Tiers: 1, 50, 250, 1000, 2500, 5000 followers)
    ('influence_1', 'Spark', '1 follower.', 'influence', 1),
    ('influence_50', 'Speaker of Truth', '50 followers.', 'influence', 50),
    ('influence_250', 'Megaphone', '250 followers.', 'influence', 250),
    ('influence_1000', 'Oceanic Visionary', '1000 followers.', 'influence', 1000),
    ('influence_2500', 'World Leader', '2500 followers.', 'influence', 2500),
    ('influence_5000', 'Universal Architect', '5000 followers.', 'influence', 5000);
