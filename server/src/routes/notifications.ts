import { Router, Request, Response } from 'express';
import { supabaseAdmin } from '../config/supabase';
import { authMiddleware } from '../middleware/auth';

const router = Router();

// GET /api/notifications - Get user notifications
router.get('/', authMiddleware, async (req: Request, res: Response): Promise<void> => {
    try {
        const userId = req.user!.id;
        const { limit = 50 } = req.query;

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

        // Transform to frontend format
        const notifications = (data || []).map((item: { id: number; text: string; created_at: string; unread: boolean; link: string }) => ({
            id: item.id,
            text: item.text,
            time: getRelativeTime(new Date(item.created_at)),
            unread: item.unread,
            link: item.link
        }));

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
        const { userId, text, link } = req.body;

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
                unread: true
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

// Helper function to get relative time
function getRelativeTime(date: Date): string {
    const now = new Date();
    const diffMs = now.getTime() - date.getTime();
    const diffMins = Math.floor(diffMs / 60000);
    const diffHours = Math.floor(diffMs / 3600000);
    const diffDays = Math.floor(diffMs / 86400000);

    if (diffMins < 1) return 'Just now';
    if (diffMins < 60) return `${diffMins}m ago`;
    if (diffHours < 24) return `${diffHours}h ago`;
    if (diffDays < 7) return `${diffDays}d ago`;
    return date.toLocaleDateString();
}

export default router;
