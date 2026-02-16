-- Unit 9.1 (Chapter 9) — Practice 1–5

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



-- Unit 10.1 (Chapter 10) — Practice 1–5

UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Derivatives',
  sub_topic_id = '10.1',
  section_id = '10.1',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 100,
  skill_tags = ARRAY['SK_LINEARIZATION', 'SK_TANGENT_LINE'],
  primary_skill_id = 'SK_LINEARIZATION',
  supporting_skill_ids = ARRAY['SK_TANGENT_LINE'],
error_tags = ARRAY['E_WRONG_POINT', 'E_ALGEBRA', 'E_ARITHMETIC'],
  prompt = 'Use linearization to approximate $\\sqrt{4.1}$.',
  latex = 'Use linearization to approximate $\\sqrt{4.1}$.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$2.025$','explanation','Correct: $f(x)=\\sqrt{x}$, $f(4)=2$, $f''(4)=\\frac{1}{4}$, so $L(4.1)=2+\\frac{1}{4}(0.1)=2.025$.'),
    jsonb_build_object('id','B','text','$2.05$','explanation','Uses slope $\\frac{1}{2}$ instead of $\\frac{1}{4}$.'),
    jsonb_build_object('id','C','text','$2.0025$','explanation','Treats $4.1-4$ as $0.01$ instead of $0.1$.'),
    jsonb_build_object('id','D','text','$1.975$','explanation','Sign error in $(x-4)$.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Let $f(x)=\\sqrt{x}$. Linearize at $a=4$:
$$L(x)=f(4)+f''(4)(x-4)=2+\\frac{1}{4}(x-4).$$
Then
$$\\sqrt{4.1}\\approx L(4.1)=2+\\frac{1}{4}(0.1)=2.025.$$',
  recommendation_reasons = ARRAY['Direct AP skill: build a tangent-line approximation near a convenient point.', 'Targets common slope and sign mistakes in $L(x)$.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Choose $a$ with easy exact values (like $4$ for square roots).',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Derivatives',
  updated_at = NOW()
WHERE title = '10.1-P1';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Derivatives',
  sub_topic_id = '10.1',
  section_id = '10.1',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 130,
  skill_tags = ARRAY['SK_DIFFERENTIALS', 'SK_LINEARIZATION'],
  primary_skill_id = 'SK_DIFFERENTIALS',
  supporting_skill_ids = ARRAY['SK_LINEARIZATION'],
error_tags = ARRAY['E_SIGN', 'E_ARITHMETIC', 'E_INTERPRETATION'],
  prompt = 'Let $f(x)=x^3$. Use differentials to estimate the change in $f$ when $x$ changes from $2$ to $2.02$.',
  latex = 'Let $f(x)=x^3$. Use differentials to estimate the change in $f$ when $x$ changes from $2$ to $2.02$.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$0.12$','explanation','Uses $f''(2)=6$ instead of $12$.'),
    jsonb_build_object('id','B','text','$0.24$','explanation','Correct: $df\\approx f''(2)\\,dx=12(0.02)=0.24$.'),
    jsonb_build_object('id','C','text','$0.08$','explanation','Uses $dx=0.01$ instead of $0.02$.'),
    jsonb_build_object('id','D','text','$0.48$','explanation','Overcounts by doubling $dx$ or doubling the derivative.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Use $df\\approx f''(a)\\,dx$ with $a=2$.
Since $f''(x)=3x^2$, we have $f''(2)=12$ and $dx=2.02-2=0.02$.
Thus
$$df\\approx 12(0.02)=0.24.$$',
  recommendation_reasons = ARRAY['Differentials vs exact change is a frequent AP concept check.', 'Reinforces correct identification of $dx$ and evaluation point.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.05,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'This is an estimate of $\\Delta f$, not an exact value.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Derivatives',
  updated_at = NOW()
WHERE title = '10.1-P2';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Derivatives',
  sub_topic_id = '10.1',
  section_id = '10.1',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 150,
  skill_tags = ARRAY['SK_NEWTON_METHOD', 'SK_TANGENT_LINE'],
  primary_skill_id = 'SK_NEWTON_METHOD',
  supporting_skill_ids = ARRAY['SK_TANGENT_LINE'],
error_tags = ARRAY['E_FORMULA', 'E_ARITHMETIC', 'E_SIGN'],
  prompt = 'Use one Newton''s method iteration to approximate a root of $f(x)=x^2-5$ starting from $x_0=2$.',
  latex = 'Use one Newton''s method iteration to approximate a root of $f(x)=x^2-5$ starting from $x_0=2$.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$2.25$','explanation','Correct: $x_1=2-\\frac{f(2)}{f''(2)}=2-\\frac{-1}{4}=2.25$.'),
    jsonb_build_object('id','B','text','$1.75$','explanation','Sign error in the Newton update.'),
    jsonb_build_object('id','C','text','$2.20$','explanation','Arithmetic slip with $\\frac{1}{4}$ or wrong derivative value.'),
    jsonb_build_object('id','D','text','$2.50$','explanation','Uses $f''(2)=2$ instead of $4$.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Compute $f(2)=2^2-5=-1$ and $f''(x)=2x$ so $f''(2)=4$.
Newton update:
$$x_1=2-\\frac{-1}{4}=2.25.$$',
  recommendation_reasons = ARRAY['Tests the Newton update formula and tangent-line interpretation.', 'Targets sign handling when $f(x_0)$ is negative.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.10,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'One iteration only (do not continue).',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Derivatives',
  updated_at = NOW()
WHERE title = '10.1-P3';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Derivatives',
  sub_topic_id = '10.1',
  section_id = '10.1',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 5,
  target_time_seconds = 180,
  skill_tags = ARRAY['SK_LINEARIZATION_ERROR', 'SK_SECOND_DERIVATIVE_BOUND'],
  primary_skill_id = 'SK_LINEARIZATION_ERROR',
  supporting_skill_ids = ARRAY['SK_SECOND_DERIVATIVE_BOUND'],
error_tags = ARRAY['E_WRONG_FORMULA', 'E_WRONG_INTERVAL', 'E_ARITHMETIC'],
  prompt = 'Let $f(x)=\\ln x$. Use the linearization at $a=1$ to approximate $\\ln(1.1)$. Using the bound $|R(x)|\\le \\frac{M}{2}(x-a)^2$, where $M$ is a maximum of $|f''''(x)|$ on the interval between $a$ and $x$, what is an upper bound on the absolute error?',
  latex = 'Let $f(x)=\\ln x$. Use the linearization at $a=1$ to approximate $\\ln(1.1)$. Using the bound $|R(x)|\\le \\frac{M}{2}(x-a)^2$, where $M$ is a maximum of $|f''''(x)|$ on the interval between $a$ and $x$, what is an upper bound on the absolute error?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\\frac{1}{100}$','explanation','Forgets the factor $\\frac{1}{2}$ in the bound.'),
    jsonb_build_object('id','B','text','$\\frac{1}{200}$','explanation','Correct: on $[1,1.1]$, $|f''''(x)|=\\frac{1}{x^2}\\le 1$, so $|R|\\le \\frac{1}{2}(0.1)^2=\\frac{1}{200}$.'),
    jsonb_build_object('id','C','text','$\\frac{1}{400}$','explanation','Uses $M=\\frac{1}{(1.1)^2}$ (not the maximum) and still includes $\\frac{1}{2}(0.1)^2$.'),
    jsonb_build_object('id','D','text','$\\frac{1}{220}$','explanation','Uses a non-maximum bound value and/or mis-squares $0.1$.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Here $f''''(x)=-\\frac{1}{x^2}$, so $|f''''(x)|=\\frac{1}{x^2}$. On $[1,1.1]$, the maximum occurs at $x=1$, so $M=1$.
Thus
$$|R(1.1)|\\le \\frac{1}{2}(1.1-1)^2=\\frac{1}{2}(0.1)^2=0.005=\\frac{1}{200}.$$',
  recommendation_reasons = ARRAY['AP-style error bound for linearization; emphasizes selecting $M$ on the correct interval.', 'Targets max-vs-min confusion for $|f''''|$.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 5,
  mastery_weight = 1.20,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Use the maximum of $|f''''(x)|$ between $a$ and $x$ (here it is at $x=1$).',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Derivatives',
  updated_at = NOW()
WHERE title = '10.1-P4';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Derivatives',
  sub_topic_id = '10.1',
  section_id = '10.1',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 160,
  skill_tags = ARRAY['SK_NEWTON_METHOD', 'SK_FUNCTION_SIGN'],
  primary_skill_id = 'SK_NEWTON_METHOD',
  supporting_skill_ids = ARRAY['SK_FUNCTION_SIGN'],
error_tags = ARRAY['E_SIGN', 'E_INTERPRETATION', 'E_FORMULA'],
  prompt = 'Consider $f(x)=x^3-2x-2$ (see graph). Starting at $x_0=2$, the Newton iterate is $x_1=x_0-\\frac{f(x_0)}{f''(x_0)}$. Which statement is true?',
  latex = 'Consider $f(x)=x^3-2x-2$. Starting at $x_0=2$, the Newton iterate is $x_1=x_0-\\frac{f(x_0)}{f''(x_0)}$. Which statement is true?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$x_1<2$ because $f(2)<0$.','explanation','Incorrect: $f(2)=8-4-2=2>0$.'),
    jsonb_build_object('id','B','text','$x_1>2$ because $f(2)>0$ and $f''''(2)>0$.','explanation','If $f(2)>0$ and $f''''(2)>0$, then $x_1=2-\\frac{f(2)}{f''''(2)}<2$, not $>2$.'),
    jsonb_build_object('id','C','text','$x_1<2$ because $f(2)>0$ and $f''''(2)>0$.','explanation','Correct: $f(2)=2>0$ and $f''''(2)=3(2^2)-2=10>0$, so $x_1=2-\\frac{2}{10}=1.8<2$.'),
    jsonb_build_object('id','D','text','$x_1=2$ because Newton''s method always stays at the initial guess for cubic functions.','explanation','False: Newton''s method moves unless $f(x_0)=0$.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'At $x_0=2$, $f(2)=2>0$ and $f''''(2)=3(2^2)-2=10>0$.
Newton update subtracts a positive amount:
$$x_1=2-\\frac{2}{10}=1.8<2.$$',
  recommendation_reasons = ARRAY['Checks sign-based interpretation of the Newton update (AP conceptual style).', 'Distinguishes direction of the iterate with minimal computation.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.10,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Direction depends on the sign of $\\frac{f(x_0)}{f''''(x_0)}$. Image file: 10.1-P5.png',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text_and_image',
  representation_type = 'symbolic',
  topic_id = 'Both_Derivatives',
  updated_at = NOW()
WHERE title = '10.1-P5';
