-- Add subscription and onboarding fields to user_profiles
ALTER TABLE public.user_profiles
ADD COLUMN IF NOT EXISTS subscription_tier text DEFAULT 'basic',
ADD COLUMN IF NOT EXISTS subscription_period_end timestamp with time zone,
ADD COLUMN IF NOT EXISTS has_seen_pro_intro boolean DEFAULT false;

-- Add check constraint for subscription_tier
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM pg_constraint WHERE conname = 'user_profiles_subscription_tier_check'
    ) THEN
        ALTER TABLE public.user_profiles 
        ADD CONSTRAINT user_profiles_subscription_tier_check 
        CHECK (subscription_tier = ANY (ARRAY['basic'::text, 'pro'::text]));
    END IF;
END $$;

-- Enable RLS for public access if needed (usually handled by existing policies)
-- But ensure user_profiles remains updatable by the user
COMMENT ON COLUMN public.user_profiles.subscription_tier IS 'Tracks user membership level (basic vs pro)';
COMMENT ON COLUMN public.user_profiles.subscription_period_end IS 'Expiration date for pro membership';
COMMENT ON COLUMN public.user_profiles.has_seen_pro_intro IS 'Whether the user has viewed the Pro Plan introductory modal';
