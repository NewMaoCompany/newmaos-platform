-- Unit 5 Part 1 Update Script (5.1 - 5.2)
-- Wrapped in a DO block to ensure atomic execution and prevent syntax errors at EOF.

DO $block$
BEGIN

-- Unit 5.1 (Using the Mean Value Theorem) — Practice 1–5

UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Analytical',
  sub_topic_id = '5.1',
  section_id = '5.1',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 120,
  skill_tags = ARRAY['SK_MVT_APPLY', 'SK_DERIV_SOLVE', 'SK_AROC'],
  primary_skill_id = 'SK_MVT_APPLY',
  supporting_skill_ids = ARRAY['SK_DERIV_SOLVE', 'SK_AROC'],
 'SK_AROC'], 'SK_AROC'],
  error_tags = ARRAY['E_MVT_COND_MISSED', 'E_AROC_ERROR', 'E_ALGEBRA_DERIV_ERROR'],
  prompt = 'Let $f(x)=x^3-3x$ on the interval $[0,2]$. By the Mean Value Theorem, there exists $c\in(0,2)$ such that
$$f''(c)=\frac{f(2)-f(0)}{2-0}.$$
Which value of $c$ satisfies this conclusion?',
  latex = 'Let $f(x)=x^3-3x$ on the interval $[0,2]$. By the Mean Value Theorem, there exists $c\in(0,2)$ such that
$$f''(c)=\frac{f(2)-f(0)}{2-0}.$$
Which value of $c$ satisfies this conclusion?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\dfrac{2}{\sqrt{3}}$','explanation','Compute the secant slope: $\dfrac{f(2)-f(0)}{2}=\dfrac{(8-6)-0}{2}=1$. Since $f''(x)=3x^2-3$, solve $3c^2-3=1\Rightarrow 3c^2=4\Rightarrow c=\dfrac{2}{\sqrt{3}}$ (the only solution in $(0,2)$).'),
    jsonb_build_object('id','B','text','$1$','explanation','If $c=1$, then $f''(1)=3(1)^2-3=0\neq 1$, so it does not match the required derivative value.'),
    jsonb_build_object('id','C','text','$\sqrt{\dfrac{4}{3}}$','explanation','$\sqrt{\dfrac{4}{3}}=\dfrac{2}{\sqrt{3}}$, so it represents the same number as option A. The simplified standard form is $\dfrac{2}{\sqrt{3}}$.'),
    jsonb_build_object('id','D','text','$\dfrac{4}{3}$','explanation','If $c=\dfrac{4}{3}$, then $f''(c)=3\left(\dfrac{16}{9}\right)-3=\dfrac{7}{3}\neq 1$.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'MVT gives $f''(c)=\dfrac{f(2)-f(0)}{2}$. Here $f(2)=2$ and $f(0)=0$, so the average rate is $1$. Solve $3c^2-3=1$ to get $c=\dfrac{2}{\sqrt{3}}$ in $(0,2)$.',
  recommendation_reasons = ARRAY['Core MVT workflow: compute secant slope, then solve $f''(c)=\text{secant}$.', 'Targets algebra and derivative-slope matching.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'MVT: solve for the point where tangent slope matches secant slope.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Analytical',
  updated_at = NOW()
WHERE title = '5.1-P1';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Analytical',
  sub_topic_id = '5.1',
  section_id = '5.1',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 75,
  skill_tags = ARRAY['SK_MVT_CONDITIONS', 'SK_CONTINUITY_CHECK', 'SK_DIFFERENTIABILITY_CHECK'],
  primary_skill_id = 'SK_MVT_CONDITIONS',
  supporting_skill_ids = ARRAY['SK_CONTINUITY_CHECK', 'SK_DIFFERENTIABILITY_CHECK'],
 'SK_DIFFERENTIABILITY_CHECK'], 'SK_DIFFERENTIABILITY_CHECK'],
  error_tags = ARRAY['E_MVT_COND_MISSED', 'E_CONT_VS_DIFF_CONFUSION'],
  prompt = 'Consider $f(x)=|x|$ on the interval $[-1,2]$. Which statement is correct regarding the Mean Value Theorem on this interval?',
  latex = 'Consider $f(x)=|x|$ on the interval $[-1,2]$. Which statement is correct regarding the Mean Value Theorem on this interval?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','MVT applies because $f$ is continuous on $[-1,2]$.','explanation','Continuity alone is not sufficient; differentiability on $( -1,2 )$ is also required.'),
    jsonb_build_object('id','B','text','MVT applies because $f$ is differentiable on $( -1,2 )$.','explanation','$f(x)=|x|$ is not differentiable at $x=0$, which lies in $( -1,2 )$.'),
    jsonb_build_object('id','C','text','MVT does not apply because $f$ is not differentiable at an interior point.','explanation','Correct: $f$ is continuous on $[-1,2]$ but not differentiable at $x=0$, so MVT cannot be applied.'),
    jsonb_build_object('id','D','text','MVT does not apply because $f$ is not continuous on $[-1,2]$.','explanation','$|x|$ is continuous everywhere, including on $[-1,2]$.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'The MVT requires $f$ continuous on $[a,b]$ and differentiable on $(a,b)$. Although $|x|$ is continuous on $[-1,2]$, it is not differentiable at $x=0\in(-1,2)$, so MVT does not apply.',
  recommendation_reasons = ARRAY['High-frequency trap: confusing continuity with differentiability for MVT.', 'Builds habit of checking hypotheses before applying a theorem.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 1,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'MVT condition check is a common MCQ target.',
  weight_primary = 1.00,
  weight_supporting = 0.00,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Analytical',
  updated_at = NOW()
WHERE title = '5.1-P2';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Analytical',
  sub_topic_id = '5.1',
  section_id = '5.1',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 80,
  skill_tags = ARRAY['SK_ROLLE', 'SK_THEOREM_SELECTION'],
  primary_skill_id = 'SK_ROLLE',
  supporting_skill_ids = ARRAY['SK_THEOREM_SELECTION'],

  error_tags = ARRAY['E_CONFUSE_MVT_ROLLE', 'E_MVT_COND_MISSED'],
  prompt = 'Suppose $f$ is continuous on $[a,b]$, differentiable on $(a,b)$, and $f(a)=f(b)$. Which statement must be true?',
  latex = 'Suppose $f$ is continuous on $[a,b]$, differentiable on $(a,b)$, and $f(a)=f(b)$. Which statement must be true?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','There exists $c\in(a,b)$ such that $f(c)=0$.','explanation','Not necessarily; $f$ could be always positive on $[a,b]$ while still having $f(a)=f(b)$.'),
    jsonb_build_object('id','B','text','There exists $c\in(a,b)$ such that $f''(c)=\dfrac{f(b)-f(a)}{b-a}$.','explanation','This is the MVT conclusion, but since $f(a)=f(b)$, it simplifies to $f''(c)=0$; the strongest correct statement is the explicit $f''(c)=0$.'),
    jsonb_build_object('id','C','text','There exists $c\in(a,b)$ such that $f''(c)=1$.','explanation','No fixed value like $1$ is guaranteed.'),
    jsonb_build_object('id','D','text','There exists $c\in(a,b)$ such that $f''(c)=0$.','explanation','Correct: by Rolle’s Theorem (a special case of MVT), $f''(c)=0$ for some $c\in(a,b)$.')
  ),
  correct_option_id = 'D',
  tolerance = 0.0010,
  explanation = 'Rolle’s Theorem applies under continuity on $[a,b]$, differentiability on $(a,b)$, and $f(a)=f(b)$, guaranteeing a point $c\in(a,b)$ with $f''(c)=0$.',
  recommendation_reasons = ARRAY['Tests recognizing Rolle’s as the $f(a)=f(b)$ case of MVT.', 'Targets theorem-identification errors.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 1,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Rolle’s is frequently tested as a named theorem/recognition item.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Analytical',
  updated_at = NOW()
WHERE title = '5.1-P3';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Analytical',
  sub_topic_id = '5.1',
  section_id = '5.1',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 150,
  skill_tags = ARRAY['SK_MVT_APPLY', 'SK_DERIV_BOUNDS', 'SK_INEQUALITY_REASONING'],
  primary_skill_id = 'SK_MVT_APPLY',
  supporting_skill_ids = ARRAY['SK_DERIV_BOUNDS', 'SK_INEQUALITY_REASONING'],
 'SK_INEQUALITY_REASONING'], 'SK_INEQUALITY_REASONING'],
  error_tags = ARRAY['E_BOUNDS_MONOTONICITY', 'E_INTERVAL_LOGIC', 'E_MVT_COND_MISSED'],
  prompt = 'Let $f(x)=\sqrt{x}$. Apply the Mean Value Theorem on $[4,4.1]$ to obtain a bound for $\sqrt{4.1}-2$. Which inequality is guaranteed?',
  latex = 'Let $f(x)=\sqrt{x}$. Apply the Mean Value Theorem on $[4,4.1]$ to obtain a bound for $\sqrt{4.1}-2$. Which inequality is guaranteed?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\dfrac{0.1}{4.1}<\sqrt{4.1}-2<\dfrac{0.1}{4}$','explanation','The derivative is $f''(x)=\dfrac{1}{2\sqrt{x}}$, not $\dfrac{1}{x}$. The denominators here are incorrect.'),
    jsonb_build_object('id','B','text','$\dfrac{0.1}{2\sqrt{4.1}}<\sqrt{4.1}-2<\dfrac{0.1}{4}$','explanation','Correct: MVT gives $\sqrt{4.1}-2=f''(c)(0.1)$ for some $c\in(4,4.1)$. Since $f''(x)=\frac{1}{2\sqrt{x}}$ is decreasing, $\frac{1}{2\sqrt{4.1}}<f''(c)<\frac{1}{2\sqrt{4}}=\frac14$. Multiply by $0.1$.'),
    jsonb_build_object('id','C','text','$\dfrac{0.1}{4}<\sqrt{4.1}-2<\dfrac{0.1}{2\sqrt{4.1}}$','explanation','The inequality direction is reversed because $f''(x)$ decreases on $[4,4.1]$.'),
    jsonb_build_object('id','D','text','$\sqrt{4.1}-2=\dfrac{0.1}{2\sqrt{4.05}}$','explanation','MVT guarantees existence of some $c$ but does not force $c$ to be the midpoint $4.05$.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'By MVT, $\sqrt{4.1}-\sqrt{4}=f''(c)(4.1-4)=\dfrac{1}{2\sqrt{c}}\cdot 0.1$ for some $c\in(4,4.1)$. Because $\dfrac{1}{2\sqrt{x}}$ decreases, $\dfrac{1}{2\sqrt{4.1}}<\dfrac{1}{2\sqrt{c}}<\dfrac14$. Multiply by $0.1$ to bound $\sqrt{4.1}-2$.',
  recommendation_reasons = ARRAY['AP-style: use MVT plus monotonicity of $f''$ to bound a difference.', 'Targets midpoint and inequality-direction misconceptions.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Key idea: MVT plus monotonicity of $f''$ yields inequalities.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Analytical',
  updated_at = NOW()
WHERE title = '5.1-P4';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Analytical',
  sub_topic_id = '5.1',
  section_id = '5.1',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 1,
  target_time_seconds = 55,
  skill_tags = ARRAY['SK_MVT_INTERPRET', 'SK_AROC'],
  primary_skill_id = 'SK_MVT_INTERPRET',
  supporting_skill_ids = ARRAY['SK_AROC'],

  error_tags = ARRAY['E_AROC_ERROR', 'E_MVT_COND_MISSED'],
  prompt = 'A function $f$ is continuous on $[1,5]$ and differentiable on $(1,5)$. If $f(1)=2$ and $f(5)=-6$, which statement must be true?',
  latex = 'A function $f$ is continuous on $[1,5]$ and differentiable on $(1,5)$. If $f(1)=2$ and $f(5)=-6$, which statement must be true?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','There exists $c\in(1,5)$ such that $f''(c)=-2$.','explanation','Correct: the average rate of change is $\dfrac{-6-2}{5-1}=-2$, so MVT guarantees $f''(c)=-2$ for some $c\in(1,5)$.'),
    jsonb_build_object('id','B','text','There exists $c\in(1,5)$ such that $f''(c)=2$.','explanation','The guaranteed value equals the average rate of change, which is $-2$, not $2$.'),
    jsonb_build_object('id','C','text','There exists $c\in(1,5)$ such that $f(c)=-2$.','explanation','That would follow from the Intermediate Value Theorem, not from MVT.'),
    jsonb_build_object('id','D','text','The function must have a local minimum on $(1,5)$.','explanation','MVT does not force a local extremum; it forces a tangent slope equal to the secant slope.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Compute the secant slope: $\dfrac{f(5)-f(1)}{5-1}=\dfrac{-6-2}{4}=-2$. MVT guarantees a point $c\in(1,5)$ where $f''(c)=-2$.',
  recommendation_reasons = ARRAY['Fast-check MVT item: compute AROC and state the guaranteed derivative value.', 'Targets sign errors in average rate of change.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 1,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Classic MVT conclusion from endpoint data.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Analytical',
  updated_at = NOW()
WHERE title = '5.1-P5';



-- Unit 5.2 (Extreme Value Theorem, Global vs Local Extrema, and Critical Points) — Practice 1–5

UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Analytical',
  sub_topic_id = '5.2',
  section_id = '5.2',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 1,
  target_time_seconds = 60,
  skill_tags = ARRAY['SK_EVT_APPLY', 'SK_CONTINUITY_CHECK'],
  primary_skill_id = 'SK_EVT_APPLY',
  supporting_skill_ids = ARRAY['SK_CONTINUITY_CHECK'],

  error_tags = ARRAY['E_EVT_HYP_MISSED', 'E_OPEN_VS_CLOSED_INTERVAL'],
  prompt = 'Let $f(x)=\dfrac{x-1}{x^2+1}$ on the interval $[0,3]$. Which statement is guaranteed?',
  latex = 'Let $f(x)=\dfrac{x-1}{x^2+1}$ on the interval $[0,3]$. Which statement is guaranteed?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$f$ has a local maximum on $(0,3)$.','explanation','Local extrema are not guaranteed by continuity alone.'),
    jsonb_build_object('id','B','text','$f$ attains both an absolute maximum value and an absolute minimum value on $[0,3]$.','explanation','Correct: $f$ is continuous on the closed interval $[0,3]$, so by EVT it achieves absolute max and min on that interval.'),
    jsonb_build_object('id','C','text','$f$ is differentiable on $[0,3]$.','explanation','Differentiability may be true here, but EVT does not require or guarantee differentiability; the key guarantee is absolute extrema on a closed interval.'),
    jsonb_build_object('id','D','text','$f$ has exactly two critical points in $(0,3)$.','explanation','EVT does not guarantee a specific number of critical points.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Because $x^2+1\neq 0$ for all real $x$, $f$ is continuous on $[0,3]$. The Extreme Value Theorem guarantees $f$ attains an absolute maximum and an absolute minimum on a closed interval.',
  recommendation_reasons = ARRAY['Direct EVT recognition: continuous + closed interval implies absolute extrema exist.', 'Targets open/closed interval confusion.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 1,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'EVT requires continuity on a closed interval; no differentiability needed.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Analytical',
  updated_at = NOW()
WHERE title = '5.2-P1';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Analytical',
  sub_topic_id = '5.2',
  section_id = '5.2',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 160,
  skill_tags = ARRAY['SK_CANDIDATES_TEST', 'SK_CRITICAL_POINTS_FIND', 'SK_FUNC_EVAL'],
  primary_skill_id = 'SK_CANDIDATES_TEST',
  supporting_skill_ids = ARRAY['SK_CRITICAL_POINTS_FIND', 'SK_FUNC_EVAL'],
 'SK_FUNC_EVAL'], 'SK_FUNC_EVAL'],
  error_tags = ARRAY['E_ENDPOINT_NEGLECT', 'E_CRITICALPOINT_MISDEF', 'E_ABS_EXTREMA_PROCESS'],
  prompt = 'Let $h(x)=x^4-4x^2+1$ on the interval $[-2,1]$. What is the absolute minimum value of $h$ on this interval?',
  latex = 'Let $h(x)=x^4-4x^2+1$ on the interval $[-2,1]$. What is the absolute minimum value of $h$ on this interval?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$-2$','explanation','$h(1)=-2$, but you must also check interior critical points; there is a smaller value.'),
    jsonb_build_object('id','B','text','$1$','explanation','$h(-2)=1$ and $h(0)=1$, but these are not minimum values on the interval.'),
    jsonb_build_object('id','C','text','$0$','explanation','No candidate point on $[-2,1]$ gives $0$ as the minimum here.'),
    jsonb_build_object('id','D','text','$-3$','explanation','Correct: $h''(x)=4x(x^2-2)$ gives critical points $x=0$ and $x=-\sqrt{2}$ in $[-2,1]$. Evaluate: $h(-2)=1$, $h(1)=-2$, $h(0)=1$, $h(-\sqrt{2})=4-8+1=-3$, so the absolute minimum value is $-3$.')
  ),
  correct_option_id = 'D',
  tolerance = 0.0010,
  explanation = 'Use the Candidates Test: endpoints $x=-2,1$ and critical points where $h''(x)=0$. Since $h''(x)=4x(x^2-2)$, candidates in $[-2,1]$ are $x=-2,1,0,-\sqrt{2}$. The smallest function value among these is $h(-\sqrt{2})=-3$.',
  recommendation_reasons = ARRAY['Absolute extrema MCQ: find critical points and check endpoints.', 'Targets the common mistake of skipping endpoints or skipping critical points.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Requires checking endpoints and interior critical points.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Analytical',
  updated_at = NOW()
WHERE title = '5.2-P2';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Analytical',
  sub_topic_id = '5.2',
  section_id = '5.2',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 130,
  skill_tags = ARRAY['SK_GRAPH_ABS_EXTREMA', 'SK_CANDIDATES_TEST', 'SK_GLOBAL_LOCAL_DISTINGUISH'],
  primary_skill_id = 'SK_GRAPH_ABS_EXTREMA',
  supporting_skill_ids = ARRAY['SK_CANDIDATES_TEST', 'SK_GLOBAL_LOCAL_DISTINGUISH'],
 'SK_GLOBAL_LOCAL_DISTINGUISH'], 'SK_GLOBAL_LOCAL_DISTINGUISH'],
  error_tags = ARRAY['E_ENDPOINT_NEGLECT', 'E_GLOBAL_LOCAL_CONFUSION', 'E_ABS_EXTREMA_PROCESS'],
  prompt = 'The graph of $f$ on $[-1,3]$ is shown in the provided image (5.2-P3.png). Which statement is supported by the graph?',
  latex = 'The graph of $f$ on $[-1,3]$ is shown in the provided image (5.2-P3.png). Which statement is supported by the graph?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','The absolute maximum occurs at $x=3$, and the absolute minimum occurs at $x=-1$.','explanation','From the graph, the highest point is slightly left of $x=0$, not at $x=3$, and the lowest point is near $x\approx 2$, not at $x=-1$.'),
    jsonb_build_object('id','B','text','The absolute maximum occurs at $x=-1$, and the absolute minimum occurs at $x=3$.','explanation','The endpoint values do not match the highest and lowest points shown.'),
    jsonb_build_object('id','C','text','The absolute maximum occurs at an interior point near $x\approx 0.1$, and the absolute minimum occurs at an interior point near $x\approx 2.0$.','explanation','Correct: the graph’s tallest peak is just right of $x=0$, and its lowest valley is near $x=2$; both occur in the interior of the interval.'),
    jsonb_build_object('id','D','text','The function has no absolute extrema on $[-1,3]$.','explanation','A continuous function on a closed interval must attain absolute max and min; the graph clearly shows highest and lowest points.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'Reading the graph on the closed interval $[-1,3]$, the highest point is a peak near $x\approx 0.1$ and the lowest point is a valley near $x\approx 2.0$. Thus the absolute maximum and absolute minimum are both attained at interior points.',
  recommendation_reasons = ARRAY['Graph-based absolute extrema: distinguish endpoint values from interior peaks/valleys.', 'Targets confusion between local vs absolute extrema.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: absolute extrema from a graph on a closed interval.',
  weight_primary = 0.60,
  weight_supporting = 0.40,
  prompt_type = 'text_and_image',
  representation_type = 'symbolic',
  topic_id = 'Both_Analytical',
  updated_at = NOW()
WHERE title = '5.2-P3';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Analytical',
  sub_topic_id = '5.2',
  section_id = '5.2',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 90,
  skill_tags = ARRAY['SK_CANDIDATES_TEST', 'SK_CRITICAL_POINTS_INTERPRET'],
  primary_skill_id = 'SK_CANDIDATES_TEST',
  supporting_skill_ids = ARRAY['SK_CRITICAL_POINTS_INTERPRET'],

  error_tags = ARRAY['E_ENDPOINT_NEGLECT', 'E_GLOBAL_LOCAL_CONFUSION', 'E_ABS_EXTREMA_PROCESS'],
  prompt = 'A function $f$ is continuous on $[0,4]$ and differentiable on $(0,4)$. The only critical points in $(0,4)$ are $x=1$ and $x=3$. The function values are
$$f(0)=2,\quad f(1)=5,\quad f(3)=1,\quad f(4)=4.$$
What is the absolute maximum value of $f$ on $[0,4]$?',
  latex = 'A function $f$ is continuous on $[0,4]$ and differentiable on $(0,4)$. The only critical points in $(0,4)$ are $x=1$ and $x=3$. The function values are
$$f(0)=2,\quad f(1)=5,\quad f(3)=1,\quad f(4)=4.$$
What is the absolute maximum value of $f$ on $[0,4]$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$5$','explanation','Correct: by the Candidates Test, check endpoints and critical points. The largest among $2,5,1,4$ is $5$.'),
    jsonb_build_object('id','B','text','$4$','explanation','$4$ is $f(4)$, but $f(1)=5$ is larger.'),
    jsonb_build_object('id','C','text','$2$','explanation','$2$ is $f(0)$, not the largest candidate value.'),
    jsonb_build_object('id','D','text','The absolute maximum cannot be determined from the information given.','explanation','It can be determined because EVT ensures an absolute maximum exists and the Candidates Test reduces the search to endpoints and critical points, whose values are provided.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Because $f$ is continuous on $[0,4]$, EVT guarantees an absolute maximum occurs at an endpoint or a critical point. Evaluate candidates $x=0,1,3,4$: values $2,5,1,4$. The greatest is $5$.',
  recommendation_reasons = ARRAY['Reinforces that absolute extrema occur at endpoints or critical points when conditions hold.', 'Builds process discipline for the Candidates Test.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Candidates Test using provided values (no calculus needed).',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Analytical',
  updated_at = NOW()
WHERE title = '5.2-P4';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Analytical',
  sub_topic_id = '5.2',
  section_id = '5.2',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 5,
  target_time_seconds = 170,
  skill_tags = ARRAY['SK_CRITICAL_POINTS_FIND', 'SK_PIECEWISE_DERIV', 'SK_NONDIFF_RECOGNIZE'],
  primary_skill_id = 'SK_CRITICAL_POINTS_FIND',
  supporting_skill_ids = ARRAY['SK_PIECEWISE_DERIV', 'SK_NONDIFF_RECOGNIZE'],
 'SK_NONDIFF_RECOGNIZE'], 'SK_NONDIFF_RECOGNIZE'],
  error_tags = ARRAY['E_CRITICALPOINT_MISDEF', 'E_INTERVAL_LOGIC', 'E_GLOBAL_LOCAL_CONFUSION'],
  prompt = 'Let $k(x)=|x-2|+x$ on the interval $(0,5)$. Which describes the set of critical points of $k$ in $(0,5)$?',
  latex = 'Let $k(x)=|x-2|+x$ on the interval $(0,5)$. Which describes the set of critical points of $k$ in $(0,5)$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','Only $x=2$','explanation','$x=2$ is critical because $k''$ does not exist there, but there are also points where $k''(x)=0$.'),
    jsonb_build_object('id','B','text','All $x$ with $0<x\le 2$','explanation','Correct: for $x<2$, $k(x)=-(x-2)+x=2$, so $k''(x)=0$ for all $x\in(0,2)$. At $x=2$, $k''$ is undefined, so $x=2$ is also critical. Thus the critical points in $(0,5)$ are $(0,2]$.'),
    jsonb_build_object('id','C','text','Only $x=0$ and $x=5$','explanation','Endpoints are not in $(0,5)$ and are not the only candidates anyway.'),
    jsonb_build_object('id','D','text','All $x$ with $2\le x<5$','explanation','For $x>2$, $k(x)=(x-2)+x=2x-2$, so $k''(x)=2$, not $0$, and $k''$ exists.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'For $x<2$, $k(x)=|x-2|+x=(2-x)+x=2$, so $k''(x)=0$ for all $x\in(0,2)$. At $x=2$, $k$ is not differentiable, so $2$ is a critical point. For $x>2$, $k(x)=(x-2)+x=2x-2$ so $k''(x)=2$. Therefore, the set of critical points in $(0,5)$ is $(0,2]$.',
  recommendation_reasons = ARRAY['Targets the precise definition: critical points include where $f''(x)=0$ or does not exist.', 'Addresses the misconception that only corners are critical points.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Common misconception: only corners are critical; also includes intervals where $f''(x)=0$.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Analytical',
  updated_at = NOW()
WHERE title = '5.2-P5';

END $block$;
