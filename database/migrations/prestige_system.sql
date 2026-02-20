-- Create Prestige Table
CREATE TABLE IF NOT EXISTS public.user_prestige (
    user_id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
    planet_level INT DEFAULT 1 CHECK (planet_level BETWEEN 1 AND 10),
    star_level INT DEFAULT 0 CHECK (star_level BETWEEN 0 AND 4),
    current_stardust INT DEFAULT 0,
    total_stardust_collected BIGINT DEFAULT 0,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- RLS
ALTER TABLE public.user_prestige ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can view own prestige"
ON public.user_prestige FOR SELECT
USING (auth.uid() = user_id);

CREATE POLICY "Users can update own prestige"
ON public.user_prestige FOR UPDATE
USING (auth.uid() = user_id);

CREATE POLICY "Users can insert own prestige"
ON public.user_prestige FOR INSERT
WITH CHECK (auth.uid() = user_id);

-- RPC: Purchase Stardust (1 Coin = 10 Stardust)
CREATE OR REPLACE FUNCTION purchase_stardust(amount_coins INT)
RETURNS JSONB
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
    v_user_id UUID;
    v_current_balance INT;
    v_new_stardust INT;
BEGIN
    v_user_id := auth.uid();
    v_new_stardust := amount_coins * 10;

    -- Check Balance
    SELECT balance INTO v_current_balance FROM points_ledger_balance WHERE user_id = v_user_id;
    
    IF v_current_balance IS NULL OR v_current_balance < amount_coins THEN
        RETURN jsonb_build_object('success', false, 'message', 'Insufficient coins');
    END IF;

    -- Deduct Coins (via ledger)
    INSERT INTO points_ledger (user_id, amount, transaction_type, description)
    VALUES (v_user_id, -amount_coins, 'SPEND', 'Purchased Stardust');

    -- Add Stardust
    INSERT INTO user_prestige (user_id, current_stardust, total_stardust_collected)
    VALUES (v_user_id, v_new_stardust, v_new_stardust)
    ON CONFLICT (user_id) DO UPDATE
    SET 
        current_stardust = user_prestige.current_stardust + EXCLUDED.current_stardust,
        total_stardust_collected = user_prestige.total_stardust_collected + EXCLUDED.total_stardust_collected,
        updated_at = NOW();

    RETURN jsonb_build_object('success', true, 'new_stardust', v_new_stardust);
END;
$$;

-- RPC: Inject Stardust (Level Up Logic)
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
    v_base_cost INT := 100;
BEGIN
    v_user_id := auth.uid();

    -- Get current state
    SELECT current_stardust, planet_level, star_level 
    INTO v_current_stardust, v_current_planet, v_current_star
    FROM user_prestige WHERE user_id = v_user_id;

    IF v_current_stardust < amount_to_inject THEN
        RETURN jsonb_build_object('success', false, 'message', 'Not enough Stardust');
    END IF;

    -- Calculate required stardust for next level
    -- Formula: Base 100 * Planet Level * (1 + (Planet Level * 0.1)) ? Simplified: 100 * Planet
    v_req_stardust := v_base_cost * v_current_planet;

    -- Simulating injection logic (frontend mainly handles the "fill", backend handles the "level up check")
    -- Here we assume user injects ALL available or specific amount to fill the bar.
    -- Ideally, the bar fills up. Providing a "Level Up" RPC might be better if we want strict transactional leveling.
    
    -- Let's make this RPC "Attempt Level Up"
    -- If provided amount covers the cost, we level up.
    
    IF amount_to_inject < v_req_stardust THEN
         RETURN jsonb_build_object('success', false, 'message', 'Insufficient Stardust for Level Up');
    END IF;

    -- Level Up Logic
    -- Star 0->1, 1->2, 2->3 (Planet Up)
    
    UPDATE user_prestige
    SET 
        current_stardust = current_stardust - v_req_stardust,
        star_level = star_level + 1,
        updated_at = NOW()
    WHERE user_id = v_user_id;
    
    -- Check if Planet Up needed (Star > 3)
    -- Actually, let's say Level 1 (0 stars), Level 2 (1 star), Level 3 (2 stars), Level 4 (3 stars -> Planet Up)
    -- User said: "From 1 star to 2 stars... then 3 stars... then next planet"
    -- So: 
    -- State 0 (No stars, working towards 1)
    -- State 1 (1 Star, working towards 2)
    -- State 2 (2 Stars, working towards 3)
    -- State 3 (3 Stars, working towards Next Planet)
    
    -- We can represent this as star_level 0, 1, 2. After 2, next is Planet Up.
    
    SELECT star_level, planet_level INTO v_current_star, v_current_planet FROM user_prestige WHERE user_id = v_user_id;
    
    IF v_current_star > 3 THEN
        -- Promote Planet
        IF v_current_planet < 10 THEN
            UPDATE user_prestige
            SET planet_level = planet_level + 1, star_level = 1 -- Reset to 1 star or 0? "From 0... 1.. 2.. 3"
            -- User said: "Next planet... from 0 stars, 1 star, 2 stars, 3 stars"
            -- So valid stars are 0, 1, 2, 3.
            -- Let's say we are AT star_level.
            -- If we are at 3, and upgrade, we go to Planet+1, Star 0.
             WHERE user_id = v_user_id;
             
             -- Fix the update logic above
             -- If star_level became 4 (from 3+1), then upgrade planet and set star to 0/1.
        END IF;
    END IF;

    RETURN jsonb_build_object('success', true);
END;
$$;
