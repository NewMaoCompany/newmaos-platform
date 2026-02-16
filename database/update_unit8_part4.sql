-- Unit 8.9 (Volume with Disc Method - Revolving Around x- or y-axis) — Practice 1–5

BEGIN;

UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_AppIntegration',
  sub_topic_id = '8.9',
  section_id = '8.9',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 90,
  skill_tags = ARRAY['SK_VOL_DISC_EVALUATE','SK_VOL_DISC_SETUP'],
  error_tags = ARRAY['E_MISSING_PI','E_FORGET_SQUARE_RADIUS','E_WRONG_BOUNDS'],
  prompt = 'Let $R$ be the region bounded by $y=\sqrt{x}$, $y=0$, $x=0$, and $x=4$. The region $R$ is revolved about the $x$-axis. What is the volume of the resulting solid?',
  latex = 'Let $R$ be the region bounded by $y=\sqrt{x}$, $y=0$, $x=0$, and $x=4$. The region $R$ is revolved about the $x$-axis. What is the volume of the resulting solid?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$8\pi$','explanation','Correct. $V=\pi\int_0^4 x\,dx=\pi\left[\tfrac{x^2}{2}\right]_0^4=8\pi$.'),
    jsonb_build_object('id','B','text','$4\pi$','explanation','This would come from forgetting the square on the radius or using $\int_0^4 \sqrt{x}\,dx$.'),
    jsonb_build_object('id','C','text','$16\pi$','explanation','This is double the correct value; a common cause is evaluating $\left[\tfrac{x^2}{2}\right]_0^4$ incorrectly.'),
    jsonb_build_object('id','D','text','$\dfrac{32\pi}{3}$','explanation','This corresponds to integrating $\sqrt{x}$ instead of $x$ after squaring the radius.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Using the disc method about the $x$-axis, radius $r(x)=\sqrt{x}$. Then
$$V=\pi\int_0^4 r(x)^2\,dx=\pi\int_0^4 x\,dx=\pi\left[\frac{x^2}{2}\right]_0^4=8\pi.$$',
  recommendation_reasons = ARRAY['Reinforces squaring the radius in disc method.','Checks correct use of bounds on $x$.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Disc method about the x-axis; radius must be squared and include \pi.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
    primary_skill_id = 'SK_VOL_DISC_EVALUATE',
  supporting_skill_ids = ARRAY['SK_VOL_DISC_SETUP'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_AppIntegration',
  updated_at = NOW()
WHERE title = '8.9-P1';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_AppIntegration',
  sub_topic_id = '8.9',
  section_id = '8.9',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 120,
  skill_tags = ARRAY['SK_VOL_DISC_EVALUATE','SK_FUNCTION_INVERSION','SK_VOL_DISC_SETUP'],
  error_tags = ARRAY['E_WRONG_VARIABLE_DX_DY','E_AXIS_RADIUS_CONFUSION','E_MISSING_PI'],
  prompt = 'The graph of the region bounded by $y=x^2$, $y=0$, and $x=1$ is shown in the figure labeled 8.9-P2. The region is revolved about the $y$-axis. Using the disc method, what is the volume of the solid?',
  latex = 'The graph of the region bounded by $y=x^2$, $y=0$, and $x=1$ is shown in the figure labeled 8.9-P2. The region is revolved about the $y$-axis. Using the disc method, what is the volume of the solid?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\pi$','explanation','This would result from using $\pi\int_0^1 1\,dy$ (incorrect constant radius).'),
    jsonb_build_object('id','B','text','$\dfrac{\pi}{2}$','explanation','Correct. About the $y$-axis with discs requires $dy$: $x=\sqrt{y}$, so $V=\pi\int_0^1 y\,dy=\pi/2$.'),
    jsonb_build_object('id','C','text','$\dfrac{\pi}{3}$','explanation','This is a common result from $\pi\int_0^1 x^2\,dx$ (wrong variable for disc method about the $y$-axis).'),
    jsonb_build_object('id','D','text','$\dfrac{2\pi}{3}$','explanation','This can come from mixing bounds or using an incorrect $y$-interval.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'For rotation about the $y$-axis using discs, take horizontal slices. Rewrite $y=x^2$ as $x=\sqrt{y}$. Radius is $r(y)=\sqrt{y}$ for $0\le y\le 1.
$$V=\pi\int_0^1 r(y)^2\,dy=\pi\int_0^1 y\,dy=\pi\left[\frac{y^2}{2}\right]_0^1=\frac{\pi}{2}.$$',
  recommendation_reasons = ARRAY['Targets choosing $dy$ for disc method about the $y$-axis.','Reinforces inverting $y=x^2$ to $x=\sqrt{y}$.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Disc method about the y-axis: must invert and integrate with respect to y.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
    primary_skill_id = 'SK_VOL_DISC_EVALUATE',
  supporting_skill_ids = ARRAY['SK_FUNCTION_INVERSION','SK_VOL_DISC_SETUP'],
  prompt_type = 'text_and_image',
  representation_type = 'symbolic',
  topic_id = 'Both_AppIntegration',
  updated_at = NOW()
WHERE title = '8.9-P2';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_AppIntegration',
  sub_topic_id = '8.9',
  section_id = '8.9',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 1,
  target_time_seconds = 75,
  skill_tags = ARRAY['SK_VOL_DISC_SETUP'],
  error_tags = ARRAY['E_FORGET_SQUARE_RADIUS','E_MISSING_PI','E_WRONG_BOUNDS'],
  prompt = 'The region bounded by $y=2x$, $y=0$, $x=0$, and $x=3$ is revolved about the $x$-axis. Which integral gives the volume of the solid using the disc method?',
  latex = 'The region bounded by $y=2x$, $y=0$, $x=0$, and $x=3$ is revolved about the $x$-axis. Which integral gives the volume of the solid using the disc method?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\displaystyle \int_0^3 2x\,dx$','explanation','This is area under the line, not volume; disc method needs $\pi r^2$.'),
    jsonb_build_object('id','B','text','$\displaystyle 2\pi\int_0^3 (2x)\,dx$','explanation','This incorrectly uses circumference-type reasoning and still misses squaring the radius.'),
    jsonb_build_object('id','C','text','$\displaystyle \pi\int_0^3 (2x)^2\,dx$','explanation','Correct. Radius is $r(x)=2x$, so disc area is $\pi(2x)^2$.'),
    jsonb_build_object('id','D','text','$\displaystyle \pi\int_0^2 x^2\,dx$','explanation','Incorrect bounds and incorrect radius.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'Disc method about the $x$-axis uses $V=\pi\int_a^b [r(x)]^2\,dx$ with $r(x)=y$. Here $y=2x$ and $x$ runs from $0$ to $3$, so
$$V=\pi\int_0^3 (2x)^2\,dx.$$',
  recommendation_reasons = ARRAY['Checks disc-method setup without computation.','Targets forgetting $r^2$ and \pi.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 1,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Pure setup recognition for disc method.',
  weight_primary = 1.00,
  weight_supporting = 0.00,
    primary_skill_id = 'SK_VOL_DISC_SETUP',
  supporting_skill_ids = ARRAY[]::text[],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_AppIntegration',
  updated_at = NOW()
WHERE title = '8.9-P3';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_AppIntegration',
  sub_topic_id = '8.9',
  section_id = '8.9',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 5,
  target_time_seconds = 180,
  skill_tags = ARRAY['SK_VOL_DISC_EVALUATE','SK_INTEGRATION_BY_PARTS','SK_VOL_DISC_SETUP'],
  error_tags = ARRAY['E_INTEGRATION_BY_PARTS_ERROR','E_MISSING_PI','E_WRONG_BOUNDS'],
  prompt = 'The graph of the region bounded by $y=\ln x$, $y=0$, $x=1$, and $x=e$ is shown in the figure labeled 8.9-P4. The region is revolved about the $x$-axis. What is the volume of the resulting solid?',
  latex = 'The graph of the region bounded by $y=\ln x$, $y=0$, $x=1$, and $x=e$ is shown in the figure labeled 8.9-P4. The region is revolved about the $x$-axis. What is the volume of the resulting solid?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\pi(e+2)$','explanation','This typically comes from sign mistakes in the antiderivative for $(\ln x)^2$.'),
    jsonb_build_object('id','B','text','$\pi(e-1)$','explanation','This often comes from incorrectly using $\int_1^e \ln x\,dx$ instead of $\int_1^e (\ln x)^2\,dx$.'),
    jsonb_build_object('id','C','text','$e-2$','explanation','This omits the required factor of $\pi$ from the disc method.'),
    jsonb_build_object('id','D','text','$\pi(e-2)$','explanation','Correct. Evaluate $\pi\int_1^{e} (\ln x)^2\,dx=\pi(e-2)$.')
  ),
  correct_option_id = 'D',
  tolerance = 0.0010,
  explanation = 'Disc method about the $x$-axis gives
$$V=\pi\int_1^{e} (\ln x)^2\,dx.$$
Use
$$\int (\ln x)^2\,dx=x\big((\ln x)^2-2\ln x+2\big)+C.$$
Evaluate: at $x=e$ gives $e(1-2+2)=e$; at $x=1$ gives $1(0-0+2)=2$. So $\int_1^e (\ln x)^2\,dx=e-2$, hence $V=\pi(e-2)$.',
  recommendation_reasons = ARRAY['Disc method plus nontrivial integral.','Targets integration-by-parts sign/term errors.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 5,
  mastery_weight = 1.20,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Requires correct antiderivative for $(\ln x)^2$ and the \pi factor.',
  weight_primary = 0.75,
  weight_supporting = 0.25,
    primary_skill_id = 'SK_VOL_DISC_EVALUATE',
  supporting_skill_ids = ARRAY['SK_INTEGRATION_BY_PARTS','SK_VOL_DISC_SETUP'],
  prompt_type = 'text_and_image',
  representation_type = 'symbolic',
  topic_id = 'Both_AppIntegration',
  updated_at = NOW()
WHERE title = '8.9-P4';


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
  explanation = 'Rotate about the $y$-axis; discs use $dy$ with radius equal to the $x$-value. Since $x=y$, radius is $r(y)=y$ for $0\le y\le 2$.
$$V=\pi\int_0^2 y^2\,dy=\pi\left[\frac{y^3}{3}\right]_0^2=\frac{8\pi}{3}.$$',
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



-- Unit 8.10 (Volume with Disc Method - Revolving Around Other Axes) — Practice 1–5

UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_AppIntegration',
  sub_topic_id = '8.10',
  section_id = '8.10',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 120,
  skill_tags = ARRAY['SK_AXIS_SHIFT','SK_VOL_DISC_EVALUATE','SK_VOL_DISC_SETUP'],
  error_tags = ARRAY['E_SHIFTED_AXIS_NOT_APPLIED','E_FORGET_SQUARE_RADIUS','E_MISSING_PI'],
  prompt = 'Let $R$ be the region bounded by $y=x$, $y=0$, $x=0$, and $x=1$. The region $R$ is revolved about the line $y=-1$. What is the volume of the resulting solid?',
  latex = 'Let $R$ be the region bounded by $y=x$, $y=0$, $x=0$, and $x=1$. The region $R$ is revolved about the line $y=-1$. What is the volume of the resulting solid?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\dfrac{\pi}{3}$','explanation','This is $\pi\int_0^1 x^2\,dx$, which ignores the vertical shift by 1.'),
    jsonb_build_object('id','B','text','$\dfrac{7\pi}{3}$','explanation','Correct. Radius is $r(x)=x-(-1)=x+1$, so $V=\pi\int_0^1 (x+1)^2\,dx=\tfrac{7\pi}{3}$.'),
    jsonb_build_object('id','C','text','$2\pi$','explanation','This can come from using $\pi\int_0^1 (x+1)\,dx$ (not squaring the radius).'),
    jsonb_build_object('id','D','text','$\dfrac{8\pi}{3}$','explanation','This is close but corresponds to integrating $(x+1)^2$ incorrectly.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Rotation about $y=-1$ shifts the radius by 1. For each $x$, the distance from $y=x$ to $y=-1$ is $r(x)=x+1$.
$$V=\pi\int_0^1 (x+1)^2\,dx=\pi\left[\frac{(x+1)^3}{3}\right]_0^1=\pi\cdot\frac{8-1}{3}=\frac{7\pi}{3}.$$',
  recommendation_reasons = ARRAY['Tests correct radius when axis is shifted.','Targets the common mistake of forgetting the shift.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Axis shift (y=-1): radius is distance to the shifted line.',
  weight_primary = 0.75,
  weight_supporting = 0.25,
    primary_skill_id = 'SK_AXIS_SHIFT',
  supporting_skill_ids = ARRAY['SK_VOL_DISC_EVALUATE','SK_VOL_DISC_SETUP'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_AppIntegration',
  updated_at = NOW()
WHERE title = '8.10-P1';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_AppIntegration',
  sub_topic_id = '8.10',
  section_id = '8.10',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 180,
  skill_tags = ARRAY['SK_AXIS_SHIFT','SK_VOL_DISC_SETUP','SK_VOL_DISC_EVALUATE','SK_FUNCTION_INVERSION'],
  error_tags = ARRAY['E_SETUP_WASHER_INNER_OUTER_SWAPPED','E_SHIFTED_AXIS_NOT_APPLIED','E_WRONG_VARIABLE_DX_DY'],
  prompt = 'The graph of the region bounded by $y=x^2$, $y=0$, and $x=2$ is shown in the figure labeled 8.10-P2. The region is revolved about the vertical line $x=3$. What is the volume of the resulting solid?',
  latex = 'The graph of the region bounded by $y=x^2$, $y=0$, and $x=2$ is shown in the figure labeled 8.10-P2. The region is revolved about the vertical line $x=3$. What is the volume of the resulting solid?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$4\pi$','explanation','Too small; typically from using an incorrect radius like $3-y$ or dropping the washer subtraction.'),
    jsonb_build_object('id','B','text','$\dfrac{32\pi}{3}$','explanation','This can occur if you use the wrong method/variable or fail to subtract the inner radius.'),
    jsonb_build_object('id','C','text','$8\pi$','explanation','Correct. Using washers with $dy$ about $x=3$ yields volume $8\pi$.'),
    jsonb_build_object('id','D','text','$12\pi$','explanation','This often comes from adding radii squares instead of subtracting.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'Rotate about $x=3$ (vertical), so use horizontal slices ($dy$) for washers. For a given $y$, the region runs from $x=\sqrt{y}$ to $x=2$ for $0\le y\le 4$.
Outer radius: $R(y)=3-\sqrt{y}$, inner radius: $r(y)=3-2=1$.
$$V=\pi\int_0^4\big(R(y)^2-r(y)^2\big)\,dy=\pi\int_0^4\big((3-\sqrt{y})^2-1\big)\,dy=8\pi.$$',
  recommendation_reasons = ARRAY['Forces correct outer/inner radii about a shifted vertical axis.','Targets the common washer swap and wrong-variable errors.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.10,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Shifted vertical axis x=3: washers in dy with outer/inner radii.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
    primary_skill_id = 'SK_AXIS_SHIFT',
  supporting_skill_ids = ARRAY['SK_VOL_DISC_SETUP','SK_VOL_DISC_EVALUATE','SK_FUNCTION_INVERSION'],
  prompt_type = 'text_and_image',
  representation_type = 'symbolic',
  topic_id = 'Both_AppIntegration',
  updated_at = NOW()
WHERE title = '8.10-P2';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_AppIntegration',
  sub_topic_id = '8.10',
  section_id = '8.10',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 150,
  skill_tags = ARRAY['SK_AXIS_SHIFT','SK_VOL_DISC_EVALUATE','SK_VOL_DISC_SETUP'],
  error_tags = ARRAY['E_SHIFTED_AXIS_NOT_APPLIED','E_FORGET_SQUARE_RADIUS','E_MISSING_PI'],
  prompt = 'The graph of the region bounded by $y=x^2$, $y=0$, $x=0$, and $x=1$ is shown in the figure labeled 8.10-P3. The region is revolved about the line $y=2$. What is the volume of the resulting solid?',
  latex = 'The graph of the region bounded by $y=x^2$, $y=0$, $x=0$, and $x=1$ is shown in the figure labeled 8.10-P3. The region is revolved about the line $y=2$. What is the volume of the resulting solid?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\dfrac{\pi}{3}$','explanation','This is far too small; it ignores the shift and uses an incorrect radius.'),
    jsonb_build_object('id','B','text','$\dfrac{7\pi}{3}$','explanation','This matches a different setup (e.g., rotating $y=x$ about $y=-1$).'),
    jsonb_build_object('id','C','text','$\dfrac{43\pi}{30}$','explanation','This is half the correct value; it often comes from dropping a term when expanding $(2-x^2)^2$.'),
    jsonb_build_object('id','D','text','$\dfrac{43\pi}{15}$','explanation','Correct. $V=\pi\int_0^1 (2-x^2)^2\,dx=\dfrac{43\pi}{15}$.')
  ),
  correct_option_id = 'D',
  tolerance = 0.0010,
  explanation = 'Rotation about $y=2$ gives radius $r(x)=2-x^2$.
$$V=\pi\int_0^1 (2-x^2)^2\,dx=\pi\int_0^1 (4-4x^2+x^4)\,dx
=\pi\left[4x-\frac{4}{3}x^3+\frac{1}{5}x^5\right]_0^1
=\pi\left(4-\frac{4}{3}+\frac{1}{5}\right)=\frac{43\pi}{15}.$$',
  recommendation_reasons = ARRAY['Tests distance-to-axis radius for a shifted horizontal axis.','Reinforces expanding and integrating a squared expression.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Shifted horizontal axis y=2: radius is vertical distance to the axis.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
    primary_skill_id = 'SK_AXIS_SHIFT',
  supporting_skill_ids = ARRAY['SK_VOL_DISC_EVALUATE','SK_VOL_DISC_SETUP'],
  prompt_type = 'text_and_image',
  representation_type = 'symbolic',
  topic_id = 'Both_AppIntegration',
  updated_at = NOW()
WHERE title = '8.10-P3';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_AppIntegration',
  sub_topic_id = '8.10',
  section_id = '8.10',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 1,
  target_time_seconds = 90,
  skill_tags = ARRAY['SK_AXIS_SHIFT','SK_VOL_DISC_EVALUATE'],
  error_tags = ARRAY['E_SETUP_WASHER_INNER_OUTER_SWAPPED','E_MISSING_PI','E_SHIFTED_AXIS_NOT_APPLIED'],
  prompt = 'The rectangular region bounded by $y=0$, $y=1$, $x=0$, and $x=1$ is revolved about the vertical line $x=-2$. What is the volume of the resulting solid?',
  latex = 'The rectangular region bounded by $y=0$, $y=1$, $x=0$, and $x=1$ is revolved about the vertical line $x=-2$. What is the volume of the resulting solid?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$5\pi$','explanation','Correct. Outer radius $3$, inner radius $2$, height in $y$ is $1$ so $V=\pi(9-4)\cdot 1=5\pi$.'),
    jsonb_build_object('id','B','text','$\pi$','explanation','This ignores the shift and treats the radius as 1.'),
    jsonb_build_object('id','C','text','$13\pi$','explanation','This comes from adding radii squares: $9+4$ instead of subtracting.'),
    jsonb_build_object('id','D','text','$\dfrac{5\pi}{2}$','explanation','This incorrectly halves the height or uses an incorrect interval.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Revolving the strip $0\le x\le 1$ about $x=-2$ creates washers for each $y$. Outer radius $R=1-(-2)=3$, inner radius $r=0-(-2)=2$.
Area is $\pi(R^2-r^2)=\pi(9-4)=5\pi$. Integrate over $y$ from 0 to 1:
$$V=\int_0^1 5\pi\,dy=5\pi.$$',
  recommendation_reasons = ARRAY['Fast check of distance-to-axis radii for a shifted vertical axis.','Reinforces washer subtraction.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 1,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Constant radii washer due to rectangle and shifted axis.',
  weight_primary = 0.90,
  weight_supporting = 0.10,
    primary_skill_id = 'SK_AXIS_SHIFT',
  supporting_skill_ids = ARRAY['SK_VOL_DISC_EVALUATE'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_AppIntegration',
  updated_at = NOW()
WHERE title = '8.10-P4';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_AppIntegration',
  sub_topic_id = '8.10',
  section_id = '8.10',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 5,
  target_time_seconds = 180,
  skill_tags = ARRAY['SK_AXIS_SHIFT','SK_VOL_DISC_EVALUATE','SK_VOL_DISC_SETUP'],
  error_tags = ARRAY['E_SETUP_WASHER_INNER_OUTER_SWAPPED','E_SHIFTED_AXIS_NOT_APPLIED','E_WRONG_VARIABLE_DX_DY'],
  prompt = 'The region bounded by $x=y^2$, $x=0$, $y=0$, and $y=1$ is revolved about the vertical line $x=-1$. What is the volume of the resulting solid?',
  latex = 'The region bounded by $x=y^2$, $x=0$, $y=0$, and $y=1$ is revolved about the vertical line $x=-1$. What is the volume of the resulting solid?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\dfrac{8\pi}{15}$','explanation','This can come from integrating $y^4+y^2$ instead of $y^4+2y^2$.'),
    jsonb_build_object('id','B','text','$\dfrac{13\pi}{15}$','explanation','Correct. Outer radius $y^2+1$, inner radius $1$, so integrand is $y^4+2y^2$ and integrates to $\tfrac{13}{15}$.'),
    jsonb_build_object('id','C','text','$\dfrac{2\pi}{3}$','explanation','This is $\pi\int_0^1 2y^2\,dy$, which drops the $y^4$ term.'),
    jsonb_build_object('id','D','text','$\dfrac{\pi}{5}$','explanation','This would be $\pi\int_0^1 y^4\,dy$ only, missing the $2y^2$ contribution.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Use washers with $dy$ (axis is vertical). For each $y\in[0,1]$, the region runs from $x=0$ to $x=y^2$.
Distances to $x=-1$: outer radius $R(y)=y^2-(-1)=y^2+1$, inner radius $r(y)=0-(-1)=1$.
$$V=\pi\int_0^1\big((y^2+1)^2-1^2\big)\,dy
=\pi\int_0^1 (y^4+2y^2)\,dy
=\pi\left(\frac{1}{5}+\frac{2}{3}\right)=\frac{13\pi}{15}.$$',
  recommendation_reasons = ARRAY['Forces careful shifted-axis radii and washer subtraction.','Tests algebra after expanding $(y^2+1)^2$.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 5,
  mastery_weight = 1.20,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Shifted vertical axis (x=-1): dy washers with correct outer/inner radii.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
    primary_skill_id = 'SK_AXIS_SHIFT',
  supporting_skill_ids = ARRAY['SK_VOL_DISC_EVALUATE','SK_VOL_DISC_SETUP'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_AppIntegration',
  updated_at = NOW()
WHERE title = '8.10-P5';

COMMIT;
