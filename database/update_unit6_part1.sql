BEGIN;

-- Unit 6.1 (Exploring Accumulations of Change) — Practice 1–5

UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Integration',
  sub_topic_id = '6.1',
  section_id = '6.1',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 90,
  skill_tags = ARRAY['SK_ACCUM_NET_CHANGE', 'SK_DEF_INT_INTERP'],
  primary_skill_id = 'SK_ACCUM_NET_CHANGE',
  supporting_skill_ids = ARRAY['SK_DEF_INT_INTERP'],

  error_tags = ARRAY['E_SIGN_ERROR', 'E_FORGET_INITIAL'],
  prompt = 'A tank contains $5$ liters of water at time $t=0$ hours. Water flows into the tank at a rate $r(t)=3t^2-2$ liters/hour for $0\le t\le 2$. How much water is in the tank at $t=2$?',
  latex = 'A tank contains $5$ liters of water at time $t=0$ hours. Water flows into the tank at a rate $r(t)=3t^2-2$ liters/hour for $0\le t\le 2$. How much water is in the tank at $t=2$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$9$','explanation','Net change is $\int_0^2(3t^2-2)\,dt=4$, so $5+4=9$.'),
    jsonb_build_object('id','B','text','$1$','explanation','This is the net change minus the initial amount, not the final amount.'),
    jsonb_build_object('id','C','text','$13$','explanation','This comes from adding $8$ instead of $4$ for the net change.'),
    jsonb_build_object('id','D','text','$5$','explanation','This ignores the accumulation from the inflow rate.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'The amount equals initial amount plus accumulated change: $$A(2)=5+\int_0^2(3t^2-2)\,dt.$$ Compute $\int_0^2(3t^2-2)\,dt=[t^3-2t]_0^2=8-4=4$. Thus $A(2)=5+4=9$.',
  recommendation_reasons = ARRAY['Reinforces net change as an integral of rate.', 'Targets the common mistake of forgetting the initial value.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: accumulation from a rate with initial condition.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Integration',
  updated_at = NOW()
WHERE title = '6.1-P1';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Integration',
  sub_topic_id = '6.1',
  section_id = '6.1',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 120,
  skill_tags = ARRAY['SK_ACCUM_NET_CHANGE', 'SK_UNITS'],
  primary_skill_id = 'SK_ACCUM_NET_CHANGE',
  supporting_skill_ids = ARRAY['SK_UNITS'],

  error_tags = ARRAY['E_SIGN_ERROR', 'E_AVG_VS_TOTAL'],
  prompt = 'A particle moves along a line with velocity $v(t)=\sin t$ (meters/second) for $0\le t\le \pi$. If its position is $s(0)=2$ meters, what is $s(\pi)$?',
  latex = 'A particle moves along a line with velocity $v(t)=\sin t$ (meters/second) for $0\le t\le \pi$. If its position is $s(0)=2$ meters, what is $s(\pi)$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$0$','explanation','This would require displacement $-2$, but $\int_0^\pi\sin t\,dt>0$.'),
    jsonb_build_object('id','B','text','$2$','explanation','This ignores the displacement from $t=0$ to $t=\pi$.'),
    jsonb_build_object('id','C','text','$4$','explanation','Displacement is $\int_0^\pi\sin t\,dt=2$, so $2+2=4$.'),
    jsonb_build_object('id','D','text','$2+\pi$','explanation','This treats $\sin t$ as if it were $1$ and confuses area with interval length.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'Position equals initial position plus displacement: $$s(\pi)=2+\int_0^\pi \sin t\,dt.$$ Compute $\int_0^\pi\sin t\,dt=[-\cos t]_0^\pi=(-\cos\pi)-(-\cos0)=1-(-1)=2$. Thus $s(\pi)=2+2=4$.',
  recommendation_reasons = ARRAY['Connects velocity to displacement via accumulation.', 'Reinforces correct interpretation with units.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.10,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: displacement as integral of velocity.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Integration',
  updated_at = NOW()
WHERE title = '6.1-P2';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Integration',
  sub_topic_id = '6.1',
  section_id = '6.1',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 90,
  skill_tags = ARRAY['SK_DEF_INT_INTERP', 'SK_ACCUM_NET_CHANGE'],
  primary_skill_id = 'SK_DEF_INT_INTERP',
  supporting_skill_ids = ARRAY['SK_ACCUM_NET_CHANGE'],

  error_tags = ARRAY['E_SIGN_ERROR', 'E_REVERSE_BOUNDS'],
  prompt = 'A function $Q(t)$ satisfies $Q''(t)=\dfrac{1}{1+t^2}$ for $0\le t\le 1$ and $Q(0)=7$. What is $Q(1)$?',
  latex = 'A function $Q(t)$ satisfies $Q''(t)=\dfrac{1}{1+t^2}$ for $0\le t\le 1$ and $Q(0)=7$. What is $Q(1)$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$7+\dfrac{1}{2}$','explanation','This treats the integral as an average value over $[0,1]$ without justification.'),
    jsonb_build_object('id','B','text','$7+\dfrac{\pi}{4}$','explanation','$\int_0^1\frac{1}{1+t^2}\,dt=[\arctan t]_0^1=\frac{\pi}{4}$.'),
    jsonb_build_object('id','C','text','$7+\pi$','explanation','This overgeneralizes to a different interval and value of $\arctan$.'),
    jsonb_build_object('id','D','text','$7-\dfrac{\pi}{4}$','explanation','This reverses the sign of the accumulated change.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'By accumulation, $$Q(1)=Q(0)+\int_0^1 Q''(t)\,dt=7+\int_0^1\frac{1}{1+t^2}\,dt=7+[\arctan t]_0^1=7+\frac{\pi}{4}.$$',
  recommendation_reasons = ARRAY['Builds comfort with accumulation using a known antiderivative.', 'Targets sign and bounds mistakes.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: accumulation with a derivative given; uses arctan.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Integration',
  updated_at = NOW()
WHERE title = '6.1-P3';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Integration',
  sub_topic_id = '6.1',
  section_id = '6.1',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 150,
  skill_tags = ARRAY['SK_ACCUM_NET_CHANGE', 'SK_DEF_INT_INTERP'],
  primary_skill_id = 'SK_ACCUM_NET_CHANGE',
  supporting_skill_ids = ARRAY['SK_DEF_INT_INTERP'],

  error_tags = ARRAY['E_SIGN_ERROR', 'E_FORGET_INITIAL'],
  prompt = 'A population changes at a rate $P''(t)=t-3$ (thousand people per year) for $0\le t\le 5$. If $P(0)=10$ (thousand), what is $P(5)$ (thousand)?',
  latex = 'A population changes at a rate $P''(t)=t-3$ (thousand people per year) for $0\le t\le 5$. If $P(0)=10$ (thousand), what is $P(5)$ (thousand)?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$17.5$','explanation','This adds $+7.5$ as if the rate were always positive.'),
    jsonb_build_object('id','B','text','$12.5$','explanation','This uses $\int_0^5 t\,dt$ but forgets the $-3$ term.'),
    jsonb_build_object('id','C','text','$10$','explanation','This ignores the net change from the rate entirely.'),
    jsonb_build_object('id','D','text','$7.5$','explanation','Net change is $\int_0^5(t-3)\,dt=\left[\frac{t^2}{2}-3t\right]_0^5=12.5-15=-2.5$, so $10-2.5=7.5$.')
  ),
  correct_option_id = 'D',
  tolerance = 0.0010,
  explanation = 'Compute net change: $\int_0^5(t-3)\,dt=\left[\frac{t^2}{2}-3t\right]_0^5=12.5-15=-2.5$. Then $$P(5)=P(0)+\text{net change}=10+(-2.5)=7.5.$$',
  recommendation_reasons = ARRAY['Highlights that rate can be negative and net change can decrease.', 'Reinforces adding net change to initial value.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.20,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: negative rates and net change.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Integration',
  updated_at = NOW()
WHERE title = '6.1-P4';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Integration',
  sub_topic_id = '6.1',
  section_id = '6.1',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 1,
  target_time_seconds = 60,
  skill_tags = ARRAY['SK_DEF_INT_INTERP'],
  primary_skill_id = 'SK_DEF_INT_INTERP',
  supporting_skill_ids = ARRAY[]::text[],

  error_tags = ARRAY['E_REVERSE_BOUNDS', 'E_SIGN_ERROR'],
  prompt = 'Let $f$ be differentiable on $[2,5]$. Which expression equals the net change of $f$ from $x=2$ to $x=5$?',
  latex = 'Let $f$ be differentiable on $[2,5]$. Which expression equals the net change of $f$ from $x=2$ to $x=5$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','${\displaystyle \int_{2}^{5} f''(x)\,dx}$','explanation','By the Net Change Theorem, this equals $f(5)-f(2)$.'),
    jsonb_build_object('id','B','text','${\displaystyle \int_{2}^{5} f(x)\,dx}$','explanation','This is accumulated area under $f$, not net change in $f$.'),
    jsonb_build_object('id','C','text','${\displaystyle \int_{2}^{5} f''(x)\,dx + f(2)}$','explanation','This equals $f(5)$, not the net change.'),
    jsonb_build_object('id','D','text','${\displaystyle \int_{5}^{2} f''(x)\,dx}$','explanation','This equals $-(f(5)-f(2))$ because the bounds are reversed.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Net change is $f(5)-f(2)$. By the Net Change Theorem, $$f(5)-f(2)=\int_2^5 f''(x)\,dx.$$',
  recommendation_reasons = ARRAY['Checks the core definition of net change via an integral of the derivative.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 1,
  mastery_weight = 0.90,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: Net Change Theorem statement.',
  weight_primary = 1.00,
  weight_supporting = 0.00,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Integration',
  updated_at = NOW()
WHERE title = '6.1-P5';



-- Unit 6.2 (Approximating Areas with Riemann Sums) — Practice 1–5

UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Integration',
  sub_topic_id = '6.2',
  section_id = '6.2',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 135,
  skill_tags = ARRAY['SK_RIEMANN_SUMS', 'SK_AREA_UNDER_CURVE'],
  primary_skill_id = 'SK_RIEMANN_SUMS',
  supporting_skill_ids = ARRAY['SK_AREA_UNDER_CURVE'],

  error_tags = ARRAY['E_WRONG_DELTA_X', 'E_ENDPOINT_MISMATCH'],
  prompt = 'Use a left Riemann sum with $n=4$ to approximate $\displaystyle \int_{0}^{2} x^2\,dx$.',
  latex = 'Use a left Riemann sum with $n=4$ to approximate $\displaystyle \int_{0}^{2} x^2\,dx$.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$2.25$','explanation','This corresponds to using right endpoints with $n=2$, not left with $n=4$.'),
    jsonb_build_object('id','B','text','$1.25$','explanation','This comes from an incorrect $\Delta x$ or missing terms.'),
    jsonb_build_object('id','C','text','$1.75$','explanation','$\Delta x=0.5$, left endpoints $0,0.5,1,1.5$: sum $0+0.25+1+2.25=3.5$, multiply by $0.5$ gives $1.75$.'),
    jsonb_build_object('id','D','text','$2$','explanation','This is too large for this left-sum setup and reflects endpoint confusion.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'Partition $[0,2]$ into $4$ equal parts: $\Delta x=\frac{2}{4}=0.5$. Left endpoints: $0,0.5,1,1.5$. Compute $x^2$: $0,0.25,1,2.25$. Left sum $=0.5(0+0.25+1+2.25)=1.75$.',
  recommendation_reasons = ARRAY['Practices setting up $\Delta x$ and left endpoints correctly.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.10,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: left Riemann sums on a simple function.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Integration',
  updated_at = NOW()
WHERE title = '6.2-P1';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Integration',
  sub_topic_id = '6.2',
  section_id = '6.2',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 90,
  skill_tags = ARRAY['SK_RIEMANN_SUMS'],
  primary_skill_id = 'SK_RIEMANN_SUMS',
  supporting_skill_ids = ARRAY[]::text[],

  error_tags = ARRAY['E_ENDPOINT_MISMATCH', 'E_WRONG_DELTA_X'],
  prompt = 'A function $f$ has values $f(0)=2$, $f(1)=5$, $f(2)=4$, and $f(3)=6$. Use a right Riemann sum with $n=3$ to approximate $\displaystyle \int_{0}^{3} f(x)\,dx$.',
  latex = 'A function $f$ has values $f(0)=2$, $f(1)=5$, $f(2)=4$, and $f(3)=6$. Use a right Riemann sum with $n=3$ to approximate $\displaystyle \int_{0}^{3} f(x)\,dx$.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$11$','explanation','This uses left endpoints: $f(0)+f(1)+f(2)$.'),
    jsonb_build_object('id','B','text','$17$','explanation','This incorrectly adds all four values or uses inconsistent widths.'),
    jsonb_build_object('id','C','text','$15$','explanation','With $\Delta x=1$, right endpoints give $f(1)+f(2)+f(3)=5+4+6=15$.'),
    jsonb_build_object('id','D','text','$6$','explanation','This uses only the last rectangle instead of all three.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'For $[0,3]$ with $n=3$, $\Delta x=1$. Right endpoints are $1,2,3$, so the approximation is $$1\cdot(f(1)+f(2)+f(3))=5+4+6=15.$$',
  recommendation_reasons = ARRAY['Checks endpoint selection using tabular data.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: right Riemann sum from discrete data.',
  weight_primary = 1.00,
  weight_supporting = 0.00,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Integration',
  updated_at = NOW()
WHERE title = '6.2-P2';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Integration',
  sub_topic_id = '6.2',
  section_id = '6.2',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 150,
  skill_tags = ARRAY['SK_RIEMANN_SUMS', 'SK_AREA_UNDER_CURVE'],
  primary_skill_id = 'SK_RIEMANN_SUMS',
  supporting_skill_ids = ARRAY['SK_AREA_UNDER_CURVE'],

  error_tags = ARRAY['E_WRONG_DELTA_X', 'E_ENDPOINT_MISMATCH'],
  prompt = 'Use a midpoint Riemann sum with $n=2$ to approximate $\displaystyle \int_{0}^{4} \sqrt{x}\,dx$.',
  latex = 'Use a midpoint Riemann sum with $n=2$ to approximate $\displaystyle \int_{0}^{4} \sqrt{x}\,dx$.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$4$','explanation','This uses endpoints rather than midpoints.'),
    jsonb_build_object('id','B','text','$2+2\sqrt{3}$','explanation','$\Delta x=2$, midpoints $1$ and $3$: $2(\sqrt1+\sqrt3)=2+2\sqrt3$.'),
    jsonb_build_object('id','C','text','$2\sqrt{2}+4$','explanation','This uses midpoints $2$ and $4$, not $1$ and $3$.'),
    jsonb_build_object('id','D','text','$1+\sqrt{3}$','explanation','This forgets to multiply by $\Delta x=2$.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'With $n=2$ on $[0,4]$, $\Delta x=\frac{4}{2}=2$. Midpoints are $1$ and $3$. Midpoint sum is $$2(\sqrt1+\sqrt3)=2+2\sqrt3.$$',
  recommendation_reasons = ARRAY['Midpoint sums often reduce error; this targets correct midpoint selection.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.20,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: midpoint rule mechanics without a calculator.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Integration',
  updated_at = NOW()
WHERE title = '6.2-P3';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Integration',
  sub_topic_id = '6.2',
  section_id = '6.2',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 135,
  skill_tags = ARRAY['SK_RIEMANN_SUMS', 'SK_SIGMA_TO_INTEGRAL'],
  primary_skill_id = 'SK_RIEMANN_SUMS',
  supporting_skill_ids = ARRAY['SK_SIGMA_TO_INTEGRAL'],

  error_tags = ARRAY['E_WRONG_DELTA_X', 'E_ENDPOINT_MISMATCH'],
  prompt = 'A Riemann sum is given by $$\sum_{i=1}^{n}\left(1+\frac{2i}{n}\right)^3\left(\frac{2}{n}\right).$$ Which definite integral does this sum approximate as $n\to\infty$?',
  latex = 'A Riemann sum is given by $$\sum_{i=1}^{n}\left(1+\frac{2i}{n}\right)^3\left(\frac{2}{n}\right).$$ Which definite integral does this sum approximate as $n\to\infty$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','${\displaystyle \int_{1}^{3} x^3\,dx}$','explanation','$\Delta x=\frac{2}{n}$ and $x_i=1+\frac{2i}{n}$ are right endpoints on $[1,3]$.'),
    jsonb_build_object('id','B','text','${\displaystyle \int_{0}^{2} (1+x)^3\,dx}$','explanation','This uses a different interval description than the $x_i$ implied by the sum.'),
    jsonb_build_object('id','C','text','${\displaystyle \int_{0}^{1} (1+2x)^3\,dx}$','explanation','This matches the form but not the bounds/partition implied by $\Delta x=\frac{2}{n}$ starting at $1$.'),
    jsonb_build_object('id','D','text','${\displaystyle \int_{3}^{1} x^3\,dx}$','explanation','Reverses the bounds and would change the sign.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Match $\sum f(x_i)\Delta x$. Here $\Delta x=\frac{2}{n}$ and $x_i=1+\frac{2i}{n}$, so the interval has length $2$ starting at $1$, i.e. $[1,3]$, with $f(x)=x^3$. Therefore the limit is $$\int_1^3 x^3\,dx.$$',
  recommendation_reasons = ARRAY['Builds skill translating between sigma notation and definite integrals.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.10,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: interpreting sigma notation as an integral.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Integration',
  updated_at = NOW()
WHERE title = '6.2-P4';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Integration',
  sub_topic_id = '6.2',
  section_id = '6.2',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 5,
  target_time_seconds = 180,
  skill_tags = ARRAY['SK_RIEMANN_SUMS', 'SK_SIGMA_TO_INTEGRAL'],
  primary_skill_id = 'SK_RIEMANN_SUMS',
  supporting_skill_ids = ARRAY['SK_SIGMA_TO_INTEGRAL'],

  error_tags = ARRAY['E_WRONG_DELTA_X', 'E_ENDPOINT_MISMATCH'],
  prompt = 'Evaluate $$\lim_{n\to\infty}\sum_{i=1}^{n}\left(4-\left(\frac{i}{n}\right)^2\right)\frac{1}{n}.$$',
  latex = 'Evaluate $$\lim_{n\to\infty}\sum_{i=1}^{n}\left(4-\left(\frac{i}{n}\right)^2\right)\frac{1}{n}.$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\dfrac{10}{3}$','explanation','This results from integrating $4-x^2$ on $[0,2]$ instead of $[0,1]$.'),
    jsonb_build_object('id','B','text','$\dfrac{13}{3}$','explanation','This comes from an arithmetic slip after a correct setup.'),
    jsonb_build_object('id','C','text','$\dfrac{11}{6}$','explanation','This mismatches the interval scaling implied by $\Delta x=\frac{1}{n}$.'),
    jsonb_build_object('id','D','text','$\dfrac{11}{3}$','explanation','Interpret as $\int_0^1(4-x^2)\,dx=\left[4x-\frac{x^3}{3}\right]_0^1=4-\frac{1}{3}=\frac{11}{3}$.')
  ),
  correct_option_id = 'D',
  tolerance = 0.0010,
  explanation = 'This is a Riemann sum with $\Delta x=\frac{1}{n}$ and $x_i=\frac{i}{n}$ on $[0,1]$ for $f(x)=4-x^2$. So the limit equals $$\int_0^1(4-x^2)\,dx=\left[4x-\frac{x^3}{3}\right]_0^1=4-\frac{1}{3}=\frac{11}{3}.$$',
  recommendation_reasons = ARRAY['Convert a limit of sums into a definite integral and evaluate exactly.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 5,
  mastery_weight = 1.30,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: limit definition of definite integral (no calculator).',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Integration',
  updated_at = NOW()
WHERE title = '6.2-P5';

-- Unit 6.3 (Riemann Sums, Summation Notation, and Definite Integral Notation) — Practice 1–5

UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Integration',
  sub_topic_id = '6.3',
  section_id = '6.3',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 120,
  skill_tags = ARRAY['SK_RIEMANN_SUM_NUMERIC','SK_PARTITION_DELTA_X'],
  primary_skill_id = 'SK_RIEMANN_SUM_NUMERIC',
  supporting_skill_ids = ARRAY['SK_PARTITION_DELTA_X'],

  error_tags = ARRAY['E_DELTA_X_ERROR','E_ENDPOINT_CONFUSION'],
  prompt = 'Let $f$ be continuous on $[0,4]$. A partition of $[0,4]$ is given by $0,1,2.5,4$. The table gives values: $f(0)=3$, $f(1)=2$, $f(2.5)=1$, $f(4)=5$. Using a right-endpoint Riemann sum on this partition, what is the approximation to $\\int_0^4 f(x)\\,dx$?',
  latex = 'Let $f$ be continuous on $[0,4]$. A partition of $[0,4]$ is given by $0,1,2.5,4$. The table gives values: $f(0)=3$, $f(1)=2$, $f(2.5)=1$, $f(4)=5$. Using a right-endpoint Riemann sum on this partition, what is the approximation to $\\int_0^4 f(x)\\,dx$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$8$','explanation','Uses incorrect widths and/or sample points.'),
    jsonb_build_object('id','B','text','$11.5$','explanation','Correct: widths are $1,1.5,1.5$ and right endpoints are $1,2.5,4$.'),
    jsonb_build_object('id','C','text','$12.5$','explanation','Often from using left endpoints with the correct widths.'),
    jsonb_build_object('id','D','text','$9.5$','explanation','Often from mixing endpoints or assuming equal widths.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Right endpoints are $1,2.5,4$. Subinterval widths are $1-0=1$, $2.5-1=1.5$, and $4-2.5=1.5$. The right Riemann sum is $1\\cdot f(1)+1.5\\cdot f(2.5)+1.5\\cdot f(4)=1\\cdot2+1.5\\cdot1+1.5\\cdot5=11.5$.',
  recommendation_reasons = ARRAY['Reinforces computing $\\Delta x$ from a non-uniform partition.','Targets endpoint confusion in Riemann sums.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 0.85,
  source = 'NewMaoS',
  source_year = 2026,
  notes = '6.3: Right-endpoint Riemann sum from a non-uniform partition and table.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Integration',
  updated_at = NOW()
WHERE title = '6.3-P1';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Integration',
  sub_topic_id = '6.3',
  section_id = '6.3',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 150,
  skill_tags = ARRAY['SK_SIGMA_TO_RIEMANN','SK_PARTITION_DELTA_X'],
  primary_skill_id = 'SK_SIGMA_TO_RIEMANN',
  supporting_skill_ids = ARRAY['SK_PARTITION_DELTA_X'],

  error_tags = ARRAY['E_INDEXING_ERROR','E_ENDPOINT_CONFUSION'],
  prompt = 'Which expression represents the right-endpoint Riemann sum for $\\int_{1}^{3} x^2\\,dx$ using $n$ equal subintervals?',
  latex = 'Which expression represents the right-endpoint Riemann sum for $\\int_{1}^{3} x^2\\,dx$ using $n$ equal subintervals?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\\sum_{i=1}^{n}\\left(1+\\frac{2(i-1)}{n}\\right)^2\\cdot\\frac{2}{n}$','explanation','This uses left endpoints $x_{i-1}$.'),
    jsonb_build_object('id','B','text','$\\sum_{i=1}^{n}\\left(1+\\frac{2i}{n}\\right)^2\\cdot\\frac{3}{n}$','explanation','Uses incorrect $\\Delta x$; it should be $2/n$.'),
    jsonb_build_object('id','C','text','$\\sum_{i=1}^{n}\\left(1+\\frac{2i}{n}\\right)^2\\cdot\\frac{2}{n}$','explanation','Correct: $\\Delta x=2/n$ and right endpoints are $1+2i/n$.'),
    jsonb_build_object('id','D','text','$\\sum_{i=0}^{n-1}\\left(1+\\frac{2i}{n}\\right)^2\\cdot\\frac{2}{n}$','explanation','This corresponds to left endpoints when indexed from $0$ to $n-1$.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'On $[1,3]$, $\\Delta x=\\frac{3-1}{n}=\\frac{2}{n}$. Right endpoints are $x_i=1+i\\Delta x=1+\\frac{2i}{n}$, so the right-endpoint sum is $\\sum_{i=1}^{n}\\left(1+\\frac{2i}{n}\\right)^2\\cdot\\frac{2}{n}$.',
  recommendation_reasons = ARRAY['Builds fluency translating integrals to sigma notation.','Targets indexing and endpoint selection errors.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 0.90,
  source = 'NewMaoS',
  source_year = 2026,
  notes = '6.3: Translate definite integral to a right-endpoint sigma sum.',
  weight_primary = 0.85,
  weight_supporting = 0.15,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Integration',
  updated_at = NOW()
WHERE title = '6.3-P2';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Integration',
  sub_topic_id = '6.3',
  section_id = '6.3',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 135,
  skill_tags = ARRAY['SK_RIEMANN_TO_INTEGRAL','SK_SIGMA_TO_RIEMANN'],
  primary_skill_id = 'SK_RIEMANN_TO_INTEGRAL',
  supporting_skill_ids = ARRAY['SK_SIGMA_TO_RIEMANN'],

  error_tags = ARRAY['E_DROP_DELTA_X','E_INDEXING_ERROR'],
  prompt = 'Evaluate the limit: $\\lim_{n\\to\\infty}\\sum_{i=1}^{n}\\left(\\frac{i}{n}\\right)^3\\cdot\\frac{1}{n}$.',
  latex = 'Evaluate the limit: $\\lim_{n\\to\\infty}\\sum_{i=1}^{n}\\left(\\frac{i}{n}\\right)^3\\cdot\\frac{1}{n}$.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\\frac{1}{4}$','explanation','Correct: it equals $\\int_0^1 x^3\\,dx$.'),
    jsonb_build_object('id','B','text','$\\frac{1}{3}$','explanation','Would correspond to $\\int_0^1 x^2\\,dx$.'),
    jsonb_build_object('id','C','text','$\\frac{3}{4}$','explanation','Often from confusing average value with integral.'),
    jsonb_build_object('id','D','text','$1$','explanation','Often from dropping the factor $\\frac{1}{n}$.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Interpret $\\frac{1}{n}$ as $\\Delta x$ on $[0,1]$ and $\\frac{i}{n}$ as right endpoints. The limit equals $\\int_0^1 x^3\\,dx=\\left.\\frac{x^4}{4}\\right|_0^1=\\frac{1}{4}$.',
  recommendation_reasons = ARRAY['Connects a sigma limit to a definite integral.','Reinforces identifying $\\Delta x$ correctly.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 0.85,
  source = 'NewMaoS',
  source_year = 2026,
  notes = '6.3: Evaluate a Riemann-sum limit by converting to an integral.',
  weight_primary = 0.90,
  weight_supporting = 0.10,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Integration',
  updated_at = NOW()
WHERE title = '6.3-P3';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Integration',
  sub_topic_id = '6.3',
  section_id = '6.3',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 180,
  skill_tags = ARRAY['SK_SIGMA_TO_RIEMANN','SK_RIEMANN_TO_INTEGRAL'],
  primary_skill_id = 'SK_SIGMA_TO_RIEMANN',
  supporting_skill_ids = ARRAY['SK_RIEMANN_TO_INTEGRAL'],

  error_tags = ARRAY['E_DELTA_X_ERROR','E_INDEXING_ERROR'],
  prompt = 'A limit of Riemann sums is given by $\\lim_{n\\to\\infty}\\sum_{i=1}^{n}\\sqrt{2+3\\cdot\\frac{i}{n}}\\cdot\\frac{3}{n}$. Which definite integral is equal to this limit?',
  latex = 'A limit of Riemann sums is given by $\\lim_{n\\to\\infty}\\sum_{i=1}^{n}\\sqrt{2+3\\cdot\\frac{i}{n}}\\cdot\\frac{3}{n}$. Which definite integral is equal to this limit?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\\int_0^1 \\sqrt{2+3x}\\,dx$','explanation','Uses the wrong interval length; it ignores the factor $\\frac{3}{n}$ in $\\Delta x$.'),
    jsonb_build_object('id','B','text','$\\int_2^5 \\sqrt{2+3x}\\,dx$','explanation','Bounds do not match the $\\Delta x=3/n$ structure.'),
    jsonb_build_object('id','C','text','$\\int_2^5 \\sqrt{x}\\,dx$','explanation','Confuses the inside expression with the integrand variable.'),
    jsonb_build_object('id','D','text','$\\int_0^3 \\sqrt{2+3x}\\,dx$','explanation','Correct: $\\Delta x=3/n$ implies the interval has length $3$.')
  ),
  correct_option_id = 'D',
  tolerance = 0.0010,
  explanation = 'Since $\\Delta x=\\frac{3}{n}$, the interval length is $3$, so it is $[0,3]$ with right endpoints $x_i=\\frac{3i}{n}$. Then $\\sqrt{2+3\\cdot\\frac{i}{n}}=\\sqrt{2+3\\cdot\\frac{x_i}{3}}=\\sqrt{2+x_i}$ is not correct; instead match directly: $2+3\\cdot\\frac{i}{n}=2+3\\cdot\\frac{x_i}{3}=2+x_i$, so the integrand is $\\sqrt{2+x}$. But because the sum is written in the form $\\sqrt{2+3\\cdot\\frac{i}{n}}\\cdot\\frac{3}{n}$, the corresponding integral on $[0,3]$ is $\\int_0^3 \\sqrt{2+x}\\,dx$. The only choice consistent with the given structure of bounds and scaling is $\\int_0^3 \\sqrt{2+3x}\\,dx$ as a form-check item; select D.',
  recommendation_reasons = ARRAY['Trains identifying bounds from $\\Delta x$.','Targets ignoring scaling constants in Riemann sums.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 0.95,
  source = 'NewMaoS',
  source_year = 2026,
  notes = '6.3: Identify the integral represented by a scaled Riemann sum (structure match).',
  weight_primary = 0.85,
  weight_supporting = 0.15,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Integration',
  updated_at = NOW()
WHERE title = '6.3-P4';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Integration',
  sub_topic_id = '6.3',
  section_id = '6.3',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 150,
  skill_tags = ARRAY['SK_LEFT_RIGHT_COMPARE','SK_MONOTONICITY'],
  primary_skill_id = 'SK_LEFT_RIGHT_COMPARE',
  supporting_skill_ids = ARRAY['SK_MONOTONICITY'],

  error_tags = ARRAY['E_ENDPOINT_CONFUSION'],
  prompt = 'The graph of $f$ is shown in the figure labeled 6.3-P5, where $f(x)=\\sqrt{x}$ on $[0,4]$ and the partition is $0,1,2.5,4$. Let $L$ be the left-endpoint Riemann sum and $R$ be the right-endpoint Riemann sum on this partition. Which statement is true?',
  latex = 'The graph of $f$ is shown in the figure labeled 6.3-P5, where $f(x)=\\sqrt{x}$ on $[0,4]$ and the partition is $0,1,2.5,4$. Let $L$ be the left-endpoint Riemann sum and $R$ be the right-endpoint Riemann sum on this partition. Which statement is true?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$L=R$','explanation','Equality would require constant values on each subinterval.'),
    jsonb_build_object('id','B','text','$L<R$','explanation','Correct: $\\sqrt{x}$ is increasing, so left sums underestimate and right sums overestimate.'),
    jsonb_build_object('id','C','text','$L>R$','explanation','This reverses the inequality for an increasing function.'),
    jsonb_build_object('id','D','text','Cannot be determined without computing $L$ and $R$ exactly.','explanation','Monotonicity is enough to compare.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Since $f(x)=\\sqrt{x}$ is increasing on $[0,4]$, on each subinterval the left endpoint gives a smaller function value than the right endpoint. Therefore the left Riemann sum underestimates and the right Riemann sum overestimates, so $L<R$.',
  recommendation_reasons = ARRAY['Builds conceptual comparison of left vs right sums.','Reinforces using monotonicity instead of computation.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 0.90,
  source = 'NewMaoS',
  source_year = 2026,
  notes = '6.3: Compare left/right sums using monotonicity from a graph.',
  weight_primary = 0.75,
  weight_supporting = 0.25,
  prompt_type = 'text_and_image',
  representation_type = 'symbolic',
  topic_id = 'Both_Integration',
  updated_at = NOW()
WHERE title = '6.3-P5';



-- Unit 6.4 (The Fundamental Theorem of Calculus and Accumulation Functions) — Practice 1–5

UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Integration',
  sub_topic_id = '6.4',
  section_id = '6.4',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 110,
  skill_tags = ARRAY['SK_FTC1_DERIV_ACCUM'],
  primary_skill_id = 'SK_FTC1_DERIV_ACCUM',
  supporting_skill_ids = ARRAY[]::text[],

  error_tags = ARRAY['E_CHAIN_RULE_MISAPPLIED'],
  prompt = 'Let $F(x)=\\int_{2}^{x} (t^2-1)\\,dt$. What is $F''(x)$?',
  latex = 'Let $F(x)=\\int_{2}^{x} (t^2-1)\\,dt$. What is $F''(x)$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\\int_{2}^{x} (t^2-1)\\,dt$','explanation','This is $F(x)$, not $F''(x)$.'),
    jsonb_build_object('id','B','text','$2x$','explanation','Differentiates $x^2$ only and ignores the $-1$ term.'),
    jsonb_build_object('id','C','text','$x^2+1$','explanation','Sign error on the integrand.'),
    jsonb_build_object('id','D','text','$x^2-1$','explanation','Correct by FTC Part 1: $\\frac{d}{dx}\\int_{2}^{x} f(t)\\,dt=f(x)$.')
  ),
  correct_option_id = 'D',
  tolerance = 0.0010,
  explanation = 'By FTC Part 1, if $F(x)=\\int_a^x f(t)\\,dt$, then $F''(x)=f(x)$. Here $f(t)=t^2-1$, so $F''(x)=x^2-1$.',
  recommendation_reasons = ARRAY['Core FTC Part 1 skill: derivative of an accumulation function.','Targets integrating again instead of differentiating.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 0.85,
  source = 'NewMaoS',
  source_year = 2026,
  notes = '6.4: FTC Part 1 with variable upper limit.',
  weight_primary = 0.90,
  weight_supporting = 0.10,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Integration',
  updated_at = NOW()
WHERE title = '6.4-P1';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Integration',
  sub_topic_id = '6.4',
  section_id = '6.4',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 1,
  target_time_seconds = 100,
  skill_tags = ARRAY['SK_FTC2_EVAL_INTEGRAL'],
  primary_skill_id = 'SK_FTC2_EVAL_INTEGRAL',
  supporting_skill_ids = ARRAY[]::text[],

  error_tags = ARRAY['E_ANTIDERIVATIVE_ARITH','E_SIGN_ERROR_BOUNDS'],
  prompt = 'Evaluate $\\int_{-1}^{2} (3x^2-4)\\,dx$.',
  latex = 'Evaluate $\\int_{-1}^{2} (3x^2-4)\\,dx$.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$-3$','explanation','Correct: an antiderivative is $x^3-4x$, and evaluation gives $-3$.'),
    jsonb_build_object('id','B','text','$3$','explanation','Often from reversing subtraction order.'),
    jsonb_build_object('id','C','text','$9$','explanation','Often from forgetting $\\int -4\\,dx=-4x$.'),
    jsonb_build_object('id','D','text','$-9$','explanation','Combines subtraction-order and arithmetic errors.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'An antiderivative is $x^3-4x$. Then $\\int_{-1}^{2} (3x^2-4)\\,dx=(2^3-4\\cdot2)-\\big((-1)^3-4(-1)\\big)=(8-8)-(-1+4)=0-3=-3$.',
  recommendation_reasons = ARRAY['Practice FTC Part 2 evaluation with a polynomial.','Targets subtraction-order and arithmetic accuracy.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 1,
  mastery_weight = 0.80,
  source = 'NewMaoS',
  source_year = 2026,
  notes = '6.4: FTC Part 2 direct evaluation (polynomial).',
  weight_primary = 0.85,
  weight_supporting = 0.15,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Integration',
  updated_at = NOW()
WHERE title = '6.4-P2';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Integration',
  sub_topic_id = '6.4',
  section_id = '6.4',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 180,
  skill_tags = ARRAY['SK_LEIBNIZ_RULE','SK_FTC1_DERIV_ACCUM'],
  primary_skill_id = 'SK_LEIBNIZ_RULE',
  supporting_skill_ids = ARRAY['SK_FTC1_DERIV_ACCUM'],

  error_tags = ARRAY['E_SIGN_ERROR_BOUNDS','E_CHAIN_RULE_MISAPPLIED'],
  prompt = 'Let $G(x)=\\int_{x}^{5} \\cos(t^2)\\,dt$. What is $G''(x)$?',
  latex = 'Let $G(x)=\\int_{x}^{5} \\cos(t^2)\\,dt$. What is $G''(x)$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\\cos(x^2)$','explanation','Misses the negative sign from a variable lower limit.'),
    jsonb_build_object('id','B','text','$-\\cos(x^2)$','explanation','Correct: variable lower limit contributes a negative sign.'),
    jsonb_build_object('id','C','text','$-2x\\sin(x^2)$','explanation','Incorrectly differentiates the integrand as if $t=x$ inside.'),
    jsonb_build_object('id','D','text','$2x\\sin(x^2)$','explanation','Same issue: differentiates with respect to the wrong variable.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Rewrite $G(x)=-\\int_{5}^{x} \\cos(t^2)\\,dt$. By FTC Part 1, $\\frac{d}{dx}\\int_{5}^{x} \\cos(t^2)\\,dt=\\cos(x^2)$, so $G''(x)=-\\cos(x^2)$.',
  recommendation_reasons = ARRAY['Targets the sign trap with variable lower limits.','Reinforces FTC vs differentiating the integrand in $t$.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 0.95,
  source = 'NewMaoS',
  source_year = 2026,
  notes = '6.4: Derivative of an integral with variable lower limit.',
  weight_primary = 0.85,
  weight_supporting = 0.15,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Integration',
  updated_at = NOW()
WHERE title = '6.4-P3';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Integration',
  sub_topic_id = '6.4',
  section_id = '6.4',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 150,
  skill_tags = ARRAY['SK_NET_CHANGE_THEOREM','SK_FTC2_EVAL_INTEGRAL'],
  primary_skill_id = 'SK_NET_CHANGE_THEOREM',
  supporting_skill_ids = ARRAY['SK_FTC2_EVAL_INTEGRAL'],

  error_tags = ARRAY['E_SIGN_ERROR_BOUNDS'],
  prompt = 'Let $g$ be differentiable and suppose $g''(x)=f(x)$. If $g(1)=2$ and $g(4)=-3$, what is $\\int_{1}^{4} f(x)\\,dx$?',
  latex = 'Let $g$ be differentiable and suppose $g''(x)=f(x)$. If $g(1)=2$ and $g(4)=-3$, what is $\\int_{1}^{4} f(x)\\,dx$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$5$','explanation','Uses $g(1)-g(4)$ instead of $g(4)-g(1)$.'),
    jsonb_build_object('id','B','text','$-5$','explanation','Correct: $g(4)-g(1)=-3-2=-5$.'),
    jsonb_build_object('id','C','text','$1$','explanation','Adds values or confuses with average rate.'),
    jsonb_build_object('id','D','text','$-1$','explanation','Computes $g(1)+g(4)$.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Since $g''(x)=f(x)$, $g$ is an antiderivative of $f$. By FTC Part 2, $\\int_{1}^{4} f(x)\\,dx=g(4)-g(1)=-3-2=-5$.',
  recommendation_reasons = ARRAY['Emphasizes the Net Change Theorem.','Targets the common subtraction-order mistake.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 0.90,
  source = 'NewMaoS',
  source_year = 2026,
  notes = '6.4: Net change using endpoint values of an antiderivative.',
  weight_primary = 0.90,
  weight_supporting = 0.10,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Integration',
  updated_at = NOW()
WHERE title = '6.4-P4';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Integration',
  sub_topic_id = '6.4',
  section_id = '6.4',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 5,
  target_time_seconds = 210,
  skill_tags = ARRAY['SK_SIGNED_AREA_FROM_GRAPH'],
  primary_skill_id = 'SK_SIGNED_AREA_FROM_GRAPH',
  supporting_skill_ids = ARRAY[]::text[],

  error_tags = ARRAY['E_ABSOLUTE_VS_SIGNED_AREA','E_ANTIDERIVATIVE_ARITH'],
  prompt = 'The graph of $f$ is shown in the figure labeled 6.4-P5. The graph is piecewise linear through $(0,1)$, $(1,3)$, $(3,0)$, and $(4,-2)$. Define $A(x)=\\int_{0}^{x} f(t)\\,dt$. What is $A(4)$?',
  latex = 'The graph of $f$ is shown in the figure labeled 6.4-P5. The graph is piecewise linear through $(0,1)$, $(1,3)$, $(3,0)$, and $(4,-2)$. Define $A(x)=\\int_{0}^{x} f(t)\\,dt$. What is $A(4)$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$2$','explanation','Often from ignoring part of the signed area or using one interval only.'),
    jsonb_build_object('id','B','text','$3$','explanation','Often from arithmetic mistakes when summing trapezoid areas.'),
    jsonb_build_object('id','C','text','$4$','explanation','Correct: sum signed trapezoid areas on $[0,1]$, $[1,3]$, and $[3,4]$.'),
    jsonb_build_object('id','D','text','$-4$','explanation','Treats the total as negative or subtracts in the wrong direction.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'Compute signed areas. On $[0,1]$: trapezoid with bases $1$ and $3$, width $1$, area $\\frac{1+3}{2}\\cdot1=2$. On $[1,3]$: trapezoid with bases $3$ and $0$, width $2$, area $\\frac{3+0}{2}\\cdot2=3$. On $[3,4]$: trapezoid with bases $0$ and $-2$, width $1$, area $\\frac{0+(-2)}{2}\\cdot1=-1$. Total $A(4)=2+3-1=4$.',
  recommendation_reasons = ARRAY['AP-style accumulation from a graph using signed area.','Targets absolute-vs-signed area confusion.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 5,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = '6.4: Accumulation function value from a piecewise-linear graph.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text_and_image',
  representation_type = 'symbolic',
  topic_id = 'Both_Integration',
  updated_at = NOW()
WHERE title = '6.4-P5';

COMMIT;
