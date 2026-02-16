-- Unit 8.13 (BC ONLY) The Arc Length of a Smooth, Planar Curve and Distance Traveled — Practice 1–5

BEGIN;

UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_AppIntegration',
  sub_topic_id = '8.13',
  section_id = '8.13',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 120,
  skill_tags = ARRAY['SK_ARCLENGTH_PARAM', 'SK_PARAM_DERIV'],
  error_tags = ARRAY['E_ARCLENGTH_FORMULA', 'E_FORGET_SQRT'],
  prompt = $p$The curve is given parametrically by $x=\cos t$ and $y=\sin t$ for $0\le t\le \frac{\pi}{2}$. The graph is shown in the figure labeled 8.13-P1. What is the exact arc length of the curve on this interval?$p$,
  latex = $l$The curve is given parametrically by $x=\cos t$ and $y=\sin t$ for $0\le t\le \frac{\pi}{2}$. The graph is shown in the figure labeled 8.13-P1. What is the exact arc length of the curve on this interval?$l$,
  options = jsonb_build_array(
    jsonb_build_object(
      'id','A',
      'text',$t$$1$$t$,
      'explanation',$x$This would be the speed (which is constant), not the total arc length over the entire interval.$x$
    ),
    jsonb_build_object(
      'id','B',
      'text',$t$$\frac{\pi}{2}$$t$,
      'explanation',$x$Correct: $\frac{dx}{dt}=-\sin t$ and $\frac{dy}{dt}=\cos t$, so speed $=\sqrt{\sin^2 t+\cos^2 t}=1$ and the length is $\int_0^{\pi/2}1\,dt=\frac{\pi}{2}$.$x$
    ),
    jsonb_build_object(
      'id','C',
      'text',$t$$\pi$$t$,
      'explanation',$x$This corresponds to a half-circle of radius $1$, not the quarter-circle traced here.$x$
    ),
    jsonb_build_object(
      'id','D',
      'text',$t$$2$$t$,
      'explanation',$x$This confuses arc length with a linear measure; the quarter-circle arc length is not $2$.$x$
    )
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = $e$Use parametric arc length:
$$L=\int_{0}^{\pi/2}\sqrt{\left(\frac{dx}{dt}\right)^2+\left(\frac{dy}{dt}\right)^2}\,dt.$$
Here $\frac{dx}{dt}=-\sin t$ and $\frac{dy}{dt}=\cos t$, so the integrand is $\sqrt{\sin^2 t+\cos^2 t}=1$.
Thus
$$L=\int_0^{\pi/2}1\,dt=\frac{\pi}{2}.$$ $e$,
  recommendation_reasons = ARRAY['Reinforces the parametric arc length formula.', 'Targets correct speed computation from derivatives.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'BC Only: parametric arc length with constant speed.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
    primary_skill_id = 'SK_ARCLENGTH_PARAM',
  supporting_skill_ids = ARRAY['SK_PARAM_DERIV'],
  prompt_type = 'text_and_image',
  representation_type = 'symbolic',
  topic_id = 'Both_AppIntegration',
  updated_at = NOW()
WHERE title = '8.13-P1';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_AppIntegration',
  sub_topic_id = '8.13',
  section_id = '8.13',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 180,
  skill_tags = ARRAY['SK_ARCLENGTH_PARAM', 'SK_U_SUB'],
  error_tags = ARRAY['E_ARCLENGTH_FORMULA', 'E_SUB_BOUNDS'],
  prompt = $p$A curve is given parametrically by $x=t^2$ and $y=\frac{2}{3}t^3$ for $0\le t\le 1$. What is the exact arc length of the curve on this interval?$p$,
  latex = $l$A curve is given parametrically by $x=t^2$ and $y=\frac{2}{3}t^3$ for $0\le t\le 1$. What is the exact arc length of the curve on this interval?$l$,
  options = jsonb_build_array(
    jsonb_build_object(
      'id','A',
      'text',$t$$\frac{2}{3}\left(\sqrt{2}-1\right)$$t$,
      'explanation',$x$This typically comes from integrating $\sqrt{1+t^2}$ while missing the needed $2t$ factor in the integrand.$x$
    ),
    jsonb_build_object(
      'id','B',
      'text',$t$$\frac{2}{3}$$t$,
      'explanation',$x$This treats $\sqrt{u}$ as $u$ during substitution, which is not correct.$x$
    ),
    jsonb_build_object(
      'id','C',
      'text',$t$$\frac{2}{3}\left(2\sqrt{2}+1\right)$$t$,
      'explanation',$x$This indicates an incorrect evaluation at the lower bound $u=1$.$x$
    ),
    jsonb_build_object(
      'id','D',
      'text',$t$$\frac{2}{3}\left(2\sqrt{2}-1\right)$$t$,
      'explanation',$x$Correct: the integral becomes $\int_1^2\sqrt{u}\,du=\frac{2}{3}\left(2\sqrt{2}-1\right)$.$x$
    )
  ),
  correct_option_id = 'D',
  tolerance = 0.0010,
  explanation = $e$Compute derivatives: $\frac{dx}{dt}=2t$ and $\frac{dy}{dt}=2t^2$.
Then
$$L=\int_0^1\sqrt{(2t)^2+(2t^2)^2}\,dt=\int_0^1 2t\sqrt{1+t^2}\,dt.$$
Let $u=1+t^2$, so $du=2t\,dt$. When $t=0$, $u=1$; when $t=1$, $u=2$.
Thus
$$L=\int_1^2\sqrt{u}\,du=\left[\frac{2}{3}u^{3/2}\right]_1^2=\frac{2}{3}\left(2\sqrt{2}-1\right).$$ $e$,
  recommendation_reasons = ARRAY['Builds fluency converting parametric arc length to a single-variable integral.', 'Targets clean $u$-substitution with correct bounds.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Emphasis: correct speed setup and bounds after substitution.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
    primary_skill_id = 'SK_ARCLENGTH_PARAM',
  supporting_skill_ids = ARRAY['SK_U_SUB'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_AppIntegration',
  updated_at = NOW()
WHERE title = '8.13-P2';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_AppIntegration',
  sub_topic_id = '8.13',
  section_id = '8.13',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 150,
  skill_tags = ARRAY['SK_DISTANCE_TRAVELED', 'SK_AREA_FROM_GRAPH'],
  error_tags = ARRAY['E_DISPLACEMENT_VS_DISTANCE', 'E_MISSING_ABS_VALUE'],
  prompt = $p$A particle moves along a line with velocity $v(t)$ shown in the figure labeled 8.13-P3. What is the total distance traveled from $t=0$ to $t=6$?$p$,
  latex = $l$A particle moves along a line with velocity $v(t)$ shown in the figure labeled 8.13-P3. What is the total distance traveled from $t=0$ to $t=6$?$l$,
  options = jsonb_build_array(
    jsonb_build_object(
      'id','A',
      'text',$t$$3$$t$,
      'explanation',$x$This is the net displacement $\int_0^6 v(t)\,dt$, not the total distance traveled.$x$
    ),
    jsonb_build_object(
      'id','B',
      'text',$t$$5$$t$,
      'explanation',$x$This undercounts the absolute area on one interval or fails to take absolute value on the negative portion.$x$
    ),
    jsonb_build_object(
      'id','C',
      'text',$t$$7$$t$,
      'explanation',$x$Correct: distance is $\int_0^6 |v(t)|\,dt$, which is the sum of the areas under $|v|$: $2\cdot2+1\cdot2+0.5\cdot2=7$.$x$
    ),
    jsonb_build_object(
      'id','D',
      'text',$t$$8$$t$,
      'explanation',$x$This typically comes from using incorrect interval widths when adding areas.$x$
    )
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = $e$Total distance traveled is
$$\int_0^6 |v(t)|\,dt.$$
From the graph: $v=2$ on $[0,2]$, $v=-1$ on $[2,4]$, and $v=0.5$ on $[4,6]$.
So
$$\int_0^2 2\,dt+\int_2^4 1\,dt+\int_4^6 0.5\,dt=4+2+1=7.$$ $e$,
  recommendation_reasons = ARRAY['Separates displacement from total distance.', 'Reinforces $\int |v(t)|dt$ and area-from-graph reasoning.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Key idea: distance uses absolute value; displacement uses signed area.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
    primary_skill_id = 'SK_DISTANCE_TRAVELED',
  supporting_skill_ids = ARRAY['SK_AREA_FROM_GRAPH'],
  prompt_type = 'text_and_image',
  representation_type = 'symbolic',
  topic_id = 'Both_AppIntegration',
  updated_at = NOW()
WHERE title = '8.13-P3';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_AppIntegration',
  sub_topic_id = '8.13',
  section_id = '8.13',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 5,
  target_time_seconds = 210,
  skill_tags = ARRAY['SK_ARCLENGTH_FUNC', 'SK_INT_TECH'],
  error_tags = ARRAY['E_ARCLENGTH_FORMULA', 'E_FORGET_SQRT'],
  prompt = $p$Find the exact arc length of $y=x^2$ on the interval $0\le x\le 1$.$p$,
  latex = $l$Find the exact arc length of $y=x^2$ on the interval $0\le x\le 1$.$l$,
  options = jsonb_build_array(
    jsonb_build_object(
      'id','A',
      'text',$t$$\frac{1}{4}\left(2\sqrt{5}+\ln\left(2+\sqrt{5}\right)\right)$$t$,
      'explanation',$x$Correct: arc length is $\int_0^1\sqrt{1+4x^2}\,dx$, which evaluates to this exact expression.$x$
    ),
    jsonb_build_object(
      'id','B',
      'text',$t$$\sqrt{5}$$t$,
      'explanation',$x$This treats arc length as a straight-line distance between endpoints (a chord), not the curve length.$x$
    ),
    jsonb_build_object(
      'id','C',
      'text',$t$$\frac{7}{3}$$t$,
      'explanation',$x$This forgets the square root in the arc length formula and integrates $1+4x^2$ instead.$x$
    ),
    jsonb_build_object(
      'id','D',
      'text',$t$$\frac{1}{4}\left(2\sqrt{5}-\ln\left(2+\sqrt{5}\right)\right)$$t$,
      'explanation',$x$This has the logarithm term with the wrong sign.$x$
    )
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = $e$For $y=x^2$, we have $y'=2x$, so
$$L=\int_0^1\sqrt{1+(2x)^2}\,dx=\int_0^1\sqrt{1+4x^2}\,dx.$$
A standard antiderivative is
$$\int\sqrt{1+4x^2}\,dx=\frac{x}{2}\sqrt{1+4x^2}+\frac{1}{4}\ln\left(2x+\sqrt{1+4x^2}\right)+C.$$
Evaluating from $0$ to $1$ gives
$$L=\frac{1}{4}\left(2\sqrt{5}+\ln\left(2+\sqrt{5}\right)\right).$$ $e$,
  recommendation_reasons = ARRAY['Checks correct setup of $\sqrt{1+(y'')^2}$.', 'Targets a high-frequency AP BC exact-form arc length evaluation.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Exact-form arc length; common error is dropping the square root.',
  weight_primary = 0.75,
  weight_supporting = 0.25,
    primary_skill_id = 'SK_ARCLENGTH_FUNC',
  supporting_skill_ids = ARRAY['SK_INT_TECH'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_AppIntegration',
  updated_at = NOW()
WHERE title = '8.13-P4';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_AppIntegration',
  sub_topic_id = '8.13',
  section_id = '8.13',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 160,
  skill_tags = ARRAY['SK_DISTANCE_TRAVELED', 'SK_SIGN_ANALYSIS'],
  error_tags = ARRAY['E_MISSING_ABS_VALUE', 'E_DISPLACEMENT_VS_DISTANCE'],
  prompt = $p$A particle's position is $s(t)=t^3-6t^2+9t$ for $0\le t\le 4$. What is the total distance traveled on $[0,4]$?$p$,
  latex = $l$A particle's position is $s(t)=t^3-6t^2+9t$ for $0\le t\le 4$. What is the total distance traveled on $[0,4]$?$l$,
  options = jsonb_build_array(
    jsonb_build_object(
      'id','A',
      'text',$t$$4$$t$,
      'explanation',$x$This is $|s(4)-s(0)|$, the magnitude of displacement, not the total distance traveled.$x$
    ),
    jsonb_build_object(
      'id','B',
      'text',$t$$12$$t$,
      'explanation',$x$Correct: velocity changes sign at $t=1$ and $t=3$, so distance is the sum of absolute position changes across the three intervals.$x$
    ),
    jsonb_build_object(
      'id','C',
      'text',$t$$8$$t$,
      'explanation',$x$This usually results from missing one interval created by a sign change in velocity.$x$
    ),
    jsonb_build_object(
      'id','D',
      'text',$t$$0$$t$,
      'explanation',$x$This would require the particle to end where it started without moving, which is not true.$x$
    )
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = $e$Velocity is $v(t)=s'(t)=3t^2-12t+9=3(t-1)(t-3)$, so sign changes occur at $t=1$ and $t=3$.
Compute positions: $s(0)=0$, $s(1)=4$, $s(3)=0$, and $s(4)=4$.
Total distance is
$$|s(1)-s(0)|+|s(3)-s(1)|+|s(4)-s(3)|=|4-0|+|0-4|+|4-0|=12.$$ $e$,
  recommendation_reasons = ARRAY['Forces correct use of $|v(t)|$ via sign analysis.', 'Reinforces splitting at velocity zeros to avoid absolute-value mistakes.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Last regular chapter in Unit 8; next step will enter Unit Test.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
    primary_skill_id = 'SK_DISTANCE_TRAVELED',
  supporting_skill_ids = ARRAY['SK_SIGN_ANALYSIS'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_AppIntegration',
  updated_at = NOW()
WHERE title = '8.13-P5';

COMMIT;
