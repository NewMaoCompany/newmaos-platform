CREATE TABLE IF NOT EXISTS public.game_stats (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
    game_id TEXT NOT NULL,
    high_score INTEGER DEFAULT 0,
    total_played INTEGER DEFAULT 0,
    coins_earned INTEGER DEFAULT 0,
    stardust_earned INTEGER DEFAULT 0,
    last_played TIMESTAMPTZ DEFAULT now(),
    UNIQUE(user_id, game_id)
);

ALTER TABLE public.game_stats ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Users can view their own game stats" ON public.game_stats FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "Users can update their own game stats" ON public.game_stats FOR UPDATE USING (auth.uid() = user_id);
CREATE POLICY "Users can insert their own game stats" ON public.game_stats FOR INSERT WITH CHECK (auth.uid() = user_id);

CREATE OR REPLACE FUNCTION public.spend_points(p_amount INT, p_type TEXT)
RETURNS JSON AS $$
DECLARE
    v_balance INT;
    v_new_balance INT;
BEGIN
    -- Get current balance
    SELECT balance INTO v_balance FROM public.user_points WHERE user_id = auth.uid() FOR UPDATE;
    
    IF v_balance IS NULL THEN
        RETURN json_build_object('success', false, 'reason', 'user_points_not_found');
    END IF;

    IF v_balance < p_amount THEN
        RETURN json_build_object('success', false, 'reason', 'insufficient_funds');
    END IF;
    
    v_new_balance := v_balance - p_amount;

    -- Update balance
    UPDATE public.user_points 
    SET balance = v_new_balance, updated_at = NOW() 
    WHERE user_id = auth.uid();

    -- Insert into ledger using manual_adjustment to bypass strict enum check if arcade_play is not added
    INSERT INTO public.points_ledger (user_id, amount, type, source_id, description)
    VALUES (auth.uid(), -p_amount, 'manual_adjustment', 'arcade_' || p_type, 'Spent ' || p_amount || ' coins on Arcade Vault: ' || p_type);
    
    RETURN json_build_object('success', true, 'new_balance', v_new_balance);
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
