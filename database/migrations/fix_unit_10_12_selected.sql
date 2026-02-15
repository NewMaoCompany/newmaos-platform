-- Fix Unit 10.12 Selected Questions (P1, P3, P4, P5)
-- Fixes fraction formatting, filenames, and excessive backslashes in text.

DO $$
BEGIN

    -- U10.12-P1
    -- Fix: Standardize fractions in options (remove text / and fix ^\frac{n}{n}!)
    UPDATE public.questions
    SET 
        prompt = $prompt$A Taylor polynomial of degree $n$ is used to approximate $f(x)$ near $x = a$. Which expression is the Lagrange error bound form?$prompt$,
        options = $json$[
            {"id": "A", "value": "$|R_n(x)| \\le M \\frac{|x-a|^n}{n!}$"},
            {"id": "B", "value": "$|R_n(x)| \\le M \\frac{|x-a|^{n+1}}{(n+1)!}$"},
            {"id": "C", "value": "$|R_n(x)| \\le \\frac{|f^{(n+1)}(x)|}{(n+1)!}$"},
            {"id": "D", "value": "$|R_n(x)| \\le M |x-a|$"}
        ]$json$::jsonb
    WHERE title = 'U10.12-P1';

    -- U10.12-P3
    -- Fix: Remove filename.
    UPDATE public.questions
    SET 
        prompt = $prompt$Refer to Table 10.12-A, which lists bounds for using $T_2$ at $0$ to approximate $e^x$. Which statement is correct?$prompt$
    WHERE title = 'U10.12-P3';

    -- U10.12-P4
    -- Fix: Remove excessive backslashes in \sin.
    UPDATE public.questions
    SET 
        prompt = $prompt$Approximate $\sin(0.1)$ using the 1st-degree Maclaurin polynomial $T_1(x) = x$. A Lagrange error bound is $|R_1(0.1)| \le M \frac{0.1^2}{2!}$ on $[0, 0.1]$. For $\sin x$, what is a valid choice for $M$ on this interval?$prompt$,
        options = $json$[
            {"id": "A", "value": "$M = 0$"},
            {"id": "B", "value": "$M = 1$"},
            {"id": "C", "value": "$M = 0.1$"},
            {"id": "D", "value": "$M = \\sin(0.1)$"}
        ]$json$::jsonb,
        explanation = $exp$For $T_1$, we bound $|f''(z)|$. If $f(x) = \sin x$, then $f''(z) = -\sin z$, and $|-\sin z| \le 1$ on any interval, so $M = 1$ is valid.$exp$
    WHERE title = 'U10.12-P4';

    -- U10.12-P5
    -- Fix: Remove excessive backslashes in text (single, since).
    UPDATE public.questions
    SET 
        prompt = $prompt$When using a Lagrange error bound for a Taylor approximation from $a$ to $x$, which interval must be used to choose $M$ (a maximum of the next derivative)?$prompt$,
        options = $json$[
            {"id": "A", "value": "Only at the single point $z=x$"},
            {"id": "B", "value": "Only at the single point $z=a$"},
            {"id": "C", "value": "On the entire interval between $a$ and $x$"},
            {"id": "D", "value": "On any convenient interval, since the bound is always exact"}
        ]$json$::jsonb,
        explanation = $exp$The Lagrange bound requires a maximum (or upper bound) for $|f^{(n+1)}(z)|$ on the whole interval connecting $a$ and $x$.$exp$
    WHERE title = 'U10.12-P5';

END $$;
