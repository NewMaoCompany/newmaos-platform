-- ====================================================================
-- Insert Script for Unit 6 Part 2 (Sections 6.5 - 6.8) - V3 (Final Schema Fix + Type Case Fix)
--
-- FIXES:
-- 1. Merges high-quality metadata (weights, secondary skills) from V2 seed
-- 2. Includes Section 6.6 (missing from V2)
-- 3. SCHEMA UPDATE: Ensures `questions` table has EXPLICIT columns for skills and weights
-- 4. CASE SENSITIVITY FIX: Changed type 'mcq' to 'MCQ' to satisfy check constraint
-- ====================================================================

-- 0. SCHEMA UPDATE (Ensure columns exist)
DO $$
BEGIN
    -- Weights
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema = 'public' AND table_name = 'questions' AND column_name = 'weight_primary') THEN
        ALTER TABLE public.questions ADD COLUMN weight_primary NUMERIC DEFAULT 1.0;
    END IF;
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema = 'public' AND table_name = 'questions' AND column_name = 'weight_supporting') THEN
        ALTER TABLE public.questions ADD COLUMN weight_supporting NUMERIC DEFAULT 0.0;
    END IF;

    -- Explicit Skills (User Request: "Distinguish primary vs supportive in question table")
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema = 'public' AND table_name = 'questions' AND column_name = 'primary_skill_id') THEN
        ALTER TABLE public.questions ADD COLUMN primary_skill_id TEXT;
    END IF;
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema = 'public' AND table_name = 'questions' AND column_name = 'supporting_skill_ids') THEN
        ALTER TABLE public.questions ADD COLUMN supporting_skill_ids TEXT[];
    END IF;
END $$;


-- 1. CLEANUP (Delete existing questions to avoid duplicates)
DELETE FROM public.questions WHERE title IN (
    'U6.5-P1', 'U6.5-P2', 'U6.5-P3', 'U6.5-P4', 'U6.5-P5',
    'U6.6-P1', 'U6.6-P2', 'U6.6-P3', 'U6.6-P4', 'U6.6-P5',
    'U6.7-P1', 'U6.7-P2', 'U6.7-P3', 'U6.7-P4', 'U6.7-P5',
    'U6.8-P1', 'U6.8-P2', 'U6.8-P3', 'U6.8-P4', 'U6.8-P5'
);

-- Using DO block for variable handling
DO $$
DECLARE
    q_id UUID;
BEGIN

    -- ============================================================
    -- Section 6.5 (From V2 Metadata)
    -- ============================================================

    -- U6.5-P1
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type,
        calculator_allowed, difficulty, target_time_seconds,
        prompt_type, representation_type, prompt, latex,
        options, correct_option_id, explanation, micro_explanations,
        reasoning_level, mastery_weight, source, source_year, notes,
        error_tags, skill_tags, status, version,
        weight_primary, weight_supporting, primary_skill_id, supporting_skill_ids
    ) VALUES (
        'U6.5-P1', 'Both', 'Integration', 'Both_Integration', '6.5', '6.5', 'MCQ',
        false, 3, 150,
        'text', 'symbolic', 'Let $A(x)=\int_0^x (t^2-4t)\,dt$ for $0\le x\le 5$. On which interval is $A(x)$ decreasing?', 'Let $A(x)=\int_0^x (t^2-4t)\,dt$ for $0\le x\le 5$. On which interval is $A(x)$ decreasing?',
        '[{"id": "A", "text": "$(0,4)$"}, {"id": "B", "text": "$(4,5)$"}, {"id": "C", "text": "$(0,5)$"}, {"id": "D", "text": "$(0,2)$"}]'::jsonb, 
        'A', 
        '$A''(x)=t^2-4t$ evaluated at $t=x$, so $A''(x)=x^2-4x=x(x-4)$. This is negative on $(0,4)$, so $A$ is decreasing there.',
        '{"A": "Correct: $A''(x)<0$ on $(0,4)$.", "B": "Wrong: for $x>4$, $A''(x)>0$, so $A$ increases.", "C": "Wrong: $A$ decreases then increases; it is not decreasing on the whole interval.", "D": "Wrong: $(0,2)$ is only part of where $A''(x)<0$."}'::jsonb, 
        3, 1.15, 'self', 2026, '', 
        '{accumulation_behavior_misread}', '{accumulation_behavior_analysis,ftc1_accumulation_function}', 'published', 1,
        0.8, 0.2, 'accumulation_behavior_analysis', '{ftc1_accumulation_function}'
    ) RETURNING id INTO q_id;

    INSERT INTO public.question_skills (question_id, skill_id, weight, role) VALUES 
    (q_id, 'accumulation_behavior_analysis', 0.8, 'primary'),
    (q_id, 'ftc1_accumulation_function', 0.2, 'supporting');

    INSERT INTO public.question_error_patterns (question_id, error_tag_id) VALUES
    (q_id, 'accumulation_behavior_misread');


    -- U6.5-P2
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type,
        calculator_allowed, difficulty, target_time_seconds,
        prompt_type, representation_type, prompt, latex,
        options, correct_option_id, explanation, micro_explanations,
        reasoning_level, mastery_weight, source, source_year, notes,
        error_tags, skill_tags, status, version,
        weight_primary, weight_supporting, primary_skill_id, supporting_skill_ids
    ) VALUES (
        'U6.5-P2', 'Both', 'Integration', 'Both_Integration', '6.5', '6.5', 'MCQ',
        false, 3, 180,
        'image', 'graph', 'The graph of $r(t)$ is provided. Let $A(x)=\int_0^x r(t)\,dt$ for $0\le x\le 6$. For which values of $x$ is $A(x)$ decreasing?', 'The graph of $r(t)$ is provided. Let $A(x)=\int_0^x r(t)\,dt$ for $0\le x\le 6$. For which values of $x$ is $A(x)$ decreasing?',
        '[{"id": "A", "text": "$0<x<3.2$"}, {"id": "B", "text": "$3.2<x<6$"}, {"id": "C", "text": "$0<x<2$"}, {"id": "D", "text": "$2<x<4$"}]'::jsonb, 
        'B', 
        '$A''(x)=r(x)$. So $A$ is decreasing where $r(x)<0$, which occurs after the graph crosses the axis at about $x\approx 3.2$ and remains below through $x=6$.',
        '{"A": "Wrong: $r(x)>0$ there, so $A$ increases.", "B": "Correct: $r(x)<0$ there, so $A$ decreases.", "C": "Wrong: $r(x)$ is positive on this interval.", "D": "Wrong: part of $(2,4)$ has $r(x)>0$ and part has $r(x)<0$."}'::jsonb, 
        3, 1.15, 'self', 2026, 'image_file: U6_6.5-P2_graph.png', 
        '{area_sign_misread}', '{accumulation_behavior_analysis,area_under_curve_interpretation}', 'published', 1,
        0.8, 0.2, 'accumulation_behavior_analysis', '{area_under_curve_interpretation}'
    ) RETURNING id INTO q_id;

    INSERT INTO public.question_skills (question_id, skill_id, weight, role) VALUES 
    (q_id, 'accumulation_behavior_analysis', 0.8, 'primary'),
    (q_id, 'area_under_curve_interpretation', 0.2, 'supporting');

    INSERT INTO public.question_error_patterns (question_id, error_tag_id) VALUES
    (q_id, 'area_sign_misread');


    -- U6.5-P3
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type,
        calculator_allowed, difficulty, target_time_seconds,
        prompt_type, representation_type, prompt, latex,
        options, correct_option_id, explanation, micro_explanations,
        reasoning_level, mastery_weight, source, source_year, notes,
        error_tags, skill_tags, status, version,
        weight_primary, weight_supporting, primary_skill_id, supporting_skill_ids
    ) VALUES (
        'U6.5-P3', 'Both', 'Integration', 'Both_Integration', '6.5', '6.5', 'MCQ',
        false, 4, 210,
        'image', 'graph', 'Using the provided graph of $r(t)$, let $A(x)=\int_0^x r(t)\,dt$. On which interval is $A(x)$ concave down?', 'Using the provided graph of $r(t)$, let $A(x)=\int_0^x r(t)\,dt$. On which interval is $A(x)$ concave down?',
        '[{"id": "A", "text": "$0<x<2$"}, {"id": "B", "text": "$2<x<4$"}, {"id": "C", "text": "$4<x<6$"}, {"id": "D", "text": "None; $A(x)$ is never concave down."}]'::jsonb, 
        'B', 
        '$A''(x)=r(x)$ and $A''''(x)=r''(x)$. $A$ is concave down where $r''(x)<0$, i.e., where $r$ is decreasing. From the graph, $r$ decreases on $(2,4)$.',
        '{"A": "Wrong: $r$ increases there, so $A''''(x)>0$ (concave up).", "B": "Correct: $r$ decreases there, so $A''''(x)<0$.", "C": "Wrong: $r$ increases there, so $A$ is concave up.", "D": "Wrong: there is an interval where $r$ is decreasing."}'::jsonb, 
        4, 1.25, 'self', 2026, 'image_file: U6_6.5-P2_graph.png', 
        '{accumulation_behavior_misread}', '{accumulation_behavior_analysis,accumulation_from_variable_limit}', 'published', 1,
        0.8, 0.2, 'accumulation_behavior_analysis', '{accumulation_from_variable_limit}'
    ) RETURNING id INTO q_id;

    INSERT INTO public.question_skills (question_id, skill_id, weight, role) VALUES 
    (q_id, 'accumulation_behavior_analysis', 0.8, 'primary'),
    (q_id, 'accumulation_from_variable_limit', 0.2, 'supporting');

    INSERT INTO public.question_error_patterns (question_id, error_tag_id) VALUES
    (q_id, 'accumulation_behavior_misread');


    -- U6.5-P4
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type,
        calculator_allowed, difficulty, target_time_seconds,
        prompt_type, representation_type, prompt, latex,
        options, correct_option_id, explanation, micro_explanations,
        reasoning_level, mastery_weight, source, source_year, notes,
        error_tags, skill_tags, status, version,
        weight_primary, weight_supporting, primary_skill_id, supporting_skill_ids
    ) VALUES (
        'U6.5-P4', 'Both', 'Integration', 'Both_Integration', '6.5', '6.5', 'MCQ',
        false, 2, 120,
        'image', 'graph', 'The graph of $g(x)$ is provided. Let $B(x)=\int_1^x g(t)\,dt$. What is $B''(5)$?', 'The graph of $g(x)$ is provided. Let $B(x)=\int_1^x g(t)\,dt$. What is $B''(5)$?',
        '[{"id": "A", "text": "$-2$"}, {"id": "B", "text": "$0$"}, {"id": "C", "text": "$1$"}, {"id": "D", "text": "$3$"}]'::jsonb, 
        'B', 
        'By FTC Part 1, $B''(x)=g(x)$. From the graph, $g(5)=0$, so $B''(5)=0$.',
        '{"A": "Wrong: that is $g(6)$, not $g(5)$.", "B": "Correct: FTC1 gives $B''(5)=g(5)=0$.", "C": "Wrong: $g(3)=1$, not $g(5)$.", "D": "Wrong: $g(4)=3$, not $g(5)$."}'::jsonb, 
        2, 1.0, 'self', 2026, 'image_file: U6_6.5-P4_graph.png', 
        '{accumulation_derivative_wrong_variable}', '{accumulation_from_variable_limit,ftc1_accumulation_function}', 'published', 1,
        0.8, 0.2, 'accumulation_from_variable_limit', '{ftc1_accumulation_function}'
    ) RETURNING id INTO q_id;

    INSERT INTO public.question_skills (question_id, skill_id, weight, role) VALUES 
    (q_id, 'accumulation_from_variable_limit', 0.8, 'primary'),
    (q_id, 'ftc1_accumulation_function', 0.2, 'supporting');

    INSERT INTO public.question_error_patterns (question_id, error_tag_id) VALUES
    (q_id, 'accumulation_derivative_wrong_variable');


    -- U6.5-P5
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type,
        calculator_allowed, difficulty, target_time_seconds,
        prompt_type, representation_type, prompt, latex,
        options, correct_option_id, explanation, micro_explanations,
        reasoning_level, mastery_weight, source, source_year, notes,
        error_tags, skill_tags, status, version,
        weight_primary, weight_supporting, primary_skill_id, supporting_skill_ids
    ) VALUES (
        'U6.5-P5', 'Both', 'Integration', 'Both_Integration', '6.5', '6.5', 'MCQ',
        false, 3, 180,
        'text', 'symbolic', 'A particle has velocity $v(t)$ (in m/s) on $0\le t\le 4$. Suppose \int_0^4 v(t)\,dt=0$ and \int_0^4 |v(t)|\,dt=10$. Which statement is true?', 'A particle has velocity $v(t)$ (in m/s) on $0\le t\le 4$. Suppose \int_0^4 v(t)\,dt=0$ and \int_0^4 |v(t)|\,dt=10$. Which statement is true?',
        '[{"id": "A", "text": "Net displacement is 10 m and total distance is 0 m."}, {"id": "B", "text": "Net displacement is 0 m and total distance is 10 m."}, {"id": "C", "text": "Net displacement is 10 m and total distance is 10 m."}, {"id": "D", "text": "Net displacement is 0 m and total distance is 0 m."}]'::jsonb, 
        'B', 
        'Net displacement equals \int_0^4 v(t)\,dt=0$. Total distance equals \int_0^4 |v(t)|\,dt=10$.',
        '{"A": "Wrong: it swaps net displacement and total distance.", "B": "Correct: net uses $v$, total uses $|v|$.", "C": "Wrong: net displacement is given as 0, not 10.", "D": "Wrong: total distance is 10, not 0."}'::jsonb, 
        3, 1.15, 'self', 2026, '', 
        '{net_vs_total_change_confusion}', '{integral_total_vs_net_area,accumulation_concept}', 'published', 1,
        0.8, 0.2, 'integral_total_vs_net_area', '{accumulation_concept}'
    ) RETURNING id INTO q_id;

    INSERT INTO public.question_skills (question_id, skill_id, weight, role) VALUES 
    (q_id, 'integral_total_vs_net_area', 0.8, 'primary'),
    (q_id, 'accumulation_concept', 0.2, 'supporting');

    INSERT INTO public.question_error_patterns (question_id, error_tag_id) VALUES
    (q_id, 'net_vs_total_change_confusion');


    -- ============================================================
    -- Section 6.6
    -- ============================================================

    -- U6.6-P1
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type,
        calculator_allowed, difficulty, target_time_seconds,
        prompt_type, representation_type, prompt, latex,
        options, correct_option_id, explanation, micro_explanations,
        reasoning_level, mastery_weight, source, source_year, notes,
        error_tags, skill_tags, status, version,
        weight_primary, weight_supporting, primary_skill_id, supporting_skill_ids
    ) VALUES (
        'U6.6-P1', 'Both', 'Integration', 'Both_Integration', '6.6', '6.6', 'MCQ',
        false, 2, 120,
        'text', 'symbolic', 'Given $\int_0^2 f(x)\,dx=5$ and $\int_2^6 f(x)\,dx=-1$, what is $\int_0^6 f(x)\,dx$?', 'Given $\int_0^2 f(x)\,dx=5$ and $\int_2^6 f(x)\,dx=-1$, what is $\int_0^6 f(x)\,dx$?',
        '[{"id": "A", "text": "$4$"}, {"id": "B", "text": "$6$"}, {"id": "C", "text": "$-4$"}, {"id": "D", "text": "$-6$"}]'::jsonb, 
        'A', 
        'Use additivity: $\int_0^6 f=\int_0^2 f+\int_2^6 f=5+(-1)=4$.',
        '{"A": "Correct: add the two pieces.", "B": "Wrong: subtracting negative issue.", "C": "Wrong sign.", "D": "Wrong."}'::jsonb, 
        2, 1.05, 'NewMaoS', 2026, '', 
        '{integral_additivity_error}', '{integral_properties_basic}', 'published', 1,
        0.9, 0.1, 'integral_properties_basic', '{}'
    ) RETURNING id INTO q_id;

    INSERT INTO public.question_skills (question_id, skill_id, weight, role) VALUES 
    (q_id, 'integral_properties_basic', 0.9, 'primary');

    INSERT INTO public.question_error_patterns (question_id, error_tag_id) VALUES
    (q_id, 'integral_additivity_error');

    -- U6.6-P2
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type,
        calculator_allowed, difficulty, target_time_seconds,
        prompt_type, representation_type, prompt, latex,
        options, correct_option_id, explanation, micro_explanations,
        reasoning_level, mastery_weight, source, source_year, notes,
        error_tags, skill_tags, status, version,
        weight_primary, weight_supporting, primary_skill_id, supporting_skill_ids
    ) VALUES (
        'U6.6-P2', 'Both', 'Integration', 'Both_Integration', '6.6', '6.6', 'MCQ',
        false, 2, 120,
        'text', 'symbolic', 'If $\int_0^6 f(x)\,dx=4$, what is $\int_6^0 f(x)\,dx$?', 'If $\int_0^6 f(x)\,dx=4$, what is $\int_6^0 f(x)\,dx$?',
        '[{"id": "A", "text": "$4$"}, {"id": "B", "text": "$-4$"}, {"id": "C", "text": "$\\frac{1}{4}$"}, {"id": "D", "text": "$0$"}]'::jsonb, 
        'B', 
        'Reversing bounds changes the sign: $\int_6^0 f= -\int_0^6 f=-4$.',
        '{"A": "Wrong: did not reverse sign.", "B": "Correct: reversing bounds negates.", "C": "Wrong: no reciprocal.", "D": "Wrong."}'::jsonb, 
        2, 1.05, 'NewMaoS', 2026, '', 
        '{integral_bounds_reversal_error}', '{integral_properties_basic}', 'published', 1,
        0.9, 0.1, 'integral_properties_basic', '{}'
    ) RETURNING id INTO q_id;

    INSERT INTO public.question_skills (question_id, skill_id, weight, role) VALUES 
    (q_id, 'integral_properties_basic', 0.9, 'primary');

    INSERT INTO public.question_error_patterns (question_id, error_tag_id) VALUES
    (q_id, 'integral_bounds_reversal_error');


    -- U6.6-P3
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type,
        calculator_allowed, difficulty, target_time_seconds,
        prompt_type, representation_type, prompt, latex,
        options, correct_option_id, explanation, micro_explanations,
        reasoning_level, mastery_weight, source, source_year, notes,
        error_tags, skill_tags, status, version,
        weight_primary, weight_supporting, primary_skill_id, supporting_skill_ids
    ) VALUES (
        'U6.6-P3', 'Both', 'Integration', 'Both_Integration', '6.6', '6.6', 'MCQ',
        false, 3, 150,
        'image', 'table', 'Use the table of given integral values. What is $\int_0^6 \left(2f(x)-g(x)\right)\,dx$?', 'Use the table of given integral values. What is $\int_0^6 (2f(x)-g(x))\,dx$?',
        '[{"id": "A", "text": "$4$"}, {"id": "B", "text": "$8$"}, {"id": "C", "text": "$0$"}, {"id": "D", "text": "$-4$"}]'::jsonb, 
        'A', 
        'Linearity: $\int_0^6(2f-g)=2\int_0^6 f-\int_0^6 g=2(4)-4=4$.',
        '{"A": "Correct: apply constant multiple and subtraction.", "B": "Wrong.", "C": "Wrong.", "D": "Wrong."}'::jsonb, 
        3, 1.2, 'NewMaoS', 2026, 'Table required (U6_6.6-P3_table.png).', 
        '{integral_additivity_error}', '{integral_properties_basic}', 'published', 1,
        0.9, 0.1, 'integral_properties_basic', '{}'
    ) RETURNING id INTO q_id;

    INSERT INTO public.question_skills (question_id, skill_id, weight, role) VALUES 
    (q_id, 'integral_properties_basic', 0.9, 'primary');

    INSERT INTO public.question_error_patterns (question_id, error_tag_id) VALUES
    (q_id, 'integral_additivity_error');


    -- U6.6-P4
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type,
        calculator_allowed, difficulty, target_time_seconds,
        prompt_type, representation_type, prompt, latex,
        options, correct_option_id, explanation, micro_explanations,
        reasoning_level, mastery_weight, source, source_year, notes,
        error_tags, skill_tags, status, version,
        weight_primary, weight_supporting, primary_skill_id, supporting_skill_ids
    ) VALUES (
        'U6.6-P4', 'Both', 'Integration', 'Both_Integration', '6.6', '6.6', 'MCQ',
        false, 2, 120,
        'text', 'symbolic', 'If $\int_a^b f(x)\,dx=3$ and $\int_a^b g(x)\,dx=-2$, what is $\int_a^b (f(x)+g(x))\,dx$?', 'If $\int_a^b f(x)\,dx=3$ and $\int_a^b g(x)\,dx=-2$, what is $\int_a^b (f(x)+g(x))\,dx$?',
        '[{"id": "A", "text": "$-5$"}, {"id": "B", "text": "$-1$"}, {"id": "C", "text": "$1$"}, {"id": "D", "text": "$5$"}]'::jsonb, 
        'C', 
        'Additivity: $\int (f+g)=\int f+\int g=3+(-2)=1$.',
        '{"A": "Wrong.", "B": "Wrong.", "C": "Correct.", "D": "Wrong."}'::jsonb, 
        2, 1.05, 'NewMaoS', 2026, '', 
        '{integral_additivity_error}', '{integral_properties_basic}', 'published', 1,
        0.9, 0.1, 'integral_properties_basic', '{}'
    ) RETURNING id INTO q_id;

    INSERT INTO public.question_skills (question_id, skill_id, weight, role) VALUES 
    (q_id, 'integral_properties_basic', 0.9, 'primary');

    INSERT INTO public.question_error_patterns (question_id, error_tag_id) VALUES
    (q_id, 'integral_additivity_error');


    -- U6.6-P5
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type,
        calculator_allowed, difficulty, target_time_seconds,
        prompt_type, representation_type, prompt, latex,
        options, correct_option_id, explanation, micro_explanations,
        reasoning_level, mastery_weight, source, source_year, notes,
        error_tags, skill_tags, status, version,
        weight_primary, weight_supporting, primary_skill_id, supporting_skill_ids
    ) VALUES (
        'U6.6-P5', 'Both', 'Integration', 'Both_Integration', '6.6', '6.6', 'MCQ',
        false, 3, 150,
        'text', 'symbolic', 'Suppose $f$ is an odd function. What must be true about $\int_{-2}^{2} f(x)\,dx$?', 'Suppose $f$ is an odd function. What must be true about $\int_{-2}^{2} f(x)\,dx$?',
        '[{"id": "A", "text": "It equals $0$."}, {"id": "B", "text": "It is positive."}, {"id": "C", "text": "It is negative."}, {"id": "D", "text": "It equals $2\\int_0^2 f(x)\\,dx$."}]'::jsonb, 
        'A', 
        'For an odd function, areas on symmetric intervals cancel, so the integral over $[-2,2]$ is 0.',
        '{"A": "Correct: symmetry cancellation.", "B": "Wrong.", "C": "Wrong.", "D": "Wrong: that is for even functions."}'::jsonb, 
        3, 1.2, 'NewMaoS', 2026, '', 
        '{symmetry_even_odd_misuse}', '{integral_symmetry_even_odd}', 'published', 1,
        0.9, 0.1, 'integral_symmetry_even_odd', '{}'
    ) RETURNING id INTO q_id;

    INSERT INTO public.question_skills (question_id, skill_id, weight, role) VALUES 
    (q_id, 'integral_symmetry_even_odd', 0.9, 'primary');

    INSERT INTO public.question_error_patterns (question_id, error_tag_id) VALUES
    (q_id, 'symmetry_even_odd_misuse');


    -- ============================================================
    -- Section 6.7
    -- ============================================================

    -- U6.7-P1
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type,
        calculator_allowed, difficulty, target_time_seconds,
        prompt_type, representation_type, prompt, latex,
        options, correct_option_id, explanation, micro_explanations,
        reasoning_level, mastery_weight, source, source_year, notes,
        error_tags, skill_tags, status, version,
        weight_primary, weight_supporting, primary_skill_id, supporting_skill_ids
    ) VALUES (
        'U6.7-P1', 'Both', 'Integration', 'Both_Integration', '6.7', '6.7', 'MCQ',
        false, 3, 150,
        'text', 'symbolic', 'Evaluate $\int_1^3 (3x^2-4)\,dx$.', 'Evaluate $\int_1^3 (3x^2-4)\,dx$.',
        '[{"id": "A", "text": "12"}, {"id": "B", "text": "18"}, {"id": "C", "text": "6"}, {"id": "D", "text": "-18"}]'::jsonb, 
        'B', 
        'An antiderivative is $x^3-4x$. Evaluate: $(27-12)-(1-4)=15-(-3)=18$.',
        '{"A": "Wrong: arithmetic/antiderivative evaluation error.", "B": "Correct: FTC2 gives 18.", "C": "Wrong: missing part of the evaluation.", "D": "Wrong: sign error."}'::jsonb, 
        3, 1.15, 'self', 2026, '', 
        '{ftc2_antiderivative_not_used}', '{ftc2_evaluate_integral,antiderivative_basic_rules}', 'published', 1,
        0.8, 0.2, 'ftc2_evaluate_integral', '{antiderivative_basic_rules}'
    ) RETURNING id INTO q_id;

    INSERT INTO public.question_skills (question_id, skill_id, weight, role) VALUES 
    (q_id, 'ftc2_evaluate_integral', 0.8, 'primary'),
    (q_id, 'antiderivative_basic_rules', 0.2, 'supporting');

    INSERT INTO public.question_error_patterns (question_id, error_tag_id) VALUES
    (q_id, 'ftc2_antiderivative_not_used');


    -- U6.7-P2
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type,
        calculator_allowed, difficulty, target_time_seconds,
        prompt_type, representation_type, prompt, latex,
        options, correct_option_id, explanation, micro_explanations,
        reasoning_level, mastery_weight, source, source_year, notes,
        error_tags, skill_tags, status, version,
        weight_primary, weight_supporting, primary_skill_id, supporting_skill_ids
    ) VALUES (
        'U6.7-P2', 'Both', 'Integration', 'Both_Integration', '6.7', '6.7', 'MCQ',
        false, 2, 120,
        'text', 'symbolic', 'Let $F$ be an antiderivative of $f$, so $F''(x)=f(x)$. If $F(2)=5$ and $F(6)=-1$, what is $\int_2^6 f(x)\,dx$?', 'Let $F$ be an antiderivative of $f$, so $F''(x)=f(x)$. If $F(2)=5$ and $F(6)=-1$, what is $\int_2^6 f(x)\,dx$?',
        '[{"id": "A", "text": "6"}, {"id": "B", "text": "-6"}, {"id": "C", "text": "4"}, {"id": "D", "text": "-4"}]'::jsonb, 
        'B', 
        'FTC2: $\int_2^6 f(x)\,dx=F(6)-F(2)=-1-5=-6$.',
        '{"A": "Wrong: sign is reversed.", "B": "Correct: difference of antiderivative values.", "C": "Wrong: incorrect subtraction.", "D": "Wrong: incorrect subtraction and sign."}'::jsonb, 
        2, 1.0, 'self', 2026, '', 
        '{ftc2_antiderivative_not_used}', '{ftc2_evaluate_integral,definite_integral_notation}', 'published', 1,
        0.8, 0.2, 'ftc2_evaluate_integral', '{definite_integral_notation}'
    ) RETURNING id INTO q_id;

    INSERT INTO public.question_skills (question_id, skill_id, weight, role) VALUES 
    (q_id, 'ftc2_evaluate_integral', 0.8, 'primary'),
    (q_id, 'definite_integral_notation', 0.2, 'supporting');

    INSERT INTO public.question_error_patterns (question_id, error_tag_id) VALUES
    (q_id, 'ftc2_antiderivative_not_used');


    -- U6.7-P3
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type,
        calculator_allowed, difficulty, target_time_seconds,
        prompt_type, representation_type, prompt, latex,
        options, correct_option_id, explanation, micro_explanations,
        reasoning_level, mastery_weight, source, source_year, notes,
        error_tags, skill_tags, status, version,
        weight_primary, weight_supporting, primary_skill_id, supporting_skill_ids
    ) VALUES (
        'U6.7-P3', 'Both', 'Integration', 'Both_Integration', '6.7', '6.7', 'MCQ',
        false, 2, 90,
        'text', 'symbolic', 'If $\int_0^2 f(x)\,dx=3$, what is $\int_2^0 5f(x)\,dx$?', 'If $\int_0^2 f(x)\,dx=3$, what is $\int_2^0 5f(x)\,dx$?',
        '[{"id": "A", "text": "15"}, {"id": "B", "text": "-15"}, {"id": "C", "text": "5"}, {"id": "D", "text": "-5"}]'::jsonb, 
        'B', 
        'Scaling gives $\int_0^2 5f=15$. Reversing bounds changes sign, so $\int_2^0 5f=-15$.',
        '{"A": "Wrong: forgot reversal changes sign.", "B": "Correct: scale then reverse.", "C": "Wrong: did not scale correctly.", "D": "Wrong: did not scale correctly and sign is wrong."}'::jsonb, 
        2, 1.0, 'self', 2026, '', 
        '{integral_bounds_reversal_error}', '{integral_properties_basic,ftc2_evaluate_integral}', 'published', 1,
        0.8, 0.2, 'integral_properties_basic', '{ftc2_evaluate_integral}'
    ) RETURNING id INTO q_id;

    INSERT INTO public.question_skills (question_id, skill_id, weight, role) VALUES 
    (q_id, 'integral_properties_basic', 0.8, 'primary'),
    (q_id, 'ftc2_evaluate_integral', 0.2, 'supporting');

    INSERT INTO public.question_error_patterns (question_id, error_tag_id) VALUES
    (q_id, 'integral_bounds_reversal_error');


    -- U6.7-P4
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type,
        calculator_allowed, difficulty, target_time_seconds,
        prompt_type, representation_type, prompt, latex,
        options, correct_option_id, explanation, micro_explanations,
        reasoning_level, mastery_weight, source, source_year, notes,
        error_tags, skill_tags, status, version,
        weight_primary, weight_supporting, primary_skill_id, supporting_skill_ids
    ) VALUES (
        'U6.7-P4', 'Both', 'Integration', 'Both_Integration', '6.7', '6.7', 'MCQ',
        false, 3, 150,
        'text', 'symbolic', 'Evaluate $\int_0^{\pi} \sin x\,dx$.', 'Evaluate $\int_0^{\pi} \sin x\,dx$.',
        '[{"id": "A", "text": "0"}, {"id": "B", "text": "1"}, {"id": "C", "text": "2"}, {"id": "D", "text": "-2"}]'::jsonb, 
        'C', 
        'An antiderivative is $-\cos x$. Evaluate: $[-\cos x]_0^{\pi}=(-\cos\pi)-(-\cos 0)=1-(-1)=2$.',
        '{"A": "Wrong: net area is not zero here.", "B": "Wrong: incomplete evaluation.", "C": "Correct: FTC2 gives 2.", "D": "Wrong: sign error."}'::jsonb, 
        3, 1.15, 'self', 2026, '', 
        '{ftc2_antiderivative_not_used}', '{ftc2_evaluate_integral,antiderivative_basic_rules}', 'published', 1,
        0.8, 0.2, 'ftc2_evaluate_integral', '{antiderivative_basic_rules}'
    ) RETURNING id INTO q_id;

    INSERT INTO public.question_skills (question_id, skill_id, weight, role) VALUES 
    (q_id, 'ftc2_evaluate_integral', 0.8, 'primary'),
    (q_id, 'antiderivative_basic_rules', 0.2, 'supporting');

    INSERT INTO public.question_error_patterns (question_id, error_tag_id) VALUES
    (q_id, 'ftc2_antiderivative_not_used');


    -- U6.7-P5
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type,
        calculator_allowed, difficulty, target_time_seconds,
        prompt_type, representation_type, prompt, latex,
        options, correct_option_id, explanation, micro_explanations,
        reasoning_level, mastery_weight, source, source_year, notes,
        error_tags, skill_tags, status, version,
        weight_primary, weight_supporting, primary_skill_id, supporting_skill_ids
    ) VALUES (
        'U6.7-P5', 'Both', 'Integration', 'Both_Integration', '6.7', '6.7', 'MCQ',
        false, 3, 180,
        'text', 'symbolic', 'Evaluate $\int_2^0 (x^2+1)\,dx$.', 'Evaluate $\int_2^0 (x^2+1)\,dx$.',
        '[{"id": "A", "text": "$\\frac{14}{3}$"}, {"id": "B", "text": "$-\\frac{14}{3}$"}, {"id": "C", "text": "$\\frac{10}{3}$"}, {"id": "D", "text": "$-\\frac{10}{3}$"}]'::jsonb, 
        'B', 
        'First compute $\int_0^2 (x^2+1)\,dx=[\frac{x^3}{3}+x]_0^2=\frac{8}{3}+2=\frac{14}{3}$. Reversing bounds gives $-\frac{14}{3}$.',
        '{"A": "Wrong: forgot reversal changes sign.", "B": "Correct: compute then reverse.", "C": "Wrong: antiderivative evaluation error.", "D": "Wrong: both evaluation and sign are wrong."}'::jsonb, 
        3, 1.15, 'self', 2026, '', 
        '{integral_bounds_reversal_error}', '{ftc2_evaluate_integral,integral_properties_basic}', 'published', 1,
        0.8, 0.2, 'ftc2_evaluate_integral', '{integral_properties_basic}'
    ) RETURNING id INTO q_id;

    INSERT INTO public.question_skills (question_id, skill_id, weight, role) VALUES 
    (q_id, 'ftc2_evaluate_integral', 0.8, 'primary'),
    (q_id, 'integral_properties_basic', 0.2, 'supporting');

    INSERT INTO public.question_error_patterns (question_id, error_tag_id) VALUES
    (q_id, 'integral_bounds_reversal_error');


    -- ============================================================
    -- Section 6.8
    -- ============================================================

    -- U6.8-P1
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type,
        calculator_allowed, difficulty, target_time_seconds,
        prompt_type, representation_type, prompt, latex,
        options, correct_option_id, explanation, micro_explanations,
        reasoning_level, mastery_weight, source, source_year, notes,
        error_tags, skill_tags, status, version,
        weight_primary, weight_supporting, primary_skill_id, supporting_skill_ids
    ) VALUES (
        'U6.8-P1', 'Both', 'Integration', 'Both_Integration', '6.8', '6.8', 'MCQ',
        false, 3, 150,
        'text', 'symbolic', 'Find $\int (6x^5-4x^{-2})\,dx$.', 'Find $\int (6x^5-4x^{-2})\,dx$.',
        '[{"id": "A", "text": "$x^6+\\frac{4}{x}+C$"}, {"id": "B", "text": "$x^6-\\frac{4}{x}+C$"}, {"id": "C", "text": "$6x^6+4x^{-1}+C$"}, {"id": "D", "text": "$x^6+4x^{-2}+C$"}]'::jsonb, 
        'A', 
        'Integrate term-by-term: $\int 6x^5 dx=x^6$. Also $\int -4x^{-2} dx=-4\cdot \frac{x^{-1}}{-1}=4x^{-1}=\frac{4}{x}$. Add $C$.',
        '{"A": "Correct: both terms integrated correctly and includes $C$.", "B": "Wrong: sign error on the $x^{-2}$ term.", "C": "Wrong: incorrect coefficient on the first term.", "D": "Wrong: integrated $x^{-2}$ incorrectly."}'::jsonb, 
        3, 1.15, 'self', 2026, '', 
        '{power_rule_antiderivative_error}', '{antiderivative_basic_rules,indefinite_integral_notation}', 'published', 1,
        0.8, 0.2, 'antiderivative_basic_rules', '{indefinite_integral_notation}'
    ) RETURNING id INTO q_id;

    INSERT INTO public.question_skills (question_id, skill_id, weight, role) VALUES 
    (q_id, 'antiderivative_basic_rules', 0.8, 'primary'),
    (q_id, 'indefinite_integral_notation', 0.2, 'supporting');

    INSERT INTO public.question_error_patterns (question_id, error_tag_id) VALUES
    (q_id, 'power_rule_antiderivative_error');


    -- U6.8-P2
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type,
        calculator_allowed, difficulty, target_time_seconds,
        prompt_type, representation_type, prompt, latex,
        options, correct_option_id, explanation, micro_explanations,
        reasoning_level, mastery_weight, source, source_year, notes,
        error_tags, skill_tags, status, version,
        weight_primary, weight_supporting, primary_skill_id, supporting_skill_ids
    ) VALUES (
        'U6.8-P2', 'Both', 'Integration', 'Both_Integration', '6.8', '6.8', 'MCQ',
        false, 2, 120,
        'text', 'symbolic', 'Which is the most general antiderivative of $f(x)=3x^2$?', 'Which is the most general antiderivative of $f(x)=3x^2$?',
        '[{"id": "A", "text": "$x^3$"}, {"id": "B", "text": "$x^3+C$"}, {"id": "C", "text": "$3x^3+C$"}, {"id": "D", "text": "$x^2+C$"}]'::jsonb, 
        'B', 
        'Since $\frac{d}{dx}(x^3)=3x^2$, the general antiderivative is $x^3+C$.',
        '{"A": "Wrong: missing the constant of integration.", "B": "Correct: includes $C$.", "C": "Wrong: derivative would be $9x^2$.", "D": "Wrong: derivative would be $2x$, not $3x^2$."}'::jsonb, 
        2, 1.0, 'self', 2026, '', 
        '{antiderivative_constant_missing}', '{indefinite_integral_notation,antiderivative_basic_rules}', 'published', 1,
        0.8, 0.2, 'indefinite_integral_notation', '{antiderivative_basic_rules}'
    ) RETURNING id INTO q_id;

    INSERT INTO public.question_skills (question_id, skill_id, weight, role) VALUES 
    (q_id, 'indefinite_integral_notation', 0.8, 'primary'),
    (q_id, 'antiderivative_basic_rules', 0.2, 'supporting');

    INSERT INTO public.question_error_patterns (question_id, error_tag_id) VALUES
    (q_id, 'antiderivative_constant_missing');


    -- U6.8-P3
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type,
        calculator_allowed, difficulty, target_time_seconds,
        prompt_type, representation_type, prompt, latex,
        options, correct_option_id, explanation, micro_explanations,
        reasoning_level, mastery_weight, source, source_year, notes,
        error_tags, skill_tags, status, version,
        weight_primary, weight_supporting, primary_skill_id, supporting_skill_ids
    ) VALUES (
        'U6.8-P3', 'Both', 'Integration', 'Both_Integration', '6.8', '6.8', 'MCQ',
        false, 3, 180,
        'text', 'symbolic', 'Let $F''(x)=2x$ and $F(3)=5$. What is $F(x)$?', 'Let $F''(x)=2x$ and $F(3)=5$. What is $F(x)$?',
        '[{"id": "A", "text": "$x^2+5$"}, {"id": "B", "text": "$x^2-4$"}, {"id": "C", "text": "$2x^2+5$"}, {"id": "D", "text": "$x^2+4$"}]'::jsonb, 
        'B', 
        'Since $F''(x)=2x$, $F(x)=x^2+C$. Use $F(3)=5$: $9+C=5$ so $C=-4$. Thus $F(x)=x^2-4$.',
        '{"A": "Wrong: does not satisfy $F(3)=5$.", "B": "Correct: matches both derivative and the given point.", "C": "Wrong: derivative would be $4x$.", "D": "Wrong: does not satisfy $F(3)=5$."}'::jsonb, 
        3, 1.15, 'self', 2026, '', 
        '{antiderivative_constant_missing}', '{indefinite_integral_notation,antiderivative_basic_rules}', 'published', 1,
        0.8, 0.2, 'indefinite_integral_notation', '{antiderivative_basic_rules}'
    ) RETURNING id INTO q_id;

    INSERT INTO public.question_skills (question_id, skill_id, weight, role) VALUES 
    (q_id, 'indefinite_integral_notation', 0.8, 'primary'),
    (q_id, 'antiderivative_basic_rules', 0.2, 'supporting');

    INSERT INTO public.question_error_patterns (question_id, error_tag_id) VALUES
    (q_id, 'antiderivative_constant_missing');


    -- U6.8-P4
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type,
        calculator_allowed, difficulty, target_time_seconds,
        prompt_type, representation_type, prompt, latex,
        options, correct_option_id, explanation, micro_explanations,
        reasoning_level, mastery_weight, source, source_year, notes,
        error_tags, skill_tags, status, version,
        weight_primary, weight_supporting, primary_skill_id, supporting_skill_ids
    ) VALUES (
        'U6.8-P4', 'Both', 'Integration', 'Both_Integration', '6.8', '6.8', 'MCQ',
        false, 3, 150,
        'text', 'symbolic', 'Find $\int \frac{1}{x}\,dx$ for $x>0$.', 'Find $\int \frac{1}{x}\,dx$ for $x>0$.',
        '[{"id": "A", "text": "$\\ln x + C$"}, {"id": "B", "text": "$\\frac{1}{x}+C$"}, {"id": "C", "text": "$x\\ln x + C$"}, {"id": "D", "text": "$\\ln(x^2)+C$"}]'::jsonb, 
        'A', 
        'For $x>0$, $\int \frac{1}{x} dx=\ln x + C$.',
        '{"A": "Correct: derivative of $\\ln x$ is $1/x$.", "B": "Wrong: derivative of $1/x$ is $-1/x^2$.", "C": "Wrong: derivative is $\\ln x + 1$, not $1/x$.", "D": "Wrong: $\\ln(x^2)=2\\ln x$, which would have derivative $2/x$."}'::jsonb, 
        3, 1.15, 'self', 2026, '', 
        '{power_rule_antiderivative_error}', '{antiderivative_basic_rules,indefinite_integral_notation}', 'published', 1,
        0.8, 0.2, 'antiderivative_basic_rules', '{indefinite_integral_notation}'
    ) RETURNING id INTO q_id;

    INSERT INTO public.question_skills (question_id, skill_id, weight, role) VALUES 
    (q_id, 'antiderivative_basic_rules', 0.8, 'primary'),
    (q_id, 'indefinite_integral_notation', 0.2, 'supporting');

    INSERT INTO public.question_error_patterns (question_id, error_tag_id) VALUES
    (q_id, 'power_rule_antiderivative_error');


    -- U6.8-P5
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type,
        calculator_allowed, difficulty, target_time_seconds,
        prompt_type, representation_type, prompt, latex,
        options, correct_option_id, explanation, micro_explanations,
        reasoning_level, mastery_weight, source, source_year, notes,
        error_tags, skill_tags, status, version,
        weight_primary, weight_supporting, primary_skill_id, supporting_skill_ids
    ) VALUES (
        'U6.8-P5', 'Both', 'Integration', 'Both_Integration', '6.8', '6.8', 'MCQ',
        false, 2, 120,
        'text', 'symbolic', 'Which statement best describes what $\int f(x)\,dx$ represents?', 'Which statement best describes what $\int f(x)\,dx$ represents?',
        '[{"id": "A", "text": "A single number equal to the area under $f$."}, {"id": "B", "text": "A family of functions that differ by a constant."}, {"id": "C", "text": "The slope of $f$ at each point."}, {"id": "D", "text": "The exact value of a definite integral for any interval."}]'::jsonb, 
        'B', 
        'An indefinite integral represents all antiderivatives of $f$, which differ by a constant.',
        '{"A": "Wrong: that describes a definite integral, not an indefinite integral.", "B": "Correct: antiderivatives form a family differing by $C$.", "C": "Wrong: that is about derivatives, not antiderivatives.", "D": "Wrong: indefinite integrals do not directly give definite values without bounds."}'::jsonb, 
        2, 1.0, 'self', 2026, '', 
        '{antiderivative_constant_missing}', '{indefinite_integral_notation,definite_integral_notation}', 'published', 1,
        0.8, 0.2, 'indefinite_integral_notation', '{definite_integral_notation}'
    ) RETURNING id INTO q_id;

    INSERT INTO public.question_skills (question_id, skill_id, weight, role) VALUES 
    (q_id, 'indefinite_integral_notation', 0.8, 'primary'),
    (q_id, 'definite_integral_notation', 0.2, 'supporting');

    INSERT INTO public.question_error_patterns (question_id, error_tag_id) VALUES
    (q_id, 'antiderivative_constant_missing');

END $$;
