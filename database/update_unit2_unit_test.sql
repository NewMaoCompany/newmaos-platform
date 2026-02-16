-- Unit 2 (Differentiation: Definition) — Unit Test Q1–Q20

UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Derivatives',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 90,
  skill_tags = ARRAY['SK_AVG_ROC','SK_FUNC_EVAL'],
  error_tags = ARRAY['E_AVG_VS_INST','E_SIGN_ERROR'],
  prompt = 'A particle’s position is $s(t)=t^2-4t$ (meters). What is the average velocity on $[1,3]$?',
  latex = 'A particle’s position is $s(t)=t^2-4t$ (meters). What is the average velocity on $[1,3]$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$0\text{ m/s}$','explanation','$\dfrac{s(3)-s(1)}{3-1}=\dfrac{(9-12)-(1-4)}{2}=\dfrac{-3-(-3)}{2}=0$.'),
    jsonb_build_object('id','B','text','$-3\text{ m/s}$','explanation','This is $s(3)$, not an average rate of change.'),
    jsonb_build_object('id','C','text','$-1\text{ m/s}$','explanation','This divides by $3$ instead of $2$.'),
    jsonb_build_object('id','D','text','$3\text{ m/s}$','explanation','This comes from reversing subtraction, causing a sign error.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Average velocity on $[1,3]$ is the secant slope:
$$\frac{s(3)-s(1)}{3-1}=0.$$',
  recommendation_reasons = ARRAY['Reinforces average rate of change as a secant slope.','Targets sign and interval-length mistakes.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: average velocity as average rate of change over an interval.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Derivatives',
  updated_at = NOW()
WHERE title = 'U2-UT-Q1';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Derivatives',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 1,
  target_time_seconds = 75,
  skill_tags = ARRAY['SK_LIMIT_DEF','SK_DERIV_NOTATION'],
  error_tags = ARRAY['E_NOTATION_MISMATCH','E_PLUG_H_EQUALS_0'],
  prompt = 'Let $f(x)=\sqrt{x}$. Which expression represents $f''(9)$ using the limit definition?',
  latex = 'Let $f(x)=\sqrt{x}$. Which expression represents $f''(9)$ using the limit definition?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\displaystyle \lim_{x\to 9}\frac{\sqrt{x}-\sqrt{9}}{x-9}$','explanation','This is an equivalent form, but the standard definition at a point uses $h\to 0$.'),
    jsonb_build_object('id','B','text','$\displaystyle \lim_{h\to 0}\frac{\sqrt{9+h}-\sqrt{9}}{h}$','explanation','This matches $f''(a)=\lim_{h\to 0}\frac{f(a+h)-f(a)}{h}$ with $a=9$.'),
    jsonb_build_object('id','C','text','$\displaystyle \lim_{h\to 0}\frac{\sqrt{h}-\sqrt{9}}{h}$','explanation','Uses $f(h)$ instead of $f(9+h)$.'),
    jsonb_build_object('id','D','text','$\displaystyle \lim_{h\to 0}\frac{\sqrt{9}-\sqrt{9-h}}{h}$','explanation','Not in correct limit-definition form as written.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Use the limit definition:
$$f''(9)=\lim_{h\to 0}\frac{f(9+h)-f(9)}{h}.$$
With $f(x)=\sqrt{x}$ this is option B.',
  recommendation_reasons = ARRAY['Builds fluency with the limit definition structure.','Targets common $h$-shift and substitution errors.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 1,
  mastery_weight = 0.90,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: correct limit-definition form for $f''(a)$.',
  weight_primary = 1.00,
  weight_supporting = 0.00,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Derivatives',
  updated_at = NOW()
WHERE title = 'U2-UT-Q2';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Derivatives',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 120,
  skill_tags = ARRAY['SK_GRAPH_READ','SK_AVG_ROC'],
  error_tags = ARRAY['E_SECANT_TANGENT_CONFUSION','E_GRAPH_READ','E_SIGN_ERROR'],
  prompt = 'Use the graph (with two marked points). What is the slope of the secant line through the two marked points?',
  latex = 'Use the graph (with two marked points). What is the slope of the secant line through the two marked points?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$1$','explanation','This matches a possible tangent slope at a point, not the secant slope between the marked points.'),
    jsonb_build_object('id','B','text','$-2$','explanation','This comes from a sign error when computing $\Delta y$.'),
    jsonb_build_object('id','C','text','$4$','explanation','This misreads the coordinates (double-counts the rise).'),
    jsonb_build_object('id','D','text','$2$','explanation','Using points $(1,1)$ and $(3,5)$ gives $\dfrac{5-1}{3-1}=2$.')
  ),
  correct_option_id = 'D',
  tolerance = 0.0010,
  explanation = 'From the graph, the marked points are $(1,1)$ and $(3,5)$. The secant slope is
$$\frac{5-1}{3-1}=2.$$',
  recommendation_reasons = ARRAY['Practices reading coordinates and computing secant slope.','Targets secant-vs-tangent confusion and sign mistakes.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.10,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Image required: grid with points $(1,1)$ and $(3,5)$ and a secant line.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text_and_image',
  representation_type = 'symbolic',
  topic_id = 'Both_Derivatives',
  updated_at = NOW()
WHERE title = 'U2-UT-Q3';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Derivatives',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 90,
  skill_tags = ARRAY['SK_DIFF_CONT'],
  error_tags = ARRAY['E_DIFF_IMPLIES_CONT','E_VALUE_VS_DERIV'],
  prompt = 'Which statement is always true if $f''(a)$ exists?',
  latex = 'Which statement is always true if $f''(a)$ exists?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$f(a)=0$','explanation','Derivative existence does not force $f(a)=0$.'),
    jsonb_build_object('id','B','text','$f$ has a local maximum at $a$','explanation','Derivative can exist at points that are not extrema.'),
    jsonb_build_object('id','C','text','$f$ is continuous at $a$','explanation','Differentiability implies continuity.'),
    jsonb_build_object('id','D','text','$f$ is not continuous at $a$','explanation','Contradicts differentiability.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'If $f''(a)$ exists, then $f$ is differentiable at $a$, hence continuous at $a$.',
  recommendation_reasons = ARRAY['Checks the core implication: differentiable $\Rightarrow$ continuous.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: differentiability vs continuity.',
  weight_primary = 1.00,
  weight_supporting = 0.00,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Derivatives',
  updated_at = NOW()
WHERE title = 'U2-UT-Q4';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Derivatives',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 85,
  skill_tags = ARRAY['SK_POWER_RULE','SK_ALGEBRA_SIMPLIFY'],
  error_tags = ARRAY['E_RULE_MISAPPLIED','E_SIGN_ERROR'],
  prompt = 'If $f(x)=3x^{5}-\dfrac{2}{x^{2}}$, what is $f''(x)$?',
  latex = 'If $f(x)=3x^{5}-\dfrac{2}{x^{2}}$, what is $f''(x)$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$15x^{4}+\dfrac{4}{x^{3}}$','explanation','Rewrite $-\dfrac{2}{x^{2}}=-2x^{-2}$ so derivative is $4x^{-3}=\dfrac{4}{x^{3}}$.'),
    jsonb_build_object('id','B','text','$15x^{4}-\dfrac{4}{x^{3}}$','explanation','Sign error when differentiating $-2x^{-2}$.'),
    jsonb_build_object('id','C','text','$15x^{4}+\dfrac{4}{x^{4}}$','explanation','Exponent decreased incorrectly; it should be $x^{-3}$.'),
    jsonb_build_object('id','D','text','$15x^{5}+\dfrac{2}{x^{3}}$','explanation','Power rule misapplied; derivative of $x^5$ is $5x^4$.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Differentiate term-by-term:
$$(3x^5)''=15x^4,\quad \left(-2x^{-2}\right)''=4x^{-3}=\frac{4}{x^3}.$$',
  recommendation_reasons = ARRAY['Reinforces rewriting with exponents before differentiating.','Targets sign and exponent-update errors.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: power rule with negative exponents.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Derivatives',
  updated_at = NOW()
WHERE title = 'U2-UT-Q5';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Derivatives',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = TRUE,
  difficulty = 3,
  target_time_seconds = 140,
  skill_tags = ARRAY['SK_TABLE_READ','SK_INST_ROC'],
  error_tags = ARRAY['E_TABLE_READ','E_AVG_VS_INST','E_ARITH_ERROR'],
  prompt = 'Use the table to estimate $f''(2)$ using a symmetric difference.',
  latex = 'Use the table to estimate $f''(2)$ using a symmetric difference.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$0.2$','explanation','This results from a decimal-place mistake after computing a slope.'),
    jsonb_build_object('id','B','text','$4$','explanation','Using $\dfrac{f(2.01)-f(1.99)}{2.01-1.99}=\dfrac{4.0401-3.9601}{0.02}=4$.'),
    jsonb_build_object('id','C','text','$2$','explanation','This is $f(2)$, not $f''(2)$.'),
    jsonb_build_object('id','D','text','$0$','explanation','Nearby values increase, so the slope is not $0$.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'A symmetric difference around $2$ gives
$$f''(2)\approx \frac{f(2.01)-f(1.99)}{2.01-1.99}=\frac{4.0401-3.9601}{0.02}=4.$$',
  recommendation_reasons = ARRAY['Builds skill estimating derivatives from tables.','Emphasizes symmetric difference for accuracy.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.20,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Image required: table of $(x,f(x))$ values near $2$.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text_and_image',
  representation_type = 'symbolic',
  topic_id = 'Both_Derivatives',
  updated_at = NOW()
WHERE title = 'U2-UT-Q6';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Derivatives',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 85,
  skill_tags = ARRAY['SK_LINEARTY'],
  error_tags = ARRAY['E_RULE_MISAPPLIED','E_NOTATION_MISMATCH'],
  prompt = 'If $g(x)=5f(x)-2h(x)$, $f''(x)=3x$, and $h''(x)=x^2$, what is $g''(x)$?',
  latex = 'If $g(x)=5f(x)-2h(x)$, $f''(x)=3x$, and $h''(x)=x^2$, what is $g''(x)$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$15x-2x^2$','explanation','$g''(x)=5f''(x)-2h''(x)=5(3x)-2(x^2)=15x-2x^2$.'),
    jsonb_build_object('id','B','text','$15x+2x^2$','explanation','Sign error on the $-2h''(x)$ term.'),
    jsonb_build_object('id','C','text','$5(3x-2x^2)$','explanation','Incorrect distribution of constants across different functions.'),
    jsonb_build_object('id','D','text','$15x^2-2x$','explanation','Mixes exponents from $f''(x)$ and $h''(x)$.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'By linearity,
$$g''(x)=5f''(x)-2h''(x)=15x-2x^2.$$',
  recommendation_reasons = ARRAY['Checks constant multiple and sum/difference rules.','Targets sign handling with linear combinations.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 0.90,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: linearity of differentiation.',
  weight_primary = 1.00,
  weight_supporting = 0.00,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Derivatives',
  updated_at = NOW()
WHERE title = 'U2-UT-Q7';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Derivatives',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 120,
  skill_tags = ARRAY['SK_DIFF_CONT','SK_GRAPH_READ'],
  error_tags = ARRAY['E_CORNER_DIFF','E_ONE_SIDED_ONLY'],
  prompt = 'Use the graph of $y=|x|$. Which statement is true about the derivative at $x=0$?',
  latex = 'Use the graph of $y=|x|$. Which statement is true about the derivative at $x=0$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','The derivative exists and equals $0$.','explanation','Left derivative is $-1$ and right derivative is $1$, so they do not match.'),
    jsonb_build_object('id','B','text','The derivative exists and equals $1$.','explanation','Uses only the right-hand derivative.'),
    jsonb_build_object('id','C','text','The derivative exists and equals $-1$.','explanation','Uses only the left-hand derivative.'),
    jsonb_build_object('id','D','text','The derivative does not exist at $x=0$.','explanation','Corner at $0$: one-sided derivatives differ.')
  ),
  correct_option_id = 'D',
  tolerance = 0.0010,
  explanation = '$|x|$ is continuous at $0$ but not differentiable there because the one-sided slopes differ ($-1$ vs $1$).',
  recommendation_reasons = ARRAY['Distinguishes continuity from differentiability at corners.','Reinforces one-sided derivative agreement criterion.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.20,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Image required: V-shaped graph of $y=|x|$ with labeled axes and title.',
  weight_primary = 1.00,
  weight_supporting = 0.00,
  prompt_type = 'text_and_image',
  representation_type = 'symbolic',
  topic_id = 'Both_Derivatives',
  updated_at = NOW()
WHERE title = 'U2-UT-Q8';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Derivatives',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 1,
  target_time_seconds = 70,
  skill_tags = ARRAY['SK_TRIG_DERIV'],
  error_tags = ARRAY['E_TRIG_MIXUP','E_SIGN_ERROR'],
  prompt = 'What is $\dfrac{d}{dx}(\cos x)$?',
  latex = 'What is $\dfrac{d}{dx}(\cos x)$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$-\sin x$','explanation','Correct basic derivative.'),
    jsonb_build_object('id','B','text','$\sin x$','explanation','Missing the negative sign.'),
    jsonb_build_object('id','C','text','$-\cos x$','explanation','Incorrect rule.'),
    jsonb_build_object('id','D','text','$\sec^2 x$','explanation','This is $(\tan x)''$.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = '$(\cos x)''=-\sin x$.',
  recommendation_reasons = ARRAY['Checks basic trig derivative recall.','Targets common sign error.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 1,
  mastery_weight = 0.80,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: basic trig derivatives.',
  weight_primary = 1.00,
  weight_supporting = 0.00,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Derivatives',
  updated_at = NOW()
WHERE title = 'U2-UT-Q9';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Derivatives',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 135,
  skill_tags = ARRAY['SK_PRODUCT_RULE','SK_TRIG_DERIV'],
  error_tags = ARRAY['E_RULE_MISAPPLIED','E_TRIG_MIXUP'],
  prompt = 'Find $\dfrac{d}{dx}\big(x^2\sin x\big)$.',
  latex = 'Find $\dfrac{d}{dx}\big(x^2\sin x\big)$.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$2x\sin x$','explanation','Misses the derivative of $\sin x$.'),
    jsonb_build_object('id','B','text','$2x\sin x+x^2\cos x$','explanation','Product rule gives $2x\sin x+x^2\cos x$.'),
    jsonb_build_object('id','C','text','$x^2\cos x$','explanation','Misses the derivative of $x^2$.'),
    jsonb_build_object('id','D','text','$2x\cos x+x^2\sin x$','explanation','Swaps $\sin$ and $\cos$ derivatives.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = '$\dfrac{d}{dx}(x^2\sin x)=2x\sin x+x^2\cos x$ by the product rule.',
  recommendation_reasons = ARRAY['Checks product rule structure and trig derivative pairing.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.10,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: product rule with trig.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Derivatives',
  updated_at = NOW()
WHERE title = 'U2-UT-Q10';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Derivatives',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 160,
  skill_tags = ARRAY['SK_QUOTIENT_RULE','SK_ALGEBRA_SIMPLIFY'],
  error_tags = ARRAY['E_RULE_MISAPPLIED','E_SIGN_ERROR'],
  prompt = 'Find $\dfrac{d}{dx}\left(\dfrac{x^2+1}{x}\right)$.',
  latex = 'Find $\dfrac{d}{dx}\left(\dfrac{x^2+1}{x}\right)$.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$2$','explanation','Drops the $+1$ term; not correct.'),
    jsonb_build_object('id','B','text','$\dfrac{2x\cdot x-(x^2+1)\cdot 1}{x^2}$','explanation','Correct quotient rule setup; simplifies to $1-\dfrac{1}{x^2}$.'),
    jsonb_build_object('id','C','text','$\dfrac{2x\cdot x+(x^2+1)\cdot 1}{x^2}$','explanation','Sign error in quotient rule numerator.'),
    jsonb_build_object('id','D','text','$\dfrac{2x}{x^2}$','explanation','Incorrect and ignores the $+1$ term.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Quotient rule with $u=x^2+1$, $v=x$ gives
$$\frac{u''v-uv''}{v^2}=\frac{(2x)(x)-(x^2+1)(1)}{x^2}.$$',
  recommendation_reasons = ARRAY['Tests quotient rule structure and sign control.','Reinforces simplifying after differentiating.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.30,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: quotient rule setup and simplification.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Derivatives',
  updated_at = NOW()
WHERE title = 'U2-UT-Q11';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Derivatives',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 85,
  skill_tags = ARRAY['SK_OTHER_TRIG'],
  error_tags = ARRAY['E_TRIG_MIXUP'],
  prompt = 'What is $\dfrac{d}{dx}(\sec x)$?',
  latex = 'What is $\dfrac{d}{dx}(\sec x)$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\sec^2 x$','explanation','This is $(\tan x)''$.'),
    jsonb_build_object('id','B','text','$\sec x\tan x$','explanation','Correct derivative.'),
    jsonb_build_object('id','C','text','$-\sec x\tan x$','explanation','Sign error.'),
    jsonb_build_object('id','D','text','$\csc x\cot x$','explanation','This is related to $\csc x$.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = '$(\sec x)''=\sec x\tan x$.',
  recommendation_reasons = ARRAY['Checks recall of secant derivative.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 0.90,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: derivative of secant.',
  weight_primary = 1.00,
  weight_supporting = 0.00,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Derivatives',
  updated_at = NOW()
WHERE title = 'U2-UT-Q12';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Derivatives',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 170,
  skill_tags = ARRAY['SK_LIMIT_DEF','SK_ALGEBRA_SIMPLIFY'],
  error_tags = ARRAY['E_PLUG_H_EQUALS_0','E_ARITH_ERROR'],
  prompt = 'Evaluate $\displaystyle \lim_{h\to 0}\frac{(2+h)^3-8}{h}$.',
  latex = 'Evaluate $\displaystyle \lim_{h\to 0}\frac{(2+h)^3-8}{h}$.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$12$','explanation','Expand and simplify: the limit is $12$.'),
    jsonb_build_object('id','B','text','$8$','explanation','Confuses the function value with the limit.'),
    jsonb_build_object('id','C','text','$6$','explanation','Incorrect binomial expansion.'),
    jsonb_build_object('id','D','text','$0$','explanation','Incorrect cancellation.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Expand $(2+h)^3=8+12h+6h^2+h^3$:
$$\frac{(2+h)^3-8}{h}=12+6h+h^2\to 12.$$',
  recommendation_reasons = ARRAY['Practices algebraic evaluation of a derivative-style limit.','Targets the $h=0$ substitution error.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.30,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: limit-definition computation via expansion.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Derivatives',
  updated_at = NOW()
WHERE title = 'U2-UT-Q13';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Derivatives',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 120,
  skill_tags = ARRAY['SK_GRAPH_READ','SK_TRIG_DERIV'],
  error_tags = ARRAY['E_VALUE_VS_DERIV','E_GRAPH_READ'],
  prompt = 'Use the graph of $y=\sin x$ with a dashed tangent line at $x=0$. What is $\sin''(0)$?',
  latex = 'Use the graph of $y=\sin x$ with a dashed tangent line at $x=0$. What is $\sin''(0)$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$0$','explanation','That is $\sin(0)$, not the tangent slope.'),
    jsonb_build_object('id','B','text','$1$','explanation','Correct tangent slope at $0$.'),
    jsonb_build_object('id','C','text','$-1$','explanation','Slope is positive at $0$.'),
    jsonb_build_object('id','D','text','$\pi$','explanation','Not a slope value here.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = '$(\sin x)''=\cos x$, so $\sin''(0)=\cos 0=1$.',
  recommendation_reasons = ARRAY['Connects derivative value to tangent slope on a graph.','Targets value-vs-slope confusion.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Image required: sine curve near the origin with tangent line of slope $1$ and title label.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text_and_image',
  representation_type = 'symbolic',
  topic_id = 'Both_Derivatives',
  updated_at = NOW()
WHERE title = 'U2-UT-Q14';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Derivatives',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 90,
  skill_tags = ARRAY['SK_LINEARTY','SK_POWER_RULE'],
  error_tags = ARRAY['E_RULE_MISAPPLIED'],
  prompt = 'If $p(x)=x^4+7$, what is $\dfrac{d}{dx}\big(3p(x)\big)$?',
  latex = 'If $p(x)=x^4+7$, what is $\dfrac{d}{dx}\big(3p(x)\big)$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$12x^3+7$','explanation','The constant term differentiates to $0$.'),
    jsonb_build_object('id','B','text','$3x^4+21$','explanation','That is $3p(x)$, not its derivative.'),
    jsonb_build_object('id','C','text','$12x^3$','explanation','Correct: $3\cdot 4x^3=12x^3$.'),
    jsonb_build_object('id','D','text','$4x^3$','explanation','Forgets the factor of $3$.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = '$p''(x)=4x^3$, so $(3p(x))''=3p''(x)=12x^3$.',
  recommendation_reasons = ARRAY['Reinforces constant multiple rule combined with power rule.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 0.90,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: linearity with constant multiples.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Derivatives',
  updated_at = NOW()
WHERE title = 'U2-UT-Q15';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Derivatives',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 115,
  skill_tags = ARRAY['SK_LOG_DERIV'],
  error_tags = ARRAY['E_LOG_DERIV_CONFUSION'],
  prompt = 'What is $\dfrac{d}{dx}(\ln x)$ for $x>0$?',
  latex = 'What is $\dfrac{d}{dx}(\ln x)$ for $x>0$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\ln x$','explanation','Confuses function with derivative.'),
    jsonb_build_object('id','B','text','$x$','explanation','Not correct.'),
    jsonb_build_object('id','C','text','$\dfrac{1}{\ln x}$','explanation','Incorrect reciprocal idea.'),
    jsonb_build_object('id','D','text','$\dfrac{1}{x}$','explanation','Correct.')
  ),
  correct_option_id = 'D',
  tolerance = 0.0010,
  explanation = 'For $x>0$, $(\ln x)''=\dfrac{1}{x}$.',
  recommendation_reasons = ARRAY['Targets a high-frequency misconception about $\ln x$ derivatives.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: derivative of natural log.',
  weight_primary = 1.00,
  weight_supporting = 0.00,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Derivatives',
  updated_at = NOW()
WHERE title = 'U2-UT-Q16';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Derivatives',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 120,
  skill_tags = ARRAY['SK_OTHER_TRIG'],
  error_tags = ARRAY['E_TRIG_MIXUP','E_SIGN_ERROR'],
  prompt = 'What is $\dfrac{d}{dx}(\csc x)$?',
  latex = 'What is $\dfrac{d}{dx}(\csc x)$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$-\csc x\cot x$','explanation','Correct.'),
    jsonb_build_object('id','B','text','$\csc x\cot x$','explanation','Sign error.'),
    jsonb_build_object('id','C','text','$-\sec x\tan x$','explanation','Wrong function.'),
    jsonb_build_object('id','D','text','$\csc^2 x$','explanation','Incorrect memorization.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = '$(\csc x)''=-\csc x\cot x$.',
  recommendation_reasons = ARRAY['Reinforces correct sign and pairing for $\csc x$ derivative.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: derivative of cosecant.',
  weight_primary = 1.00,
  weight_supporting = 0.00,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Derivatives',
  updated_at = NOW()
WHERE title = 'U2-UT-Q17';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Derivatives',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 170,
  skill_tags = ARRAY['SK_PRODUCT_RULE'],
  error_tags = ARRAY['E_RULE_MISAPPLIED'],
  prompt = 'If $y=(x^3-1)(x^2+2)$, what is $y''$?',
  latex = 'If $y=(x^3-1)(x^2+2)$, what is $y''$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$(3x^2)(2x)$','explanation','Incorrect: product rule is not $u''v''$.'),
    jsonb_build_object('id','B','text','$3x^2(x^2+2)+(x^3-1)(2x)$','explanation','Correct: $u''v+uv''$.'),
    jsonb_build_object('id','C','text','$3x^2(x^2+2)-(x^3-1)(2x)$','explanation','Incorrect sign.'),
    jsonb_build_object('id','D','text','$(x^3-1)(2x)$','explanation','Differentiates only one factor.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'With $u=x^3-1$, $v=x^2+2$, product rule gives $y''=u''v+uv''$.',
  recommendation_reasons = ARRAY['Targets the common misconception $\frac{d}{dx}(uv)=u''v''''.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.20,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: product rule structure.',
  weight_primary = 1.00,
  weight_supporting = 0.00,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Derivatives',
  updated_at = NOW()
WHERE title = 'U2-UT-Q18';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Derivatives',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 5,
  target_time_seconds = 200,
  skill_tags = ARRAY['SK_QUOTIENT_RULE','SK_TRIG_DERIV'],
  error_tags = ARRAY['E_RULE_MISAPPLIED','E_SIGN_ERROR','E_TRIG_MIXUP'],
  prompt = 'Find $\dfrac{d}{dx}\left(\dfrac{\sin x}{x}\right)$ for $x\ne 0$.',
  latex = 'Find $\dfrac{d}{dx}\left(\dfrac{\sin x}{x}\right)$ for $x\ne 0$.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\dfrac{\cos x}{x}$','explanation','Incomplete; missing quotient-rule correction term.'),
    jsonb_build_object('id','B','text','$\dfrac{x\cos x-\sin x}{x^2}$','explanation','Correct.'),
    jsonb_build_object('id','C','text','$\dfrac{x\cos x+\sin x}{x^2}$','explanation','Sign error.'),
    jsonb_build_object('id','D','text','$\dfrac{\cos x}{x^2}$','explanation','Drops the $-\sin x$ term.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Quotient rule with $u=\sin x$, $v=x$ gives
$$\frac{(\cos x)(x)-(\sin x)(1)}{x^2}=\frac{x\cos x-\sin x}{x^2}.$$',
  recommendation_reasons = ARRAY['Combines quotient rule with trig derivative fluency.','Targets sign errors in the quotient numerator.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.40,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: quotient rule with trig.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Derivatives',
  updated_at = NOW()
WHERE title = 'U2-UT-Q19';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Derivatives',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 120,
  skill_tags = ARRAY['SK_POWER_RULE','SK_ALGEBRA_SIMPLIFY'],
  error_tags = ARRAY['E_RULE_MISAPPLIED','E_SIGN_ERROR'],
  prompt = 'If $f(x)=\dfrac{1}{\sqrt{x}}$ for $x>0$, what is $f''(x)$?',
  latex = 'If $f(x)=\dfrac{1}{\sqrt{x}}$ for $x>0$, what is $f''(x)$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\dfrac{1}{2\sqrt{x}}$','explanation','Derivative of $\sqrt{x}$, not $x^{-1/2}$.'),
    jsonb_build_object('id','B','text','$-\dfrac{1}{2x\sqrt{x}}$','explanation','Correct: $x^{-1/2}\to (-\tfrac12)x^{-3/2}=-\dfrac{1}{2x\sqrt{x}}$.'),
    jsonb_build_object('id','C','text','$-\dfrac{1}{2\sqrt{x}}$','explanation','Exponent not decreased correctly.'),
    jsonb_build_object('id','D','text','$\dfrac{1}{x\sqrt{x}}$','explanation','Missing factor $\tfrac12$ and wrong sign.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Write $f(x)=x^{-1/2}$. Then
$$f''(x)=(-\tfrac12)x^{-3/2}=-\frac{1}{2x\sqrt{x}}.$$',
  recommendation_reasons = ARRAY['Checks fractional exponent handling and simplification.','Targets missing coefficient and sign errors.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.10,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: power rule with fractional/negative exponents.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Derivatives',
  updated_at = NOW()
WHERE title = 'U2-UT-Q20';
