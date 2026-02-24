-- Update Inject Stardust RPC (V7: Rebalanced Leveling Support)
-- Greatly reduces the required stardust for each level, ensuring users can reach the max level within a year of daily activity.

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

    -- V7 Rebalanced Cost logic: 300 * power(3, Math.min(planet, 5) - 1)
    -- Level 5 base = 24300. Max cost ~180,000 for top level.
    v_base_cost := 300 * power(3, LEAST(v_current_planet, 5) - 1);
    
    IF v_current_star = 0 THEN
        v_req_stardust := v_base_cost;
    ELSIF v_current_star = 1 THEN
        v_req_stardust := v_base_cost * 1.5;
    ELSIF v_current_star = 2 THEN
        v_req_stardust := v_base_cost * 2;
    ELSIF v_current_star >= 3 THEN
        v_req_stardust := v_base_cost * 3;
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
        UPDATE user_prestige
        SET 
            current_stardust = current_stardust - v_req_stardust,
            star_level = star_level + 1,
            updated_at = NOW()
        WHERE user_id = v_user_id;

    ELSIF v_current_star = 3 THEN
        UPDATE user_prestige
        SET 
            current_stardust = current_stardust - v_req_stardust,
            star_level = 4,
            updated_at = NOW()
        WHERE user_id = v_user_id;

    ELSE
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
