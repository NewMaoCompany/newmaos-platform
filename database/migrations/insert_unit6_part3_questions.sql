-- ====================================================================
-- Insert Script for Unit 6 Part 3 (Sections 6.9 - 6.12)
-- 
-- Covers:
-- 6.9: Integration by Substitution (Basic)
-- 6.10: Integration of Rational Functions (Long Division, Completing Square)
-- 6.11: Integration using Integration by Parts (Technique Selection)
-- 6.12: Integration using Linear Partial Fractions (Technique Selection)
--
-- Actions:
-- 1. Inserts missing Error Tags
-- 2. Inserts Questions (populating explicit columns + legacy arrays)
-- 3. Inserts Junction Table records (question_skills, question_error_patterns)
-- ====================================================================

-- 1. Insert Missing Error Tags
INSERT INTO public.error_tags (id, name, category, severity, unit) VALUES
('u_choice_poor', 'Poor u-Choice', 'Substitution', 3, 'Both_Integration'),
('du_missing_factor', 'Missing Factor in du', 'Substitution', 3, 'Both_Integration'),
('u_limits_not_changed_or_mixed', 'u-Limits Not \frac{Changed}{Mixed}', 'Substitution', 4, 'Both_Integration'),
('long_division_skipped', 'Long Division Skipped', 'Algebra', 3, 'Both_Integration'),
('complete_square_incorrect', 'Completing Square Incorrect', 'Algebra', 3, 'Both_Integration')
ON CONFLICT (id) DO NOTHING;

-- 2. Clean up existing questions to prevent duplicates
DELETE FROM public.questions WHERE title IN (
    'U6.9-P1', 'U6.9-P2', 'U6.9-P3', 'U6.9-P4', 'U6.9-P5',
    'U6.10-P1', 'U6.10-P2', 'U6.10-P3', 'U6.10-P4', 'U6.10-P5',
    'U6.11-P1', 'U6.11-P2', 'U6.11-P3', 'U6.11-P4', 'U6.11-P5',
    'U6.12-P1', 'U6.12-P2', 'U6.12-P3', 'U6.12-P4', 'U6.12-P5'
);

-- 3. Insert Questions
DO $$
DECLARE
    q_id UUID;
BEGIN

    -- ============================================================
    -- Section 6.9
    -- ============================================================

    -- U6.9-P1
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type,
        calculator_allowed, difficulty, target_time_seconds,
        prompt_type, representation_type, prompt, latex,
        options, correct_option_id, explanation, micro_explanations,
        reasoning_level, mastery_weight, source, source_year, notes,
        error_tags, skill_tags, status, version,
        weight_primary, weight_supporting, primary_skill_id, supporting_skill_ids
    ) VALUES (
        'U6.9-P1', 'Both', 'Both_Integration', 'Both_Integration', '6.9', '6.9', 'MCQ',
        false, 3, 180,
        'text', 'symbolic', 'Which substitution is most appropriate to start evaluating $\int x\,(x^2+1)^5\,dx$?', 'Which substitution is most appropriate to start evaluating $\int x\,(x^2+1)^5\,dx$?',
        '[{"id": "A", "text": "$u=x^2+1$"}, {"id": "B", "text": "$u=x$"}, {"id": "C", "text": "$u=(x^2+1)^5$"}, {"id": "D", "text": "$u=x^2$"}]'::jsonb, 
        'A', 
        'Choose $u=x^2+1$ because its derivative is proportional to $x\,dx$, which matches the extra factor outside the power.',
        '{"A": "Correct: $du=2x\\,dx$ matches the \\integrand structure.", "B": "Wrong: does not simplify the power expression.", "C": "Wrong: $du$ becomes messy and does not match available factors.", "D": "Wrong: close, but leaves a constant shift that is unnecessary; best is $x^2+1$."}'::jsonb, 
        3, 1.15, 'self', 2026, '', 
        '{u_choice_poor}', '{u_substitution_setup,antiderivative_basic_rules}', 'published', 1,
        0.8, 0.2, 'u_substitution_setup', '{antiderivative_basic_rules}'
    ) RETURNING id INTO q_id;

    INSERT INTO public.question_skills (question_id, skill_id, weight, role) VALUES 
    (q_id, 'u_substitution_setup', 0.8, 'primary'),
    (q_id, 'antiderivative_basic_rules', 0.2, 'supporting');

    INSERT INTO public.question_error_patterns (question_id, error_tag_id) VALUES
    (q_id, 'u_choice_poor');


    -- U6.9-P2
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type,
        calculator_allowed, difficulty, target_time_seconds,
        prompt_type, representation_type, prompt, latex,
        options, correct_option_id, explanation, micro_explanations,
        reasoning_level, mastery_weight, source, source_year, notes,
        error_tags, skill_tags, status, version,
        weight_primary, weight_supporting, primary_skill_id, supporting_skill_ids
    ) VALUES (
        'U6.9-P2', 'Both', 'Both_Integration', 'Both_Integration', '6.9', '6.9', 'MCQ',
        false, 4, 210,
        'text', 'symbolic', 'Evaluate $\int 3x^2\\\\\\\cos(x^3)\,dx$.', 'Evaluate $\int 3x^2\\\\\\\cos(x^3)\,dx$.',
        '[{"id": "A", "text": "$\\\\\\\\sin(x^3)+C$"}, {"id": "B", "text": "$3\\\\\\\\sin(x^3)+C$"}, {"id": "C", "text": "$\\\\\\\\sin x + C$"}, {"id": "D", "text": "$-\\\\\\\\sin(x^3)+C$"}]'::jsonb, 
        'A', 
        'Let $u=x^3$, so $du=3x^2\,dx$. Then the \\integral becomes $\int \\\\\\\cos u\,du=\\\\\\\sin u + C=\\\\\\\sin(x^3)+C$.',
        '{"A": "Correct: substitution matches exactly.", "B": "Wrong: extra factor of 3 appears from forgetting $du$ already included it.", "C": "Wrong: argument should remain $x^3$ after reversing substitution.", "D": "Wrong: sign error; derivative of $\\\\\\\\sin$ is $\\\\\\\\cos$."}'::jsonb, 
        4, 1.25, 'self', 2026, '', 
        '{du_missing_factor}', '{u_substitution_setup,antiderivative_basic_rules}', 'published', 1,
        0.8, 0.2, 'u_substitution_setup', '{antiderivative_basic_rules}'
    ) RETURNING id INTO q_id;

    INSERT INTO public.question_skills (question_id, skill_id, weight, role) VALUES 
    (q_id, 'u_substitution_setup', 0.8, 'primary'),
    (q_id, 'antiderivative_basic_rules', 0.2, 'supporting');

    INSERT INTO public.question_error_patterns (question_id, error_tag_id) VALUES
    (q_id, 'du_missing_factor');


    -- U6.9-P3
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type,
        calculator_allowed, difficulty, target_time_seconds,
        prompt_type, representation_type, prompt, latex,
        options, correct_option_id, explanation, micro_explanations,
        reasoning_level, mastery_weight, source, source_year, notes,
        error_tags, skill_tags, status, version,
        weight_primary, weight_supporting, primary_skill_id, supporting_skill_ids
    ) VALUES (
        'U6.9-P3', 'Both', 'Both_Integration', 'Both_Integration', '6.9', '6.9', 'MCQ',
        false, 4, 220,
        'text', 'symbolic', 'Evaluate $\int_{0}^{1} 2x\,(x^2+1)^3\,dx$ using substitution and changing \\\\\\\\limits in $u$.', 'Evaluate $\int_{0}^{1} 2x\,(x^2+1)^3\,dx$ using substitution and changing \\\\\\\\limits in $u$.',
        '[{"id": "A", "text": "$\\frac{15}{4}$"}, {"id": "B", "text": "$\\frac{15}{2}$"}, {"id": "C", "text": "$4$"}, {"id": "D", "text": "$\\frac{1}{4}$"}]'::jsonb, 
        'A', 
        'Let $u=x^2+1$, so $du=2x\,dx$. When $x=0$, $u=1$; when $x=1$, $u=2$. Then $\int_{1}^{2} u^3\,du=\left.\frac{u^4}{4}\right|_{1}^{2}=\frac{16-1}{4}=\frac{15}{4}$.',
        '{"A": "Correct: \\\\\\\\limits changed consistently and evaluated correctly.", "B": "Wrong: common arithmetic slip (forgetting division by 4).", "C": "Wrong: treating as $\\int u^3 du$ without applying bounds correctly.", "D": "Wrong: subtracting in the wrong order or dropping the 16."}'::jsonb, 
        4, 1.25, 'self', 2026, '', 
        '{u_limits_not_changed_or_mixed}', '{u_substitution_limits,ftc2_evaluate_integral}', 'published', 1,
        0.8, 0.2, 'u_substitution_limits', '{ftc2_evaluate_integral}'
    ) RETURNING id INTO q_id;

    INSERT INTO public.question_skills (question_id, skill_id, weight, role) VALUES 
    (q_id, 'u_substitution_limits', 0.8, 'primary'),
    (q_id, 'ftc2_evaluate_integral', 0.2, 'supporting');

    INSERT INTO public.question_error_patterns (question_id, error_tag_id) VALUES
    (q_id, 'u_limits_not_changed_or_mixed');


    -- U6.9-P4
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type,
        calculator_allowed, difficulty, target_time_seconds,
        prompt_type, representation_type, prompt, latex,
        options, correct_option_id, explanation, micro_explanations,
        reasoning_level, mastery_weight, source, source_year, notes,
        error_tags, skill_tags, status, version,
        weight_primary, weight_supporting, primary_skill_id, supporting_skill_ids
    ) VALUES (
        'U6.9-P4', 'Both', 'Both_Integration', 'Both_Integration', '6.9', '6.9', 'MCQ',
        false, 3, 170,
        'text', 'symbolic', 'Which method is most efficient for $\int \frac{5x}{x^2+4}\,dx$?', 'Which method is most efficient for $\int \frac{5x}{x^2+4}\,dx$?',
        '[{"id": "A", "text": "u-substitution"}, {"id": "B", "text": "Riemann sum approximation"}, {"id": "C", "text": "Use only definite-integral properties"}, {"id": "D", "text": "Complete the square first"}]'::jsonb, 
        'A', 
        'The numerator is proportional to the derivative of the denominator, so u-substitution is the direct approach.',
        '{"A": "Correct: matches the classic substitution pattern.", "B": "Wrong: no need to approximate; it can be found exactly.", "C": "Wrong: properties alone do not evaluate an indefinite \\integral.", "D": "Wrong: denominator is already in a useful form."}'::jsonb, 
        3, 1.15, 'self', 2026, '', 
        '{wrong_method_choice_unit6}', '{u_substitution_setup,technique_selection_antidiff}', 'published', 1,
        0.8, 0.2, 'u_substitution_setup', '{technique_selection_antidiff}'
    ) RETURNING id INTO q_id;

    INSERT INTO public.question_skills (question_id, skill_id, weight, role) VALUES 
    (q_id, 'u_substitution_setup', 0.8, 'primary'),
    (q_id, 'technique_selection_antidiff', 0.2, 'supporting');

    INSERT INTO public.question_error_patterns (question_id, error_tag_id) VALUES
    (q_id, 'wrong_method_choice_unit6');


    -- U6.9-P5
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type,
        calculator_allowed, difficulty, target_time_seconds,
        prompt_type, representation_type, prompt, latex,
        options, correct_option_id, explanation, micro_explanations,
        reasoning_level, mastery_weight, source, source_year, notes,
        error_tags, skill_tags, status, version,
        weight_primary, weight_supporting, primary_skill_id, supporting_skill_ids
    ) VALUES (
        'U6.9-P5', 'Both', 'Both_Integration', 'Both_Integration', '6.9', '6.9', 'MCQ',
        false, 4, 210,
        'text', 'symbolic', 'Evaluate $\int \frac{4x}{\sqrt{x^2+9}}\,dx$.', 'Evaluate $\int \frac{4x}{\sqrt{x^2+9}}\,dx$.',
        '[{"id": "A", "text": "$4\\sqrt{x^2+9}+C$"}, {"id": "B", "text": "$2\\sqrt{x^2+9}+C$"}, {"id": "C", "text": "$\\frac{4}{\\sqrt{x^2+9}}+C$"}, {"id": "D", "text": "$4\\\\\\\\ln(x^2+9)+C$"}]'::jsonb, 
        'A', 
        'Let $u=x^2+9$, $du=2x\,dx$. Then $\int \frac{4x}{\sqrt{u}}dx = \int \frac{2}{\\sqrt{u}}du = 4\\sqrt{u}+C = 4\\sqrt{x^2+9}+C$.',
        '{"A": "Correct: substitution plus correct power rule in $u$.", "B": "Wrong: missing a factor of 2 from matching $du$.", "C": "Wrong: treating the \\integrand as if it were a reciprocal power without \\integrating.", "D": "Wrong: \\\\\\\log form does not apply here."}'::jsonb, 
        4, 1.25, 'self', 2026, '', 
        '{du_missing_factor}', '{u_substitution_setup,antiderivative_basic_rules}', 'published', 1,
        0.8, 0.2, 'u_substitution_setup', '{antiderivative_basic_rules}'
    ) RETURNING id INTO q_id;

    INSERT INTO public.question_skills (question_id, skill_id, weight, role) VALUES 
    (q_id, 'u_substitution_setup', 0.8, 'primary'),
    (q_id, 'antiderivative_basic_rules', 0.2, 'supporting');

    INSERT INTO public.question_error_patterns (question_id, error_tag_id) VALUES
    (q_id, 'du_missing_factor');


    -- ============================================================
    -- Section 6.10
    -- ============================================================

    -- U6.10-P1
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type,
        calculator_allowed, difficulty, target_time_seconds,
        prompt_type, representation_type, prompt, latex,
        options, correct_option_id, explanation, micro_explanations,
        reasoning_level, mastery_weight, source, source_year, notes,
        error_tags, skill_tags, status, version,
        weight_primary, weight_supporting, primary_skill_id, supporting_skill_ids
    ) VALUES (
        'U6.10-P1', 'Both', 'Both_Integration', 'Both_Integration', '6.10', '6.10', 'MCQ',
        false, 4, 220,
        'text', 'symbolic', 'Which first step is most appropriate for $\int \frac{x^2+1}{x-1}\,dx$?', 'Which first step is most appropriate for $\int \frac{x^2+1}{x-1}\,dx$?',
        '[{"id": "A", "text": "Perform long division first"}, {"id": "B", "text": "Use u-substitution with $u=x-1$"}, {"id": "C", "text": "Use symmetry rules for definite integrals"}, {"id": "D", "text": "Rewrite as a Riemann sum"}]'::jsonb, 
        'A', 
        'The degree of the numerator is at least the degree of the denominator, so long division is the correct setup step before \\integrating.',
        '{"A": "Correct: required when rational function is improper.", "B": "Wrong: substitution does not reduce the rational structure here.", "C": "Wrong: not a definite \\integral setting.", "D": "Wrong: unnecessary approximation."}'::jsonb, 
        4, 1.25, 'self', 2026, '', 
        '{long_division_skipped}', '{algebraic_prep_long_division,antiderivative_basic_rules}', 'published', 1,
        0.8, 0.2, 'algebraic_prep_long_division', '{antiderivative_basic_rules}'
    ) RETURNING id INTO q_id;

    INSERT INTO public.question_skills (question_id, skill_id, weight, role) VALUES 
    (q_id, 'algebraic_prep_long_division', 0.8, 'primary'),
    (q_id, 'antiderivative_basic_rules', 0.2, 'supporting');

    INSERT INTO public.question_error_patterns (question_id, error_tag_id) VALUES
    (q_id, 'long_division_skipped');


    -- U6.10-P2
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type,
        calculator_allowed, difficulty, target_time_seconds,
        prompt_type, representation_type, prompt, latex,
        options, correct_option_id, explanation, micro_explanations,
        reasoning_level, mastery_weight, source, source_year, notes,
        error_tags, skill_tags, status, version,
        weight_primary, weight_supporting, primary_skill_id, supporting_skill_ids
    ) VALUES (
        'U6.10-P2', 'Both', 'Both_Integration', 'Both_Integration', '6.10', '6.10', 'MCQ',
        false, 4, 240,
        'text', 'symbolic', 'Evaluate $\int \frac{x^2}{x+1}\,dx$.', 'Evaluate $\int \frac{x^2}{x+1}\,dx$.',
        '[{"id": "A", "text": "$\\frac{x^2}{2}-x+\\\\\\\\ln|x+1|+C$"}, {"id": "B", "text": "$\\frac{x^2}{2}+x+\\\\\\\\ln|x+1|+C$"}, {"id": "C", "text": "$\\frac{x^2}{2}-x-\\\\\\\\ln|x+1|+C$"}, {"id": "D", "text": "$\\\\\\\\ln|x+1|+C$"}]'::jsonb, 
        'A', 
        'Divide: $\frac{x^2}{x+1}=x-1+\frac{1}{x+1}$. Integrate term-by-term to get $\frac{x^2}{2}-x+\\\\\\\ln|x+1|+C$.',
        '{"A": "Correct: division and \\integration are consistent.", "B": "Wrong: sign error on the linear term.", "C": "Wrong: \\\\\\\log sign error.", "D": "Wrong: ignores the polynomial part after division."}'::jsonb, 
        4, 1.25, 'self', 2026, '', 
        '{long_division_skipped}', '{algebraic_prep_long_division,antiderivative_basic_rules}', 'published', 1,
        0.8, 0.2, 'algebraic_prep_long_division', '{antiderivative_basic_rules}'
    ) RETURNING id INTO q_id;

    INSERT INTO public.question_skills (question_id, skill_id, weight, role) VALUES 
    (q_id, 'algebraic_prep_long_division', 0.8, 'primary'),
    (q_id, 'antiderivative_basic_rules', 0.2, 'supporting');

    INSERT INTO public.question_error_patterns (question_id, error_tag_id) VALUES
    (q_id, 'long_division_skipped');


    -- U6.10-P3
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type,
        calculator_allowed, difficulty, target_time_seconds,
        prompt_type, representation_type, prompt, latex,
        options, correct_option_id, explanation, micro_explanations,
        reasoning_level, mastery_weight, source, source_year, notes,
        error_tags, skill_tags, status, version,
        weight_primary, weight_supporting, primary_skill_id, supporting_skill_ids
    ) VALUES (
        'U6.10-P3', 'Both', 'Both_Integration', 'Both_Integration', '6.10', '6.10', 'MCQ',
        false, 3, 200,
        'text', 'symbolic', 'Which rewrite is correct for completing the square in $x^2+6x+13$?', 'Which rewrite is correct for completing the square in $x^2+6x+13$?',
        '[{"id": "A", "text": "$(x+3)^2+4$"}, {"id": "B", "text": "$(x+3)^2-4$"}, {"id": "C", "text": "$(x+6)^2+13$"}, {"id": "D", "text": "$(x+3)^2+13$"}]'::jsonb, 
        'A', 
        'Since $(x+3)^2=x^2+6x+9$, adding 4 gives $x^2+6x+13$.',
        '{"A": "Correct: matches exactly.", "B": "Wrong: constant term becomes 5.", "C": "Wrong: expands to $x^2+12x+49$.", "D": "Wrong: constant term becomes 22."}'::jsonb, 
        3, 1.15, 'self', 2026, '', 
        '{complete_square_incorrect}', '{algebraic_prep_complete_square,antiderivative_basic_rules}', 'published', 1,
        0.8, 0.2, 'algebraic_prep_complete_square', '{antiderivative_basic_rules}'
    ) RETURNING id INTO q_id;

    INSERT INTO public.question_skills (question_id, skill_id, weight, role) VALUES 
    (q_id, 'algebraic_prep_complete_square', 0.8, 'primary'),
    (q_id, 'antiderivative_basic_rules', 0.2, 'supporting');

    INSERT INTO public.question_error_patterns (question_id, error_tag_id) VALUES
    (q_id, 'complete_square_incorrect');


    -- U6.10-P4
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type,
        calculator_allowed, difficulty, target_time_seconds,
        prompt_type, representation_type, prompt, latex,
        options, correct_option_id, explanation, micro_explanations,
        reasoning_level, mastery_weight, source, source_year, notes,
        error_tags, skill_tags, status, version,
        weight_primary, weight_supporting, primary_skill_id, supporting_skill_ids
    ) VALUES (
        'U6.10-P4', 'Both', 'Both_Integration', 'Both_Integration', '6.10', '6.10', 'MCQ',
        false, 3, 180,
        'text', 'symbolic', 'Before \\integrating $\int \frac{1}{x^2+6x+13}\,dx$, what preparation is most helpful?', 'Before \\integrating $\int \frac{1}{x^2+6x+13}\,dx$, what preparation is most helpful?',
        '[{"id": "A", "text": "Complete the square in the quadratic"}, {"id": "B", "text": "Convert to a Riemann sum"}, {"id": "C", "text": "Use only definite-integral properties"}, {"id": "D", "text": "Split the fraction using additivity"}]'::jsonb, 
        'A', 
        'Completing the square rewrites the denominator \\into a standard shifted-square form that matches common antiderivative patterns.',
        '{"A": "Correct: sets up a standard form.", "B": "Wrong: approximation is not needed.", "C": "Wrong: no bounds are given.", "D": "Wrong: additivity does not directly simplify this rational form."}'::jsonb, 
        3, 1.15, 'self', 2026, '', 
        '{wrong_method_choice_unit6}', '{technique_selection_antidiff,algebraic_prep_complete_square}', 'published', 1,
        0.8, 0.2, 'technique_selection_antidiff', '{algebraic_prep_complete_square}'
    ) RETURNING id INTO q_id;

    INSERT INTO public.question_skills (question_id, skill_id, weight, role) VALUES 
    (q_id, 'technique_selection_antidiff', 0.8, 'primary'),
    (q_id, 'algebraic_prep_complete_square', 0.2, 'supporting');

    INSERT INTO public.question_error_patterns (question_id, error_tag_id) VALUES
    (q_id, 'wrong_method_choice_unit6');


    -- U6.10-P5
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type,
        calculator_allowed, difficulty, target_time_seconds,
        prompt_type, representation_type, prompt, latex,
        options, correct_option_id, explanation, micro_explanations,
        reasoning_level, mastery_weight, source, source_year, notes,
        error_tags, skill_tags, status, version,
        weight_primary, weight_supporting, primary_skill_id, supporting_skill_ids
    ) VALUES (
        'U6.10-P5', 'Both', 'Both_Integration', 'Both_Integration', '6.10', '6.10', 'MCQ',
        false, 4, 230,
        'text', 'symbolic', 'Which \\integral most clearly requires long division before evaluating?', 'Which \\integral most clearly requires long division before evaluating?',
        '[{"id": "A", "text": "$\\int \\frac{x^3+1}{x^2+1}\\,dx$"}, {"id": "B", "text": "$\\int \\frac{2x}{x^2+1}\\,dx$"}, {"id": "C", "text": "$\\int \\frac{1}{x^2+1}\\,dx$"}, {"id": "D", "text": "$\\int x(x^2+1)^2\\,dx$"}]'::jsonb, 
        'A', 
        'Long division is needed when the numerator degree is greater than or equal to the denominator degree; only choice A is an improper rational function.',
        '{"A": "Correct: degree 3 over degree 2 suggests division first.", "B": "Wrong: best handled by u-substitution.", "C": "Wrong: already a standard form without division.", "D": "Wrong: a substitution structure, not a rational division case."}'::jsonb, 
        4, 1.25, 'self', 2026, '', 
        '{wrong_method_choice_unit6}', '{algebraic_prep_long_division,technique_selection_antidiff}', 'published', 1,
        0.8, 0.2, 'algebraic_prep_long_division', '{technique_selection_antidiff}'
    ) RETURNING id INTO q_id;

    INSERT INTO public.question_skills (question_id, skill_id, weight, role) VALUES 
    (q_id, 'algebraic_prep_long_division', 0.8, 'primary'),
    (q_id, 'technique_selection_antidiff', 0.2, 'supporting');

    INSERT INTO public.question_error_patterns (question_id, error_tag_id) VALUES
    (q_id, 'wrong_method_choice_unit6');


    -- ============================================================
    -- Section 6.11
    -- ============================================================

    -- U6.11-P1
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type,
        calculator_allowed, difficulty, target_time_seconds,
        prompt_type, representation_type, prompt, latex,
        options, correct_option_id, explanation, micro_explanations,
        reasoning_level, mastery_weight, source, source_year, notes,
        error_tags, skill_tags, status, version,
        weight_primary, weight_supporting, primary_skill_id, supporting_skill_ids
    ) VALUES (
        'U6.11-P1', 'BC', 'Both_Integration', 'Both_Integration', '6.11', '6.11', 'MCQ',
        false, 3, 150,
        'text', 'symbolic', 'A student wants to evaluate $\int x e^x\,dx$. Which strategy choice is most appropriate?', 'A student wants to evaluate $\int x e^x\,dx$. Which strategy choice is most appropriate?',
        '[{"id": "A", "text": "Use a technique designed for products of unlike types (polynomial with exponential)"}, {"id": "B", "text": "Use a Riemann sum approximation"}, {"id": "C", "text": "Use only definite-integral properties"}, {"id": "D", "text": "Complete the square first"}]'::jsonb, 
        'A', 
        'This is a product of a polynomial and an exponential, so it calls for a product-focused antidifferentiation technique rather than substitution or algebra prep.',
        '{"A": "Correct: selects the \\intended product-handling technique.", "B": "Wrong: not an approximation problem.", "C": "Wrong: no bounds are provided.", "D": "Wrong: completing the square is for quadratics in a denominator."}'::jsonb, 
        3, 1.0, 'self', 2026, '', 
        '{wrong_method_choice_unit6}', '{technique_selection_antidiff,antiderivative_basic_rules}', 'published', 1,
        0.8, 0.2, 'technique_selection_antidiff', '{antiderivative_basic_rules}'
    ) RETURNING id INTO q_id;

    INSERT INTO public.question_skills (question_id, skill_id, weight, role) VALUES 
    (q_id, 'technique_selection_antidiff', 0.8, 'primary'),
    (q_id, 'antiderivative_basic_rules', 0.2, 'supporting');

    INSERT INTO public.question_error_patterns (question_id, error_tag_id) VALUES
    (q_id, 'wrong_method_choice_unit6');


    -- U6.11-P2
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type,
        calculator_allowed, difficulty, target_time_seconds,
        prompt_type, representation_type, prompt, latex,
        options, correct_option_id, explanation, micro_explanations,
        reasoning_level, mastery_weight, source, source_year, notes,
        error_tags, skill_tags, status, version,
        weight_primary, weight_supporting, primary_skill_id, supporting_skill_ids
    ) VALUES (
        'U6.11-P2', 'BC', 'Both_Integration', 'Both_Integration', '6.11', '6.11', 'MCQ',
        false, 3, 150,
        'text', 'symbolic', 'Which \\integrand is LEAST likely to be efficiently handled by u-substitution and instead suggests a product-focused technique?', 'Which \\integrand is LEAST likely to be efficiently handled by u-substitution and instead suggests a product-focused technique?',
        '[{"id": "A", "text": "$x\\\\\\\\sin x$"}, {"id": "B", "text": "$\\frac{2x}{x^2+5}$"}, {"id": "C", "text": "$(3x+1)^7$"}, {"id": "D", "text": "$\\\\\\\\cos(x^3)\\cdot 3x^2$"}]'::jsonb, 
        'A', 
        'Choice A is a product of a polynomial and a trig function with no clean inside-derivative match; the others fit standard substitution patterns.',
        '{"A": "Correct: no obvious $u$ makes $du$ appear directly.", "B": "Wrong: classic substitution with $u=x^2+5$.", "C": "Wrong: substitution with $u=3x+1$.", "D": "Wrong: substitution with $u=x^3$."}'::jsonb, 
        3, 1.0, 'self', 2026, '', 
        '{wrong_method_choice_unit6}', '{technique_selection_antidiff,u_substitution_setup}', 'published', 1,
        0.8, 0.2, 'technique_selection_antidiff', '{u_substitution_setup}'
    ) RETURNING id INTO q_id;

    INSERT INTO public.question_skills (question_id, skill_id, weight, role) VALUES 
    (q_id, 'technique_selection_antidiff', 0.8, 'primary'),
    (q_id, 'u_substitution_setup', 0.2, 'supporting');

    INSERT INTO public.question_error_patterns (question_id, error_tag_id) VALUES
    (q_id, 'wrong_method_choice_unit6');


    -- U6.11-P3
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type,
        calculator_allowed, difficulty, target_time_seconds,
        prompt_type, representation_type, prompt, latex,
        options, correct_option_id, explanation, micro_explanations,
        reasoning_level, mastery_weight, source, source_year, notes,
        error_tags, skill_tags, status, version,
        weight_primary, weight_supporting, primary_skill_id, supporting_skill_ids
    ) VALUES (
        'U6.11-P3', 'BC', 'Both_Integration', 'Both_Integration', '6.11', '6.11', 'MCQ',
        false, 4, 200,
        'text', 'symbolic', 'A student tries to start $\int x\\\\\\\ln x\,dx$ with long division. What is the best correction?', 'A student tries to start $\int x\\\\\\\ln x\,dx$ with long division. What is the best correction?',
        '[{"id": "A", "text": "Long division is not applicable; select a product-focused antidifferentiation technique"}, {"id": "B", "text": "Long division is correct; continue dividing"}, {"id": "C", "text": "Convert to a Riemann sum"}, {"id": "D", "text": "Use even/odd symmetry"}]'::jsonb, 
        'A', 
        'Long division applies to rational functions. Here the \\integrand is a product of different function types, so technique selection should shift accordingly.',
        '{"A": "Correct: identifies the method mismatch.", "B": "Wrong: there is nothing to divide.", "C": "Wrong: not an approximation setup.", "D": "Wrong: symmetry rules require symmetric bounds and an \\integrand type that fits."}'::jsonb, 
        4, 1.15, 'self', 2026, '', 
        '{wrong_method_choice_unit6}', '{technique_selection_antidiff,algebraic_prep_long_division}', 'published', 1,
        0.8, 0.2, 'technique_selection_antidiff', '{algebraic_prep_long_division}'
    ) RETURNING id INTO q_id;

    INSERT INTO public.question_skills (question_id, skill_id, weight, role) VALUES 
    (q_id, 'technique_selection_antidiff', 0.8, 'primary'),
    (q_id, 'algebraic_prep_long_division', 0.2, 'supporting');

    INSERT INTO public.question_error_patterns (question_id, error_tag_id) VALUES
    (q_id, 'wrong_method_choice_unit6');


    -- U6.11-P4
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type,
        calculator_allowed, difficulty, target_time_seconds,
        prompt_type, representation_type, prompt, latex,
        options, correct_option_id, explanation, micro_explanations,
        reasoning_level, mastery_weight, source, source_year, notes,
        error_tags, skill_tags, status, version,
        weight_primary, weight_supporting, primary_skill_id, supporting_skill_ids
    ) VALUES (
        'U6.11-P4', 'BC', 'Both_Integration', 'Both_Integration', '6.11', '6.11', 'MCQ',
        false, 4, 210,
        'text', 'symbolic', 'Which \\integral is MOST naturally handled by u-substitution (not a product-focused technique)?', 'Which \\integral is MOST naturally handled by u-substitution (not a product-focused technique)?',
        '[{"id": "A", "text": "$\\int x\\\\\\\\cos x\\,dx$"}, {"id": "B", "text": "$\\int \\frac{1}{x}\\,dx$"}, {"id": "C", "text": "$\\int 2x\\,(x^2+7)^4\\,dx$"}, {"id": "D", "text": "$\\int x e^x\\,dx$"}]'::jsonb, 
        'C', 
        'Choice C has a clear inner function $x^2+7$ with derivative $2x$, matching the substitution pattern directly.',
        '{"A": "Wrong: no inside-derivative match; suggests product-focused technique.", "B": "Wrong: basic antiderivative rule, not substitution.", "C": "Correct: perfect $u$ pattern.", "D": "Wrong: classic product situation; substitution is not efficient."}'::jsonb, 
        4, 1.15, 'self', 2026, '', 
        '{wrong_method_choice_unit6}', '{technique_selection_antidiff,u_substitution_setup}', 'published', 1,
        0.8, 0.2, 'technique_selection_antidiff', '{u_substitution_setup}'
    ) RETURNING id INTO q_id;

    INSERT INTO public.question_skills (question_id, skill_id, weight, role) VALUES 
    (q_id, 'technique_selection_antidiff', 0.8, 'primary'),
    (q_id, 'u_substitution_setup', 0.2, 'supporting');

    INSERT INTO public.question_error_patterns (question_id, error_tag_id) VALUES
    (q_id, 'wrong_method_choice_unit6');


    -- U6.11-P5
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type,
        calculator_allowed, difficulty, target_time_seconds,
        prompt_type, representation_type, prompt, latex,
        options, correct_option_id, explanation, micro_explanations,
        reasoning_level, mastery_weight, source, source_year, notes,
        error_tags, skill_tags, status, version,
        weight_primary, weight_supporting, primary_skill_id, supporting_skill_ids
    ) VALUES (
        'U6.11-P5', 'BC', 'Both_Integration', 'Both_Integration', '6.11', '6.11', 'MCQ',
        false, 3, 160,
        'text', 'symbolic', 'A student plans to complete the square to evaluate $\int x\\\\\\\\sin x\\,dx$. Which statement is best?', 'A student plans to complete the square to evaluate $\int x\\\\\\\\sin x\\,dx$. Which statement is best?',
        '[{"id": "A", "text": "Completing the square is not relevant; this is a product-type integrand requiring a different technique"}, {"id": "B", "text": "Completing the square is required for all trig integrals"}, {"id": "C", "text": "Complete the square first, then use sigma notation"}, {"id": "D", "text": "Use symmetry rules on a symmetric interval"}]'::jsonb, 
        'A', 
        'Completing the square is a quadratic-denominator preparation step, not a product-with-trig situation.',
        '{"A": "Correct: identifies the mismatch and redirects technique selection.", "B": "Wrong: not a general requirement.", "C": "Wrong: sigma notation is unrelated here.", "D": "Wrong: no bounds; symmetry not applicable."}'::jsonb, 
        3, 1.0, 'self', 2026, '', 
        '{wrong_method_choice_unit6}', '{technique_selection_antidiff,algebraic_prep_complete_square}', 'published', 1,
        0.8, 0.2, 'technique_selection_antidiff', '{algebraic_prep_complete_square}'
    ) RETURNING id INTO q_id;

    INSERT INTO public.question_skills (question_id, skill_id, weight, role) VALUES 
    (q_id, 'technique_selection_antidiff', 0.8, 'primary'),
    (q_id, 'algebraic_prep_complete_square', 0.2, 'supporting');

    INSERT INTO public.question_error_patterns (question_id, error_tag_id) VALUES
    (q_id, 'wrong_method_choice_unit6');


    -- ============================================================
    -- Section 6.12
    -- ============================================================

    -- U6.12-P1
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type,
        calculator_allowed, difficulty, target_time_seconds,
        prompt_type, representation_type, prompt, latex,
        options, correct_option_id, explanation, micro_explanations,
        reasoning_level, mastery_weight, source, source_year, notes,
        error_tags, skill_tags, status, version,
        weight_primary, weight_supporting, primary_skill_id, supporting_skill_ids
    ) VALUES (
        'U6.12-P1', 'BC', 'Both_Integration', 'Both_Integration', '6.12', '6.12', 'MCQ',
        false, 4, 190,
        'text', 'symbolic', 'A student is deciding how to start $\int \frac{2x+3}{x^2+x}\,dx$. Which is the best first move?', 'A student is deciding how to start $\int \frac{2x+3}{x^2+x}\,dx$. Which is the best first move?',
        '[{"id": "A", "text": "Choose a technique that decomposes a rational expression into simpler pieces before integrating"}, {"id": "B", "text": "Complete the square immediately"}, {"id": "C", "text": "Rewrite as a Riemann sum"}, {"id": "D", "text": "Use even/odd symmetry"}]'::jsonb, 
        'A', 
        'This is a rational function with a factorable denominator, so the efficient approach is to split it \\into simpler terms (a rational-decomposition technique) rather than substitution or algebraic square-completion.',
        '{"A": "Correct: appropriate technique selection for rational expressions.", "B": "Wrong: completing the square is not the natural setup for a factorable denominator.", "C": "Wrong: not an approximation setup.", "D": "Wrong: no symmetric bounds; symmetry rules do not apply."}'::jsonb, 
        4, 1.15, 'self', 2026, '', 
        '{wrong_method_choice_unit6}', '{technique_selection_antidiff,algebraic_prep_long_division}', 'published', 1,
        0.8, 0.2, 'technique_selection_antidiff', '{algebraic_prep_long_division}'
    ) RETURNING id INTO q_id;

    INSERT INTO public.question_skills (question_id, skill_id, weight, role) VALUES 
    (q_id, 'technique_selection_antidiff', 0.8, 'primary'),
    (q_id, 'algebraic_prep_long_division', 0.2, 'supporting');

    INSERT INTO public.question_error_patterns (question_id, error_tag_id) VALUES
    (q_id, 'wrong_method_choice_unit6');


    -- U6.12-P2
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type,
        calculator_allowed, difficulty, target_time_seconds,
        prompt_type, representation_type, prompt, latex,
        options, correct_option_id, explanation, micro_explanations,
        reasoning_level, mastery_weight, source, source_year, notes,
        error_tags, skill_tags, status, version,
        weight_primary, weight_supporting, primary_skill_id, supporting_skill_ids
    ) VALUES (
        'U6.12-P2', 'BC', 'Both_Integration', 'Both_Integration', '6.12', '6.12', 'MCQ',
        false, 3, 160,
        'text', 'symbolic', 'Which \\integral is MOST likely to require splitting a rational expression \\into simpler terms (rather than u-substitution)?', 'Which \\integral is MOST likely to require splitting a rational expression \\into simpler terms (rather than u-substitution)?',
        '[{"id": "A", "text": "$\\int \\frac{1}{x(x+2)}\\,dx$"}, {"id": "B", "text": "$\\int 2x(x^2+1)^3\\,dx$"}, {"id": "C", "text": "$\\int \\\\\\\\cos(5x)\\,dx$"}, {"id": "D", "text": "$\\int \\frac{4x}{x^2+9}\\,dx$"}]'::jsonb, 
        'A', 
        'Choice A is a rational function with a product of linear factors in the denominator, which typically calls for splitting \\into simpler rational terms.',
        '{"A": "Correct: classic rational-decomposition structure.", "B": "Wrong: clear u-substitution pattern.", "C": "Wrong: basic antiderivative rule.", "D": "Wrong: clear u-substitution pattern with denominator derivative present."}'::jsonb, 
        3, 1.0, 'self', 2026, '', 
        '{wrong_method_choice_unit6}', '{technique_selection_antidiff,u_substitution_setup}', 'published', 1,
        0.8, 0.2, 'technique_selection_antidiff', '{u_substitution_setup}'
    ) RETURNING id INTO q_id;

    INSERT INTO public.question_skills (question_id, skill_id, weight, role) VALUES 
    (q_id, 'technique_selection_antidiff', 0.8, 'primary'),
    (q_id, 'u_substitution_setup', 0.2, 'supporting');

    INSERT INTO public.question_error_patterns (question_id, error_tag_id) VALUES
    (q_id, 'wrong_method_choice_unit6');


    -- U6.12-P3
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type,
        calculator_allowed, difficulty, target_time_seconds,
        prompt_type, representation_type, prompt, latex,
        options, correct_option_id, explanation, micro_explanations,
        reasoning_level, mastery_weight, source, source_year, notes,
        error_tags, skill_tags, status, version,
        weight_primary, weight_supporting, primary_skill_id, supporting_skill_ids
    ) VALUES (
        'U6.12-P3', 'BC', 'Both_Integration', 'Both_Integration', '6.12', '6.12', 'MCQ',
        false, 4, 200,
        'text', 'symbolic', 'Which rational \\integrand suggests long division as the needed preparation step?', 'Which rational \\integrand suggests long division as the needed preparation step?',
        '[{"id": "A", "text": "$\\frac{x^2+3x+1}{x+1}$"}, {"id": "B", "text": "$\\frac{1}{x(x+1)}$"}, {"id": "C", "text": "$\\frac{2x}{x^2+1}$"}, {"id": "D", "text": "$\\frac{1}{(x+2)^2}$"}]'::jsonb, 
        'A', 
        'Long division is indicated when the numerator degree is at least the denominator degree; only A has degree 2 over degree 1.',
        '{"A": "Correct: improper rational function.", "B": "Wrong: already proper; splitting is more relevant.", "C": "Wrong: substitution pattern, not division.", "D": "Wrong: already a simple power form."}'::jsonb, 
        4, 1.15, 'self', 2026, '', 
        '{long_division_skipped}', '{algebraic_prep_long_division,technique_selection_antidiff}', 'published', 1,
        0.8, 0.2, 'algebraic_prep_long_division', '{technique_selection_antidiff}'
    ) RETURNING id INTO q_id;

    INSERT INTO public.question_skills (question_id, skill_id, weight, role) VALUES 
    (q_id, 'algebraic_prep_long_division', 0.8, 'primary'),
    (q_id, 'technique_selection_antidiff', 0.2, 'supporting');

    INSERT INTO public.question_error_patterns (question_id, error_tag_id) VALUES
    (q_id, 'long_division_skipped');


    -- U6.12-P4
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type,
        calculator_allowed, difficulty, target_time_seconds,
        prompt_type, representation_type, prompt, latex,
        options, correct_option_id, explanation, micro_explanations,
        reasoning_level, mastery_weight, source, source_year, notes,
        error_tags, skill_tags, status, version,
        weight_primary, weight_supporting, primary_skill_id, supporting_skill_ids
    ) VALUES (
        'U6.12-P4', 'BC', 'Both_Integration', 'Both_Integration', '6.12', '6.12', 'MCQ',
        false, 3, 160,
        'text', 'symbolic', 'A student tries to use definite-\\integral symmetry rules to evaluate an indefinite \\integral of a rational function. What is the best correction?', 'A student tries to use definite-\\integral symmetry rules to evaluate an indefinite \\integral of a rational function. What is the best correction?',
        '[{"id": "A", "text": "Symmetry rules require symmetric bounds; choose an antidifferentiation technique instead"}, {"id": "B", "text": "Symmetry rules always work, even without bounds"}, {"id": "C", "text": "Rewrite it as a Riemann sum"}, {"id": "D", "text": "Reverse the bounds to fix the sign"}]'::jsonb, 
        'A', 
        'Symmetry is a definite-\\integral shortcut that requires bounds; without bounds, method selection should shift to an appropriate antidifferentiation technique.',
        '{"A": "Correct: identifies why symmetry explains nothing for an indefinite \\integral.", "B": "Wrong: symmetry needs bounds and context.", "C": "Wrong: not an approximation problem.", "D": "Wrong: there are no bounds to reverse."}'::jsonb, 
        3, 1.0, 'self', 2026, '', 
        '{wrong_method_choice_unit6}', '{technique_selection_antidiff,definite_integral_notation}', 'published', 1,
        0.8, 0.2, 'technique_selection_antidiff', '{definite_integral_notation}'
    ) RETURNING id INTO q_id;

    INSERT INTO public.question_skills (question_id, skill_id, weight, role) VALUES 
    (q_id, 'technique_selection_antidiff', 0.8, 'primary'),
    (q_id, 'definite_integral_notation', 0.2, 'supporting');

    INSERT INTO public.question_error_patterns (question_id, error_tag_id) VALUES
    (q_id, 'wrong_method_choice_unit6');


    -- U6.12-P5
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type,
        calculator_allowed, difficulty, target_time_seconds,
        prompt_type, representation_type, prompt, latex,
        options, correct_option_id, explanation, micro_explanations,
        reasoning_level, mastery_weight, source, source_year, notes,
        error_tags, skill_tags, status, version,
        weight_primary, weight_supporting, primary_skill_id, supporting_skill_ids
    ) VALUES (
        'U6.12-P5', 'BC', 'Both_Integration', 'Both_Integration', '6.12', '6.12', 'MCQ',
        false, 4, 200,
        'text', 'symbolic', 'Which choice best explains why completing the square is NOT the first step for $\int \frac{1}{x(x+1)}\,dx$?', 'Which choice best explains why completing the square is NOT the first step for $\int \frac{1}{x(x+1)}\,dx$?',
        '[{"id": "A", "text": "The denominator is already factorable into linear factors, suggesting splitting into simpler rational terms"}, {"id": "B", "text": "Completing the square only works when a calculator is allowed"}, {"id": "C", "text": "Completing the square changes the value of the integrand"}, {"id": "D", "text": "Completing the square is only for definite integrals"}]'::jsonb, 
        'A', 
        'With a product of linear factors in the denominator, the natural simplification is to split \\into simpler rational \\pieces rather than rewrite as a square.',
        '{"A": "Correct: matches the structure-driven method choice.", "B": "Wrong: unrelated to calculator policy.", "C": "Wrong: completing the square is an algebraic identity when done correctly.", "D": "Wrong: it can be used in indefinite \\integrals too, just not appropriate here."}'::jsonb, 
        4, 1.15, 'self', 2026, '', 
        '{wrong_method_choice_unit6}', '{technique_selection_antidiff,algebraic_prep_complete_square}', 'published', 1,
        0.8, 0.2, 'technique_selection_antidiff', '{algebraic_prep_complete_square}'
    ) RETURNING id INTO q_id;

    INSERT INTO public.question_skills (question_id, skill_id, weight, role) VALUES 
    (q_id, 'technique_selection_antidiff', 0.8, 'primary'),
    (q_id, 'algebraic_prep_complete_square', 0.2, 'supporting');

    INSERT INTO public.question_error_patterns (question_id, error_tag_id) VALUES
    (q_id, 'wrong_method_choice_unit6');

END $$;
