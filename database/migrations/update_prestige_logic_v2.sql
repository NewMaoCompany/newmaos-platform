-- Update Inject Stardust RPC (V2 Scaling: 5x jump per planet level)
CREATE OR REPLACE FUNCTION inject_stardust(amount_to_inject INT)
RETURNS JSONB
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
    v_user_id UUID;
    v_current_stardust INT;
    v_current_planet INT;
    v_current_star INT;
    v_req_stardust INT;
    v_base_cost NUMERIC;
BEGIN
    v_user_id := auth.uid();

    -- Get current state
    SELECT current_stardust, planet_level, star_level 
    INTO v_current_stardust, v_current_planet, v_current_star
    FROM user_prestige WHERE user_id = v_user_id;

    -- V2 Cost logic: 100 * power(5, planet - 1)
    v_base_cost := 100 * power(5, v_current_planet - 1);
    
    IF v_current_star = 0 THEN
        v_req_stardust := v_base_cost;
    ELSIF v_current_star = 1 THEN
        v_req_stardust := v_base_cost * 2.5;
    ELSIF v_current_star = 2 THEN
        v_req_stardust := v_base_cost * 5;
    ELSE
        v_req_stardust := 999999; 
    END IF;

    -- Validation
    IF v_current_stardust < amount_to_inject THEN
        RETURN jsonb_build_object('success', false, 'message', 'Not enough Stardust');
    END IF;

    IF amount_to_inject < v_req_stardust THEN
         RETURN jsonb_build_object('success', false, 'message', 'Insufficient Stardust to progress');
    END IF;

    -- Update Logic
    IF v_current_star < 2 THEN
        UPDATE user_prestige
        SET 
            current_stardust = current_stardust - v_req_stardust,
            star_level = star_level + 1,
            updated_at = NOW()
        WHERE user_id = v_user_id;
    ELSE
        -- Level Up Planet
        IF v_current_planet < 10 THEN
            UPDATE user_prestige
            SET 
                current_stardust = current_stardust - v_req_stardust,
                planet_level = planet_level + 1,
                star_level = 0,
                updated_at = NOW()
            WHERE user_id = v_user_id;
        ELSE
            UPDATE user_prestige
            SET 
                current_stardust = current_stardust - v_req_stardust,
                star_level = 3,
                updated_at = NOW()
            WHERE user_id = v_user_id;
        END IF;
    END IF;

    RETURN jsonb_build_object('success', true);
END;
$$;
