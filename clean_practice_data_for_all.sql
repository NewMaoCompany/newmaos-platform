DO $$
DECLARE
    target_users UUID[] := ARRAY[
        '0e25f355-da8d-413f-befa-b7f7d0d5eac7',
        '0b92016d-26ff-455a-889c-0bfdcda5cd0a',
        'b55d71f0-0649-4ca1-ab0e-2bb06e7f286a',
        '86dbe22f-71af-436d-b619-ccbd46c1cd3d',
        '7abe83bb-8941-4060-8aee-2604dab3d12a',
        'e084bdd6-b350-4a08-85f8-6bb9a0533fc7'
    ]::UUID[];
BEGIN
    -- 1. 清空做题尝试记录
    DELETE FROM public.question_attempts WHERE user_id = ANY(target_users);
    
    -- 2. 清空章节进度
    DELETE FROM public.user_section_progress WHERE user_id = ANY(target_users);
    
    -- 3. 清空单元满分通关记录
    DELETE FROM public.unit_mastery WHERE user_id = ANY(target_users);
    
    -- 4. 清空正确率和刷题统计
    DELETE FROM public.user_stats WHERE user_id = ANY(target_users);
    
    -- 5. 清空课程整体进度
    DELETE FROM public.course_progress WHERE user_id = ANY(target_users);
    
    -- 6. 删除练习相关的活动动态 (保留论坛动态)
    DELETE FROM public.activities 
    WHERE user_id = ANY(target_users) AND type IN ('quiz', 'practice', 'mastery');
    
    -- 7. 【核心】清除做题相关的金币流水和幂等键
    DELETE FROM public.points_ledger 
    WHERE user_id = ANY(target_users) 
    AND type IN ('practice_correct', 'practice_batch', 'unit_test_complete', 'unit_mastery', 'accuracy_bonus');
    
    -- 8. 重置 Profile 中的刷题数量 (已修复为 jsonb)
    UPDATE public.user_profiles 
    SET problems_solved = 0, study_hours = '[0,0,0,0,0,0,0]'::jsonb
    WHERE id = ANY(target_users);
END $$;
