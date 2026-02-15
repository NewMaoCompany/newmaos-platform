-- =====================================================
-- CONSOLIDATE FORUM CHANNELS
-- Move all unit-specific channels into two course-level channels
-- =====================================================

-- 1. Create the new course channels if they don't exist
INSERT INTO public.forum_channels (slug, name, category, description, position)
VALUES 
    ('ap-calculus-ab', 'AP Calculus AB Chat', 'Courses', 'Main discussion channel for AB Calculus', 5),
    ('ap-calculus-bc', 'AP Calculus BC Chat', 'Courses', 'Main discussion channel for BC Calculus', 6)
ON CONFLICT (slug) DO UPDATE SET 
    name = EXCLUDED.name,
    category = EXCLUDED.category,
    description = EXCLUDED.description,
    position = EXCLUDED.position;

-- 2. Migrate existing messages from AB unit channels to the main AB channel
UPDATE public.forum_messages
SET channel_id = (SELECT id FROM public.forum_channels WHERE slug = 'ap-calculus-ab')
WHERE channel_id IN (
    SELECT id FROM public.forum_channels 
    WHERE slug LIKE 'ab-unit-%'
);

-- 3. Migrate existing messages from BC unit channels to the main BC channel
UPDATE public.forum_messages
SET channel_id = (SELECT id FROM public.forum_channels WHERE slug = 'ap-calculus-bc')
WHERE channel_id IN (
    SELECT id FROM public.forum_channels 
    WHERE slug LIKE 'bc-unit-%'
);

-- 4. Delete the old unit-specific channels
DELETE FROM public.forum_channels 
WHERE slug LIKE 'ab-unit-%' 
   OR slug LIKE 'bc-unit-%';
