-- Ensure streak_days column exists
ALTER TABLE public.user_profiles 
ADD COLUMN IF NOT EXISTS streak_days INTEGER DEFAULT 0;

-- Ensure other columns exist just in case
ALTER TABLE public.user_profiles 
ADD COLUMN IF NOT EXISTS last_login_at TIMESTAMPTZ DEFAULT now(),
ADD COLUMN IF NOT EXISTS prev_streak_days INTEGER DEFAULT 0;
