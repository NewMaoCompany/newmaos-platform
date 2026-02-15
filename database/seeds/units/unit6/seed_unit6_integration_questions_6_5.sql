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
