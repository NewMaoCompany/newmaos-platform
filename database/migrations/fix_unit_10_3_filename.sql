-- Fix Unit 10.3-P4 Filename Removal
-- User Request: "去除啥啥.png" (Remove filename from prompt)

UPDATE public.questions
SET 
    prompt = $prompt$Refer to Table 10.3-A, which lists terms $a_n$. What can you conclude about $\sum_{n=1}^{\infty} a_n$ using the $n$th-term test?$prompt$
WHERE title = 'U10.3-P4';
