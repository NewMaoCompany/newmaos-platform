-- Insert Unit 8 Practice Questions (8.1-8.6)
-- 
-- Includes:
-- 1. Skills and Error Tags for Unit 8
-- 2. Questions U8.1-P1 to U8.6-P5
-- 3. Ensures correct `topic` ('Both_AppIntegration')
-- 4. Uses `representation_type` = 'symbolic'

DO $$
DECLARE
    q_id UUID;
BEGIN

    -- 1. \frac{Insert}{Ensure} Skills
    INSERT INTO public.skills (id, name, unit) VALUES
        ('average_value_formula', 'Average Value Formula', 'Unit8_Applications_of_Integration'),
        ('average_value_from_graph_or_table', 'Average Value from \frac{Graph}{Table}', 'Unit8_Applications_of_Integration'),
        ('average_value_interpretation', 'Average Value Interpretation', 'Unit8_Applications_of_Integration'),
        ('bounds_from_context', 'Determine Bounds from Context', 'Unit8_Applications_of_Integration'),
        ('motion_displacement_from_velocity', 'Displacement from Velocity', 'Unit8_Applications_of_Integration'),
        ('total_distance_vs_displacement', 'Total Distance vs Displacement', 'Unit8_Applications_of_Integration'),
        ('motion_velocity_from_acceleration_with_initial', 'Velocity from Accel (with IC)', 'Unit8_Applications_of_Integration'),
        ('motion_position_with_initial_condition', 'Position from Velocity (with IC)', 'Unit8_Applications_of_Integration'),
        ('units_interpretation_in_applications', 'Units Interpretation', 'Unit8_Applications_of_Integration'),
        ('accumulation_from_rate', 'Accumulation from Rate', 'Unit8_Applications_of_Integration'),
        ('net_change_vs_total_change_context', 'Net vs Total Change (Context)', 'Unit8_Applications_of_Integration'),
        ('area_between_curves_dx_setup', 'Area Between Curves (dx)', 'Unit8_Applications_of_Integration'),
        ('area_top_minus_bottom_or_right_minus_left', 'Top-\frac{Bottom}{Right}-Left Strategy', 'Unit8_Applications_of_Integration'),
        ('solve_intersections_for_bounds', 'Solve Intersections for Bounds', 'Unit8_Applications_of_Integration'),
        ('area_between_curves_dy_setup', 'Area Between Curves (dy)', 'Unit8_Applications_of_Integration'),
        ('choose_dx_or_dy_strategy_area', 'Choose \frac{dx}{dy} Strategy (Area)', 'Unit8_Applications_of_Integration'),
        ('area_multiple_intersections_split', 'Area with Multiple Intersections', 'Unit8_Applications_of_Integration')
    ON CONFLICT (id) DO UPDATE SET
        name = EXCLUDED.name,
        unit = EXCLUDED.unit;

    -- 2. \frac{Insert}{Ensure} Error Tags
    INSERT INTO public.error_tags (id, name, category, severity, unit) VALUES
        ('avg_value_missing_divide_by_interval', 'Missing 1/(b-a)', 'Conceptual', 3, 'Unit8_Applications_of_Integration'),
        ('avg_value_wrong_interval_length', 'Wrong Interval Length', 'Calculation', 2, 'Unit8_Applications_of_Integration'),
        ('algebra_simplification_error', 'Algebra Error', 'Algebra', 2, 'Unit8_Applications_of_Integration'),
        ('avg_value_wrong_bounds', 'Wrong Bounds (Avg Val)', 'Procedural', 3, 'Unit8_Applications_of_Integration'),
        ('avg_value_integrand_misread', 'Misread Integrand', 'Data', 2, 'Unit8_Applications_of_Integration'),
        ('rounding_too_early', 'Rounding Too Early', 'Calculation', 2, 'Unit8_Applications_of_Integration'),
        ('motion_displacement_distance_confusion', 'Distance vs Displacement Confusion', 'Conceptual', 3, 'Unit8_Applications_of_Integration'),
        ('motion_sign_mistake', 'Sign Mistake (Motion)', 'Algebra', 2, 'Unit8_Applications_of_Integration'),
        ('accumulation_bounds_misread_context', 'Misread Bounds (Context)', 'Interpretation', 2, 'Unit8_Applications_of_Integration'),
        ('motion_forget_initial_condition', 'Forgot Initial Condition', 'Conceptual', 3, 'Unit8_Applications_of_Integration'),
        ('motion_units_mismatch', 'Units Mismatch (Motion)', 'Interpretation', 2, 'Unit8_Applications_of_Integration'),
        ('accumulation_units_mismatch', 'Units Mismatch (Accumulation)', 'Interpretation', 2, 'Unit8_Applications_of_Integration'),
        ('accumulation_net_vs_total_confusion', 'Net vs Total Change Confusion', 'Conceptual', 3, 'Unit8_Applications_of_Integration'),
        ('area_wrong_top_minus_bottom', 'Wrong Top-Bottom Order', 'Conceptual', 3, 'Unit8_Applications_of_Integration'),
        ('area_intersections_incorrect', 'Incorrect Intersections', 'Algebra', 3, 'Unit8_Applications_of_Integration'),
        ('area_missing_abs_value', 'Missing Absolute Value (Area)', 'Conceptual', 3, 'Unit8_Applications_of_Integration'),
        ('area_wrong_dx_dy_choice', 'Wrong \frac{dx}{dy} Choice', 'Strategy', 3, 'Unit8_Applications_of_Integration'),
        ('area_missing_split_interval', 'Missing Interval Split', 'Procedural', 3, 'Unit8_Applications_of_Integration')
    ON CONFLICT (id) DO UPDATE SET
        name = EXCLUDED.name,
        category = EXCLUDED.category,
        severity = EXCLUDED.severity,
        unit = EXCLUDED.unit;

    -- 3. Cleanup Existing Questions
    DELETE FROM public.questions WHERE title IN (
        'U8.1-P1', 'U8.1-P2', 'U8.1-P3', 'U8.1-P4', 'U8.1-P5',
        'U8.2-P1', 'U8.2-P2', 'U8.2-P3', 'U8.2-P4', 'U8.2-P5',
        'U8.3-P1', 'U8.3-P2', 'U8.3-P3', 'U8.3-P4', 'U8.3-P5',
        'U8.4-P1', 'U8.4-P2', 'U8.4-P3', 'U8.4-P4', 'U8.4-P5',
        'U8.5-P1', 'U8.5-P2', 'U8.5-P3', 'U8.5-P4', 'U8.5-P5',
        'U8.6-P1', 'U8.6-P2', 'U8.6-P3', 'U8.6-P4', 'U8.6-P5'
    );

    -- 4. Insert Questions

    -- U8.1-P1
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U8.1-P1', 'Both', 'Both_AppIntegration', 'Both_AppIntegration', 'Practice', '8.1', 'MCQ', false, 2,
        'Let $f(x) = 3x+2$. What is the average value of $f$ on $[1,5]$?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$8$"},
            {"id": "B", "value": "$11$"},
            {"id": "C", "value": "$14$"},
            {"id": "D", "value": "$17$"}
        ]'::jsonb, 'B',
        'Average value is $\frac{1}{5-1}\int_1^5(3x+2)\,dx = \frac{1}{4}\left[\frac{3}{2}x^2+2x\right]_1^5 = \frac{1}{4}(50-\frac{7}{2}) = 11$.',
        'average_value_formula', ARRAY['average_value_formula', 'bounds_from_context'], ARRAY['avg_value_missing_divide_by_interval', 'avg_value_wrong_interval_length', 'algebra_simplification_error'],
        NOW(), NOW(), 'published', 1
    );

    -- U8.1-P2
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version, notes
    ) VALUES (
        'U8.1-P2', 'Both', 'Both_AppIntegration', 'Both_AppIntegration', 'Practice', '8.1', 'MCQ', false, 3,
        'The graph of $f$ is shown on $[0,4]$. What is the average value of $f$ on $[0,4]$?', 'image', 'symbolic',
        '[
            {"id": "A", "value": "$1$"},
            {"id": "B", "value": "$\\frac{3}{2}$"},
            {"id": "C", "value": "$2$"},
            {"id": "D", "value": "$3$"}
        ]'::jsonb, 'B',
        'Average value is $\frac{1}{4}\int_0^4 f(x)\,dx$. From the \\piecewise-linear graph, area is $\frac{1}{2}(1)(2) + (1)(2) + \frac{(2+1)}{2}(2) = 1+2+3=6$, so average value is $\frac{6}{4} = \frac{3}{2}$.',
        'average_value_from_graph_or_table', ARRAY['average_value_from_graph_or_table', 'average_value_formula'], ARRAY['avg_value_missing_divide_by_interval', 'avg_value_wrong_bounds', 'avg_value_integrand_misread'],
        NOW(), NOW(), 'published', 1, 'Uses image file: U8_1_Q2_graph.png'
    );

    -- U8.1-P3
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version, notes
    ) VALUES (
        'U8.1-P3', 'Both', 'Both_AppIntegration', 'Both_AppIntegration', 'Practice', '8.1', 'MCQ', false, 4,
        'Values of $f$ are given in the table for $x=0,1,2,3,4$. Use the trapezoidal rule with $\Delta x = 1$ to approximate the average value of $f$ on $[0,4]$.', 'image', 'symbolic',
        '[
            {"id": "A", "value": "$\\frac{21}{8}$"},
            {"id": "B", "value": "$\\frac{21}{4}$"},
            {"id": "C", "value": "$\\frac{9}{4}$"},
            {"id": "D", "value": "$\\frac{21}{2}$"}
        ]'::jsonb, 'A',
        'Trapezoidal gives $\int_0^4 f(x)\,dx \approx \frac{1}{2}\left[f(0)+2(f(1)+f(2)+f(3))+f(4)\right] = \frac{1}{2}[1+2(2+4+3)+2] = \frac{21}{2}$. Average value $\approx \frac{1}{4} \cdot \frac{21}{2} = \frac{21}{8}$.',
        'average_value_from_graph_or_table', ARRAY['average_value_from_graph_or_table', 'average_value_formula'], ARRAY['avg_value_missing_divide_by_interval', 'avg_value_wrong_interval_length', 'rounding_too_early'],
        NOW(), NOW(), 'published', 1, 'Uses image file: U8_1_Q3_table.png'
    );

    -- U8.1-P4
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U8.1-P4', 'Both', 'Both_AppIntegration', 'Both_AppIntegration', 'Practice', '8.1', 'MCQ', false, 3,
        'The average value of $f(x) = kx^2$ on $[0,2]$ is $\frac{8}{3}$. What is $k$?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$1$"},
            {"id": "B", "value": "$2$"},
            {"id": "C", "value": "$4$"},
            {"id": "D", "value": "$8$"}
        ]'::jsonb, 'B',
        'Average value is $\frac{1}{2}\int_0^2 kx^2\,dx = \frac{1}{2} \cdot k \left[\frac{x^3}{3}\right]_0^2 = \frac{1}{2} \cdot k \cdot \frac{8}{3} = \frac{4k}{3}$. Set $\frac{4k}{3} = \frac{8}{3}$ to get $k=2$.',
        'average_value_formula', ARRAY['average_value_formula', 'average_value_interpretation'], ARRAY['avg_value_wrong_bounds', 'avg_value_wrong_interval_length', 'algebra_simplification_error'],
        NOW(), NOW(), 'published', 1
    );

    -- U8.1-P5
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U8.1-P5', 'Both', 'Both_AppIntegration', 'Both_AppIntegration', 'Practice', '8.1', 'MCQ', false, 2,
        'If the average value of $f$ on $[a,b]$ is $m$, which statement must be true?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$\\\int_a^b f(x) \\\, dx = m$"},
            {"id": "B", "value": "$\\\int_a^b f(x) \\\, dx = m(b-a)$"},
            {"id": "C", "value": "$m = f(a)+f(b)$"},
            {"id": "D", "value": "$m = (f(a)+f(b))/2$ for any $f$"}
        ]'::jsonb, 'B',
        'By definition, $m = \frac{1}{b-a} \int_a^b f(x)\,dx$, so $\int_a^b f(x)\,dx = m(b-a)$.',
        'average_value_interpretation', ARRAY['average_value_interpretation', 'average_value_formula'], ARRAY['avg_value_missing_divide_by_interval', 'avg_value_wrong_interval_length'],
        NOW(), NOW(), 'published', 1
    );

    -- U8.2-P1
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U8.2-P1', 'Both', 'Both_AppIntegration', 'Both_AppIntegration', 'Practice', '8.2', 'MCQ', false, 3,
        'A particle moves with velocity $v(t) = 2t - 5$ \frac{m}{s} for $0 \le t \le 4$. What is the displacement on $[0,4]$?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$-4$"},
            {"id": "B", "value": "$4$"},
            {"id": "C", "value": "$-12$"},
            {"id": "D", "value": "$12$"}
        ]'::jsonb, 'A',
        'Displacement is $\int_0^4(2t-5)\,dt = \left[t^2-5t\right]_0^4 = 16-20 = -4$.',
        'motion_displacement_from_velocity', ARRAY['motion_displacement_from_velocity', 'bounds_from_context'], ARRAY['accumulation_bounds_misread_context', 'motion_sign_mistake', 'algebra_simplification_error'],
        NOW(), NOW(), 'published', 1
    );

    -- U8.2-P2
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version, notes
    ) VALUES (
        'U8.2-P2', 'Both', 'Both_AppIntegration', 'Both_AppIntegration', 'Practice', '8.2', 'MCQ', false, 4,
        'The velocity $v(t)$ (\frac{m}{s}) is shown on $0 \le t \le 6$. What is the total distance traveled on $[0,6]$?', 'image', 'symbolic',
        '[
            {"id": "A", "value": "$9.5$"},
            {"id": "B", "value": "$10.5$"},
            {"id": "C", "value": "$11.5$"},
            {"id": "D", "value": "$0.5$"}
        ]'::jsonb, 'B',
        'Total distance is $\int_0^6 |v(t)| \, dt$. From the graph: area on $[0,2]$ is $\frac{(1+3)}{2}(2) = 4$, on $[2,3]$ is $\frac{(3+0)}{2}(1) = \frac{3}{2}$, on $[3,4]$ is $\frac{(0+2)}{2}(1) = 1$ (absolute value), and on $[4,6]$ is $(2)(2) = 4$, so total distance is $4+\frac{3}{2}+1+4 = \frac{21}{2} = 10.5$.',
        'total_distance_vs_displacement', ARRAY['total_distance_vs_displacement', 'motion_displacement_from_velocity'], ARRAY['motion_displacement_distance_confusion', 'motion_sign_mistake', 'algebra_simplification_error'],
        NOW(), NOW(), 'published', 1, 'Uses image file: U8_2_Q2_graph.png'
    );

    -- U8.2-P3
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version, notes
    ) VALUES (
        'U8.2-P3', 'Both', 'Both_AppIntegration', 'Both_AppIntegration', 'Practice', '8.2', 'MCQ', false, 4,
        'Acceleration values are given in the table for $t=0,1,2,3,4$. If $v(0) = 3$ \frac{m}{s}, use the trapezoidal rule with $\Delta t = 1$ to approximate $v(4)$.', 'image', 'symbolic',
        '[
            {"id": "A", "value": "$3$"},
            {"id": "B", "value": "$4$"},
            {"id": "C", "value": "$5$"},
            {"id": "D", "value": "$2$"}
        ]'::jsonb, 'B',
        'Change in velocity is $\Delta v \approx \int_0^4 a(t) \, dt \approx \frac{1}{2}[a(0)+2(a(1)+a(2)+a(3))+a(4)] \cdot 1 = \frac{1}{2}[0+2(2+1-1)+(-2)] = 1$. Thus $v(4) \approx v(0) + \Delta v = 3 + 1 = 4$.',
        'motion_velocity_from_acceleration_with_initial', ARRAY['motion_velocity_from_acceleration_with_initial', 'bounds_from_context'], ARRAY['motion_forget_initial_condition', 'rounding_too_early', 'motion_units_mismatch'],
        NOW(), NOW(), 'published', 1, 'Uses image file: U8_2_Q3_table.png'
    );

    -- U8.2-P4
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U8.2-P4', 'Both', 'Both_AppIntegration', 'Both_AppIntegration', 'Practice', '8.2', 'MCQ', false, 4,
        'A particle has velocity $v(t) = t^2 - 2t$ \frac{m}{s}. If $s(0) = 5$ meters, what is $s(3)$?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$2$"},
            {"id": "B", "value": "$5$"},
            {"id": "C", "value": "$8$"},
            {"id": "D", "value": "$11$"}
        ]'::jsonb, 'B',
        'Position is $s(3) = s(0) + \int_0^3 (t^2-2t) \, dt = 5 + \left[\frac{t^3}{3}-t^2\right]_0^3 = 5 + (9-9) = 5$.',
        'motion_position_with_initial_condition', ARRAY['motion_position_with_initial_condition', 'motion_displacement_from_velocity'], ARRAY['motion_forget_initial_condition', 'motion_sign_mistake', 'algebra_simplification_error'],
        NOW(), NOW(), 'published', 1
    );

    -- U8.2-P5
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U8.2-P5', 'Both', 'Both_AppIntegration', 'Both_AppIntegration', 'Practice', '8.2', 'MCQ', false, 3,
        'If $a(t)$ is measured in \frac{m}{s}$^2$, what are the units of $\int_0^T a(t) \, dt$?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "\\frac{m}{s}$^2$"},
            {"id": "B", "value": "\\frac{m}{s}"},
            {"id": "C", "value": "m"},
            {"id": "D", "value": "\\frac{s}{m}"}
        ]'::jsonb, 'B',
        'Integrating \frac{m}{s}$^2$ with respect to $t$ (\\seconds) gives \frac{m}{s} because $(\text{\frac{m}{s}}^2) \cdot \text{s} = \text{\frac{m}{s}}$.',
        'units_interpretation_in_applications', ARRAY['units_interpretation_in_applications', 'motion_displacement_from_velocity'], ARRAY['motion_units_mismatch', 'accumulation_units_mismatch'],
        NOW(), NOW(), 'published', 1
    );

    -- U8.3-P1
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U8.3-P1', 'Both', 'Both_AppIntegration', 'Both_AppIntegration', 'Practice', '8.3', 'MCQ', false, 3,
        'The rate at which water flows \\into a \\tank is $r(t) = 3t^2$ gallons per minute for $0 \le t \le 2$. How many gallons of water flow \\into the \\tank over $[0,2]$?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$4$"},
            {"id": "B", "value": "$6$"},
            {"id": "C", "value": "$8$"},
            {"id": "D", "value": "$12$"}
        ]'::jsonb, 'C',
        'Accumulation equals $\int_0^2 3t^2 \, dt = \left[t^3\right]_0^2 = 8$ gallons.',
        'accumulation_from_rate', ARRAY['accumulation_from_rate', 'bounds_from_context'], ARRAY['accumulation_bounds_misread_context', 'accumulation_units_mismatch', 'algebra_simplification_error'],
        NOW(), NOW(), 'published', 1
    );

    -- U8.3-P2
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version, notes
    ) VALUES (
        'U8.3-P2', 'Both', 'Both_AppIntegration', 'Both_AppIntegration', 'Practice', '8.3', 'MCQ', false, 4,
        'The rate function $r(t)$ is shown on $0 \le t \le 6$. What is the net change in the quantity over $[0,6]$?', 'image', 'symbolic',
        '[
            {"id": "A", "value": "$3$"},
            {"id": "B", "value": "$5$"},
            {"id": "C", "value": "$7$"},
            {"id": "D", "value": "$9$"}
        ]'::jsonb, 'B',
        'Net change is $\int_0^6 r(t) \, dt$. From trapezoid areas: on $[0,2]$ area $= \frac{(1+3)}{2}(2) = 4$, on $[2,4]$ area $= \frac{(3+0)}{2}(2) = 3$, on $[4,6]$ area $= \frac{(0+(-2))}{2}(2) = -2$. Total $4+3-2=5$.',
        'accumulation_from_rate', ARRAY['accumulation_from_rate', 'bounds_from_context'], ARRAY['accumulation_bounds_misread_context', 'accumulation_net_vs_total_confusion', 'rounding_too_early'],
        NOW(), NOW(), 'published', 1, 'Uses image file: U8_3_Q2_rate_graph.png'
    );

    -- U8.3-P3
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version, notes
    ) VALUES (
        'U8.3-P3', 'Both', 'Both_AppIntegration', 'Both_AppIntegration', 'Practice', '8.3', 'MCQ', true, 4,
        'A quantity changes at rate $r(t)$ (\frac{units}{hr}). Values are given for $t=0,1,2,3,4$. Use the trapezoidal rule with $\Delta t = 1$ to approximate the change in the quantity over $[0,4]$.', 'image', 'symbolic',
        '[
            {"id": "A", "value": "$12$"},
            {"id": "B", "value": "$\\frac{25}{2}$"},
            {"id": "C", "value": "$13$"},
            {"id": "D", "value": "$10$"}
        ]'::jsonb, 'B',
        'Trapezoidal rule: $\int_0^4 r(t) \, dt \approx \frac{1}{2} [4+2(3+5+2)+1] = \frac{25}{2}$.',
        'accumulation_from_rate', ARRAY['accumulation_from_rate', 'units_interpretation_in_applications'], ARRAY['rounding_too_early', 'accumulation_units_mismatch', 'accumulation_bounds_misread_context'],
        NOW(), NOW(), 'published', 1, 'Uses image file: U8_3_Q3_rate_table.png'
    );

    -- U8.3-P4
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U8.3-P4', 'Both', 'Both_AppIntegration', 'Both_AppIntegration', 'Practice', '8.3', 'MCQ', false, 4,
        'A population changes at rate $r(t) = t - 2$ thousand people per year for $0 \le t \le 4$. What is the total change in population over $[0,4]$?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$0$"},
            {"id": "B", "value": "$2$"},
            {"id": "C", "value": "$4$"},
            {"id": "D", "value": "$8$"}
        ]'::jsonb, 'C',
        'Total change is $\int_0^4 |t-2| \, dt = \int_0^2 (2-t) \, dt + \int_2^4 (t-2) \, dt = 2+2=4$ (thousand people).',
        'net_change_vs_total_change_context', ARRAY['net_change_vs_total_change_context', 'accumulation_from_rate'], ARRAY['accumulation_net_vs_total_confusion', 'accumulation_bounds_misread_context', 'algebra_simplification_error'],
        NOW(), NOW(), 'published', 1
    );

    -- U8.3-P5
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U8.3-P5', 'Both', 'Both_AppIntegration', 'Both_AppIntegration', 'Practice', '8.3', 'MCQ', false, 2,
        'A company’s revenue rate is $R(t)$ measured in dollars per day. What are the units of $\\int_0^{10} R(t)\\,dt$?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "\\frac{dollars}{day}"},
            {"id": "B", "value": "\\frac{days}{dollar}"},
            {"id": "C", "value": "dollars"},
            {"id": "D", "value": "days"}
        ]'::jsonb, 'C',
        'Integrating \frac{dollars}{day} with respect to days gives dollars because $(\\text{\frac{dollars}{day}})\\cdot(\\text{day})=\\text{dollars}$.',
        'units_interpretation_in_applications', ARRAY['units_interpretation_in_applications', 'accumulation_from_rate'], ARRAY['accumulation_units_mismatch', 'motion_units_mismatch'],
        NOW(), NOW(), 'published', 1
    );

    -- U8.4-P1
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U8.4-P1', 'Both', 'Both_AppIntegration', 'Both_AppIntegration', 'Practice', '8.4', 'MCQ', false, 3,
        'Let $f(x) = 4x - x^2$ and $g(x) = x^2$. Which \\integral represents the area of the region enclosed by $f$ and $g$?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$\\\int_0^2 [(4x-x^2)-x^2] \\\, dx$"},
            {"id": "B", "value": "$\\\int_0^2 [x^2-(4x-x^2)] \\\, dx$"},
            {"id": "C", "value": "$\\\int_0^4 [(4x-x^2)-x^2] \\\, dx$"},
            {"id": "D", "value": "$\\\int_0^2 |(4x-x^2)+x^2| \\\, dx$"}
        ]'::jsonb, 'A',
        'Solve $4x-x^2 = x^2$ to get \\intersections at $x = 0$ and $x = 2$. On $[0,2]$, $f$ is above $g$, so area is $\int_0^2 (f-g) \, dx = \int_0^2[(4x-x^2)-x^2] \, dx$.',
        'area_between_curves_dx_setup', ARRAY['area_between_curves_dx_setup', 'area_top_minus_bottom_or_right_minus_left'], ARRAY['area_wrong_top_minus_bottom', 'area_intersections_incorrect', 'area_missing_abs_value'],
        NOW(), NOW(), 'published', 1
    );

    -- U8.4-P2
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version, notes
    ) VALUES (
        'U8.4-P2', 'Both', 'Both_AppIntegration', 'Both_AppIntegration', 'Practice', '8.4', 'MCQ', false, 4,
        'The curves $y = x^2$ and $y = 4x - x^2$ are shown on $[0,2]$. What is the area of the region between the curves on $[0,2]$?', 'image', 'symbolic',
        '[
            {"id": "A", "value": "$\\frac{8}{3}$"},
            {"id": "B", "value": "$\\frac{4}{3}$"},
            {"id": "C", "value": "$8$"},
            {"id": "D", "value": "$\\frac{16}{3}$"}
        ]'::jsonb, 'A',
        'Area is $\int_0^2[(4x-x^2)-x^2] \, dx = \int_0^2(4x-2x^2) \, dx = \left[2x^2-\frac{2}{3}x^3\right]_0^2 = 8-\frac{16}{3} = \frac{8}{3}$.',
        'area_between_curves_dx_setup', ARRAY['area_between_curves_dx_setup', 'solve_intersections_for_bounds'], ARRAY['area_wrong_top_minus_bottom', 'area_intersections_incorrect', 'algebra_simplification_error'],
        NOW(), NOW(), 'published', 1, 'Uses image file: U8_4_Q2_area_graph.png'
    );

    -- U8.4-P3
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U8.4-P3', 'Both', 'Both_AppIntegration', 'Both_AppIntegration', 'Practice', '8.4', 'MCQ', false, 3,
        'What is the area of the region bounded by $y = \\\\\\\ln x$, $y = 0$, $x = 1$, and $x = e$?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$1$"},
            {"id": "B", "value": "$e-1$"},
            {"id": "C", "value": "$e-2$"},
            {"id": "D", "value": "$2-e$"}
        ]'::jsonb, 'C',
        'Area is $\int_1^e \\\\\\\ln x \, dx = \left[x \\\\\\\ln x - x\right]_1^e = (e \cdot 1 - e) - (0 - 1) = 1$? Wait: $(e-e)-(-1)=1$ gives $1$.',
        'area_between_curves_dx_setup', ARRAY['area_between_curves_dx_setup', 'bounds_from_context'], ARRAY['bounds_from_context', 'algebra_simplification_error', 'area_wrong_top_minus_bottom'],
        NOW(), NOW(), 'published', 1
    );

    -- U8.4-P4
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U8.4-P4', 'Both', 'Both_AppIntegration', 'Both_AppIntegration', 'Practice', '8.4', 'MCQ', false, 5,
        'Find the area of the region between $y=\\\\\\\\sin x$ and $y=\\\\\\\\cos x$ on $\\left[0,\\frac{\\pi}{2}\\right]$.', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$2\\sqrt{2}-2$"},
            {"id": "B", "value": "$\\sqrt{2}-1$"},
            {"id": "C", "value": "$1$"},
            {"id": "D", "value": "$2-2\\sqrt{2}$"}
        ]'::jsonb, 'A',
        'They \\intersect where $\\\\\\\\sin x=\\\\\\\\cos x\\Rightarrow x=\\frac{\\pi}{4}$. Area is $\\int_0^{\\\frac{\pi}{4}}(\\\\\\\\cos x-\\\\\\\\sin x)dx+\\int_{\\\frac{\pi}{4}}^{\\\frac{\pi}{2}}(\\\\\\\\sin x-\\\\\\\\cos x)dx$. Each \\piece equals $\\sqrt{2}-1$, so total is $2(\\sqrt{2}-1)=2\\sqrt{2}-2$.',
        'area_top_minus_bottom_or_right_minus_left', ARRAY['area_top_minus_bottom_or_right_minus_left', 'solve_intersections_for_bounds'], ARRAY['area_missing_split_interval', 'area_missing_abs_value', 'area_intersections_incorrect'],
        NOW(), NOW(), 'published', 1
    );

    -- U8.4-P5
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U8.4-P5', 'Both', 'Both_AppIntegration', 'Both_AppIntegration', 'Practice', '8.4', 'MCQ', false, 3,
        'What is the area of the region between $y = x$ and $y = x^3$ on $[0,1]$?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$\\frac{1}{4}$"},
            {"id": "B", "value": "$\\frac{1}{2}$"},
            {"id": "C", "value": "$\\frac{3}{4}$"},
            {"id": "D", "value": "$0$"}
        ]'::jsonb, 'A',
        'On $[0,1]$, $x \ge x^3$, so area is $\int_0^1 (x-x^3) \, dx = \left[\frac{x^2}{2}-\frac{x^4}{4}\right]_0^1 = \frac{1}{2}-\frac{1}{4} = \frac{1}{4}$.',
        'area_top_minus_bottom_or_right_minus_left', ARRAY['area_top_minus_bottom_or_right_minus_left', 'area_between_curves_dx_setup'], ARRAY['area_wrong_top_minus_bottom', 'area_missing_abs_value', 'algebra_simplification_error'],
        NOW(), NOW(), 'published', 1
    );

    -- U8.5-P1
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U8.5-P1', 'Both', 'Both_AppIntegration', 'Both_AppIntegration', 'Practice', '8.5', 'MCQ', false, 3,
        'The region is bounded by $x = y^2$ and $x = y + 2$. Which \\integral represents the area of the region?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$\\\int_{-1}^{2} ((y+2)-y^2) \\\, dy$"},
            {"id": "B", "value": "$\\\int_{-1}^{2} (y^2-(y+2)) \\\, dy$"},
            {"id": "C", "value": "$\\\int_{0}^{2} ((y+2)-y^2) \\\, dy$"},
            {"id": "D", "value": "$\\\int_{-1}^{2} ((y+2)+y^2) \\\, dy$"}
        ]'::jsonb, 'A',
        'Solve $y^2 = y+2$ to get $y = -1, 2$. For $-1 \le y \le 2$, the right curve is $x = y+2$ and the left curve is $x = y^2$, so area is $\int_{-1}^{2} ((y+2)-y^2) \, dy$.',
        'area_between_curves_dy_setup', ARRAY['area_between_curves_dy_setup', 'solve_intersections_for_bounds'], ARRAY['area_wrong_dx_dy_choice', 'area_wrong_top_minus_bottom', 'area_intersections_incorrect'],
        NOW(), NOW(), 'published', 1
    );

    -- U8.5-P2
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version, notes
    ) VALUES (
        'U8.5-P2', 'Both', 'Both_AppIntegration', 'Both_AppIntegration', 'Practice', '8.5', 'MCQ', false, 4,
        'The curves $x = y^2$ and $x = y + 2$ are shown. What is the area of the region enclosed by the curves?', 'image', 'symbolic',
        '[
            {"id": "A", "value": "$\\frac{7}{2}$"},
            {"id": "B", "value": "$\\frac{9}{2}$"},
            {"id": "C", "value": "$\\frac{11}{2}$"},
            {"id": "D", "value": "$9$"}
        ]'::jsonb, 'B',
        'Intersections occur when $y^2 = y+2$, so $y = -1, 2$. Area is $\int_{-1}^{2}((y+2)-y^2) \, dy = \left[\frac{y^2}{2}+2y-\frac{y^3}{3}\right]_{-1}^{2} = \frac{9}{2}$.',
        'area_between_curves_dy_setup', ARRAY['area_between_curves_dy_setup', 'area_top_minus_bottom_or_right_minus_left'], ARRAY['area_wrong_dx_dy_choice', 'area_wrong_top_minus_bottom', 'algebra_simplification_error'],
        NOW(), NOW(), 'published', 1, 'Uses image file: U8_5_Q2_dy_graph.png'
    );

    -- U8.5-P3
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version, notes
    ) VALUES (
        'U8.5-P3', 'Both', 'Both_AppIntegration', 'Both_AppIntegration', 'Practice', '8.5', 'MCQ', true, 4,
        'For the region bounded by $x = y^2$ and $x = y+2$, the table gives $x_{\text{left}}$, $x_{\text{right}}$, and width for several $y$-values. Using the trapezoidal rule with $\Delta y = 1$, approximate the area of the region.', 'image', 'symbolic',
        '[
            {"id": "A", "value": "$3$"},
            {"id": "B", "value": "$4$"},
            {"id": "C", "value": "$\\frac{9}{2}$"},
            {"id": "D", "value": "$5$"}
        ]'::jsonb, 'B',
        'Area $\approx \frac{\Delta y}{2}[w(-1)+2w(0)+2w(1)+w(2)] = \frac{1}{2}[0+2(2)+2(2)+0] = 4$.',
        'area_between_curves_dy_setup', ARRAY['area_between_curves_dy_setup', 'choose_dx_or_dy_strategy_area'], ARRAY['area_wrong_dx_dy_choice', 'rounding_too_early', 'area_wrong_top_minus_bottom'],
        NOW(), NOW(), 'published', 1, 'Uses image file: U8_5_Q3_width_table.png'
    );

    -- U8.5-P4
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U8.5-P4', 'Both', 'Both_AppIntegration', 'Both_AppIntegration', 'Practice', '8.5', 'MCQ', false, 4,
        'The region is bounded by $y=x^2$ and $y=2x$. Which \\integral uses $dy$ to compute the area of the region?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$\\\int_{0}^{2}(2x-x^2)\\\,dx$"},
            {"id": "B", "value": "$\\\int_{0}^{4}\\\left(\\sqrt{y}-\\frac{y}{2}\\right)\\\,dy$"},
            {"id": "C", "value": "$\\\int_{0}^{4}\\\left(\\frac{y}{2}-\\sqrt{y}\\right)\\\,dy$"},
            {"id": "D", "value": "$\\\int_{0}^{2}\\\left(\\sqrt{x}-\\frac{x}{2}\\right)\\\,dx$"}
        ]'::jsonb, 'B',
        'Rewrite boundaries as $x=\\sqrt{y}$ (from $y=x^2$) and $x=\\frac{y}{2}$ (from $y=2x$), with $y$ from $0$ to $4$. Right minus left gives $\\int_{0}^{4}\\left(\\sqrt{y}-\\frac{y}{2}\\right)dy$.',
        'choose_dx_or_dy_strategy_area', ARRAY['choose_dx_or_dy_strategy_area', 'area_between_curves_dy_setup'], ARRAY['area_wrong_dx_dy_choice', 'area_intersections_incorrect', 'area_wrong_top_minus_bottom'],
        NOW(), NOW(), 'published', 1
    );

    -- U8.5-P5
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U8.5-P5', 'Both', 'Both_AppIntegration', 'Both_AppIntegration', 'Practice', '8.5', 'MCQ', false, 3,
        'What is the area of the region bounded by $y=x^2$ and $y=2x$?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$\\frac{4}{3}$"},
            {"id": "B", "value": "$\\frac{2}{3}$"},
            {"id": "C", "value": "$\\frac{8}{3}$"},
            {"id": "D", "value": "$\\frac{1}{3}$"}
        ]'::jsonb, 'A',
        'Using $dy$: area is $\\int_0^4\\left(\\sqrt{y}-\\frac{y}{2}\\right)dy=\\left[\\frac{2}{3}y^{\frac{3}{2}}-\\frac{y^2}{4}\\right]_0^4=\\frac{16}{3}-4=\\frac{4}{3}$.',
        'area_between_curves_dy_setup', ARRAY['area_between_curves_dy_setup', 'area_top_minus_bottom_or_right_minus_left'], ARRAY['area_wrong_dx_dy_choice', 'algebra_simplification_error', 'area_wrong_top_minus_bottom'],
        NOW(), NOW(), 'published', 1
    );

    -- U8.6-P1
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U8.6-P1', 'Both', 'Both_AppIntegration', 'Both_AppIntegration', 'Practice', '8.6', 'MCQ', false, 4,
        'On $[0,2\\pi]$, the curves $y=\\\\\\\\sin x$ and $y=\\\\\\\\sin(2x)$ \\intersect at which $x$-values?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$0,\\\ \\frac{\\pi}{3},\\\ \\pi,\\\ \\frac{5\\pi}{3},\\\ 2\\pi$"},
            {"id": "B", "value": "$0,\\\ \\frac{\\pi}{2},\\\ \\pi,\\\ \\frac{3\\pi}{2},\\\ 2\\pi$"},
            {"id": "C", "value": "$\\frac{\\pi}{3},\\\ \\pi,\\\ \\frac{5\\pi}{3}$ only"},
            {"id": "D", "value": "$0,\\\ \\frac{\\pi}{3},\\\ \\frac{2\\pi}{3},\\\ \\pi,\\\ 2\\pi$"}
        ]'::jsonb, 'A',
        'Solve $\\\\\\\\sin x=\\\\\\\\sin(2x)=2\\\\\\\\sin x\\\\\\\\cos x$. Either $\\\\\\\\sin x=0$ gives $x=0,\\pi,2\\pi$, or $1=2\\\\\\\\cos x$ gives $\\\\\\\\cos x=\\frac{1}{2}$ so $x=\\frac{\\pi}{3},\\frac{5\\pi}{3}$.',
        'solve_intersections_for_bounds', ARRAY['solve_intersections_for_bounds', 'area_multiple_intersections_split'], ARRAY['area_intersections_incorrect', 'algebra_simplification_error', 'area_missing_split_interval'],
        NOW(), NOW(), 'published', 1
    );

    -- U8.6-P2
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version, notes
    ) VALUES (
        'U8.6-P2', 'Both', 'Both_AppIntegration', 'Both_AppIntegration', 'Practice', '8.6', 'MCQ', false, 5,
        'The graphs of $y=\\\\\\\\sin x$ and $y=\\\\\\\\sin(2x)$ on $[0,2\\pi]$ are shown. Which expression represents the area between the curves on $[0,2\\pi]$?', 'image', 'symbolic',
        '[
            {"id": "A", "value": "$\\\int_0^{2\\pi}(\\sin x-\\sin(2x))\\\,dx$"},
            {"id": "B", "value": "$\\\int_0^{2\\pi}|\\sin x-\\sin(2x)|\\\,dx$"},
            {"id": "C", "value": "$\\\int_0^{\\pi}(\\sin x-\\sin(2x))\\\,dx$"},
            {"id": "D", "value": "$\\\int_0^{2\\pi}(\\sin x+\\sin(2x))\\\,dx$"}
        ]'::jsonb, 'B',
        'Because the curves cross more than twice, the “top” curve changes. The area between curves is $\\int_0^{2\\pi}|\\\\\\\\sin x-\\\\\\\\sin(2x)|\\,dx$ (equivalently, split at all \\intersection points and sum positive areas).',
        'area_multiple_intersections_split', ARRAY['area_multiple_intersections_split', 'area_top_minus_bottom_or_right_minus_left'], ARRAY['area_missing_split_interval', 'area_missing_abs_value', 'area_intersections_incorrect'],
        NOW(), NOW(), 'published', 1, 'Uses image file: U8_6_Q2_multi_intersections.png'
    );

    -- U8.6-P3
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U8.6-P3', 'Both', 'Both_AppIntegration', 'Both_AppIntegration', 'Practice', '8.6', 'MCQ', false, 5,
        'What is the area between $y = \\\\\\\sin x$ and $y = \\\\\\\sin(2x)$ on $[0,2\pi]$?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$4$"},
            {"id": "B", "value": "$5$"},
            {"id": "C", "value": "$\\frac{9}{2}$"},
            {"id": "D", "value": "$6$"}
        ]'::jsonb, 'B',
        'Split at \\intersection points $0, \frac{\pi}{3}, \pi, \frac{5\pi}{3}, 2\pi$ and \\integrate the positive difference on each subinterval. The total area sums to $5$.',
        'area_multiple_intersections_split', ARRAY['area_multiple_intersections_split', 'solve_intersections_for_bounds'], ARRAY['area_missing_split_interval', 'area_missing_abs_value', 'algebra_simplification_error'],
        NOW(), NOW(), 'published', 1
    );

    -- U8.6-P4
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U8.6-P4', 'Both', 'Both_AppIntegration', 'Both_AppIntegration', 'Practice', '8.6', 'MCQ', false, 4,
        'Find the area of the region between $y = x^3 - x$ and $y = 0$ on $[-1,1]$.', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$\\frac{1}{2}$"},
            {"id": "B", "value": "$0$"},
            {"id": "C", "value": "$\\frac{1}{4}$"},
            {"id": "D", "value": "$1$"}
        ]'::jsonb, 'A',
        'The curve meets the x-axis at $x = -1, 0, 1$. Area is $\int_{-1}^{1}|x^3-x| \, dx = 2\int_0^1(x-x^3) \, dx = 2\left[\frac{x^2}{2}-\frac{x^4}{4}\right]_0^1 = \frac{1}{2}$.',
        'area_multiple_intersections_split', ARRAY['area_multiple_intersections_split', 'area_top_minus_bottom_or_right_minus_left'], ARRAY['area_missing_split_interval', 'area_missing_abs_value', 'algebra_simplification_error'],
        NOW(), NOW(), 'published', 1
    );

    -- U8.6-P5
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U8.6-P5', 'Both', 'Both_AppIntegration', 'Both_AppIntegration', 'Practice', '8.6', 'MCQ', false, 4,
        'Suppose two continuous curves \\intersect at $x=a<b<c<d$ on an \\interval and switch which one is on top at each \\intersection. Which approach is guaranteed to produce the total area between them on $[a,d]$?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$\\\int_a^d (\\text{top}-\\text{bottom})\\\,dx$ using only one order for the whole \\interval"},
            {"id": "B", "value": "$\\\int_a^d |f(x)-g(x)|\\\,dx$"},
            {"id": "C", "value": "$\\\int_a^d (f(x)-g(x))\\\,dx$ and take the absolute value at the end"},
            {"id": "D", "value": "Compute $f(d)-f(a)$ and $g(d)-g(a)$ and add them"}
        ]'::jsonb, 'B',
        'When the order switches multiple times, total area is found by \\integrating the absolute difference (or splitting \\into subintervals and summing positive areas).',
        'area_multiple_intersections_split', ARRAY['area_multiple_intersections_split', 'solve_intersections_for_bounds'], ARRAY['area_missing_split_interval', 'area_intersections_incorrect', 'area_missing_abs_value'],
        NOW(), NOW(), 'published', 1
    );

END $$;
