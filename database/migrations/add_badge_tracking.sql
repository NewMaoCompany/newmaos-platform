-- Add badge tracking and onboarding flags to user_profiles
ALTER TABLE public.user_profiles 
ADD COLUMN IF NOT EXISTS last_analysis_view_time TIMESTAMPTZ DEFAULT NOW(),
ADD COLUMN IF NOT EXISTS last_practice_rec_view_time TIMESTAMPTZ DEFAULT NOW(),
ADD COLUMN IF NOT EXISTS last_pro_reminder_date DATE,
ADD COLUMN IF NOT EXISTS has_claimed_welcome_gift BOOLEAN DEFAULT false;

-- To sync unread forum counts, we need a way to track last_forum_read_time
ALTER TABLE public.user_profiles
ADD COLUMN IF NOT EXISTS last_forum_read_time TIMESTAMPTZ DEFAULT NOW();
