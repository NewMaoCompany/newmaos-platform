-- Unit 5 Part 4 Update Script (5.7 - 5.8)
-- Wrapped in a DO block to ensure atomic execution and prevent syntax errors at EOF.

DO $block$
BEGIN

-- Unit 5.7 (Using the Second Derivative Test to Find Extrema) — Practice 1–5

UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Analytical',
  sub_topic_id = '5.7',
  section_id = '5.7',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 105,
  skill_tags = ARRAY['SK_SECOND_DERIV_TEST','SK_ALGEBRA_FACTORING','SK_CRITICAL_POINTS'],
  primary_skill_id = 'SK_SECOND_DERIV_TEST',
  supporting_skill_ids = ARRAY['SK_ALGEBRA_FACTORING', 'SK_CRITICAL_POINTS'],
 'SK_CRITICAL_POINTS'],'SK_CRITICAL_POINTS'],
  error_tags = ARRAY['ERR_FORGET_FPRIME_ZERO','ERR_SIGN_CONFUSION','ERR_SECOND_DERIV_TEST_MISUSE'],
  prompt = 'Let $f$ be a twice-differentiable function with $$f''(x)=(x-1)(x+2)^2.$$ Using the second derivative test, classify the critical point at $x=1$.',
  latex = 'Let $f$ be a twice-differentiable function with $$f''(x)=(x-1)(x+2)^2.$$ Using the second derivative test, classify the critical point at $x=1$.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','Local maximum at $x=1$','explanation','At $x=1$, $f''''(1)>0$, so this is not a local maximum.'),
    jsonb_build_object('id','B','text','Local minimum at $x=1$','explanation','Compute $f''''(x)=\\frac{d}{dx}[(x-1)(x+2)^2]=(x+2)^2+2(x-1)(x+2)=3x(x+2)$. Then $f''''(1)=9>0$, so $f$ has a local minimum at $x=1$.'),
    jsonb_build_object('id','C','text','Neither; $x=1$ is not a critical point','explanation','$f''(1)=0$, so $x=1$ is a critical point.'),
    jsonb_build_object('id','D','text','Inconclusive by the second derivative test','explanation','Inconclusive occurs when $f''''(1)=0$ or does not exist; here $f''''(1)=9$.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Differentiate $f''(x)$ to get $f''''(x)=3x(x+2)$. Since $f''(1)=0$ and $f''''(1)=9>0$, the second derivative test gives a local minimum at $x=1$.',
  recommendation_reasons = ARRAY['Reinforces computing a second derivative from factored form and applying the second derivative test correctly.','Targets sign mistakes in $f''''(c)$ evaluation.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: compute $f''''(x)$ efficiently and evaluate at the critical point.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Analytical',
  updated_at = NOW()
WHERE title = '5.7-P1';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Analytical',
  sub_topic_id = '5.7',
  section_id = '5.7',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 85,
  skill_tags = ARRAY['SK_SECOND_DERIV_TEST','SK_CRITICAL_POINTS'],
  primary_skill_id = 'SK_SECOND_DERIV_TEST',
  supporting_skill_ids = ARRAY['SK_CRITICAL_POINTS'],

  error_tags = ARRAY['ERR_SECOND_DERIV_TEST_MISUSE','ERR_SIGN_CONFUSION'],
  prompt = 'A twice-differentiable function $f$ satisfies $f''(3)=0$ and $f''''(3)<0$. What can you conclude about $f$ at $x=3$?',
  latex = 'A twice-differentiable function $f$ satisfies $f''(3)=0$ and $f''''(3)<0$. What can you conclude about $f$ at $x=3$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$f$ has a local minimum at $x=3$','explanation','A local minimum would require $f''''(3)>0$ (with $f''(3)=0$).'),
    jsonb_build_object('id','B','text','$f$ has an inflection point at $x=3$','explanation','An inflection point requires concavity to change; $f''''(3)<0$ alone does not establish a change.'),
    jsonb_build_object('id','C','text','No conclusion can be made because $f''(3)=0$','explanation','With $f''''(3)\\ne 0$, the second derivative test is conclusive.'),
    jsonb_build_object('id','D','text','$f$ has a local maximum at $x=3$','explanation','Since $f''(3)=0$ and $f''''(3)<0$, the second derivative test gives a local maximum at $x=3$.')
  ),
  correct_option_id = 'D',
  tolerance = 0.0010,
  explanation = 'The second derivative test: if $f''(c)=0$ and $f''''(c)<0$, then $f$ has a local maximum at $x=c$. Here $c=3$.',
  recommendation_reasons = ARRAY['Quick identification of maxima/minima from derivative signs.','Targets the common mistake of calling any $f''''(c)<0$ an inflection point.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 0.90,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Pure concept check for the second derivative test.',
  weight_primary = 1.00,
  weight_supporting = 0.00,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Analytical',
  updated_at = NOW()
WHERE title = '5.7-P2';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Analytical',
  sub_topic_id = '5.7',
  section_id = '5.7',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 120,
  skill_tags = ARRAY['SK_SECOND_DERIV_TEST','SK_DIFFERENTIATION_RULES','SK_CRITICAL_POINTS'],
  primary_skill_id = 'SK_SECOND_DERIV_TEST',
  supporting_skill_ids = ARRAY['SK_DIFFERENTIATION_RULES', 'SK_CRITICAL_POINTS'],
 'SK_CRITICAL_POINTS'],'SK_CRITICAL_POINTS'],
  error_tags = ARRAY['ERR_ALGEBRA_SOLVE_ERROR','ERR_FORGET_FPRIME_ZERO','ERR_SECOND_DERIV_TEST_MISUSE'],
  prompt = 'Consider $f(x)=x^4-4x^2+2$. Which statement is true?',
  latex = 'Consider $f(x)=x^4-4x^2+2$. Which statement is true?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$f$ has local minima at $x=\\pm\\sqrt{2}$ and a local maximum at $x=0$','explanation','Compute $f''(x)=4x^3-8x=4x(x^2-2)$ so critical points are $0,\\pm\\sqrt{2}$. Then $f''''(x)=12x^2-8$. Since $f''''(0)=-8<0$ and $f''''(\\pm\\sqrt{2})=16>0$, the classification follows.'),
    jsonb_build_object('id','B','text','$f$ has local maxima at $x=\\pm\\sqrt{2}$ and a local minimum at $x=0$','explanation','The second derivative signs are reversed: $f''''(0)<0$ gives a maximum at $0$, not a minimum.'),
    jsonb_build_object('id','C','text','$f$ has only one critical point at $x=0$','explanation','$f''(x)=4x(x^2-2)$ has three real zeros.'),
    jsonb_build_object('id','D','text','The second derivative test is inconclusive at all critical points','explanation','Here $f''''(0)\\ne 0$ and $f''''(\\pm\\sqrt{2})\\ne 0$, so it is conclusive.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Find critical points from $f''(x)=0$ and classify using $f''''(x)$. The signs show a local maximum at $x=0$ and local minima at $x=\\pm\\sqrt{2}$.',
  recommendation_reasons = ARRAY['Canonical polynomial workflow: differentiate, solve, then apply the second derivative test.','Builds factoring discipline to avoid algebra slips.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Keep algebra clean: factor $f''(x)$ before solving.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Analytical',
  updated_at = NOW()
WHERE title = '5.7-P3';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Analytical',
  sub_topic_id = '5.7',
  section_id = '5.7',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 110,
  skill_tags = ARRAY['SK_SECOND_DERIV_TEST','SK_THEOREM_INTERPRETATION'],
  primary_skill_id = 'SK_SECOND_DERIV_TEST',
  supporting_skill_ids = ARRAY['SK_THEOREM_INTERPRETATION'],

  error_tags = ARRAY['ERR_SECOND_DERIV_TEST_MISUSE','ERR_OVERGENERALIZE_RESULT'],
  prompt = 'A function $f$ is twice differentiable and satisfies $f''(2)=0$ and $f''''(2)=0$. Which conclusion must be true?',
  latex = 'A function $f$ is twice differentiable and satisfies $f''(2)=0$ and $f''''(2)=0$. Which conclusion must be true?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$f$ has a local maximum at $x=2$','explanation','The second derivative test is not conclusive when $f''''(2)=0$.'),
    jsonb_build_object('id','B','text','$f$ has a local minimum at $x=2$','explanation','The second derivative test is not conclusive when $f''''(2)=0$.'),
    jsonb_build_object('id','C','text','No conclusion about a local extremum can be drawn from the second derivative test','explanation','When $f''(c)=0$ and $f''''(c)=0$, the second derivative test is inconclusive; $x=2$ could be a max, min, or neither.'),
    jsonb_build_object('id','D','text','$f$ must have an inflection point at $x=2$','explanation','An inflection point requires concavity to change; $f''''(2)=0$ does not guarantee that.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'The second derivative test requires $f''''(c)\\ne 0$. If $f''''(c)=0$, it is inconclusive: examples exist with a local max, local min, or neither at $c$.',
  recommendation_reasons = ARRAY['Targets a high-frequency trap: assuming $f''''(c)=0$ forces an inflection or no extremum.','Builds precise use of “inconclusive” conditions.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.10,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Emphasize “inconclusive” conditions precisely.',
  weight_primary = 1.00,
  weight_supporting = 0.00,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Analytical',
  updated_at = NOW()
WHERE title = '5.7-P4';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Analytical',
  sub_topic_id = '5.7',
  section_id = '5.7',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 5,
  target_time_seconds = 150,
  skill_tags = ARRAY['SK_SECOND_DERIV_TEST','SK_QUOTIENT_RULE','SK_ALGEBRA_SIMPLIFY','SK_CRITICAL_POINTS'],
  primary_skill_id = 'SK_SECOND_DERIV_TEST',
  supporting_skill_ids = ARRAY['SK_QUOTIENT_RULE', 'SK_ALGEBRA_SIMPLIFY', 'SK_CRITICAL_POINTS'],
 'SK_ALGEBRA_SIMPLIFY', 'SK_CRITICAL_POINTS'],'SK_ALGEBRA_SIMPLIFY','SK_CRITICAL_POINTS'],
  error_tags = ARRAY['ERR_ALGEBRA_SOLVE_ERROR','ERR_SECOND_DERIV_TEST_MISUSE','ERR_DOMAIN_IGNORED'],
  prompt = 'Let $f(x)=\\dfrac{x}{x^2+1}$. Use the second derivative test to classify the critical point at $x=1$.',
  latex = 'Let $f(x)=\\dfrac{x}{x^2+1}$. Use the second derivative test to classify the critical point at $x=1$.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','Local minimum at $x=1$','explanation','A local minimum would require $f''''(1)>0$, but $f''''(1)=-\\tfrac12$.'),
    jsonb_build_object('id','B','text','Local maximum at $x=1$','explanation','Compute $f''(x)=\\dfrac{1-x^2}{(x^2+1)^2}$ so $f''(1)=0$. Then $f''''(x)=\\dfrac{2x(x^2-3)}{(x^2+1)^3}$, and $f''''(1)=-\\tfrac12<0$, giving a local maximum at $x=1$.'),
    jsonb_build_object('id','C','text','Neither; $x=1$ is not a critical point','explanation','$f''(1)=0$, so $x=1$ is a critical point.'),
    jsonb_build_object('id','D','text','Inconclusive by the second derivative test','explanation','It is conclusive because $f''''(1)\\ne 0$.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Find $f''(x)=\\dfrac{1-x^2}{(x^2+1)^2}$ so $x=1$ is critical. Then $f''''(x)=\\dfrac{2x(x^2-3)}{(x^2+1)^3}$ gives $f''''(1)=-\\tfrac12<0$. Therefore $f$ has a local maximum at $x=1$.',
  recommendation_reasons = ARRAY['Harder algebra/derivative chain: quotient rule plus second derivative evaluation.','Punishes sign errors in $f''''(x)$ simplification.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 5,
  mastery_weight = 1.20,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Designed to punish sign/algebra slips in the second derivative computation.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Analytical',
  updated_at = NOW()
WHERE title = '5.7-P5';



-- Unit 5.8 (Sketching Graphs of Functions and Their Derivatives) — Practice 1–5

UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Analytical',
  sub_topic_id = '5.8',
  section_id = '5.8',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 90,
  skill_tags = ARRAY['SK_GRAPH_DERIVATIVE_RELATIONSHIP','SK_INCREASING_DECREASING'],
  primary_skill_id = 'SK_GRAPH_DERIVATIVE_RELATIONSHIP',
  supporting_skill_ids = ARRAY['SK_INCREASING_DECREASING'],

  error_tags = ARRAY['ERR_GRAPH_READING','ERR_SIGN_CONFUSION'],
  prompt = 'The image (5.8-P1.png) shows the graph of $f$. On which interval is $f''(x)>0$ for all $x$ in the interval?',
  latex = 'The image (5.8-P1.png) shows the graph of $f$. On which interval is $f''(x)>0$ for all $x$ in the interval?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$(-2,-1)$','explanation','On $(-2,-1)$ the graph is decreasing toward a local minimum near $x=-1$, so $f''(x)<0$ there.'),
    jsonb_build_object('id','B','text','$(0,1)$','explanation','This interval does not stay entirely in the increasing region shown; the graph behavior changes relative to the critical points.'),
    jsonb_build_object('id','C','text','$(2,3)$','explanation','This interval lies to the right of a local maximum near $x=2$, where the graph is decreasing, so $f''(x)$ is not positive throughout.'),
    jsonb_build_object('id','D','text','$(-1,2)$','explanation','From just right of $x=-1$ up to just left of $x=2$, the graph of $f$ is increasing, so $f''(x)>0$ throughout $(-1,2)$.')
  ),
  correct_option_id = 'D',
  tolerance = 0.0010,
  explanation = 'Where a function is increasing, its derivative is positive. The graph increases continuously from the local minimum near $x=-1$ to the local maximum near $x=2$, so $f''(x)>0$ on $(-1,2)$.',
  recommendation_reasons = ARRAY['Direct read of $f''\\gtrless0$ from a graph of $f$.','Targets interval thinking rather than point sampling.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 0.90,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Check monotonicity on the full interval, not just at sample points.',
  weight_primary = 1.00,
  weight_supporting = 0.00,
  prompt_type = 'text_and_image',
  representation_type = 'symbolic',
  topic_id = 'Both_Analytical',
  updated_at = NOW()
WHERE title = '5.8-P1';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Analytical',
  sub_topic_id = '5.8',
  section_id = '5.8',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 110,
  skill_tags = ARRAY['SK_GRAPH_DERIVATIVE_RELATIONSHIP','SK_LOCAL_EXTREMA_FROM_FPRIME'],
  primary_skill_id = 'SK_GRAPH_DERIVATIVE_RELATIONSHIP',
  supporting_skill_ids = ARRAY['SK_LOCAL_EXTREMA_FROM_FPRIME'],

  error_tags = ARRAY['ERR_SIGN_CHART','ERR_GRAPH_READING','ERR_CONFUSE_F_WITH_FPRIME'],
  prompt = 'The image (5.8-P2.png) shows the graph of $f''(x)$. At which $x$-value does $f$ have a local maximum?',
  latex = 'The image (5.8-P2.png) shows the graph of $f''(x)$. At which $x$-value does $f$ have a local maximum?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$x=1$','explanation','At $x=1$, $f''(x)$ changes from positive to negative, so $f$ has a local maximum at $x=1$.'),
    jsonb_build_object('id','B','text','$x=-1$','explanation','At $x=-1$, $f''(x)$ changes from negative to positive, which indicates a local minimum, not a maximum.'),
    jsonb_build_object('id','C','text','$x=3$','explanation','At $x=3$, $f''(x)$ changes from negative to positive, indicating a local minimum.'),
    jsonb_build_object('id','D','text','$x=0$','explanation','A local extremum requires $f''(x)=0$ with a sign change; the graph does not show $f''(0)=0$.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'A local maximum occurs where $f''(x)$ changes from $+$ to $-$. From the graph, this happens at $x=1$.',
  recommendation_reasons = ARRAY['Connects sign change of the derivative to local extrema of the original function.','Targets confusion between zeros and sign changes.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Use sign change, not just “where $f''(x)=0$.”',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text_and_image',
  representation_type = 'symbolic',
  topic_id = 'Both_Analytical',
  updated_at = NOW()
WHERE title = '5.8-P2';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Analytical',
  sub_topic_id = '5.8',
  section_id = '5.8',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 105,
  skill_tags = ARRAY['SK_CONCAVITY_FROM_FDOUBLEPRIME','SK_GRAPH_DERIVATIVE_RELATIONSHIP'],
  primary_skill_id = 'SK_CONCAVITY_FROM_FDOUBLEPRIME',
  supporting_skill_ids = ARRAY['SK_GRAPH_DERIVATIVE_RELATIONSHIP'],

  error_tags = ARRAY['ERR_SIGN_CONFUSION','ERR_GRAPH_READING','ERR_CONCAVITY_CONFUSION'],
  prompt = 'The image (5.8-P3.png) shows the graph of $f''''(x)$. On which interval is $f$ concave down?',
  latex = 'The image (5.8-P3.png) shows the graph of $f''''(x)$. On which interval is $f$ concave down?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$(-\\infty,0)$','explanation','For $x<0$, the graph of $f''''$ is above the $x$-axis, so $f''''(x)>0$ and $f$ is concave up there.'),
    jsonb_build_object('id','B','text','$(2,\\infty)$','explanation','For $x>2$, $f''''(x)>0$, so $f$ is concave up.'),
    jsonb_build_object('id','C','text','$(0,2)$','explanation','On $(0,2)$, the graph of $f''''(x)$ is below the $x$-axis, so $f''''(x)<0$ and $f$ is concave down.'),
    jsonb_build_object('id','D','text','All real numbers','explanation','Concavity changes where $f''''$ crosses the axis; here it crosses at $x=0$ and $x=2$.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'A function is concave down where $f''''(x)<0$. From the graph of $f''''$, it is negative on $(0,2)$.',
  recommendation_reasons = ARRAY['Solidifies concavity from a $f''''$ graph.','Targets the common up-vs-down sign confusion.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Concave down corresponds to $f''''<0$ (graph below the axis).',
  weight_primary = 1.00,
  weight_supporting = 0.00,
  prompt_type = 'text_and_image',
  representation_type = 'symbolic',
  topic_id = 'Both_Analytical',
  updated_at = NOW()
WHERE title = '5.8-P3';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Analytical',
  sub_topic_id = '5.8',
  section_id = '5.8',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 135,
  skill_tags = ARRAY['SK_GRAPH_DERIVATIVE_RELATIONSHIP','SK_MATCH_F_TO_FPRIME','SK_CRITICAL_POINTS'],
  primary_skill_id = 'SK_GRAPH_DERIVATIVE_RELATIONSHIP',
  supporting_skill_ids = ARRAY['SK_MATCH_F_TO_FPRIME', 'SK_CRITICAL_POINTS'],
 'SK_CRITICAL_POINTS'],'SK_CRITICAL_POINTS'],
  error_tags = ARRAY['ERR_DERIVATIVE_SHAPE_MISMATCH','ERR_GRAPH_READING','ERR_CONFUSE_F_WITH_FPRIME'],
  prompt = 'Suppose $f(x)=x^3-3x^2+1$. The image (5.8-P4.png) shows four candidate graphs (A–D). Which candidate graph could represent $f''(x)$?',
  latex = 'Suppose $f(x)=x^3-3x^2+1$. The image (5.8-P4.png) shows four candidate graphs (A–D). Which candidate graph could represent $f''(x)$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','A','explanation','Compute $f''(x)=3x^2-6x=3x(x-2)$, an upward-opening parabola with zeros at $x=0$ and $x=2$. Option A matches this.'),
    jsonb_build_object('id','B','text','B','explanation','B has zeros shifted; it does not have roots at $0$ and $2$.'),
    jsonb_build_object('id','C','text','C','explanation','C opens downward, but $f''(x)=3x^2-6x$ opens upward.'),
    jsonb_build_object('id','D','text','D','explanation','D is linear; $f''(x)$ is quadratic.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Differentiate: $f''(x)=3x^2-6x=3x(x-2)$. So $f''(x)$ is an upward-opening parabola crossing the $x$-axis at $0$ and $2$, which corresponds to option A.',
  recommendation_reasons = ARRAY['Combines symbolic differentiation with graphical features (degree, roots, opening).','Targets shape-mismatch errors when matching derivatives to graphs.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.10,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Key cues: derivative degree drops by 1; zeros of $f''''$ align with extrema of $f$.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text_and_image',
  representation_type = 'symbolic',
  topic_id = 'Both_Analytical',
  updated_at = NOW()
WHERE title = '5.8-P4';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Analytical',
  sub_topic_id = '5.8',
  section_id = '5.8',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 120,
  skill_tags = ARRAY['SK_SLOPE_FROM_TANGENT_GRAPH','SK_GRAPH_READING','SK_DERIVATIVE_AS_SLOPE'],
  primary_skill_id = 'SK_SLOPE_FROM_TANGENT_GRAPH',
  supporting_skill_ids = ARRAY['SK_GRAPH_READING', 'SK_DERIVATIVE_AS_SLOPE'],
 'SK_DERIVATIVE_AS_SLOPE'],'SK_DERIVATIVE_AS_SLOPE'],
  error_tags = ARRAY['ERR_GRAPH_READING','ERR_SLOPE_CONFUSION','ERR_APPROXIMATION_SLIP'],
  prompt = 'The image (5.8-P5.png) shows the graph of $f$ and the tangent line at $x=2$. Which value is closest to $f''(2)$?',
  latex = 'The image (5.8-P5.png) shows the graph of $f$ and the tangent line at $x=2$. Which value is closest to $f''(2)$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$-0.29$','explanation','The tangent line rises as $x$ increases, so the slope is positive, not negative.'),
    jsonb_build_object('id','B','text','$0.58$','explanation','This is about double the observed slope; the tangent line is much flatter than that.'),
    jsonb_build_object('id','C','text','$0.29$','explanation','From the tangent line, a run of about $2$ corresponds to a rise a bit over $0.5$, giving slope near $0.25$–$0.30$. So $0.29$ is closest.'),
    jsonb_build_object('id','D','text','$1.73$','explanation','A slope near $1.7$ would look very steep; the tangent line is shallow.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'The derivative at a point equals the slope of the tangent line there. Reading two convenient points on the tangent line from the graph gives a slope near $0.29$.',
  recommendation_reasons = ARRAY['Builds comfort estimating derivative values from tangent lines on a graph.','Targets confusion between tangent slope and other nearby slopes.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Estimate slope using two readable points on the tangent line; avoid confusing with a secant slope.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text_and_image',
  representation_type = 'symbolic',
  topic_id = 'Both_Analytical',
  updated_at = NOW()
WHERE title = '5.8-P5';

END $block$;
