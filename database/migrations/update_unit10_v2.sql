-- Unit 10 Questions Update (v2)
-- High quality questions with micro-explanations.

INSERT INTO "public"."questions"
("id","course","topic","sub_topic_id","type","calculator_allowed","difficulty","target_time_seconds","skill_tags","error_tags","prompt","latex","options","correct_option_id","tolerance","explanation","micro_explanations","recommendation_reasons","created_at","updated_at","status","version","reasoning_level","mastery_weight","representation_type","topic_id","section_id","source","notes","weight_primary","weight_supporting","title","prompt_type","primary_skill_id","supporting_skill_ids")
VALUES
-- Q1
('0f3b5c8a-7e1f-4b67-bc66-2d1b76a7b2e1','BC','BC_Series','10.1','MCQ','false','1','120',
ARRAY['sequence_and_series_definitions','partial_sum_reasoning'],
ARRAY['confuse_sequence_vs_series','assume_limit_exists_implies_series_converges'],
'Let $\sum_{n=1}^{\infty} a_n$ be an infinite series with partial sums $s_k=\sum_{n=1}^{k} a_n$. Which statement correctly defines when $\sum_{n=1}^{\infty} a_n$ converges?

A. The series converges if and only if $\lim_{k\to\infty} s_k$ exists and is finite.
B. The series converges if and only if $\lim_{n\to\infty} a_n$ exists and is finite.
C. The series converges if and only if $a_n$ is decreasing for all $n$.
D. The series converges if and only if $a_n>0$ for all $n$.',
null,
'[{"id":"A","value":"The series converges if and only if $\\lim_{k\\to\\infty} s_k$ exists and is finite."},{"id":"B","value":"The series converges if and only if $\\lim_{n\\to\\infty} a_n$ exists and is finite."},{"id":"C","value":"The series converges if and only if $a_n$ is decreasing for all $n$."},{"id":"D","value":"The series converges if and only if $a_n>0$ for all $n$."}]',
'A',null,
'By definition, $\sum_{n=1}^{\infty} a_n$ converges exactly when the partial sums $s_k=\sum_{n=1}^{k} a_n$ approach a finite limit, i.e., $\lim_{k\to\infty} s_k$ exists and is finite.',
'{"A":"Correct. Convergence of a series is defined by the convergence of its sequence of partial sums.","B":"Incorrect. Even if $\\lim a_n$ exists (and even if it equals 0), the series may still diverge.","C":"Incorrect. Decreasing terms do not guarantee convergence (e.g., $\\sum 1/n$).","D":"Incorrect. Many positive-term series diverge; positivity is not a defining condition."}',
ARRAY[]::text[],'2026-02-06 23:00:00+00','2026-02-06 23:00:00+00','published','1','1','1.00','verbal','BC_Series','10.1','self',
'Definition check: convergence of series via limit of partial sums.',
'0.85','0.15','U10C10.1-Q1-DefinitionSeriesConvergenceByPartialSums','text','sequence_and_series_definitions',ARRAY['partial_sum_reasoning']::text[]),

-- Q2
('2a0f7f4d-6dd0-4c8a-9fb6-5b2d4d6b7a9a','BC','BC_Series','10.1','MCQ','false','2','120',
ARRAY['partial_sum_reasoning','algebraic_simplification']::text[],
ARRAY['treat_divergent_series_as_having_sum','assume_limit_exists_implies_series_converges']::text[],
'An infinite series $\sum_{n=1}^{\infty} a_n$ has partial sums
$$s_k=5-\frac{2}{k+1}.$$
Which statement is true?

A. The series diverges because $\lim_{k\to\infty} s_k=\infty$.
B. The series diverges because $\lim_{k\to\infty} s_k$ does not exist.
C. The series converges and its sum is $5$.
D. The series converges and its sum is $3$.',
null,
'[{"id":"A","value":"The series diverges because $\\lim_{k\\to\\infty} s_k=\\infty$."},{"id":"B","value":"The series diverges because $\\lim_{k\\to\\infty} s_k$ does not exist."},{"id":"C","value":"The series converges and its sum is $5$."},{"id":"D","value":"The series converges and its sum is $3$."}]',
'C',null,
'A series converges to $S$ when $\lim_{k\to\infty} s_k=S$. Here $s_k=5-\frac{2}{k+1}\to 5$, so the series converges and its sum is $5$.',
'{"A":"Incorrect. $s_k$ approaches a finite value.","B":"Incorrect. The limit exists because $\\frac{2}{k+1}\\to 0$.","C":"Correct. $\\lim_{k\\to\\infty}\\left(5-\\frac{2}{k+1}\\right)=5$.","D":"Incorrect. The limit of the partial sums is $5$, not $3$."}',
ARRAY[]::text[],'2026-02-06 23:00:00+00','2026-02-06 23:00:00+00','published','1','2','1.00','verbal','BC_Series','10.1','self',
'Given $s_k$, series sum is $\\lim s_k$ if finite.',
'0.80','0.20','U10C10.1-Q2-SumFromExplicitPartialSumLimit','text','partial_sum_reasoning',ARRAY['algebraic_simplification']::text[]),

-- Q3
('7b6f6f2a-0c5b-44b0-9b4b-7c4a76f1b2c7','BC','BC_Series','10.1','MCQ','false','3','180',
ARRAY['partial_sum_reasoning','sequence_and_series_definitions']::text[],
ARRAY['treat_divergent_series_as_having_sum','assume_limit_exists_implies_series_converges']::text[],
'A series $\sum_{n=1}^{\infty} a_n$ has partial sums $s_k$ given by
$$s_k=\begin{cases}2 & \text{if $k$ is even}\\ 1 & \text{if $k$ is odd.}\end{cases}$$
Which is true?

A. The series converges to $\frac{3}{2}$.
B. The series converges to $2$.
C. The series converges to $1$.
D. The series diverges.',
null,
'[{"id":"A","value":"The series converges to $\\frac{3}{2}$."},{"id":"B","value":"The series converges to $2$."},{"id":"C","value":"The series converges to $1$."},{"id":"D","value":"The series diverges."}]',
'D',null,
'Convergence requires $\lim_{k\to\infty} s_k$ to exist. Since $s_k$ alternates between 1 and 2, the limit does not exist, so the series diverges.',
'{"A":"Incorrect. Partial sums must approach a single value; alternating values do not converge.","B":"Incorrect. Odd partial sums stay at 1, so the limit cannot be 2.","C":"Incorrect. Even partial sums stay at 2, so the limit cannot be 1.","D":"Correct. The sequence $s_k$ has no limit, so the series diverges."}',
ARRAY[]::text[],'2026-02-06 23:00:00+00','2026-02-06 23:00:00+00','published','1','3','1.00','verbal','BC_Series','10.1','self',
'Oscillation means no limit for $s_k$.',
'0.85','0.15','U10C10.1-Q3-DivergenceFromOscillatingPartialSums','text','partial_sum_reasoning',ARRAY['sequence_and_series_definitions']::text[]),

-- Q4
('c9b8f1e1-3c11-4a54-9b9f-41a1c4c0b6d0','BC','BC_Series','10.1','MCQ','false','2','120',
ARRAY['sequence_and_series_definitions','sigma_notation_manipulation']::text[],
ARRAY['confuse_sequence_vs_series','use_wrong_first_term_index']::text[],
'Let $a_n=\frac{1}{n^2}$ and $s_n=\sum_{k=1}^{n} a_k$. Which statement is correct?

A. $a_n$ is the $n$th partial sum of the series.
B. $s_n$ is the $n$th partial sum of the series $\sum_{n=1}^{\infty} a_n$.
C. $\sum_{n=1}^{\infty} a_n$ is a sequence.
D. $\lim_{n\to\infty} s_n$ equals $a_n$.',
null,
'[{"id":"A","value":"$a_n$ is the $n$th partial sum of the series."},{"id":"B","value":"$s_n$ is the $n$th partial sum of the series $\\sum_{n=1}^{\\infty} a_n$."},{"id":"C","value":"$\\sum_{n=1}^{\\infty} a_n$ is a sequence."},{"id":"D","value":"$\\lim_{n\\to\\infty} s_n$ equals $a_n$."}]',
'B',null,
'A term is $a_n$. The $n$th partial sum is $s_n=\sum_{k=1}^{n} a_k$. The infinite series is $\sum_{n=1}^{\infty} a_n$. Only statement B matches these definitions.',
'{"A":"Incorrect. $a_n$ is a term of the sequence, not a partial sum.","B":"Correct. $s_n=\\sum_{k=1}^{n} a_k$ is exactly the $n$th partial sum.","C":"Incorrect. It denotes an infinite sum (a series), not a sequence.","D":"Incorrect. If $\\lim s_n$ exists, it is the series sum; $a_n$ is a single term."}',
ARRAY[]::text[],'2026-02-06 23:00:00+00','2026-02-06 23:00:00+00','published','1','2','1.00','verbal','BC_Series','10.1','self',
'Clarify roles of $a_n$, $\\sum a_n$, and $s_n$.',
'0.90','0.10','U10C10.1-Q4-IdentifyTermVsPartialSum','text','sequence_and_series_definitions',ARRAY['sigma_notation_manipulation']::text[]),

-- Q5
('5f0d8a2b-1f8b-4cc6-8c59-9c61a8b6a9f3','BC','BC_Series','10.1','MCQ','false','4','240',
ARRAY['sigma_notation_manipulation','partial_sum_reasoning']::text[],
ARRAY['use_wrong_first_term_index','confuse_sequence_vs_series']::text[],
'A series has partial sums $s_n=\sum_{k=1}^{n} a_k$ given by
$$s_n=\frac{n}{n+2}.$$
What is $a_n$ for $n\ge2$?

A. $a_n=\frac{2}{(n+1)(n+2)}$
B. $a_n=\frac{2}{n(n+2)}$
C. $a_n=\frac{1}{n+2}$
D. $a_n=\frac{1}{n+1}-\frac{1}{n+2}$',
null,
'[{"id":"A","value":"$a_n=\\frac{2}{(n+1)(n+2)}$"},{"id":"B","value":"$a_n=\\frac{2}{n(n+2)}$"},{"id":"C","value":"$a_n=\\frac{1}{n+2}$"},{"id":"D","value":"$a_n=\\frac{1}{n+1}-\\frac{1}{n+2}$"}]',
'A',null,
'For $n\ge2$, $a_n=s_n-s_{n-1}$.
$$a_n=\frac{n}{n+2}-\frac{n-1}{n+1}=\frac{n(n+1)-(n-1)(n+2)}{(n+2)(n+1)}=\frac{2}{(n+1)(n+2)}.$$',
'{"A":"Correct. $a_n=s_n-s_{n-1}=\\frac{n}{n+2}-\\frac{n-1}{n+1}=\\frac{2}{(n+1)(n+2)}$.","B":"Incorrect. This does not match the difference $\\frac{n}{n+2}-\\frac{n-1}{n+1}$.","C":"Incorrect. $a_n$ is a difference of consecutive partial sums, not $s_n$ itself.","D":"Incorrect. This equals $\\frac{1}{(n+1)(n+2)}$, missing a factor of 2."}',
ARRAY[]::text[],'2026-02-06 23:00:00+00','2026-02-06 23:00:00+00','published','1','4','1.00','verbal','BC_Series','10.1','self',
'Use $a_n=s_n-s_{n-1}$ for $n\\ge2$.',
'0.60','0.40','U10C10.1-Q5-FindNthTermFromPartialSumsDifference','text','sigma_notation_manipulation',ARRAY['partial_sum_reasoning']::text[]),

-- Q6
('a7d9a6d4-62aa-4f75-9a61-5d6ed5c3d1c4','BC','BC_Series','10.2','MCQ','false','1','120',
ARRAY['geometric_series_computation','algebraic_simplification']::text[],
ARRAY['misidentify_geometric_ratio','treat_divergent_series_as_having_sum']::text[],
'Evaluate the infinite series
$$\sum_{n=0}^{\infty} 3\left(\frac{1}{4}\right)^n.$$

A. $\frac{3}{4}$
B. $4$
C. $\frac{12}{5}$
D. Diverges',
null,
'[{"id":"A","value":"$\\frac{3}{4}$"},{"id":"B","value":"$4$"},{"id":"C","value":"$\\frac{12}{5}$"},{"id":"D","value":"Diverges"}]',
'B',null,
'This is geometric with first term $a=3$ and ratio $r=\frac14$. Because $|r|<1$, it converges and
$$\sum_{n=0}^{\infty} ar^n=\frac{a}{1-r}=\frac{3}{1-\frac14}=4.$$',
'{"A":"Incorrect. $\\frac{3}{4}$ is $ar$ (not the sum).","B":"Correct. $a=3$, $r=\\frac14$, so sum $=\\frac{3}{1-\\frac14}=4$.","C":"Incorrect. This can come from using an incorrect denominator such as $1+r$.","D":"Incorrect. Since $|r|<1$, the geometric series converges."}',
ARRAY[]::text[],'2026-02-06 23:00:00+00','2026-02-06 23:00:00+00','published','1','1','1.00','verbal','BC_Series','10.2','self',
'Infinite geometric sum $a/(1-r)$ when $|r|<1$.',
'0.90','0.10','U10C10.2-Q6-InfiniteGeometricSumBasic','text','geometric_series_computation',ARRAY['algebraic_simplification']::text[]),

-- Q7
('e1a7c8f5-3e57-4f2a-9b2e-3b9bca8b5d0e','BC','BC_Series','10.2','MCQ','false','3','180',
ARRAY['geometric_series_computation','sequence_and_series_definitions']::text[],
ARRAY['ignore_domain_of_r','misidentify_geometric_ratio']::text[],
'For which values of $k$ does the series
$$\sum_{n=1}^{\infty} k\left(\frac{k}{3}\right)^{n-1}$$
converge?

A. All real $k$
B. $|k|<3$
C. $|k|\le 3$
D. $|k|>3$',
null,
'[{"id":"A","value":"All real $k$"},{"id":"B","value":"$|k|<3$"},{"id":"C","value":"$|k|\\le 3$"},{"id":"D","value":"$|k|>3$"}]',
'B',null,
'At $n=1$ the term is $k$, and the common ratio is $r=\frac{k}{3}$. An infinite geometric series converges iff $|r|<1$.
Thus $\left|\frac{k}{3}\right|<1\Rightarrow |k|<3$.',
'{"A":"Incorrect. Convergence depends on the common ratio $r=\\frac{k}{3}$.","B":"Correct. The series is geometric with ratio $r=\\frac{k}{3}$, so it converges iff $|r|<1$, i.e. $|k|<3$.","C":"Incorrect. If $|k|=3$, then $|r|=1$ and the geometric series does not converge.","D":"Incorrect. If $|k|>3$, then $|r|>1$ and the terms do not approach 0."}',
ARRAY[]::text[],'2026-02-06 23:00:00+00','2026-02-06 23:00:00+00','published','1','3','1.00','verbal','BC_Series','10.2','self',
'Use $|r|<1$ with $r=k/3$.',
'0.75','0.25','U10C10.2-Q7-ParameterRangeForGeometricConvergence','text','geometric_series_computation',ARRAY['sequence_and_series_definitions']::text[]),

-- Q8
('3b2c9f3a-9c79-4cda-9b13-9a3cf6b5dce1','BC','BC_Series','10.2','MCQ','false','2','180',
ARRAY['modeling_with_series','geometric_series_computation']::text[],
ARRAY['misidentify_geometric_ratio','use_wrong_first_term_index']::text[],
'Write $0.\overline{36}$ as a fraction in simplest form.

A. $\frac{9}{25}$
B. $\frac{12}{25}$
C. $\frac{4}{11}$
D. $\frac{36}{99}$',
null,
'[{"id":"A","value":"$\\frac{9}{25}$"},{"id":"B","value":"$\\frac{12}{25}$"},{"id":"C","value":"$\\frac{4}{11}$"},{"id":"D","value":"$\\frac{36}{99}$"}]',
'C',null,
'Interpret as a geometric series:
$$0.\overline{36}=0.36+0.0036+0.000036+\cdots$$
This has $a=0.36$ and $r=0.01$, so
$$\frac{a}{1-r}=\frac{0.36}{0.99}=\frac{36}{99}=\frac{4}{11}.$$',
'{"A":"Incorrect. $\\frac{9}{25}=0.36$ (terminating), not $0.\\overline{36}$.","B":"Incorrect. $\\frac{12}{25}=0.48$.","C":"Correct. $0.\\overline{36}=\\frac{36}{99}=\\frac{4}{11}$.","D":"Incorrect. This equals the value but is not simplified."}',
ARRAY[]::text[],'2026-02-06 23:00:00+00','2026-02-06 23:00:00+00','published','1','2','1.00','verbal','BC_Series','10.1','self',
'Represent repeating decimal as infinite geometric series.',
'0.60','0.40','U10C10.2-Q8-RepeatingDecimalToFractionGeometric','text','modeling_with_series',ARRAY['geometric_series_computation']::text[]),

-- Q9
('8a8b9a2a-2f7d-4c1a-9b5a-7ed2d5c8a1f9','BC','BC_Series','10.2','MCQ','false','4','240',
ARRAY['geometric_series_computation','sigma_notation_manipulation']::text[],
ARRAY['use_wrong_first_term_index','misidentify_geometric_ratio']::text[],
'Evaluate
$$\sum_{n=2}^{\infty} 5\left(\frac{2}{3}\right)^n.$$

A. $\frac{20}{3}$
B. $\frac{10}{3}$
C. $\frac{20}{9}$
D. Diverges',
null,
'[{"id":"A","value":"$\\frac{20}{3}$"},{"id":"B","value":"$\\frac{10}{3}$"},{"id":"C","value":"$\\frac{20}{9}$"},{"id":"D","value":"Diverges"}]',
'A',null,
'Factor out 5 and identify the first term at $n=2$:
$$\sum_{n=2}^{\infty} 5\left(\frac{2}{3}\right)^n = 5\sum_{n=2}^{\infty}\left(\frac{2}{3}\right)^n.$$
First term is $\left(\frac{2}{3}\right)^2=\frac{4}{9}$, ratio is $\frac{2}{3}$, so
$$5\cdot\frac{\frac{4}{9}}{1-\frac{2}{3}}=5\cdot\frac{\frac{4}{9}}{\frac{1}{3}}=5\cdot\frac{4}{3}=\frac{20}{3}.$$',
'{"A":"Correct. It is geometric with first term $5\\left(\\frac{2}{3}\\right)^2=\\frac{20}{9}$ and ratio $\\frac{2}{3}$, so sum $=\\frac{\\frac{20}{9}}{1-\\frac{2}{3}}=\\frac{20}{3}$.","B":"Incorrect. This often comes from using $5\\left(\\frac{2}{3}\\right)^1$ as the first term or dropping a factor of 2.","C":"Incorrect. $\\frac{20}{9}$ is the first term (at $n=2$), not the sum to infinity.","D":"Incorrect. Since $\\left|\\frac{2}{3}\\right|<1$, the geometric series converges."}',
ARRAY[]::text[],'2026-02-06 23:00:00+00','2026-02-06 23:00:00+00','published','1','4','1.00','verbal','BC_Series','10.2','self',
'Starts at $n=2$: first term must be evaluated at $n=2$.',
'0.70','0.30','U10C10.2-Q9-InfiniteGeometricIndexShiftExactSum','text','geometric_series_computation',ARRAY['sigma_notation_manipulation']::text[]),

-- Q10
('1d6c4f5b-3f2b-4b4f-8bb7-9f2a3c4d5e6f','BC','BC_Series','10.2','MCQ','false','2','180',
ARRAY['geometric_series_computation','algebraic_simplification']::text[],
ARRAY['misidentify_geometric_ratio','use_wrong_first_term_index']::text[],
'Compute the finite sum
$$\sum_{n=0}^{3} 5\cdot 2^n.$$

A. $35$
B. $40$
C. $45$
D. $75$',
null,
'[{"id":"A","value":"$35$"},{"id":"B","value":"$40$"},{"id":"C","value":"$45$"},{"id":"D","value":"$75$"}]',
'D',null,
'This is a finite geometric sum with first term $5$ and ratio $2$:
$$\sum_{n=0}^{3} 5\cdot 2^n = 5\sum_{n=0}^{3}2^n = 5\cdot\frac{2^{4}-1}{2-1}=5(16-1)=75.$$',
'{"A":"Incorrect. That is $5(1+2+4)=35$, missing the $n=3$ term.","B":"Incorrect. That would be the last term $5\\cdot 2^3$ only.","C":"Incorrect. This can come from adding $5+10+30$ (skipping a term).","D":"Correct. $5(1+2+4+8)=5\\cdot 15=75$, or $5\\cdot\\frac{2^4-1}{2-1}=75$."}',
ARRAY[]::text[],'2026-02-06 23:00:00+00','2026-02-06 23:00:00+00','published','1','2','1.00','verbal','BC_Series','10.2','self',
'Finite geometric sum with $n$ starting at 0.',
'0.80','0.20','U10C10.2-Q10-FiniteGeometricSumFormula','text','geometric_series_computation',ARRAY['algebraic_simplification']::text[])

ON CONFLICT (id) DO UPDATE SET
    course = EXCLUDED.course,
    topic = EXCLUDED.topic,
    sub_topic_id = EXCLUDED.sub_topic_id,
    type = EXCLUDED.type,
    calculator_allowed = EXCLUDED.calculator_allowed,
    difficulty = EXCLUDED.difficulty,
    target_time_seconds = EXCLUDED.target_time_seconds,
    skill_tags = EXCLUDED.skill_tags,
    error_tags = EXCLUDED.error_tags,
    prompt = EXCLUDED.prompt,
    latex = EXCLUDED.latex,
    options = EXCLUDED.options,
    correct_option_id = EXCLUDED.correct_option_id,
    tolerance = EXCLUDED.tolerance,
    explanation = EXCLUDED.explanation,
    micro_explanations = EXCLUDED.micro_explanations,
    updated_at = NOW(),
    status = EXCLUDED.status,
    version = EXCLUDED.version,
    reasoning_level = EXCLUDED.reasoning_level,
    mastery_weight = EXCLUDED.mastery_weight,
    representation_type = EXCLUDED.representation_type,
    topic_id = EXCLUDED.topic_id,
    section_id = EXCLUDED.section_id,
    source = EXCLUDED.source,
    notes = EXCLUDED.notes,
    weight_primary = EXCLUDED.weight_primary,
    weight_supporting = EXCLUDED.weight_supporting,
    title = EXCLUDED.title,
    prompt_type = EXCLUDED.prompt_type,
    primary_skill_id = EXCLUDED.primary_skill_id,
    supporting_skill_ids = EXCLUDED.supporting_skill_ids;
