import { Router, Request, Response } from 'express';
import { supabaseAdmin } from '../config/supabase';
import { authMiddleware } from '../middleware/auth';
import { getRelativeTime } from '../utils/time';

const router = Router();

// GET /api/notifications - Get user notifications
router.get('/', authMiddleware, async (req: Request, res: Response): Promise<void> => {
    try {
        const userId = req.user!.id;
        const { limit = 50 } = req.query;

        // 1. Fetch friend requests for current user to check statuses
        const { data: friendRequests } = await supabaseAdmin
            .from('friend_requests')
            .select('sender_id, status')
            .eq('receiver_id', userId);

        const acceptedSenders = new Set(
            (friendRequests || [])
                .filter(r => r.status === 'accepted')
                .map(r => r.sender_id)
        );

        // 2. Fetch notifications
        const { data, error } = await supabaseAdmin
            .from('notifications')
            .select('*')
            .eq('user_id', userId)
            .order('created_at', { ascending: false })
            .limit(Number(limit));

        if (error) {
            res.status(400).json({ error: error.message });
            return;
        }

        // 3. Transform to frontend format with isAccepted enrichment
        const notifications = (data || []).map((item: any) => {
            let isAccepted = false;
            if (item.link && item.link.includes('action=friend_request')) {
                const urlParams = new URLSearchParams(item.link.split('?')[1]);
                const senderId = urlParams.get('sender_id');
                if (senderId && acceptedSenders.has(senderId)) {
                    isAccepted = true;
                }
            }

            return {
                id: item.id,
                text: item.text,
                time: getRelativeTime(new Date(item.created_at)),
                unread: item.unread,
                link: item.link,
                type: item.type,
                metadata: item.metadata,
                isAccepted
            };
        });

        res.json(notifications);
    } catch (error) {
        console.error('Get notifications error:', error);
        res.status(500).json({ error: 'Failed to get notifications' });
    }
});

// PUT /api/notifications/:id/read - Mark single notification as read
router.put('/:id/read', authMiddleware, async (req: Request, res: Response): Promise<void> => {
    try {
        const userId = req.user!.id;
        const { id } = req.params;

        const { error } = await supabaseAdmin
            .from('notifications')
            .update({ unread: false })
            .eq('id', id)
            .eq('user_id', userId);

        if (error) {
            res.status(400).json({ error: error.message });
            return;
        }

        res.json({ message: 'Notification marked as read' });
    } catch (error) {
        console.error('Mark read error:', error);
        res.status(500).json({ error: 'Failed to mark notification as read' });
    }
});

// PUT /api/notifications/read-all - Mark all notifications as read
router.put('/read-all', authMiddleware, async (req: Request, res: Response): Promise<void> => {
    try {
        const userId = req.user!.id;

        const { error } = await supabaseAdmin
            .from('notifications')
            .update({ unread: false })
            .eq('user_id', userId)
            .eq('unread', true);

        if (error) {
            res.status(400).json({ error: error.message });
            return;
        }

        res.json({ message: 'All notifications marked as read' });
    } catch (error) {
        console.error('Mark all read error:', error);
        res.status(500).json({ error: 'Failed to mark all notifications as read' });
    }
});

// POST /api/notifications - Create a notification (internal use)
router.post('/', authMiddleware, async (req: Request, res: Response): Promise<void> => {
    try {
        const { userId, text, link, type, metadata } = req.body;

        if (!userId || !text) {
            res.status(400).json({ error: 'userId and text are required' });
            return;
        }

        const { data, error } = await supabaseAdmin
            .from('notifications')
            .insert({
                user_id: userId,
                text,
                link: link || '/dashboard',
                unread: true,
                type: type || null,
                metadata: metadata || null
            })
            .select()
            .single();

        if (error) {
            res.status(400).json({ error: error.message });
            return;
        }

        res.status(201).json({
            id: data.id,
            text: data.text,
            time: 'Just now',
            unread: data.unread,
            link: data.link
        });
    } catch (error) {
        console.error('Create notification error:', error);
        res.status(500).json({ error: 'Failed to create notification' });
    }
});


// POST /api/notifications/:id/accept-friend - Accept a friend request via notification
router.post('/:id/accept-friend', authMiddleware, async (req: Request, res: Response): Promise<void> => {
    try {
        const userId = req.user!.id;
        const notifId = Number(req.params.id);

        // 1. Find the notification and extract sender_id from link
        const { data: notif, error: notifError } = await supabaseAdmin
            .from('notifications')
            .select('id, link')
            .eq('id', notifId)
            .eq('user_id', userId)
            .single();

        if (notifError || !notif) {
            res.status(404).json({ error: 'Notification not found' });
            return;
        }

        // Extract sender_id from link
        let senderId: string | null = null;
        if (notif.link && notif.link.includes('sender_id=')) {
            const urlParams = new URLSearchParams(notif.link.split('?')[1]);
            senderId = urlParams.get('sender_id');
        }

        if (!senderId) {
            res.status(400).json({ error: 'No sender_id found in notification' });
            return;
        }

        // 2. Update friend_requests status to accepted
        const { error: frError } = await supabaseAdmin
            .from('friend_requests')
            .update({ status: 'accepted' })
            .eq('sender_id', senderId)
            .eq('receiver_id', userId);

        if (frError) {
            console.error('Failed to accept friend request:', frError);
            res.status(400).json({ error: frError.message });
            return;
        }

        // 3. Update notification metadata to mark as accepted & mark as read
        await supabaseAdmin
            .from('notifications')
            .update({ metadata: { accepted: true }, unread: false })
            .eq('id', notifId);

        res.json({ success: true });
    } catch (error) {
        console.error('Accept friend error:', error);
        res.status(500).json({ error: 'Failed to accept friend request' });
    }
});


export default router;
