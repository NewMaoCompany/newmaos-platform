-- Insert Unit 8 Part 2 Practice Questions (8.7 - 8.13)
-- 
-- Includes:
-- 1. Skills and Error Tags for Unit 8 Part 2
-- 2. Questions U8.7-P1 to U8.13-P5
-- 3. Ensures correct `topic` ('Both_AppIntegration')
-- 4. Special handling for 8.13 (course='BC')

DO $$
DECLARE
    q_id UUID;
BEGIN

    -- 1. \frac{Insert}{Ensure} Skills
    INSERT INTO public.skills (id, name, unit) VALUES
        ('volume_cross_sections_setup', 'Volume with Cr-Sections Setup', 'Unit8_Applications_of_Integration'),
        ('cross_section_square_area', 'Area of Square Cr-Section', 'Unit8_Applications_of_Integration'),
        ('volume_integral_evaluation', 'Evaluate Volume Integral', 'Unit8_Applications_of_Integration'),
        ('choose_dx_or_dy_strategy_volume', 'Choose \frac{dx}{dy} Strategy (Volume)', 'Unit8_Applications_of_Integration'),
        ('cross_section_rectangle_area', 'Area of Rect Cr-Section', 'Unit8_Applications_of_Integration'),
        ('cross_section_semicircle_area', 'Area of Semicircle Cr-Section', 'Unit8_Applications_of_Integration'),
        ('cross_section_triangle_area', 'Area of Triangle Cr-Section', 'Unit8_Applications_of_Integration'),
        ('numerical_approx_trapezoid_volume', 'Trapezoidal Rule for Volume', 'Unit8_Applications_of_Integration'),
        ('disk_method_setup', 'Disc Method Setup', 'Unit8_Applications_of_Integration'),
        ('disk_method_radius_expression', 'Radius Expression (Disc)', 'Unit8_Applications_of_Integration'),
        ('disk_method_bounds', 'Disc Method Bounds', 'Unit8_Applications_of_Integration'),
        ('axis_shift_handling', 'Handle Axis Shift', 'Unit8_Applications_of_Integration'),
        ('disk_shift_radius_adjustment', 'Radius Adjustment (Shifted Axis)', 'Unit8_Applications_of_Integration'),
        ('disk_method_evaluation', 'Evaluate Disc Method', 'Unit8_Applications_of_Integration'),
        ('washer_method_setup', 'Washer Method Setup', 'Unit8_Applications_of_Integration'),
        ('washer_method_inner_outer_radius', '\frac{Inner}{Outer} Radius ID', 'Unit8_Applications_of_Integration'),
        ('washer_method_evaluation', 'Evaluate Washer Method', 'Unit8_Applications_of_Integration'),
        ('washer_shift_radius_adjustment', 'Washer Radius Shift', 'Unit8_Applications_of_Integration'),
        ('method_selection_disk_vs_washer', 'Select Disc vs Washer', 'Unit8_Applications_of_Integration'),
        ('arc_length_formula_setup', 'Arc Length Formula', 'Unit8_Applications_of_Integration'),
        ('arc_length_derivative_needed', 'Compute Derivative for Arc Length', 'Unit8_Applications_of_Integration'),
        ('arc_length_integrand_build', 'Build Arc Length Integrand', 'Unit8_Applications_of_Integration'),
        ('distance_vs_displacement', 'Distance vs Displacement', 'Unit8_Applications_of_Integration'),
        ('absolute_value_in_distance', 'Absolute Value for Distance', 'Unit8_Applications_of_Integration'),
        ('distance_from_velocity_graph', 'Distance from Velocity Graph', 'Unit8_Applications_of_Integration'),
        ('arc_length_units_interpretation', 'Interpret Arc Length Units', 'Unit8_Applications_of_Integration'),
        ('axis_as_reference_radius', 'Axis as Reference for Radius', 'Unit8_Applications_of_Integration')
    ON CONFLICT (id) DO UPDATE SET
        name = EXCLUDED.name,
        unit = EXCLUDED.unit;

    -- 2. \frac{Insert}{Ensure} Error Tags
    INSERT INTO public.error_tags (id, name, category, severity, unit) VALUES
        ('wrong_cross_section_area_formula', 'Wrong Area Formula', 'Conceptual', 3, 'Unit8_Applications_of_Integration'),
        ('wrong_dx_dy_choice_volume', 'Wrong \frac{dx}{dy} Choice', 'Strategy', 3, 'Unit8_Applications_of_Integration'),
        ('trapezoid_weight_error', 'Trapezoid Weight Error', 'Procedural', 2, 'Unit8_Applications_of_Integration'),
        ('washer_vs_disk_confusion', 'Washer vs Disc Confusion', 'Conceptual', 3, 'Unit8_Applications_of_Integration'),
        ('missing_pi_factor', 'Missing Pi', 'Procedural', 2, 'Unit8_Applications_of_Integration'),
        ('squared_radius_missing', 'Forgot to Square Radius', 'Conceptual', 3, 'Unit8_Applications_of_Integration'),
        ('wrong_radius_expression', 'Wrong Radius Expression', 'Algebra', 3, 'Unit8_Applications_of_Integration'),
        ('wrong_bounds', 'Wrong Bounds', 'Interpretation', 2, 'Unit8_Applications_of_Integration'),
        ('shift_not_applied', 'Axis Shift Not Applied', 'Conceptual', 3, 'Unit8_Applications_of_Integration'),
        ('inner_outer_swapped', '\frac{Inner}{Outer} Swapped', 'Conceptual', 3, 'Unit8_Applications_of_Integration'),
        ('arc_length_missing_sqrt', 'Missing Sqrt (Arc Length)', 'Conceptual', 3, 'Unit8_Applications_of_Integration'),
        ('arc_length_missing_square_on_derivative', 'Missing Square on Deriv', 'Algebra', 3, 'Unit8_Applications_of_Integration'),
        ('distance_equals_displacement_mistake', 'Distance = Displacement Error', 'Conceptual', 3, 'Unit8_Applications_of_Integration'),
        ('missing_absolute_value', 'Missing Absolute Value', 'Conceptual', 3, 'Unit8_Applications_of_Integration'),
        ('signed_area_misread', 'Misread Signed Area', 'Interpretation', 2, 'Unit8_Applications_of_Integration'),
        ('units_mismatch_distance', 'Units Mismatch (Distance)', 'Interpretation', 2, 'Unit8_Applications_of_Integration'),
        ('\\piecewise_interval_missed', 'Missed Piecewise Interval', 'Interpretation', 2, 'Unit8_Applications_of_Integration'),
        ('derivative_error', 'Derivative Error', 'Calculation', 2, 'Unit8_Applications_of_Integration'),
        ('formula_context_confusion', 'Formula Context Confusion', 'Conceptual', 2, 'Unit8_Applications_of_Integration')
    ON CONFLICT (id) DO UPDATE SET
        name = EXCLUDED.name,
        category = EXCLUDED.category,
        severity = EXCLUDED.severity,
        unit = EXCLUDED.unit;

    -- 3. Cleanup Existing Questions
    DELETE FROM public.questions WHERE title IN (
        'U8.7-P1', 'U8.7-P2', 'U8.7-P3', 'U8.7-P4', 'U8.7-P5',
        'U8.8-P1', 'U8.8-P2', 'U8.8-P3', 'U8.8-P4', 'U8.8-P5',
        'U8.9-P1', 'U8.9-P2', 'U8.9-P3', 'U8.9-P4', 'U8.9-P5',
        'U8.10-P1', 'U8.10-P2', 'U8.10-P3', 'U8.10-P4', 'U8.10-P5',
        'U8.11-P1', 'U8.11-P2', 'U8.11-P3', 'U8.11-P4', 'U8.11-P5',
        'U8.12-P1', 'U8.12-P2', 'U8.12-P3', 'U8.12-P4', 'U8.12-P5',
        'U8.13-P1', 'U8.13-P2', 'U8.13-P3', 'U8.13-P4', 'U8.13-P5'
    );

    -- 4. Insert Questions

    -- U8.7-P1
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U8.7-P1', 'Both', 'Both_AppIntegration', 'Both_AppIntegration', 'Practice', '8.7', 'MCQ', false, 4,
        'A solid has base in the region between $y=f(x)$ and $y=g(x)$ on $[a,b]$. Cross-\\sections perpendicular to the $x$-axis are squares. Which \\integral gives the volume?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$\\\int_a^b (f(x)-g(x))^2 \\\, dx$"},
            {"id": "B", "value": "$\\\int_a^b (f(x)-g(x)) \\\, dx$"},
            {"id": "C", "value": "$\\\int_a^b \\pi(f(x)-g(x))^2 \\\, dx$"},
            {"id": "D", "value": "$\\\int_a^b (f(x)^2-g(x)^2) \\\, dx$"}
        ]'::jsonb, 'A',
        'For squares, cross-\\sectional area is $A(x) = \text{side}^2 = (f(x)-g(x))^2$, so $V = \int_a^b A(x) \, dx$.',
        'volume_cross_sections_setup', ARRAY['volume_cross_sections_setup', 'cross_section_square_area'], ARRAY['wrong_cross_section_area_formula', 'area_wrong_top_minus_bottom', 'bounds_from_context'],
        NOW(), NOW(), 'published', 1
    );

    -- U8.7-P2
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version, notes
    ) VALUES (
        'U8.7-P2', 'Both', 'Both_AppIntegration', 'Both_AppIntegration', 'Practice', '8.7', 'MCQ', false, 4,
        'The base region $R$ is shown: $0 \le y \le \sqrt{x}$ for $0 \le x \le 4$. Cross-\\sections perpendicular to the $x$-axis are squares. What is the volume of the solid?', 'image', 'symbolic',
        '[
            {"id": "A", "value": "$8$"},
            {"id": "B", "value": "$4$"},
            {"id": "C", "value": "$16$"},
            {"id": "D", "value": "$\\frac{32}{3}$"}
        ]'::jsonb, 'A',
        'At each $x$, the square side length is $\sqrt{x} - 0 = \sqrt{x}$, so $A(x) = x$. Volume is $\int_0^4 x \, dx = \left[\frac{x^2}{2}\right]_0^4 = 8$.',
        'volume_cross_sections_setup', ARRAY['volume_cross_sections_setup', 'cross_section_square_area'], ARRAY['wrong_cross_section_area_formula', 'bounds_from_context', 'algebra_simplification_error'],
        NOW(), NOW(), 'published', 1, 'Uses image file: U8_7_Q2_base_region.png'
    );

    -- U8.7-P3
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U8.7-P3', 'Both', 'Both_AppIntegration', 'Both_AppIntegration', 'Practice', '8.7', 'MCQ', false, 4,
        'A solid has cross-\\sectional area $A(x) = (x+1)^2$ for $0 \le x \le 2$ (areas are in square units). What is the volume?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$\\frac{26}{3}$"},
            {"id": "B", "value": "$\\frac{13}{3}$"},
            {"id": "C", "value": "$9$"},
            {"id": "D", "value": "$\\frac{8}{3}$"}
        ]'::jsonb, 'A',
        'Volume is $\int_0^2 (x+1)^2 \, dx = \left[\frac{(x+1)^3}{3}\right]_0^2 = \frac{27-1}{3} = \frac{26}{3}$.',
        'volume_integral_evaluation', ARRAY['volume_integral_evaluation', 'volume_cross_sections_setup'], ARRAY['algebra_simplification_error', 'bounds_from_context', 'wrong_cross_section_area_formula'],
        NOW(), NOW(), 'published', 1
    );

    -- U8.7-P4
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version, notes
    ) VALUES (
        'U8.7-P4', 'Both', 'Both_AppIntegration', 'Both_AppIntegration', 'Practice', '8.7', 'MCQ', false, 5,
        'The base region $R$ is shown in the first quadrant, bounded by $x=y^2$, $x=4$, and $y=0$. Cross-\\sections perpendicular to the $y$-axis are rectangles with height $2$. What is the volume?', 'image', 'symbolic',
        '[
            {"id": "A", "value": "$\\frac{32}{3}$"},
            {"id": "B", "value": "$\\frac{16}{3}$"},
            {"id": "C", "value": "$8$"},
            {"id": "D", "value": "$16$"}
        ]'::jsonb, 'A',
        'For a fixed $y$, the base length is $4-y^2$. Rectangle area is $A(y) = 2(4-y^2)$. Volume is $\int_0^2 2(4-y^2) \, dy = \frac{32}{3}$.',
        'choose_dx_or_dy_strategy_volume', ARRAY['choose_dx_or_dy_strategy_volume', 'cross_section_rectangle_area'], ARRAY['wrong_dx_dy_choice_volume', 'wrong_cross_section_area_formula', 'bounds_from_context'],
        NOW(), NOW(), 'published', 1, 'Uses image file: U8_7_Q4_base_region.png'
    );

    -- U8.7-P5
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U8.7-P5', 'Both', 'Both_AppIntegration', 'Both_AppIntegration', 'Practice', '8.7', 'MCQ', false, 3,
        'A solid has base between $y=f(x)$ and $y=g(x)$ on $[a,b]$. Cross-\\sections perpendicular to the $x$-axis are rectangles whose height is $3$ times their base (the base is the vertical distance $f(x)-g(x)$). Which \\integral gives the volume?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$\\\int_a^b 3(f(x)-g(x))^2 \\\, dx$"},
            {"id": "B", "value": "$\\\int_a^b 3(f(x)-g(x)) \\\, dx$"},
            {"id": "C", "value": "$\\\int_a^b (f(x)-g(x))^2 \\\, dx$"},
            {"id": "D", "value": "$\\\int_a^b \\pi(f(x)-g(x))^2 \\\, dx$"}
        ]'::jsonb, 'A',
        'Rectangle area is base times height: $A(x) = (f-g) \cdot 3(f-g) = 3(f-g)^2$, so volume is $\int_a^b 3(f-g)^2 \, dx$.',
        'cross_section_rectangle_area', ARRAY['cross_section_rectangle_area', 'volume_cross_sections_setup'], ARRAY['wrong_cross_section_area_formula', 'area_wrong_top_minus_bottom', 'algebra_simplification_error'],
        NOW(), NOW(), 'published', 1
    );

    -- U8.8-P1
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U8.8-P1', 'Both', 'Both_AppIntegration', 'Both_AppIntegration', 'Practice', '8.8', 'MCQ', false, 4,
        'Cross-\\sections perpendicular to the $x$-axis are semicircles whose diameter is $d(x)$. Which expression is the cross-\\sectional area $A(x)$?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$\\frac{\\pi}{8} \\\, d(x)^2$"},
            {"id": "B", "value": "$\\frac{\\pi}{4} \\\, d(x)^2$"},
            {"id": "C", "value": "$\\frac{\\pi}{2} \\\, d(x)$"},
            {"id": "D", "value": "$\\pi \\\, d(x)^2$"}
        ]'::jsonb, 'A',
        'Radius is $r = \frac{d}{2}$. Semicircle area is $\frac{1}{2}\pi r^2 = \frac{1}{2}\pi\left(\frac{d}{2}\right)^2 = \frac{\pi}{8}d^2$.',
        'cross_section_semicircle_area', ARRAY['cross_section_semicircle_area', 'volume_cross_sections_setup'], ARRAY['wrong_cross_section_area_formula', 'algebra_simplification_error', 'bounds_from_context'],
        NOW(), NOW(), 'published', 1
    );

    -- U8.8-P2
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version, notes
    ) VALUES (
        'U8.8-P2', 'Both', 'Both_AppIntegration', 'Both_AppIntegration', 'Practice', '8.8', 'MCQ', false, 5,
        'The base region $R$ is shown: $0 \le y \le \\\\\\\sin x$ for $0 \le x \le \pi$. Cross-\\sections perpendicular to the $x$-axis are semicircles with diameter $\\\\\\\sin x$. What is the volume?', 'image', 'symbolic',
        '[
            {"id": "A", "value": "$\\pi^\\frac{2}{16}$"},
            {"id": "B", "value": "$\\pi^\\frac{2}{8}$"},
            {"id": "C", "value": "$\\frac{\\pi}{4}$"},
            {"id": "D", "value": "$\\frac{\\pi}{8}$"}
        ]'::jsonb, 'A',
        'Area is $A(x) = \frac{\pi}{8}(\\\\\\\sin x)^2$. Volume is $\int_0^{\pi} \frac{\pi}{8}\\\\\\\sin^2 x \, dx = \frac{\pi}{8} \cdot \frac{\pi}{2} = \frac{\pi^2}{16}$.',
        'volume_cross_sections_setup', ARRAY['volume_cross_sections_setup', 'cross_section_semicircle_area'], ARRAY['wrong_cross_section_area_formula', 'bounds_from_context', 'algebra_simplification_error'],
        NOW(), NOW(), 'published', 1, 'Uses image file: U8_8_Q2_base_region.png'
    );

    -- U8.8-P3
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version, notes
    ) VALUES (
        'U8.8-P3', 'Both', 'Both_AppIntegration', 'Both_AppIntegration', 'Practice', '8.8', 'MCQ', false, 4,
        'The base region $R$ is shown: $0 \le y \le x$ for $0 \le x \le 2$. Cross-\\sections perpendicular to the $x$-axis are right isosceles triangles whose legs equal the vertical width of $R$. What is the volume?', 'image', 'symbolic',
        '[
            {"id": "A", "value": "$\\frac{4}{3}$"},
            {"id": "B", "value": "$\\frac{8}{3}$"},
            {"id": "C", "value": "$2$"},
            {"id": "D", "value": "$\\frac{2}{3}$"}
        ]'::jsonb, 'A',
        'Width is $x$. Triangle area is $A(x) = \frac{1}{2}x^2$. Volume is $\int_0^2 \frac{1}{2}x^2 \, dx = \frac{1}{2} \cdot \frac{8}{3} = \frac{4}{3}$.',
        'cross_section_triangle_area', ARRAY['cross_section_triangle_area', 'volume_cross_sections_setup'], ARRAY['wrong_cross_section_area_formula', 'bounds_from_context', 'algebra_simplification_error'],
        NOW(), NOW(), 'published', 1, 'Uses image file: U8_8_Q3_base_region.png'
    );

    -- U8.8-P4
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version, notes
    ) VALUES (
        'U8.8-P4', 'Both', 'Both_AppIntegration', 'Both_AppIntegration', 'Practice', '8.8', 'MCQ', true, 4,
        'Diameters $d(x)$ for semicircle cross-\\sections are given at $x=0,1,2,3,4$. Using the trapezoidal rule with $\Delta x = 1$, approximate the volume of the solid.', 'image', 'symbolic',
        '[
            {"id": "A", "value": "$33\\frac{\\pi}{16}$"},
            {"id": "B", "value": "$33\\frac{\\pi}{8}$"},
            {"id": "C", "value": "$33\\frac{\\pi}{32}$"},
            {"id": "D", "value": "$11\\frac{\\pi}{4}$"}
        ]'::jsonb, 'A',
        'Area is $A(x) = \frac{\pi}{8}d(x)^2$. Compute $A$ at each point and apply trapezoidal weights: $V \approx \frac{1}{2}(A_0+2(A_1+A_2+A_3)+A_4) = \frac{33\pi}{16}$.',
        'numerical_approx_trapezoid_volume', ARRAY['numerical_approx_trapezoid_volume', 'cross_section_semicircle_area'], ARRAY['trapezoid_weight_error', 'wrong_cross_section_area_formula', 'rounding_too_early'],
        NOW(), NOW(), 'published', 1, 'Uses image file: U8_8_Q4_diameter_table.png'
    );

    -- U8.8-P5
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U8.8-P5', 'Both', 'Both_AppIntegration', 'Both_AppIntegration', 'Practice', '8.8', 'MCQ', false, 3,
        'A solid’s cross-\\sections are taken perpendicular to the $y$-axis. Which setup is always consistent with computing its volume?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "∫ A(x) dx where A is written in terms of x only"},
            {"id": "B", "value": "∫ A(y) dy where A is written in terms of y only"},
            {"id": "C", "value": "∫ (top-bottom) dx"},
            {"id": "D", "value": "∫ (right-left) dx"}
        ]'::jsonb, 'B',
        'If slices are perpendicular to the $y$-axis, thickness is $dy$ and the cross-\\sectional area must be expressed as a function of $y$, so volume is $\\int A(y)\\,dy$ over the appropriate $y$-\\interval.',
        'choose_dx_or_dy_strategy_volume', ARRAY['choose_dx_or_dy_strategy_volume', 'volume_cross_sections_setup'], ARRAY['wrong_dx_dy_choice_volume', 'bounds_from_context', 'wrong_cross_section_area_formula'],
        NOW(), NOW(), 'published', 1
    );

    -- U8.9-P1
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U8.9-P1', 'Both', 'Both_AppIntegration', 'Both_AppIntegration', 'Practice', '8.9', 'MCQ', false, 4,
        'A region bounded by $y=f(x)$ and the $x$-axis on $[a,b]$ is revolved about the $x$-axis. Which \\integral represents the volume using the disc method?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$\\pi \\\int_a^b (f(x))^2 \\\, dx$"},
            {"id": "B", "value": "$\\\int_a^b f(x) \\\, dx$"},
            {"id": "C", "value": "$2\\pi \\\int_a^b f(x) \\\, dx$"},
            {"id": "D", "value": "$\\pi \\\int_a^b f(x) \\\, dx$"}
        ]'::jsonb, 'A',
        'Revolving about the $x$-axis gives circular cross-\\sections with radius $r=f(x)$, so $A(x) = \pi r^2 = \pi(f(x))^2$ and $V = \int_a^b A(x) \, dx$.',
        'disk_method_setup', ARRAY['disk_method_setup', 'disk_method_radius_expression'], ARRAY['washer_vs_disk_confusion', 'missing_pi_factor', 'squared_radius_missing'],
        NOW(), NOW(), 'published', 1
    );

    -- U8.9-P2
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version, notes
    ) VALUES (
        'U8.9-P2', 'Both', 'Both_AppIntegration', 'Both_AppIntegration', 'Practice', '8.9', 'MCQ', false, 4,
        'The region $R$ is shown: $0 \le y \le 2-x$ for $0 \le x \le 2$. The region is revolved about the $x$-axis. What is the volume of the solid?', 'image', 'symbolic',
        '[
            {"id": "A", "value": "$8\\frac{\\pi}{3}$"},
            {"id": "B", "value": "$4\\frac{\\pi}{3}$"},
            {"id": "C", "value": "$8\\pi$"},
            {"id": "D", "value": "$16\\frac{\\pi}{3}$"}
        ]'::jsonb, 'A',
        'Radius is $r=2-x$. Volume is $\pi\int_0^2 (2-x)^2 \, dx = \pi\int_0^2 (4-4x+x^2) \, dx = \pi\left[4x-2x^2+\frac{x^3}{3}\right]_0^2 = \frac{8\pi}{3}$.',
        'disk_method_setup', ARRAY['disk_method_setup', 'disk_method_bounds'], ARRAY['wrong_radius_expression', 'missing_pi_factor', 'wrong_bounds'],
        NOW(), NOW(), 'published', 1, 'Uses image file: U8_9_Q2_disk_xaxis.png'
    );

    -- U8.9-P3
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U8.9-P3', 'Both', 'Both_AppIntegration', 'Both_AppIntegration', 'Practice', '8.9', 'MCQ', false, 5,
        'The region bounded by $x=y^2$, $y=0$, and $y=2$ is revolved about the $y$-axis. Which \\integral represents the volume using discs?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$\\pi \\\int_0^2 (y^2)^2 \\\, dy$"},
            {"id": "B", "value": "$\\pi \\\int_0^2 y^2 \\\, dy$"},
            {"id": "C", "value": "$\\pi \\\int_0^2 (2y)^2 \\\, dy$"},
            {"id": "D", "value": "$\\pi \\\int_0^2 (y^2) \\\, dx$"}
        ]'::jsonb, 'A',
        'Revolving around the $y$-axis uses radius measured horizontally: $r(y) = x = y^2$. Disc area is $\pi r^2 = \pi(y^2)^2$, \\integrated in $y$ from $0$ to $2$.',
        'disk_method_radius_expression', ARRAY['disk_method_radius_expression', 'choose_dx_or_dy_strategy_volume'], ARRAY['wrong_dx_dy_choice_volume', 'wrong_radius_expression', 'squared_radius_missing'],
        NOW(), NOW(), 'published', 1
    );

    -- U8.9-P4
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version, notes
    ) VALUES (
        'U8.9-P4', 'Both', 'Both_AppIntegration', 'Both_AppIntegration', 'Practice', '8.9', 'MCQ', false, 4,
        'The region $R$ is shown: $0 \le x \le y^2$ for $0 \le y \le 2$. The region is revolved about the $y$-axis. What is the volume of the solid?', 'image', 'symbolic',
        '[
            {"id": "A", "value": "$32\\frac{\\pi}{5}$"},
            {"id": "B", "value": "$16\\frac{\\pi}{5}$"},
            {"id": "C", "value": "$32\\frac{\\pi}{3}$"},
            {"id": "D", "value": "$8\\frac{\\pi}{5}$"}
        ]'::jsonb, 'A',
        'Radius is $r(y) = y^2$. Volume is $\pi\int_0^2 (y^2)^2 \, dy = \pi\int_0^2 y^4 \, dy = \pi\left[\frac{y^5}{5}\right]_0^2 = \frac{32\pi}{5}$.',
        'disk_method_setup', ARRAY['disk_method_setup', 'disk_method_evaluation'], ARRAY['missing_pi_factor', 'squared_radius_missing', 'algebra_simplification_error'],
        NOW(), NOW(), 'published', 1, 'Uses image file: U8_9_Q4_disk_yaxis.png'
    );

    -- U8.9-P5
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U8.9-P5', 'Both', 'Both_AppIntegration', 'Both_AppIntegration', 'Practice', '8.9', 'MCQ', false, 4,
        'A region is revolved about the $x$-axis using discs. Which step is necessary to set correct bounds and radius before \\integrating?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "Find where the region \\frac{starts}{ends} along axis, express radius as function of that variable"},
            {"id": "B", "value": "Compute f(b)-f(a) and multiply by π"},
            {"id": "C", "value": "Always \\integrate in y when revolving about the x-axis"},
            {"id": "D", "value": "Use the absolute value of the radius so you do not need bounds"}
        ]'::jsonb, 'A',
        'For disc method, you must determine the \\interval along the slice direction (bounds) and write the radius (distance to the axis) in terms of that variable before forming $\\pi r^2$.',
        'disk_method_bounds', ARRAY['disk_method_bounds', 'disk_method_radius_expression'], ARRAY['wrong_bounds', 'wrong_radius_expression', 'washer_vs_disk_confusion'],
        NOW(), NOW(), 'published', 1
    );

    -- U8.10-P1
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U8.10-P1', 'Both', 'Both_AppIntegration', 'Both_AppIntegration', 'Practice', '8.10', 'MCQ', false, 4,
        'A region is revolved about the horizontal line $y=c$ (not the $x$-axis). Which expression correctly represents the radius if the curve is $y=f(x)$ and the axis is above the curve on the \\interval?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$r(x) = c - f(x)$"},
            {"id": "B", "value": "$r(x) = f(x)$"},
            {"id": "C", "value": "$r(x) = f(x) - c$"},
            {"id": "D", "value": "$r(x) = c + f(x)$"}
        ]'::jsonb, 'A',
        'Radius is the vertical distance from the curve to the line of rotation. If the axis is above the curve, that distance is $c-f(x)$.',
        'axis_shift_handling', ARRAY['axis_shift_handling', 'disk_shift_radius_adjustment'], ARRAY['shift_not_applied', 'wrong_radius_expression', 'squared_radius_missing'],
        NOW(), NOW(), 'published', 1
    );

    -- U8.10-P2
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version, notes
    ) VALUES (
        'U8.10-P2', 'Both', 'Both_AppIntegration', 'Both_AppIntegration', 'Practice', '8.10', 'MCQ', false, 4,
        'The region $R$ is shown: $x^2 \le y \le 2$ for $-\sqrt{2} \le x \le \sqrt{2}$. The region is revolved about the line $y=2$. Which \\integral gives the volume using discs?', 'image', 'symbolic',
        '[
            {"id": "A", "value": "$\\pi \\\int_{-\\sqrt{2}}^{\\sqrt{2}} (2-x^2)^2 \\\, dx$"},
            {"id": "B", "value": "$\\pi \\\int_{-\\sqrt{2}}^{\\sqrt{2}} (x^2)^2 \\\, dx$"},
            {"id": "C", "value": "$\\pi \\\int_{-\\sqrt{2}}^{\\sqrt{2}} (2-x^2) \\\, dx$"},
            {"id": "D", "value": "$\\\int_{-\\sqrt{2}}^{\\sqrt{2}} (2-x^2)^2 \\\, dx$"}
        ]'::jsonb, 'A',
        'Radius is the distance from $y=x^2$ up to the axis $y=2$, so $r(x) = 2-x^2$. Disc area is $\pi r^2 = \pi(2-x^2)^2$.',
        'disk_shift_radius_adjustment', ARRAY['disk_shift_radius_adjustment', 'disk_method_setup'], ARRAY['shift_not_applied', 'missing_pi_factor', 'squared_radius_missing'],
        NOW(), NOW(), 'published', 1, 'Uses image file: U8_10_Q2_shift_y2.png'
    );

    -- U8.10-P3
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U8.10-P3', 'Both', 'Both_AppIntegration', 'Both_AppIntegration', 'Practice', '8.10', 'MCQ', false, 5,
        'The region between $y=x^2$ and $y=2$ is revolved about $y=2$ for $-\sqrt{2} \le x \le \sqrt{2}$. What is the volume?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$128\\sqrt{2}\\frac{\\pi}{15}$"},
            {"id": "B", "value": "$64\\sqrt{2}\\frac{\\pi}{15}$"},
            {"id": "C", "value": "$32\\sqrt{2}\\frac{\\pi}{15}$"},
            {"id": "D", "value": "$128\\frac{\\pi}{15}$"}
        ]'::jsonb, 'A',
        'Volume is $\pi \int_{-\sqrt{2}}^{\sqrt{2}}(2-x^2)^2 \, dx = \pi \int(4-4x^2+x^4) \, dx$. Integrand is even, so $V = 2\pi \left[4x-\frac{4x^3}{3}+\frac{x^5}{5}\right]_0^{\sqrt{2}} = \frac{128\sqrt{2}\pi}{15}$.',
        'disk_shift_radius_adjustment', ARRAY['disk_shift_radius_adjustment', 'disk_method_evaluation'], ARRAY['shift_not_applied', 'algebra_simplification_error', 'wrong_bounds'],
        NOW(), NOW(), 'published', 1
    );

    -- U8.10-P4
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version, notes
    ) VALUES (
        'U8.10-P4', 'Both', 'Both_AppIntegration', 'Both_AppIntegration', 'Practice', '8.10', 'MCQ', false, 4,
        'The region $R$ is shown: $y^2 \le x \le 1$ for $-1 \le y \le 1$. The region is revolved about the line $x=1$. Which \\integral gives the volume using discs (with respect to $y$)?', 'image', 'symbolic',
        '[
            {"id": "A", "value": "$\\pi \\\int_{-1}^{1} (1-y^2)^2 \\\, dy$"},
            {"id": "B", "value": "$\\pi \\\int_{-1}^{1} (y^2)^2 \\\, dy$"},
            {"id": "C", "value": "$\\pi \\\int_{-1}^{1} (1-y^2) \\\, dy$"},
            {"id": "D", "value": "$\\\int_{-1}^{1} (1-y^2)^2 \\\, dy$"}
        ]'::jsonb, 'A',
        'Radius is the horizontal distance from $x=y^2$ to the axis $x = 1$, so $r(y) = 1-y^2$. Disc area is $\pi r^2 = \pi(1-y^2)^2$ \\integrated from $y = -1$ to $1$.',
        'axis_shift_handling', ARRAY['axis_shift_handling', 'choose_dx_or_dy_strategy_volume'], ARRAY['wrong_dx_dy_choice_volume', 'shift_not_applied', 'wrong_radius_expression'],
        NOW(), NOW(), 'published', 1, 'Uses image file: U8_10_Q4_shift_x1.png'
    );

    -- U8.10-P5
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U8.10-P5', 'Both', 'Both_AppIntegration', 'Both_AppIntegration', 'Practice', '8.10', 'MCQ', false, 4,
        'For the solid from rotating the region $y^2 \le x \le 1$ on $-1 \le y \le 1$ about $x=1$, what is the volume?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$16\\frac{\\pi}{15}$"},
            {"id": "B", "value": "$8\\frac{\\pi}{15}$"},
            {"id": "C", "value": "$4\\frac{\\pi}{3}$"},
            {"id": "D", "value": "$2\\frac{\\pi}{3}$"}
        ]'::jsonb, 'A',
        'Volume is $\pi \int_{-1}^{1}(1-y^2)^2 \, dy = \pi \int_{-1}^{1}(1-2y^2+y^4) \, dy$. Integrand is even, so $V = 2\pi \left[y-\frac{2y^3}{3}+\frac{y^5}{5}\right]_0^1 = 2\pi \left(1-\frac{2}{3}+\frac{1}{5}\right) = \frac{16\pi}{15}$.',
        'disk_shift_radius_adjustment', ARRAY['disk_shift_radius_adjustment', 'disk_method_evaluation'], ARRAY['shift_not_applied', 'algebra_simplification_error', 'squared_radius_missing'],
        NOW(), NOW(), 'published', 1
    );

    -- U8.11-P1
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U8.11-P1', 'Both', 'Both_AppIntegration', 'Both_AppIntegration', 'Practice', '8.11', 'MCQ', false, 4,
        'A region is revolved about the $x$-axis and forms washers. If the outer radius is $R(x)$ and inner radius is $r(x)$, which \\integral gives the volume?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$\\pi \\\int_a^b (R(x)^2 - r(x)^2) \\\, dx$"},
            {"id": "B", "value": "$\\pi \\\int_a^b (R(x) - r(x))^2 \\\, dx$"},
            {"id": "C", "value": "$\\\int_a^b (R(x)^2 - r(x)^2) \\\, dx$"},
            {"id": "D", "value": "$2\\pi \\\int_a^b (R(x) - r(x)) \\\, dx$"}
        ]'::jsonb, 'A',
        'Washer area is $\pi R^2 - \pi r^2 = \pi(R^2-r^2)$, so volume is $\pi \int_a^b(R^2-r^2) \, dx$.',
        'washer_method_setup', ARRAY['washer_method_setup', 'washer_method_inner_outer_radius'], ARRAY['washer_vs_disk_confusion', 'inner_outer_swapped', 'squared_radius_missing'],
        NOW(), NOW(), 'published', 1
    );

    -- U8.11-P2
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version, notes
    ) VALUES (
        'U8.11-P2', 'Both', 'Both_AppIntegration', 'Both_AppIntegration', 'Practice', '8.11', 'MCQ', false, 4,
        'The region $R$ is shown between $y=x$ and $y=2$ for $0 \le x \le 2$. The region is revolved about the $x$-axis. What is the volume?', 'image', 'symbolic',
        '[
            {"id": "A", "value": "$16\\frac{\\pi}{3}$"},
            {"id": "B", "value": "$8\\frac{\\pi}{3}$"},
            {"id": "C", "value": "$4\\pi$"},
            {"id": "D", "value": "$20\\frac{\\pi}{3}$"}
        ]'::jsonb, 'A',
        'Outer radius is $R(x)=2$ and inner radius is $r(x)=x$. Volume is $\pi \int_0^2(2^2-x^2) \, dx = \pi \left[4x-\frac{x^3}{3}\right]_0^2 = \frac{16\pi}{3}$.',
        'washer_method_setup', ARRAY['washer_method_setup', 'washer_method_inner_outer_radius'], ARRAY['inner_outer_swapped', 'squared_radius_missing', 'missing_pi_factor'],
        NOW(), NOW(), 'published', 1, 'Uses image file: U8_11_Q2_washer_xaxis.png'
    );

    -- U8.11-P3
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U8.11-P3', 'Both', 'Both_AppIntegration', 'Both_AppIntegration', 'Practice', '8.11', 'MCQ', false, 5,
        'A region bounded by $x=1$, $x=y^2$, $y=0$, and $y=1$ is revolved about the $y$-axis. Using washers, which setup is correct (in terms of $y$)?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$\\pi \\\int_0^1 (1^2 - (y^2)^2) \\\, dy$"},
            {"id": "B", "value": "$\\pi \\\int_0^1 ((y^2)^2 - 1^2) \\\, dy$"},
            {"id": "C", "value": "$\\pi \\\int_0^1 (1 - y^2)^2 \\\, dy$"},
            {"id": "D", "value": "$\\pi \\\int_0^1 (1^2 - y^2) \\\, dy$"}
        ]'::jsonb, 'A',
        'About the $y$-axis, radii are horizontal distances. Outer radius is $R(y)=1$ and inner radius is $r(y)=y^2$, so $V = \pi \int_0^1 (R^2-r^2) \, dy = \pi \int_0^1(1-y^4) \, dy$.',
        'choose_dx_or_dy_strategy_volume', ARRAY['choose_dx_or_dy_strategy_volume', 'washer_method_setup'], ARRAY['wrong_dx_dy_choice_volume', 'inner_outer_swapped', 'wrong_radius_expression'],
        NOW(), NOW(), 'published', 1
    );

    -- U8.11-P4
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version, notes
    ) VALUES (
        'U8.11-P4', 'Both', 'Both_AppIntegration', 'Both_AppIntegration', 'Practice', '8.11', 'MCQ', false, 4,
        'The region $R$ is shown between $x=y^2$ and $x=1$ for $0 \le y \le 1$. The region is revolved about the $y$-axis. What is the volume?', 'image', 'symbolic',
        '[
            {"id": "A", "value": "$4\\frac{\\pi}{5}$"},
            {"id": "B", "value": "$\\frac{\\pi}{5}$"},
            {"id": "C", "value": "$3\\frac{\\pi}{5}$"},
            {"id": "D", "value": "$\\frac{\\pi}{2}$"}
        ]'::jsonb, 'A',
        'Outer radius is $R(y)=1$ and inner radius is $r(y)=y^2$. Volume is $\pi \int_0^1(1-y^4) \, dy = \pi \left[y-\frac{y^5}{5}\right]_0^1 = \frac{4\pi}{5}$.',
        'washer_method_evaluation', ARRAY['washer_method_evaluation', 'washer_method_setup'], ARRAY['inner_outer_swapped', 'missing_pi_factor', 'algebra_simplification_error'],
        NOW(), NOW(), 'published', 1, 'Uses image file: U8_11_Q4_washer_yaxis.png'
    );

    -- U8.11-P5
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U8.11-P5', 'Both', 'Both_AppIntegration', 'Both_AppIntegration', 'Practice', '8.11', 'MCQ', false, 4,
        'When revolving a region about the $y$-axis using washers (with respect to $y$), what do the radii represent?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "Vertical distances from the curve to the axis"},
            {"id": "B", "value": "Horizontal distances from the curve to the axis"},
            {"id": "C", "value": "Slopes of the bounding curves"},
            {"id": "D", "value": "Arc lengths of the bounding curves"}
        ]'::jsonb, 'B',
        'About the $y$-axis, the radius is measured horizontally (distance in the $x$-direction) from the axis to the curve that forms the \frac{outer}{inner} boundary.',
        'washer_method_inner_outer_radius', ARRAY['washer_method_inner_outer_radius', 'axis_as_reference_radius'], ARRAY['wrong_radius_expression', 'inner_outer_swapped', 'shift_not_applied'],
        NOW(), NOW(), 'published', 1
    );

    -- U8.12-P1
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U8.12-P1', 'Both', 'Both_AppIntegration', 'Both_AppIntegration', 'Practice', '8.12', 'MCQ', false, 4,
        'A region is revolved about the horizontal line $y=c$ and forms washers. If the top curve is $y=\text{top}(x)$ and the bottom curve is $y=\text{bot}(x)$ with $\text{bot}(x) \le \text{top}(x) \le c$, what are the outer and inner radii?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$R(x) = c-\\text{bot}(x), r(x) = c-\\text{top}(x)$"},
            {"id": "B", "value": "$R(x) = \\text{top}(x)-c, r(x) = \\text{bot}(x)-c$"},
            {"id": "C", "value": "$R(x) = \\text{top}(x)-\\text{bot}(x), r(x) = 0$"},
            {"id": "D", "value": "$R(x) = c-\\text{top}(x), r(x) = c-\\text{bot}(x)$"}
        ]'::jsonb, 'A',
        'Distances are measured to the axis $y=c$. The farther curve (bottom) gives the outer radius $R = c-\text{bot}(x)$, and the nearer curve (top) gives the inner radius $r = c-\text{top}(x)$.',
        'axis_shift_handling', ARRAY['axis_shift_handling', 'washer_shift_radius_adjustment'], ARRAY['shift_not_applied', 'wrong_radius_expression', 'inner_outer_swapped'],
        NOW(), NOW(), 'published', 1
    );

    -- U8.12-P2
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version, notes
    ) VALUES (
        'U8.12-P2', 'Both', 'Both_AppIntegration', 'Both_AppIntegration', 'Practice', '8.12', 'MCQ', false, 5,
        'The region $R$ is shown: $x^2 \le y \le 4$ for $-2 \le x \le 2$. The region is revolved about the line $y = 1$. Which \\integral gives the volume using washers?', 'image', 'symbolic',
        '[
            {"id": "A", "value": "$\\pi \\\int_{-2}^{2} ((4-1)^2 - (x^2-1)^2) \\\, dx$"},
            {"id": "B", "value": "$\\pi \\\int_{-2}^{2} (4-x^2)^2 \\\, dx$"},
            {"id": "C", "value": "$\\pi \\\int_{-2}^{2} ((4-1) - (x^2-1)) \\\, dx$"},
            {"id": "D", "value": "$\\\int_{-2}^{2} ((4-1)^2 - (x^2-1)^2) \\\, dx$"}
        ]'::jsonb, 'A',
        'About $y=1$, outer radius is $R = 4-1 = 3$ and inner radius is $r = x^2-1$ (distance from $y=x^2$ to $y = 1$). Washer area is $\pi(R^2-r^2)$.',
        'washer_shift_radius_adjustment', ARRAY['washer_shift_radius_adjustment', 'washer_method_setup'], ARRAY['shift_not_applied', 'inner_outer_swapped', 'squared_radius_missing'],
        NOW(), NOW(), 'published', 1, 'Uses image file: U8_12_Q2_washer_y1.png'
    );

    -- U8.12-P3
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U8.12-P3', 'Both', 'Both_AppIntegration', 'Both_AppIntegration', 'Practice', '8.12', 'MCQ', false, 5,
        'For the region $x^2 \le y \le 4$ on $-2 \le x \le 2$ revolved about $y = 1$, what is the volume?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$544\\frac{\\pi}{15}$"},
            {"id": "B", "value": "$272\\frac{\\pi}{15}$"},
            {"id": "C", "value": "$424\\frac{\\pi}{15}$"},
            {"id": "D", "value": "$544\\frac{\\pi}{5}$"}
        ]'::jsonb, 'A',
        'Volume is $\pi \int_{-2}^{2}(3^2-(x^2-1)^2) \, dx = \pi \int_{-2}^{2}(9-(x^4-2x^2+1)) \, dx = \pi \int_{-2}^{2}(8+2x^2-x^4) \, dx = \frac{544\pi}{15}$.',
        'washer_method_evaluation', ARRAY['washer_method_evaluation', 'washer_shift_radius_adjustment'], ARRAY['shift_not_applied', 'algebra_simplification_error', 'inner_outer_swapped'],
        NOW(), NOW(), 'published', 1
    );

    -- U8.12-P4
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version, notes
    ) VALUES (
        'U8.12-P4', 'Both', 'Both_AppIntegration', 'Both_AppIntegration', 'Practice', '8.12', 'MCQ', true, 4,
        'The region $R$ is shown: $0 \le y \le \\\\\\\sin(x)$ for $0 \le x \le \pi$. The region is revolved about the line $y = 2$. Using washers and the trapezoidal rule with 4 subintervals, approximate the volume.', 'image', 'symbolic',
        '[
            {"id": "A", "value": "Approximately $15.5$"},
            {"id": "B", "value": "Approximately $9.7$"},
            {"id": "C", "value": "Approximately $6.3$"},
            {"id": "D", "value": "Approximately $19.4$"}
        ]'::jsonb, 'A',
        'Outer radius is $R=2-0 = 2$ and inner radius is $r = 2-\\\\\\\sin(x)$. Volume \\integrand is $\pi(R^2-r^2) = \pi(4-(2-\\\\\\\sin x)^2)$. Apply trapezoidal rule on $[0,\pi]$ with $\Delta x = \frac{\pi}{4}$ to get about 15.5.',
        'washer_shift_radius_adjustment', ARRAY['washer_shift_radius_adjustment', 'numerical_approx_trapezoid_volume'], ARRAY['shift_not_applied', 'trapezoid_weight_error', 'rounding_too_early'],
        NOW(), NOW(), 'published', 1, 'Uses image file: U8_12_Q4_washer_y2.png'
    );

    -- U8.12-P5
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U8.12-P5', 'Both', 'Both_AppIntegration', 'Both_AppIntegration', 'Practice', '8.12', 'MCQ', false, 4,
        'A region is revolved about a line and the cross-\\sections perpendicular to the axis of rotation have a hole. Which method matches this situation?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "Disc method"},
            {"id": "B", "value": "Washer method"},
            {"id": "C", "value": "Average value method"},
            {"id": "D", "value": "Trapezoidal rule for area only"}
        ]'::jsonb, 'B',
        'A hole means you subtract an inner radius from an outer radius, which is exactly the washer method setup $\\pi(R^2-r^2)$.',
        'method_selection_disk_vs_washer', ARRAY['method_selection_disk_vs_washer', 'axis_shift_handling'], ARRAY['washer_vs_disk_confusion', 'shift_not_applied', 'inner_outer_swapped'],
        NOW(), NOW(), 'published', 1
    );

    -- U8.13-P1 (BC Only)
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U8.13-P1', 'BC', 'Both_AppIntegration', 'Both_AppIntegration', 'Practice', '8.13', 'MCQ', false, 4,
        'Which \\integral represents the arc length of $y = f(x)$ on $[a,b]$?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$\\\int_a^b \\sqrt{1+(f''(x))^2} \\\, dx$"},
            {"id": "B", "value": "$\\\int_a^b (1+f''(x)) \\\, dx$"},
            {"id": "C", "value": "$\\\int_a^b \\sqrt{1+f''(x)} \\\, dx$"},
            {"id": "D", "value": "$\\\int_a^b (1+f''(x)^2) \\\, dx$"}
        ]'::jsonb, 'A',
        'Arc length for $y = f(x)$ on $[a,b]$ is $\int_a^b \sqrt{1+(f''(x))^2} \, dx$.',
        'arc_length_formula_setup', ARRAY['arc_length_formula_setup', 'arc_length_derivative_needed'], ARRAY['arc_length_missing_sqrt', 'arc_length_missing_square_on_derivative', 'wrong_bounds'],
        NOW(), NOW(), 'published', 1
    );

    -- U8.13-P2 (BC Only)
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version, notes
    ) VALUES (
        'U8.13-P2', 'BC', 'Both_AppIntegration', 'Both_AppIntegration', 'Practice', '8.13', 'MCQ', false, 5,
        'The curve $y = \frac{1}{4}x^2$ on $0 \le x \le 2$ is shown. Which \\integral gives its arc length?', 'image', 'symbolic',
        '[
            {"id": "A", "value": "$\\\int_0^2 \\sqrt{1+(\\frac{x}{2})^2} \\\, dx$"},
            {"id": "B", "value": "$\\\int_0^2 (1+\\frac{x}{2}) \\\, dx$"},
            {"id": "C", "value": "$\\\int_0^2 \\sqrt{1+\\frac{x}{2}} \\\, dx$"},
            {"id": "D", "value": "$\\\int_0^2 (1+(\\frac{x}{2})^2) \\\, dx$"}
        ]'::jsonb, 'A',
        'Here $f(x) = \frac{1}{4}x^2$ so $f''(x) = \frac{x}{2}$. Arc length is $\int_0^2 \sqrt{1+(f''(x))^2} \, dx = \int_0^2 \sqrt{1+\left(\frac{x}{2}\right)^2} \, dx$.',
        'arc_length_integrand_build', ARRAY['arc_length_integrand_build', 'arc_length_derivative_needed'], ARRAY['arc_length_missing_sqrt', 'arc_length_missing_square_on_derivative', 'derivative_error'],
        NOW(), NOW(), 'published', 1, 'Uses image file: U8_13_Q2_arc_curve.png'
    );

    -- U8.13-P3 (BC Only)
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U8.13-P3', 'BC', 'Both_AppIntegration', 'Both_AppIntegration', 'Practice', '8.13', 'MCQ', false, 4,
        'A particle has velocity $v(t)$ on $[a,b]$. Which expression gives the total distance traveled?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$\\\int_a^b v(t) \\\, dt$"},
            {"id": "B", "value": "$\\\int_a^b |v(t)| \\\, dt$"},
            {"id": "C", "value": "$|\\\int_a^b v(t) \\\, dt|$"},
            {"id": "D", "value": "$\\\int_a^b v(t)^2 \\\, dt$"}
        ]'::jsonb, 'B',
        'Displacement is $\int_a^b v(t) \, dt$, but total distance counts motion in either direction, so use $\int_a^b |v(t)| \, dt$.',
        'distance_vs_displacement', ARRAY['distance_vs_displacement', 'absolute_value_in_distance'], ARRAY['distance_equals_displacement_mistake', 'missing_absolute_value', 'signed_area_misread'],
        NOW(), NOW(), 'published', 1
    );

    -- U8.13-P4 (BC Only)
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version, notes
    ) VALUES (
        'U8.13-P4', 'BC', 'Both_AppIntegration', 'Both_AppIntegration', 'Practice', '8.13', 'MCQ', false, 5,
        'The velocity graph $v(t)$ is shown. The particle moves from $t = 0$ to $t = 3$. What is the total distance traveled?', 'image', 'symbolic',
        '[
            {"id": "A", "value": "$5$"},
            {"id": "B", "value": "$3$"},
            {"id": "C", "value": "$1$"},
            {"id": "D", "value": "$7$"}
        ]'::jsonb, 'A',
        'From $0$ to $1$, $v > 0$ and area is $1$. From $1$ to $2$, $v < 0$ and absolute area is $1$. From $2$ to $3$, $v = -2$ so distance adds $2$. Total distance $= 1+1+2=5$.',
        'distance_from_velocity_graph', ARRAY['distance_from_velocity_graph', 'absolute_value_in_distance'], ARRAY['missing_absolute_value', 'signed_area_misread', '\\piecewise_interval_missed'],
        NOW(), NOW(), 'published', 1, 'Uses image file: U8_13_Q4_velocity_graph.png'
    );

    -- U8.13-P5 (BC Only)
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U8.13-P5', 'BC', 'Both_AppIntegration', 'Both_AppIntegration', 'Practice', '8.13', 'MCQ', false, 4,
        'A function $v(t)$ gives velocity in meters per \\second. Which statement is correct about the units of $\\int_0^5 |v(t)|\\,dt$?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "It has units of meters and represents total distance traveled."},
            {"id": "B", "value": "It has units of meters per \\second and represents average velocity."},
            {"id": "C", "value": "It has units of \\seconds and represents total time traveled."},
            {"id": "D", "value": "It is unitless because of the absolute value."}
        ]'::jsonb, 'A',
        'Velocity (\frac{m}{s}) times time (s) gives meters. Using $|v(t)|$ makes it total distance rather than signed displacement.',
        'arc_length_units_interpretation', ARRAY['arc_length_units_interpretation', 'distance_vs_displacement'], ARRAY['units_mismatch_distance', 'distance_equals_displacement_mistake', 'formula_context_confusion'],
        NOW(), NOW(), 'published', 1
    );

END $$;

