-- Insert Script for Chapter 1.5 Questions (Determining Limits Using Algebraic Properties of Limits)
-- Unit: Both_Limits / 1.5

-- 1. Clean up potential duplicates
DELETE FROM public.questions WHERE title IN ('1.5-P1', '1.5-P2', '1.5-P3', '1.5-P4', '1.5-P5');

-- ============================================================
-- 1.5-P1
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        '1.5-P1', 'Both', 'Both_Limits', '1.5', '1.5', 'MCQ', FALSE,
        1, 120, '{limit_laws,limit_notation}', '{notation_misread}', 'text',
        $txt$Given $\lim_{x\to 2} f(x)=3$ and $\lim_{x\to 2} g(x)=-1$, find $\lim_{x\to 2} \left(f(x)+g(x)\right)$.$txt$,
        $txt$Given $\lim_{x\to 2} f(x)=3$ and $\lim_{x\to 2} g(x)=-1$, find $\lim_{x\to 2} \left(f(x)+g(x)\right)$.$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$-3$", "type": "text", "explanation": "This comes from multiplying instead of adding."},
          {"id": "B", "label": "B", "value": "2", "type": "text", "explanation": "Correct: sum of the limits is $3+(-1)=2$."},
          {"id": "C", "label": "C", "value": "3", "type": "text", "explanation": "This ignores the contribution of $g(x)$."},
          {"id": "D", "label": "D", "value": "$-1$", "type": "text", "explanation": "This incorrectly states the limit equals $\\lim g(x)$."}
        ]$txt$,
        'B',
        $txt$By the sum law, $\lim_{x\to 2}(f(x)+g(x))=\lim_{x\to 2}f(x)+\lim_{x\to 2}g(x)=3+(-1)=2$.$txt$,
        '{limit_laws}',
        'published', 1, 1, 0.9, 'NewMaoS', 2026, 'Target time: 2 minutes.', 0.9, 0.1, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'limit_laws', 'primary', 0.9 FROM new_question
    UNION ALL
    SELECT id, 'limit_notation', 'supporting', 0.1 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'notation_misread' FROM new_question;


-- ============================================================
-- 1.5-P2
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        '1.5-P2', 'Both', 'Both_Limits', '1.5', '1.5', 'MCQ', FALSE,
        2, 180, '{limit_laws,method_selection}', '{wrong_method_choice}', 'text',
        $txt$Evaluate $\lim_{x\to 3} (2x^2-5x+1)$.$txt$,
        $txt$Evaluate $\lim_{x\to 3} (2x^2-5x+1)$.$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "4", "type": "text", "explanation": "Correct: direct substitution gives 4."},
          {"id": "B", "label": "B", "value": "7", "type": "text", "explanation": "This results from an arithmetic error."},
          {"id": "C", "label": "C", "value": "10", "type": "text", "explanation": "This often comes from forgetting the $-5x$ term sign."},
          {"id": "D", "label": "D", "value": "DNE", "type": "text", "explanation": "The limit exists because polynomials are continuous."}
        ]$txt$,
        'A',
        $txt$Polynomials are continuous, so substitute $x=3$: $2(3)^2-5(3)+1=18-15+1=4$.$txt$,
        '{limit_laws}',
        'published', 1, 2, 1.0, 'NewMaoS', 2026, 'Target time: 3 minutes.', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'limit_laws', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'method_selection', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'wrong_method_choice' FROM new_question;


-- ============================================================
-- 1.5-P3
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        '1.5-P3', 'Both', 'Both_Limits', '1.5', '1.5', 'MCQ', FALSE,
        3, 240, '{limit_laws,limit_concept}', '{quotient_law_denominator_zero}', 'text',
        $txt$Given $\lim_{x\to 1} f(x)=2$ and $\lim_{x\to 1} g(x)=0$, which statement must be true?$txt$,
        $txt$Given $\lim_{x\to 1} f(x)=2$ and $\lim_{x\to 1} g(x)=0$, which statement must be true?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$\\lim_{x\\to 1} \\frac{f(x)}{g(x)}=0$", "type": "text", "explanation": "A denominator approaching 0 does not force the quotient to approach 0."},
          {"id": "B", "label": "B", "value": "$\\lim_{x\\to 1} \\frac{f(x)}{g(x)}=\\infty$", "type": "text", "explanation": "The quotient could blow up, but it could also approach a finite value depending on rates."},
          {"id": "C", "label": "C", "value": "$\\lim_{x\\to 1} \\frac{f(x)}{g(x)}$ cannot be determined from the given information", "type": "text", "explanation": "Correct: the limit cannot be concluded without more information."},
          {"id": "D", "label": "D", "value": "$\\lim_{x\\to 1} \\frac{f(x)}{g(x)}=2$", "type": "text", "explanation": "2 would be true only if $g(x)\\to 1$, not 0."}
        ]$txt$,
        'C',
        $txt$The quotient law requires $\lim_{x\to 1} g(x)\ne 0$. Since the denominator limit is 0, the quotient limit cannot be determined from the given information alone.$txt$,
        '{limit_laws}',
        'published', 1, 3, 1.15, 'NewMaoS', 2026, 'Target time: 4 minutes.', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'limit_laws', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'limit_concept', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'quotient_law_denominator_zero' FROM new_question;


-- ============================================================
-- 1.5-P4
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        '1.5-P4', 'Both', 'Both_Limits', '1.5', '1.5', 'MCQ', FALSE,
        3, 240, '{limit_laws,limit_notation}', '{limit_vs_value}', 'text',
        $txt$If $\lim_{x\to a} f(x)=4$, what is $\lim_{x\to a} \left(3f(x)-7\right)$?$txt$,
        $txt$If $\lim_{x\to a} f(x)=4$, what is $\lim_{x\to a} \left(3f(x)-7\right)$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "5", "type": "text", "explanation": "Correct: $3(4)-7=5$."},
          {"id": "B", "label": "B", "value": "12", "type": "text", "explanation": "This forgets to subtract 7 after multiplying by 3."},
          {"id": "C", "label": "C", "value": "$-7$", "type": "text", "explanation": "This incorrectly drops the $3f(x)$ term."},
          {"id": "D", "label": "D", "value": "DNE", "type": "text", "explanation": "Linear combinations preserve limits, so it exists."}
        ]$txt$,
        'A',
        $txt$Use limit laws: $\lim(3f(x)-7)=3\lim f(x)-7=3\cdot 4-7=5$.$txt$,
        '{limit_laws}',
        'published', 1, 3, 1.15, 'NewMaoS', 2026, 'Target time: 4 minutes.', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'limit_laws', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'limit_notation', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'limit_vs_value' FROM new_question;


-- ============================================================
-- 1.5-P5
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        '1.5-P5', 'Both', 'Both_Limits', '1.5', '1.5', 'MCQ', FALSE,
        4, 300, '{limit_laws,method_selection}', '{illegal_substitution_0over0}', 'text',
        $txt$Evaluate $\lim_{x\to 2} \frac{(x^2-4)}{(x-2)}$.$txt$,
        $txt$Evaluate $\lim_{x\to 2} \frac{(x^2-4)}{(x-2)}$.$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "0", "type": "text", "explanation": "0 comes from stopping at $0/0$ or claiming the limit is 0."},
          {"id": "B", "label": "B", "value": "2", "type": "text", "explanation": "This is a common arithmetic slip after simplification."},
          {"id": "C", "label": "C", "value": "4", "type": "text", "explanation": "Correct: simplify to $x+2$ then substitute $x=2$ to get 4."},
          {"id": "D", "label": "D", "value": "DNE", "type": "text", "explanation": "The limit exists after algebraic simplification."}
        ]$txt$,
        'C',
        $txt$Direct substitution gives $0/0$, so factor: $x^2-4=(x-2)(x+2)$. Then the expression simplifies to $x+2$, so the limit is $2+2=4$.$txt$,
        '{limit_laws}',
        'published', 1, 4, 1.3, 'NewMaoS', 2026, 'Target time: 5 minutes.', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'limit_laws', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'method_selection', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'illegal_substitution_0over0' FROM new_question;
