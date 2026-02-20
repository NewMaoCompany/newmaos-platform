-- Add selected_prestige_level column to user_profiles table
ALTER TABLE public.user_profiles
ADD COLUMN IF NOT EXISTS selected_prestige_level integer DEFAULT NULL;

-- Comment on column
COMMENT ON COLUMN public.user_profiles.selected_prestige_level IS 'The prestige level the user has chosen to display on their public profile. NULL means show current level.';
