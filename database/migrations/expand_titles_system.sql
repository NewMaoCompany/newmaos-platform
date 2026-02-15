-- Expand Titles System to 10 Levels per Category
-- 1. Truncate existing titles to ensure clean seed (Optional based on strategy, but we use ON CONFLICT)
-- Actually, let's keep it safe.

INSERT INTO public.titles (id, name, description, category, threshold) VALUES
    -- 1. Seniority (1-10 Years) - Existing IDs handled in previous migration
    ('seniority_365', 'Senior Scholar', 'Member for 1 year.', 'seniority', 365),
    ('seniority_730', 'Advanced Scholar', 'Member for 2 years.', 'seniority', 730),
    ('seniority_1095', 'Honorary Scholar', 'Member for 3 years.', 'seniority', 1095),
    ('seniority_1460', 'Distinguished Member', 'Member for 4 years.', 'seniority', 1460),
    ('seniority_1825', 'Established Sage', 'Member for 5 years.', 'seniority', 1825),
    ('seniority_2190', 'Senior Sage', 'Member for 6 years.', 'seniority', 2190),
    ('seniority_2555', 'Eminent Scholar', 'Member for 7 years.', 'seniority', 2555),
    ('seniority_2920', 'Grandmaster', 'Member for 8 years.', 'seniority', 2920),
    ('seniority_3285', 'Legendary Mentor', 'Member for 9 years.', 'seniority', 3285),
    ('seniority_3650', 'Eternal Hall of Fame', 'Legendary member for 10 years.', 'seniority', 3650),

    -- 2. Streak (10 Levels: 1, 3, 7, 14, 21, 30, 60, 100, 180, 365 days)
    ('streak_1', 'Pathfinder', 'Started the journey.', 'streak', 1),
    ('streak_3', 'Casual Learner', '3-day momentum.', 'streak', 3),
    ('streak_7', 'Active Weekly', 'Completed a full week.', 'streak', 7),
    ('streak_14', 'Fortnightly Hero', 'Unstoppable for 14 days.', 'streak', 14),
    ('streak_21', 'Habit Former', 'Consistency for 21 days.', 'streak', 21),
    ('streak_30', 'Monthly Vanguard', 'A month of dedication.', 'streak', 30),
    ('streak_60', 'Double Month', '60 days of focus.', 'streak', 60),
    ('streak_100', 'Centurion', '100 days of mastery.', 'streak', 100),
    ('streak_180', 'Half-Year Pillar', 'Legendary half-year streak.', 'streak', 180),
    ('streak_365_s', 'Streak Immortal', '365 days of unbroken learning.', 'streak', 365),

    -- 3. Unit Mastery (10 Levels: Unit 1-10)
    ('mastery_unit_1', 'Limits Whisperer', 'Mastered Unit 1.', 'mastery_unit', 1),
    ('mastery_unit_2', 'Derivative Apprentice', 'Mastered Unit 2.', 'mastery_unit', 2),
    ('mastery_unit_3', 'Chain Rule Expert', 'Mastered Unit 3.', 'mastery_unit', 3),
    ('mastery_unit_4', 'Rate Specialist', 'Mastered Unit 4.', 'mastery_unit', 4),
    ('mastery_unit_5', 'Extreme Analyst', 'Mastered Unit 5.', 'mastery_unit', 5),
    ('mastery_unit_6', 'Integration Initiate', 'Mastered Unit 6.', 'mastery_unit', 6),
    ('mastery_unit_7', 'Differential Pilot', 'Mastered Unit 7.', 'mastery_unit', 7),
    ('mastery_unit_8', 'Area Architect', 'Mastered Unit 8.', 'mastery_unit', 8),
    ('mastery_unit_9', 'Parametric Voyager', 'Mastered Unit 9 (BC).', 'mastery_unit', 9),
    ('mastery_unit_10', 'Series Sovereign', 'Mastered Unit 10 (BC).', 'mastery_unit', 10),

    -- 4. Course Mastery (AB and BC)
    ('mastery_course_ab', 'AB Syllabus Conqueror', 'Complete 100% of AP Calculus AB.', 'mastery_course', 1),
    ('mastery_course_bc', 'BC Syllabus Dominator', 'Complete 100% of AP Calculus BC.', 'mastery_course', 2),

    -- 5. Social (10 Levels: 1, 3, 5, 10, 20, 30, 50, 75, 100, 200 friends)
    ('social_1', 'First Peer', 'Added 1 friend.', 'social', 1),
    ('social_3', 'Small Circle', 'Added 3 friends.', 'social', 3),
    ('social_5', 'Study Group', 'Added 5 friends.', 'social', 5),
    ('social_10', 'Socialite', 'Added 10 friends.', 'social', 10),
    ('social_20', 'Networker', 'Added 20 friends.', 'social', 20),
    ('social_30', 'Connected', 'Added 30 friends.', 'social', 30),
    ('social_50', 'Popular Scholar', 'Added 50 friends.', 'social', 50),
    ('social_75', 'Community Icon', 'Added 75 friends.', 'social', 75),
    ('social_100', 'Network Master', 'Added 100 friends.', 'social', 100),
    ('social_200', 'Social Legend', 'Added 200 friends.', 'social', 200),

    -- 6. Influence (10 Levels: 1, 5, 10, 25, 50, 100, 250, 500, 1000, 5000 followers)
    ('influence_1', 'Spark', '1 follower.', 'influence', 1),
    ('influence_5', 'Rising Voice', '5 followers.', 'influence', 5),
    ('influence_10', 'Gathering Power', '10 followers.', 'influence', 10),
    ('influence_25', 'Local Influence', '25 followers.', 'influence', 25),
    ('influence_50', 'Speaker of Truth', '50 followers.', 'influence', 50),
    ('influence_100', 'Regional Hero', '100 followers.', 'influence', 100),
    ('influence_250', 'Megaphone', '250 followers.', 'influence', 250),
    ('influence_500', 'Beacon of Knowledge', '500 followers.', 'influence', 500),
    ('influence_1000', 'Oceanic Visionary', '1000 followers.', 'influence', 1000),
    ('influence_5000', 'Universal Architect', '5000 followers.', 'influence', 5000)
ON CONFLICT (id) DO UPDATE SET 
    name = EXCLUDED.name, 
    description = EXCLUDED.description, 
    category = EXCLUDED.category, 
    threshold = EXCLUDED.threshold;

-- Cleanup legacy IDs if needed, but since we map many to new, it's safer to keep for a while or remove known duplicates.
-- Delete OLD IDs that are no longer in use
DELETE FROM public.titles 
WHERE id IN (
    'streak_90', 'friends_1', 'friends_10', 'friends_100', 
    'influence_owner' -- influence_owner is redundant now
);
