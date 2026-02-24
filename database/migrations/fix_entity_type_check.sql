-- 1. Find and drop the check constraint dynamically
DO $$
DECLARE
    constraint_name text;
BEGIN
    SELECT conname INTO constraint_name
    FROM pg_constraint
    WHERE conrelid = 'public.user_section_progress'::regclass
      AND contype = 'c'
      AND pg_get_constraintdef(oid) LIKE '%entity_type%';

    IF constraint_name IS NOT NULL THEN
        EXECUTE 'ALTER TABLE public.user_section_progress DROP CONSTRAINT ' || constraint_name;
    END IF;
END $$;
