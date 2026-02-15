-- SQL MIGRATION PART 2

-- Fix 1.10 P4 (Move Image from Option to Prompt)
UPDATE questions SET
  prompt = '["Use the graph provided. What is $\\lim_{x\\to 2} f(x)$?","https://xzpjlnkirboevkjzitcx.supabase.co/storage/v1/object/public/images/questions/b55d71f0-0649-4ca1-ab0e-2bb06e7f286a/1769383775068_nhfm4.jpg"]',
  options = '[{"id":"A","type":"text","label":"A","value":"$\\infty$","explanation":"Correct: both sides rise upward without bound as $x$ approaches 2."},{"id":"B","type":"text","label":"B","value":"$-\\infty$","explanation":"The graph does not decrease without bound; it increases."},{"id":"C","type":"text","label":"C","value":"0","explanation":"The graph does not approach 0 near $x=2$."},{"id":"D","type":"text","label":"D","value":"DNE","explanation":"The limit is an infinite limit ($\\infty$), which is a valid limit statement here."}]'::jsonb,
  prompt_type = 'text_and_image',
  updated_at = NOW()
WHERE id = 'b06360c6-c478-442e-956b-41b946d58257';

-- Fix 1.14 P3 (Move Image from Option to Prompt)
UPDATE questions SET
  prompt = '["Use the graph provided. Which statement is correct?","https://xzpjlnkirboevkjzitcx.supabase.co/storage/v1/object/public/images/questions/b55d71f0-0649-4ca1-ab0e-2bb06e7f286a/1769384224211_xnrzy.jpg"]',
  options = '[{"id":"A","type":"text","label":"A","value":"$\\lim_{x\\to 1^-} f(x)=\\infty$ and $\\lim_{x\\to 1^+} f(x)=\\infty$","explanation":"Left side goes downward, not upward."},{"id":"B","type":"text","label":"B","value":"$\\lim_{x\\to 1^-} f(x)=-\\infty$ and $\\lim_{x\\to 1^+} f(x)=\\infty$","explanation":"Correct: opposite infinite behavior on the two sides."},{"id":"C","type":"text","label":"C","value":"$\\lim_{x\\to 1^-} f(x)=0$ and $\\lim_{x\\to 1^+} f(x)=0$","explanation":"The function does not approach 0 near the asymptote."},{"id":"D","type":"text","label":"D","value":"$\\lim_{x\\to 1} f(x)$ exists and equals 1","explanation":"With opposite infinite behavior, the two-sided limit does not exist."}]'::jsonb,
  prompt_type = 'text_and_image',
  updated_at = NOW()
WHERE id = '4a20b9f3-7002-470a-b576-e8a4850d729c';

-- Fix 1.2 P4 (Remove raw LaTeX Table)
UPDATE questions SET
  prompt = '["A function $f$ is shown in the table. What is the best estimate of $\\lim_{x\\to 2} f(x)$?","https://xzpjlnkirboevkjzitcx.supabase.co/storage/v1/object/public/images/questions/b55d71f0-0649-4ca1-ab0e-2bb06e7f286a/1769383816905_oanfb.jpg"]',
  updated_at = NOW()
WHERE id = '140e8637-cefb-4071-961f-dd01e9627f51';

