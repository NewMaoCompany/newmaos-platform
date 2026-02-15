-- Check if the questions exist and what their topic/sub_topic_id are
SELECT id, title, topic, sub_topic_id, course, status 
FROM questions 
WHERE topic = 'Unit6_Integration' OR title LIKE 'U6.1%';
