-- Seed Script: Update Unit 5 Practice Descriptions (card_description)
-- Unit: ABBC_Analytical

BEGIN;

-- Ensure column exists (idempotency check)
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'sections' AND column_name = 'description2') THEN
        ALTER TABLE public.sections ADD COLUMN description2 TEXT DEFAULT '';
    END IF;
END $$;

-- Update Descriptions

-- 5.1
UPDATE public.sections
SET description2 = 'This practice trains you to recognize when the Mean Value Theorem can be applied and what it guarantees. You’ll practice checking the two required conditions on a closed interval, then interpreting the conclusion as a statement about a matching instantaneous rate somewhere inside the interval. Problems include deciding whether the theorem applies (and clearly stating why), identifying an appropriate interval from a graph or context, and translating the theorem’s meaning into plain language. You’ll also work on “trap” cases where the function looks smooth but fails a condition at an endpoint or at a corner, and cases where students confuse the theorem’s conclusion with an average rate. The goal is accurate condition-checking, correct interpretation, and clean justification.'
WHERE id = '5.1' AND topic_id = 'ABBC_Analytical';

-- 5.2
UPDATE public.sections
SET description2 = 'This practice focuses on the logic behind absolute maxima and minima and how they differ from local extrema. You’ll learn to use the Extreme Value Theorem to decide whether absolute extrema must exist, with emphasis on the required closed-interval setting. Then you’ll identify critical points, including places where the slope is zero and where the slope does not exist, and connect those candidates to possible extrema. Questions also separate “existence” from “location,” so you don’t accidentally claim the theorem tells you exactly where the extremum occurs. You’ll practice reading graphs and simple analytic information to decide whether a point is a local maximum, local minimum, neither, or an absolute extreme. Common pitfalls are addressed directly: missing endpoints, skipping nondifferentiable points, and mixing up global vs local language.'
WHERE id = '5.2' AND topic_id = 'ABBC_Analytical';

-- 5.3
UPDATE public.sections
SET description2 = 'This practice builds skill in turning derivative information into behavior statements about a function. You’ll analyze where a function is increasing, decreasing, or constant by using sign information from the derivative. Problems include creating and interpreting sign charts, choosing correct test intervals, and avoiding errors caused by splitting intervals incorrectly or using the wrong test point. Some items provide a graph of the derivative and ask you to infer where the original function rises or falls; others provide algebraic sign clues or a table of derivative values. You’ll also practice explaining your reasoning clearly, especially in cases where the derivative is undefined at a point but still determines how intervals should be split. The emphasis is on correct interval notation, correct sign logic, and connecting sign changes to behavior without overclaiming.'
WHERE id = '5.3' AND topic_id = 'ABBC_Analytical';

-- 5.4
UPDATE public.sections
SET description2 = 'This practice strengthens your ability to classify local extrema by analyzing how the derivative changes sign around a critical point. You’ll work with sign charts, derivative graphs, and brief contextual descriptions to decide whether a point is a local maximum, local minimum, or neither. A major focus is doing the sign-change check correctly rather than assuming that “derivative equals zero” automatically means an extremum. You’ll see examples where the derivative touches zero but does not change sign, where the derivative is undefined but still produces a change from increasing to decreasing, and where multiple critical points require careful interval management. You’ll also practice writing a concise justification that matches AP expectations: identify the intervals, state the sign on each interval, and conclude the classification. Accuracy in logic, not memorization, is the target.'
WHERE id = '5.4' AND topic_id = 'ABBC_Analytical';

-- 5.5
UPDATE public.sections
SET description2 = 'This practice trains the complete workflow for finding absolute extrema on a closed interval. You’ll identify all candidates that must be checked: endpoints and interior critical points, including points where the slope does not exist. Then you’ll evaluate the function at every candidate and compare results to determine the absolute maximum and absolute minimum. Problems include cases where students typically miss a candidate, forget to include endpoints, or compare values incorrectly. Some questions emphasize interpretation: reporting absolute extrema with correct x-location and y-value language, or recognizing when the absolute maximum occurs at an endpoint even if there is an interior local maximum. You’ll also see problems where the function is not continuous on the interval, forcing you to explain why the method fails or how the conclusion changes. The goal is a disciplined, complete comparison process.'
WHERE id = '5.5' AND topic_id = 'ABBC_Analytical';

-- 5.6
UPDATE public.sections
SET description2 = 'This practice develops your ability to determine concavity and identify where concavity changes. You’ll analyze the second derivative or other concavity indicators and translate them into “concave up” and “concave down” intervals. Problems include reading concavity from graphs, interpreting a table of second-derivative values, and managing interval breaks when the second derivative is zero or undefined. A key theme is avoiding false inflection points: you must confirm a true change in concavity rather than assuming that “second derivative equals zero” is enough. You’ll practice clear interval notation and correct reasoning statements that match AP style, including cases with nondifferentiable points or discontinuities. Some items blend concavity with behavior so you connect “slope increasing or decreasing” to concavity meaningfully. The emphasis is careful sign analysis, proper checks, and accurate conclusions.'
WHERE id = '5.6' AND topic_id = 'ABBC_Analytical';

-- 5.7
UPDATE public.sections
SET description2 = 'This practice focuses on using the second derivative test correctly and knowing when it does not apply. You’ll start by identifying critical points, then use second-derivative information to classify them as local maxima, local minima, or inconclusive. Problems highlight the difference between classification by the second derivative test and classification by sign changes in the first derivative. You’ll encounter common incorrect moves: applying the second derivative test at a point that is not a critical point, ignoring the “inconclusive” outcome, or misreading the sign of the second derivative. Some questions provide derivative graphs or tables instead of explicit formulas so you practice interpretation skills, not just computation. The goal is correct decision-making: confirm the prerequisites, apply the test only when appropriate, and state conclusions with proper justification and language.'
WHERE id = '5.7' AND topic_id = 'ABBC_Analytical';

-- 5.8
UPDATE public.sections
SET description2 = 'This practice builds graph-sense: how function shape connects to the behavior of its derivative. You’ll work with graphs of a function and determine key features of its derivative, including where the derivative is positive, negative, or zero and where it is undefined. You’ll also do the reverse: given a derivative graph, infer the rising and falling behavior of the original function and locate likely extrema. Problems include interpreting relative steepness, understanding how flat regions appear, and recognizing corners or cusps as places where the derivative fails to exist. The tasks emphasize qualitative reasoning over exact computation, matching how AP often tests graph interpretation. You’ll practice producing a derivative sketch that has correct sign, correct key points, and reasonable shape, while avoiding common mix-ups between the function and its derivative. Clear reasoning and accurate feature-matching are the priorities.'
WHERE id = '5.8' AND topic_id = 'ABBC_Analytical';

-- 5.9
UPDATE public.sections
SET description2 = 'This practice is a synthesis set that links increasing/decreasing behavior, extrema, concavity, and inflection points through first- and second-derivative information. You’ll compare multiple representations: a graph of a function, a graph of its first derivative, and a graph or table describing second-derivative behavior. Problems ask you to match which graph belongs to which quantity, identify where slope is increasing versus decreasing, and determine where concavity changes. A major focus is avoiding “role confusion,” such as treating a zero of the derivative like a zero of the function, or reading concavity directly from the first-derivative sign instead of from how the slope changes. You’ll also practice explaining why a proposed match cannot be correct by pointing to a specific feature mismatch. These tasks mirror AP multiple-choice style: interpret, connect, and justify quickly and accurately.'
WHERE id = '5.9' AND topic_id = 'ABBC_Analytical';

-- 5.10
UPDATE public.sections
SET description2 = 'This practice introduces the structure of optimization: define variables, build an objective, express constraints, and identify a valid domain. You’ll work on translating word problems into a single-variable model without skipping steps, with emphasis on defining what each variable represents and what quantity is being maximized or minimized. Problems include geometry and real-world contexts where you must set up relationships carefully, choose reasonable units, and identify endpoints that matter. The practice targets common modeling errors: forgetting a constraint, using an incorrect relationship, or failing to state the allowable interval for the variable. You’ll also preview the logic behind checking endpoints and interior critical points so you understand why optimization is not just “set derivative equal to zero.” The goal is clean setup and correct domain thinking before any calculus steps.'
WHERE id = '5.10' AND topic_id = 'ABBC_Analytical';

-- 5.11
UPDATE public.sections
SET description2 = 'This practice completes the optimization workflow from modeling to final interpretation. You’ll start from a correctly defined objective function and domain, then determine where the objective reaches a maximum or minimum on the allowed interval. Problems require you to find candidate points, check endpoints, and justify the final choice with a comparison rather than an assumption. You’ll also practice sanity checks: confirming units, ensuring the answer matches the context, and verifying that the chosen value is valid under the original constraints. Common AP-style pitfalls are built in: missing domain restrictions, failing to check endpoints, or reporting the wrong quantity (for example reporting a variable value when the question asks for a maximum area or minimum cost). The emphasis is correctness, completeness, and communicating the final result clearly in context.'
WHERE id = '5.11' AND topic_id = 'ABBC_Analytical';

-- 5.12
UPDATE public.sections
SET description2 = 'This practice focuses on understanding how an implicitly defined relationship behaves without forcing it into an explicit function form. You’ll interpret the meaning of the derivative in this setting, analyze where the relation has horizontal or vertical tangents, and connect those tangent conditions to geometric features on the curve. Problems also include identifying points that must be excluded, checking whether a point actually lies on the relation, and avoiding extraneous conclusions that come from algebraic steps. Some questions are qualitative, asking you to describe local behavior near a point; others use simple numeric information to decide whether the curve is rising steeply, flattening, or turning vertical. The goal is careful point-checking, correct tangent-condition logic, and disciplined interpretation—skills that appear frequently in AP multiple-choice and free-response contexts.'
WHERE id = '5.12' AND topic_id = 'ABBC_Analytical';

-- Unit Test (Unit 5)
UPDATE public.sections
SET description2 = 'The Unit 5 test is a comprehensive assessment of analytical applications of differentiation. It mixes theorem-based reasoning, behavior analysis, and modeling tasks to mirror AP pacing and style. You’ll be asked to verify conditions before applying major results, interpret conclusions correctly, and avoid overgeneral statements. The test includes problems on increasing/decreasing intervals, local and absolute extrema, and concavity-based reasoning, with careful attention to endpoints and nondifferentiable points. Several items require connecting representations, such as reading information from graphs or tables and matching it to function behavior. Optimization questions emphasize correct setup, domain management, and final interpretation in context. You’ll also see implicit-relation behavior questions that test tangent conditions and validity checks. The test is designed to expose typical error patterns (missing candidates, incorrect sign logic, incomplete domain checks) while rewarding clear, disciplined reasoning.'
WHERE id = 'unit_test' AND topic_id = 'ABBC_Analytical';

COMMIT;
