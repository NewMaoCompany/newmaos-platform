-- Update Inject Stardust RPC for Tiered Costs and Auto-Promotion
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
BEGIN
    v_user_id := auth.uid();

    -- Get current state
    SELECT current_stardust, planet_level, star_level 
    INTO v_current_stardust, v_current_planet, v_current_star
    FROM user_prestige WHERE user_id = v_user_id;

    -- Determine cost based on current star level
    -- Segment 1 (0 -> 1): 100 * level
    -- Segment 2 (1 -> 2): 250 * level
    -- Segment 3 (2 -> 3): 500 * level
    IF v_current_star = 0 THEN
        v_req_stardust := 100 * v_current_planet;
    ELSIF v_current_star = 1 THEN
        v_req_stardust := 250 * v_current_planet;
    ELSIF v_current_star = 2 THEN
        v_req_stardust := 500 * v_current_planet;
    ELSE
        -- If already at 3 stars, something is wrong or handled via auto-promotion
        v_req_stardust := 999999; 
    END IF;

    -- Basic validation
    IF v_current_stardust < amount_to_inject THEN
        RETURN jsonb_build_object('success', false, 'message', 'Not enough Stardust');
    END IF;

    IF amount_to_inject < v_req_stardust THEN
         RETURN jsonb_build_object('success', false, 'message', 'Insufficient Stardust to progress');
    END IF;

    -- Update Logic
    IF v_current_star < 2 THEN
        -- Standard star increment
        UPDATE user_prestige
        SET 
            current_stardust = current_stardust - v_req_stardust,
            star_level = star_level + 1,
            updated_at = NOW()
        WHERE user_id = v_user_id;
    ELSE
        -- 2 stars -> 3 stars -> Planet UP
        IF v_current_planet < 10 THEN
            UPDATE user_prestige
            SET 
                current_stardust = current_stardust - v_req_stardust,
                planet_level = planet_level + 1,
                star_level = 0,
                updated_at = NOW()
            WHERE user_id = v_user_id;
        ELSE
            -- Max planet reached
            UPDATE user_prestige
            SET 
                current_stardust = current_stardust - v_req_stardust,
                star_level = 3, -- Stay at 3 stars for max planet
                updated_at = NOW()
            WHERE user_id = v_user_id;
        END IF;
    END IF;

    RETURN jsonb_build_object('success', true);
END;
$$;
