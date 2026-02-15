-- Migration: Add card_description to sections table
-- Reason: To support detailed practice descriptions distinct from the short description.

BEGIN;

DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'sections' AND column_name = 'card_description') THEN
        ALTER TABLE public.sections ADD COLUMN card_description TEXT DEFAULT '';
    END IF;
END $$;

COMMIT;
