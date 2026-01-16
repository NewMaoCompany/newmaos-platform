import { Router, Request, Response } from 'express';
import { supabase, supabaseAdmin } from '../config/supabase';

const router = Router();

// POST /api/auth/register
router.post('/register', async (req: Request, res: Response): Promise<void> => {
    try {
        const { email, password, name } = req.body;

        if (!email || !password || !name) {
            res.status(400).json({ error: 'Email, password, and name are required' });
            return;
        }

        // Register user with Supabase Auth
        const { data: authData, error: authError } = await supabase.auth.signUp({
            email,
            password,
            options: {
                data: { name }
            }
        });

        if (authError) {
            res.status(400).json({ error: authError.message });
            return;
        }

        if (authData.user) {
            // Create user profile
            const { error: profileError } = await supabaseAdmin
                .from('user_profiles')
                .insert({
                    id: authData.user.id,
                    name,
                    avatar_url: `https://ui-avatars.com/api/?name=${encodeURIComponent(name)}&background=f9d406&color=1c1a0d&bold=true`,
                    current_course: 'AB',
                    problems_solved: 0,
                    study_hours: [0, 0, 0, 0, 0, 0, 0],
                    streak_days: 0,
                    percentile: 0
                });

            if (profileError) {
                console.error('Profile creation error:', profileError);
            }

            // Initialize topic mastery for new user
            const topics = ['Limits', 'Derivatives', 'Composite', 'Contextual Applications',
                'Analytical Applications', 'Integration', 'Diff Eq', 'App of Int',
                'Parametric/Polar', 'Series'];

            for (const topic of topics) {
                await supabaseAdmin.from('topic_mastery').insert({
                    user_id: authData.user.id,
                    subject: topic,
                    mastery_score: 0,
                    full_mark: 100
                });
            }

            // Create welcome notification
            await supabaseAdmin.from('notifications').insert({
                user_id: authData.user.id,
                text: 'Welcome to NewMaoS! Start your first session.',
                link: '/practice',
                unread: true
            });

            // Initialize course progress
            for (const courseId of ['AB', 'BC']) {
                await supabaseAdmin.from('course_progress').insert({
                    user_id: authData.user.id,
                    course_id: courseId,
                    status: 'Not Started',
                    current_module_index: 0,
                    modules: courseId === 'AB'
                        ? [{ id: 'm1', title: 'Limits & Continuity', progress: 0, status: 'active' },
                        { id: 'm2', title: 'Differentiation', progress: 0, status: 'locked' }]
                        : [{ id: 'm1', title: 'Infinite Sequences and Series', progress: 0, status: 'active' },
                        { id: 'm2', title: 'Parametric Equations', progress: 0, status: 'locked' }]
                });
            }
        }

        res.status(201).json({
            message: 'Registration successful',
            user: authData.user,
            session: authData.session
        });
    } catch (error) {
        console.error('Register error:', error);
        res.status(500).json({ error: 'Registration failed' });
    }
});

// POST /api/auth/login
router.post('/login', async (req: Request, res: Response): Promise<void> => {
    try {
        const { email, password } = req.body;

        if (!email || !password) {
            res.status(400).json({ error: 'Email and password are required' });
            return;
        }

        const { data, error } = await supabase.auth.signInWithPassword({
            email,
            password
        });

        if (error) {
            res.status(401).json({ error: error.message });
            return;
        }

        // Fetch user profile
        const { data: profile } = await supabaseAdmin
            .from('user_profiles')
            .select('*')
            .eq('id', data.user.id)
            .single();

        res.json({
            user: data.user,
            profile,
            session: data.session
        });
    } catch (error) {
        console.error('Login error:', error);
        res.status(500).json({ error: 'Login failed' });
    }
});

// POST /api/auth/logout
router.post('/logout', async (req: Request, res: Response): Promise<void> => {
    try {
        const { error } = await supabase.auth.signOut();

        if (error) {
            res.status(400).json({ error: error.message });
            return;
        }

        res.json({ message: 'Logged out successfully' });
    } catch (error) {
        console.error('Logout error:', error);
        res.status(500).json({ error: 'Logout failed' });
    }
});

// POST /api/auth/forgot-password
router.post('/forgot-password', async (req: Request, res: Response): Promise<void> => {
    try {
        const { email } = req.body;

        if (!email) {
            res.status(400).json({ error: 'Email is required' });
            return;
        }

        const { error } = await supabase.auth.resetPasswordForEmail(email, {
            redirectTo: `${process.env.FRONTEND_URL || 'http://localhost:3000'}/reset-password`
        });

        if (error) {
            res.status(400).json({ error: error.message });
            return;
        }

        res.json({ message: 'Password reset email sent' });
    } catch (error) {
        console.error('Forgot password error:', error);
        res.status(500).json({ error: 'Failed to send reset email' });
    }
});

// POST /api/auth/reset-password
router.post('/reset-password', async (req: Request, res: Response): Promise<void> => {
    try {
        const { password, token } = req.body;

        if (!password || !token) {
            res.status(400).json({ error: 'Password and token are required' });
            return;
        }

        const { error } = await supabase.auth.updateUser({
            password
        });

        if (error) {
            res.status(400).json({ error: error.message });
            return;
        }

        res.json({ message: 'Password updated successfully' });
    } catch (error) {
        console.error('Reset password error:', error);
        res.status(500).json({ error: 'Failed to reset password' });
    }
});

// POST /api/auth/verify-creator
router.post('/verify-creator', async (req: Request, res: Response): Promise<void> => {
    try {
        const { password, userId } = req.body;

        // Creator password check (in production, use secure method)
        if (password !== 'CzLjc6120') {
            res.status(403).json({ error: 'Access denied' });
            return;
        }

        if (userId) {
            // Update user profile to mark as creator
            await supabaseAdmin
                .from('user_profiles')
                .update({ is_creator: true })
                .eq('id', userId);
        }

        res.json({ success: true, message: 'Creator access granted' });
    } catch (error) {
        console.error('Verify creator error:', error);
        res.status(500).json({ error: 'Verification failed' });
    }
});

export default router;
