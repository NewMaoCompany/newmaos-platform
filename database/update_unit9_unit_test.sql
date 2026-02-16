-- BC Unit 9 — Unit Test (20 MCQs)

BEGIN;

-- Q1
UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Motion',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 90,
  skill_tags = ARRAY['SK_PARAM_DYDX', 'SK_ALGEBRA_SIMPLIFY'],
  error_tags = ARRAY['E_INVERT_DYDX_PARAM', 'E_ALGEBRA'],
  prompt = 'For the parametric curve $x=t^2+1$ and $y=\ln(t)$ with $t>0$, what is $\dfrac{dy}{dx}$ when $t=1$?',
  latex = 'For the parametric curve $$x=t^2+1,\quad y=\ln(t),\quad t>0,$$ what is $$\frac{dy}{dx}$$ when $t=1$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\dfrac{1}{2}$','explanation','Correct: $\dfrac{dy}{dx}=\dfrac{dy/dt}{dx/dt}=\dfrac{(1/t)}{2t}=\dfrac{1}{2t^2}$, so at $t=1$ it is $\dfrac{1}{2}$.'),
    jsonb_build_object('id','B','text','$2$','explanation','This inverts the ratio (computes $\dfrac{dx}{dy}$) instead of $\dfrac{dy}{dx}$.'),
    jsonb_build_object('id','C','text','$1$','explanation','This forgets to divide by $dx/dt$ or miscomputes a derivative.'),
    jsonb_build_object('id','D','text','$\dfrac{1}{2t}$','explanation','Algebra error: $\dfrac{(1/t)}{2t}=\dfrac{1}{2t^2}$, not $\dfrac{1}{2t}$.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Compute $dy/dt=1/t$ and $dx/dt=2t$. Then
$$\frac{dy}{dx}=\frac{dy/dt}{dx/dt}=\frac{1/t}{2t}=\frac{1}{2t^2}.$$
At $t=1$, $\dfrac{dy}{dx}=\dfrac{1}{2}$.',
  recommendation_reasons = ARRAY['Reinforces $\frac{dy}{dx}=\frac{dy/dt}{dx/dt}$ for parametric curves.', 'Targets the common inversion and simplification errors.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Unit Test: Parametric derivative at a parameter value.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
    primary_skill_id = 'SK_PARAM_DYDX',
  supporting_skill_ids = ARRAY['SK_ALGEBRA_SIMPLIFY'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Motion',
  updated_at = NOW()
WHERE title = '9.0-UT-Q1';

-- Q2
UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Motion',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 150,
  skill_tags = ARRAY['SK_PARAM_D2YDX2', 'SK_PARAM_DYDX'],
  error_tags = ARRAY['E_MISS_DIVIDE_BY_DXDT', 'E_INVERT_DYDX_PARAM'],
  prompt = 'A curve is given by $x=\sin t$ and $y=\cos t$. What is $\dfrac{d^2y}{dx^2}$ at $t=\dfrac{\pi}{4}$?',
  latex = 'A curve is given by $$x=\sin t,\quad y=\cos t.$$ What is $$\frac{d^2y}{dx^2}$$ at $t=\frac{\pi}{4}$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$-\sqrt{2}$','explanation','This typically stops too early (e.g., at $d/dt(dy/dx)$) or divides by the wrong quantity.'),
    jsonb_build_object('id','B','text','$-2$','explanation','This often comes from evaluating $\sec^2(\pi/4)=2$ but missing the final division by $dx/dt$.'),
    jsonb_build_object('id','C','text','$-2\sqrt{2}$','explanation','Correct: $\dfrac{dy}{dx}=\dfrac{-\sin t}{\cos t}=-\tan t$, so $\dfrac{d}{dt}(dy/dx)=-\sec^2 t$. Then $\dfrac{d^2y}{dx^2}=\dfrac{-\sec^2 t}{dx/dt}=\dfrac{-\sec^2 t}{\cos t}=-\sec^3 t$. At $t=\pi/4$, $\sec t=\sqrt2$, so $-\sec^3 t=-2\sqrt2$.'),
    jsonb_build_object('id','D','text','$2\sqrt{2}$','explanation','Sign error: the second derivative is negative here.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'First,
$$\frac{dy}{dx}=\frac{dy/dt}{dx/dt}=\frac{-\sin t}{\cos t}=-\tan t.$$
Then
$$\frac{d^2y}{dx^2}=\frac{\frac{d}{dt}(dy/dx)}{dx/dt}=\frac{-\sec^2 t}{\cos t}=-\sec^3 t.$$
At $t=\pi/4$, $\sec(\pi/4)=\sqrt2$, so $\dfrac{d^2y}{dx^2}=-2\sqrt2$.',
  recommendation_reasons = ARRAY['Builds the correct parametric second-derivative workflow.', 'Targets the frequent omission: divide by $dx/dt$ at the end.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.10,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Unit Test: Parametric second derivative.',
  weight_primary = 0.75,
  weight_supporting = 0.25,
    primary_skill_id = 'SK_PARAM_D2YDX2',
  supporting_skill_ids = ARRAY['SK_PARAM_DYDX'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Motion',
  updated_at = NOW()
WHERE title = '9.0-UT-Q2';

-- Q3
UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Motion',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 135,
  skill_tags = ARRAY['SK_PARAM_ARC_LENGTH', 'SK_ALGEBRA_SIMPLIFY'],
  error_tags = ARRAY['E_ARC_LENGTH_FORMULA', 'E_DROP_SQRT'],
  prompt = 'Find the arc length of the parametric curve $x=3t$ and $y=4t$ for $0\le t\le 2$.',
  latex = 'Find the arc length of the parametric curve $$x=3t,\quad y=4t,$$ for $$0\le t\le 2.$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$14$','explanation','This adds speeds instead of using $\sqrt{(dx/dt)^2+(dy/dt)^2}$.'),
    jsonb_build_object('id','B','text','$10$','explanation','Correct: $L=\int_0^2\sqrt{3^2+4^2}\,dt=\int_0^2 5\,dt=10$.'),
    jsonb_build_object('id','C','text','$\dfrac{25}{2}$','explanation','This forgets the square root and uses $\int(x''^2+y''^2)\,dt$.'),
    jsonb_build_object('id','D','text','$5$','explanation','This computes speed correctly but forgets to multiply by the time interval length.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Arc length is
$$L=\int_0^2\sqrt{\left(\frac{dx}{dt}\right)^2+\left(\frac{dy}{dt}\right)^2}\,dt
=\int_0^2\sqrt{3^2+4^2}\,dt=\int_0^2 5\,dt=10.$$',
  recommendation_reasons = ARRAY['Reinforces $L=\int\sqrt{x''^2+y''^2}\,dt$ for parametrics.', 'Targets the common missing-square-root error.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Unit Test: Parametric arc length with constant speed.',
  weight_primary = 0.85,
  weight_supporting = 0.15,
    primary_skill_id = 'SK_PARAM_ARC_LENGTH',
  supporting_skill_ids = ARRAY['SK_ALGEBRA_SIMPLIFY'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Motion',
  updated_at = NOW()
WHERE title = '9.0-UT-Q3';

-- Q4
UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Motion',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 165,
  skill_tags = ARRAY['SK_PARAM_ARC_LENGTH', 'SK_TRIG_IDENTITIES'],
  error_tags = ARRAY['E_ARC_LENGTH_FORMULA', 'E_ALGEBRA'],
  prompt = 'A curve is given by $x=\cos t$ and $y=\sin t$ for $0\le t\le \pi$. What is its arc length?',
  latex = 'A curve is given by $$x=\cos t,\quad y=\sin t,$$ for $$0\le t\le \pi.$$ What is its arc length?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$2$','explanation','This is a diameter-like value, not an arc length.'),
    jsonb_build_object('id','B','text','$\pi^2$','explanation','Arc length does not square the interval length.'),
    jsonb_build_object('id','C','text','$1$','explanation','This is the radius, not the semicircular arc length.'),
    jsonb_build_object('id','D','text','$\pi$','explanation','Correct: speed is $\sqrt{(-\sin t)^2+(\cos t)^2}=1$, so $L=\int_0^\pi 1\,dt=\pi$.')
  ),
  correct_option_id = 'D',
  tolerance = 0.0010,
  explanation = 'Compute $dx/dt=-\sin t$ and $dy/dt=\cos t$. Then the speed is
$$\sqrt{(-\sin t)^2+(\cos t)^2}=\sqrt{\sin^2 t+\cos^2 t}=1,$$
so
$$L=\int_0^\pi 1\,dt=\pi.$$',
  recommendation_reasons = ARRAY['Connects parametric arc length to constant speed via $\sin^2+\cos^2=1$.', 'Builds fast recognition for semicircle parametrizations.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.05,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Unit Test: Arc length using trig identity.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
    primary_skill_id = 'SK_PARAM_ARC_LENGTH',
  supporting_skill_ids = ARRAY['SK_TRIG_IDENTITIES'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Motion',
  updated_at = NOW()
WHERE title = '9.0-UT-Q4';

-- Q5
UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Motion',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 105,
  skill_tags = ARRAY['SK_VECTOR_DERIV', 'SK_VECTOR_COMPONENTS'],
  error_tags = ARRAY['E_VECTOR_COMPONENT', 'E_ALGEBRA'],
  prompt = 'Let $\vec r(t)=\langle t^3-2t,\ e^{t}\rangle$. What is $\vec r\,''(t)$?',
  latex = 'Let $$\vec r(t)=\langle t^3-2t,\ e^{t}\rangle.$$ What is $$\vec r\,''(t)?$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\langle 3t^2-2,\ e^{t}\rangle$','explanation','Correct: differentiate each component.'),
    jsonb_build_object('id','B','text','$\langle 3t^2-2t,\ te^{t}\rangle$','explanation','Derivative errors: $d(-2t)/dt=-2$, and $d(e^t)/dt=e^t$ (no product rule).'),
    jsonb_build_object('id','C','text','$\langle 3t^2,\ e^{t}\rangle$','explanation','Drops the $-2$ from differentiating $-2t$.'),
    jsonb_build_object('id','D','text','$\langle 3t^2-2,\ e^{t-1}\rangle$','explanation','Incorrect derivative of $e^t$.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Differentiate component-wise:
$$\frac{d}{dt}(t^3-2t)=3t^2-2,\quad \frac{d}{dt}(e^t)=e^t.$$
So $\vec r\,''(t)=\langle 3t^2-2,\ e^t\rangle$.',
  recommendation_reasons = ARRAY['Checks that vector derivatives are computed component-wise.', 'Targets the common dropped-term mistake.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Unit Test: Vector-valued differentiation.',
  weight_primary = 0.85,
  weight_supporting = 0.15,
    primary_skill_id = 'SK_VECTOR_DERIV',
  supporting_skill_ids = ARRAY['SK_VECTOR_COMPONENTS'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Motion',
  updated_at = NOW()
WHERE title = '9.0-UT-Q5';

-- Q6
UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Motion',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 150,
  skill_tags = ARRAY['SK_VECTOR_INTEGRAL', 'SK_INITIAL_CONDITIONS'],
  error_tags = ARRAY['E_FORGET_IC', 'E_VECTOR_COMPONENT'],
  prompt = 'A particle has velocity $\vec v(t)=\langle 2t,\ \cos t\rangle$ and position $\vec r(0)=\langle 1,\ -2\rangle$. What is $\vec r(t)$?',
  latex = 'A particle has velocity $$\vec v(t)=\langle 2t,\ \cos t\rangle$$ and position $$\vec r(0)=\langle 1,\ -2\rangle.$$ What is $$\vec r(t)?$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\langle t^2+1,\ \sin t-2\rangle$','explanation','Correct: integrate each component and apply $\vec r(0)$.'),
    jsonb_build_object('id','B','text','$\langle t^2,\ \sin t\rangle$','explanation','Forgets the initial position constants.'),
    jsonb_build_object('id','C','text','$\langle t^2+1,\ -\sin t-2\rangle$','explanation','Sign error: $\int \cos t\,dt=\sin t$, not $-\sin t$.'),
    jsonb_build_object('id','D','text','$\langle 2t^2+1,\ \sin t-2\rangle$','explanation','Integrates $2t$ incorrectly.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Since $\vec r\,''(t)=\vec v(t)$, integrate:
$$x(t)=\int 2t\,dt=t^2+C_1,\quad y(t)=\int \cos t\,dt=\sin t+C_2.$$
Use $\vec r(0)=\langle 1,-2\rangle$ to get $C_1=1$ and $C_2=-2$, so
$$\vec r(t)=\langle t^2+1,\ \sin t-2\rangle.$$',
  recommendation_reasons = ARRAY['Connects velocity to position via component-wise integration.', 'Targets the high-frequency “forgot the initial condition” error.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.05,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Unit Test: Vector integration with initial condition.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
    primary_skill_id = 'SK_VECTOR_INTEGRAL',
  supporting_skill_ids = ARRAY['SK_INITIAL_CONDITIONS'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Motion',
  updated_at = NOW()
WHERE title = '9.0-UT-Q6';

-- Q7
UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Motion',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 180,
  skill_tags = ARRAY['SK_MOTION_SPEED', 'SK_VECTOR_DERIV'],
  error_tags = ARRAY['E_VECTOR_COMPONENT', 'E_ALGEBRA'],
  prompt = 'A particle’s position is $\vec r(t)=\langle t^2-1,\ 2t^3\rangle$. For what $t>0$ is the speed equal to $10$?',
  latex = 'A particle’s position is $$\vec r(t)=\langle t^2-1,\ 2t^3\rangle.$$ For what $t>0$ is the speed equal to $10$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$t=\sqrt{2}$','explanation','This is not obtained from solving $|\vec v(t)|=10$.'),
    jsonb_build_object('id','B','text','$t=\sqrt{\dfrac{-1+\sqrt{901}}{18}}$','explanation','Correct: $\vec v(t)=\langle 2t,6t^2\rangle$, so $|\vec v|=\sqrt{4t^2+36t^4}=10$ leads to $9t^4+t^2-25=0$, then $t^2=\dfrac{-1+\sqrt{901}}{18}$ and $t>0$.'),
    jsonb_build_object('id','C','text','$t=\dfrac{5}{3}$','explanation','This incorrectly treats $\sqrt{4t^2+36t^4}$ as $2t+6t^2$.'),
    jsonb_build_object('id','D','text','$t=1$','explanation','At $t=1$, speed is $\sqrt{(2)^2+(6)^2}=\sqrt{40}\ne 10$.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Velocity is $\vec v(t)=\vec r\,''(t)=\langle 2t,6t^2\rangle$, so speed is
$$|\vec v|=\sqrt{(2t)^2+(6t^2)^2}=\sqrt{4t^2+36t^4}.$$
Set $\sqrt{4t^2+36t^4}=10$:
$$4t^2+36t^4=100\;\Rightarrow\;9t^4+t^2-25=0.$$
Let $u=t^2$. Then $9u^2+u-25=0$, so
$$u=\frac{-1+\sqrt{901}}{18}\quad(\text{positive root}).$$
Thus $t=\sqrt{\dfrac{-1+\sqrt{901}}{18}}$ for $t>0$.',
  recommendation_reasons = ARRAY['Reinforces speed as the magnitude of velocity.', 'Targets incorrect “splitting the square root” algebra.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.10,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Unit Test: Solve for time given speed from vector position.',
  weight_primary = 0.75,
  weight_supporting = 0.25,
    primary_skill_id = 'SK_MOTION_SPEED',
  supporting_skill_ids = ARRAY['SK_VECTOR_DERIV'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Motion',
  updated_at = NOW()
WHERE title = '9.0-UT-Q7';

-- Q8
UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Motion',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 150,
  skill_tags = ARRAY['SK_PARAM_DYDX', 'SK_VECTOR_DERIV'],
  error_tags = ARRAY['E_INVERT_DYDX_PARAM', 'E_ALGEBRA'],
  prompt = 'Refer to the figure (image). A particle has position $\vec r(t)=\langle t,\ t^2\rangle$ for $0\le t\le 2$. What is the slope $\dfrac{dy}{dx}$ of the path at $t=1$?',
  latex = 'Refer to the figure (image). A particle has position $$\vec r(t)=\langle t,\ t^2\rangle,$$ $0\le t\le 2$. What is the slope $$\frac{dy}{dx}$$ at $t=1$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$0$','explanation','This incorrectly assumes a horizontal tangent at $t=1$.'),
    jsonb_build_object('id','B','text','$1$','explanation','This uses $dy/dt=t$ instead of $dy/dt=2t$.'),
    jsonb_build_object('id','C','text','$\dfrac{1}{2}$','explanation','This computes the reciprocal slope (i.e., $dx/dy$).'),
    jsonb_build_object('id','D','text','$2$','explanation','Correct: $dx/dt=1$ and $dy/dt=2t$, so $dy/dx=2t$. At $t=1$, slope is $2$.')
  ),
  correct_option_id = 'D',
  tolerance = 0.0010,
  explanation = 'Here $x=t$ and $y=t^2$. Then $dx/dt=1$ and $dy/dt=2t$, so
$$\frac{dy}{dx}=\frac{dy/dt}{dx/dt}=2t.$$
At $t=1$, the slope is $2$.',
  recommendation_reasons = ARRAY['Checks slope computation from parametric/vector form.', 'Targets reciprocal and derivative slips.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Unit Test: Uses image (tangent shown) for parametric slope.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
    primary_skill_id = 'SK_PARAM_DYDX',
  supporting_skill_ids = ARRAY['SK_VECTOR_DERIV'],
  prompt_type = 'text_and_image',
  representation_type = 'symbolic',
  topic_id = 'BC_Motion',
  updated_at = NOW()
WHERE title = '9.0-UT-Q8';

-- Q9
UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Motion',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 105,
  skill_tags = ARRAY['SK_POLAR_DR', 'SK_TRIG_IDENTITIES'],
  error_tags = ARRAY['E_TRIG_FUNC_MIXUP', 'E_ALGEBRA'],
  prompt = 'For the polar curve $r=3\sin\theta$, what is $\dfrac{dr}{d\theta}$ at $\theta=\dfrac{\pi}{3}$?',
  latex = 'For the polar curve $$r=3\sin\theta,$$ what is $$\frac{dr}{d\theta}$$ at $\theta=\frac{\pi}{3}$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\dfrac{3}{2}$','explanation','Correct: $dr/d\theta=3\cos\theta$, and $\cos(\pi/3)=1/2$.'),
    jsonb_build_object('id','B','text','$\dfrac{3\sqrt{3}}{2}$','explanation','This mistakenly uses $\sin(\pi/3)$ instead of $\cos(\pi/3)$.'),
    jsonb_build_object('id','C','text','$-\dfrac{3}{2}$','explanation','Sign error: $\cos(\pi/3)$ is positive.'),
    jsonb_build_object('id','D','text','$\dfrac{1}{2}$','explanation','Drops the factor of 3.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Differentiate: $dr/d\theta=3\cos\theta$. Evaluate at $\theta=\pi/3$:
$$\frac{dr}{d\theta}=3\cos\left(\frac{\pi}{3}\right)=3\cdot\frac12=\frac32.$$',
  recommendation_reasons = ARRAY['Builds basic fluency with polar differentiation.', 'Targets wrong-trig-function and constant-factor mistakes.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 0.95,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Unit Test: Basic polar derivative.',
  weight_primary = 0.85,
  weight_supporting = 0.15,
    primary_skill_id = 'SK_POLAR_DR',
  supporting_skill_ids = ARRAY['SK_TRIG_IDENTITIES'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Motion',
  updated_at = NOW()
WHERE title = '9.0-UT-Q9';

-- Q10
UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Motion',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 5,
  target_time_seconds = 210,
  skill_tags = ARRAY['SK_POLAR_DYDX', 'SK_TRIG_IDENTITIES'],
  error_tags = ARRAY['E_MIX_R_AND_RPRIME', 'E_SIGN_ERROR'],
  prompt = 'For $r(\theta)=2\theta$, use the polar slope formula
$$\dfrac{dy}{dx}=\dfrac{r''''(\theta)\sin\theta+r(\theta)\cos\theta}{r''''(\theta)\cos\theta-r(\theta)\sin\theta}.$$
What is $\dfrac{dy}{dx}$ at $\theta=\dfrac{\pi}{2}$?',
  latex = 'For $r(\theta)=2\theta$, use the polar slope formula
$$\frac{dy}{dx}=\frac{r''''(\theta)\sin\theta+r(\theta)\cos\theta}{r''''(\theta)\cos\theta-r(\theta)\sin\theta}.$$
What is $\frac{dy}{dx}$ at $\theta=\frac{\pi}{2}$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$0$','explanation','This guesses a horizontal tangent without evaluating the formula.'),
    jsonb_build_object('id','B','text','$-\dfrac{2}{\pi}$','explanation','Correct: $r''''=2$, $r=\pi$. At $\theta=\pi/2$, numerator $=2\cdot1+\pi\cdot0=2$ and denominator $=2\cdot0-\pi\cdot1=-\pi$, so slope $=2/(-\pi)=-2/\pi$.'),
    jsonb_build_object('id','C','text','Undefined','explanation','Denominator is $-\pi\ne 0$, so the slope is defined.'),
    jsonb_build_object('id','D','text','$\dfrac{\pi}{2}$','explanation','This swaps numerator and denominator or confuses $r$ with $r''''.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Here $r(\theta)=2\theta$ so $r''''(\theta)=2$. At $\theta=\pi/2$, $r=\pi$, $\sin\theta=1$, $\cos\theta=0$. Substitute:
$$\frac{dy}{dx}=\frac{2\cdot1+\pi\cdot0}{2\cdot0-\pi\cdot1}=\frac{2}{-\pi}=-\frac{2}{\pi}.$$',
  recommendation_reasons = ARRAY['Forces correct use of the polar $dy/dx$ formula.', 'Targets the frequent confusion between $r$ and its derivative.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 5,
  mastery_weight = 1.20,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Unit Test: Polar slope evaluation at a special angle.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
    primary_skill_id = 'SK_POLAR_DYDX',
  supporting_skill_ids = ARRAY['SK_TRIG_IDENTITIES'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Motion',
  updated_at = NOW()
WHERE title = '9.0-UT-Q10';

-- Q11
UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Motion',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 180,
  skill_tags = ARRAY['SK_POLAR_AREA_SINGLE', 'SK_TRIG_IDENTITIES'],
  error_tags = ARRAY['E_POLAR_BOUNDS', 'E_OVERCOUNT_SYMMETRY'],
  prompt = 'Find the area enclosed by one loop of the polar curve $r=2\sin\theta$.',
  latex = 'Find the area enclosed by one loop of the polar curve $$r=2\sin\theta.$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\dfrac{\pi}{2}$','explanation','This loses a factor of 2 from $r^2$ or the $\dfrac12$ in the formula.'),
    jsonb_build_object('id','B','text','$2\pi$','explanation','This double-counts by integrating over $0$ to $2\pi$.'),
    jsonb_build_object('id','C','text','$4\pi$','explanation','This applies incorrect scaling and bounds.'),
    jsonb_build_object('id','D','text','$\pi$','explanation','Correct: one loop is traced for $0\le\theta\le\pi$, and $A=\dfrac12\int_0^\pi (2\sin\theta)^2\,d\theta=\pi$.')
  ),
  correct_option_id = 'D',
  tolerance = 0.0010,
  explanation = 'One loop occurs where $r\ge 0$, i.e. $0\le\theta\le\pi$. Area is
$$A=\frac12\int_0^\pi r^2\,d\theta=\frac12\int_0^\pi 4\sin^2\theta\,d\theta
=2\int_0^\pi \sin^2\theta\,d\theta=2\cdot\frac{\pi}{2}=\pi.$$',
  recommendation_reasons = ARRAY['Reinforces $A=\frac12\int r^2\,d\theta$ for polar regions.', 'Targets wrong bounds that double-count a loop.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.10,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Unit Test: Polar area for a single loop.',
  weight_primary = 0.85,
  weight_supporting = 0.15,
    primary_skill_id = 'SK_POLAR_AREA_SINGLE',
  supporting_skill_ids = ARRAY['SK_TRIG_IDENTITIES'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Motion',
  updated_at = NOW()
WHERE title = '9.0-UT-Q11';

-- Q12
UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Motion',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 180,
  skill_tags = ARRAY['SK_POLAR_AREA_SINGLE', 'SK_TRIG_IDENTITIES'],
  error_tags = ARRAY['E_POLAR_BOUNDS', 'E_ALGEBRA'],
  prompt = 'Refer to the polar graph (image) of $r=2+2\cos\theta$. What is the area enclosed by the curve?',
  latex = 'Refer to the polar graph (image) of $$r=2+2\cos\theta.$$ What is the area enclosed by the curve?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$4\pi$','explanation','Treats the curve as a circle of radius 2.'),
    jsonb_build_object('id','B','text','$8\pi$','explanation','Overcounts the area (often by doubling unnecessarily).'),
    jsonb_build_object('id','C','text','$2\pi$','explanation','Uses the wrong integrand (e.g., integrates $r$ instead of $r^2$).'),
    jsonb_build_object('id','D','text','$6\pi$','explanation','Correct: $A=\dfrac12\int_0^{2\pi}(2+2\cos\theta)^2\,d\theta=6\pi$.')
  ),
  correct_option_id = 'D',
  tolerance = 0.0010,
  explanation = 'Use
$$A=\frac12\int_0^{2\pi} r^2\,d\theta=\frac12\int_0^{2\pi}(2+2\cos\theta)^2\,d\theta.$$
Expand: $(2+2\cos\theta)^2=4(1+2\cos\theta+\cos^2\theta)$, so
$$A=2\int_0^{2\pi}(1+2\cos\theta+\cos^2\theta)\,d\theta.$$
Over $[0,2\pi]$, $\int_0^{2\pi}\cos\theta\,d\theta=0$ and $\int_0^{2\pi}\cos^2\theta\,d\theta=\pi$, hence
$$A=2(2\pi+0+\pi)=6\pi.$$',
  recommendation_reasons = ARRAY['Builds full-period polar area computation with trig integrals.', 'Targets the frequent mistake of using $\int r\,d\theta$ instead of $\frac12\int r^2\,d\theta$.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.10,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Unit Test: Uses image of the polar curve.',
  weight_primary = 0.75,
  weight_supporting = 0.25,
    primary_skill_id = 'SK_POLAR_AREA_SINGLE',
  supporting_skill_ids = ARRAY['SK_TRIG_IDENTITIES'],
  prompt_type = 'text_and_image',
  representation_type = 'symbolic',
  topic_id = 'BC_Motion',
  updated_at = NOW()
WHERE title = '9.0-UT-Q12';

-- Q13
UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Motion',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 195,
  skill_tags = ARRAY['SK_POLAR_AREA_BETWEEN', 'SK_INTERSECTIONS'],
  error_tags = ARRAY['E_POLAR_BOUNDS', 'E_SIGN_ERROR'],
  prompt = 'Find the area of the region inside $r=2\cos\theta$ and outside $r=\cos\theta$.',
  latex = 'Find the area of the region inside $$r=2\cos\theta$$ and outside $$r=\cos\theta.$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\dfrac{\pi}{4}$','explanation','This typically uses incorrect bounds or misses the $\dfrac12$ factor.'),
    jsonb_build_object('id','B','text','$\dfrac{\pi}{2}$','explanation','This overcounts; it does not match the setup $\frac12\int\big(r_{\text{outer}}^2-r_{\text{inner}}^2\big)\,d\theta$.'),
    jsonb_build_object('id','C','text','$\dfrac{3\pi}{4}$','explanation','Correct: $A=\dfrac12\int_{-\pi/2}^{\pi/2}\big((2\cos\theta)^2-(\cos\theta)^2\big)\,d\theta=\dfrac{3\pi}{4}$.'),
    jsonb_build_object('id','D','text','$\pi$','explanation','This double-counts the region.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'Where $\cos\theta\ge 0$ (i.e., $-\pi/2\le\theta\le\pi/2$), the outer curve is $r=2\cos\theta$ and the inner curve is $r=\cos\theta$. Area between curves:
$$A=\frac12\int_{-\pi/2}^{\pi/2}\left[(2\cos\theta)^2-(\cos\theta)^2\right]d\theta
=\frac12\int_{-\pi/2}^{\pi/2}3\cos^2\theta\,d\theta.$$
Since $\int_{-\pi/2}^{\pi/2}\cos^2\theta\,d\theta=\frac{\pi}{2}$,
$$A=\frac12\cdot 3\cdot\frac{\pi}{2}=\frac{3\pi}{4}.$$',
  recommendation_reasons = ARRAY['Reinforces “area between polar curves” structure.', 'Targets incorrect bounds and subtraction order.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.10,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Unit Test: Area between two related polar curves.',
  weight_primary = 0.85,
  weight_supporting = 0.15,
    primary_skill_id = 'SK_POLAR_AREA_BETWEEN',
  supporting_skill_ids = ARRAY['SK_INTERSECTIONS'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Motion',
  updated_at = NOW()
WHERE title = '9.0-UT-Q13';

-- Q14
UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Motion',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 150,
  skill_tags = ARRAY['SK_PARAM_D2YDX2', 'SK_PARAM_DYDX'],
  error_tags = ARRAY['E_MISS_DIVIDE_BY_DXDT', 'E_INVERT_DYDX_PARAM'],
  prompt = 'A curve is given by $x=t^2$ and $y=t^3$. What is $\dfrac{d^2y}{dx^2}$ when $t=2$?',
  latex = 'A curve is given by $$x=t^2,\quad y=t^3.$$ What is $$\frac{d^2y}{dx^2}$$ when $t=2$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\dfrac{3}{8}$','explanation','Correct: $dy/dx=\dfrac{3t^2}{2t}=\dfrac{3}{2}t$, then $\dfrac{d^2y}{dx^2}=\dfrac{d/dt(dy/dx)}{dx/dt}=\dfrac{(3/2)}{2t}=\dfrac{3}{4t}$, so at $t=2$ it is $\dfrac{3}{8}$.'),
    jsonb_build_object('id','B','text','$\dfrac{3}{4}$','explanation','Stops at $d/dt(dy/dx)=3/2$ and evaluates incorrectly.'),
    jsonb_build_object('id','C','text','$3$','explanation','Confuses $\dfrac{d^2y}{dx^2}$ with $\dfrac{d^2y}{dt^2}$.'),
    jsonb_build_object('id','D','text','$\dfrac{3}{16}$','explanation','Arithmetic slip in the final division by $2t$.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Compute
$$\frac{dy}{dx}=\frac{dy/dt}{dx/dt}=\frac{3t^2}{2t}=\frac{3}{2}t.$$
Then
$$\frac{d^2y}{dx^2}=\frac{\frac{d}{dt}(dy/dx)}{dx/dt}=\frac{3/2}{2t}=\frac{3}{4t}.$$
At $t=2$, $\dfrac{d^2y}{dx^2}=\dfrac{3}{8}$.',
  recommendation_reasons = ARRAY['Clean benchmark problem for parametric second derivatives.', 'Targets the missing “divide by $dx/dt$” error.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Unit Test: Parametric second derivative with power functions.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
    primary_skill_id = 'SK_PARAM_D2YDX2',
  supporting_skill_ids = ARRAY['SK_PARAM_DYDX'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Motion',
  updated_at = NOW()
WHERE title = '9.0-UT-Q14';

-- Q15
UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Motion',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 120,
  skill_tags = ARRAY['SK_VECTOR_INTEGRAL', 'SK_INITIAL_CONDITIONS'],
  error_tags = ARRAY['E_FORGET_IC', 'E_VECTOR_COMPONENT'],
  prompt = 'If $\vec r\,''(t)=\langle 4,\ 3t^2\rangle$ and $\vec r(1)=\langle 2,\ 5\rangle$, what is $\vec r(0)$?',
  latex = 'If $$\vec r\,''(t)=\langle 4,\ 3t^2\rangle$$ and $$\vec r(1)=\langle 2,\ 5\rangle,$$ what is $$\vec r(0)?$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\langle -2,\ 2\rangle$','explanation','This subtracts the $y$-displacement incorrectly.'),
    jsonb_build_object('id','B','text','$\langle -2,\ 4\rangle$','explanation','Correct: $\vec r(1)-\vec r(0)=\int_0^1\langle 4,3t^2\rangle dt=\langle 4,1\rangle$, so $\vec r(0)=\langle 2,5\rangle-\langle 4,1\rangle=\langle -2,4\rangle$.'),
    jsonb_build_object('id','C','text','$\langle 6,\ 6\rangle$','explanation','Adds the displacement instead of subtracting.'),
    jsonb_build_object('id','D','text','$\langle 2,\ 4\rangle$','explanation','Adjusts only the $y$-component and ignores the $x$-displacement.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Use displacement:
$$\vec r(1)-\vec r(0)=\int_0^1 \vec r\,''(t)\,dt=\int_0^1\langle 4,3t^2\rangle dt=\langle 4,t^3\rangle\big|_0^1=\langle 4,1\rangle.$$
Thus
$$\vec r(0)=\vec r(1)-\langle 4,1\rangle=\langle 2,5\rangle-\langle 4,1\rangle=\langle -2,4\rangle.$$',
  recommendation_reasons = ARRAY['Practices vector FTC with a known position at $t=1$.', 'Targets sign and component-omission mistakes.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Unit Test: Back-solving earlier position using an integral.',
  weight_primary = 0.75,
  weight_supporting = 0.25,
    primary_skill_id = 'SK_VECTOR_INTEGRAL',
  supporting_skill_ids = ARRAY['SK_INITIAL_CONDITIONS'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Motion',
  updated_at = NOW()
WHERE title = '9.0-UT-Q15';

-- Q16
UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Motion',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 5,
  target_time_seconds = 210,
  skill_tags = ARRAY['SK_POLAR_AREA_BETWEEN', 'SK_INTERSECTIONS'],
  error_tags = ARRAY['E_POLAR_BOUNDS', 'E_OVERCOUNT_SYMMETRY'],
  prompt = 'Refer to the figure (image). Let $C_1$ be $r=2\cos\theta$ and $C_2$ be $r=1$. What is the area of the region inside both curves?',
  latex = 'Refer to the figure (image). Let $$C_1: r=2\cos\theta$$ and $$C_2: r=1.$$ What is the area of the region inside both curves?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\dfrac{\pi}{2}$','explanation','This uses only the unit circle area without accounting for where $r=2\cos\theta$ is smaller.'),
    jsonb_build_object('id','B','text','$\dfrac{\pi}{3}+\dfrac{\sqrt{3}}{4}$','explanation','This misses a factor of 2 in the cosine-squared contribution.'),
    jsonb_build_object('id','C','text','$\dfrac{\pi}{3}+\dfrac{\sqrt{3}}{2}$','explanation','Correct: the curves intersect at $2\cos\theta=1\Rightarrow \theta=\pm\pi/3$. Overlap area is $\frac12\!\left(\int_{-\pi/3}^{\pi/3}1^2\,d\theta+2\int_{\pi/3}^{\pi/2}(2\cos\theta)^2\,d\theta\right)=\dfrac{\pi}{3}+\dfrac{\sqrt{3}}{2}$.'),
    jsonb_build_object('id','D','text','$\dfrac{2\pi}{3}$','explanation','This overcounts by treating the overlap as a fixed-radius sector.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'Intersect when $2\cos\theta=1$, so $\theta=\pm\pi/3$. Inside both curves means $0\le r\le \min(1,2\cos\theta)$ for $-\pi/2\le\theta\le\pi/2$.\nThus
$$A=\frac12\left(\int_{-\pi/3}^{\pi/3}1^2\,d\theta+2\int_{\pi/3}^{\pi/2}(2\cos\theta)^2\,d\theta\right)
=\frac{\pi}{3}+4\int_{\pi/3}^{\pi/2}\cos^2\theta\,d\theta.$$
Compute
$$\int_{\pi/3}^{\pi/2}\cos^2\theta\,d\theta=\left[\frac{\theta}{2}+\frac{\sin(2\theta)}{4}\right]_{\pi/3}^{\pi/2}=\frac{\pi}{12}+\frac{\sqrt3}{8}.$$
So
$$A=\frac{\pi}{3}+4\left(\frac{\pi}{12}+\frac{\sqrt3}{8}\right)=\frac{\pi}{3}+\frac{\sqrt3}{2}.$$',
  recommendation_reasons = ARRAY['Representative “overlap of two polar curves” setup requiring a piecewise minimum.', 'Targets incorrect bounds and symmetry overcounting.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 5,
  mastery_weight = 1.20,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Unit Test: Uses image to emphasize the overlap region.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
    primary_skill_id = 'SK_POLAR_AREA_BETWEEN',
  supporting_skill_ids = ARRAY['SK_INTERSECTIONS'],
  prompt_type = 'text_and_image',
  representation_type = 'symbolic',
  topic_id = 'BC_Motion',
  updated_at = NOW()
WHERE title = '9.0-UT-Q16';

-- Q17
UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Motion',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 120,
  skill_tags = ARRAY['SK_PARAM_DYDX', 'SK_TANGENT_CONDITIONS'],
  error_tags = ARRAY['E_ALGEBRA', 'E_INVERT_DYDX_PARAM'],
  prompt = 'The curve $x=t^2-4t$ and $y=t-1$ has a vertical tangent when $\dfrac{dx}{dt}=0$ and $\dfrac{dy}{dt}\ne 0$. For what value of $t$ does this occur?',
  latex = 'The curve $$x=t^2-4t,\quad y=t-1$$ has a vertical tangent when $$\frac{dx}{dt}=0$$ and $$\frac{dy}{dt}\ne 0.$$ For what value of $t$ does this occur?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$t=2$','explanation','Correct: $dx/dt=2t-4=0\Rightarrow t=2$, and $dy/dt=1\ne 0$.'),
    jsonb_build_object('id','B','text','$t=4$','explanation','Solves $2t-4=0$ incorrectly.'),
    jsonb_build_object('id','C','text','$t=0$','explanation','Confuses $x=0$ with $dx/dt=0$.'),
    jsonb_build_object('id','D','text','No such $t$','explanation','There is a solution because $dx/dt=0$ at $t=2$ and $dy/dt\ne 0$.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Compute $dx/dt=2t-4$. Setting $dx/dt=0$ gives $2t-4=0\Rightarrow t=2$. Since $dy/dt=1\ne 0$, the tangent is vertical at $t=2$.',
  recommendation_reasons = ARRAY['Reinforces the vertical tangent condition for parametric curves.', 'Targets the common confusion between $x=0$ and $dx/dt=0$.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Unit Test: Vertical tangent condition.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
    primary_skill_id = 'SK_PARAM_DYDX',
  supporting_skill_ids = ARRAY['SK_TANGENT_CONDITIONS'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Motion',
  updated_at = NOW()
WHERE title = '9.0-UT-Q17';

-- Q18
UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Motion',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 180,
  skill_tags = ARRAY['SK_VECTOR_DERIV', 'SK_TRIG_IDENTITIES'],
  error_tags = ARRAY['E_VECTOR_COMPONENT', 'E_ALGEBRA'],
  prompt = 'Let $\vec r(t)=\langle \cos t,\ \sin t\rangle$. What is the magnitude of acceleration $|\vec r\,''''(t)|$ for any $t$?',
  latex = 'Let $$\vec r(t)=\langle \cos t,\ \sin t\rangle.$$ What is the magnitude of acceleration $$|\vec r\,''''(t)|$$ for any $t$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$0$','explanation','Acceleration is not zero; the direction of velocity changes.'),
    jsonb_build_object('id','B','text','$1$','explanation','Correct: $\vec r\,''(t)=\langle -\sin t,\ \cos t\rangle$, $\vec r\,''''(t)=\langle -\cos t,\ -\sin t\rangle$, so magnitude is $\sqrt{\cos^2 t+\sin^2 t}=1$.'),
    jsonb_build_object('id','C','text','$\sqrt{2}$','explanation','Uses an incorrect magnitude computation.'),
    jsonb_build_object('id','D','text','$2$','explanation','Confuses this with speed or doubles incorrectly.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Differentiate twice:
$$\vec r\,''(t)=\langle -\sin t,\ \cos t\rangle,\quad \vec r\,''''(t)=\langle -\cos t,\ -\sin t\rangle.$$
Thus
$$|\vec r\,''''(t)|=\sqrt{(-\cos t)^2+(-\sin t)^2}=\sqrt{\cos^2 t+\sin^2 t}=1.$$',
  recommendation_reasons = ARRAY['Connects vector derivatives to uniform circular motion.', 'Reinforces magnitude via $\sin^2+\cos^2=1$.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.05,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Unit Test: Acceleration magnitude for unit-circle motion.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
    primary_skill_id = 'SK_VECTOR_DERIV',
  supporting_skill_ids = ARRAY['SK_TRIG_IDENTITIES'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Motion',
  updated_at = NOW()
WHERE title = '9.0-UT-Q18';

-- Q19
UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Motion',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 165,
  skill_tags = ARRAY['SK_POLAR_AREA_SINGLE', 'SK_OVERCOUNT_SYMMETRY'],
  error_tags = ARRAY['E_POLAR_BOUNDS', 'E_OVERCOUNT_SYMMETRY'],
  prompt = 'What is the area enclosed by one petal of the rose $r=2\cos(2\theta)$?',
  latex = 'What is the area enclosed by one petal of the rose $$r=2\cos(2\theta)?$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\pi$','explanation','This counts multiple petals or uses incorrect bounds.'),
    jsonb_build_object('id','B','text','$\dfrac{\pi}{2}$','explanation','This is off by a factor of 2 (often from bounds or the $\dfrac12$).'),
    jsonb_build_object('id','C','text','$\dfrac{\pi}{4}$','explanation','Correct: one petal is traced for $-\pi/4\le\theta\le\pi/4$, so $A=\dfrac12\int_{-\pi/4}^{\pi/4}(2\cos(2\theta))^2\,d\theta=\dfrac{\pi}{4}$.'),
    jsonb_build_object('id','D','text','$\dfrac{\pi}{8}$','explanation','This typically forgets an even-symmetry doubling step.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'One petal occurs where $r\ge 0$, i.e. $\cos(2\theta)\ge 0$, so $-\pi/4\le\theta\le\pi/4$.\nThen
$$A=\frac12\int_{-\pi/4}^{\pi/4}(2\cos(2\theta))^2\,d\theta
=2\int_{-\pi/4}^{\pi/4}\cos^2(2\theta)\,d\theta.$$
Using even symmetry and $\cos^2(2\theta)=\frac{1+\cos(4\theta)}{2}$ gives $A=\frac{\pi}{4}$.',
  recommendation_reasons = ARRAY['Classic BC rose-curve area question.', 'Targets wrong “one-petal interval” selection.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.10,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Unit Test: Polar area for a rose petal.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
    primary_skill_id = 'SK_POLAR_AREA_SINGLE',
  supporting_skill_ids = ARRAY['SK_OVERCOUNT_SYMMETRY'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Motion',
  updated_at = NOW()
WHERE title = '9.0-UT-Q19';

-- Q20
UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Motion',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 5,
  target_time_seconds = 210,
  skill_tags = ARRAY['SK_PARAM_ARC_LENGTH', 'SK_ALGEBRA_SIMPLIFY'],
  error_tags = ARRAY['E_ARC_LENGTH_FORMULA', 'E_DROP_SQRT'],
  prompt = 'Find the arc length of $x=t^2$ and $y=\dfrac{2}{3}t^3$ from $t=0$ to $t=1$.',
  latex = 'Find the arc length of $$x=t^2,\quad y=\frac{2}{3}t^3$$ from $t=0$ to $t=1$.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\dfrac{5}{3}$','explanation','This omits the square root in the speed or uses a linearized speed.'),
    jsonb_build_object('id','B','text','$\sqrt{5}$','explanation','This incorrectly treats speed as constant.'),
    jsonb_build_object('id','C','text','$\dfrac{2}{3}(2\sqrt{2}-1)$','explanation','Correct: $x''=2t$, $y''=2t^2$, so speed is $2t\sqrt{1+t^2}$, and a $u=1+t^2$ substitution gives $\dfrac{2}{3}(2\sqrt{2}-1)$.'),
    jsonb_build_object('id','D','text','$\dfrac{2}{3}(2\sqrt{2}+1)$','explanation','Sign error: the substitution produces $u^{3/2}$ evaluated as $2^{3/2}-1$, not $2^{3/2}+1$.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'Compute derivatives: $dx/dt=2t$ and $dy/dt=2t^2$. Then speed is
$$\sqrt{(2t)^2+(2t^2)^2}=\sqrt{4t^2+4t^4}=2t\sqrt{1+t^2}\quad(0\le t\le 1).$$
So
$$L=\int_0^1 2t\sqrt{1+t^2}\,dt.$$
Let $u=1+t^2$, $du=2t\,dt$:
$$L=\int_1^2 \sqrt{u}\,du=\left[\frac{2}{3}u^{3/2}\right]_1^2=\frac{2}{3}(2^{3/2}-1)=\frac{2}{3}(2\sqrt{2}-1).$$',
  recommendation_reasons = ARRAY['Arc length setup that rewards correct speed and a clean substitution.', 'Targets the frequent missing-square-root error.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 5,
  mastery_weight = 1.20,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Unit Test: Arc length requiring substitution.',
  weight_primary = 0.85,
  weight_supporting = 0.15,
    primary_skill_id = 'SK_PARAM_ARC_LENGTH',
  supporting_skill_ids = ARRAY['SK_ALGEBRA_SIMPLIFY'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Motion',
  updated_at = NOW()
WHERE title = '9.0-UT-Q20';

COMMIT;
