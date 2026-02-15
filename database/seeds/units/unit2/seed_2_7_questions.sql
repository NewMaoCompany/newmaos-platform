-- Insert Script for Unit 2.7 Questions (Trig, Exp, Log Derivatives)
-- Unit: ABBC_Derivatives / 2.7

-- 1. Clean up potential duplicates
DELETE FROM public.questions WHERE title IN ('U2.7-P1', 'U2.7-P2', 'U2.7-P3', 'U2.7-P4', 'U2.7-P5');

-- ============================================================
-- U2.7-P1
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U2.7-P1', 'Both', 'ABBC_Derivatives', '2.7', '2.7', 'MCQ', FALSE,
        2, 90, '{trig_derivatives_basic}', '{trig_derivative_swap_error}', 'text',
        $txt$If $f(x)=\sin x$, what is $f'(x)$?$txt$,
        $txt$If $f(x)=\sin x$, what is $f'(x)$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$\\cos x$", "type": "text", "explanation": "Correct. d/dx(sin x) = cos x."},
          {"id": "B", "label": "B", "value": "$-\\cos x$", "type": "text", "explanation": "The negative sign belongs to the derivative of cos x, not sin x."},
          {"id": "C", "label": "C", "value": "$\\sin x$", "type": "text", "explanation": "This is the original function, not its derivative."},
          {"id": "D", "label": "D", "value": "$-\\sin x$", "type": "text", "explanation": "This is not the correct derivative rule for sin x."}
        ]$txt$,
        'A',
        $txt$The derivative of $\sin x$ is $\cos x$.$txt$,
        '{trig_derivatives_basic}',
        'published', 1, 2, 1.0, 'NewMaoS', 2026, '', 1.0, 0.0, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'trig_derivatives_basic', 'primary', 1.0 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'trig_derivative_swap_error' FROM new_question;

-- ============================================================
-- U2.7-P2
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U2.7-P2', 'Both', 'ABBC_Derivatives', '2.7', '2.7', 'MCQ', FALSE,
        3, 120, '{trig_derivatives_basic,linearity_rules}', '{trig_derivative_swap_error}', 'text',
        $txt$If $f(x)=4\cos x - 3\sin x$, what is $f'(x)$?$txt$,
        $txt$If $f(x)=4\cos x - 3\sin x$, what is $f'(x)$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$-4\\sin x - 3\\cos x$", "type": "text", "explanation": "Correct. Apply trig derivatives and linearity to get -4sin x - 3cos x."},
          {"id": "B", "label": "B", "value": "$-4\\sin x + 3\\cos x$", "type": "text", "explanation": "The sign on the second term is incorrect."},
          {"id": "C", "label": "C", "value": "$4\\sin x - 3\\cos x$", "type": "text", "explanation": "This has the wrong sign for the derivative of cos x."},
          {"id": "D", "label": "D", "value": "$4\\cos x - 3\\sin x$", "type": "text", "explanation": "This repeats the original function instead of differentiating."}
        ]$txt$,
        'A',
        $txt$Differentiate term-by-term: $\frac{d}{dx}(4\cos x)=-4\sin x$ and $\frac{d}{dx}(-3\sin x)=-3\cos x$. So $f'(x)=-4\sin x - 3\cos x$.$txt$,
        '{trig_derivatives_basic}',
        'published', 1, 3, 1.1, 'NewMaoS', 2026, '', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'trig_derivatives_basic', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'linearity_rules', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'trig_derivative_swap_error' FROM new_question;

-- ============================================================
-- U2.7-P3
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U2.7-P3', 'Both', 'ABBC_Derivatives', '2.7', '2.7', 'MCQ', FALSE,
        2, 90, '{exp_derivatives_basic}', '{exp_log_derivative_confusion}', 'text',
        $txt$If $f(x)=e^x$, what is $f'(x)$?$txt$,
        $txt$If $f(x)=e^x$, what is $f'(x)$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$e^x$", "type": "text", "explanation": "Correct. d/dx(e^x)=e^x."},
          {"id": "B", "label": "B", "value": "$xe^{x-1}$", "type": "text", "explanation": "This is not a valid derivative rule for e^x."},
          {"id": "C", "label": "C", "value": "$\\ln x$", "type": "text", "explanation": "ln x is a different function, not the derivative of e^x."},
          {"id": "D", "label": "D", "value": "$1/x$", "type": "text", "explanation": "1/x is the derivative of ln x, not e^x."}
        ]$txt$,
        'A',
        $txt$The derivative of $e^x$ is $e^x$.$txt$,
        '{exp_derivatives_basic}',
        'published', 1, 2, 1.0, 'NewMaoS', 2026, '', 1.0, 0.0, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'exp_derivatives_basic', 'primary', 1.0 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'exp_log_derivative_confusion' FROM new_question;

-- ============================================================
-- U2.7-P4
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U2.7-P4', 'Both', 'ABBC_Derivatives', '2.7', '2.7', 'MCQ', FALSE,
        3, 120, '{log_derivatives_basic}', '{exp_log_derivative_confusion}', 'text',
        $txt$If $f(x)=\ln x$, what is $f'(x)$?$txt$,
        $txt$If $f(x)=\ln x$, what is $f'(x)$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$1/x$", "type": "text", "explanation": "Correct. d/dx(ln x)=1/x."},
          {"id": "B", "label": "B", "value": "$\\ln x$", "type": "text", "explanation": "This repeats the original function."},
          {"id": "C", "label": "C", "value": "$e^x$", "type": "text", "explanation": "e^x is not the derivative of ln x."},
          {"id": "D", "label": "D", "value": "$x$", "type": "text", "explanation": "x is not the derivative of ln x."}
        ]$txt$,
        'A',
        $txt$The derivative of $\ln x$ is $\frac{1}{x}$ (for $x>0$).$txt$,
        '{log_derivatives_basic}',
        'published', 1, 3, 1.1, 'NewMaoS', 2026, '', 1.0, 0.0, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'log_derivatives_basic', 'primary', 1.0 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'exp_log_derivative_confusion' FROM new_question;

-- ============================================================
-- U2.7-P5
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U2.7-P5', 'Both', 'ABBC_Derivatives', '2.7', '2.7', 'MCQ', FALSE,
        4, 180, '{method_selection_derivatives,trig_derivatives_basic}', '{wrong_method_choice_derivative}', 'text',
        $txt$Which method is most efficient for finding the derivative of $f(x)=\sin x + e^x + \ln x$?$txt$,
        $txt$Which method is most efficient for finding the derivative of $f(x)=\sin x + e^x + \ln x$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "Use derivative rules for each term and apply linearity.", "type": "text", "explanation": "Correct. Known derivative rules + linearity is the quickest exact method."},
          {"id": "B", "label": "B", "value": "Use a table of values near a point and estimate slopes.", "type": "text", "explanation": "A table gives only an approximation and is slower."},
          {"id": "C", "label": "C", "value": "Graph the function and estimate the tangent slope.", "type": "text", "explanation": "A graph gives only an estimate and is unnecessary here."},
          {"id": "D", "label": "D", "value": "Use the limit definition of the derivative.", "type": "text", "explanation": "The limit definition works but is not efficient."}
        ]$txt$,
        'A',
        $txt$Since the function is a sum of basic functions with known derivative rules, applying those rules with linearity is fastest and exact.$txt$,
        '{method_selection_derivatives}',
        'published', 1, 4, 1.25, 'NewMaoS', 2026, '', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'method_selection_derivatives', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'trig_derivatives_basic', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'wrong_method_choice_derivative' FROM new_question;
