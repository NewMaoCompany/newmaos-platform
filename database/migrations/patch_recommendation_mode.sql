ALTER TABLE public.recommendations
ADD COLUMN IF NOT EXISTS mode VARCHAR(50);
