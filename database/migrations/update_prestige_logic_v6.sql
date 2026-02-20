-- Update Inject Stardust RPC (V6: Infinite Leveling Support)
-- Removes the hard cap of Level 5, 3 Stars.
-- Modifies the base cost logic to cap at Level 5 so it won't overflow integer limits.

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

    -- V6 Cost logic: 100 * power(5, Math.min(planet, 5) - 1)
    -- This ensures costs remain flat after level 5 so we never hit integer overflow limits 
    -- and users can infinitely progress without breaking the db or taking centuries.
    v_base_cost := 100 * power(5, LEAST(v_current_planet, 5) - 1);
    
    IF v_current_star = 0 THEN
        v_req_stardust := v_base_cost;
    ELSIF v_current_star = 1 THEN
        v_req_stardust := v_base_cost * 2.5;
    ELSIF v_current_star = 2 THEN
        v_req_stardust := v_base_cost * 5;
    ELSIF v_current_star >= 3 THEN
        v_req_stardust := v_base_cost * 10;
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
    IF v_current_star < 3 THEN
        -- Standard star increment (0->1, 1->2, 2->3)
        UPDATE user_prestige
        SET 
            current_stardust = current_stardust - v_req_stardust,
            star_level = star_level + 1,
            updated_at = NOW()
        WHERE user_id = v_user_id;

    ELSIF v_current_star = 3 THEN
        -- 3 stars -> 4 (Reached "Next Level" state) for ALL planets universally
        UPDATE user_prestige
        SET 
            current_stardust = current_stardust - v_req_stardust,
            star_level = 4,
            updated_at = NOW()
        WHERE user_id = v_user_id;

    ELSE
        -- star_level >= 4: Promotion to next planet, infinitely scaling
        UPDATE user_prestige
        SET 
            planet_level = planet_level + 1,
            star_level = 0,
            updated_at = NOW()
        WHERE user_id = v_user_id;
    END IF;

    RETURN jsonb_build_object('success', true);
END;
$$;
