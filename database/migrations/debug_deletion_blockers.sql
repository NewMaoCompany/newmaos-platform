-- ==============================================================================
-- DIAGNOSTIC SCRIPT: FIND BLOCKING CONSTRAINTS
-- Run this in Supabase SQL Editor to see which tables are preventing deletion.
-- ==============================================================================

SELECT
    conname AS constraint_name,
    conrelid::regclass AS table_name,
    a.attname AS column_name,
    confrelid::regclass AS references_table,
    CASE confdeltype
        WHEN 'a' THEN 'NO ACTION'
        WHEN 'r' THEN 'RESTRICT'
        WHEN 'c' THEN 'CASCADE'
        WHEN 'n' THEN 'SET NULL'
        WHEN 'd' THEN 'SET DEFAULT'
    END AS on_delete_action
FROM pg_constraint c
JOIN pg_attribute a ON a.attnum = ANY(c.conkey) AND a.attrelid = c.conrelid
WHERE confrelid = 'auth.users'::regclass OR confrelid = 'public.user_profiles'::regclass
ORDER BY on_delete_action, table_name;
