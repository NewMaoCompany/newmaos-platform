-- Restore Unit 1.3 and 1.4 Prompts (UPDATE ONLY)
BEGIN;

-- Update C3Q1_LeftHandLimitAt2 (3e778fee-ed46-4ce9-9957-0f98aab05d85)
UPDATE questions SET 
    prompt = '["Use the graph to evaluate the limit.\n\nFind $\\displaystyle \\lim_{x\\to 2^-} f(x)$.", "https://xzpjlnkirboevkjzitcx.supabase.co/storage/v1/object/public/images/questions/86dbe22f-71af-436d-b619-ccbd46c1cd3d/1770526960043_mbny6.jpg"]'::jsonb
WHERE id = '3e778fee-ed46-4ce9-9957-0f98aab05d85' AND title = 'C3Q1_LeftHandLimitAt2';

-- Update C3Q2_TwoSidedLimitJumpAt1 (8a0ad35f-00a0-488e-875e-e3cc3be3279e)
UPDATE questions SET 
    prompt = '["Use the graph to evaluate the limit.\n\nFind $\\displaystyle \\lim_{x\\to 1} f(x)$.", "https://xzpjlnkirboevkjzitcx.supabase.co/storage/v1/object/public/images/questions/86dbe22f-71af-436d-b619-ccbd46c1cd3d/1770526969705_rz4ie6.jpg"]'::jsonb
WHERE id = '8a0ad35f-00a0-488e-875e-e3cc3be3279e' AND title = 'C3Q2_TwoSidedLimitJumpAt1';

-- Update C3Q3_InfiniteLimitAt0Plus (ddab50a0-a3fc-4ea4-910d-0b38bf5de730)
UPDATE questions SET 
    prompt = '["Use the graph to evaluate the limit.\n\nFind $\\displaystyle \\lim_{x\\to 0^+} f(x)$.", "https://xzpjlnkirboevkjzitcx.supabase.co/storage/v1/object/public/images/questions/86dbe22f-71af-436d-b619-ccbd46c1cd3d/1770526991306_zkhj2j.jpg"]'::jsonb
WHERE id = 'ddab50a0-a3fc-4ea4-910d-0b38bf5de730' AND title = 'C3Q3_InfiniteLimitAt0Plus';

-- Update C3Q4_RemovableDiscontinuityAtMinus1 (adc81ac2-cfc7-4e33-b3df-345b6e79ae16)
UPDATE questions SET 
    prompt = '["Use the graph to evaluate the limit.\n\nFind $\\displaystyle \\lim_{x\\to -1} f(x)$.", "https://xzpjlnkirboevkjzitcx.supabase.co/storage/v1/object/public/images/questions/86dbe22f-71af-436d-b619-ccbd46c1cd3d/1770526984898_rvoxom.jpg"]'::jsonb
WHERE id = 'adc81ac2-cfc7-4e33-b3df-345b6e79ae16' AND title = 'C3Q4_RemovableDiscontinuityAtMinus1';

-- Update C3Q5_RightHandLimitAt0 (e432e2fb-7cd6-4257-bbb4-d503e8ca9056)
UPDATE questions SET 
    prompt = '["Use the graph to evaluate the limit.\n\nFind $\\displaystyle \\lim_{x\\to 0^+} f(x)$.", "https://xzpjlnkirboevkjzitcx.supabase.co/storage/v1/object/public/images/questions/86dbe22f-71af-436d-b619-ccbd46c1cd3d/1770526997091_u056z.jpg"]'::jsonb
WHERE id = 'e432e2fb-7cd6-4257-bbb4-d503e8ca9056' AND title = 'C3Q5_RightHandLimitAt0';

-- Update C4Q1_TableLimitApproaches6 (f625c885-89ec-4710-97bd-12c5b697f4be)
UPDATE questions SET 
    prompt = '["A function $f$ is defined near $x=3$. Use the table to estimate $\\displaystyle \\lim_{x\\to 3} f(x)$.\n\n$$\n\\begin{array}{c|cccccc}\nx & 2.9 & 2.99 & 2.999 & 3.001 & 3.01 & 3.1\\\\ \\hline\nf(x) & 5.7 & 5.97 & 5.997 & 6.003 & 6.03 & 6.3\n\\end{array}\n$$"]'::jsonb
WHERE id = 'f625c885-89ec-4710-97bd-12c5b697f4be' AND title = 'C4Q1_TableLimitApproaches6';

-- Update C4Q2_TableTwoSidedLimitDNE (45053b2f-bb1a-40db-ba92-8b4cb8d8b544)
UPDATE questions SET 
    prompt = '["Use the table to determine $\\displaystyle \\lim_{x\\to 2} f(x)$.\n\n$$\n\\begin{array}{c|cccccc}\nx & 1.9 & 1.99 & 1.999 & 2.001 & 2.01 & 2.1\\\\ \\hline\nf(x) & -1.1 & -1.01 & -1.001 & 3.001 & 3.01 & 3.1\n\\end{array}\n$$"]'::jsonb
WHERE id = '45053b2f-bb1a-40db-ba92-8b4cb8d8b544' AND title = 'C4Q2_TableTwoSidedLimitDNE';

-- Update C4Q3_TableInfiniteLimit (42aacaf5-0631-49b3-ae54-46805526a3ac)
UPDATE questions SET 
    prompt = '["Use the table to evaluate the limit.\n\n$$\n\\begin{array}{c|cccccc}\nx & -0.1 & -0.01 & -0.001 & 0.001 & 0.01 & 0.1\\\\ \\hline\nf(x) & 10 & 100 & 1000 & 1000 & 100 & 10\n\\end{array}\n$$\n\nFind $\\displaystyle \\lim_{x\\to 0} f(x)$."]'::jsonb
WHERE id = '42aacaf5-0631-49b3-ae54-46805526a3ac' AND title = 'C4Q3_TableInfiniteLimit';

-- Update C4Q4_DifferenceQuotientFromTable (9b8a1428-e64e-4826-93cf-3167497f581d)
UPDATE questions SET 
    prompt = '["A function $f$ is defined near $x=2$. Use the table to estimate\n$$\\displaystyle \\lim_{x\\to 2}\\frac{f(x)-f(2)}{x-2}.$$\n\n$$\n\\begin{array}{c|cccccc}\nx & 1.9 & 1.99 & 1.999 & 2.001 & 2.01 & 2.1\\\\ \\hline\nf(x) & 4.61 & 4.9601 & 4.996001 & 5.004001 & 5.0401 & 5.41\n\\end{array}\n$$\n\nAssume $f(2)=5$."]'::jsonb
WHERE id = '9b8a1428-e64e-4826-93cf-3167497f581d' AND title = 'C4Q4_DifferenceQuotientFromTable';

-- Update C4Q5_TableOscillationDNE (995d20ab-7ad4-4fc2-aa05-06031445ebb2)
UPDATE questions SET 
    prompt = '["Use the table to determine $\\displaystyle \\lim_{x\\to 0} f(x)$.\n\n$$\n\\begin{array}{c|cccccc}\nx & -0.1 & -0.01 & -0.001 & 0.001 & 0.01 & 0.1\\\\ \\hline\nf(x) & 1 & -1 & 1 & -1 & 1 & -1\n\\end{array}\n$$"]'::jsonb
WHERE id = '995d20ab-7ad4-4fc2-aa05-06031445ebb2' AND title = 'C4Q5_TableOscillationDNE';

COMMIT;
