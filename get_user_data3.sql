SELECT 
    s.title,
    usp.correct_questions,
    usp.total_questions,
    usp.score
FROM sections s
LEFT JOIN user_section_progress usp ON s.id = usp.section_id
JOIN auth.users u ON u.id = usp.user_id
WHERE u.email = 'newmao6120@gmail.com' AND s.topic_id = 'Limits';

SELECT get_unit_progress_stats(u.id, 'Limits')
FROM auth.users u WHERE u.email = 'newmao6120@gmail.com';
