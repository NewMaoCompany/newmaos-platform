-- Migration: Rename card_description to description2
-- Reason: Server code and Frontend expect 'description2', but I previously added 'card_description'.

BEGIN;

DO $$
BEGIN
    -- Check if card_description exists and description2 does NOT exist
    IF EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'sections' AND column_name = 'card_description') 
       AND NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'sections' AND column_name = 'description2') THEN
        
        ALTER TABLE public.sections RENAME COLUMN card_description TO description2;
        
    -- If both exist (unlikely but possible if partial run), move data and drop old
    ELSIF EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'sections' AND column_name = 'card_description') 
          AND EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'sections' AND column_name = 'description2') THEN
          
        UPDATE public.sections SET description2 = card_description WHERE description2 IS NULL OR description2 = '';
        ALTER TABLE public.sections DROP COLUMN card_description;
        
    -- If only description2 exists (already correct or previously existed), do nothing (idempotent)
    -- If neither exists (should verify), add description2
    ELSIF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'sections' AND column_name = 'description2') THEN
        ALTER TABLE public.sections ADD COLUMN description2 TEXT DEFAULT '';
    END IF;
END $$;

COMMIT;
