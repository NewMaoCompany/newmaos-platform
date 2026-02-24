-- Diagnostic: Check what algorithmic sessions exist and whether they have error IDs
SELECT 
    user_id,
    section_id,
    entity_type,
    data->>'sessionTopic' as session_topic,
    data->>'currentIncorrectIds' as raw_incorrect_ids,
    jsonb_typeof(data->'currentIncorrectIds') as json_type,
    CASE 
        WHEN jsonb_typeof(data->'currentIncorrectIds') = 'array' THEN jsonb_array_length(data->'currentIncorrectIds')
        ELSE -1
    END as arr_len,
    length(data->>'currentIncorrectIds') as str_len
FROM public.user_section_progress 
WHERE entity_type = 'algorithmic'
LIMIT 20;
