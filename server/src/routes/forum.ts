import { Router, Request, Response } from 'express';
import { supabaseAdmin } from '../config/supabase';
import { authMiddleware } from '../middleware/auth';

const router = Router();

// POST /api/forum/messages - Add a new discussion message
router.post('/messages', authMiddleware, async (req: Request, res: Response): Promise<void> => {
    try {
        const userId = req.user!.id;
        const { questionId, channelId, content, replyToId } = req.body;

        if (!content) {
            res.status(400).json({ error: 'content is required' });
            return;
        }

        // 1. Fetch the user's profile details manually
        let userProfile = { name: 'Anonymous', avatar_url: null };
        const { data: profileData } = await supabaseAdmin
            .from('user_profiles')
            .select('name, avatar_url')
            .eq('id', userId)
            .single();

        if (profileData) {
            userProfile = profileData;
        }

        // 2. Insert the message
        // If questionId is missing, explicitly set it to null or omit it
        const insertPayload: any = {
            content: content,
            user_id: userId,
            channel_id: channelId || null,
            reply_to_id: replyToId || null
        };

        if (questionId) {
            insertPayload.question_id = questionId;
        }

        const { data: insertedMessage, error: insertError } = await supabaseAdmin
            .from('forum_messages')
            .insert(insertPayload)
            .select('*')
            .single();

        if (insertError || !insertedMessage) {
            console.error('Supabase insert error:', insertError);
            res.status(500).json({ error: 'Failed to save message' });
            return;
        }

        // 3. (CRITICAL FIX FOR NOTIFICATIONS)
        // If it's a reply, explicitly insert a targeted notification for the parent author.
        if (replyToId) {
            const { data: parentMsg } = await supabaseAdmin
                .from('forum_messages')
                .select('user_id')
                .eq('id', replyToId)
                .single();

            if (parentMsg && parentMsg.user_id && parentMsg.user_id !== userId) {
                const snippet = content.length > 50 ? content.substring(0, 47) + '...' : content;
                const notifText = `${userProfile.name} replied to your message: "${snippet}"`;

                await supabaseAdmin.from('notifications').insert({
                    user_id: parentMsg.user_id,
                    text: notifText,
                    type: 'reply',
                    unread: true,
                    link: channelId ? `/forum?channel_id=${channelId}` : '/forum'
                });
            }
        }

        // 4. Assemble and return
        const responseData = {
            ...insertedMessage,
            user_profiles: userProfile
        };

        res.json({ message: 'Message saved successfully', data: responseData });
    } catch (error) {
        console.error('Post message error:', error);
        res.status(500).json({ error: 'Internal server error' });
    }
});

export default router;
