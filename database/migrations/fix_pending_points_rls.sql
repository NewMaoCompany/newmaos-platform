-- ============================================================
-- 修复 pending_points 表的 RLS 策略
-- 解决 401 Unauthorized 错误
-- ============================================================

-- 确保 RLS 已启用
ALTER TABLE public.pending_points ENABLE ROW LEVEL SECURITY;

-- 删除旧策略（如果存在）
DROP POLICY IF EXISTS "Users can view own pending points" ON public.pending_points;
DROP POLICY IF EXISTS "Users can view their own pending points" ON public.pending_points;
DROP POLICY IF EXISTS "System can insert pending points" ON public.pending_points;

-- 创建正确的 SELECT 策略
CREATE POLICY "Users can view own pending points" ON public.pending_points
    FOR SELECT 
    USING (auth.uid() = user_id);

-- 创建 INSERT 策略（允许触发器插入）
CREATE POLICY "System can insert pending points" ON public.pending_points
    FOR INSERT 
    WITH CHECK (true);

-- UPDATE 策略（允许领取时更新 claimed 状态）
CREATE POLICY "System can update pending points" ON public.pending_points
    FOR UPDATE
    USING (true)
    WITH CHECK (true);

-- 验证策略是否创建成功
SELECT 
    schemaname,
    tablename,
    policyname,
    permissive,
    roles,
    cmd,
    qual,
    with_check
FROM pg_policies 
WHERE tablename = 'pending_points'
ORDER BY policyname;

-- ============================================================
-- END OF FIX
-- ============================================================
