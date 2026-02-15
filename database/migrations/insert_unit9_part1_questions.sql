-- Insert Unit 9 Part 1 Questions (9.1-9.4)
-- 
-- Configuration:
-- Topic ID: 'BC_Unit9'
-- Course: 'BC'
-- Representation Type: 'symbolic' (forced)
-- Correction Applied: U9.3-P2 correct_option_id = 'A'

DO $$
DECLARE
    q_id UUID;
BEGIN

    -- 1. \frac{Insert}{Ensure} Skills
    INSERT INTO public.skills (id, name, unit) VALUES
        ('parametric_dydx', 'Parametric \frac{dy}{dx}', 'Unit9_Parametric_Polar_Vector'),
        ('parametric_representation_concept', 'Parametric Curves Concept', 'Unit9_Parametric_Polar_Vector'),
        ('parametric_horizontal_vertical_tangents', '\frac{Horizontal}{Vertical} Tangents (Parametric)', 'Unit9_Parametric_Polar_Vector'),
        ('parametric_tangent_normal_lines', 'Tangent Lines (Parametric)', 'Unit9_Parametric_Polar_Vector'),
        ('parametric_eliminate_parameter', 'Eliminating the Parameter', 'Unit9_Parametric_Polar_Vector'),
        ('parametric_second_derivative', 'Parametric Second Derivative', 'Unit9_Parametric_Polar_Vector'),
        ('parametric_concavity_analysis', 'Parametric Concavity Analysis', 'Unit9_Parametric_Polar_Vector'),
        ('parametric_arc_length', 'Parametric Arc Length', 'Unit9_Parametric_Polar_Vector'),
        ('vector_component_derivative', 'Vector Derivative (Componentwise)', 'Unit9_Parametric_Polar_Vector'),
        ('vector_velocity_acceleration', 'Vector Velocity & Acceleration', 'Unit9_Parametric_Polar_Vector'),
        ('vector_speed_magnitude', 'Vector \frac{Speed}{Magnitude}', 'Unit9_Parametric_Polar_Vector'),
        ('vector_position_from_velocity', 'Vector Position from Velocity', 'Unit9_Parametric_Polar_Vector'),
        ('vector_valued_function_concept', 'Vector-Valued Functions Concept', 'Unit9_Parametric_Polar_Vector'),
        -- Support Skills (Ensure existence)
        ('parametric_first_derivatives', 'Parametric First Derivatives', 'Unit9_Parametric_Polar_Vector'),
        ('graph_reading_interval_error', 'Graph Reading Strategy', 'Unit9_Parametric_Polar_Vector'),
        ('vector_integral_componentwise', 'Vector Integral (Componentwise)', 'Unit9_Parametric_Polar_Vector')
    ON CONFLICT (id) DO UPDATE SET
        name = EXCLUDED.name,
        unit = EXCLUDED.unit;

    -- 2. \frac{Insert}{Ensure} Error Tags
    INSERT INTO public.error_tags (id, name, category, severity, unit) VALUES
        ('param_dydx_missing_divide_by_dxdt', 'Forgot to divide by \frac{dx}{dt}', 'Procedural', 3, 'Unit9_Parametric_Polar_Vector'),
        ('param_tangent_line_point_mismatch', 'Tangent Point Mismatch', 'Procedural', 2, 'Unit9_Parametric_Polar_Vector'),
        ('param_elimination_algebra_error', 'Algebra Error Eliminating Parameter', 'Algebra', 2, 'Unit9_Parametric_Polar_Vector'),
        ('param_dxdt_zero_not_checked', 'Forgot to check \frac{dx}{dt}=0', 'Conceptual', 3, 'Unit9_Parametric_Polar_Vector'),
        ('param_horizontal_vertical_conditions_swapped', 'Swapped \frac{Horiz}{Vert} Conditions', 'Conceptual', 3, 'Unit9_Parametric_Polar_Vector'),
        ('param_second_derivative_wrong_formula', 'Wrong Parametric 2nd Derivative', 'Formula', 3, 'Unit9_Parametric_Polar_Vector'),
        ('param_concavity_sign_error', 'Concavity Sign Error', 'Calculation', 2, 'Unit9_Parametric_Polar_Vector'),
        ('arc_length_missing_squares', 'Missing Squares in Arc Length', 'Formula', 3, 'Unit9_Parametric_Polar_Vector'),
        ('arc_length_wrong_bounds', 'Wrong Arc Length Bounds', 'Interpretation', 2, 'Unit9_Parametric_Polar_Vector'),
        ('arc_length_simplification_error', 'Arc Length Algebra Error', 'Algebra', 2, 'Unit9_Parametric_Polar_Vector'),
        ('vector_derivative_not_componentwise', 'Vector Derivative Not Componentwise', 'Conceptual', 3, 'Unit9_Parametric_Polar_Vector'),
        ('velocity_vs_speed_confusion', 'Velocity vs Speed Confusion', 'Conceptual', 2, 'Unit9_Parametric_Polar_Vector'),
        ('vector_magnitude_error', 'Vector Magnitude Formula Error', 'Formula', 3, 'Unit9_Parametric_Polar_Vector'),
        ('vector_integral_missing_constant_vector', 'Missing Constant Vector C', 'Procedural', 2, 'Unit9_Parametric_Polar_Vector'),
        ('vector_initial_value_not_applied', 'Initial Value Not Applied', 'Procedural', 2, 'Unit9_Parametric_Polar_Vector'),
        ('calculator_mode_or_rounding_issue', '\frac{Calculator}{Rounding} Error', 'General', 1, 'Unit9_Parametric_Polar_Vector')
    ON CONFLICT (id) DO UPDATE SET
        name = EXCLUDED.name,
        category = EXCLUDED.category,
        severity = EXCLUDED.severity,
        unit = EXCLUDED.unit;

    -- 3. Cleanup Existing Questions
    DELETE FROM public.questions WHERE title IN (
        'U9.1-P1', 'U9.1-P2', 'U9.1-P3', 'U9.1-P4', 'U9.1-P5',
        'U9.2-P1', 'U9.2-P2', 'U9.2-P3', 'U9.2-P4', 'U9.2-P5',
        'U9.3-P1', 'U9.3-P2', 'U9.3-P3', 'U9.3-P4', 'U9.3-P5',
        'U9.4-P1', 'U9.4-P2', 'U9.4-P3', 'U9.4-P4', 'U9.4-P5'
    );

    -- 4. Insert Questions

    -- U9.1-P1
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U9.1-P1', 'BC', 'BC_Unit9', 'BC_Unit9', '9.1', '9.1', 'MCQ', false, 2,
        'Let $x(t)=t^2+1$ and $y(t)=3t-2$. What is $\\frac{dy}{dx}$ when $t=2$?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "\\frac{3}{4}"},
            {"id": "B", "value": "\\frac{4}{3}"},
            {"id": "C", "value": "\\frac{3}{2}"},
            {"id": "D", "value": "\\frac{3}{8}"}
        ]'::jsonb, 'A',
        '$\\frac{dy}{dx}=\\frac{\frac{dy}{dt}}{\frac{dx}{dt}}=\\frac{3}{2t}$. At $t=2$, $\\frac{dy}{dx}=\\frac{3}{4}$.',
        'parametric_dydx', ARRAY['parametric_dydx', 'parametric_first_derivatives'], ARRAY['param_dydx_missing_divide_by_dxdt', 'param_tangent_line_point_mismatch', 'param_elimination_algebra_error'],
        NOW(), NOW(), 'published', 1
    );

    -- U9.1-P2
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U9.1-P2', 'BC', 'BC_Unit9', 'BC_Unit9', '9.1', '9.1', 'MCQ', false, 2,
        'A curve is given by $x(t) = \\\\\\\cos(t)$ and $y(t) = \\\\\\\sin(t)$. As $t$ increases from $0$ to $\frac{\pi}{2}$, which statement is true about the motion along the curve?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "It moves counterclockwise along the unit circle from $(1,0)$ to $(0,1)$."},
            {"id": "B", "value": "It moves clockwise along the unit circle from $(1,0)$ to $(0,1)$."},
            {"id": "C", "value": "It moves along a line segment from $(0,1)$ to $(1,0)$."},
            {"id": "D", "value": "It stays at a \\\\\\\\single point because $\\cos(t)$ and $\\sin(t)$ are periodic."}
        ]'::jsonb, 'A',
        'At $t = 0$, the point is $(\\\\\\\cos 0, \\\\\\\sin 0) = (1,0)$. At $t = \frac{\pi}{2}$, the point is $(0,1)$. Increasing $t$ traces the unit circle counterclockwise.',
        'parametric_representation_concept', ARRAY['parametric_representation_concept', 'parametric_first_derivatives'], ARRAY['param_tangent_line_point_mismatch', 'graph_reading_interval_error', 'param_dydx_missing_divide_by_dxdt'],
        NOW(), NOW(), 'published', 1
    );

    -- U9.1-P3
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U9.1-P3', 'BC', 'BC_Unit9', 'BC_Unit9', '9.1', '9.1', 'MCQ', false, 3,
        'A curve is given by $x(t) = t^3 - 3t$ and $y(t) = t^2$. For which value(s) of $t$ does the curve have a vertical \\tangent line?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$t = -1$ and $t = 1$"},
            {"id": "B", "value": "$t = 0$ only"},
            {"id": "C", "value": "$t = -1$ only"},
            {"id": "D", "value": "$t = 1$ only"}
        ]'::jsonb, 'A',
        'Vertical \\tangent occurs when $\frac{dx}{dt} = 0$ and $\frac{dy}{dt} \neq 0$. Here $\frac{dx}{dt} = 3t^2 - 3 = 3(t^2 - 1)$, so $t = \pm 1$. Also $\frac{dy}{dt} = 2t$, which is nonzero at $t = \pm 1$.',
        'parametric_horizontal_vertical_tangents', ARRAY['parametric_horizontal_vertical_tangents', 'parametric_dydx'], ARRAY['param_dxdt_zero_not_checked', 'param_horizontal_vertical_conditions_swapped', 'param_dydx_missing_divide_by_dxdt'],
        NOW(), NOW(), 'published', 1
    );

    -- U9.1-P4
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version, notes
    ) VALUES (
        'U9.1-P4', 'BC', 'BC_Unit9', 'BC_Unit9', '9.1', '9.1', 'MCQ', false, 4,
        'The curve shown is given by $x(t) = t^2$ and $y(t) = t^3 - t$. The point corresponding to $t = 1$ is marked. What is the equation of the \\tangent line at $t = 1$?', 'image', 'symbolic',
        '[
            {"id": "A", "value": "$y = x - 1$"},
            {"id": "B", "value": "$y = -x + 1$"},
            {"id": "C", "value": "$y = 2x - 2$"},
            {"id": "D", "value": "$y = \\frac{1}{2x} - \\frac{1}{2}$"}
        ]'::jsonb, 'A',
        'At $t = 1$, $(x,y) = (1,0)$. Also $\frac{dx}{dt} = 2t = 2$ and $\frac{dy}{dt} = 3t^2 - 1 = 2$, so $\frac{dy}{dx} = \frac{2}{2} = 1$. Tangent line: $y - 0 = 1(x - 1)$ so $y = x - 1$.',
        'parametric_tangent_normal_lines', ARRAY['parametric_tangent_normal_lines', 'parametric_dydx'], ARRAY['param_dydx_missing_divide_by_dxdt', 'param_tangent_line_point_mismatch', 'param_dxdt_zero_not_checked'],
        NOW(), NOW(), 'published', 1, 'Uses image file: U9_1_P4_param_curve.png'
    );

    -- U9.1-P5
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U9.1-P5', 'BC', 'BC_Unit9', 'BC_Unit9', '9.1', '9.1', 'MCQ', false, 3,
        'A curve is given by $x(t) = 2t + 1$ and $y(t) = t^2$. Which equation relates $x$ and $y$ (eliminating $t$)?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$y = (\\frac{x-1}{2})^2$"},
            {"id": "B", "value": "$y = \\frac{x-1}{2}$"},
            {"id": "C", "value": "$y = (\\frac{2}{x-1})^2$"},
            {"id": "D", "value": "$y = (x-1)^2$"}
        ]'::jsonb, 'A',
        'From $x = 2t + 1$, $t = \frac{x-1}{2}$. Substitute \\into $y = t^2$ to get $y = (\frac{x-1}{2})^2$.',
        'parametric_eliminate_parameter', ARRAY['parametric_eliminate_parameter', 'parametric_representation_concept'], ARRAY['param_elimination_algebra_error', 'param_tangent_line_point_mismatch', 'calculator_mode_or_rounding_issue'],
        NOW(), NOW(), 'published', 1
    );

    -- U9.2-P1
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U9.2-P1', 'BC', 'BC_Unit9', 'BC_Unit9', '9.2', '9.2', 'MCQ', false, 4,
        'Let $x(t) = t^2 + 1$ and $y(t) = t^3$. What is $\frac{d^2y}{dx^2}$ when $t = 1$?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "\\frac{3}{4}"},
            {"id": "B", "value": "\\frac{3}{2}"},
            {"id": "C", "value": "\\frac{1}{2}"},
            {"id": "D", "value": "\\frac{3}{8}"}
        ]'::jsonb, 'A',
        '$\frac{dy}{dx} = \frac{3t^2}{2t} = \frac{3t}{2}$. Then $\frac{d}{dt}(\frac{dy}{dx}) = \frac{3}{2}$. Also $\frac{dx}{dt} = 2t$, so $\frac{d^2y}{dx^2} = \frac{\frac{d}{dt}(\frac{dy}{dx})}{\frac{dx}{dt}} = \frac{\frac{3}{2}}{2} = \frac{3}{4}$ at $t = 1$.',
        'parametric_second_derivative', ARRAY['parametric_second_derivative', 'parametric_dydx'], ARRAY['param_second_derivative_wrong_formula', 'param_dydx_missing_divide_by_dxdt', 'param_dxdt_zero_not_checked'],
        NOW(), NOW(), 'published', 1
    );

    -- U9.2-P2
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U9.2-P2', 'BC', 'BC_Unit9', 'BC_Unit9', '9.2', '9.2', 'MCQ', false, 3,
        'A curve is given by $x(t) = t$ and $y(t) = t^3 - 3t$. At $t = -1$, is the curve concave up or concave down (with respect to $x$)?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "Concave up"},
            {"id": "B", "value": "Concave down"},
            {"id": "C", "value": "Neither; $d^\\frac{2y}{dx}^2 = 0$ at $t = -1$"},
            {"id": "D", "value": "Cannot be determined without a graph"}
        ]'::jsonb, 'B',
        'Since $x = t$, we have $\frac{d^2y}{dx^2} = \frac{d^2y}{dt^2}$. Here $y'' = 3t^2 - 3$ and $y'''' = 6t$. At $t = -1$, $y'''' = -6 < 0$, so the curve is concave down.',
        'parametric_concavity_analysis', ARRAY['parametric_concavity_analysis', 'parametric_second_derivative'], ARRAY['param_concavity_sign_error', 'param_second_derivative_wrong_formula', 'param_dydx_missing_divide_by_dxdt'],
        NOW(), NOW(), 'published', 1
    );

    -- U9.2-P3
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U9.2-P3', 'BC', 'BC_Unit9', 'BC_Unit9', '9.2', '9.2', 'MCQ', false, 4,
        'A curve is given by $x(t) = t$ and $y(t) = t^3 - 3t$. At which point does the curve have an inflection point?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$(0,0)$"},
            {"id": "B", "value": "$(1,-2)$"},
            {"id": "C", "value": "$(-1,2)$"},
            {"id": "D", "value": "$(0,-3)$"}
        ]'::jsonb, 'A',
        'With $x = t$, concavity is determined by $y''''(t) = 6t$. The sign changes at $t = 0$, so the inflection occurs at $t = 0$, giving point $(x,y) = (0,0)$.',
        'parametric_concavity_analysis', ARRAY['parametric_concavity_analysis', 'parametric_representation_concept'], ARRAY['param_concavity_sign_error', 'param_tangent_line_point_mismatch', 'param_second_derivative_wrong_formula'],
        NOW(), NOW(), 'published', 1
    );

    -- U9.2-P4
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version, notes
    ) VALUES (
        'U9.2-P4', 'BC', 'BC_Unit9', 'BC_Unit9', '9.2', '9.2', 'MCQ', false, 4,
        'The curve shown is given by $x(t)=t^2-1$ and $y(t)=t^3-3t$. The point corresponding to $t=1$ is marked. At $t=1$, is the curve concave up or concave down (with respect to $x$)?', 'image', 'symbolic',
        '[
            {"id": "A", "value": "Concave up"},
            {"id": "B", "value": "Concave down"},
            {"id": "C", "value": "Neither; d^\\frac{2y}{dx}^2=0 at t=1"},
            {"id": "D", "value": "Cannot be determined without numerical values"}
        ]'::jsonb, 'A',
        'Compute $\frac{dy}{dx}=\\frac{\frac{dy}{dt}}{\frac{dx}{dt}}=\\frac{3t^2-3}{2t}$. Then $\\frac{d}{dt}(\frac{dy}{dx})=\\frac{3}{2}\\left(1+\\frac{1}{t^2}\\right)$. Also $\frac{dx}{dt}=2t$, so $\\frac{d^2y}{dx^2}=\\frac{\\frac{3}{2}(1+\frac{1}{t}^2)}{2t}=\\frac{3(1+\frac{1}{t}^2)}{4t}$. At $t=1$, this is $\\frac{3(2)}{4}=\\frac{3}{2}>0$, so concave up.',
        'parametric_concavity_analysis', ARRAY['parametric_concavity_analysis', 'parametric_second_derivative'], ARRAY['param_concavity_sign_error', 'param_second_derivative_wrong_formula', 'param_tangent_line_point_mismatch'],
        NOW(), NOW(), 'published', 1, 'Uses image file: U9_2_P4_concavity_curve.png'
    );

    -- U9.2-P5
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version, notes
    ) VALUES (
        'U9.2-P5', 'BC', 'BC_Unit9', 'BC_Unit9', '9.2', '9.2', 'MCQ', false, 3,
        'A table of values at $t = 2$ is shown. Using $\frac{d^2y}{dx^2} = \frac{\frac{d}{dt}(\frac{dy}{dx})}{\frac{dx}{dt}}$, what is $\frac{d^2y}{dx^2}$ at $t = 2$?', 'image', 'symbolic',
        '[
            {"id": "A", "value": "\\frac{3}{4}"},
            {"id": "B", "value": "\\frac{4}{3}"},
            {"id": "C", "value": "3"},
            {"id": "D", "value": "\\frac{3}{8}"}
        ]'::jsonb, 'A',
        'From the table at $t = 2$, $\frac{dx}{dt} = 4$ and $\frac{d}{dt}(\frac{dy}{dx}) = 3$. Thus $\frac{d^2y}{dx^2} = \frac{3}{4}$.',
        'parametric_second_derivative', ARRAY['parametric_second_derivative', 'parametric_dydx'], ARRAY['param_second_derivative_wrong_formula', 'param_dxdt_zero_not_checked', 'param_dydx_missing_divide_by_dxdt'],
        NOW(), NOW(), 'published', 1, 'Uses image file: U9_2_P5_second_deriv_table.png'
    );

    -- U9.3-P1
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U9.3-P1', 'BC', 'BC_Unit9', 'BC_Unit9', '9.3', '9.3', 'MCQ', false, 4,
        'A curve is given by $x(t) = t^2$ and $y(t) = e^t$ for $0 \le t \le 1$. Which \\integral gives the arc length?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$\\\int_0^1 \\sqrt{(2t)^2+(e^t)^2} \\\, dt$"},
            {"id": "B", "value": "$\\\int_0^1 (2t+e^t) \\\, dt$"},
            {"id": "C", "value": "$\\\int_0^1 \\sqrt{1+(e^\\frac{t}{2t})^2} \\\, dt$"},
            {"id": "D", "value": "$\\\int_0^1 \\sqrt{(2t)+(e^t)} \\\, dt$"}
        ]'::jsonb, 'A',
        'Arc length in parametric form is $\int_a^b \sqrt{\left(\frac{dx}{dt}\right)^2+\left(\frac{dy}{dt}\right)^2} \, dt$. Here $\frac{dx}{dt} = 2t$ and $\frac{dy}{dt} = e^t$.',
        'parametric_arc_length', ARRAY['parametric_arc_length', 'parametric_first_derivatives'], ARRAY['arc_length_missing_squares', 'arc_length_wrong_bounds', 'arc_length_simplification_error'],
        NOW(), NOW(), 'published', 1
    );

    -- U9.3-P2
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version, notes
    ) VALUES (
        'U9.3-P2', 'BC', 'BC_Unit9', 'BC_Unit9', '9.3', '9.3', 'MCQ', false, 3,
        'A curve is given by $x(t) = 3t$ and $y(t) = 4t$ for $0 \le t \le 2$. What is the arc length on this \\interval?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$10$"},
            {"id": "B", "value": "$20$"},
            {"id": "C", "value": "$5$"},
            {"id": "D", "value": "$\\sqrt{5}$"}
        ]'::jsonb, 'A',
        '$\frac{dx}{dt} = 3$ and $\frac{dy}{dt} = 4$, so speed is $\sqrt{3^2+4^2} = 5$. Arc length $= \int_0^2 5 \, dt = 10$.',
        'parametric_arc_length', ARRAY['parametric_arc_length', 'parametric_first_derivatives'], ARRAY['arc_length_missing_squares', 'arc_length_wrong_bounds', 'arc_length_simplification_error'],
        NOW(), NOW(), 'published', 1, 'Correct option fixed to A (10) as per user request.'
    );

    -- U9.3-P3
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U9.3-P3', 'BC', 'BC_Unit9', 'BC_Unit9', '9.3', '9.3', 'MCQ', false, 3,
        'A curve is given by $x(t) = \\\\\\\cos(t)$ and $y(t) = \\\\\\\sin(t)$ for $0 \le t \le \frac{\pi}{2}$. What is the arc length?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$1$"},
            {"id": "B", "value": "$\\frac{\\pi}{2}$"},
            {"id": "C", "value": "$\\pi$"},
            {"id": "D", "value": "$2$"}
        ]'::jsonb, 'B',
        '$\frac{dx}{dt} = -\\\\\\\sin(t)$ and $\frac{dy}{dt} = \\\\\\\cos(t)$. Speed is $\sqrt{\\\\\\\sin^2(t)+\\\\\\\cos^2(t)} = 1$. Arc length $= \int_0^{\\frac{\pi}{2}} 1 \, dt = \frac{\pi}{2}$.',
        'parametric_arc_length', ARRAY['parametric_arc_length', 'parametric_first_derivatives'], ARRAY['arc_length_wrong_bounds', 'arc_length_missing_squares', 'arc_length_simplification_error'],
        NOW(), NOW(), 'published', 1
    );

    -- U9.3-P4
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version, notes
    ) VALUES (
        'U9.3-P4', 'BC', 'BC_Unit9', 'BC_Unit9', '9.3', '9.3', 'MCQ', true, 4,
        'A table of speed values $|\mathbf{v}(t)|$ is shown for $0 \le t \le 4$ with $\Delta t = 1$. Using the trapezoidal rule, approximate the arc length on $[0,4]$.', 'image', 'symbolic',
        '[
            {"id": "A", "value": "$17.8$"},
            {"id": "B", "value": "$18.0$"},
            {"id": "C", "value": "$16.8$"},
            {"id": "D", "value": "$35.6$"}
        ]'::jsonb, 'A',
        'Arc length $\approx \int_0^4 |\mathbf{v}(t)| \, dt$. Trapezoidal rule with $\Delta t = 1$: $\frac{1}{2} [v_0 + 2v_1 + 2v_2 + 2v_3 + v_4] = \frac{1}{2}(5.0 + 8.4 + 7.6 + 9.2 + 5.4) = 17.8$.',
        'parametric_arc_length', ARRAY['parametric_arc_length', 'parametric_first_derivatives'], ARRAY['arc_length_wrong_bounds', 'arc_length_simplification_error', 'calculator_mode_or_rounding_issue'],
        NOW(), NOW(), 'published', 1, 'Uses image file: U9_3_P4_speed_table.png'
    );

    -- U9.3-P5
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U9.3-P5', 'BC', 'BC_Unit9', 'BC_Unit9', '9.3', '9.3', 'MCQ', false, 3,
        'A curve is given by $x(t) = 1 - t$ and $y(t) = t^2$. The curve is traced from the point $(1,0)$ to the point $(-2,9)$. Which $t$-\\interval should be used for arc length?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$0 \\le t \\le 3$"},
            {"id": "B", "value": "$-3 \\le t \\le 0$"},
            {"id": "C", "value": "$1 \\le t \\le 9$"},
            {"id": "D", "value": "$-2 \\le t \\le 1$"}
        ]'::jsonb, 'A',
        'At $t = 0$, $(x,y) = (1,0)$. To reach $(-2,9)$, solve $1 - t = -2$ giving $t = 3$, and then $y(3) = 9$ matches. So use $0 \le t \le 3$.',
        'parametric_arc_length', ARRAY['parametric_arc_length', 'parametric_representation_concept'], ARRAY['arc_length_wrong_bounds', 'graph_reading_interval_error', 'arc_length_missing_squares'],
        NOW(), NOW(), 'published', 1
    );

    -- U9.4-P1
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U9.4-P1', 'BC', 'BC_Unit9', 'BC_Unit9', '9.4', '9.4', 'MCQ', false, 2,
        'Let $\mathbf{r}(t) = \langle t^2-1, 3t, \\\\\\\sin(t) \rangle$. What is $\mathbf{r}''(t)$?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$\\\langle 2t, 3, \\cos(t) \\rangle$"},
            {"id": "B", "value": "$\\\langle t^2, 3t, \\sin(t) \\rangle$"},
            {"id": "C", "value": "$\\\langle 2, 3, \\cos(t) \\rangle$"},
            {"id": "D", "value": "$\\\langle 2t, 0, \\cos(t) \\rangle$"}
        ]'::jsonb, 'A',
        'Differentiate componentwise: $(t^2-1)'' = 2t$, $(3t)'' = 3$, and $(\\\\\\\sin t)'' = \\\\\\\cos t$.',
        'vector_component_derivative', ARRAY['vector_component_derivative', 'vector_valued_function_concept'], ARRAY['vector_derivative_not_componentwise', 'param_elimination_algebra_error', 'calculator_mode_or_rounding_issue'],
        NOW(), NOW(), 'published', 1
    );

    -- U9.4-P2
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U9.4-P2', 'BC', 'BC_Unit9', 'BC_Unit9', '9.4', '9.4', 'MCQ', false, 3,
        'A particle has position $\mathbf{r}(t) = \langle t, t^2 \rangle$. What is its velocity vector $\mathbf{v}(2)$?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$\\\langle 1, 4 \\rangle$"},
            {"id": "B", "value": "$\\\langle 2, 4 \\rangle$"},
            {"id": "C", "value": "$\\\langle 1, 2 \\rangle$"},
            {"id": "D", "value": "$\\\langle 2, 8 \\rangle$"}
        ]'::jsonb, 'A',
        '$\mathbf{v}(t) = \mathbf{r}''(t) = \langle 1, 2t \rangle$, so $\mathbf{v}(2) = \langle 1, 4 \rangle$.',
        'vector_velocity_acceleration', ARRAY['vector_velocity_acceleration', 'vector_component_derivative'], ARRAY['vector_derivative_not_componentwise', 'param_tangent_line_point_mismatch', 'calculator_mode_or_rounding_issue'],
        NOW(), NOW(), 'published', 1
    );

    -- U9.4-P3
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U9.4-P3', 'BC', 'BC_Unit9', 'BC_Unit9', '9.4', '9.4', 'MCQ', false, 2,
        'A particle has velocity $\mathbf{v}(t) = \langle 3, -4 \rangle$. What is its speed?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$-1$"},
            {"id": "B", "value": "$7$"},
            {"id": "C", "value": "$5$"},
            {"id": "D", "value": "$1$"}
        ]'::jsonb, 'C',
        'Speed is $|\mathbf{v}(t)| = \sqrt{3^2+(-4)^2} = 5$.',
        'vector_speed_magnitude', ARRAY['vector_speed_magnitude', 'vector_velocity_acceleration'], ARRAY['velocity_vs_speed_confusion', 'vector_magnitude_error', 'calculator_mode_or_rounding_issue'],
        NOW(), NOW(), 'published', 1
    );

    -- U9.4-P4
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U9.4-P4', 'BC', 'BC_Unit9', 'BC_Unit9', '9.4', '9.4', 'MCQ', false, 4,
        'A particle has velocity $\mathbf{v}(t) = \langle 2t, \\\\\\\cos(t) \rangle$ and position $\mathbf{r}(0) = \langle 1, 0 \rangle$. What is $\mathbf{r}(\pi)$?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$\\\langle 1+\\pi^2, 0 \\rangle$"},
            {"id": "B", "value": "$\\\langle \\pi^2, 0 \\rangle$"},
            {"id": "C", "value": "$\\\langle 1+2\\pi, 1 \\rangle$"},
            {"id": "D", "value": "$\\\langle 1+\\pi^2, 2 \\rangle$"}
        ]'::jsonb, 'A',
        '$\mathbf{r}(\pi) = \mathbf{r}(0) + \int_0^{\pi} \mathbf{v}(t) \, dt = \langle 1,0 \rangle + \left\langle \int_0^{\pi} 2t \, dt, \int_0^{\pi} \\\\\\\cos(t) \, dt \right\rangle = \langle 1+\pi^2, 0 \rangle$.',
        'vector_position_from_velocity', ARRAY['vector_position_from_velocity', 'vector_integral_componentwise'], ARRAY['vector_integral_missing_constant_vector', 'vector_initial_value_not_applied', 'calculator_mode_or_rounding_issue'],
        NOW(), NOW(), 'published', 1
    );

    -- U9.4-P5
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version, notes
    ) VALUES (
        'U9.4-P5', 'BC', 'BC_Unit9', 'BC_Unit9', '9.4', '9.4', 'MCQ', false, 3,
        'The path of a particle is shown for $0 \le t \le \pi$. The particle’s position is $\mathbf{r}(t) = \langle \\\\\\\cos(t), \\\\\\\sin(t) \rangle$. Which statement is true?', 'image', 'symbolic',
        '[
            {"id": "A", "value": "It moves along the upper semicircle from $(1,0)$ to $(-1,0)$ counterclockwise."},
            {"id": "B", "value": "It moves along the upper semicircle from $(-1,0)$ to $(1,0)$ counterclockwise."},
            {"id": "C", "value": "It moves along the lower semicircle from $(1,0)$ to $(-1,0)$."},
            {"id": "D", "value": "It stays at $(1,0)$ because the position is periodic."}
        ]'::jsonb, 'A',
        'At $t = 0$, $\mathbf{r}(0) = (1,0)$. At $t = \pi$, $\mathbf{r}(\pi) = (-1,0)$. Increasing $t$ traces the unit circle counterclockwise, so on $[0,\pi]$ it traces the upper semicircle from right to left.',
        'vector_valued_function_concept', ARRAY['vector_valued_function_concept', 'vector_component_derivative'], ARRAY['graph_reading_interval_error', 'param_tangent_line_point_mismatch', 'velocity_vs_speed_confusion'],
        NOW(), NOW(), 'published', 1, 'Uses image file: U9_4_P5_vector_path.png'
    );

END $$;
