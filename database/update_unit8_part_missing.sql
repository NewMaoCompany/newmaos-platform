-- Missing Unit 8 Questions (8.0-UT-Q1, 8.5, 8.6, 8.9-P5)

BEGIN;

-- 8.0-UT-Q1
UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_AppIntegration',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 90,
  skill_tags = ARRAY['SK_AVG_VALUE_FORMULA','SK_DEFINITE_INTEGRAL_EVAL'],
  error_tags = ARRAY['E_AVG_VALUE_DIVIDE','E_LIMITS_SWAP'],
  prompt = 'Let $f(x)=3x^2-2x$ on $[1,4]$. What is the average value of $f$ on this interval?',
  latex = 'Let $f(x)=3x^2-2x$ on $[1,4]$. What is the average value of $f$ on this interval?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$48$','explanation','This is the value of the definite integral before dividing by $b-a$.'),
    jsonb_build_object('id','B','text','$16$','explanation','Correct: average value is $\frac{1}{4-1}\int_1^4(3x^2-2x)dx=16$.'),
    jsonb_build_object('id','C','text','$12$','explanation','This comes from dividing by $4$ instead of $3$.'),
    jsonb_build_object('id','D','text','$29$','explanation','Arithmetic error.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Average value is $\frac{1}{b-a}\int_a^b f(x)dx$.',
  recommendation_reasons = ARRAY['Tests average value formula.','Targets forgetting to divide by interval length.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Average value of a function.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  primary_skill_id = 'SK_AVG_VALUE_FORMULA',
  supporting_skill_ids = ARRAY['SK_DEFINITE_INTEGRAL_EVAL'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_AppIntegration',
  updated_at = NOW()
WHERE title = '8.0-UT-Q1';

-- 8.5-P1
UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_AppIntegration',
  sub_topic_id = '8.5',
  section_id = '8.5',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 120,
  skill_tags = ARRAY['SK_AREA_DY','SK_SOLVE_INTERSECTIONS','SK_SETUP_DY','SK_DEFINITE_INTEGRAL_EVAL'],
  error_tags = ARRAY['E_BOUNDS_FROM_INTERSECTIONS','E_RIGHT_MINUS_LEFT_SWAP','E_ALGEBRA_INTERSECTIONS'],
  prompt = 'Find the area of the region bounded by $x=y^2$ and $x=4-y$. Choose the exact value.',
  latex = 'Find the area of the region bounded by $x=y^2$ and $x=4-y$. Choose the exact value.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\frac{17\sqrt{17}}{6}$','explanation','Correct: intersections solve $y^2=4-y$, and area is $\int[(4-y)-y^2]\,dy$ over those bounds.'),
    jsonb_build_object('id','B','text','$\frac{17\sqrt{17}}{3}$','explanation','This is twice the correct value; no symmetry-doubling applies here.'),
    jsonb_build_object('id','C','text','$\frac{\sqrt{17}}{6}$','explanation','Missing the factor from integrating the quadratic difference; far too small.'),
    jsonb_build_object('id','D','text','$\frac{17}{6}$','explanation','Drops the $\sqrt{17}$ coming from the intersection bounds.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Solve intersections: $y^2=4-y\Rightarrow y^2+y-4=0$, so $$y_1=\frac{-1-\sqrt{17}}{2},\quad y_2=\frac{-1+\sqrt{17}}{2}.$$ For a horizontal slice, right curve is $x=4-y$ and left curve is $x=y^2$. $$A=\int_{y_1}^{y_2}\big[(4-y)-y^2\big]\,dy.$$ Compute: $$\int(4-y-y^2)\,dy=4y-\frac{y^2}{2}-\frac{y^3}{3}.$$ Evaluating from $y_1$ to $y_2$ simplifies to $$A=\frac{17\sqrt{17}}{6}.$$',
  recommendation_reasons = ARRAY['Reinforces right-minus-left when integrating with respect to $y$.','Practices finding bounds from intersections.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Area between curves as functions of $y$ (right-minus-left).',
  weight_primary = 0.75,
  weight_supporting = 0.25,
  primary_skill_id = 'SK_AREA_DY',
  supporting_skill_ids = ARRAY['SK_SOLVE_INTERSECTIONS','SK_SETUP_DY','SK_DEFINITE_INTEGRAL_EVAL'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_AppIntegration',
  updated_at = NOW()
WHERE title = '8.5-P1';

-- 8.5-P2
UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_AppIntegration',
  sub_topic_id = '8.5',
  section_id = '8.5',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 90,
  skill_tags = ARRAY['SK_INTERPRET_GRAPH','SK_SETUP_DY','SK_AREA_DY'],
  error_tags = ARRAY['E_WRONG_SLICE_VARIABLE','E_RIGHT_MINUS_LEFT_SWAP','E_BOUNDS_FROM_INTERSECTIONS'],
  prompt = 'The shaded region is bounded by $x=y^2-1$ and $x=3-y$ (see image). Which integral equals the area of the shaded region?

![8.5-P2](8.5-P2.png)',
  latex = 'The shaded region is bounded by $x=y^2-1$ and $x=3-y$. Which integral equals the area of the shaded region?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\displaystyle \int_{y_1}^{y_2}\big[(y^2-1)-(3-y)\big]\,dy$','explanation','This is left-minus-right, giving a negative value over the interval.'),
    jsonb_build_object('id','B','text','$\displaystyle \int_{y_1}^{y_2}\big[(3-y)-(y^2-1)\big]\,dy$','explanation','Correct: for horizontal slices, area is $\int(\text{right}-\text{left})\,dy$.'),
    jsonb_build_object('id','C','text','$\displaystyle \int_{x_1}^{x_2}\big[(3-x)-\sqrt{x+1}\big]\,dx$','explanation','This mixes expressions and uses $dx$ without matching the pictured boundaries cleanly.'),
    jsonb_build_object('id','D','text','$\displaystyle \int_{y_1}^{y_2}\big[(3-y)+(y^2-1)\big]\,dy$','explanation','Adds the curves instead of taking their horizontal distance.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Because both boundaries are given as $x$ in terms of $y$, use horizontal slices. Let $y_1<y_2$ be the intersection $y$-values found from $y^2-1=3-y$. For each $y$ between $y_1$ and $y_2$, the right boundary is $x=3-y$ and the left boundary is $x=y^2-1$. Thus the area is $$\int_{y_1}^{y_2}\big[(3-y)-(y^2-1)\big]\,dy.$$',
  recommendation_reasons = ARRAY['Builds the habit: with $x=f(y)$, use horizontal slices and right-minus-left.','Targets setup accuracy from a graph.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Graph-to-integral setup with respect to $y$.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  primary_skill_id = 'SK_INTERPRET_GRAPH',
  supporting_skill_ids = ARRAY['SK_SETUP_DY','SK_AREA_DY'],
  prompt_type = 'text_and_image',
  representation_type = 'symbolic',
  topic_id = 'Both_AppIntegration',
  updated_at = NOW()
WHERE title = '8.5-P2';

-- 8.5-P3
UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_AppIntegration',
  sub_topic_id = '8.5',
  section_id = '8.5',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 100,
  skill_tags = ARRAY['SK_SETUP_DY','SK_AREA_DY','SK_DEFINITE_INTEGRAL_EVAL'],
  error_tags = ARRAY['E_RIGHT_MINUS_LEFT_SWAP','E_INTEGRAL_ARITHMETIC','E_BOUNDS_FROM_INTERSECTIONS'],
  prompt = 'Find the area of the region bounded by $x=y^2+1$ and $x=5-y^2$.',
  latex = 'Find the area of the region bounded by $x=y^2+1$ and $x=5-y^2$.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\frac{8}{3}$','explanation','This results from missing a factor of 2 when integrating $-2y^2$ over a symmetric interval.'),
    jsonb_build_object('id','B','text','$\frac{32}{3}$','explanation','This is too large; it corresponds to integrating $4-2y^2$ over an interval longer than $[-2,2]$.'),
    jsonb_build_object('id','C','text','$\frac{16}{3}$','explanation','Correct: intersections at $y=\pm2$ and area is $\int_{-2}^{2}[(5-y^2)-(y^2+1)]\,dy$.'),
    jsonb_build_object('id','D','text','$8$','explanation','This would be the area if the horizontal width were constant 4 over length 2, which it is not.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'Intersect: $y^2+1=5-y^2\Rightarrow 2y^2=4\Rightarrow y=\pm2$. Right-minus-left: $$A=\int_{-2}^{2}\big[(5-y^2)-(y^2+1)\big]\,dy=\int_{-2}^{2}(4-2y^2)\,dy.$$ Compute: $$\int(4-2y^2)\,dy=4y-\frac{2}{3}y^3.$$ Evaluate $[-2,2]$: $$A=\left(8-\frac{16}{3}\right)-\left(-8+\frac{16}{3}\right)=\frac{16}{3}.$$',
  recommendation_reasons = ARRAY['Practices clean $dy$ setup when both curves are $x=f(y)$.','Reinforces right-minus-left and definite integration.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Symmetric bounds from intersections; compute exact area.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  primary_skill_id = 'SK_SETUP_DY',
  supporting_skill_ids = ARRAY['SK_AREA_DY','SK_DEFINITE_INTEGRAL_EVAL'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_AppIntegration',
  updated_at = NOW()
WHERE title = '8.5-P3';

-- 8.5-P4
UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_AppIntegration',
  sub_topic_id = '8.5',
  section_id = '8.5',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 150,
  skill_tags = ARRAY['SK_SPLIT_INTEGRAL','SK_AREA_DY','SK_DEFINITE_INTEGRAL_EVAL'],
  error_tags = ARRAY['E_MISS_SPLIT_AT_SWITCH','E_RIGHT_MINUS_LEFT_SWAP','E_SIGN_ERROR_AREA'],
  prompt = 'Let $R$ be the region bounded by $x=y$ and $x=y^3$ for $-1\le y\le 1$. What is the area of $R$?',
  latex = 'Let $R$ be the region bounded by $x=y$ and $x=y^3$ for $-1\le y\le 1$. What is the area of $R$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$0$','explanation','Area cannot be 0 because the curves are distinct except at $y=-1,0,1$.'),
    jsonb_build_object('id','B','text','$\frac{1}{4}$','explanation','This is half the correct area; it ignores one side of the symmetry.'),
    jsonb_build_object('id','C','text','$\frac{2}{3}$','explanation','This comes from integrating $y-y^3$ on $[0,1]$ without doubling or splitting correctly.'),
    jsonb_build_object('id','D','text','$\frac{1}{2}$','explanation','Correct: the right-minus-left switches at $y=0$, requiring a split (or symmetry argument).')
  ),
  correct_option_id = 'D',
  tolerance = 0.0010,
  explanation = 'For $y\in[-1,0]$, $y^3>y$, so width is $(y^3-y)$. For $y\in[0,1]$, $y>y^3$, so width is $(y-y^3)$. Thus $$A=\int_{-1}^{0}(y^3-y)\,dy+\int_{0}^{1}(y-y^3)\,dy.$$ By symmetry these integrals are equal, so $$A=2\int_{0}^{1}(y-y^3)\,dy=2\left[\frac{y^2}{2}-\frac{y^4}{4}\right]_0^1=\frac12.$$',
  recommendation_reasons = ARRAY['Targets the common need to split when left/right swap.','Builds sign-awareness: area uses absolute horizontal distance.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Even with $dy$, left/right can swap; split at the switch point.',
  weight_primary = 0.75,
  weight_supporting = 0.25,
  primary_skill_id = 'SK_SPLIT_INTEGRAL',
  supporting_skill_ids = ARRAY['SK_AREA_DY','SK_DEFINITE_INTEGRAL_EVAL'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_AppIntegration',
  updated_at = NOW()
WHERE title = '8.5-P4';

-- 8.5-P5
UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_AppIntegration',
  sub_topic_id = '8.5',
  section_id = '8.5',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 5,
  target_time_seconds = 180,
  skill_tags = ARRAY['SK_CONVERT_DX_TO_DY','SK_SETUP_DY','SK_DEFINITE_INTEGRAL_EVAL','SK_SOLVE_INTERSECTIONS'],
  error_tags = ARRAY['E_DX_DY_MIXUP','E_BOUNDS_FROM_INTERSECTIONS','E_WRONG_LEFT_RIGHT_AFTER_SOLVE'],
  prompt = 'The region $R$ is bounded by $y=2x$ and $y=x^2$ (see image). Using integration with respect to $y$, what is the area of $R$?

![8.5-P5](8.5-P5.png)',
  latex = 'The region $R$ is bounded by $y=2x$ and $y=x^2$. Using integration with respect to $y$, what is the area of $R$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\frac{4}{3}$','explanation','Correct: $x=\frac{y}{2}$ and $x=\sqrt{y}$ on $0\le y\le 4$, so $\int_0^4(\sqrt{y}-y/2)\,dy=\frac{4}{3}$.'),
    jsonb_build_object('id','B','text','$\frac{8}{3}$','explanation','This is double the correct value; no extra symmetry factor is needed beyond the actual bounds.'),
    jsonb_build_object('id','C','text','$\frac{2}{3}$','explanation','This is half the correct value; it typically comes from dropping the $-y^2/4$ term.'),
    jsonb_build_object('id','D','text','$2$','explanation','This would be a rough estimate but not the exact integral value.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Intersections: $2x=x^2\Rightarrow x=0,2$, giving $y=0,4$. Solve for $x$ in terms of $y$: From $y=2x$, $x=\frac{y}{2}$. From $y=x^2$ in the region, $x=\sqrt{y}$. For $0\le y\le 4$, $\frac{y}{2}\le \sqrt{y}$, so left is $x=y/2$ and right is $x=\sqrt{y}$. $$A=\int_0^4\left(\sqrt{y}-\frac{y}{2}\right)dy=\left[\frac{2}{3}y^{3/2}-\frac{y^2}{4}\right]_0^4=\frac{4}{3}.$$',
  recommendation_reasons = ARRAY['Forces correct conversion $y=f(x)\to x=g(y)$ before integrating.','Targets the common left/right identification error in $dy$ setups.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 5,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Convert to $dy$: solve for $x$ as functions of $y$ and use right-minus-left.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  primary_skill_id = 'SK_CONVERT_DX_TO_DY',
  supporting_skill_ids = ARRAY['SK_SETUP_DY','SK_DEFINITE_INTEGRAL_EVAL','SK_SOLVE_INTERSECTIONS'],
  prompt_type = 'text_and_image',
  representation_type = 'symbolic',
  topic_id = 'Both_AppIntegration',
  updated_at = NOW()
WHERE title = '8.5-P5';

-- 8.6-P1
UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_AppIntegration',
  sub_topic_id = '8.6',
  section_id = '8.6',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 130,
  skill_tags = ARRAY['SK_SPLIT_INTEGRAL','SK_AREA_DX','SK_DEFINITE_INTEGRAL_EVAL'],
  error_tags = ARRAY['E_FORGET_ABSOLUTE_AREA','E_MISS_SPLIT_AT_INTERSECTIONS','E_TOP_MINUS_BOTTOM_CONFUSION'],
  prompt = 'Find the area of the region enclosed by $y=|x|$ and $y=x^2$.',
  latex = 'Find the area of the region enclosed by $y=|x|$ and $y=x^2$.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\frac{1}{6}$','explanation','This is the area on $[0,1]$ only, without doubling for symmetry.'),
    jsonb_build_object('id','B','text','$\frac{1}{3}$','explanation','Correct: symmetric about the $y$-axis; area is $2\int_0^1(x-x^2)\,dx=\frac{1}{3}$.'),
    jsonb_build_object('id','C','text','$\frac{2}{3}$','explanation','This typically comes from doubling twice (overcounting symmetry).'),
    jsonb_build_object('id','D','text','$1$','explanation','Overestimates; the bounded region is smaller than a $1\\times1$ square.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Intersections solve $|x|=x^2$. For $x\ge 0$: $x=x^2\Rightarrow x=0,1$. For $x\le 0$: $-x=x^2\Rightarrow x=0,-1$. On $[0,1]$, top is $y=x$ and bottom is $y=x^2$. By symmetry, $$A=2\int_0^1(x-x^2)\,dx=2\left[\frac{x^2}{2}-\frac{x^3}{3}\right]_0^1=\frac13.$$',
  recommendation_reasons = ARRAY['Introduces multiple intersection points and absolute-area thinking.','Reinforces symmetry as a legitimate simplifier (once).'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'More than two intersection points: use splitting and/or symmetry; area is nonnegative.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  primary_skill_id = 'SK_SPLIT_INTEGRAL',
  supporting_skill_ids = ARRAY['SK_AREA_DX','SK_DEFINITE_INTEGRAL_EVAL'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_AppIntegration',
  updated_at = NOW()
WHERE title = '8.6-P1';

-- 8.6-P2
UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_AppIntegration',
  sub_topic_id = '8.6',
  section_id = '8.6',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 160,
  skill_tags = ARRAY['SK_FIND_ZEROS_SIGN','SK_SPLIT_INTEGRAL','SK_DEFINITE_INTEGRAL_EVAL','SK_ABS_AREA'],
  error_tags = ARRAY['E_SIGNED_VS_AREA','E_MISS_SPLIT_AT_INTERSECTIONS','E_SIGN_ERROR_AREA'],
  prompt = 'Let $f(x)=x^3-3x$. Find the area between the graph of $y=f(x)$ and the $x$-axis on $[-2,2]$.',
  latex = 'Let $f(x)=x^3-3x$. Find the area between the graph of $y=f(x)$ and the $x$-axis on $[-2,2]$.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$0$','explanation','The signed integral is 0 by odd symmetry, but area is not the signed integral.'),
    jsonb_build_object('id','B','text','$2$','explanation','Too small; misses large lobes near $x=\pm2$.'),
    jsonb_build_object('id','C','text','$4$','explanation','This can occur if you split but make a sign mistake on one interval.'),
    jsonb_build_object('id','D','text','$5$','explanation','Correct: split at $x=-\sqrt3,0,\sqrt3$ and integrate absolute value.')
  ),
  correct_option_id = 'D',
  tolerance = 0.0010,
  explanation = 'Zeros: $x^3-3x=x(x^2-3)=0\Rightarrow x=-\sqrt3,0,\sqrt3$. Area is $$\int_{-2}^{2}|x^3-3x|\,dx.$$ By odd symmetry, the area is twice the area on $[0,2]$. On $(0,\sqrt3)$, $x^3-3x<0$; on $(\sqrt3,2)$, $x^3-3x>0$. So $$A=2\left(\int_{0}^{\sqrt3}-(x^3-3x)\,dx+\int_{\sqrt3}^{2}(x^3-3x)\,dx\right)=5.$$',
  recommendation_reasons = ARRAY['Trains split points from zeros and sign analysis.','Separates net change from geometric area.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Multiple zeros: split by sign; area uses $|f(x)|$.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  primary_skill_id = 'SK_FIND_ZEROS_SIGN',
  supporting_skill_ids = ARRAY['SK_SPLIT_INTEGRAL','SK_EVAL_DEF_INT','SK_ABS_AREA'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_AppIntegration',
  updated_at = NOW()
WHERE title = '8.6-P2';

-- 8.6-P3
UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_AppIntegration',
  sub_topic_id = '8.6',
  section_id = '8.6',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 1,
  target_time_seconds = 75,
  skill_tags = ARRAY['SK_ABS_AREA','SK_SPLIT_INTEGRAL','SK_EVAL_DEF_INT'],
  error_tags = ARRAY['E_SIGNED_VS_AREA','E_WRONG_SPLIT_POINT','E_TRIG_INTEGRAL_SIGN'],
  prompt = 'Find the area between $y=\sin x$ and $y=0$ on $[0,2\pi]$ (see image).

![8.6-P3](8.6-P3.png)',
  latex = 'Find the area between $y=\sin x$ and $y=0$ on $[0,2\pi]$.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$0$','explanation','That is the signed integral $\int_0^{2\pi}\sin x\,dx$, not the geometric area.'),
    jsonb_build_object('id','B','text','$2$','explanation','This is the area on $[0,\pi]$ only.'),
    jsonb_build_object('id','C','text','$4$','explanation','Correct: split at $x=\pi$ and add the two equal positive areas.'),
    jsonb_build_object('id','D','text','$\pi$','explanation','Area is not equal to the interval length; it requires integration of height.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'Geometric area is $$A=\int_0^{2\pi}|\sin x|\,dx=\int_0^{\pi}\sin x\,dx+\int_{\pi}^{2\pi}(-\sin x)\,dx.$$ Compute: $$\int_0^{\pi}\sin x\,dx=[-\cos x]_0^{\pi}=2,$$ $$\int_{\pi}^{2\pi}(-\sin x)\,dx=[\cos x]_{\pi}^{2\pi}=2.$$ So $A=4$.',
  recommendation_reasons = ARRAY['Fast check of absolute value area logic with trig.','Reinforces splitting at zeros/sign changes.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Absolute area: split where $\sin x$ changes sign.',
  weight_primary = 0.75,
  weight_supporting = 0.25,
  primary_skill_id = 'SK_ABS_AREA',
  supporting_skill_ids = ARRAY['SK_SPLIT_INTEGRAL','SK_EVAL_DEF_INT'],
  prompt_type = 'text_and_image',
  representation_type = 'symbolic',
  topic_id = 'Both_AppIntegration',
  updated_at = NOW()
WHERE title = '8.6-P3';

-- 8.6-P4
UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_AppIntegration',
  sub_topic_id = '8.6',
  section_id = '8.6',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 5,
  target_time_seconds = 190,
  skill_tags = ARRAY['SK_SOLVE_TRIG_INTERSECTIONS','SK_SPLIT_INTEGRAL','SK_TRIG_IDENTITIES','SK_ABS_AREA'],
  error_tags = ARRAY['E_MISS_SPLIT_AT_INTERSECTIONS','E_FORGET_ABSOLUTE_AREA','E_TRIG_SOLVE_INTERSECTIONS'],
  prompt = 'Find the area between $y=\sin x$ and $y=\sin(2x)$ on $[0,2\pi]$.',
  latex = 'Find the area between $y=\sin x$ and $y=\sin(2x)$ on $[0,2\pi]$.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$3$','explanation','Underestimates; there are multiple lobes over $[0,2\pi]$.'),
    jsonb_build_object('id','B','text','$5$','explanation','Correct: split at $x=0,\pi/3,\pi,5\pi/3,2\pi$ and integrate $|\sin x-\sin 2x|$.'),
    jsonb_build_object('id','C','text','$0$','explanation','That would be the signed integral if symmetry canceled, but area uses absolute value.'),
    jsonb_build_object('id','D','text','$2$','explanation','This typically comes from using only one lobe and forgetting the rest.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Intersections satisfy $\sin x=\sin 2x=2\sin x\cos x$. So either $\sin x=0$ giving $x=0,\pi,2\pi$, or $1=2\cos x$ giving $\cos x=\tfrac12$, so $x=\pi/3,5\pi/3$. Thus split $[0,2\pi]$ at $0,\pi/3,\pi,5\pi/3,2\pi$. Area: $$A=\int_0^{2\pi}|\sin x-\sin 2x|\,dx,$$ and on each subinterval the sign is constant, so remove absolute value with the correct sign and add. The result is $A=5$.',
  recommendation_reasons = ARRAY['Forces solving trig intersections beyond endpoints.','Builds correct split-and-sum workflow for >2 intersections.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 5,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Nontrivial intersections: solve and split; use absolute difference.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  primary_skill_id = 'SK_SOLVE_TRIG_INTERSECTIONS',
  supporting_skill_ids = ARRAY['SK_SPLIT_INTEGRAL','SK_TRIG_IDENTITIES','SK_ABS_AREA'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_AppIntegration',
  updated_at = NOW()
WHERE title = '8.6-P4';

-- 8.6-P5
UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_AppIntegration',
  sub_topic_id = '8.6',
  section_id = '8.6',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 140,
  skill_tags = ARRAY['SK_SPLIT_INTEGRAL','SK_AREA_DX','SK_EVAL_DEF_INT','SK_ABS_AREA'],
  error_tags = ARRAY['E_FORGET_ABSOLUTE_AREA','E_MISS_SPLIT_AT_INTERSECTIONS','E_TOP_MINUS_BOTTOM_CONFUSION'],
  prompt = 'Let $R$ be the region enclosed by $y=x$ and $y=x^3$ on $[-1,1]$. What is the area of $R$?',
  latex = 'Let $R$ be the region enclosed by $y=x$ and $y=x^3$ on $[-1,1]$. What is the area of $R$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\frac{1}{2}$','explanation','Correct: intersections at $x=-1,0,1$; area is $2\int_0^1(x-x^3)\,dx=\frac12$.'),
    jsonb_build_object('id','B','text','$0$','explanation','That is the signed integral of an odd function difference; area is not signed.'),
    jsonb_build_object('id','C','text','$1$','explanation','Overestimates; the maximum vertical gap is less than 1 over most of the interval.'),
    jsonb_build_object('id','D','text','$\frac{1}{4}$','explanation','This is the area on $[0,1]$ only (forgot doubling by symmetry).')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Intersections: $x=x^3\Rightarrow x(x^2-1)=0\Rightarrow x=-1,0,1$. On $[0,1]$, $x>x^3$, so gap is $(x-x^3)$. By symmetry, $$A=2\int_0^1(x-x^3)\,dx=2\left[\frac{x^2}{2}-\frac{x^4}{4}\right]_0^1=\frac12.$$',
  recommendation_reasons = ARRAY['Classic >2 intersection example: line vs cubic.','Reinforces symmetry and absolute-area concept.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'More than two intersection points: split (or symmetry) and use positive gap.',
  weight_primary = 0.75,
  weight_supporting = 0.25,
  primary_skill_id = 'SK_SPLIT_INTEGRAL',
  supporting_skill_ids = ARRAY['SK_AREA_DX','SK_EVAL_DEF_INT','SK_ABS_AREA'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_AppIntegration',
  updated_at = NOW()
WHERE title = '8.6-P5';

-- 8.9-P5
UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_AppIntegration',
  sub_topic_id = '8.9',
  section_id = '8.9',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 150,
  skill_tags = ARRAY['SK_VOL_DISC_EVALUATE','SK_VOL_DISC_SETUP'],
  error_tags = ARRAY['E_AXIS_RADIUS_CONFUSION','E_MISSING_PI','E_WRONG_BOUNDS'],
  prompt = 'The region bounded by $x=y$, $x=0$, $y=0$, and $y=2$ is revolved about the $y$-axis. What is the volume of the resulting solid using the disc method?',
  latex = 'The region bounded by $x=y$, $x=0$, $y=0$, and $y=2$ is revolved about the $y$-axis. What is the volume of the resulting solid using the disc method?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\dfrac{8\pi}{3}$','explanation','Correct. Radius is $r(y)=y$, so $V=\pi\int_0^2 y^2\,dy=\pi\left[\tfrac{y^3}{3}\right]_0^2=\tfrac{8\pi}{3}$.'),
    jsonb_build_object('id','B','text','$4\pi$','explanation','This comes from using $\pi\int_0^2 y\,dy$ (forgetting to square the radius).'),
    jsonb_build_object('id','C','text','$\dfrac{4\pi}{3}$','explanation','This can come from using the wrong bounds or halving the region by mistake.'),
    jsonb_build_object('id','D','text','$8\pi$','explanation','This is too large; check the antiderivative of $y^2$.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Rotate about the $y$-axis; discs use $dy$ with radius equal to the $x$-value. Since $x=y$, radius is $r(y)=y$ for $0\le y\le 2$. $$V=\pi\int_0^2 y^2\,dy=\pi\left[\frac{y^3}{3}\right]_0^2=\frac{8\pi}{3}.$$',
  recommendation_reasons = ARRAY['Connects radius to $x=y$ directly.','Reinforces squaring the radius and correct $dy$ bounds.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Disc method about y-axis with linear boundary x=y.',
  weight_primary = 0.85,
  weight_supporting = 0.15,
  primary_skill_id = 'SK_VOL_DISC_EVALUATE',
  supporting_skill_ids = ARRAY['SK_VOL_DISC_SETUP'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_AppIntegration',
  updated_at = NOW()
WHERE title = '8.9-P5';

COMMIT;
