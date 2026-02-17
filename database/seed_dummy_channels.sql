
-- Seed Dummy Channels for UI Testing
-- This script creates extra channels to test the "Top 10" list.

DO $$
DECLARE
    creator_uuid UUID;
    i INTEGER;
BEGIN

    -- 1. Get a valid user ID (anyone will do since we disable the trigger)
    SELECT id INTO creator_uuid FROM auth.users LIMIT 1;

    -- 2. Temporarily disable the limit trigger
    ALTER TABLE public.forum_channels DISABLE TRIGGER on_create_channel_limit;

    -- 3. Insert 10 dummy channels
    FOR i IN 1..10 LOOP
        INSERT INTO public.forum_channels (slug, name, category, description, creator_id, position)
        VALUES (
            'dummy-channel-' || i || '-' || floor(random() * 1000)::text,
            'Top Channel #' || i,
            'User',
            'This is a test channel to verify the top 10 list.',
            creator_uuid,
            100 + i -- Arbitrary position
        )
        ON CONFLICT (slug) DO NOTHING;
    END LOOP;
    
    -- 4. Re-enable the trigger
    ALTER TABLE public.forum_channels ENABLE TRIGGER on_create_channel_limit;
    
    -- 3. Add random members to make them "popular" (optional, but good for sorting test)
    -- actually, just inserting channels is enough to show them.
    -- To test sorting, we'd need members, but let's just get them to show up first.

END $$;
