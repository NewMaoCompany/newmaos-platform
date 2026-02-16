-- Unit 4 Unit Test SQL Update Script
-- Wrapped in a DO block to ensure atomic execution and prevent syntax errors at EOF.

DO $block$
BEGIN

-- Unit 4 (Contextual Applications) — Unit Test (Questions 1–20)

UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Applications',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 75,
  skill_tags = ARRAY['SK_DERIV_IN_CONTEXT', 'SK_SIGN_INTERP', 'SK_UNITS'],
  primary_skill_id = 'SK_DERIV_IN_CONTEXT',
  supporting_skill_ids = ARRAY['SK_SIGN_INTERP', 'SK_UNITS'],
 'SK_UNITS'], 'SK_UNITS'],
  error_tags = ARRAY['E_SIGN_INTERP', 'E_UNITS', 'E_AVG_VS_INST'],
  prompt = 'A bacteria culture has population $P(t)$ (in thousands) at time $t$ hours. At $t=6$, $P(6)=18$ and $P''(6)=-0.7$. Which statement is correct?',
  latex = 'A bacteria culture has population $P(t)$ (in thousands) at time $t$ hours. At $t=6$, $P(6)=18$ and $P''(6)=-0.7$. Which statement is correct?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','At $t=6$, the population is decreasing at $0.7$ thousand bacteria per hour.','explanation','Correct: $P''(6)=-0.7$ thousand/hour indicates a decrease.'),
    jsonb_build_object('id','B','text','At $t=6$, the population is decreasing at $0.7$ bacteria per hour.','explanation','Units mismatch: $P$ is in thousands.'),
    jsonb_build_object('id','C','text','From $t=5$ to $t=6$, the population decreased by $0.7$ thousand bacteria.','explanation','Confuses instantaneous rate with a one-hour net change.'),
    jsonb_build_object('id','D','text','At $t=6$, the population is $-0.7$ thousand bacteria.','explanation','Confuses the value $P(6)$ with the rate $P''(6)$.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Because $P$ is measured in thousands, $P''(6)=-0.7$ means the population is changing at $-0.7$ thousand bacteria per hour at $t=6$.',
  recommendation_reasons = ARRAY['Interprets a derivative value using correct sign and units.', 'Targets the common value-vs-rate confusion.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: interpret $f''(a)$ with sign and units in a real context.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Applications',
  updated_at = NOW()
WHERE title = '4.0-UT-Q1';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Applications',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 105,
  skill_tags = ARRAY['SK_MOTION', 'SK_GRAPH_READ', 'SK_SIGN_INTERP'],
  primary_skill_id = 'SK_MOTION',
  supporting_skill_ids = ARRAY['SK_GRAPH_READ', 'SK_SIGN_INTERP'],
 'SK_SIGN_INTERP'], 'SK_SIGN_INTERP'],
  error_tags = ARRAY['E_SIGN_INTERP', 'E_AVG_VS_INST'],
  prompt = 'The image shows position $s$ (meters) versus time $t$ (seconds). At $t=5$, which best describes the velocity $v(5)$? (See image.)',
  latex = 'The image shows position $s$ (meters) versus time $t$ (seconds). At $t=5$, which best describes the velocity $v(5)$? (See image.)',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$v(5)>0$','explanation','Correct: the graph is increasing at $t=5$, so slope (velocity) is positive.'),
    jsonb_build_object('id','B','text','$v(5)=0$','explanation','Velocity would be zero only if the tangent were horizontal.'),
    jsonb_build_object('id','C','text','$v(5)<0$','explanation','Negative velocity would require decreasing position at $t=5$.'),
    jsonb_build_object('id','D','text','Velocity cannot be determined from a position–time graph.','explanation','Velocity equals the slope of the position–time graph.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Velocity is $v(t)=s''(t)$, the slope of the position–time graph. At $t=5$ the curve is increasing, so $s''(5)>0$.',
  recommendation_reasons = ARRAY['Connects motion to derivative-as-slope on a graph.', 'Reinforces sign interpretation of velocity from position.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.05,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: velocity sign from position graph slope; includes required diagram.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text_and_image',
  representation_type = 'symbolic',
  topic_id = 'Both_Applications',
  updated_at = NOW()
WHERE title = '4.0-UT-Q2';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Applications',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 90,
  skill_tags = ARRAY['SK_RELATED_SETUP', 'SK_IMPLICIT_DIFF', 'SK_UNITS'],
  primary_skill_id = 'SK_RELATED_SETUP',
  supporting_skill_ids = ARRAY['SK_IMPLICIT_DIFF', 'SK_UNITS'],
 'SK_UNITS'], 'SK_UNITS'],
  error_tags = ARRAY['E_IMPLICIT_DIFF', 'E_UNITS', 'E_CHAIN_RULE'],
  prompt = 'The radius $r$ of a circle is increasing at $\frac{dr}{dt}=3$ cm/s. The area is $A=\pi r^2$. Which expression correctly gives $\frac{dA}{dt}$ in terms of $r$?',
  latex = 'The radius $r$ of a circle is increasing at $\frac{dr}{dt}=3$ cm/s. The area is $A=\pi r^2$. Which expression correctly gives $\frac{dA}{dt}$ in terms of $r$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\frac{dA}{dt}=3\pi$','explanation','Does not differentiate $\pi r^2$ with respect to time.'),
    jsonb_build_object('id','B','text','$\frac{dA}{dt}=2\pi r$','explanation','This is $\frac{dA}{dr}$, not $\frac{dA}{dt}$.'),
    jsonb_build_object('id','C','text','$\frac{dA}{dt}=2\pi r\cdot 3$','explanation','Correct: chain rule gives $\frac{dA}{dt}=2\pi r\frac{dr}{dt}=2\pi r\cdot 3$.'),
    jsonb_build_object('id','D','text','$\frac{dA}{dt}=3\pi r^2$','explanation','Multiplies by $\frac{dr}{dt}$ without differentiating first.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'Differentiate with respect to $t$: $\frac{dA}{dt}=\frac{d}{dt}(\pi r^2)=2\pi r\frac{dr}{dt}=2\pi r\cdot 3$.',
  recommendation_reasons = ARRAY['Checks correct chain-rule setup in related rates.', 'Targets confusion between $dA/dr$ and $dA/dt$.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: differentiate with respect to time and apply chain rule.',
  weight_primary = 0.75,
  weight_supporting = 0.25,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Applications',
  updated_at = NOW()
WHERE title = '4.0-UT-Q3';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Applications',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 150,
  skill_tags = ARRAY['SK_RELATED_SOLVE', 'SK_IMPLICIT_DIFF', 'SK_ALG_SOLVE'],
  primary_skill_id = 'SK_RELATED_SOLVE',
  supporting_skill_ids = ARRAY['SK_IMPLICIT_DIFF', 'SK_ALG_SOLVE'],
 'SK_ALG_SOLVE'], 'SK_ALG_SOLVE'],
  error_tags = ARRAY['E_IMPLICIT_DIFF', 'E_CHAIN_RULE', 'E_ARITH'],
  prompt = 'A spherical balloon has volume $V=\frac{4}{3}\pi r^3$. Air is pumped in at $\frac{dV}{dt}=10$ cm$^3$/s. When $r=5$ cm, what is $\frac{dr}{dt}$?',
  latex = 'A spherical balloon has volume $V=\frac{4}{3}\pi r^3$. Air is pumped in at $\frac{dV}{dt}=10$ cm$^3$/s. When $r=5$ cm, what is $\frac{dr}{dt}$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\frac{1}{10\pi}$','explanation','Incorrect differentiation and missing $r^2$.'),
    jsonb_build_object('id','B','text','$\frac{1}{25\pi}$','explanation','Missing the factor $4\pi r^2$ after differentiating.'),
    jsonb_build_object('id','C','text','$\frac{1}{50\pi}$','explanation','Arithmetic/factor error.'),
    jsonb_build_object('id','D','text','$\frac{1}{100\pi}$','explanation','Correct: $10=4\pi(25)\,\frac{dr}{dt}$ so $\frac{dr}{dt}=\frac{1}{100\pi}$.')
  ),
  correct_option_id = 'D',
  tolerance = 0.0010,
  explanation = 'Differentiate: $\frac{dV}{dt}=4\pi r^2\frac{dr}{dt}$. At $r=5$, $10=4\pi(25)\frac{dr}{dt}=100\pi\frac{dr}{dt}$, so $\frac{dr}{dt}=\frac{1}{100\pi}$.',
  recommendation_reasons = ARRAY['Representative multi-step related rates solve.', 'Targets common differentiation and algebra slips.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.15,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: sphere volume related rates with substitution at a specific radius.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Applications',
  updated_at = NOW()
WHERE title = '4.0-UT-Q4';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Applications',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 110,
  skill_tags = ARRAY['SK_RATE_MODEL', 'SK_UNITS', 'SK_SIGN_INTERP'],
  primary_skill_id = 'SK_RATE_MODEL',
  supporting_skill_ids = ARRAY['SK_UNITS', 'SK_SIGN_INTERP'],
 'SK_SIGN_INTERP'], 'SK_SIGN_INTERP'],
  error_tags = ARRAY['E_UNITS', 'E_AVG_VS_INST', 'E_SIGN_INTERP'],
  prompt = 'A tank contains $W(t)$ liters of water. At $t=4$ minutes, $W(4)=120$ and the net rate of change is $W''(4)=-3$. Which interpretation is correct?',
  latex = 'A tank contains $W(t)$ liters of water. At $t=4$ minutes, $W(4)=120$ and the net rate of change is $W''(4)=-3$. Which interpretation is correct?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','At $t=4$, water is leaving the tank $3$ L/min faster than it is entering.','explanation','Correct: net rate $-3$ means outflow exceeds inflow by $3$ L/min.'),
    jsonb_build_object('id','B','text','At $t=4$, the tank contains $-3$ liters of water.','explanation','Confuses amount with rate.'),
    jsonb_build_object('id','C','text','From $t=3$ to $t=4$, exactly $3$ liters left the tank.','explanation','Instantaneous rate does not force an exact one-minute net change.'),
    jsonb_build_object('id','D','text','At $t=4$, water is entering the tank at $3$ L/min.','explanation','A negative net rate does not mean inflow is $3$; it means net is decreasing.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = '$W''(4)=-3$ L/min means the amount of water is decreasing at 3 L/min at that moment, so outflow exceeds inflow by 3 L/min.',
  recommendation_reasons = ARRAY['Builds correct language for net rate of change in context.', 'Targets instantaneous-vs-average confusion.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.05,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: interpret negative derivative as net decrease with correct units.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Applications',
  updated_at = NOW()
WHERE title = '4.0-UT-Q5';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Applications',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 140,
  skill_tags = ARRAY['SK_LINEAR_APPROX', 'SK_ALG_SOLVE'],
  primary_skill_id = 'SK_LINEAR_APPROX',
  supporting_skill_ids = ARRAY['SK_ALG_SOLVE'],

  error_tags = ARRAY['E_LINEARIZATION', 'E_ARITH'],
  prompt = 'Use linearization at $x=4$ to approximate $\sqrt{4.1}$.',
  latex = 'Use linearization at $x=4$ to approximate $\sqrt{4.1}$.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$2.01$','explanation','Too small; correct linearization gives $2.025$.'),
    jsonb_build_object('id','B','text','$2.025$','explanation','Correct: $f(4)=2$, $f''(4)=\frac{1}{4}$, so $2+\frac{1}{4}(0.1)=2.025$.'),
    jsonb_build_object('id','C','text','$2.05$','explanation','Uses $f''(4)=\frac{1}{2}$ instead of $\frac{1}{4}$.'),
    jsonb_build_object('id','D','text','$2.1$','explanation','Incorrectly adds $0.1$ directly to $\sqrt{4}$.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Let $f(x)=\sqrt{x}$. Then $f(4)=2$ and $f''(x)=\frac{1}{2\sqrt{x}}$, so $f''(4)=\frac{1}{4}$. Linearization $L(x)=2+\frac{1}{4}(x-4)$ gives $\sqrt{4.1}\approx L(4.1)=2.025$.',
  recommendation_reasons = ARRAY['Reinforces tangent-line approximation near a convenient point.', 'Targets common derivative and arithmetic slips.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.15,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: compute $L(x)=f(a)+f''(a)(x-a)$ and evaluate.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Applications',
  updated_at = NOW()
WHERE title = '4.0-UT-Q6';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Applications',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 120,
  skill_tags = ARRAY['SK_MOTION', 'SK_ALG_SOLVE', 'SK_SIGN_INTERP'],
  primary_skill_id = 'SK_MOTION',
  supporting_skill_ids = ARRAY['SK_ALG_SOLVE', 'SK_SIGN_INTERP'],
 'SK_SIGN_INTERP'], 'SK_SIGN_INTERP'],
  error_tags = ARRAY['E_ARITH', 'E_SIGN_INTERP'],
  prompt = 'A particle moves along a line with velocity $v(t)=t^2-4t+1$ (m/s). On what interval(s) is the particle moving to the left?',
  latex = 'A particle moves along a line with velocity $v(t)=t^2-4t+1$ (m/s). On what interval(s) is the particle moving to the left?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$(-\infty,0)$','explanation','Does not match where the quadratic is negative.'),
    jsonb_build_object('id','B','text','$(2-\sqrt{3},\,2+\sqrt{3})$','explanation','Correct: $v(t)<0$ between the roots.'),
    jsonb_build_object('id','C','text','$(2+\sqrt{3},\,\infty)$','explanation','For large $t$, $v(t)>0$ since the parabola opens upward.'),
    jsonb_build_object('id','D','text','Never','explanation','The velocity is negative for some $t$ values.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Moving left means $v(t)<0$. Solve $t^2-4t+1<0$. The roots are $t=2\pm\sqrt{3}$. Since the parabola opens upward, it is negative between the roots, so the particle moves left on $(2-\sqrt{3},\,2+\sqrt{3})$.',
  recommendation_reasons = ARRAY['Connects direction to the sign of velocity.', 'Reinforces solving quadratic inequalities.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.05,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: direction from sign of velocity; interval reasoning.',
  weight_primary = 0.75,
  weight_supporting = 0.25,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Applications',
  updated_at = NOW()
WHERE title = '4.0-UT-Q7';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Applications',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 110,
  skill_tags = ARRAY['SK_LHOSPITAL', 'SK_LIMIT_FORMS'],
  primary_skill_id = 'SK_LHOSPITAL',
  supporting_skill_ids = ARRAY['SK_LIMIT_FORMS'],

  error_tags = ARRAY['E_LHOSPITAL_COND', 'E_ARITH'],
  prompt = 'Evaluate $\displaystyle \lim_{x\to 0}\frac{\sin(5x)}{x}$.',
  latex = 'Evaluate $\displaystyle \lim_{x\to 0}\frac{\sin(5x)}{x}$.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$0$','explanation','The ratio does not approach 0.'),
    jsonb_build_object('id','B','text','$1$','explanation','This would be for $\lim \frac{\sin x}{x}$ without the factor 5.'),
    jsonb_build_object('id','C','text','$5$','explanation','Correct: $\frac{\sin(5x)}{x}=5\cdot\frac{\sin(5x)}{5x}\to 5$.'),
    jsonb_build_object('id','D','text','Does not exist','explanation','This standard limit exists.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'Use $\lim_{u\to 0}\frac{\sin u}{u}=1$ with $u=5x$: $\frac{\sin(5x)}{x}=5\cdot\frac{\sin(5x)}{5x}\to 5$.',
  recommendation_reasons = ARRAY['Checks recognition of a standard trig limit with scaling.', 'Targets the common missing-factor error.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: indeterminate form $0/0$; use standard limit structure.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Applications',
  updated_at = NOW()
WHERE title = '4.0-UT-Q8';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Applications',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 160,
  skill_tags = ARRAY['SK_RELATED_SOLVE', 'SK_IMPLICIT_DIFF', 'SK_RELATED_SETUP'],
  primary_skill_id = 'SK_RELATED_SOLVE',
  supporting_skill_ids = ARRAY['SK_IMPLICIT_DIFF', 'SK_RELATED_SETUP'],
 'SK_RELATED_SETUP'], 'SK_RELATED_SETUP'],
  error_tags = ARRAY['E_IMPLICIT_DIFF', 'E_CHAIN_RULE', 'E_SIGN_INTERP'],
  prompt = 'A $10$-ft ladder leans against a wall. Let $x$ be the distance (ft) from the wall to the foot of the ladder and $y$ the height (ft) of the top of the ladder. When $x=6$ and $\frac{dx}{dt}=2$ ft/s, what is $\frac{dy}{dt}$? (See image.)',
  latex = 'A $10$-ft ladder leans against a wall. Let $x$ be the distance (ft) from the wall to the foot of the ladder and $y$ the height (ft) of the top of the ladder. When $x=6$ and $\frac{dx}{dt}=2$ ft/s, what is $\frac{dy}{dt}$? (See image.)',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$-\frac{3}{2}$','explanation','Magnitude error; check substitution into $-\frac{x}{y}\frac{dx}{dt}$.'),
    jsonb_build_object('id','B','text','$\frac{3}{4}$','explanation','Wrong sign: $y$ decreases as $x$ increases.'),
    jsonb_build_object('id','C','text','$\frac{3}{2}$','explanation','Wrong sign and magnitude.'),
    jsonb_build_object('id','D','text','$-\frac{3}{4}$','explanation','Correct: $2x\frac{dx}{dt}+2y\frac{dy}{dt}=0$ with $x=6$, $y=8$.')
  ),
  correct_option_id = 'D',
  tolerance = 0.0010,
  explanation = 'Using $x^2+y^2=100$, differentiate: $2x\frac{dx}{dt}+2y\frac{dy}{dt}=0$, so $\frac{dy}{dt}=-\frac{x}{y}\frac{dx}{dt}$. When $x=6$, $y=\sqrt{100-36}=8$, so $\frac{dy}{dt}=-\frac{6}{8}(2)=-\frac{3}{4}$ ft/s.',
  recommendation_reasons = ARRAY['Classic ladder related-rates with sign reasoning.', 'Reinforces implicit differentiation of a constraint.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.15,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: ladder constraint $x^2+y^2=L^2$; includes required diagram.',
  weight_primary = 0.85,
  weight_supporting = 0.15,
  prompt_type = 'text_and_image',
  representation_type = 'symbolic',
  topic_id = 'Both_Applications',
  updated_at = NOW()
WHERE title = '4.0-UT-Q9';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Applications',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 5,
  target_time_seconds = 180,
  skill_tags = ARRAY['SK_RELATED_SOLVE', 'SK_IMPLICIT_DIFF', 'SK_ALG_SOLVE'],
  primary_skill_id = 'SK_RELATED_SOLVE',
  supporting_skill_ids = ARRAY['SK_IMPLICIT_DIFF', 'SK_ALG_SOLVE'],
 'SK_ALG_SOLVE'], 'SK_ALG_SOLVE'],
  error_tags = ARRAY['E_CHAIN_RULE', 'E_IMPLICIT_DIFF', 'E_ARITH'],
  prompt = 'Sand falls onto a conical pile so that the volume increases at $\frac{dV}{dt}=12$ ft$^3$/min. The pile maintains the ratio $\frac{r}{h}=\frac{1}{3}$. When $h=6$ ft, how fast is the height increasing, $\frac{dh}{dt}$?',
  latex = 'Sand falls onto a conical pile so that the volume increases at $\frac{dV}{dt}=12$ ft$^3$/min. The pile maintains the ratio $\frac{r}{h}=\frac{1}{3}$. When $h=6$ ft, how fast is the height increasing, $\frac{dh}{dt}$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\frac{1}{\pi}$','explanation','Incorrect elimination of variables and factors.'),
    jsonb_build_object('id','B','text','$\frac{3}{\pi}$','explanation','Correct: with $r=\frac{h}{3}$, $V=\frac{\pi}{27}h^3$ and $12=4\pi\,\frac{dh}{dt}$.'),
    jsonb_build_object('id','C','text','$\frac{9}{\pi}$','explanation','Factor-of-3 error.'),
    jsonb_build_object('id','D','text','$\frac{27}{\pi}$','explanation','Large factor error.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'With $r=\frac{h}{3}$, $V=\frac{1}{3}\pi r^2h=\frac{\pi}{27}h^3$. Differentiate: $\frac{dV}{dt}=\frac{\pi}{9}h^2\frac{dh}{dt}$. At $h=6$, $12=\frac{\pi}{9}(36)\frac{dh}{dt}=4\pi\frac{dh}{dt}$, so $\frac{dh}{dt}=\frac{3}{\pi}$ ft/min.',
  recommendation_reasons = ARRAY['High-discrimination related rates using a geometric constraint.', 'Targets elimination of variables before differentiating.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 5,
  mastery_weight = 1.20,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: use the constant-shape ratio to express $V$ in one variable.',
  weight_primary = 0.85,
  weight_supporting = 0.15,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Applications',
  updated_at = NOW()
WHERE title = '4.0-UT-Q10';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Applications',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 110,
  skill_tags = ARRAY['SK_DERIV_IN_CONTEXT', 'SK_UNITS'],
  primary_skill_id = 'SK_DERIV_IN_CONTEXT',
  supporting_skill_ids = ARRAY['SK_UNITS'],

  error_tags = ARRAY['E_UNITS', 'E_AVG_VS_INST'],
  prompt = 'A company''s profit (in millions of dollars) is $P(x)$ where $x$ is the number of thousands of units sold. At $x=30$, $P(30)=12$ and $P''(30)=0.4$. Which is the best interpretation of $P''(30)=0.4$?',
  latex = 'A company''s profit (in millions of dollars) is $P(x)$ where $x$ is the number of thousands of units sold. At $x=30$, $P(30)=12$ and $P''(30)=0.4$. Which is the best interpretation of $P''(30)=0.4$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','When 30,000 units have been sold, profit is increasing at about $0.4$ million dollars per additional 1,000 units sold.','explanation','Correct: derivative is rate of change of profit per 1,000 units.'),
    jsonb_build_object('id','B','text','When 30,000 units have been sold, profit is increasing at about $0.4$ million dollars per unit sold.','explanation','Input units are thousands, not single units.'),
    jsonb_build_object('id','C','text','After 30,000 units are sold, profit will be $0.4$ million dollars.','explanation','Confuses rate with value.'),
    jsonb_build_object('id','D','text','From 29,000 to 30,000 units sold, profit increased by exactly $0.4$ million dollars.','explanation','Derivative is instantaneous; finite change need not be exactly $0.4$.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Since $x$ is in thousands of units, $P''(30)=0.4$ means profit changes by about $0.4$ million dollars for each additional $1{,}000$ units sold at $x=30$.',
  recommendation_reasons = ARRAY['Reinforces matching derivative units to interpretation.', 'Targets the thousand-vs-one unit mismatch.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.05,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: interpret derivative when independent variable uses scaled units.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Applications',
  updated_at = NOW()
WHERE title = '4.0-UT-Q11';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Applications',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 145,
  skill_tags = ARRAY['SK_RATE_MODEL', 'SK_DERIV_IN_CONTEXT'],
  primary_skill_id = 'SK_RATE_MODEL',
  supporting_skill_ids = ARRAY['SK_DERIV_IN_CONTEXT'],

  error_tags = ARRAY['E_ARITH', 'E_SIGN_INTERP'],
  prompt = 'The temperature of a chemical reactor (in $^\circ$C) is modeled by $T(t)=80+20e^{-0.1t}$, where $t$ is in minutes. What is the instantaneous rate of change of temperature at $t=0$?',
  latex = 'The temperature of a chemical reactor (in $^\circ$C) is modeled by $T(t)=80+20e^{-0.1t}$, where $t$ is in minutes. What is the instantaneous rate of change of temperature at $t=0$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$2$','explanation','Sign should be negative since $e^{-0.1t}$ is decreasing.'),
    jsonb_build_object('id','B','text','$-0.1$','explanation','Forgets to multiply by 20.'),
    jsonb_build_object('id','C','text','$-2$','explanation','Correct: $T''(t)=-2e^{-0.1t}$ so $T''(0)=-2$.'),
    jsonb_build_object('id','D','text','$-20$','explanation','Factor-of-10 error.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'Differentiate: $T''(t)=20(-0.1)e^{-0.1t}=-2e^{-0.1t}$. Thus $T''(0)=-2$ $^\circ$C/min.',
  recommendation_reasons = ARRAY['Applied derivative with exponentials; emphasizes sign and constants.', 'Common AP-style rate question.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.10,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: derivative of exponential decay model and evaluation at a point.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Applications',
  updated_at = NOW()
WHERE title = '4.0-UT-Q12';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Applications',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 150,
  skill_tags = ARRAY['SK_RELATED_SOLVE', 'SK_IMPLICIT_DIFF', 'SK_ALG_SOLVE'],
  primary_skill_id = 'SK_RELATED_SOLVE',
  supporting_skill_ids = ARRAY['SK_IMPLICIT_DIFF', 'SK_ALG_SOLVE'],
 'SK_ALG_SOLVE'], 'SK_ALG_SOLVE'],
  error_tags = ARRAY['E_IMPLICIT_DIFF', 'E_ARITH', 'E_UNITS'],
  prompt = 'An oil spill forms a circular region with area $A=\pi r^2$. The area is increasing at $\frac{dA}{dt}=50$ m$^2$/min. When $r=20$ m, what is $\frac{dr}{dt}$?',
  latex = 'An oil spill forms a circular region with area $A=\pi r^2$. The area is increasing at $\frac{dA}{dt}=50$ m$^2$/min. When $r=20$ m, what is $\frac{dr}{dt}$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\frac{50}{\pi}$','explanation','Forgets the derivative $\frac{d}{dt}(r^2)=2r\frac{dr}{dt}$.'),
    jsonb_build_object('id','B','text','$\frac{5}{4\pi}$','explanation','Correct: $50=2\pi(20)\frac{dr}{dt}$ so $\frac{dr}{dt}=\frac{5}{4\pi}$.'),
    jsonb_build_object('id','C','text','$\frac{5}{2\pi}$','explanation','Off by a factor of 2.'),
    jsonb_build_object('id','D','text','$\frac{25}{2\pi}$','explanation','Arithmetic error after solving for $\frac{dr}{dt}$.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Differentiate $A=\pi r^2$: $\frac{dA}{dt}=2\pi r\frac{dr}{dt}$. At $r=20$, $50=2\pi(20)\frac{dr}{dt}$, so $\frac{dr}{dt}=\frac{50}{40\pi}=\frac{5}{4\pi}$ m/min.',
  recommendation_reasons = ARRAY['Related rates with correct chain rule and units.', 'Targets common missing-factor error.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.10,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: solve for $dr/dt$ from $dA/dt$ in a circular growth context.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Applications',
  updated_at = NOW()
WHERE title = '4.0-UT-Q13';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Applications',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 135,
  skill_tags = ARRAY['SK_DERIV_IN_CONTEXT', 'SK_LINEAR_APPROX', 'SK_UNITS'],
  primary_skill_id = 'SK_DERIV_IN_CONTEXT',
  supporting_skill_ids = ARRAY['SK_LINEAR_APPROX', 'SK_UNITS'],
 'SK_UNITS'], 'SK_UNITS'],
  error_tags = ARRAY['E_LINEARIZATION', 'E_SIGN_INTERP', 'E_UNITS'],
  prompt = 'The fuel efficiency of a car is modeled by $E(v)$ (miles per gallon) at speed $v$ (mph). At $v=60$, $E(60)=32$ and $E''(60)=-0.15$. Estimate $E(62)$.',
  latex = 'The fuel efficiency of a car is modeled by $E(v)$ (miles per gallon) at speed $v$ (mph). At $v=60$, $E(60)=32$ and $E''(60)=-0.15$. Estimate $E(62)$.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$31.7$','explanation','Correct: $32+(-0.15)(2)=31.7$.'),
    jsonb_build_object('id','B','text','$32.3$','explanation','Sign error; derivative is negative.'),
    jsonb_build_object('id','C','text','$31.85$','explanation','Uses $62-60=1$ instead of 2.'),
    jsonb_build_object('id','D','text','$29.0$','explanation','Scale error; drop is far too large.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Linear approximation: $E(62)\approx E(60)+E''(60)(62-60)=32+(-0.15)(2)=31.7$.',
  recommendation_reasons = ARRAY['Uses derivative as local rate for a nearby-value estimate.', 'Targets sign and input-difference mistakes.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.10,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: contextual linear approximation using derivative information.',
  weight_primary = 0.75,
  weight_supporting = 0.25,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Applications',
  updated_at = NOW()
WHERE title = '4.0-UT-Q14';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Applications',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 5,
  target_time_seconds = 175,
  skill_tags = ARRAY['SK_DIFFERENTIALS', 'SK_LINEAR_APPROX'],
  primary_skill_id = 'SK_DIFFERENTIALS',
  supporting_skill_ids = ARRAY['SK_LINEAR_APPROX'],

  error_tags = ARRAY['E_LINEARIZATION', 'E_ARITH'],
  prompt = 'Use differentials to estimate the change in $f(x)=\ln x$ when $x$ changes from $5$ to $5.2$.',
  latex = 'Use differentials to estimate the change in $f(x)=\ln x$ when $x$ changes from $5$ to $5.2$.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$0.2$','explanation','Incorrectly assumes $\Delta f\approx \Delta x$.'),
    jsonb_build_object('id','B','text','$0.04$','explanation','Correct: $df\approx \frac{1}{5}(0.2)=0.04$.'),
    jsonb_build_object('id','C','text','$5$','explanation','Confuses input value with change in output.'),
    jsonb_build_object('id','D','text','$0.2\ln 5$','explanation','Not the differential formula for $\ln x$.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'For $f(x)=\ln x$, $f''(x)=\frac{1}{x}$. With $x=5$ and $dx=0.2$, $df\approx f''(5)dx=\frac{1}{5}(0.2)=0.04$.',
  recommendation_reasons = ARRAY['Reinforces differential approximation $df=f''(a)dx$.', 'Targets common misuse of exact change vs differential.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 5,
  mastery_weight = 1.20,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: compute $df$ using derivative at the base point.',
  weight_primary = 0.85,
  weight_supporting = 0.15,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Applications',
  updated_at = NOW()
WHERE title = '4.0-UT-Q15';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Applications',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 140,
  skill_tags = ARRAY['SK_LHOSPITAL', 'SK_LIMIT_FORMS', 'SK_ALG_SOLVE'],
  primary_skill_id = 'SK_LHOSPITAL',
  supporting_skill_ids = ARRAY['SK_LIMIT_FORMS', 'SK_ALG_SOLVE'],
 'SK_ALG_SOLVE'], 'SK_ALG_SOLVE'],
  error_tags = ARRAY['E_LHOSPITAL_COND', 'E_ARITH'],
  prompt = 'Evaluate $\displaystyle \lim_{x\to 0}\frac{e^{2x}-1-2x}{x^2}$.',
  latex = 'Evaluate $\displaystyle \lim_{x\to 0}\frac{e^{2x}-1-2x}{x^2}$.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$0$','explanation','After canceling linear behavior, the limit is not 0.'),
    jsonb_build_object('id','B','text','$1$','explanation','Missing the factor from the second derivative.'),
    jsonb_build_object('id','C','text','$2$','explanation','Correct: applying L''Hospital twice gives 2.'),
    jsonb_build_object('id','D','text','Does not exist','explanation','The limit exists and is finite.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'This is $0/0$. Apply L''Hospital: first derivative gives $\lim_{x\to 0}\frac{2e^{2x}-2}{2x}=\lim_{x\to 0}\frac{e^{2x}-1}{x}$, still $0/0$. Apply again: $\lim_{x\to 0}\frac{2e^{2x}}{1}=2$.',
  recommendation_reasons = ARRAY['Representative repeated L''Hospital pattern in AP BC.', 'Reinforces checking indeterminate form each time.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.15,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: L''Hospital twice; avoid stopping one step early.',
  weight_primary = 0.85,
  weight_supporting = 0.15,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Applications',
  updated_at = NOW()
WHERE title = '4.0-UT-Q16';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Applications',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 120,
  skill_tags = ARRAY['SK_LINEAR_APPROX', 'SK_ALG_SOLVE'],
  primary_skill_id = 'SK_LINEAR_APPROX',
  supporting_skill_ids = ARRAY['SK_ALG_SOLVE'],

  error_tags = ARRAY['E_LINEARIZATION', 'E_ARITH'],
  prompt = 'Let $f(x)=x^3$. Use linearization at $x=2$ to approximate $f(2.02)$.',
  latex = 'Let $f(x)=x^3$. Use linearization at $x=2$ to approximate $f(2.02)$.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$8.24$','explanation','Correct: $f(2)=8$ and $f''(2)=12$, so $8+12(0.02)=8.24$.'),
    jsonb_build_object('id','B','text','$8.12$','explanation','Uses $f''(2)=6$ instead of 12.'),
    jsonb_build_object('id','C','text','$8.08$','explanation','Arithmetic/derivative slip.'),
    jsonb_build_object('id','D','text','$8.00$','explanation','Ignores the change in $x$.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Linearization: $L(x)=f(2)+f''(2)(x-2)$. With $f''(x)=3x^2$, $f''(2)=12$. Thus $f(2.02)\approx 8+12(0.02)=8.24$.',
  recommendation_reasons = ARRAY['Quick check of tangent-line approximation computation.', 'Targets common derivative-value errors.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.05,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: compute linearization and evaluate near the base point.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Applications',
  updated_at = NOW()
WHERE title = '4.0-UT-Q17';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Applications',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 150,
  skill_tags = ARRAY['SK_MOTION', 'SK_ALG_SOLVE', 'SK_SIGN_INTERP'],
  primary_skill_id = 'SK_MOTION',
  supporting_skill_ids = ARRAY['SK_ALG_SOLVE', 'SK_SIGN_INTERP'],
 'SK_SIGN_INTERP'], 'SK_SIGN_INTERP'],
  error_tags = ARRAY['E_SIGN_INTERP', 'E_ARITH'],
  prompt = 'A particle has acceleration $a(t)=6t-12$ (m/s$^2$) and velocity $v(0)=3$ (m/s). At what time $t>0$ does the particle first change direction?',
  latex = 'A particle has acceleration $a(t)=6t-12$ (m/s$^2$) and velocity $v(0)=3$ (m/s). At what time $t>0$ does the particle first change direction?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$t=\frac{1}{2}$','explanation','Direction change occurs when $v(t)=0$, not at a guessed time.'),
    jsonb_build_object('id','B','text','$t=1$','explanation','This is when $a(t)=0$, not necessarily when $v(t)=0$.'),
    jsonb_build_object('id','C','text','$t=2+\sqrt{3}$','explanation','This is a time when $v(t)=0$, but not the first positive one.'),
    jsonb_build_object('id','D','text','$t=2-\sqrt{3}$','explanation','Correct: integrating gives $v(t)=3t^2-12t+3$ and the first positive root is $2-\sqrt{3}$.')
  ),
  correct_option_id = 'D',
  tolerance = 0.0010,
  explanation = 'Since $v''(t)=a(t)=6t-12$, integrate: $v(t)=3t^2-12t+C$. Using $v(0)=3$ gives $C=3$. Solve $3t^2-12t+3=0\Rightarrow t^2-4t+1=0\Rightarrow t=2\pm\sqrt{3}$. The first positive time is $t=2-\sqrt{3}$.',
  recommendation_reasons = ARRAY['Tests direction-change criterion (velocity sign).', 'Connects acceleration to velocity via integration and initial condition.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.15,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: change direction when $v(t)$ crosses 0; not when $a(t)=0$.',
  weight_primary = 0.85,
  weight_supporting = 0.15,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Applications',
  updated_at = NOW()
WHERE title = '4.0-UT-Q18';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Applications',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 155,
  skill_tags = ARRAY['SK_ERROR_BOUND', 'SK_LINEAR_APPROX'],
  primary_skill_id = 'SK_ERROR_BOUND',
  supporting_skill_ids = ARRAY['SK_LINEAR_APPROX'],

  error_tags = ARRAY['E_LINEARIZATION', 'E_ARITH'],
  prompt = 'Use the second derivative to bound the error when approximating $\sin(0.1)$ by its linearization at $0$. Which is a valid upper bound on the absolute error?',
  latex = 'Use the second derivative to bound the error when approximating $\sin(0.1)$ by its linearization at $0$. Which is a valid upper bound on the absolute error?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\frac{1}{2}(0.1)$','explanation','Wrong order; linearization error scales like $(x-a)^2$.'),
    jsonb_build_object('id','B','text','$\frac{1}{6}(0.1)^3$','explanation','Uses a cubic term; not the standard first-order remainder bound.'),
    jsonb_build_object('id','C','text','$0.05$','explanation','Too large and not justified by the remainder formula.'),
    jsonb_build_object('id','D','text','$\frac{1}{2}(0.1)^2$','explanation','Correct: with $|f^{(3)}(x)|\le 1$, $|R_1|\le \frac{1}{2}(0.1)^2=0.005$.')
  ),
  correct_option_id = 'D',
  tolerance = 0.0010,
  explanation = 'For $f(x)=\sin x$, $f^{(3)}(x)=-\sin x$, so $|f^{(3)}(x)|\le 1$ near 0. The first-order remainder satisfies $|R_1(x)|\le \frac{M}{2}(x-a)^2$ with $M=1$, $a=0$, $x=0.1$, so $|R_1|\le \frac{1}{2}(0.1)^2=0.005$.',
  recommendation_reasons = ARRAY['Builds remainder-bound technique using $\max|f^{(3)}|$.', 'High-frequency AP BC error-estimation skill.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.15,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: linearization error bound $\frac{M}{2}(x-a)^2$ with $M=\max|f^{(3)}|$.',
  weight_primary = 0.75,
  weight_supporting = 0.25,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Applications',
  updated_at = NOW()
WHERE title = '4.0-UT-Q19';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Applications',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 5,
  target_time_seconds = 170,
  skill_tags = ARRAY['SK_LHOSPITAL', 'SK_LIMIT_FORMS', 'SK_ALG_SOLVE'],
  primary_skill_id = 'SK_LHOSPITAL',
  supporting_skill_ids = ARRAY['SK_LIMIT_FORMS', 'SK_ALG_SOLVE'],
 'SK_ALG_SOLVE'], 'SK_ALG_SOLVE'],
  error_tags = ARRAY['E_LHOSPITAL_COND', 'E_ARITH'],
  prompt = 'Evaluate $\displaystyle \lim_{x\to \infty}\frac{\ln x}{x^{1/3}}$.',
  latex = 'Evaluate $\displaystyle \lim_{x\to \infty}\frac{\ln x}{x^{1/3}}$.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\infty$','explanation','A positive power of $x$ grows faster than $\ln x$.'),
    jsonb_build_object('id','B','text','$1$','explanation','No constant ratio here.'),
    jsonb_build_object('id','C','text','$0$','explanation','Correct: apply L''Hospital once to get a constant multiple of $x^{-1/3}\to 0$.'),
    jsonb_build_object('id','D','text','Does not exist','explanation','The limit exists and equals 0.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'This is an $\infty/\infty$ form. L''Hospital gives $\frac{(1/x)}{(1/3)x^{-2/3}}=3x^{-1/3}\to 0$ as $x\to\infty$.',
  recommendation_reasons = ARRAY['Classic growth-rate limit using L''Hospital.', 'Targets exponent-handling in algebra after differentiating.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 5,
  mastery_weight = 1.20,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: logarithm vs power growth; correct L''Hospital execution.',
  weight_primary = 0.85,
  weight_supporting = 0.15,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Applications',
  updated_at = NOW()
WHERE title = '4.0-UT-Q20';

END $block$;
