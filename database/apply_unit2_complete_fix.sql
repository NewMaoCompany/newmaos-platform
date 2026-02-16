-- Consolidated Unit 2 Unit Test Fix Script (v7 - FINAL - REALLY)
-- Title Correction: WHERE title = '2.0-UT-Qx'
-- Reverted Skills/Tags Unit to 'Unit 2' as requested.
-- Relations Sync: Handled 'primary' vs 'supporting' role constraint.
-- COLUMNS SYNC: Explicitly updates primary_skill_id and supporting_skill_ids columns.

BEGIN;

-- 1. Insert/Update Uppercase Skills
INSERT INTO public.skills (id, name, unit, prerequisites)
VALUES
  ('SK_AVG_ROC', 'Average Rate of Change', 'Unit 2', '{}'),
  ('SK_DERIV_NOTATION', 'Derivative Notation', 'Unit 2', '{}'),
  ('SK_FUNC_EVAL', 'Function Evaluation', 'Unit 2', '{}'),
  ('SK_POWER_RULE', 'Power Rule', 'Unit 2', '{}'),
  ('SK_TRIG_DERIV', 'Derivatives of Sine and Cosine', 'Unit 2', '{}'),
  ('SK_ALGEBRA_SIMPLIFY', 'Algebraic Simplification', 'Unit 2', '{}'),
  ('SK_LOG_DERIV', 'Derivative of Natural Logarithm', 'Unit 2', '{}'),
  ('SK_SLOPE_2PTS', 'Slope Between Two Points', 'Unit 2', '{"SK_AVG_ROC"}'),
  ('SK_INST_ROC', 'Instantaneous Rate of Change', 'Unit 2', '{"SK_AVG_ROC"}'),
  ('SK_DERIV_ESTIMATE_NUMERICAL', 'Estimating Derivatives Numerically', 'Unit 2', '{"SK_AVG_ROC"}'),
  ('SK_LINEARTY', 'Linearity of Differentiation', 'Unit 2', '{"SK_POWER_RULE"}'),
  ('SK_DIFF_CONT', 'Differentiability implies Continuity', 'Unit 2', '{}'),
  ('SK_OTHER_TRIG', 'Derivatives of Other Trig Functions', 'Unit 2', '{"SK_TRIG_DERIV"}'),
  ('SK_LIMIT_DEF', 'Limit Definition of Derivative', 'Unit 2', '{"SK_DERIV_ESTIMATE_NUMERICAL"}'),
  ('SK_GRAPH_READ', 'Reading Derivatives from Graphs', 'Unit 2', '{"SK_INST_ROC"}'),
  ('SK_TABLE_READ', 'Reading Derivatives from Tables', 'Unit 2', '{"SK_DERIV_ESTIMATE_NUMERICAL"}'),
  ('SK_PRODUCT_RULE', 'Product Rule', 'Unit 2', '{"SK_LINEARTY", "SK_POWER_RULE"}'),
  ('SK_QUOTIENT_RULE', 'The Quotient Rule', 'Unit 2', '{"SK_LINEARTY", "SK_POWER_RULE"}')
ON CONFLICT (id) 
DO UPDATE SET 
  unit = EXCLUDED.unit,
  prerequisites = EXCLUDED.prerequisites;

-- 2. Insert/Update Uppercase Error Tags
INSERT INTO public.error_tags (id, name, category, severity, unit)
VALUES
  ('E_AVG_VS_INST', 'Confusing Average vs Instantaneous Rate', 'Conceptual', 3, 'Unit 2'),
  ('E_SIGN_ERROR', 'Sign Error', 'Algebra', 2, 'Unit 2'),
  ('E_NOTATION_MISMATCH', 'Derivative Notation Mismatch', 'Notation', 2, 'Unit 2'),
  ('E_PLUG_H_EQUALS_0', 'Incorrectly Plugging h=0 (Undefined)', 'Limit Definition', 3, 'Unit 2'),
  ('E_SECANT_TANGENT_CONFUSION', 'Confusing Secant and Tangent Lines', 'Conceptual', 3, 'Unit 2'),
  ('E_GRAPH_READ', 'Misreading Graph / Coordinates', 'Graphing', 2, 'Unit 2'),
  ('E_DIFF_IMPLIES_CONT', 'Misunderstanding Differentiability Implies Continuity', 'Conceptual', 4, 'Unit 2'),
  ('E_VALUE_VS_DERIV', 'Confusing Function Value with Derivative Value', 'Conceptual', 3, 'Unit 2'),
  ('E_RULE_MISAPPLIED', 'Differentiation Rule Misapplied', 'Procedural', 3, 'Unit 2'),
  ('E_TABLE_READ', 'Misreading Table Values', 'Data Interpretation', 2, 'Unit 2'),
  ('E_ARITH_ERROR', 'Arithmetic Error', 'Algebra', 1, 'Unit 2'),
  ('E_CORNER_DIFF', 'Differentiability at a Corner/Cusp', 'Conceptual', 3, 'Unit 2'),
  ('E_ONE_SIDED_ONLY', 'Using Only One-Sided Derivative', 'Conceptual', 3, 'Unit 2'),
  ('E_TRIG_MIXUP', 'Confusing Trig Derivatives (e.g. sin vs cos)', 'Procedural', 3, 'Unit 2'),
  ('E_LOG_DERIV_CONFUSION', 'Confusing Log Deriv Rules', 'Procedural', 3, 'Unit 2')
ON CONFLICT (id) 
DO UPDATE SET 
  unit = EXCLUDED.unit;

-- 3. Update Questions (Now with primary_skill_id and supporting_skill_ids)
UPDATE public.questions SET primary_skill_id = 'SK_AVG_ROC', supporting_skill_ids = ARRAY['SK_FUNC_EVAL'], skill_tags = ARRAY['SK_AVG_ROC','SK_FUNC_EVAL'], error_tags = ARRAY['E_AVG_VS_INST','E_SIGN_ERROR'], prompt = 'A particle’s position is $s(t)=t^2-4t$ (meters). What is the average velocity on $[1,3]$?', updated_at = NOW() WHERE title = '2.0-UT-Q1';

UPDATE public.questions SET primary_skill_id = 'SK_LIMIT_DEF', supporting_skill_ids = ARRAY['SK_DERIV_NOTATION'], skill_tags = ARRAY['SK_LIMIT_DEF','SK_DERIV_NOTATION'], error_tags = ARRAY['E_NOTATION_MISMATCH','E_PLUG_H_EQUALS_0'], prompt = 'Let $f(x)=\sqrt{x}$. Which expression represents $f''(9)$ using the limit definition?', updated_at = NOW() WHERE title = '2.0-UT-Q2';

UPDATE public.questions SET primary_skill_id = 'SK_GRAPH_READ', supporting_skill_ids = ARRAY['SK_AVG_ROC'], skill_tags = ARRAY['SK_GRAPH_READ','SK_AVG_ROC'], error_tags = ARRAY['E_SECANT_TANGENT_CONFUSION','E_GRAPH_READ','E_SIGN_ERROR'], prompt = 'Use the graph (with two marked points). What is the slope of the secant line through the two marked points?', updated_at = NOW() WHERE title = '2.0-UT-Q3';

UPDATE public.questions SET primary_skill_id = 'SK_DIFF_CONT', supporting_skill_ids = ARRAY[]::text[], skill_tags = ARRAY['SK_DIFF_CONT'], error_tags = ARRAY['E_DIFF_IMPLIES_CONT','E_VALUE_VS_DERIV'], prompt = 'Which statement is always true if $f''(a)$ exists?', updated_at = NOW() WHERE title = '2.0-UT-Q4';

UPDATE public.questions SET primary_skill_id = 'SK_POWER_RULE', supporting_skill_ids = ARRAY['SK_ALGEBRA_SIMPLIFY'], skill_tags = ARRAY['SK_POWER_RULE','SK_ALGEBRA_SIMPLIFY'], error_tags = ARRAY['E_RULE_MISAPPLIED','E_SIGN_ERROR'], prompt = 'If $f(x)=3x^{5}-\dfrac{2}{x^{2}}$, what is $f''(x)$?', updated_at = NOW() WHERE title = '2.0-UT-Q5';

UPDATE public.questions SET primary_skill_id = 'SK_TABLE_READ', supporting_skill_ids = ARRAY['SK_INST_ROC'], skill_tags = ARRAY['SK_TABLE_READ','SK_INST_ROC'], error_tags = ARRAY['E_TABLE_READ','E_AVG_VS_INST','E_ARITH_ERROR'], prompt = 'Use the table to estimate $f''(2)$ using a symmetric difference.', updated_at = NOW() WHERE title = '2.0-UT-Q6';

UPDATE public.questions SET primary_skill_id = 'SK_LINEARTY', supporting_skill_ids = ARRAY[]::text[], skill_tags = ARRAY['SK_LINEARTY'], error_tags = ARRAY['E_RULE_MISAPPLIED','E_NOTATION_MISMATCH'], prompt = 'If $g(x)=5f(x)-2h(x)$, $f''(x)=3x$, and $h''(x)=x^2$, what is $g''(x)$?', updated_at = NOW() WHERE title = '2.0-UT-Q7';

UPDATE public.questions SET primary_skill_id = 'SK_DIFF_CONT', supporting_skill_ids = ARRAY['SK_GRAPH_READ'], skill_tags = ARRAY['SK_DIFF_CONT','SK_GRAPH_READ'], error_tags = ARRAY['E_CORNER_DIFF','E_ONE_SIDED_ONLY'], prompt = 'Use the graph of $y=|x|$. Which statement is true about the derivative at $x=0$?', updated_at = NOW() WHERE title = '2.0-UT-Q8';

UPDATE public.questions SET primary_skill_id = 'SK_TRIG_DERIV', supporting_skill_ids = ARRAY[]::text[], skill_tags = ARRAY['SK_TRIG_DERIV'], error_tags = ARRAY['E_TRIG_MIXUP','E_SIGN_ERROR'], prompt = 'What is $\dfrac{d}{dx}(\cos x)$?', updated_at = NOW() WHERE title = '2.0-UT-Q9';

UPDATE public.questions SET primary_skill_id = 'SK_PRODUCT_RULE', supporting_skill_ids = ARRAY['SK_TRIG_DERIV'], skill_tags = ARRAY['SK_PRODUCT_RULE','SK_TRIG_DERIV'], error_tags = ARRAY['E_RULE_MISAPPLIED','E_TRIG_MIXUP'], prompt = 'Find $\dfrac{d}{dx}\big(x^2\sin x\big)$.', updated_at = NOW() WHERE title = '2.0-UT-Q10';

UPDATE public.questions SET primary_skill_id = 'SK_QUOTIENT_RULE', supporting_skill_ids = ARRAY['SK_ALGEBRA_SIMPLIFY'], skill_tags = ARRAY['SK_QUOTIENT_RULE','SK_ALGEBRA_SIMPLIFY'], error_tags = ARRAY['E_RULE_MISAPPLIED','E_SIGN_ERROR'], prompt = 'Find $\dfrac{d}{dx}\left(\dfrac{x^2+1}{x}\right)$.', updated_at = NOW() WHERE title = '2.0-UT-Q11';

UPDATE public.questions SET primary_skill_id = 'SK_OTHER_TRIG', supporting_skill_ids = ARRAY[]::text[], skill_tags = ARRAY['SK_OTHER_TRIG'], error_tags = ARRAY['E_TRIG_MIXUP'], prompt = 'What is $\dfrac{d}{dx}(\sec x)$?', updated_at = NOW() WHERE title = '2.0-UT-Q12';

UPDATE public.questions SET primary_skill_id = 'SK_LIMIT_DEF', supporting_skill_ids = ARRAY['SK_ALGEBRA_SIMPLIFY'], skill_tags = ARRAY['SK_LIMIT_DEF','SK_ALGEBRA_SIMPLIFY'], error_tags = ARRAY['E_PLUG_H_EQUALS_0','E_ARITH_ERROR'], prompt = 'Evaluate $\displaystyle \lim_{h\to 0}\frac{(2+h)^3-8}{h}$.', updated_at = NOW() WHERE title = '2.0-UT-Q13';

UPDATE public.questions SET primary_skill_id = 'SK_GRAPH_READ', supporting_skill_ids = ARRAY['SK_TRIG_DERIV'], skill_tags = ARRAY['SK_GRAPH_READ','SK_TRIG_DERIV'], error_tags = ARRAY['E_VALUE_VS_DERIV','E_GRAPH_READ'], prompt = 'Use the graph of $y=\sin x$ with a dashed tangent line at $x=0$. What is $\sin''(0)$?', updated_at = NOW() WHERE title = '2.0-UT-Q14';

UPDATE public.questions SET primary_skill_id = 'SK_LINEARTY', supporting_skill_ids = ARRAY['SK_POWER_RULE'], skill_tags = ARRAY['SK_LINEARTY','SK_POWER_RULE'], error_tags = ARRAY['E_RULE_MISAPPLIED'], prompt = 'If $p(x)=x^4+7$, what is $\dfrac{d}{dx}\big(3p(x)\big)$?', updated_at = NOW() WHERE title = '2.0-UT-Q15';

UPDATE public.questions SET primary_skill_id = 'SK_LOG_DERIV', supporting_skill_ids = ARRAY[]::text[], skill_tags = ARRAY['SK_LOG_DERIV'], error_tags = ARRAY['E_LOG_DERIV_CONFUSION'], prompt = 'What is $\dfrac{d}{dx}(\ln x)$ for $x>0$?', updated_at = NOW() WHERE title = '2.0-UT-Q16';

UPDATE public.questions SET primary_skill_id = 'SK_OTHER_TRIG', supporting_skill_ids = ARRAY[]::text[], skill_tags = ARRAY['SK_OTHER_TRIG'], error_tags = ARRAY['E_TRIG_MIXUP','E_SIGN_ERROR'], prompt = 'What is $\dfrac{d}{dx}(\csc x)$?', updated_at = NOW() WHERE title = '2.0-UT-Q17';

UPDATE public.questions SET primary_skill_id = 'SK_PRODUCT_RULE', supporting_skill_ids = ARRAY[]::text[], skill_tags = ARRAY['SK_PRODUCT_RULE'], error_tags = ARRAY['E_RULE_MISAPPLIED'], prompt = 'If $y=(x^3-1)(x^2+2)$, what is $y''$?', updated_at = NOW() WHERE title = '2.0-UT-Q18';

UPDATE public.questions SET primary_skill_id = 'SK_QUOTIENT_RULE', supporting_skill_ids = ARRAY['SK_TRIG_DERIV'], skill_tags = ARRAY['SK_QUOTIENT_RULE','SK_TRIG_DERIV'], error_tags = ARRAY['E_RULE_MISAPPLIED','E_SIGN_ERROR','E_TRIG_MIXUP'], prompt = 'Find $\dfrac{d}{dx}\left(\dfrac{\sin x}{x}\right)$ for $x\ne 0$.', updated_at = NOW() WHERE title = '2.0-UT-Q19';

UPDATE public.questions SET primary_skill_id = 'SK_POWER_RULE', supporting_skill_ids = ARRAY['SK_ALGEBRA_SIMPLIFY'], skill_tags = ARRAY['SK_POWER_RULE','SK_ALGEBRA_SIMPLIFY'], error_tags = ARRAY['E_RULE_MISAPPLIED','E_SIGN_ERROR'], prompt = 'If $f(x)=\dfrac{1}{\sqrt{x}}$ for $x>0$, what is $f''(x)$?', updated_at = NOW() WHERE title = '2.0-UT-Q20';

-- 4. Sync Table question_skills (with Primary Constraint Handling)
DELETE FROM question_skills
WHERE question_id IN (
    SELECT id FROM questions WHERE title LIKE '2.0-UT-Q%'
);

-- Insert PRIMARY skills (First in array)
INSERT INTO question_skills (question_id, skill_id, role)
SELECT id, skill_tags[1], 'primary'
FROM questions 
WHERE title LIKE '2.0-UT-Q%' AND array_length(skill_tags, 1) >= 1;

-- Insert SUPPORTING skills (Rest of array)
INSERT INTO question_skills (question_id, skill_id, role)
SELECT id, unnest(skill_tags[2:]), 'supporting'
FROM questions
WHERE title LIKE '2.0-UT-Q%' AND array_length(skill_tags, 1) >= 2;

COMMIT;
