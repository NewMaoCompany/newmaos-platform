-- ============================================================
-- Fix Unit 10.1 & 10.2 Questions — options key fix + escaping fix
-- 1) options 中 "text" → "value" (匹配前端字段名)
-- 2) 所有含 LaTeX 的字段使用 dollar-quoted 字符串
-- ============================================================

-- ==================== 10.1-P1 ====================
UPDATE public.questions
SET
  options = $json$[
    {"id":"A","value":"The sequence $\\{a_n\\}$ has a finite limit.","explanation":"A limit for $a_n$ concerns the terms, not the partial sums; it is not the definition of series convergence."},
    {"id":"B","value":"The sequence $\\{S_k\\}$ approaches a finite limit as $k\\to\\infty$.","explanation":"Correct: convergence of the series is convergence of $S_k$ to a finite value."},
    {"id":"C","value":"The sequence $\\{S_k\\}$ is increasing and bounded above.","explanation":"Increasing and bounded implies convergence, but a convergent series need not have increasing partial sums."},
    {"id":"D","value":"The terms $a_n$ eventually become negative.","explanation":"Sign of terms does not define convergence."}
  ]$json$::jsonb,
  version = version + 1,
  updated_at = NOW()
WHERE title = '10.1-P1';

-- ==================== 10.1-P2 ====================
UPDATE public.questions
SET
  options = $json$[
    {"id":"A","value":"$1-\\frac{1}{k}$","explanation":"Index error: the last remaining term is $\\frac{1}{k+1}$, not $\\frac{1}{k}$."},
    {"id":"B","value":"$\\frac{1}{k+1}$","explanation":"This is only the final leftover term, not the whole partial sum."},
    {"id":"C","value":"$1-\\frac{1}{k+1}$","explanation":"Correct telescoping result."},
    {"id":"D","value":"$\\frac{k}{k+1}$","explanation":"This is equivalent to $1-\\frac{1}{k+1}$, but the prompt targets the telescoping form directly."}
  ]$json$::jsonb,
  version = version + 1,
  updated_at = NOW()
WHERE title = '10.1-P2';

-- ==================== 10.1-P3 ====================
UPDATE public.questions
SET
  options = $json$[
    {"id":"A","value":"$\\sum_{n=1}^{\\infty} \\frac{1}{n^2}$","explanation":"This is an infinite series written in sigma notation."},
    {"id":"B","value":"$\\left\\{\\sum_{n=1}^{k} \\frac{1}{n^2}\\right\\}_{k=1}^{\\infty}$","explanation":"Correct: the braces indicate a sequence indexed by $k$ (the partial sums)."},
    {"id":"C","value":"$\\frac{1}{1^2}+\\frac{1}{2^2}+\\frac{1}{3^2}+\\cdots$","explanation":"This is an infinite series written with ellipses."},
    {"id":"D","value":"$\\sum_{n=1}^{50} \\frac{1}{n^2}$","explanation":"This is a finite sum (a single number after summing), not a sequence."}
  ]$json$::jsonb,
  version = version + 1,
  updated_at = NOW()
WHERE title = '10.1-P3';

-- ==================== 10.1-P4 ====================
UPDATE public.questions
SET
  options = $json$[
    {"id":"A","value":"$1$","explanation":"Confuses the limit with the coefficient of $\\frac{2}{k}$ or a term value."},
    {"id":"B","value":"$3$","explanation":"Correct: $\\lim_{k\\to\\infty} S_k=3$."},
    {"id":"C","value":"$2$","explanation":"Uses the numerator $2$ incorrectly as the sum."},
    {"id":"D","value":"The series diverges.","explanation":"A finite limit for $S_k$ means the series converges."}
  ]$json$::jsonb,
  version = version + 1,
  updated_at = NOW()
WHERE title = '10.1-P4';

-- ==================== 10.1-P5 ====================
UPDATE public.questions
SET
  options = $json$[
    {"id":"A","value":"$\\{S_k\\}$ is increasing.","explanation":"Correct: bounded and increasing implies $S_k$ converges."},
    {"id":"B","value":"$\\{a_n\\}$ is increasing.","explanation":"Monotonicity of terms $a_n$ does not ensure the partial sums converge."},
    {"id":"C","value":"$a_n>0$ for all $n$.","explanation":"Positive terms alone do not force convergence; partial sums could grow without bound."},
    {"id":"D","value":"$S_k\\ne 0$ for all $k$.","explanation":"Nonzero partial sums is irrelevant to convergence."}
  ]$json$::jsonb,
  version = version + 1,
  updated_at = NOW()
WHERE title = '10.1-P5';


-- ============================================================
-- Unit 10.2 (Working with Geometric Series) — Practice 1–5
-- 所有包含 LaTeX 的字段全部使用 dollar-quoted 字符串
-- ============================================================

-- ==================== 10.2-P1 ====================
UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Series',
  sub_topic_id = '10.2',
  section_id = '10.2',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 80,
  skill_tags = ARRAY['SK_GEOM_CONVERGENCE_CONDITION','SK_GEOM_IDENTIFY_RATIO'],
  error_tags = ARRAY['E_GEOM_RATIO_WRONG','E_GEOM_CONVERGENCE_MISAPPLY'],
  prompt = $prm$Consider the series $\sum_{n=0}^{\infty} 6\left(-\frac{1}{3}\right)^n$. Which statement is true?$prm$,
  latex = $ltx$This is geometric with ratio $r=-\frac{1}{3}$. A geometric series converges when $|r|<1$, so it converges.$ltx$,
  options = $json$[
    {"id":"A","value":"It converges because $\\left|-\\frac{1}{3}\\right|<1$.","explanation":"Correct: $|r|<1$ guarantees convergence for a geometric series."},
    {"id":"B","value":"It diverges because the terms alternate in sign.","explanation":"Alternating signs do not prevent convergence for geometric series."},
    {"id":"C","value":"It diverges because $r$ is negative.","explanation":"Negative ratio is allowed; magnitude controls convergence."},
    {"id":"D","value":"It converges only if $r>0$.","explanation":"There is no requirement that $r$ be positive."}
  ]$json$::jsonb,
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = $exp$The series is geometric with ratio $r=-\frac{1}{3}$. Since $|r|<1$, the series converges.$exp$,
  recommendation_reasons = ARRAY['Checks the core convergence criterion for geometric series.','Targets sign-based misconceptions about ratios.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = $nte$Convergence depends on $|r|$, not the sign of $r$.$nte$,
  weight_primary = 0.60,
  weight_supporting = 0.40,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Series',
  updated_at = NOW()
WHERE title = '10.2-P1';

-- ==================== 10.2-P2 ====================
UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Series',
  sub_topic_id = '10.2',
  section_id = '10.2',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 120,
  skill_tags = ARRAY['SK_GEOM_SUM_INFINITE','SK_GEOM_IDENTIFY_A_AND_R'],
  error_tags = ARRAY['E_GEOM_SUM_FORMULA_MISUSE','E_GEOM_RATIO_WRONG'],
  prompt = $prm$Find the sum of the infinite geometric series $$5-\frac{5}{2}+\frac{5}{4}-\frac{5}{8}+\cdots.$$$$prm$,
  latex = $ltx$First term $a=5$, ratio $r=-\frac{1}{2}$. Since $|r|<1$, the sum is $S=\frac{a}{1-r}=\frac{5}{1-(-1/2)}=\frac{10}{3}$.$ltx$,
  options = $json$[
    {"id":"A","value":"$\\frac{5}{3}$","explanation":"Often comes from using $1+r$ instead of $1-r$ in the denominator."},
    {"id":"B","value":"$\\frac{10}{3}$","explanation":"Correct: $S=\\frac{5}{1-(-1/2)}=\\frac{10}{3}$."},
    {"id":"C","value":"$\\frac{15}{2}$","explanation":"This can result from summing only the first few terms, not the infinite sum."},
    {"id":"D","value":"$\\frac{10}{7}$","explanation":"Uses an incorrect formula such as $1-r^2$ in the denominator."}
  ]$json$::jsonb,
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = $exp$Identify $a=5$ and $r=-\frac{1}{2}$. The infinite geometric sum is $S=\frac{a}{1-r}=\frac{10}{3}$.$exp$,
  recommendation_reasons = ARRAY['Practices identifying $a$ and $r$ from a written series.','Reinforces the infinite geometric sum formula with negative ratio.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.10,
  source = 'NewMaoS',
  source_year = 2026,
  notes = $nte$Denominator is $1-r$ even when $r<0$.$nte$,
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Series',
  updated_at = NOW()
WHERE title = '10.2-P2';

-- ==================== 10.2-P3 ====================
UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Series',
  sub_topic_id = '10.2',
  section_id = '10.2',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 150,
  skill_tags = ARRAY['SK_REPEAT_DECIMAL_GEOM_MODEL','SK_GEOM_SUM_INFINITE'],
  error_tags = ARRAY['E_PLACE_VALUE_ERROR','E_GEOM_SUM_FORMULA_MISUSE'],
  prompt = $prm$Write $0.\overline{27}$ as a fraction by interpreting it as a geometric series.$prm$,
  latex = $ltx$0.\overline{27}=\frac{27}{100}+\frac{27}{100^2}+\frac{27}{100^3}+\cdots$ is geometric with $a=\frac{27}{100}$ and $r=\frac{1}{100}$. Sum $S=\frac{a}{1-r}=\frac{27/100}{1-1/100}=\frac{27}{99}=\frac{3}{11}$.$ltx$,
  options = $json$[
    {"id":"A","value":"$\\frac{27}{100}$","explanation":"This is only the first term; it does not include the repeating tail."},
    {"id":"B","value":"$\\frac{27}{99}$","explanation":"This is correct but not simplified; it reduces to $\\frac{3}{11}$."},
    {"id":"C","value":"$\\frac{3}{11}$","explanation":"Correct simplified fraction."},
    {"id":"D","value":"$\\frac{27}{11}$","explanation":"Places the decimal incorrectly, making the value too large."}
  ]$json$::jsonb,
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = $exp$Model the repeating decimal as a geometric series with first term $\frac{27}{100}$ and ratio $\frac{1}{100}$. The sum is $\frac{27}{99}=\frac{3}{11}$.$exp$,
  recommendation_reasons = ARRAY['Connects geometric series to a classic application (repeating decimals).','Targets common place-value and ratio mistakes.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.20,
  source = 'NewMaoS',
  source_year = 2026,
  notes = $nte$Be explicit about first term $\frac{27}{100}$ and ratio $\frac{1}{100}$.$nte$,
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Series',
  updated_at = NOW()
WHERE title = '10.2-P3';

-- ==================== 10.2-P4 ====================
UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Series',
  sub_topic_id = '10.2',
  section_id = '10.2',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 115,
  skill_tags = ARRAY['SK_GEOM_SOLVE_FOR_RATIO','SK_GEOM_SUM_INFINITE'],
  error_tags = ARRAY['E_GEOM_CONVERGENCE_MISAPPLY','E_ALGEBRA_SETUP_ERROR'],
  prompt = $prm$An infinite geometric series has first term $a$ and ratio $r$. Its sum is $12$, and its second term is $6$. What is $r$?$prm$,
  latex = $ltx$Sum: $\frac{a}{1-r}=12$ so $a=12(1-r)$. Second term: $ar=6$. Then $12(1-r)r=6 \Rightarrow 12(r-r^2)=6 \Rightarrow 2r^2-2r+1=0 \Rightarrow (r-\frac{1}{2})^2=0$, so $r=\frac{1}{2}$.$ltx$,
  options = $json$[
    {"id":"A","value":"$\\frac{1}{2}$","explanation":"Correct: it satisfies both the sum and the second-term condition, and $|r|<1$."},
    {"id":"B","value":"$2$","explanation":"If $r=2$, the series cannot converge because $|r|<1$ is required."},
    {"id":"C","value":"$-\\frac{1}{2}$","explanation":"With $a=12(1-r)$, this would not produce a positive second term of $6$."},
    {"id":"D","value":"$\\frac{3}{2}$","explanation":"Fails convergence since $|r|>1$."}
  ]$json$::jsonb,
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = $exp$Use $S=\frac{a}{1-r}=12$ so $a=12(1-r)$. The second term is $ar=6$. Solving $12(1-r)r=6$ gives $r=\frac{1}{2}$.$exp$,
  recommendation_reasons = ARRAY['Combines parameter identification with the infinite sum formula.','Reinforces that an infinite geometric sum requires $|r|<1$.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.15,
  source = 'NewMaoS',
  source_year = 2026,
  notes = $nte$Set up equations from "sum" and "second term"; enforce $|r|<1$.$nte$,
  weight_primary = 0.50,
  weight_supporting = 0.50,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Series',
  updated_at = NOW()
WHERE title = '10.2-P4';

-- ==================== 10.2-P5 ====================
UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Series',
  sub_topic_id = '10.2',
  section_id = '10.2',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 5,
  target_time_seconds = 180,
  skill_tags = ARRAY['SK_GEOM_SIGMA_NOTATION','SK_GEOM_IDENTIFY_RATIO','SK_GEOM_IDENTIFY_FIRST_TERM'],
  error_tags = ARRAY['E_INDEX_SHIFT','E_GEOM_RATIO_WRONG'],
  prompt = $prm$Which sigma notation represents the geometric series $$\frac{3}{4}+\frac{3}{10}+\frac{3}{25}+\frac{3}{62.5}+\cdots\ ?$$$prm$,
  latex = $ltx$Compute the common ratio: $\frac{(3/10)}{(3/4)}=\frac{2}{5}$ and $\frac{(3/25)}{(3/10)}=\frac{2}{5}$. So $a=\frac{3}{4}$ and $r=\frac{2}{5}$. A matching sigma form is $\sum_{n=0}^{\infty} \frac{3}{4}\left(\frac{2}{5}\right)^n$.$ltx$,
  options = $json$[
    {"id":"A","value":"$\\displaystyle \\sum_{n=1}^{\\infty} \\frac{3}{4}\\left(\\frac{2}{5}\\right)^n$","explanation":"Starts at $n=1$, so the first term becomes $\\frac{3}{4}\\cdot\\frac{2}{5}$, which is too small."},
    {"id":"B","value":"$\\displaystyle \\sum_{n=0}^{\\infty} \\frac{3}{4}\\left(\\frac{5}{2}\\right)^n$","explanation":"Uses the reciprocal ratio $\\frac{5}{2}$, which makes terms grow."},
    {"id":"C","value":"$\\displaystyle \\sum_{n=0}^{\\infty} \\frac{3}{4}\\left(\\frac{2}{5}\\right)^n$","explanation":"Correct: matches the first term when $n=0$ and uses ratio $\\frac{2}{5}$."},
    {"id":"D","value":"$\\displaystyle \\sum_{n=1}^{\\infty} \\frac{3}{4}\\left(\\frac{5}{2}\\right)^{n-1}$","explanation":"Uses the wrong ratio $\\frac{5}{2}$; also produces increasing terms."}
  ]$json$::jsonb,
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = $exp$The common ratio is $r=\frac{2}{5}$ and the first term is $\frac{3}{4}$. Using $n=0$ gives the first term directly, so $\sum_{n=0}^{\infty} \frac{3}{4}\left(\frac{2}{5}\right)^n$ matches the series.$exp$,
  recommendation_reasons = ARRAY['Tests precise control of indexing ($n=0$ vs $n=1$) in sigma form.','Reinforces identifying ratio from consecutive terms.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 5,
  mastery_weight = 1.25,
  source = 'NewMaoS',
  source_year = 2026,
  notes = $nte$Primary trap: indexing. Using $n=0$ matches the first term cleanly.$nte$,
  weight_primary = 0.60,
  weight_supporting = 0.40,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Series',
  updated_at = NOW()
WHERE title = '10.2-P5';
