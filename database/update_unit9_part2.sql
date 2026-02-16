-- Unit 9.3 (Finding Arc Lengths of Curves Given by Parametric Equations) — Practice 1–5

BEGIN;

UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Motion',
  sub_topic_id = '9.3',
  section_id = '9.3',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 1,
  target_time_seconds = 75,
  skill_tags = ARRAY['SK_U9_ARC_LENGTH'],
  error_tags = ARRAY['E_ARCLEN_MISSING_SQRT', 'E_ARCLEN_CONFUSE_BOUNDS'],
  prompt = 'Let $x=3t$ and $y=4t$ for $0\le t\le 2$. What is the arc length of the curve on this interval?',
  latex = 'Let $x=3t$ and $y=4t$ for $0\le t\le 2$. What is the arc length of the curve on this interval?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$10$','explanation','Correct. $\frac{ds}{dt}=\sqrt{3^2+4^2}=5$, so $s=\int_0^2 5\,dt=10$.'),
    jsonb_build_object('id','B','text','$5$','explanation','This is the speed $\frac{ds}{dt}$, not the arc length over $[0,2]$.'),
    jsonb_build_object('id','C','text','$\sqrt{10}$','explanation','This comes from misapplying the formula and not integrating over $t$.'),
    jsonb_build_object('id','D','text','$20$','explanation','The distance from $(0,0)$ to $(6,8)$ is $10$, so $20$ is incorrect.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Arc length is $\int_a^b \sqrt{\left(\frac{dx}{dt}\right)^2+\left(\frac{dy}{dt}\right)^2}\,dt$. Here $\frac{dx}{dt}=3$, $\frac{dy}{dt}=4$, so integrand $=5$ and $s=\int_0^2 5\,dt=10$.',
  recommendation_reasons = ARRAY['Reinforces the arc length formula in a constant-speed case.','Targets confusion between speed and total arc length.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 0.85,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: arc length formula; constant speed.',
  weight_primary = 1.00,
  weight_supporting = 0.00,
    primary_skill_id = 'SK_U9_ARC_LENGTH',
  supporting_skill_ids = ARRAY[]::text[],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Motion',
  updated_at = NOW()
WHERE title = '9.3-P1';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Motion',
  sub_topic_id = '9.3',
  section_id = '9.3',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 130,
  skill_tags = ARRAY['SK_U9_ARC_LENGTH', 'SK_ALGEBRA_SIMPLIFY'],
  error_tags = ARRAY['E_ARCLEN_MISSING_SQRT', 'E_ARCLEN_FORGET_DYDT', 'E_ARCLEN_SQUARE_ROOT_ALGEBRA'],
  prompt = 'A curve is given by $x=t^2-1$ and $y=2t$ for $0\le t\le 2$. The graph of this parametric curve is provided.

![9.3-P2](9.3-P2.png)

Which integral gives the arc length of the curve on $[0,2]$?',
  latex = 'A curve is given by $x=t^2-1$ and $y=2t$ for $0\le t\le 2$. Which integral gives the arc length of the curve on $[0,2]$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\displaystyle \int_0^2 \sqrt{(2t)^2+(2)^2}\,dt$','explanation','Correct. Use $\sqrt{(dx/dt)^2+(dy/dt)^2}$.'),
    jsonb_build_object('id','B','text','$\displaystyle \int_0^2 \left((2t)^2+(2)^2\right)\,dt$','explanation','Missing the square root.'),
    jsonb_build_object('id','C','text','$\displaystyle \int_{-1}^{3} \sqrt{1+\left(\frac{dy}{dx}\right)^2}\,dx$','explanation','Requires extra conversion and careful bounds; direct setup is in $t$.'),
    jsonb_build_object('id','D','text','$\displaystyle \int_0^2 \sqrt{(t^2-1)^2+(2t)^2}\,dt$','explanation','Uses $x,y$ instead of derivatives.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Use $s=\int_0^2 \sqrt{(dx/dt)^2+(dy/dt)^2}\,dt$. Here $dx/dt=2t$ and $dy/dt=2$, so $s=\int_0^2 \sqrt{4t^2+4}\,dt$.',
  recommendation_reasons = ARRAY['Builds correct setup for parametric arc length.','Targets omitting the square root.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.05,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Image supports interpreting the parametric interval; core is correct arc length setup.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
    primary_skill_id = 'SK_U9_ARC_LENGTH',
  supporting_skill_ids = ARRAY['SK_ALGEBRA_SIMPLIFY'],
  prompt_type = 'text_and_image',
  representation_type = 'symbolic',
  topic_id = 'BC_Motion',
  updated_at = NOW()
WHERE title = '9.3-P2';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Motion',
  sub_topic_id = '9.3',
  section_id = '9.3',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 170,
  skill_tags = ARRAY['SK_U9_ARC_LENGTH', 'SK_INTEGRATION_SUB'],
  error_tags = ARRAY['E_ARCLEN_FORGET_DYDT', 'E_U_SUB_WRONG_DU', 'E_ARCLEN_SQUARE_ROOT_ALGEBRA'],
  prompt = 'Let $x=t^2$ and $y=t^3$ for $0\le t\le 1$. What is the arc length of the curve on this interval?',
  latex = 'Let $x=t^2$ and $y=t^3$ for $0\le t\le 1$. What is the arc length of the curve on this interval?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\displaystyle \frac{1}{27}\left(13\sqrt{13}-8\right)$','explanation','Correct.'),
    jsonb_build_object('id','B','text','$\displaystyle \frac{1}{18}\left(13\sqrt{13}-8\right)$','explanation','Constant error after substitution.'),
    jsonb_build_object('id','C','text','$\displaystyle \int_0^1 \sqrt{4+9t^2}\,dt$','explanation','Missing the factor $t$.'),
    jsonb_build_object('id','D','text','$\displaystyle \frac{5}{27}$','explanation','Drops radicals/powers incorrectly.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = '$x''=2t$, $y''=3t^2$. Then $\frac{ds}{dt}=\sqrt{4t^2+9t^4}=t\sqrt{4+9t^2}$ (for $t\ge0$). With $u=4+9t^2$, $du=18t\,dt$, $$s=\int_0^1 t\sqrt{4+9t^2}\,dt=\frac{1}{27}\left(13\sqrt{13}-8\right).$$',
  recommendation_reasons = ARRAY['Arc length with simplification and $u$-substitution.','Targets algebra mistakes inside square roots.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.25,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Key move: factor out $t$ then $u$-sub.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
    primary_skill_id = 'SK_U9_ARC_LENGTH',
  supporting_skill_ids = ARRAY['SK_INTEGRATION_SUB'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Motion',
  updated_at = NOW()
WHERE title = '9.3-P3';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Motion',
  sub_topic_id = '9.3',
  section_id = '9.3',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 105,
  skill_tags = ARRAY['SK_U9_PARAM_SPEED', 'SK_U9_ARC_LENGTH'],
  error_tags = ARRAY['E_CHAIN_RULE_PARAM', 'E_ARCLEN_MISSING_SQRT'],
  prompt = 'A parametric curve is given by $x=f(t)$ and $y=g(t)$. Which expression equals the speed $\dfrac{ds}{dt}$?',
  latex = 'A parametric curve is given by $x=f(t)$ and $y=g(t)$. Which expression equals the speed $\dfrac{ds}{dt}$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\sqrt{(f(t))^2+(g(t))^2}$','explanation','Distance from origin, not speed.'),
    jsonb_build_object('id','B','text','$\sqrt{(f''(t))^2+(g''(t))^2}$','explanation','Correct.'),
    jsonb_build_object('id','C','text','$(f''(t))^2+(g''(t))^2$','explanation','Speed-squared.'),
    jsonb_build_object('id','D','text','$\dfrac{g''(t)}{f''(t)}$','explanation','Slope $dy/dx$ when defined.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Velocity is $\langle f''(t),g''(t)\rangle$ and speed is its magnitude: $\frac{ds}{dt}=\sqrt{(f''(t))^2+(g''(t))^2}$.',
  recommendation_reasons = ARRAY['Locks in $\frac{ds}{dt}=\|\mathbf{r}''(t)\|$.','Distinguishes speed vs slope vs position magnitude.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 0.90,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Definition-level item.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
    primary_skill_id = 'SK_U9_PARAM_SPEED',
  supporting_skill_ids = ARRAY['SK_U9_ARC_LENGTH'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Motion',
  updated_at = NOW()
WHERE title = '9.3-P4';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Motion',
  sub_topic_id = '9.3',
  section_id = '9.3',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 110,
  skill_tags = ARRAY['SK_U9_ARC_LENGTH', 'SK_TRIG_DERIV'],
  error_tags = ARRAY['E_ARCLEN_MISSING_SQRT', 'E_TRIG_DERIV_SIGN'],
  prompt = 'Let $x=2\cos t$ and $y=2\sin t$ for $0\le t\le \frac{\pi}{2}$. What is the arc length on this interval?',
  latex = 'Let $x=2\cos t$ and $y=2\sin t$ for $0\le t\le \frac{\pi}{2}$. What is the arc length on this interval?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$2$','explanation','Speed, not total length.'),
    jsonb_build_object('id','B','text','$\pi$','explanation','Correct.'),
    jsonb_build_object('id','C','text','$\frac{\pi}{2}$','explanation','Forgets factor 2 in speed.'),
    jsonb_build_object('id','D','text','$4\pi$','explanation','Full circle length, not quarter.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = '$x''=-2\sin t$, $y''=2\cos t$ so speed $=\sqrt{4(\sin^2 t+\cos^2 t)}=2$. Thus $s=\int_0^{\pi/2}2\,dt=\pi$.',
  recommendation_reasons = ARRAY['Arc length with trig parameterization.','Targets speed vs length confusion.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 0.95,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Quarter-circle via parametric trig.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
    primary_skill_id = 'SK_U9_ARC_LENGTH',
  supporting_skill_ids = ARRAY['SK_TRIG_DERIV'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Motion',
  updated_at = NOW()
WHERE title = '9.3-P5';



-- Unit 9.4 (Defining and Differentiating Vector-Valued Functions) — Practice 1–5

UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Motion',
  sub_topic_id = '9.4',
  section_id = '9.4',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 1,
  target_time_seconds = 80,
  skill_tags = ARRAY['SK_U9_VECTOR_DERIV'],
  error_tags = ARRAY['E_VECTOR_COMPONENTWISE', 'E_DERIV_EXP'],
  prompt = 'Let $\mathbf{r}(t)=\langle t^2, e^t, \sin t\rangle$. What is $\mathbf{r}''(0)$?',
  latex = 'Let $\mathbf{r}(t)=\langle t^2, e^t, \sin t\rangle$. What is $\mathbf{r}''(0)$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\langle 0,1,0\rangle$','explanation','Misses that $\cos 0=1$.'),
    jsonb_build_object('id','B','text','$\langle 0,1,1\rangle$','explanation','Correct.'),
    jsonb_build_object('id','C','text','$\langle 2,e,0\rangle$','explanation','Wrong evaluation and trig derivative.'),
    jsonb_build_object('id','D','text','$\langle t^2,e^t,\sin t\rangle$','explanation','Not differentiated.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Differentiate componentwise: $\mathbf{r}''(t)=\langle 2t,e^t,\cos t\rangle$, so $\mathbf{r}''(0)=\langle 0,1,1\rangle$.',
  recommendation_reasons = ARRAY['Componentwise differentiation.','Targets derivative slips with $e^t$ and trig.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 1,
  mastery_weight = 0.80,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Componentwise derivative and evaluation.',
  weight_primary = 1.00,
  weight_supporting = 0.00,
    primary_skill_id = 'SK_U9_VECTOR_DERIV',
  supporting_skill_ids = ARRAY[]::text[],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Motion',
  updated_at = NOW()
WHERE title = '9.4-P1';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Motion',
  sub_topic_id = '9.4',
  section_id = '9.4',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 135,
  skill_tags = ARRAY['SK_U9_TANGENT_LINE', 'SK_U9_VECTOR_DERIV'],
  error_tags = ARRAY['E_TANGENT_VECTOR_USE_POSITION', 'E_VECTOR_COMPONENTWISE'],
  prompt = 'A plane curve is given by $\mathbf{r}(t)=\langle t, t^2\rangle$. Which is a parametric equation of the tangent line at $t=2$?',
  latex = 'A plane curve is given by $\mathbf{r}(t)=\langle t, t^2\rangle$. Which is a parametric equation of the tangent line at $t=2$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\langle 2,4\rangle+s\langle 1,4\rangle$','explanation','Correct.'),
    jsonb_build_object('id','B','text','$\langle 2,4\rangle+s\langle 2,4\rangle$','explanation','Uses position vector as direction.'),
    jsonb_build_object('id','C','text','$\langle 2,4\rangle+s\langle 1,2\rangle$','explanation','Direction should be $\langle 1,4\rangle$.'),
    jsonb_build_object('id','D','text','$\langle 2,4\rangle+s\langle 4,1\rangle$','explanation','Not parallel to $\langle 1,4\rangle$.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Point is $\mathbf{r}(2)=\langle 2,4\rangle$. Direction is $\mathbf{r}''(2)$ where $\mathbf{r}''(t)=\langle 1,2t\rangle$, so $\mathbf{r}''(2)=\langle 1,4\rangle$.',
  recommendation_reasons = ARRAY['Uses $\mathbf{r}(t_0)$ and $\mathbf{r}''(t_0)$ for tangent line.','Targets using position as direction.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.10,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Tangent line via vector form.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
    primary_skill_id = 'SK_U9_TANGENT_LINE',
  supporting_skill_ids = ARRAY['SK_U9_VECTOR_DERIV'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Motion',
  updated_at = NOW()
WHERE title = '9.4-P2';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Motion',
  sub_topic_id = '9.4',
  section_id = '9.4',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 175,
  skill_tags = ARRAY['SK_U9_VECTOR_SPEED', 'SK_DOT_PRODUCT'],
  error_tags = ARRAY['E_SPEED_INCREASING_USE_COMPONENT', 'E_DOT_PRODUCT_SIGN', 'E_VECTOR_SPEED_CONFUSE'],
  prompt = 'A particle has position $\mathbf{r}(t)=\langle t^2, t\rangle$. For $t>0$, when is the speed increasing?',
  latex = 'A particle has position $\mathbf{r}(t)=\langle t^2, t\rangle$. For $t>0$, when is the speed increasing?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','For all $t>0$','explanation','Correct.'),
    jsonb_build_object('id','B','text','For $0<t<1$ only','explanation','$\mathbf{v}\cdot\mathbf{a}$ stays positive for all $t>0$.'),
    jsonb_build_object('id','C','text','For $t>1$ only','explanation','No threshold occurs.'),
    jsonb_build_object('id','D','text','Never; the speed is constant','explanation','Speed is $\sqrt{4t^2+1}$, not constant.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = '$\mathbf{v}=\langle 2t,1\rangle$, $\mathbf{a}=\langle 2,0\rangle$, so $\mathbf{v}\cdot\mathbf{a}=4t>0$ for all $t>0$, hence speed is increasing for all $t>0$.',
  recommendation_reasons = ARRAY['Applies $\mathbf{v}\cdot\mathbf{a}>0$ criterion.','Targets checking components instead of dot product.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.25,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Speed increasing iff $\mathbf{v}\cdot\mathbf{a}>0$.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
    primary_skill_id = 'SK_U9_VECTOR_SPEED',
  supporting_skill_ids = ARRAY['SK_DOT_PRODUCT'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Motion',
  updated_at = NOW()
WHERE title = '9.4-P3';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Motion',
  sub_topic_id = '9.4',
  section_id = '9.4',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 145,
  skill_tags = ARRAY['SK_U9_DYDX_PARAM', 'SK_TRIG_DERIV'],
  error_tags = ARRAY['E_DYDX_DIVIDE_WRONG', 'E_TRIG_DERIV_SIGN', 'E_CHAIN_RULE_PARAM'],
  prompt = 'The plane curve is $\mathbf{r}(t)=\langle \cos t, \tfrac12\sin(2t)\rangle$. A tangent direction at $t=\frac{\pi}{3}$ is shown.

![9.4-P4](9.4-P4.png)

What is $\left.\dfrac{dy}{dx}\right|_{t=\pi/3}$?',
  latex = 'The plane curve is $\mathbf{r}(t)=\langle \cos t, \tfrac12\sin(2t)\rangle$. What is $\left.\dfrac{dy}{dx}\right|_{t=\pi/3}$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$-\sqrt{3}$','explanation','Negatives cancel, so slope is positive.'),
    jsonb_build_object('id','B','text','$\sqrt{3}$','explanation','Reciprocal error.'),
    jsonb_build_object('id','C','text','$\dfrac{\sqrt{3}}{3}$','explanation','Correct.'),
    jsonb_build_object('id','D','text','$-\dfrac{\sqrt{3}}{3}$','explanation','Sign error.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = '$dx/dt=-\sin t$ and $dy/dt=\cos(2t)$, so $\frac{dy}{dx}=\frac{\cos(2t)}{-\sin t}$. At $t=\pi/3$, this is $\frac{-1/2}{-\sqrt{3}/2}=\frac{\sqrt{3}}{3}$.',
  recommendation_reasons = ARRAY['Computes $dy/dx$ via $(dy/dt)/(dx/dt)$.','Targets sign and reciprocal errors.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.10,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Image emphasizes tangent direction.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
    primary_skill_id = 'SK_U9_DYDX_PARAM',
  supporting_skill_ids = ARRAY['SK_TRIG_DERIV'],
  prompt_type = 'text_and_image',
  representation_type = 'symbolic',
  topic_id = 'BC_Motion',
  updated_at = NOW()
WHERE title = '9.4-P4';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Motion',
  sub_topic_id = '9.4',
  section_id = '9.4',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 110,
  skill_tags = ARRAY['SK_U9_VECTOR_SPEED', 'SK_U9_VECTOR_DERIV'],
  error_tags = ARRAY['E_VECTOR_SPEED_CONFUSE', 'E_VECTOR_COMPONENTWISE'],
  prompt = 'For $t>0$, let $\mathbf{r}(t)=\langle 3t,4t\rangle$. What is the unit tangent vector $\mathbf{T}(t)$?',
  latex = 'For $t>0$, let $\mathbf{r}(t)=\langle 3t,4t\rangle$. What is the unit tangent vector $\mathbf{T}(t)$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\left\langle \frac{3}{5},\frac{4}{5}\right\rangle$','explanation','Correct.'),
    jsonb_build_object('id','B','text','$\left\langle \frac{3t}{5},\frac{4t}{5}\right\rangle$','explanation','Magnitude is $t$, not $1$.'),
    jsonb_build_object('id','C','text','$\left\langle \frac{3}{25},\frac{4}{25}\right\rangle$','explanation','Divides by $|\mathbf{v}|^2$.'),
    jsonb_build_object('id','D','text','$\langle 3,4\rangle$','explanation','Not normalized.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = '$\mathbf{v}=\mathbf{r}''=\langle 3,4\rangle$ has magnitude $5$, so $\mathbf{T}=\frac{1}{5}\langle 3,4\rangle=\left\langle \frac{3}{5},\frac{4}{5}\right\rangle$.',
  recommendation_reasons = ARRAY['Uses $\mathbf{T}=\mathbf{r}''/|\mathbf{r}''|$.','Targets normalization mistakes.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 0.95,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Unit tangent from constant velocity.',
  weight_primary = 0.60,
  weight_supporting = 0.40,
    primary_skill_id = 'SK_U9_VECTOR_SPEED',
  supporting_skill_ids = ARRAY['SK_U9_VECTOR_DERIV'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Motion',
  updated_at = NOW()
WHERE title = '9.4-P5';

COMMIT;
