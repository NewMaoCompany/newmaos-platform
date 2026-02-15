-- Insert Script for 6.5 (Interpreting Behavior of Accumulation Functions)
-- Unit: ABBC_Integration

-- 1. Clean up potential duplicates
DELETE FROM public.questions WHERE title IN (
    'U6.5-P1', 'U6.5-P2', 'U6.5-P3', 'U6.5-P4', 'U6.5-P5'
);

-- ============================================================
-- U6.5-P1
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U6.5-P1', 'Both', 'ABBC_Integration', '6.5', '6.5', 'MCQ', FALSE,
        3, 150, '{accumulation_behavior_analysis,accumulation_function_behavior}', '{accumulation_behavior_misread}', 'text',
        $txt$Let $A(x)=\int_0^x f(t)\,dt$. The graph of $f$ is shown in the figure. At which $x$ does $A$ have a relative maximum?$txt$,
        $txt$Let $A(x)=\int_0^x f(t)\,dt$. The graph of $f$ is shown. At which $x$ does $A$ have a relative maximum?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$2$", "type": "text", "explanation": "At $x=2$, $f(x)$ is still positive, so $A$ is still increasing there."},
          {"id": "B", "label": "B", "value": "$\\frac{5}{2}$", "type": "text", "explanation": "Correct: $f$ crosses from positive to negative at $x=\\frac{5}{2}$."},
          {"id": "C", "label": "C", "value": "$\\frac{14}{3}$", "type": "text", "explanation": "That is where $f$ crosses from negative to positive, giving a relative minimum of $A$."},
          {"id": "D", "label": "D", "value": "$5$", "type": "text", "explanation": "At $x=5$, $f(x)$ is positive again; $A$ is increasing, not at a max."}
        ]$txt$,
        'B',
        $txt$$A'(x)=f(x)$. A relative maximum of $A$ occurs where $f$ changes from positive to negative, which happens at $x=\frac{5}{2}$.$txt$,
        '{accumulation_function_behavior}',
        'published', 1, 3, 1.2, 'NewMaoS', 2026, 'Graph required (U6_6.5-P2_graph.png).', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'accumulation_behavior_analysis', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'accumulation_function_behavior', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'accumulation_behavior_misread' FROM new_question;

-- ============================================================
-- U6.5-P2
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U6.5-P2', 'Both', 'ABBC_Integration', '6.5', '6.5', 'MCQ', FALSE,
        3, 150, '{accumulation_behavior_analysis}', '{accumulation_behavior_misread}', 'text',
        $txt$Let $A(x)=\int_0^x f(t)\,dt$. Using the graph of $f$, on which interval is $A$ decreasing?$txt$,
        $txt$Let $A(x)=\int_0^x f(t)\,dt$. Using the graph of $f$, on which interval is $A$ decreasing?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$(0,\\frac{5}{2})$", "type": "text", "explanation": "On this interval $f>0$, so $A$ is increasing."},
          {"id": "B", "label": "B", "value": "$(\\frac{5}{2},\\frac{14}{3})$", "type": "text", "explanation": "Correct: $f<0$ throughout, so $A$ decreases."},
          {"id": "C", "label": "C", "value": "$(\\frac{14}{3},6)$", "type": "text", "explanation": "Here $f>0$ again, so $A$ increases."},
          {"id": "D", "label": "D", "value": "$(0,6)$", "type": "text", "explanation": "$A$ does not decrease on the whole interval because $f$ changes sign."}
        ]$txt$,
        'B',
        $txt$$A'(x)=f(x)$. $A$ is decreasing exactly where $f(x)<0$, which is from $x=\frac{5}{2}$ to $x=\frac{14}{3}$.$txt$,
        '{accumulation_function_behavior}',
        'published', 1, 3, 1.2, 'NewMaoS', 2026, 'Graph required (U6_6.5-P2_graph.png).', 0.9, 0.1, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'accumulation_behavior_analysis', 'primary', 0.9 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'accumulation_behavior_misread' FROM new_question;

-- ============================================================
-- U6.5-P3
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U6.5-P3', 'Both', 'ABBC_Integration', '6.5', '6.5', 'MCQ', FALSE,
        2, 120, '{accumulation_behavior_analysis}', '{accumulation_behavior_misread}', 'text',
        $txt$Let $A(x)=\int_0^x f(t)\,dt$. The graph of $A$ is shown in the figure. What is the sign of $f(3)$?$txt$,
        $txt$Let $A(x)=\int_0^x f(t)\,dt$. The graph of $A$ is shown. What is the sign of $f(3)$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$f(3)>0$", "type": "text", "explanation": "That would require $A$ to be increasing at $x=3$."},
          {"id": "B", "label": "B", "value": "$f(3)<0$", "type": "text", "explanation": "Correct: $A$ is decreasing at $x=3$, so $A'(3)<0$ and $f(3)<0$."},
          {"id": "C", "label": "C", "value": "$f(3)=0$", "type": "text", "explanation": "That would require the tangent slope of $A$ to be 0 at $x=3$."},
          {"id": "D", "label": "D", "value": "Cannot be determined", "type": "text", "explanation": "It can be determined from the slope of $A$."}
        ]$txt$,
        'B',
        $txt$Since $A'(x)=f(x)$, the sign of $f(3)$ matches the slope of the graph of $A$ at $x=3$. The graph is decreasing at $x=3$, so the slope is negative.$txt$,
        '{accumulation_function_behavior}',
        'published', 1, 2, 1.1, 'NewMaoS', 2026, 'Graph required (U6_6.5-P4_graph.png).', 0.9, 0.1, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'accumulation_behavior_analysis', 'primary', 0.9 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'accumulation_behavior_misread' FROM new_question;

-- ============================================================
-- U6.5-P4
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U6.5-P4', 'Both', 'ABBC_Integration', '6.5', '6.5', 'MCQ', FALSE,
        3, 150, '{net_change_from_integral,accumulation_function_behavior}', '{accumulation_vs_value_confusion}', 'text',
        $txt$Let $A(x)=\int_0^x f(t)\,dt$. Using the graph of $A$, approximate $\int_0^6 f(t)\,dt$.$txt$,
        $txt$Let $A(x)=\int_0^x f(t)\,dt$. Using the graph of $A$, approximate $\int_0^6 f(t)\,dt$.$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$3$", "type": "text", "explanation": "Too low compared with the endpoint value of $A$ at $x=6$."},
          {"id": "B", "label": "B", "value": "$4$", "type": "text", "explanation": "Correct: $A(6)$ is about 4."},
          {"id": "C", "label": "C", "value": "$5$", "type": "text", "explanation": "Too high; the graph at $x=6$ is not near 5."},
          {"id": "D", "label": "D", "value": "$6$", "type": "text", "explanation": "Too high; the graph at $x=6$ is not near 6."}
        ]$txt$,
        'B',
        $txt$$A(6)=\int_0^6 f(t)\,dt$. Read $A(6)$ from the graph; it is approximately 4.$txt$,
        '{net_change_from_integral}',
        'published', 1, 3, 1.2, 'NewMaoS', 2026, 'Graph required (U6_6.5-P4_graph.png).', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'net_change_from_integral', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'accumulation_function_behavior', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'accumulation_vs_value_confusion' FROM new_question;

-- ============================================================
-- U6.5-P5
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U6.5-P5', 'Both', 'ABBC_Integration', '6.5', '6.5', 'MCQ', FALSE,
        4, 180, '{net_change_from_integral,method_selection_unit6}', '{net_vs_total_change_confusion}', 'text',
        $txt$Let $A(x)=\int_0^x f(t)\,dt$. Suppose $A(8)=A(2)$. Which statement must be true about $\int_2^8 f(t)\,dt$?$txt$,
        $txt$Let $A(x)=\int_0^x f(t)\,dt$. Suppose $A(8)=A(2)$. Which statement must be true about $\int_2^8 f(t)\,dt$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "It equals 0.", "type": "text", "explanation": "Correct: equal accumulation values imply net integral 0 on that interval."},
          {"id": "B", "label": "B", "value": "It is positive.", "type": "text", "explanation": "Not necessary; net area could cancel to 0."},
          {"id": "C", "label": "C", "value": "It is negative.", "type": "text", "explanation": "Not necessary; net area could cancel to 0."},
          {"id": "D", "label": "D", "value": "The total area between $f$ and the axis on $[2,8]$ is 0.", "type": "text", "explanation": "Not necessary; net integral 0 does not imply total (unsigned) area is 0."}
        ]$txt$,
        'A',
        $txt$$A(8)-A(2)=\int_2^8 f(t)\,dt$. If $A(8)=A(2)$, then the net change is 0, so the integral is 0.$txt$,
        '{net_change_from_integral}',
        'published', 1, 4, 1.35, 'NewMaoS', 2026, '', 0.7, 0.3, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'net_change_from_integral', 'primary', 0.7 FROM new_question
    UNION ALL
    SELECT id, 'method_selection_unit6', 'supporting', 0.3 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'net_vs_total_change_confusion' FROM new_question;
-- Insert Script for 6.6 (Applying Properties of Definite Integrals)
-- Unit: ABBC_Integration

-- 1. Clean up potential duplicates
DELETE FROM public.questions WHERE title IN (
    'U6.6-P1', 'U6.6-P2', 'U6.6-P3', 'U6.6-P4', 'U6.6-P5'
);

-- ============================================================
-- U6.6-P1
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U6.6-P1', 'Both', 'ABBC_Integration', '6.6', '6.6', 'MCQ', FALSE,
        2, 120, '{integral_properties_basic}', '{integral_additivity_error}', 'text',
        $txt$Given $\int_0^2 f(x)\,dx=5$ and $\int_2^6 f(x)\,dx=-1$, what is $\int_0^6 f(x)\,dx$?$txt$,
        $txt$Given $\int_0^2 f(x)\,dx=5$ and $\int_2^6 f(x)\,dx=-1$, what is $\int_0^6 f(x)\,dx$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$4$", "type": "text", "explanation": "Correct: add the two pieces."},
          {"id": "B", "label": "B", "value": "$6$", "type": "text", "explanation": "Would come from subtracting the negative incorrectly."},
          {"id": "C", "label": "C", "value": "$-4$", "type": "text", "explanation": "Wrong sign; does not match 5 + (−1)."},
          {"id": "D", "label": "D", "value": "$-6$", "type": "text", "explanation": "Wrong magnitude and sign."}
        ]$txt$,
        'A',
        $txt$Use additivity: $\int_0^6 f=\int_0^2 f+\int_2^6 f=5+(-1)=4$.$txt$,
        '{integral_properties_basic}',
        'published', 1, 2, 1.05, 'NewMaoS', 2026, '', 0.9, 0.1, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'integral_properties_basic', 'primary', 0.9 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'integral_additivity_error' FROM new_question;

-- ============================================================
-- U6.6-P2
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U6.6-P2', 'Both', 'ABBC_Integration', '6.6', '6.6', 'MCQ', FALSE,
        2, 120, '{integral_properties_basic}', '{integral_bounds_reversal_error}', 'text',
        $txt$If $\int_0^6 f(x)\,dx=4$, what is $\int_6^0 f(x)\,dx$?$txt$,
        $txt$If $\int_0^6 f(x)\,dx=4$, what is $\int_6^0 f(x)\,dx$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$4$", "type": "text", "explanation": "Does not account for reversing bounds."},
          {"id": "B", "label": "B", "value": "$-4$", "type": "text", "explanation": "Correct: reversing bounds negates the integral."},
          {"id": "C", "label": "C", "value": "$\\frac{1}{4}$", "type": "text", "explanation": "No rule gives a reciprocal here."},
          {"id": "D", "label": "D", "value": "$0$", "type": "text", "explanation": "Would only be true if the original integral were 0."}
        ]$txt$,
        'B',
        $txt$Reversing bounds changes the sign: $\int_6^0 f= -\int_0^6 f=-4$.$txt$,
        '{integral_properties_basic}',
        'published', 1, 2, 1.05, 'NewMaoS', 2026, '', 0.9, 0.1, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'integral_properties_basic', 'primary', 0.9 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'integral_bounds_reversal_error' FROM new_question;

-- ============================================================
-- U6.6-P3
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U6.6-P3', 'Both', 'ABBC_Integration', '6.6', '6.6', 'MCQ', FALSE,
        3, 150, '{integral_properties_basic}', '{integral_additivity_error}', 'text',
        $txt$Use the table of given integral values. What is $\int_0^6 \left(2f(x)-g(x)\right)\,dx$?$txt$,
        $txt$Use the table of given integral values. What is $\int_0^6 (2f(x)-g(x))\,dx$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$4$", "type": "text", "explanation": "Correct: apply constant multiple and subtraction rules."},
          {"id": "B", "label": "B", "value": "$8$", "type": "text", "explanation": "Would happen if you forgot to subtract the $\\int g$ term."},
          {"id": "C", "label": "C", "value": "$0$", "type": "text", "explanation": "Would happen if you incorrectly assumed the two terms cancel."},
          {"id": "D", "label": "D", "value": "$-4$", "type": "text", "explanation": "Wrong sign; does not match 8−4."}
        ]$txt$,
        'A',
        $txt$Linearity: $\int_0^6(2f-g)=2\int_0^6 f-\int_0^6 g=2(4)-4=4$.$txt$,
        '{integral_properties_basic}',
        'published', 1, 3, 1.2, 'NewMaoS', 2026, 'Table required (U6_6.6-P3_table.png).', 0.9, 0.1, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'integral_properties_basic', 'primary', 0.9 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'integral_additivity_error' FROM new_question;

-- ============================================================
-- U6.6-P4
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U6.6-P4', 'Both', 'ABBC_Integration', '6.6', '6.6', 'MCQ', FALSE,
        2, 120, '{integral_properties_basic}', '{integral_additivity_error}', 'text',
        $txt$If $\int_a^b f(x)\,dx=3$ and $\int_a^b g(x)\,dx=-2$, what is $\int_a^b (f(x)+g(x))\,dx$?$txt$,
        $txt$If $\int_a^b f(x)\,dx=3$ and $\int_a^b g(x)\,dx=-2$, what is $\int_a^b (f(x)+g(x))\,dx$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$-5$", "type": "text", "explanation": "Would come from multiplying instead of adding."},
          {"id": "B", "label": "B", "value": "$-1$", "type": "text", "explanation": "Would come from subtracting $-2$ incorrectly."},
          {"id": "C", "label": "C", "value": "$1$", "type": "text", "explanation": "Correct: 3 + (−2) = 1."},
          {"id": "D", "label": "D", "value": "$5$", "type": "text", "explanation": "Would come from adding absolute values."}
        ]$txt$,
        'C',
        $txt$Additivity: $\int (f+g)=\int f+\int g=3+(-2)=1$.$txt$,
        '{integral_properties_basic}',
        'published', 1, 2, 1.05, 'NewMaoS', 2026, '', 0.9, 0.1, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'integral_properties_basic', 'primary', 0.9 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'integral_additivity_error' FROM new_question;

-- ============================================================
-- U6.6-P5
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U6.6-P5', 'Both', 'ABBC_Integration', '6.6', '6.6', 'MCQ', FALSE,
        3, 150, '{integral_symmetry_even_odd}', '{symmetry_even_odd_misuse}', 'text',
        $txt$Suppose $f$ is an odd function. What must be true about $\int_{-2}^{2} f(x)\,dx$?$txt$,
        $txt$Suppose $f$ is an odd function. What must be true about $\int_{-2}^{2} f(x)\,dx$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "It equals $0$.", "type": "text", "explanation": "Correct: symmetry cancellation for odd functions."},
          {"id": "B", "label": "B", "value": "It is positive.", "type": "text", "explanation": "Not guaranteed; cancellation can produce 0."},
          {"id": "C", "label": "C", "value": "It is negative.", "type": "text", "explanation": "Not guaranteed; cancellation can produce 0."},
          {"id": "D", "label": "D", "value": "It equals $2\\int_0^2 f(x)\\,dx$.", "type": "text", "explanation": "That relationship holds for even functions, not odd functions."}
        ]$txt$,
        'A',
        $txt$For an odd function, areas on symmetric intervals cancel, so the integral over $[-2,2]$ is 0.$txt$,
        '{integral_symmetry_even_odd}',
        'published', 1, 3, 1.2, 'NewMaoS', 2026, '', 0.9, 0.1, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'integral_symmetry_even_odd', 'primary', 0.9 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'symmetry_even_odd_misuse' FROM new_question;
-- Insert Script for 6.7 (FTC Part 1 / Derivatives of Integrals)
-- Note: User labels this 6.7, but content is FTC Part 1 (Derivatives of Accumulation).
-- In CED, this is often 6.4, but we follow User mappings.
-- Unit: ABBC_Integration

-- 1. Clean up potential duplicates
DELETE FROM public.questions WHERE title IN (
    'U6.7-P1', 'U6.7-P2', 'U6.7-P3', 'U6.7-P4', 'U6.7-P5'
);

-- ============================================================
-- U6.7-P1
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U6.7-P1', 'Both', 'ABBC_Integration', '6.7', '6.7', 'MCQ', FALSE,
        3, 150, '{ftc1_accumulation_function}', '{accumulation_derivative_wrong_variable}', 'text',
        $txt$Let $F(x)=\int_1^x (t^2-4t)\,dt$. What is $F'(x)$?$txt$,
        $txt$Let $F(x)=\int_1^x (t^2-4t)\,dt$. What is $F'(x)$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$x^2-4x$", "type": "text", "explanation": "Correct: FTC1 gives the integrand evaluated at $x$."},
          {"id": "B", "label": "B", "value": "$2x-4$", "type": "text", "explanation": "That is the derivative of $x^2-4x$, not the result of FTC1 here."},
          {"id": "C", "label": "C", "value": "$x^2-4$", "type": "text", "explanation": "Drops the $x$ term incorrectly."},
          {"id": "D", "label": "D", "value": "$\\int_1^x (t^2-4t)\\,dt$", "type": "text", "explanation": "FTC1 differentiates the integral; it does not stay as an integral."}
        ]$txt$,
        'A',
        $txt$By FTC Part 1, if $F(x)=\int_a^x f(t)dt$, then $F'(x)=f(x)$. Here $f(t)=t^2-4t$, so $F'(x)=x^2-4x$.$txt$,
        '{ftc_part2_basic}',
        'published', 1, 3, 1.2, 'NewMaoS', 2026, '', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'ftc1_accumulation_function', 'primary', 0.8 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'accumulation_derivative_wrong_variable' FROM new_question;

-- ============================================================
-- U6.7-P2
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U6.7-P2', 'Both', 'ABBC_Integration', '6.7', '6.7', 'MCQ', FALSE,
        4, 180, '{ftc1_accumulation_function}', '{accumulation_derivative_wrong_variable}', 'text',
        $txt$The function $f$ is shown in the figure. Let $G(x)=\int_0^x f(t)\,dt$. What is $G'(2)$?$txt$,
        $txt$The function $f$ is shown. Let $G(x)=\int_0^x f(t)\,dt$. What is $G'(2)$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$f(2)$", "type": "text", "explanation": "Correct: derivative of an accumulation function equals the integrand value."},
          {"id": "B", "label": "B", "value": "$-f(2)$", "type": "text", "explanation": "The negative would come from swapping bounds, which is not the case."},
          {"id": "C", "label": "C", "value": "$\\int_0^2 f(t)\\,dt$", "type": "text", "explanation": "That is $G(2)$, not $G'(2)$."},
          {"id": "D", "label": "D", "value": "Cannot be determined from the graph", "type": "text", "explanation": "It can be determined: $G'(2)$ is the y-value $f(2)$."}
        ]$txt$,
        'A',
        $txt$By FTC1, $G'(x)=f(x)$, so $G'(2)=f(2)$ (read the y-value of the graph at $x=2$).$txt$,
        '{ftc_part2_graph_read}',
        'published', 1, 4, 1.3, 'NewMaoS', 2026, 'Graph required (U6_6.7-P2_graph.png).', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'ftc1_accumulation_function', 'primary', 0.8 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'accumulation_derivative_wrong_variable' FROM new_question;

-- ============================================================
-- U6.7-P3
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U6.7-P3', 'Both', 'ABBC_Integration', '6.7', '6.7', 'MCQ', FALSE,
        4, 180, '{ftc1_chain_inside}', '{accumulation_chain_rule_missing}', 'text',
        $txt$Let $H(x)=\int_3^{x^2} \sqrt{1+t}\,dt$. What is $H'(x)$?$txt$,
        $txt$Let $H(x)=\int_3^{x^2} \sqrt{1+t}\,dt$. What is $H'(x)$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$\\sqrt{1+x^2}$", "type": "text", "explanation": "Missing the chain rule factor $u'(x)=2x$."},
          {"id": "B", "label": "B", "value": "$2x\\sqrt{1+x^2}$", "type": "text", "explanation": "Correct: evaluate at $t=x^2$ and multiply by $2x$."},
          {"id": "C", "label": "C", "value": "$\\frac{1}{2\\sqrt{1+x^2}}$", "type": "text", "explanation": "That is the derivative of $\\sqrt{1+x^2}$, not the result here."},
          {"id": "D", "label": "D", "value": "$2x\\sqrt{1+t}$", "type": "text", "explanation": "Leaves an extra variable $t$; the final answer must be in $x$."}
        ]$txt$,
        'B',
        $txt$FTC1 with chain rule: if $H(x)=\int_a^{u(x)} f(t)dt$, then $H'(x)=f(u(x))u'(x)$. Here $u(x)=x^2$, $u'(x)=2x$, and $f(t)=\sqrt{1+t}$, so $H'(x)=2x\sqrt{1+x^2}$.$txt$,
        '{ftc_part2_chain_rule}',
        'published', 1, 4, 1.3, 'NewMaoS', 2026, '', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'ftc1_chain_inside', 'primary', 0.8 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'accumulation_chain_rule_missing' FROM new_question;

-- ============================================================
-- U6.7-P4
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U6.7-P4', 'Both', 'ABBC_Integration', '6.7', '6.7', 'MCQ', FALSE,
        5, 210, '{ftc1_chain_inside}', '{accumulation_chain_rule_missing}', 'text',
        $txt$The function $g$ is shown in the figure. Let $J(x)=\int_1^{2x-1} g(t)\,dt$. Which expression equals $J'(x)$?$txt$,
        $txt$The function $g$ is shown. Let $J(x)=\int_1^{2x-1} g(t)\,dt$. Which expression equals $J'(x)$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$g(2x-1)$", "type": "text", "explanation": "Missing the derivative of the upper limit $(2x-1)'=2$."},
          {"id": "B", "label": "B", "value": "$2g(2x-1)$", "type": "text", "explanation": "Correct: multiply by 2 from the chain rule."},
          {"id": "C", "label": "C", "value": "$(2x-1)g(x)$", "type": "text", "explanation": "Not a valid FTC1 form; introduces unrelated factors."},
          {"id": "D", "label": "D", "value": "$\\int_1^{2x-1} g(t)\\,dt$", "type": "text", "explanation": "That is $J(x)$, not the derivative."}
        ]$txt$,
        'B',
        $txt$FTC1 with chain rule: $J'(x)=g(2x-1)\cdot (2)$, so $J'(x)=2g(2x-1)$.$txt$,
        '{ftc_part2_chain_rule}',
        'published', 1, 5, 1.4, 'NewMaoS', 2026, 'Graph required (U6_6.7-P4_graph.png).', 0.7, 0.3, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'ftc1_chain_inside', 'primary', 0.7 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'accumulation_chain_rule_missing' FROM new_question;

-- ============================================================
-- U6.7-P5
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U6.7-P5', 'Both', 'ABBC_Integration', '6.7', '6.7', 'MCQ', FALSE,
        4, 180, '{accumulation_from_variable_limit}', '{accumulation_derivative_wrong_variable}', 'text',
        $txt$Use the table of values of $h$. Let $K(x)=\int_{x}^{4} h(t)\,dt$. What is $K'(2)$?$txt$,
        $txt$Use the table of values of $h$. Let $K(x)=\int_{x}^{4} h(t)\,dt$. What is $K'(2)$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$-h(2)$", "type": "text", "explanation": "Correct: derivative is negative of the integrand at the lower limit; then substitute $h(2)=-1$."},
          {"id": "B", "label": "B", "value": "$h(2)$", "type": "text", "explanation": "Sign is wrong for a variable lower limit."},
          {"id": "C", "label": "C", "value": "$\\int_2^4 h(t)\\,dt$", "type": "text", "explanation": "That is $K(2)$, not $K'(2)$."},
          {"id": "D", "label": "D", "value": "$0$", "type": "text", "explanation": "Nothing indicates the slope must be zero."}
        ]$txt$,
        'A',
        $txt$If $K(x)=\int_x^4 h(t)dt$, then $K'(x)=-h(x)$ (variable lower limit). From the table, $h(2)=-1$, so $K'(2)=-(-1)=1$.$txt$,
        '{ftc_part2_lower_limit_sign}',
        'published', 1, 4, 1.3, 'NewMaoS', 2026, 'Table required (U6_6.7-P5_table.png).', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'accumulation_from_variable_limit', 'primary', 0.8 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'accumulation_derivative_wrong_variable' FROM new_question;
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
