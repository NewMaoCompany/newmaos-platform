-- SQL MIGRATION PART 6 (Fix frac patterns)
-- Fix Part 6 for 76b55854-854f-420c-ae6f-9d9fbaab2ecb
UPDATE questions SET prompt = 'Which power series represents $\\\frac{1}{1-2x}$ for $|x|<\\$\frac{1}{2}$$?', options = '[{"id":"A","value":"∑(2x)^n (n=0 to ∞)"},{"id":"B","value":"∑2^n x^{n+1} (n=0 to ∞)"},{"id":"C","value":"∑(-2x)^n (n=0 to ∞)"},{"id":"D","value":"∑(2x)^n (n=1 to ∞)"}]'::jsonb, updated_at = NOW() WHERE id = '76b55854-854f-420c-ae6f-9d9fbaab2ecb';
-- Total Updates: 1
