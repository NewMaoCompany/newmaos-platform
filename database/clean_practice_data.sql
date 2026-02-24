-- 专门针对 newmao6120@gmail.com 的测试数据清理脚本
DO $$
DECLARE
    target_user_id UUID;
BEGIN
    -- 1. 查找此邮箱对应的 ID
    SELECT id INTO target_user_id FROM auth.users WHERE email = 'newmao6120@gmail.com';
    
    IF target_user_id IS NOT NULL THEN
        -- 2. 清理所有学习进度和积分记录
        DELETE FROM user_section_progress WHERE user_id = target_user_id;
        DELETE FROM points_ledger WHERE user_id = target_user_id;
        DELETE FROM pending_points WHERE user_id = target_user_id;
        
        -- 可选：如果连装扮/头衔也想重置，可以解除这几行的注释
        -- DELETE FROM user_titles WHERE user_id = target_user_id;
        -- DELETE FROM user_items WHERE user_id = target_user_id;
        -- DELETE FROM active_titles WHERE user_id = target_user_id;
        
        -- 3. 重置 profile 的状态（连续打卡天数，称号等）
        UPDATE user_profiles 
        SET streak_days = 0,
            equipped_title_id = NULL
        WHERE id = target_user_id;
        
        RAISE NOTICE '✅ 成功清理用户 % (newmao6120@gmail.com) 的所有练习数据！', target_user_id;
    ELSE
        RAISE NOTICE '❌ 未找到邮箱为 newmao6120@gmail.com 的用户。请检查邮箱拼写。';
    END IF;
END $$;
