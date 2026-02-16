-- Explicit Title-based UPSERT Script
-- Generated matching user request for explicit update blocks + Insert fallback

DO $do$
BEGIN
    -- Update based on title
    UPDATE public.questions
    SET
        course = 'Both',
        topic = 'Both_Limits',
        sub_topic_id = '1.1',
        type = 'MCQ',
        calculator_allowed = 'false',
        difficulty = '2',
        target_time_seconds = '75',
        skill_tags = ARRAY['SK_AVG_ROC','SK_SECANT_SLOPE','SK_FUNC_EVAL','SK_UNITS_INTERPRET'],
        error_tags = ARRAY['E_AVG_ROC_SETUP','E_SIGN_ERROR','E_UNITS_MISMATCH'],
        prompt = 'A particle’s position is given by $s(t)=t^2+2t$ (meters), where $t$ is in seconds. What is the average velocity on the interval $[1,3]$?',
        latex = 'A particle’s position is given by $s(t)=t^2+2t$ (meters), where $t$ is in seconds. What is the average velocity on the interval $[1,3]$?',
        options = '[{"id": "A", "text": "$4\\\\ \\\\text{m/s}$", "explanation": "This can result from using the correct difference-quotient form but evaluating $s(3)-s(1)$ incorrectly."}, {"id": "B", "text": "$6\\\\ \\\\text{m/s}$", "explanation": "Correct: $\\\\dfrac{s(3)-s(1)}{3-1}=\\\\dfrac{15-3}{2}=6$."}, {"id": "C", "text": "$8\\\\ \\\\text{m/s}$", "explanation": "This can happen if you compute $\\\\dfrac{s(3)}{3}$ or confuse an average rate with a point-based value."}, {"id": "D", "text": "$10\\\\ \\\\text{m/s}$", "explanation": "This can happen if you forget to divide by $3-1=2$ and use $s(3)-s(1)=12$ as the answer."}]'::jsonb,
        correct_option_id = 'B',
        tolerance = '0.0010',
        explanation = 'Average velocity on $[1,3]$ is the slope of the secant line:
$$\\frac{s(3)-s(1)}{3-1}=\\frac{(3^2+2\\cdot 3)-(1^2+2\\cdot 1)}{2}=\\frac{15-3}{2}=6.$$',
        micro_explanations = '{"A": "Distance change only.", "B": "Correct secant slope with units mph.", "C": "Uses [0,5], not [2,5].", "D": "Instantaneous rate at one time."}',
        recommendation_reasons = ARRAY['Reinforces average rate of change as a secant slope.','Targets correct interval setup and units.'],
        created_by = null,
        updated_at = NOW(),
        status = 'published',
        version = '6',
        reasoning_level = '2',
        mastery_weight = '1.00',
        representation_type = 'symbolic',
        topic_id = 'Both_Limits',
        section_id = '1.1',
        source = 'NewMaoS',
        source_year = '2026',
        notes = 'Focus: compute average velocity via difference quotient on an interval.',
        weight_primary = '0.8',
        weight_supporting = '0.2',
        prompt_type = 'text',
        primary_skill_id = 'SKL_AverageRateOfChange',
        supporting_skill_ids = ARRAY['SKL_UnitsInterpretation']
    WHERE title = '1.1-P1';

    -- Insert if not found
    IF NOT FOUND THEN
        INSERT INTO public.questions (id, course, topic, sub_topic_id, type, calculator_allowed, difficulty, target_time_seconds, skill_tags, error_tags, prompt, latex, options, correct_option_id, tolerance, explanation, micro_explanations, recommendation_reasons, created_by, created_at, updated_at, status, version, reasoning_level, mastery_weight, representation_type, topic_id, section_id, source, source_year, notes, weight_primary, weight_supporting, title, prompt_type, primary_skill_id, supporting_skill_ids)
        VALUES ('60d6066b-c923-453a-8378-50cfda9ea539', 'Both', 'Both_Limits', '1.1', 'MCQ', 'false', '2', '75', ARRAY['SK_AVG_ROC','SK_SECANT_SLOPE','SK_FUNC_EVAL','SK_UNITS_INTERPRET'], ARRAY['E_AVG_ROC_SETUP','E_SIGN_ERROR','E_UNITS_MISMATCH'], 'A particle’s position is given by $s(t)=t^2+2t$ (meters), where $t$ is in seconds. What is the average velocity on the interval $[1,3]$?', 'A particle’s position is given by $s(t)=t^2+2t$ (meters), where $t$ is in seconds. What is the average velocity on the interval $[1,3]$?', '[{"id": "A", "text": "$4\\\\ \\\\text{m/s}$", "explanation": "This can result from using the correct difference-quotient form but evaluating $s(3)-s(1)$ incorrectly."}, {"id": "B", "text": "$6\\\\ \\\\text{m/s}$", "explanation": "Correct: $\\\\dfrac{s(3)-s(1)}{3-1}=\\\\dfrac{15-3}{2}=6$."}, {"id": "C", "text": "$8\\\\ \\\\text{m/s}$", "explanation": "This can happen if you compute $\\\\dfrac{s(3)}{3}$ or confuse an average rate with a point-based value."}, {"id": "D", "text": "$10\\\\ \\\\text{m/s}$", "explanation": "This can happen if you forget to divide by $3-1=2$ and use $s(3)-s(1)=12$ as the answer."}]'::jsonb, 'B', '0.0010', 'Average velocity on $[1,3]$ is the slope of the secant line:
$$\\frac{s(3)-s(1)}{3-1}=\\frac{(3^2+2\\cdot 3)-(1^2+2\\cdot 1)}{2}=\\frac{15-3}{2}=6.$$', '{"A": "Distance change only.", "B": "Correct secant slope with units mph.", "C": "Uses [0,5], not [2,5].", "D": "Instantaneous rate at one time."}', ARRAY['Reinforces average rate of change as a secant slope.','Targets correct interval setup and units.'], null, '2026-02-07 17:20:00+00', NOW(), 'published', '6', '2', '1.00', 'symbolic', 'Both_Limits', '1.1', 'NewMaoS', '2026', 'Focus: compute average velocity via difference quotient on an interval.', '0.8', '0.2', '1.1-P1', 'text', 'SKL_AverageRateOfChange', ARRAY['SKL_UnitsInterpretation']);
    END IF;
END $do$;


DO $do$
BEGIN
    -- Update based on title
    UPDATE public.questions
    SET
        course = 'Both',
        topic = 'Both_Limits',
        sub_topic_id = '1.1',
        type = 'MCQ',
        calculator_allowed = 'false',
        difficulty = '3',
        target_time_seconds = '90',
        skill_tags = ARRAY['SK_LIMIT_DEF_DERIV','SK_DIFF_QUOTIENT','SK_LIMIT_CONCEPT'],
        error_tags = ARRAY['E_PLUG_H_0','E_LIMIT_VARIABLE_MISMATCH','E_SIGN_ERROR'],
        prompt = 'Let $f(x)=3x^2-5x$. Which expression represents the slope of the tangent line to $y=f(x)$ at $x=2$ using the definition of derivative?',
        latex = 'Let $f(x)=3x^2-5x$. Which expression represents the slope of the tangent line to $y=f(x)$ at $x=2$ using the definition of derivative?',
        options = '[{"id": "A", "text": "$$\\\\lim_{h\\\\to 0}\\\\frac{f(2)-f(2-h)}{h}$$", "explanation": "This is not the standard increment form and can cause sign confusion unless carefully rewritten."}, {"id": "B", "text": "$$\\\\lim_{h\\\\to 0}\\\\frac{f(h)-f(2)}{h-2}$$", "explanation": "This misuses $h$ as an input rather than an increment around $2$."}, {"id": "C", "text": "$$\\\\lim_{x\\\\to 0}\\\\frac{f(2)-f(x)}{2-x}$$", "explanation": "This is not stated correctly for the tangent at $x=2$ because the limit should be as $x\\\\to 2$, not $x\\\\to 0$."}, {"id": "D", "text": "$$\\\\lim_{h\\\\to 0}\\\\frac{f(2+h)-f(2)}{h}$$", "explanation": "Correct: this is the limit definition of the derivative at $x=2$."}]'::jsonb,
        correct_option_id = 'D',
        tolerance = '0.0010',
        explanation = 'By definition, the slope of the tangent line at $x=2$ is
$$\\lim_{h\\to 0}\\frac{f(2+h)-f(2)}{h}.$$',
        micro_explanations = '{"A": "Correct: secant slope over [1,3] is 6.", "B": "Likely arithmetic/interval mistake.", "C": "Likely point-value confusion.", "D": "Forgot 3-1=2."}',
        recommendation_reasons = ARRAY['Builds correct derivative-as-limit setup.','Targets common notation and variable-limit mismatches.'],
        created_by = null,
        updated_at = NOW(),
        status = 'published',
        version = '6',
        reasoning_level = '3',
        mastery_weight = '1.05',
        representation_type = 'symbolic',
        topic_id = 'Both_Limits',
        section_id = '1.1',
        source = 'NewMaoS',
        source_year = '2026',
        notes = 'Focus: identify the correct limit expression for instantaneous rate of change at a point.',
        weight_primary = '0.85',
        weight_supporting = '0.15',
        prompt_type = 'text',
        primary_skill_id = 'SKL_AverageRateOfChange',
        supporting_skill_ids = ARRAY['SKL_DifferenceQuotient']
    WHERE title = '1.1-P2';

    -- Insert if not found
    IF NOT FOUND THEN
        INSERT INTO public.questions (id, course, topic, sub_topic_id, type, calculator_allowed, difficulty, target_time_seconds, skill_tags, error_tags, prompt, latex, options, correct_option_id, tolerance, explanation, micro_explanations, recommendation_reasons, created_by, created_at, updated_at, status, version, reasoning_level, mastery_weight, representation_type, topic_id, section_id, source, source_year, notes, weight_primary, weight_supporting, title, prompt_type, primary_skill_id, supporting_skill_ids)
        VALUES ('6c08ffe1-73ba-41b9-8414-98ef93262341', 'Both', 'Both_Limits', '1.1', 'MCQ', 'false', '3', '90', ARRAY['SK_LIMIT_DEF_DERIV','SK_DIFF_QUOTIENT','SK_LIMIT_CONCEPT'], ARRAY['E_PLUG_H_0','E_LIMIT_VARIABLE_MISMATCH','E_SIGN_ERROR'], 'Let $f(x)=3x^2-5x$. Which expression represents the slope of the tangent line to $y=f(x)$ at $x=2$ using the definition of derivative?', 'Let $f(x)=3x^2-5x$. Which expression represents the slope of the tangent line to $y=f(x)$ at $x=2$ using the definition of derivative?', '[{"id": "A", "text": "$$\\\\lim_{h\\\\to 0}\\\\frac{f(2)-f(2-h)}{h}$$", "explanation": "This is not the standard increment form and can cause sign confusion unless carefully rewritten."}, {"id": "B", "text": "$$\\\\lim_{h\\\\to 0}\\\\frac{f(h)-f(2)}{h-2}$$", "explanation": "This misuses $h$ as an input rather than an increment around $2$."}, {"id": "C", "text": "$$\\\\lim_{x\\\\to 0}\\\\frac{f(2)-f(x)}{2-x}$$", "explanation": "This is not stated correctly for the tangent at $x=2$ because the limit should be as $x\\\\to 2$, not $x\\\\to 0$."}, {"id": "D", "text": "$$\\\\lim_{h\\\\to 0}\\\\frac{f(2+h)-f(2)}{h}$$", "explanation": "Correct: this is the limit definition of the derivative at $x=2$."}]'::jsonb, 'D', '0.0010', 'By definition, the slope of the tangent line at $x=2$ is
$$\\lim_{h\\to 0}\\frac{f(2+h)-f(2)}{h}.$$', '{"A": "Correct: secant slope over [1,3] is 6.", "B": "Likely arithmetic/interval mistake.", "C": "Likely point-value confusion.", "D": "Forgot 3-1=2."}', ARRAY['Builds correct derivative-as-limit setup.','Targets common notation and variable-limit mismatches.'], null, '2026-02-07 17:20:00+00', NOW(), 'published', '6', '3', '1.05', 'symbolic', 'Both_Limits', '1.1', 'NewMaoS', '2026', 'Focus: identify the correct limit expression for instantaneous rate of change at a point.', '0.85', '0.15', '1.1-P2', 'text', 'SKL_AverageRateOfChange', ARRAY['SKL_DifferenceQuotient']);
    END IF;
END $do$;


DO $do$
BEGIN
    -- Update based on title
    UPDATE public.questions
    SET
        course = 'Both',
        topic = 'Both_Limits',
        sub_topic_id = '1.1',
        type = 'MCQ',
        calculator_allowed = 'false',
        difficulty = '4',
        target_time_seconds = '120',
        skill_tags = ARRAY['SK_RADICAL_RATIONALIZE','SK_DIFF_QUOTIENT','SK_ALGEBRA_SIMPLIFY'],
        error_tags = ARRAY['E_RATIONALIZE_MISUSE','E_PLUG_H_0','E_ARITHMETIC_SLIP'],
        prompt = 'Compute the instantaneous rate of change of $g(x)=\\sqrt{x}$ at $x=9$ using the limit definition $$g''(9)=\\lim_{h\\to 0}\\frac{\\sqrt{9+h}-3}{h}.$$',
        latex = 'Compute the instantaneous rate of change of $g(x)=\\sqrt{x}$ at $x=9$ using the limit definition $$g''(9)=\\lim_{h\\to 0}\\frac{\\sqrt{9+h}-3}{h}.$$',
        options = '[{"id": "A", "text": "$\\\\dfrac{1}{3}$", "explanation": "This can happen if you cancel incorrectly before rationalizing."}, {"id": "B", "text": "$\\\\dfrac{1}{18}$", "explanation": "This can happen if you mistakenly evaluate $\\\\sqrt{9+h}+3\\\\to 18$ instead of $\\\\to 6$."}, {"id": "C", "text": "$\\\\dfrac{1}{6}$", "explanation": "Correct: rationalizing gives $\\\\dfrac{1}{\\\\sqrt{9+h}+3}\\\\to \\\\dfrac{1}{6}$."}, {"id": "D", "text": "$\\\\dfrac{1}{9}$", "explanation": "This can happen if you confuse $\\\\sqrt{9}=3$ and incorrectly square values during simplification."}]'::jsonb,
        correct_option_id = 'C',
        tolerance = '0.0010',
        explanation = 'Rationalize:
$$\\frac{\\sqrt{9+h}-3}{h}\\cdot\\frac{\\sqrt{9+h}+3}{\\sqrt{9+h}+3}
=\\frac{(9+h)-9}{h(\\sqrt{9+h}+3)}
=\\frac{1}{\\sqrt{9+h}+3}.$$
Then
$$\\lim_{h\\to 0}\\frac{1}{\\sqrt{9+h}+3}=\\frac{1}{3+3}=\\frac{1}{6}.$$',
        micro_explanations = '{"A": "Correct.", "B": "Likely dropped terms/incorrect simplification.", "C": "Used function value instead of limit.", "D": "Binomial expansion error."}',
        recommendation_reasons = ARRAY['Reinforces conjugate technique inside a limit.','Targets the “substitute $h=0$ too early” misconception.'],
        created_by = null,
        updated_at = NOW(),
        status = 'published',
        version = '6',
        reasoning_level = '4',
        mastery_weight = '1.20',
        representation_type = 'symbolic',
        topic_id = 'Both_Limits',
        section_id = '1.1',
        source = 'NewMaoS',
        source_year = '2026',
        notes = 'Focus: rationalize a radical difference quotient and take the limit safely.',
        weight_primary = '0.7',
        weight_supporting = '0.3',
        prompt_type = 'text',
        primary_skill_id = 'SKL_DifferenceQuotient',
        supporting_skill_ids = ARRAY['SKL_AlgebraicManipulation']
    WHERE title = '1.1-P3';

    -- Insert if not found
    IF NOT FOUND THEN
        INSERT INTO public.questions (id, course, topic, sub_topic_id, type, calculator_allowed, difficulty, target_time_seconds, skill_tags, error_tags, prompt, latex, options, correct_option_id, tolerance, explanation, micro_explanations, recommendation_reasons, created_by, created_at, updated_at, status, version, reasoning_level, mastery_weight, representation_type, topic_id, section_id, source, source_year, notes, weight_primary, weight_supporting, title, prompt_type, primary_skill_id, supporting_skill_ids)
        VALUES ('710fbf4a-ce08-45d3-add5-76c86de02a04', 'Both', 'Both_Limits', '1.1', 'MCQ', 'false', '4', '120', ARRAY['SK_RADICAL_RATIONALIZE','SK_DIFF_QUOTIENT','SK_ALGEBRA_SIMPLIFY'], ARRAY['E_RATIONALIZE_MISUSE','E_PLUG_H_0','E_ARITHMETIC_SLIP'], 'Compute the instantaneous rate of change of $g(x)=\\sqrt{x}$ at $x=9$ using the limit definition $$g''(9)=\\lim_{h\\to 0}\\frac{\\sqrt{9+h}-3}{h}.$$', 'Compute the instantaneous rate of change of $g(x)=\\sqrt{x}$ at $x=9$ using the limit definition $$g''(9)=\\lim_{h\\to 0}\\frac{\\sqrt{9+h}-3}{h}.$$', '[{"id": "A", "text": "$\\\\dfrac{1}{3}$", "explanation": "This can happen if you cancel incorrectly before rationalizing."}, {"id": "B", "text": "$\\\\dfrac{1}{18}$", "explanation": "This can happen if you mistakenly evaluate $\\\\sqrt{9+h}+3\\\\to 18$ instead of $\\\\to 6$."}, {"id": "C", "text": "$\\\\dfrac{1}{6}$", "explanation": "Correct: rationalizing gives $\\\\dfrac{1}{\\\\sqrt{9+h}+3}\\\\to \\\\dfrac{1}{6}$."}, {"id": "D", "text": "$\\\\dfrac{1}{9}$", "explanation": "This can happen if you confuse $\\\\sqrt{9}=3$ and incorrectly square values during simplification."}]'::jsonb, 'C', '0.0010', 'Rationalize:
$$\\frac{\\sqrt{9+h}-3}{h}\\cdot\\frac{\\sqrt{9+h}+3}{\\sqrt{9+h}+3}
=\\frac{(9+h)-9}{h(\\sqrt{9+h}+3)}
=\\frac{1}{\\sqrt{9+h}+3}.$$
Then
$$\\lim_{h\\to 0}\\frac{1}{\\sqrt{9+h}+3}=\\frac{1}{3+3}=\\frac{1}{6}.$$', '{"A": "Correct.", "B": "Likely dropped terms/incorrect simplification.", "C": "Used function value instead of limit.", "D": "Binomial expansion error."}', ARRAY['Reinforces conjugate technique inside a limit.','Targets the “substitute $h=0$ too early” misconception.'], null, '2026-02-07 17:20:00+00', NOW(), 'published', '6', '4', '1.20', 'symbolic', 'Both_Limits', '1.1', 'NewMaoS', '2026', 'Focus: rationalize a radical difference quotient and take the limit safely.', '0.7', '0.3', '1.1-P3', 'text', 'SKL_DifferenceQuotient', ARRAY['SKL_AlgebraicManipulation']);
    END IF;
END $do$;


DO $do$
BEGIN
    -- Update based on title
    UPDATE public.questions
    SET
        course = 'Both',
        topic = 'Both_Limits',
        sub_topic_id = '1.1',
        type = 'MCQ',
        calculator_allowed = 'false',
        difficulty = '1',
        target_time_seconds = '60',
        skill_tags = ARRAY['SK_AVG_ROC','SK_UNITS_INTERPRET'],
        error_tags = ARRAY['E_AVG_VS_INST','E_AVG_ROC_SETUP','E_UNITS_MISMATCH'],
        prompt = 'A car’s distance from home (in miles) after $t$ hours is $D(t)$. Which quantity best represents the average speed of the car from $t=2$ to $t=5$?',
        latex = 'A car’s distance from home (in miles) after $t$ hours is $D(t)$. Which quantity best represents the average speed of the car from $t=2$ to $t=5$?',
        options = '[{"id": "A", "text": "$$\\\\frac{D(5)-D(2)}{5-2}$$", "explanation": "Correct: change in distance divided by change in time (miles per hour)."}, {"id": "B", "text": "$D(5)-D(2)$", "explanation": "This is total change in distance, not a rate per hour."}, {"id": "C", "text": "$$\\\\frac{D(5)}{5}$$", "explanation": "This averages from $0$ to $5$, not from $2$ to $5$."}, {"id": "D", "text": "$D''(2)$", "explanation": "This is an instantaneous rate at $t=2$, not an average over $[2,5]$."}]'::jsonb,
        correct_option_id = 'A',
        tolerance = '0.0010',
        explanation = 'Average speed on $[2,5]$ is the average rate of change:
$$\\frac{D(5)-D(2)}{5-2}.$$',
        micro_explanations = '{"A": "Missed full rationalization.", "B": "Correct: limit is 1/6.", "C": "Substitution done incorrectly.", "D": "Incorrect denominator evaluation."}',
        recommendation_reasons = ARRAY['Locks in the definition of average speed as a secant slope.','Separates average rate from instantaneous rate.'],
        created_by = null,
        updated_at = NOW(),
        status = 'published',
        version = '6',
        reasoning_level = '1',
        mastery_weight = '0.85',
        representation_type = 'symbolic',
        topic_id = 'Both_Limits',
        section_id = '1.1',
        source = 'NewMaoS',
        source_year = '2026',
        notes = 'Focus: interpret average speed as a difference quotient with correct units.',
        weight_primary = '0.9',
        weight_supporting = '0.1',
        prompt_type = 'text',
        primary_skill_id = 'SKL_AlgebraicManipulation',
        supporting_skill_ids = ARRAY['SKL_DifferenceQuotient']
    WHERE title = '1.1-P4';

    -- Insert if not found
    IF NOT FOUND THEN
        INSERT INTO public.questions (id, course, topic, sub_topic_id, type, calculator_allowed, difficulty, target_time_seconds, skill_tags, error_tags, prompt, latex, options, correct_option_id, tolerance, explanation, micro_explanations, recommendation_reasons, created_by, created_at, updated_at, status, version, reasoning_level, mastery_weight, representation_type, topic_id, section_id, source, source_year, notes, weight_primary, weight_supporting, title, prompt_type, primary_skill_id, supporting_skill_ids)
        VALUES ('e3077013-8f07-4447-b3a4-21ab045a37fa', 'Both', 'Both_Limits', '1.1', 'MCQ', 'false', '1', '60', ARRAY['SK_AVG_ROC','SK_UNITS_INTERPRET'], ARRAY['E_AVG_VS_INST','E_AVG_ROC_SETUP','E_UNITS_MISMATCH'], 'A car’s distance from home (in miles) after $t$ hours is $D(t)$. Which quantity best represents the average speed of the car from $t=2$ to $t=5$?', 'A car’s distance from home (in miles) after $t$ hours is $D(t)$. Which quantity best represents the average speed of the car from $t=2$ to $t=5$?', '[{"id": "A", "text": "$$\\\\frac{D(5)-D(2)}{5-2}$$", "explanation": "Correct: change in distance divided by change in time (miles per hour)."}, {"id": "B", "text": "$D(5)-D(2)$", "explanation": "This is total change in distance, not a rate per hour."}, {"id": "C", "text": "$$\\\\frac{D(5)}{5}$$", "explanation": "This averages from $0$ to $5$, not from $2$ to $5$."}, {"id": "D", "text": "$D''(2)$", "explanation": "This is an instantaneous rate at $t=2$, not an average over $[2,5]$."}]'::jsonb, 'A', '0.0010', 'Average speed on $[2,5]$ is the average rate of change:
$$\\frac{D(5)-D(2)}{5-2}.$$', '{"A": "Missed full rationalization.", "B": "Correct: limit is 1/6.", "C": "Substitution done incorrectly.", "D": "Incorrect denominator evaluation."}', ARRAY['Locks in the definition of average speed as a secant slope.','Separates average rate from instantaneous rate.'], null, '2026-02-07 17:20:00+00', NOW(), 'published', '6', '1', '0.85', 'symbolic', 'Both_Limits', '1.1', 'NewMaoS', '2026', 'Focus: interpret average speed as a difference quotient with correct units.', '0.9', '0.1', '1.1-P4', 'text', 'SKL_AlgebraicManipulation', ARRAY['SKL_DifferenceQuotient']);
    END IF;
END $do$;


DO $do$
BEGIN
    -- Update based on title
    UPDATE public.questions
    SET
        course = 'Both',
        topic = 'Both_Limits',
        sub_topic_id = '1.1',
        type = 'MCQ',
        calculator_allowed = 'false',
        difficulty = '5',
        target_time_seconds = '135',
        skill_tags = ARRAY['SK_DIFF_QUOTIENT','SK_ALGEBRA_SIMPLIFY','SK_LIMIT_CONCEPT'],
        error_tags = ARRAY['E_EXPANSION_ERROR','E_CANCEL_INCORRECTLY','E_PLUG_H_0'],
        prompt = 'Let $p(x)=x^3$. Evaluate $$\\lim_{h\\to 0}\\frac{p(2+h)-p(2)}{h}.$$',
        latex = 'Let $p(x)=x^3$. Evaluate $$\\lim_{h\\to 0}\\frac{p(2+h)-p(2)}{h}.$$',
        options = '[{"id": "A", "text": "$6$", "explanation": "This can happen if you mishandle the expansion and lose terms after dividing by $h$."}, {"id": "B", "text": "$12$", "explanation": "Correct: $\\\\dfrac{(2+h)^3-8}{h}=12+6h+h^2\\\\to 12$."}, {"id": "C", "text": "$8$", "explanation": "This confuses $p(2)=8$ with the value of the limit."}, {"id": "D", "text": "$4$", "explanation": "This can happen from an expansion error such as treating $(2+h)^3$ as $8+4h$."}]'::jsonb,
        correct_option_id = 'B',
        tolerance = '0.0010',
        explanation = 'Compute:
$$(2+h)^3=8+12h+6h^2+h^3.$$
So
$$\\frac{(2+h)^3-8}{h}=\\frac{12h+6h^2+h^3}{h}=12+6h+h^2.$$
Taking $h\\to 0$ gives $12$.',
        micro_explanations = '{"A": "Can be transformed but not the intended clean form.", "B": "Treats h as input value, not increment.", "C": "Correct increment form.", "D": "Would need x→2, not x→0."}',
        recommendation_reasons = ARRAY['Connects instantaneous rate to a limit of secant slopes.','Requires careful algebra and safe cancellation.'],
        created_by = null,
        updated_at = NOW(),
        status = 'published',
        version = '6',
        reasoning_level = '5',
        mastery_weight = '1.25',
        representation_type = 'symbolic',
        topic_id = 'Both_Limits',
        section_id = '1.1',
        source = 'NewMaoS',
        source_year = '2026',
        notes = 'Focus: evaluate a difference-quotient limit by algebraic expansion.',
        weight_primary = '0.75',
        weight_supporting = '0.25',
        prompt_type = 'text',
        primary_skill_id = 'SKL_DifferenceQuotient',
        supporting_skill_ids = ARRAY['SKL_LimitConcept']
    WHERE title = '1.1-P5';

    -- Insert if not found
    IF NOT FOUND THEN
        INSERT INTO public.questions (id, course, topic, sub_topic_id, type, calculator_allowed, difficulty, target_time_seconds, skill_tags, error_tags, prompt, latex, options, correct_option_id, tolerance, explanation, micro_explanations, recommendation_reasons, created_by, created_at, updated_at, status, version, reasoning_level, mastery_weight, representation_type, topic_id, section_id, source, source_year, notes, weight_primary, weight_supporting, title, prompt_type, primary_skill_id, supporting_skill_ids)
        VALUES ('f0ddf815-2b22-4147-b15e-2e040490afa6', 'Both', 'Both_Limits', '1.1', 'MCQ', 'false', '5', '135', ARRAY['SK_DIFF_QUOTIENT','SK_ALGEBRA_SIMPLIFY','SK_LIMIT_CONCEPT'], ARRAY['E_EXPANSION_ERROR','E_CANCEL_INCORRECTLY','E_PLUG_H_0'], 'Let $p(x)=x^3$. Evaluate $$\\lim_{h\\to 0}\\frac{p(2+h)-p(2)}{h}.$$', 'Let $p(x)=x^3$. Evaluate $$\\lim_{h\\to 0}\\frac{p(2+h)-p(2)}{h}.$$', '[{"id": "A", "text": "$6$", "explanation": "This can happen if you mishandle the expansion and lose terms after dividing by $h$."}, {"id": "B", "text": "$12$", "explanation": "Correct: $\\\\dfrac{(2+h)^3-8}{h}=12+6h+h^2\\\\to 12$."}, {"id": "C", "text": "$8$", "explanation": "This confuses $p(2)=8$ with the value of the limit."}, {"id": "D", "text": "$4$", "explanation": "This can happen from an expansion error such as treating $(2+h)^3$ as $8+4h$."}]'::jsonb, 'B', '0.0010', 'Compute:
$$(2+h)^3=8+12h+6h^2+h^3.$$
So
$$\\frac{(2+h)^3-8}{h}=\\frac{12h+6h^2+h^3}{h}=12+6h+h^2.$$
Taking $h\\to 0$ gives $12$.', '{"A": "Can be transformed but not the intended clean form.", "B": "Treats h as input value, not increment.", "C": "Correct increment form.", "D": "Would need x→2, not x→0."}', ARRAY['Connects instantaneous rate to a limit of secant slopes.','Requires careful algebra and safe cancellation.'], null, '2026-02-07 17:20:00+00', NOW(), 'published', '6', '5', '1.25', 'symbolic', 'Both_Limits', '1.1', 'NewMaoS', '2026', 'Focus: evaluate a difference-quotient limit by algebraic expansion.', '0.75', '0.25', '1.1-P5', 'text', 'SKL_DifferenceQuotient', ARRAY['SKL_LimitConcept']);
    END IF;
END $do$;


DO $do$
BEGIN
    -- Update based on title
    UPDATE public.questions
    SET
        course = 'Both',
        topic = 'Both_Limits',
        sub_topic_id = '1.2',
        type = 'MCQ',
        calculator_allowed = 'false',
        difficulty = '2',
        target_time_seconds = '75',
        skill_tags = ARRAY['SK_LIMIT_NOTATION','SK_LIMIT_CONCEPT'],
        error_tags = ARRAY['E_LIMIT_VALUE_VS_FUNCTION_VALUE','E_ASSUME_LIMIT_EXISTS'],
        prompt = 'Suppose $\\lim_{x\\to 4} f(x)=7$. Which statement must be true?',
        latex = 'Suppose $\\lim_{x\\to 4} f(x)=7$. Which statement must be true?',
        options = '[{"id": "A", "text": "$f(4)=7$", "explanation": "Not required: the limit can exist even if $f(4)$ is different or undefined."}, {"id": "B", "text": "$f(x)=7$ for all $x$ near $4$", "explanation": "Not required: $f(x)$ can vary and still approach $7$ as $x\\\\to 4$."}, {"id": "C", "text": "For values of $x$ close to $4$ (but not necessarily equal to $4$), $f(x)$ can be made arbitrarily close to $7$.", "explanation": "Correct: this is the meaning of $\\\\lim_{x\\\\to 4} f(x)=7$."}, {"id": "D", "text": "$\\\\lim_{x\\\\to 7} f(x)=4$", "explanation": "Unrelated reversal; not implied by the given limit statement."}]'::jsonb,
        correct_option_id = 'C',
        tolerance = '0.0010',
        explanation = 'The statement $\\lim_{x\\to 4} f(x)=7$ means that for $x$ sufficiently close to $4$ (with $x\\ne 4$ allowed), the values $f(x)$ can be made as close to $7$ as desired.',
        micro_explanations = '{"A": "Only right-hand value.", "B": "Only left-hand value.", "C": "Correct: mismatch implies DNE.", "D": "Not from either one-sided limit."}',
        recommendation_reasons = ARRAY['Builds correct conceptual interpretation of limit notation.','Targets confusion between limit value and function value.'],
        created_by = null,
        updated_at = NOW(),
        status = 'published',
        version = '6',
        reasoning_level = '2',
        mastery_weight = '1.00',
        representation_type = 'symbolic',
        topic_id = 'Both_Limits',
        section_id = '1.2',
        source = 'NewMaoS',
        source_year = '2026',
        notes = 'Focus: interpret limit notation without assuming $f(4)$ or local constancy.',
        weight_primary = '0.8',
        weight_supporting = '0.2',
        prompt_type = 'text',
        primary_skill_id = 'SKL_LimitExistence',
        supporting_skill_ids = ARRAY['SKL_PiecewiseAnalysis','SKL_OneSidedLimits']
    WHERE title = '1.2-P1';

    -- Insert if not found
    IF NOT FOUND THEN
        INSERT INTO public.questions (id, course, topic, sub_topic_id, type, calculator_allowed, difficulty, target_time_seconds, skill_tags, error_tags, prompt, latex, options, correct_option_id, tolerance, explanation, micro_explanations, recommendation_reasons, created_by, created_at, updated_at, status, version, reasoning_level, mastery_weight, representation_type, topic_id, section_id, source, source_year, notes, weight_primary, weight_supporting, title, prompt_type, primary_skill_id, supporting_skill_ids)
        VALUES ('e6cc77b3-c032-4c44-8e71-a6e943faec08', 'Both', 'Both_Limits', '1.2', 'MCQ', 'false', '2', '75', ARRAY['SK_LIMIT_NOTATION','SK_LIMIT_CONCEPT'], ARRAY['E_LIMIT_VALUE_VS_FUNCTION_VALUE','E_ASSUME_LIMIT_EXISTS'], 'Suppose $\\lim_{x\\to 4} f(x)=7$. Which statement must be true?', 'Suppose $\\lim_{x\\to 4} f(x)=7$. Which statement must be true?', '[{"id": "A", "text": "$f(4)=7$", "explanation": "Not required: the limit can exist even if $f(4)$ is different or undefined."}, {"id": "B", "text": "$f(x)=7$ for all $x$ near $4$", "explanation": "Not required: $f(x)$ can vary and still approach $7$ as $x\\\\to 4$."}, {"id": "C", "text": "For values of $x$ close to $4$ (but not necessarily equal to $4$), $f(x)$ can be made arbitrarily close to $7$.", "explanation": "Correct: this is the meaning of $\\\\lim_{x\\\\to 4} f(x)=7$."}, {"id": "D", "text": "$\\\\lim_{x\\\\to 7} f(x)=4$", "explanation": "Unrelated reversal; not implied by the given limit statement."}]'::jsonb, 'C', '0.0010', 'The statement $\\lim_{x\\to 4} f(x)=7$ means that for $x$ sufficiently close to $4$ (with $x\\ne 4$ allowed), the values $f(x)$ can be made as close to $7$ as desired.', '{"A": "Only right-hand value.", "B": "Only left-hand value.", "C": "Correct: mismatch implies DNE.", "D": "Not from either one-sided limit."}', ARRAY['Builds correct conceptual interpretation of limit notation.','Targets confusion between limit value and function value.'], null, '2026-02-07 17:20:00+00', NOW(), 'published', '6', '2', '1.00', 'symbolic', 'Both_Limits', '1.2', 'NewMaoS', '2026', 'Focus: interpret limit notation without assuming $f(4)$ or local constancy.', '0.8', '0.2', '1.2-P1', 'text', 'SKL_LimitExistence', ARRAY['SKL_PiecewiseAnalysis','SKL_OneSidedLimits']);
    END IF;
END $do$;


DO $do$
BEGIN
    -- Update based on title
    UPDATE public.questions
    SET
        course = 'Both',
        topic = 'Both_Limits',
        sub_topic_id = '1.2',
        type = 'MCQ',
        calculator_allowed = 'false',
        difficulty = '3',
        target_time_seconds = '90',
        skill_tags = ARRAY['SK_ONE_SIDED_LIMIT','SK_LIMIT_EXISTENCE','SK_ABS_VALUE_SIGN'],
        error_tags = ARRAY['E_LEFT_RIGHT_CONFUSION','E_ASSUME_LIMIT_EXISTS','E_PIECEWISE_BRANCH_MIXUP'],
        prompt = 'For $x\\ne 1$, define $$f(x)=\\frac{|x-1|}{x-1}.$$ Which statement is correct?',
        latex = 'For $x\\ne 1$, define $$f(x)=\\frac{|x-1|}{x-1}.$$ Which statement is correct?',
        options = '[{"id": "A", "text": "$$\\\\lim_{x\\\\to 1^-} f(x)=-1\\\\ \\\\text{and}\\\\ \\\\lim_{x\\\\to 1^+} f(x)=1$$", "explanation": "Correct: for $x<1$, $f(x)=-1$; for $x>1$, $f(x)=1$."}, {"id": "B", "text": "$$\\\\lim_{x\\\\to 1} f(x)=1$$", "explanation": "The two-sided limit does not exist because the one-sided limits are different."}, {"id": "C", "text": "$$\\\\lim_{x\\\\to 1} f(x)=-1$$", "explanation": "Only the left-hand limit is $-1$; the right-hand limit is $1$."}, {"id": "D", "text": "$f(1)=0$", "explanation": "The function is not defined at $x=1$ because the definition specifies $x\\\\ne 1$."}]'::jsonb,
        correct_option_id = 'A',
        tolerance = '0.0010',
        explanation = 'If $x>1$, then $|x-1|=x-1$ so $f(x)=1$. If $x<1$, then $|x-1|=-(x-1)$ so $f(x)=-1$. Therefore
$$\\lim_{x\\to 1^-} f(x)=-1,\\qquad \\lim_{x\\to 1^+} f(x)=1,$$
so the two-sided limit does not exist.',
        micro_explanations = '{"A": "Moved constant in wrong direction.", "B": "Correct.", "C": "Did not undo shift by 3.", "D": "Sign slip."}',
        recommendation_reasons = ARRAY['Reinforces one-sided limits via sign analysis.','Targets the misconception that a two-sided limit always exists.'],
        created_by = null,
        updated_at = NOW(),
        status = 'published',
        version = '6',
        reasoning_level = '3',
        mastery_weight = '1.10',
        representation_type = 'symbolic',
        topic_id = 'Both_Limits',
        section_id = '1.2',
        source = 'NewMaoS',
        source_year = '2026',
        notes = 'Focus: determine one-sided limits and conclude about existence of the two-sided limit.',
        weight_primary = '0.75',
        weight_supporting = '0.25',
        prompt_type = 'text',
        primary_skill_id = 'SKL_LimitLaws',
        supporting_skill_ids = ARRAY['SKL_LimitNotation']
    WHERE title = '1.2-P2';

    -- Insert if not found
    IF NOT FOUND THEN
        INSERT INTO public.questions (id, course, topic, sub_topic_id, type, calculator_allowed, difficulty, target_time_seconds, skill_tags, error_tags, prompt, latex, options, correct_option_id, tolerance, explanation, micro_explanations, recommendation_reasons, created_by, created_at, updated_at, status, version, reasoning_level, mastery_weight, representation_type, topic_id, section_id, source, source_year, notes, weight_primary, weight_supporting, title, prompt_type, primary_skill_id, supporting_skill_ids)
        VALUES ('de61e723-1540-42bc-94fd-5de9605011e4', 'Both', 'Both_Limits', '1.2', 'MCQ', 'false', '3', '90', ARRAY['SK_ONE_SIDED_LIMIT','SK_LIMIT_EXISTENCE','SK_ABS_VALUE_SIGN'], ARRAY['E_LEFT_RIGHT_CONFUSION','E_ASSUME_LIMIT_EXISTS','E_PIECEWISE_BRANCH_MIXUP'], 'For $x\\ne 1$, define $$f(x)=\\frac{|x-1|}{x-1}.$$ Which statement is correct?', 'For $x\\ne 1$, define $$f(x)=\\frac{|x-1|}{x-1}.$$ Which statement is correct?', '[{"id": "A", "text": "$$\\\\lim_{x\\\\to 1^-} f(x)=-1\\\\ \\\\text{and}\\\\ \\\\lim_{x\\\\to 1^+} f(x)=1$$", "explanation": "Correct: for $x<1$, $f(x)=-1$; for $x>1$, $f(x)=1$."}, {"id": "B", "text": "$$\\\\lim_{x\\\\to 1} f(x)=1$$", "explanation": "The two-sided limit does not exist because the one-sided limits are different."}, {"id": "C", "text": "$$\\\\lim_{x\\\\to 1} f(x)=-1$$", "explanation": "Only the left-hand limit is $-1$; the right-hand limit is $1$."}, {"id": "D", "text": "$f(1)=0$", "explanation": "The function is not defined at $x=1$ because the definition specifies $x\\\\ne 1$."}]'::jsonb, 'A', '0.0010', 'If $x>1$, then $|x-1|=x-1$ so $f(x)=1$. If $x<1$, then $|x-1|=-(x-1)$ so $f(x)=-1$. Therefore
$$\\lim_{x\\to 1^-} f(x)=-1,\\qquad \\lim_{x\\to 1^+} f(x)=1,$$
so the two-sided limit does not exist.', '{"A": "Moved constant in wrong direction.", "B": "Correct.", "C": "Did not undo shift by 3.", "D": "Sign slip."}', ARRAY['Reinforces one-sided limits via sign analysis.','Targets the misconception that a two-sided limit always exists.'], null, '2026-02-07 17:20:00+00', NOW(), 'published', '6', '3', '1.10', 'symbolic', 'Both_Limits', '1.2', 'NewMaoS', '2026', 'Focus: determine one-sided limits and conclude about existence of the two-sided limit.', '0.75', '0.25', '1.2-P2', 'text', 'SKL_LimitLaws', ARRAY['SKL_LimitNotation']);
    END IF;
END $do$;


DO $do$
BEGIN
    -- Update based on title
    UPDATE public.questions
    SET
        course = 'Both',
        topic = 'Both_Limits',
        sub_topic_id = '1.2',
        type = 'MCQ',
        calculator_allowed = 'false',
        difficulty = '4',
        target_time_seconds = '105',
        skill_tags = ARRAY['SK_LIMIT_LAWS','SK_LIMIT_NOTATION'],
        error_tags = ARRAY['E_SIGN_ERROR','E_ARITHMETIC_SLIP','E_LIMIT_VALUE_VS_FUNCTION_VALUE'],
        prompt = 'If $\\lim_{x\\to 2} (f(x)-3)=5$, what is $\\lim_{x\\to 2} f(x)$?',
        latex = 'If $\\lim_{x\\to 2} (f(x)-3)=5$, what is $\\lim_{x\\to 2} f(x)$?',
        options = '[{"id": "A", "text": "$2$", "explanation": "This can happen if you subtract $3$ instead of adding it back."}, {"id": "B", "text": "$5$", "explanation": "This is the limit of $f(x)-3$, not the limit of $f(x)$."}, {"id": "C", "text": "$-8$", "explanation": "This can happen from sign confusion when moving $-3$ to the other side."}, {"id": "D", "text": "$8$", "explanation": "Correct: $\\\\lim f(x)=5+3=8$."}]'::jsonb,
        correct_option_id = 'D',
        tolerance = '0.0010',
        explanation = 'Use limit laws:
$$\\lim_{x\\to 2}(f(x)-3)=\\lim_{x\\to 2}f(x)-3=5,$$
so
$$\\lim_{x\\to 2}f(x)=8.$$',
        micro_explanations = '{"A": "Limit does not force function value.", "B": "Limit does not force constancy nearby.", "C": "Correct epsilon-delta meaning (informal).", "D": "Unrelated."}',
        recommendation_reasons = ARRAY['Builds fluency with limit laws and algebraic rearrangement.','Targets common shift/sign mistakes.'],
        created_by = null,
        updated_at = NOW(),
        status = 'published',
        version = '6',
        reasoning_level = '3',
        mastery_weight = '1.10',
        representation_type = 'symbolic',
        topic_id = 'Both_Limits',
        section_id = '1.2',
        source = 'NewMaoS',
        source_year = '2026',
        notes = 'Focus: translate a limit statement involving a constant shift into the limit of the function.',
        weight_primary = '0.7',
        weight_supporting = '0.3',
        prompt_type = 'text',
        primary_skill_id = 'SKL_LimitNotation',
        supporting_skill_ids = ARRAY['SKL_LimitConcept']
    WHERE title = '1.2-P3';

    -- Insert if not found
    IF NOT FOUND THEN
        INSERT INTO public.questions (id, course, topic, sub_topic_id, type, calculator_allowed, difficulty, target_time_seconds, skill_tags, error_tags, prompt, latex, options, correct_option_id, tolerance, explanation, micro_explanations, recommendation_reasons, created_by, created_at, updated_at, status, version, reasoning_level, mastery_weight, representation_type, topic_id, section_id, source, source_year, notes, weight_primary, weight_supporting, title, prompt_type, primary_skill_id, supporting_skill_ids)
        VALUES ('b4025401-2b48-4196-a636-220aea3baa4e', 'Both', 'Both_Limits', '1.2', 'MCQ', 'false', '4', '105', ARRAY['SK_LIMIT_LAWS','SK_LIMIT_NOTATION'], ARRAY['E_SIGN_ERROR','E_ARITHMETIC_SLIP','E_LIMIT_VALUE_VS_FUNCTION_VALUE'], 'If $\\lim_{x\\to 2} (f(x)-3)=5$, what is $\\lim_{x\\to 2} f(x)$?', 'If $\\lim_{x\\to 2} (f(x)-3)=5$, what is $\\lim_{x\\to 2} f(x)$?', '[{"id": "A", "text": "$2$", "explanation": "This can happen if you subtract $3$ instead of adding it back."}, {"id": "B", "text": "$5$", "explanation": "This is the limit of $f(x)-3$, not the limit of $f(x)$."}, {"id": "C", "text": "$-8$", "explanation": "This can happen from sign confusion when moving $-3$ to the other side."}, {"id": "D", "text": "$8$", "explanation": "Correct: $\\\\lim f(x)=5+3=8$."}]'::jsonb, 'D', '0.0010', 'Use limit laws:
$$\\lim_{x\\to 2}(f(x)-3)=\\lim_{x\\to 2}f(x)-3=5,$$
so
$$\\lim_{x\\to 2}f(x)=8.$$', '{"A": "Limit does not force function value.", "B": "Limit does not force constancy nearby.", "C": "Correct epsilon-delta meaning (informal).", "D": "Unrelated."}', ARRAY['Builds fluency with limit laws and algebraic rearrangement.','Targets common shift/sign mistakes.'], null, '2026-02-07 17:20:00+00', NOW(), 'published', '6', '3', '1.10', 'symbolic', 'Both_Limits', '1.2', 'NewMaoS', '2026', 'Focus: translate a limit statement involving a constant shift into the limit of the function.', '0.7', '0.3', '1.2-P3', 'text', 'SKL_LimitNotation', ARRAY['SKL_LimitConcept']);
    END IF;
END $do$;


DO $do$
BEGIN
    -- Update based on title
    UPDATE public.questions
    SET
        course = 'Both',
        topic = 'Both_Limits',
        sub_topic_id = '1.2',
        type = 'MCQ',
        calculator_allowed = 'false',
        difficulty = '1',
        target_time_seconds = '60',
        skill_tags = ARRAY['SK_LIMIT_NOTATION','SK_ONE_SIDED_LIMIT'],
        error_tags = ARRAY['E_LEFT_RIGHT_CONFUSION'],
        prompt = 'Which notation correctly describes “the left-hand limit of $f(x)$ as $x$ approaches $5$”?',
        latex = 'Which notation correctly describes “the left-hand limit of $f(x)$ as $x$ approaches $5$”?',
        options = '[{"id": "A", "text": "$$\\\\lim_{x\\\\to 5^+} f(x)$$", "explanation": "$5^+$ indicates approaching from the right, not from the left."}, {"id": "B", "text": "$$\\\\lim_{x\\\\to 5} f(5)$$", "explanation": "This misuses limit notation by treating $f(5)$ as varying with $x$."}, {"id": "C", "text": "$$\\\\lim_{f(x)\\\\to 5^-} x$$", "explanation": "This reverses input/output and is not standard one-sided limit notation."}, {"id": "D", "text": "$$\\\\lim_{x\\\\to 5^-} f(x)$$", "explanation": "Correct: $x\\\\to 5^-$ means values less than $5$ approaching $5$."}]'::jsonb,
        correct_option_id = 'D',
        tolerance = '0.0010',
        explanation = 'Approaching from the left uses $5^-$, so the left-hand limit is
$$\\lim_{x\\to 5^-} f(x).$$',
        micro_explanations = '{"A": "Plus means right side.", "B": "Correct left-hand notation.", "C": "f(5) is constant expression.", "D": "Incorrect variable roles."}',
        recommendation_reasons = ARRAY['Locks in left vs right one-sided limit notation.','Prevents common symbol direction errors.'],
        created_by = null,
        updated_at = NOW(),
        status = 'published',
        version = '6',
        reasoning_level = '1',
        mastery_weight = '0.80',
        representation_type = 'symbolic',
        topic_id = 'Both_Limits',
        section_id = '1.2',
        source = 'NewMaoS',
        source_year = '2026',
        notes = 'Focus: recognize correct one-sided limit notation.',
        weight_primary = '0.9',
        weight_supporting = '0.1',
        prompt_type = 'text',
        primary_skill_id = 'SKL_LimitNotation',
        supporting_skill_ids = ARRAY['SKL_OneSidedLimits']
    WHERE title = '1.2-P4';

    -- Insert if not found
    IF NOT FOUND THEN
        INSERT INTO public.questions (id, course, topic, sub_topic_id, type, calculator_allowed, difficulty, target_time_seconds, skill_tags, error_tags, prompt, latex, options, correct_option_id, tolerance, explanation, micro_explanations, recommendation_reasons, created_by, created_at, updated_at, status, version, reasoning_level, mastery_weight, representation_type, topic_id, section_id, source, source_year, notes, weight_primary, weight_supporting, title, prompt_type, primary_skill_id, supporting_skill_ids)
        VALUES ('2aa7162f-0b44-488c-9b81-8a8d38f9bcbc', 'Both', 'Both_Limits', '1.2', 'MCQ', 'false', '1', '60', ARRAY['SK_LIMIT_NOTATION','SK_ONE_SIDED_LIMIT'], ARRAY['E_LEFT_RIGHT_CONFUSION'], 'Which notation correctly describes “the left-hand limit of $f(x)$ as $x$ approaches $5$”?', 'Which notation correctly describes “the left-hand limit of $f(x)$ as $x$ approaches $5$”?', '[{"id": "A", "text": "$$\\\\lim_{x\\\\to 5^+} f(x)$$", "explanation": "$5^+$ indicates approaching from the right, not from the left."}, {"id": "B", "text": "$$\\\\lim_{x\\\\to 5} f(5)$$", "explanation": "This misuses limit notation by treating $f(5)$ as varying with $x$."}, {"id": "C", "text": "$$\\\\lim_{f(x)\\\\to 5^-} x$$", "explanation": "This reverses input/output and is not standard one-sided limit notation."}, {"id": "D", "text": "$$\\\\lim_{x\\\\to 5^-} f(x)$$", "explanation": "Correct: $x\\\\to 5^-$ means values less than $5$ approaching $5$."}]'::jsonb, 'D', '0.0010', 'Approaching from the left uses $5^-$, so the left-hand limit is
$$\\lim_{x\\to 5^-} f(x).$$', '{"A": "Plus means right side.", "B": "Correct left-hand notation.", "C": "f(5) is constant expression.", "D": "Incorrect variable roles."}', ARRAY['Locks in left vs right one-sided limit notation.','Prevents common symbol direction errors.'], null, '2026-02-07 17:20:00+00', NOW(), 'published', '6', '1', '0.80', 'symbolic', 'Both_Limits', '1.2', 'NewMaoS', '2026', 'Focus: recognize correct one-sided limit notation.', '0.9', '0.1', '1.2-P4', 'text', 'SKL_LimitNotation', ARRAY['SKL_OneSidedLimits']);
    END IF;
END $do$;


DO $do$
BEGIN
    -- Update based on title
    UPDATE public.questions
    SET
        course = 'Both',
        topic = 'Both_Limits',
        sub_topic_id = '1.2',
        type = 'MCQ',
        calculator_allowed = 'false',
        difficulty = '5',
        target_time_seconds = '120',
        skill_tags = ARRAY['SK_LIMIT_EXISTENCE','SK_ONE_SIDED_LIMIT','SK_PIECEWISE_LIMIT'],
        error_tags = ARRAY['E_PIECEWISE_BRANCH_MIXUP','E_LEFT_RIGHT_CONFUSION','E_ASSUME_LIMIT_EXISTS'],
        prompt = 'Define $$f(x)=\\begin{cases}2x+1,& x<0\\\\ x^2,& x\\ge 0\\end{cases}$$ What is $\\lim_{x\\to 0} f(x)$?',
        latex = 'Define $$f(x)=\\begin{cases}2x+1,& x<0\\\\ x^2,& x\\ge 0\\end{cases}$$ What is $\\lim_{x\\to 0} f(x)$?',
        options = '[{"id": "A", "text": "$0$", "explanation": "This is the right-hand limit ($x\\\\to 0^+$), not the two-sided limit."}, {"id": "B", "text": "$1$", "explanation": "This is the left-hand limit ($x\\\\to 0^-$), not the two-sided limit."}, {"id": "C", "text": "Does not exist", "explanation": "Correct: the one-sided limits are $1$ and $0$, so the two-sided limit does not exist."}, {"id": "D", "text": "$2$", "explanation": "This can happen if you mix branches or substitute incorrectly across the piecewise definition."}]'::jsonb,
        correct_option_id = 'C',
        tolerance = '0.0010',
        explanation = 'Compute one-sided limits:
$$\\lim_{x\\to 0^-} f(x)=\\lim_{x\\to 0^-}(2x+1)=1,$$
$$\\lim_{x\\to 0^+} f(x)=\\lim_{x\\to 0^+}(x^2)=0.$$
Since $1\\ne 0$, $\\lim_{x\\to 0} f(x)$ does not exist.',
        micro_explanations = '{"A": "Right-hand only is 1.", "B": "Left-hand only is -1.", "C": "Correct left/right analysis.", "D": "Domain excludes x=1."}',
        recommendation_reasons = ARRAY['Builds the rule: two-sided limit exists iff one-sided limits match.','Targets piecewise branch selection and left/right control.'],
        created_by = null,
        updated_at = NOW(),
        status = 'published',
        version = '6',
        reasoning_level = '5',
        mastery_weight = '1.25',
        representation_type = 'symbolic',
        topic_id = 'Both_Limits',
        section_id = '1.2',
        source = 'NewMaoS',
        source_year = '2026',
        notes = 'Focus: compare one-sided limits of a piecewise function to determine existence of the two-sided limit.',
        weight_primary = '0.75',
        weight_supporting = '0.25',
        prompt_type = 'text',
        primary_skill_id = 'SKL_OneSidedLimits',
        supporting_skill_ids = ARRAY['SKL_LimitExistence']
    WHERE title = '1.2-P5';

    -- Insert if not found
    IF NOT FOUND THEN
        INSERT INTO public.questions (id, course, topic, sub_topic_id, type, calculator_allowed, difficulty, target_time_seconds, skill_tags, error_tags, prompt, latex, options, correct_option_id, tolerance, explanation, micro_explanations, recommendation_reasons, created_by, created_at, updated_at, status, version, reasoning_level, mastery_weight, representation_type, topic_id, section_id, source, source_year, notes, weight_primary, weight_supporting, title, prompt_type, primary_skill_id, supporting_skill_ids)
        VALUES ('f0cf4e8c-1ea4-4671-a564-ea2cea9b6fc8', 'Both', 'Both_Limits', '1.2', 'MCQ', 'false', '5', '120', ARRAY['SK_LIMIT_EXISTENCE','SK_ONE_SIDED_LIMIT','SK_PIECEWISE_LIMIT'], ARRAY['E_PIECEWISE_BRANCH_MIXUP','E_LEFT_RIGHT_CONFUSION','E_ASSUME_LIMIT_EXISTS'], 'Define $$f(x)=\\begin{cases}2x+1,& x<0\\\\ x^2,& x\\ge 0\\end{cases}$$ What is $\\lim_{x\\to 0} f(x)$?', 'Define $$f(x)=\\begin{cases}2x+1,& x<0\\\\ x^2,& x\\ge 0\\end{cases}$$ What is $\\lim_{x\\to 0} f(x)$?', '[{"id": "A", "text": "$0$", "explanation": "This is the right-hand limit ($x\\\\to 0^+$), not the two-sided limit."}, {"id": "B", "text": "$1$", "explanation": "This is the left-hand limit ($x\\\\to 0^-$), not the two-sided limit."}, {"id": "C", "text": "Does not exist", "explanation": "Correct: the one-sided limits are $1$ and $0$, so the two-sided limit does not exist."}, {"id": "D", "text": "$2$", "explanation": "This can happen if you mix branches or substitute incorrectly across the piecewise definition."}]'::jsonb, 'C', '0.0010', 'Compute one-sided limits:
$$\\lim_{x\\to 0^-} f(x)=\\lim_{x\\to 0^-}(2x+1)=1,$$
$$\\lim_{x\\to 0^+} f(x)=\\lim_{x\\to 0^+}(x^2)=0.$$
Since $1\\ne 0$, $\\lim_{x\\to 0} f(x)$ does not exist.', '{"A": "Right-hand only is 1.", "B": "Left-hand only is -1.", "C": "Correct left/right analysis.", "D": "Domain excludes x=1."}', ARRAY['Builds the rule: two-sided limit exists iff one-sided limits match.','Targets piecewise branch selection and left/right control.'], null, '2026-02-07 17:20:00+00', NOW(), 'published', '6', '5', '1.25', 'symbolic', 'Both_Limits', '1.2', 'NewMaoS', '2026', 'Focus: compare one-sided limits of a piecewise function to determine existence of the two-sided limit.', '0.75', '0.25', '1.2-P5', 'text', 'SKL_OneSidedLimits', ARRAY['SKL_LimitExistence']);
    END IF;
END $do$;
