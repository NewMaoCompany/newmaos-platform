import { Router, Request, Response } from 'express';
import { supabaseAdmin } from '../config/supabase';
import { authMiddleware } from '../middleware/auth';
import { getRelativeTime } from '../utils/time';

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
            .from('unit_mastery')
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

        // Transform notifications
        const enrichedNotifications = (notifications || []).map((item: any) => {
            return {
                ...item,
                time: getRelativeTime(new Date(item.created_at)),
                // Simplified isAccepted for this route as we don't fetch friend requests here easily without more code
                isAccepted: false
            };
        });

        res.json({
            profile,
            mastery: mastery || [],
            courseProgress: courseProgress || [],
            activities: activities || [],
            notifications: enrichedNotifications
        });
    } catch (error) {
        console.error('Get full user data error:', error);
        res.status(500).json({ error: 'Failed to get user data' });
    }
});

// POST /api/users/friend-request - Send friend request by Email or ID
router.post('/friend-request', authMiddleware, async (req: Request, res: Response): Promise<void> => {
    try {
        const userId = req.user!.id;
        const { identifier } = req.body;

        if (!identifier) {
            res.status(400).json({ error: 'Identifier (Email or ID) is required' });
            return;
        }

        const cleanIdentifier = identifier.trim();
        let targetUserId: string | null = null;

        // 1. Check if identifier is a valid UUID
        const isUUID = /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i.test(cleanIdentifier);

        if (isUUID) {
            // Check if user exists with this ID
            const { data: user, error } = await supabaseAdmin
                .from('user_profiles')
                .select('id')
                .eq('id', cleanIdentifier)
                .single();

            if (user) targetUserId = user.id;
        }

        // 2. If not found by ID (or not UUID), try Email or Name
        if (!targetUserId) {
            // First try strict email match
            const { data: userByEmail, error: emailError } = await supabaseAdmin
                .from('user_profiles')
                .select('id')
                .ilike('email', cleanIdentifier)
                .single();

            if (userByEmail) {
                targetUserId = userByEmail.id;
            } else {
                // If not found by email, try searching by name (username)
                // We use ilike for case-insensitive match on name
                const { data: userByName, error: nameError } = await supabaseAdmin
                    .from('user_profiles')
                    .select('id')
                    .ilike('name', cleanIdentifier)
                    .limit(1) // Just take the first match if multiple? Or specific logic?
                    .maybeSingle();

                if (userByName) {
                    targetUserId = userByName.id;
                }
            }

            // Fallback: If still not found, and it looks like an email, try to find in auth.users via Admin API
            // This handles cases where user_profiles.email might not be populated yet
            if (!targetUserId && cleanIdentifier.includes('@')) {
                const { data: { users }, error: listError } = await supabaseAdmin.auth.admin.listUsers();
                if (users) {
                    const foundAuthUser = users.find((u: any) => u.email?.toLowerCase() === cleanIdentifier.toLowerCase());
                    if (foundAuthUser) targetUserId = foundAuthUser.id;
                }
            }
        }

        if (!targetUserId) {
            console.log(`[FriendRequest] User not found for identifier: ${cleanIdentifier}`);
            res.status(404).json({ error: 'User not found' });
            return;
        }

        // 3. Prevent self-request
        if (targetUserId === userId) {
            res.status(400).json({ error: 'You cannot send a friend request to yourself' });
            return;
        }

        // 4. Check if request already exists
        const { data: existing, error: fetchError } = await supabaseAdmin
            .from('friend_requests')
            .select('*')
            .or(`and(sender_id.eq.${userId},receiver_id.eq.${targetUserId}),and(sender_id.eq.${targetUserId},receiver_id.eq.${userId})`)
            .maybeSingle();

        if (fetchError) {
            throw fetchError;
        }

        if (existing) {
            if (existing.status === 'accepted') {
                res.status(400).json({ error: 'You are already friends with this user' });
            } else if (existing.status === 'pending') {
                if (existing.sender_id === userId) {
                    res.status(400).json({ error: 'Friend request already sent' });
                } else {
                    res.status(400).json({ error: 'This user has already sent you a friend request. Check your notifications!' });
                }
            } else {
                // Rejected? We can allow re-sending or not. Let's allow for now if needed, or maybe specific logic.
                // For now, let's treat rejected as 'cannot send again' immediately without localized reset, 
                // BUT typically apps allow re-requesting.
                // If status is 'rejected', we might want to update it to 'pending' if the SENDER is the one who was rejected?
                // Or just insert new if row invalid? 
                // The unique constraint might block insert.
                // Let's UPDATE to pending if it exists.
                const { error: updateError } = await supabaseAdmin
                    .from('friend_requests')
                    .update({ status: 'pending', sender_id: userId, receiver_id: targetUserId }) // Reset sender/receiver direction too?
                    .eq('id', existing.id);

                if (updateError) throw updateError;
                res.json({ success: true, message: 'Friend request sent' });
                return;
            }
            return;
        }

        // 5. Create new request
        const { error: insertError } = await supabaseAdmin
            .from('friend_requests')
            .insert({
                sender_id: userId,
                receiver_id: targetUserId,
                status: 'pending'
            });

        if (insertError) {
            throw insertError;
        }

        res.json({ success: true, message: 'Friend request sent' });

    } catch (error) {
        console.error('Send friend request error:', error);
        res.status(500).json({ error: 'Failed to send friend request' });
    }
});

export default router;
