-- Add visibility columns to user_profiles table
ALTER TABLE public.user_profiles
ADD COLUMN IF NOT EXISTS show_name BOOLEAN DEFAULT true,
ADD COLUMN IF NOT EXISTS show_email BOOLEAN DEFAULT false,
ADD COLUMN IF NOT EXISTS show_bio BOOLEAN DEFAULT true;

-- Update the comment to reflect these new privacy settings
COMMENT ON TABLE public.user_profiles IS 'Extended profile data including customization and privacy settings';
