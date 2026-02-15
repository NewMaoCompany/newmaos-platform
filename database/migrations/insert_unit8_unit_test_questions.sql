-- Insert Unit 8 Unit Test Questions (U8-UT-Q1 to U8-UT-Q20)
-- 
-- Configuration:
-- Topic ID: 'Both_AppIntegration'
-- \frac{Section}{SubTopic} ID: 'unit_test' (lowercase)
-- Representation Type: 'symbolic' (forced)

DO $$
DECLARE
    q_id UUID;
BEGIN

    -- 1. \frac{Insert}{Ensure} Skills
    INSERT INTO public.skills (id, name, unit) VALUES
        ('average_value_formula', 'Average Value Formula', 'Unit8_Applications_of_Integration'),
        ('average_value_from_graph_or_table', 'Average Value from \frac{Graph}{Table}', 'Unit8_Applications_of_Integration'),
        ('average_value_interpretation', 'Interpret Average Value', 'Unit8_Applications_of_Integration'),
        ('total_distance_vs_displacement', 'Total Distance vs Displacement', 'Unit8_Applications_of_Integration'),
        ('motion_position_with_initial_condition', 'Position from Velocity & Initial Cond', 'Unit8_Applications_of_Integration'),
        ('accumulation_from_rate', 'Accumulation from Rate', 'Unit8_Applications_of_Integration'),
        ('net_change_vs_total_change_context', 'Net vs Total Change Context', 'Unit8_Applications_of_Integration'),
        ('area_between_curves_dx_setup', 'Area Between Curves (dx)', 'Unit8_Applications_of_Integration'),
        ('area_between_curves_dy_setup', 'Area Between Curves (dy)', 'Unit8_Applications_of_Integration'),
        ('area_multiple_intersections_split', 'Area with Multiple Intersections', 'Unit8_Applications_of_Integration'),
        ('cross_section_area_function', 'Cross-Section Area Function', 'Unit8_Applications_of_Integration'),
        ('cross_sections_square', 'Volume: Square Cross-Sections', 'Unit8_Applications_of_Integration'),
        ('cross_sections_semicircle', 'Volume: Semicircle Cross-Sections', 'Unit8_Applications_of_Integration'),
        ('volume_disk_method_basic', 'Volume: Disc Method (Basic)', 'Unit8_Applications_of_Integration'),
        ('volume_revolution_about_shifted_axis', 'Volume: Shifted Axis', 'Unit8_Applications_of_Integration'),
        ('volume_revolution_about_x_or_y', 'Volume: About X or Y Axis', 'Unit8_Applications_of_Integration'),
        ('radius_distance_to_axis', 'Radius as Distance to Axis', 'Unit8_Applications_of_Integration'),
        ('arc_length_formula', 'Arc Length Formula', 'Unit8_Applications_of_Integration'),
        ('arc_length_derivative_and_sqrt', 'Arc Length: Derivative & Sqrt', 'Unit8_Applications_of_Integration'),
        ('units_interpretation_in_applications', 'Interpret Units in Integration', 'Unit8_Applications_of_Integration'),
        -- Support Skills (Ensure existence)
        ('bounds_from_context', 'Determine Bounds from Context', 'Unit8_Applications_of_Integration'),
        ('motion_displacement_from_velocity', 'Displacement from Velocity', 'Unit8_Applications_of_Integration'),
        ('solve_intersections_for_bounds', 'Solve Intersections for Bounds', 'Unit8_Applications_of_Integration'),
        ('area_top_minus_bottom_or_right_minus_left', 'Area Setup Strategy', 'Unit8_Applications_of_Integration'),
        ('\\integration_modeling_from_context', 'Modeling with Integration', 'Unit8_Applications_of_Integration')
    ON CONFLICT (id) DO UPDATE SET
        name = EXCLUDED.name,
        unit = EXCLUDED.unit;

    -- 2. \frac{Insert}{Ensure} Error Tags
    INSERT INTO public.error_tags (id, name, category, severity, unit) VALUES
        ('avg_value_missing_divide_by_interval', 'Forgot 1/(b-a)', 'Procedural', 3, 'Unit8_Applications_of_Integration'),
        ('avg_value_wrong_interval_length', 'Wrong Interval Length', 'Algebra', 2, 'Unit8_Applications_of_Integration'),
        ('avg_value_integrand_misread', 'Misread Integrand (Avg Val)', 'Interpretation', 2, 'Unit8_Applications_of_Integration'),
        ('motion_units_mismatch', 'Units Mismatch (Motion)', 'Interpretation', 2, 'Unit8_Applications_of_Integration'),
        ('motion_displacement_distance_confusion', 'Distance vs Displacement Error', 'Conceptual', 3, 'Unit8_Applications_of_Integration'),
        ('motion_sign_mistake', 'Sign Error in Motion', 'Calculation', 2, 'Unit8_Applications_of_Integration'),
        ('motion_forget_initial_condition', 'Forgot Initial Condition', 'Procedural', 3, 'Unit8_Applications_of_Integration'),
        ('accumulation_bounds_misread_context', 'Misread Accumulation Bounds', 'Interpretation', 2, 'Unit8_Applications_of_Integration'),
        ('accumulation_net_vs_total_confusion', 'Net vs Total Confusion', 'Conceptual', 3, 'Unit8_Applications_of_Integration'),
        ('area_wrong_top_minus_bottom', 'Wrong Top-Bottom Order', 'Conceptual', 3, 'Unit8_Applications_of_Integration'),
        ('area_intersections_incorrect', 'Wrong \frac{Intersection}{Bounds}', 'Calculation', 3, 'Unit8_Applications_of_Integration'),
        ('area_missing_abs_value', 'Missing Absolute Value (Area)', 'Conceptual', 2, 'Unit8_Applications_of_Integration'),
        ('area_wrong_dx_dy_choice', 'Wrong \frac{dx}{dy} Choice', 'Strategy', 3, 'Unit8_Applications_of_Integration'),
        ('area_missing_split_interval', 'Missed Interval Split', 'Conceptual', 3, 'Unit8_Applications_of_Integration'),
        ('cross_section_side_length_misread', 'Misread Side Length', 'Interpretation', 2, 'Unit8_Applications_of_Integration'),
        ('cross_section_wrong_area_formula', 'Wrong Cross-Section Formula', 'Conceptual', 3, 'Unit8_Applications_of_Integration'),
        ('volume_missing_pi_factor', 'Missing Pi in Volume', 'Procedural', 2, 'Unit8_Applications_of_Integration'),
        ('volume_forget_square_radius', 'Forgot to Square Radius', 'Conceptual', 3, 'Unit8_Applications_of_Integration'),
        ('volume_wrong_limits', 'Wrong Volume Limits', 'Interpretation', 2, 'Unit8_Applications_of_Integration'),
        ('volume_wrong_axis_distance_shift', 'Wrong Axis Shift', 'Conceptual', 3, 'Unit8_Applications_of_Integration'),
        ('volume_washer_radii_reversed', 'Reversed \frac{Outer}{Inner} Radii', 'Conceptual', 3, 'Unit8_Applications_of_Integration'),
        ('volume_radius_height_swapped', '\frac{Radius}{Height} Swapped', 'Conceptual', 3, 'Unit8_Applications_of_Integration'),
        ('arc_length_missing_sqrt_structure', 'Missing Sqrt Structure', 'Conceptual', 3, 'Unit8_Applications_of_Integration'),
        ('arc_length_wrong_derivative', 'Wrong Derivative in Arc Length', 'Calculation', 3, 'Unit8_Applications_of_Integration'),
        ('arc_length_wrong_bounds', 'Wrong Arc Length Bounds', 'Interpretation', 2, 'Unit8_Applications_of_Integration'),
        ('accumulation_units_mismatch', 'Units Mismatch (Accumulation)', 'Interpretation', 2, 'Unit8_Applications_of_Integration'),
        ('accumulation_wrong_rate_variable', 'Wrong Variable in Rate', 'Algebra', 2, 'Unit8_Applications_of_Integration')
    ON CONFLICT (id) DO UPDATE SET
        name = EXCLUDED.name,
        category = EXCLUDED.category,
        severity = EXCLUDED.severity,
        unit = EXCLUDED.unit;

    -- 3. Cleanup Existing Questions
    DELETE FROM public.questions WHERE title IN (
        'U8-UT-Q1', 'U8-UT-Q2', 'U8-UT-Q3', 'U8-UT-Q4', 'U8-UT-Q5',
        'U8-UT-Q6', 'U8-UT-Q7', 'U8-UT-Q8', 'U8-UT-Q9', 'U8-UT-Q10',
        'U8-UT-Q11', 'U8-UT-Q12', 'U8-UT-Q13', 'U8-UT-Q14', 'U8-UT-Q15',
        'U8-UT-Q16', 'U8-UT-Q17', 'U8-UT-Q18', 'U8-UT-Q19', 'U8-UT-Q20'
    );

    -- 4. Insert Questions

    -- U8-UT-Q1
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U8-UT-Q1', 'Both', 'Both_AppIntegration', 'Both_AppIntegration', 'unit_test', 'unit_test', 'MCQ', false, 3,
        'Let $f(x) = x^2-1$. What is the average value of $f$ on $[0,2]$?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$\\frac{1}{3}$"},
            {"id": "B", "value": "$\\frac{2}{3}$"},
            {"id": "C", "value": "$\\frac{4}{3}$"},
            {"id": "D", "value": "$\\frac{1}{6}$"}
        ]'::jsonb, 'A',
        'Average value is $\frac{1}{2-0} \int_0^2(x^2-1) \, dx = \frac{1}{2} \left[\frac{x^3}{3}-x\right]_0^2 = \frac{1}{3}$.',
        'average_value_formula', ARRAY['average_value_formula', 'bounds_from_context'], ARRAY['avg_value_missing_divide_by_interval', 'avg_value_wrong_interval_length', 'algebra_simplification_error'],
        NOW(), NOW(), 'published', 1
    );

    -- U8-UT-Q2
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version, notes
    ) VALUES (
        'U8-UT-Q2', 'Both', 'Both_AppIntegration', 'Both_AppIntegration', 'unit_test', 'unit_test', 'MCQ', true, 4,
        'A table of $f(x)$ values on $[0,4]$ is shown. Using the trapezoidal rule with $\Delta x = 1$, approximate the average value of $f$ on $[0,4]$.', 'image', 'symbolic',
        '[
            {"id": "A", "value": "$2.25$"},
            {"id": "B", "value": "$2.00$"},
            {"id": "C", "value": "$2.50$"},
            {"id": "D", "value": "$9.00$"}
        ]'::jsonb, 'A',
        'Trapezoidal approximation: $\frac{1}{2}[f_0+2f_1+2f_2+2f_3+f_4] = \frac{1}{2}[2+5+3+6+2] = 9$. Average value is $\frac{1}{4} \cdot 9 = 2.25$.',
        'average_value_from_graph_or_table', ARRAY['average_value_from_graph_or_table', 'average_value_formula'], ARRAY['avg_value_wrong_interval_length', 'avg_value_integrand_misread', 'rounding_too_early'],
        NOW(), NOW(), 'published', 1, 'Uses image file: U8_UT_Q2_avg_table.png'
    );

    -- U8-UT-Q3
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U8-UT-Q3', 'Both', 'Both_AppIntegration', 'Both_AppIntegration', 'unit_test', 'unit_test', 'MCQ', false, 3,
        'A function $P(t)$ gives power output (in kilowatts) over $0\\le t\\le 6$ hours. Which statement best describes the meaning of the average value of $P$ on $[0,6]$?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "The constant power level that would produce the same total energy over 6 hours."},
            {"id": "B", "value": "The total energy produced over 6 hours."},
            {"id": "C", "value": "The maximum power output during the 6 hours."},
            {"id": "D", "value": "The time when the power output is increasing fastest."}
        ]'::jsonb, 'A',
        'Average value represents a constant output whose rectangle area matches the total area under $P(t)$ over the \\interval.',
        'average_value_interpretation', ARRAY['average_value_interpretation', 'units_interpretation_in_applications'], ARRAY['avg_value_missing_divide_by_interval', 'motion_units_mismatch', 'algebra_simplification_error'],
        NOW(), NOW(), 'published', 1
    );

    -- U8-UT-Q4
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version, notes
    ) VALUES (
        'U8-UT-Q4', 'Both', 'Both_AppIntegration', 'Both_AppIntegration', 'unit_test', 'unit_test', 'MCQ', false, 4,
        'The velocity graph $v(t)$ is shown for $0 \le t \le 4$. What is the total distance traveled on $[0,4]$?', 'image', 'symbolic',
        '[
            {"id": "A", "value": "$4.5$"},
            {"id": "B", "value": "$1.5$"},
            {"id": "C", "value": "$0.5$"},
            {"id": "D", "value": "$3.5$"}
        ]'::jsonb, 'A',
        'Total distance is $\int_0^4 |v(t)| \, dt$. From $0$ to $1.5$ area is $\frac{1}{2}(1.5)(3) = 2.25$. From $1.5$ to $2$ area is $\frac12(0.5)(1) = 0.25$. From $2$ to $4$ area is $|-1| \cdot 2 = 2$. Total $= 4.5$.',
        'total_distance_vs_displacement', ARRAY['total_distance_vs_displacement', 'motion_displacement_from_velocity'], ARRAY['motion_displacement_distance_confusion', 'motion_sign_mistake', 'algebra_simplification_error'],
        NOW(), NOW(), 'published', 1, 'Uses image file: U8_UT_Q4_velocity_graph.png'
    );

    -- U8-UT-Q5
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U8-UT-Q5', 'Both', 'Both_AppIntegration', 'Both_AppIntegration', 'unit_test', 'unit_test', 'MCQ', false, 3,
        'A particle has velocity $v(t) = 2t-1$ and position $s(0) = 5$. What is $s(3)$?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$11$"},
            {"id": "B", "value": "$9$"},
            {"id": "C", "value": "$6$"},
            {"id": "D", "value": "$14$"}
        ]'::jsonb, 'A',
        '$s(3) = s(0) + \int_0^3(2t-1) \, dt = 5 + \left[t^2-t\right]_0^3 = 5 + (9-3) = 11$.',
        'motion_position_with_initial_condition', ARRAY['motion_position_with_initial_condition', 'motion_displacement_from_velocity'], ARRAY['motion_forget_initial_condition', 'motion_sign_mistake', 'algebra_simplification_error'],
        NOW(), NOW(), 'published', 1
    );

    -- U8-UT-Q6
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version, notes
    ) VALUES (
        'U8-UT-Q6', 'Both', 'Both_AppIntegration', 'Both_AppIntegration', 'unit_test', 'unit_test', 'MCQ', true, 4,
        'A \\tank’s net flow rate is $r(t)$ (\frac{L}{hr}). A table of $r(t)$ values is shown for $0 \le t \le 4$. Using the trapezoidal rule with $\Delta t = 1$, approximate the net change in volume over $[0,4]$.', 'image', 'symbolic',
        '[
            {"id": "A", "value": "$8.5$ L"},
            {"id": "B", "value": "$17$ L"},
            {"id": "C", "value": "$9.0$ L"},
            {"id": "D", "value": "$6.5$ L"}
        ]'::jsonb, 'A',
        'Trapezoids: $\frac{1}{2}[5+2(3)+2(-1)+2(2)+4] = \frac{1}{2}(17) = 8.5$ liters.',
        'accumulation_from_rate', ARRAY['accumulation_from_rate', 'bounds_from_context'], ARRAY['accumulation_bounds_misread_context', 'accumulation_net_vs_total_confusion', 'rounding_too_early'],
        NOW(), NOW(), 'published', 1, 'Uses image file: U8_UT_Q6_rate_table.png'
    );

    -- U8-UT-Q7
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U8-UT-Q7', 'Both', 'Both_AppIntegration', 'Both_AppIntegration', 'unit_test', 'unit_test', 'MCQ', false, 3,
        'A rate function $r(t)$ can be positive or negative. Which expression represents the total amount of change accumulated over $[a,b]$, regardless of direction?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "∫_a^b r(t) dt"},
            {"id": "B", "value": "∫_a^b |r(t)| dt"},
            {"id": "C", "value": "|∫_a^b r(t) dt|"},
            {"id": "D", "value": "∫_a^b r(t)^2 dt"}
        ]'::jsonb, 'B',
        'Net change is $\\int r(t)dt$. Total change ignores direction and uses $\\int|r(t)|dt$ (splitting where the sign changes).',
        'net_change_vs_total_change_context', ARRAY['net_change_vs_total_change_context', 'accumulation_from_rate'], ARRAY['accumulation_net_vs_total_confusion', 'motion_displacement_distance_confusion', 'accumulation_bounds_misread_context'],
        NOW(), NOW(), 'published', 1
    );

    -- U8-UT-Q8
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version, notes
    ) VALUES (
        'U8-UT-Q8', 'Both', 'Both_AppIntegration', 'Both_AppIntegration', 'unit_test', 'unit_test', 'MCQ', false, 4,
        'The region between $y = 4-x^2$ and $y=x$ is shown. Which \\integral gives the area of the shaded region (with respect to $x$)?', 'image', 'symbolic',
        '[
            {"id": "A", "value": "$\\\int_{(-1-\\sqrt{17})/2}^{(-1+\\sqrt{17})/2} ((4-x^2)-x) \\\, dx$"},
            {"id": "B", "value": "$\\\int_{(-1-\\sqrt{17})/2}^{(-1+\\sqrt{17})/2} (x-(4-x^2)) \\\, dx$"},
            {"id": "C", "value": "$\\\int_{-1}^{2} ((4-x^2)-x) \\\, dx$"},
            {"id": "D", "value": "$|\\\int_{(-1-\\sqrt{17})/2}^{(-1+\\sqrt{17})/2} ((4-x^2)-x) \\\, dx|$"}
        ]'::jsonb, 'A',
        'Area with $dx$ uses top-minus-bottom: $(4-x^2)-x$, with bounds at the \\intersection points solving $4-x^2=x$.',
        'area_between_curves_dx_setup', ARRAY['area_between_curves_dx_setup', 'solve_intersections_for_bounds'], ARRAY['area_wrong_top_minus_bottom', 'area_intersections_incorrect', 'area_missing_abs_value'],
        NOW(), NOW(), 'published', 1, 'Uses image file: U8_UT_Q8_area_between_curves.png'
    );

    -- U8-UT-Q9
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U8-UT-Q9', 'Both', 'Both_AppIntegration', 'Both_AppIntegration', 'unit_test', 'unit_test', 'MCQ', false, 4,
        'The region is bounded by $x=y^2$ and $x=2-y$. Which \\integral gives the area of the region (with respect to $y$)?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$\\\int_{-2}^{1} ((2-y)-y^2) \\\, dy$"},
            {"id": "B", "value": "$\\\int_{-2}^{1} (y^2-(2-y)) \\\, dy$"},
            {"id": "C", "value": "$\\\int_{0}^{2} ((2-y)-y^2) \\\, dy$"},
            {"id": "D", "value": "$\\\int_{-2}^{1} ((2-y)^2-(y^2)^2) \\\, dy$"}
        ]'::jsonb, 'A',
        'With $dy$, use right-minus-left. Intersections solve $y^2 = 2-y$ giving $y=-2,1$. Right curve is $x=2-y$ and left curve is $x=y^2$.',
        'area_between_curves_dy_setup', ARRAY['area_between_curves_dy_setup', 'area_top_minus_bottom_or_right_minus_left'], ARRAY['area_wrong_dx_dy_choice', 'area_wrong_top_minus_bottom', 'area_intersections_incorrect'],
        NOW(), NOW(), 'published', 1
    );

    -- U8-UT-Q10
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U8-UT-Q10', 'Both', 'Both_AppIntegration', 'Both_AppIntegration', 'unit_test', 'unit_test', 'MCQ', false, 4,
        'Which expression equals the area between $y = \\\\\\\sin(x)$ and the $x$-axis on $[0,2\pi]$?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$\\\int_0^{2\\pi} \\sin(x) \\\, dx$"},
            {"id": "B", "value": "$\\\int_0^{\\pi} \\sin(x) \\\, dx - \\\int_{\\pi}^{2\\pi} \\sin(x) \\\, dx$"},
            {"id": "C", "value": "$\\\int_0^{2\\pi} \\sin(x)^2 \\\, dx$"},
            {"id": "D", "value": "$|\\\int_0^{2\\pi} \\sin(x) \\\, dx|$"}
        ]'::jsonb, 'B',
        'Area requires absolute \frac{value}{splitting} when the function changes sign. $\\\\\\\sin(x)$ is positive on $[0,\pi]$ and negative on $[\pi,2\pi]$.',
        'area_multiple_intersections_split', ARRAY['area_multiple_intersections_split', 'area_top_minus_bottom_or_right_minus_left'], ARRAY['area_missing_split_interval', 'area_missing_abs_value', 'area_wrong_top_minus_bottom'],
        NOW(), NOW(), 'published', 1
    );

    -- U8-UT-Q11
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U8-UT-Q11', 'Both', 'Both_AppIntegration', 'Both_AppIntegration', 'unit_test', 'unit_test', 'MCQ', false, 3,
        'A base region is bounded by $y=x$ and $y=2$ for $0 \le x \le 2$. Cross-\\sections perpendicular to the $x$-axis are squares. What is the correct area function $A(x)$?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$(2-x)^2$"},
            {"id": "B", "value": "$(2+x)^2$"},
            {"id": "C", "value": "$2-x$"},
            {"id": "D", "value": "$\\pi(2-x)^2$"}
        ]'::jsonb, 'A',
        'The side length is the vertical distance top-minus-bottom: $2-x$. Square area is $(2-x)^2$.',
        'cross_section_area_function', ARRAY['cross_section_area_function', 'bounds_from_context'], ARRAY['cross_section_side_length_misread', 'cross_section_wrong_area_formula', 'algebra_simplification_error'],
        NOW(), NOW(), 'published', 1
    );

    -- U8-UT-Q12
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version, notes
    ) VALUES (
        'U8-UT-Q12', 'Both', 'Both_AppIntegration', 'Both_AppIntegration', 'unit_test', 'unit_test', 'MCQ', false, 4,
        'The base region $R$ is shown between $y=x$ and $y=2$ for $0 \le x \le 2$. Cross-\\sections perpendicular to the $x$-axis are squares. What is the volume?', 'image', 'symbolic',
        '[
            {"id": "A", "value": "$\\frac{8}{3}$"},
            {"id": "B", "value": "$4$"},
            {"id": "C", "value": "$\\frac{16}{3}$"},
            {"id": "D", "value": "$8\\frac{\\pi}{3}$"}
        ]'::jsonb, 'A',
        'Side length is $2-x$, so $A(x) = (2-x)^2$. Volume $= \int_0^2(2-x)^2 \, dx = \frac{8}{3}$.',
        'cross_sections_square', ARRAY['cross_sections_square', 'cross_section_area_function'], ARRAY['cross_section_wrong_area_formula', 'cross_section_side_length_misread', 'algebra_simplification_error'],
        NOW(), NOW(), 'published', 1, 'Uses image file: U8_UT_Q12_cross_sections_base.png'
    );

    -- U8-UT-Q13
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U8-UT-Q13', 'Both', 'Both_AppIntegration', 'Both_AppIntegration', 'unit_test', 'unit_test', 'MCQ', false, 5,
        'The base region is bounded by $y=x$ and $y=2$ on $0 \le x \le 2$. Cross-\\sections perpendicular to the $x$-axis are semicircles with diameter equal to the vertical distance in the base. What is the volume?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$\\frac{\\pi}{3}$"},
            {"id": "B", "value": "$2\\frac{\\pi}{3}$"},
            {"id": "C", "value": "$\\frac{\\pi}{6}$"},
            {"id": "D", "value": "$8\\frac{\\pi}{3}$"}
        ]'::jsonb, 'A',
        'Diameter is $2-x$, so radius $r = \frac{2-x}{2}$. Semicircle area is $\frac{1}{2}\pi r^2 = \frac{\pi}{8}(2-x)^2$. Volume $= \int_0^2 \frac{\pi}{8}(2-x)^2 \, dx = \frac{\pi}{3}$.',
        'cross_sections_semicircle', ARRAY['cross_sections_semicircle', 'cross_section_area_function'], ARRAY['cross_section_wrong_area_formula', 'cross_section_side_length_misread', 'volume_missing_pi_factor'],
        NOW(), NOW(), 'published', 1
    );

    -- U8-UT-Q14
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U8-UT-Q14', 'Both', 'Both_AppIntegration', 'Both_AppIntegration', 'unit_test', 'unit_test', 'MCQ', false, 4,
        'The region under $y = \sqrt{x}$ from $x=0$ to $x=4$ is revolved about the $x$-axis. What is the volume?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$8\\pi$"},
            {"id": "B", "value": "$4\\pi$"},
            {"id": "C", "value": "$16\\pi$"},
            {"id": "D", "value": "$16\\frac{\\pi}{3}$"}
        ]'::jsonb, 'A',
        'Disc method: $V = \pi \int_0^4(\sqrt{x})^2 \, dx = \pi \int_0^4 x \, dx = \pi \left[\frac{x^2}{2}\right]_0^4 = 8\pi$.',
        'volume_disk_method_basic', ARRAY['volume_disk_method_basic', 'radius_distance_to_axis'], ARRAY['volume_missing_pi_factor', 'volume_forget_square_radius', 'volume_wrong_limits'],
        NOW(), NOW(), 'published', 1
    );

    -- U8-UT-Q15
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version, notes
    ) VALUES (
        'U8-UT-Q15', 'Both', 'Both_AppIntegration', 'Both_AppIntegration', 'unit_test', 'unit_test', 'MCQ', false, 5,
        'The region $x^2 \le y \le 4$ for $-2 \le x \le 2$ is shown and is revolved about $y=1$. Which \\integral gives the volume using washers?', 'image', 'symbolic',
        '[
            {"id": "A", "value": "$\\pi \\\int_{-2}^{2} ((4-1)^2 - (x^2-1)^2) \\\, dx$"},
            {"id": "B", "value": "$\\pi \\\int_{-2}^{2} (4-x^2)^2 \\\, dx$"},
            {"id": "C", "value": "$\\pi \\\int_{-2}^{2} ((4-1) - (x^2-1)) \\\, dx$"},
            {"id": "D", "value": "$\\\int_{-2}^{2} ((4-1)^2 - (x^2-1)^2) \\\, dx$"}
        ]'::jsonb, 'A',
        'About $y = 1$, outer radius is $R = 4-1$ and inner radius is $r = x^2-1$. Washer area is $\pi(R^2-r^2)$.',
        'volume_revolution_about_shifted_axis', ARRAY['volume_revolution_about_shifted_axis', 'radius_distance_to_axis'], ARRAY['volume_wrong_axis_distance_shift', 'volume_washer_radii_reversed', 'volume_forget_square_radius'],
        NOW(), NOW(), 'published', 1, 'Uses image file: U8_UT_Q15_shifted_axis_volume.png'
    );

    -- U8-UT-Q16
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U8-UT-Q16', 'Both', 'Both_AppIntegration', 'Both_AppIntegration', 'unit_test', 'unit_test', 'MCQ', false, 4,
        'The region bounded by $y = x^2$, $y = 4$, and the $y$-axis is revolved about the $y$-axis. Which \\integral gives the volume using disks (with respect to $y$)?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$\\pi \\\int_0^4 y \\\, dy$"},
            {"id": "B", "value": "$\\pi \\\int_0^2 (x^2)^2 \\\, dx$"},
            {"id": "C", "value": "$\\pi \\\int_0^4 \\sqrt{y} \\\, dy$"},
            {"id": "D", "value": "$\\\int_0^4 y \\\, dy$"}
        ]'::jsonb, 'A',
        'At height $y$, the radius to the $y$-axis is $x = \sqrt{y}$, so disc area is $\pi(\sqrt{y})^2 = \pi y$ and bounds are $0 \le y \le 4$.',
        'volume_revolution_about_x_or_y', ARRAY['volume_revolution_about_x_or_y', 'bounds_from_context'], ARRAY['volume_wrong_limits', 'volume_radius_height_swapped', 'volume_missing_pi_factor'],
        NOW(), NOW(), 'published', 1
    );

    -- U8-UT-Q17
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U8-UT-Q17', 'Both', 'Both_AppIntegration', 'Both_AppIntegration', 'unit_test', 'unit_test', 'MCQ', false, 3,
        'A region is revolved about the line $y=1$. If a boundary curve is $y=x^2$, which expression correctly gives the distance from the curve to the axis (a radius) at a given $x$?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$|x^2-1|$"},
            {"id": "B", "value": "$x^2+1$"},
            {"id": "C", "value": "$1-x$"},
            {"id": "D", "value": "$x-1$"}
        ]'::jsonb, 'A',
        'A radius is a distance to the axis, so it must be the absolute vertical distance between $y = x^2$ and $y = 1$.',
        'radius_distance_to_axis', ARRAY['radius_distance_to_axis', 'volume_revolution_about_shifted_axis'], ARRAY['volume_wrong_axis_distance_shift', 'volume_radius_height_swapped', 'algebra_simplification_error'],
        NOW(), NOW(), 'published', 1
    );

    -- U8-UT-Q18 (BC Only)
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version, notes
    ) VALUES (
        'U8-UT-Q18', 'BC', 'Both_AppIntegration', 'Both_AppIntegration', 'unit_test', 'unit_test', 'MCQ', false, 5,
        'The curve $y = \\\\\\\ln(x+1)$ on $0 \le x \le 3$ is shown. Which \\integral gives the arc length of the curve on this \\interval?', 'image', 'symbolic',
        '[
            {"id": "A", "value": "$\\\int_0^3 \\sqrt{1+(1/(x+1))^2} \\\, dx$"},
            {"id": "B", "value": "$\\\int_0^3 (1+1/(x+1)) \\\, dx$"},
            {"id": "C", "value": "$\\\int_0^3 \\sqrt{1+1/(x+1)} \\\, dx$"},
            {"id": "D", "value": "$\\\int_0^3 (1+(1/(x+1))^2) \\\, dx$"}
        ]'::jsonb, 'A',
        'Arc length is $\int_0^3 \sqrt{1+(y'')^2} \, dx$ and for $y = \\\\\\\ln(x+1)$, $y'' = \frac{1}{x+1}$.',
        'arc_length_formula', ARRAY['arc_length_formula', 'arc_length_derivative_and_sqrt'], ARRAY['arc_length_missing_sqrt_structure', 'arc_length_wrong_derivative', 'arc_length_wrong_bounds'],
        NOW(), NOW(), 'published', 1, 'Uses image file: U8_UT_Q18_arc_length_curve.png'
    );

    -- U8-UT-Q19 (BC Only)
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U8-UT-Q19', 'BC', 'Both_AppIntegration', 'Both_AppIntegration', 'unit_test', 'unit_test', 'MCQ', false, 4,
        'Which \\integrand is used to compute the arc length of $y = \\\\\\\sin(x)$ on an \\interval (with respect to $x$)?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$\\sqrt{1+\\cos^2(x)}$"},
            {"id": "B", "value": "$\\sqrt{1+\\sin^2(x)}$"},
            {"id": "C", "value": "$1+\\cos(x)$"},
            {"id": "D", "value": "$1+\\cos^2(x)$"}
        ]'::jsonb, 'A',
        'Arc length \\integrand is $\sqrt{1+(y'')^2}$ and $y'' = \\\\\\\cos(x)$ for $y = \\\\\\\sin(x)$.',
        'arc_length_derivative_and_sqrt', ARRAY['arc_length_derivative_and_sqrt', 'arc_length_formula'], ARRAY['arc_length_missing_sqrt_structure', 'arc_length_wrong_derivative', 'algebra_simplification_error'],
        NOW(), NOW(), 'published', 1
    );

    -- U8-UT-Q20
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U8-UT-Q20', 'Both', 'Both_AppIntegration', 'Both_AppIntegration', 'unit_test', 'unit_test', 'MCQ', false, 3,
        'A function $r(t)$ gives a water flow rate in gallons per hour. Which statement best describes the meaning and units of $\int_2^5 r(t) \, dt$?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "It gives the total gallons added between $t=2$ and $t=5$ (units: gallons)."},
            {"id": "B", "value": "It gives the average flow rate between $t=2$ and $t=5$ (units: gallons per hour)."},
            {"id": "C", "value": "It gives the flow rate at $t=5$ (units: gallons per hour)."},
            {"id": "D", "value": "It gives the time elapsed from $t=2$ to $t=5$ (units: hours)."}
        ]'::jsonb, 'A',
        'Integrating rate (\frac{gallons}{hour}) over time (hours) gives total amount (gallons) accumulated over the \\interval.',
        'units_interpretation_in_applications', ARRAY['units_interpretation_in_applications', '\\integration_modeling_from_context'], ARRAY['accumulation_units_mismatch', 'motion_units_mismatch', 'accumulation_wrong_rate_variable'],
        NOW(), NOW(), 'published', 1
    );

END $$;

