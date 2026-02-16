-- Unit 9.1 (Defining and Differentiating Parametric Equations) — Practice 1–5

BEGIN;

UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Derivatives',
  sub_topic_id = '9.1',
  section_id = '9.1',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 90,
  skill_tags = ARRAY['SK_RELRATES_SETUP', 'SK_IMPLICIT_DIFFERENTIATION'],
  primary_skill_id = 'SK_RELRATES_SETUP',
  supporting_skill_ids = ARRAY['SK_IMPLICIT_DIFFERENTIATION'],
  error_tags = ARRAY['E_UNITS', 'E_POWER_RULE', 'E_ALGEBRA'],
  prompt = 'A circular oil spill has area $A$ (in m$^2$) and radius $r$ (in m). The radius is increasing at a constant rate of $\\frac{dr}{dt}=0.20$ m/s. When $r=15$ m, what is $\\frac{dA}{dt}$?',
  latex = 'A circular oil spill has area $A$ (in m$^2$) and radius $r$ (in m). The radius is increasing at a constant rate of $\\frac{dr}{dt}=0.20$ m/s. When $r=15$ m, what is $\\frac{dA}{dt}$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$6\\pi$ m$^2$/s','explanation','Correct: $\\frac{dA}{dt}=2\\pi r\\frac{dr}{dt}=2\\pi(15)(0.20)=6\\pi$.'),
    jsonb_build_object('id','B','text','$3\\pi$ m$^2$/s','explanation','Misses the factor of $2$ from differentiating $r^2$.'),
    jsonb_build_object('id','C','text','$60\\pi$ m$^2$/s','explanation','Typically from mishandling decimals or multiplying by $r^2$ instead of $r$.'),
    jsonb_build_object('id','D','text','$0.40\\pi$ m$^2$/s','explanation','Forgets the factor of $r$ in $2\\pi r\\frac{dr}{dt}$.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Differentiate $A=\\pi r^2$ with respect to $t$:
$$\\frac{dA}{dt}=2\\pi r\\frac{dr}{dt}.$$
Substitute $r=15$ and $\\frac{dr}{dt}=0.20$:
$$\\frac{dA}{dt}=2\\pi(15)(0.20)=6\\pi\\text{ m}^2/\\text{s}.$$',
  recommendation_reasons = ARRAY['Builds correct related-rates workflow: differentiate first, substitute last.', 'Reinforces unit tracking for $\\frac{dA}{dt}$.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Differentiate before substituting; final units are m$^2$/s.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Derivatives',
  updated_at = NOW()
WHERE title = '9.1-P1';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Derivatives',
  sub_topic_id = '9.1',
  section_id = '9.1',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 140,
  skill_tags = ARRAY['SK_RELRATES_SETUP', 'SK_CHAIN_RULE'],
  primary_skill_id = 'SK_RELRATES_SETUP',
  supporting_skill_ids = ARRAY['SK_CHAIN_RULE'],
  error_tags = ARRAY['E_SIGN', 'E_SUBSTITUTE_TOO_EARLY', 'E_ALGEBRA'],
  prompt = 'A 5 m ladder leans against a vertical wall (see image). The bottom slides away from the wall at $\\frac{dx}{dt}=0.60$ m/s. When the bottom is 4 m from the wall, how fast is the top sliding down the wall, $\\frac{dy}{dt}$?',
  latex = 'A 5 m ladder leans against a vertical wall. The bottom slides away from the wall at $\\frac{dx}{dt}=0.60$ m/s. When the bottom is 4 m from the wall, how fast is the top sliding down the wall, $\\frac{dy}{dt}$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$0.80$ m/s','explanation','Magnitude only; the top moves downward so $\\frac{dy}{dt}$ must be negative.'),
    jsonb_build_object('id','B','text','$-0.80$ m/s','explanation','Correct: $x^2+y^2=25\\Rightarrow 2x\\frac{dx}{dt}+2y\\frac{dy}{dt}=0$. At $x=4,y=3$: $\\frac{dy}{dt}=-(\\frac{4}{3})(0.60)=-0.80$.'),
    jsonb_build_object('id','C','text','$-0.45$ m/s','explanation','Uses $-\\frac{y}{x}\\frac{dx}{dt}$ instead of $-\\frac{x}{y}\\frac{dx}{dt}$.'),
    jsonb_build_object('id','D','text','$-1.20$ m/s','explanation','Solves $2x\\frac{dx}{dt}+2y\\frac{dy}{dt}=0$ incorrectly (typically forgets dividing by $y$).')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Use $x^2+y^2=25$. Differentiate:
$$2x\\frac{dx}{dt}+2y\\frac{dy}{dt}=0\\Rightarrow \\frac{dy}{dt}=-\\frac{x}{y}\\frac{dx}{dt}.$$
When $x=4$, $y=\\sqrt{25-16}=3$, so
$$\\frac{dy}{dt}=-\\frac{4}{3}(0.60)=-0.80\\text{ m/s}.$$',
  recommendation_reasons = ARRAY['Classic related-rates triangle with sign interpretation.', 'Emphasizes: substitute values after differentiating.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.15,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Top moving down implies $\\frac{dy}{dt}<0$. Image file: 9.1-P2.png',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text_and_image',
  representation_type = 'symbolic',
  topic_id = 'Both_Derivatives',
  updated_at = NOW()
WHERE title = '9.1-P2';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Derivatives',
  sub_topic_id = '9.1',
  section_id = '9.1',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 120,
  skill_tags = ARRAY['SK_RELRATES_SETUP', 'SK_IMPLICIT_DIFFERENTIATION'],
  primary_skill_id = 'SK_RELRATES_SETUP',
  supporting_skill_ids = ARRAY['SK_IMPLICIT_DIFFERENTIATION'],
  error_tags = ARRAY['E_SUBSTITUTE_TOO_EARLY', 'E_ALGEBRA', 'E_UNITS'],
  prompt = 'A balloon is being inflated so that its volume changes at a constant rate of $\\frac{dV}{dt}=12\\pi$ cm$^3$/s. When the radius is $r=3$ cm, what is $\\frac{dr}{dt}$?',
  latex = 'A balloon is being inflated so that its volume changes at a constant rate of $\\frac{dV}{dt}=12\\pi$ cm$^3$/s. When the radius is $r=3$ cm, what is $\\frac{dr}{dt}$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$1$ cm/s','explanation','Too large; it ignores the $r^2$ factor in $\\frac{dV}{dt}=4\\pi r^2\\frac{dr}{dt}$.'),
    jsonb_build_object('id','B','text','$\\frac{1}{3}$ cm/s','explanation','Correct: $12\\pi=4\\pi(3^2)\\frac{dr}{dt}=36\\pi\\frac{dr}{dt}\\Rightarrow \\frac{dr}{dt}=\\frac{1}{3}$.'),
    jsonb_build_object('id','C','text','$\\frac{3}{4}$ cm/s','explanation','From differentiating $\\frac{4}{3}\\pi r^3$ incorrectly.'),
    jsonb_build_object('id','D','text','$\\frac{1}{9}$ cm/s','explanation','Uses $r^3$ instead of $r^2$ after differentiating.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'For a sphere, $V=\\frac{4}{3}\\pi r^3$. Differentiate:
$$\\frac{dV}{dt}=4\\pi r^2\\frac{dr}{dt}.$$
Substitute $\\frac{dV}{dt}=12\\pi$ and $r=3$:
$$12\\pi=4\\pi(9)\\frac{dr}{dt}=36\\pi\\frac{dr}{dt}\\Rightarrow \\frac{dr}{dt}=\\frac{1}{3}\\text{ cm/s}.$$',
  recommendation_reasons = ARRAY['Reinforces correct derivative and correct power of $r$ in related rates.', 'Targets a common AP error: mixing $r^2$ vs $r^3$.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.05,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Differentiate first; then substitute values.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Derivatives',
  updated_at = NOW()
WHERE title = '9.1-P3';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Derivatives',
  sub_topic_id = '9.1',
  section_id = '9.1',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 5,
  target_time_seconds = 170,
  skill_tags = ARRAY['SK_RELRATES_SETUP', 'SK_SIMILAR_TRIANGLES'],
  primary_skill_id = 'SK_RELRATES_SETUP',
  supporting_skill_ids = ARRAY['SK_SIMILAR_TRIANGLES'],
  error_tags = ARRAY['E_FORGET_RELATION', 'E_SUBSTITUTE_TOO_EARLY', 'E_ALGEBRA'],
  prompt = 'A conical tank has height 12 m and radius 4 m (see image). Water is poured in so that $\\frac{dV}{dt}=2$ m$^3$/min. When the water depth is $h=6$ m, what is $\\frac{dh}{dt}$?',
  latex = 'A conical tank has height 12 m and radius 4 m. Water is poured in so that $\\frac{dV}{dt}=2$ m$^3$/min. When the water depth is $h=6$ m, what is $\\frac{dh}{dt}$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\\frac{1}{4\\pi}$ m/min','explanation','Typically from differentiating $h^3$ incorrectly (missing a factor of $h$).'),
    jsonb_build_object('id','B','text','$\\frac{1}{2\\pi}$ m/min','explanation','Correct: $r=\\frac{h}{3}\\Rightarrow V=\\frac{\\pi}{27}h^3$. Then $2=\\frac{\\pi}{9}(36)\\frac{dh}{dt}=4\\pi\\frac{dh}{dt}\\Rightarrow \\frac{dh}{dt}=\\frac{1}{2\\pi}$.'),
    jsonb_build_object('id','C','text','$\\frac{2}{\\pi}$ m/min','explanation','Treats $r$ as constant instead of related to $h$.'),
    jsonb_build_object('id','D','text','$\\frac{3}{8\\pi}$ m/min','explanation','Algebra slip after substituting $h=6$ into $\\frac{dV}{dt}=\\frac{\\pi}{9}h^2\\frac{dh}{dt}$.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Use similar triangles: $\\frac{r}{h}=\\frac{4}{12}=\\frac{1}{3}$, so $r=\\frac{h}{3}$. Substitute into
$$V=\\frac{1}{3}\\pi r^2h$$
to get
$$V=\\frac{1}{3}\\pi\\left(\\frac{h}{3}\\right)^2h=\\frac{\\pi}{27}h^3.$$
Differentiate:
$$\\frac{dV}{dt}=\\frac{\\pi}{9}h^2\\frac{dh}{dt}.$$
At $h=6$ and $\\frac{dV}{dt}=2$:
$$2=\\frac{\\pi}{9}(36)\\frac{dh}{dt}=4\\pi\\frac{dh}{dt}\\Rightarrow \\frac{dh}{dt}=\\frac{1}{2\\pi}\\text{ m/min}.$$',
  recommendation_reasons = ARRAY['Forces eliminating $r$ via similarity before differentiating.', 'High-frequency AP trap: treating a changing radius as constant.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 5,
  mastery_weight = 1.25,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Must express $V$ in terms of $h$ only before differentiating. Image file: 9.1-P4.png',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text_and_image',
  representation_type = 'symbolic',
  topic_id = 'Both_Derivatives',
  updated_at = NOW()
WHERE title = '9.1-P4';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Derivatives',
  sub_topic_id = '9.1',
  section_id = '9.1',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 130,
  skill_tags = ARRAY['SK_SIMILAR_TRIANGLES', 'SK_RELRATES_SETUP'],
  primary_skill_id = 'SK_SIMILAR_TRIANGLES',
  supporting_skill_ids = ARRAY['SK_RELRATES_SETUP'],
  error_tags = ARRAY['E_FORGET_RELATION', 'E_SIGN', 'E_ALGEBRA'],
  prompt = 'A 1.8 m person walks away from a 4.5 m streetlight at 1.2 m/s along a straight path. Let $x$ be the distance from the pole to the person, and let $s$ be the length of the person''s shadow. When $x=6$ m, what is $\\frac{ds}{dt}$?',
  latex = 'A 1.8 m person walks away from a 4.5 m streetlight at 1.2 m/s along a straight path. Let $x$ be the distance from the pole to the person, and let $s$ be the length of the person''s shadow. When $x=6$ m, what is $\\frac{ds}{dt}$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$0.48$ m/s','explanation','Mixes up $x$ and $x+s$ in the similarity ratio.'),
    jsonb_build_object('id','B','text','$0.72$ m/s','explanation','Sets up similar triangles with the wrong corresponding sides.'),
    jsonb_build_object('id','C','text','$0.96$ m/s','explanation','Arithmetic slip: $\\frac{2}{3}\\cdot 1.2=0.8$, not $0.96$.'),
    jsonb_build_object('id','D','text','$0.80$ m/s','explanation','Correct: similarity gives $s=\\frac{2}{3}x$, so $\\frac{ds}{dt}=\\frac{2}{3}\\frac{dx}{dt}=\\frac{2}{3}(1.2)=0.80$.')
  ),
  correct_option_id = 'D',
  tolerance = 0.0010,
  explanation = 'From similar triangles:
$$\\frac{4.5}{x+s}=\\frac{1.8}{s}.$$
Then $4.5s=1.8(x+s)\\Rightarrow 2.7s=1.8x\\Rightarrow s=\\frac{2}{3}x$.
Differentiate:
$$\\frac{ds}{dt}=\\frac{2}{3}\\frac{dx}{dt}=\\frac{2}{3}(1.2)=0.80\\text{ m/s}.$$',
  recommendation_reasons = ARRAY['Combines similarity with rates (a common AP related-rates pattern).', 'Shows simplification to a linear relation before differentiating.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.05,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Simplify the similarity equation to $s=\\frac{2}{3}x$ before differentiating.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Derivatives',
  updated_at = NOW()
WHERE title = '9.1-P5';



-- Unit 9.2 (Second Derivatives of Parametric Equations) — Practice 1–5

UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Motion',
  sub_topic_id = '9.2',
  section_id = '9.2',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 110,
  skill_tags = ARRAY['SK_PARAM_SECOND_DERIVATIVE','SK_PARAM_DYDX_FROM_T','SK_EVALUATE_AT_PARAMETER'],
  primary_skill_id = 'SK_PARAM_SECOND_DERIVATIVE',
  supporting_skill_ids = ARRAY['SK_PARAM_DYDX_FROM_T', 'SK_EVALUATE_AT_PARAMETER'],
  error_tags = ARRAY['ET_SECOND_DERIV_FORGET_DIVIDE_DXDT','ET_EVAL_AT_WRONG_T','ET_ALGEBRA_SIMPLIFICATION'],
  prompt = 'Let $x(t)=t^2$ and $y(t)=t^3$. What is $\dfrac{d^2y}{dx^2}$ at $t=1$?',
  latex = 'Let $x(t)=t^2$ and $y(t)=t^3$. What is $\dfrac{d^2y}{dx^2}$ at $t=1$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\dfrac{3}{2}$','explanation','This equals $\dfrac{d}{dt}(dy/dx)$ at $t=1$ but forgets to divide by $dx/dt$.'),
    jsonb_build_object('id','B','text','$\dfrac{3}{4}$','explanation','Correct. $\dfrac{d^2y}{dx^2}=\dfrac{\frac{d}{dt}(dy/dx)}{dx/dt}$ gives $\dfrac{3}{4}$ at $t=1$.'),
    jsonb_build_object('id','C','text','$\dfrac{1}{4}$','explanation','This comes from an arithmetic or differentiation slip after forming the formula.'),
    jsonb_build_object('id','D','text','$\dfrac{3}{2}t$','explanation','This is $dy/dx$ in terms of $t$, not the second derivative at $t=1$.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'First compute $dy/dx=(dy/dt)/(dx/dt)=(3t^2)/(2t)=(3/2)t$ (for $t\ne 0$). Then
$$\frac{d^2y}{dx^2}=\frac{\frac{d}{dt}(dy/dx)}{dx/dt}=\frac{\frac{3}{2}}{2t}=\frac{3}{4t}.$$
At $t=1$, this is $\dfrac{3}{4}$.',
  recommendation_reasons = ARRAY['Applies the parametric second-derivative formula correctly.','Targets the common “missing final division by $dx/dt$” error.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: compute $d^2y/dx^2$ from parametric derivatives and evaluate at a parameter value.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
    primary_skill_id = 'SK_PARAM_SECOND_DERIVATIVE',
  supporting_skill_ids = ARRAY['SK_PARAM_DYDX_FROM_T','SK_EVALUATE_AT_PARAMETER'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Motion',
  updated_at = NOW()
WHERE title = '9.2-P1';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Motion',
  sub_topic_id = '9.2',
  section_id = '9.2',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 160,
  skill_tags = ARRAY['SK_PARAM_SECOND_DERIVATIVE','SK_PARAM_CONCAVITY_FROM_T','SK_EVALUATE_AT_PARAMETER'],
  primary_skill_id = 'SK_PARAM_SECOND_DERIVATIVE',
  supporting_skill_ids = ARRAY['SK_PARAM_CONCAVITY_FROM_T', 'SK_EVALUATE_AT_PARAMETER'],
  error_tags = ARRAY['ET_SECOND_DERIV_FORGET_DIVIDE_DXDT','ET_SIGN_ERROR','ET_EVAL_AT_WRONG_T'],
  prompt = 'A curve is given by $x(t)=t$ and $y(t)=\sin t$ for $0<t<\pi$. For which values of $t$ is the curve concave down?',
  latex = 'A curve is given by $x(t)=t$ and $y(t)=\sin t$ for $0<t<\pi$. For which values of $t$ is the curve concave down?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$0<t<\dfrac{\pi}{2}$','explanation','On this interval, the curve is concave down, but it is not limited to this sub-interval.'),
    jsonb_build_object('id','B','text','$\dfrac{\pi}{2}<t<\pi$','explanation','Also concave down; restricting to only this half is incorrect.'),
    jsonb_build_object('id','C','text','All $0<t<\pi$','explanation','Correct. $d^2y/dx^2=-\sin t<0$ for all $0<t<\pi$.'),
    jsonb_build_object('id','D','text','None of $0<t<\pi$','explanation','This would require $-\sin t\ge 0$ throughout, which is false on $(0,\pi)$.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'Because $x=t$, we have $dx/dt=1$ and $dy/dt=\cos t$, so $dy/dx=\cos t$. Then
$$\frac{d^2y}{dx^2}=\frac{\frac{d}{dt}(\cos t)}{1}=-\sin t.$$
For $0<t<\pi$, $\sin t>0$, so $-\sin t<0$, hence concave down on the entire interval.',
  recommendation_reasons = ARRAY['Connects parametric second derivative to concavity.','Reinforces sign analysis of $d^2y/dx^2$.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.15,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: determine concavity from $d^2y/dx^2$ in a parametric setting.',
  weight_primary = 0.75,
  weight_supporting = 0.25,
    primary_skill_id = 'SK_PARAM_SECOND_DERIVATIVE',
  supporting_skill_ids = ARRAY['SK_PARAM_CONCAVITY_FROM_T','SK_EVALUATE_AT_PARAMETER'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Motion',
  updated_at = NOW()
WHERE title = '9.2-P2';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Motion',
  sub_topic_id = '9.2',
  section_id = '9.2',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 5,
  target_time_seconds = 190,
  skill_tags = ARRAY['SK_PARAM_SECOND_DERIVATIVE','SK_PARAM_DYDX_FROM_T','SK_ALGEBRA_RATIONAL'],
  primary_skill_id = 'SK_PARAM_SECOND_DERIVATIVE',
  supporting_skill_ids = ARRAY['SK_PARAM_DYDX_FROM_T', 'SK_ALGEBRA_RATIONAL'],
  error_tags = ARRAY['ET_SECOND_DERIV_FORGET_DIVIDE_DXDT','ET_ALGEBRA_SIMPLIFICATION','ET_SIGN_ERROR'],
  prompt = 'Let $x(t)=t^2+1$ and $y(t)=\dfrac{1}{t}$ for $t\ne 0$. What is $\dfrac{d^2y}{dx^2}$ in terms of $t$?',
  latex = 'Let $x(t)=t^2+1$ and $y(t)=\dfrac{1}{t}$ for $t\ne 0$. What is $\dfrac{d^2y}{dx^2}$ in terms of $t$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\dfrac{1}{4t^5}$','explanation','Coefficient error; the factor $3$ is missing.'),
    jsonb_build_object('id','B','text','$\dfrac{3}{4t^5}$','explanation','Correct. Applying the full parametric second-derivative formula yields $\dfrac{3}{4t^5}$.'),
    jsonb_build_object('id','C','text','$-\dfrac{3}{4t^5}$','explanation','Sign error after differentiating $-\dfrac{1}{2}t^{-3}$; the derivative becomes positive.'),
    jsonb_build_object('id','D','text','$\dfrac{3}{2t^4}$','explanation','This equals $\dfrac{d}{dt}(dy/dx)$ but misses the final division by $dx/dt$.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Compute $dx/dt=2t$ and $dy/dt=-1/t^2$. Then
$$\frac{dy}{dx}=\frac{-1/t^2}{2t}=-\frac{1}{2t^3}.$$
Differentiate with respect to $t$:
$$\frac{d}{dt}\left(\frac{dy}{dx}\right)=\frac{3}{2t^4}.$$
Finally
$$\frac{d^2y}{dx^2}=\frac{\frac{d}{dt}(dy/dx)}{dx/dt}=\frac{\frac{3}{2t^4}}{2t}=\frac{3}{4t^5}.$$',
  recommendation_reasons = ARRAY['Requires careful algebra with negative exponents.','Checks correct execution of the full parametric second-derivative formula.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 5,
  mastery_weight = 1.25,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: compute $d^2y/dx^2$ symbolically with rational functions and powers.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
    primary_skill_id = 'SK_PARAM_SECOND_DERIVATIVE',
  supporting_skill_ids = ARRAY['SK_PARAM_DYDX_FROM_T','SK_ALGEBRA_RATIONAL'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Motion',
  updated_at = NOW()
WHERE title = '9.2-P3';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Motion',
  sub_topic_id = '9.2',
  section_id = '9.2',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 140,
  skill_tags = ARRAY['SK_PARAM_SECOND_DERIVATIVE','SK_PARAM_TANGENT_SLOPE_ZERO','SK_EVALUATE_AT_PARAMETER'],
  primary_skill_id = 'SK_PARAM_SECOND_DERIVATIVE',
  supporting_skill_ids = ARRAY['SK_PARAM_TANGENT_SLOPE_ZERO', 'SK_EVALUATE_AT_PARAMETER'],
  error_tags = ARRAY['ET_SOLVE_EQN_INCORRECTLY','ET_SECOND_DERIV_FORGET_DIVIDE_DXDT','ET_DOMAIN_OVERLOOK'],
  prompt = 'A curve is given by $x(t)=t^3$ and $y(t)=t^2-4t$. At the parameter value where the tangent line is horizontal and $t\ne 0$, what is $\dfrac{d^2y}{dx^2}$?',
  latex = 'A curve is given by $x(t)=t^3$ and $y(t)=t^2-4t$. At the parameter value where the tangent line is horizontal and $t\ne 0$, what is $\dfrac{d^2y}{dx^2}$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$-\dfrac{1}{3}$','explanation','This does not match the second-derivative computation at the horizontal-tangent parameter value.'),
    jsonb_build_object('id','B','text','$\dfrac{1}{72}$','explanation','Correct. At $t=2$, the full formula gives $\dfrac{d^2y}{dx^2}=\dfrac{1}{72}$.'),
    jsonb_build_object('id','C','text','$0$','explanation','A horizontal tangent means $dy/dx=0$, not $d^2y/dx^2=0$.'),
    jsonb_build_object('id','D','text','$\dfrac{1}{6}$','explanation','This equals $\dfrac{d}{dt}(dy/dx)$ at $t=2$ but does not divide by $dx/dt$.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Horizontal tangent requires $dy/dt=0$ and $dx/dt\ne 0$. Here $dy/dt=2t-4=0\Rightarrow t=2$ (and $dx/dt=3t^2=12\ne 0$). Next
$$\frac{dy}{dx}=\frac{2t-4}{3t^2}=\frac{2}{3}(t-2)t^{-2}.$$
Differentiate:
$$\frac{d}{dt}\left(\frac{dy}{dx}\right)=\frac{2}{3}\left(t^{-2}-2(t-2)t^{-3}\right).$$
At $t=2$, this is $\dfrac{1}{6}$. Finally
$$\frac{d^2y}{dx^2}=\frac{\frac{d}{dt}(dy/dx)}{dx/dt}=\frac{1/6}{12}=\frac{1}{72}.$$',
  recommendation_reasons = ARRAY['Uses $dy/dt=0$ to locate a horizontal tangent in a parametric setting.','Reinforces that $d^2y/dx^2$ needs the final division by $dx/dt$.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.10,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: compute $d^2y/dx^2$ at a horizontal tangent parameter value.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
    primary_skill_id = 'SK_PARAM_SECOND_DERIVATIVE',
  supporting_skill_ids = ARRAY['SK_PARAM_TANGENT_SLOPE_ZERO','SK_EVALUATE_AT_PARAMETER'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Motion',
  updated_at = NOW()
WHERE title = '9.2-P4';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Motion',
  sub_topic_id = '9.2',
  section_id = '9.2',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 1,
  target_time_seconds = 75,
  skill_tags = ARRAY['SK_PARAM_SECOND_DERIVATIVE'],
  primary_skill_id = 'SK_PARAM_SECOND_DERIVATIVE',
  supporting_skill_ids = ARRAY[]::text[],
  error_tags = ARRAY['ET_SECOND_DERIV_FORGET_DIVIDE_DXDT','ET_SIGN_ERROR'],
  prompt = 'A curve is given by $x(t)=t$ and $y(t)=t^2$. What is $\dfrac{d^2y}{dx^2}$?',
  latex = 'A curve is given by $x(t)=t$ and $y(t)=t^2$. What is $\dfrac{d^2y}{dx^2}$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$2$','explanation','Correct. Since $x=t$, we have $y=x^2$, so $d^2y/dx^2=2$.'),
    jsonb_build_object('id','B','text','$2t$','explanation','This is $dy/dx$, not the second derivative.'),
    jsonb_build_object('id','C','text','$1$','explanation','This is $dx/dt$, not $d^2y/dx^2$.'),
    jsonb_build_object('id','D','text','$0$','explanation','The second derivative of $x^2$ is not $0$.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Because $x=t$, rewrite $y=t^2$ as $y=x^2$. Then $d^2y/dx^2=2$.',
  recommendation_reasons = ARRAY['Quick calibration: when $x=t$, the parametric setup reduces to a standard $y(x)$.','Separates first- vs second-derivative interpretation.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 1,
  mastery_weight = 0.85,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: interpret and compute $d^2y/dx^2$ in a simple parametric case.',
  weight_primary = 1.00,
  weight_supporting = 0.00,
    primary_skill_id = 'SK_PARAM_SECOND_DERIVATIVE',
  supporting_skill_ids = ARRAY[]::text[],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Motion',
  updated_at = NOW()
WHERE title = '9.2-P5';

COMMIT;
