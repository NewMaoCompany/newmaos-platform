-- Insert Script for 6.8 (Finding Antiderivatives and Indefinite Integrals)
-- Unit: ABBC_Integration

-- 1. Clean up potential duplicates
DELETE FROM public.questions WHERE title IN (
    'U6.8-P1', 'U6.8-P2', 'U6.8-P3', 'U6.8-P4', 'U6.8-P5'
);

-- ============================================================
-- U6.8-P1
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U6.8-P1', 'Both', 'ABBC_Integration', '6.8', '6.8', 'MCQ', FALSE,
        2, 120, '{antiderivative_basic_rules}', '{power_rule_antiderivative_error}', 'text',
        $txt$Which expression is an antiderivative of $6x^5-4x+7$?$txt$,
        $txt$Which expression is an antiderivative of $6x^5-4x+7$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$x^6-2x^2+7x+C$", "type": "text", "explanation": "Correct: differentiating gives $6x^5-4x+7$."},
          {"id": "B", "label": "B", "value": "$x^6-2x^2+7+C$", "type": "text", "explanation": "Missing the $7x$ term from integrating the constant 7."},
          {"id": "C", "label": "C", "value": "$6x^6-2x^2+7x+C$", "type": "text", "explanation": "Incorrect power rule constant factor on $x^6$."},
          {"id": "D", "label": "D", "value": "$x^6-4x^2+7x+C$", "type": "text", "explanation": "Integrates $-4x$ incorrectly; should be $-2x^2$."}
        ]$txt$,
        'A',
        $txt$Integrate term-by-term: $\int 6x^5dx=x^6$, $\int -4xdx=-2x^2$, and $\int 7dx=7x$, plus $C$.$txt$,
        '{basic_antiderivative_polynomial}',
        'published', 1, 2, 1.05, 'NewMaoS', 2026, '', 0.9, 0.1, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'antiderivative_basic_rules', 'primary', 0.9 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'power_rule_antiderivative_error' FROM new_question;

-- ============================================================
-- U6.8-P2
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U6.8-P2', 'Both', 'ABBC_Integration', '6.8', '6.8', 'MCQ', FALSE,
        3, 150, '{antiderivative_basic_rules}', '{antiderivative_constant_missing}', 'text',
        $txt$If $\int f(x)\,dx=3x^2-5x+C$, which expression could equal $f(x)$?$txt$,
        $txt$If $\int f(x)\,dx=3x^2-5x+C$, which expression could equal $f(x)$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$6x-5$", "type": "text", "explanation": "Correct: derivative of the given antiderivative."},
          {"id": "B", "label": "B", "value": "$3x^2-5x$", "type": "text", "explanation": "That repeats the antiderivative, not the derivative."},
          {"id": "C", "label": "C", "value": "$6x-5+C$", "type": "text", "explanation": "$C$ disappears when differentiating; $f(x)$ does not include $+C$."},
          {"id": "D", "label": "D", "value": "$3x-5$", "type": "text", "explanation": "Incorrect derivative of $3x^2$."}
        ]$txt$,
        'A',
        $txt$Differentiate the antiderivative: $\frac{d}{dx}(3x^2-5x+C)=6x-5$.$txt$,
        '{differentiate_to_check_antiderivative}',
        'published', 1, 3, 1.15, 'NewMaoS', 2026, '', 0.9, 0.1, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'antiderivative_basic_rules', 'primary', 0.9 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'antiderivative_constant_missing' FROM new_question;

-- ============================================================
-- U6.8-P3
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U6.8-P3', 'Both', 'ABBC_Integration', '6.8', '6.8', 'MCQ', FALSE,
        3, 150, '{antiderivative_basic_rules}', '{power_rule_antiderivative_error}', 'text',
        $txt$Which is an antiderivative of $\frac{1}{x^2}$ for $x>0$?$txt$,
        $txt$Which is an antiderivative of $\frac{1}{x^2}$ for $x>0$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$-\\frac{1}{x}+C$", "type": "text", "explanation": "Correct: power rule with exponent -2."},
          {"id": "B", "label": "B", "value": "$\\ln x+C$", "type": "text", "explanation": "$\\ln x$ differentiates to $1/x$, not $1/x^2$."},
          {"id": "C", "label": "C", "value": "$\\frac{1}{x}+C$", "type": "text", "explanation": "Derivative of $1/x$ is $-1/x^2$."},
          {"id": "D", "label": "D", "value": "$-\\ln x+C$", "type": "text", "explanation": "Derivative of $-\\ln x$ is $-1/x$."}
        ]$txt$,
        'A',
        $txt$\frac{1}{x^2}=x^{-2}$. Integrate: $\int x^{-2}dx=\frac{x^{-1}}{-1}=-\frac{1}{x}+C$.$txt$,
        '{power_rule_negative_exponent}',
        'published', 1, 3, 1.15, 'NewMaoS', 2026, '', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'antiderivative_basic_rules', 'primary', 0.8 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'power_rule_antiderivative_error' FROM new_question;

-- ============================================================
-- U6.8-P4
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U6.8-P4', 'Both', 'ABBC_Integration', '6.8', '6.8', 'MCQ', FALSE,
        4, 180, '{indefinite_integral_notation,antiderivative_basic_rules}', '{antiderivative_constant_missing}', 'text',
        $txt$If $\int (2x+1)\,dx = x^2+x+C$, which statement is true?$txt$,
        $txt$If $\int (2x+1)\,dx = x^2+x+C$, which statement is true?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "The constant $C$ is always 0.", "type": "text", "explanation": "False: $C$ can be any real number."},
          {"id": "B", "label": "B", "value": "All antiderivatives differ by a constant.", "type": "text", "explanation": "Correct: that is the meaning of $+C$."},
          {"id": "C", "label": "C", "value": "There is exactly one antiderivative.", "type": "text", "explanation": "False: there are infinitely many, differing by a constant."},
          {"id": "D", "label": "D", "value": "$C$ must be 1 because of the +1 in the integrand.", "type": "text", "explanation": "False: the +1 in the integrand contributes an $x$ term, not a fixed constant."}
        ]$txt$,
        'B',
        $txt$Indefinite integrals represent a family of functions. Any two antiderivatives of the same integrand differ by a constant.$txt$,
        '{meaning_of_plus_C}',
        'published', 1, 4, 1.25, 'NewMaoS', 2026, '', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'indefinite_integral_notation', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'antiderivative_basic_rules', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'antiderivative_constant_missing' FROM new_question;

-- ============================================================
-- U6.8-P5
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U6.8-P5', 'Both', 'ABBC_Integration', '6.8', '6.8', 'MCQ', FALSE,
        4, 180, '{antiderivative_basic_rules}', '{power_rule_antiderivative_error}', 'text',
        $txt$Which expression is an antiderivative of $\left(5-\frac{2}{x}\right)$ for $x>0$?$txt$,
        $txt$Which expression is an antiderivative of $\left(5-\frac{2}{x}\right)$ for $x>0$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$5x-2\\ln x+C$", "type": "text", "explanation": "Correct: derivative is $5-2/x$."},
          {"id": "B", "label": "B", "value": "$5x-\\frac{2}{x}+C$", "type": "text", "explanation": "Integrates $-2/x$ incorrectly; it becomes a log term."},
          {"id": "C", "label": "C", "value": "$5-2\\ln x+C$", "type": "text", "explanation": "Missing the $x$ factor from integrating 5."},
          {"id": "D", "label": "D", "value": "$5x+2\\ln x+C$", "type": "text", "explanation": "Sign error: derivative would be $5+2/x$."}
        ]$txt$,
        'A',
        $txt$Integrate term-by-term: $\int 5dx=5x$ and $\int \frac{-2}{x}dx=-2\ln x$ (for $x>0$), plus $C$.$txt$,
        '{log_antiderivative_rule}',
        'published', 1, 4, 1.25, 'NewMaoS', 2026, '', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'antiderivative_basic_rules', 'primary', 0.8 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'power_rule_antiderivative_error' FROM new_question;
