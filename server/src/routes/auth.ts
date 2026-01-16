import { Router, Request, Response } from 'express';
import { supabase, supabaseAdmin } from '../config/supabase';
import { Resend } from 'resend';

const router = Router();
const resend = new Resend(process.env.RESEND_API_KEY);

// Helper: Generate 6-digit code
const generateCode = () => Math.floor(100000 + Math.random() * 900000).toString();

// POST /api/auth/register
router.post('/register', async (req: Request, res: Response): Promise<void> => {
    try {
        const { email, password, name } = req.body;

        if (!email || !password || !name) {
            res.status(400).json({ error: 'Email, password, and name are required' });
            return;
        }

        // 0. Check if user already exists
        const { data: { users }, error: listError } = await supabaseAdmin.auth.admin.listUsers();
        let existingUser = users.find(u => u.email === email);
        let user = existingUser;

        if (existingUser) {
            // Case A: User exists and is confirmed -> Login required
            if (existingUser.email_confirmed_at) {
                res.status(400).json({ error: 'A user with this email address has already been registered. Please login.' });
                return;
            }
            // Case B: User exists but NOT confirmed -> Resend OTP (Allow them to proceed to verification)
            // Optional: Update metadata if name changed
            if (existingUser.user_metadata.name !== name) {
                await supabaseAdmin.auth.admin.updateUserById(existingUser.id, { user_metadata: { name } });
            }
        } else {
            // Case C: User does NOT exist -> Create new user
            const { data: authData, error: authError } = await supabase.auth.signUp({
                email,
                password,
                options: {
                    data: { name }
                }
            });

            if (authError) {
                console.error('Supabase SignUp Error:', authError);
                res.status(400).json({ error: authError.message });
                return;
            }
            user = authData.user || undefined;
        }

        if (!user) {
            res.status(500).json({ error: 'User creation failed' });
            return;
        }

        // 2. Generate OTP
        const code = generateCode();
        const expiresAt = new Date(Date.now() + 15 * 60 * 1000); // 15 mins

        // 3. Store OTP in DB
        const { error: dbError } = await supabaseAdmin
            .from('verification_codes')
            .upsert({
                email,
                code,
                expires_at: expiresAt.toISOString()
            });

        if (dbError) {
            console.error('Error saving verification code:', dbError);
        }

        // 4. Send Email via Resend
        try {
            await resend.emails.send({
                from: 'NewMaoS <onboarding@resend.dev>', // Default Resend testing domain
                to: email,
                subject: 'Your Verification Code - NewMaoS',
                html: `
                    <h1>Welcome to NewMaoS!</h1>
                    <p>Your verification code is:</p>
                    <h2 style="letter-spacing: 5px; background: #f4f4f5; padding: 10px; display: inline-block;">${code}</h2>
                    <p>This code will expire in 15 minutes.</p>
                `
            });
        } catch (emailError) {
            console.error('Resend Error:', emailError);
        }

        // 5. Ensure Profile Exists (Idempotent)
        const { data: existingProfile } = await supabaseAdmin
            .from('user_profiles')
            .select('id')
            .eq('id', user.id)
            .single();

        if (!existingProfile) {
            await supabaseAdmin.from('user_profiles').insert({
                id: user.id,
                name,
                avatar_url: `https://ui-avatars.com/api/?name=${encodeURIComponent(name)}&background=f9d406&color=1c1a0d&bold=true`,
                current_course: 'AB',
                problems_solved: 0,
                study_hours: [0, 0, 0, 0, 0, 0, 0],
                streak_days: 0,
                percentile: 0
            });

            // Initialize topic mastery
            const topics = ['Limits', 'Derivatives', 'Composite', 'Contextual Applications',
                'Analytical Applications', 'Integration', 'Diff Eq', 'App of Int',
                'Parametric/Polar', 'Series'];

            for (const topic of topics) {
                await supabaseAdmin.from('topic_mastery').insert({
                    user_id: user.id,
                    subject: topic,
                    mastery_score: 0,
                    full_mark: 100
                });
            }

            await supabaseAdmin.from('notifications').insert({
                user_id: user.id,
                text: 'Welcome to NewMaoS! Start your first session.',
                link: '/practice',
                unread: true
            });

            for (const courseId of ['AB', 'BC']) {
                await supabaseAdmin.from('course_progress').insert({
                    user_id: user.id,
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
            message: 'Registration successful. Please check your email for the verification code.',
            user: user,
            session: null // No session yet
        });

    } catch (error: any) {
        console.error('Register error:', error);
        res.status(500).json({ error: error.message || 'Registration failed' });
    }
});

// POST /api/auth/verify-email
router.post('/verify-email', async (req: Request, res: Response): Promise<void> => {
    try {
        const { email, code } = req.body;

        if (!email || !code) {
            res.status(400).json({ error: 'Email and code are required' });
            return;
        }

        // 1. Verify Code
        const { data: record, error: fetchError } = await supabaseAdmin
            .from('verification_codes')
            .select('*')
            .eq('email', email)
            .single();

        if (fetchError || !record) {
            res.status(400).json({ error: 'Invalid or expired verification code' });
            return;
        }

        if (record.code !== code) {
            res.status(400).json({ error: 'Incorrect verification code' });
            return;
        }

        if (new Date(record.expires_at) < new Date()) {
            res.status(400).json({ error: 'Verification code has expired' });
            return;
        }

        // 2. Confirm User
        let targetUserId;
        const { data: { users } } = await supabaseAdmin.auth.admin.listUsers();
        const found = users.find(u => u.email === email);
        if (found) targetUserId = found.id;

        if (!targetUserId) {
            res.status(404).json({ error: 'User not found' });
            return;
        }

        const { error: updateError } = await supabaseAdmin.auth.admin.updateUserById(
            targetUserId,
            { email_confirm: true }
        );

        if (updateError) {
            res.status(400).json({ error: updateError.message });
            return;
        }

        await supabaseAdmin.from('verification_codes').delete().eq('email', email);
        res.json({ success: true, message: 'Email verified successfully' });

    } catch (error: any) {
        console.error('Verify error:', error);
        res.status(500).json({ error: 'Verification failed' });
    }
});

// POST /api/auth/resend-verification
router.post('/resend-verification', async (req: Request, res: Response): Promise<void> => {
    try {
        const { email } = req.body;
        if (!email) {
            res.status(400).json({ error: 'Email is required' });
            return;
        }

        const code = generateCode();
        const expiresAt = new Date(Date.now() + 15 * 60 * 1000);

        await supabaseAdmin
            .from('verification_codes')
            .upsert({ email, code, expires_at: expiresAt.toISOString() });

        await resend.emails.send({
            from: 'NewMaoS <onboarding@resend.dev>',
            to: email,
            subject: 'New Verification Code - NewMaoS',
            html: `
                <p>Your new verification code is:</p>
                <h2 style="letter-spacing: 5px; background: #f4f4f5; padding: 10px; display: inline-block;">${code}</h2>
            `
        });

        res.json({ message: 'Code resent successfully' });
    } catch (error: any) {
        console.error('Resend error:', error);
        res.status(500).json({ error: 'Failed to resend' });
    }
});

// POST /api/auth/login
router.post('/login', async (req: Request, res: Response): Promise<void> => {
    try {
        const { email, password } = req.body;
        const { data, error } = await supabase.auth.signInWithPassword({
            email,
            password
        });

        if (error) {
            console.error('Supabase Auth SignIn Error:', error);
            res.status(401).json({ error: error.message });
            return;
        }

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

        const { error } = await supabase.auth.updateUser({ password });

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
        if (password !== 'CzLjc6120') {
            res.status(403).json({ error: 'Access denied' });
            return;
        }

        if (userId) {
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
