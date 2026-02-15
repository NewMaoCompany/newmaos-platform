-- Unit 1 Safe Update Script (Fixed with Tagged Dollar Quoting)
-- Updates content for 10 specific questions while PRESERVING existing IDs.
-- Uses 'title' as the unique lookup key.
-- Uses $val$ delimiters to avoid conflict with LaTeX $$ inside the content.

BEGIN;

DO $do$
DECLARE
    q_id uuid;
BEGIN

    -- 1. U1C1.1_AverageVelocity_SecantSlope
    SELECT id INTO q_id FROM public.questions WHERE title = 'U1C1.1_AverageVelocity_SecantSlope';
    IF q_id IS NOT NULL THEN
        UPDATE public.questions SET
            prompt = $val$A particle’s position is given by $s(t)=t^2+2t$ (meters), where $t$ is in seconds. What is the average velocity on the interval $[1,3]$?$val$,
            latex = $val$s(t)=t^2+2t,\ \text{Average velocity on }[1,3]=\frac{s(3)-s(1)}{3-1}$val$,
            options = $val$[{"id": "A", "text": "$6\\ \\text{m/s}$"}, {"id": "B", "text": "$4\\ \\text{m/s}$"}, {"id": "C", "text": "$8\\ \\text{m/s}$"}, {"id": "D", "text": "$10\\ \\text{m/s}$"}]$val$::jsonb,
            correct_option_id = 'A',
            explanation = $val$Average velocity on $[1,3]$ is the slope of the secant line: $$\frac{s(3)-s(1)}{3-1}=\frac{(9+6)-(1+2)}{2}=\frac{15-3}{2}=6.$$ $val$,
            micro_explanations = $val$ {"A": "Correct: secant slope over $[1,3]$ is $6$.", "B": "This can happen if you mistakenly compute $s(3)-s(1)$ as $8$ or divide by the wrong interval length.", "C": "This can happen if you use $\\frac{s(3)}{3}$ or a point-slope confusion instead of a difference quotient.", "D": "This can happen if you divide by $1$ (forgetting $3-1=2$)."}$val$::jsonb,
            updated_at = NOW()
        WHERE id = q_id;
    ELSE
        INSERT INTO public.questions (title, course, topic, sub_topic_id, type, calculator_allowed, difficulty, target_time_seconds, skill_tags, error_tags, prompt, latex, options, correct_option_id, explanation, micro_explanations, recommendation_reasons, status, version, reasoning_level, mastery_weight, representation_type, topic_id, section_id, source, source_year, notes, weight_primary, weight_supporting, prompt_type, primary_skill_id, supporting_skill_ids)
        VALUES (
            'U1C1.1_AverageVelocity_SecantSlope', 'AP_Calculus_BC', 'Both_Limits', 'Unit1_1.1', 'mcq', false, 'Level2', 75,
            ARRAY['AverageRateOfChange', 'SecantSlope', 'DifferenceQuotient'], ARRAY['UsingPointInsteadOfInterval', 'SlopeSignConfusion', 'UnitsMismatch'],
            $val$A particle’s position is given by $s(t)=t^2+2t$ (meters), where $t$ is in seconds. What is the average velocity on the interval $[1,3]$?$val$,
            $val$s(t)=t^2+2t,\ \text{Average velocity on }[1,3]=\frac{s(3)-s(1)}{3-1}$val$,
            $val$[{"id": "A", "text": "$6\\ \\text{m/s}$"}, {"id": "B", "text": "$4\\ \\text{m/s}$"}, {"id": "C", "text": "$8\\ \\text{m/s}$"}, {"id": "D", "text": "$10\\ \\text{m/s}$"}]$val$::jsonb,
            'A',
            $val$Average velocity on $[1,3]$ is the slope of the secant line: $$\frac{s(3)-s(1)}{3-1}=\frac{(9+6)-(1+2)}{2}=\frac{15-3}{2}=6.$$ $val$,
            $val$ {"A": "Correct: secant slope over $[1,3]$ is $6$.", "B": "This can happen if you mistakenly compute $s(3)-s(1)$ as $8$ or divide by the wrong interval length.", "C": "This can happen if you use $\\frac{s(3)}{3}$ or a point-slope confusion instead of a difference quotient.", "D": "This can happen if you divide by $1$ (forgetting $3-1=2$)."}$val$::jsonb,
            ARRAY['Core Chapter 1.1 skill: average rate of change as secant slope', 'Builds correct difference-quotient setup'],
            'published', 1, 'Procedural', 1.0, 'symbolic', 'Both_Limit', 'Unit1_1.1', 'NewMaoS', 2026, 'No image needed; purely symbolic average rate-of-change computation.', 0.7, 0.3, 'text', 'SKL_AverageRateOfChange', ARRAY['SKL_DifferenceQuotient']
        );
    END IF;

    -- 2. U1C1.1_TangentSlope_DefinitionForm
    SELECT id INTO q_id FROM public.questions WHERE title = 'U1C1.1_TangentSlope_DefinitionForm';
    IF q_id IS NOT NULL THEN
        UPDATE public.questions SET
            prompt = $val$Let $f(x)=3x^2-5x$. Which expression represents the slope of the tangent line to $y=f(x)$ at $x=2$ using the definition of derivative?$val$,
            latex = $val$\text{Slope at }x=2=\lim_{h\to 0}\frac{f(2+h)-f(2)}{h}$val$,
            options = $val$[{"id": "A", "text": "$\\displaystyle \\lim_{h\\to 0}\\frac{f(2)-f(2-h)}{h}$"}, {"id": "B", "text": "$\\displaystyle \\lim_{h\\to 0}\\frac{f(h)-f(2)}{h-2}$"}, {"id": "C", "text": "$\\displaystyle \\lim_{h\\to 0}\\frac{f(2+h)-f(2)}{h}$"}, {"id": "D", "text": "$\\displaystyle \\lim_{x\\to 0}\\frac{f(2)-f(x)}{2-x}$"}]$val$::jsonb,
            correct_option_id = 'C',
            explanation = $val$By definition, the slope of the tangent at $x=2$ is $$\lim_{h\to 0}\frac{f(2+h)-f(2)}{h}.$$ This is the limit of secant slopes as the interval shrinks to zero.$val$,
            micro_explanations = $val$ {"A": "This equals $\\lim_{h\\to 0}\\frac{f(2)-f(2-h)}{h}$ which is not the standard form; it also introduces a sign issue unless rewritten carefully.", "B": "This is not anchored at $x=2$ correctly; it mixes $h$ as an $x$-value rather than an increment.", "C": "Correct: increment form at $x=2$.", "D": "This can be correct if written as $\\lim_{x\\to 2}\\frac{f(x)-f(2)}{x-2}$, but the given form has mismatched limit variable ($x\\to 0$)."}$val$::jsonb,
            updated_at = NOW()
        WHERE id = q_id;
    ELSE
        INSERT INTO public.questions (title, course, topic, sub_topic_id, type, calculator_allowed, difficulty, target_time_seconds, skill_tags, error_tags, prompt, latex, options, correct_option_id, explanation, micro_explanations, recommendation_reasons, status, version, reasoning_level, mastery_weight, representation_type, topic_id, section_id, source, source_year, notes, weight_primary, weight_supporting, prompt_type, primary_skill_id, supporting_skill_ids)
        VALUES (
            'U1C1.1_TangentSlope_DefinitionForm', 'AP_Calculus_BC', 'Both_Limits', 'Unit1_1.1', 'mcq', false, 'Level3', 90,
            ARRAY['DifferenceQuotient', 'InstantaneousRateIdea', 'LimitConcept'], ARRAY['PluggingHInsteadOfLimiting', 'DistributingErrors', 'SignErrorInSubstitution'],
            $val$Let $f(x)=3x^2-5x$. Which expression represents the slope of the tangent line to $y=f(x)$ at $x=2$ using the definition of derivative?$val$,
            $val$\text{Slope at }x=2=\lim_{h\to 0}\frac{f(2+h)-f(2)}{h}$val$,
            $val$[{"id": "A", "text": "$\\displaystyle \\lim_{h\\to 0}\\frac{f(2)-f(2-h)}{h}$"}, {"id": "B", "text": "$\\displaystyle \\lim_{h\\to 0}\\frac{f(h)-f(2)}{h-2}$"}, {"id": "C", "text": "$\\displaystyle \\lim_{h\\to 0}\\frac{f(2+h)-f(2)}{h}$"}, {"id": "D", "text": "$\\displaystyle \\lim_{x\\to 0}\\frac{f(2)-f(x)}{2-x}$"}]$val$::jsonb,
            'C',
            $val$By definition, the slope of the tangent at $x=2$ is $$\lim_{h\to 0}\frac{f(2+h)-f(2)}{h}.$$ This is the limit of secant slopes as the interval shrinks to zero.$val$,
            $val$ {"A": "This equals $\\lim_{h\\to 0}\\frac{f(2)-f(2-h)}{h}$ which is not the standard form; it also introduces a sign issue unless rewritten carefully.", "B": "This is not anchored at $x=2$ correctly; it mixes $h$ as an $x$-value rather than an increment.", "C": "Correct: increment form at $x=2$.", "D": "This can be correct if written as $\\lim_{x\\to 2}\\frac{f(x)-f(2)}{x-2}$, but the given form has mismatched limit variable ($x\\to 0$)."}$val$::jsonb,
            ARRAY['Core Chapter 1.1: instantaneous rate as limit of secant slopes', 'Focuses on correct limit setup rather than computation'],
            'published', 1, 'Conceptual', 1.0, 'symbolic', 'Both_Limit', 'Unit1_1.1', 'NewMaoS', 2026, 'No image needed; checks correct derivative-as-limit expression.', 0.8, 0.2, 'text', 'SKL_DifferenceQuotient', ARRAY['SKL_LimitConcept']
        );
    END IF;

    -- 3. U1C1.1_InstantRate_Sqrt_Rationalize
    SELECT id INTO q_id FROM public.questions WHERE title = 'U1C1.1_InstantRate_Sqrt_Rationalize';
    IF q_id IS NOT NULL THEN
        UPDATE public.questions SET
            prompt = $val$Compute the instantaneous rate of change of $g(x)=\sqrt{x}$ at $x=9$ using the limit definition $$g''(9)=\lim_{h\to 0}\frac{\sqrt{9+h}-3}{h}.$$ $val$,
            latex = $val$g''(9)=\lim_{h\to 0}\frac{\sqrt{9+h}-3}{h}$val$,
            options = $val$[{"id": "A", "text": "$\\displaystyle \\frac{1}{3}$"}, {"id": "B", "text": "$\\displaystyle \\frac{1}{6}$"}, {"id": "C", "text": "$\\displaystyle \\frac{1}{9}$"}, {"id": "D", "text": "$\\displaystyle \\frac{1}{18}$"}]$val$::jsonb,
            correct_option_id = 'B',
            explanation = $val$Rationalize: $$\frac{\sqrt{9+h}-3}{h}\cdot\frac{\sqrt{9+h}+3}{\sqrt{9+h}+3}=\frac{(9+h)-9}{h(\sqrt{9+h}+3)}=\frac{1}{\sqrt{9+h}+3}.$$ Taking $h\to 0$ gives $\frac{1}{3+3}=\frac{1}{6}.$$ $val$,
            micro_explanations = $val$ {"A": "This can happen if you incorrectly cancel $h$ without rationalizing fully.", "B": "Correct: rationalization leads to $\\frac{1}{\\sqrt{9+h}+3}\\to \\frac{1}{6}$.", "C": "This can happen if you substitute $h=0$ too early and treat the expression as $\\frac{\\sqrt{9}-3}{h}$.", "D": "This can happen if you mistakenly get $\\sqrt{9+h}+3\\to 9+3=12$."}$val$::jsonb,
            updated_at = NOW()
        WHERE id = q_id;
    ELSE
        INSERT INTO public.questions (title, course, topic, sub_topic_id, type, calculator_allowed, difficulty, target_time_seconds, skill_tags, error_tags, prompt, latex, options, correct_option_id, explanation, micro_explanations, recommendation_reasons, status, version, reasoning_level, mastery_weight, representation_type, topic_id, section_id, source, source_year, notes, weight_primary, weight_supporting, prompt_type, primary_skill_id, supporting_skill_ids)
        VALUES (
            'U1C1.1_InstantRate_Sqrt_Rationalize', 'AP_Calculus_BC', 'Both_Limits', 'Unit1_1.1', 'mcq', false, 'Level4', 120,
            ARRAY['DifferenceQuotient', 'AlgebraSimplification', 'InstantaneousRateIdea'], ARRAY['FactoringMistake', 'CancelingNoncommonFactors', 'SignErrorInExpansion'],
            $val$Compute the instantaneous rate of change of $g(x)=\sqrt{x}$ at $x=9$ using the limit definition $$g''(9)=\lim_{h\to 0}\frac{\sqrt{9+h}-3}{h}.$$ $val$,
            $val$g''(9)=\lim_{h\to 0}\frac{\sqrt{9+h}-3}{h}$val$,
            $val$[{"id": "A", "text": "$\\displaystyle \\frac{1}{3}$"}, {"id": "B", "text": "$\\displaystyle \\frac{1}{6}$"}, {"id": "C", "text": "$\\displaystyle \\frac{1}{9}$"}, {"id": "D", "text": "$\\displaystyle \\frac{1}{18}$"}]$val$::jsonb,
            'B',
            $val$Rationalize: $$\frac{\sqrt{9+h}-3}{h}\cdot\frac{\sqrt{9+h}+3}{\sqrt{9+h}+3}=\frac{(9+h)-9}{h(\sqrt{9+h}+3)}=\frac{1}{\sqrt{9+h}+3}.$$ Taking $h\to 0$ gives $\frac{1}{3+3}=\frac{1}{6}.$$ $val$,
            $val$ {"A": "This can happen if you incorrectly cancel $h$ without rationalizing fully.", "B": "Correct: rationalization leads to $\\frac{1}{\\sqrt{9+h}+3}\\to \\frac{1}{6}$.", "C": "This can happen if you substitute $h=0$ too early and treat the expression as $\\frac{\\sqrt{9}-3}{h}$.", "D": "This can happen if you mistakenly get $\\sqrt{9+h}+3\\to 9+3=12$."}$val$::jsonb,
            ARRAY['Chapter 1.1: concrete computation from instantaneous-rate limit form', 'Requires correct conjugate technique'],
            'published', 1, 'Algebraic', 1.2, 'symbolic', 'Both_Limit', 'Unit1_1.1', 'NewMaoS', 2026, 'No image needed; emphasizes conjugate/rationalization within limit definition context.', 0.7, 0.3, 'text', 'SKL_AlgebraicManipulation', ARRAY['SKL_DifferenceQuotient']
        );
    END IF;

    -- 4. U1C1.1_AverageSpeed_Interpretation
    SELECT id INTO q_id FROM public.questions WHERE title = 'U1C1.1_AverageSpeed_Interpretation';
    IF q_id IS NOT NULL THEN
        UPDATE public.questions SET
            prompt = $val$A car’s distance from home (in miles) after $t$ hours is $D(t)$. Which quantity best represents the average speed of the car from $t=2$ to $t=5$?$val$,
            latex = $val$\text{Average speed on }[2,5]=\frac{D(5)-D(2)}{5-2}$val$,
            options = $val$[{"id": "A", "text": "$D(5)-D(2)$"}, {"id": "B", "text": "$\\displaystyle \\frac{D(5)-D(2)}{5-2}$"}, {"id": "C", "text": "$\\displaystyle \\frac{D(5)}{5}$"}, {"id": "D", "text": "$D''(2)$"}]$val$::jsonb,
            correct_option_id = 'B',
            explanation = $val$Average speed over an interval is change in distance divided by change in time: $$\frac{D(5)-D(2)}{5-2}.$$ The units are miles per hour.$val$,
            micro_explanations = $val$ {"A": "This is total change in distance, not per hour.", "B": "Correct: secant slope (miles per hour).", "C": "This averages from $0$ to $5$, not from $2$ to $5$.", "D": "This is an instantaneous rate at $t=2$, not an average over $[2,5]$."}$val$::jsonb,
            updated_at = NOW()
        WHERE id = q_id;
    ELSE
        INSERT INTO public.questions (title, course, topic, sub_topic_id, type, calculator_allowed, difficulty, target_time_seconds, skill_tags, error_tags, prompt, latex, options, correct_option_id, explanation, micro_explanations, recommendation_reasons, status, version, reasoning_level, mastery_weight, representation_type, topic_id, section_id, source, source_year, notes, weight_primary, weight_supporting, prompt_type, primary_skill_id, supporting_skill_ids)
        VALUES (
            'U1C1.1_AverageSpeed_Interpretation', 'AP_Calculus_BC', 'Both_Limits', 'Unit1_1.1', 'mcq', false, 'Level1', 60,
            ARRAY['AverageRateOfChange', 'UnitsInterpretation'], ARRAY['UnitsMismatch', 'UsingPointInsteadOfInterval', 'SlopeSignConfusion'],
            $val$A car’s distance from home (in miles) after $t$ hours is $D(t)$. Which quantity best represents the average speed of the car from $t=2$ to $t=5$?$val$,
            $val$\text{Average speed on }[2,5]=\frac{D(5)-D(2)}{5-2}$val$,
            $val$[{"id": "A", "text": "$D(5)-D(2)$"}, {"id": "B", "text": "$\\displaystyle \\frac{D(5)-D(2)}{5-2}$"}, {"id": "C", "text": "$\\displaystyle \\frac{D(5)}{5}$"}, {"id": "D", "text": "$D''(2)$"}]$val$::jsonb,
            'B',
            $val$Average speed over an interval is change in distance divided by change in time: $$\frac{D(5)-D(2)}{5-2}.$$ The units are miles per hour.$val$,
            $val$ {"A": "This is total change in distance, not per hour.", "B": "Correct: secant slope (miles per hour).", "C": "This averages from $0$ to $5$, not from $2$ to $5$.", "D": "This is an instantaneous rate at $t=2$, not an average over $[2,5]$."}$val$::jsonb,
            ARRAY['Chapter 1.1: interprets average rate as slope and correct units', 'Targets common confusion between average and instantaneous'],
            'published', 1, 'Conceptual', 0.8, 'symbolic', 'Both_Limit', 'Unit1_1.1', 'NewMaoS', 2026, 'No image needed; language-based interpretation of average rate.', 0.9, 0.1, 'text', 'SKL_AverageRateOfChange', ARRAY['SKL_UnitsInterpretation']
        );
    END IF;

    -- 5. U1C1.1_DifferenceQuotient_CubicAt2
    SELECT id INTO q_id FROM public.questions WHERE title = 'U1C1.1_DifferenceQuotient_CubicAt2';
    IF q_id IS NOT NULL THEN
        UPDATE public.questions SET
            prompt = $val$Let $p(x)=x^3$. Evaluate $$\lim_{h\to 0}\frac{p(2+h)-p(2)}{h}.$$ $val$,
            latex = $val$\lim_{h\to 0}\frac{(2+h)^3-8}{h}$val$,
            options = $val$[{"id": "A", "text": "$12$"}, {"id": "B", "text": "$6$"}, {"id": "C", "text": "$8$"}, {"id": "D", "text": "$4$"}]$val$::jsonb,
            correct_option_id = 'A',
            explanation = $val$Expand: $(2+h)^3=8+12h+6h^2+h^3$. Then $$\frac{(2+h)^3-8}{h}=\frac{12h+6h^2+h^3}{h}=12+6h+h^2.$$ Taking $h\to 0$ gives $12$.$val$,
            micro_explanations = $val$ {"A": "Correct: difference quotient limit equals $12$.", "B": "This can happen if you drop the $6h^2+h^3$ terms too early and then incorrectly simplify.", "C": "This can happen if you confuse $p(2)=8$ with the limit value.", "D": "This can happen if you only keep the linear term as $4h$ due to an expansion mistake."}$val$::jsonb,
            updated_at = NOW()
        WHERE id = q_id;
    ELSE
        INSERT INTO public.questions (title, course, topic, sub_topic_id, type, calculator_allowed, difficulty, target_time_seconds, skill_tags, error_tags, prompt, latex, options, correct_option_id, explanation, micro_explanations, recommendation_reasons, status, version, reasoning_level, mastery_weight, representation_type, topic_id, section_id, source, source_year, notes, weight_primary, weight_supporting, prompt_type, primary_skill_id, supporting_skill_ids)
        VALUES (
            'U1C1.1_DifferenceQuotient_CubicAt2', 'AP_Calculus_BC', 'Both_Limits', 'Unit1_1.1', 'mcq', false, 'Level5', 135,
            ARRAY['DifferenceQuotient', 'AlgebraSimplification', 'LimitConcept'], ARRAY['CancelingNoncommonFactors', 'FactoringMistake', 'PluggingHInsteadOfLimiting'],
            $val$Let $p(x)=x^3$. Evaluate $$\lim_{h\to 0}\frac{p(2+h)-p(2)}{h}.$$ $val$,
            $val$\lim_{h\to 0}\frac{(2+h)^3-8}{h}$val$,
            $val$[{"id": "A", "text": "$12$"}, {"id": "B", "text": "$6$"}, {"id": "C", "text": "$8$"}, {"id": "D", "text": "$4$"}]$val$::jsonb,
            'A',
            $val$Expand: $(2+h)^3=8+12h+6h^2+h^3$. Then $$\frac{(2+h)^3-8}{h}=\frac{12h+6h^2+h^3}{h}=12+6h+h^2.$$ Taking $h\to 0$ gives $12$.$val$,
            $val$ {"A": "Correct: difference quotient limit equals $12$.", "B": "This can happen if you drop the $6h^2+h^3$ terms too early and then incorrectly simplify.", "C": "This can happen if you confuse $p(2)=8$ with the limit value.", "D": "This can happen if you only keep the linear term as $4h$ due to an expansion mistake."}$val$::jsonb,
            ARRAY['Chapter 1.1: connects secant-slope limit to a concrete value', 'Checks careful algebra in difference quotient'],
            'published', 1, 'Algebraic', 1.3, 'symbolic', 'Both_Limit', 'Unit1_1.1', 'NewMaoS', 2026, 'No image needed; purely symbolic limit of a difference quotient.', 0.7, 0.3, 'text', 'SKL_DifferenceQuotient', ARRAY['SKL_AlgebraicManipulation']
        );
    END IF;

    -- 6. U1C1.2_LimitNotation_Interpretation
    SELECT id INTO q_id FROM public.questions WHERE title = 'U1C1.2_LimitNotation_Interpretation';
    IF q_id IS NOT NULL THEN
        UPDATE public.questions SET
            prompt = $val$Suppose $\lim_{x\to 4} f(x)=7$. Which statement must be true?$val$,
            latex = $val$\lim_{x\to 4}f(x)=7$val$,
            options = $val$[{"id": "A", "text": "$f(4)=7$"}, {"id": "B", "text": "$f(x)=7$ for all $x$ near $4$"}, {"id": "C", "text": "For values of $x$ close to $4$ (but not necessarily equal to $4$), $f(x)$ can be made arbitrarily close to $7$."}, {"id": "D", "text": "$\\lim_{x\\to 7} f(x)=4$"}]$val$::jsonb,
            correct_option_id = 'C',
            explanation = $val$The meaning of $\lim_{x\to 4} f(x)=7$ is that as $x$ approaches $4$, the outputs $f(x)$ approach $7$; this does not force $f(4)$ to equal $7$ or $f$ to be constant near $4$.$val$,
            micro_explanations = $val$ {"A": "Not required: the limit can exist even if $f(4)$ is different or undefined.", "B": "Not required: $f(x)$ can vary and still approach $7$ as $x\\to 4$.", "C": "Correct: this is the core interpretation of a limit.", "D": "Unrelated reversal; not implied by the given limit statement."}$val$::jsonb,
            updated_at = NOW()
        WHERE id = q_id;
    ELSE
        INSERT INTO public.questions (title, course, topic, sub_topic_id, type, calculator_allowed, difficulty, target_time_seconds, skill_tags, error_tags, prompt, latex, options, correct_option_id, explanation, micro_explanations, recommendation_reasons, status, version, reasoning_level, mastery_weight, representation_type, topic_id, section_id, source, source_year, notes, weight_primary, weight_supporting, prompt_type, primary_skill_id, supporting_skill_ids)
        VALUES (
            'U1C1.2_LimitNotation_Interpretation', 'AP_Calculus_BC', 'Both_Limits', 'Unit1_1.2', 'mcq', false, 'Level2', 75,
            ARRAY['LimitNotation', 'LimitConcept'], ARRAY['ConfusingFunctionValueWithLimit', 'LeftRightMixUp', 'AssumingLimitExists'],
            $val$Suppose $\lim_{x\to 4} f(x)=7$. Which statement must be true?$val$,
            $val$\lim_{x\to 4}f(x)=7$val$,
            $val$[{"id": "A", "text": "$f(4)=7$"}, {"id": "B", "text": "$f(x)=7$ for all $x$ near $4$"}, {"id": "C", "text": "For values of $x$ close to $4$ (but not necessarily equal to $4$), $f(x)$ can be made arbitrarily close to $7$."}, {"id": "D", "text": "$\\lim_{x\\to 7} f(x)=4$"}]$val$::jsonb,
            'C',
            $val$The meaning of $\lim_{x\to 4} f(x)=7$ is that as $x$ approaches $4$, the outputs $f(x)$ approach $7$; this does not force $f(4)$ to equal $7$ or $f$ to be constant near $4$.$val$,
            $val$ {"A": "Not required: the limit can exist even if $f(4)$ is different or undefined.", "B": "Not required: $f(x)$ can vary and still approach $7$ as $x\\to 4$.", "C": "Correct: this is the core interpretation of a limit.", "D": "Unrelated reversal; not implied by the given limit statement."}$val$::jsonb,
            ARRAY['Chapter 1.2: interprets limit notation precisely', 'Targets the common confusion between limit value and function value'],
            'published', 1, 'Conceptual', 1.0, 'symbolic', 'Both_Limit', 'Unit1_1.2', 'NewMaoS', 2026, 'No image needed; focuses on correct interpretation of limit notation.', 0.8, 0.2, 'text', 'SKL_LimitNotation', ARRAY['SKL_LimitConcept']
        );
    END IF;

    -- 7. U1C1.2_OneSidedLimits_AbsRatio
    SELECT id INTO q_id FROM public.questions WHERE title = 'U1C1.2_OneSidedLimits_AbsRatio';
    IF q_id IS NOT NULL THEN
        UPDATE public.questions SET
            prompt = $val$For $x\ne 1$, define $$f(x)=\frac{|x-1|}{x-1}.$$ Which statement is correct?$val$,
            latex = $val$f(x)=\frac{|x-1|}{x-1},\ x\ne 1$val$,
            options = $val$[{"id": "A", "text": "$\\displaystyle \\lim_{x\\to 1} f(x)=1$"}, {"id": "B", "text": "$\\displaystyle \\lim_{x\\to 1} f(x)=-1$"}, {"id": "C", "text": "$\\displaystyle \\lim_{x\\to 1^-} f(x)=-1$ and \\displaystyle \\lim_{x\\to 1^+} f(x)=1$"}, {"id": "D", "text": "$f(1)=0$"}]$val$::jsonb,
            correct_option_id = 'C', -- Manually corrected from 'B' to match explanation logic
            explanation = $val$For $x>1$, $|x-1|=x-1$ so $f(x)=1$. For $x<1$, $|x-1|=-(x-1)$ so $f(x)=-1$. Thus $$\lim_{x\to 1^-}f(x)=-1,\quad \lim_{x\to 1^+}f(x)=1,$$ so the two-sided limit does not exist.$val$,
            micro_explanations = $val$ {"A": "Two-sided limit does not exist because left and right limits differ.", "B": "Incorrect: the two-sided limit does not equal $-1$; only the left-hand limit is $-1$.", "C": "Correct: left-hand is $-1$, right-hand is $1$.", "D": "$f(1)$ is not defined by the given definition ($x\\ne 1$)."}$val$::jsonb,
            updated_at = NOW()
        WHERE id = q_id;
    ELSE
        INSERT INTO public.questions (title, course, topic, sub_topic_id, type, calculator_allowed, difficulty, target_time_seconds, skill_tags, error_tags, prompt, latex, options, correct_option_id, explanation, micro_explanations, recommendation_reasons, status, version, reasoning_level, mastery_weight, representation_type, topic_id, section_id, source, source_year, notes, weight_primary, weight_supporting, prompt_type, primary_skill_id, supporting_skill_ids)
        VALUES (
            'U1C1.2_OneSidedLimits_AbsRatio', 'AP_Calculus_BC', 'Both_Limits', 'Unit1_1.2', 'mcq', false, 'Level3', 90,
            ARRAY['OneSidedLimits', 'LimitExistence'], ARRAY['LeftRightMixUp', 'AssumingLimitExists', 'ConfusingFunctionValueWithLimit'],
            $val$For $x\ne 1$, define $$f(x)=\frac{|x-1|}{x-1}.$$ Which statement is correct?$val$,
            $val$f(x)=\frac{|x-1|}{x-1},\ x\ne 1$val$,
            $val$[{"id": "A", "text": "$\\displaystyle \\lim_{x\\to 1} f(x)=1$"}, {"id": "B", "text": "$\\displaystyle \\lim_{x\\to 1} f(x)=-1$"}, {"id": "C", "text": "$\\displaystyle \\lim_{x\\to 1^-} f(x)=-1$ and \\displaystyle \\lim_{x\\to 1^+} f(x)=1$"}, {"id": "D", "text": "$f(1)=0$"}]$val$::jsonb,
            'C', -- Manually corrected from 'B'
            $val$For $x>1$, $|x-1|=x-1$ so $f(x)=1$. For $x<1$, $|x-1|=-(x-1)$ so $f(x)=-1$. Thus $$\lim_{x\to 1^-}f(x)=-1,\quad \lim_{x\to 1^+}f(x)=1,$$ so the two-sided limit does not exist.$val$,
            $val$ {"A": "Two-sided limit does not exist because left and right limits differ.", "B": "Incorrect: the two-sided limit does not equal $-1$; only the left-hand limit is $-1$.", "C": "Correct: left-hand is $-1$, right-hand is $1$.", "D": "$f(1)$ is not defined by the given definition ($x\\ne 1$)."}$val$::jsonb,
            ARRAY['Chapter 1.2: distinguishes one-sided vs two-sided limits', 'Classic absolute-value sign analysis'],
            'published', 1, 'Conceptual', 1.1, 'symbolic', 'Both_Limit', 'Unit1_1.2', 'NewMaoS', 2026, 'No image needed; sign analysis for one-sided limits.', 0.7, 0.3, 'text', 'SKL_OneSidedLimits', ARRAY['SKL_LimitExistence']
        );
    END IF;

    -- 8. U1C1.2_LimitLaws_ShiftByConstant
    SELECT id INTO q_id FROM public.questions WHERE title = 'U1C1.2_LimitLaws_ShiftByConstant';
    IF q_id IS NOT NULL THEN
        UPDATE public.questions SET
            prompt = $val$If $\lim_{x\to 2} (f(x)-3)=5$, what is $\lim_{x\to 2} f(x)$?$val$,
            latex = $val$\lim_{x\to 2}(f(x)-3)=5$val$,
            options = $val$[{"id": "A", "text": "$2$"}, {"id": "B", "text": "$8$"}, {"id": "C", "text": "$5$"}, {"id": "D", "text": "$-8$"}]$val$::jsonb,
            correct_option_id = 'B',
            explanation = $val$Use limit laws: $$\lim_{x\to 2}(f(x)-3)=\lim_{x\to 2}f(x)-3=5,$$ so $\lim_{x\to 2}f(x)=8$.$val$,
            micro_explanations = $val$ {"A": "This can happen if you subtract instead of add back the $3$.", "B": "Correct: add $3$ to both sides of the limit equation.", "C": "This is the given limit value of $f(x)-3$, not of $f(x)$.", "D": "This can happen from sign mistakes (treating $-3$ incorrectly)."}$val$::jsonb,
            updated_at = NOW()
        WHERE id = q_id;
    ELSE
        INSERT INTO public.questions (title, course, topic, sub_topic_id, type, calculator_allowed, difficulty, target_time_seconds, skill_tags, error_tags, prompt, latex, options, correct_option_id, explanation, micro_explanations, recommendation_reasons, status, version, reasoning_level, mastery_weight, representation_type, topic_id, section_id, source, source_year, notes, weight_primary, weight_supporting, prompt_type, primary_skill_id, supporting_skill_ids)
        VALUES (
            'U1C1.2_LimitLaws_ShiftByConstant', 'AP_Calculus_BC', 'Both_Limits', 'Unit1_1.2', 'mcq', false, 'Level4', 105,
            ARRAY['LimitNotation', 'LimitLaws', 'DirectSubstitution'], ARRAY['DomainRestrictionIgnored', 'ConfusingFunctionValueWithLimit', 'ArithmeticSlip'],
            $val$If $\lim_{x\to 2} (f(x)-3)=5$, what is $\lim_{x\to 2} f(x)$?$val$,
            $val$\lim_{x\to 2}(f(x)-3)=5$val$,
            $val$[{"id": "A", "text": "$2$"}, {"id": "B", "text": "$8$"}, {"id": "C", "text": "$5$"}, {"id": "D", "text": "$-8$"}]$val$::jsonb,
            'B',
            $val$Use limit laws: $$\lim_{x\to 2}(f(x)-3)=\lim_{x\to 2}f(x)-3=5,$$ so $\lim_{x\to 2}f(x)=8$.$val$,
            $val$ {"A": "This can happen if you subtract instead of add back the $3$.", "B": "Correct: add $3$ to both sides of the limit equation.", "C": "This is the given limit value of $f(x)-3$, not of $f(x)$.", "D": "This can happen from sign mistakes (treating $-3$ incorrectly)."}$val$::jsonb,
            ARRAY['Chapter 1.2: fluent translation between limit statements using laws', 'Targets a common algebra/sign slip'],
            'published', 1, 'Procedural', 1.1, 'symbolic', 'Both_Limit', 'Unit1_1.2', 'NewMaoS', 2026, 'No image needed; pure limit-law manipulation.', 0.7, 0.3, 'text', 'SKL_LimitLaws', ARRAY['SKL_LimitNotation']
        );
    END IF;

    -- 9. U1C1.2_Notation_LeftHandLimit
    SELECT id INTO q_id FROM public.questions WHERE title = 'U1C1.2_Notation_LeftHandLimit';
    IF q_id IS NOT NULL THEN
        UPDATE public.questions SET
            prompt = $val$Which notation correctly describes “the left-hand limit of $f(x)$ as $x$ approaches $5$”?$val$,
            latex = $val$\text{Left-hand limit at }x=5$val$,
            options = $val$[{"id": "A", "text": "$\\displaystyle \\lim_{x\\to 5^+} f(x)$"}, {"id": "B", "text": "$\\displaystyle \\lim_{x\\to 5^-} f(x)$"}, {"id": "C", "text": "$\\displaystyle \\lim_{x\\to 5} f(5)$"}, {"id": "D", "text": "$\\displaystyle \\lim_{f(x)\\to 5^-} x$"}]$val$::jsonb,
            correct_option_id = 'B',
            explanation = $val$Approaching from the left uses $5^-$, so the left-hand limit is $$\lim_{x\to 5^-} f(x).$$ $val$,
            micro_explanations = $val$ {"A": "$5^+$ is the right-hand limit, not left-hand.", "B": "Correct: $x\\to 5^-$ means values less than $5$ approaching $5$.", "C": "This incorrectly treats $f(5)$ as varying and misuses limit notation.", "D": "This reverses the roles of input and output and is not standard for one-sided limits."}$val$::jsonb,
            updated_at = NOW()
        WHERE id = q_id;
    ELSE
        INSERT INTO public.questions (title, course, topic, sub_topic_id, type, calculator_allowed, difficulty, target_time_seconds, skill_tags, error_tags, prompt, latex, options, correct_option_id, explanation, micro_explanations, recommendation_reasons, status, version, reasoning_level, mastery_weight, representation_type, topic_id, section_id, source, source_year, notes, weight_primary, weight_supporting, prompt_type, primary_skill_id, supporting_skill_ids)
        VALUES (
            'U1C1.2_Notation_LeftHandLimit', 'AP_Calculus_BC', 'Both_Limits', 'Unit1_1.2', 'mcq', false, 'Level1', 60,
            ARRAY['LimitNotation', 'OneSidedLimits'], ARRAY['LeftRightMixUp', 'AssumingLimitExists', 'ConfusingArrowDirection'],
            $val$Which notation correctly describes “the left-hand limit of $f(x)$ as $x$ approaches $5$”?$val$,
            $val$\text{Left-hand limit at }x=5$val$,
            $val$[{"id": "A", "text": "$\\displaystyle \\lim_{x\\to 5^+} f(x)$"}, {"id": "B", "text": "$\\displaystyle \\lim_{x\\to 5^-} f(x)$"}, {"id": "C", "text": "$\\displaystyle \\lim_{x\\to 5} f(5)$"}, {"id": "D", "text": "$\\displaystyle \\lim_{f(x)\\to 5^-} x$"}]$val$::jsonb,
            'B',
            $val$Approaching from the left uses $5^-$, so the left-hand limit is $$\lim_{x\to 5^-} f(x).$$ $val$,
            $val$ {"A": "$5^+$ is the right-hand limit, not left-hand.", "B": "Correct: $x\\to 5^-$ means values less than $5$ approaching $5$.", "C": "This incorrectly treats $f(5)$ as varying and misuses limit notation.", "D": "This reverses the roles of input and output and is not standard for one-sided limits."}$val$::jsonb,
            ARRAY['Chapter 1.2: precise limit notation fluency', 'Quick check for left/right symbol accuracy'],
            'published', 1, 'Recall', 0.7, 'symbolic', 'Both_Limit', 'Unit1_1.2', 'NewMaoS', 2026, 'No image needed; notation recognition.', 0.9, 0.1, 'text', 'SKL_LimitNotation', ARRAY['SKL_OneSidedLimits']
        );
    END IF;

    -- 10. U1C1.2_LimitExistence_PiecewiseAt0
    SELECT id INTO q_id FROM public.questions WHERE title = 'U1C1.2_LimitExistence_PiecewiseAt0';
    IF q_id IS NOT NULL THEN
        UPDATE public.questions SET
            prompt = $val$Define $$f(x)=\begin{cases}2x+1,& x<0\\ x^2,& x\ge 0\end{cases}$$ What is $\lim_{x\to 0} f(x)$?$val$,
            latex = $val$f(x)=\begin{cases}2x+1,& x<0\\ x^2,& x\ge 0\end{cases}$val$,
            options = $val$[{"id": "A", "text": "$0$"}, {"id": "B", "text": "$1$"}, {"id": "C", "text": "Does not exist"}, {"id": "D", "text": "$2$"}]$val$::jsonb,
            correct_option_id = 'C',
            explanation = $val$Compute one-sided limits: for $x\to 0^-$, $f(x)=2x+1\to 1$. For $x\to 0^+$, $f(x)=x^2\to 0$. Since $1\ne 0$, the two-sided limit does not exist.$val$,
            micro_explanations = $val$ {"A": "This is the right-hand limit ($x\\to 0^+$), not the two-sided limit.", "B": "This is the left-hand limit ($x\\to 0^-$), not the two-sided limit.", "C": "Correct: unequal one-sided limits imply the two-sided limit does not exist.", "D": "This can happen if you mistakenly substitute $x=1$ or confuse expressions across branches."}$val$::jsonb,
            updated_at = NOW()
        WHERE id = q_id;
    ELSE
        INSERT INTO public.questions (title, course, topic, sub_topic_id, type, calculator_allowed, difficulty, target_time_seconds, skill_tags, error_tags, prompt, latex, options, correct_option_id, explanation, micro_explanations, recommendation_reasons, status, version, reasoning_level, mastery_weight, representation_type, topic_id, section_id, source, source_year, notes, weight_primary, weight_supporting, prompt_type, primary_skill_id, supporting_skill_ids)
        VALUES (
            'U1C1.2_LimitExistence_PiecewiseAt0', 'AP_Calculus_BC', 'Both_Limits', 'Unit1_1.2', 'mcq', false, 'Level5', 120,
            ARRAY['LimitExistence', 'OneSidedLimits', 'PiecewiseAnalysis'], ARRAY['LeftRightMixUp', 'AssumingLimitExists', 'ConfusingFunctionValueWithLimit'],
            $val$Define $$f(x)=\begin{cases}2x+1,& x<0\\ x^2,& x\ge 0\end{cases}$$ What is $\lim_{x\to 0} f(x)$?$val$,
            $val$f(x)=\begin{cases}2x+1,& x<0\\ x^2,& x\ge 0\end{cases}$val$,
            $val$[{"id": "A", "text": "$0$"}, {"id": "B", "text": "$1$"}, {"id": "C", "text": "Does not exist"}, {"id": "D", "text": "$2$"}]$val$::jsonb,
            'C',
            $val$Compute one-sided limits: for $x\to 0^-$, $f(x)=2x+1\to 1$. For $x\to 0^+$, $f(x)=x^2\to 0$. Since $1\ne 0$, the two-sided limit does not exist.$val$,
            $val$ {"A": "This is the right-hand limit ($x\\to 0^+$), not the two-sided limit.", "B": "This is the left-hand limit ($x\\to 0^-$), not the two-sided limit.", "C": "Correct: unequal one-sided limits imply the two-sided limit does not exist.", "D": "This can happen if you mistakenly substitute $x=1$ or confuse expressions across branches."}$val$::jsonb,
            ARRAY['Chapter 1.2: tests existence via matching one-sided limits', 'High-value piecewise limit skill for AP-style questions'],
            'published', 1, 'Conceptual', 1.3, 'symbolic', 'Both_Limit', 'Unit1_1.2', 'NewMaoS', 2026, 'No image needed; piecewise one-sided limit comparison.', 0.7, 0.3, 'text', 'SKL_LimitExistence', ARRAY['SKL_PiecewiseAnalysis', 'SKL_OneSidedLimits']
        );
    END IF;

END $do$;

COMMIT;
