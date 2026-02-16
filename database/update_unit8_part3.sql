-- Unit 8.7 (Volumes with Cross-Sections - Squares and Rectangles) — Practice 1–5

BEGIN;

UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_AppIntegration',
  sub_topic_id = '8.7',
  section_id = '8.7',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 90,
  skill_tags = ARRAY['SK_VOL_CROSS_SECTIONS', 'SK_CS_SQ_RECT_AREA'],
  error_tags = ARRAY['E_FORGET_SQUARE_SIDE', 'E_WRONG_BOUNDS'],
  prompt = 'Let $R$ be the region bounded by $y=x$ and $y=x^2$ for $0\le x\le 1$. Cross-sections perpendicular to the $x$-axis are squares whose bases lie in $R$. What is the volume of the solid?',
  latex = 'Let $R$ be the region bounded by $y=x$ and $y=x^2$ for $0\le x\le 1$. Cross-sections perpendicular to the $x$-axis are squares whose bases lie in $R$. What is the volume of the solid?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\dfrac{1}{30}$','explanation','Correct: side length is $x-x^2$, so $A(x)=(x-x^2)^2$ and $\int_0^1 (x-x^2)^2\,dx=\frac{1}{30}$.'),
    jsonb_build_object('id','B','text','$\dfrac{1}{6}$','explanation','This can result from forgetting to square the side length and integrating $x-x^2$.'),
    jsonb_build_object('id','C','text','$\dfrac{1}{15}$','explanation','This often comes from a coefficient mistake when expanding $(x-x^2)^2$.'),
    jsonb_build_object('id','D','text','$\dfrac{1}{20}$','explanation','This typically comes from integrating $x^2-x^3$ instead of $x^2-2x^3+x^4$.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'For squares, $A(x)=s(x)^2$ where $s(x)$ is (top − bottom) $=x-x^2$. Thus
$$V=\int_0^1 (x-x^2)^2\,dx=\int_0^1 (x^2-2x^3+x^4)\,dx=\left[\frac{x^3}{3}-\frac{x^4}{2}+\frac{x^5}{5}\right]_0^1=\frac{1}{30}.$$',
  micro_explanations = jsonb_build_array(
    'Square cross-section: $A=s^2$.',
    'Top minus bottom: $x-x^2$ on $[0,1]$.',
    'Integrate $x^2-2x^3+x^4$.'
  ),
  recommendation_reasons = ARRAY['Reinforces top-minus-bottom for cross-sections', 'Checks correct squaring before integrating'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Square cross-sections; base as vertical distance in the region.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
    primary_skill_id = 'SK_VOL_CROSS_SECTIONS',
  supporting_skill_ids = ARRAY['SK_CS_SQ_RECT_AREA'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_AppIntegration',
  updated_at = NOW()
WHERE title = '8.7-P1';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_AppIntegration',
  sub_topic_id = '8.7',
  section_id = '8.7',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 140,
  skill_tags = ARRAY['SK_INTEGRATION_BY_PARTS', 'SK_VOL_CROSS_SECTIONS'],
  error_tags = ARRAY['E_IBP_ERROR', 'E_TOP_MINUS_BOTTOM_REVERSED'],
  prompt = 'The region $R$ is bounded by $y=\cos x$ and $y=\sin x$ on $0\le x\le \frac{\pi}{4}$. Cross-sections perpendicular to the $x$-axis are rectangles whose height is $2x$ and whose base lies in $R$. What is the volume?',
  latex = 'The region $R$ is bounded by $y=\cos x$ and $y=\sin x$ on $0\le x\le \frac{\pi}{4}$. Cross-sections perpendicular to the $x$-axis are rectangles whose height is $2x$ and whose base lies in $R$. What is the volume?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$2-\dfrac{\pi\sqrt2}{2}$','explanation','This is the negative of the correct value; it can come from reversing top-minus-bottom or subtracting in the wrong order.'),
    jsonb_build_object('id','B','text','$\dfrac{\pi\sqrt2}{2}-2$','explanation','Correct: $V=\int_0^{\pi/4} 2x(\cos x-\sin x)\,dx=\frac{\pi\sqrt2}{2}-2$.'),
    jsonb_build_object('id','C','text','$\dfrac{\pi\sqrt2}{4}-1$','explanation','This often comes from forgetting the factor of $2$ in the height $2x$.'),
    jsonb_build_object('id','D','text','$\dfrac{\pi\sqrt2}{2}-1$','explanation','This typically comes from evaluating the antiderivative at $0$ incorrectly.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Base $=\cos x-\sin x$ and height $=2x$, so $A(x)=2x(\cos x-\sin x)$. Then
$$V=\int_0^{\pi/4}2x(\cos x-\sin x)\,dx=2\left[ x(\sin x+\cos x)+(\cos x-\sin x)\right]_0^{\pi/4}.$$
At $x=\pi/4$, $\sin x=\cos x=\frac{\sqrt2}{2}$ so the bracket is $\frac{\pi}{4}\cdot\sqrt2+0$. At $x=0$, the bracket is $1$. Thus
$$V=2\left(\frac{\pi\sqrt2}{4}-1\right)=\frac{\pi\sqrt2}{2}-2.$$',
  micro_explanations = jsonb_build_array(
    'Rectangle area: base·height.',
    'Base is vertical distance: $\cos x-\sin x$.',
    'Use integration by parts for $x\cos x$ and $x\sin x$.'
  ),
  recommendation_reasons = ARRAY['Combines cross-section setup with integration by parts', 'Targets common sign and factor mistakes'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.20,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Height depends on $x$; base is difference of trig functions.',
  weight_primary = 0.60,
  weight_supporting = 0.40,
    primary_skill_id = 'SK_INTEGRATION_BY_PARTS',
  supporting_skill_ids = ARRAY['SK_VOL_CROSS_SECTIONS'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_AppIntegration',
  updated_at = NOW()
WHERE title = '8.7-P2';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_AppIntegration',
  sub_topic_id = '8.7',
  section_id = '8.7',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 110,
  skill_tags = ARRAY['SK_VOL_CROSS_SECTIONS', 'SK_FIND_BOUNDS_INTERSECTION'],
  error_tags = ARRAY['E_WRONG_BOUNDS', 'E_FORGET_SQUARE_SIDE'],
  prompt = 'Let $R$ be the region bounded by $x=y^2$ and $x=2y$. Cross-sections perpendicular to the $y$-axis are squares. What is the volume of the solid?',
  latex = 'Let $R$ be the region bounded by $x=y^2$ and $x=2y$. Cross-sections perpendicular to the $y$-axis are squares. What is the volume of the solid?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\dfrac{16}{15}$','explanation','Correct: $V=\int_0^2 (2y-y^2)^2\,dy=\frac{16}{15}$.'),
    jsonb_build_object('id','B','text','$\dfrac{8}{15}$','explanation','This commonly results from expansion errors in $(2y-y^2)^2$.'),
    jsonb_build_object('id','C','text','$\dfrac{32}{15}$','explanation','This often comes from doubling the integral unnecessarily.'),
    jsonb_build_object('id','D','text','$\dfrac{16}{5}$','explanation','This can happen if the side length is taken as $2y$ before squaring.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Perpendicular to the $y$-axis means integrate with respect to $y$. The square side is
$$s(y)=x_{right}-x_{left}=2y-y^2,$$
with intersections from $y^2=2y\Rightarrow y=0,2$. Then
$$V=\int_0^2 (2y-y^2)^2\,dy=\int_0^2 (4y^2-4y^3+y^4)\,dy=\left[\frac{4y^3}{3}-y^4+\frac{y^5}{5}\right]_0^2=\frac{16}{15}.$$',
  micro_explanations = jsonb_build_array(
    'Use $y$-integration since slices are ⟂ $y$-axis.',
    'Side length is horizontal distance: right − left.',
    'Bounds from $y^2=2y$: $[0,2]$.'
  ),
  recommendation_reasons = ARRAY['Practices choosing variable to match slicing direction', 'Reinforces intersection-based bounds'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.10,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Squares with $y$-slices; horizontal distance between curves.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
    primary_skill_id = 'SK_VOL_CROSS_SECTIONS',
  supporting_skill_ids = ARRAY['SK_FIND_BOUNDS_INTERSECTION'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_AppIntegration',
  updated_at = NOW()
WHERE title = '8.7-P3';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_AppIntegration',
  sub_topic_id = '8.7',
  section_id = '8.7',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 1,
  target_time_seconds = 70,
  skill_tags = ARRAY['SK_VOLUME_INTEGRAL', 'SK_VOL_CROSS_SECTIONS'],
  error_tags = ARRAY['E_FORGET_CONSTANT_FACTOR', 'E_WRONG_BOUNDS'],
  prompt = 'The base of a solid is the region under $y=4-x^2$ and above the $x$-axis. Cross-sections perpendicular to the $x$-axis are rectangles with constant height $3$. What is the volume?',
  latex = 'The base of a solid is the region under $y=4-x^2$ and above the $x$-axis. Cross-sections perpendicular to the $x$-axis are rectangles with constant height $3$. What is the volume?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\dfrac{32}{3}$','explanation','This can occur if the factor $3$ (height) is omitted.'),
    jsonb_build_object('id','B','text','$32$','explanation','Correct: $V=\int_{-2}^{2}3(4-x^2)\,dx=32$.'),
    jsonb_build_object('id','C','text','$64$','explanation','This can happen if the integral is doubled after already using symmetric bounds.'),
    jsonb_build_object('id','D','text','$16$','explanation','This often comes from using bounds $[0,2]$ without doubling.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Since cross-sections are rectangles, $A(x)=\text{height}\cdot\text{base}=3(4-x^2)$. The region meets the $x$-axis at $4-x^2=0\Rightarrow x=\pm2$. Thus
$$V=\int_{-2}^{2}3(4-x^2)\,dx=3\left[4x-\frac{x^3}{3}\right]_{-2}^{2}=32.$$',
  micro_explanations = jsonb_build_array(
    'Bounds from $4-x^2=0$: $x=\pm2$.',
    'Rectangle area uses constant height $3$.',
    'Evaluate on $[-2,2]$ without extra doubling.'
  ),
  recommendation_reasons = ARRAY['Fast check on bounds and constant factors', 'Builds confidence before more complex cross-sections'],
  status = 'published',
  version = version + 1,
  reasoning_level = 1,
  mastery_weight = 0.90,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Rectangles with constant height; base is the function value.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
    primary_skill_id = 'SK_VOLUME_INTEGRAL',
  supporting_skill_ids = ARRAY['SK_VOL_CROSS_SECTIONS'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_AppIntegration',
  updated_at = NOW()
WHERE title = '8.7-P4';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_AppIntegration',
  sub_topic_id = '8.7',
  section_id = '8.7',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 120,
  skill_tags = ARRAY['SK_VOL_CROSS_SECTIONS', 'SK_ALGEBRA_SIMPLIFY'],
  error_tags = ARRAY['E_FORGET_CONSTANT_FACTOR', 'E_FORGET_SQUARE_SIDE'],
  prompt = 'The base of a solid is the region between $y=e^{-x}$ and the $x$-axis on $0\le x\le 1$. Cross-sections perpendicular to the $x$-axis are rectangles whose height is $k$ times the base in the region. If the volume is $3(1-e^{-2})$, what is $k$?',
  latex = 'The base of a solid is the region between $y=e^{-x}$ and the $x$-axis on $0\le x\le 1$. Cross-sections perpendicular to the $x$-axis are rectangles whose height is $k$ times the base in the region. If the volume is $3(1-e^{-2})$, what is $k$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$3$','explanation','This happens if $\int_0^1 e^{-2x}dx$ is incorrectly taken as $(1-e^{-2})$ instead of $\frac{1}{2}(1-e^{-2})$.'),
    jsonb_build_object('id','B','text','$6$','explanation','Correct: $\frac{k}{2}(1-e^{-2})=3(1-e^{-2})\Rightarrow k=6$.'),
    jsonb_build_object('id','C','text','$\dfrac{3}{2}$','explanation','This can occur if the area is set up as $k e^{-x}$ instead of $k(e^{-x})^2$.'),
    jsonb_build_object('id','D','text','$12$','explanation','This often comes from multiplying by $2$ instead of dividing by $2$ after integrating $e^{-2x}$.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Base length is $e^{-x}-0=e^{-x}$. Rectangle height is $k$ times the base, so height $=k e^{-x}$. Area is
$$A(x)=(e^{-x})(k e^{-x})=k e^{-2x}.$$
Thus
$$V=\int_0^1 k e^{-2x}\,dx=\frac{k}{2}(1-e^{-2}).$$
Set equal to $3(1-e^{-2})$ to get $\frac{k}{2}=3\Rightarrow k=6$.',
  micro_explanations = jsonb_build_array(
    'Height proportional to base ⇒ area proportional to base$^2$.',
    'Integrate $e^{-2x}$ carefully: factor $\frac12$.',
    'Match coefficients of $(1-e^{-2})$.'
  ),
  recommendation_reasons = ARRAY['Targets proportional-height rectangle setups', 'Checks exponential integration constant handling'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Rectangle height proportional to base implies area proportional to base squared.',
  weight_primary = 0.60,
  weight_supporting = 0.40,
    primary_skill_id = 'SK_VOL_CROSS_SECTIONS',
  supporting_skill_ids = ARRAY['SK_ALGEBRA_SIMPLIFY'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_AppIntegration',
  updated_at = NOW()
WHERE title = '8.7-P5';



-- Unit 8.8 (Volumes with Cross-Sections - Triangles and Semicircles) — Practice 1–5

UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_AppIntegration',
  sub_topic_id = '8.8',
  section_id = '8.8',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 95,
  skill_tags = ARRAY['SK_CS_TRI_SEMI_AREA', 'SK_VOL_CROSS_SECTIONS'],
  error_tags = ARRAY['E_DIAMETER_AS_RADIUS', 'E_FORGET_CONSTANT_FACTOR'],
  prompt = 'The base of a solid is the region between $y=\sqrt{x}$ and $y=0$ for $0\le x\le 4$. Cross-sections perpendicular to the $x$-axis are semicircles with diameter in the base. What is the volume?',
  latex = 'The base of a solid is the region between $y=\sqrt{x}$ and $y=0$ for $0\le x\le 4$. Cross-sections perpendicular to the $x$-axis are semicircles with diameter in the base. What is the volume?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\dfrac{\pi}{2}$','explanation','This can occur from mishandling constants after integrating.'),
    jsonb_build_object('id','B','text','$2\pi$','explanation','This often comes from using the full circle area instead of semicircle area.'),
    jsonb_build_object('id','C','text','$\pi$','explanation','Correct: $V=\int_0^4 \frac{\pi}{8}x\,dx=\pi$.'),
    jsonb_build_object('id','D','text','$\dfrac{\pi}{4}$','explanation','This can happen if diameter is mistakenly used as radius without converting.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'The diameter is the vertical distance: $d(x)=\sqrt{x}-0=\sqrt{x}$. For a semicircle with diameter $d$, radius $r=\frac{d}{2}$, so
$$A(x)=\frac{1}{2}\pi r^2=\frac{1}{2}\pi\left(\frac{d}{2}\right)^2=\frac{\pi}{8}d^2=\frac{\pi}{8}x.$$
Thus
$$V=\int_0^4 \frac{\pi}{8}x\,dx=\frac{\pi}{8}\left[\frac{x^2}{2}\right]_0^4=\pi.$$',
  micro_explanations = jsonb_build_array(
    'Convert diameter to radius: $r=d/2$.',
    'Semicircle area becomes $\frac{\pi}{8}d^2$.',
    'Here $d^2=x$, so integrate a polynomial.'
  ),
  recommendation_reasons = ARRAY['High-frequency semicircle diameter-to-area conversion', 'Reinforces constant factors $\pi/8$'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Semicircle area in terms of diameter: $A=\frac{\pi}{8}d^2$.',
  weight_primary = 0.60,
  weight_supporting = 0.40,
    primary_skill_id = 'SK_CS_TRI_SEMI_AREA',
  supporting_skill_ids = ARRAY['SK_VOL_CROSS_SECTIONS'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_AppIntegration',
  updated_at = NOW()
WHERE title = '8.8-P1';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_AppIntegration',
  sub_topic_id = '8.8',
  section_id = '8.8',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 100,
  skill_tags = ARRAY['SK_CS_TRI_SEMI_AREA', 'SK_VOLUME_INTEGRAL'],
  error_tags = ARRAY['E_FORGET_CONSTANT_FACTOR', 'E_FORGET_SQUARE_SIDE'],
  prompt = 'The base of a solid is the region between $y=x$ and $y=0$ for $0\le x\le 3$. Cross-sections perpendicular to the $x$-axis are equilateral triangles whose bases lie in the region. What is the volume?',
  latex = 'The base of a solid is the region between $y=x$ and $y=0$ for $0\le x\le 3$. Cross-sections perpendicular to the $x$-axis are equilateral triangles whose bases lie in the region. What is the volume?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\dfrac{9\sqrt3}{4}$','explanation','Correct: $V=\int_0^3 \frac{\sqrt3}{4}x^2\,dx=\frac{9\sqrt3}{4}$.'),
    jsonb_build_object('id','B','text','$\dfrac{27\sqrt3}{4}$','explanation','This can occur if $\int_0^3 x^2\,dx$ is incorrectly computed as $27$ instead of $9$.'),
    jsonb_build_object('id','C','text','$\dfrac{9}{4}$','explanation','This results from dropping the factor $\sqrt3$ in the equilateral triangle area formula.'),
    jsonb_build_object('id','D','text','$\dfrac{3\sqrt3}{4}$','explanation','This often comes from integrating $x$ instead of $x^2$.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'The triangle base is the vertical distance $b(x)=x-0=x$. For equilateral triangles,
$$A(x)=\frac{\sqrt3}{4}b(x)^2=\frac{\sqrt3}{4}x^2.$$
So
$$V=\int_0^3 \frac{\sqrt3}{4}x^2\,dx=\frac{\sqrt3}{4}\left[\frac{x^3}{3}\right]_0^3=\frac{9\sqrt3}{4}.$$',
  micro_explanations = jsonb_build_array(
    'Equilateral triangle area: $\frac{\sqrt3}{4}b^2$.',
    'Here $b=x$ from $y=x$ down to $y=0$.',
    'Integrate $x^2$ on $[0,3]$.'
  ),
  recommendation_reasons = ARRAY['Reinforces triangle area formulas in volume contexts', 'Clean polynomial integral to reduce cognitive load'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Equilateral triangle cross-sections; base is vertical distance.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
    primary_skill_id = 'SK_CS_TRI_SEMI_AREA',
  supporting_skill_ids = ARRAY['SK_VOLUME_INTEGRAL'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_AppIntegration',
  updated_at = NOW()
WHERE title = '8.8-P2';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_AppIntegration',
  sub_topic_id = '8.8',
  section_id = '8.8',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 5,
  target_time_seconds = 160,
  skill_tags = ARRAY['SK_INTEGRATE_LOG', 'SK_CS_TRI_SEMI_AREA'],
  error_tags = ARRAY['E_WRONG_CS_AREA_FORMULA', 'E_IBP_ERROR'],
  prompt = 'The base of a solid is the region between $y=\ln x$ and $y=0$ for $1\le x\le e$. Cross-sections perpendicular to the $x$-axis are right isosceles triangles whose legs lie in the base. What is the volume?',
  latex = 'The base of a solid is the region between $y=\ln x$ and $y=0$ for $1\le x\le e$. Cross-sections perpendicular to the $x$-axis are right isosceles triangles whose legs lie in the base. What is the volume?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\dfrac{e-2}{2}$','explanation','Correct: $\int (\ln x)^2 dx=x((\ln x)^2-2\ln x+2)$, so $V=\frac12(e-2)$.'),
    jsonb_build_object('id','B','text','$\dfrac{e-1}{2}$','explanation','This can occur from evaluating the antiderivative at $x=1$ as $1$ instead of $2$.'),
    jsonb_build_object('id','C','text','$e-2$','explanation','This often comes from forgetting the factor $\frac12$ in the right-triangle area.'),
    jsonb_build_object('id','D','text','$\dfrac{e}{2}$','explanation','This can occur if the lower bound contribution is incorrectly treated as $0$.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'The leg length is the vertical distance $b(x)=\ln x-0=\ln x$. A right isosceles triangle with legs $b$ has area
$$A(x)=\frac12 b^2=\frac12(\ln x)^2.$$
So
$$V=\int_1^e \frac12(\ln x)^2\,dx=\frac12\left[x\big((\ln x)^2-2\ln x+2\big)\right]_1^e.$$
At $x=e$, this is $e(1-2+2)=e$. At $x=1$, this is $2$. Therefore
$$V=\frac12(e-2).$$',
  micro_explanations = jsonb_build_array(
    'Right triangle area: $\frac12(\text{leg})(\text{leg})$.',
    'Here the leg is $\ln x$ from the base region.',
    'Use $\int (\ln x)^2 dx = x((\ln x)^2-2\ln x+2)$.'
  ),
  recommendation_reasons = ARRAY['BC-level integral with logarithms', 'Common trap: missing the $\frac12$ in triangle area'],
  status = 'published',
  version = version + 1,
  reasoning_level = 5,
  mastery_weight = 1.30,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Log integral; right isosceles triangle legs in base.',
  weight_primary = 0.60,
  weight_supporting = 0.40,
    primary_skill_id = 'SK_INTEGRATE_LOG',
  supporting_skill_ids = ARRAY['SK_CS_TRI_SEMI_AREA'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_AppIntegration',
  updated_at = NOW()
WHERE title = '8.8-P3';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_AppIntegration',
  sub_topic_id = '8.8',
  section_id = '8.8',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 125,
  skill_tags = ARRAY['SK_VOL_CROSS_SECTIONS', 'SK_CS_TRI_SEMI_AREA'],
  error_tags = ARRAY['E_WRONG_BOUNDS', 'E_DIAMETER_AS_RADIUS'],
  prompt = 'Let $R$ be the region bounded by $x=y^2$ and $x=y$ for $0\le y\le 1$. Cross-sections perpendicular to the $y$-axis are semicircles whose diameters lie in $R$. What is the volume?',
  latex = 'Let $R$ be the region bounded by $x=y^2$ and $x=y$ for $0\le y\le 1$. Cross-sections perpendicular to the $y$-axis are semicircles whose diameters lie in $R$. What is the volume?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\dfrac{\pi}{120}$','explanation','This often results from a constant-factor mistake in the final simplification.'),
    jsonb_build_object('id','B','text','$\dfrac{\pi}{240}$','explanation','Correct: $V=\frac{\pi}{8}\int_0^1 (y-y^2)^2 dy=\frac{\pi}{240}$.'),
    jsonb_build_object('id','C','text','$\dfrac{\pi}{60}$','explanation','This can occur if semicircle area is treated as full circle area or radius conversion is skipped.'),
    jsonb_build_object('id','D','text','$\dfrac{\pi}{480}$','explanation','This can occur if the semicircle factor is mistakenly applied twice.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Perpendicular to the $y$-axis implies $y$-integration. The diameter is horizontal distance:
$$d(y)=x_{right}-x_{left}=y-y^2.$$
Semicircle area in terms of diameter is
$$A(y)=\frac{\pi}{8}d(y)^2=\frac{\pi}{8}(y-y^2)^2.$$
So
$$V=\int_0^1 \frac{\pi}{8}(y-y^2)^2\,dy=\frac{\pi}{8}\int_0^1 (y^2-2y^3+y^4)\,dy=\frac{\pi}{8}\left(\frac13-\frac12+\frac15\right)=\frac{\pi}{240}.$$',
  micro_explanations = jsonb_build_array(
    'Use $y$ since slices are ⟂ $y$-axis.',
    'Diameter is right − left: $y-y^2$.',
    'Semicircle area: $\frac{\pi}{8}d^2$.'
  ),
  recommendation_reasons = ARRAY['Checks direction-switching (use $y$ not $x$)', 'Targets semicircle diameter-to-area factor'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.10,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Semicircles with $y$-slices; diameter is horizontal distance between curves.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
    primary_skill_id = 'SK_VOL_CROSS_SECTIONS',
  supporting_skill_ids = ARRAY['SK_CS_TRI_SEMI_AREA'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_AppIntegration',
  updated_at = NOW()
WHERE title = '8.8-P4';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_AppIntegration',
  sub_topic_id = '8.8',
  section_id = '8.8',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 135,
  skill_tags = ARRAY['SK_CS_TRI_SEMI_AREA', 'SK_VOLUME_INTEGRAL'],
  error_tags = ARRAY['E_WRONG_CS_AREA_FORMULA', 'E_WRONG_BOUNDS'],
  prompt = 'The base of a solid is the region between $y=2-x$ and $y=0$ for $0\le x\le 2$. Cross-sections perpendicular to the $x$-axis are isosceles right triangles whose hypotenuses lie in the base. What is the volume?',
  latex = 'The base of a solid is the region between $y=2-x$ and $y=0$ for $0\le x\le 2$. Cross-sections perpendicular to the $x$-axis are isosceles right triangles whose hypotenuses lie in the base. What is the volume?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\dfrac{4}{3}$','explanation','This can occur if the area is incorrectly taken as $\frac12 h^2$ instead of $\frac14 h^2$.'),
    jsonb_build_object('id','B','text','$\dfrac{2}{3}$','explanation','Correct: $V=\int_0^2 \frac{(2-x)^2}{4}\,dx=\frac{2}{3}$.'),
    jsonb_build_object('id','C','text','$\dfrac{1}{3}$','explanation','This often comes from using $A=\frac{h^2}{8}$ (dividing by $2$ again).'),
    jsonb_build_object('id','D','text','$1$','explanation','This can occur from integrating $(2-x)^2$ but forgetting the factor $\frac14$.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'The hypotenuse length is the vertical distance $h(x)=(2-x)-0=2-x$. For an isosceles right triangle with hypotenuse $h$, each leg is $\frac{h}{\sqrt2}$, so
$$A(x)=\frac12\left(\frac{h}{\sqrt2}\right)^2=\frac{h^2}{4}.$$
Thus
$$V=\int_0^2 \frac{(2-x)^2}{4}\,dx=\frac14\int_0^2 (4-4x+x^2)\,dx=\frac14\left[4x-2x^2+\frac{x^3}{3}\right]_0^2=\frac{2}{3}.$$',
  micro_explanations = jsonb_build_array(
    'Given hypotenuse $h$, each leg is $h/\sqrt2$.',
    'Area becomes $A=\frac12(h/\sqrt2)^2=\frac{h^2}{4}$.',
    'Integrate $\frac{(2-x)^2}{4}$ over $[0,2]$.'
  ),
  recommendation_reasons = ARRAY['High-yield geometry-to-area conversion', 'Common trap: confusing leg vs hypotenuse'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.20,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Isosceles right triangles given hypotenuse; area factor $1/4$ is key.',
  weight_primary = 0.60,
  weight_supporting = 0.40,
    primary_skill_id = 'SK_CS_TRI_SEMI_AREA',
  supporting_skill_ids = ARRAY['SK_VOLUME_INTEGRAL'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_AppIntegration',
  updated_at = NOW()
WHERE title = '8.8-P5';

COMMIT;
