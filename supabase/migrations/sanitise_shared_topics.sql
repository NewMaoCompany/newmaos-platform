-- 1. Insert new "Shared" topic entries into topic_content table if they don't exist
-- This ensures that when we update the questions to use 'Both_Limits', it maps to a valid topic.
-- Note: You may need to adjust the content/descriptions as preferred.

INSERT INTO public.topic_content (id, title, description, created_at, updated_at)
VALUES 
('Both_Limits', 'Unit 1: Limits and Continuity (Shared)', 'Limits and Continuity', NOW(), NOW()),
('Both_Derivatives', 'Unit 2: Differentiation: Definition (Shared)', 'Differentiation Definition', NOW(), NOW()),
('Both_Composite', 'Unit 3: Differentiation: Composite (Shared)', 'Composite Functions', NOW(), NOW()),
('Both_Applications', 'Unit 4: Contextual Applications (Shared)', 'Contextual Applications', NOW(), NOW()),
('Both_Analytical', 'Unit 5: Analytical Applications (Shared)', 'Analytical Applications', NOW(), NOW()),
('Both_Integration', 'Unit 6: Integration (Shared)', 'Integration and Accumulation of Change', NOW(), NOW()),
('Both_DiffEq', 'Unit 7: Differential Equations (Shared)', 'Differential Equations', NOW(), NOW()),
('Both_AppIntegration', 'Unit 8: Applications of Integration (Shared)', 'Applications of Integration', NOW(), NOW())
ON CONFLICT (id) DO NOTHING;

-- 2. Update existing questions that are marked as 'Both' (course = 'Both') 
-- to use the new neutral topic IDs instead of course-specific ones (AB_... or BC_...).

UPDATE public.questions
SET topic = 'Both_Limits'
WHERE course = 'Both' AND (topic = 'AB_Limits' OR topic = 'BC_Limits');

UPDATE public.questions
SET topic = 'Both_Derivatives'
WHERE course = 'Both' AND (topic = 'AB_Derivatives' OR topic = 'BC_Derivatives');

UPDATE public.questions
SET topic = 'Both_Composite'
WHERE course = 'Both' AND (topic = 'AB_Composite' OR topic = 'BC_Composite');

UPDATE public.questions
SET topic = 'Both_Applications'
WHERE course = 'Both' AND (topic = 'AB_Applications' OR topic = 'BC_Applications');

UPDATE public.questions
SET topic = 'Both_Analytical'
WHERE course = 'Both' AND (topic = 'AB_Analytical' OR topic = 'BC_Analytical');

UPDATE public.questions
SET topic = 'Both_Integration'
WHERE course = 'Both' AND (topic = 'AB_Integration' OR topic = 'BC_Integration');

UPDATE public.questions
SET topic = 'Both_DiffEq'
WHERE course = 'Both' AND (topic = 'AB_DiffEq' OR topic = 'BC_DiffEq');

UPDATE public.questions
SET topic = 'Both_AppIntegration'
WHERE course = 'Both' AND (topic = 'AB_AppIntegration' OR topic = 'BC_AppIntegration');

-- 3. Verify the updates
SELECT id, course, topic FROM public.questions WHERE course = 'Both';
