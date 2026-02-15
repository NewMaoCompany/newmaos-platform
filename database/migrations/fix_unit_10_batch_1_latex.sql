-- Fix Unit 10 LaTeX Formatting - Batch 1 (U10.1 - U10.5)
-- Fixes triple backslashes, custom commands, and enforces strict LaTeX formatting.

DO $$
BEGIN

    -- U10.1-P1
    -- Fix: \\\\\\\\limit -> limit, \\\sum -> \sum.
    UPDATE public.questions
    SET 
        prompt = $prompt$Which statement best describes what it means for an infinite series $\sum_{n=1}^{\infty} a_n$ to converge?$prompt$,
        options = $json$[
            {"id": "A", "value": "The terms satisfy $a_n > 0$ for all $n$."},
            {"id": "B", "value": "The sequence of partial sums $S_N = \\sum_{n=1}^{N} a_n$ approaches a finite limit as $N \\to \\infty$."},
            {"id": "C", "value": "The terms satisfy $a_n \\to \\infty$ as $n \\to \\infty$."},
            {"id": "D", "value": "The partial sums $S_N$ are increasing for all $N$."}
        ]$json$::jsonb,
        explanation = $exp$A series converges if and only if its partial sums approach a finite limit.$exp$
    WHERE title = 'U10.1-P1';

    -- U10.1-P2
    -- Fix: Standardize fractions and sums.
    UPDATE public.questions
    SET 
        prompt = $prompt$Let $a_n = \frac{1}{n(n+1)}$ and $S_N = \sum_{n=1}^{N} a_n$. Which expression for $S_N$ is correct?$prompt$,
        options = $json$[
            {"id": "A", "value": "$S_N = \\frac{N}{N+1}$"},
            {"id": "B", "value": "$S_N = \\frac{N+1}{N}$"},
            {"id": "C", "value": "$S_N = \\ln(N+1)$"},
            {"id": "D", "value": "$S_N = \\frac{1}{N+1}$"}
        ]$json$::jsonb,
        explanation = $exp$Using partial fractions $\frac{1}{n(n+1)} = \frac{1}{n} - \frac{1}{n+1}$, the sum telescopes to $S_N = 1 - \frac{1}{N+1} = \frac{N}{N+1}$.$exp$
    WHERE title = 'U10.1-P2';

    -- U10.1-P3
    -- Fix: \\\sum -> \sum.
    UPDATE public.questions
    SET 
        prompt = $prompt$Which statement is always true if the series $\sum_{n=1}^{\infty} a_n$ converges?$prompt$,
        options = $json$[
            {"id": "A", "value": "$a_n \\to 0$ as $n \\to \\infty$"},
            {"id": "B", "value": "$a_n$ is decreasing for all $n$"},
            {"id": "C", "value": "$a_n > 0$ for all $n$"},
            {"id": "D", "value": "$\\sum_{n=1}^{\\infty} a_n$ must be geometric"}
        ]$json$::jsonb,
        explanation = $exp$If partial sums converge, then $a_n=S_n-S_{n-1} \to 0$; this is necessary but not sufficient for convergence.$exp$
    WHERE title = 'U10.1-P3';

    -- U10.1-P4
    -- Fix: Standardize LaTeX.
    UPDATE public.questions
    SET 
        prompt = $prompt$A sequence of partial sums is defined by $S_N = 2 - \frac{1}{N}$. Let $\sum_{n=1}^{\infty} a_n$ be the series with these partial sums. What is the value of $\sum_{n=1}^{\infty} a_n$?$prompt$,
        options = $json$[
            {"id": "A", "value": "$0$"},
            {"id": "B", "value": "$1$"},
            {"id": "C", "value": "$2$"},
            {"id": "D", "value": "The series diverges because $S_N$ depends on $N$"}
        ]$json$::jsonb,
        explanation = $exp$Since $S_N \to 2$ as $N \to \infty$, the infinite series converges to $2$.$exp$
    WHERE title = 'U10.1-P4';

    -- U10.1-P5
    -- Fix: \integers -> integers, \\\\\\\\single -> single.
    UPDATE public.questions
    SET 
        prompt = $prompt$Suppose $S_N = \sum_{n=1}^{N} a_n$ satisfies $S_{2k} = 1$ and $S_{2k-1} = 0$ for all integers $k \ge 1$. Which statement is correct about $\sum_{n=1}^{\infty} a_n$?$prompt$,
        options = $json$[
            {"id": "A", "value": "The series converges to $\\frac{1}{2}$"},
            {"id": "B", "value": "The series converges to $1$"},
            {"id": "C", "value": "The series diverges because the partial sums do not approach a single limit"},
            {"id": "D", "value": "The series converges because $S_N$ is bounded"}
        ]$json$::jsonb,
        explanation = $exp$The partial sums oscillate between $0$ and $1$ and therefore do not converge to a single value, so the series diverges.$exp$
    WHERE title = 'U10.1-P5';

    -- U10.2-P1
    -- Fix: \\\sum -> \sum.
    UPDATE public.questions
    SET 
        prompt = $prompt$Which series is geometric?$prompt$,
        options = $json$[
            {"id": "A", "value": "$\\sum_{n=1}^{\\infty} \\frac{1}{n}$"},
            {"id": "B", "value": "$\\sum_{n=0}^{\\infty} 3 \\cdot 2^n$"},
            {"id": "C", "value": "$\\sum_{n=1}^{\\infty} \\frac{1}{n^2}$"},
            {"id": "D", "value": "$\\sum_{n=1}^{\\infty} \\frac{n}{n+1}$"}
        ]$json$::jsonb
    WHERE title = 'U10.2-P1';

    -- U10.2-P2
    -- Fix: Standardize fractions.
    UPDATE public.questions
    SET 
        prompt = $prompt$Consider the geometric series $\sum_{n=0}^{\infty} 5 \left(\frac{1}{3}\right)^n$. What is its sum?$prompt$,
        options = $json$[
            {"id": "A", "value": "$\\frac{5}{1-\\frac{1}{3}}$"},
            {"id": "B", "value": "$\\frac{5}{1+\\frac{1}{3}}$"},
            {"id": "C", "value": "$\\frac{1}{1-\\frac{1}{3}}$"},
            {"id": "D", "value": "The series diverges because $\\frac{1}{3} \\neq 0$"}
        ]$json$::jsonb
    WHERE title = 'U10.2-P2';

    -- U10.2-P3
    -- Fix: \\\\\\\\since -> since.
    UPDATE public.questions
    SET 
        prompt = $prompt$For the series $\sum_{n=1}^{\infty} 12 \left(-\frac{2}{3}\right)^{n-1}$, which statement is true?$prompt$,
        options = $json$[
            {"id": "A", "value": "It diverges because $r < 0$"},
            {"id": "B", "value": "It converges and its sum is $\\frac{12}{1+\\frac{2}{3}}$"},
            {"id": "C", "value": "It converges and its sum is $\\frac{12}{1-(-\\frac{2}{3})}$"},
            {"id": "D", "value": "It diverges because $|r| > 1$"}
        ]$json$::jsonb,
        explanation = $exp$This is geometric with $a=12$ and $r = -\frac{2}{3}$; since $|r| < 1$, it converges and the sum is $\frac{a}{1-r} = \frac{12}{1-(-\frac{2}{3})}$.$exp$
    WHERE title = 'U10.2-P3';

    -- U10.2-P4
    -- Fix: \integer -> integer.
    UPDATE public.questions
    SET 
        prompt = $prompt$A geometric series has first term $a_1 = 9$ and common ratio $r = \frac{1}{2}$. What is the smallest integer $N$ such that the partial sum $S_N$ satisfies $S_N > 17$?$prompt$,
        options = $json$[
            {"id": "A", "value": "$N=1$"},
            {"id": "B", "value": "$N=2$"},
            {"id": "C", "value": "$N=3$"},
            {"id": "D", "value": "$N=5$"}
        ]$json$::jsonb,
        explanation = $exp$Compute partial sums: $S_1 = 9$, $S_2 = 13.5$, $S_3 = 15.75$, $S_4 = 16.875$, $S_5 = 17.4375$. The smallest integer is $N = 5$.$exp$
    WHERE title = 'U10.2-P4';

    -- U10.2-P5
    UPDATE public.questions
    SET 
        prompt = $prompt$Which value of $r$ makes the geometric series $\sum_{n=0}^{\infty} 7r^n$ converge?$prompt$,
        options = $json$[
            {"id": "A", "value": "$r = -2$"},
            {"id": "B", "value": "$r = 1$"},
            {"id": "C", "value": "$r = \\frac{3}{2}$"},
            {"id": "D", "value": "$r = -\\frac{3}{4}$"}
        ]$json$::jsonb
    WHERE title = 'U10.2-P5';

    -- U10.3-P1
    -- Fix: n/(n+1) -> \frac{n}{n+1}.
    UPDATE public.questions
    SET 
        prompt = $prompt$Consider the series $\sum_{n=1}^{\infty} \frac{n}{n+1}$. What does the $n$th-term test tell you about this series?$prompt$,
        options = $json$[
            {"id": "A", "value": "The series converges because $\\frac{n}{n+1} \\to 0$."},
            {"id": "B", "value": "The series diverges because $\\frac{n}{n+1}$ does not approach $0$."},
            {"id": "C", "value": "The series converges because it is a $p$-series."},
            {"id": "D", "value": "The $n$th-term test is inconclusive because $\\frac{n}{n+1} \\to 0$."}
        ]$json$::jsonb,
        explanation = $exp$Since $\frac{n}{n+1} \to 1 \ne 0$, the series must diverge by the $n$th-term test.$exp$
    WHERE title = 'U10.3-P1';

    -- U10.3-P2
    -- Fix: \\\\\\\sin -> \sin.
    UPDATE public.questions
    SET 
        prompt = $prompt$Consider the series $\sum_{n=1}^{\infty} \frac{\sin(n)}{n}$. Which conclusion is correct based only on the $n$th-term test?$prompt$,
        options = $json$[
            {"id": "A", "value": "The series converges because $\\frac{\\sin(n)}{n} \\to 0$."},
            {"id": "B", "value": "The series diverges because $\\sin(n)$ oscillates."},
            {"id": "C", "value": "The $n$th-term test is inconclusive because $\\frac{\\sin(n)}{n} \\to 0$."},
            {"id": "D", "value": "The series diverges because $\\frac{\\sin(n)}{n}$ is not decreasing."}
        ]$json$::jsonb,
        explanation = $exp$Since $\left|\frac{\sin(n)}{n}\right| \le \frac{1}{n}$, we have $\frac{\sin(n)}{n} \to 0$; the $n$th-term test cannot decide convergence from this alone.$exp$
    WHERE title = 'U10.3-P2';

    -- U10.3-P3
    UPDATE public.questions
    SET 
        prompt = $prompt$Let $a_n = (-1)^n$. What does the $n$th-term test imply about $\sum_{n=1}^{\infty} a_n$?$prompt$,
        options = $json$[
            {"id": "A", "value": "The series converges because the terms alternate."},
            {"id": "B", "value": "The series diverges because $a_n$ does not approach $0$."},
            {"id": "C", "value": "The series converges to $0$ because the average term is $0$."},
            {"id": "D", "value": "The $n$th-term test is inconclusive because the terms are bounded."}
        ]$json$::jsonb
    WHERE title = 'U10.3-P3';

    -- U10.3-P4
    UPDATE public.questions
    SET 
        prompt = $prompt$Refer to Table 10.3-A (`U10.3_Practice_Table1_Terms.png`), which lists terms $a_n$. What can you conclude about $\sum_{n=1}^{\infty} a_n$ using the $n$th-term test?$prompt$,
        options = $json$[
            {"id": "A", "value": "The series converges because the terms are decreasing."},
            {"id": "B", "value": "The series converges because $a_n \\to 0$."},
            {"id": "C", "value": "The series diverges because $a_n$ does not approach $0$."},
            {"id": "D", "value": "The $n$th-term test is inconclusive because the terms are bounded."}
        ]$json$::jsonb,
        explanation = $exp$From the table, $a_n$ approaches a value near $1$ rather than $0$, so the series must diverge by the $n$th-term test.$exp$
    WHERE title = 'U10.3-P4';

    -- U10.3-P5
    -- Fix: arrow inside math mode.
    UPDATE public.questions
    SET 
        prompt = $prompt$Which statement about the condition $a_n \to 0$ is correct for an infinite series $\sum_{n=1}^{\infty} a_n$?$prompt$,
        options = $json$[
            {"id": "A", "value": "If $a_n \\to 0$, then the series must converge."},
            {"id": "B", "value": "If $a_n \\to 0$, then the series must diverge."},
            {"id": "C", "value": "If $a_n \\to 0$, the $n$th-term test is inconclusive."},
            {"id": "D", "value": "If $a_n \\to 0$, then the series is geometric."}
        ]$json$::jsonb,
        explanation = $exp$The condition $a_n \to 0$ is necessary for convergence, but not sufficient; the $n$th-term test cannot decide in that case.$exp$
    WHERE title = 'U10.3-P5';

    -- U10.4-P1
    -- Fix: \\\\\\\\ln -> \ln, \integral -> Integral.
    UPDATE public.questions
    SET 
        prompt = $prompt$Consider the series $\sum_{n=2}^{\infty} \frac{1}{n\ln(n)}$. If $f(x) = \frac{1}{x\ln(x)}$, which statement best matches the Integral Test conclusion?$prompt$,
        options = $json$[
            {"id": "A", "value": "The Integral converges, so the series converges."},
            {"id": "B", "value": "The Integral diverges, so the series diverges."},
            {"id": "C", "value": "The Integral Test cannot be applied because $f(x)$ is positive."},
            {"id": "D", "value": "The series converges because $\\frac{1}{n \\ln(n)} \\to 0$."}
        ]$json$::jsonb,
        explanation = $exp$Here $f$ is positive, continuous, and decreasing for $x > 1$, and $\int_2^{\infty} \frac{1}{x \ln x} \, dx = \infty$, so the series diverges by the Integral Test.$exp$
    WHERE title = 'U10.4-P1';

    -- U10.4-P2
    -- Fix: p-series -> $p$-series.
    UPDATE public.questions
    SET 
        prompt = $prompt$Consider the series $\sum_{n=1}^{\infty} \frac{1}{n^2}$. Which statement is correct?$prompt$,
        options = $json$[
            {"id": "A", "value": "It diverges because $\\frac{1}{n^2} \\to 0$."},
            {"id": "B", "value": "It converges because it is a $p$-series with $p > 1$."},
            {"id": "C", "value": "It diverges because it is a $p$-series with $p > 1$."},
            {"id": "D", "value": "The $p$-series test is inconclusive when $p = 2$."}
        ]$json$::jsonb,
        explanation = $exp$This is a $p$-series with $p = 2 > 1$, so it converges (and the Integral Test also confirms convergence).$exp$
    WHERE title = 'U10.4-P2';

    -- U10.4-P3
    -- Fix: \integral -> Integral.
    UPDATE public.questions
    SET 
        prompt = $prompt$Consider the series $\sum_{n=1}^{\infty} \frac{1}{n^2+1}$. Using $f(x) = \frac{1}{x^2+1}$, which conclusion is correct?$prompt$,
        options = $json$[
            {"id": "A", "value": "The integral converges, so the series converges."},
            {"id": "B", "value": "The integral diverges, so the series diverges."},
            {"id": "C", "value": "The Integral Test cannot be applied because $f(x)$ is decreasing."},
            {"id": "D", "value": "The series diverges because $\\frac{1}{n^2+1} \\to 0$."}
        ]$json$::jsonb,
        explanation = $exp$For $x \ge 1$, $f$ is positive, continuous, and decreasing, and $\int_1^{\infty} \frac{1}{x^2+1} \, dx$ converges, so the series converges by the Integral Test.$exp$
    WHERE title = 'U10.4-P3';

    -- U10.4-P4
    -- Fix: \integer -> integer, \\\\\\\\\\lim -> \lim.
    UPDATE public.questions
    SET 
        prompt = $prompt$Refer to Table 10.4-A (`U10.4_Practice_Table1_FunctionValues.png`), where $f(x) = \frac{x-1}{x}$ is listed at integer inputs. Which condition needed for the Integral Test fails for $f$ on $[1, \infty)$?$prompt$,
        options = $json$[
            {"id": "A", "value": "$f$ is not positive on $[1, \\infty)$."},
            {"id": "B", "value": "$f$ is not continuous on $[1, \\infty)$."},
            {"id": "C", "value": "$f$ is not decreasing on $[1, \\infty)$."},
            {"id": "D", "value": "$f$ does not satisfy $\\lim_{x \\to \\infty} f(x) = 0$."}
        ]$json$::jsonb
    WHERE title = 'U10.4-P4';

    -- U10.4-P5
    -- Fix: \integral -> Integral.
    UPDATE public.questions
    SET 
        prompt = $prompt$Suppose $a_n=f(n)$ where $f$ is positive, continuous, and decreasing on $[1,\infty)$. Which statement about the Integral Test is correct?$prompt$,
        options = $json$[
            {"id": "A", "value": "If $\\int f(x) \\, dx$ converges, then $\\sum a_n$ converges."},
            {"id": "B", "value": "If $\\int f(x) \\, dx$ converges, then $\\sum a_n$ diverges."},
            {"id": "C", "value": "If $\\int f(x) \\, dx$ diverges, then $\\sum a_n$ converges."},
            {"id": "D", "value": "The Integral Test determines the exact sum of $\\sum a_n$."}
        ]$json$::jsonb,
        explanation = $exp$Under the Integral Test conditions, $\sum a_n$ and $\int f(x) \, dx$ either both converge or both diverge; thus integral convergence implies series convergence.$exp$
    WHERE title = 'U10.4-P5';

    -- U10.5-P1
    -- Fix: p-series -> $p$-series.
    UPDATE public.questions
    SET 
        prompt = $prompt$Which statement about the $p$-series $\sum_{n=1}^{\infty} \frac{1}{n^p}$ is correct?$prompt$,
        options = $json$[
            {"id": "A", "value": "It converges for all $p > 0$."},
            {"id": "B", "value": "It converges only when $p > 1$."},
            {"id": "C", "value": "It diverges for all $p > 1$."},
            {"id": "D", "value": "It converges only when $p < 1$."}
        ]$json$::jsonb,
        explanation = $exp$A $p$-series $\sum \frac{1}{n^p}$ converges if and only if $p > 1$; it diverges for $p \le 1$.$exp$
    WHERE title = 'U10.5-P1';

    -- U10.5-P2
    UPDATE public.questions
    SET 
        prompt = $prompt$Which series is the harmonic series?$prompt$,
        options = $json$[
            {"id": "A", "value": "$\\sum_{n=1}^{\\infty} \\frac{1}{n}$"},
            {"id": "B", "value": "$\\sum_{n=1}^{\\infty} \\frac{1}{n^2}$"},
            {"id": "C", "value": "$\\sum_{n=1}^{\\infty} \\frac{1}{2^n}$"},
            {"id": "D", "value": "$\\sum_{n=1}^{\\infty} \\frac{1}{n!}$"}
        ]$json$::jsonb,
        explanation = $exp$The harmonic series is $\sum_{n=1}^{\infty} \frac{1}{n}$, which is the $p$-series with $p = 1$ (and it diverges).$exp$
    WHERE title = 'U10.5-P2';

    -- U10.5-P3
    UPDATE public.questions
    SET 
        prompt = $prompt$Refer to Table 10.5-A (`U10.5_Practice_Table1_Harmonic_vs_p2.png`). Which statement is correct?$prompt$,
        options = $json$[
            {"id": "A", "value": "Both $\\sum \\frac{1}{n}$ and $\\sum \\frac{1}{n^2}$ diverge because their terms approach $0$."},
            {"id": "B", "value": "$\\sum \\frac{1}{n}$ converges and $\\sum \\frac{1}{n^2}$ diverges."},
            {"id": "C", "value": "$\\sum \\frac{1}{n}$ diverges and $\\sum \\frac{1}{n^2}$ converges."},
            {"id": "D", "value": "Both series converge because the terms decrease."}
        ]$json$::jsonb
    WHERE title = 'U10.5-P3';

    -- U10.5-P4
    UPDATE public.questions
    SET 
        prompt = $prompt$Determine whether the series $\sum_{n=1}^{\infty} \frac{1}{n^{\frac{3}{2}}}$ converges or diverges.$prompt$,
        options = $json$[
            {"id": "A", "value": "Converges ($p$-series with $p = \\frac{3}{2} > 1$)"},
            {"id": "B", "value": "Diverges ($p$-series with $p = \\frac{3}{2} > 1$)"},
            {"id": "C", "value": "Converges because $\\frac{1}{n^{\\frac{3}{2}}} \\to 0$"},
            {"id": "D", "value": "Diverges because $\\frac{1}{n^{\\frac{3}{2}}} \\to 0$"}
        ]$json$::jsonb,
        explanation = $exp$This is a $p$-series with $p = \frac{3}{2} > 1$, so it converges.$exp$
    WHERE title = 'U10.5-P4';

    -- U10.5-P5
    UPDATE public.questions
    SET 
        prompt = $prompt$For which value of $p$ does the series $\sum_{n=1}^{\infty} \frac{1}{n^p}$ diverge?$prompt$,
        options = $json$[
            {"id": "A", "value": "$p = 2$"},
            {"id": "B", "value": "$p = \\frac{3}{2}$"},
            {"id": "C", "value": "$p = 1$"},
            {"id": "D", "value": "$p = 4$"}
        ]$json$::jsonb
    WHERE title = 'U10.5-P5';

END $$;
