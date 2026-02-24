-- ====================================================================
-- Auto-Clustering Script for Skills & Error Tags
-- Description: This script automatically groups similar skills and
-- error tags by normalizing their names (lowercasing, removing 
-- spaces/symbols), generating parent cluster rows, and binding 
-- the children to their respective parent clusters.
-- ====================================================================

DO $$
DECLARE
    r RECORD;
    new_cluster_id VARCHAR(100);
    normalized_name VARCHAR(255);
    base_category VARCHAR(100);
    best_name VARCHAR(255);
    base_severity INTEGER;
BEGIN
    RAISE NOTICE 'Starting auto-clustering for SKILLS...';

    -- 1. Cluster Skills
    FOR r IN (
        SELECT 
            -- Normalize the name by lowering and keeping only alphanumeric chars
            LOWER(REGEXP_REPLACE(name, '[^a-zA-Z0-9]', '', 'g')) AS norm_name,
            -- Pick the longest/best formatted name to be the actual cluster name
            MAX(name) AS display_name,
            -- Just grab the first unit we find to act as the category
            MAX(unit) AS category,
            COUNT(id) AS similarity_count
        FROM public.skills
        GROUP BY LOWER(REGEXP_REPLACE(name, '[^a-zA-Z0-9]', '', 'g'))
    ) LOOP
        -- Skip empty edge cases
        IF r.norm_name IS NULL OR r.norm_name = '' THEN
            CONTINUE;
        END IF;

        -- Generate a predictable cluster ID
        new_cluster_id := 'c_skill_' || SUBSTRING(r.norm_name FROM 1 FOR 60);
        
        -- Insert or ignore the parent cluster
        INSERT INTO public.skill_clusters (id, name, category, description)
        VALUES (
            new_cluster_id, 
            r.display_name, 
            COALESCE(r.category, 'General'), 
            'Auto-generated cluster linking ' || r.similarity_count || ' similar skills.'
        )
        ON CONFLICT (id) DO NOTHING;

        -- Update all skills that match this normalized name to point to the new cluster
        UPDATE public.skills 
        SET cluster_id = new_cluster_id
        WHERE LOWER(REGEXP_REPLACE(name, '[^a-zA-Z0-9]', '', 'g')) = r.norm_name
          AND (cluster_id IS NULL OR cluster_id != new_cluster_id);
          
    END LOOP;

    RAISE NOTICE 'Finished auto-clustering for SKILLS.';
    RAISE NOTICE 'Starting auto-clustering for ERROR TAGS...';

    -- 2. Cluster Error Tags
    FOR r IN (
        SELECT 
            LOWER(REGEXP_REPLACE(name, '[^a-zA-Z0-9]', '', 'g')) AS norm_name,
            MAX(name) AS display_name,
            MAX(category) AS category,
            MAX(severity) AS severity,
            COUNT(id) AS similarity_count
        FROM public.error_tags
        GROUP BY LOWER(REGEXP_REPLACE(name, '[^a-zA-Z0-9]', '', 'g'))
    ) LOOP
        IF r.norm_name IS NULL OR r.norm_name = '' THEN
            CONTINUE;
        END IF;

        new_cluster_id := 'c_err_' || SUBSTRING(r.norm_name FROM 1 FOR 60);
        
        INSERT INTO public.error_tag_clusters (id, name, category, default_severity, description)
        VALUES (
            new_cluster_id, 
            r.display_name, 
            COALESCE(r.category, 'General'), 
            COALESCE(r.severity, 3),
            'Auto-generated cluster linking ' || r.similarity_count || ' similar error tags.'
        )
        ON CONFLICT (id) DO NOTHING;

        -- Bind the existing error tags
        UPDATE public.error_tags 
        SET cluster_id = new_cluster_id
        WHERE LOWER(REGEXP_REPLACE(name, '[^a-zA-Z0-9]', '', 'g')) = r.norm_name
          AND (cluster_id IS NULL OR cluster_id != new_cluster_id);
          
    END LOOP;

    RAISE NOTICE 'Finished auto-clustering for ERROR TAGS.';
END $$;
