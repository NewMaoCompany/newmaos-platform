-- Insert Script for Unit 3.2 Questions (Implicit Differentiation)
-- Unit: Unit3_Composite_Implicit_Inverse / 3.2

-- 1. Clean up potential duplicates
DELETE FROM public.questions WHERE title IN ('U3.2-P1', 'U3.2-P2', 'U3.2-P3', 'U3.2-P4', 'U3.2-P5');

-- ============================================================
-- U3.2-P1
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U3.2-P1', 'Both', 'ABBC_Composite', '3.2', '3.2', 'MCQ', FALSE,
        3, 150, '{implicit_diff_basic}', '{implicit_diff_forget_dydx}', 'text',
        $txt$If $x^2+y^2=25$, find $\frac{dy}{dx}$.$txt$,
        $txt$If $x^2+y^2=25$, find $\frac{dy}{dx}$.$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$\\frac{dy}{dx}=\\frac{x}{y}$", "type": "text", "explanation": "The sign is incorrect after moving terms to isolate $dy/dx$."},
          {"id": "B", "label": "B", "value": "$\\frac{dy}{dx}=-\\frac{x}{y}$", "type": "text", "explanation": "Correct: $2x+2y(dy/dx)=0 \\Rightarrow dy/dx=-x/y$."},
          {"id": "C", "label": "C", "value": "$\\frac{dy}{dx}=\\frac{y}{x}$", "type": "text", "explanation": "This swaps numerator and denominator incorrectly."},
          {"id": "D", "label": "D", "value": "$\\frac{dy}{dx}=-\\frac{y}{x}$", "type": "text", "explanation": "This swaps the fraction and changes the sign incorrectly."}
        ]$txt$,
        'B',
        $txt$Differentiate both sides with respect to $x$, remembering that $y$ depends on $x$.$txt$,
        '{implicit_diff_basic}',
        'published', 1, 3, 1.1, 'NewMaoS', 2026, '', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'implicit_diff_basic', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'algebraic_simplification_unit3', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'implicit_diff_forget_dydx' FROM new_question;

-- ============================================================
-- U3.2-P2
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U3.2-P2', 'Both', 'ABBC_Composite', '3.2', '3.2', 'MCQ', FALSE,
        4, 180, '{implicit_diff_at_point}', '{implicit_diff_point_sub_error}', 'text',
        $txt$If $x^2+xy+y^2=7$, what is $\frac{dy}{dx}$ at the point $(1,2)$?$txt$,
        $txt$If $x^2+xy+y^2=7$, what is $\frac{dy}{dx}$ at the point $(1,2)$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$-\\frac{4}{5}$", "type": "text", "explanation": "Correct: after implicit differentiation, substitute $(1,2)$ and solve for $dy/dx$."},
          {"id": "B", "label": "B", "value": "$\\frac{4}{5}$", "type": "text", "explanation": "This misses the negative sign from moving terms."},
          {"id": "C", "label": "C", "value": "$-\\frac{5}{4}$", "type": "text", "explanation": "This is the reciprocal of the correct answer."},
          {"id": "D", "label": "D", "value": "$\\frac{5}{4}$", "type": "text", "explanation": "This has both the reciprocal and the sign wrong."}
        ]$txt$,
        'A',
        $txt$Differentiate implicitly first, then substitute the point to evaluate the slope.$txt$,
        '{implicit_diff_at_point}',
        'published', 1, 4, 1.25, 'NewMaoS', 2026, '', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'implicit_diff_at_point', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'implicit_diff_basic', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'implicit_diff_point_sub_error' FROM new_question;

-- ============================================================
-- U3.2-P3
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U3.2-P3', 'Both', 'ABBC_Composite', '3.2', '3.2', 'MCQ', FALSE,
        4, 180, '{implicit_diff_product_quotient}', '{implicit_diff_wrong_product_rule}', 'text',
        $txt$Given $xy=x+y$, find $\frac{dy}{dx}$.$txt$,
        $txt$Given $xy=x+y$, find $\frac{dy}{dx}$.$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$\\frac{1-y}{x-1}$", "type": "text", "explanation": "Correct: $x(dy/dx)+y=1+(dy/dx)$ so $(x-1)dy/dx=1-y$."},
          {"id": "B", "label": "B", "value": "$\\frac{y-1}{x-1}$", "type": "text", "explanation": "This flips the sign in the numerator."},
          {"id": "C", "label": "C", "value": "$\\frac{1+y}{x+1}$", "type": "text", "explanation": "This comes from differentiating as if it were a quotient or from incorrect algebra."},
          {"id": "D", "label": "D", "value": "$\\frac{y-1}{1-x}$", "type": "text", "explanation": "This is algebraically equivalent to choice B, not the correct result."}
        ]$txt$,
        'A',
        $txt$Differentiate the product $xy$ correctly using product rule, then solve for $dy/dx$.$txt$,
        '{implicit_diff_product_quotient}',
        'published', 1, 4, 1.25, 'NewMaoS', 2026, '', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'implicit_diff_product_quotient', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'implicit_diff_basic', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'implicit_diff_wrong_product_rule' FROM new_question;

-- ============================================================
-- U3.2-P4
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U3.2-P4', 'Both', 'ABBC_Composite', '3.2', '3.2', 'MCQ', FALSE,
        3, 150, '{implicit_diff_basic}', '{implicit_diff_not_isolated}', 'text',
        $txt$If $3x^2+2y=xy$, find $\frac{dy}{dx}$.$txt$,
        $txt$If $3x^2+2y=xy$, find $\frac{dy}{dx}$.$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$\\frac{y-6x}{2-x}$", "type": "text", "explanation": "Correct: $6x+2(dy/dx)=x(dy/dx)+y$ leading to $(2-x)dy/dx=y-6x$."},
          {"id": "B", "label": "B", "value": "$\\frac{6x-y}{2-x}$", "type": "text", "explanation": "This has the numerator sign reversed."},
          {"id": "C", "label": "C", "value": "$\\frac{y-6x}{x-2}$", "type": "text", "explanation": "This is equivalent to choice B after multiplying top/bottom by -1."},
          {"id": "D", "label": "D", "value": "$\\frac{6x-y}{x-2}$", "type": "text", "explanation": "This matches the wrong sign pattern from incorrect rearranging."}
        ]$txt$,
        'A',
        $txt$Differentiate both sides and solve for $dy/dx$ by collecting all $dy/dx$ terms together.$txt$,
        '{implicit_diff_basic}',
        'published', 1, 3, 1.1, 'NewMaoS', 2026, '', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'implicit_diff_basic', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'algebraic_simplification_unit3', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'implicit_diff_not_isolated' FROM new_question;

-- ============================================================
-- U3.2-P5
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U3.2-P5', 'Both', 'ABBC_Composite', '3.2', '3.2', 'MCQ', FALSE,
        2, 90, '{method_selection_unit3}', '{method_choice_wrong_unit3}', 'text',
        $txt$Which method is most appropriate to find $\frac{dy}{dx}$ if $y=\frac{x^2+1}{x-1}$?$txt$,
        $txt$Which method is most appropriate to find $\frac{dy}{dx}$ if $y=\frac{x^2+1}{x-1}$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "Implicit differentiation", "type": "text", "explanation": "Implicit differentiation is unnecessary because the function is already solved for $y$."},
          {"id": "B", "label": "B", "value": "Derivative of an inverse function", "type": "text", "explanation": "There is no inverse-function information requested here."},
          {"id": "C", "label": "C", "value": "Quotient rule (or rewrite then differentiate)", "type": "text", "explanation": "Correct: quotient rule (or equivalent simplification approach) is the natural method."},
          {"id": "D", "label": "D", "value": "Higher-order differentiation", "type": "text", "explanation": "Higher-order differentiation applies only after finding the first derivative."}
        ]$txt$,
        'C',
        $txt$The equation already gives $y$ explicitly as a function of $x$, so standard derivative rules apply directly.$txt$,
        '{method_selection_unit3}',
        'published', 1, 2, 0.95, 'NewMaoS', 2026, '', 1.0, 0.0, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'method_selection_unit3', 'primary', 1.0 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'method_choice_wrong_unit3' FROM new_question;
