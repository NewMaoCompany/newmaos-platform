-- Unit 8.11 (Volume with Washer Method - Revolving Around x- or y-axis) — Practice 1–5

BEGIN;

UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_AppIntegration',
  sub_topic_id = '8.11',
  section_id = '8.11',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 90,
  skill_tags = ARRAY['SK_WASHER_SETUP', 'SK_INTEGRAL_EVAL'],
  error_tags = ARRAY['E_WRONG_RADIUS', 'E_FORGET_PI', 'E_ARITH'],
  prompt = 'Let $R$ be the region bounded by $y=3-x$, $y=0$, $x=0$, and $x=2$. The region is revolved about the $x$-axis. What is the volume of the resulting solid?',
  latex = 'Let $R$ be the region bounded by $y=3-x$, $y=0$, $x=0$, and $x=2$. The region is revolved about the $x$-axis. What is the volume of the resulting solid?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\dfrac{26\pi}{3}$','explanation','Correct: $V=\pi\int_0^2(3-x)^2dx=\dfrac{26\pi}{3}$.'),
    jsonb_build_object('id','B','text','$\dfrac{13\pi}{3}$','explanation','Typically from an arithmetic slip when evaluating $\left[\frac{x^3}{3}-3x^2+9x\right]_0^2$.'),
    jsonb_build_object('id','C','text','$26\pi$','explanation','Often from forgetting the $\frac{1}{3}$ that appears when integrating $x^2$.'),
    jsonb_build_object('id','D','text','$\dfrac{52\pi}{3}$','explanation','Often from doubling a single-washer integral or overcounting the region.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Using washers about the $x$-axis: $$V=\pi\int_0^2(3-x)^2\,dx=\pi\int_0^2(x^2-6x+9)\,dx.$$ Compute $$\int_0^2(x^2-6x+9)\,dx=\left[\frac{x^3}{3}-3x^2+9x\right]_0^2=\frac{26}{3}.$$ Thus $V=\dfrac{26\pi}{3}$.',
  recommendation_reasons = ARRAY['Reinforces washer setup about the x-axis with a linear radius.','Targets careful expansion/integration with the $\pi$ factor.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Washer about x-axis; straightforward computation.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
    primary_skill_id = 'SK_WASHER_SETUP',
  supporting_skill_ids = ARRAY['SK_INTEGRAL_EVAL'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_AppIntegration',
  updated_at = NOW()
WHERE title = '8.11-P1';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_AppIntegration',
  sub_topic_id = '8.11',
  section_id = '8.11',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 150,
  skill_tags = ARRAY['SK_OUTER_INNER', 'SK_WASHER_SETUP', 'SK_INTEGRAL_EVAL'],
  error_tags = ARRAY['E_OUTER_INNER_SWAP', 'E_POWER_ALGEBRA', 'E_FORGOT_PI'],
  prompt = 'The region is bounded by $y=2x$ and $y=x^2$ for $0\le x\le 2$. The region is revolved about the $x$-axis. What is the volume?',
  latex = 'The region is bounded by $y=2x$ and $y=x^2$ for $0\le x\le 2$. The region is revolved about the $x$-axis. What is the volume?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\dfrac{32\pi}{15}$','explanation','Often from missing a factor of 2 when squaring $2x$ (treating $(2x)^2$ as $2x^2$).'),
    jsonb_build_object('id','B','text','$\dfrac{64\pi}{3}$','explanation','Incorrect antiderivative evaluation; magnitude is too large for this region.'),
    jsonb_build_object('id','C','text','$\dfrac{64\pi}{15}$','explanation','Correct: $V=\pi\int_0^2\big((2x)^2-(x^2)^2\big)\,dx=\dfrac{64\pi}{15}$.'),
    jsonb_build_object('id','D','text','$\dfrac{64\pi}{5}$','explanation','Common arithmetic slip when combining $\frac{32}{3}-\frac{32}{5}$.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'Outer radius is $R(x)=2x$ and inner radius is $r(x)=x^2$ on $[0,2]$. $$V=\pi\int_0^2\left(R^2-r^2\right)dx=\pi\int_0^2(4x^2-x^4)\,dx.$$ $$\int_0^2(4x^2-x^4)\,dx=\left[\frac{4x^3}{3}-\frac{x^5}{5}\right]_0^2=\frac{32}{3}-\frac{32}{5}=\frac{64}{15}.$$ So $V=\dfrac{64\pi}{15}$.',
  recommendation_reasons = ARRAY['Practices identifying outer vs inner radius when revolving between curves.','Targets correct squaring and subtraction before integrating.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.20,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Includes diagram (8.11-P2.png) to support outer/inner identification.',
  weight_primary = 0.90,
  weight_supporting = 0.10,
    primary_skill_id = 'SK_OUTER_INNER',
  supporting_skill_ids = ARRAY['SK_WASHER_SETUP','SK_INTEGRAL_EVAL'],
  prompt_type = 'text_and_image',
  representation_type = 'symbolic',
  topic_id = 'Both_AppIntegration',
  updated_at = NOW()
WHERE title = '8.11-P2';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_AppIntegration',
  sub_topic_id = '8.11',
  section_id = '8.11',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 120,
  skill_tags = ARRAY['SK_WASHER_SETUP', 'SK_ORIENTATION_CHOICE', 'SK_INTEGRAL_EVAL'],
  error_tags = ARRAY['E_WRONG_VARIABLE', 'E_WRONG_RADIUS', 'E_FORGOT_PI'],
  prompt = 'The region bounded by $y=\sqrt{x}$, $y=0$, and $x=9$ is revolved about the $y$-axis. What is the volume?',
  latex = 'The region bounded by $y=\sqrt{x}$, $y=0$, and $x=9$ is revolved about the $y$-axis. What is the volume?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$81\pi$','explanation','Often from integrating with respect to $x$ without converting to $y$, leading to a mismatched setup.'),
    jsonb_build_object('id','B','text','$\dfrac{81\pi}{5}$','explanation','Often from using incorrect $y$-bounds (for example, $0\le y\le \sqrt{9}=3$ is correct, but a wrong bound changes the value).'),
    jsonb_build_object('id','C','text','$\dfrac{243\pi}{10}$','explanation','Arithmetic slip evaluating $\frac{3^5}{5}$.'),
    jsonb_build_object('id','D','text','$\dfrac{243\pi}{5}$','explanation','Correct: write $x=y^2$, then $V=\pi\int_0^3 y^4\,dy=\dfrac{243\pi}{5}$.')
  ),
  correct_option_id = 'D',
  tolerance = 0.0010,
  explanation = 'Use washers with respect to $y$. Since $y=\sqrt{x}$, we have $x=y^2$. With $x=9$, $y$ runs from $0$ to $3$. $$V=\pi\int_0^3 (y^2)^2\,dy=\pi\int_0^3 y^4\,dy=\pi\left[\frac{y^5}{5}\right]_0^3=\frac{243\pi}{5}.$$',
  recommendation_reasons = ARRAY['Trains choosing dy for rotation about the y-axis.','Reinforces converting between $y=\sqrt{x}$ and $x=y^2$ with correct bounds.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.10,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Washer about y-axis; emphasizes changing variables and bounds.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
    primary_skill_id = 'SK_WASHER_SETUP',
  supporting_skill_ids = ARRAY['SK_ORIENTATION_CHOICE','SK_INTEGRAL_EVAL'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_AppIntegration',
  updated_at = NOW()
WHERE title = '8.11-P3';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_AppIntegration',
  sub_topic_id = '8.11',
  section_id = '8.11',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 150,
  skill_tags = ARRAY['SK_OUTER_INNER', 'SK_WASHER_SETUP', 'SK_INTEGRAL_EVAL'],
  error_tags = ARRAY['E_OUTER_INNER_SWAP', 'E_WRONG_RADIUS', 'E_FORGOT_PI'],
  prompt = 'The region is bounded by $x=y^2$ and $x=4$ for $0\le y\le 2$. The region is revolved about the $y$-axis. What is the volume?',
  latex = 'The region is bounded by $x=y^2$ and $x=4$ for $0\le y\le 2$. The region is revolved about the $y$-axis. What is the volume?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\dfrac{32\pi}{5}$','explanation','Often from forgetting $R^2$ (using $R=4$ instead of $R^2=16$).'),
    jsonb_build_object('id','B','text','$\dfrac{128\pi}{5}$','explanation','Correct: $V=\pi\int_0^2(16-y^4)\,dy=\dfrac{128\pi}{5}$.'),
    jsonb_build_object('id','C','text','$\dfrac{64\pi}{5}$','explanation','Often from using inner radius $r=y^2$ but forgetting to square again for $r^2=y^4$.'),
    jsonb_build_object('id','D','text','$\dfrac{96\pi}{5}$','explanation','Arithmetic slip combining $32-\frac{32}{5}$.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'About the $y$-axis with $dy$: outer radius $R(y)=4$, inner radius $r(y)=y^2$. $$V=\pi\int_0^2\left(R^2-r^2\right)dy=\pi\int_0^2(16-y^4)\,dy.$$ $$\int_0^2(16-y^4)dy=\left[16y-\frac{y^5}{5}\right]_0^2=32-\frac{32}{5}=\frac{128}{5}.$$ So $V=\dfrac{128\pi}{5}$.',
  recommendation_reasons = ARRAY['Reinforces washer setup about the y-axis using dy.','Targets the common mistake: squaring the inner radius correctly.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.20,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Includes diagram (8.11-P4.png) to support interpreting radii from x-as-function-of-y boundaries.',
  weight_primary = 0.90,
  weight_supporting = 0.10,
    primary_skill_id = 'SK_OUTER_INNER',
  supporting_skill_ids = ARRAY['SK_WASHER_SETUP','SK_INTEGRAL_EVAL'],
  prompt_type = 'text_and_image',
  representation_type = 'symbolic',
  topic_id = 'Both_AppIntegration',
  updated_at = NOW()
WHERE title = '8.11-P4';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_AppIntegration',
  sub_topic_id = '8.11',
  section_id = '8.11',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 1,
  target_time_seconds = 75,
  skill_tags = ARRAY['SK_WASHER_SETUP'],
  error_tags = ARRAY['E_POWER_ALGEBRA', 'E_FORGOT_PI', 'E_WRONG_BOUNDS'],
  prompt = 'The region bounded by $y=\dfrac{1}{x}$, $y=0$, $x=1$, and $x=3$ is revolved about the $x$-axis. What is the volume?',
  latex = 'The region bounded by $y=\dfrac{1}{x}$, $y=0$, $x=1$, and $x=3$ is revolved about the $x$-axis. What is the volume?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\dfrac{2\pi}{3}$','explanation','Correct: $V=\pi\int_1^3(1/x^2)\,dx=\frac{2\pi}{3}$.'),
    jsonb_build_object('id','B','text','$2\pi$','explanation','Often from integrating $1/x$ instead of $(1/x)^2$.'),
    jsonb_build_object('id','C','text','$\dfrac{\pi}{3}$','explanation','Often from dropping one endpoint contribution when evaluating $\left[-\frac{1}{x}\right]_1^3$.'),
    jsonb_build_object('id','D','text','$\dfrac{4\pi}{3}$','explanation','Often from doubling the correct answer without justification.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Washer (disk) method about the $x$-axis: $$V=\pi\int_1^3\left(\frac{1}{x}\right)^2dx=\pi\int_1^3 x^{-2}dx=\pi\left[-\frac{1}{x}\right]_1^3=\pi\left(1-\frac{1}{3}\right)=\frac{2\pi}{3}.$$',
  recommendation_reasons = ARRAY['Quick check on squaring the radius and using correct bounds.','Addresses the common error of using $\int 1/x$ instead of $\int 1/x^2$.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 1,
  mastery_weight = 0.90,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Basic disk volume; emphasizes squaring radius.',
  weight_primary = 1.00,
  weight_supporting = 0.00,
    primary_skill_id = 'SK_WASHER_SETUP',
  supporting_skill_ids = ARRAY[]::text[],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_AppIntegration',
  updated_at = NOW()
WHERE title = '8.11-P5';



-- Unit 8.12 (Volume with Washer Method - Revolving Around Other Axes) — Practice 1–5

UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_AppIntegration',
  sub_topic_id = '8.12',
  section_id = '8.12',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 5,
  target_time_seconds = 180,
  skill_tags = ARRAY['SK_AXIS_SHIFT_WASHER', 'SK_OUTER_INNER', 'SK_INTEGRAL_EVAL'],
  error_tags = ARRAY['E_AXIS_SHIFT', 'E_WRONG_RADIUS', 'E_ABS_VALUE', 'E_FORGOT_PI'],
  prompt = 'The region bounded by $y=\sqrt{x}$ and $y=0$ for $0\le x\le 4$ is revolved about the line $y=1$. What is the volume?',
  latex = 'The region bounded by $y=\sqrt{x}$ and $y=0$ for $0\le x\le 4$ is revolved about the line $y=1$. What is the volume?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\dfrac{16\pi}{3}$','explanation','Often from dropping the $-x$ term after simplifying $1-(\sqrt{x}-1)^2$.'),
    jsonb_build_object('id','B','text','$4\pi$','explanation','Often from treating the solid as a cylinder-like shape rather than washers with changing radii.'),
    jsonb_build_object('id','C','text','$\dfrac{8\pi}{3}$','explanation','Correct: $V=\pi\int_0^4\left(1-(\sqrt{x}-1)^2\right)\,dx=\dfrac{8\pi}{3}$.'),
    jsonb_build_object('id','D','text','$\dfrac{10\pi}{3}$','explanation','Arithmetic slip when evaluating $\frac{32}{3}-8$.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'Revolve about $y=1$. With vertical slices, distances to the axis are $1$ and $|\sqrt{x}-1|$, so washer area is $$\pi\left(1^2-(|\sqrt{x}-1|)^2\right)=\pi\left(1-(\sqrt{x}-1)^2\right).$$ Simplify: $1-(\sqrt{x}-1)^2=2\sqrt{x}-x$. Thus $$V=\pi\int_0^4(2\sqrt{x}-x)\,dx=\pi\left[\frac{4}{3}x^{3/2}-\frac{x^2}{2}\right]_0^4=\pi\left(\frac{32}{3}-8\right)=\frac{8\pi}{3}.$$',
  recommendation_reasons = ARRAY['Targets shifted-axis washer radii as distances to $y=1$.','Addresses the absolute-value distance issue (squaring removes sign but setup must be correct).'],
  status = 'published',
  version = version + 1,
  reasoning_level = 5,
  mastery_weight = 1.30,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Axis passes through the region; squared distance handles sign but setup must be correct.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
    primary_skill_id = 'SK_AXIS_SHIFT_WASHER',
  supporting_skill_ids = ARRAY['SK_OUTER_INNER','SK_INTEGRAL_EVAL'],
  prompt_type = 'text_and_image',
  representation_type = 'symbolic',
  topic_id = 'Both_AppIntegration',
  updated_at = NOW()
WHERE title = '8.12-P1';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_AppIntegration',
  sub_topic_id = '8.12',
  section_id = '8.12',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 160,
  skill_tags = ARRAY['SK_AXIS_SHIFT_WASHER', 'SK_INTEGRAL_EVAL'],
  error_tags = ARRAY['E_AXIS_SHIFT', 'E_WRONG_RADIUS', 'E_FORGOT_PI'],
  prompt = 'The region bounded by $y=2$, $y=x^2$, and $0\le x\le 1$ is revolved about the line $y=-1$. What is the volume?',
  latex = 'The region bounded by $y=2$, $y=x^2$, and $0\le x\le 1$ is revolved about the line $y=-1$. What is the volume?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\dfrac{32\pi}{15}$','explanation','Often from using $R=2$ instead of the shifted distance $R=3$, or from incomplete squaring.'),
    jsonb_build_object('id','B','text','$\dfrac{107\pi}{15}$','explanation','Correct: $V=\pi\int_0^1\left(9-(x^2+1)^2\right)\,dx=\dfrac{107\pi}{15}$.'),
    jsonb_build_object('id','C','text','$\dfrac{53\pi}{15}$','explanation','Often from forgetting the $+1$ inside $(x^2+1)^2$.'),
    jsonb_build_object('id','D','text','$\dfrac{107\pi}{5}$','explanation','Typically from not dividing by 3 or 5 when integrating polynomial terms.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'About $y=-1$, outer radius to $y=2$ is $R=3$ and inner radius to $y=x^2$ is $r=x^2+1$. $$V=\pi\int_0^1\left(R^2-r^2\right)dx=\pi\int_0^1\left(9-(x^2+1)^2\right)dx.$$ Since $(x^2+1)^2=x^4+2x^2+1$, integrand is $8-2x^2-x^4$. $$\int_0^1(8-2x^2-x^4)\,dx=\left[8x-\frac{2}{3}x^3-\frac{1}{5}x^5\right]_0^1=8-\frac{2}{3}-\frac{1}{5}=\frac{107}{15}.$$ So $V=\dfrac{107\pi}{15}$.',
  recommendation_reasons = ARRAY['Shifted-axis washer setup with both radii shifted.','Checks careful algebra in squaring $(x^2+1)$.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.20,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Shifted horizontal axis; emphasizes correct distance expressions.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
    primary_skill_id = 'SK_AXIS_SHIFT_WASHER',
  supporting_skill_ids = ARRAY['SK_INTEGRAL_EVAL'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_AppIntegration',
  updated_at = NOW()
WHERE title = '8.12-P2';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_AppIntegration',
  sub_topic_id = '8.12',
  section_id = '8.12',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 5,
  target_time_seconds = 180,
  skill_tags = ARRAY['SK_AXIS_SHIFT_WASHER', 'SK_ORIENTATION_CHOICE', 'SK_OUTER_INNER'],
  error_tags = ARRAY['E_WRONG_VARIABLE', 'E_AXIS_SHIFT', 'E_OUTER_INNER_SWAP', 'E_FORGOT_PI'],
  prompt = 'The region bounded by $y=\ln x$ and $y=0$ for $1\le x\le e$ is revolved about the line $x=-1$. What is the volume?',
  latex = 'The region bounded by $y=\ln x$ and $y=0$ for $1\le x\le e$ is revolved about the line $x=-1$. What is the volume?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\pi\left(\dfrac{e^2-1}{2}+2e-5\right)$','explanation','Correct: use $dy$ with $x=e^y$; $R=e^y+1$, $r=2$.'),
    jsonb_build_object('id','B','text','$\pi\left(\dfrac{e^2-1}{2}+2e-2\right)$','explanation','Often from forgetting to integrate the constant term correctly (dropping $-3y$ at evaluation).'),
    jsonb_build_object('id','C','text','$\pi\left(\dfrac{e^2-1}{2}+2e-3\right)$','explanation','Often from subtracting $3$ once instead of integrating $-3$ over an interval of length 1.'),
    jsonb_build_object('id','D','text','$\pi\left(\dfrac{e^2-1}{2}+e-5\right)$','explanation','Often from dropping the factor 2 in the $2e^y$ term when expanding $(e^y+1)^2$.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Rotate about $x=-1$ using washers with $dy$. Since $y=\ln x$, write $x=e^y$, and $y$ runs from $0$ to $1$. Left boundary is $x=1$. Radii are distances to $x=-1$: $R(y)=e^y+1$, $r(y)=2$. $$V=\pi\int_0^1\left((e^y+1)^2-2^2\right)dy=\pi\int_0^1\left(e^{2y}+2e^y-3\right)dy.$$ $$\int_0^1\left(e^{2y}+2e^y-3\right)dy=\left[\frac{1}{2}e^{2y}+2e^y-3y\right]_0^1=\frac{e^2-1}{2}+2(e-1)-3.$$ Hence $V=\pi\left(\frac{e^2-1}{2}+2e-5\right)$.',
  recommendation_reasons = ARRAY['Forces correct orientation choice (dy) for a vertical shifted axis.','Reinforces converting $y=\ln x$ to $x=e^y$ with correct radii distances.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 5,
  mastery_weight = 1.30,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Shifted vertical axis; requires rewriting $x=e^y$ and using $dy$.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
    primary_skill_id = 'SK_AXIS_SHIFT_WASHER',
  supporting_skill_ids = ARRAY['SK_ORIENTATION_CHOICE','SK_OUTER_INNER'],
  prompt_type = 'text_and_image',
  representation_type = 'symbolic',
  topic_id = 'Both_AppIntegration',
  updated_at = NOW()
WHERE title = '8.12-P3';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_AppIntegration',
  sub_topic_id = '8.12',
  section_id = '8.12',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 140,
  skill_tags = ARRAY['SK_AXIS_SHIFT_WASHER', 'SK_OUTER_INNER'],
  error_tags = ARRAY['E_AXIS_SHIFT', 'E_ABS_VALUE', 'E_OUTER_INNER_SWAP', 'E_FORGOT_PI'],
  prompt = 'The region bounded by $x=0$, $x=y+1$, $y=0$, and $y=2$ is revolved about the line $x=2$. What is the volume?',
  latex = 'The region bounded by $x=0$, $x=y+1$, $y=0$, and $y=2$ is revolved about the line $x=2$. What is the volume?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\dfrac{20\pi}{3}$','explanation','Often from using an incorrect inner-radius integral.'),
    jsonb_build_object('id','B','text','$\dfrac{22\pi}{3}$','explanation','Correct: $V=\pi\int_0^2\left(4-(1-y)^2\right)\,dy=\dfrac{22\pi}{3}$.'),
    jsonb_build_object('id','C','text','$\dfrac{26\pi}{3}$','explanation','Often from forgetting that the inner radius is squared: $(1-y)^2$.'),
    jsonb_build_object('id','D','text','$8\pi$','explanation','Often from ignoring the hole (using $V=\pi\int_0^2 4\,dy$).')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Use washers with $dy$ about $x=2$. For $y\in[0,2]$, segment runs from $x=0$ to $x=y+1$. Outer radius is $R=|2-0|=2$. Inner radius is $r=|2-(y+1)|=|1-y|$. $$V=\pi\int_0^2\left(R^2-r^2\right)dy=\pi\int_0^2\left(4-(1-y)^2\right)dy.$$ $$\int_0^2 (1-y)^2dy=\left[\frac{(y-1)^3}{3}\right]_0^2=\frac{1-(-1)}{3}=\frac{2}{3}.$$ Thus $V=\pi\left(8-\frac{2}{3}\right)=\frac{22\pi}{3}$.',
  recommendation_reasons = ARRAY['Targets vertical shifted axis with dy and distance-to-axis expressions.','Emphasizes that absolute value disappears only after squaring the radius.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.10,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Shifted vertical axis; careful with outer/inner and absolute value.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
    primary_skill_id = 'SK_AXIS_SHIFT_WASHER',
  supporting_skill_ids = ARRAY['SK_OUTER_INNER'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_AppIntegration',
  updated_at = NOW()
WHERE title = '8.12-P4';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_AppIntegration',
  sub_topic_id = '8.12',
  section_id = '8.12',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 120,
  skill_tags = ARRAY['SK_AXIS_SHIFT_WASHER', 'SK_INTEGRAL_EVAL'],
  error_tags = ARRAY['E_AXIS_SHIFT', 'E_WRONG_RADIUS', 'E_FORGOT_PI'],
  prompt = 'The region bounded by $y=x$, $y=0$, and $0\le x\le 2$ is revolved about the line $y=3$. What is the volume?',
  latex = 'The region bounded by $y=x$, $y=0$, and $0\le x\le 2$ is revolved about the line $y=3$. What is the volume?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\dfrac{20\pi}{3}$','explanation','Often from an algebra slip expanding $(3-x)^2$.'),
    jsonb_build_object('id','B','text','$\dfrac{10\pi}{3}$','explanation','Often from missing a factor of 2 when integrating $6x$.'),
    jsonb_build_object('id','C','text','$\dfrac{28\pi}{3}$','explanation','Correct: $V=\pi\int_0^2\left(9-(3-x)^2\right)\,dx=\dfrac{28\pi}{3}$.'),
    jsonb_build_object('id','D','text','$\dfrac{26\pi}{3}$','explanation','Often from integrating $x^2$ incorrectly or a final arithmetic slip.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'About $y=3$, outer radius to $y=0$ is $R=3$, inner radius to $y=x is $r=3-x$. $$V=\pi\int_0^2\left(R^2-r^2\right)dx=\pi\int_0^2\left(9-(3-x)^2\right)dx.$$ Since $9-(3-x)^2=6x-x^2$, $$V=\pi\int_0^2(6x-x^2)\,dx=\pi\left[3x^2-\frac{x^3}{3}\right]_0^2=\pi\left(12-\frac{8}{3}\right)=\frac{28\pi}{3}.$$',
  recommendation_reasons = ARRAY['Core shifted-axis washer setup with a linear inner radius.','Reinforces correct distance expressions to the axis $y=3$.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.10,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Shifted horizontal axis; emphasizes correct distance expressions.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
    primary_skill_id = 'SK_AXIS_SHIFT_WASHER',
  supporting_skill_ids = ARRAY['SK_INTEGRAL_EVAL'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_AppIntegration',
  updated_at = NOW()
WHERE title = '8.12-P5';


COMMIT;
