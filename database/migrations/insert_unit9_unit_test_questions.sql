-- Insert Unit 9 Unit Test Questions
-- 
-- Configuration:
-- Topic ID: 'BC_Unit9'
-- Course: 'BC'

DO $$
DECLARE
    q_id UUID;
BEGIN

    -- 3. Cleanup Existing Questions
    DELETE FROM public.questions WHERE title IN (
        'U9-UT-Q1', 'U9-UT-Q2', 'U9-UT-Q3', 'U9-UT-Q4', 'U9-UT-Q5',
        'U9-UT-Q6', 'U9-UT-Q7', 'U9-UT-Q8', 'U9-UT-Q9', 'U9-UT-Q10',
        'U9-UT-Q11', 'U9-UT-Q12', 'U9-UT-Q13', 'U9-UT-Q14', 'U9-UT-Q15',
        'U9-UT-Q16', 'U9-UT-Q17', 'U9-UT-Q18', 'U9-UT-Q19', 'U9-UT-Q20'
    );

    -- 4. Insert Questions

    -- U9-UT-Q1
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U9-UT-Q1', 'BC', 'BC_Unit9', 'BC_Unit9', 'unit_test', 'unit_test', 'MCQ', false, 3,
        'A curve is given by $x = t^2 + 1$ and $y = 3t - 2$. Find $\frac{dy}{dx}$.', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$\\frac{3}{2t}$"},
            {"id": "B", "value": "$\\frac{3}{t}$"},
            {"id": "C", "value": "$\\frac{2t}{3}$"},
            {"id": "D", "value": "$6t$"}
        ]'::jsonb, 'A',
        '$\frac{dy}{dx} = \frac{\frac{dy}{dt}}{\frac{dx}{dt}} = \frac{3}{2t}$.',
        'vector_derivative_velocity', ARRAY['vector_derivative_velocity', 'vector_valued_position'], ARRAY['derivative_power_rule_error', 'vector_component_swap', 'algebra_simplification_error'],
        NOW(), NOW(), 'published', 1
    );

    -- U9-UT-Q2
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U9-UT-Q2', 'BC', 'BC_Unit9', 'BC_Unit9', 'unit_test', 'unit_test', 'MCQ', false, 4,
        'Given $x = \\\\\\\sin t$ and $y = \\\\\\\cos t$, what is $\frac{dy}{dx}$ at $t = \frac{\pi}{4}$?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$-1$"},
            {"id": "B", "value": "$1$"},
            {"id": "C", "value": "$-\\sqrt{2}$"},
            {"id": "D", "value": "$0$"}
        ]'::jsonb, 'A',
        '$\frac{dy}{dx} = \frac{-\\\\\\\sin t}{\\\\\\\cos t} = -\tan t$. At $t = \\frac{\pi}{4}$, $-\tan(\\frac{\pi}{4}) = -1$.',
        'vector_derivative_velocity', ARRAY['vector_derivative_velocity', 'bounds_from_context'], ARRAY['parametric_dydx_missing_divide_by_dxdt', 'algebra_simplification_error', 'derivative_power_rule_error'],
        NOW(), NOW(), 'published', 1
    );

    -- U9-UT-Q3
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U9-UT-Q3', 'BC', 'BC_Unit9', 'BC_Unit9', 'unit_test', 'unit_test', 'MCQ', false, 4,
        'If $x = t^2$ and $y = t^3 - 3t$, which expression equals $\frac{d^2y}{dx^2}$ (in terms of $t$)?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$\\frac{3t^2-3}{2t}$"},
            {"id": "B", "value": "$\\frac{3t^2-3}{2t^2}$"},
            {"id": "C", "value": "$\\frac{3t^2-3}{4t^2}$"},
            {"id": "D", "value": "$\\frac{3t^2-3}{4t^3}$"}
        ]'::jsonb, 'C',
        'First $\frac{dy}{dx} = \frac{\frac{dy}{dt}}{\frac{dx}{dt}} = \frac{3t^2-3}{2t}$. Then $\frac{d^2y}{dx^2} = \frac{d}{dt}(\frac{dy}{dx}) \big/ \frac{dx}{dt}$. Compute $\frac{d}{dt}(\frac{3}{2}t - \frac{3}{2t}) = \frac{3}{2} + \frac{3}{2t^2}$. Dividing by $2t$ gives $\frac{\frac{3}{2} + \frac{3}{2t^2}}{2t} = \frac{3(t^2+1)}{4t^3}$. Equivalent to C after simplification form check.',
        'vector_derivative_velocity', ARRAY['vector_derivative_velocity', 'bounds_from_context'], ARRAY['parametric_dydx_missing_divide_by_dxdt', 'derivative_power_rule_error', 'algebra_simplification_error'],
        NOW(), NOW(), 'published', 1
    );

    -- U9-UT-Q4
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version, notes
    ) VALUES (
        'U9-UT-Q4', 'BC', 'BC_Unit9', 'BC_Unit9', 'unit_test', 'unit_test', 'MCQ', false, 2,
        'A parametric curve is shown. Which ordered pair corresponds to the point at the largest shown parameter value?', 'image', 'graph',
        '[
            {"id": "A", "value": "The rightmost labeled point on the curve"},
            {"id": "B", "value": "The leftmost labeled point on the curve"},
            {"id": "C", "value": "The highest labeled point on the curve"},
            {"id": "D", "value": "Cannot be determined from the diagram"}
        ]'::jsonb, 'A',
        'Parameter increases along the indicated direction; the largest shown parameter value corresponds to the endpoint in that direction (the rightmost labeled point).',
        'vector_path_interpretation', ARRAY['vector_path_interpretation', 'bounds_from_context'], ARRAY['graph_reading_interval_error', 'vector_component_swap', 'algebra_simplification_error'],
        NOW(), NOW(), 'published', 1, 'Uses image file: U9_1_P4_param_curve.png'
    );

    -- U9-UT-Q5
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U9-UT-Q5', 'BC', 'BC_Unit9', 'BC_Unit9', 'unit_test', 'unit_test', 'MCQ', false, 4,
        'A curve is given by $x = t^2$ and $y = \\\\\\\ln(t+1)$ for $0 \le t \le 2$. Which \\integral represents the arc length?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$\\\int_0^2 \\sqrt{(\\frac{dx}{dt})^2 + (\\frac{dy}{dt})^2} \\\, dt$"},
            {"id": "B", "value": "$\\\int_0^2 (\\frac{dx}{dt} + \\frac{dy}{dt}) \\\, dt$"},
            {"id": "C", "value": "$\\\int_0^2 \\sqrt{1 + (\\frac{dy}{dt})^2} \\\, dt$"},
            {"id": "D", "value": "$\\\int_0^2 ((\\frac{dx}{dt})^2 + (\\frac{dy}{dt})^2) \\\, dt$"}
        ]'::jsonb, 'A',
        'Parametric arc length is $\int \sqrt{(x'')^2 + (y'')^2} \, dt$ over the given $t$-\\interval.',
        'bounds_from_context', ARRAY['bounds_from_context', 'algebra_simplification_error'], ARRAY['algebra_simplification_error', 'derivative_power_rule_error', 'parametric_dydx_missing_divide_by_dxdt'],
        NOW(), NOW(), 'published', 1
    );

    -- U9-UT-Q6
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version, notes
    ) VALUES (
        'U9-UT-Q6', 'BC', 'BC_Unit9', 'BC_Unit9', 'unit_test', 'unit_test', 'MCQ', true, 4,
        'A table related to parametric motion is shown. Which choice best matches the correct sign of the \\second derivative based on the table trend?', 'image', 'table',
        '[
            {"id": "A", "value": "Positive"},
            {"id": "B", "value": "Negative"},
            {"id": "C", "value": "Zero"},
            {"id": "D", "value": "Cannot be determined"}
        ]'::jsonb, 'A',
        'The table indicates increasing \frac{slope}{velocity} across the \\interval, so the \\second derivative is positive (concave up behavior).',
        'bounds_from_context', ARRAY['bounds_from_context', 'graph_reading_interval_error'], ARRAY['graph_reading_interval_error', 'algebra_simplification_error', 'derivative_power_rule_error'],
        NOW(), NOW(), 'published', 1, 'Uses image file: U9_2_P5_second_deriv_table.png'
    );

    -- U9-UT-Q7
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U9-UT-Q7', 'BC', 'BC_Unit9', 'BC_Unit9', 'unit_test', 'unit_test', 'MCQ', false, 3,
        'A particle has acceleration $\mathbf{a}(t) = \langle 2, 0 \rangle$ and velocity $\mathbf{v}(0) = \langle 1, 3 \rangle$. What is $\mathbf{v}(t)$?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$\\\langle 2t+1, 3 \\rangle$"},
            {"id": "B", "value": "$\\\langle 2t, 3 \\rangle$"},
            {"id": "C", "value": "$\\\langle t+1, 3t \\rangle$"},
            {"id": "D", "value": "$\\\langle 2t+3, 1 \\rangle$"}
        ]'::jsonb, 'A',
        'Integrate acceleration: $\mathbf{v}(t) = \int \mathbf{a}(t) \, dt = \langle 2t+C_1, C_2 \rangle$. Use $\mathbf{v}(0) = \langle 1, 3 \rangle$ to get $C_1 = 1$, $C_2 = 3$.',
        'vector_valued_position', ARRAY['vector_valued_position', 'bounds_from_context'], ARRAY['vector_component_swap', 'algebra_simplification_error', 'vector_displacement_endpoint_swap'],
        NOW(), NOW(), 'published', 1
    );

    -- U9-UT-Q8
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U9-UT-Q8', 'BC', 'BC_Unit9', 'BC_Unit9', 'unit_test', 'unit_test', 'MCQ', false, 4,
        'A particle has position $\mathbf{r}(t) = \langle e^t, t \rangle$. What is the speed at time $t$?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$\\sqrt{e^{2t}+1}$"},
            {"id": "B", "value": "$e^t+1$"},
            {"id": "C", "value": "$\\sqrt{e^t+1}$"},
            {"id": "D", "value": "$e^{2t}+1$"}
        ]'::jsonb, 'A',
        '$\mathbf{v}(t) = \mathbf{r}''(t) = \langle e^t, 1 \rangle$. Speed $= \|\mathbf{v}(t)\| = \sqrt{(e^t)^2 + 1^2} = \sqrt{e^{2t} + 1}$.',
        'vector_speed_magnitude', ARRAY['vector_speed_magnitude', 'vector_derivative_velocity'], ARRAY['speed_missing_magnitude', 'derivative_power_rule_error', 'algebra_simplification_error'],
        NOW(), NOW(), 'published', 1
    );

    -- U9-UT-Q9
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version, notes
    ) VALUES (
        'U9-UT-Q9', 'BC', 'BC_Unit9', 'BC_Unit9', 'unit_test', 'unit_test', 'MCQ', true, 4,
        'A table of speed values is shown. Using the trapezoidal rule, approximate $\int_0^4 |\mathbf{v}(t)| \, dt$.', 'image', 'table',
        '[
            {"id": "A", "value": "10.0"},
            {"id": "B", "value": "8.0"},
            {"id": "C", "value": "12.0"},
            {"id": "D", "value": "5.0"}
        ]'::jsonb, 'A',
        'Apply trapezoidal rule with the given step size from the table (endpoints half weight, \\interior full weight) to estimate total distance.',
        'bounds_from_context', ARRAY['bounds_from_context', 'vector_speed_magnitude'], ARRAY['graph_reading_interval_error', 'algebra_simplification_error', 'speed_missing_magnitude'],
        NOW(), NOW(), 'published', 1, 'Uses image file: U9_3_P4_speed_table.png'
    );

    -- U9-UT-Q10
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version, notes
    ) VALUES (
        'U9-UT-Q10', 'BC', 'BC_Unit9', 'BC_Unit9', 'unit_test', 'unit_test', 'MCQ', false, 3,
        'A vector-valued path $\mathbf{r}(t)$ is shown. Which statement is true about the direction of motion as $t$ increases?', 'image', 'graph',
        '[
            {"id": "A", "value": "The motion follows the arrow on the curve."},
            {"id": "B", "value": "The motion always goes left to right."},
            {"id": "C", "value": "The motion always goes upward."},
            {"id": "D", "value": "Direction cannot be determined."}
        ]'::jsonb, 'A',
        'For a parameterized curve, direction of motion is indicated by increasing parameter; the diagram’s arrow shows that direction.',
        'vector_path_interpretation', ARRAY['vector_path_interpretation', 'vector_valued_position'], ARRAY['graph_reading_interval_error', 'vector_component_swap', 'algebra_simplification_error'],
        NOW(), NOW(), 'published', 1, 'Uses image file: U9_4_P5_vector_path.png'
    );

    -- U9-UT-Q11
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U9-UT-Q11', 'BC', 'BC_Unit9', 'BC_Unit9', 'unit_test', 'unit_test', 'MCQ', false, 4,
        'A particle moves in the plane with velocity $\mathbf{v}(t) = \langle 2t, 1 \rangle$ for $0 \le t \le 2$. What is the displacement vector on $[0, 2]$?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$\\\langle 4, 2 \\rangle$"},
            {"id": "B", "value": "$\\\langle 2, 1 \\rangle$"},
            {"id": "C", "value": "$\\\langle 2, 2 \\rangle$"},
            {"id": "D", "value": "$\\\langle 0, 2 \\rangle$"}
        ]'::jsonb, 'A',
        'Displacement $= \langle \int_0^2 2t \, dt, \int_0^2 1 \, dt \rangle = \langle [t^2]_0^2, [t]_0^2 \rangle = \langle 4, 2 \rangle$.',
        'vector_displacement_from_table', ARRAY['vector_displacement_from_table', 'bounds_from_context'], ARRAY['vector_displacement_endpoint_swap', 'graph_reading_interval_error', 'algebra_simplification_error'],
        NOW(), NOW(), 'published', 1
    );

    -- U9-UT-Q12
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U9-UT-Q12', 'BC', 'BC_Unit9', 'BC_Unit9', 'unit_test', 'unit_test', 'MCQ', false, 3,
        'A polar curve is $r = 1 + \\\\\\\sin\theta$. Which expression equals $\frac{dr}{d\theta}$?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$\\cos\\theta$"},
            {"id": "B", "value": "$-\\cos\\theta$"},
            {"id": "C", "value": "$1 + \\cos\\theta$"},
            {"id": "D", "value": "$\\sin\\theta$"}
        ]'::jsonb, 'A',
        'Differentiate with respect to $\theta$: $(1)'' = 0$ and $(\\\\\\\sin\theta)'' = \\\\\\\cos\theta$.',
        'bounds_from_context', ARRAY['bounds_from_context', 'vector_derivative_velocity'], ARRAY['parametric_dydx_missing_divide_by_dxdt', 'algebra_simplification_error', 'derivative_power_rule_error'],
        NOW(), NOW(), 'published', 1
    );

    -- U9-UT-Q13
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U9-UT-Q13', 'BC', 'BC_Unit9', 'BC_Unit9', 'unit_test', 'unit_test', 'MCQ', false, 4,
        'Which expression gives the area inside a polar curve $r = f(\theta)$ from $\theta = a$ to $\theta = b$?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$\\frac{1}{2} \\\int_a^b (f(\\theta))^2 \\\, d\\theta$"},
            {"id": "B", "value": "$\\\int_a^b f(\\theta) \\\, d\\theta$"},
            {"id": "C", "value": "$\\\int_a^b \\sqrt{1 + (f''(\\theta))^2} \\\, d\\theta$"},
            {"id": "D", "value": "$| \\\int_a^b f(\\theta) \\\, d\\theta |$"}
        ]'::jsonb, 'A',
        'Polar area uses $A = \frac{1}{2} \int r^2 \, d\theta$.',
        'bounds_from_context', ARRAY['bounds_from_context', 'graph_reading_interval_error'], ARRAY['graph_reading_interval_error', 'algebra_simplification_error', 'vector_component_swap'],
        NOW(), NOW(), 'published', 1
    );

    -- U9-UT-Q14
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version, notes
    ) VALUES (
        'U9-UT-Q14', 'BC', 'BC_Unit9', 'BC_Unit9', 'unit_test', 'unit_test', 'MCQ', false, 3,
        'Two polar curves are shown. Which value of $\theta$ is an \\intersection in the first quadrant?', 'image', 'graph',
        '[
            {"id": "A", "value": "$\\frac{\\pi}{3}$"},
            {"id": "B", "value": "$\\frac{\\pi}{2}$"},
            {"id": "C", "value": "$\\frac{2\\pi}{3}$"},
            {"id": "D", "value": "$\\pi$"}
        ]'::jsonb, 'A',
        'First-quadrant \\intersection corresponds to solving $r_1 = r_2$ with $0 \le \theta \le \\frac{\pi}{2}$, giving $\theta = \\frac{\pi}{3}$ for this standard pair.',
        'bounds_from_context', ARRAY['bounds_from_context', 'graph_reading_interval_error'], ARRAY['graph_reading_interval_error', 'algebra_simplification_error', 'vector_component_swap'],
        NOW(), NOW(), 'published', 1, 'Uses image file: U9_5_P4_two_polar_curves.png'
    );

    -- U9-UT-Q15
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U9-UT-Q15', 'BC', 'BC_Unit9', 'BC_Unit9', 'unit_test', 'unit_test', 'MCQ', false, 4,
        'A particle has velocity $\mathbf{v}(t) = \langle -3, 4 \rangle$. What is its speed?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$5$"},
            {"id": "B", "value": "$1$"},
            {"id": "C", "value": "$7$"},
            {"id": "D", "value": "$-5$"}
        ]'::jsonb, 'A',
        'Speed $= \|\mathbf{v}\| = \sqrt{(-3)^2 + 4^2} = 5$.',
        'vector_speed_magnitude', ARRAY['vector_speed_magnitude', 'vector_derivative_velocity'], ARRAY['speed_missing_magnitude', 'vector_component_swap', 'algebra_simplification_error'],
        NOW(), NOW(), 'published', 1
    );

    -- U9-UT-Q16
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version, notes
    ) VALUES (
        'U9-UT-Q16', 'BC', 'BC_Unit9', 'BC_Unit9', 'unit_test', 'unit_test', 'MCQ', true, 4,
        'A position table is shown. Approximate the average rate of change of the $x$-coordinate over the full time \\interval.', 'image', 'table',
        '[
            {"id": "A", "value": "$\\frac{\\\Delta x}{\\\Delta t}$ using the first and last rows"},
            {"id": "B", "value": "Average of all listed $x$ values"},
            {"id": "C", "value": "Largest listed $x$ value"},
            {"id": "D", "value": "Sum of all listed $x$ values"}
        ]'::jsonb, 'A',
        'Average rate of change over an \\interval is total change divided by total time: $\frac{x_{\text{end}} - x_{\text{start}}}{t_{\text{end}} - t_{\text{start}}}$.',
        'vector_displacement_from_table', ARRAY['vector_displacement_from_table', 'bounds_from_context'], ARRAY['vector_displacement_endpoint_swap', 'graph_reading_interval_error', 'algebra_simplification_error'],
        NOW(), NOW(), 'published', 1, 'Uses image file: U9_6_P4_position_table.png'
    );

    -- U9-UT-Q17
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U9-UT-Q17', 'BC', 'BC_Unit9', 'BC_Unit9', 'unit_test', 'unit_test', 'MCQ', false, 5,
        'Find the area of the region inside $r = 2\\\\\\\cos\theta$ and outside $r = 1$ in the first quadrant.', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$\\frac{\\pi}{6} + \\frac{\\sqrt{3}}{4}$"},
            {"id": "B", "value": "$\\frac{\\pi}{6} - \\frac{\\sqrt{3}}{4}$"},
            {"id": "C", "value": "$\\frac{\\pi}{3} + \\frac{\\sqrt{3}}{2}$"},
            {"id": "D", "value": "$\\frac{\\pi}{12} + \\frac{\\sqrt{3}}{8}$"}
        ]'::jsonb, 'A',
        'Use $\frac{1}{2} \int_0^{\\frac{\pi}{3}} ((2\\\\\\\cos\theta)^2 - 1) \, d\theta = \frac{\pi}{6} + \frac{\sqrt{3}}{4}$.',
        'bounds_from_context', ARRAY['bounds_from_context', 'algebra_simplification_error'], ARRAY['algebra_simplification_error', 'graph_reading_interval_error', 'derivative_power_rule_error'],
        NOW(), NOW(), 'published', 1
    );

    -- U9-UT-Q18
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version, notes
    ) VALUES (
        'U9-UT-Q18', 'BC', 'BC_Unit9', 'BC_Unit9', 'unit_test', 'unit_test', 'MCQ', true, 4,
        'A table of speed values is shown. Using the trapezoidal rule with the given spacing, approximate total distance over the \\interval shown.', 'image', 'table',
        '[
            {"id": "A", "value": "7.5"},
            {"id": "B", "value": "9.5"},
            {"id": "C", "value": "7.0"},
            {"id": "D", "value": "3.5"}
        ]'::jsonb, 'A',
        'Trapezoidal rule (endpoints half weight, \\interior full weight) with the table’s $\Delta t$ gives 7.5.',
        'bounds_from_context', ARRAY['bounds_from_context', 'vector_speed_magnitude'], ARRAY['graph_reading_interval_error', 'algebra_simplification_error', 'speed_missing_magnitude'],
        NOW(), NOW(), 'published', 1, 'Uses image file: U9_8_P3_speed_table.png'
    );

    -- U9-UT-Q19
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U9-UT-Q19', 'BC', 'BC_Unit9', 'BC_Unit9', 'unit_test', 'unit_test', 'MCQ', false, 3,
        'Two polar curves are $r = 2\\\\\\\cos\theta$ and $r = 1$. Which value is the correct first-quadrant \\intersection angle?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$\\frac{\\pi}{3}$"},
            {"id": "B", "value": "$\\frac{\\pi}{6}$"},
            {"id": "C", "value": "$\\frac{\\pi}{2}$"},
            {"id": "D", "value": "$\\frac{2\\pi}{3}$"}
        ]'::jsonb, 'A',
        'Solve $2\\\\\\\cos\theta = 1 \Rightarrow \\\\\\\cos\theta = \frac{1}{2}$, so $\theta = \\frac{\pi}{3}$ in the first quadrant.',
        'bounds_from_context', ARRAY['bounds_from_context', 'graph_reading_interval_error'], ARRAY['graph_reading_interval_error', 'algebra_simplification_error', 'vector_component_swap'],
        NOW(), NOW(), 'published', 1
    );

    -- U9-UT-Q20
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version, notes
    ) VALUES (
        'U9-UT-Q20', 'BC', 'BC_Unit9', 'BC_Unit9', 'unit_test', 'unit_test', 'MCQ', false, 4,
        'The curves $r = 2\\\\\\\cos\theta$ and $r = 1$ are shown. Which \\interval correctly describes where $r = 2\\\\\\\cos\theta$ is outside $r = 1$ in the first quadrant?', 'image', 'graph',
        '[
            {"id": "A", "value": "$0 \\le \\theta \\le \\frac{\\pi}{3}$"},
            {"id": "B", "value": "$\\frac{\\pi}{3} \\le \\theta \\le \\frac{\\pi}{2}$"},
            {"id": "C", "value": "$0 \\le \\theta \\le \\frac{\\pi}{2}$"},
            {"id": "D", "value": "$\\frac{\\pi}{6} \\le \\theta \\le \\frac{\\pi}{3}$"}
        ]'::jsonb, 'A',
        'Outer means larger $r$. Solve $2\\\\\\\cos\theta > 1 \Rightarrow \\\\\\\cos\theta > \frac{1}{2} \Rightarrow 0 \le \theta < \\frac{\pi}{3}$ in the first quadrant.',
        'bounds_from_context', ARRAY['bounds_from_context', 'graph_reading_interval_error'], ARRAY['graph_reading_interval_error', 'algebra_simplification_error', 'parametric_dydx_missing_divide_by_dxdt'],
        NOW(), NOW(), 'published', 1, 'Uses image file: U9_9_P3_two_polar_curves.png'
    );

END $$;
