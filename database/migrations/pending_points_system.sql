-- ============================================================
-- FORUM 积分手动领取系统
-- 将自动发放改为待领取模式
-- 执行顺序：在 forum_points_complete.sql 之后执行
-- ============================================================

-- ============================================================
-- STEP 1: 创建待领取积分表
-- ============================================================

CREATE TABLE IF NOT EXISTS public.pending_points (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES public.user_profiles(id) ON DELETE CASCADE,
    amount INTEGER NOT NULL,
    type TEXT NOT NULL, -- 'like_received', 'comment_received', 'friend_added'
    source_id TEXT, -- message_id / friend_request_id / user_id
    description TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    claimed BOOLEAN DEFAULT FALSE,
    claimed_at TIMESTAMPTZ
);

CREATE INDEX IF NOT EXISTS idx_pending_user_claimed ON public.pending_points(user_id, claimed);
CREATE INDEX IF NOT EXISTS idx_pending_created ON public.pending_points(created_at DESC);

-- Enable RLS
ALTER TABLE public.pending_points ENABLE ROW LEVEL SECURITY;

-- RLS Policies
DROP POLICY IF EXISTS "Users can view own pending points" ON public.pending_points;
DROP POLICY IF EXISTS "System can insert pending points" ON public.pending_points;

CREATE POLICY "Users can view own pending points" ON public.pending_points
    FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY "System can insert pending points" ON public.pending_points
    FOR INSERT WITH CHECK (true); -- Triggers need to insert

-- ============================================================
-- STEP 2: 修改触发器 - 改为插入待领取记录
-- ============================================================

-- ============================================================
-- TRIGGER 1: 点赞触发器（改为插入 pending_points）
-- ============================================================

CREATE OR REPLACE FUNCTION award_like_points()
RETURNS TRIGGER AS $$
DECLARE
    v_message_author_id UUID;
BEGIN
    -- Only for 'like' reactions
    IF NEW.reaction_type = 'like' THEN
        -- Get the message author
        SELECT user_id INTO v_message_author_id 
        FROM forum_messages 
        WHERE id = NEW.message_id;
        
        -- Create pending points only if:
        -- 1. Message author exists
        -- 2. Liker is not the author (no self-like points)
        IF v_message_author_id IS NOT NULL AND v_message_author_id <> NEW.user_id THEN
            -- Insert into pending_points instead of awarding directly
            INSERT INTO pending_points (user_id, amount, type, source_id, description)
            VALUES (
                v_message_author_id,
                5,
                'like_received',
                NEW.message_id::TEXT,
                'Received a like on your message'
            )
            ON CONFLICT DO NOTHING; -- Prevent duplicates if idempotency needed
        END IF;
    END IF;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Trigger already exists, function updated

-- ============================================================
-- TRIGGER 2: 评论触发器（改为插入 pending_points）
-- ============================================================

CREATE OR REPLACE FUNCTION award_comment_points()
RETURNS TRIGGER AS $$
DECLARE
    v_parent_author_id UUID;
BEGIN
    -- Only when this is a reply (reply_to_id is not null)
    IF NEW.reply_to_id IS NOT NULL THEN
        -- Get the parent message author
        SELECT user_id INTO v_parent_author_id 
        FROM forum_messages 
        WHERE id = NEW.reply_to_id;
        
        -- Create pending points only if:
        -- 1. Parent author exists
        -- 2. Commenter is not the parent author (no self-comment points)
        IF v_parent_author_id IS NOT NULL AND v_parent_author_id <> NEW.user_id THEN
            -- Insert into pending_points
            INSERT INTO pending_points (user_id, amount, type, source_id, description)
            VALUES (
                v_parent_author_id,
                10,
                'comment_received',
                NEW.id::TEXT,
                'Received a comment on your message'
            )
            ON CONFLICT DO NOTHING;
        END IF;
    END IF;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Trigger already exists, function updated

-- ============================================================
-- TRIGGER 3: 好友触发器（改为插入 pending_points）
-- ============================================================

CREATE OR REPLACE FUNCTION award_friend_points()
RETURNS TRIGGER AS $$
BEGIN
    -- Only when status changes from pending → accepted
    IF NEW.status = 'accepted' AND (OLD.status IS NULL OR OLD.status = 'pending') THEN
        
        -- Create pending points for SENDER
        INSERT INTO pending_points (user_id, amount, type, source_id, description)
        VALUES (
            NEW.sender_id,
            10,
            'friend_added',
            NEW.receiver_id::TEXT,
            'Friend request accepted'
        )
        ON CONFLICT DO NOTHING;
        
        -- Create pending points for RECEIVER
        INSERT INTO pending_points (user_id, amount, type, source_id, description)
        VALUES (
            NEW.receiver_id,
            10,
            'friend_added',
            NEW.sender_id::TEXT,
            'New friend added'
        )
        ON CONFLICT DO NOTHING;
        
    END IF;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Trigger already exists, function updated

-- ============================================================
-- STEP 3: 创建领取积分的 RPC 函数
-- ============================================================

CREATE OR REPLACE FUNCTION claim_pending_points()
RETURNS TABLE(claimed_amount INTEGER, claimed_count INTEGER) AS $$
DECLARE
    v_user_id UUID;
    v_total_amount INTEGER;
    v_count INTEGER;
BEGIN
    v_user_id := auth.uid();
    
    IF v_user_id IS NULL THEN
        RAISE EXCEPTION 'Not authenticated';
    END IF;
    
    -- 计算待领取总额
    SELECT COALESCE(SUM(amount), 0), COUNT(*)
    INTO v_total_amount, v_count
    FROM pending_points
    WHERE user_id = v_user_id AND claimed = FALSE;
    
    -- 如果有待领取积分
    IF v_total_amount > 0 THEN
        -- 调用 award_points 发放积分
        PERFORM award_points(
            v_user_id,
            v_total_amount,
            'batch_claim',
            'pending_batch_' || NOW()::TEXT,
            'Claimed ' || v_count || ' pending rewards',
            'batch_claim_' || v_user_id || '_' || EXTRACT(EPOCH FROM NOW())::TEXT
        );
        
        -- 标记为已领取
        UPDATE pending_points
        SET claimed = TRUE, claimed_at = NOW()
        WHERE user_id = v_user_id AND claimed = FALSE;
    END IF;
    
    RETURN QUERY SELECT v_total_amount, v_count;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- ============================================================
-- STEP 4: 查询待领取明细的辅助函数
-- ============================================================

CREATE OR REPLACE FUNCTION get_pending_points_detail()
RETURNS TABLE(
    type TEXT,
    count BIGINT,
    total_amount BIGINT
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        p.type,
        COUNT(*) as count,
        SUM(p.amount) as total_amount
    FROM pending_points p
    WHERE p.user_id = auth.uid() AND p.claimed = FALSE
    GROUP BY p.type
    ORDER BY total_amount DESC;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- ============================================================
-- 验证
-- ============================================================

-- 检查表是否创建成功
SELECT EXISTS (
    SELECT FROM pg_tables 
    WHERE schemaname = 'public' AND tablename = 'pending_points'
) AS pending_points_exists;

-- 检查函数是否创建成功
SELECT 
    proname AS function_name,
    prosrc IS NOT NULL AS has_definition
FROM pg_proc 
WHERE proname IN ('claim_pending_points', 'get_pending_points_detail')
ORDER BY proname;

-- ============================================================
-- END OF MIGRATION
-- ============================================================
