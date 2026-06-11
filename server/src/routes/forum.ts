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
                .select('user_id, created_at')
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

                // Cleanup: The database trigger inserted 'comment_received' into pending_points, we must remove it to avoid double-awarding
                await supabaseAdmin.from('pending_points').delete()
                    .eq('type', 'comment_received')
                    .eq('source_id', insertedMessage.id);

                // Award 10 NMS Points for receiving a reply
                await supabaseAdmin.from('pending_points').insert({
                    user_id: parentMsg.user_id,
                    amount: 10,
                    type: 'reply',
                    source_id: insertedMessage.id,
                    description: 'Received a reply to your message'
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

// POST /api/forum/reward-like - Award points for a received like
router.post('/reward-like', authMiddleware, async (req: Request, res: Response): Promise<void> => {
    try {
        const likerId = req.user!.id;
        const { messageId, authorId } = req.body;

        if (!messageId || !authorId) {
            res.status(400).json({ error: 'messageId and authorId are required' });
            return;
        }

        // 1. Prevent self-liking rewards
        if (likerId === authorId) {
            res.json({ success: true, ignored: true, reason: 'self_like' });
            return;
        }

        // Cleanup: Database trigger auto-inserts 'like_received'. We must remove it to control rewards manually and prevent double-awarding
        await supabaseAdmin.from('pending_points').delete()
            .eq('type', 'like_received')
            .eq('source_id', messageId)
            .eq('user_id', authorId);

        // 2. Verify the like actually exists to prevent abuse
        const { data: reaction } = await supabaseAdmin
            .from('message_reactions')
            .select('id')
            .eq('message_id', messageId)
            .eq('user_id', likerId)
            .eq('reaction_type', 'like')
            .maybeSingle();

        if (!reaction) {
            res.status(400).json({ error: 'Like not found' });
            return;
        }

        // 3. Ensure points were not already awarded for this specific like
        const sourceId = `${messageId}_${likerId}`;
        const { data: existingPoint } = await supabaseAdmin
            .from('pending_points')
            .select('id')
            .eq('source_id', sourceId)
            .eq('type', 'like')
            .maybeSingle();

        if (existingPoint) {
            res.json({ success: true, ignored: true, reason: 'already_awarded' });
            return;
        }

        // Check if message was already awarded in ledger (if claimed quickly)
        const { data: existingLedger } = await supabaseAdmin
            .from('points_ledger')
            .select('id')
            .eq('source_id', sourceId)
            .eq('type', 'like')
            .maybeSingle();

        if (existingLedger) {
            res.json({ success: true, ignored: true, reason: 'already_awarded_ledger' });
            return;
        }

        // 4. Award 5 NMS Points
        await supabaseAdmin.from('pending_points').insert({
            user_id: authorId,
            amount: 5,
            type: 'like',
            source_id: sourceId,
            description: 'Received a like on your forum message'
        });

        res.json({ success: true });
    } catch (error) {
        console.error('Reward like error:', error);
        res.status(500).json({ error: 'Internal server error' });
    }
});

export default router;
