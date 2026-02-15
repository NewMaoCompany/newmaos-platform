-- Comprehensive Fix for Unit 4.2 Questions
-- 1. Fix U4.2-P5: Replace Markdown table (which failed to render) with LaTeX array.
-- 2. Fix U4.2-P2: Fix corrupted "(in ft/s)" text.
-- 3. Fix U4.2-P4: Fix potentially corrupted "(in ft/s^2)" text.

-- U4.2-P5: Table fix
UPDATE public.questions
SET
    prompt = $txt$The table below gives position $s(t)$ (in feet) of a runner at times $t$ (in minutes). Which is the best estimate of the runner’s velocity at $t=3.0$ minutes?

$$
\begin{array}{|c|c|}
\hline
t \text{ (min)} & s(t) \text{ (ft)} \\
\hline
2.9 & 150.0 \\
3.0 & 159.0 \\
3.1 & 168.0 \\
\hline
\end{array}
$$$txt$,
    latex = $txt$The table below gives position $s(t)$ (in feet) of a runner at times $t$ (in minutes). Which is the best estimate of the runner’s velocity at $t=3.0$ minutes?

$$
\begin{array}{|c|c|}
\hline
t \text{ (min)} & s(t) \text{ (ft)} \\
\hline
2.9 & 150.0 \\
3.0 & 159.0 \\
3.1 & 168.0 \\
\hline
\end{array}
$$$txt$
WHERE title = 'U4.2-P5';

-- U4.2-P2: Fix text "v(t) (in ft/s)"
UPDATE public.questions
SET
    prompt = $txt$The graph shows velocity $v(t)$ (in ft/s) of a moving object for $0 \le t \le 10$ seconds. During which time interval is the object moving backward?$txt$,
    latex = $txt$The graph shows velocity $v(t)$ (in ft/s) of a moving object for $0 \le t \le 10$ seconds. During which time interval is the object moving backward?$txt$
WHERE title = 'U4.2-P2';

-- U4.2-P4: Fix text "a(t) (in ft/s^2)" just in case
UPDATE public.questions
SET
    prompt = $txt$The graph shows acceleration $a(t)$ (in ft/s$^2$) for $0 \le t \le 8$. At which time $t$ is acceleration most likely positive and large?$txt$,
    latex = $txt$The graph shows acceleration $a(t)$ (in ft/s$^2$) for $0 \le t \le 8$. At which time $t$ is acceleration most likely positive and large?$txt$
WHERE title = 'U4.2-P4';
