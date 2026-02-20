-- Drop the existing constraint that restricts star_level to max 3
ALTER TABLE public.user_prestige DROP CONSTRAINT IF EXISTS user_prestige_star_level_check;

-- Add the corrected constraint allowing star_level up to 4 (required for the "Next Level" temporary state)
ALTER TABLE public.user_prestige ADD CONSTRAINT user_prestige_star_level_check CHECK (star_level BETWEEN 0 AND 4);
