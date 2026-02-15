-- Insert Script for Chapter 4.7 Questions (L’Hospital’s Rule)
-- Unit: ABBC_Applications / 4.7

-- 1. Clean up potential duplicates
DELETE FROM public.questions WHERE title IN ('U4.7-P1', 'U4.7-P2', 'U4.7-P3', 'U4.7-P4', 'U4.7-P5');

-- ============================================================
-- U4.7-P1
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U4.7-P1', 'Both', 'ABBC_Applications', '4.7', '4.7', 'MCQ', FALSE,
        3, 180, '{lhospital_identify_indeterminate,method_selection_unit4}', '{use_lhospital_wrong_form}', 'text',
        $txt$L’Hospital’s Rule is most directly applicable when a limit produces which type of indeterminate form?$txt$,
        $txt$L’Hospital’s Rule is most directly applicable when a limit produces which type of indeterminate form?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "A positive number divided by a positive number", "type": "text", "explanation": "That is a determinate form, not indeterminate."},
          {"id": "B", "label": "B", "value": "Zero divided by zero ($0/0$), or infinity divided by infinity ($\\infty/\\infty$)", "type": "text", "explanation": "Correct: the classic direct forms are $0/0$ and $\\infty/\\infty$."},
          {"id": "C", "label": "C", "value": "A negative number divided by a positive number", "type": "text", "explanation": "This is determinate if the denominator is nonzero."},
          {"id": "D", "label": "D", "value": "A positive number divided by zero", "type": "text", "explanation": "This typically diverges and is not an indeterminate form."}
        ]$txt$,
        'B',
        $txt$L’Hospital’s Rule applies most directly to the indeterminate forms $0/0$ and $\infty/\infty$ (under the required conditions).$txt$,
        '{lhospital_identify_indeterminate}',
        'published', 1, 3, 1.15, 'NewMaoS', 2026, '', 0.85, 0.15, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'lhospital_identify_indeterminate', 'primary', 0.85 FROM new_question
    UNION ALL
    SELECT id, 'method_selection_unit4', 'supporting', 0.15 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'use_lhospital_wrong_form' FROM new_question;

-- ============================================================
-- U4.7-P2
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U4.7-P2', 'Both', 'ABBC_Applications', '4.7', '4.7', 'MCQ', FALSE,
        4, 210, '{lhospital_apply_once,lhospital_identify_indeterminate}', '{differentiate_only_numerator}', 'text',
        $txt$Evaluate the limit as $x$ approaches $0$ of $\frac{\sin x}{x}$ using L’Hospital’s Rule.$txt$,
        $txt$Evaluate the limit as $x$ approaches $0$ of $\frac{\sin x}{x}$ using L’Hospital’s Rule.$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "0", "type": "text", "explanation": "That would match $\\sin(0)$, but not the ratio limit."},
          {"id": "B", "label": "B", "value": "1", "type": "text", "explanation": "Correct: the classic limit evaluates to $1$."},
          {"id": "C", "label": "C", "value": "Does not exist", "type": "text", "explanation": "This limit exists and equals a finite value."},
          {"id": "D", "label": "D", "value": "Infinity", "type": "text", "explanation": "The ratio does not diverge near $0$."}
        ]$txt$,
        'B',
        $txt$The expression gives $0/0$ at $x=0$. Differentiating numerator and denominator gives $(\cos x)/1$, which approaches $1$ as $x$ approaches $0$.$txt$,
        '{lhospital_apply_once}',
        'published', 1, 4, 1.25, 'NewMaoS', 2026, '', 0.85, 0.15, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'lhospital_apply_once', 'primary', 0.85 FROM new_question
    UNION ALL
    SELECT id, 'lhospital_identify_indeterminate', 'supporting', 0.15 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'differentiate_only_numerator' FROM new_question;

-- ============================================================
-- U4.7-P3
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U4.7-P3', 'Both', 'ABBC_Applications', '4.7', '4.7', 'MCQ', FALSE,
        5, 270, '{lhospital_repeat_application,method_selection_unit4}', '{stop_too_early_lhospital}', 'text',
        $txt$Evaluate the limit as $x$ approaches $0$ of $\frac{1 - \cos x}{x^2}$ using L’Hospital’s Rule.$txt$,
        $txt$Evaluate the limit as $x$ approaches $0$ of $\frac{1 - \cos x}{x^2}$ using L’Hospital’s Rule.$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "0", "type": "text", "explanation": "If you stop too early, you may incorrectly conclude $0$."},
          {"id": "B", "label": "B", "value": "1/2", "type": "text", "explanation": "Correct: repeated differentiation leads to $1/2$."},
          {"id": "C", "label": "C", "value": "1", "type": "text", "explanation": "Too large; not the correct limiting constant."},
          {"id": "D", "label": "D", "value": "2", "type": "text", "explanation": "Far too large; inconsistent with small-angle behavior."}
        ]$txt$,
        'B',
        $txt$This produces $0/0$ at $x=0$. Applying L’Hospital’s Rule more than once resolves the indeterminate form and gives a finite constant limit of $1/2$.$txt$,
        '{lhospital_repeat_application}',
        'published', 1, 5, 1.35, 'NewMaoS', 2026, '', 0.85, 0.15, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'lhospital_repeat_application', 'primary', 0.85 FROM new_question
    UNION ALL
    SELECT id, 'method_selection_unit4', 'supporting', 0.15 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'stop_too_early_lhospital' FROM new_question;

-- ============================================================
-- U4.7-P4
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U4.7-P4', 'Both', 'ABBC_Applications', '4.7', '4.7', 'MCQ', FALSE,
        4, 240, '{lhospital_rewrite_form,lhospital_identify_indeterminate}', '{rewrite_indeterminate_wrong}', 'text',
        $txt$Which expression is already in a form where L’Hospital’s Rule can be applied directly (assuming conditions are satisfied)?$txt$,
        $txt$Which expression is already in a form where L’Hospital’s Rule can be applied directly (assuming conditions are satisfied)?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$(x^2 + 1) / (x + 1)$ as $x$ approaches $1$", "type": "text", "explanation": "This is determinate, not $0/0$ or $\\infty/\\infty$."},
          {"id": "B", "label": "B", "value": "$(x - 2) / (x^2 - 4)$ as $x$ approaches $2$", "type": "text", "explanation": "Correct: it produces $0/0$ at the limit point."},
          {"id": "C", "label": "C", "value": "$(x^2 - 4) / (x - 2)$ as $x$ approaches $2$", "type": "text", "explanation": "This simplifies to a finite value without needing L’Hospital."},
          {"id": "D", "label": "D", "value": "$(x^2 + 4) / (x - 2)$ as $x$ approaches $2$", "type": "text", "explanation": "This tends to $\\pm\\infty$, not an indeterminate form."}
        ]$txt$,
        'B',
        $txt$At $x=2$, choice B gives $0/0$, which is a direct indeterminate form for L’Hospital’s Rule. The others are not directly indeterminate or do not produce $0/0$ or $\infty/\infty$.$txt$,
        '{lhospital_rewrite_form}',
        'published', 1, 4, 1.25, 'NewMaoS', 2026, '', 0.85, 0.15, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'lhospital_rewrite_form', 'primary', 0.85 FROM new_question
    UNION ALL
    SELECT id, 'lhospital_identify_indeterminate', 'supporting', 0.15 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'rewrite_indeterminate_wrong' FROM new_question;

-- ============================================================
-- U4.7-P5
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U4.7-P5', 'Both', 'ABBC_Applications', '4.7', '4.7', 'MCQ', FALSE,
        5, 300, '{lhospital_strategy_choice,method_selection_unit4}', '{use_lhospital_when_algebra_easier}', 'text',
        $txt$A limit problem can be solved either by algebraic simplification or by L’Hospital’s Rule. Which statement best describes a good strategy choice on the AP exam?$txt$,
        $txt$A limit problem can be solved either by algebraic simplification or by L’Hospital’s Rule. Which statement best describes a good strategy choice on the AP exam?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "Always use L’Hospital’s Rule because it is faster in all cases.", "type": "text", "explanation": "Not always fastest; may require repeated differentiation."},
          {"id": "B", "label": "B", "value": "Always avoid L’Hospital’s Rule because it is never allowed.", "type": "text", "explanation": "It can be allowed in appropriate contexts, so this is false."},
          {"id": "C", "label": "C", "value": "Choose the simplest correct method; algebraic simplification is often quicker when it works cleanly.", "type": "text", "explanation": "Correct: select the simplest valid method."},
          {"id": "D", "label": "D", "value": "Use L’Hospital’s Rule before checking whether the form is indeterminate.", "type": "text", "explanation": "You must confirm an indeterminate form before using L’Hospital."}
        ]$txt$,
        'C',
        $txt$On the AP exam, the best approach is the simplest correct method. If factoring/canceling resolves the limit quickly, it is often the most efficient choice.$txt$,
        '{lhospital_strategy_choice}',
        'published', 1, 5, 1.4, 'NewMaoS', 2026, '', 0.85, 0.15, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'lhospital_strategy_choice', 'primary', 0.85 FROM new_question
    UNION ALL
    SELECT id, 'method_selection_unit4', 'supporting', 0.15 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'use_lhospital_when_algebra_easier' FROM new_question;
