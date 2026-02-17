-- ==========================================
-- Fix Image Upload & Save Permission (RLS)
-- 请在 Supabase SQL Editor 中运行此脚本
-- ==========================================

-- 1. 将所有用户提升为 Creator 权限 (绕过 RLS 限制)
UPDATE public.user_profiles
SET is_creator = true;

-- 2. 直接放宽 question_versions 表的插入权限 (双重保险)
DROP POLICY IF EXISTS "Creators can insert question versions" ON public.question_versions;
CREATE POLICY "Allow authenticated to insert versions" ON public.question_versions
    FOR INSERT 
    TO authenticated 
    WITH CHECK (true);

-- 3. 确保 questions 表也有更新权限 (如果之前有限制)
DROP POLICY IF EXISTS "Creators can update questions" ON public.questions;
CREATE POLICY "Allow authenticated to update questions" ON public.questions
    FOR UPDATE
    TO authenticated
    USING (true)
    WITH CHECK (true);
