-- Unlock All Titles for Admin User
DO $$
DECLARE
    v_user_id UUID;
BEGIN
    -- 1. Get User ID from Email
    SELECT id INTO v_user_id FROM auth.users WHERE email = 'newmao6120@gmail.com';
    
    IF v_user_id IS NOT NULL THEN
        -- 2. Insert all available titles into user_titles for this user
        INSERT INTO public.user_titles (user_id, title_id)
        SELECT v_user_id, id FROM public.titles
        ON CONFLICT (user_id, title_id) DO NOTHING;
        
        RAISE NOTICE 'Successfully unlocked all titles for user %', v_user_id;
    ELSE
        RAISE EXCEPTION 'User with email newmao6120@gmail.com not found';
    END IF;
END $$;
