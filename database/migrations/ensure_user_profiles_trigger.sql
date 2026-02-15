-- 1. Function to handle profile creation
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO public.user_profiles (id, name, avatar_url, subscription_tier)
  VALUES (
    NEW.id,
    COALESCE(NEW.raw_user_meta_data->>'name', split_part(NEW.email, '@', 1)),
    'https://ui-avatars.com/api/?name=' || COALESCE(NEW.raw_user_meta_data->>'name', split_part(NEW.email, '@', 1)) || '&background=f9d406&color=1c1a0d&bold=true',
    'basic'
  )
  ON CONFLICT (id) DO NOTHING;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- 2. Trigger on auth.users signup
DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;
CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();

-- 3. Rescue existing users (Manual Sync)
-- This ensures all current auth users have a profile row
INSERT INTO public.user_profiles (id, name, avatar_url, subscription_tier)
SELECT 
  id, 
  COALESCE(raw_user_meta_data->>'name', split_part(email, '@', 1)),
  'https://ui-avatars.com/api/?name=' || COALESCE(raw_user_meta_data->>'name', split_part(email, '@', 1)) || '&background=f9d406&color=1c1a0d&bold=true',
  'basic'
FROM auth.users
ON CONFLICT (id) DO NOTHING;
