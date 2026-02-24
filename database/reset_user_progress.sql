-- Find user UUID
DO $$ 
DECLARE 
    v_user_id UUID;
BEGIN
    SELECT id INTO v_user_id FROM auth.users WHERE email = 'newmao620@gmail.com';
    
    IF v_user_id IS NULL THEN
        RAISE NOTICE 'User newmao620@gmail.com not found. Check the email.';
        RETURN;
    END IF;

    -- Delete specific topic progress from section_progress
    DELETE FROM public.section_progress 
    WHERE user_id = v_user_id 
    AND (
        section_id LIKE '%Limits%' OR 
        section_id LIKE '%logosrisicmcchoice%' OR 
        data->>'sessionTopic' LIKE '%Limits%'
    );

    -- Delete corresponding question attempts
    DELETE FROM public.question_attempts 
    WHERE user_id = v_user_id 
    AND question_id IN (
        SELECT id FROM public.questions WHERE topic ILIKE '%Limits%'
    );

    -- Delete cached recommendations
    DELETE FROM public.recommendations 
    WHERE user_id = v_user_id 
    AND mode IN ('adaptive', 'review', 'random');
    
    RAISE NOTICE 'Successfully reset progress for newmao620@gmail.com on Limits/Logosrisicmcchoice';
END $$;
