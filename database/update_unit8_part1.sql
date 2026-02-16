-- Unit 8.1 (Finding the Average Value of a Function on an Interval) — Practice 1–5

BEGIN;

UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_AppIntegration',
  sub_topic_id = '8.1',
  section_id = '8.1',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 90,
  skill_tags = ARRAY['SK_AVG_VALUE_FORMULA','SK_DEFINITE_INTEGRAL_EVAL'],
  error_tags = ARRAY['E_AVG_VALUE_FORGET_DIVIDE','E_AVG_RATE_VS_AVG_VALUE'],
  prompt = 'Let $f(x)=3x^2-6x+1$. What is the average value of $f$ on $[0,2]$?',
  latex = 'Let $f(x)=3x^2-6x+1$. What is the average value of $f$ on $[0,2]$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$-1$','explanation','This is $f(1)$ (a point value), not the average value over an interval.'),
    jsonb_build_object('id','B','text','$1$','explanation','Correct. $f_{\mathrm{avg}}=\dfrac{1}{2-0}\int_0^2(3x^2-6x+1)\,dx=\dfrac{1}{2}[x^3-3x^2+x]_0^2=\dfrac{1}{2}(8-12+2)=1$.'),
    jsonb_build_object('id','C','text','$2$','explanation','This is $\int_0^2 f(x)\,dx$, forgetting to divide by $(2-0)$.'),
    jsonb_build_object('id','D','text','$4$','explanation','This comes from an antiderivative/evaluation error or dividing by the wrong number.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Average value on $[a,b]$ is
$$f_{\mathrm{avg}}=\frac{1}{b-a}\int_a^b f(x)\,dx.$$
Here,
$$f_{\mathrm{avg}}=\frac{1}{2}\int_0^2(3x^2-6x+1)\,dx=\frac{1}{2}[x^3-3x^2+x]_0^2=1.$$',
  recommendation_reasons = ARRAY['Reinforces the average value formula and the required division by $b-a$.','Targets the common confusion between average value and average rate of change.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: compute average value via $\frac{1}{b-a}\int_a^b f(x)\,dx$.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
    primary_skill_id = 'SK_AVG_VALUE_FORMULA',
  supporting_skill_ids = ARRAY['SK_DEFINITE_INTEGRAL_EVAL'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_AppIntegration',
  updated_at = NOW()
WHERE title = '8.1-P1';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_AppIntegration',
  sub_topic_id = '8.1',
  section_id = '8.1',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 105,
  skill_tags = ARRAY['SK_AVG_VALUE_FORMULA','SK_INTERPRET_GRAPH'],
  error_tags = ARRAY['E_AVG_VALUE_FORGET_DIVIDE','E_AVG_RATE_VS_AVG_VALUE'],
  prompt = 'The graph of $f$ on $[0,4]$ is shown in the figure labeled 8.1-P2. Which expression equals the average value of $f$ on $[0,4]$?',
  latex = 'The graph of $f$ on $[0,4]$ is shown in the figure labeled 8.1-P2. Which expression equals the average value of $f$ on $[0,4]$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\displaystyle \int_0^4 f(x)\,dx$','explanation','This is the net signed area, not the average value; it is missing division by $4$.'),
    jsonb_build_object('id','B','text','$\displaystyle \frac{1}{4}\int_0^4 f(x)\,dx$','explanation','Correct. Average value on $[0,4]$ is $\frac{1}{4-0}\int_0^4 f(x)\,dx$.'),
    jsonb_build_object('id','C','text','$\displaystyle \frac{1}{f(4)-f(0)}\int_0^4 f(x)\,dx$','explanation','This divides by a change in $y$-values, which is not part of the average value formula.'),
    jsonb_build_object('id','D','text','$\displaystyle \frac{f(4)-f(0)}{4}$','explanation','This is not the average value formula; it resembles a scaled secant slope idea.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'For any function (graph or formula), the average value on $[a,b]$ is
$$f_{\mathrm{avg}}=\frac{1}{b-a}\int_a^b f(x)\,dx.$$
With $a=0$ and $b=4$, this is $\frac{1}{4}\int_0^4 f(x)\,dx$.',
  recommendation_reasons = ARRAY['Checks recognition of the average value formula in a graphical context.','Targets the high-frequency mistake of choosing $\int_a^b f(x)\,dx$ without dividing by $b-a$.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 1,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: identify the correct expression for average value from a graph context.',
  weight_primary = 0.60,
  weight_supporting = 0.40,
    primary_skill_id = 'SK_AVG_VALUE_FORMULA',
  supporting_skill_ids = ARRAY['SK_INTERPRET_GRAPH'],
  prompt_type = 'text_and_image',
  representation_type = 'symbolic',
  topic_id = 'Both_AppIntegration',
  updated_at = NOW()
WHERE title = '8.1-P2';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_AppIntegration',
  sub_topic_id = '8.1',
  section_id = '8.1',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 140,
  skill_tags = ARRAY['SK_AVG_VALUE_FORMULA','SK_DEFINITE_INTEGRAL_EVAL'],
  error_tags = ARRAY['E_AVG_VALUE_FORGET_DIVIDE','E_SIGN_ERROR_LIMITS'],
  prompt = 'A function $f$ satisfies $\int_1^5 f(x)\,dx=12$ and $\int_5^9 f(x)\,dx=-4$. What is the average value of $f$ on $[1,9]$?',
  latex = 'A function $f$ satisfies $\int_1^5 f(x)\,dx=12$ and $\int_5^9 f(x)\,dx=-4$. What is the average value of $f$ on $[1,9]$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$1$','explanation','Correct. $\int_1^9 f(x)\,dx=12+(-4)=8$, so $f_{\mathrm{avg}}=\dfrac{1}{9-1}\cdot 8=1$.'),
    jsonb_build_object('id','B','text','$2$','explanation','This can come from dividing by the wrong interval length (such as $4$).'),
    jsonb_build_object('id','C','text','$8$','explanation','This is the net integral $\int_1^9 f(x)\,dx$, forgetting to divide by $8$.'),
    jsonb_build_object('id','D','text','$\frac{1}{2}$','explanation','This can come from averaging the two given integrals directly instead of combining and dividing by total length.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Combine adjacent integrals:
$$\int_1^9 f(x)\,dx=\int_1^5 f(x)\,dx+\int_5^9 f(x)\,dx=12-4=8.$$
Average value on $[1,9]$ is
$$f_{\mathrm{avg}}=\frac{1}{9-1}\int_1^9 f(x)\,dx=\frac{1}{8}\cdot 8=1.$$',
  recommendation_reasons = ARRAY['Builds fluency combining definite integrals across intervals.','Emphasizes that average value uses the net (signed) integral over the full interval.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: add integrals on subintervals, then divide by total length.',
  weight_primary = 0.60,
  weight_supporting = 0.40,
    primary_skill_id = 'SK_AVG_VALUE_FORMULA',
  supporting_skill_ids = ARRAY['SK_DEFINITE_INTEGRAL_EVAL'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_AppIntegration',
  updated_at = NOW()
WHERE title = '8.1-P3';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_AppIntegration',
  sub_topic_id = '8.1',
  section_id = '8.1',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 110,
  skill_tags = ARRAY['SK_AVG_VALUE_FORMULA','SK_AVERAGE_RATE_CHANGE'],
  error_tags = ARRAY['E_AVG_RATE_VS_AVG_VALUE','E_AVG_VALUE_FORGET_DIVIDE'],
  prompt = 'For $f(x)=e^x$ on $[0,\ln 4]$, which quantity equals the average value of $f$ on the interval?',
  latex = 'For $f(x)=e^x$ on $[0,\ln 4]$, which quantity equals the average value of $f$ on the interval?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\displaystyle \frac{e^{\ln 4}-e^0}{\ln 4}$','explanation','This is the average rate of change (secant slope), not the average value.'),
    jsonb_build_object('id','B','text','$\displaystyle \int_0^{\ln 4} e^x\,dx$','explanation','This is the net accumulation, not the average value; it misses dividing by $\ln 4$.'),
    jsonb_build_object('id','C','text','$\displaystyle \frac{1}{\ln 4}\int_0^{\ln 4} e^x\,dx$','explanation','Correct. Average value is $\frac{1}{b-a}\int_a^b f(x)\,dx$ with $b-a=\ln 4$.'),
    jsonb_build_object('id','D','text','$\displaystyle \frac{1}{4}\int_0^{\ln 4} e^x\,dx$','explanation','This divides by $4$, which is not the interval length in $x$.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'Average value depends on the interval length in $x$:
$$f_{\mathrm{avg}}=\frac{1}{\ln 4-0}\int_0^{\ln 4} e^x\,dx=\frac{1}{\ln 4}\int_0^{\ln 4} e^x\,dx.$$',
  recommendation_reasons = ARRAY['Directly contrasts average value with average rate of change.','Targets the common error of dividing by the wrong quantity.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 1,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: choose the correct expression form; do not use secant slope.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
    primary_skill_id = 'SK_AVG_VALUE_FORMULA',
  supporting_skill_ids = ARRAY['SK_AVERAGE_RATE_CHANGE'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_AppIntegration',
  updated_at = NOW()
WHERE title = '8.1-P4';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_AppIntegration',
  sub_topic_id = '8.1',
  section_id = '8.1',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 5,
  target_time_seconds = 170,
  skill_tags = ARRAY['SK_AVG_VALUE_FORMULA','SK_DEFINITE_INTEGRAL_EVAL'],
  error_tags = ARRAY['E_AVG_VALUE_FORGET_DIVIDE','E_ALGEBRA_SOLVE_ERROR'],
  prompt = 'Find the value of $k$ such that the average value of $f(x)=kx+2$ on $[0,6]$ equals $8$.',
  latex = 'Find the value of $k$ such that the average value of $f(x)=kx+2$ on $[0,6]$ equals $8$.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$1$','explanation','This would give $f_{\mathrm{avg}}=\frac{1}{6}\int_0^6(x+2)\,dx=5$, not $8$.'),
    jsonb_build_object('id','B','text','$\frac{4}{3}$','explanation','This comes from dividing by the wrong factor when solving $3k+2=8$.'),
    jsonb_build_object('id','C','text','$3$','explanation','This would produce an average value greater than $8$; it comes from setting $\int_0^6 (kx+2)\,dx=8$ without dividing by $6$.'),
    jsonb_build_object('id','D','text','$2$','explanation','Correct. $8=\frac{1}{6}\int_0^6 (kx+2)\,dx=\frac{1}{6}\left[\frac{k}{2}x^2+2x\right]_0^6=\frac{1}{6}(18k+12)=3k+2$, so $k=2$.')
  ),
  correct_option_id = 'D',
  tolerance = 0.0010,
  explanation = 'Set
$$8=\frac{1}{6}\int_0^6 (kx+2)\,dx=\frac{1}{6}\left[\frac{k}{2}x^2+2x\right]_0^6=\frac{18k+12}{6}=3k+2.$$
Thus $3k=6$ and $k=2$.',
  recommendation_reasons = ARRAY['Integrates parameter solving with the average value definition.','Targets the frequent mistake of forgetting the divide-by-interval-length step.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.05,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: compute average value, then solve for a parameter.',
  weight_primary = 0.60,
  weight_supporting = 0.40,
    primary_skill_id = 'SK_AVG_VALUE_FORMULA',
  supporting_skill_ids = ARRAY['SK_DEFINITE_INTEGRAL_EVAL'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_AppIntegration',
  updated_at = NOW()
WHERE title = '8.1-P5';



-- Unit 8.2 (Connecting Position, Velocity, and Acceleration Functions Using Integrals) — Practice 1–5

UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_AppIntegration',
  sub_topic_id = '8.2',
  section_id = '8.2',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 95,
  skill_tags = ARRAY['SK_MOTION_POSITION_FROM_VELOCITY','SK_FTC_ACCUMULATION'],
  error_tags = ARRAY['E_MOTION_IGNORE_INITIAL_POSITION','E_MOTION_DISPLACEMENT_VS_POSITION'],
  prompt = 'A particle moves along the $x$-axis with velocity $v(t)=4t-6$ (meters per second) for $0\le t\le 3$. If $x(0)=5$, what is $x(3)$?',
  latex = 'A particle moves along the $x$-axis with velocity $v(t)=4t-6$ (meters per second) for $0\le t\le 3$. If $x(0)=5$, what is $x(3)$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$5$','explanation','Correct. $x(3)=x(0)+\int_0^3(4t-6)\,dt=5+[2t^2-6t]_0^3=5+(18-18)=5$.'),
    jsonb_build_object('id','B','text','$0$','explanation','This is the displacement $\int_0^3 v(t)\,dt$, but it ignores the initial position $x(0)=5$.'),
    jsonb_build_object('id','C','text','$-5$','explanation','This comes from subtracting $x(0)$ or mishandling the integral sign.'),
    jsonb_build_object('id','D','text','$9$','explanation','This can come from computing $\int_0^3 4t\,dt=18$ and incorrectly combining with $-6$ without integrating it.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Position accumulates velocity:
$$x(t)=x(0)+\int_0^t v(s)\,ds.$$
Thus
$$x(3)=5+\int_0^3(4t-6)\,dt=5+[2t^2-6t]_0^3=5.$$',
  recommendation_reasons = ARRAY['Reinforces position as initial value plus accumulated velocity.','Targets the common mistake of reporting displacement instead of position.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: use $x(t)=x(0)+\int_0^t v$ and keep initial condition.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
    primary_skill_id = 'SK_MOTION_POSITION_FROM_VELOCITY',
  supporting_skill_ids = ARRAY['SK_FTC_ACCUMULATION'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_AppIntegration',
  updated_at = NOW()
WHERE title = '8.2-P1';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_AppIntegration',
  sub_topic_id = '8.2',
  section_id = '8.2',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 120,
  skill_tags = ARRAY['SK_MOTION_DISTANCE_FROM_VELOCITY_GRAPH','SK_INTERPRET_GRAPH'],
  error_tags = ARRAY['E_MOTION_DISPLACEMENT_VS_DISTANCE','E_ABS_VALUE_DISTANCE'],
  prompt = 'The velocity of a particle is shown in the figure labeled 8.2-P2. What is the total distance traveled on $0\le t\le 9$?',
  latex = 'The velocity of a particle is shown in the figure labeled 8.2-P2. What is the total distance traveled on $0\le t\le 9$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$1$','explanation','This incorrectly uses only a single interval or misreads the axes.'),
    jsonb_build_object('id','B','text','$5$','explanation','This counts only the first segment and ignores the negative-velocity segment.'),
    jsonb_build_object('id','C','text','$7$','explanation','This can come from adding $5$ and $2$ but forgetting that the $-2$ segment contributes distance $4$.'),
    jsonb_build_object('id','D','text','$9$','explanation','Correct. Distance is $\int_0^9|v(t)|dt=1\cdot 5+2\cdot 2+0\cdot 2=5+4+0=9$.')
  ),
  correct_option_id = 'D',
  tolerance = 0.0010,
  explanation = 'Total distance traveled is
$$\int_0^9 |v(t)|\,dt.$$
From the step graph: $v=1$ on $[0,5)$ gives $5$, $v=-2$ on $[5,7)$ gives $4$, and $v=0$ on $[7,9]$ gives $0$, so the total distance is $9$.',
  recommendation_reasons = ARRAY['Distinguishes total distance (absolute area) from displacement (signed area).','Builds fluency reading areas from velocity graphs.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: sum absolute areas under a velocity graph.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
    primary_skill_id = 'SK_MOTION_DISTANCE_FROM_VELOCITY_GRAPH',
  supporting_skill_ids = ARRAY['SK_INTERPRET_GRAPH'],
  prompt_type = 'text_and_image',
  representation_type = 'symbolic',
  topic_id = 'Both_AppIntegration',
  updated_at = NOW()
WHERE title = '8.2-P2';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_AppIntegration',
  sub_topic_id = '8.2',
  section_id = '8.2',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 145,
  skill_tags = ARRAY['SK_MOTION_VELOCITY_FROM_ACCELERATION','SK_FTC_ACCUMULATION'],
  error_tags = ARRAY['E_MOTION_IGNORE_INITIAL_POSITION','E_MOTION_DISPLACEMENT_VS_POSITION'],
  prompt = 'A particle has acceleration $a(t)=6t$ for $0\le t\le 2$ and velocity $v(0)=-1$. What is $v(2)$?',
  latex = 'A particle has acceleration $a(t)=6t$ for $0\le t\le 2$ and velocity $v(0)=-1$. What is $v(2)$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$11$','explanation','Correct. $v(2)=v(0)+\int_0^2 6t\,dt=-1+[3t^2]_0^2=-1+12=11$.'),
    jsonb_build_object('id','B','text','$12$','explanation','This is the change in velocity $\int_0^2 a(t)\,dt$, but it ignores the initial velocity $v(0)=-1$.'),
    jsonb_build_object('id','C','text','$-13$','explanation','This subtracts the integral instead of adding it.'),
    jsonb_build_object('id','D','text','$-1$','explanation','This incorrectly assumes velocity stays constant despite nonzero acceleration.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Velocity accumulates from acceleration:
$$v(t)=v(0)+\int_0^t a(s)\,ds.$$
So
$$v(2)=-1+\int_0^2 6t\,dt=-1+[3t^2]_0^2=-1+12=11.$$',
  recommendation_reasons = ARRAY['Connects acceleration to velocity through accumulation.','Targets the mistake of reporting only the change in velocity.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: $v(t)=v(0)+\int_0^t a(s)\,ds$ with correct initial condition.',
  weight_primary = 0.60,
  weight_supporting = 0.40,
    primary_skill_id = 'SK_MOTION_VELOCITY_FROM_ACCELERATION',
  supporting_skill_ids = ARRAY['SK_FTC_ACCUMULATION'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_AppIntegration',
  updated_at = NOW()
WHERE title = '8.2-P3';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_AppIntegration',
  sub_topic_id = '8.2',
  section_id = '8.2',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 120,
  skill_tags = ARRAY['SK_MOTION_DISPLACEMENT_INTEGRAL','SK_DEFINITE_INTEGRAL_EVAL'],
  error_tags = ARRAY['E_MOTION_DISPLACEMENT_VS_DISTANCE','E_SIGN_ERROR_LIMITS'],
  prompt = 'A particle’s velocity is $v(t)=t^2-4t$ for $0\le t\le 5$. What is the displacement on $[0,5]$?',
  latex = 'A particle’s velocity is $v(t)=t^2-4t$ for $0\le t\le 5$. What is the displacement on $[0,5]$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\displaystyle \int_0^5 |t^2-4t|\,dt$','explanation','This gives total distance traveled, not displacement.'),
    jsonb_build_object('id','B','text','$-\dfrac{25}{3}$','explanation','Correct. Displacement is $\int_0^5 (t^2-4t)\,dt=\left[\frac{t^3}{3}-2t^2\right]_0^5=\frac{125}{3}-50=-\frac{25}{3}$.'),
    jsonb_build_object('id','C','text','$\dfrac{25}{3}$','explanation','This has the wrong sign and often comes from swapping limits or dropping the negative.'),
    jsonb_build_object('id','D','text','$-25$','explanation','This results from an antiderivative error or arithmetic mistake at evaluation.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Displacement is the signed integral of velocity:
$$\text{displacement}=\int_0^5 v(t)\,dt=\int_0^5(t^2-4t)\,dt=\left[\frac{t^3}{3}-2t^2\right]_0^5=-\frac{25}{3}.$$',
  recommendation_reasons = ARRAY['Reinforces displacement as a signed area under $v(t)$.','Targets the common misuse of absolute value when asked for displacement.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: displacement uses $\int v(t)\,dt$ (no absolute value).',
  weight_primary = 0.70,
  weight_supporting = 0.30,
    primary_skill_id = 'SK_MOTION_DISPLACEMENT_INTEGRAL',
  supporting_skill_ids = ARRAY['SK_DEFINITE_INTEGRAL_EVAL'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_AppIntegration',
  updated_at = NOW()
WHERE title = '8.2-P4';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_AppIntegration',
  sub_topic_id = '8.2',
  section_id = '8.2',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 5,
  target_time_seconds = 175,
  skill_tags = ARRAY['SK_MAX_POSITION_FROM_VELOCITY','SK_MOTION_POSITION_FROM_VELOCITY'],
  error_tags = ARRAY['E_MOTION_MAX_VS_MAX_VELOCITY','E_MOTION_IGNORE_INITIAL_POSITION'],
  prompt = 'A particle moves on the $x$-axis with velocity $v(t)=\sin t$ for $0\le t\le 2\pi$. If $x(0)=0$, at what time $t$ is the particle farthest to the right?',
  latex = 'A particle moves on the $x$-axis with velocity $v(t)=\sin t$ for $0\le t\le 2\pi$. If $x(0)=0$, at what time $t$ is the particle farthest to the right?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$0$','explanation','At $t=0$, $x=0$, but the particle initially moves right since $\sin t>0$ for small $t>0$.'),
    jsonb_build_object('id','B','text','$\frac{\pi}{2}$','explanation','Here velocity is greatest, but the particle is farthest right when position is maximized, not when velocity is maximized.'),
    jsonb_build_object('id','C','text','$\pi$','explanation','Correct. $x(t)=\int_0^t \sin s\,ds=1-\cos t$, which is maximized when $\cos t$ is minimized, at $t=\pi$.'),
    jsonb_build_object('id','D','text','$2\pi$','explanation','At $t=2\pi$, $x(2\pi)=1-\cos(2\pi)=0$, returning to the start.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'Position is accumulated velocity:
$$x(t)=x(0)+\int_0^t \sin s\,ds=\int_0^t \sin s\,ds=1-\cos t.$$
On $[0,2\pi]$, $1-\cos t$ is largest when $\cos t$ is smallest, which occurs at $t=\pi$.',
  recommendation_reasons = ARRAY['Connects “farthest right” to maximizing position (an accumulation), not maximizing velocity.','Targets a classic AP trap: confusing peak velocity with maximum position.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.05,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: maximize $x(t)=x(0)+\int_0^t v(s)\,ds$ using the accumulated position function.',
  weight_primary = 0.60,
  weight_supporting = 0.40,
    primary_skill_id = 'SK_MAX_POSITION_FROM_VELOCITY',
  supporting_skill_ids = ARRAY['SK_MOTION_POSITION_FROM_VELOCITY'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_AppIntegration',
  updated_at = NOW()
WHERE title = '8.2-P5';

COMMIT;
