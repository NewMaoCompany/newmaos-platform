-- Unit 9.5 (Integrating Vector-Valued Functions) — Practice 1–5

BEGIN;

UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Motion',
  sub_topic_id = '9.5',
  section_id = '9.5',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 90,
  skill_tags = ARRAY['SK_VV_INT_COMPONENTWISE','SK_DEF_INT_VECTOR_DISPLACEMENT'],
  error_tags = ARRAY['ERR_INTEGRATE_COMPONENTS_MISMATCH','ERR_SIGN_DEF_INT'],
  prompt = 'Let $\vec r\,''(t)=\langle 3t^2-4,\; 2\sin t\rangle$ for $0\le t\le 2$. Compute $\int_{0}^{2}\vec r\,''(t)\,dt$.',
  latex = 'Let $\vec r\,''(t)=\langle 3t^2-4,\; 2\sin t\rangle$ for $0\le t\le 2$. Compute $\int_{0}^{2}\vec r\,''(t)\,dt$.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\langle 0,\;2\sin 2\rangle$','explanation','The second component is not integrated; $\int_0^2 2\sin t\,dt$ is not $2\sin 2$.'),
    jsonb_build_object('id','B','text','$\langle 0,\;2-2\cos 2\rangle$','explanation','Correct: $\int_0^2(3t^2-4)dt=[t^3-4t]_0^2=0$ and $\int_0^2 2\sin t\,dt=[-2\cos t]_0^2=2-2\cos 2$.'),
    jsonb_build_object('id','C','text','$\langle 8,\;2-2\cos 2\rangle$','explanation','This drops the $-4t$ term in the first component: $[t^3-4t]_0^2\ne 8$.'),
    jsonb_build_object('id','D','text','$\langle 0,\;-2+2\cos 2\rangle$','explanation','This reverses the sign when evaluating $[-2\cos t]_0^2$.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Integrate componentwise:
$$\int_0^2\langle 3t^2-4,\;2\sin t\rangle dt
=\left\langle [t^3-4t]_0^2,\;[-2\cos t]_0^2\right\rangle
=\langle 0,\;2-2\cos 2\rangle.$$',
  recommendation_reasons = ARRAY['Reinforces componentwise integration for vector-valued functions.','Targets sign and bounds errors in definite integrals.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 0.90,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: componentwise definite integration and careful evaluation at bounds.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
    primary_skill_id = 'SK_VV_INT_COMPONENTWISE',
  supporting_skill_ids = ARRAY['SK_DEF_INT_VECTOR_DISPLACEMENT'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Motion',
  updated_at = NOW()
WHERE title = '9.5-P1';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Motion',
  sub_topic_id = '9.5',
  section_id = '9.5',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 120,
  skill_tags = ARRAY['SK_VV_POSITION_FROM_VELOCITY','SK_INITIAL_CONDITION_VECTOR'],
  error_tags = ARRAY['ERR_FORGET_CONSTANT_VECTOR','ERR_INITIAL_CONDITION_MISAPPLIED'],
  prompt = 'A particle has velocity $\vec v(t)=\langle 2t-1,\;t^2\rangle$ for $t\ge 0$. If $\vec r(0)=\langle 3,-2\rangle$, what is $\vec r(t)$?',
  latex = 'A particle has velocity $\vec v(t)=\langle 2t-1,\;t^2\rangle$ for $t\ge 0$. If $\vec r(0)=\langle 3,-2\rangle$, what is $\vec r(t)$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\langle t^2-t+3,\;\tfrac13 t^3-2\rangle$','explanation','Correct: integrate and apply $\vec r(0)=\langle 3,-2\rangle$ componentwise.'),
    jsonb_build_object('id','B','text','$\langle t^2-t,\;\tfrac13 t^3\rangle$','explanation','This omits the constant vector needed to satisfy $\vec r(0)$.'),
    jsonb_build_object('id','C','text','$\langle t^2+t+3,\;\tfrac13 t^3-2\rangle$','explanation','Sign error: $\int(2t-1)dt=t^2-t+C$, not $t^2+t+C$.'),
    jsonb_build_object('id','D','text','$\langle 2t-1+3,\;t^2-2\rangle$','explanation','This treats velocity components as position components; you must integrate.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Integrate componentwise:
$$\vec r(t)=\left\langle \int(2t-1)dt,\;\int t^2dt\right\rangle
=\langle t^2-t+C_1,\;\tfrac13 t^3+C_2\rangle.$$
Use $\vec r(0)=\langle 3,-2\rangle$ to get $C_1=3$ and $C_2=-2$.',
  recommendation_reasons = ARRAY['Connects velocity to position via vector antiderivatives.','Emphasizes applying initial conditions componentwise.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: integrate velocity and use vector initial condition.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
    primary_skill_id = 'SK_VV_POSITION_FROM_VELOCITY',
  supporting_skill_ids = ARRAY['SK_INITIAL_CONDITION_VECTOR'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Motion',
  updated_at = NOW()
WHERE title = '9.5-P2';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Motion',
  sub_topic_id = '9.5',
  section_id = '9.5',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 90,
  skill_tags = ARRAY['SK_DEF_INT_VECTOR_DISPLACEMENT','SK_DISPLACEMENT_VS_DISTANCE'],
  error_tags = ARRAY['ERR_MIX_DISPLACEMENT_DISTANCE','ERR_VECTOR_MAGNITUDE_TOO_EARLY'],
  prompt = 'A particle''s velocity is $\vec v(t)=\langle 4,\;-3\rangle$ for $0\le t\le 5$. What is the displacement vector on $[0,5]$?',
  latex = 'A particle''s velocity is $\vec v(t)=\langle 4,\;-3\rangle$ for $0\le t\le 5$. What is the displacement vector on $[0,5]$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\langle 4,\;-3\rangle$','explanation','This is velocity, not displacement. Displacement requires integrating over time.'),
    jsonb_build_object('id','B','text','$25$','explanation','This is distance: speed is $5$, so $5\cdot 5=25$, but the question asks for the displacement vector.'),
    jsonb_build_object('id','C','text','$\langle 5,\;5\rangle$','explanation','This confuses the time interval length with vector components.'),
    jsonb_build_object('id','D','text','$\langle 20,\;-15\rangle$','explanation','Correct: $\int_0^5\langle 4,-3\rangle dt=\langle 20,-15\rangle$.')
  ),
  correct_option_id = 'D',
  tolerance = 0.0010,
  explanation = 'Displacement is the integral of velocity:
$$\int_0^5\langle 4,-3\rangle dt=\langle 4t,-3t\rangle\Big|_0^5=\langle 20,-15\rangle.$$',
  recommendation_reasons = ARRAY['Clarifies displacement as a vector-valued definite integral.','Separates displacement from distance traveled.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 0.80,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: displacement vector vs distance (magnitude).',
  weight_primary = 0.70,
  weight_supporting = 0.30,
    primary_skill_id = 'SK_DEF_INT_VECTOR_DISPLACEMENT',
  supporting_skill_ids = ARRAY['SK_DISPLACEMENT_VS_DISTANCE'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Motion',
  updated_at = NOW()
WHERE title = '9.5-P3';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Motion',
  sub_topic_id = '9.5',
  section_id = '9.5',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 150,
  skill_tags = ARRAY['SK_VV_AVERAGE_VALUE','SK_VV_INT_COMPONENTWISE'],
  error_tags = ARRAY['ERR_AVG_VALUE_SCALAR_NOT_VECTOR','ERR_FORGET_DIVIDE_BY_INTERVAL'],
  prompt = 'Let $\vec r(t)=\langle t^2,\;e^t\rangle$ on $[0,1]$. What is the average value vector of $\vec r(t)$ on this interval?',
  latex = 'Let $\vec r(t)=\langle t^2,\;e^t\rangle$ on $[0,1]$. What is the average value vector of $\vec r(t)$ on this interval?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\langle 1,\;e\rangle$','explanation','This uses endpoint values rather than the integral average.'),
    jsonb_build_object('id','B','text','$\langle \tfrac12,\;\tfrac{e}{2}\rangle$','explanation','This averages endpoints componentwise, not the average value via integral.'),
    jsonb_build_object('id','C','text','$\langle \tfrac13,\;e-1\rangle$','explanation','Correct: $\vec r_{avg}=\frac{1}{1-0}\int_0^1\langle t^2,e^t\rangle dt=\langle \tfrac13,\;e-1\rangle$.'),
    jsonb_build_object('id','D','text','$(e-1)+\tfrac13$','explanation','This incorrectly collapses a vector average into a scalar.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'Average value is
$$\vec r_{avg}=\frac{1}{1-0}\int_0^1\langle t^2,e^t\rangle dt
=\left\langle \int_0^1 t^2dt,\;\int_0^1 e^t dt\right\rangle
=\langle \tfrac13,\;e-1\rangle.$$',
  recommendation_reasons = ARRAY['Tests the definition of average value for vector-valued functions.','Targets scalar-vs-vector confusion.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.10,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: average value remains vector-valued; compute via componentwise integral.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
    primary_skill_id = 'SK_VV_AVERAGE_VALUE',
  supporting_skill_ids = ARRAY['SK_VV_INT_COMPONENTWISE'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Motion',
  updated_at = NOW()
WHERE title = '9.5-P4';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Motion',
  sub_topic_id = '9.5',
  section_id = '9.5',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 5,
  target_time_seconds = 180,
  skill_tags = ARRAY['SK_VV_INT_COMPONENTWISE','SK_VECTOR_SCALAR_MULTIPLICATION'],
  error_tags = ARRAY['ERR_DISTRIBUTE_VECTOR_INCORRECTLY','ERR_INTEGRATE_COMPONENTS_MISMATCH'],
  prompt = 'Evaluate $\int_0^{\pi}\big(\langle 1,2\rangle\cos t+\langle 3,-1\rangle\sin t\big)\,dt$.',
  latex = 'Evaluate $\int_0^{\pi}\big(\langle 1,2\rangle\cos t+\langle 3,-1\rangle\sin t\big)\,dt$.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\langle 0,0\rangle$','explanation','The sine term contributes because $\int_0^{\pi}\sin t\,dt\ne 0$.'),
    jsonb_build_object('id','B','text','$\langle 6,\;2\rangle$','explanation','Sign error: the second component should be negative because it includes $-1\cdot\int_0^{\pi}\sin t\,dt$.'),
    jsonb_build_object('id','C','text','$\langle 6,\;-2\rangle$','explanation','Correct: $\int_0^{\pi}\cos t\,dt=0$ and $\int_0^{\pi}\sin t\,dt=2$, so the result is $2\langle 3,-1\rangle=\langle 6,-2\rangle$.'),
    jsonb_build_object('id','D','text','$\langle 4,\;1\rangle$','explanation','This incorrectly integrates the trig functions or adds the constant vectors without integrating.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'Use linearity:
$$\int_0^{\pi}\big(\langle 1,2\rangle\cos t+\langle 3,-1\rangle\sin t\big)dt
=\langle 1,2\rangle\int_0^{\pi}\cos t\,dt+\langle 3,-1\rangle\int_0^{\pi}\sin t\,dt.$$
Since $\int_0^{\pi}\cos t\,dt=0$ and $\int_0^{\pi}\sin t\,dt=2$, the integral equals $2\langle 3,-1\rangle=\langle 6,-2\rangle$.',
  recommendation_reasons = ARRAY['Uses linearity with constant vectors and scalar trig integrals.','Targets distributing scalars across vectors correctly.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 5,
  mastery_weight = 1.20,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: linearity of vector integrals; keep track of signs in components.',
  weight_primary = 0.60,
  weight_supporting = 0.40,
    primary_skill_id = 'SK_VV_INT_COMPONENTWISE',
  supporting_skill_ids = ARRAY['SK_VECTOR_SCALAR_MULTIPLICATION'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Motion',
  updated_at = NOW()
WHERE title = '9.5-P5';



-- Unit 9.6 (Solving Motion Problems Using Parametric and Vector-Valued Functions) — Practice 1–5

UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Motion',
  sub_topic_id = '9.6',
  section_id = '9.6',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 90,
  skill_tags = ARRAY['SK_VELOCITY_VECTOR_FROM_POSITION','SK_SPEED_MAGNITUDE'],
  error_tags = ARRAY['ERR_CONFUSE_VELOCITY_SPEED','ERR_DERIVATIVE_COMPONENTWISE_ERROR'],
  prompt = 'A particle''s position is $\vec r(t)=\langle t^2-2t,\;3\cos t\rangle$. What is its speed at time $t$?',
  latex = 'A particle''s position is $\vec r(t)=\langle t^2-2t,\;3\cos t\rangle$. What is its speed at time $t$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\sqrt{(2t-2)^2+(3\sin t)^2}$','explanation','Correct: $\vec v(t)=\langle 2t-2,-3\sin t\rangle$ and speed is $\|\vec v(t)\|=\sqrt{(2t-2)^2+(-3\sin t)^2}$.'),
    jsonb_build_object('id','B','text','$\langle 2t-2,\;-3\sin t\rangle$','explanation','This is the velocity vector, not speed.'),
    jsonb_build_object('id','C','text','$\sqrt{(2t-2)^2+(3\cos t)^2}$','explanation','This incorrectly uses the position $y(t)=3\cos t$ instead of $y''(t)=-3\sin t$.'),
    jsonb_build_object('id','D','text','$\sqrt{(t^2-2t)^2+(3\cos t)^2}$','explanation','This is the magnitude of position, not the magnitude of velocity.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Differentiate to get velocity:
$$\vec v(t)=\vec r\,''(t)=\langle 2t-2,\;-3\sin t\rangle.$$
Speed is magnitude:
$$\|\vec v(t)\|=\sqrt{(2t-2)^2+(3\sin t)^2}.$$',
  recommendation_reasons = ARRAY['Separates velocity (vector) from speed (magnitude).','Builds fluency with componentwise differentiation in motion contexts.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 0.90,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: speed is the magnitude of velocity, not the position magnitude.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
    primary_skill_id = 'SK_VELOCITY_VECTOR_FROM_POSITION',
  supporting_skill_ids = ARRAY['SK_SPEED_MAGNITUDE'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Motion',
  updated_at = NOW()
WHERE title = '9.6-P1';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Motion',
  sub_topic_id = '9.6',
  section_id = '9.6',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 120,
  skill_tags = ARRAY['SK_PARTICLE_STOPS_SOLVE_VELOCITY_ZERO','SK_ACCELERATION_VECTOR'],
  error_tags = ARRAY['ERR_SET_SPEED_ZERO_INSTEAD_OF_VELOCITY','ERR_SOLVE_COMPONENTWISE_INCONSISTENT'],
  prompt = 'A particle has velocity $\vec v(t)=\langle t-3,\;6-2t\rangle$. At what time $t$ does the particle come to rest?',
  latex = 'A particle has velocity $\vec v(t)=\langle t-3,\;6-2t\rangle$. At what time $t$ does the particle come to rest?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$t=2$','explanation','At $t=2$, the second component is $6-4=2\ne 0$, so the particle is not at rest.'),
    jsonb_build_object('id','B','text','$t=0$','explanation','At $t=0$, $\vec v(0)=\langle -3,6\rangle\ne \langle 0,0\rangle$.'),
    jsonb_build_object('id','C','text','The particle never comes to rest.','explanation','Incorrect: there is a time when both components are zero.'),
    jsonb_build_object('id','D','text','$t=3$','explanation','Correct: $t-3=0$ and $6-2t=0$ both give $t=3$.')
  ),
  correct_option_id = 'D',
  tolerance = 0.0010,
  explanation = 'The particle is at rest when $\vec v(t)=\langle 0,0\rangle$. Solve
$$t-3=0\quad\text{and}\quad 6-2t=0,$$
which both yield $t=3$.',
  recommendation_reasons = ARRAY['Reinforces that coming to rest requires the entire velocity vector to be zero.','Targets solving both component equations consistently.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: rest condition is simultaneous zero of both velocity components.',
  weight_primary = 0.60,
  weight_supporting = 0.40,
    primary_skill_id = 'SK_PARTICLE_STOPS_SOLVE_VELOCITY_ZERO',
  supporting_skill_ids = ARRAY['SK_ACCELERATION_VECTOR'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Motion',
  updated_at = NOW()
WHERE title = '9.6-P2';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Motion',
  sub_topic_id = '9.6',
  section_id = '9.6',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 150,
  skill_tags = ARRAY['SK_DISPLACEMENT_VS_DISTANCE','SK_SPEED_MAGNITUDE'],
  error_tags = ARRAY['ERR_MIX_DISPLACEMENT_DISTANCE','ERR_FORGET_ABSOLUTE_VALUE_DISTANCE_1D'],
  prompt = 'A particle moves on a line with velocity $v(t)=t-2$ for $0\le t\le 5$. What is the total distance traveled?',
  latex = 'A particle moves on a line with velocity $v(t)=t-2$ for $0\le t\le 5$. What is the total distance traveled?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\tfrac{5}{2}$','explanation','This is the displacement $\int_0^5 (t-2)dt$, not total distance; it ignores the sign change at $t=2$.'),
    jsonb_build_object('id','B','text','$\tfrac{13}{2}$','explanation','Correct: distance is $\int_0^5|t-2|dt=\int_0^2(2-t)dt+\int_2^5(t-2)dt=2+\tfrac{9}{2}=\tfrac{13}{2}$.'),
    jsonb_build_object('id','C','text','$\tfrac{9}{2}$','explanation','This is only the distance from $t=2$ to $t=5$ and omits the distance from $0$ to $2$.'),
    jsonb_build_object('id','D','text','$9$','explanation','This typically comes from an arithmetic mistake after splitting at $t=2$.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Total distance is
$$\int_0^5|t-2|dt=\int_0^2(2-t)dt+\int_2^5(t-2)dt
=\left[2t-\tfrac12 t^2\right]_0^2+\left[\tfrac12 t^2-2t\right]_2^5
=2+\tfrac{9}{2}=\tfrac{13}{2}.$$',
  recommendation_reasons = ARRAY['Targets the key idea: distance uses absolute value of velocity in 1D.','Builds skill splitting integrals at sign changes.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.10,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: distance traveled = integral of |v(t)|; split at sign change.',
  weight_primary = 0.60,
  weight_supporting = 0.40,
    primary_skill_id = 'SK_DISPLACEMENT_VS_DISTANCE',
  supporting_skill_ids = ARRAY['SK_SPEED_MAGNITUDE'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Motion',
  updated_at = NOW()
WHERE title = '9.6-P3';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Motion',
  sub_topic_id = '9.6',
  section_id = '9.6',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 120,
  skill_tags = ARRAY['SK_ACCELERATION_VECTOR','SK_DERIVATIVE_COMPONENTWISE'],
  error_tags = ARRAY['ERR_DERIVATIVE_COMPONENTWISE_ERROR','ERR_CONFUSE_ACCELERATION_WITH_VELOCITY'],
  prompt = 'A particle has position $\vec r(t)=\langle \sin t,\;\cos t\rangle$. Which of the following is the acceleration vector $\vec a(t)$?',
  latex = 'A particle has position $\vec r(t)=\langle \sin t,\;\cos t\rangle$. Which of the following is the acceleration vector $\vec a(t)$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\langle \cos t,\;-\sin t\rangle$','explanation','This is velocity $\vec v(t)=\vec r\,''(t)$, not acceleration.'),
    jsonb_build_object('id','B','text','$\langle -\sin t,\;-\cos t\rangle$','explanation','Correct: $\vec v(t)=\langle \cos t,-\sin t\rangle$ and $\vec a(t)=\langle -\sin t,-\cos t\rangle$.'),
    jsonb_build_object('id','C','text','$\langle -\cos t,\;\sin t\rangle$','explanation','This is $-\vec v(t)$, not $\vec a(t)$.'),
    jsonb_build_object('id','D','text','$\langle \sin t,\;\cos t\rangle$','explanation','This is the position vector, not acceleration.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Differentiate twice:
$$\vec v(t)=\vec r\,''(t)=\langle \cos t,\;-\sin t\rangle,\qquad
\vec a(t)=\vec v\,''(t)=\langle -\sin t,\;-\cos t\rangle.$$',
  recommendation_reasons = ARRAY['Reinforces position → velocity → acceleration.','Targets common confusion between r(t), v(t), and a(t).'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: acceleration is the second derivative of position.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
    primary_skill_id = 'SK_ACCELERATION_VECTOR',
  supporting_skill_ids = ARRAY['SK_DERIVATIVE_COMPONENTWISE'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Motion',
  updated_at = NOW()
WHERE title = '9.6-P4';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Motion',
  sub_topic_id = '9.6',
  section_id = '9.6',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 5,
  target_time_seconds = 180,
  skill_tags = ARRAY['SK_VV_POSITION_FROM_VELOCITY','SK_DEF_INT_VECTOR_DISPLACEMENT','SK_INITIAL_CONDITION_VECTOR'],
  error_tags = ARRAY['ERR_INITIAL_CONDITION_MISAPPLIED','ERR_FORGET_CONSTANT_VECTOR','ERR_SIGN_DEF_INT'],
  prompt = 'A particle has velocity $\vec v(t)=\langle t,\;1-t\rangle$ for $0\le t\le 2$ and position $\vec r(0)=\langle -1,4\rangle$. What is $\vec r(2)$?',
  latex = 'A particle has velocity $\vec v(t)=\langle t,\;1-t\rangle$ for $0\le t\le 2$ and position $\vec r(0)=\langle -1,4\rangle$. What is $\vec r(2)$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\langle 1,\;2\rangle$','explanation','This incorrectly changes the second component; the net $y$-displacement is 0.'),
    jsonb_build_object('id','B','text','$\langle -1,\;4\rangle$','explanation','This ignores displacement from integrating velocity.'),
    jsonb_build_object('id','C','text','$\langle 3,\;4\rangle$','explanation','This doubles the $x$-displacement: $\int_0^2 t\,dt=2$, not 4.'),
    jsonb_build_object('id','D','text','$\langle 1,\;4\rangle$','explanation','Correct: displacement is $\int_0^2\langle t,1-t\rangle dt=\langle 2,0\rangle$, so add to $\langle -1,4\rangle$ to get $\langle 1,4\rangle$.')
  ),
  correct_option_id = 'D',
  tolerance = 0.0010,
  explanation = 'Compute displacement:
$$\int_0^2\langle t,1-t\rangle dt=\left\langle \tfrac12 t^2,\;t-\tfrac12 t^2\right\rangle_0^2=\langle 2,0\rangle.$$
Then
$$\vec r(2)=\vec r(0)+\text{displacement}=\langle -1,4\rangle+\langle 2,0\rangle=\langle 1,4\rangle.$$',
  recommendation_reasons = ARRAY['Combines definite vector integral with initial position.','Targets initial-condition and sign errors in motion problems.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 5,
  mastery_weight = 1.20,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: final position = initial position + displacement (vector integral).',
  weight_primary = 0.50,
  weight_supporting = 0.50,
    primary_skill_id = 'SK_VV_POSITION_FROM_VELOCITY',
  supporting_skill_ids = ARRAY['SK_DEF_INT_VECTOR_DISPLACEMENT','SK_INITIAL_CONDITION_VECTOR'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Motion',
  updated_at = NOW()
WHERE title = '9.6-P5';

COMMIT;
