-- 修复 Pro 弹窗重复显示
-- 将所有 Pro 用户的 has_seen_pro_intro 设为 true

ALTER TABLE user_profiles 
ADD COLUMN IF NOT EXISTS has_seen_pro_intro BOOLEAN DEFAULT FALSE;

UPDATE user_profiles 
SET has_seen_pro_intro = true 
WHERE subscription_tier = 'pro';

SELECT id, name, subscription_tier, has_seen_pro_intro 
FROM user_profiles 
WHERE subscription_tier = 'pro';
