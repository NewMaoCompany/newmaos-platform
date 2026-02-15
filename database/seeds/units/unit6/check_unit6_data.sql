-- Verify Unit 6 Data Counts
-- Expected: 31 Skills, 38 Error Tags

SELECT 
    (SELECT COUNT(*) FROM skills WHERE unit = 'ABBC_Integration') as skill_count,
    (SELECT COUNT(*) FROM error_tags WHERE unit = 'ABBC_Integration') as error_tag_count;

-- Optional: List them to check names
-- SELECT * FROM skills WHERE unit = 'ABBC_Integration';
-- SELECT * FROM error_tags WHERE unit = 'ABBC_Integration';
