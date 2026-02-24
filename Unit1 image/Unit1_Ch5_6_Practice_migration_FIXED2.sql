-- Unit 1.5 (Determining Limits Using Algebraic Properties of Limits) — Practice 1–5

UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.5',
  section_id = '1.5',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 1,
  target_time_seconds = 60,
  skill_tags = ARRAY['SK_LIMIT_LAWS', 'SK_DIRECT_SUBSTITUTION'],
  error_tags = ARRAY['E_ARITHMETIC_SLIP', 'E_MISAPPLY_LIMIT_LAWS'],
  prompt = 'Evaluate the limit: $$\lim_{x\to 3}\left(2x^2-5x+1\right).$$',
  latex = 'Evaluate the limit: $$\lim_{x\to 3}\left(2x^2-5x+1\right).$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$4$','explanation','Direct substitution gives $2(3^2)-5(3)+1=18-15+1=4$.'),
    jsonb_build_object('id','B','text','$6$','explanation','This results from miscomputing $18-15+1$.'),
    jsonb_build_object('id','C','text','$-4$','explanation','This comes from sign errors when combining terms.'),
    jsonb_build_object('id','D','text','Does not exist','explanation','Polynomials are continuous everywhere, so the limit exists.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Because polynomials are continuous, $$\lim_{x\to 3}(2x^2-5x+1)=2\cdot 3^2-5\cdot 3+1=4.$$',
  recommendation_reasons = ARRAY['Reinforces direct substitution for polynomial limits.', 'Targets common arithmetic and sign errors.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 1,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: apply limit laws and continuity of polynomials.',
  weight_primary = 1.00,
  weight_supporting = 0.00,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Limits',
  updated_at = NOW()
WHERE title = '1.5-P1';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.5',
  section_id = '1.5',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 110,
  skill_tags = ARRAY['SK_LIMIT_LAWS', 'SK_GRAPH_LIMIT_READ'],
  error_tags = ARRAY['E_READ_LIMIT_AS_VALUE', 'E_GRAPH_READ_ERROR'],
  prompt = 'Using the graph (see image 1.5-P2.png), evaluate $$\lim_{x\to 1}\left(3f(x)-2g(x)\right).$$',
  latex = 'Using the graph (see image 1.5-P2.png), evaluate $$\lim_{x\to 1}\left(3f(x)-2g(x)\right).$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$4$','explanation','This uses an incorrect limit value from the graph for either $f$ or $g$.'),
    jsonb_build_object('id','B','text','$8$','explanation','From the graph, $\lim f(x)=2$ and $\lim g(x)=-1$, so $3(2)-2(-1)=8$.'),
    jsonb_build_object('id','C','text','$-8$','explanation','This comes from a sign mistake when computing $-2g(x)$.'),
    jsonb_build_object('id','D','text','Does not exist','explanation','Both $\lim_{x\to 1} f(x)$ and $\lim_{x\to 1} g(x)$ exist, so the limit exists by limit laws.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'From the graph, $$\lim_{x\to 1}f(x)=2,\quad \lim_{x\to 1}g(x)=-1.$$ By limit laws, $$\lim_{x\to 1}(3f(x)-2g(x))=3\cdot 2-2\cdot(-1)=8.$$',
  recommendation_reasons = ARRAY['Connects limit laws to graphical limit values.', 'Builds accuracy reading limits (not point values) from graphs.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Image required: graph provides approaching values of $f$ and $g$ at $x=1$.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text_and_image',
  representation_type = 'symbolic',
  topic_id = 'Both_Limits',
  updated_at = NOW()
WHERE title = '1.5-P2';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.5',
  section_id = '1.5',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 90,
  skill_tags = ARRAY['SK_LIMIT_LAWS', 'SK_FUNCTION_COMPOSITION_LIMITS'],
  error_tags = ARRAY['E_MISAPPLY_LIMIT_LAWS', 'E_POWER_RULE_MISUSE'],
  prompt = 'Suppose $$\lim_{x\to 2}f(x)=5\quad\text{and}\quad \lim_{x\to 2}g(x)=-3.$$ Evaluate $$\lim_{x\to 2}\frac{(f(x))^2}{g(x)+7}.$$',
  latex = 'Suppose $$\lim_{x\to 2}f(x)=5\quad\text{and}\quad \lim_{x\to 2}g(x)=-3.$$ Evaluate $$\lim_{x\to 2}\frac{(f(x))^2}{g(x)+7}.$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\frac{10}{4}$','explanation','This incorrectly treats $(f(x))^2$ as $2f(x)$.'),
    jsonb_build_object('id','B','text','$\frac{25}{4}$','explanation','Compute $\frac{(5)^2}{-3+7}=\frac{25}{4}$.'),
    jsonb_build_object('id','C','text','$\frac{25}{-10}$','explanation','This mishandles the denominator limit $-3+7$.'),
    jsonb_build_object('id','D','text','Does not exist','explanation','The denominator limit is $-3+7=4\neq 0$, so the limit exists.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'By limit laws, $$\lim_{x\to 2}\frac{(f(x))^2}{g(x)+7}=\frac{(\lim f(x))^2}{\lim(g(x)+7)}=\frac{5^2}{-3+7}=\frac{25}{4}.$$',
  recommendation_reasons = ARRAY['Practices combining limits with powers and sums.', 'Targets the misconception squaring vs doubling.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: evaluate a composite limit using limit laws and a nonzero denominator check.',
  weight_primary = 1.00,
  weight_supporting = 0.00,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Limits',
  updated_at = NOW()
WHERE title = '1.5-P3';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.5',
  section_id = '1.5',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 140,
  skill_tags = ARRAY['SK_LIMIT_EXISTENCE', 'SK_RATIONAL_LIMITS'],
  error_tags = ARRAY['E_DIVIDE_BY_ZERO_END', 'E_ASSUME_DNE_WHEN_EXISTS'],
  prompt = 'Evaluate (or state that it does not exist): $$\lim_{x\to 2}\frac{x+1}{x^2-4}.$$',
  latex = 'Evaluate (or state that it does not exist): $$\lim_{x\to 2}\frac{x+1}{x^2-4}.$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\frac{3}{0}$','explanation','A limit cannot be left as division by zero; you must determine the behavior.'),
    jsonb_build_object('id','B','text','$\frac{3}{4}$','explanation','This incorrectly treats $x^2-4$ as $4$ at $x=2$.'),
    jsonb_build_object('id','C','text','Does not exist (unbounded)','explanation','Since the denominator approaches $0$ while the numerator approaches $3\neq 0$, the expression becomes unbounded.'),
    jsonb_build_object('id','D','text','$0$','explanation','This would require the numerator to approach $0$, which it does not.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'Factor $x^2-4=(x-2)(x+2)$. As $x\to 2$, the numerator $x+1\to 3$ while the denominator $(x-2)(x+2)\to 0$. A nonzero number divided by something approaching $0$ becomes unbounded, so the two-sided limit does not exist.',
  recommendation_reasons = ARRAY['Builds habit of checking denominator behavior in quotient limits.', 'Distinguishes unbounded behavior from removable discontinuities.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: DNE due to infinite behavior when denominator limit is 0 and numerator limit is nonzero.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Limits',
  updated_at = NOW()
WHERE title = '1.5-P4';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.5',
  section_id = '1.5',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 85,
  skill_tags = ARRAY['SK_LIMIT_LAWS', 'SK_DIRECT_SUBSTITUTION'],
  error_tags = ARRAY['E_ARITHMETIC_SLIP', 'E_MISAPPLY_LIMIT_LAWS'],
  prompt = 'Evaluate the limit: $$\lim_{x\to -1}\frac{x^2+3x+2}{x+2}.$$',
  latex = 'Evaluate the limit: $$\lim_{x\to -1}\frac{x^2+3x+2}{x+2}.$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$1$','explanation','This comes from an arithmetic slip in the numerator.'),
    jsonb_build_object('id','B','text','$-1$','explanation','This comes from sign errors in $1-3+2$.'),
    jsonb_build_object('id','C','text','Does not exist','explanation','The denominator approaches $1\neq 0$, so the limit exists.'),
    jsonb_build_object('id','D','text','$0$','explanation','Direct substitution gives $\frac{1-3+2}{1}=0$.')
  ),
  correct_option_id = 'D',
  tolerance = 0.0010,
  explanation = 'Because the denominator approaches $-1+2=1\neq 0$, substitute directly: $$\lim_{x\to -1}\frac{x^2+3x+2}{x+2}=\frac{(-1)^2+3(-1)+2}{-1+2}=\frac{0}{1}=0.$$',
  recommendation_reasons = ARRAY['Reinforces substitution when the denominator limit is nonzero.', 'Targets routine arithmetic accuracy in rational expressions.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: direct substitution with a nonzero denominator at the limit point.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Limits',
  updated_at = NOW()
WHERE title = '1.5-P5';



-- Unit 1.6 (Determining Limits Using Algebraic Manipulation) — Practice 1–5

UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.6',
  section_id = '1.6',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 95,
  skill_tags = ARRAY['SK_ALGEBRAIC_LIMITS', 'SK_FACTOR_CANCEL'],
  error_tags = ARRAY['E_FACTORING_ERROR', 'E_SUBSTITUTE_TOO_EARLY'],
  prompt = 'Evaluate the limit: $$\lim_{x\to 2}\frac{x^2-4}{x-2}.$$',
  latex = 'Evaluate the limit: $$\lim_{x\to 2}\frac{x^2-4}{x-2}.$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$2$','explanation','This comes from canceling incorrectly or simplifying to $x$ instead of $x+2$.'),
    jsonb_build_object('id','B','text','$4$','explanation','Factor $x^2-4=(x-2)(x+2)$, cancel, then substitute to get $4$.'),
    jsonb_build_object('id','C','text','$0$','explanation','This results from substituting first to get $0/0$ and stopping.'),
    jsonb_build_object('id','D','text','Does not exist','explanation','After cancellation, the expression is continuous near $x=2$, so the limit exists.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Factor: $$\frac{x^2-4}{x-2}=\frac{(x-2)(x+2)}{x-2}=x+2\ (x\neq 2).$$ Then $$\lim_{x\to 2}(x+2)=4.$$',
  recommendation_reasons = ARRAY['Core technique: factor and cancel to remove $0/0$.', 'Targets the common mistake of substituting before simplifying.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: resolve an indeterminate form by factoring and cancellation.',
  weight_primary = 1.00,
  weight_supporting = 0.00,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Limits',
  updated_at = NOW()
WHERE title = '1.6-P1';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.6',
  section_id = '1.6',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 150,
  skill_tags = ARRAY['SK_ALGEBRAIC_LIMITS', 'SK_RATIONALIZE_CONJUGATE'],
  error_tags = ARRAY['E_RATIONALIZE_ERROR', 'E_SUBSTITUTE_TOO_EARLY'],
  prompt = 'Evaluate the limit: $$\lim_{x\to 0}\frac{\sqrt{1+x}-1}{x}.$$',
  latex = 'Evaluate the limit: $$\lim_{x\to 0}\frac{\sqrt{1+x}-1}{x}.$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\frac{1}{2}$','explanation','Multiply by the conjugate to simplify to $\frac{1}{\sqrt{1+x}+1}$, then substitute $x=0$.'),
    jsonb_build_object('id','B','text','$1$','explanation','This ignores the conjugate simplification and overestimates the limit.'),
    jsonb_build_object('id','C','text','$0$','explanation','This comes from substituting to get $0/0$ and guessing.'),
    jsonb_build_object('id','D','text','Does not exist','explanation','After rationalizing, the expression is continuous at $x=0$, so the limit exists.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Rationalize: $$\frac{\sqrt{1+x}-1}{x}\cdot\frac{\sqrt{1+x}+1}{\sqrt{1+x}+1}=\frac{(1+x)-1}{x(\sqrt{1+x}+1)}=\frac{1}{\sqrt{1+x}+1}.$$ Then $$\lim_{x\to 0}\frac{1}{\sqrt{1+x}+1}=\frac{1}{2}.$$',
  recommendation_reasons = ARRAY['Canonical conjugate technique used repeatedly in AP limits.', 'Builds precision with algebraic manipulation before substitution.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: rationalize to remove radicals and resolve $0/0$.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Limits',
  updated_at = NOW()
WHERE title = '1.6-P2';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.6',
  section_id = '1.6',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 125,
  skill_tags = ARRAY['SK_ALGEBRAIC_LIMITS', 'SK_RATIONALIZE_CONJUGATE'],
  error_tags = ARRAY['E_RATIONALIZE_ERROR', 'E_ALGEBRA_SLIP'],
  prompt = 'Evaluate the limit: $$\lim_{x\to 3}\frac{x-3}{\sqrt{x}-\sqrt{3}}.$$',
  latex = 'Evaluate the limit: $$\lim_{x\to 3}\frac{x-3}{\sqrt{x}-\sqrt{3}}.$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\sqrt{3}$','explanation','This misses the factor of $2\sqrt{3}$ after simplifying to $\sqrt{x}+\sqrt{3}$.'),
    jsonb_build_object('id','B','text','$2\sqrt{3}$','explanation','Multiply by the conjugate to cancel $x-3$, then substitute to get $2\sqrt{3}$.'),
    jsonb_build_object('id','C','text','$6$','explanation','This incorrectly replaces $\sqrt{3}$ with $3$ in the final step.'),
    jsonb_build_object('id','D','text','$\frac{1}{2\sqrt{3}}$','explanation','This is the reciprocal of the simplified expression.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Multiply by the conjugate: $$\frac{x-3}{\sqrt{x}-\sqrt{3}}\cdot\frac{\sqrt{x}+\sqrt{3}}{\sqrt{x}+\sqrt{3}}=\frac{(x-3)(\sqrt{x}+\sqrt{3})}{x-3}=\sqrt{x}+\sqrt{3}.$$ Then $$\lim_{x\to 3}(\sqrt{x}+\sqrt{3})=2\sqrt{3}.$$',
  recommendation_reasons = ARRAY['Rationalization with a difference of square roots in the denominator.', 'Checks symbolic precision with radicals.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: conjugate cancels the factor created by a difference of squares.',
  weight_primary = 1.00,
  weight_supporting = 0.00,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Limits',
  updated_at = NOW()
WHERE title = '1.6-P3';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.6',
  section_id = '1.6',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 120,
  skill_tags = ARRAY['SK_ALGEBRAIC_LIMITS', 'SK_FACTOR_CANCEL'],
  error_tags = ARRAY['E_FACTORING_ERROR', 'E_SUBSTITUTE_TOO_EARLY'],
  prompt = 'Evaluate the limit: $$\lim_{x\to 1}\frac{x^3-1}{x-1}.$$',
  latex = 'Evaluate the limit: $$\lim_{x\to 1}\frac{x^3-1}{x-1}.$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$1$','explanation','This comes from incorrect cancellation or substituting too early.'),
    jsonb_build_object('id','B','text','$2$','explanation','This results from factoring $x^3-1$ incorrectly.'),
    jsonb_build_object('id','C','text','$3$','explanation','Use $x^3-1=(x-1)(x^2+x+1)$, cancel, then substitute $x=1$ to get $3$.'),
    jsonb_build_object('id','D','text','Does not exist','explanation','This is a removable discontinuity, so the limit exists.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'Difference of cubes: $$x^3-1=(x-1)(x^2+x+1).$$ Then $$\frac{x^3-1}{x-1}=x^2+x+1\ (x\neq 1),$$ so $$\lim_{x\to 1}\frac{x^3-1}{x-1}=1^2+1+1=3.$$',
  recommendation_reasons = ARRAY['Reinforces special factoring (difference of cubes).', 'Extends factor-cancel technique beyond quadratics.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: factor using $a^3-b^3$ and cancel to evaluate the limit.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Limits',
  updated_at = NOW()
WHERE title = '1.6-P4';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.6',
  section_id = '1.6',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 5,
  target_time_seconds = 170,
  skill_tags = ARRAY['SK_CONTINUITY_REMOVABLE', 'SK_GRAPH_LIMIT_READ'],
  error_tags = ARRAY['E_CONFUSE_LIMIT_WITH_VALUE', 'E_READ_LIMIT_AS_VALUE'],
  prompt = 'A function has the graph shown (see image 1.6-P5.png). What value should be defined at $x=3$ to make the function continuous at $x=3$?',
  latex = 'A function has the graph shown (see image 1.6-P5.png). What value should be defined at $x=3$ to make the function continuous at $x=3$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$3$','explanation','This confuses the input value with the output needed for continuity.'),
    jsonb_build_object('id','B','text','$6$','explanation','The hole is at $(3,6)$, so define $f(3)=6$ to match the limit.'),
    jsonb_build_object('id','C','text','$0$','explanation','This would not match the approaching value on the graph.'),
    jsonb_build_object('id','D','text','No value works','explanation','A removable discontinuity can be fixed by setting the point equal to the limit.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'To make $f$ continuous at $x=3$, define $f(3)$ to equal the two-sided limit. The graph shows a hole at $(3,6)$, so $$\lim_{x\to 3}f(x)=6$$ and the required definition is $f(3)=6$.',
  recommendation_reasons = ARRAY['Connects continuity to the definition $f(a)=\lim_{x\to a}f(x)$.', 'Targets confusion between limit value and function value.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 5,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Image required: identify the hole’s $y$-value and set $f(3)$ equal to the limit.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text_and_image',
  representation_type = 'symbolic',
  topic_id = 'Both_Limits',
  updated_at = NOW()
WHERE title = '1.6-P5';
