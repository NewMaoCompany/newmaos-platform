-- Unit 4.3 & 4.4 SQL Update Script
-- Wrapped in a DO block to ensure atomic execution and prevent syntax errors at EOF.

DO $block$
BEGIN

-- Unit 4.3 (Rates of Change in Applied Contexts other than Motion) — Practice 1–5

UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Applications',
  sub_topic_id = '4.3',
  section_id = '4.3',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 90,
  skill_tags = ARRAY['SK_INTERPRET_ROC_CONTEXT','SK_UNITS_SIGN'],
  primary_skill_id = 'SK_INTERPRET_ROC_CONTEXT',
  supporting_skill_ids = ARRAY['SK_UNITS_SIGN'],

  error_tags = ARRAY['E_UNITS','E_SIGN','E_NOTATION_VALUE_VS_RATE'],
  prompt = 'A company’s profit (in thousands of dollars) from selling $x$ units is $P(x)=120-0.02(x-3000)^2$. What is the best interpretation of $P''(2500)$?',
  latex = 'A company’s profit (in thousands of dollars) from selling $x$ units is $P(x)=120-0.02(x-3000)^2$. What is the best interpretation of $P''(2500)$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','At $x=2500$, profit is increasing at about $20$ thousand dollars per additional unit sold.','explanation','Correct: $P''(x)=-0.04(x-3000)$ so $P''(2500)=20$. Units: thousand dollars per unit.'),
    jsonb_build_object('id','B','text','At $x=2500$, profit is decreasing at about $20$ thousand dollars per additional unit sold.','explanation','Sign error: $P''(2500)=20>0$, so profit is increasing near $x=2500$.'),
    jsonb_build_object('id','C','text','At $x=2500$, profit is $20$ thousand dollars.','explanation','Confuses derivative with function value; $P''(2500)$ is a rate, not a profit amount.'),
    jsonb_build_object('id','D','text','At $x=2500$, selling one more unit makes profit increase by $20$ dollars.','explanation','Unit error: the model is in thousands of dollars, so the rate is thousand dollars per unit.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Differentiate: $P''(x)=-0.04(x-3000)$. Then $P''(2500)=-0.04(-500)=20$. So near $x=2500$, each additional unit sold increases profit by about $20$ thousand dollars.',
  recommendation_reasons = ARRAY['Trains interpretation of a derivative value as a contextual rate with correct units.','Targets common sign and unit mistakes.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: interpret $P''(x)$ with correct units (thousands of dollars per unit) and sign.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Applications',
  updated_at = NOW()
WHERE title = '4.3-P1';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Applications',
  sub_topic_id = '4.3',
  section_id = '4.3',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 120,
  skill_tags = ARRAY['SK_CHAIN_RULE_CONTEXT','SK_INTERPRET_ROC_CONTEXT'],
  primary_skill_id = 'SK_CHAIN_RULE_CONTEXT',
  supporting_skill_ids = ARRAY['SK_INTERPRET_ROC_CONTEXT'],

  error_tags = ARRAY['E_CHAIN_RULE','E_UNITS','E_NOTATION_VALUE_VS_RATE'],
  prompt = 'The radius of a spherical balloon is increasing at $\dfrac{dr}{dt}=0.2\ \mathrm{cm/s}$. At the instant when $r=10\ \mathrm{cm}$, what is $\dfrac{dV}{dt}$ for the balloon’s volume $V$?',
  latex = 'The radius of a spherical balloon is increasing at $\dfrac{dr}{dt}=0.2\ \mathrm{cm/s}$. At the instant when $r=10\ \mathrm{cm}$, what is $\dfrac{dV}{dt}$ for the balloon’s volume $V$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\dfrac{dV}{dt}=\dfrac{4}{3}\pi(10)^3(0.2)$','explanation','Uses $V\cdot \dfrac{dr}{dt}$ instead of $\dfrac{dV}{dr}\cdot\dfrac{dr}{dt}$.'),
    jsonb_build_object('id','B','text','$\dfrac{dV}{dt}=4\pi(10)^2(0.2)=80\pi\ \mathrm{cm^3/s}$','explanation','Correct: $\dfrac{dV}{dt}=4\pi r^2\dfrac{dr}{dt}$; substitute $r=10$, $\dfrac{dr}{dt}=0.2$.'),
    jsonb_build_object('id','C','text','$\dfrac{dV}{dt}=4\pi(10)(0.2)=8\pi\ \mathrm{cm^3/s}$','explanation','Power rule error: $\dfrac{d}{dr}(r^3)=3r^2$, not $r$.'),
    jsonb_build_object('id','D','text','$\dfrac{dV}{dt}=\dfrac{4}{3}\pi(10)^3=\dfrac{4000}{3}\pi\ \mathrm{cm^3/s}$','explanation','That is the volume $V$ (in $\mathrm{cm^3}$), not a rate.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'With $V=\dfrac{4}{3}\pi r^3$, we have $\dfrac{dV}{dt}=4\pi r^2\dfrac{dr}{dt}$. At $r=10$ and $\dfrac{dr}{dt}=0.2$, $\dfrac{dV}{dt}=4\pi(100)(0.2)=80\pi\ \mathrm{cm^3/s}$.',
  recommendation_reasons = ARRAY['Reinforces chain rule in context for non-motion rates.','Targets unit awareness for volume rates.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.20,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: chain rule for volume rate from radius rate.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Applications',
  updated_at = NOW()
WHERE title = '4.3-P2';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Applications',
  sub_topic_id = '4.3',
  section_id = '4.3',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 150,
  skill_tags = ARRAY['SK_EXP_DIFF','SK_INTERPRET_ROC_CONTEXT'],
  primary_skill_id = 'SK_EXP_DIFF',
  supporting_skill_ids = ARRAY['SK_INTERPRET_ROC_CONTEXT'],

  error_tags = ARRAY['E_CHAIN_RULE','E_AVG_VS_INST','E_RATE_CONVERSION'],
  prompt = 'A bacterial population is modeled by $N(t)=800e^{0.18t}$ where $t$ is in hours. At $t=5$, which expression gives the instantaneous growth rate $N''(5)$ (in bacteria per hour)?',
  latex = 'A bacterial population is modeled by $N(t)=800e^{0.18t}$ where $t$ is in hours. At $t=5$, which expression gives the instantaneous growth rate $N''(5)$ (in bacteria per hour)?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$800e^{0.18\cdot 5}$','explanation','That is $N(5)$, not $N''(5)$.'),
    jsonb_build_object('id','B','text','$\dfrac{N(6)-N(5)}{1}$','explanation','That is an average rate on $[5,6]$, not instantaneous at $t=5$.'),
    jsonb_build_object('id','C','text','$0.18\cdot 5\cdot 800e^{0.18\cdot 5}$','explanation','Incorrectly multiplies by $t$; chain rule uses the constant $0.18$.'),
    jsonb_build_object('id','D','text','$0.18\cdot 800e^{0.18\cdot 5}$','explanation','Correct: $N''(t)=800(0.18)e^{0.18t}$; substitute $t=5$.')
  ),
  correct_option_id = 'D',
  tolerance = 0.0010,
  explanation = 'Differentiate: $N''(t)=800\cdot 0.18\,e^{0.18t}$. Therefore $N''(5)=0.18\cdot 800e^{0.9}$ bacteria per hour.',
  recommendation_reasons = ARRAY['Checks exponential differentiation with correct chain rule factor.','Distinguishes instantaneous from average rate.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.30,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: derivative of of an exponential model and interpretation as instantaneous growth rate.',
  weight_primary = 0.85,
  weight_supporting = 0.15,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Applications',
  updated_at = NOW()
WHERE title = '4.3-P3';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Applications',
  sub_topic_id = '4.3',
  section_id = '4.3',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 1,
  target_time_seconds = 75,
  skill_tags = ARRAY['SK_TABLE_DERIV_EST','SK_UNITS_SIGN'],
  primary_skill_id = 'SK_TABLE_DERIV_EST',
  supporting_skill_ids = ARRAY['SK_UNITS_SIGN'],

  error_tags = ARRAY['E_AVG_VS_INST','E_UNITS','E_SIGN'],
  prompt = 'Let $C(t)$ be the concentration of a chemical (in $\mathrm{mg/L}$) in a tank at time $t$ minutes. The table gives values near $t=4$.\n\n$t$: 3.9, 4.0, 4.1\n\n$C(t)$: 12.4, 12.0, 11.6\n\nWhich is the best estimate of $C''(4)$ (in $\mathrm{mg/(L\cdot min)}$)?',
  latex = 'Let $C(t)$ be the concentration of a chemical (in $\mathrm{mg/L}$) in a tank at time $t$ minutes. The table gives values near $t=4$.\n\n$t$: 3.9, 4.0, 4.1\n\n$C(t)$: 12.4, 12.0, 11.6\n\nWhich is the best estimate of $C''(4)$ (in $\mathrm{mg/(L\cdot min)}$)?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$-4$','explanation','Correct: centered difference $\dfrac{11.6-12.4}{4.1-3.9}=\dfrac{-0.8}{0.2}=-4$.'),
    jsonb_build_object('id','B','text','$-0.4$','explanation','Wrong denominator; uses $2$ instead of $0.2$.'),
    jsonb_build_object('id','C','text','$4$','explanation','Sign error; concentration is decreasing near $t=4$.'),
    jsonb_build_object('id','D','text','$-8$','explanation','Double-counts the change rather than using one centered slope.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Estimate with a centered difference: $\;C''(4)\approx \dfrac{C(4.1)-C(3.9)}{4.1-3.9}=\dfrac{11.6-12.4}{0.2}=-4$.',
  recommendation_reasons = ARRAY['Builds skill estimating derivatives from tables using centered differences.','Targets unit and sign awareness.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 1,
  mastery_weight = 0.90,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: derivative estimation from tabular data (centered difference).',
  weight_primary = 0.75,
  weight_supporting = 0.25,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Applications',
  updated_at = NOW()
WHERE title = '4.3-P4';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Applications',
  sub_topic_id = '4.3',
  section_id = '4.3',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 5,
  target_time_seconds = 180,
  skill_tags = ARRAY['SK_NET_RATE_MODEL','SK_INTERPRET_ROC_CONTEXT'],
  primary_skill_id = 'SK_NET_RATE_MODEL',
  supporting_skill_ids = ARRAY['SK_INTERPRET_ROC_CONTEXT'],

  error_tags = ARRAY['E_RATE_SETUP','E_SIGN','E_RATE_CONVERSION'],
  prompt = 'A tank’s volume $V(t)$ (in liters) changes due to inflow and outflow. Inflow is $8\ \mathrm{L/min}$. Outflow is $2\sqrt{V}\ \mathrm{L/min}$. At the instant when $V=25$, what is $\dfrac{dV}{dt}$?',
  latex = 'A tank’s volume $V(t)$ (in liters) changes due to inflow and outflow. Inflow is $8\ \mathrm{L/min}$. Outflow is $2\sqrt{V}\ \mathrm{L/min}$. At the instant when $V=25$, what is $\dfrac{dV}{dt}$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$-2\ \mathrm{L/min}$','explanation','Correct: $\dfrac{dV}{dt}=8-2\sqrt{25}=8-10=-2$.'),
    jsonb_build_object('id','B','text','$18\ \mathrm{L/min}$','explanation','Adds outflow instead of subtracting; outflow decreases volume.'),
    jsonb_build_object('id','C','text','$2\ \mathrm{L/min}$','explanation','Reverses sign by doing outflow minus inflow.'),
    jsonb_build_object('id','D','text','$0.8\ \mathrm{L/min}$','explanation','Incorrectly divides rates; net rate is a difference, not a ratio.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Net rate is inflow minus outflow: $\dfrac{dV}{dt}=8-2\sqrt{V}$. At $V=25$, $\dfrac{dV}{dt}=8-2\cdot 5=-2\ \mathrm{L/min}$.',
  recommendation_reasons = ARRAY['Reinforces net-rate modeling as inflow minus outflow.','Targets sign conventions in rate problems.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.50,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Uses a diagram; emphasizes net rate as inflow minus outflow and evaluating at a given volume.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text_and_image',
  representation_type = 'symbolic',
  topic_id = 'Both_Applications',
  updated_at = NOW()
WHERE title = '4.3-P5';



-- Unit 4.4 (Introduction to Related Rates) — Practice 1–5

UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Applications',
  sub_topic_id = '4.4',
  section_id = '4.4',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 110,
  skill_tags = ARRAY['SK_RR_GEOMETRY','SK_IMPLICIT_DIFF_T'],
  primary_skill_id = 'SK_RR_GEOMETRY',
  supporting_skill_ids = ARRAY['SK_IMPLICIT_DIFF_T'],

  error_tags = ARRAY['E_CHAIN_RULE','E_SIGN','E_NOTATION_VALUE_VS_RATE'],
  prompt = 'A circle’s radius $r$ is increasing at $\dfrac{dr}{dt}=3\ \mathrm{cm/s}$. What is $\dfrac{dA}{dt}$ when $r=5\ \mathrm{cm}$ for area $A=\pi r^2$?',
  latex = 'A circle’s radius $r$ is increasing at $\dfrac{dr}{dt}=3\ \mathrm{cm/s}$. What is $\dfrac{dA}{dt}$ when $r=5\ \mathrm{cm}$ for area $A=\pi r^2$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$15\pi\ \mathrm{cm^2/s}$','explanation','Misses a factor of $2$: $dA/dt=2\pi r\,dr/dt$.'),
    jsonb_build_object('id','B','text','$30\pi\ \mathrm{cm^2/s}$','explanation','Correct: $dA/dt=2\pi(5)(3)=30\pi$.'),
    jsonb_build_object('id','C','text','$75\pi\ \mathrm{cm^2/s}$','explanation','Uses $\pi r^2(dr/dt)$ instead of differentiating properly.'),
    jsonb_build_object('id','D','text','$3\ \mathrm{cm^2/s}$','explanation','Confuses $dA/dt$ with $dr/dt$.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Differentiate $A=\pi r^2$ with respect to $t$: $\dfrac{dA}{dt}=2\pi r\dfrac{dr}{dt}$. Substitute $r=5$ and $\dfrac{dr}{dt}=3$ to get $\dfrac{dA}{dt}=30\pi\ \mathrm{cm^2/s}$.',
  recommendation_reasons = ARRAY['Introduces the core RR workflow: relate variables, differentiate in time, then substitute.','Targets missing factor-of-2 mistakes.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: differentiate an area formula w.r.t. time and substitute after differentiating.',
  weight_primary = 0.75,
  weight_supporting = 0.25,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Applications',
  updated_at = NOW()
WHERE title = '4.4-P1';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Applications',
  sub_topic_id = '4.4',
  section_id = '4.4',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 140,
  skill_tags = ARRAY['SK_RR_GEOMETRY','SK_IMPLICIT_DIFF_T'],
  primary_skill_id = 'SK_RR_GEOMETRY',
  supporting_skill_ids = ARRAY['SK_IMPLICIT_DIFF_T'],

  error_tags = ARRAY['E_CHAIN_RULE','E_UNITS','E_SIGN'],
  prompt = 'The side length $s$ of a cube is changing at $\dfrac{ds}{dt}=-0.4\ \mathrm{cm/s}$. At the instant when $s=6\ \mathrm{cm}$, what is $\dfrac{dV}{dt}$ for $V=s^3$?',
  latex = 'The side length $s$ of a cube is changing at $\dfrac{ds}{dt}=-0.4\ \mathrm{cm/s}$. At the instant when $s=6\ \mathrm{cm}$, what is $\dfrac{dV}{dt}$ for $V=s^3$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$-7.2\ \mathrm{cm^3/s}$','explanation','Uses $3s$ instead of $3s^2$ in $dV/dt=3s^2\,ds/dt$.'),
    jsonb_build_object('id','B','text','$-43.2\ \mathrm{cm^3/s}$','explanation','Correct: $dV/dt=3(6)^2(-0.4)=-43.2$.'),
    jsonb_build_object('id','C','text','$-86.4\ \mathrm{cm^3/s}$','explanation','Incorrectly multiplies $V$ by $ds/dt$ instead of differentiating.'),
    jsonb_build_object('id','D','text','$0.4\ \mathrm{cm^3/s}$','explanation','Wrong sign and ignores dependence on $s$.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Differentiate $V=s^3$ with respect to $t$: $\dfrac{dV}{dt}=3s^2\dfrac{ds}{dt}$. At $s=6$ and $\dfrac{ds}{dt}=-0.4$, $\dfrac{dV}{dt}=3(36)(-0.4)=-43.2\ \mathrm{cm^3/s}$.',
  recommendation_reasons = ARRAY['Strengthens power-rule + chain-rule reasoning in RR contexts.','Targets common missing-$s$ and sign errors.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.20,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: time differentiation of $V=s^3$ and substitution after differentiating.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Applications',
  updated_at = NOW()
WHERE title = '4.4-P2';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Applications',
  sub_topic_id = '4.4',
  section_id = '4.4',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 170,
  skill_tags = ARRAY['SK_PYTHAG_RR','SK_IMPLICIT_DIFF_T','SK_RR_GEOMETRY'],
  primary_skill_id = 'SK_PYTHAG_RR',
  supporting_skill_ids = ARRAY['SK_IMPLICIT_DIFF_T', 'SK_RR_GEOMETRY'],
 'SK_RR_GEOMETRY'],'SK_RR_GEOMETRY'],
  error_tags = ARRAY['E_SIGN','E_CHAIN_RULE','E_RATIO_INVERT'],
  prompt = 'A $10$-ft ladder leans against a vertical wall. The bottom slides away from the wall at $\dfrac{dx}{dt}=2\ \mathrm{ft/s}$. At the instant when $x=6\ \mathrm{ft}$, what is $\dfrac{dy}{dt}$, where $y$ is the height of the top on the wall?',
  latex = 'A $10$-ft ladder leans against a vertical wall. The bottom slides away from the wall at $\dfrac{dx}{dt}=2\ \mathrm{ft/s}$. At the instant when $x=6\ \mathrm{ft}$, what is $\dfrac{dy}{dt}$, where $y$ is the height of the top on the wall?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$-\dfrac{8}{3}\ \mathrm{ft/s}$','explanation','Inverts the ratio; from $2x\,dx/dt+2y\,dy/dt=0$, $dy/dt=-(x/y)dx/dt$.'),
    jsonb_build_object('id','B','text','$-\dfrac{1}{3}\ \mathrm{ft/s}$','explanation','Does not use the constraint $x^2+y^2=100$ and the correct implicit-differentiation relationship.'),
    jsonb_build_object('id','C','text','$1.5\ \mathrm{ft/s}$','explanation','Magnitude matches, but sign is wrong; the top moves downward so $dy/dt<0$.'),
    jsonb_build_object('id','D','text','$-1.5\ \mathrm{ft/s}$','explanation','Correct: $x^2+y^2=100\Rightarrow dy/dt=-(x/y)dx/dt$. With $x=6$, $y=8$, $dy/dt=-(6/8)\cdot 2=-1.5$.')
  ),
  correct_option_id = 'D',
  tolerance = 0.0010,
  explanation = 'Constraint: $x^2+y^2=100$. Differentiate: $2x\dfrac{dx}{dt}+2y\dfrac{dy}{dt}=0\Rightarrow \dfrac{dy}{dt}=-\dfrac{x}{y}\dfrac{dx}{dt}$. When $x=6$, $y=\sqrt{100-36}=8$, so $\dfrac{dy}{dt}=-(6/8)(2)=-1.5\ \mathrm{ft/s}$.',
  recommendation_reasons = ARRAY['Classic RR setup with Pythagorean constraint.','Targets sign and ratio-inversion errors.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.40,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Diagram-based; emphasizes solving for $y$ before substitution and keeping the sign correct.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text_and_image',
  representation_type = 'symbolic',
  topic_id = 'Both_Applications',
  updated_at = NOW()
WHERE title = '4.4-P3';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Applications',
  sub_topic_id = '4.4',
  section_id = '4.4',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 150,
  skill_tags = ARRAY['SK_IMPLICIT_DIFF_T','SK_PRODUCT_RULE_T'],
  primary_skill_id = 'SK_IMPLICIT_DIFF_T',
  supporting_skill_ids = ARRAY['SK_PRODUCT_RULE_T'],

  error_tags = ARRAY['E_PRODUCT_RULE','E_SIGN','E_AVG_VS_INST'],
  prompt = 'Two variables satisfy $x^2+xy=10$, where $x$ and $y$ are functions of time $t$. If $\dfrac{dx}{dt}=1$ and at the instant $x=2$ and $y=3$, what is $\dfrac{dy}{dt}$?',
  latex = 'Two variables satisfy $x^2+xy=10$, where $x$ and $y$ are functions of time $t$. If $\dfrac{dx}{dt}=1$ and at the instant $x=2$ and $y=3$, what is $\dfrac{dy}{dt}$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$-\dfrac{7}{2}$','explanation','Correct: $2x\,dx/dt + x\,dy/dt + y\,dx/dt=0\Rightarrow 7+2\,dy/dt=0$.'),
    jsonb_build_object('id','B','text','$\dfrac{7}{2}$','explanation','Sign error when solving for $dy/dt$.'),
    jsonb_build_object('id','C','text','$-\dfrac{7}{5}$','explanation','Algebra error; denominator is $x=2$, not $x+y=5$.'),
    jsonb_build_object('id','D','text','$-7$','explanation','Forgets the factor of $x$ multiplying $dy/dt$.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Differentiate: $\dfrac{d}{dt}(x^2)+\dfrac{d}{dt}(xy)=0\Rightarrow 2x\dfrac{dx}{dt}+x\dfrac{dy}{dt}+y\dfrac{dx}{dt}=0$. Substitute $x=2$, $y=3$, $dx/dt=1$: $4+2\,dy/dt+3=0\Rightarrow dy/dt=-7/2$.',
  recommendation_reasons = ARRAY['Builds time-derivative product-rule skill needed for RR problems.','Targets sign and missing-factor mistakes.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: implicit differentiation with respect to time using the product rule.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Applications',
  updated_at = NOW()
WHERE title = '4.4-P4';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Applications',
  sub_topic_id = '4.4',
  section_id = '4.4',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 5,
  target_time_seconds = 180,
  skill_tags = ARRAY['SK_SIMILAR_TRI_RR','SK_RR_GEOMETRY','SK_IMPLICIT_DIFF_T'],
  primary_skill_id = 'SK_SIMILAR_TRI_RR',
  supporting_skill_ids = ARRAY['SK_RR_GEOMETRY', 'SK_IMPLICIT_DIFF_T'],
 'SK_IMPLICIT_DIFF_T'],'SK_IMPLICIT_DIFF_T'],
  error_tags = ARRAY['E_CHAIN_RULE','E_RATE_SETUP','E_RATE_CONVERSION'],
  prompt = 'Water is poured into a cone at a constant rate of $\dfrac{dV}{dt}=6\ \mathrm{cm^3/s}$. The cone has height $12\ \mathrm{cm}$ and radius $4\ \mathrm{cm}$. At the instant when the water depth is $h=3\ \mathrm{cm}$, what is $\dfrac{dh}{dt}$?',
  latex = 'Water is poured into a cone at a constant rate of $\dfrac{dV}{dt}=6\ \mathrm{cm^3/s}$. The cone has height $12\ \mathrm{cm}$ and radius $4\ \mathrm{cm}$. At the instant when the water depth is $h=3\ \mathrm{cm}$, what is $\dfrac{dh}{dt}$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\dfrac{2}{\pi}$','explanation','Algebra error after differentiating; at $h=3$, the coefficient of $dh/dt$ becomes $\pi$, not $3\pi$.'),
    jsonb_build_object('id','B','text','$\dfrac{6}{\pi}$','explanation','Correct: with $r=h/3$, $V=\dfrac{1}{27}\pi h^3$, so $dV/dt=\dfrac{1}{9}\pi h^2\,dh/dt$; at $h=3$ this is $\pi\,dh/dt$.'),
    jsonb_build_object('id','C','text','$\dfrac{6}{\pi(3)^2}$','explanation','Treats the cone like a cylinder with constant radius; $r$ varies with $h$.'),
    jsonb_build_object('id','D','text','$\dfrac{18}{\pi}$','explanation','Uses the correct setup but multiplies by $3$ incorrectly at the end.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Similar triangles give $r/h=4/12=1/3$, so $r=h/3$. Then $V=\dfrac{1}{3}\pi r^2h=\dfrac{1}{3}\pi\left(\dfrac{h}{3}\right)^2h=\dfrac{1}{27}\pi h^3$. Differentiate: $\dfrac{dV}{dt}=\dfrac{1}{9}\pi h^2\dfrac{dh}{dt}$. At $h=3$, $\dfrac{dV}{dt}=\pi\dfrac{dh}{dt}$. With $\dfrac{dV}{dt}=6$, $\dfrac{dh}{dt}=\dfrac{6}{\pi}$.',
  recommendation_reasons = ARRAY['High-frequency RR: eliminate a variable using similar triangles.','Targets the “treat it like a cylinder” error.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 5,
  mastery_weight = 1.60,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Cone RR with similar triangles; substitute after differentiating and then evaluate at $h=3$.',
  weight_primary = 0.65,
  weight_supporting = 0.35,
  prompt_type = 'text_and_image',
  representation_type = 'symbolic',
  topic_id = 'Both_Applications',
  updated_at = NOW()
WHERE title = '4.4-P5';

END $block$;
