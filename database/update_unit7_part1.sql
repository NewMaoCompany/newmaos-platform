-- Unit 7.1 (Modeling Situations with Differential Equations) — Practice 1–5

BEGIN;

UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_DiffEq',
  sub_topic_id = '7.1',
  section_id = '7.1',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 75,
  skill_tags = ARRAY['SK_DE_MODEL_VERBAL','SK_RATE_INTERPRET','SK_ALGEBRA_SIMPLIFY'],
  error_tags = ARRAY['E_UNITS_IGNORED','E_SIGN_ERROR','E_POWER_MISMATCH'],
  prompt = 'A bacteria culture has population $P(t)$ (in thousands) at time $t$ hours. The instantaneous rate of change of the population is proportional to the square root of the population, and the population is increasing. Which differential equation models this situation?

I. $\dfrac{dP}{dt}=k\sqrt{P}$
II. $\dfrac{dP}{dt}=kP^2$
III. $\dfrac{dP}{dt}=-k\sqrt{P}$

Assume $k>0$ is a constant.',
  latex = 'A bacteria culture has population $P(t)$ (in thousands) at time $t$ hours. The instantaneous rate of change of the population is proportional to the square root of the population, and the population is increasing. Which differential equation models this situation?

I. $\dfrac{dP}{dt}=k\sqrt{P}$
II. $\dfrac{dP}{dt}=kP^2$
III. $\dfrac{dP}{dt}=-k\sqrt{P}$

Assume $k>0$ is a constant.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','I only','explanation','Proportional to $\sqrt{P}$ and increasing means $\dfrac{dP}{dt}>0$, so $\dfrac{dP}{dt}=k\sqrt{P}$.'),
    jsonb_build_object('id','B','text','II only','explanation','This is proportional to $P^2$, not $\sqrt{P}$.'),
    jsonb_build_object('id','C','text','III only','explanation','The negative sign would make $\dfrac{dP}{dt}<0$ for $P>0$, contradicting increasing population.'),
    jsonb_build_object('id','D','text','I and II','explanation','II has the wrong dependence on $P$.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = '“Rate is proportional to the square root of the population” translates to $\dfrac{dP}{dt}=k\sqrt{P}$ for some constant $k$. Since the population is increasing, the derivative must be positive, so no negative sign is included. Thus I only.',
  micro_explanations = jsonb_build_object(
    'A','Matches $\sqrt{P}$ and increasing.',
    'B','Wrong power of $P$.',
    'C','Wrong sign (decreasing).',
    'D','Includes an incorrect model.'
  ),
  recommendation_reasons = ARRAY['Translates verbal rate statements into differential equations.','Targets sign and proportionality mismatches.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = '7.1 Focus: translate “proportional to” language into a first-order DE with correct sign.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text',
    primary_skill_id = 'SK_DE_MODEL_VERBAL',
    supporting_skill_ids = ARRAY['SK_RATE_INTERPRET','SK_ALGEBRA_SIMPLIFY'],
  representation_type = 'symbolic',
  topic_id = 'Both_DiffEq',
  updated_at = NOW()
WHERE title = '7.1-P1';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_DiffEq',
  sub_topic_id = '7.1',
  section_id = '7.1',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 105,
  skill_tags = ARRAY['SK_DE_MODEL_VERBAL','SK_UNITS','SK_ALGEBRA_SIMPLIFY'],
  error_tags = ARRAY['E_UNITS_IGNORED','E_SIGN_ERROR','E_SUB_NOT_APPLIED'],
  prompt = 'Let $V(t)$ be the volume of water (in liters) in a tank at time $t$ minutes. Water drains from the tank at a rate proportional to the volume in the tank, and the constant of proportionality is $0.04\ \text{min}^{-1}$. Which differential equation correctly models $V(t)$?',
  latex = 'Let $V(t)$ be the volume of water (in liters) in a tank at time $t$ minutes. Water drains from the tank at a rate proportional to the volume in the tank, and the constant of proportionality is $0.04\ \text{min}^{-1}$. Which differential equation correctly models $V(t)$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\dfrac{dV}{dt}=0.04V$','explanation','This would make volume increase since $V>0$ implies $\dfrac{dV}{dt}>0$.'),
    jsonb_build_object('id','B','text','$\dfrac{dV}{dt}=-0.04V$','explanation','Draining means $V$ decreases; proportional to $V$ gives $\dfrac{dV}{dt}=-0.04V$.'),
    jsonb_build_object('id','C','text','$\dfrac{dV}{dt}=-\dfrac{0.04}{V}$','explanation','This is proportional to $1/V$, not $V$.'),
    jsonb_build_object('id','D','text','$\dfrac{dV}{dt}=-0.04t$','explanation','This makes the rate depend on $t$, not on $V$.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = '“Rate proportional to volume” gives $\dfrac{dV}{dt}=kV$. Draining means $\dfrac{dV}{dt}<0$ for $V>0$, so $k$ must be negative. With magnitude $0.04\ \text{min}^{-1}$, the model is $\dfrac{dV}{dt}=-0.04V$.',
  micro_explanations = jsonb_build_object(
    'A','Wrong sign (increasing).',
    'B','Correct proportionality and sign.',
    'C','Wrong dependence on $V$.',
    'D','Depends on $t$, not $V$.'
  ),
  recommendation_reasons = ARRAY['Reinforces correct sign choice in draining/decay models.','Connects proportionality constant units to the DE form.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = '7.1 Focus: exponential-type rate model with correct sign and units.',
  weight_primary = 0.75,
  weight_supporting = 0.25,
  prompt_type = 'text',
    primary_skill_id = 'SK_DE_MODEL_VERBAL',
    supporting_skill_ids = ARRAY['SK_UNITS','SK_ALGEBRA_SIMPLIFY'],
  representation_type = 'symbolic',
  topic_id = 'Both_DiffEq',
  updated_at = NOW()
WHERE title = '7.1-P2';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_DiffEq',
  sub_topic_id = '7.1',
  section_id = '7.1',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 1,
  target_time_seconds = 60,
  skill_tags = ARRAY['SK_RATE_INTERPRET','SK_UNITS'],
  error_tags = ARRAY['E_SLOPE_CONFUSION','E_SIGN_ERROR','E_UNITS_IGNORED'],
  prompt = 'A quantity $y$ is measured in grams and depends on time $t$ measured in seconds. Which statement best interprets $\dfrac{dy}{dt}=-5$ at $t=12$?',
  latex = 'A quantity $y$ is measured in grams and depends on time $t$ measured in seconds. Which statement best interprets $\dfrac{dy}{dt}=-5$ at $t=12$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','At $t=12$, $y=-5$ grams.','explanation','$\dfrac{dy}{dt}$ is a rate of change, not the value of $y$.'),
    jsonb_build_object('id','B','text','At $t=12$, $y$ is decreasing at $5$ grams per second.','explanation','A negative derivative means decreasing; magnitude $5$ gives the rate.'),
    jsonb_build_object('id','C','text','At $t=12$, $y$ is increasing at $5$ grams per second.','explanation','Sign is wrong: derivative is negative.'),
    jsonb_build_object('id','D','text','At $t=12$, $t$ is decreasing at $5$ seconds per gram.','explanation','This inverts the derivative and swaps variables/units.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = '$\dfrac{dy}{dt}$ gives the instantaneous rate of change of $y$ with respect to $t$. The value $-5$ means $y$ decreases at $5$ grams per second at that instant.',
  micro_explanations = jsonb_build_object(
    'A','Confuses $y$ with $\dfrac{dy}{dt}$.',
    'B','Correct sign and units.',
    'C','Wrong sign.',
    'D','Swaps variables/units.'
  ),
  recommendation_reasons = ARRAY['Locks in derivative-as-rate interpretation with correct units.','Targets the common “value vs rate” confusion.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 1,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = '7.1 Focus: interpret a derivative value in context (direction + units).',
  weight_primary = 0.90,
  weight_supporting = 0.10,
  prompt_type = 'text',
    primary_skill_id = 'SK_RATE_INTERPRET',
    supporting_skill_ids = ARRAY['SK_UNITS'],
  representation_type = 'symbolic',
  topic_id = 'Both_DiffEq',
  updated_at = NOW()
WHERE title = '7.1-P3';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_DiffEq',
  sub_topic_id = '7.1',
  section_id = '7.1',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 135,
  skill_tags = ARRAY['SK_IVP_EVAL_DERIV','SK_DE_MODEL_VERBAL','SK_ALGEBRA_SIMPLIFY'],
  error_tags = ARRAY['E_SUB_NOT_APPLIED','E_SIGN_ERROR','E_ALGEBRA_DISTRIBUTION'],
  prompt = 'A function $y(t)$ satisfies the differential equation
$$\frac{dy}{dt}=3t^2-2y.$$
If $y(1)=4$, what is the value of $\left.\dfrac{dy}{dt}\right|_{t=1}$?',
  latex = 'A function $y(t)$ satisfies the differential equation
$$\frac{dy}{dt}=3t^2-2y.$$
If $y(1)=4$, what is the value of $\left.\dfrac{dy}{dt}\right|_{t=1}$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$-2$','explanation','Substituting gives $3(1)^2-2(4)=3-8=-5$, not $-2$.'),
    jsonb_build_object('id','B','text','$-5$','explanation','Substitute into the DE: $3(1)^2-2(4)=3-8=-5$.'),
    jsonb_build_object('id','C','text','$11$','explanation','This can come from using $+2y$ instead of $-2y$.'),
    jsonb_build_object('id','D','text','$1$','explanation','This confuses $t$ with the derivative value.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'The differential equation gives the derivative in terms of $t$ and $y$. At $t=1$, $y=4$, so
$$\left.\frac{dy}{dt}\right|_{t=1}=3(1)^2-2(4)=3-8=-5.$$',
  micro_explanations = jsonb_build_object(
    'A','Arithmetic/sign slip.',
    'B','Direct substitution into the DE.',
    'C','Sign error on the $-2y$ term.',
    'D','Does not use the equation.'
  ),
  recommendation_reasons = ARRAY['Builds the habit “DE gives slope at a point” using an initial value.','Targets substitution and sign control.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.05,
  source = 'NewMaoS',
  source_year = 2026,
  notes = '7.1 Focus: evaluate $\dfrac{dy}{dt}$ from a DE using a given point.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text',
    primary_skill_id = 'SK_IVP_EVAL_DERIV',
    supporting_skill_ids = ARRAY['SK_DE_MODEL_VERBAL','SK_ALGEBRA_SIMPLIFY'],
  representation_type = 'symbolic',
  topic_id = 'Both_DiffEq',
  updated_at = NOW()
WHERE title = '7.1-P4';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_DiffEq',
  sub_topic_id = '7.1',
  section_id = '7.1',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 110,
  skill_tags = ARRAY['SK_UNITS','SK_DE_MODEL_VERBAL','SK_RATE_INTERPRET'],
  error_tags = ARRAY['E_UNITS_IGNORED','E_SLOPE_CONFUSION','E_SIGN_ERROR'],
  prompt = 'A quantity $y$ is measured in meters and depends on time $t$ in seconds. Suppose $\dfrac{dy}{dt}=ky$ where $k$ is a constant. What are the correct units for $k$?',
  latex = 'A quantity $y$ is measured in meters and depends on time $t$ in seconds. Suppose $\dfrac{dy}{dt}=ky$ where $k$ is a constant. What are the correct units for $k$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','meters','explanation','Units must make $ky$ match units of $\dfrac{dy}{dt}$, not just match $y$.'),
    jsonb_build_object('id','B','text','seconds','explanation','$k$ should not have units of seconds; it must convert meters to meters/second.'),
    jsonb_build_object('id','C','text','$\text{s}^{-1}$','explanation','$\dfrac{dy}{dt}$ has units m/s and $y$ has m, so $k$ must be $1/\text{s}$.'),
    jsonb_build_object('id','D','text','$\text{m}\cdot\text{s}^{-1}$','explanation','That would make $ky$ have units $\text{m}^2/\text{s}$.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'Since $\dfrac{dy}{dt}$ has units $\text{m}/\text{s}$ and $y$ has units $\text{m}$, the constant $k$ must have units $\dfrac{1}{\text{s}}$ so that $ky$ has units $\text{m}/\text{s}$.',
  micro_explanations = jsonb_build_object(
    'A','Ignores matching units of both sides.',
    'B','Uses seconds instead of per second.',
    'C','Correct: $k$ is per second.',
    'D','Creates wrong units.'
  ),
  recommendation_reasons = ARRAY['Strengthens unit-checking for differential equation models.','Prevents common “constant is unitless” assumption.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = '7.1 Focus: determine units of a proportionality constant in $\dfrac{dy}{dt}=ky$.',
  weight_primary = 0.65,
  weight_supporting = 0.35,
  prompt_type = 'text',
    primary_skill_id = 'SK_UNITS',
    supporting_skill_ids = ARRAY['SK_DE_MODEL_VERBAL','SK_RATE_INTERPRET'],
  representation_type = 'symbolic',
  topic_id = 'Both_DiffEq',
  updated_at = NOW()
WHERE title = '7.1-P5';



-- Unit 7.2 (Verifying Solutions for Differential Equations) — Practice 1–5

UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_DiffEq',
  sub_topic_id = '7.2',
  section_id = '7.2',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 95,
  skill_tags = ARRAY['SK_DE_VERIFY','SK_DERIV_RULES','SK_ALGEBRA_SIMPLIFY'],
  error_tags = ARRAY['E_DERIV_MISCOMP','E_SUB_NOT_APPLIED','E_ALGEBRA_DISTRIBUTION'],
  prompt = 'Which function is a solution to the differential equation
$$\frac{dy}{dx}=2x(y-1)$$
for $y(x)$?',
  latex = 'Which function is a solution to the differential equation
$$\frac{dy}{dx}=2x(y-1)$$
for $y(x)$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$y=1+e^{x^2}$','explanation','Then $y''=2xe^{x^2}$ and $2x(y-1)=2x e^{x^2}$, so it works.'),
    jsonb_build_object('id','B','text','$y=1+e^{2x}$','explanation','Then $y''=2e^{2x}$ but $2x(y-1)=2x e^{2x}$; not equal for all $x$.'),
    jsonb_build_object('id','C','text','$y=1+x^2$','explanation','Then $y''=2x$ but $2x(y-1)=2x(x^2)=2x^3$; not equal.'),
    jsonb_build_object('id','D','text','$y=e^{x^2}$','explanation','Then $y''=2xe^{x^2}$ but $2x(y-1)=2x(e^{x^2}-1)$; not equal.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'To verify, compute $y''$ and substitute into the right side. For $y=1+e^{x^2}$, $y''=2xe^{x^2}$ and $2x(y-1)=2x(e^{x^2})=2xe^{x^2}$. The two sides match for all $x$, so it is a solution.',
  micro_explanations = jsonb_build_object(
    'A','Derivative matches RHS exactly.',
    'B','Missing factor of $x$.',
    'C','Creates $2x^3$ on RHS.',
    'D','RHS includes an extra $-2x$ term.'
  ),
  recommendation_reasons = ARRAY['Practices verify-by-substitution using derivative computation.','Targets common mismatch between $y-1$ and $y$.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = '7.2 Focus: verify a proposed solution by differentiating and substituting.',
  weight_primary = 0.75,
  weight_supporting = 0.25,
  prompt_type = 'text',
    primary_skill_id = 'SK_DE_VERIFY',
    supporting_skill_ids = ARRAY['SK_DERIV_RULES','SK_ALGEBRA_SIMPLIFY'],
  representation_type = 'symbolic',
  topic_id = 'Both_DiffEq',
  updated_at = NOW()
WHERE title = '7.2-P1';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_DiffEq',
  sub_topic_id = '7.2',
  section_id = '7.2',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 120,
  skill_tags = ARRAY['SK_DE_VERIFY','SK_IVP_CHECK','SK_ALGEBRA_SIMPLIFY'],
  error_tags = ARRAY['E_SUB_NOT_APPLIED','E_SIGN_ERROR','E_CONSTANT_MISUSE'],
  prompt = 'A function $y(x)$ is claimed to solve
$$\frac{dy}{dx}=\frac{y}{x}$$
with initial condition $y(2)=6$. Which of the following functions satisfies BOTH the differential equation and the initial condition (for $x>0$)?',
  latex = 'A function $y(x)$ is claimed to solve
$$\frac{dy}{dx}=\frac{y}{x}$$
with initial condition $y(2)=6$. Which of the following functions satisfies BOTH the differential equation and the initial condition (for $x>0$)?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$y=3x$','explanation','$y''=3$ and $y/x=3$, and $y(2)=6$; works.'),
    jsonb_build_object('id','B','text','$y=\dfrac{6}{x}$','explanation','$y''=-\dfrac{6}{x^2}$ but $y/x=\dfrac{6}{x^2}$; sign mismatch.'),
    jsonb_build_object('id','C','text','$y=6x$','explanation','DE holds, but $y(2)=12\ne 6$.'),
    jsonb_build_object('id','D','text','$y=3x^2$','explanation','$y''=6x$ but $y/x=3x$; not equal.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Check each candidate. For $y=3x$, $y''=3$ and $\dfrac{y}{x}=3$, so it satisfies the DE. Also $y(2)=3\cdot 2=6$, so it satisfies the initial condition.',
  micro_explanations = jsonb_build_object(
    'A','Satisfies DE and $y(2)=6$.',
    'B','Derivative sign does not match $\dfrac{y}{x}$.',
    'C','Fails the initial condition.',
    'D','Fails the DE.'
  ),
  recommendation_reasons = ARRAY['Combines DE verification with initial-condition checking.','Targets sign errors when differentiating $1/x$ forms.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.05,
  source = 'NewMaoS',
  source_year = 2026,
  notes = '7.2 Focus: verify solution AND satisfy an initial condition (two filters).',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text',
    primary_skill_id = 'SK_DE_VERIFY',
    supporting_skill_ids = ARRAY['SK_IVP_CHECK','SK_ALGEBRA_SIMPLIFY'],
  representation_type = 'symbolic',
  topic_id = 'Both_DiffEq',
  updated_at = NOW()
WHERE title = '7.2-P2';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_DiffEq',
  sub_topic_id = '7.2',
  section_id = '7.2',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 150,
  skill_tags = ARRAY['SK_DE_VERIFY','SK_DERIV_RULES','SK_CHAIN_RULE'],
  error_tags = ARRAY['E_CHAIN_RULE_OMIT','E_DERIV_MISCOMP','E_SUB_NOT_APPLIED'],
  prompt = 'Let $y(x)=\ln(x^2+1)$. Does $y$ satisfy the differential equation
$$\frac{dy}{dx}=\frac{2x}{x^2+1}?$$',
  latex = 'Let $y(x)=\ln(x^2+1)$. Does $y$ satisfy the differential equation
$$\frac{dy}{dx}=\frac{2x}{x^2+1}?$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','No, because $\dfrac{dy}{dx}=\dfrac{1}{x^2+1}$.','explanation','Derivative is missing the chain rule factor $2x$.'),
    jsonb_build_object('id','B','text','No, because $\dfrac{dy}{dx}=\dfrac{2}{x^2+1}$.','explanation','Still missing the factor of $x$ from the chain rule.'),
    jsonb_build_object('id','C','text','Yes, because $\dfrac{dy}{dx}=\dfrac{2x}{x^2+1}$.','explanation','Using chain rule: derivative of $\ln(u)$ is $u''/u$ with $u=x^2+1$.'),
    jsonb_build_object('id','D','text','Yes, because $\dfrac{dy}{dx}=\dfrac{x^2+1}{2x}$.','explanation','This inverts the derivative.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'Differentiate $y=\ln(x^2+1)$ using the chain rule. Let $u=x^2+1$, so $u''=2x$. Then
$$\frac{dy}{dx}=\frac{u''}{u}=\frac{2x}{x^2+1},$$
which matches the differential equation. So the answer is yes.',
  micro_explanations = jsonb_build_object(
    'A','Chain rule factor omitted.',
    'B','Still missing factor $x$.',
    'C','Correct chain rule computation.',
    'D','Inverts the derivative.'
  ),
  recommendation_reasons = ARRAY['Targets the most common verification pitfall: missing chain rule in log derivatives.','Reinforces match-the-RHS verification.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.10,
  source = 'NewMaoS',
  source_year = 2026,
  notes = '7.2 Focus: verification with correct chain rule differentiation.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text',
    primary_skill_id = 'SK_DE_VERIFY',
    supporting_skill_ids = ARRAY['SK_DERIV_RULES','SK_CHAIN_RULE'],
  representation_type = 'symbolic',
  topic_id = 'Both_DiffEq',
  updated_at = NOW()
WHERE title = '7.2-P3';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_DiffEq',
  sub_topic_id = '7.2',
  section_id = '7.2',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 90,
  skill_tags = ARRAY['SK_DE_VERIFY','SK_DERIV_RULES'],
  error_tags = ARRAY['E_SUB_NOT_APPLIED','E_DERIV_MISCOMP','E_DOMAIN_IGNORED'],
  prompt = 'A student claims that $y=x^2-1$ is a solution to
$$\frac{dy}{dx}=2x.$$
Which statement is correct?',
  latex = 'A student claims that $y=x^2-1$ is a solution to
$$\frac{dy}{dx}=2x.$$
Which statement is correct?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','Not a solution, because $y$ is negative when $x=0$.','explanation','The sign/value of $y$ is irrelevant; only $y''$ must match the DE.'),
    jsonb_build_object('id','B','text','Not a solution, because $\dfrac{dy}{dx}=x$.','explanation','Derivative of $x^2-1$ is $2x$, not $x$.'),
    jsonb_build_object('id','C','text','It is a solution, because $\dfrac{dy}{dx}=2x$.','explanation','Differentiate: $(x^2-1)''=2x$, which matches the DE.'),
    jsonb_build_object('id','D','text','It is a solution only for $x\ge 0$.','explanation','The equality $y''=2x$ holds for all real $x$.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'To verify, compute $y''$. For $y=x^2-1$, $y''=2x$, which matches the right-hand side exactly, so it is a solution for all real $x$.',
  micro_explanations = jsonb_build_object(
    'A','Verification depends on $y''$, not the sign of $y$.',
    'B','Derivative is miscomputed.',
    'C','Correct verification.',
    'D','No domain restriction is needed here.'
  ),
  recommendation_reasons = ARRAY['Reinforces that adding constants does not change $y'' in verification.','Prevents irrelevant “value of y” arguments.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 1,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = '7.2 Focus: basic verification and the role of additive constants.',
  weight_primary = 0.85,
  weight_supporting = 0.15,
  prompt_type = 'text',
    primary_skill_id = 'SK_DE_VERIFY',
    supporting_skill_ids = ARRAY['SK_DERIV_RULES'],
  representation_type = 'symbolic',
  topic_id = 'Both_DiffEq',
  updated_at = NOW()
WHERE title = '7.2-P4';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_DiffEq',
  sub_topic_id = '7.2',
  section_id = '7.2',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 5,
  target_time_seconds = 180,
  skill_tags = ARRAY['SK_DE_VERIFY','SK_DERIV_RULES','SK_ALGEBRA_SIMPLIFY','SK_DOMAIN'],
  error_tags = ARRAY['E_DERIV_MISCOMP','E_DOMAIN_IGNORED','E_SUB_NOT_APPLIED'],
  prompt = 'Consider the differential equation (for $x>0$)
$$x\frac{dy}{dx}+y=\sqrt{x}.$$
Which function satisfies the equation for $x>0$?',
  latex = 'Consider the differential equation (for $x>0$)
$$x\frac{dy}{dx}+y=\sqrt{x}.$$
Which function satisfies the equation for $x>0$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$y=\sqrt{x}$','explanation','$y''=\dfrac{1}{2\sqrt{x}}$, so $xy''+y=\dfrac{\sqrt{x}}{2}+\sqrt{x}=\dfrac{3\sqrt{x}}{2}\ne\sqrt{x}$.'),
    jsonb_build_object('id','B','text','$y=\dfrac{1}{\sqrt{x}}$','explanation','$y''=-\dfrac{1}{2x^{3/2}}$, so $xy''+y=-\dfrac{1}{2\sqrt{x}}+\dfrac{1}{\sqrt{x}}=\dfrac{1}{2\sqrt{x}}\ne\sqrt{x}$.'),
    jsonb_build_object('id','C','text','$y=\dfrac{2}{3}\sqrt{x}$','explanation','$y''=\dfrac{1}{3\sqrt{x}}$, so $xy''+y=\dfrac{\sqrt{x}}{3}+\dfrac{2\sqrt{x}}{3}=\sqrt{x}$.'),
    jsonb_build_object('id','D','text','$y=\dfrac{2}{3}x$','explanation','$y''=\dfrac{2}{3}$, so $xy''+y=\dfrac{2}{3}x+\dfrac{2}{3}x=\dfrac{4}{3}x\ne\sqrt{x}$.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'Verify by substitution. For $y=\dfrac{2}{3}\sqrt{x}$, we have $y''=\dfrac{1}{3\sqrt{x}}$ (for $x>0$). Then
$$x\frac{dy}{dx}+y=x\left(\frac{1}{3\sqrt{x}}\right)+\frac{2}{3}\sqrt{x}=\frac{\sqrt{x}}{3}+\frac{2\sqrt{x}}{3}=\sqrt{x},$$
so it satisfies the differential equation on $x>0$.',
  micro_explanations = jsonb_build_object(
    'A','Produces $\tfrac{3}{2}\sqrt{x}$, not $\sqrt{x}$.',
    'B','Produces $\tfrac{1}{2\sqrt{x}}$, not $\sqrt{x}$.',
    'C','Matches exactly after substitution.',
    'D','Left side becomes proportional to $x$.'
  ),
  recommendation_reasons = ARRAY['AP-style verification with $xy''+y$ structure and domain $x>0$.','Stresses careful differentiation of $\sqrt{x}$.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.20,
  source = 'NewMaoS',
  source_year = 2026,
  notes = '7.2 Focus: verify solution for a first-order linear form with a domain restriction.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text',
    primary_skill_id = 'SK_DE_VERIFY',
    supporting_skill_ids = ARRAY['SK_DERIV_RULES','SK_ALGEBRA_SIMPLIFY','SK_DOMAIN'],
  representation_type = 'symbolic',
  topic_id = 'Both_DiffEq',
  updated_at = NOW()
WHERE title = '7.2-P5';


COMMIT;

-- Unit 7.3 (Sketching Slope Fields) — Practice 1–5

UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_DiffEq',
  sub_topic_id = '7.3',
  section_id = '7.3',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 90,
  skill_tags = ARRAY['SK_SLOPE_FIELD_SKETCH', 'SK_EVAL_DYDX_POINT', 'SK_ALGEBRA_FLUENCY'],
  error_tags = ARRAY['E_ALGEBRA_ERROR', 'E_SIGN_ERROR'],
  prompt = 'For the differential equation $\dfrac{dy}{dx}=\dfrac{x+y}{2}$, what is the slope of the small line segment you would draw at the point $(2,-1)$ when sketching a slope field?',
  latex = 'For the differential equation $\dfrac{dy}{dx}=\dfrac{x+y}{2}$, what is the slope of the small line segment you would draw at the point $(2,-1)$ when sketching a slope field?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$-\dfrac{1}{2}$','explanation','This would come from an incorrect substitution or arithmetic error when evaluating $\dfrac{x+y}{2}$.'),
    jsonb_build_object('id','B','text','$\dfrac{1}{2}$','explanation','Substitute $(x,y)=(2,-1)$: $\dfrac{x+y}{2}=\dfrac{2-1}{2}=\dfrac{1}{2}$.'),
    jsonb_build_object('id','C','text','$1$','explanation','This is $x+y$ without dividing by $2$.'),
    jsonb_build_object('id','D','text','$\dfrac{3}{2}$','explanation','This comes from using $2+1$ instead of $2+(-1)$.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Evaluate the right-hand side at $(2,-1)$:
$$\frac{dy}{dx}=\frac{2+(-1)}{2}=\frac{1}{2}.$$',
  recommendation_reasons = ARRAY['Reinforces evaluating $\frac{dy}{dx}$ at a point before drawing a segment.','Targets substitution and sign mistakes in slope-field setup.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: compute the local slope from the differential equation at a given point.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
    primary_skill_id = 'SK_SLOPE_FIELD_SKETCH',
  supporting_skill_ids = ARRAY['SK_EVAL_DYDX_POINT','SK_ALGEBRA_FLUENCY'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_DiffEq',
  updated_at = NOW()
WHERE title = '7.3-P1';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_DiffEq',
  sub_topic_id = '7.3',
  section_id = '7.3',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 110,
  skill_tags = ARRAY['SK_SLOPE_FIELD_READ'],
  error_tags = ARRAY['E_SLOPEFIELD_READ_ERROR', 'E_CONFUSE_FIELD_VS_SOLUTION'],
  prompt = 'Use the accompanying slope field (image). At the point $(1,0)$, which value best matches the slope $\dfrac{dy}{dx}$ indicated by the field?',
  latex = 'Use the accompanying slope field (image). At the point $(1,0)$, which value best matches the slope $\dfrac{dy}{dx}$ indicated by the field?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$-1$','explanation','This would match a clearly downward segment at $(1,0)$, which is not shown.'),
    jsonb_build_object('id','B','text','$0$','explanation','A slope of $0$ would be horizontal, but the segment at $(1,0)$ tilts upward.'),
    jsonb_build_object('id','C','text','$\dfrac{1}{2}$','explanation','This is too shallow compared to the segment shown at $(1,0)$.'),
    jsonb_build_object('id','D','text','$1$','explanation','The segment rises about as much as it runs, consistent with slope near $1$.')
  ),
  correct_option_id = 'D',
  tolerance = 0.0010,
  explanation = 'Reading the segment at $(1,0)$, the local tilt is closest to slope $1$.',
  recommendation_reasons = ARRAY['Builds accuracy reading slope fields at specific points.','Targets the mistake of reading a solution curve instead of the local direction segment.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Image-based: read a local slope from a direction field at a point.',
  weight_primary = 1.00,
  weight_supporting = 0.00,
    primary_skill_id = 'SK_SLOPE_FIELD_READ',
  supporting_skill_ids = ARRAY[]::text[],
  prompt_type = 'text_and_image',
  representation_type = 'symbolic',
  topic_id = 'Both_DiffEq',
  updated_at = NOW()
WHERE title = '7.3-P2';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_DiffEq',
  sub_topic_id = '7.3',
  section_id = '7.3',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 140,
  skill_tags = ARRAY['SK_ISOCLINE_ANALYSIS', 'SK_SLOPE_FIELD_SKETCH'],
  error_tags = ARRAY['E_IGNORE_ISOCLINE', 'E_SLOPEFIELD_READ_ERROR'],
  prompt = 'A slope field has horizontal (zero-slope) segments along the line $y=x$. Below that line (where $y<x$), the segments tilt upward (positive slope). Above that line (where $y>x$), the segments tilt downward (negative slope). Which differential equation matches this slope field?',
  latex = 'A slope field has horizontal (zero-slope) segments along the line $y=x$. Below that line (where $y<x$), the segments tilt upward (positive slope). Above that line (where $y>x$), the segments tilt downward (negative slope). Which differential equation matches this slope field?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\dfrac{dy}{dx}=x-y$','explanation','On $y=x$, $x-y=0$. If $y<x$, then $x-y>0$; if $y>x$, then $x-y<0$.'),
    jsonb_build_object('id','B','text','$\dfrac{dy}{dx}=y-x$','explanation','This has the opposite sign pattern: negative below $y=x$ and positive above.'),
    jsonb_build_object('id','C','text','$\dfrac{dy}{dx}=x+y$','explanation','Zero slope would occur on $y=-x$, not $y=x$.'),
    jsonb_build_object('id','D','text','$\dfrac{dy}{dx}=xy$','explanation','Zero slope would occur on $x=0$ or $y=0$, not along $y=x$.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'The described sign pattern is: slope $0$ on $y=x$, positive when $y<x$, and negative when $y>x$. The expression $x-y$ has exactly this behavior.',
  recommendation_reasons = ARRAY['Connects slope-field sign patterns to the differential equation.','Reinforces isoclines as curves where $\frac{dy}{dx}$ is constant.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.20,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: identify a differential equation from an isocline and sign description.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
    primary_skill_id = 'SK_ISOCLINE_ANALYSIS',
  supporting_skill_ids = ARRAY['SK_SLOPE_FIELD_SKETCH'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_DiffEq',
  updated_at = NOW()
WHERE title = '7.3-P3';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_DiffEq',
  sub_topic_id = '7.3',
  section_id = '7.3',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 95,
  skill_tags = ARRAY['SK_ISOCLINE_ANALYSIS', 'SK_SLOPE_FIELD_SKETCH'],
  error_tags = ARRAY['E_IGNORE_ISOCLINE', 'E_ALGEBRA_ERROR'],
  prompt = 'For $\dfrac{dy}{dx}=y^2-1$, along which curves in the $xy$-plane will the slope-field segments be horizontal?',
  latex = 'For $\dfrac{dy}{dx}=y^2-1$, along which curves in the $xy$-plane will the slope-field segments be horizontal?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$y=0$ only','explanation','At $y=0$, $y^2-1=-1$, not $0$.'),
    jsonb_build_object('id','B','text','$y=1$ only','explanation','At $y=1$ the slope is $0$, but $y=-1$ also makes the slope $0$.'),
    jsonb_build_object('id','C','text','$y=1$ and $y=-1$','explanation','Set $y^2-1=0\Rightarrow y=\pm 1$.'),
    jsonb_build_object('id','D','text','$y=x$','explanation','The slope depends only on $y$, so the zero-slope curves are horizontal lines, not $y=x$.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'Horizontal segments occur where $\frac{dy}{dx}=0$:
$$y^2-1=0\Rightarrow y^2=1\Rightarrow y=\pm 1.$$',
  recommendation_reasons = ARRAY['Reinforces that isoclines come from setting the RHS equal to a constant.','Targets missing the $\pm$ when solving $y^2=1$.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: slope $0$ isoclines for an equation depending only on $y$.',
  weight_primary = 0.60,
  weight_supporting = 0.40,
    primary_skill_id = 'SK_ISOCLINE_ANALYSIS',
  supporting_skill_ids = ARRAY['SK_SLOPE_FIELD_SKETCH'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_DiffEq',
  updated_at = NOW()
WHERE title = '7.3-P4';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_DiffEq',
  sub_topic_id = '7.3',
  section_id = '7.3',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 1,
  target_time_seconds = 75,
  skill_tags = ARRAY['SK_SLOPE_FIELD_SKETCH', 'SK_DEPENDENCE_XY'],
  error_tags = ARRAY['E_SLOPEFIELD_READ_ERROR'],
  prompt = 'Consider the differential equation $\dfrac{dy}{dx}=x^2$. Which statement about its slope field is true?',
  latex = 'Consider the differential equation $\dfrac{dy}{dx}=x^2$. Which statement about its slope field is true?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','The slope is the same along each horizontal line $y=c$.','explanation','That would require the slope to depend only on $y$, not only on $x$.'),
    jsonb_build_object('id','B','text','The slope is the same along each vertical line $x=c$.','explanation','Since $x^2$ depends only on $x$, all points with the same $x$ have the same slope.'),
    jsonb_build_object('id','C','text','The slope is zero only on the line $y=0$.','explanation','Slope is zero when $x^2=0$, i.e., when $x=0$.'),
    jsonb_build_object('id','D','text','The slope is negative whenever $x<0$.','explanation','Because $x^2\ge 0$ for all $x$, slopes are never negative.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Because $\frac{dy}{dx}=x^2$ depends only on $x$, the slope is constant along any vertical line $x=c$.',
  recommendation_reasons = ARRAY['Checks recognition of whether slope depends on $x$ or $y$.','Prevents axis-mixup errors when sketching slope fields.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 1,
  mastery_weight = 0.90,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: direction fields for equations depending only on $x$.',
  weight_primary = 0.85,
  weight_supporting = 0.15,
    primary_skill_id = 'SK_SLOPE_FIELD_SKETCH',
  supporting_skill_ids = ARRAY['SK_DEPENDENCE_XY'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_DiffEq',
  updated_at = NOW()
WHERE title = '7.3-P5';



-- Unit 7.4 (Reasoning Using Slope Fields) — Practice 1–5

UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_DiffEq',
  sub_topic_id = '7.4',
  section_id = '7.4',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 125,
  skill_tags = ARRAY['SK_SLOPE_FIELD_REASON', 'SK_EQUILIBRIUM_STABILITY'],
  error_tags = ARRAY['E_SLOPEFIELD_READ_ERROR', 'E_IGNORE_ISOCLINE'],
  prompt = 'Use the accompanying slope field (image). A solution satisfies $y(0)=0.5$. As $x\to\infty$, what value does $y$ approach?',
  latex = 'Use the accompanying slope field (image). A solution satisfies $y(0)=0.5$. As $x\to\infty$, what value does $y$ approach?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$2$','explanation','The field indicates $y=2$ is a stable equilibrium: solutions between $0$ and $2$ increase toward $2$.'),
    jsonb_build_object('id','B','text','$0$','explanation','From $y(0)=0.5$, the field shows positive slopes, so the solution moves away from $0$.'),
    jsonb_build_object('id','C','text','$-\infty$','explanation','Near $y=0.5$ the slopes are positive, so the solution does not decrease without bound.'),
    jsonb_build_object('id','D','text','$+\infty$','explanation','Above $y=2$ the field slopes downward, so solutions are pushed back down rather than blowing up.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'From the field, $y=0$ and $y=2$ are equilibrium lines. In the region $0<y<2$ the slopes are positive, so the solution increases toward the stable equilibrium $y=2$.',
  recommendation_reasons = ARRAY['Builds long-run reasoning from equilibrium lines in a slope field.','Targets choosing an equilibrium without checking stability/direction.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.10,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Image-based: infer long-run behavior from stability of equilibrium solutions.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
    primary_skill_id = 'SK_SLOPE_FIELD_REASON',
  supporting_skill_ids = ARRAY['SK_EQUILIBRIUM_STABILITY'],
  prompt_type = 'text_and_image',
  representation_type = 'symbolic',
  topic_id = 'Both_DiffEq',
  updated_at = NOW()
WHERE title = '7.4-P1';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_DiffEq',
  sub_topic_id = '7.4',
  section_id = '7.4',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 155,
  skill_tags = ARRAY['SK_SLOPE_FIELD_REASON', 'SK_EQUILIBRIUM_STABILITY'],
  error_tags = ARRAY['E_SIGN_ERROR', 'E_IGNORE_ISOCLINE'],
  prompt = 'For the autonomous differential equation $\dfrac{dy}{dx}=(y-3)(y+1)$, a solution satisfies $y(0)=2$. Which statement is correct about the solution as $x$ increases?',
  latex = 'For the autonomous differential equation $\dfrac{dy}{dx}=(y-3)(y+1)$, a solution satisfies $y(0)=2$. Which statement is correct about the solution as $x$ increases?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','The solution increases and approaches $y=3$.','explanation','For $-1<y<3$, $(y-3)(y+1)<0$, so the solution decreases, not increases.'),
    jsonb_build_object('id','B','text','The solution decreases and approaches $y=-1$.','explanation','Starting at $y=2$ (between $-1$ and $3$), the slope is negative so the solution decreases toward the stable equilibrium at $y=-1$.'),
    jsonb_build_object('id','C','text','The solution is constant $y=2$ for all $x$.','explanation','Constant solutions occur only at equilibria $y=-1$ or $y=3$.'),
    jsonb_build_object('id','D','text','The solution decreases without bound to $-\infty$.','explanation','The sign chart shows solutions are pushed toward $y=-1$, not past it to $-\infty$.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Equilibria are $y=-1$ and $y=3$. Since $(y-3)(y+1)<0$ for $-1<y<3$, the solution starting at $2$ decreases. The equilibrium $y=-1$ is stable, so the solution approaches $-1$ as $x$ increases.',
  recommendation_reasons = ARRAY['Trains equilibrium sign-chart reasoning used in slope-field interpretation.','Targets stability errors from misreading the sign of $\frac{dy}{dx}$.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.20,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: use sign analysis to determine stability and long-term behavior.',
  weight_primary = 0.65,
  weight_supporting = 0.35,
    primary_skill_id = 'SK_SLOPE_FIELD_REASON',
  supporting_skill_ids = ARRAY['SK_EQUILIBRIUM_STABILITY'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_DiffEq',
  updated_at = NOW()
WHERE title = '7.4-P2';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_DiffEq',
  sub_topic_id = '7.4',
  section_id = '7.4',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 105,
  skill_tags = ARRAY['SK_SLOPE_FIELD_REASON', 'SK_MATCH_DE_BEHAVIOR'],
  error_tags = ARRAY['E_SLOPEFIELD_READ_ERROR', 'E_SIGN_ERROR'],
  prompt = 'A slope field shows that along the horizontal line $y=0$ the segments are horizontal. For $y>0$, the segments tilt downward (negative slope). For $y<0$, the segments tilt upward (positive slope). Which differential equation is most consistent with this behavior?',
  latex = 'A slope field shows that along the horizontal line $y=0$ the segments are horizontal. For $y>0$, the segments tilt downward (negative slope). For $y<0$, the segments tilt upward (positive slope). Which differential equation is most consistent with this behavior?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\dfrac{dy}{dx}=y$','explanation','If $y>0$, then the slope would be positive, contradicting the downward tilt above $0$.'),
    jsonb_build_object('id','B','text','$\dfrac{dy}{dx}=-y$','explanation','If $y>0$ then $-y<0$; if $y<0$ then $-y>0$; and slope is $0$ on $y=0$.'),
    jsonb_build_object('id','C','text','$\dfrac{dy}{dx}=y^2$','explanation','Since $y^2\ge 0$, slopes would not be negative for $y>0$.'),
    jsonb_build_object('id','D','text','$\dfrac{dy}{dx}=-y^2$','explanation','Since $-y^2\le 0$, slopes would not be positive for $y<0$.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'The sign pattern is: slope $0$ at $y=0$, negative for $y>0$, and positive for $y<0$. The expression $-y$ matches this exactly.',
  recommendation_reasons = ARRAY['Builds mapping between qualitative slope-field sign patterns and formulas.','Targets confusion among $y$, $-y$, $y^2$, and $-y^2$.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: match an equation to equilibrium at $y=0$ and directional signs.',
  weight_primary = 0.75,
  weight_supporting = 0.25,
    primary_skill_id = 'SK_SLOPE_FIELD_REASON',
  supporting_skill_ids = ARRAY['SK_MATCH_DE_BEHAVIOR'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_DiffEq',
  updated_at = NOW()
WHERE title = '7.4-P3';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_DiffEq',
  sub_topic_id = '7.4',
  section_id = '7.4',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 120,
  skill_tags = ARRAY['SK_SLOPE_FIELD_REASON', 'SK_EQUILIBRIUM_STABILITY'],
  error_tags = ARRAY['E_SLOPEFIELD_READ_ERROR', 'E_IGNORE_ISOCLINE'],
  prompt = 'Use the accompanying slope field (image). Which statement about the equilibrium solution $y=0$ is correct?',
  latex = 'Use the accompanying slope field (image). Which statement about the equilibrium solution $y=0$ is correct?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$y=0$ is unstable because nearby solutions move away from it.','explanation','The field shows directions pointing back toward $y=0$ from above and below.'),
    jsonb_build_object('id','B','text','$y=0$ is neither stable nor unstable because slopes are zero everywhere.','explanation','Slopes are zero only on $y=0$; elsewhere the segments tilt up or down.'),
    jsonb_build_object('id','C','text','$y=0$ is stable because nearby solutions move toward it as $x$ increases.','explanation','Above $0$ the field tilts downward; below $0$ it tilts upward, pushing solutions toward $0$.'),
    jsonb_build_object('id','D','text','$y=0$ is not an equilibrium because the solution curve must be curved.','explanation','A horizontal line is an equilibrium when the slope is $0$ along that line.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'The field shows horizontal segments on $y=0$. For $y>0$ the slopes are negative and for $y<0$ the slopes are positive, so solutions move toward $y=0$ as $x$ increases. Therefore $y=0$ is stable.',
  recommendation_reasons = ARRAY['Builds stable/unstable equilibrium recognition directly from a slope field.','Targets misconceptions about what counts as a solution curve.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.05,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Image-based: classify stability of an equilibrium solution from a direction field.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
    primary_skill_id = 'SK_SLOPE_FIELD_REASON',
  supporting_skill_ids = ARRAY['SK_EQUILIBRIUM_STABILITY'],
  prompt_type = 'text_and_image',
  representation_type = 'symbolic',
  topic_id = 'Both_DiffEq',
  updated_at = NOW()
WHERE title = '7.4-P4';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_DiffEq',
  sub_topic_id = '7.4',
  section_id = '7.4',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 5,
  target_time_seconds = 170,
  skill_tags = ARRAY['SK_SLOPE_FIELD_REASON', 'SK_QUAL_BEHAVIOR'],
  error_tags = ARRAY['E_CONFUSE_FIELD_VS_SOLUTION', 'E_SLOPEFIELD_READ_ERROR'],
  prompt = 'A solution to $\dfrac{dy}{dx}=x-y$ passes through $(0,0)$. Using slope-field reasoning (sign of $x-y$ near $x=0$), what can you conclude about $(0,0)$ on this solution curve?',
  latex = 'A solution to $\dfrac{dy}{dx}=x-y$ passes through $(0,0)$. Using slope-field reasoning (sign of $x-y$ near $x=0$), what can you conclude about $(0,0)$ on this solution curve?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','It is a local maximum on the solution curve.','explanation','A local maximum would require slopes changing from positive to negative across the point.'),
    jsonb_build_object('id','B','text','It is a point of inflection on the solution curve.','explanation','Inflection requires concavity analysis; the slope sign change indicates an extremum instead.'),
    jsonb_build_object('id','C','text','It is a local minimum on the solution curve.','explanation','Slopes are negative for $x<0$ near the origin and positive for $x>0$ near the origin, giving a local minimum.'),
    jsonb_build_object('id','D','text','Nothing can be concluded because the slope at $(0,0)$ is $0$.','explanation','A zero slope at a point can still correspond to a local min/max if the slope changes sign.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'At $(0,0)$ the slope is $0$. For $x<0$ near the origin, $x-y<0$ so the solution decreases; for $x>0$ near the origin, $x-y>0$ so the solution increases. Decreasing then increasing implies a local minimum at $(0,0)$.',
  recommendation_reasons = ARRAY['AP-style qualitative reasoning: infer an extremum from a slope sign change.','Targets the misconception that slope $0$ means no conclusion.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 5,
  mastery_weight = 1.25,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: use sign of $\frac{dy}{dx}$ around a point to infer local extrema on a solution curve.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
    primary_skill_id = 'SK_SLOPE_FIELD_REASON',
  supporting_skill_ids = ARRAY['SK_QUAL_BEHAVIOR'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_DiffEq',
  updated_at = NOW()
WHERE title = '7.4-P5';
