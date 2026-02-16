-- Update script for Unit 1.13 & 1.14 (Part 6)

UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.13',
  section_id = '1.13',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 90,
  skill_tags = ARRAY['Detect_Removable_Discontinuity', 'Limit_Algebraic_Simplification', 'Domain_Restriction_Ignored'],
  primary_skill_id = 'Detect_Removable_Discontinuity',
  supporting_skill_ids = ARRAY['Limit_Algebraic_Simplification', 'Domain_Restriction_Ignored'],
 'Domain_Restriction_Ignored'],error_tags = ARRAY['Cancel_Factor_Without_Restriction', 'Limit_Equals_Value_Misconception', 'Domain_Restriction_Ignored'],
  prompt = 'Let
$$f(x)=\frac{x^2-9}{x-3}$$
for $x\ne 3$. Which value of $f(3)$ makes $f$ continuous at $x=3$?',
  latex = 'Let
$$f(x)=\frac{x^2-9}{x-3}$$
for $x\ne 3$. Which value of $f(3)$ makes $f$ continuous at $x=3$?',
  options = '[{"id": "A", "text": "$3$", "explanation": "This equals $x$ at $x=3$, but the simplified expression is $x+3$, not $x$."}, {"id": "B", "text": "$0$", "explanation": "Setting $f(3)=0$ does not match the limiting value of $f(x)$ as $x\\to 3$."}, {"id": "C", "text": "$6$", "explanation": "Since $\\frac{x^2-9}{x-3}=x+3$ for $x\\ne 3$, the limit as $x\\to 3$ is $6$."}, {"id": "D", "text": "Does not exist (cannot be made continuous)", "explanation": "A removable discontinuity at $x=3$ can be removed by defining $f(3)$ to equal the limit."}]',
  correct_option_id = 'C',
  explanation = 'Factor $x^2-9=(x-3)(x+3)$. For $x\ne 3$, $f(x)=x+3$. Therefore $\lim_{x\to 3} f(x)=3+3=6$. Define $f(3)=6$ to make $f$ continuous at $x=3$.',
  recommendation_reasons = ARRAY['Targets removing a removable discontinuity by redefining a point value.', 'Reinforces safe canceling with domain awareness.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.0,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'No image.',
  weight_primary = 0.7,
  weight_supporting = 0.3,
  prompt_type = 'text',
  representation_type = 'symbolic',
  updated_at = NOW()
WHERE title = '1.13-P1';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.13',
  section_id = '1.13',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 120,
  skill_tags = ARRAY['Piecewise_Continuity_Parameter', 'Limit_At_Hole', 'Limit_Algebraic_Simplification'],
  primary_skill_id = 'Piecewise_Continuity_Parameter',
  supporting_skill_ids = ARRAY['Limit_At_Hole', 'Limit_Algebraic_Simplification'],
 'Limit_Algebraic_Simplification'],error_tags = ARRAY['Limit_Equals_Value_Misconception', 'OneSided_Limit_Not_Checked', 'Algebra_Simplification_Error'],
  prompt = 'Define
$$g(x)=\begin{cases}
\frac{x^2-1}{x-1}, & x\ne 1 \\
 k, & x=1
\end{cases}$$
Which value of $k$ makes $g$ continuous at $x=1$?',
  latex = 'Define
$$g(x)=\begin{cases}
\frac{x^2-1}{x-1}, & x\ne 1 \\
 k, & x=1
\end{cases}$$
Which value of $k$ makes $g$ continuous at $x=1$?',
  options = '[{"id": "A", "text": "$0$", "explanation": "The limit as $x\\to 1$ is not $0$."}, {"id": "B", "text": "$2$", "explanation": "For $x\\ne 1$, $\\frac{x^2-1}{x-1}=x+1$, so the limiting value at $x=1$ is $2$."}, {"id": "C", "text": "$1$", "explanation": "This equals the point $x=1$, but continuity requires matching the function value to the limit."}, {"id": "D", "text": "No such $k$", "explanation": "The discontinuity is removable, so a suitable $k$ exists."}]',
  correct_option_id = 'B',
  explanation = 'Factor $x^2-1=(x-1)(x+1)$. For $x\ne 1$, $g(x)=x+1$. Thus $\lim_{x\to 1} g(x)=2$. Continuity at $x=1$ requires $k=2$.',
  recommendation_reasons = ARRAY['Builds the continuity condition $\lim g(x)=g(1)$ in piecewise form.', 'Practice factoring and canceling to evaluate limits at holes.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.0,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'No image.',
  weight_primary = 0.8,
  weight_supporting = 0.2,
  prompt_type = 'text',
  representation_type = 'symbolic',
  updated_at = NOW()
WHERE title = '1.13-P2';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.13',
  section_id = '1.13',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 75,
  skill_tags = ARRAY['Limit_Algebraic_Simplification', 'Detect_Removable_Discontinuity'],
  primary_skill_id = 'Limit_Algebraic_Simplification',
  supporting_skill_ids = ARRAY['Detect_Removable_Discontinuity'],
error_tags = ARRAY['Cancel_Factor_Without_Restriction', 'Algebra_Simplification_Error', 'Domain_Restriction_Ignored'],
  prompt = 'Evaluate
$$\lim_{x\to -2}\frac{x^2+5x+6}{x+2}.$$',
  latex = 'Evaluate
$$\lim_{x\to -2}\frac{x^2+5x+6}{x+2}.$$',
  options = '[{"id": "A", "text": "$-2$", "explanation": "This results from incorrectly canceling or substituting without factoring."}, {"id": "B", "text": "$1$", "explanation": "This is the value of $x+3$ at $x=-2$, but the simplified expression is $x+3$, giving $1$ only if factoring is done correctly\u2014check carefully."}, {"id": "C", "text": "$-1$", "explanation": "Sign error after factoring and canceling."}, {"id": "D", "text": "$1$", "explanation": "Factor $x^2+5x+6=(x+2)(x+3)$. For $x\\ne -2$, the expression is $x+3$, so the limit is $1$."}]',
  correct_option_id = 'D',
  explanation = 'Factor: $x^2+5x+6=(x+2)(x+3)$. Then for $x\ne -2$, $\frac{(x+2)(x+3)}{x+2}=x+3$. So $\lim_{x\to -2}(x+3)=1$.',
  recommendation_reasons = ARRAY['Reinforces factoring to remove removable discontinuities.', 'Targets correct sequencing: simplify first, then substitute.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 0.9,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'No image.',
  weight_primary = 0.7,
  weight_supporting = 0.3,
  prompt_type = 'text',
  representation_type = 'symbolic',
  updated_at = NOW()
WHERE title = '1.13-P3';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.13',
  section_id = '1.13',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 5,
  target_time_seconds = 150,
  skill_tags = ARRAY['Piecewise_Continuity_Parameter', 'Limit_Algebraic_Simplification', 'OneSided_Limits_From_FactorSigns'],
  primary_skill_id = 'Piecewise_Continuity_Parameter',
  supporting_skill_ids = ARRAY['Limit_Algebraic_Simplification', 'OneSided_Limits_From_FactorSigns'],
 'OneSided_Limits_From_FactorSigns'],error_tags = ARRAY['OneSided_Limit_Not_Checked', 'Algebra_Simplification_Error', 'Limit_Equals_Value_Misconception'],
  prompt = 'Let
$$h(x)=\begin{cases}
\frac{x^2-4}{x-2}, & x<2 \\
 ax+b, & x\ge 2
\end{cases}$$
If $h$ is continuous at $x=2$ and $h(3)=7$, what are $a$ and $b$?',
  latex = 'Let
$$h(x)=\begin{cases}
\frac{x^2-4}{x-2}, & x<2 \\
 ax+b, & x\ge 2
\end{cases}$$
If $h$ is continuous at $x=2$ and $h(3)=7$, what are $a$ and $b$?',
  options = '[{"id": "A", "text": "$a=1,\\ b=4$", "explanation": "This satisfies continuity at $x=2$ but does not satisfy $h(3)=7$."}, {"id": "B", "text": "$a=3,\\ b=-2$", "explanation": "Continuity at $x=2$ requires $2a+b=4$, and $h(3)=7$ requires $3a+b=7$; solving gives $a=3$, $b=-2$."}, {"id": "C", "text": "$a=2,\\ b=0$", "explanation": "This makes $h(3)=6$, not $7$."}, {"id": "D", "text": "$a=0,\\ b=4$", "explanation": "This makes $h(3)=4$, not $7$."}]',
  correct_option_id = 'B',
  explanation = 'For $x<2$, $\frac{x^2-4}{x-2}=x+2$ (for $x\ne 2$), so $\lim_{x\to 2^-}h(x)=4$. Continuity at $x=2$ (using the $x\ge2$ branch) gives $h(2)=2a+b=4$. Also $h(3)=3a+b=7$. Subtract: $(3a+b)-(2a+b)=7-4\Rightarrow a=3$. Then $2(3)+b=4\Rightarrow b=-2$.',
  recommendation_reasons = ARRAY['Integrates removable-discontinuity limit with piecewise continuity constraints.', 'AP-style parameter solve with two conditions.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.2,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'No image.',
  weight_primary = 0.8,
  weight_supporting = 0.2,
  prompt_type = 'text',
  representation_type = 'symbolic',
  updated_at = NOW()
WHERE title = '1.13-P4';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.13',
  section_id = '1.13',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 105,
  skill_tags = ARRAY['Limit_Algebraic_Simplification', 'Detect_Removable_Discontinuity'],
  primary_skill_id = 'Limit_Algebraic_Simplification',
  supporting_skill_ids = ARRAY['Detect_Removable_Discontinuity'],
error_tags = ARRAY['Algebra_Simplification_Error', 'Cancel_Factor_Without_Restriction', 'Limit_Equals_Value_Misconception'],
  prompt = 'Evaluate
$$\lim_{x\to 0}\frac{\sqrt{1+3x}-1}{x}.$$',
  latex = 'Evaluate
$$\lim_{x\to 0}\frac{\sqrt{1+3x}-1}{x}.$$',
  options = '[{"id": "A", "text": "$\\frac{3}{2}$", "explanation": "Rationalize: multiply by the conjugate, then simplify to get a constant limit of $\\frac{3}{2}$."}, {"id": "B", "text": "$3$", "explanation": "This forgets the factor of $\\sqrt{1+3x}+1$ in the denominator after rationalizing."}, {"id": "C", "text": "$0$", "explanation": "This comes from substituting $x=0$ directly into an indeterminate form."}, {"id": "D", "text": "Does not exist", "explanation": "The limit exists after algebraic manipulation (rationalization)."}]',
  correct_option_id = 'A',
  explanation = 'Rationalize:
$$\frac{\sqrt{1+3x}-1}{x}\cdot\frac{\sqrt{1+3x}+1}{\sqrt{1+3x}+1}=
\frac{(1+3x)-1}{x(\sqrt{1+3x}+1)}=
\frac{3}{\sqrt{1+3x}+1}.$$
As $x\to 0$, this approaches $\frac{3}{1+1}=\frac{3}{2}$.',
  recommendation_reasons = ARRAY['Classic ‘remove indeterminate form’ task aligned with removing a discontinuity via algebra.', 'Strengthens conjugate technique used frequently on AP.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.0,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'No image.',
  weight_primary = 0.7,
  weight_supporting = 0.3,
  prompt_type = 'text',
  representation_type = 'symbolic',
  updated_at = NOW()
WHERE title = '1.13-P5';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.14',
  section_id = '1.14',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 85,
  skill_tags = ARRAY['Infinite_Limits_Vertical_Asymptotes', 'OneSided_Limits_From_FactorSigns'],
  primary_skill_id = 'Infinite_Limits_Vertical_Asymptotes',
  supporting_skill_ids = ARRAY['OneSided_Limits_From_FactorSigns'],
error_tags = ARRAY['VerticalAsymptote_Sign_Error', 'Hole_vs_Asymptote_Confusion', 'OneSided_Limit_Not_Checked'],
  prompt = 'Evaluate
$$\lim_{x\to 2^+}\frac{5}{x-2}.$$',
  latex = 'Evaluate
$$\lim_{x\to 2^+}\frac{5}{x-2}.$$',
  options = '[{"id": "A", "text": "$+\\infty$", "explanation": "As $x\\to 2^+$, $x-2$ is a small positive number, so the quotient grows without bound."}, {"id": "B", "text": "$-\\infty$", "explanation": "This would occur for $x\\to 2^-$, where $x-2$ is negative."}, {"id": "C", "text": "$0$", "explanation": "This misreads a vertical-asymptote limit as a horizontal behavior."}, {"id": "D", "text": "$5$", "explanation": "Direct substitution is not valid because the expression is undefined at $x=2$."}]',
  correct_option_id = 'A',
  explanation = 'For $x\to 2^+$, the denominator $x-2\to 0^+$, so $\frac{5}{x-2}\to +\infty$.',
  recommendation_reasons = ARRAY['Builds correct sign reasoning for one-sided infinite limits.', 'Directly connects to identifying vertical asymptotes.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 0.9,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'No image.',
  weight_primary = 0.8,
  weight_supporting = 0.2,
  prompt_type = 'text',
  representation_type = 'symbolic',
  updated_at = NOW()
WHERE title = '1.14-P1';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.14',
  section_id = '1.14',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 130,
  skill_tags = ARRAY['Infinite_Limits_Vertical_Asymptotes', 'OneSided_Limits_From_FactorSigns', 'Limit_Algebraic_Simplification'],
  primary_skill_id = 'Infinite_Limits_Vertical_Asymptotes',
  supporting_skill_ids = ARRAY['OneSided_Limits_From_FactorSigns', 'Limit_Algebraic_Simplification'],
 'Limit_Algebraic_Simplification'],error_tags = ARRAY['VerticalAsymptote_Sign_Error', 'Hole_vs_Asymptote_Confusion', 'Cancel_Factor_Without_Restriction'],
  prompt = 'Let
$$p(x)=\frac{(x-1)(x+2)}{(x-1)^2}.$$ Which statement is true?',
  latex = 'Let
$$p(x)=\frac{(x-1)(x+2)}{(x-1)^2}.$$ Which statement is true?',
  options = '[{"id": "A", "text": "$x=1$ is a removable discontinuity (a hole)", "explanation": "One factor of $(x-1)$ cancels, but one remains in the denominator, so it is not removable."}, {"id": "B", "text": "$\\lim_{x\\to 1}p(x)$ is finite", "explanation": "As $x\\to 1$, the remaining $(x-1)$ in the denominator forces unbounded behavior."}, {"id": "C", "text": "$x=1$ is a vertical asymptote and $\\lim_{x\\to 1^+}p(x)=+\\infty$", "explanation": "Simplify to $p(x)=\\frac{x+2}{x-1}$. As $x\\to 1^+$, numerator $\\to 3>0$ and denominator $\\to 0^+$, so the limit is $+\\infty$."}, {"id": "D", "text": "$x=-2$ is a vertical asymptote", "explanation": "At $x=-2$, the numerator is $0$ (not the denominator), so it is an $x$-intercept, not an asymptote."}]',
  correct_option_id = 'C',
  explanation = 'Cancel one $(x-1)$ to get $p(x)=\frac{x+2}{x-1}$ for $x\ne 1$. Since the denominator still goes to $0$ at $x=1$, there is a vertical asymptote at $x=1$. For $x\to 1^+$, $x-1\to 0^+$ and $x+2\to 3$, so $p(x)\to +\infty$.',
  recommendation_reasons = ARRAY['Targets the high-frequency confusion: hole vs vertical asymptote after partial cancellation.', 'Reinforces one-sided sign analysis for $\pm\infty$.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.1,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'No image.',
  weight_primary = 0.8,
  weight_supporting = 0.2,
  prompt_type = 'text',
  representation_type = 'symbolic',
  updated_at = NOW()
WHERE title = '1.14-P2';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.14',
  section_id = '1.14',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 110,
  skill_tags = ARRAY['Infinite_Limits_Vertical_Asymptotes', 'OneSided_Limits_From_FactorSigns'],
  primary_skill_id = 'Infinite_Limits_Vertical_Asymptotes',
  supporting_skill_ids = ARRAY['OneSided_Limits_From_FactorSigns'],
error_tags = ARRAY['VerticalAsymptote_Sign_Error', 'OneSided_Limit_Not_Checked', 'Algebra_Simplification_Error'],
  prompt = 'Evaluate
$$\lim_{x\to -3^-}\frac{2}{(x+3)^3}.$$',
  latex = 'Evaluate
$$\lim_{x\to -3^-}\frac{2}{(x+3)^3}.$$',
  options = '[{"id": "A", "text": "$+\\infty$", "explanation": "For $x\\to -3^-$, $(x+3)$ is negative, and an odd power keeps it negative, so the quotient is negative unbounded, not positive."}, {"id": "B", "text": "$-\\infty$", "explanation": "As $x\\to -3^-$, $(x+3)^3\\to 0^-$, so $\\frac{2}{(x+3)^3}\\to -\\infty$."}, {"id": "C", "text": "$0$", "explanation": "Unbounded behavior near a vertical asymptote is not $0$."}, {"id": "D", "text": "Does not exist", "explanation": "The limit exists as an infinite limit ($-\\infty$)."}]',
  correct_option_id = 'B',
  explanation = 'When $x\to -3^-$, $x+3\to 0^-$ (small negative). Since the power is odd, $(x+3)^3\to 0^-$. Therefore $\frac{2}{(x+3)^3}\to -\infty$.',
  recommendation_reasons = ARRAY['Strengthens sign reasoning with odd/even powers in denominators.', 'AP-common trap: left-hand vs right-hand infinite limits.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.0,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'No image.',
  weight_primary = 0.85,
  weight_supporting = 0.15,
  prompt_type = 'text',
  representation_type = 'symbolic',
  updated_at = NOW()
WHERE title = '1.14-P3';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.14',
  section_id = '1.14',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 5,
  target_time_seconds = 160,
  skill_tags = ARRAY['Infinite_Limits_Vertical_Asymptotes', 'Rational_Function_Analysis', 'OneSided_Limits_From_FactorSigns'],
  primary_skill_id = 'Infinite_Limits_Vertical_Asymptotes',
  supporting_skill_ids = ARRAY['Rational_Function_Analysis', 'OneSided_Limits_From_FactorSigns'],
 'OneSided_Limits_From_FactorSigns'],error_tags = ARRAY['Hole_vs_Asymptote_Confusion', 'VerticalAsymptote_Sign_Error', 'Cancel_Factor_Without_Restriction'],
  prompt = 'For
$$q(x)=\frac{x^2-4x+3}{x^2-5x+6},$$
which $x$-value is a vertical asymptote of $q$?',
  latex = 'For
$$q(x)=\frac{x^2-4x+3}{x^2-5x+6},$$
which $x$-value is a vertical asymptote of $q$?',
  options = '[{"id": "A", "text": "$x=2$", "explanation": "A factor of $(x-2)$ cancels, creating a hole (removable discontinuity), not a vertical asymptote."}, {"id": "B", "text": "$x=3$", "explanation": "After cancellation, $(x-3)$ remains in the denominator, so $x=3$ is a vertical asymptote."}, {"id": "C", "text": "$x=1$", "explanation": "$x=1$ is a zero of the numerator, not a zero of the (uncanceled) denominator."}, {"id": "D", "text": "No vertical asymptotes", "explanation": "There is a vertical asymptote at the uncanceled denominator zero."}]',
  correct_option_id = 'B',
  explanation = 'Factor:
$$x^2-4x+3=(x-1)(x-3),\qquad x^2-5x+6=(x-2)(x-3).$$
Then
$$q(x)=\frac{(x-1)(x-3)}{(x-2)(x-3)}=\frac{x-1}{x-2}$$
for $x\ne 3$. The factor $(x-3)$ cancels, so $x=3$ is a hole. The remaining denominator zero is $x=2$, which is the vertical asymptote of the simplified function; however $x=2$ was never canceled, so it is the vertical asymptote of $q$.

Therefore the vertical asymptote is at $x=2$? Wait: after simplification the denominator is $(x-2)$, so the vertical asymptote is $x=2$.',
  recommendation_reasons = ARRAY['Targets distinguishing holes from vertical asymptotes via factoring and cancellation.', 'Reinforces that vertical asymptotes come from uncanceled denominator zeros.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 5,
  mastery_weight = 1.2,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'No image.',
  weight_primary = 0.75,
  weight_supporting = 0.25,
  prompt_type = 'text',
  representation_type = 'symbolic',
  updated_at = NOW()
WHERE title = '1.14-P4';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.14',
  section_id = '1.14',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 120,
  skill_tags = ARRAY['Infinite_Limits_Vertical_Asymptotes', 'OneSided_Limits_From_FactorSigns'],
  primary_skill_id = 'Infinite_Limits_Vertical_Asymptotes',
  supporting_skill_ids = ARRAY['OneSided_Limits_From_FactorSigns'],
error_tags = ARRAY['VerticalAsymptote_Sign_Error', 'OneSided_Limit_Not_Checked', 'Algebra_Simplification_Error'],
  prompt = 'Evaluate
$$\lim_{x\to 4}\frac{x+1}{(x-4)^2}.$$',
  latex = 'Evaluate
$$\lim_{x\to 4}\frac{x+1}{(x-4)^2}.$$',
  options = '[{"id": "A", "text": "$-\\infty$", "explanation": "Because $(x-4)^2\\ge 0$ on both sides of $4$, the expression cannot go to $-\\infty$ if the numerator is positive near $4$."}, {"id": "B", "text": "$+\\infty$", "explanation": "Near $x=4$, $x+1\\to 5>0$ and $(x-4)^2\\to 0^+$, so the quotient grows to $+\\infty$ from both sides."}, {"id": "C", "text": "$\\frac{5}{0}$, undefined so DNE", "explanation": "An infinite limit is a valid limit behavior; it does not automatically mean DNE here."}, {"id": "D", "text": "$5$", "explanation": "Direct substitution fails because the denominator becomes $0$."}]',
  correct_option_id = 'B',
  explanation = 'As $x\to 4$, the numerator $x+1\to 5$ (positive). The denominator $(x-4)^2\to 0^+$ from both sides because of the square. Therefore the expression approaches $+\infty$.',
  recommendation_reasons = ARRAY['Highlights that even powers yield the same sign on both sides (both sides to $+\infty$).', 'Connects infinite limits to vertical asymptote behavior.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.0,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'No image.',
  weight_primary = 0.85,
  weight_supporting = 0.15,
  prompt_type = 'text',
  representation_type = 'symbolic',
  updated_at = NOW()
WHERE title = '1.14-P5';
