-- Unlock all available titles for a specific user
DO $$
DECLARE
    v_user_id UUID;
BEGIN
    -- 1. Get user_id from email
    SELECT id INTO v_user_id FROM auth.users WHERE email = 'newmao6120@gmail.com';
    
    IF v_user_id IS NULL THEN
        RAISE NOTICE 'User with email newmao6120@gmail.com not found.';
    ELSE
        -- 2. Bulk insert all titles into user_titles for this user
        INSERT INTO public.user_titles (user_id, title_id)
        SELECT v_user_id, id FROM public.titles
        ON CONFLICT (user_id, title_id) DO NOTHING;
        
        RAISE NOTICE 'Successfully unlocked all titles for newmao6120@gmail.com';
    END IF;
END $$;
