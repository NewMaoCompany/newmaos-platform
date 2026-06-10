import dotenv from 'dotenv';
dotenv.config({ path: '.env.local' });
import { createClient } from '@supabase/supabase-js';
import fs from 'fs';

const supabase = createClient(process.env.VITE_SUPABASE_URL, process.env.VITE_SUPABASE_SERVICE_ROLE_KEY || process.env.VITE_SUPABASE_ANON_KEY);

const sql = `
-- Drop generate_system_notifications since we don't need system bell notifications
DROP FUNCTION IF EXISTS public.generate_system_notifications(UUID);

-- Clean up old bell notifications
DELETE FROM public.notifications WHERE chat_id IS NULL AND channel_id IS NULL;

-- Update get_user_badges function
CREATE OR REPLACE FUNCTION get_user_badges(p_user_id UUID)
RETURNS JSON AS $$
DECLARE
    v_dashboard_badge BOOLEAN;
    v_practice_badge BOOLEAN;
    v_analysis_badge BOOLEAN;
    v_forum_unread_count INT;
    v_settings_badge BOOLEAN;
    v_profile RECORD;
    v_forum_details JSON;
BEGIN
    -- 1. Get user profile data
    SELECT * INTO v_profile FROM public.user_profiles WHERE id = p_user_id;

    -- 2. Dashboard Badge (Check-in)
    SELECT NOT EXISTS (
        SELECT 1 FROM public.user_checkins 
        WHERE user_id = p_user_id AND checkin_date = CURRENT_DATE
    ) INTO v_dashboard_badge;

    -- 3. Practice Badge (Recommendations)
    IF DATE(COALESCE(v_profile.last_practice_rec_view_time, '1970-01-01'::DATE)) < CURRENT_DATE THEN
        v_practice_badge := true;
    ELSE
        v_practice_badge := false;
    END IF;

    -- 4. Analysis Badge
    SELECT EXISTS (
        SELECT 1 FROM public.question_attempts 
        WHERE user_id = p_user_id 
        AND created_at > COALESCE(v_profile.last_analysis_view_time, '1970-01-01'::TIMESTAMPTZ)
        AND created_at >= NOW() - INTERVAL '24 hours'
    ) INTO v_analysis_badge;

    -- 5. Forum Badge
    -- JSON breakdown of channel_id/chat_id counts
    SELECT COALESCE(json_object_agg(id, cnt), '{}'::JSON) INTO v_forum_details
    FROM (
        SELECT COALESCE(chat_id::TEXT, channel_id::TEXT) as id, count(*) as cnt 
        FROM public.notifications 
        WHERE user_id = p_user_id AND unread = true AND (chat_id IS NOT NULL OR channel_id IS NOT NULL) 
        GROUP BY COALESCE(chat_id::TEXT, channel_id::TEXT)
    ) t;

    -- Sum of counts
    SELECT COALESCE(SUM(cnt), 0) INTO v_forum_unread_count
    FROM (
        SELECT count(*) as cnt 
        FROM public.notifications 
        WHERE user_id = p_user_id AND unread = true AND (chat_id IS NOT NULL OR channel_id IS NOT NULL) 
    ) t2;

    -- Add other forum activities (mentions, replies, etc.)
    v_forum_unread_count := v_forum_unread_count + (
        SELECT COUNT(*)
        FROM public.activities
        WHERE user_id = p_user_id
        AND created_at > COALESCE(v_profile.last_forum_read_time, '1970-01-01'::TIMESTAMPTZ)
        AND type IN ('forum_reply', 'forum_like', 'forum_mention', 'friend_request', 'friend_accept')
    );

    -- 6. Settings Badge
    IF v_profile.subscription_tier = 'basic' THEN
        v_settings_badge := true;
    ELSE
        v_settings_badge := false;
    END IF;

    -- Return as JSON
    RETURN json_build_object(
        'dashboard', v_dashboard_badge,
        'practice', v_practice_badge,
        'analysis', v_analysis_badge,
        'forum', v_forum_unread_count,
        'forum_unread_details', v_forum_details,
        'settings', v_settings_badge,
        'has_claimed_welcome_gift', COALESCE(v_profile.has_claimed_welcome_gift, false)
    );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
`;

async function run() {
  console.log('Running migration...');
  const { data, error } = await supabase.rpc('exec_sql', { query: sql });
  console.log('Result:', data);
  if (error) console.error('Error:', error);
}
run();
