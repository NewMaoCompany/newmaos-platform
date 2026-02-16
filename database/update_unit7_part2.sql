-- Unit 7.5 ((BC ONLY) Approximating Solutions Using Euler’s Method) — Practice 1–5

BEGIN;

UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_DiffEq',
  sub_topic_id = '7.5',
  section_id = '7.5',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 90,
  skill_tags = ARRAY['SK_EULER_METHOD', 'SK_TABLE_ITERATION', 'SK_SLOPE_EVAL'],
  error_tags = ARRAY['E_STEP_SIZE', 'E_SIGN_ARITH', 'E_IC_MISAPPLIED'],
  prompt = 'Use Euler’s method with step size $h=0.5$ to approximate $y(1)$ for the IVP $$\frac{dy}{dx}=x+y,\quad y(0)=1.$$',
  latex = 'Use Euler’s method with step size $h=0.5$ to approximate $y(1)$ for the IVP $$\frac{dy}{dx}=x+y,\quad y(0)=1.$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$2.75$','explanation','This often comes from taking an extra step past $x=1$ or mixing the number of steps needed.'),
    jsonb_build_object('id','B','text','$2.50$','explanation','Correct. Two steps of size $0.5$ reach $x=1$ and give $y(1)\approx 2.5$.'),
    jsonb_build_object('id','C','text','$2.25$','explanation','This often comes from using the slope at the wrong point (for example, using $(0.5,1)$ instead of $(0.5,1.5)$).'),
    jsonb_build_object('id','D','text','$3.00$','explanation','This often comes from using $h=1$ or taking an unnecessary additional step.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Euler update: $y_{n+1}=y_n+h\,f(x_n,y_n)$ with $f(x,y)=x+y$.\n\nStart $(x_0,y_0)=(0,1)$, $h=0.5$.\n\n$y_1=1+0.5(0+1)=1.5$ at $x_1=0.5$.\n\n$y_2=1.5+0.5(0.5+1.5)=1.5+1=2.5$ at $x_2=1$.\n\nSo $y(1)\approx 2.5$.',
  recommendation_reasons = ARRAY['Reinforces correct Euler iteration and step counting.', 'Targets common step-size and point-evaluation mistakes.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Euler’s method with two steps; emphasize evaluating slope at the left endpoint of each step.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text',
    primary_skill_id = 'SK_EULER_METHOD',
    supporting_skill_ids = ARRAY['SK_TABLE_ITERATION','SK_SLOPE_EVAL'],
  representation_type = 'symbolic',
  topic_id = 'Both_DiffEq',
  updated_at = NOW()
WHERE title = '7.5-P1';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_DiffEq',
  sub_topic_id = '7.5',
  section_id = '7.5',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 1,
  target_time_seconds = 60,
  skill_tags = ARRAY['SK_EULER_METHOD', 'SK_SLOPE_EVAL'],
  error_tags = ARRAY['E_STEP_SIZE', 'E_SIGN_ARITH'],
  prompt = 'A solution satisfies $\frac{dy}{dx}=4-x$ and $y(2)=5$. Using Euler’s method with step size $h=0.25$, what is the next approximation for $y(2.25)$?',
  latex = 'A solution satisfies $\frac{dy}{dx}=4-x$ and $y(2)=5$. Using Euler’s method with step size $h=0.25$, what is the next approximation for $y(2.25)$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$5.25$','explanation','This often comes from using slope $1$ instead of the correct slope $2$ at $x=2$.'),
    jsonb_build_object('id','B','text','$5.375$','explanation','This often comes from using slope $1.5$ (evaluating at the wrong $x$) or using the wrong step size.'),
    jsonb_build_object('id','C','text','$5.50$','explanation','Correct. Euler uses the left-endpoint slope at $x=2$, which is $4-2=2$, so $\Delta y\approx 0.25(2)=0.5$.'),
    jsonb_build_object('id','D','text','$5.5625$','explanation','This often comes from incorrectly evaluating the slope at $x=2.25$ and then multiplying by $0.25$.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'Euler step: $y_{1}=y_0+h\,f(x_0,y_0)$ with $f(x,y)=4-x$.\n\nAt $x_0=2$, $f=4-2=2$. With $h=0.25$,\n$$y(2.25)\approx 5+0.25(2)=5.5.$$',
  recommendation_reasons = ARRAY['Checks the core Euler update when $f$ depends only on $x$.', 'Targets the left-endpoint slope rule.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 1,
  mastery_weight = 0.90,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Single Euler step; emphasize using slope at $x=2$ (not $x=2.25$).',
  weight_primary = 1.00,
  weight_supporting = 0.00,
  prompt_type = 'text',
    primary_skill_id = 'SK_EULER_METHOD',
    supporting_skill_ids = ARRAY['SK_SLOPE_EVAL'],
  representation_type = 'symbolic',
  topic_id = 'Both_DiffEq',
  updated_at = NOW()
WHERE title = '7.5-P2';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_DiffEq',
  sub_topic_id = '7.5',
  section_id = '7.5',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 120,
  skill_tags = ARRAY['SK_EULER_METHOD', 'SK_EULER_ERROR_CONCAVITY', 'SK_CONCAVITY_REASONING'],
  error_tags = ARRAY['E_OVER_UNDER', 'E_CONCAVITY'],
  prompt = 'Consider the IVP $$\frac{dy}{dx}=y,\quad y(0)=1.$$ Using Euler’s method with step size $h=1$ to approximate $y(1)$, will the Euler approximation be an overestimate or an underestimate of the exact value?',
  latex = 'Consider the IVP $$\frac{dy}{dx}=y,\quad y(0)=1.$$ Using Euler’s method with step size $h=1$ to approximate $y(1)$, will the Euler approximation be an overestimate or an underestimate of the exact value?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','Overestimate','explanation','For a concave up solution, the tangent line lies below the graph, so Euler tends to underestimate.'),
    jsonb_build_object('id','B','text','Underestimate','explanation','Correct. The solution is concave up on $[0,1]$, so the Euler (tangent-line) step from $x=0$ lies below the curve.'),
    jsonb_build_object('id','C','text','Exact (no error)','explanation','Euler is exact only when the solution is linear on the step interval, which is not the case here.'),
    jsonb_build_object('id','D','text','Cannot be determined','explanation','Concavity is enough to decide: the solution is concave up on $[0,1]$.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'The exact solution is $y=e^x$, and $y''''=e^x>0$ on $[0,1]$, so $y$ is concave up.\n\nEuler’s method uses the tangent line at the left endpoint. For concave up functions, tangent lines lie below the curve on the interval, so the Euler approximation underestimates the exact value.',
  recommendation_reasons = ARRAY['Builds AP-style reasoning about Euler error using concavity.', 'Targets the frequent over/under reversal mistake.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.05,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Qualitative Euler error: concave up implies Euler underestimate (left-endpoint tangent).',
  weight_primary = 0.60,
  weight_supporting = 0.40,
  prompt_type = 'text',
    primary_skill_id = 'SK_EULER_METHOD',
    supporting_skill_ids = ARRAY['SK_EULER_ERROR_CONCAVITY','SK_CONCAVITY_REASONING'],
  representation_type = 'symbolic',
  topic_id = 'Both_DiffEq',
  updated_at = NOW()
WHERE title = '7.5-P3';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_DiffEq',
  sub_topic_id = '7.5',
  section_id = '7.5',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 150,
  skill_tags = ARRAY['SK_EULER_METHOD', 'SK_COMPARE_EXACT', 'SK_INTEGRATE_BASIC'],
  error_tags = ARRAY['E_STEP_SIZE', 'E_SIGN_ARITH', 'E_COMPARE_WRONG_QUANTITY'],
  prompt = 'Use Euler’s method with step size $h=0.5$ to approximate $y(1)$ for $$\frac{dy}{dx}=2x,\quad y(0)=0.$$ Then compare with the exact value $y(1)$ and find the absolute error.',
  latex = 'Use Euler’s method with step size $h=0.5$ to approximate $y(1)$ for $$\frac{dy}{dx}=2x,\quad y(0)=0.$$ Then compare with the exact value $y(1)$ and find the absolute error.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','Approx $y(1)=0$, error $1$','explanation','This comes from using the first-step slope $2x_0=0$ for both steps.'),
    jsonb_build_object('id','B','text','Approx $y(1)=1$, error $0$','explanation','This would be true only if Euler were exact here with $h=0.5$, but it is not.'),
    jsonb_build_object('id','C','text','Approx $y(1)=0.5$, error $0.5$','explanation','Correct. Euler gives $y(1)\approx 0.5$ and the exact value is $1$, so the absolute error is $0.5$.'),
    jsonb_build_object('id','D','text','Approx $y(1)=0.25$, error $0.75$','explanation','This often comes from using $h=0.25$ or miscomputing the second-step slope.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'Euler: $y_{n+1}=y_n+h(2x_n)$ with $h=0.5$.\n\n$(x_0,y_0)=(0,0)$: $y_1=0+0.5(0)=0$ at $x_1=0.5$.\n\nAt $x_1=0.5$: $y_2=0+0.5(2\cdot 0.5)=0.5$ at $x_2=1$.\n\nExact: $y''=2x \Rightarrow y=x^2+C$, and $y(0)=0\Rightarrow y=x^2$, so $y(1)=1$.\n\nAbsolute error: $|1-0.5|=0.5$.',
  recommendation_reasons = ARRAY['Combines Euler iteration with exact-solution comparison.', 'Targets confusing the approximation with the exact value.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.15,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Compute Euler approximation and absolute error; exact obtained by integration.',
  weight_primary = 0.60,
  weight_supporting = 0.40,
  prompt_type = 'text',
    primary_skill_id = 'SK_EULER_METHOD',
    supporting_skill_ids = ARRAY['SK_COMPARE_EXACT','SK_INTEGRATE_BASIC'],
  representation_type = 'symbolic',
  topic_id = 'Both_DiffEq',
  updated_at = NOW()
WHERE title = '7.5-P4';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_DiffEq',
  sub_topic_id = '7.5',
  section_id = '7.5',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 135,
  skill_tags = ARRAY['SK_EULER_METHOD', 'SK_TABLE_ITERATION'],
  error_tags = ARRAY['E_STEP_SIZE', 'E_SIGN_ARITH', 'E_IC_MISAPPLIED'],
  prompt = 'Use Euler’s method with step size $h=0.1$ to approximate $y(0.2)$ for $$\frac{dy}{dx}=y^2,\quad y(0)=1.$$',
  latex = 'Use Euler’s method with step size $h=0.1$ to approximate $y(0.2)$ for $$\frac{dy}{dx}=y^2,\quad y(0)=1.$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$1.20$','explanation','This often comes from treating the slope as constant: $y(0.2)\approx 1+0.2(1^2)$.'),
    jsonb_build_object('id','B','text','$1.21$','explanation','This often comes from stopping after computing $1.1^2=1.21$ but not finishing the second Euler update.'),
    jsonb_build_object('id','C','text','$1.221$','explanation','Correct. Two Euler steps: $y_1=1.1$, then $y_2=1.1+0.1(1.1^2)=1.221$.'),
    jsonb_build_object('id','D','text','$1.232$','explanation','This often comes from inconsistent rounding or squaring an incorrect intermediate value.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'Euler update $y_{n+1}=y_n+h\,y_n^2$ with $h=0.1$.\n\n$y_0=1$.\n\nAt $x=0.1$: $y_1=1+0.1(1^2)=1.1$.\n\nAt $x=0.2$: $y_2=1.1+0.1(1.1^2)=1.1+0.1(1.21)=1.221$.\n\nSo $y(0.2)\approx 1.221$.',
  recommendation_reasons = ARRAY['Forces recomputing slope each step for a nonlinear DE.', 'Targets the common “treat slope constant” shortcut error.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.10,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Nonlinear Euler iteration; emphasize updating with the current $y_n$.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text',
    primary_skill_id = 'SK_EULER_METHOD',
    supporting_skill_ids = ARRAY['SK_TABLE_ITERATION'],
  representation_type = 'symbolic',
  topic_id = 'Both_DiffEq',
  updated_at = NOW()
WHERE title = '7.5-P5';



-- Unit 7.6 (Finding General Solutions Using Separation of Variables) — Practice 1–5

UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_DiffEq',
  sub_topic_id = '7.6',
  section_id = '7.6',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 105,
  skill_tags = ARRAY['SK_SEP_VARIABLES', 'SK_INTEGRATE_BASIC', 'SK_SOLVE_FOR_Y'],
  error_tags = ARRAY['E_SEPARATION_WRONG', 'E_CONST_MISSING', 'E_SIGN_ARITH'],
  prompt = 'Find the general solution of $$\frac{dy}{dx}=\frac{x^2}{y}$$ for $y\ne 0$.',
  latex = 'Find the general solution of $$\frac{dy}{dx}=\frac{x^2}{y}$$ for $y\ne 0$.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$y^2=\frac{2}{3}x^3+C$','explanation','Correct. Separate to get $y\,dy=x^2\,dx$; integrate and multiply by 2.'),
    jsonb_build_object('id','B','text','$y=\frac{1}{3}x^3+C$','explanation','This treats the equation as if it were linear and ignores the $y$ factor when separating.'),
    jsonb_build_object('id','C','text','$\ln|y|=\frac{1}{3}x^3+C$','explanation','This integrates the left side as $\int \frac{1}{y}\,dy$ instead of $\int y\,dy$.'),
    jsonb_build_object('id','D','text','$y^2=\frac{1}{3}x^3+C$','explanation','This misses the factor of 2 when clearing the $\frac12$ from $\frac12 y^2$.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Separate: $\frac{dy}{dx}=\frac{x^2}{y}\Rightarrow y\,dy=x^2\,dx$.\n\nIntegrate: $\int y\,dy=\int x^2\,dx$ gives $\frac12 y^2=\frac13 x^3+C$.\n\nMultiply by 2: $y^2=\frac{2}{3}x^3+C$.',
  recommendation_reasons = ARRAY['Standard separable form; checks constants carefully.', 'Targets wrong-side integration and missing factor errors.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Keep solution in implicit form; emphasize correct separation and the factor 2.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text',
    primary_skill_id = 'SK_SEP_VARIABLES',
    supporting_skill_ids = ARRAY['SK_INTEGRATE_BASIC','SK_SOLVE_FOR_Y'],
  representation_type = 'symbolic',
  topic_id = 'Both_DiffEq',
  updated_at = NOW()
WHERE title = '7.6-P1';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_DiffEq',
  sub_topic_id = '7.6',
  section_id = '7.6',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 150,
  skill_tags = ARRAY['SK_SEP_VARIABLES', 'SK_INTEGRATE_BASIC', 'SK_APPLY_IC'],
  error_tags = ARRAY['E_IC_MISAPPLIED', 'E_CONST_MISSING', 'E_SIGN_ARITH'],
  prompt = 'Solve the IVP $$\frac{dy}{dx}=y\cos x,\quad y(0)=2.$$',
  latex = 'Solve the IVP $$\frac{dy}{dx}=y\cos x,\quad y(0)=2.$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$y=2e^{\sin x}$','explanation','Correct. $\frac{1}{y}dy=\cos x\,dx\Rightarrow \ln|y|=\sin x+C$, then use $y(0)=2$.'),
    jsonb_build_object('id','B','text','$y=2e^{\cos x}$','explanation','This integrates $\cos x$ incorrectly (it should be $\sin x$).'),
    jsonb_build_object('id','C','text','$y=2+\sin x$','explanation','This ignores the multiplicative $y$ factor and treats $y''=\cos x$.'),
    jsonb_build_object('id','D','text','$y=e^{2\sin x}$','explanation','This misapplies the initial condition by placing 2 inside the exponent.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Separate: $\frac{dy}{dx}=y\cos x\Rightarrow \frac{1}{y}dy=\cos x\,dx$.\n\nIntegrate: $\ln|y|=\sin x+C$.\n\nExponentiate: $y=Ke^{\sin x}$.\n\nUse $y(0)=2$: $2=Ke^{0}\Rightarrow K=2$.\n\nSo $y=2e^{\sin x}$.',
  recommendation_reasons = ARRAY['Common AP separable IVP with exponential form.', 'Targets the frequent antiderivative and IC-placement mistakes.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.05,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Separable IVP; ensure correct integration of $\cos x$ and proper use of $y(0)=2$.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text',
    primary_skill_id = 'SK_SEP_VARIABLES',
    supporting_skill_ids = ARRAY['SK_INTEGRATE_BASIC','SK_APPLY_IC'],
  representation_type = 'symbolic',
  topic_id = 'Both_DiffEq',
  updated_at = NOW()
WHERE title = '7.6-P2';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_DiffEq',
  sub_topic_id = '7.6',
  section_id = '7.6',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 1,
  target_time_seconds = 75,
  skill_tags = ARRAY['SK_IDENTIFY_SEPARABLE', 'SK_SEP_VARIABLES'],
  error_tags = ARRAY['E_SEPARATION_WRONG', 'E_CLASSIFY_SEPARABLE'],
  prompt = 'Which differential equation is separable?\n\nI. $\frac{dy}{dx}=x+y$\n\nII. $\frac{dy}{dx}=xy$\n\nIII. $\frac{dy}{dx}=\frac{x}{y}$',
  latex = 'Which differential equation is separable?\n\nI. $\frac{dy}{dx}=x+y$\n\nII. $\frac{dy}{dx}=xy$\n\nIII. $\frac{dy}{dx}=\frac{x}{y}$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','II only','explanation','II is separable, but III is also separable.'),
    jsonb_build_object('id','B','text','III only','explanation','III is separable, but II is also separable.'),
    jsonb_build_object('id','C','text','II and III only','explanation','Correct. II can be written $\frac{1}{y}dy=x\,dx$ and III can be written $y\,dy=x\,dx$. I is not a product of a pure $x$-function and a pure $y$-function.'),
    jsonb_build_object('id','D','text','I, II, and III','explanation','I is not separable as written because $x+y$ does not factor into $g(x)h(y)$.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'A first-order DE is separable if it can be written $\frac{dy}{dx}=g(x)h(y)$.\n\nII: $xy=g(x)h(y)$ with $g(x)=x$ and $h(y)=y$.\n\nIII: $\frac{x}{y}=g(x)h(y)$ with $g(x)=x$ and $h(y)=\frac{1}{y}$.\n\nI: $x+y$ is a sum, not a product of a pure $x$-function and a pure $y$-function.',
  recommendation_reasons = ARRAY['Fast classification skill used frequently in Unit 7.', 'Targets the common “sum is separable” misconception.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 1,
  mastery_weight = 0.85,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Recognition only; no solving required.',
  weight_primary = 1.00,
  weight_supporting = 0.00,
  prompt_type = 'text',
    primary_skill_id = 'SK_IDENTIFY_SEPARABLE',
    supporting_skill_ids = ARRAY['SK_SEP_VARIABLES'],
  representation_type = 'symbolic',
  topic_id = 'Both_DiffEq',
  updated_at = NOW()
WHERE title = '7.6-P3';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_DiffEq',
  sub_topic_id = '7.6',
  section_id = '7.6',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 165,
  skill_tags = ARRAY['SK_SEP_VARIABLES', 'SK_APPLY_IC', 'SK_POWER_LAW_SOLUTION'],
  error_tags = ARRAY['E_LN_ABS_MISSING', 'E_IC_MISAPPLIED', 'E_SIGN_ARITH'],
  prompt = 'Solve the IVP $$\frac{dy}{dx}=\frac{3y}{x},\quad y(2)=-4,$$ for $x>0$.',
  latex = 'Solve the IVP $$\frac{dy}{dx}=\frac{3y}{x},\quad y(2)=-4,$$ for $x>0$.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$y=-2x^3$','explanation','This comes from using $-4=C\cdot 2$ instead of $-4=C\cdot 8$ when applying the initial condition.'),
    jsonb_build_object('id','B','text','$y=\frac{1}{2}x^3$','explanation','Sign error: $y(2)$ is negative, so the constant must be negative.'),
    jsonb_build_object('id','C','text','$y=-\frac{1}{2}x$','explanation','This does not follow from separating $\frac{1}{y}dy=\frac{3}{x}dx$.'),
    jsonb_build_object('id','D','text','$y=-\frac{1}{2}x^3$','explanation','Correct. Separation gives $y=Cx^3$, then $-4=C(8)$ so $C=-\frac{1}{2}$.')
  ),
  correct_option_id = 'D',
  tolerance = 0.0010,
  explanation = 'Separate: $\frac{dy}{dx}=\frac{3y}{x}\Rightarrow \frac{1}{y}dy=\frac{3}{x}dx$.\n\nIntegrate: $\ln|y|=3\ln|x|+C$. For $x>0$, $\ln|x|=\ln x$.\n\nExponentiate: $y=Cx^3$.\n\nUse $y(2)=-4$: $-4=C\cdot 8\Rightarrow C=-\frac{1}{2}$.\n\nSo $y=-\frac{1}{2}x^3$.',
  recommendation_reasons = ARRAY['High-frequency form $y''/y=k/x$ leading to a power solution.', 'Targets sign and initial-condition constant errors.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.15,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Emphasize $\ln|y|$ and domain $x>0$; then convert to $y=Cx^3$ before applying IC.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text',
    primary_skill_id = 'SK_SEP_VARIABLES',
    supporting_skill_ids = ARRAY['SK_APPLY_IC','SK_POWER_LAW_SOLUTION'],
  representation_type = 'symbolic',
  topic_id = 'Both_DiffEq',
  updated_at = NOW()
WHERE title = '7.6-P4';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_DiffEq',
  sub_topic_id = '7.6',
  section_id = '7.6',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 5,
  target_time_seconds = 210,
  skill_tags = ARRAY['SK_SEP_VARIABLES', 'SK_PARTIAL_FRACTIONS', 'SK_LOG_PROPERTIES'],
  error_tags = ARRAY['E_PARTIAL_FRACTIONS', 'E_CONST_MISSING', 'E_LN_ABS_MISSING'],
  prompt = 'Find an implicit general solution to $$\frac{dy}{dx}=(y-1)(y+2).$$',
  latex = 'Find an implicit general solution to $$\frac{dy}{dx}=(y-1)(y+2).$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\ln|y-1|-\ln|y+2|=3x+C$','explanation','This is equivalent to the correct answer, but it is not simplified into a single logarithm ratio.'),
    jsonb_build_object('id','B','text','$\ln\left|\frac{y-1}{y+2}\right|=3x+C$','explanation','Correct. Separation gives $\int \frac{1}{(y-1)(y+2)}dy=\int dx$, and partial fractions lead to a log ratio equal to $3x+C$.'),
    jsonb_build_object('id','C','text','$\ln|y-1|+\ln|y+2|=x+C$','explanation','This uses the wrong partial-fraction signs and the wrong constant factor.'),
    jsonb_build_object('id','D','text','$\ln|y^2+y-2|=x+C$','explanation','This incorrectly treats $\int \frac{1}{(y-1)(y+2)}dy$ as $\ln$ of the denominator.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Separate: $\frac{dy}{(y-1)(y+2)}=dx$.\n\nPartial fractions:\n$$\frac{1}{(y-1)(y+2)}=\frac{1/3}{y-1}-\frac{1/3}{y+2}.$$\n\nIntegrate:\n$$\frac{1}{3}\ln|y-1|-\frac{1}{3}\ln|y+2|=x+C.$$\n\nMultiply by 3 and combine logs:\n$$\ln\left|\frac{y-1}{y+2}\right|=3x+C''. $$',
  recommendation_reasons = ARRAY['AP-style separable DE requiring partial fractions.', 'Targets coefficient/sign mistakes and log-combination errors.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 5,
  mastery_weight = 1.25,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Implicit solution acceptable; focus on partial fractions and log properties.',
  weight_primary = 0.60,
  weight_supporting = 0.40,
  prompt_type = 'text',
    primary_skill_id = 'SK_SEP_VARIABLES',
    supporting_skill_ids = ARRAY['SK_PARTIAL_FRACTIONS','SK_LOG_PROPERTIES'],
  representation_type = 'symbolic',
  topic_id = 'Both_DiffEq',
  updated_at = NOW()
WHERE title = '7.6-P5';

COMMIT;
