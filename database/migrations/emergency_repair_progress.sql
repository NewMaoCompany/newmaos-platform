-- ============================================================
-- NUCLEAR REPAIR: Force Constraints & Schema Mismatch Fix
-- This script FIXES "42P10", "42P13" AND "Failed to save settings"
-- Run this ENTIRE file in Supabase SQL Editor
-- ============================================================

-- I. PRE-REQUISITE: Ensure Sections Table has all Columns (Fixes Save Failure)
ALTER TABLE public.sections ADD COLUMN IF NOT EXISTS description2 TEXT DEFAULT '';
ALTER TABLE public.sections ADD COLUMN IF NOT EXISTS has_lesson BOOLEAN DEFAULT true;
ALTER TABLE public.sections ADD COLUMN IF NOT EXISTS has_practice BOOLEAN DEFAULT true;
ALTER TABLE public.sections ADD COLUMN IF NOT EXISTS estimated_minutes INTEGER DEFAULT 15;
ALTER TABLE public.sections ADD COLUMN IF NOT EXISTS sort_order INTEGER DEFAULT 0;
ALTER TABLE public.sections ADD COLUMN IF NOT EXISTS updated_at TIMESTAMPTZ DEFAULT NOW();

-- II. Ensure User Progress Table has all Columns
ALTER TABLE public.user_section_progress ADD COLUMN IF NOT EXISTS entity_type VARCHAR(20) DEFAULT 'section';
ALTER TABLE public.user_section_progress ADD COLUMN IF NOT EXISTS score INTEGER DEFAULT 0;
ALTER TABLE public.user_section_progress ADD COLUMN IF NOT EXISTS total_questions INTEGER DEFAULT 0;
ALTER TABLE public.user_section_progress ADD COLUMN IF NOT EXISTS correct_questions INTEGER DEFAULT 0;
ALTER TABLE public.user_section_progress ADD COLUMN IF NOT EXISTS last_accessed_at TIMESTAMPTZ DEFAULT NOW();

-- III. DEDUPLICATE & FORCE CONSTRAINTS
DO $$ 
BEGIN 
    -- 0. Clean NULLs
    DELETE FROM public.sections WHERE id IS NULL OR topic_id IS NULL;

    -- 1. Deduplicate public.sections (keep newest per topic_id)
    DELETE FROM public.sections
    WHERE ctid IN (
        SELECT ctid FROM (
            SELECT ctid, ROW_NUMBER() OVER (PARTITION BY id, topic_id ORDER BY updated_at DESC) as row_num
            FROM public.sections
        ) t WHERE t.row_num > 1
    );

    -- 2. Force Composite Primary Key on sections
    -- This allows 'unit_test' and 'overview' to exist uniquely per topic
    BEGIN
        ALTER TABLE public.sections DROP CONSTRAINT IF EXISTS sections_pkey;
        ALTER TABLE public.sections ADD PRIMARY KEY (id, topic_id);
    EXCEPTION WHEN OTHERS THEN 
        RAISE NOTICE 'Sections PK setup notice: %', SQLERRM;
    END;

    -- 2.5 Clean NULLs for progress
    DELETE FROM public.user_section_progress WHERE user_id IS NULL OR section_id IS NULL;

    -- 3. Deduplicate public.user_section_progress (keep newest)
    DELETE FROM public.user_section_progress
    WHERE ctid IN (
        SELECT ctid FROM (
            SELECT ctid, ROW_NUMBER() OVER (PARTITION BY user_id, section_id ORDER BY last_accessed_at DESC) as row_num
            FROM public.user_section_progress
        ) t WHERE t.row_num > 1
    );

    -- 4. Force Primary Key on user_section_progress
    BEGIN
        ALTER TABLE public.user_section_progress DROP CONSTRAINT IF EXISTS user_section_progress_pkey;
        ALTER TABLE public.user_section_progress ADD PRIMARY KEY (user_id, section_id);
    EXCEPTION WHEN OTHERS THEN 
        RAISE NOTICE 'User Progress PK setup notice: %', SQLERRM;
    END;
END $$;

-- IV. SEED STATIC DATA
-- Using ON CONFLICT (id, topic_id) matching THE NEW PK
INSERT INTO public.sections (id, topic_id, title)
VALUES 
-- Unit 1
('1.1', 'ABBC_Limits', '1.1 Introducing Calculus: Can Change Occur at an Instant?'),
('1.2', 'ABBC_Limits', '1.2 Defining Limits and Using Limit Notation'),
('1.3', 'ABBC_Limits', '1.3 Estimating Limit Values from Graphs'),
('1.4', 'ABBC_Limits', '1.4 Estimating Limit Values from Tables'),
('1.5', 'ABBC_Limits', '1.5 Determining Limits Using Algebraic Properties of Limits'),
('1.6', 'ABBC_Limits', '1.6 Determining Limits Using Algebraic Manipulation'),
('1.7', 'ABBC_Limits', '1.7 Selecting Procedures for Determining Limits'),
('1.8', 'ABBC_Limits', '1.8 Determining Limits Using the Squeeze Theorem'),
('1.9', 'ABBC_Limits', '1.9 Connecting Multiple Representations of Limits'),
('1.10', 'ABBC_Limits', '1.10 Exploring Continuity'),
('1.11', 'ABBC_Limits', '1.11 Defining Continuity at a Point'),
('1.12', 'ABBC_Limits', '1.12 Confirming Continuity over an Interval'),
('1.13', 'ABBC_Limits', '1.13 Removing Discontinuities'),
('1.14', 'ABBC_Limits', '1.14 Connecting Infinite Limits and Vertical Asymptotes'),
('1.15', 'ABBC_Limits', '1.15 Connecting Limits at Infinity and Horizontal Asymptotes'),
('1.16', 'ABBC_Limits', '1.16 Working with the Intermediate Value Theorem (IVT)'),
('unit_test', 'ABBC_Limits', 'Unit 1 Test'),
('overview', 'ABBC_Limits', 'Unit 1 Overview'),
-- Unit 2
('2.1', 'ABBC_Derivatives', '2.1 Defining Average and Instantaneous Rates of Change at a Point'),
('2.2', 'ABBC_Derivatives', '2.2 Defining the Derivative of a Function and Using Derivative Notation'),
('2.3', 'ABBC_Derivatives', '2.3 Estimating Derivatives of a Function at a Point'),
('2.4', 'ABBC_Derivatives', '2.4 Connecting Differentiability and Continuity'),
('2.5', 'ABBC_Derivatives', '2.5 Applying the Power Rule'),
('2.6', 'ABBC_Derivatives', '2.6 Derivative Rules'),
('2.7', 'ABBC_Derivatives', '2.7 Derivatives of cos x, sin x, e^x, and ln x'),
('2.8', 'ABBC_Derivatives', '2.8 The Product Rule'),
('2.9', 'ABBC_Derivatives', '2.9 The Quotient Rule'),
('2.10', 'ABBC_Derivatives', '2.10 Finding the Derivatives of Tangent, etc.'),
('unit_test', 'ABBC_Derivatives', 'Unit 2 Test'),
('overview', 'ABBC_Derivatives', 'Unit 2 Overview')
ON CONFLICT (id, topic_id) DO UPDATE SET title = EXCLUDED.title, updated_at = NOW();

-- V. RPC RE-INITIALIZATION
-- Explicitly drop functions before recreation to fix 42P13
DROP FUNCTION IF EXISTS public.save_section_progress(VARCHAR, JSONB, INTEGER);
DROP FUNCTION IF EXISTS public.save_section_progress(VARCHAR, JSONB, INTEGER, BOOLEAN);
DROP FUNCTION IF EXISTS public.save_section_progress(VARCHAR, JSONB, INTEGER, VARCHAR, BOOLEAN);
DROP FUNCTION IF EXISTS public.complete_section_session(VARCHAR, INTEGER, INTEGER, INTEGER, JSONB);
DROP FUNCTION IF EXISTS public.complete_section_session(VARCHAR, INTEGER, INTEGER, INTEGER, JSONB, BOOLEAN);
DROP FUNCTION IF EXISTS public.get_all_user_progress();
DROP FUNCTION IF EXISTS public.get_topic_section_progress(VARCHAR);
DROP FUNCTION IF EXISTS public.diagnose_supabase_connection();

CREATE OR REPLACE FUNCTION public.save_section_progress(
    p_section_id VARCHAR, p_data JSONB, p_time_spent INTEGER DEFAULT 0, p_entity_type VARCHAR DEFAULT 'section', p_skip_status_update BOOLEAN DEFAULT FALSE
) RETURNS BOOLEAN AS $$
DECLARE v_user_id UUID := auth.uid();
BEGIN
    IF v_user_id IS NULL THEN RETURN FALSE; END IF;
    INSERT INTO public.user_section_progress (user_id, section_id, status, data, entity_type, last_accessed_at)
    VALUES (v_user_id, p_section_id, 'in_progress', p_data, p_entity_type, NOW())
    ON CONFLICT (user_id, section_id) DO UPDATE SET
        status = CASE WHEN p_skip_status_update THEN user_section_progress.status WHEN user_section_progress.status = 'completed' THEN 'completed' ELSE 'in_progress' END,
        data = p_data, entity_type = p_entity_type, last_accessed_at = NOW();
    RETURN TRUE;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

CREATE OR REPLACE FUNCTION public.complete_section_session(
    p_section_id VARCHAR, p_score INTEGER, p_total_questions INTEGER, p_correct_questions INTEGER, p_data JSONB, p_skip_status_update BOOLEAN DEFAULT FALSE
) RETURNS JSONB AS $$
DECLARE v_user_id UUID := auth.uid();
BEGIN
    IF v_user_id IS NULL THEN RETURN jsonb_build_object('success', false, 'error', 'Not authenticated'); END IF;
    INSERT INTO public.user_section_progress (user_id, section_id, status, data, score, total_questions, correct_questions, last_accessed_at)
    VALUES (v_user_id, p_section_id, CASE WHEN p_skip_status_update THEN 'in_progress' ELSE 'completed' END, p_data, p_score, p_total_questions, p_correct_questions, NOW())
    ON CONFLICT (user_id, section_id) DO UPDATE SET
        status = CASE WHEN p_skip_status_update THEN user_section_progress.status ELSE 'completed' END,
        data = p_data, score = CASE WHEN p_skip_status_update THEN user_section_progress.score ELSE GREATEST(user_section_progress.score, p_score) END,
        total_questions = p_total_questions, correct_questions = CASE WHEN p_skip_status_update THEN user_section_progress.correct_questions ELSE GREATEST(user_section_progress.correct_questions, p_correct_questions) END,
        last_accessed_at = NOW();
    RETURN jsonb_build_object('success', true);
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

CREATE OR REPLACE FUNCTION public.get_all_user_progress()
RETURNS TABLE (section_id VARCHAR, status VARCHAR, data JSONB, score INTEGER, correct_questions INTEGER, total_questions INTEGER, last_accessed_at TIMESTAMPTZ, entity_type VARCHAR) AS $$
BEGIN
    RETURN QUERY SELECT usp.section_id, usp.status, usp.data, usp.score, usp.correct_questions, usp.total_questions, usp.last_accessed_at, usp.entity_type
    FROM public.user_section_progress usp WHERE usp.user_id = auth.uid();
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

CREATE OR REPLACE FUNCTION public.get_topic_section_progress(p_topic_id VARCHAR)
RETURNS TABLE (section_id VARCHAR, status VARCHAR, data JSONB, score INTEGER, correct_questions INTEGER, total_questions INTEGER, last_accessed_at TIMESTAMPTZ) AS $$
BEGIN
    RETURN QUERY SELECT s.id as section_id, COALESCE(usp.status, 'not_started') as status, usp.data, usp.score, usp.correct_questions, usp.total_questions, usp.last_accessed_at
    FROM public.sections s LEFT JOIN public.user_section_progress usp ON s.id = usp.section_id AND usp.user_id = auth.uid() WHERE s.topic_id = p_topic_id;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

CREATE OR REPLACE FUNCTION diagnose_supabase_connection()
RETURNS JSONB AS $$
DECLARE v_user_id UUID := auth.uid(); v_table_exists BOOLEAN; v_row_count INTEGER;
BEGIN
    SELECT EXISTS (SELECT FROM information_schema.tables WHERE table_name = 'user_section_progress') INTO v_table_exists;
    SELECT COUNT(*) FROM public.user_section_progress INTO v_row_count;
    RETURN jsonb_build_object('authenticated_user', v_user_id, 'table_user_section_progress_exists', v_table_exists, 'total_rows_in_progress_table', v_row_count, 'timestamp', NOW());
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
