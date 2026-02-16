-- Updated Unit 2 Questions Script
-- Generated from provided SQL values

-- Update 1.13-P2 (4fcdb293-25e2-46f2-b889-0899197211c0)
UPDATE public.questions
SET
  title = '1.13-P2',
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.13',
  type = 'MCQ',
  difficulty = 4,
  target_time_seconds = 120,
  calculator_allowed = false,
  skill_tags = ARRAY['Piecewise_Continuity_Parameter', 'Limit_At_Hole', 'Limit_Algebraic_Simplification'],
  primary_skill_id = 'Piecewise_Continuity_Parameter',
  supporting_skill_ids = ARRAY['Limit_At_Hole', 'Limit_Algebraic_Simplification'],
 'Limit_Algebraic_Simplification'],error_tags = ARRAY['Limit_Equals_Value_Misconception', 'OneSided_Limit_Not_Checked', 'Algebra_Simplification_Error'],
  prompt = 'Define\n$$g(x)=\begin{cases}\n\frac{x^2-1}{x-1}, & x\ne 1 \\\n k, & x=1\n\end{cases}$$\nWhich value of $k$ makes $g$ continuous at $x=1$?',
  latex = 'Define\n$$g(x)=\begin{cases}\n\frac{x^2-1}{x-1}, & x\ne 1 \\\n k, & x=1\n\end{cases}$$\nWhich value of $k$ makes $g$ continuous at $x=1$?',
  options = '[{"id": "A", "text": "$0$", "explanation": "The limit as $x\\to 1$ is not $0$."}, {"id": "B", "text": "$2$", "explanation": "For $x\\ne 1$, $\\frac{x^2-1}{x-1}=x+1$, so the limiting value at $x=1$ is $2$."}, {"id": "C", "text": "$1$", "explanation": "This equals the point $x=1$, but continuity requires matching the function value to the limit."}, {"id": "D", "text": "No such $k$", "explanation": "The discontinuity is removable, so a suitable $k$ exists."}]'::jsonb,
  correct_option_id = 'B',
  explanation = 'Factor $x^2-1=(x-1)(x+1)$. For $x\ne 1$, $g(x)=x+1$. Thus $\lim_{x\to 1} g(x)=2$. Continuity at $x=1$ requires $k=2$.',
  updated_at = NOW(),
  version = version + 1
WHERE id = '4fcdb293-25e2-46f2-b889-0899197211c0';

-- Update 1.13-P1 (6d17abb7-94c3-4b6c-8645-61f01c7c0d9d)
UPDATE public.questions
SET
  title = '1.13-P1',
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.13',
  type = 'MCQ',
  difficulty = 3,
  target_time_seconds = 120,
  calculator_allowed = false,
  skill_tags = ARRAY['Detect_Removable_Discontinuity', 'Limit_Algebraic_Simplification', 'Domain_Restriction_Ignored'],
  primary_skill_id = 'Detect_Removable_Discontinuity',
  supporting_skill_ids = ARRAY['Limit_Algebraic_Simplification', 'Domain_Restriction_Ignored'],
 'Domain_Restriction_Ignored'],error_tags = ARRAY['Cancel_Factor_Without_Restriction', 'Limit_Equals_Value_Misconception', 'Domain_Restriction_Ignored'],
  prompt = 'Let\n$$f(x)=\frac{x^2-9}{x-3}$$\nfor $x\ne 3$. Which value of $f(3)$ makes $f$ continuous at $x=3$?',
  latex = 'Let\n$$f(x)=\frac{x^2-9}{x-3}$$\nfor $x\ne 3$. Which value of $f(3)$ makes $f$ continuous at $x=3$?',
  options = '[{"id": "A", "text": "$3$", "explanation": "This equals $x$ at $x=3$, but the simplified expression is $x+3$, not $x$."}, {"id": "B", "text": "$0$", "explanation": "Setting $f(3)=0$ does not match the limiting value of $f(x)$ as $x\\to 3$."}, {"id": "C", "text": "$6$", "explanation": "Since $\\frac{x^2-9}{x-3}=x+3$ for $x\\ne 3$, the limit as $x\\to 3$ is $6$."}, {"id": "D", "text": "Does not exist (cannot be made continuous)", "explanation": "A removable discontinuity at $x=3$ can be removed by defining $f(3)$ to equal the limit."}]'::jsonb,
  correct_option_id = 'C',
  explanation = 'Factor $x^2-9=(x-3)(x+3)$. For $x\ne 3$, $f(x)=x+3$. Therefore $\lim_{x\to 3} f(x)=3+3=6$. Define $f(3)=6$ to make $f$ continuous at $x=3$.',
  updated_at = NOW(),
  version = version + 1
WHERE id = '6d17abb7-94c3-4b6c-8645-61f01c7c0d9d';

-- Update 1.13-P5 (1d1df4d4-390a-4763-98ee-9a9154aa7101)
UPDATE public.questions
SET
  title = '1.13-P5',
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.13',
  type = 'MCQ',
  difficulty = 3,
  target_time_seconds = 120,
  calculator_allowed = false,
  skill_tags = ARRAY['Limit_Algebraic_Simplification', 'Detect_Removable_Discontinuity'],
  primary_skill_id = 'Limit_Algebraic_Simplification',
  supporting_skill_ids = ARRAY['Detect_Removable_Discontinuity'],
error_tags = ARRAY['Algebra_Simplification_Error', 'Cancel_Factor_Without_Restriction', 'Limit_Equals_Value_Misconception'],
  prompt = 'Evaluate\n$$\lim_{x\to 0}\frac{\sqrt{1+3x}-1}{x}.$$',
  latex = 'Evaluate\n$$\lim_{x\to 0}\frac{\sqrt{1+3x}-1}{x}.$$',
  options = '[{"id": "A", "text": "$\\frac{3}{2}$", "explanation": "Rationalize: multiply by the conjugate, then simplify to get a constant limit of $\\frac{3}{2}$."}, {"id": "B", "text": "$3$", "explanation": "This forgets the factor of $\\sqrt{1+3x}+1$ in the denominator after rationalizing."}, {"id": "C", "text": "$0$", "explanation": "This comes from substituting $x=0$ directly into an indeterminate form."}, {"id": "D", "text": "Does not exist", "explanation": "The limit exists after algebraic manipulation (rationalization)."}]'::jsonb,
  correct_option_id = 'A',
  explanation = 'Rationalize:\n$$\frac{\sqrt{1+3x}-1}{x}\cdot\frac{\sqrt{1+3x}+1}{\sqrt{1+3x}+1}=\n\frac{(1+3x)-1}{x(\sqrt{1+3x}+1)}=\n\frac{3}{\sqrt{1+3x}+1}.$$\nAs $x\to 0$, this approaches $\frac{3}{1+1}=\frac{3}{2}$.',
  updated_at = NOW(),
  version = version + 1
WHERE id = '1d1df4d4-390a-4763-98ee-9a9154aa7101';

-- Update 1.13-P3 (8acd8514-e063-407b-8559-b87300662014)
UPDATE public.questions
SET
  title = '1.13-P3',
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.13',
  type = 'MCQ',
  difficulty = 2,
  target_time_seconds = 120,
  calculator_allowed = false,
  skill_tags = ARRAY['Limit_Algebraic_Simplification', 'Detect_Removable_Discontinuity'],
  primary_skill_id = 'Limit_Algebraic_Simplification',
  supporting_skill_ids = ARRAY['Detect_Removable_Discontinuity'],
error_tags = ARRAY['Cancel_Factor_Without_Restriction', 'Algebra_Simplification_Error', 'Domain_Restriction_Ignored'],
  prompt = 'Evaluate\n$$\lim_{x\to -2}\frac{x^2+5x+6}{x+2}.$$',
  latex = 'Evaluate\n$$\lim_{x\to -2}\frac{x^2+5x+6}{x+2}.$$',
  options = '[{"id": "A", "text": "$-2$", "explanation": "This results from incorrectly canceling or substituting without factoring."}, {"id": "B", "text": "$1$", "explanation": "This is the value of $x+3$ at $x=-2$, but the simplified expression is $x+3$, giving $1$ only if factoring is done correctly\u2014check carefully."}, {"id": "C", "text": "$-1$", "explanation": "Sign error after factoring and canceling."}, {"id": "D", "text": "$1$", "explanation": "Factor $x^2+5x+6=(x+2)(x+3)$. For $x\\ne -2$, the expression is $x+3$, so the limit is $1$."}]'::jsonb,
  correct_option_id = 'D',
  explanation = 'Factor: $x^2+5x+6=(x+2)(x+3)$. Then for $x\ne -2$, $\frac{(x+2)(x+3)}{x+2}=x+3$. So $\lim_{x\to -2}(x+3)=1$.',
  updated_at = NOW(),
  version = version + 1
WHERE id = '8acd8514-e063-407b-8559-b87300662014';

-- Update 1.13-P4 (f7c82732-afba-4e9f-90b2-a2b9686812f1)
UPDATE public.questions
SET
  title = '1.13-P4',
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.13',
  type = 'MCQ',
  difficulty = 5,
  target_time_seconds = 120,
  calculator_allowed = false,
  skill_tags = ARRAY['Piecewise_Continuity_Parameter', 'Limit_Algebraic_Simplification', 'OneSided_Limits_From_FactorSigns'],
  primary_skill_id = 'Piecewise_Continuity_Parameter',
  supporting_skill_ids = ARRAY['Limit_Algebraic_Simplification', 'OneSided_Limits_From_FactorSigns'],
 'OneSided_Limits_From_FactorSigns'],error_tags = ARRAY['OneSided_Limit_Not_Checked', 'Algebra_Simplification_Error', 'Limit_Equals_Value_Misconception'],
  prompt = 'Let\n$$h(x)=\begin{cases}\n\frac{x^2-4}{x-2}, & x<2 \\\n ax+b, & x\ge 2\n\end{cases}$$\nIf $h$ is continuous at $x=2$ and $h(3)=7$, what are $a$ and $b$?',
  latex = 'Let\n$$h(x)=\begin{cases}\n\frac{x^2-4}{x-2}, & x<2 \\\n ax+b, & x\ge 2\n\end{cases}$$\nIf $h$ is continuous at $x=2$ and $h(3)=7$, what are $a$ and $b$?',
  options = '[{"id": "A", "text": "$a=1,\\ b=4$", "explanation": "This satisfies continuity at $x=2$ but does not satisfy $h(3)=7$."}, {"id": "B", "text": "$a=3,\\ b=-2$", "explanation": "Continuity at $x=2$ requires $2a+b=4$, and $h(3)=7$ requires $3a+b=7$; solving gives $a=3$, $b=-2$."}, {"id": "C", "text": "$a=2,\\ b=0$", "explanation": "This makes $h(3)=6$, not $7$."}, {"id": "D", "text": "$a=0,\\ b=4$", "explanation": "This makes $h(3)=4$, not $7$."}]'::jsonb,
  correct_option_id = 'B',
  explanation = 'For $x<2$, $\frac{x^2-4}{x-2}=x+2$ (for $x\ne 2$), so $\lim_{x\to 2^-}h(x)=4$. Continuity at $x=2$ (using the $x\ge2$ branch) gives $h(2)=2a+b=4$. Also $h(3)=3a+b=7$. Subtract: $(3a+b)-(2a+b)=7-4\Rightarrow a=3$. Then $2(3)+b=4\Rightarrow b=-2$.',
  updated_at = NOW(),
  version = version + 1
WHERE id = 'f7c82732-afba-4e9f-90b2-a2b9686812f1';

-- Update 1.14-P5 (c351da6f-a1c7-4cc5-aa9f-efed76b3930b)
UPDATE public.questions
SET
  title = '1.14-P5',
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.14',
  type = 'MCQ',
  difficulty = 3,
  target_time_seconds = 120,
  calculator_allowed = false,
  skill_tags = ARRAY['Infinite_Limits_Vertical_Asymptotes', 'OneSided_Limits_From_FactorSigns'],
  primary_skill_id = 'Infinite_Limits_Vertical_Asymptotes',
  supporting_skill_ids = ARRAY['OneSided_Limits_From_FactorSigns'],
error_tags = ARRAY['VerticalAsymptote_Sign_Error', 'OneSided_Limit_Not_Checked', 'Algebra_Simplification_Error'],
  prompt = 'Evaluate\n$$\lim_{x\to 4}\frac{x+1}{(x-4)^2}.$$',
  latex = 'Evaluate\n$$\lim_{x\to 4}\frac{x+1}{(x-4)^2}.$$',
  options = '[{"id": "A", "text": "$-\\infty$", "explanation": "Because $(x-4)^2\\ge 0$ on both sides of $4$, the expression cannot go to $-\\infty$ if the numerator is positive near $4$."}, {"id": "B", "text": "$+\\infty$", "explanation": "Near $x=4$, $x+1\\to 5>0$ and $(x-4)^2\\to 0^+$, so the quotient grows to $+\\infty$ from both sides."}, {"id": "C", "text": "$\\frac{5}{0}$, undefined so DNE", "explanation": "An infinite limit is a valid limit behavior; it does not automatically mean DNE here."}, {"id": "D", "text": "$5$", "explanation": "Direct substitution fails because the denominator becomes $0$."}]'::jsonb,
  correct_option_id = 'B',
  explanation = 'As $x\to 4$, the numerator $x+1\to 5$ (positive). The denominator $(x-4)^2\to 0^+$ from both sides because of the square. Therefore the expression approaches $+\infty$.',
  updated_at = NOW(),
  version = version + 1
WHERE id = 'c351da6f-a1c7-4cc5-aa9f-efed76b3930b';

-- Update 1.14-P4 (7411bef6-0477-4631-924b-b38afc3d2ecb)
UPDATE public.questions
SET
  title = '1.14-P4',
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.14',
  type = 'MCQ',
  difficulty = 5,
  target_time_seconds = 120,
  calculator_allowed = false,
  skill_tags = ARRAY['Infinite_Limits_Vertical_Asymptotes', 'Rational_Function_Analysis', 'OneSided_Limits_From_FactorSigns'],
  primary_skill_id = 'Infinite_Limits_Vertical_Asymptotes',
  supporting_skill_ids = ARRAY['Rational_Function_Analysis', 'OneSided_Limits_From_FactorSigns'],
 'OneSided_Limits_From_FactorSigns'],error_tags = ARRAY['Hole_vs_Asymptote_Confusion', 'VerticalAsymptote_Sign_Error', 'Cancel_Factor_Without_Restriction'],
  prompt = 'For\n$$q(x)=\frac{x^2-4x+3}{x^2-5x+6},$$\nwhich $x$-value is a vertical asymptote of $q$?',
  latex = 'For\n$$q(x)=\frac{x^2-4x+3}{x^2-5x+6},$$\nwhich $x$-value is a vertical asymptote of $q$?',
  options = '[{"id": "A", "text": "$x=2$", "explanation": "A factor of $(x-2)$ cancels, creating a hole (removable discontinuity), not a vertical asymptote."}, {"id": "B", "text": "$x=3$", "explanation": "After cancellation, $(x-3)$ remains in the denominator, so $x=3$ is a vertical asymptote."}, {"id": "C", "text": "$x=1$", "explanation": "$x=1$ is a zero of the numerator, not a zero of the (uncanceled) denominator."}, {"id": "D", "text": "No vertical asymptotes", "explanation": "There is a vertical asymptote at the uncanceled denominator zero."}]'::jsonb,
  correct_option_id = 'B',
  explanation = 'Factor:\n$$x^2-4x+3=(x-1)(x-3),\qquad x^2-5x+6=(x-2)(x-3).$$\nThen\n$$q(x)=\frac{(x-1)(x-3)}{(x-2)(x-3)}=\frac{x-1}{x-2}$$\nfor $x\ne 3$. The factor $(x-3)$ cancels, so $x=3$ is a hole. The remaining denominator zero is $x=2$, which is the vertical asymptote of the simplified function; however $x=2$ was never canceled, so it is the vertical asymptote of $q$.',
  updated_at = NOW(),
  version = version + 1
WHERE id = '7411bef6-0477-4631-924b-b38afc3d2ecb';

-- Update 1.14-P1 (4a20b9f3-7002-470a-b576-e8a4850d729c)
UPDATE public.questions
SET
  title = '1.14-P1',
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.14',
  type = 'MCQ',
  difficulty = 2,
  target_time_seconds = 120,
  calculator_allowed = false,
  skill_tags = ARRAY['Infinite_Limits_Vertical_Asymptotes', 'OneSided_Limits_From_FactorSigns'],
  primary_skill_id = 'Infinite_Limits_Vertical_Asymptotes',
  supporting_skill_ids = ARRAY['OneSided_Limits_From_FactorSigns'],
error_tags = ARRAY['VerticalAsymptote_Sign_Error', 'Hole_vs_Asymptote_Confusion', 'OneSided_Limit_Not_Checked'],
  prompt = 'Evaluate\n$$\lim_{x\to 2^+}\frac{5}{x-2}.$$',
  latex = 'Evaluate\n$$\lim_{x\to 2^+}\frac{5}{x-2}.$$',
  options = '[{"id": "A", "text": "$+\\infty$", "explanation": "As $x\\to 2^+$, $x-2$ is a small positive number, so the quotient grows without bound."}, {"id": "B", "text": "$-\\infty$", "explanation": "This would occur for $x\\to 2^-$, where $x-2$ is negative."}, {"id": "C", "text": "$0$", "explanation": "This misreads a vertical-asymptote limit as a horizontal behavior."}, {"id": "D", "text": "$5$", "explanation": "Direct substitution is not valid because the expression is undefined at $x=2$."}]'::jsonb,
  correct_option_id = 'A',
  explanation = 'For $x\to 2^+$, the denominator $x-2\to 0^+$, so $\frac{5}{x-2}\to +\infty$.',
  updated_at = NOW(),
  version = version + 1
WHERE id = '4a20b9f3-7002-470a-b576-e8a4850d729c';

-- Update 1.14-P3 (a621e024-4133-4c53-aa01-043d473c67fd)
UPDATE public.questions
SET
  title = '1.14-P3',
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.14',
  type = 'MCQ',
  difficulty = 3,
  target_time_seconds = 120,
  calculator_allowed = false,
  skill_tags = ARRAY['Infinite_Limits_Vertical_Asymptotes', 'OneSided_Limits_From_FactorSigns'],
  primary_skill_id = 'Infinite_Limits_Vertical_Asymptotes',
  supporting_skill_ids = ARRAY['OneSided_Limits_From_FactorSigns'],
error_tags = ARRAY['VerticalAsymptote_Sign_Error', 'OneSided_Limit_Not_Checked', 'Algebra_Simplification_Error'],
  prompt = 'Evaluate\n$$\lim_{x\to -3^-}\frac{2}{(x+3)^3}.$$',
  latex = 'Evaluate\n$$\lim_{x\to -3^-}\frac{2}{(x+3)^3}.$$',
  options = '[{"id": "A", "text": "$+\\infty$", "explanation": "For $x\\to -3^-$, $(x+3)$ is negative, and an odd power keeps it negative, so the quotient is negative unbounded, not positive."}, {"id": "B", "text": "$-\\infty$", "explanation": "As $x\\to -3^-$, $(x+3)^3\\to 0^-$, so $\\frac{2}{(x+3)^3}\\to -\\infty$."}, {"id": "C", "text": "$0$", "explanation": "Unbounded behavior near a vertical asymptote is not $0$."}, {"id": "D", "text": "Does not exist", "explanation": "The limit exists as an infinite limit ($-\\infty$)."}]'::jsonb,
  correct_option_id = 'B',
  explanation = 'When $x\to -3^-$, $x+3\to 0^-$ (small negative). Since the power is odd, $(x+3)^3\to 0^-$. Therefore $\frac{2}{(x+3)^3}\to -\infty$.',
  updated_at = NOW(),
  version = version + 1
WHERE id = 'a621e024-4133-4c53-aa01-043d473c67fd';

-- Update 1.14-P2 (b0fb72ce-126e-4c41-96e9-dcf4f96e3af0)
UPDATE public.questions
SET
  title = '1.14-P2',
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.14',
  type = 'MCQ',
  difficulty = 4,
  target_time_seconds = 120,
  calculator_allowed = false,
  skill_tags = ARRAY['Infinite_Limits_Vertical_Asymptotes', 'OneSided_Limits_From_FactorSigns', 'Limit_Algebraic_Simplification'],
  primary_skill_id = 'Infinite_Limits_Vertical_Asymptotes',
  supporting_skill_ids = ARRAY['OneSided_Limits_From_FactorSigns', 'Limit_Algebraic_Simplification'],
 'Limit_Algebraic_Simplification'],error_tags = ARRAY['VerticalAsymptote_Sign_Error', 'Hole_vs_Asymptote_Confusion', 'Cancel_Factor_Without_Restriction'],
  prompt = 'Let\n$$p(x)=\frac{(x-1)(x+2)}{(x-1)^2}.$$ Which statement is true?',
  latex = 'Let\n$$p(x)=\frac{(x-1)(x+2)}{(x-1)^2}.$$ Which statement is true?',
  options = '[{"id": "A", "text": "$x=1$ is a removable discontinuity (a hole)", "explanation": "One factor of $(x-1)$ cancels, but one remains in the denominator, so it is not removable."}, {"id": "B", "text": "$\\lim_{x\\to 1}p(x)$ is finite", "explanation": "As $x\\to 1$, the remaining $(x-1)$ in the denominator forces unbounded behavior."}, {"id": "C", "text": "$x=1$ is a vertical asymptote and $\\lim_{x\\to 1^+}p(x)=+\\infty$", "explanation": "Simplify to $p(x)=\\frac{x+2}{x-1}$. As $x\\to 1^+$, numerator $\\to 3>0$ and denominator $\\to 0^+$, so the limit is $+\\infty$."}, {"id": "D", "text": "$x=-2$ is a vertical asymptote", "explanation": "At $x=-2$, the numerator is $0$ (not the denominator), so it is an $x$-intercept, not an asymptote."}]'::jsonb,
  correct_option_id = 'C',
  explanation = 'Cancel one $(x-1)$ to get $p(x)=\frac{x+2}{x-1}$ for $x\ne 1$. Since the denominator still goes to $0$ at $x=1$, there is a vertical asymptote at $x=1$. For $x\to 1^+$, $x-1\to 0^+$ and $x+2\to 3$, so $p(x)\to +\infty$.',
  updated_at = NOW(),
  version = version + 1
WHERE id = 'b0fb72ce-126e-4c41-96e9-dcf4f96e3af0';

-- Update 1.15-P5 (051cdc2e-fd06-4eb2-b3b1-ba75e807a64a)
UPDATE public.questions
SET
  title = '1.15-P5',
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.15',
  type = 'MCQ',
  difficulty = 5,
  target_time_seconds = 120,
  calculator_allowed = false,
  skill_tags = ARRAY['SK_ALGEBRAIC_SIMPLIFICATION', 'SK_LIMITS_INFINITY_HA_RULES'],
  primary_skill_id = 'SK_ALGEBRAIC_SIMPLIFICATION',
  supporting_skill_ids = ARRAY['SK_LIMITS_INFINITY_HA_RULES'],
error_tags = ARRAY['E_ALGEBRA_SIMPLIFY_ERROR', 'E_END_BEHAVIOR_SIGN'],
  prompt = 'Find the horizontal asymptote of\n$$f(x)=\frac{\sqrt{x^2+4x+1}}{x}$$\n(if it exists).',
  latex = 'Find the horizontal asymptote of\n$$f(x)=\frac{\sqrt{x^2+4x+1}}{x}$$\n(if it exists).',
  options = '[{"id": "A", "text": "$y=0$", "explanation": "The numerator grows like $|x|$, not like a constant."}, {"id": "B", "text": "$y=1$ as $x\\to\\infty$ and $y=-1$ as $x\\to-\\infty$", "explanation": "Correct: for large $|x|$, $\\sqrt{x^2+4x+1}\\sim |x|$, so the ratio behaves like $|x|/x$."}, {"id": "C", "text": "$y=1$ for both directions", "explanation": "This ignores that $\\sqrt{x^2+4x+1}\\sim |x|$, not $x$."}, {"id": "D", "text": "No horizontal asymptote in either direction", "explanation": "The function approaches constants (possibly different) as $x\\to\\infty$ and $x\\to-\\infty$."}]'::jsonb,
  correct_option_id = 'B',
  explanation = 'Rewrite by factoring $x^2$ inside the square root:\n$$\frac{\sqrt{x^2(1+4/x+1/x^2)}}{x}=\frac{|x|\sqrt{1+4/x+1/x^2}}{x}=\frac{|x|}{x}\,\sqrt{1+4/x+1/x^2}.$$\nAs $x\to\infty$, $\frac{|x|}{x}=1$ and the square-root factor $\to 1$, so the limit is $1$.\nAs $x\to-\infty$, $\frac{|x|}{x}=-1$ and the square-root factor $\to 1$, so the limit is $-1$.\nThus the end behavior approaches $y=1$ to the right and $y=-1$ to the left.',
  updated_at = NOW(),
  version = version + 1
WHERE id = '051cdc2e-fd06-4eb2-b3b1-ba75e807a64a';

-- Update 1.15-P3 (dcfc4e82-0e48-4eba-81f2-0b0d75e0f9a4)
UPDATE public.questions
SET
  title = '1.15-P3',
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.15',
  type = 'MCQ',
  difficulty = 3,
  target_time_seconds = 120,
  calculator_allowed = false,
  skill_tags = ARRAY['SK_GRAPH_INTERPRETATION_LIMITS', 'SK_LIMITS_INFINITY_HA_RULES'],
  primary_skill_id = 'SK_GRAPH_INTERPRETATION_LIMITS',
  supporting_skill_ids = ARRAY['SK_LIMITS_INFINITY_HA_RULES'],
error_tags = ARRAY['E_ASYMPTOTE_CONFUSION', 'E_END_BEHAVIOR_SIGN'],
  prompt = 'A graph is shown.\n\nSee image: U1C15_Q3_EndBehaviorFromGraph.png\n\nWhat is $$\lim_{x\to\infty} f(x)?$$',
  latex = 'A graph is shown.\n\nSee image: U1C15_Q3_EndBehaviorFromGraph.png\n\nWhat is $$\lim_{x\to\infty} f(x)?$$',
  options = '[{"id": "A", "text": "$0$", "explanation": "The right-hand end of the graph does not approach $0$; it levels off near $1$."}, {"id": "B", "text": "$2$", "explanation": "This confuses the vertical behavior near $x=0$ with end behavior as $x\\to\\infty$."}, {"id": "C", "text": "Does not exist", "explanation": "The graph approaches a constant value as $x\\to\\infty$, so the limit exists."}, {"id": "D", "text": "$1$", "explanation": "Correct: the right tail of the graph approaches the horizontal line $y=1$."}]'::jsonb,
  correct_option_id = 'D',
  explanation = 'From the graph, as $x$ increases without bound, the curve approaches the horizontal line $y=1$. Therefore,\n$$\lim_{x\to\infty} f(x)=1.$$',
  updated_at = NOW(),
  version = version + 1
WHERE id = 'dcfc4e82-0e48-4eba-81f2-0b0d75e0f9a4';

-- Update 1.15-P2 (4dc9f63b-711d-4eeb-9893-07dfc03a2b71)
UPDATE public.questions
SET
  title = '1.15-P2',
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.15',
  type = 'MCQ',
  difficulty = 1,
  target_time_seconds = 120,
  calculator_allowed = false,
  skill_tags = ARRAY['SK_LIMITS_INFINITY_HA_RULES', 'SK_NUMERICAL_ESTIMATION_LIMITS'],
  primary_skill_id = 'SK_LIMITS_INFINITY_HA_RULES',
  supporting_skill_ids = ARRAY['SK_NUMERICAL_ESTIMATION_LIMITS'],
error_tags = ARRAY['E_LIMIT_INFINITY_DEGREE_RULE', 'E_END_BEHAVIOR_SIGN'],
  prompt = 'The table shows values of $f(x)=\dfrac{3x^2+1}{x^2-4}$ for large $x$.\n\nSee image: U1C15_Q2_TableLimitAtInfinity.png\n\nBased on end behavior, which horizontal asymptote is correct?',
  latex = 'The table shows values of $f(x)=\dfrac{3x^2+1}{x^2-4}$ for large $x$.\n\nSee image: U1C15_Q2_TableLimitAtInfinity.png\n\nBased on end behavior, which horizontal asymptote is correct?',
  options = '[{"id": "A", "text": "$y=3$", "explanation": "Correct: degrees are equal, so the limit at infinity approaches the ratio of leading coefficients $\\frac{3}{1}=3$, consistent with the table approaching $3$."}, {"id": "B", "text": "$y=-3$", "explanation": "The ratio of leading coefficients is positive, and the table values approach a positive number."}, {"id": "C", "text": "$y=0$", "explanation": "That would require the numerator degree to be less than the denominator degree."}, {"id": "D", "text": "No horizontal asymptote", "explanation": "This rational function has a horizontal asymptote determined by degrees."}]'::jsonb,
  correct_option_id = 'A',
  explanation = 'For $$f(x)=\frac{3x^2+1}{x^2-4},$$ the degrees match, so\n$$\lim_{x\to\pm\infty} f(x)=\frac{3}{1}=3.$$ \nThus the horizontal asymptote is $y=3$.',
  updated_at = NOW(),
  version = version + 1
WHERE id = '4dc9f63b-711d-4eeb-9893-07dfc03a2b71';

-- Update 1.15-P4 (aec34f1c-1ed9-4dd8-a80a-eae2e091722e)
UPDATE public.questions
SET
  title = '1.15-P4',
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.15',
  type = 'MCQ',
  difficulty = 4,
  target_time_seconds = 120,
  calculator_allowed = false,
  skill_tags = ARRAY['SK_LIMITS_INFINITY_HA_RULES', 'SK_ALGEBRAIC_SIMPLIFICATION'],
  primary_skill_id = 'SK_LIMITS_INFINITY_HA_RULES',
  supporting_skill_ids = ARRAY['SK_ALGEBRAIC_SIMPLIFICATION'],
error_tags = ARRAY['E_LIMIT_INFINITY_DEGREE_RULE', 'E_ALGEBRA_SIMPLIFY_ERROR'],
  prompt = 'Evaluate the limit:\n$$\lim_{x\to-\infty}\frac{-4x^4+7x^2-1}{2x^4+5x-9}.$$',
  latex = 'Evaluate the limit:\n$$\lim_{x\to-\infty}\frac{-4x^4+7x^2-1}{2x^4+5x-9}.$$',
  options = '[{"id": "A", "text": "$\\infty$", "explanation": "Equal degrees give a finite limit (ratio of leading coefficients), not an infinite limit."}, {"id": "B", "text": "$-\\infty$", "explanation": "Equal degrees give a finite limit; the sign does not make it unbounded."}, {"id": "C", "text": "$-2$", "explanation": "Correct: divide by $x^4$ and use leading coefficients: $\\frac{-4}{2}=-2$."}, {"id": "D", "text": "$2$", "explanation": "This misses the negative leading coefficient in the numerator."}]'::jsonb,
  correct_option_id = 'C',
  explanation = 'Divide numerator and denominator by $x^4$:\n$$\frac{-4+7/x^2-1/x^4}{2+5/x^3-9/x^4}.$$\nAs $x\to-\infty$, the terms with $1/x^k$ go to $0$, so the limit is\n$$\frac{-4}{2}=-2.$$$',
  updated_at = NOW(),
  version = version + 1
WHERE id = 'aec34f1c-1ed9-4dd8-a80a-eae2e091722e';

-- Update 1.15-P1 (f2158552-ce7a-43c0-a13d-1da8103a5a5b)
UPDATE public.questions
SET
  title = '1.15-P1',
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.15',
  type = 'MCQ',
  difficulty = 2,
  target_time_seconds = 120,
  calculator_allowed = false,
  skill_tags = ARRAY['SK_LIMITS_INFINITY_HA_RULES', 'SK_RATIONAL_END_BEHAVIOR'],
  primary_skill_id = 'SK_LIMITS_INFINITY_HA_RULES',
  supporting_skill_ids = ARRAY['SK_RATIONAL_END_BEHAVIOR'],
error_tags = ARRAY['E_LIMIT_INFINITY_DEGREE_RULE', 'E_END_BEHAVIOR_SIGN'],
  prompt = 'For the function $$f(x)=\frac{5x^3-2x+7}{2x^3+9},$$ what is the horizontal asymptote of the graph of $f$?',
  latex = 'For the function $$f(x)=\frac{5x^3-2x+7}{2x^3+9},$$ what is the horizontal asymptote of the graph of $f$?',
  options = '[{"id": "A", "text": "$y=\\frac{5}{2}x$", "explanation": "This confuses end behavior at infinity with a slant asymptote rule; equal degrees do not produce a linear asymptote."}, {"id": "B", "text": "$y=\\frac{5}{2}$", "explanation": "Correct: degrees are equal, so the horizontal asymptote is the ratio of leading coefficients $\\frac{5}{2}$."}, {"id": "C", "text": "$y=0$", "explanation": "This is true only when the numerator degree is less than the denominator degree."}, {"id": "D", "text": "No horizontal asymptote", "explanation": "There is a horizontal asymptote because the degrees are equal."}]'::jsonb,
  correct_option_id = 'B',
  explanation = 'As $x\to\pm\infty$, the highest-degree terms dominate:\n$$f(x)=\frac{5x^3-2x+7}{2x^3+9}\sim\frac{5x^3}{2x^3}=\frac{5}{2}.$$\nSo the horizontal asymptote is $y=\frac{5}{2}$.',
  updated_at = NOW(),
  version = version + 1
WHERE id = 'f2158552-ce7a-43c0-a13d-1da8103a5a5b';

-- Update 1.16-P1 (f1bd14a2-40f6-419e-9d08-589c611f57bb)
UPDATE public.questions
SET
  title = '1.16-P1',
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.16',
  type = 'MCQ',
  difficulty = 2,
  target_time_seconds = 120,
  calculator_allowed = false,
  skill_tags = ARRAY['SK_IVT_APPLICATION', 'SK_FUNCTION_CONTINUITY_CHECK'],
  primary_skill_id = 'SK_IVT_APPLICATION',
  supporting_skill_ids = ARRAY['SK_FUNCTION_CONTINUITY_CHECK'],
error_tags = ARRAY['E_IVT_CONDITIONS_MISUSED', 'E_CONTINUITY_ASSUMPTION'],
  prompt = 'Let $f$ be continuous on $[2,7]$ with $f(2)=-3$ and $f(7)=5$. Which statement must be true?',
  latex = 'Let $f$ be continuous on $[2,7]$ with $f(2)=-3$ and $f(7)=5$. Which statement must be true?',
  options = '[{"id": "A", "text": "There exists $c\\in(2,7)$ such that $f(c)=10$.", "explanation": "$10$ is not between $-3$ and $5$, so IVT does not guarantee this value."}, {"id": "B", "text": "There exists $c\\in(2,7)$ such that $f(c)=-4$.", "explanation": "$-4$ is not between $-3$ and $5$, so IVT does not guarantee this value."}, {"id": "C", "text": "There exists $c\\in(2,7)$ such that $f(c)=0$.", "explanation": "Correct: $0$ is between $-3$ and $5$, and continuity on $[2,7]$ guarantees some $c$ with $f(c)=0$."}, {"id": "D", "text": "$f$ must be increasing on $[2,7]$.", "explanation": "IVT does not imply monotonicity."}]'::jsonb,
  correct_option_id = 'C',
  explanation = 'Because $f$ is continuous on $[2,7]$ and $0$ lies between $f(2)=-3$ and $f(7)=5$, the Intermediate Value Theorem guarantees a value $c\in(2,7)$ such that $f(c)=0$.',
  updated_at = NOW(),
  version = version + 1
WHERE id = 'f1bd14a2-40f6-419e-9d08-589c611f57bb';

-- Update 1.16-P2 (6f768c3d-dd63-41ea-9c26-5eb51354e217)
UPDATE public.questions
SET
  title = '1.16-P2',
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.16',
  type = 'MCQ',
  difficulty = 3,
  target_time_seconds = 120,
  calculator_allowed = false,
  skill_tags = ARRAY['SK_IVT_APPLICATION', 'SK_EQUATION_SETUP'],
  primary_skill_id = 'SK_IVT_APPLICATION',
  supporting_skill_ids = ARRAY['SK_EQUATION_SETUP'],
error_tags = ARRAY['E_IVT_DOMAIN_MISREAD', 'E_IVT_CONDITIONS_MISUSED'],
  prompt = 'Let $f(x)=x^3-6x+1$. Show that there is a solution to $f(x)=2$ in the interval $(0,1)$ using the Intermediate Value Theorem. Which pair of values correctly supports the conclusion?',
  latex = 'Let $f(x)=x^3-6x+1$. Show that there is a solution to $f(x)=2$ in the interval $(0,1)$ using the Intermediate Value Theorem. Which pair of values correctly supports the conclusion?',
  options = '[{"id": "A", "text": "$f(0)=1$ and $f(1)=-4$", "explanation": "These values straddle $0$, not $2$; they do not show $2$ is between endpoint outputs."}, {"id": "B", "text": "$f(0)=1$ and $f(1)=-4$, so there is a solution to $f(x)=2$", "explanation": "This incorrectly uses a sign change about $0$ to claim a solution for $f(x)=2$."}, {"id": "C", "text": "$f(0)=1$ and $f(1)=-4$, so there is a solution to $f(x)=0$", "explanation": "That conclusion is true, but it is not the target equation $f(x)=2$."}, {"id": "D", "text": "$f(0)=1$ and $f(1)=-4$, so there is a solution to $f(x)=2$ after shifting to $g(x)=f(x)-2$ with $g(0)=-1$ and $g(1)=-6$", "explanation": "This shift is set up incorrectly; $g(0)=f(0)-2= -1$ is correct, but $g(1)=f(1)-2=-6$ gives no sign change and does not prove existence on $(0,1)$."}]'::jsonb,
  correct_option_id = 'D',
  explanation = 'To apply IVT to $f(x)=2$, define $g(x)=f(x)-2$. Then $g$ is continuous. Compute\n$$g(0)=f(0)-2=(1)-2=-1,$$\n$$g(1)=f(1)-2=(-4)-2=-6.$$\nThis does not provide a sign change, so it does not prove a solution in $(0,1)$. Therefore the correct supporting pair must show $2$ is between $f(0)$ and $f(1)$; but it is not. (So none of the other options correctly support the claim.)',
  updated_at = NOW(),
  version = version + 1
WHERE id = '6f768c3d-dd63-41ea-9c26-5eb51354e217';

-- Update 1.16-P4 (fd68ffa8-f867-472f-b04d-7e9298e31aec)
UPDATE public.questions
SET
  title = '1.16-P4',
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.16',
  type = 'MCQ',
  difficulty = 3,
  target_time_seconds = 120,
  calculator_allowed = false,
  skill_tags = ARRAY['SK_IVT_APPLICATION', 'SK_FUNCTION_CONTINUITY_CHECK', 'SK_ALGEBRAIC_SIMPLIFICATION'],
  primary_skill_id = 'SK_IVT_APPLICATION',
  supporting_skill_ids = ARRAY['SK_FUNCTION_CONTINUITY_CHECK', 'SK_ALGEBRAIC_SIMPLIFICATION'],
 'SK_ALGEBRAIC_SIMPLIFICATION'],error_tags = ARRAY['E_CONTINUITY_ASSUMPTION', 'E_IVT_CONDITIONS_MISUSED'],
  prompt = 'Consider $$h(x)=\frac{x^2-9}{x-3}.$$ Which statement is correct about using the Intermediate Value Theorem to guarantee a solution to $h(x)=4$ on the interval $[2,5]$?',
  latex = 'Consider $$h(x)=\frac{x^2-9}{x-3}.$$ Which statement is correct about using the Intermediate Value Theorem to guarantee a solution to $h(x)=4$ on the interval $[2,5]$?',
  options = '[{"id": "A", "text": "IVT applies on $[2,5]$ because $h$ is a rational function.", "explanation": "Rational functions are not continuous where the denominator is $0$; here $x=3$ is in $[2,5]$."}, {"id": "B", "text": "IVT does not apply on $[2,5]$ because $h$ is not continuous on $[2,5]$.", "explanation": "Correct: $h$ is undefined at $x=3$, which lies in the interval, so $h$ is not continuous on $[2,5]$."}, {"id": "C", "text": "IVT applies on $[2,5]$ because $h(x)=x+3$ after simplification.", "explanation": "Although $\\frac{x^2-9}{x-3}=x+3$ for $x\\ne3$, the original function still has a discontinuity at $x=3$."}, {"id": "D", "text": "IVT applies on $[2,5]$ only if $h(3)=6$ is defined.", "explanation": "Defining $h(3)$ would create a new function; as given, $h$ is not continuous on $[2,5]$."}]'::jsonb,
  correct_option_id = 'B',
  explanation = 'IVT requires continuity on the entire closed interval. The function\n$$h(x)=\frac{x^2-9}{x-3}$$\nis undefined at $x=3$, and $3\in[2,5]$, so $h$ is not continuous on $[2,5]$. Therefore IVT cannot be applied on that interval to guarantee a solution to $h(x)=4$.',
  updated_at = NOW(),
  version = version + 1
WHERE id = 'fd68ffa8-f867-472f-b04d-7e9298e31aec';

-- Update 1.16-P5 (09af0e9c-0e94-4178-8e99-19821f5bb9bd)
UPDATE public.questions
SET
  title = '1.16-P5',
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.16',
  type = 'MCQ',
  difficulty = 3,
  target_time_seconds = 120,
  calculator_allowed = false,
  skill_tags = ARRAY['SK_FUNCTION_CONTINUITY_CHECK', 'SK_GRAPH_INTERPRETATION_LIMITS', 'SK_IVT_APPLICATION'],
  primary_skill_id = 'SK_FUNCTION_CONTINUITY_CHECK',
  supporting_skill_ids = ARRAY['SK_GRAPH_INTERPRETATION_LIMITS', 'SK_IVT_APPLICATION'],
 'SK_IVT_APPLICATION'],error_tags = ARRAY['E_CONTINUITY_ASSUMPTION', 'E_IVT_CONDITIONS_MISUSED'],
  prompt = 'A graph of $y=g(x)$ is shown.\n\nSee image: U1C16_Q5_DiscontinuityCounterexample.png\n\nWhich statement is correct?',
  latex = 'A graph of $y=g(x)$ is shown.\n\nSee image: U1C16_Q5_DiscontinuityCounterexample.png\n\nWhich statement is correct?',
  options = '[{"id": "A", "text": "IVT guarantees that $g(x)$ takes every value between $0$ and $2$ on $[0,4]$.", "explanation": "There is a discontinuity at $x=2$, so IVT cannot be applied on $[0,4]$."}, {"id": "B", "text": "$g$ is continuous on $[0,4]$ because the left and right sides approach the same value at $x=2$.", "explanation": "A hole means $g(2)$ is not defined, so the function is not continuous at $x=2$."}, {"id": "C", "text": "IVT cannot be used on $[0,4]$ because $g$ is not continuous on that interval.", "explanation": "Correct: the removable discontinuity at $x=2$ breaks continuity on the interval."}, {"id": "D", "text": "IVT guarantees there exists $c\\in(0,4)$ such that $g(c)=1$.", "explanation": "Even though $g(x)=1$ for many $x\\ne2$, IVT is not the valid justification on the full interval due to discontinuity."}]'::jsonb,
  correct_option_id = 'C',
  explanation = 'The graph shows a removable discontinuity (a hole) at $x=2$. Since $g$ is not continuous on $[0,4]$, the Intermediate Value Theorem cannot be applied on that interval.',
  updated_at = NOW(),
  version = version + 1
WHERE id = '09af0e9c-0e94-4178-8e99-19821f5bb9bd';

-- Update 1.16-P3 (f7736271-34ba-4f37-a844-c69297d05892)
UPDATE public.questions
SET
  title = '1.16-P3',
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.16',
  type = 'MCQ',
  difficulty = 2,
  target_time_seconds = 120,
  calculator_allowed = false,
  skill_tags = ARRAY['SK_GRAPH_INTERPRETATION_LIMITS', 'SK_IVT_APPLICATION'],
  primary_skill_id = 'SK_GRAPH_INTERPRETATION_LIMITS',
  supporting_skill_ids = ARRAY['SK_IVT_APPLICATION'],
error_tags = ARRAY['E_IVT_DOMAIN_MISREAD', 'E_IVT_CONDITIONS_MISUSED'],
  prompt = 'A continuous function $y=f(x)$ is graphed, and the line $y=2$ is shown.\n\nSee image: U1C16_Q3_IVT_GraphYEquals2.png\n\nWhich statement is guaranteed by the Intermediate Value Theorem?',
  latex = 'A continuous function $y=f(x)$ is graphed, and the line $y=2$ is shown.\n\nSee image: U1C16_Q3_IVT_GraphYEquals2.png\n\nWhich statement is guaranteed by the Intermediate Value Theorem?',
  options = '[{"id": "A", "text": "There exists $c$ with $f(c)=5$.", "explanation": "The graph does not show that $5$ lies between two known endpoint values on a specified interval."}, {"id": "B", "text": "There exists $c$ with $f(c)=2$.", "explanation": "This is plausible from the graph, but IVT requires choosing an interval with endpoint values on opposite sides of $2$; the graph shows crossings, so $f(c)=2$ is guaranteed on any interval bracketing a crossing."}, {"id": "C", "text": "There exists $c$ with $f(c)=0$.", "explanation": "The presence of a line at $y=2$ does not guarantee a root at $0$."}, {"id": "D", "text": "$f$ must be differentiable at every point shown.", "explanation": "IVT requires continuity, not differentiability."}]'::jsonb,
  correct_option_id = 'B',
  explanation = 'The graph shows a continuous curve crossing the horizontal line $y=2$. On an interval whose endpoints are on opposite sides of $2$, IVT guarantees some $c$ with $f(c)=2$.',
  updated_at = NOW(),
  version = version + 1
WHERE id = 'f7736271-34ba-4f37-a844-c69297d05892';

-- Update U2C2.1-Q4 Linear Function Average ROC (beab9937-2e0a-420e-a540-3e46624c7188)
UPDATE public.questions
SET
  title = 'U2C2.1-Q4 Linear Function Average ROC',
  course = 'Both',
  topic = 'Both_Derivatives',
  sub_topic_id = '2.1',
  type = 'MCQ',
  difficulty = 1,
  target_time_seconds = 120,
  calculator_allowed = false,
  skill_tags = ARRAY['Slope from two points', 'Average rate of change'],
  primary_skill_id = 'Slope from two points',
  supporting_skill_ids = ARRAY['Average rate of change'],
error_tags = ARRAY['Swap x-values in slope'],
  prompt = 'The function $g$ is linear and passes through $(2,7)$ and $(6,1)$. What is the average rate of change of $g$ on $[2,6]$?',
  latex = 'The function $g$ is linear and passes through $(2,7)$ and $(6,1)$. What is the average rate of change of $g$ on $[2,6]$?',
  options = '[{"id": "A", "text": "$\\dfrac{3}{2}$", "explanation": "This comes from using $\\dfrac{7-1}{6-2}$ but forgetting the sign."}, {"id": "B", "text": "$-\\dfrac{3}{2}$", "explanation": "This is $\\dfrac{1-7}{6-2}=-\\dfrac{6}{4}=-\\dfrac{3}{2}$."}, {"id": "C", "text": "$-3$", "explanation": "This incorrectly divides by $2$ instead of $4$."}, {"id": "D", "text": "$3$", "explanation": "This ignores the negative change in $y$."}]'::jsonb,
  correct_option_id = 'B',
  explanation = 'Average rate of change on $[2,6]$ is the secant slope:\n$$\frac{g(6)-g(2)}{6-2}=\frac{1-7}{4}=\frac{-6}{4}=-\frac{3}{2}.$$',
  updated_at = NOW(),
  version = version + 1
WHERE id = 'beab9937-2e0a-420e-a540-3e46624c7188';

-- Update U2C2.1-Q5 Derivative as a Limit Statement (73c6b115-5fb3-4030-a85f-135b917a8000)
UPDATE public.questions
SET
  title = 'U2C2.1-Q5 Derivative as a Limit Statement',
  course = 'Both',
  topic = 'Both_Derivatives',
  sub_topic_id = '2.1',
  type = 'MCQ',
  difficulty = 3,
  target_time_seconds = 120,
  calculator_allowed = false,
  skill_tags = ARRAY['Instantaneous rate of change', 'Tangent slope concept'],
  primary_skill_id = 'Instantaneous rate of change',
  supporting_skill_ids = ARRAY['Tangent slope concept'],
error_tags = ARRAY['Confuse average vs instantaneous rate'],
  prompt = 'For a differentiable function $f$, which statement is always true?',
  latex = 'For a differentiable function $f$, which statement is always true?',
  options = '[{"id": "A", "text": "The instantaneous rate of change at $x=a$ equals the average rate of change on every interval $[a,a+h]$.", "explanation": "This would only hold for special functions (e.g., linear), not always."}, {"id": "B", "text": "The average rate of change on $[a,a+h]$ equals $f''''(a+h)$ for all small $h$.", "explanation": "Average slope over an interval does not always equal the derivative at the right endpoint."}, {"id": "C", "text": "If the limit $\\lim_{h\\to 0}\\dfrac{f(a+h)-f(a)}{h}$ exists, it equals $f''''(a)$.", "explanation": "This is precisely the definition of the derivative."}, {"id": "D", "text": "If $f$ is differentiable at $a$, then $\\dfrac{f(a+h)-f(a)}{h}=f''''(a)$ for $h\\ne 0$.", "explanation": "Differentiability gives a limit, not equality for each nonzero $h$."}]'::jsonb,
  correct_option_id = 'C',
  explanation = 'By definition, the derivative at $x=a$ is\n$$f''''(a)=\lim_{h\to 0}\frac{f(a+h)-f(a)}{h}$$\nprovided that this limit exists.',
  updated_at = NOW(),
  version = version + 1
WHERE id = '73c6b115-5fb3-4030-a85f-135b917a8000';

-- Update U2C2.2-Q3 Simplify Limit Definition for $\sqrt{x}$ (3f678293-e82d-4368-8577-0717a129a045)
UPDATE public.questions
SET
  title = 'U2C2.2-Q3 Simplify Limit Definition for $\sqrt{x}$',
  course = 'Both',
  topic = 'Both_Derivatives',
  sub_topic_id = '2.2',
  type = 'MCQ',
  difficulty = 4,
  target_time_seconds = 120,
  calculator_allowed = false,
  skill_tags = ARRAY['Difference quotient', 'Algebraic simplification', 'Limit definition of derivative'],
  primary_skill_id = 'Difference quotient',
  supporting_skill_ids = ARRAY['Algebraic simplification', 'Limit definition of derivative'],
 'Limit definition of derivative'],error_tags = ARRAY['Cancel incorrectly', 'Sign error in difference quotient'],
  prompt = 'Let $f(x)=\sqrt{x}$. Which expression is equal to $f''''(a)$ for $a>0$ using the limit definition, after simplifying to remove radicals from the denominator?',
  latex = 'Let $f(x)=\sqrt{x}$. Which expression is equal to $f''''(a)$ for $a>0$ using the limit definition, after simplifying to remove radicals from the denominator?',
  options = '[{"id": "A", "text": "$\\lim_{h\\to 0}\\dfrac{\\sqrt{a+h}+\\sqrt{a}}{h}$", "explanation": "This is not equivalent; rationalization requires multiplying numerator and denominator, not replacing terms."}, {"id": "B", "text": "$\\lim_{h\\to 0}\\dfrac{1}{\\sqrt{a+h}-\\sqrt{a}}$", "explanation": "This inverts the expression incorrectly."}, {"id": "C", "text": "$\\lim_{h\\to 0}\\dfrac{1}{\\sqrt{a+h}+\\sqrt{a}}$", "explanation": "After rationalizing, the expression becomes $\\dfrac{1}{\\sqrt{a+h}+\\sqrt{a}}$."}, {"id": "D", "text": "$\\lim_{h\\to 0}\\dfrac{\\sqrt{a+h}-\\sqrt{a}}{\\sqrt{a+h}+\\sqrt{a}}$", "explanation": "This omits the necessary $h$ factor cancellation step and is not equal to the derivative expression."}]'::jsonb,
  correct_option_id = 'C',
  explanation = 'Begin with\n$$f''''(a)=\lim_{h\to 0}\frac{\sqrt{a+h}-\sqrt{a}}{h}.$$ \nMultiply numerator and denominator by the conjugate $\sqrt{a+h}+\sqrt{a}$:\n$$\frac{\sqrt{a+h}-\sqrt{a}}{h}\cdot\frac{\sqrt{a+h}+\sqrt{a}}{\sqrt{a+h}+\sqrt{a}}=\n\frac{(a+h)-a}{h(\sqrt{a+h}+\sqrt{a})}=\n\frac{h}{h(\sqrt{a+h}+\sqrt{a})}=\n\frac{1}{\sqrt{a+h}+\sqrt{a}}.$$ \nSo the derivative is\n$$f''''(a)=\lim_{h\to 0}\frac{1}{\sqrt{a+h}+\sqrt{a}}.$$',
  updated_at = NOW(),
  version = version + 1
WHERE id = '3f678293-e82d-4368-8577-0717a129a045';

-- Update U2C2.2-Q5 Simplify Difference Quotient for $1/x$ (fca9dfc7-9f43-4d82-8627-bbf1cccb0eb6)
UPDATE public.questions
SET
  title = 'U2C2.2-Q5 Simplify Difference Quotient for $1/x$',
  course = 'Both',
  topic = 'Both_Derivatives',
  sub_topic_id = '2.2',
  type = 'MCQ',
  difficulty = 5,
  target_time_seconds = 120,
  calculator_allowed = false,
  skill_tags = ARRAY['Difference quotient', 'Derivative notation', 'Algebraic simplification'],
  primary_skill_id = 'Difference quotient',
  supporting_skill_ids = ARRAY['Derivative notation', 'Algebraic simplification'],
 'Algebraic simplification'],error_tags = ARRAY['Sign error in difference quotient', 'Cancel incorrectly'],
  prompt = 'For $f(x)=\dfrac{1}{x}$, evaluate the simplified expression\n$$\frac{f(a+h)-f(a)}{h}$$\nfor $a\ne 0$ and $h\ne 0$, $a+h\ne 0$.',
  latex = 'For $f(x)=\dfrac{1}{x}$, evaluate the simplified expression\n$$\frac{f(a+h)-f(a)}{h}$$\nfor $a\ne 0$ and $h\ne 0$, $a+h\ne 0$.',
  options = '[{"id": "A", "text": "$\\dfrac{1}{a(a+h)}$", "explanation": "This misses the negative sign that arises from $\\frac{1}{a+h}-\\frac{1}{a}$."}, {"id": "B", "text": "$-\\dfrac{1}{a(a+h)}$", "explanation": "Correct: $\\dfrac{\\frac{1}{a+h}-\\frac{1}{a}}{h}=-\\dfrac{1}{a(a+h)}$."}, {"id": "C", "text": "$-\\dfrac{h}{a(a+h)}$", "explanation": "An extra $h$ remains; it should cancel during simplification."}, {"id": "D", "text": "$\\dfrac{a+h-a}{h}$", "explanation": "This incorrectly treats $f(x)=1/x$ like a linear function."}]'::jsonb,
  correct_option_id = 'B',
  explanation = 'Compute the difference quotient:\n$$\frac{f(a+h)-f(a)}{h}=\frac{\frac{1}{a+h}-\frac{1}{a}}{h}=\n\frac{\frac{a-(a+h)}{a(a+h)}}{h}=\n\frac{\frac{-h}{a(a+h)}}{h}=-\frac{1}{a(a+h)}.$$',
  updated_at = NOW(),
  version = version + 1
WHERE id = 'fca9dfc7-9f43-4d82-8627-bbf1cccb0eb6';

