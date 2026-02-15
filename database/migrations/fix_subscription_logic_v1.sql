-- =====================================================
-- FIX: Subscription System Permissions & Schema
-- =====================================================

-- 1. Ensure columns exist with correct types and defaults
ALTER TABLE public.user_profiles 
ADD COLUMN IF NOT EXISTS subscription_tier text DEFAULT 'basic',
ADD COLUMN IF NOT EXISTS subscription_period_end timestamp with time zone,
ADD COLUMN IF NOT EXISTS has_seen_pro_intro boolean DEFAULT false;

-- 2. Add/Correct constraint for tier values
DO $$ 
BEGIN 
    IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'user_profiles_subscription_tier_check') THEN
        ALTER TABLE public.user_profiles ADD CONSTRAINT user_profiles_subscription_tier_check CHECK (subscription_tier = ANY (ARRAY['basic'::text, 'pro'::text]));
    END IF;
END $$;

-- 3. Fix Row Level Security (RLS)
-- Ensure RLS is enabled
ALTER TABLE public.user_profiles ENABLE ROW LEVEL SECURITY;

-- Drop existing restricted update policies if any
DROP POLICY IF EXISTS "Users can update own profile" ON public.user_profiles;

-- Create robust update policy
CREATE POLICY "Users can update own profile" ON public.user_profiles 
  FOR UPDATE 
  USING (auth.uid() = id)
  WITH CHECK (auth.uid() = id);

-- 4. CRITICAL: Grant explicit UPDATE permissions
-- Previous migrations might have limited grants to SELECT only.
GRANT UPDATE ON TABLE public.user_profiles TO authenticated;
GRANT SELECT, UPDATE ON TABLE public.user_profiles TO authenticated;

-- Ensure service_role has all permissions for backend operations
GRANT ALL ON TABLE public.user_profiles TO service_role;

-- 5. Helper Function for Realtime (Optional but helpful for dynamic memory)
-- Ensure 'updated_at' is always current
CREATE OR REPLACE FUNCTION public.handle_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS on_user_profiles_updated ON public.user_profiles;
CREATE TRIGGER on_user_profiles_updated
  BEFORE UPDATE ON public.user_profiles
  FOR EACH ROW EXECUTE FUNCTION public.handle_updated_at();
