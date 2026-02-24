-- ============================================================
-- Migration: Universal Clustering Schema for Skills & Error Tags
-- Description: Introduces parent cluster tables to aggregate 
--              duplicate/similar skills and error tags under 
--              a single unified identifier for easier management 
--              and highly generic analytics.
-- ============================================================

-- ==========================================
-- 1. Skill Clusters
-- ==========================================
CREATE TABLE IF NOT EXISTS public.skill_clusters (
    id VARCHAR(100) PRIMARY KEY,       -- e.g., 'integrals_advanced', 'derivatives_basic'
    name VARCHAR(255) NOT NULL,        -- Standard display name e.g., 'Advanced Integration'
    category VARCHAR(100),             -- Broad grouping e.g., 'Calculus', 'Algebra'
    description TEXT,                  -- Optional detailed explanation
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Note: We do not drop existing columns on `skills`, we only append.
-- This ensures zero downtime and zero data loss on existing historical rows.
ALTER TABLE public.skills
ADD COLUMN IF NOT EXISTS cluster_id VARCHAR(100) REFERENCES public.skill_clusters(id) ON DELETE SET NULL;

-- Index for fast lookup by cluster
CREATE INDEX IF NOT EXISTS idx_skills_cluster_id ON public.skills(cluster_id);


-- ==========================================
-- 2. Error Tag Clusters
-- ==========================================
CREATE TABLE IF NOT EXISTS public.error_tag_clusters (
    id VARCHAR(100) PRIMARY KEY,       -- e.g., 'sign_errors', 'algebra_slip'
    name VARCHAR(255) NOT NULL,        -- Standard display name e.g., 'Sign/Negative Error'
    category VARCHAR(100),             -- Broad grouping e.g., 'Calculation', 'Conceptual'
    description TEXT,                  -- Optional detailed explanation
    default_severity INTEGER DEFAULT 3,-- Baseline severity for this type of error
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

ALTER TABLE public.error_tags
ADD COLUMN IF NOT EXISTS cluster_id VARCHAR(100) REFERENCES public.error_tag_clusters(id) ON DELETE SET NULL;

-- Index for fast lookup by cluster
CREATE INDEX IF NOT EXISTS idx_error_tags_cluster_id ON public.error_tags(cluster_id);


-- ==========================================
-- 3. Trigger for Auto-updating timestamps
-- ==========================================

-- Trigger function is likely already defined in the DB, but ensure it runs for these tables
DO $$ 
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_trigger WHERE tgname = 'set_timestamp_skill_clusters') THEN
        CREATE TRIGGER set_timestamp_skill_clusters
        BEFORE UPDATE ON public.skill_clusters
        FOR EACH ROW
        EXECUTE FUNCTION trigger_set_timestamp();
    END IF;

    IF NOT EXISTS (SELECT 1 FROM pg_trigger WHERE tgname = 'set_timestamp_error_tag_clusters') THEN
        CREATE TRIGGER set_timestamp_error_tag_clusters
        BEFORE UPDATE ON public.error_tag_clusters
        FOR EACH ROW
        EXECUTE FUNCTION trigger_set_timestamp();
    END IF;
EXCEPTION
    WHEN undefined_function THEN
        -- If trigger_set_timestamp() doesn't exist, we skip binding to avoid crash. 
        -- (Most Supabase projects have this standard function, but we wrap for safety)
        RAISE NOTICE 'Function trigger_set_timestamp() does not exist. Skipping trigger creation.';
END $$;
