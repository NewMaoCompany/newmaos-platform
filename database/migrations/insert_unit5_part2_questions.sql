-- Insert Unit 5 Questions (Generated from JSON)
-- Delete old/duplicate questions
DELETE FROM public.questions WHERE title LIKE 'U5-5.2-%';
DELETE FROM public.questions WHERE title LIKE 'U5.2-%';

    -- Question: U5.2-P1
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type,
        calculator_allowed, difficulty, target_time_seconds,
        prompt_type, representation_type, prompt, latex,
        options, correct_option_id, tolerance, explanation,
        micro_explanations, recommendation_reasons,
        reasoning_level, mastery_weight,
        source, source_year, notes, error_tags, status, version
    ) VALUES (
        'U5.2-P1', 'Both', 'Both_Analytical', 'Both_Analytical', '5.2', '5.2', 'MCQ',
        false, 2, 150,
        'text', 'symbolic', 'Which statement is sufficient to guarantee that a function $f$ has both an absolute maximum and an absolute minimum on $[a,b]$?', 'Which statement is sufficient to guarantee that a function $f$ has both an absolute maximum and an absolute minimum on $[a,b]$?',
        '[{"id": "A", "text": "$f$ is continuous on $[a,b]$."}, {"id": "B", "text": "$f$ is differentiable on $(a,b)$."}, {"id": "C", "text": "$f$ is continuous on $(a,b)$."}, {"id": "D", "text": "$f$ is differentiable on $[a,b]$."}]'::jsonb, 'A', 0, 'By the Extreme Value Theorem, if $f$ is continuous on a closed interval $[a,b]$, then $f$ attains both an absolute maximum and an absolute minimum on $[a,b]$.',
        '{"A": "Correct: EVT requires continuity on a closed interval.", "B": "Differentiability on $(a,b)$ alone does not guarantee endpoints or boundedness.", "C": "Continuity only on the open interval does not guarantee extrema are attained.", "D": "Differentiable on $[a,b]$ implies continuous, but the key condition is continuity on the closed interval (A is the standard EVT statement)."}'::jsonb, ARRAY['evt_conditions_check']::text[],
        2, 1.05,
        'self', 2026, '', ARRAY['evt_missing_closed_interval', 'evt_missing_continuity', 'confuse_local_global']::text[], 'published', 1
    ) RETURNING id;
    

    -- Question: U5.2-P2
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type,
        calculator_allowed, difficulty, target_time_seconds,
        prompt_type, representation_type, prompt, latex,
        options, correct_option_id, tolerance, explanation,
        micro_explanations, recommendation_reasons,
        reasoning_level, mastery_weight,
        source, source_year, notes, error_tags, status, version
    ) VALUES (
        'U5.2-P2', 'Both', 'Both_Analytical', 'Both_Analytical', '5.2', '5.2', 'MCQ',
        false, 3, 190,
        'text', 'symbolic', 'Let $f(x)=x^3-3x$ on $[-2,2]$. At which $x$-values must you evaluate $f$ to find the absolute maximum and minimum on $[-2,2]$?', 'Let $f(x)=x^3-3x$ on $[-2,2]$. At which $x$-values must you evaluate $f$ to find the absolute maximum and minimum on $[-2,2]$?',
        '[{"id": "A", "text": "$x=-2,0,2$"}, {"id": "B", "text": "$x=-1,1$"}, {"id": "C", "text": "$x=-2,-1,1,2$"}, {"id": "D", "text": "$x=0$ only"}]'::jsonb, 'C', 0, 'On a closed interval, absolute extrema occur at endpoints or critical points. $f''(x)=3x^2-3=3(x^2-1)$, so critical points are $x=\pm 1$. Check $x=-2,-1,1,2$.',
        '{"A": "Misses the critical points $x=\\\\pm 1$.", "B": "Misses endpoints, where absolute extrema can occur.", "C": "Correct: endpoints and all critical points in the interval.", "D": "Checking only one point is not sufficient."}'::jsonb, ARRAY['absolute_extrema_on_closed_interval_procedure']::text[],
        3, 1.1,
        'self', 2026, '', ARRAY['forget_endpoints', 'only_check_where_derivative_zero', 'interval_bounds_error']::text[], 'published', 1
    ) RETURNING id;
    

    -- Question: U5.2-P3
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type,
        calculator_allowed, difficulty, target_time_seconds,
        prompt_type, representation_type, prompt, latex,
        options, correct_option_id, tolerance, explanation,
        micro_explanations, recommendation_reasons,
        reasoning_level, mastery_weight,
        source, source_year, notes, error_tags, status, version
    ) VALUES (
        'U5.2-P3', 'Both', 'Both_Analytical', 'Both_Analytical', '5.2', '5.2', 'MCQ',
        false, 3, 200,
        'text', 'symbolic', 'Which statement must be true?', 'Which statement must be true?',
        '[{"id": "A", "text": "If $f$ has an absolute maximum at $x=c$ in $(a,b)$, then $f''(c)=0$."}, {"id": "B", "text": "If $f''(c)=0$, then $f$ has a local maximum at $x=c$."}, {"id": "C", "text": "If $f$ has a local maximum at $x=c$, then $f(c)$ is the absolute maximum on $[a,b]$."}, {"id": "D", "text": "If $f$ is continuous on $(a,b)$, then $f$ has an absolute maximum on $(a,b)$."}]'::jsonb, 'A', 0, 'If $f$ has an absolute maximum at an interior point and is differentiable there, then Fermat’s Theorem gives $f''(c)=0$. The other choices are not guaranteed by the given information.',
        '{"A": "Correct: interior absolute max (with differentiability) implies derivative 0.", "B": "Derivative 0 could be min, max, or neither (e.g., inflection).", "C": "Local max does not have to be the largest value overall.", "D": "Continuity on an open interval does not guarantee extrema are attained."}'::jsonb, ARRAY['local_vs_absolute_extrema_concepts']::text[],
        3, 1.1,
        'self', 2026, '', ARRAY['confuse_local_global', 'assume_local_implies_absolute', 'endpoint_misconception']::text[], 'published', 1
    ) RETURNING id;
    

    -- Question: U5.2-P4
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type,
        calculator_allowed, difficulty, target_time_seconds,
        prompt_type, representation_type, prompt, latex,
        options, correct_option_id, tolerance, explanation,
        micro_explanations, recommendation_reasons,
        reasoning_level, mastery_weight,
        source, source_year, notes, error_tags, status, version
    ) VALUES (
        'U5.2-P4', 'Both', 'Both_Analytical', 'Both_Analytical', '5.2', '5.2', 'MCQ',
        false, 4, 240,
        'text', 'symbolic', 'Let $f(x)=|x-2|+\frac{1}{x}$ with domain $x\ne 0$. Which $x$-values are critical numbers of $f$?', 'Let $f(x)=|x-2|+\frac{1}{x}$ with domain $x\ne 0$. Which $x$-values are critical numbers of $f$?',
        '[{"id": "A", "text": "$x=0$ only"}, {"id": "B", "text": "$x=2$ only"}, {"id": "C", "text": "$x=2$ and $x=0$"}, {"id": "D", "text": "None"}]'::jsonb, 'B', 0, 'Critical numbers are in the domain where $f''(x)=0$ or $f''(x)$ does not exist. $|x-2|$ is not differentiable at $x=2$, and $2$ is in the domain, so $x=2$ is a critical number. $x=0$ is not in the domain, so it cannot be a critical number.',
        '{"A": "0 is excluded from the domain, so it cannot be a critical number.", "B": "Correct: nondifferentiable point at $x=2$ is in the domain.", "C": "Includes $x=0$, but $x=0$ is not allowed in the domain.", "D": "There is at least one critical number at the cusp."}'::jsonb, ARRAY['critical_points_including_nondifferentiable']::text[],
        4, 1.2,
        'self', 2026, '', ARRAY['forget_nondifferentiable_critical', 'treat_discontinuity_as_critical', 'ignore_domain_restriction']::text[], 'published', 1
    ) RETURNING id;
    

    -- Question: U5.2-P5
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type,
        calculator_allowed, difficulty, target_time_seconds,
        prompt_type, representation_type, prompt, latex,
        options, correct_option_id, tolerance, explanation,
        micro_explanations, recommendation_reasons,
        reasoning_level, mastery_weight,
        source, source_year, notes, error_tags, status, version
    ) VALUES (
        'U5.2-P5', 'Both', 'Both_Analytical', 'Both_Analytical', '5.2', '5.2', 'MCQ',
        false, 4, 260,
        'text', 'symbolic', 'Consider $f(x)=\frac{1}{x}$ on $(0,1]$. Which statement is true?', 'Consider $f(x)=\frac{1}{x}$ on $(0,1]$. Which statement is true?',
        '[{"id": "A", "text": "$f$ has an absolute maximum on $(0,1]$."}, {"id": "B", "text": "$f$ has an absolute minimum on $(0,1]$."}, {"id": "C", "text": "$f$ has both an absolute maximum and minimum on $(0,1]$ by EVT."}, {"id": "D", "text": "$f$ has neither an absolute maximum nor an absolute minimum on $(0,1]$."}]'::jsonb, 'B', 0, '$f(1)=1$ is the smallest value on $(0,1]$, so there is an absolute minimum at $x=1$. As $x\to 0^+$, $\frac{1}{x}\to\infty$, so there is no absolute maximum because values grow without bound and $0$ is not included.',
        '{"A": "No maximum: the function increases without bound near 0.", "B": "Correct: the smallest value occurs at the included endpoint $x=1$.", "C": "EVT does not apply because the interval is not closed (0 is excluded).", "D": "There is an absolute minimum at $x=1$, so not neither."}'::jsonb, ARRAY['evt_not_satisfied_counterexample_reasoning']::text[],
        4, 1.2,
        'self', 2026, '', ARRAY['assume_bounded_implies_extrema', 'ignore_open_interval_issue', 'confuse_limit_with_value']::text[], 'published', 1
    ) RETURNING id;
    