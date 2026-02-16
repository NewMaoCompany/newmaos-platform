-- Unit 4.1 & 4.2 SQL Update Script
-- Wrapped in a DO block to ensure atomic execution and prevent syntax errors at EOF.

DO $block$
BEGIN

-- Unit 4.1 (Interpreting the Meaning of the Derivative in Context) — Practice 1–5

UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Applications',
  sub_topic_id = '4.1',
  section_id = '4.1',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 90,
  skill_tags = ARRAY['SKILL_INTERPRET_DERIVATIVE_CONTEXT','SKILL_UNITS_IN_CONTEXT'],
  primary_skill_id = 'SKILL_INTERPRET_DERIVATIVE_CONTEXT',
  supporting_skill_ids = ARRAY['SKILL_UNITS_IN_CONTEXT'],

  error_tags = ARRAY['ERR_INTERPRET_DERIVATIVE_AS_VALUE','ERR_IGNORE_UNITS','ERR_SIGN_MISINTERPRET'],
  prompt = 'A company''s weekly profit is modeled by $P(t)=120t-5t^2$, where $P$ is in thousands of dollars and $t$ is measured in weeks since a new product launch. Which statement best interprets $P''(8)$?',
  latex = 'A company''s weekly profit is modeled by $P(t)=120t-5t^2$, where $P$ is in thousands of dollars and $t$ is measured in weeks since a new product launch. Which statement best interprets $P''(8)$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','At $t=8$, the profit is decreasing and equals $P''(8)$ thousand dollars.','explanation','The derivative is a rate, not the profit value.'),
    jsonb_build_object('id','B','text','At $t=8$, the profit is increasing at $40$ thousand dollars per week.','explanation','Correct: $P''(8)=40$ and the units are thousand dollars per week.'),
    jsonb_build_object('id','C','text','At $t=8$, the profit is decreasing at $40$ thousand dollars per week.','explanation','Sign is wrong because $P''(8)=40>0$.'),
    jsonb_build_object('id','D','text','At $t=8$, the profit will be $40$ thousand dollars next week.','explanation','A derivative does not directly give next week''s profit amount.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Compute $P''(t)=120-10t$, so $P''(8)=120-80=40$. Because $P''(8)>0$, profit is increasing at that instant at a rate of $40$ thousand dollars per week.',
  recommendation_reasons = ARRAY['Targets interpreting derivatives as instantaneous rates with correct sign and units.','Addresses the common confusion between a derivative value and a function value.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: derivative meaning in context; emphasize units (thousand dollars per week) and sign.',
  weight_primary = 0.75,
  weight_supporting = 0.25,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Applications',
  updated_at = NOW()
WHERE title = '4.1-P1';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Applications',
  sub_topic_id = '4.1',
  section_id = '4.1',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 75,
  skill_tags = ARRAY['SKILL_UNITS_IN_CONTEXT','SKILL_INTERPRET_DERIVATIVE_CONTEXT'],
  primary_skill_id = 'SKILL_UNITS_IN_CONTEXT',
  supporting_skill_ids = ARRAY['SKILL_INTERPRET_DERIVATIVE_CONTEXT'],

  error_tags = ARRAY['ERR_IGNORE_UNITS','ERR_AVG_INSTEAD_OF_INST'],
  prompt = 'The amount of salt in a tank is $S(t)$ grams, where $t$ is measured in minutes. Which set of units is correct for $S''(t)$?',
  latex = 'The amount of salt in a tank is $S(t)$ grams, where $t$ is measured in minutes. Which set of units is correct for $S''(t)$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','grams','explanation','That would be $S(t)$, not $S''(t)$.'),
    jsonb_build_object('id','B','text','minutes','explanation','Time alone is not a rate.'),
    jsonb_build_object('id','C','text','minutes per gram','explanation','That is the inverse rate ($dt/dS$).'),
    jsonb_build_object('id','D','text','grams per minute','explanation','Correct: change in grams per minute.')
  ),
  correct_option_id = 'D',
  tolerance = 0.0010,
  explanation = '$S''(t)$ is the rate of change of salt amount (grams) with respect to time (minutes), so its units are grams per minute.',
  recommendation_reasons = ARRAY['Builds fast unit reasoning for derivatives in applied settings.','Prevents swapping/inverting rate units.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Quick unit check; no computation required.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Applications',
  updated_at = NOW()
WHERE title = '4.1-P2';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Applications',
  sub_topic_id = '4.1',
  section_id = '4.1',
  type = 'MCQ',
  calculator_allowed = TRUE,
  difficulty = 4,
  target_time_seconds = 120,
  skill_tags = ARRAY['SKILL_READ_GRAPH_SLOPE','SKILL_INSTANT_RATE_OF_CHANGE','SKILL_UNITS_IN_CONTEXT'],
  primary_skill_id = 'SKILL_READ_GRAPH_SLOPE',
  supporting_skill_ids = ARRAY['SKILL_INSTANT_RATE_OF_CHANGE', 'SKILL_UNITS_IN_CONTEXT'],
 'SKILL_UNITS_IN_CONTEXT'],'SKILL_UNITS_IN_CONTEXT'],
  error_tags = ARRAY['ERR_SLOPE_INVERTED','ERR_AVG_INSTEAD_OF_INST','ERR_IGNORE_UNITS'],
  prompt = 'Refer to the graph. The temperature $T$ of a chemical bath (in $^\\circ\\!\\text{C}$) is shown as a function of time $t$ (in hours). A tangent line is drawn at $t=3$. Which value best estimates $T''(3)$?',
  latex = 'Refer to the graph. The temperature $T$ of a chemical bath (in $^\\circ\\!\\text{C}$) is shown as a function of time $t$ (in hours). A tangent line is drawn at $t=3$. Which value best estimates $T''(3)$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','About $1.0\\ ^\\circ\\!\\text{C}/\\text{hour}$','explanation','Correct: matches the tangent line slope and has the correct sign.'),
    jsonb_build_object('id','B','text','About $0.1\\ ^\\circ\\!\\text{C}/\\text{hour}$','explanation','Too small for the tangent''s rise/run.'),
    jsonb_build_object('id','C','text','About $10\\ ^\\circ\\!\\text{C}/\\text{hour}$','explanation','Too large; would require a much steeper tangent.'),
    jsonb_build_object('id','D','text','About $-1.0\\ ^\\circ\\!\\text{C}/\\text{hour}$','explanation','Wrong sign; the tangent rises to the right.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'The derivative at $t=3$ is the slope of the tangent line. From the drawn tangent, the rise is roughly $1.2\\ ^\\circ\\!\\text{C}$ over a run of about $1.2$ hours, giving a slope near $1\\ ^\\circ\\!\\text{C}/\\text{hour}$.',
  recommendation_reasons = ARRAY['Trains estimating instantaneous rate from a tangent line on a graph.','Targets common mistakes: using an average slope or flipping rise/run.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.10,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Graph-based derivative estimation; ensure correct units and sign.',
  weight_primary = 0.65,
  weight_supporting = 0.35,
  prompt_type = 'text_and_image',
  representation_type = 'symbolic',
  topic_id = 'Both_Applications',
  updated_at = NOW()
WHERE title = '4.1-P3';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Applications',
  sub_topic_id = '4.1',
  section_id = '4.1',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 90,
  skill_tags = ARRAY['SKILL_INTERPRET_DERIVATIVE_CONTEXT','SKILL_UNITS_IN_CONTEXT'],
  primary_skill_id = 'SKILL_INTERPRET_DERIVATIVE_CONTEXT',
  supporting_skill_ids = ARRAY['SKILL_UNITS_IN_CONTEXT'],

  error_tags = ARRAY['ERR_INTERPRET_DERIVATIVE_AS_VALUE','ERR_IGNORE_UNITS','ERR_ARITHMETIC'],
  prompt = 'The total cost to produce $x$ items is $C(x)$ dollars. If $C''(50)=12$, which statement best describes what this means?',
  latex = 'The total cost to produce $x$ items is $C(x)$ dollars. If $C''(50)=12$, which statement best describes what this means?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','The cost to produce 50 items is $\\$12$.','explanation','Confuses marginal cost with total cost.'),
    jsonb_build_object('id','B','text','The average cost per item when $x=50$ is $\\$12$.','explanation','Average cost is $C(50)/50$, not $C''(50)$.'),
    jsonb_build_object('id','C','text','When 50 items have been produced, the cost is increasing at about $\\$12$ per additional item.','explanation','Correct: $C''(50)$ is the marginal cost near $x=50$.'),
    jsonb_build_object('id','D','text','When 50 items have been produced, the cost will be $\\$12$ higher after producing 50 more items.','explanation','Misreads the derivative as a multi-item total change.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = '$C''(50)$ is the instantaneous rate of change of cost with respect to number of items at $x=50$. It estimates the marginal cost: producing one more item near 50 increases total cost by about $\\$12$.',
  recommendation_reasons = ARRAY['Reinforces marginal interpretation of derivatives in economics contexts.','Separates average vs marginal reasoning.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Marginal cost interpretation; emphasize units ($\\$ per item).',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Applications',
  updated_at = NOW()
WHERE title = '4.1-P4';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Applications',
  sub_topic_id = '4.1',
  section_id = '4.1',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 1,
  target_time_seconds = 60,
  skill_tags = ARRAY['SKILL_INSTANT_RATE_OF_CHANGE','SKILL_UNITS_IN_CONTEXT'],
  primary_skill_id = 'SKILL_INSTANT_RATE_OF_CHANGE',
  supporting_skill_ids = ARRAY['SKILL_UNITS_IN_CONTEXT'],

  error_tags = ARRAY['ERR_AVG_INSTEAD_OF_INST','ERR_SIGN_MISINTERPRET'],
  prompt = 'A runner''s distance from the start is $s(t)$ miles after $t$ hours. If $s''(2)=6$, which statement must be true?',
  latex = 'A runner''s distance from the start is $s(t)$ miles after $t$ hours. If $s''(2)=6$, which statement must be true?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','The runner traveled 6 miles during the second hour.','explanation','That is a change over an interval, not instantaneous at $t=2$.'),
    jsonb_build_object('id','B','text','The runner''s average speed from $t=0$ to $t=2$ is 6 miles per hour.','explanation','Average speed depends on $s(2)$, not $s''(2)$.'),
    jsonb_build_object('id','C','text','The runner has run 6 miles total by $t=2$.','explanation','Derivative does not give total distance.'),
    jsonb_build_object('id','D','text','At $t=2$, the runner''s instantaneous speed is 6 miles per hour.','explanation','Correct: $s''(2)$ is instantaneous speed at $t=2$.')
  ),
  correct_option_id = 'D',
  tolerance = 0.0010,
  explanation = '$s''(2)$ is the instantaneous rate of change of distance with respect to time at $t=2$, i.e., the instantaneous speed (in miles per hour) at that moment.',
  recommendation_reasons = ARRAY['Separates instantaneous rate from average rate and total change.','Builds correct reading of $s''(t)$ in motion contexts.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 1,
  mastery_weight = 0.90,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Instantaneous vs average vs total; standard AP phrasing.',
  weight_primary = 0.85,
  weight_supporting = 0.15,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Applications',
  updated_at = NOW()
WHERE title = '4.1-P5';



-- Unit 4.2 (Straight-Line Motion: Connecting Position, Velocity, and Acceleration) — Practice 1–5

UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Applications',
  sub_topic_id = '4.2',
  section_id = '4.2',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 105,
  skill_tags = ARRAY['SKILL_MOTION_POSITION_VELOCITY_ACCEL','SKILL_SOLVE_EQUATIONS'],
  primary_skill_id = 'SKILL_MOTION_POSITION_VELOCITY_ACCEL',
  supporting_skill_ids = ARRAY['SKILL_SOLVE_EQUATIONS'],

  error_tags = ARRAY['ERR_CONFUSE_V_AND_A','ERR_ARITHMETIC','ERR_SIGN_MISINTERPRET'],
  prompt = 'A particle moves along a line with position $x(t)=t^3-6t^2+9t$ meters for $0\\le t\\le 4$, where $t$ is in seconds. At which time(s) is the velocity zero?',
  latex = 'A particle moves along a line with position $x(t)=t^3-6t^2+9t$ meters for $0\\le t\\le 4$, where $t$ is in seconds. At which time(s) is the velocity zero?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$t=0$ only','explanation','Velocity is $x''(t)$; here $v(0)=9\\ne 0$.'),
    jsonb_build_object('id','B','text','$t=2$ only','explanation','$v(2)=3(4)-24+9=-3\\ne 0$.'),
    jsonb_build_object('id','C','text','$t=1$ and $t=3$','explanation','Correct: $v(t)=3(t-1)(t-3)$ so zeros are $t=1,3$.'),
    jsonb_build_object('id','D','text','$t=1$ only','explanation','Misses the second root at $t=3$.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'Velocity is $v(t)=x''(t)=3t^2-12t+9=3(t-1)(t-3)$. Thus $v(t)=0$ at $t=1$ and $t=3$, both in $[0,4]$.',
  recommendation_reasons = ARRAY['Connects position to velocity via differentiation.','Checks solving for zeros of velocity and interpreting them as moments of rest.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Derivative to get velocity; solve $v(t)=0$ with factoring.',
  weight_primary = 0.75,
  weight_supporting = 0.25,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Applications',
  updated_at = NOW()
WHERE title = '4.2-P1';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Applications',
  sub_topic_id = '4.2',
  section_id = '4.2',
  type = 'MCQ',
  calculator_allowed = TRUE,
  difficulty = 4,
  target_time_seconds = 120,
  skill_tags = ARRAY['SKILL_READ_GRAPH_SLOPE','SKILL_MOTION_POSITION_VELOCITY_ACCEL'],
  primary_skill_id = 'SKILL_READ_GRAPH_SLOPE',
  supporting_skill_ids = ARRAY['SKILL_MOTION_POSITION_VELOCITY_ACCEL'],

  error_tags = ARRAY['ERR_SLOPE_INVERTED','ERR_AVG_INSTEAD_OF_INST','ERR_SIGN_MISINTERPRET'],
  prompt = 'Refer to the position graph. What is the cart''s velocity at $t=6$ seconds?',
  latex = 'Refer to the position graph. What is the cart''s velocity at $t=6$ seconds?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$-2\\ \\text{m/s}$','explanation','Correct: slope on the segment from $(5,6)$ to $(7,2)$ is $\\frac{2-6}{7-5}=-2$.'),
    jsonb_build_object('id','B','text','$2\\ \\text{m/s}$','explanation','Correct magnitude but wrong sign.'),
    jsonb_build_object('id','C','text','$-4\\ \\text{m/s}$','explanation','Uses rise $-4$ but forgets to divide by run $2$.'),
    jsonb_build_object('id','D','text','$0\\ \\text{m/s}$','explanation','Confuses the flat segment (earlier) with the segment containing $t=6$.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Velocity is the slope of the position graph. At $t=6$, the cart lies on the segment from $(5,6)$ to $(7,2)$, so\n$$v(6)=\\frac{2-6}{7-5}=-2\\ \\text{m/s}.$$',
  recommendation_reasons = ARRAY['Builds reading instantaneous velocity from a position-time graph.','Targets choosing the correct segment and computing slope correctly.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.10,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Graph-based velocity: slope of $x(t)$ at the given time.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text_and_image',
  representation_type = 'symbolic',
  topic_id = 'Both_Applications',
  updated_at = NOW()
WHERE title = '4.2-P2';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Applications',
  sub_topic_id = '4.2',
  section_id = '4.2',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 105,
  skill_tags = ARRAY['SKILL_MOTION_POSITION_VELOCITY_ACCEL','SKILL_INTEGRATE_RATE_TO_CHANGE'],
  primary_skill_id = 'SKILL_MOTION_POSITION_VELOCITY_ACCEL',
  supporting_skill_ids = ARRAY['SKILL_INTEGRATE_RATE_TO_CHANGE'],

  error_tags = ARRAY['ERR_CONFUSE_V_AND_A','ERR_SIGN_MISINTERPRET','ERR_ARITHMETIC'],
  prompt = 'A particle''s velocity is $v(t)=4-0.5t$ meters per second for $0\\le t\\le 6$. If $x(0)=10$ meters, what is $x(6)$?',
  latex = 'A particle''s velocity is $v(t)=4-0.5t$ meters per second for $0\\le t\\le 6$. If $x(0)=10$ meters, what is $x(6)$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$19$','explanation','Too small; typically from subtracting displacement instead of adding to $x(0)$.'),
    jsonb_build_object('id','B','text','$21$','explanation','Arithmetic error when evaluating the integral.'),
    jsonb_build_object('id','C','text','$24$','explanation','Treats velocity as constant at $v(0)=4$.'),
    jsonb_build_object('id','D','text','$25$','explanation','Correct: $x(6)=10+\\int_0^6(4-0.5t)dt=25$.')
  ),
  correct_option_id = 'D',
  tolerance = 0.0010,
  explanation = 'Displacement is the integral of velocity:\n$$x(6)=x(0)+\\int_0^6 (4-0.5t)\\,dt=10+\\left[4t-0.25t^2\\right]_0^6.$$\nCompute $24-9=15$, so $x(6)=10+15=25$.',
  recommendation_reasons = ARRAY['Reinforces $x(b)=x(a)+\\int_a^b v(t)dt$ for straight-line motion.','Builds careful integral evaluation with units.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Position from velocity using definite integrals (accumulated change).',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Applications',
  updated_at = NOW()
WHERE title = '4.2-P3';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Applications',
  sub_topic_id = '4.2',
  section_id = '4.2',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 80,
  skill_tags = ARRAY['SKILL_MOTION_POSITION_VELOCITY_ACCEL','SKILL_SOLVE_EQUATIONS'],
  primary_skill_id = 'SKILL_MOTION_POSITION_VELOCITY_ACCEL',
  supporting_skill_ids = ARRAY['SKILL_SOLVE_EQUATIONS'],

  error_tags = ARRAY['ERR_CONFUSE_V_AND_A','ERR_SIGN_MISINTERPRET'],
  prompt = 'An object''s acceleration is constant at $a(t)=-3\\ \\text{m/s}^2$, and its velocity at $t=0$ is $v(0)=12\\ \\text{m/s}$. When does it first come to rest?',
  latex = 'An object''s acceleration is constant at $a(t)=-3\\ \\text{m/s}^2$, and its velocity at $t=0$ is $v(0)=12\\ \\text{m/s}$. When does it first come to rest?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$t=3$ s','explanation','Would give $v(3)=12-9=3\\ne 0$.'),
    jsonb_build_object('id','B','text','$t=4$ s','explanation','Correct: $v(t)=12-3t$ hits 0 at $t=4$.'),
    jsonb_build_object('id','C','text','$t=6$ s','explanation','Would correspond to a different constant acceleration.'),
    jsonb_build_object('id','D','text','$t=12$ s','explanation','Confuses initial velocity value with time to stop.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'With constant acceleration, velocity is $v(t)=v(0)+at=12-3t$. Set $v(t)=0$:\n$$12-3t=0\\Rightarrow t=4\\ \\text{s}.$$',
  recommendation_reasons = ARRAY['Connects acceleration to velocity in constant-acceleration motion.','Targets mixing up kinematics relationships and sign.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 0.95,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Solve for stopping time using $v(t)=v_0+at$.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Applications',
  updated_at = NOW()
WHERE title = '4.2-P4';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Applications',
  sub_topic_id = '4.2',
  section_id = '4.2',
  type = 'MCQ',
  calculator_allowed = TRUE,
  difficulty = 5,
  target_time_seconds = 135,
  skill_tags = ARRAY['SKILL_READ_GRAPH_SLOPE','SKILL_MOTION_POSITION_VELOCITY_ACCEL','SKILL_UNITS_IN_CONTEXT'],
  primary_skill_id = 'SKILL_READ_GRAPH_SLOPE',
  supporting_skill_ids = ARRAY['SKILL_MOTION_POSITION_VELOCITY_ACCEL', 'SKILL_UNITS_IN_CONTEXT'],
 'SKILL_UNITS_IN_CONTEXT'],'SKILL_UNITS_IN_CONTEXT'],
  error_tags = ARRAY['ERR_CONFUSE_V_AND_A','ERR_SLOPE_INVERTED','ERR_IGNORE_UNITS'],
  prompt = 'Refer to the velocity graph. Which value best represents the drone''s acceleration at $t=2$ seconds?',
  latex = 'Refer to the velocity graph. Which value best represents the drone''s acceleration at $t=2$ seconds?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$-2\\ \\text{m/s}^2$','explanation','Wrong sign; velocity increases so slope is positive.'),
    jsonb_build_object('id','B','text','$0.75\\ \\text{m/s}^2$','explanation','Half the correct constant slope.'),
    jsonb_build_object('id','C','text','$1.5\\ \\text{m/s}^2$','explanation','Correct: slope $\\frac{10-(-2)}{8-0}=\\frac{12}{8}=1.5$.'),
    jsonb_build_object('id','D','text','$3\\ \\text{m/s}^2$','explanation','Double the correct slope.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'Acceleration is the slope of the velocity graph. The graph is a straight line, so acceleration is constant:\n$$a=\\frac{10-(-2)}{8-0}=\\frac{12}{8}=1.5\\ \\text{m/s}^2.$$',
  recommendation_reasons = ARRAY['Differentiates velocity vs acceleration via graph slope.','Targets common slope mistakes and unit errors.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 5,
  mastery_weight = 1.20,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Acceleration from $v(t)$ graph: constant slope with units $\\text{m/s}^2$.',
  weight_primary = 0.65,
  weight_supporting = 0.35,
  prompt_type = 'text_and_image',
  representation_type = 'symbolic',
  topic_id = 'Both_Applications',
  updated_at = NOW()
WHERE title = '4.2-P5';

END $block$;
