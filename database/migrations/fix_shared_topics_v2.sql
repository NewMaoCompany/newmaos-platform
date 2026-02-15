-- Dynamic Shift to 'Both_' topics for Shared Questions

-- 1. Ensure Topic Content exists for all potential Shared units
-- (We use ON CONFLICT DO NOTHING to avoid errors if they already exist)
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

-- 2. Dynamically update ALL questions where course = 'Both' but topic starts with 'AB_'
-- This converts 'AB_Limits' -> 'Both_Limits'
UPDATE public.questions
SET topic = 'Both_' || SUBSTRING(topic FROM 4)
WHERE course = 'Both' AND topic LIKE 'AB_%';

-- 3. Dynamically update ALL questions where course = 'Both' but topic starts with 'BC_'
-- This converts 'BC_Limits' -> 'Both_Limits'
UPDATE public.questions
SET topic = 'Both_' || SUBSTRING(topic FROM 4)
WHERE course = 'Both' AND topic LIKE 'BC_%';

-- 4. Verify results
SELECT id, course, topic FROM public.questions WHERE course = 'Both';
