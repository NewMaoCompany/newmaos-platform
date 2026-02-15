-- 1. Seed Skills
INSERT INTO public.skills (id, name, unit) VALUES
('accumulation_behavior_analysis', 'Accumulation Behavior Analysis', 'Unit 6'),
('accumulation_concept', 'Accumulation Concept', 'Unit 6'),
('accumulation_from_variable_limit', 'Accumulation From Variable Limit', 'Unit 6'),
('antiderivative_basic_rules', 'Antiderivative Basic Rules', 'Unit 6'),
('area_under_curve_interpretation', 'Area Under Curve Interpretation', 'Unit 6'),
('definite_integral_notation', 'Definite Integral Notation', 'Unit 6'),
('ftc1_accumulation_function', 'Ftc1 Accumulation Function', 'Unit 6'),
('ftc2_evaluate_integral', 'Ftc2 Evaluate Integral', 'Unit 6'),
('indefinite_integral_notation', 'Indefinite Integral Notation', 'Unit 6'),
('\\integral_properties_basic', 'Integral Properties Basic', 'Unit 6'),
('\\integral_total_vs_net_area', 'Integral Total Vs Net Area', 'Unit 6')
ON CONFLICT (id) DO NOTHING;


-- 2. Seed Error Tags
INSERT INTO public.error_tags (id, name, category, severity) VALUES
('accumulation_behavior_misread', 'Accumulation Behavior Misread', 'conceptual', 2),
('accumulation_derivative_wrong_variable', 'Accumulation Derivative Wrong Variable', 'conceptual', 2),
('antiderivative_constant_missing', 'Antiderivative Constant Missing', 'conceptual', 2),
('area_sign_misread', 'Area Sign Misread', 'conceptual', 2),
('ftc2_antiderivative_not_used', 'Ftc2 Antiderivative Not Used', 'conceptual', 2),
('\\integral_bounds_reversal_error', 'Integral Bounds Reversal Error', 'conceptual', 2),
('net_vs_total_change_confusion', 'Net Vs Total Change Confusion', 'conceptual', 2),
('power_rule_antiderivative_error', 'Power Rule Antiderivative Error', 'conceptual', 2)
ON CONFLICT (id) DO NOTHING;


-- 3. Seed Questions
-- Using a DO block to handle UUID generation and linking
DO $$
DECLARE
    q_id UUID;
BEGIN

    -- Question: U6.5-P1
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type,
        calculator_allowed, difficulty, target_time_seconds,
        prompt_type, representation_type, prompt, latex,
        options, correct_option_id, tolerance, explanation,
        micro_explanations, recommendation_reasons,
       
        reasoning_level, mastery_weight,
        source, source_year, notes, error_tags, status, version
    ) VALUES (
        'U6.5-P1', 'Both', 'Integration', 'Both_Integration', '6.5', '6.5', 'MCQ',
        false, 3, 150,
        'text', 'symbolic', 'Let $A(x)=\int_0^x (t^2-4t)\,dt$ for $0\le x\le 5$. On which \\interval is $A(x)$ decreasing?', 'Let $A(x)=\int_0^x (t^2-4t)\,dt$ for $0\le x\le 5$. On which \\interval is $A(x)$ decreasing?',
        '[{"id": "A", "text": "$(0,4)$"}, {"id": "B", "text": "$(4,5)$"}, {"id": "C", "text": "$(0,5)$"}, {"id": "D", "text": "$(0,2)$"}]'::jsonb, 'A', 0, '$A''(x)=t^2-4t$ evaluated at $t=x$, so $A''(x)=x^2-4x=x(x-4)$. This is negative on $(0,4)$, so $A$ is decreasing there.',
        '{"A": "Correct: $A''(x)<0$ on $(0,4)$.", "B": "Wrong: for $x>4$, $A''(x)>0$, so $A$ increases.", "C": "Wrong: $A$ decreases then increases; it is not decreasing on the whole \\interval.", "D": "Wrong: $(0,2)$ is only part of where $A''(x)<0$."}'::jsonb, '{accumulation_behavior_analysis}',
        3, 1.15,
        'self', 2026, '', '{accumulation_behavior_misread}', 'published', 1
    ) RETURNING id INTO q_id;
    INSERT INTO public.question_skills (question_id, skill_id, weight, role)
    VALUES (q_id, 'accumulation_behavior_analysis', 0.8, 'primary')
    ON CONFLICT DO NOTHING;
    INSERT INTO public.question_skills (question_id, skill_id, weight, role)
    VALUES (q_id, 'ftc1_accumulation_function', 0.2, 'supporting')
    ON CONFLICT DO NOTHING;

    -- Question: U6.5-P2
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type,
        calculator_allowed, difficulty, target_time_seconds,
        prompt_type, representation_type, prompt, latex,
        options, correct_option_id, tolerance, explanation,
        micro_explanations, recommendation_reasons,
        reasoning_level, mastery_weight,
        source, source_year, notes, error_tags, status, version
    ) VALUES (
        'U6.5-P2', 'Both', 'Integration', 'Both_Integration', '6.5', '6.5', 'MCQ',
        false, 3, 180,
        'image', 'graph', 'The graph of $r(t)$ is provided. Let $A(x)=\int_0^x r(t)\,dt$ for $0\le x\le 6$. For which values of $x$ is $A(x)$ decreasing?', 'The graph of $r(t)$ is provided. Let $A(x)=\int_0^x r(t)\,dt$ for $0\le x\le 6$. For which values of $x$ is $A(x)$ decreasing?',
        '[{"id": "A", "text": "$0<x<3.2$"}, {"id": "B", "text": "$3.2<x<6$"}, {"id": "C", "text": "$0<x<2$"}, {"id": "D", "text": "$2<x<4$"}]'::jsonb, 'B', 0, '$A''(x)=r(x)$. So $A$ is decreasing where $r(x)<0$, which occurs after the graph crosses the axis at about $x\approx 3.2$ and remains below through $x=6$.',
        '{"A": "Wrong: $r(x)>0$ there, so $A$ increases.", "B": "Correct: $r(x)<0$ there, so $A$ decreases.", "C": "Wrong: $r(x)$ is positive on this \\interval.", "D": "Wrong: part of $(2,4)$ has $r(x)>0$ and part has $r(x)<0$."}'::jsonb, '{accumulation_behavior_analysis}',
        3, 1.15,
        'self', 2026, 'image_file: U6_6.5-P2_graph.png', '{area_sign_misread}', 'published', 1
    ) RETURNING id INTO q_id;
    INSERT INTO public.question_skills (question_id, skill_id, weight, role)
    VALUES (q_id, 'accumulation_behavior_analysis', 0.8, 'primary')
    ON CONFLICT DO NOTHING;
    INSERT INTO public.question_skills (question_id, skill_id, weight, role)
    VALUES (q_id, 'area_under_curve_interpretation', 0.2, 'supporting')
    ON CONFLICT DO NOTHING;

    -- Question: U6.5-P3
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type,
        calculator_allowed, difficulty, target_time_seconds,
        prompt_type, representation_type, prompt, latex,
        options, correct_option_id, tolerance, explanation,
        micro_explanations, recommendation_reasons,
        reasoning_level, mastery_weight,
        source, source_year, notes, error_tags, status, version
    ) VALUES (
        'U6.5-P3', 'Both', 'Integration', 'Both_Integration', '6.5', '6.5', 'MCQ',
        false, 4, 210,
        'image', 'graph', 'Using the provided graph of $r(t)$, let $A(x)=\int_0^x r(t)\,dt$. On which \\interval is $A(x)$ concave down?', 'Using the provided graph of $r(t)$, let $A(x)=\int_0^x r(t)\,dt$. On which \\interval is $A(x)$ concave down?',
        '[{"id": "A", "text": "$0<x<2$"}, {"id": "B", "text": "$2<x<4$"}, {"id": "C", "text": "$4<x<6$"}, {"id": "D", "text": "None; $A(x)$ is never concave down."}]'::jsonb, 'B', 0, '$A''(x)=r(x)$ and $A''''(x)=r''(x)$. $A$ is concave down where $r''(x)<0$, i.e., where $r$ is decreasing. From the graph, $r$ decreases on $(2,4)$.',
        '{"A": "Wrong: $r$ increases there, so $A''''(x)>0$ (concave up).", "B": "Correct: $r$ decreases there, so $A''''(x)<0$.", "C": "Wrong: $r$ increases there, so $A$ is concave up.", "D": "Wrong: there is an \\interval where $r$ is decreasing."}'::jsonb, '{accumulation_behavior_analysis}',
        4, 1.25,
        'self', 2026, 'image_file: U6_6.5-P2_graph.png', '{accumulation_behavior_misread}', 'published', 1
    ) RETURNING id INTO q_id;
    INSERT INTO public.question_skills (question_id, skill_id, weight, role)
    VALUES (q_id, 'accumulation_behavior_analysis', 0.8, 'primary')
    ON CONFLICT DO NOTHING;
    INSERT INTO public.question_skills (question_id, skill_id, weight, role)
    VALUES (q_id, 'accumulation_from_variable_limit', 0.2, 'supporting')
    ON CONFLICT DO NOTHING;

    -- Question: U6.5-P4
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type,
        calculator_allowed, difficulty, target_time_seconds,
        prompt_type, representation_type, prompt, latex,
        options, correct_option_id, tolerance, explanation,
        micro_explanations, recommendation_reasons,
        reasoning_level, mastery_weight,
        source, source_year, notes, error_tags, status, version
    ) VALUES (
        'U6.5-P4', 'Both', 'Integration', 'Both_Integration', '6.5', '6.5', 'MCQ',
        false, 2, 120,
        'image', 'graph', 'The graph of $g(x)$ is provided. Let $B(x)=\int_1^x g(t)\,dt$. What is $B''(5)$?', 'The graph of $g(x)$ is provided. Let $B(x)=\int_1^x g(t)\,dt$. What is $B''(5)$?',
        '[{"id": "A", "text": "$-2$"}, {"id": "B", "text": "$0$"}, {"id": "C", "text": "$1$"}, {"id": "D", "text": "$3$"}]'::jsonb, 'B', 0, 'By FTC Part 1, $B''(x)=g(x)$. From the graph, $g(5)=0$, so $B''(5)=0$.',
        '{"A": "Wrong: that is $g(6)$, not $g(5)$.", "B": "Correct: FTC1 gives $B''(5)=g(5)=0$.", "C": "Wrong: $g(3)=1$, not $g(5)$.", "D": "Wrong: $g(4)=3$, not $g(5)$."}'::jsonb, '{accumulation_from_variable_limit}',
        2, 1.0,
        'self', 2026, 'image_file: U6_6.5-P4_graph.png', '{accumulation_derivative_wrong_variable}', 'published', 1
    ) RETURNING id INTO q_id;
    INSERT INTO public.question_skills (question_id, skill_id, weight, role)
    VALUES (q_id, 'accumulation_from_variable_limit', 0.8, 'primary')
    ON CONFLICT DO NOTHING;
    INSERT INTO public.question_skills (question_id, skill_id, weight, role)
    VALUES (q_id, 'ftc1_accumulation_function', 0.2, 'supporting')
    ON CONFLICT DO NOTHING;

    -- Question: U6.5-P5
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type,
        calculator_allowed, difficulty, target_time_seconds,
        prompt_type, representation_type, prompt, latex,
        options, correct_option_id, tolerance, explanation,
        micro_explanations, recommendation_reasons,
        reasoning_level, mastery_weight,
        source, source_year, notes, error_tags, status, version
    ) VALUES (
        'U6.5-P5', 'Both', 'Integration', 'Both_Integration', '6.5', '6.5', 'MCQ',
        false, 3, 180,
        'text', 'symbolic', 'A particle has velocity $v(t)$ (in \frac{m}{s}) on $0\le t\le 4$. Suppose \int_0^4 v(t)\,dt=0$ and \int_0^4 |v(t)|\,dt=10$. Which statement is true?', 'A particle has velocity $v(t)$ (in \frac{m}{s}) on $0\le t\le 4$. Suppose \int_0^4 v(t)\,dt=0$ and \int_0^4 |v(t)|\,dt=10$. Which statement is true?',
        '[{"id": "A", "text": "Net displacement is 10 m and total distance is 0 m."}, {"id": "B", "text": "Net displacement is 0 m and total distance is 10 m."}, {"id": "C", "text": "Net displacement is 10 m and total distance is 10 m."}, {"id": "D", "text": "Net displacement is 0 m and total distance is 0 m."}]'::jsonb, 'B', 0, 'Net displacement equals \int_0^4 v(t)\,dt=0$. Total distance equals \int_0^4 |v(t)|\,dt=10$.',
        '{"A": "Wrong: it swaps net displacement and total distance.", "B": "Correct: net uses $v$, total uses $|v|$.", "C": "Wrong: net displacement is given as 0, not 10.", "D": "Wrong: total distance is 10, not 0."}'::jsonb, '{\\integral_total_vs_net_area}',
        3, 1.15,
        'self', 2026, '', '{net_vs_total_change_confusion}', 'published', 1
    ) RETURNING id INTO q_id;
    INSERT INTO public.question_skills (question_id, skill_id, weight, role)
    VALUES (q_id, '\\integral_total_vs_net_area', 0.8, 'primary')
    ON CONFLICT DO NOTHING;
    INSERT INTO public.question_skills (question_id, skill_id, weight, role)
    VALUES (q_id, 'accumulation_concept', 0.2, 'supporting')
    ON CONFLICT DO NOTHING;

    -- Question: U6.7-P1
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type,
        calculator_allowed, difficulty, target_time_seconds,
        prompt_type, representation_type, prompt, latex,
        options, correct_option_id, tolerance, explanation,
        micro_explanations, recommendation_reasons,
        reasoning_level, mastery_weight,
        source, source_year, notes, error_tags, status, version
    ) VALUES (
        'U6.7-P1', 'Both', 'Integration', 'Both_Integration', '6.7', '6.7', 'MCQ',
        false, 3, 150,
        'text', 'symbolic', 'Evaluate $\int_1^3 (3x^2-4)\,dx$.', 'Evaluate $\int_1^3 (3x^2-4)\,dx$.',
        '[{"id": "A", "text": "12"}, {"id": "B", "text": "18"}, {"id": "C", "text": "6"}, {"id": "D", "text": "-18"}]'::jsonb, 'B', 0, 'An antiderivative is $x^3-4x$. Evaluate: $(27-12)-(1-4)=15-(-3)=18$.',
        '{"A": "Wrong: \frac{arithmetic}{antiderivative} evaluation error.", "B": "Correct: FTC2 gives 18.", "C": "Wrong: missing part of the evaluation.", "D": "Wrong: sign error."}'::jsonb, '{ftc2_evaluate_integral}',
        3, 1.15,
        'self', 2026, '', '{ftc2_antiderivative_not_used}', 'published', 1
    ) RETURNING id INTO q_id;
    INSERT INTO public.question_skills (question_id, skill_id, weight, role)
    VALUES (q_id, 'ftc2_evaluate_integral', 0.8, 'primary')
    ON CONFLICT DO NOTHING;
    INSERT INTO public.question_skills (question_id, skill_id, weight, role)
    VALUES (q_id, 'antiderivative_basic_rules', 0.2, 'supporting')
    ON CONFLICT DO NOTHING;

    -- Question: U6.7-P2
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type,
        calculator_allowed, difficulty, target_time_seconds,
        prompt_type, representation_type, prompt, latex,
        options, correct_option_id, tolerance, explanation,
        micro_explanations, recommendation_reasons,
        reasoning_level, mastery_weight,
        source, source_year, notes, error_tags, status, version
    ) VALUES (
        'U6.7-P2', 'Both', 'Integration', 'Both_Integration', '6.7', '6.7', 'MCQ',
        false, 2, 120,
        'text', 'symbolic', 'Let $F$ be an antiderivative of $f$, so $F''(x)=f(x)$. If $F(2)=5$ and $F(6)=-1$, what is $\int_2^6 f(x)\,dx$?', 'Let $F$ be an antiderivative of $f$, so $F''(x)=f(x)$. If $F(2)=5$ and $F(6)=-1$, what is $\int_2^6 f(x)\,dx$?',
        '[{"id": "A", "text": "6"}, {"id": "B", "text": "-6"}, {"id": "C", "text": "4"}, {"id": "D", "text": "-4"}]'::jsonb, 'B', 0, 'FTC2: $\int_2^6 f(x)\,dx=F(6)-F(2)=-1-5=-6$.',
        '{"A": "Wrong: sign is reversed.", "B": "Correct: difference of antiderivative values.", "C": "Wrong: incorrect subtraction.", "D": "Wrong: incorrect subtraction and sign."}'::jsonb, '{ftc2_evaluate_integral}',
        2, 1.0,
        'self', 2026, '', '{ftc2_antiderivative_not_used}', 'published', 1
    ) RETURNING id INTO q_id;
    INSERT INTO public.question_skills (question_id, skill_id, weight, role)
    VALUES (q_id, 'ftc2_evaluate_integral', 0.8, 'primary')
    ON CONFLICT DO NOTHING;
    INSERT INTO public.question_skills (question_id, skill_id, weight, role)
    VALUES (q_id, 'definite_integral_notation', 0.2, 'supporting')
    ON CONFLICT DO NOTHING;

    -- Question: U6.7-P3
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type,
        calculator_allowed, difficulty, target_time_seconds,
        prompt_type, representation_type, prompt, latex,
        options, correct_option_id, tolerance, explanation,
        micro_explanations, recommendation_reasons,
        reasoning_level, mastery_weight,
        source, source_year, notes, error_tags, status, version
    ) VALUES (
        'U6.7-P3', 'Both', 'Integration', 'Both_Integration', '6.7', '6.7', 'MCQ',
        false, 2, 90,
        'text', 'symbolic', 'If $\int_0^2 f(x)\,dx=3$, what is $\int_2^0 5f(x)\,dx$?', 'If $\int_0^2 f(x)\,dx=3$, what is $\int_2^0 5f(x)\,dx$?',
        '[{"id": "A", "text": "15"}, {"id": "B", "text": "-15"}, {"id": "C", "text": "5"}, {"id": "D", "text": "-5"}]'::jsonb, 'B', 0, 'Scaling gives $\int_0^2 5f=15$. Reversing bounds changes sign, so $\int_2^0 5f=-15$.',
        '{"A": "Wrong: forgot reversal changes sign.", "B": "Correct: scale then reverse.", "C": "Wrong: did not scale correctly.", "D": "Wrong: did not scale correctly and sign is wrong."}'::jsonb, '{\\integral_properties_basic}',
        2, 1.0,
        'self', 2026, '', '{\\integral_bounds_reversal_error}', 'published', 1
    ) RETURNING id INTO q_id;
    INSERT INTO public.question_skills (question_id, skill_id, weight, role)
    VALUES (q_id, '\\integral_properties_basic', 0.8, 'primary')
    ON CONFLICT DO NOTHING;
    INSERT INTO public.question_skills (question_id, skill_id, weight, role)
    VALUES (q_id, 'ftc2_evaluate_integral', 0.2, 'supporting')
    ON CONFLICT DO NOTHING;

    -- Question: U6.7-P4
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type,
        calculator_allowed, difficulty, target_time_seconds,
        prompt_type, representation_type, prompt, latex,
        options, correct_option_id, tolerance, explanation,
        micro_explanations, recommendation_reasons,
        reasoning_level, mastery_weight,
        source, source_year, notes, error_tags, status, version
    ) VALUES (
        'U6.7-P4', 'Both', 'Integration', 'Both_Integration', '6.7', '6.7', 'MCQ',
        false, 3, 150,
        'text', 'symbolic', 'Evaluate $\int_0^{\pi} \\\\\\\sin x\,dx$.', 'Evaluate $\int_0^{\pi} \\\\\\\sin x\,dx$.',
        '[{"id": "A", "text": "0"}, {"id": "B", "text": "1"}, {"id": "C", "text": "2"}, {"id": "D", "text": "-2"}]'::jsonb, 'C', 0, 'An antiderivative is $-\\\\\\\cos x$. Evaluate: $[-\\\\\\\cos x]_0^{\pi}=(-\\\\\\\cos\pi)-(-\\\\\\\cos 0)=1-(-1)=2$.',
        '{"A": "Wrong: net area is not zero here.", "B": "Wrong: incomplete evaluation.", "C": "Correct: FTC2 gives 2.", "D": "Wrong: sign error."}'::jsonb, '{ftc2_evaluate_integral}',
        3, 1.15,
        'self', 2026, '', '{ftc2_antiderivative_not_used}', 'published', 1
    ) RETURNING id INTO q_id;
    INSERT INTO public.question_skills (question_id, skill_id, weight, role)
    VALUES (q_id, 'ftc2_evaluate_integral', 0.8, 'primary')
    ON CONFLICT DO NOTHING;
    INSERT INTO public.question_skills (question_id, skill_id, weight, role)
    VALUES (q_id, 'antiderivative_basic_rules', 0.2, 'supporting')
    ON CONFLICT DO NOTHING;

    -- Question: U6.7-P5
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type,
        calculator_allowed, difficulty, target_time_seconds,
        prompt_type, representation_type, prompt, latex,
        options, correct_option_id, tolerance, explanation,
        micro_explanations, recommendation_reasons,
        reasoning_level, mastery_weight,
        source, source_year, notes, error_tags, status, version
    ) VALUES (
        'U6.7-P5', 'Both', 'Integration', 'Both_Integration', '6.7', '6.7', 'MCQ',
        false, 3, 180,
        'text', 'symbolic', 'Evaluate $\int_2^0 (x^2+1)\,dx$.', 'Evaluate $\int_2^0 (x^2+1)\,dx$.',
        '[{"id": "A", "text": "$\\frac{14}{3}$"}, {"id": "B", "text": "$-\\frac{14}{3}$"}, {"id": "C", "text": "$\\frac{10}{3}$"}, {"id": "D", "text": "$-\\frac{10}{3}$"}]'::jsonb, 'B', 0, 'First compute $\int_0^2 (x^2+1)\,dx=[\frac{x^3}{3}+x]_0^2=\frac{8}{3}+2=\frac{14}{3}$. Reversing bounds gives $-\frac{14}{3}$.',
        '{"A": "Wrong: forgot reversal changes sign.", "B": "Correct: compute then reverse.", "C": "Wrong: antiderivative evaluation error.", "D": "Wrong: both evaluation and sign are wrong."}'::jsonb, '{ftc2_evaluate_integral}',
        3, 1.15,
        'self', 2026, '', '{\\integral_bounds_reversal_error}', 'published', 1
    ) RETURNING id INTO q_id;
    INSERT INTO public.question_skills (question_id, skill_id, weight, role)
    VALUES (q_id, 'ftc2_evaluate_integral', 0.8, 'primary')
    ON CONFLICT DO NOTHING;
    INSERT INTO public.question_skills (question_id, skill_id, weight, role)
    VALUES (q_id, '\\integral_properties_basic', 0.2, 'supporting')
    ON CONFLICT DO NOTHING;

    -- Question: U6.8-P1
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type,
        calculator_allowed, difficulty, target_time_seconds,
        prompt_type, representation_type, prompt, latex,
        options, correct_option_id, tolerance, explanation,
        micro_explanations, recommendation_reasons,
        reasoning_level, mastery_weight,
        source, source_year, notes, error_tags, status, version
    ) VALUES (
        'U6.8-P1', 'Both', 'Integration', 'Both_Integration', '6.8', '6.8', 'MCQ',
        false, 3, 150,
        'text', 'symbolic', 'Find $\int (6x^5-4x^{-2})\,dx$.', 'Find $\int (6x^5-4x^{-2})\,dx$.',
        '[{"id": "A", "text": "$x^6+\\frac{4}{x}+C$"}, {"id": "B", "text": "$x^6-\\frac{4}{x}+C$"}, {"id": "C", "text": "$6x^6+4x^{-1}+C$"}, {"id": "D", "text": "$x^6+4x^{-2}+C$"}]'::jsonb, 'A', 0, 'Integrate term-by-term: $\int 6x^5 dx=x^6$. Also $\int -4x^{-2} dx=-4\cdot \frac{x^{-1}}{-1}=4x^{-1}=\frac{4}{x}$. Add $C$.',
        '{"A": "Correct: both terms \\integrated correctly and includes $C$.", "B": "Wrong: sign error on the $x^{-2}$ term.", "C": "Wrong: incorrect coefficient on the first term.", "D": "Wrong: \\integrated $x^{-2}$ incorrectly."}'::jsonb, '{antiderivative_basic_rules}',
        3, 1.15,
        'self', 2026, '', '{power_rule_antiderivative_error}', 'published', 1
    ) RETURNING id INTO q_id;
    INSERT INTO public.question_skills (question_id, skill_id, weight, role)
    VALUES (q_id, 'antiderivative_basic_rules', 0.8, 'primary')
    ON CONFLICT DO NOTHING;
    INSERT INTO public.question_skills (question_id, skill_id, weight, role)
    VALUES (q_id, 'indefinite_integral_notation', 0.2, 'supporting')
    ON CONFLICT DO NOTHING;

    -- Question: U6.8-P2
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type,
        calculator_allowed, difficulty, target_time_seconds,
        prompt_type, representation_type, prompt, latex,
        options, correct_option_id, tolerance, explanation,
        micro_explanations, recommendation_reasons,
        reasoning_level, mastery_weight,
        source, source_year, notes, error_tags, status, version
    ) VALUES (
        'U6.8-P2', 'Both', 'Integration', 'Both_Integration', '6.8', '6.8', 'MCQ',
        false, 2, 120,
        'text', 'symbolic', 'Which is the most general antiderivative of $f(x)=3x^2$?', 'Which is the most general antiderivative of $f(x)=3x^2$?',
        '[{"id": "A", "text": "$x^3$"}, {"id": "B", "text": "$x^3+C$"}, {"id": "C", "text": "$3x^3+C$"}, {"id": "D", "text": "$x^2+C$"}]'::jsonb, 'B', 0, 'Since $\frac{d}{dx}(x^3)=3x^2$, the general antiderivative is $x^3+C$.',
        '{"A": "Wrong: missing the constant of \\integration.", "B": "Correct: includes $C$.", "C": "Wrong: derivative would be $9x^2$.", "D": "Wrong: derivative would be $2x$, not $3x^2$."}'::jsonb, '{indefinite_integral_notation}',
        2, 1.0,
        'self', 2026, '', '{antiderivative_constant_missing}', 'published', 1
    ) RETURNING id INTO q_id;
    INSERT INTO public.question_skills (question_id, skill_id, weight, role)
    VALUES (q_id, 'indefinite_integral_notation', 0.8, 'primary')
    ON CONFLICT DO NOTHING;
    INSERT INTO public.question_skills (question_id, skill_id, weight, role)
    VALUES (q_id, 'antiderivative_basic_rules', 0.2, 'supporting')
    ON CONFLICT DO NOTHING;

    -- Question: U6.8-P3
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type,
        calculator_allowed, difficulty, target_time_seconds,
        prompt_type, representation_type, prompt, latex,
        options, correct_option_id, tolerance, explanation,
        micro_explanations, recommendation_reasons,
        reasoning_level, mastery_weight,
        source, source_year, notes, error_tags, status, version
    ) VALUES (
        'U6.8-P3', 'Both', 'Integration', 'Both_Integration', '6.8', '6.8', 'MCQ',
        false, 3, 180,
        'text', 'symbolic', 'Let $F''(x)=2x$ and $F(3)=5$. What is $F(x)$?', 'Let $F''(x)=2x$ and $F(3)=5$. What is $F(x)$?',
        '[{"id": "A", "text": "$x^2+5$"}, {"id": "B", "text": "$x^2-4$"}, {"id": "C", "text": "$2x^2+5$"}, {"id": "D", "text": "$x^2+4$"}]'::jsonb, 'B', 0, 'Since $F''(x)=2x$, $F(x)=x^2+C$. Use $F(3)=5$: $9+C=5$ so $C=-4$. Thus $F(x)=x^2-4$.',
        '{"A": "Wrong: does not satisfy $F(3)=5$.", "B": "Correct: matches both derivative and the given point.", "C": "Wrong: derivative would be $4x$.", "D": "Wrong: does not satisfy $F(3)=5$."}'::jsonb, '{indefinite_integral_notation}',
        3, 1.15,
        'self', 2026, '', '{antiderivative_constant_missing}', 'published', 1
    ) RETURNING id INTO q_id;
    INSERT INTO public.question_skills (question_id, skill_id, weight, role)
    VALUES (q_id, 'indefinite_integral_notation', 0.8, 'primary')
    ON CONFLICT DO NOTHING;
    INSERT INTO public.question_skills (question_id, skill_id, weight, role)
    VALUES (q_id, 'antiderivative_basic_rules', 0.2, 'supporting')
    ON CONFLICT DO NOTHING;

    -- Question: U6.8-P4
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type,
        calculator_allowed, difficulty, target_time_seconds,
        prompt_type, representation_type, prompt, latex,
        options, correct_option_id, tolerance, explanation,
        micro_explanations, recommendation_reasons,
        reasoning_level, mastery_weight,
        source, source_year, notes, error_tags, status, version
    ) VALUES (
        'U6.8-P4', 'Both', 'Integration', 'Both_Integration', '6.8', '6.8', 'MCQ',
        false, 3, 150,
        'text', 'symbolic', 'Find $\int \frac{1}{x}\,dx$ for $x>0$.', 'Find $\int \frac{1}{x}\,dx$ for $x>0$.',
        '[{"id": "A", "text": "$\\\\\\\\ln x + C$"}, {"id": "B", "text": "$\\frac{1}{x}+C$"}, {"id": "C", "text": "$x\\\\\\\\ln x + C$"}, {"id": "D", "text": "$\\\\\\\\ln(x^2)+C$"}]'::jsonb, 'A', 0, 'For $x>0$, $\int \frac{1}{x} dx=\\\\\\\ln x + C$.',
        '{"A": "Correct: derivative of $\\\\\\\\ln x$ is $\frac{1}{x}$.", "B": "Wrong: derivative of $\frac{1}{x}$ is $-\frac{1}{x}^2$.", "C": "Wrong: derivative is $\\\\\\\\ln x + 1$, not $\frac{1}{x}$.", "D": "Wrong: $\\\\\\\\ln(x^2)=2\\\\\\\\ln x$, which would have derivative $\frac{2}{x}$."}'::jsonb, '{antiderivative_basic_rules}',
        3, 1.15,
        'self', 2026, '', '{power_rule_antiderivative_error}', 'published', 1
    ) RETURNING id INTO q_id;
    INSERT INTO public.question_skills (question_id, skill_id, weight, role)
    VALUES (q_id, 'antiderivative_basic_rules', 0.8, 'primary')
    ON CONFLICT DO NOTHING;
    INSERT INTO public.question_skills (question_id, skill_id, weight, role)
    VALUES (q_id, 'indefinite_integral_notation', 0.2, 'supporting')
    ON CONFLICT DO NOTHING;

    -- Question: U6.8-P5
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type,
        calculator_allowed, difficulty, target_time_seconds,
        prompt_type, representation_type, prompt, latex,
        options, correct_option_id, tolerance, explanation,
        micro_explanations, recommendation_reasons,
        reasoning_level, mastery_weight,
        source, source_year, notes, error_tags, status, version
    ) VALUES (
        'U6.8-P5', 'Both', 'Integration', 'Both_Integration', '6.8', '6.8', 'MCQ',
        false, 2, 120,
        'text', 'symbolic', 'Which statement best describes what $\int f(x)\,dx$ represents?', 'Which statement best describes what $\int f(x)\,dx$ represents?',
        '[{"id": "A", "text": "A single number equal to the area under $f$."}, {"id": "B", "text": "A family of functions that differ by a constant."}, {"id": "C", "text": "The slope of $f$ at each point."}, {"id": "D", "text": "The exact value of a definite integral for any interval."}]'::jsonb, 'B', 0, 'An indefinite \\integral represents all antiderivatives of $f$, which differ by a constant.',
        '{"A": "Wrong: that describes a definite \\integral, not an indefinite \\integral.", "B": "Correct: antiderivatives form a family differing by $C$.", "C": "Wrong: that is about derivatives, not antiderivatives.", "D": "Wrong: indefinite \\integrals do not directly give definite values without bounds."}'::jsonb, '{indefinite_integral_notation}',
        2, 1.0,
        'self', 2026, '', '{antiderivative_constant_missing}', 'published', 1
    ) RETURNING id INTO q_id;
    INSERT INTO public.question_skills (question_id, skill_id, weight, role)
    VALUES (q_id, 'indefinite_integral_notation', 0.8, 'primary')
    ON CONFLICT DO NOTHING;
    INSERT INTO public.question_skills (question_id, skill_id, weight, role)
    VALUES (q_id, 'definite_integral_notation', 0.2, 'supporting')
    ON CONFLICT DO NOTHING;
END $$;
