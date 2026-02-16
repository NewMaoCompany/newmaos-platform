-- Unit 4.5 & 4.6 SQL Update Script
-- Wrapped in a DO block to ensure atomic execution and prevent syntax errors at EOF.

DO $block$
BEGIN

-- Unit 4.5 (Solving Related Rates Problems) — Practice 1–5

UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Applications',
  sub_topic_id = '4.5',
  section_id = '4.5',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 120,
  skill_tags = ARRAY['SK_RR_SETUP', 'SK_IMPLICIT_DIFF', 'SK_SOLVE_RATE', 'SK_UNIT_ANALYSIS'],
  primary_skill_id = 'SK_RR_SETUP',
  supporting_skill_ids = ARRAY['SK_IMPLICIT_DIFF', 'SK_SOLVE_RATE', 'SK_UNIT_ANALYSIS'],
 'SK_SOLVE_RATE', 'SK_UNIT_ANALYSIS'], 'SK_SOLVE_RATE', 'SK_UNIT_ANALYSIS'],
  error_tags = ARRAY['E_SUBSTITUTE_EARLY', 'E_CHAIN_RULE', 'E_SIGN', 'E_UNITS'],
  prompt = 'A $10$-ft ladder leans against a vertical wall (see image). Let $x$ be the distance (ft) from the wall to the foot of the ladder and let $y$ be the height (ft) of the top of the ladder on the wall. At the moment when $x=6$, the foot of the ladder is sliding away from the wall at a rate of $\dfrac{dx}{dt}=0.5$ ft/s. What is $\dfrac{dy}{dt}$ at that moment?',
  latex = 'A $10$-ft ladder leans against a vertical wall (see image). Let $x$ be the distance (ft) from the wall to the foot of the ladder and let $y$ be the height (ft) of the top of the ladder on the wall. At the moment when $x=6$, the foot of the ladder is sliding away from the wall at a rate of $\dfrac{dx}{dt}=0.5$ ft/s. What is $\dfrac{dy}{dt}$ at that moment?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$-0.75$ ft/s','explanation','This can result from using an incorrect value for $y$ when $x=6$ (since $y$ should be $8$, not $4$).'),
    jsonb_build_object('id','B','text','$-0.375$ ft/s','explanation','Correct. From $x^2+y^2=100$, $\dfrac{dy}{dt}=-(x/y)\dfrac{dx}{dt}=-(6/8)(0.5)=-0.375$.'),
    jsonb_build_object('id','C','text','$0.375$ ft/s','explanation','Sign error: as $x$ increases, $y$ must decrease, so $\dfrac{dy}{dt}<0$.'),
    jsonb_build_object('id','D','text','$-0.5$ ft/s','explanation','This ignores the factor $x/y$ that appears after implicit differentiation of $x^2+y^2=100$.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Because the ladder length is constant, $x^2+y^2=10^2=100$. Differentiate with respect to $t$:
$$2x\frac{dx}{dt}+2y\frac{dy}{dt}=0 \;\Rightarrow\; \frac{dy}{dt}= -\frac{x}{y}\frac{dx}{dt}.$$
When $x=6$, $y=\sqrt{100-36}=8$, so
$$\frac{dy}{dt}= -\frac{6}{8}(0.5)=-0.375\text{ ft/s}.$$',
  recommendation_reasons = ARRAY['Reinforces related-rates setup from a fixed-length constraint.', 'Targets sign and substitution-at-the-end habits.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Use the Pythagorean constraint and substitute $x=6$ only after differentiating.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text_and_image',
  representation_type = 'symbolic',
  topic_id = 'Both_Applications',
  updated_at = NOW()
WHERE title = '4.5-P1';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Applications',
  sub_topic_id = '4.5',
  section_id = '4.5',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 90,
  skill_tags = ARRAY['SK_RR_SETUP', 'SK_CHAIN_RULE', 'SK_UNIT_ANALYSIS'],
  primary_skill_id = 'SK_RR_SETUP',
  supporting_skill_ids = ARRAY['SK_CHAIN_RULE', 'SK_UNIT_ANALYSIS'],
 'SK_UNIT_ANALYSIS'], 'SK_UNIT_ANALYSIS'],
  error_tags = ARRAY['E_CHAIN_RULE', 'E_UNITS', 'E_ALGEBRA', 'E_SUBSTITUTE_EARLY'],
  prompt = 'A circular oil spill expands so that its radius increases at a constant rate of $\dfrac{dr}{dt}=0.4$ m/min. When the radius is $r=10$ m, what is the rate of change of the area of the spill, $\dfrac{dA}{dt}$?',
  latex = 'A circular oil spill expands so that its radius increases at a constant rate of $\dfrac{dr}{dt}=0.4$ m/min. When the radius is $r=10$ m, what is the rate of change of the area of the spill, $\dfrac{dA}{dt}$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$4\pi$ m$^2$/min','explanation','This omits the factor $2r$ from differentiating $A=\pi r^2$.'),
    jsonb_build_object('id','B','text','$8\pi$ m$^2$/min','explanation','Correct. $\dfrac{dA}{dt}=2\pi r\dfrac{dr}{dt}=2\pi(10)(0.4)=8\pi$.'),
    jsonb_build_object('id','C','text','$40\pi$ m$^2$/min','explanation','This typically comes from computing $2\pi r=20\pi$ and then multiplying by $2$ again or mishandling the rate.'),
    jsonb_build_object('id','D','text','$80\pi$ m$^2$/min','explanation','This commonly results from using $r^2$ instead of $r$ in $2\pi r\dfrac{dr}{dt}$.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'With $A=\pi r^2$, differentiate:
$$\frac{dA}{dt}=2\pi r\frac{dr}{dt}.$$
At $r=10$ and $\frac{dr}{dt}=0.4$,
$$\frac{dA}{dt}=2\pi(10)(0.4)=8\pi\text{ m}^2/\text{min}.$$',
  recommendation_reasons = ARRAY['Builds fluency converting geometry formulas into related rates.', 'Targets chain-rule and unit consistency.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 0.90,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Differentiate first, then substitute the instantaneous values.',
  weight_primary = 0.85,
  weight_supporting = 0.15,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Applications',
  updated_at = NOW()
WHERE title = '4.5-P2';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Applications',
  sub_topic_id = '4.5',
  section_id = '4.5',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 150,
  skill_tags = ARRAY['SK_RR_SETUP', 'SK_SIMILAR_TRIANGLES', 'SK_CHAIN_RULE', 'SK_SOLVE_RATE', 'SK_UNIT_ANALYSIS'],
  primary_skill_id = 'SK_RR_SETUP',
  supporting_skill_ids = ARRAY['SK_SIMILAR_TRIANGLES', 'SK_CHAIN_RULE', 'SK_SOLVE_RATE', 'SK_UNIT_ANALYSIS'],
 'SK_CHAIN_RULE', 'SK_SOLVE_RATE', 'SK_UNIT_ANALYSIS'], 'SK_CHAIN_RULE', 'SK_SOLVE_RATE', 'SK_UNIT_ANALYSIS'],
  error_tags = ARRAY['E_SUBSTITUTE_EARLY', 'E_CHAIN_RULE', 'E_ALGEBRA', 'E_UNITS'],
  prompt = 'Water is poured into an inverted right circular cone with height $H=6$ m and base radius $R=3$ m (see image). Let $h$ be the water height (m) and $V$ the water volume (m$^3$). At the moment when $h=2$ m, water is being poured in at a rate of $\dfrac{dV}{dt}=0.5$ m$^3$/min. What is $\dfrac{dh}{dt}$ at that moment?',
  latex = 'Water is poured into an inverted right circular cone with height $H=6$ m and base radius $R=3$ m (see image). Let $h$ be the water height (m) and $V$ the water volume (m$^3$). At the moment when $h=2$ m, water is being poured in at a rate of $\dfrac{dV}{dt}=0.5$ m$^3$/min. What is $\dfrac{dh}{dt}$ at that moment?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\dfrac{1}{8\pi}$ m/min','explanation','This can occur from using an incorrect constant when expressing $V$ as a function of $h$.'),
    jsonb_build_object('id','B','text','$\dfrac{1}{\pi}$ m/min','explanation','This often results from differentiating $h^3$ incorrectly (missing the factor $3$).'),
    jsonb_build_object('id','C','text','$\dfrac{1}{4\pi}$ m/min','explanation','This typically comes from using an incorrect similarity ratio for $r$ in terms of $h$.'),
    jsonb_build_object('id','D','text','$\dfrac{1}{2\pi}$ m/min','explanation','Correct. Similar triangles give $r=\dfrac{h}{2}$ and $V=\dfrac{\pi}{12}h^3$, so $\dfrac{dV}{dt}=\dfrac{\pi}{4}h^2\dfrac{dh}{dt}$. At $h=2$, $\dfrac{dh}{dt}=\dfrac{0.5}{\pi}=\dfrac{1}{2\pi}$.')
  ),
  correct_option_id = 'D',
  tolerance = 0.0010,
  explanation = 'By similar triangles,
$$\frac{r}{h}=\frac{R}{H}=\frac{3}{6}=\frac{1}{2}\;\Rightarrow\; r=\frac{h}{2}.$$
Then
$$V=\frac{1}{3}\pi r^2h=\frac{1}{3}\pi\left(\frac{h}{2}\right)^2h=\frac{\pi}{12}h^3.$$
Differentiate:
$$\frac{dV}{dt}=\frac{\pi}{4}h^2\frac{dh}{dt}.$$
At $h=2$,
$$0.5=\frac{\pi}{4}(4)\frac{dh}{dt}=\pi\frac{dh}{dt}\;\Rightarrow\;\frac{dh}{dt}=\frac{1}{2\pi}\text{ m/min}.$$',
  recommendation_reasons = ARRAY['Forces correct elimination of variables using similarity before differentiating.', 'Targets common constant and ratio mistakes in cone-tank related rates.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.10,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Key step: express $r$ in terms of $h$ using similarity.',
  weight_primary = 0.75,
  weight_supporting = 0.25,
  prompt_type = 'text_and_image',
  representation_type = 'symbolic',
  topic_id = 'Both_Applications',
  updated_at = NOW()
WHERE title = '4.5-P3';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Applications',
  sub_topic_id = '4.5',
  section_id = '4.5',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 135,
  skill_tags = ARRAY['SK_RR_SETUP', 'SK_SIMILAR_TRIANGLES', 'SK_SOLVE_RATE', 'SK_UNIT_ANALYSIS'],
  primary_skill_id = 'SK_RR_SETUP',
  supporting_skill_ids = ARRAY['SK_SIMILAR_TRIANGLES', 'SK_SOLVE_RATE', 'SK_UNIT_ANALYSIS'],
 'SK_SOLVE_RATE', 'SK_UNIT_ANALYSIS'], 'SK_SOLVE_RATE', 'SK_UNIT_ANALYSIS'],
  error_tags = ARRAY['E_ALGEBRA', 'E_UNITS', 'E_SUBSTITUTE_EARLY', 'E_SIGN'],
  prompt = 'A $2$-m tall person walks away from a streetlight that is $6$ m tall. If the person walks away from the light at a rate of $1.5$ m/s, how fast is the length of the person’s shadow changing when the person is $4$ m from the pole? (Let $x$ be the distance from pole to person and $s$ be the shadow length.)',
  latex = 'A $2$-m tall person walks away from a streetlight that is $6$ m tall. If the person walks away from the light at a rate of $1.5$ m/s, how fast is the length of the person’s shadow changing when the person is $4$ m from the pole? (Let $x$ be the distance from pole to person and $s$ be the shadow length.)',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$1.0$ m/s','explanation','This can come from incorrectly simplifying the similarity proportion.'),
    jsonb_build_object('id','B','text','$0.75$ m/s','explanation','Correct. Similar triangles give $s=\dfrac{x}{2}$, so $\dfrac{ds}{dt}=\dfrac{1}{2}\dfrac{dx}{dt}=0.75$.'),
    jsonb_build_object('id','C','text','$1.5$ m/s','explanation','This assumes $s$ increases at the same rate as $x$, ignoring the similar-triangle relationship.'),
    jsonb_build_object('id','D','text','$3.0$ m/s','explanation','This often results from solving for $s$ incorrectly (for example, getting $s=2x$).')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'From similar triangles,
$$\frac{6}{x+s}=\frac{2}{s}\;\Rightarrow\;6s=2(x+s)\;\Rightarrow\;4s=2x\;\Rightarrow\;s=\frac{x}{2}.$$
Differentiate:
$$\frac{ds}{dt}=\frac{1}{2}\frac{dx}{dt}=\frac{1}{2}(1.5)=0.75\text{ m/s}.$$',
  recommendation_reasons = ARRAY['Reinforces similarity-based related rates with clean algebra.', 'Targets rate-versus-length confusion.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'After simplifying to $s=x/2$, the value $x=4$ is no longer needed.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Applications',
  updated_at = NOW()
WHERE title = '4.5-P4';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Applications',
  sub_topic_id = '4.5',
  section_id = '4.5',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 5,
  target_time_seconds = 170,
  skill_tags = ARRAY['SK_RR_SETUP', 'SK_PYTHAG', 'SK_SOLVE_RATE', 'SK_UNIT_ANALYSIS'],
  primary_skill_id = 'SK_RR_SETUP',
  supporting_skill_ids = ARRAY['SK_PYTHAG', 'SK_SOLVE_RATE', 'SK_UNIT_ANALYSIS'],
 'SK_SOLVE_RATE', 'SK_UNIT_ANALYSIS'], 'SK_SOLVE_RATE', 'SK_UNIT_ANALYSIS'],
  error_tags = ARRAY['E_CHAIN_RULE', 'E_ALGEBRA', 'E_UNITS', 'E_SIGN'],
  prompt = 'Two cars start from the same intersection. Car A travels east at $30$ mph and Car B travels north at $40$ mph. How fast is the distance between the cars increasing $2$ hours after they start?',
  latex = 'Two cars start from the same intersection. Car A travels east at $30$ mph and Car B travels north at $40$ mph. How fast is the distance between the cars increasing $2$ hours after they start?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$50$ mph','explanation','Correct. The distance is $d(t)=\sqrt{(30t)^2+(40t)^2}=50t$, so $\dfrac{dd}{dt}=50$.'),
    jsonb_build_object('id','B','text','$70$ mph','explanation','This adds speeds directly; distance rate is not $\dfrac{dx}{dt}+\dfrac{dy}{dt}$.'),
    jsonb_build_object('id','C','text','$25$ mph','explanation','This can come from incorrectly dividing the correct rate by $2$.'),
    jsonb_build_object('id','D','text','$100$ mph','explanation','This can come from treating distance as $x+y$ rather than $\sqrt{x^2+y^2}$.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Let $x=30t$ and $y=40t$. Then
$$d=\sqrt{x^2+y^2}=\sqrt{(30t)^2+(40t)^2}=\sqrt{2500t^2}=50t.$$
Therefore $\dfrac{dd}{dt}=50$ mph for all $t$, including $t=2$.',
  recommendation_reasons = ARRAY['Checks conceptual understanding of orthogonal motion in related rates.', 'Targets the common “add the speeds” misconception.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.15,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'This one simplifies to a constant rate; no implicit differentiation is required.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Applications',
  updated_at = NOW()
WHERE title = '4.5-P5';



-- Unit 4.6 (Approximating Values of a Function Using Local Linearity and Linearization) — Practice 1–5

UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Applications',
  sub_topic_id = '4.6',
  section_id = '4.6',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 90,
  skill_tags = ARRAY['SK_LINEAR_APPROX', 'SK_LOCAL_LINEARITY', 'SK_DERIV_EVAL'],
  primary_skill_id = 'SK_LINEAR_APPROX',
  supporting_skill_ids = ARRAY['SK_LOCAL_LINEARITY', 'SK_DERIV_EVAL'],
 'SK_DERIV_EVAL'], 'SK_DERIV_EVAL'],
  error_tags = ARRAY['E_WRONG_POINT', 'E_DERIV_VALUE', 'E_ALGEBRA', 'E_SIGN'],
  prompt = 'Use linear approximation to estimate $\sqrt{10}$ by linearizing $f(x)=\sqrt{x}$ at $x=9$.',
  latex = 'Use linear approximation to estimate $\sqrt{10}$ by linearizing $f(x)=\sqrt{x}$ at $x=9$.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$3.1$','explanation','This typically comes from adding the correction term incorrectly.'),
    jsonb_build_object('id','B','text','$3.166\overline{6}$','explanation','Correct. $f(9)=3$, $f''(9)=\dfrac{1}{6}$, so $\sqrt{10}\approx 3+\dfrac{1}{6}(1)=3.166\overline{6}$.'),
    jsonb_build_object('id','C','text','$3.333\overline{3}$','explanation','This can come from using $f''(9)=\dfrac{1}{3}$ instead of $\dfrac{1}{6}$.'),
    jsonb_build_object('id','D','text','$3.0$','explanation','This uses $f(9)$ only and ignores the linear correction.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Linearization at $a=9$ is $L(x)=f(9)+f''(9)(x-9)$. Since $f(9)=3$ and
$$f''(x)=\frac{1}{2\sqrt{x}}\;\Rightarrow\; f''(9)=\frac{1}{6},$$
we get
$$\sqrt{10}=f(10)\approx L(10)=3+\frac{1}{6}(10-9)=3.166\overline{6}.$$',
  recommendation_reasons = ARRAY['Builds speed with standard linearization computations.', 'Targets derivative-at-a-point accuracy.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 0.90,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Use $a=9$ because $\sqrt{9}$ is exact and close to $\sqrt{10}$.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Applications',
  updated_at = NOW()
WHERE title = '4.6-P1';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Applications',
  sub_topic_id = '4.6',
  section_id = '4.6',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 120,
  skill_tags = ARRAY['SK_LINEAR_APPROX', 'SK_LOCAL_LINEARITY', 'SK_DERIV_EVAL'],
  primary_skill_id = 'SK_LINEAR_APPROX',
  supporting_skill_ids = ARRAY['SK_LOCAL_LINEARITY', 'SK_DERIV_EVAL'],
 'SK_DERIV_EVAL'], 'SK_DERIV_EVAL'],
  error_tags = ARRAY['E_WRONG_POINT', 'E_DERIV_VALUE', 'E_ALGEBRA', 'E_SIGN'],
  prompt = 'The graph shows $f(x)=\sqrt{x+1}$ and the tangent line at $x=3$ (see image). Use the tangent line (linearization at $x=3$) to approximate $\sqrt{4.1}$.',
  latex = 'The graph shows $f(x)=\sqrt{x+1}$ and the tangent line at $x=3$ (see image). Use the tangent line (linearization at $x=3$) to approximate $\sqrt{4.1}$.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$2.05$','explanation','This can come from using an overly large slope for the tangent line at $x=3$.'),
    jsonb_build_object('id','B','text','$2.00$','explanation','This uses $f(3)=2$ but ignores the tangent-line adjustment to $x=3.1$.'),
    jsonb_build_object('id','C','text','$2.025$','explanation','Correct. Since $\sqrt{4.1}=f(3.1)$, use $f(3)=2$ and $f''(3)=\dfrac{1}{4}$ to get $f(3.1)\approx 2+\dfrac{1}{4}(0.1)=2.025$.'),
    jsonb_build_object('id','D','text','$2.10$','explanation','This treats the change in $y$ as approximately equal to the change in $x$ (slope about $1$).')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'Write $\sqrt{4.1}=\sqrt{(3.1)+1}=f(3.1)$ for $f(x)=\sqrt{x+1}$. Linearization at $a=3$:
$$L(x)=f(3)+f''(3)(x-3).$$
Compute $f(3)=2$ and
$$f''(x)=\frac{1}{2\sqrt{x+1}}\;\Rightarrow\; f''(3)=\frac{1}{4}.$$
Then
$$\sqrt{4.1}=f(3.1)\approx L(3.1)=2+\frac{1}{4}(0.1)=2.025.$$',
  recommendation_reasons = ARRAY['Connects tangent-line meaning to numerical approximation.', 'Targets correct input shift: $\sqrt{4.1}=f(3.1)$.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Use the tangent at $x=3$ because $f(3)=2$ is exact.',
  weight_primary = 0.75,
  weight_supporting = 0.25,
  prompt_type = 'text_and_image',
  representation_type = 'symbolic',
  topic_id = 'Both_Applications',
  updated_at = NOW()
WHERE title = '4.6-P2';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Applications',
  sub_topic_id = '4.6',
  section_id = '4.6',
  type = 'MCQ',
  calculator_allowed = TRUE,
  difficulty = 4,
  target_time_seconds = 150,
  skill_tags = ARRAY['SK_DIFFERENTIALS', 'SK_LINEAR_APPROX', 'SK_DERIV_EVAL'],
  primary_skill_id = 'SK_DIFFERENTIALS',
  supporting_skill_ids = ARRAY['SK_LINEAR_APPROX', 'SK_DERIV_EVAL'],
 'SK_DERIV_EVAL'], 'SK_DERIV_EVAL'],
  error_tags = ARRAY['E_WRONG_POINT', 'E_DERIV_VALUE', 'E_ALGEBRA', 'E_SIGN'],
  prompt = 'Use differentials to approximate $\sqrt[3]{65}$ by linearizing $g(x)=x^{1/3}$ at $x=64$.',
  latex = 'Use differentials to approximate $\sqrt[3]{65}$ by linearizing $g(x)=x^{1/3}$ at $x=64$.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$4.01$','explanation','This typically comes from using a derivative that is too large (for example, $\dfrac{1}{12}$ instead of $\dfrac{1}{48}$).'),
    jsonb_build_object('id','B','text','$4.25$','explanation','This is far too large for a $+1$ change near $64$ because cube roots change slowly there.'),
    jsonb_build_object('id','C','text','$4.020833\ldots$','explanation','Correct. $g(64)=4$, $g''(64)=\dfrac{1}{48}$, so $g(65)\approx 4+\dfrac{1}{48}(1)=4.020833\ldots$.'),
    jsonb_build_object('id','D','text','$3.979167\ldots$','explanation','Sign error: since $65>64$, the cube root must be greater than $4$.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'Let $g(x)=x^{1/3}$. Then $g(64)=4$ and
$$g''(x)=\frac{1}{3}x^{-2/3}.$$
Since $64^{2/3}=(\sqrt[3]{64})^2=16$, we have $g''(64)=\dfrac{1}{3\cdot 16}=\dfrac{1}{48}$. Thus
$$\sqrt[3]{65}=g(65)\approx g(64)+g''(64)(65-64)=4+\frac{1}{48}=4.020833\ldots.$$',
  recommendation_reasons = ARRAY['Reinforces differentials with fractional powers.', 'Targets correct computation of $64^{2/3}$.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.10,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Calculator allowed but the linearization can be done exactly.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Applications',
  updated_at = NOW()
WHERE title = '4.6-P3';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Applications',
  sub_topic_id = '4.6',
  section_id = '4.6',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 1,
  target_time_seconds = 75,
  skill_tags = ARRAY['SK_LOCAL_LINEARITY', 'SK_LINEAR_APPROX'],
  primary_skill_id = 'SK_LOCAL_LINEARITY',
  supporting_skill_ids = ARRAY['SK_LINEAR_APPROX'],

  error_tags = ARRAY['E_SIGN', 'E_ALGEBRA', 'E_UNITS', 'E_WRONG_POINT'],
  prompt = 'If $f(5)=12$ and $f''(5)=-0.8$, use local linearity to approximate $f(5.2)$.',
  latex = 'If $f(5)=12$ and $f''(5)=-0.8$, use local linearity to approximate $f(5.2)$.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$11.84$','explanation','Correct. $f(5.2)\approx 12+(-0.8)(0.2)=11.84$.'),
    jsonb_build_object('id','B','text','$12.16$','explanation','Sign error: a negative derivative means the function decreases as $x$ increases near $5$.'),
    jsonb_build_object('id','C','text','$11.2$','explanation','This uses $\Delta x=1$ instead of $\Delta x=0.2$.'),
    jsonb_build_object('id','D','text','$12.8$','explanation','This treats $-0.8$ as a value to add rather than a rate per unit $x$.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Local linearity at $x=5$ gives
$$f(5.2)\approx f(5)+f''(5)(5.2-5)=12+(-0.8)(0.2)=11.84.$$',
  recommendation_reasons = ARRAY['Fast check of tangent-line approximation mechanics.', 'Targets sign and step-size errors.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 1,
  mastery_weight = 0.85,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Treat $f''(5)$ as the slope of the tangent line at $x=5$.',
  weight_primary = 0.85,
  weight_supporting = 0.15,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Applications',
  updated_at = NOW()
WHERE title = '4.6-P4';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Applications',
  sub_topic_id = '4.6',
  section_id = '4.6',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 5,
  target_time_seconds = 170,
  skill_tags = ARRAY['SK_LINEAR_APPROX', 'SK_LOCAL_LINEARITY', 'SK_DERIV_EVAL'],
  primary_skill_id = 'SK_LINEAR_APPROX',
  supporting_skill_ids = ARRAY['SK_LOCAL_LINEARITY', 'SK_DERIV_EVAL'],
 'SK_DERIV_EVAL'], 'SK_DERIV_EVAL'],
  error_tags = ARRAY['E_WRONG_POINT', 'E_SIGN', 'E_ALGEBRA', 'E_DERIV_VALUE'],
  prompt = 'Let $f(x)=\ln x$. Using the linearization at $x=1$, which estimate is closest to $\ln(1.05)$?',
  latex = 'Let $f(x)=\ln x$. Using the linearization at $x=1$, which estimate is closest to $\ln(1.05)$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$0.0513$','explanation','This is closer to a calculator value, not the linearization at $x=1$.'),
    jsonb_build_object('id','B','text','$0.05$','explanation','Correct. $L(x)=f(1)+f''(1)(x-1)=0+1(x-1)$, so $L(1.05)=0.05$.'),
    jsonb_build_object('id','C','text','$-0.05$','explanation','Sign error: $\ln(1.05)>0$ because $1.05>1$.'),
    jsonb_build_object('id','D','text','$0.025$','explanation','This halves the change without justification; the tangent slope at $1$ is $1$.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'For $f(x)=\ln x$, $f(1)=0$ and $f''(1)=1$. The linearization at $x=1$ is
$$L(x)=f(1)+f''(1)(x-1)=x-1.$$
So
$$\ln(1.05)\approx L(1.05)=1.05-1=0.05.$$',
  recommendation_reasons = ARRAY['Reinforces the standard approximation $\ln(1+u)\approx u$ for small $u$.', 'Targets correct choice of expansion point and sign.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.20,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Near $x=1$, $\ln x$ is well-approximated by its tangent line.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Applications',
  updated_at = NOW()
WHERE title = '4.6-P5';

END $block$;
