-- 1. 确保 avatars bucket 存在且必须是 Public 的
INSERT INTO storage.buckets (id, name, public) 
VALUES ('avatars', 'avatars', true)
ON CONFLICT (id) DO UPDATE SET public = true;

-- 2. 清理之前可能冲突的旧规则（预防报错）
DROP POLICY IF EXISTS "Avatar Upload Policy" ON storage.objects;
DROP POLICY IF EXISTS "Avatar Update Policy" ON storage.objects;
DROP POLICY IF EXISTS "Avatar Read Policy" ON storage.objects;
DROP POLICY IF EXISTS "Avatar Delete Policy" ON storage.objects;
DROP POLICY IF EXISTS "Allow authenticated uploads to avatars" ON storage.objects;
DROP POLICY IF EXISTS "Allow authenticated updates to avatars" ON storage.objects;
DROP POLICY IF EXISTS "Allow public read from avatars" ON storage.objects;
DROP POLICY IF EXISTS "Allow authenticated deletes from avatars" ON storage.objects;

-- 3. 创建标准安全规则

-- 开放读取：任何人都可以在网页上看到你的头像（必须的，因为头像要在论坛上展示）
CREATE POLICY "Allow public read from avatars" 
ON storage.objects FOR SELECT 
USING (bucket_id = 'avatars');

-- 允许上传：仅限登录用户，且只能传到属于自己 user_id 的文件夹下
CREATE POLICY "Allow authenticated uploads to avatars" 
ON storage.objects FOR INSERT TO authenticated 
WITH CHECK (bucket_id = 'avatars' AND auth.uid()::text = (storage.foldername(name))[1]);

-- 允许更新：覆盖自己以前的头像
CREATE POLICY "Allow authenticated updates to avatars" 
ON storage.objects FOR UPDATE TO authenticated 
USING (bucket_id = 'avatars' AND auth.uid()::text = (storage.foldername(name))[1]);

-- 允许删除：删除自己的头像
CREATE POLICY "Allow authenticated deletes from avatars" 
ON storage.objects FOR DELETE TO authenticated 
USING (bucket_id = 'avatars' AND auth.uid()::text = (storage.foldername(name))[1]);
