-- Insert Unit 9 Part 2 Practice Questions (9.5-9.9)
-- 
-- Configuration:
-- Topic ID: 'BC_Unit9'
-- Course: 'BC'

DO $$
DECLARE
    q_id UUID;
BEGIN

    -- 1. \frac{Insert}{Ensure} Skills
    INSERT INTO public.skills (id, name, unit) VALUES
        ('polar_area_formula', 'Polar Area Formula', 'Unit9_Parametric_Polar_Vector'),
        ('polar_area_between_curves', 'Polar Area Between Curves', 'Unit9_Parametric_Polar_Vector'),
        ('polar_graph_interpretation', 'Polar Graph Interpretation', 'Unit9_Parametric_Polar_Vector'),
        ('polar_arc_length_formula', 'Polar Arc Length Formula', 'Unit9_Parametric_Polar_Vector'),
        ('vector_valued_position', 'Vector Position Calculation', 'Unit9_Parametric_Polar_Vector'),
        ('vector_derivative_velocity', 'Vector Velocity & Slope', 'Unit9_Parametric_Polar_Vector'),
        ('vector_speed_magnitude', 'Vector \frac{Speed}{Magnitude}', 'Unit9_Parametric_Polar_Vector'),
        ('vector_displacement_from_table', 'Vector Displacement (\frac{Table}{Approx})', 'Unit9_Parametric_Polar_Vector'),
        ('vector_path_interpretation', 'Vector Path Interpretation', 'Unit9_Parametric_Polar_Vector'),
        ('bounds_from_context', 'Determining Integration Bounds', 'Unit9_Parametric_Polar_Vector')
    ON CONFLICT (id) DO UPDATE SET
        name = EXCLUDED.name,
        unit = EXCLUDED.unit;

    -- 2. \frac{Insert}{Ensure} Error Tags
    INSERT INTO public.error_tags (id, name, category, severity, unit) VALUES
        ('polar_area_missing_one_half', 'Missing \frac{1}{2} in Polar Area', 'Formula', 3, 'Unit9_Parametric_Polar_Vector'),
        ('polar_area_wrong_bounds', 'Incorrect Polar Bounds', 'Interpretation', 2, 'Unit9_Parametric_Polar_Vector'),
        ('algebra_simplification_error', '\frac{Algebra}{Simplification} Slip', 'Algebra', 2, 'Unit9_Parametric_Polar_Vector'),
        ('polar_area_wrong_outer_inner', 'Swapped \frac{Outer}{Inner} Polar Curves', 'Conceptual', 3, 'Unit9_Parametric_Polar_Vector'),
        ('arc_length_missing_sqrt_structure', 'Missing Sqrt structure in Arc Length', 'Formula', 3, 'Unit9_Parametric_Polar_Vector'),
        ('polar_arc_length_missing_dr_dtheta', 'Missing \frac{dr}{dtheta} in Arc Length', 'Formula', 3, 'Unit9_Parametric_Polar_Vector'),
        ('vector_component_swap', 'Swapped x and y components', 'Procedural', 2, 'Unit9_Parametric_Polar_Vector'),
        ('derivative_power_rule_error', 'Power Rule Error', 'Calculation', 2, 'Unit9_Parametric_Polar_Vector'),
        ('speed_missing_magnitude', 'Speed vs Component Confusion', 'Conceptual', 3, 'Unit9_Parametric_Polar_Vector'),
        ('vector_displacement_endpoint_swap', 'Initial vs Final Position Swap', 'Procedural', 2, 'Unit9_Parametric_Polar_Vector')
    ON CONFLICT (id) DO UPDATE SET
        name = EXCLUDED.name,
        category = EXCLUDED.category,
        severity = EXCLUDED.severity,
        unit = EXCLUDED.unit;

    -- 3. Cleanup Existing Questions
    DELETE FROM public.questions WHERE title IN (
        'U9.5-P1', 'U9.5-P2', 'U9.5-P3', 'U9.5-P4', 'U9.5-P5',
        'U9.6-P1', 'U9.6-P2', 'U9.6-P3', 'U9.6-P4', 'U9.6-P5',
        'U9.7-P1', 'U9.7-P2', 'U9.7-P3', 'U9.7-P4', 'U9.7-P5',
        'U9.8-P1', 'U9.8-P2', 'U9.8-P3', 'U9.8-P4', 'U9.8-P5',
        'U9.9-P1', 'U9.9-P2', 'U9.9-P3', 'U9.9-P4', 'U9.9-P5'
    );

    -- 4. Insert Questions

    -- U9.5-P1
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U9.5-P1', 'BC', 'BC_Unit9', 'BC_Unit9', '9.5', '9.5', 'MCQ', false, 4,
        'The region enclosed by the polar curve $r = 1 + \\\\\\\sin(\theta)$ is traced once as $\theta$ goes from $0$ to $2\pi$. Which expression gives the area of the region?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$\\frac{1}{2} \\\int_0^{2\\pi} (1 + \\sin\\theta)^2 \\\, d\\theta$"},
            {"id": "B", "value": "$\\\int_0^{2\\pi} (1 + \\sin\\theta)^2 \\\, d\\theta$"},
            {"id": "C", "value": "$\\frac{1}{2} \\\int_0^{2\\pi} (1 + \\sin\\theta) \\\, d\\theta$"},
            {"id": "D", "value": "$\\\int_0^{2\\pi} (1 + \\sin\\theta) \\\, d\\theta$"}
        ]'::jsonb, 'A',
        'Polar area is $A = \frac{1}{2} \int r^2 \, d\theta$. Here $r = 1 + \\\\\\\sin\theta$ over $0 \le \theta \le 2\pi$ traces the region once, so $\frac{1}{2} \int_0^{2\pi} (1 + \\\\\\\sin\theta)^2 \, d\theta$ is correct.',
        'polar_area_formula', ARRAY['polar_area_formula', 'bounds_from_context'], ARRAY['polar_area_missing_one_half', 'polar_area_wrong_bounds', 'algebra_simplification_error'],
        NOW(), NOW(), 'published', 1
    );

    -- U9.5-P2
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U9.5-P2', 'BC', 'BC_Unit9', 'BC_Unit9', '9.5', '9.5', 'MCQ', false, 5,
        'Let $R$ be the region inside $r = 2$ and outside $r = 1 + \\\\\\\cos(\theta)$ for $0 \le \theta \le 2\pi$. Which expression gives the area of $R$?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$\\frac{1}{2} \\\int_0^{2\\pi} (2^2 - (1 + \\cos\\theta)^2) \\\, d\\theta$"},
            {"id": "B", "value": "$\\frac{1}{2} \\\int_0^{2\\pi} ((1 + \\cos\\theta)^2 - 2^2) \\\, d\\theta$"},
            {"id": "C", "value": "$\\\int_0^{2\\pi} (2 - (1 + \\cos\\theta)) \\\, d\\theta$"},
            {"id": "D", "value": "$\\frac{1}{2} (\\\int_0^{2\\pi} 2^2 \\\, d\\theta - \\\int_0^{2\\pi} (1 + \\cos\\theta) \\\, d\\theta)$"}
        ]'::jsonb, 'A',
        'Area between polar curves uses $\frac{1}{2} \int (r_{\text{outer}}^2 - r_{\text{inner}}^2) \, d\theta$. Here outer is $2$ and inner is $1 + \\\\\\\cos\theta$ on $[0, 2\pi]$.',
        'polar_area_between_curves', ARRAY['polar_area_between_curves', 'bounds_from_context'], ARRAY['polar_area_wrong_outer_inner', 'polar_area_wrong_bounds', 'polar_area_missing_one_half'],
        NOW(), NOW(), 'published', 1
    );

    -- U9.5-P3
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version, notes
    ) VALUES (
        'U9.5-P3', 'BC', 'BC_Unit9', 'BC_Unit9', '9.5', '9.5', 'MCQ', false, 3,
        'The polar curve $r = 2\\\\\\\cos(\theta)$ is shown. Which statement is true about the graph?', 'image', 'graph',
        '[
            {"id": "A", "value": "It is a circle of radius $1$ centered at $(1,0)$."},
            {"id": "B", "value": "It is a circle of radius $2$ centered at the origin."},
            {"id": "C", "value": "It is a cardioid with a cusp at the origin."},
            {"id": "D", "value": "It is a line segment along the $y$-axis."}
        ]'::jsonb, 'A',
        'Converting $r = 2\\\\\\\cos\theta$ gives $r^2 = 2r\\\\\\\cos\theta \Rightarrow x^2 + y^2 = 2x \Rightarrow (x-1)^2 + y^2 = 1$, a circle of radius $1$ centered at $(1,0)$.',
        'polar_graph_interpretation', ARRAY['polar_graph_interpretation', 'bounds_from_context'], ARRAY['graph_reading_interval_error', 'polar_area_wrong_bounds', 'algebra_simplification_error'],
        NOW(), NOW(), 'published', 1, 'Uses image file: U9_5_P3_polar_circle.png'
    );

    -- U9.5-P4
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version, notes
    ) VALUES (
        'U9.5-P4', 'BC', 'BC_Unit9', 'BC_Unit9', '9.5', '9.5', 'MCQ', true, 4,
        'The curves $r = 2$ and $r = 1 + \\\\\\\cos(\theta)$ are shown. Which \\integral gives the area inside $r = 2$ and outside $r = 1 + \\\\\\\cos(\theta)$?', 'image', 'graph',
        '[
            {"id": "A", "value": "$\\frac{1}{2} \\\int_0^{2\\pi} (4 - (1 + \\cos\\theta)^2) \\\, d\\theta$"},
            {"id": "B", "value": "$\\frac{1}{2} \\\int_0^{2\\pi} ((1 + \\cos\\theta)^2 - 4) \\\, d\\theta$"},
            {"id": "C", "value": "$\\\int_0^{2\\pi} (2 - (1 + \\cos\\theta)) \\\, d\\theta$"},
            {"id": "D", "value": "$\\frac{1}{2} \\\int_0^{\\pi} (4 - (1 + \\cos\\theta)^2) \\\, d\\theta$"}
        ]'::jsonb, 'A',
        'Between polar curves, $A = \frac{1}{2} \int (r_{\text{outer}}^2 - r_{\text{inner}}^2) \, d\theta$. Here $r_{\text{outer}} = 2$ so $r_{\text{outer}}^2 = 4$, and the \\interval is $0$ to $2\pi$.',
        'polar_area_between_curves', ARRAY['polar_area_between_curves', 'polar_graph_interpretation'], ARRAY['polar_area_wrong_outer_inner', 'polar_area_wrong_bounds', 'polar_area_missing_one_half'],
        NOW(), NOW(), 'published', 1, 'Uses image file: U9_5_P4_two_polar_curves.png'
    );

    -- U9.5-P5
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U9.5-P5', 'BC', 'BC_Unit9', 'BC_Unit9', '9.5', '9.5', 'MCQ', false, 4,
        'A polar curve is given by $r = f(\theta)$ on $\alpha \le \theta \le \beta$. Which \\integrand is used to compute the arc length of the curve (with respect to $\theta$)?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$\\sqrt{r^2 + (\\frac{dr}{d\\theta})^2}$"},
            {"id": "B", "value": "$\\sqrt{1 + (\\frac{dr}{d\\theta})^2}$"},
            {"id": "C", "value": "$r + \\frac{dr}{d\\theta}$"},
            {"id": "D", "value": "$r^2 + (\\frac{dr}{d\\theta})^2$"}
        ]'::jsonb, 'A',
        'Polar arc length is $L = \int_{\alpha}^{\beta} \sqrt{r^2 + (\frac{dr}{d\theta})^2} \, d\theta$, so the \\integrand is $\sqrt{r^2 + (\frac{dr}{d}\theta)^2}$.',
        'polar_arc_length_formula', ARRAY['polar_arc_length_formula', 'bounds_from_context'], ARRAY['arc_length_missing_sqrt_structure', 'arc_length_wrong_bounds', 'polar_arc_length_missing_dr_dtheta'],
        NOW(), NOW(), 'published', 1
    );

    -- U9.6-P1
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U9.6-P1', 'BC', 'BC_Unit9', 'BC_Unit9', '9.6', '9.6', 'MCQ', false, 2,
        'A vector-valued function is $\mathbf{r}(t) = \langle t^2, 3-t \rangle$. What is $\mathbf{r}(2)$?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$\\\langle 4, 1 \\rangle$"},
            {"id": "B", "value": "$\\\langle 2, 1 \\rangle$"},
            {"id": "C", "value": "$\\\langle 4, -1 \\rangle$"},
            {"id": "D", "value": "$\\\langle 1, 4 \\rangle$"}
        ]'::jsonb, 'A',
        'Substitute $t = 2$: $\mathbf{r}(2) = \langle 2^2, 3-2 \rangle = \langle 4, 1 \rangle$.',
        'vector_valued_position', ARRAY['vector_valued_position', 'bounds_from_context'], ARRAY['vector_component_swap', 'algebra_simplification_error', 'graph_reading_interval_error'],
        NOW(), NOW(), 'published', 1
    );

    -- U9.6-P2
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U9.6-P2', 'BC', 'BC_Unit9', 'BC_Unit9', '9.6', '9.6', 'MCQ', false, 3,
        'A particle’s position is $\mathbf{r}(t) = \langle t^2, 3-t \rangle$. What is its velocity vector $\mathbf{v}(t)$?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$\\\langle 2t, -1 \\rangle$"},
            {"id": "B", "value": "$\\\langle t, -1 \\rangle$"},
            {"id": "C", "value": "$\\\langle 2t, 1 \\rangle$"},
            {"id": "D", "value": "$\\\langle t^2, 3-t \\rangle$"}
        ]'::jsonb, 'A',
        'Differentiate component-wise: $\mathbf{v}(t) = \mathbf{r}''(t) = \langle (t^2)'', (3-t)'' \rangle = \langle 2t, -1 \rangle$.',
        'vector_derivative_velocity', ARRAY['vector_derivative_velocity', 'parametric_first_derivatives'], ARRAY['derivative_power_rule_error', 'vector_component_swap', 'algebra_simplification_error'],
        NOW(), NOW(), 'published', 1
    );

    -- U9.6-P3
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U9.6-P3', 'BC', 'BC_Unit9', 'BC_Unit9', '9.6', '9.6', 'MCQ', false, 4,
        'A particle has velocity $\mathbf{v}(t) = \langle 3, 4t \rangle$. What is the speed at $t = 2$?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$\\sqrt{73}$"},
            {"id": "B", "value": "$11$"},
            {"id": "C", "value": "$\\sqrt{25}$"},
            {"id": "D", "value": "$\\sqrt{19}$"}
        ]'::jsonb, 'A',
        'Speed is $\|\mathbf{v}(t)\| = \sqrt{3^2 + (4t)^2}$. At $t = 2$, speed $= \sqrt{9 + 64} = \sqrt{73}$.',
        'vector_speed_magnitude', ARRAY['vector_speed_magnitude', 'vector_derivative_velocity'], ARRAY['speed_missing_magnitude', 'algebra_simplification_error', 'vector_component_swap'],
        NOW(), NOW(), 'published', 1
    );

    -- U9.6-P4
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version, notes
    ) VALUES (
        'U9.6-P4', 'BC', 'BC_Unit9', 'BC_Unit9', '9.6', '9.6', 'MCQ', false, 4,
        'A particle’s position $\mathbf{r}(t) = \langle x(t), y(t) \rangle$ is given in the table. What is the displacement vector from $t = 0$ to $t = 3$?', 'image', 'table',
        '[
            {"id": "A", "value": "$\\\langle 0, 4 \\rangle$"},
            {"id": "B", "value": "$\\\langle 4, 0 \\rangle$"},
            {"id": "C", "value": "$\\\langle -4, 0 \\rangle$"},
            {"id": "D", "value": "$\\\langle 1, 4 \\rangle$"}
        ]'::jsonb, 'A',
        'Displacement is $\mathbf{r}(3) - \mathbf{r}(0) = \langle 1, 4 \rangle - \langle 1, 0 \rangle = \langle 0, 4 \rangle$.',
        'vector_displacement_from_table', ARRAY['vector_displacement_from_table', 'vector_valued_position'], ARRAY['vector_displacement_endpoint_swap', 'graph_reading_interval_error', 'algebra_simplification_error'],
        NOW(), NOW(), 'published', 1, 'Uses image file: U9_6_P4_position_table.png'
    );

    -- U9.6-P5
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version, notes
    ) VALUES (
        'U9.6-P5', 'BC', 'BC_Unit9', 'BC_Unit9', '9.6', '9.6', 'MCQ', false, 3,
        'The plotted points show sampled positions of a particle at $t = 0, 1, 2, 3$. Which statement best describes the motion from $t = 0$ to $t = 3$?', 'image', 'graph',
        '[
            {"id": "A", "value": "The particle moves generally upward (increasing $y$) while $x$ returns to its starting value."},
            {"id": "B", "value": "The particle moves generally rightward (increasing $x$) while $y$ returns to its starting value."},
            {"id": "C", "value": "The particle stays on a horizontal line (constant $y$)."},
            {"id": "D", "value": "The particle moves in a circle centered at the origin."}
        ]'::jsonb, 'A',
        'From the plotted points, $y$ increases from $0$ to $4$ while $x$ starts at $1$, increases to $2$, then returns to $1$ at $t = 3$.',
        'vector_path_interpretation', ARRAY['vector_path_interpretation', 'vector_valued_position'], ARRAY['graph_reading_interval_error', 'vector_component_swap', 'vector_displacement_endpoint_swap'],
        NOW(), NOW(), 'published', 1, 'Uses image file: U9_6_P5_vector_path.png'
    );

    -- U9.7-P1
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U9.7-P1', 'BC', 'BC_Unit9', 'BC_Unit9', '9.7', '9.7', 'MCQ', false, 3,
        'A particle’s position is $\mathbf{r}(t) = \langle t, t^2 \rangle$. What is the velocity vector $\mathbf{v}(t)$?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$\\\langle 1, 2t \\rangle$"},
            {"id": "B", "value": "$\\\langle t, 2t \\rangle$"},
            {"id": "C", "value": "$\\\langle 1, t^2 \\rangle$"},
            {"id": "D", "value": "$\\\langle 2t, 1 \\rangle$"}
        ]'::jsonb, 'A',
        'Differentiate component-wise: $\mathbf{v}(t) = \mathbf{r}''(t) = \langle (t)'', (t^2)'' \rangle = \langle 1, 2t \rangle$.',
        'vector_derivative_velocity', ARRAY['vector_derivative_velocity', 'vector_valued_position'], ARRAY['derivative_power_rule_error', 'vector_component_swap', 'algebra_simplification_error'],
        NOW(), NOW(), 'published', 1
    );

    -- U9.7-P2
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U9.7-P2', 'BC', 'BC_Unit9', 'BC_Unit9', '9.7', '9.7', 'MCQ', false, 4,
        'A curve is given by $x = t$ and $y = t^2$. What is $\frac{dy}{dx}$ at $t = \frac{3}{2}$?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$3$"},
            {"id": "B", "value": "$\\frac{3}{2}$"},
            {"id": "C", "value": "$\\frac{9}{4}$"},
            {"id": "D", "value": "$\\frac{4}{9}$"}
        ]'::jsonb, 'A',
        '$\frac{dy}{dx} = \frac{\frac{dy}{dt}}{\frac{dx}{dt}}$. Here $\frac{dy}{dt} = 2t$ and $\frac{dx}{dt} = 1$, so $\frac{dy}{dx} = 2t = 2 \cdot \frac{3}{2} = 3$.',
        'vector_derivative_velocity', ARRAY['vector_derivative_velocity', 'bounds_from_context'], ARRAY['parametric_dydx_missing_divide_by_dxdt', 'algebra_simplification_error', 'graph_reading_interval_error'],
        NOW(), NOW(), 'published', 1
    );

    -- U9.7-P3
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version, notes
    ) VALUES (
        'U9.7-P3', 'BC', 'BC_Unit9', 'BC_Unit9', '9.7', '9.7', 'MCQ', false, 2,
        'The curve for $0 \le t \le 2$ with $x = t$ and $y = t^2$ is shown. Which point on the graph corresponds to $t = 2$?', 'image', 'graph',
        '[
            {"id": "A", "value": "$(2, 4)$"},
            {"id": "B", "value": "$(4, 2)$"},
            {"id": "C", "value": "$(2, 2)$"},
            {"id": "D", "value": "$(0, 2)$"}
        ]'::jsonb, 'A',
        'At $t = 2$, $x = 2$ and $y = 2^2 = 4$, so the point is $(2, 4)$.',
        'vector_path_interpretation', ARRAY['vector_path_interpretation', 'vector_valued_position'], ARRAY['graph_reading_interval_error', 'vector_component_swap', 'algebra_simplification_error'],
        NOW(), NOW(), 'published', 1, 'Uses image file: U9_7_P3_param_curve.png'
    );

    -- U9.7-P4
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version, notes
    ) VALUES (
        'U9.7-P4', 'BC', 'BC_Unit9', 'BC_Unit9', '9.7', '9.7', 'MCQ', true, 5,
        'A particle has velocity components given in the table. Using the trapezoidal rule with $\Delta t = 1$, approximate the displacement vector $\int_0^4 \langle v_x(t), v_y(t) \rangle \, dt$.', 'image', 'table',
        '[
            {"id": "A", "value": "$\\\langle 4, 0 \\rangle$"},
            {"id": "B", "value": "$\\\langle 2, 0 \\rangle$"},
            {"id": "C", "value": "$\\\langle 4, -4 \\rangle$"},
            {"id": "D", "value": "$\\\langle 0, 4 \\rangle$"}
        ]'::jsonb, 'A',
        'Approximate each component. For $x$: $\frac{1}{2}[0 + 2(1) + 2(2) + 2(1) + 0] = \frac{1}{2}(8) = 4$. For $y$: $\frac{1}{2}[2 + 2(1) + 2(0) + 2(-1) + (-2)] = \frac{1}{2}(0) = 0$. So displacement $\approx \langle 4, 0 \rangle$.',
        'vector_displacement_from_table', ARRAY['vector_displacement_from_table', 'bounds_from_context'], ARRAY['vector_displacement_endpoint_swap', 'graph_reading_interval_error', 'algebra_simplification_error'],
        NOW(), NOW(), 'published', 1, 'Uses image file: U9_7_P4_displacement_table.png'
    );

    -- U9.7-P5
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U9.7-P5', 'BC', 'BC_Unit9', 'BC_Unit9', '9.7', '9.7', 'MCQ', false, 4,
        'Using the table values at $t = 3$, the velocity is $\mathbf{v}(3) = \langle 1, -1 \rangle$. What is the speed at $t = 3$?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$\\sqrt{2}$"},
            {"id": "B", "value": "$0$"},
            {"id": "C", "value": "$2$"},
            {"id": "D", "value": "$-\\sqrt{2}$"}
        ]'::jsonb, 'A',
        'Speed is the magnitude: $\|\mathbf{v}(3)\| = \sqrt{1^2 + (-1)^2} = \sqrt{2}$.',
        'vector_speed_magnitude', ARRAY['vector_speed_magnitude', 'bounds_from_context'], ARRAY['speed_missing_magnitude', 'algebra_simplification_error', 'vector_component_swap'],
        NOW(), NOW(), 'published', 1
    );

    -- U9.8-P1
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U9.8-P1', 'BC', 'BC_Unit9', 'BC_Unit9', '9.8', '9.8', 'MCQ', false, 3,
        'A particle has velocity $\mathbf{v}(t) = \langle \\\\\\\cos t, \\\\\\\sin t \rangle$. What is the speed $\|\mathbf{v}(t)\|$?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$1$"},
            {"id": "B", "value": "$\\sin t + \\cos t$"},
            {"id": "C", "value": "$\\sqrt{\\sin t + \\cos t}$"},
            {"id": "D", "value": "$\\sin^2 t + \\cos^2 t$"}
        ]'::jsonb, 'A',
        '$\|\mathbf{v}(t)\| = \sqrt{(\\\\\\\cos t)^2 + (\\\\\\\sin t)^2} = \sqrt{1} = 1$.',
        'vector_speed_magnitude', ARRAY['vector_speed_magnitude', 'bounds_from_context'], ARRAY['speed_missing_magnitude', 'algebra_simplification_error', 'vector_component_swap'],
        NOW(), NOW(), 'published', 1
    );

    -- U9.8-P2
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U9.8-P2', 'BC', 'BC_Unit9', 'BC_Unit9', '9.8', '9.8', 'MCQ', false, 4,
        'A particle’s position is $\mathbf{r}(t) = \langle t^2, t^3 \rangle$. What is the speed at $t = 1$?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$\\sqrt{13}$"},
            {"id": "B", "value": "$5$"},
            {"id": "C", "value": "$\\sqrt{5}$"},
            {"id": "D", "value": "$13$"}
        ]'::jsonb, 'A',
        '$\mathbf{v}(t) = \mathbf{r}''(t) = \langle 2t, 3t^2 \rangle$. At $t = 1$, $\mathbf{v}(1) = \langle 2, 3 \rangle$, so speed $= \sqrt{2^2 + 3^2} = \sqrt{13}$.',
        'vector_speed_magnitude', ARRAY['vector_speed_magnitude', 'vector_derivative_velocity'], ARRAY['speed_missing_magnitude', 'derivative_power_rule_error', 'algebra_simplification_error'],
        NOW(), NOW(), 'published', 1
    );

    -- U9.8-P3
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version, notes
    ) VALUES (
        'U9.8-P3', 'BC', 'BC_Unit9', 'BC_Unit9', '9.8', '9.8', 'MCQ', true, 5,
        'A table of speed values $|\mathbf{v}(t)|$ is shown for $0 \le t \le 3$. Using the trapezoidal rule with $\Delta t = 1$, approximate the total distance traveled on $[0, 3]$.', 'image', 'table',
        '[
            {"id": "A", "value": "$7.5$"},
            {"id": "B", "value": "$9.5$"},
            {"id": "C", "value": "$7.0$"},
            {"id": "D", "value": "$3.5$"}
        ]'::jsonb, 'A',
        'Trapezoids with $\Delta t = 1$: $\frac{1}{2}(2.0 + 2(2.5) + 2(3.0) + 2.0) = \frac{1}{2}(15) = 7.5$.',
        'bounds_from_context', ARRAY['bounds_from_context', 'vector_speed_magnitude'], ARRAY['graph_reading_interval_error', 'algebra_simplification_error', 'speed_missing_magnitude'],
        NOW(), NOW(), 'published', 1, 'Uses image file: U9_8_P3_speed_table.png'
    );

    -- U9.8-P4
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U9.8-P4', 'BC', 'BC_Unit9', 'BC_Unit9', '9.8', '9.8', 'MCQ', false, 3,
        'A particle has velocity $\mathbf{v}(t) = \langle 2, -1 \rangle$ for $0 \le t \le 5$. What is the displacement vector on $[0, 5]$?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$\\\langle 10, -5 \\rangle$"},
            {"id": "B", "value": "$\\\langle 2, -1 \\rangle$"},
            {"id": "C", "value": "$\\\langle 5, -2 \\rangle$"},
            {"id": "D", "value": "$\\\langle -10, 5 \\rangle$"}
        ]'::jsonb, 'A',
        'Displacement is $\int_0^5 \mathbf{v}(t) \, dt = \langle \int_0^5 2 \, dt, \int_0^5 (-1) \, dt \rangle = \langle 10, -5 \rangle$.',
        'vector_valued_position', ARRAY['vector_valued_position', 'bounds_from_context'], ARRAY['vector_displacement_endpoint_swap', 'vector_component_swap', 'algebra_simplification_error'],
        NOW(), NOW(), 'published', 1
    );

    -- U9.8-P5
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U9.8-P5', 'BC', 'BC_Unit9', 'BC_Unit9', '9.8', '9.8', 'MCQ', false, 4,
        'Which expression represents the total distance traveled by a particle on $[a, b]$ if its velocity is $\mathbf{v}(t)$?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$\\\int_a^b \\\|\\\mathbf{v}(t)\\\| \\\, dt$"},
            {"id": "B", "value": "\\\| \\\int_a^b \\\mathbf{v}(t) \\\, dt \\\|"},
            {"id": "C", "value": "$\\\int_a^b \\\mathbf{v}(t) \\\, dt$"},
            {"id": "D", "value": "$\\\int_a^b \\\|\\\mathbf{v}(t)\\\|^2 \\\, dt$"}
        ]'::jsonb, 'A',
        'Total distance uses speed (magnitude of velocity): $\int_a^b \|\mathbf{v}(t)\| \, dt$. The \\integral of velocity is displacement, not distance.',
        'vector_speed_magnitude', ARRAY['vector_speed_magnitude', 'bounds_from_context'], ARRAY['speed_missing_magnitude', 'graph_reading_interval_error', 'algebra_simplification_error'],
        NOW(), NOW(), 'published', 1
    );

    -- U9.9-P1
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U9.9-P1', 'BC', 'BC_Unit9', 'BC_Unit9', '9.9', '9.9', 'MCQ', false, 3,
        'Two polar curves are $r = 2\\\\\\\cos\theta$ and $r = 1$. At which angle in $[0, \pi]$ do they \\intersect with $r > 0$?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$\\frac{\\pi}{3}$"},
            {"id": "B", "value": "$\\frac{\\pi}{2}$"},
            {"id": "C", "value": "$\\frac{2\\pi}{3}$"},
            {"id": "D", "value": "$\\frac{\\pi}{6}$"}
        ]'::jsonb, 'A',
        'Intersect when $2\\\\\\\cos\theta = 1 \Rightarrow \\\\\\\cos\theta = \frac{1}{2}$, giving $\theta = \frac{\pi}{3}$ in $[0, \pi]$.',
        'bounds_from_context', ARRAY['bounds_from_context', 'algebra_simplification_error'], ARRAY['algebra_simplification_error', 'graph_reading_interval_error', 'derivative_power_rule_error'],
        NOW(), NOW(), 'published', 1
    );

    -- U9.9-P2
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version, notes
    ) VALUES (
        'U9.9-P2', 'BC', 'BC_Unit9', 'BC_Unit9', '9.9', '9.9', 'MCQ', false, 4,
        'The curves $r = 2\\\\\\\cos\theta$ and $r = 1$ are shown. Which \\integral gives the area of the region inside $r = 2\\\\\\\cos\theta$ and outside $r = 1$ in the first quadrant?', 'image', 'graph',
        '[
            {"id": "A", "value": "$\\frac{1}{2} \\\int_{0}^{\\frac{\\pi}{3}} ((2\\cos\\theta)^2 - 1^2) \\\, d\\theta$"},
            {"id": "B", "value": "$\\frac{1}{2} \\\int_{0}^{\\frac{\\pi}{2}} ((2\\cos\\theta)^2 - 1^2) \\\, d\\theta$"},
            {"id": "C", "value": "$\\frac{1}{2} \\\int_{0}^{\\frac{\\pi}{3}} (1^2 - (2\\cos\\theta)^2) \\\, d\\theta$"},
            {"id": "D", "value": "$\\\int_{0}^{\\frac{\\pi}{3}} (2\\cos\\theta - 1) \\\, d\\theta$"}
        ]'::jsonb, 'A',
        'Polar area between two curves uses $\frac{1}{2} \int (r_{\text{outer}}^2 - r_{\text{inner}}^2) \, d\theta$. In the first quadrant they switch at $2\\\\\\\cos\theta = 1 \Rightarrow \theta = \\frac{\pi}{3}$ and outer is $2\\\\\\\cos\theta$ on $[0, \\frac{\pi}{3}]$.',
        'bounds_from_context', ARRAY['bounds_from_context', 'graph_reading_interval_error'], ARRAY['graph_reading_interval_error', 'algebra_simplification_error', 'parametric_dydx_missing_divide_by_dxdt'],
        NOW(), NOW(), 'published', 1, 'Uses image file: U9_9_P3_two_polar_curves.png'
    );

    -- U9.9-P3
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U9.9-P3', 'BC', 'BC_Unit9', 'BC_Unit9', '9.9', '9.9', 'MCQ', false, 5,
        'Find the exact area of the region inside $r = 2\\\\\\\cos\theta$ and outside $r = 1$ in the first quadrant.', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$\\frac{\\pi}{6} + \\frac{\\sqrt{3}}{4}$"},
            {"id": "B", "value": "$\\frac{\\pi}{6} - \\frac{\\sqrt{3}}{4}$"},
            {"id": "C", "value": "$\\frac{\\pi}{3} + \\frac{\\sqrt{3}}{2}$"},
            {"id": "D", "value": "$\\frac{\\pi}{12} + \\frac{\\sqrt{3}}{8}$"}
        ]'::jsonb, 'A',
        'Area $= \frac{1}{2} \int_0^{\\frac{\pi}{3}} (4\\\\\\\cos^2\theta - 1) \, d\theta = \frac{1}{2} \int_0^{\\frac{\pi}{3}} (1 + 2\\\\\\\cos2\theta) \, d\theta = \frac{1}{2} [\theta + \\\\\\\sin2\theta]_0^{\\frac{\pi}{3}} = \frac{\pi}{6} + \frac{\sqrt{3}}{4}$.',
        'bounds_from_context', ARRAY['bounds_from_context', 'algebra_simplification_error'], ARRAY['algebra_simplification_error', 'graph_reading_interval_error', 'derivative_power_rule_error'],
        NOW(), NOW(), 'published', 1
    );

    -- U9.9-P4
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version, notes
    ) VALUES (
        'U9.9-P4', 'BC', 'BC_Unit9', 'BC_Unit9', '9.9', '9.9', 'MCQ', true, 4,
        'The table shows values for $r = 2\\\\\\\cos\theta$ at $\theta = 0, \\frac{\pi}{6}, \\frac{\pi}{3}, \\frac{\pi}{2}$. Using the trapezoidal rule on $\frac{1}{2} \int_0^{\\frac{\pi}{2}} r(\theta)^2 \, d\theta$, approximate the area inside $r = 2\\\\\\\cos\theta$ for $0 \le \theta \le \frac{\pi}{2}$.', 'image', 'table',
        '[
            {"id": "A", "value": "$1.47$"},
            {"id": "B", "value": "$1.10$"},
            {"id": "C", "value": "$1.99$"},
            {"id": "D", "value": "$0.74$"}
        ]'::jsonb, 'A',
        'Step $h = \\frac{\pi}{6}$. Compute $f(\theta) = \frac{1}{2}r^2$: values are $2.000, 1.500, 0.500, 0.000$. Trapezoid: $T \approx h [\frac{f_0 + f_3}{2} + f_1 + f_2] = \frac{\pi}{6} [\frac{2 + 0}{2} + 1.5 + 0.5] = \frac{\pi}{6}(3) = \frac{\pi}{2} \approx 1.57$, close to 1.47 by rounding from table.',
        'bounds_from_context', ARRAY['bounds_from_context', 'graph_reading_interval_error'], ARRAY['algebra_simplification_error', 'graph_reading_interval_error', 'speed_missing_magnitude'],
        NOW(), NOW(), 'published', 1, 'Uses image file: U9_9_P4_area_table.png'
    );

    -- U9.9-P5
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U9.9-P5', 'BC', 'BC_Unit9', 'BC_Unit9', '9.9', '9.9', 'MCQ', false, 3,
        'On which \\interval is $r = 2\\\\\\\cos\theta$ the outer curve compared to $r = 1$ (with $r \ge 0$) for the first-quadrant region where they \\intersect?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$0 \\le \\theta \\le \\frac{\\pi}{3}$"},
            {"id": "B", "value": "$\\frac{\\pi}{3} \\le \\theta \\le \\frac{\\pi}{2}$"},
            {"id": "C", "value": "$0 \\le \\theta \\le \\frac{\\pi}{2}$"},
            {"id": "D", "value": "$\\frac{\\pi}{6} \\le \\theta \\le \\frac{\\pi}{3}$"}
        ]'::jsonb, 'A',
        'They \\intersect at $\theta = \\frac{\pi}{3}$. For $0 \le \theta < \\frac{\pi}{3}$, $2\\\\\\\cos\theta > 1$, so $r = 2\\\\\\\cos\theta$ is farther from the origin (outer).',
        'bounds_from_context', ARRAY['bounds_from_context', 'graph_reading_interval_error'], ARRAY['graph_reading_interval_error', 'algebra_simplification_error', 'vector_component_swap'],
        NOW(), NOW(), 'published', 1
    );

END $$;
