import { Router, Request, Response } from 'express';
import { supabaseAdmin } from '../config/supabase';
import { authMiddleware } from '../middleware/auth';

const router = Router();

// GET /api/users/me - Get current user profile
router.get('/me', authMiddleware, async (req: Request, res: Response): Promise<void> => {
    try {
        const userId = req.user!.id;

        const { data: profile, error } = await supabaseAdmin
            .from('user_profiles')
            .select('*')
            .eq('id', userId)
            .single();

        if (error || !profile) {
            res.status(404).json({ error: 'Profile not found' });
            return;
        }

        res.json(profile);
    } catch (error) {
        console.error('Get profile error:', error);
        res.status(500).json({ error: 'Failed to get profile' });
    }
});

// PUT /api/users/me - Update current user profile
router.put('/me', authMiddleware, async (req: Request, res: Response): Promise<void> => {
    try {
        const userId = req.user!.id;
        const { name, avatar_url, current_course } = req.body;

        const updates: Record<string, any> = { updated_at: new Date().toISOString() };
        if (name !== undefined) updates.name = name;
        if (avatar_url !== undefined) updates.avatar_url = avatar_url;
        if (current_course !== undefined) updates.current_course = current_course;

        const { data, error } = await supabaseAdmin
            .from('user_profiles')
            .update(updates)
            .eq('id', userId)
            .select()
            .single();

        if (error) {
            res.status(400).json({ error: error.message });
            return;
        }

        res.json(data);
    } catch (error) {
        console.error('Update profile error:', error);
        res.status(500).json({ error: 'Failed to update profile' });
    }
});

// PUT /api/users/preferences - Update user preferences
router.put('/preferences', authMiddleware, async (req: Request, res: Response): Promise<void> => {
    try {
        const userId = req.user!.id;
        const { email_notifications, sound_effects } = req.body;

        const updates: Record<string, any> = { updated_at: new Date().toISOString() };
        if (email_notifications !== undefined) updates.email_notifications = email_notifications;
        if (sound_effects !== undefined) updates.sound_effects = sound_effects;

        const { data, error } = await supabaseAdmin
            .from('user_profiles')
            .update(updates)
            .eq('id', userId)
            .select()
            .single();

        if (error) {
            res.status(400).json({ error: error.message });
            return;
        }

        res.json(data);
    } catch (error) {
        console.error('Update preferences error:', error);
        res.status(500).json({ error: 'Failed to update preferences' });
    }
});

// GET /api/users/full - Get full user data including progress
router.get('/full', authMiddleware, async (req: Request, res: Response): Promise<void> => {
    try {
        const userId = req.user!.id;

        // Get profile
        const { data: profile } = await supabaseAdmin
            .from('user_profiles')
            .select('*')
            .eq('id', userId)
            .single();

        // Get topic mastery
        const { data: mastery } = await supabaseAdmin
            .from('topic_mastery')
            .select('*')
            .eq('user_id', userId);

        // Get course progress
        const { data: courseProgress } = await supabaseAdmin
            .from('course_progress')
            .select('*')
            .eq('user_id', userId);

        // Get recent activities
        const { data: activities } = await supabaseAdmin
            .from('activities')
            .select('*')
            .eq('user_id', userId)
            .order('created_at', { ascending: false })
            .limit(20);

        // Get notifications
        const { data: notifications } = await supabaseAdmin
            .from('notifications')
            .select('*')
            .eq('user_id', userId)
            .order('created_at', { ascending: false })
            .limit(50);

        res.json({
            profile,
            mastery: mastery || [],
            courseProgress: courseProgress || [],
            activities: activities || [],
            notifications: notifications || []
        });
    } catch (error) {
        console.error('Get full user data error:', error);
        res.status(500).json({ error: 'Failed to get user data' });
    }
});

export default router;
