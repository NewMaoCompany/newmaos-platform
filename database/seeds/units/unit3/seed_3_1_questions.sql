-- Insert Script for Unit 3.1 Questions (Chain Rule)
-- Unit: Unit3_Composite_Implicit_Inverse / 3.1

-- 1. Clean up potential duplicates
DELETE FROM public.questions WHERE title IN ('U3.1-P1', 'U3.1-P2', 'U3.1-P3', 'U3.1-P4', 'U3.1-P5');

-- ============================================================
-- U3.1-P1
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U3.1-P1', 'Both', 'ABBC_Composite', '3.1', '3.1', 'MCQ', FALSE,
        2, 90, '{chain_rule_basic}', '{chain_rule_missing_inner}', 'text',
        $txt$Find the derivative of $f(x)=(3x-2)^5$.$txt$,
        $txt$Find the derivative of $f(x)=(3x-2)^5$.$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$5(3x-2)^4$", "type": "text", "explanation": "This forgets to multiply by the derivative of the inside, which is 3."},
          {"id": "B", "label": "B", "value": "$15(3x-2)^4$", "type": "text", "explanation": "Correct: outer derivative gives $5(3x-2)^4$ and inside derivative adds a factor of 3."},
          {"id": "C", "label": "C", "value": "$15(3x-2)^5$", "type": "text", "explanation": "The power should decrease by 1 after differentiating; it should not stay at 5."},
          {"id": "D", "label": "D", "value": "$(3x-2)^4$", "type": "text", "explanation": "This is missing the factor 5 and the inside derivative factor 3."}
        ]$txt$,
        'B',
        $txt$Use the chain rule: differentiate the outer power and multiply by the derivative of the inside linear expression.$txt$,
        '{chain_rule_basic}',
        'published', 1, 2, 1.0, 'NewMaoS', 2026, '', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'chain_rule_basic', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'algebraic_simplification_unit3', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'chain_rule_missing_inner' FROM new_question;

-- ============================================================
-- U3.1-P2
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U3.1-P2', 'Both', 'ABBC_Composite', '3.1', '3.1', 'MCQ', FALSE,
        4, 180, '{chain_rule_multi_layer}', '{chain_rule_wrong_layers}', 'text',
        $txt$Find the derivative of $y=\sin\left((x^2+1)^3\right)$.$txt$,
        $txt$Find the derivative of $y=\sin\left((x^2+1)^3\right)$.$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$\\cos\\left((x^2+1)^3\\right)$", "type": "text", "explanation": "This differentiates $\\sin$ but ignores the derivative of the inside composite expression."},
          {"id": "B", "label": "B", "value": "$3(x^2+1)^2\\cos\\left((x^2+1)^3\\right)$", "type": "text", "explanation": "This ignores the derivative of $x^2+1$, which contributes a factor of $2x$."},
          {"id": "C", "label": "C", "value": "$6x(x^2+1)^2\\cos\\left((x^2+1)^3\\right)$", "type": "text", "explanation": "Correct: outer derivative gives cosine, then multiply by derivative of $(x^2+1)^3$, then multiply by derivative of $x^2+1$."},
          {"id": "D", "label": "D", "value": "$6x(x^2+1)^2\\sin\\left((x^2+1)^3\\right)$", "type": "text", "explanation": "The derivative of $\\sin$ is $\\cos$, not $\\sin$."}
        ]$txt$,
        'C',
        $txt$This is a multi-layer chain rule problem: differentiate sine to cosine, then differentiate the inside step-by-step.$txt$,
        '{chain_rule_multi_layer}',
        'published', 1, 4, 1.25, 'NewMaoS', 2026, '', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'chain_rule_multi_layer', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'chain_rule_with_trig_exp_log', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'chain_rule_wrong_layers' FROM new_question;

-- ============================================================
-- U3.1-P3
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U3.1-P3', 'Both', 'ABBC_Composite', '3.1', '3.1', 'MCQ', FALSE,
        3, 120, '{chain_rule_with_trig_exp_log}', '{chain_rule_missing_inner}', 'text',
        $txt$Find the derivative of $g(x)=\ln(5x^2-1)$.$txt$,
        $txt$Find the derivative of $g(x)=\ln(5x^2-1)$.$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$\\frac{1}{5x^2-1}$", "type": "text", "explanation": "This forgets the inside derivative factor $10x$."},
          {"id": "B", "label": "B", "value": "$\\frac{10x}{5x^2-1}$", "type": "text", "explanation": "Correct: $u'/u$ with $u=5x^2-1$."},
          {"id": "C", "label": "C", "value": "$\\frac{5x^2-1}{10x}$", "type": "text", "explanation": "This incorrectly flips the fraction."},
          {"id": "D", "label": "D", "value": "$\\frac{10}{5x^2-1}$", "type": "text", "explanation": "This misses the factor of $x$ from differentiating $x^2$."}
        ]$txt$,
        'B',
        $txt$For $\ln(u)$, the derivative is $u'/u$. Here $u=5x^2-1$ so $u'=10x$.$txt$,
        '{chain_rule_with_trig_exp_log}',
        'published', 1, 3, 1.1, 'NewMaoS', 2026, '', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'chain_rule_with_trig_exp_log', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'algebraic_simplification_unit3', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'chain_rule_missing_inner' FROM new_question;

-- ============================================================
-- U3.1-P4
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U3.1-P4', 'Both', 'ABBC_Composite', '3.1', '3.1', 'MCQ', FALSE,
        2, 90, '{chain_rule_basic}', '{chain_rule_algebra_slip}', 'text',
        $txt$Let $f(x)=(2x+1)^4$. What is $f'(0)$?$txt$,
        $txt$Let $f(x)=(2x+1)^4$. What is $f'(0)$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "4", "type": "text", "explanation": "This is missing the inside derivative factor 2."},
          {"id": "B", "label": "B", "value": "8", "type": "text", "explanation": "Correct: $f'(x)=8(2x+1)^3$, so $f'(0)=8."},
          {"id": "C", "label": "C", "value": "16", "type": "text", "explanation": "This overcounts the chain rule factor or mis-evaluates the power."},
          {"id": "D", "label": "D", "value": "32", "type": "text", "explanation": "This is likely multiplying by 4 again after already applying chain rule."}
        ]$txt$,
        'B',
        $txt$Differentiate using chain rule, then substitute $x=0$ carefully.$txt$,
        '{chain_rule_basic}',
        'published', 1, 2, 0.95, 'NewMaoS', 2026, '', 1.0, 0.0, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'chain_rule_basic', 'primary', 1.0 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'chain_rule_algebra_slip' FROM new_question;

-- ============================================================
-- U3.1-P5
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U3.1-P5', 'Both', 'ABBC_Composite', '3.1', '3.1', 'MCQ', FALSE,
        3, 120, '{method_selection_unit3}', '{method_choice_wrong_unit3}', 'text',
        $txt$Find the derivative of $h(x)=\sqrt{x^2+1}$.$txt$,
        $txt$Find the derivative of $h(x)=\sqrt{x^2+1}$.$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$\\frac{1}{2\\sqrt{x^2+1}}$", "type": "text", "explanation": "This differentiates the outside but ignores the derivative of the inside $x^2+1$."},
          {"id": "B", "label": "B", "value": "$\\frac{x}{\\sqrt{x^2+1}}$", "type": "text", "explanation": "Correct: outer gives $\\frac{1}{2}(x^2+1)^{-1/2}$ and inner gives $2x$."},
          {"id": "C", "label": "C", "value": "$\\frac{2x}{\\sqrt{x^2+1}}$", "type": "text", "explanation": "This doubles the result; the factor 2 should cancel with the outer $1/2$."},
          {"id": "D", "label": "D", "value": "$\\sqrt{x^2+1}$", "type": "text", "explanation": "This is the original function, not its derivative."}
        ]$txt$,
        'B',
        $txt$Rewrite as $(x^2+1)^{1/2}$ and apply the chain rule: outer derivative times inner derivative.$txt$,
        '{method_selection_unit3}',
        'published', 1, 3, 1.1, 'NewMaoS', 2026, '', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'method_selection_unit3', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'chain_rule_basic', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'method_choice_wrong_unit3' FROM new_question;
