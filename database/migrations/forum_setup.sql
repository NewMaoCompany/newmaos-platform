-- =====================================================
-- FORUM SETUP (Discord Style) - v2 (Granular Units)
-- Tables: forum_channels, forum_messages
-- =====================================================

-- 1. Create Channels Table
CREATE TABLE IF NOT EXISTS public.forum_channels (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    slug TEXT NOT NULL UNIQUE,
    name TEXT NOT NULL,
    category TEXT NOT NULL DEFAULT 'General',
    description TEXT,
    position INTEGER DEFAULT 0,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 2. Create Messages Table
CREATE TABLE IF NOT EXISTS public.forum_messages (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    channel_id UUID REFERENCES public.forum_channels(id) ON DELETE CASCADE,
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
    content TEXT NOT NULL,
    is_pinned BOOLEAN DEFAULT false,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- 3. Enable RLS
ALTER TABLE public.forum_channels ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.forum_messages ENABLE ROW LEVEL SECURITY;

-- 4. Policies
DROP POLICY IF EXISTS "Public view channels" ON public.forum_channels;
CREATE POLICY "Public view channels" ON public.forum_channels FOR SELECT USING (true);

DROP POLICY IF EXISTS "Public view messages" ON public.forum_messages;
CREATE POLICY "Public view messages" ON public.forum_messages FOR SELECT USING (true);

DROP POLICY IF EXISTS "Auth insert messages" ON public.forum_messages;
CREATE POLICY "Auth insert messages" ON public.forum_messages FOR INSERT WITH CHECK (auth.uid() = user_id);

DROP POLICY IF EXISTS "Users update own messages" ON public.forum_messages;
CREATE POLICY "Users update own messages" ON public.forum_messages FOR UPDATE USING (auth.uid() = user_id);

DROP POLICY IF EXISTS "Users delete own messages" ON public.forum_messages;
CREATE POLICY "Users delete own messages" ON public.forum_messages FOR DELETE USING (auth.uid() = user_id);

-- 5. Realtime
DO $$
BEGIN
  ALTER PUBLICATION supabase_realtime ADD TABLE public.forum_messages;
EXCEPTION
  WHEN duplicate_object OR sqlstate '42710' THEN
    NULL; -- Ignore if already exists
END $$;

-- 6. Seed Detailed Unit Channels (RESET & RE-SEED)
-- WARNING: This deletes old channels to ensure the new structure is clean.
DELETE FROM public.forum_channels;

INSERT INTO public.forum_channels (slug, name, category, description, position)
VALUES 
    -- Information
    ('announcements', 'announcements', 'Information', 'Official updates, exam dates, and news', 1),
    ('resources', 'resources', 'Information', 'Cheat sheets, formulas, and helpful PDFs', 2),
    
    -- Community
    ('general', 'general', 'Community', 'Casual chat, study groups, and vibes', 3),
    ('q-and-a', 'q-and-a', 'Community', 'General homework help and questions', 4),
    
    -- AP Calculus AB (8 Units)
    ('ab-unit-1', 'unit-1-limits', 'AP Calculus AB', 'Limits & Continuity (AB)', 10),
    ('ab-unit-2', 'unit-2-derivatives', 'AP Calculus AB', 'Differentiation: Definition & Rules (AB)', 11),
    ('ab-unit-3', 'unit-3-adv-derivatives', 'AP Calculus AB', 'Composite, Implicit, Inverse (AB)', 12),
    ('ab-unit-4', 'unit-4-calc-apps', 'AP Calculus AB', 'Contextual Applications (AB)', 13),
    ('ab-unit-5', 'unit-5-analytical', 'AP Calculus AB', 'Analytical Applications (AB)', 14),
    ('ab-unit-6', 'unit-6-integration', 'AP Calculus AB', 'Integration and Accumulation (AB)', 15),
    ('ab-unit-7', 'unit-7-diff-eq', 'AP Calculus AB', 'Differential Equations (AB)', 16),
    ('ab-unit-8', 'unit-8-integrals-app', 'AP Calculus AB', 'Applications of Integration (AB)', 17),
    
    -- AP Calculus BC (10 Units - Independent)
    ('bc-unit-1', 'unit-1-limits', 'AP Calculus BC', 'Limits & Continuity (BC)', 20),
    ('bc-unit-2', 'unit-2-derivatives', 'AP Calculus BC', 'Differentiation: Definition & Rules (BC)', 21),
    ('bc-unit-3', 'unit-3-adv-derivatives', 'AP Calculus BC', 'Composite, Implicit, Inverse (BC)', 22),
    ('bc-unit-4', 'unit-4-calc-apps', 'AP Calculus BC', 'Contextual Applications (BC)', 23),
    ('bc-unit-5', 'unit-5-analytical', 'AP Calculus BC', 'Analytical Applications (BC)', 24),
    ('bc-unit-6', 'unit-6-integration', 'AP Calculus BC', 'Integration and Accumulation (BC)', 25),
    ('bc-unit-7', 'unit-7-diff-eq', 'AP Calculus BC', 'Differential Equations (BC)', 26),
    ('bc-unit-8', 'unit-8-integrals-app', 'AP Calculus BC', 'Applications of Integration (BC)', 27),
    ('bc-unit-9', 'unit-9-parametric', 'AP Calculus BC', 'Parametric, Polar & Vector-Valued (BC)', 28),
    ('bc-unit-10', 'unit-10-series', 'AP Calculus BC', 'Infinite Sequences and Series (BC)', 29)

ON CONFLICT (slug) DO UPDATE SET 
    name = EXCLUDED.name,
    category = EXCLUDED.category,
    description = EXCLUDED.description,
    position = EXCLUDED.position;
