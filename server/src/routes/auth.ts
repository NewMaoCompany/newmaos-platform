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

        // 0. Check if user already exists in auth
        const { data: { users } } = await supabaseAdmin.auth.admin.listUsers();
        const existingUser = users.find(u => u.email === email);

        if (existingUser) {
            if (existingUser.email_confirmed_at) {
                res.status(400).json({ error: 'A user with this email address has already been registered. Please login.' });
                return;
            }
            // User exists but not confirmed - delete the incomplete user so they can re-register
            await supabaseAdmin.auth.admin.deleteUser(existingUser.id);
        }

        // 1. Generate 6-digit verification code
        const code = generateCode();
        const expiresAt = new Date(Date.now() + 10 * 60 * 1000); // 10 minutes

        // 2. Store registration data + verification code in DB (user NOT created yet)
        // Password is stored temporarily - will be used to create user after verification
        const { error: dbError } = await supabaseAdmin
            .from('verification_codes')
            .upsert({
                email,
                code,
                expires_at: expiresAt.toISOString(),
                // Store registration data for later user creation
                metadata: JSON.stringify({ name, password })
            });

        if (dbError) {
            console.error('Error saving verification code:', dbError);
            res.status(500).json({ error: 'Failed to initiate registration' });
            return;
        }

        // 3. Send 6-digit OTP Email via Resend
        try {
            await resend.emails.send({
                from: 'NewMaoS <noreply@newmaos.com>',
                to: email,
                subject: 'Your Verification Code - NewMaoS',
                html: `
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body style="margin: 0; padding: 0; font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif; background-color: #f5f5f5;">
    <table role="presentation" width="100%" cellspacing="0" cellpadding="0" style="min-width: 100%; background-color: #f5f5f5;">
        <tr>
            <td align="center" style="padding: 40px 20px;">
                <table role="presentation" width="100%" cellspacing="0" cellpadding="0" style="max-width: 480px; background-color: #ffffff; border-radius: 16px; box-shadow: 0 4px 24px rgba(0,0,0,0.08);">
                    <tr>
                        <td style="padding: 40px 40px 24px; text-align: center;">
                            <div style="display: inline-block; background: #f9d406; width: 56px; height: 56px; border-radius: 14px; line-height: 56px; font-size: 28px; font-weight: 900; color: #1c1a0d;">∫</div>
                            <h1 style="margin: 20px 0 0; font-size: 24px; font-weight: 800; color: #1c1a0d;">Your Verification Code</h1>
                        </td>
                    </tr>
                    <tr>
                        <td style="padding: 0 40px 32px;">
                            <p style="margin: 0 0 24px; font-size: 16px; line-height: 1.6; color: #4a4a4a; text-align: center;">
                                Hi <strong>${name}</strong>, use this code to verify your email:
                            </p>
                            <div style="background: #f5f5f5; border-radius: 12px; padding: 20px; text-align: center; margin-bottom: 24px;">
                                <span style="font-size: 36px; font-weight: 900; letter-spacing: 8px; color: #1c1a0d;">${code}</span>
                            </div>
                            <p style="margin: 0; font-size: 13px; color: #888; text-align: center;">
                                This code expires in 15 minutes.
                            </p>
                        </td>
                    </tr>
                    <tr>
                        <td style="padding: 24px 40px 32px; text-align: center; border-top: 1px solid #eee;">
                            <p style="margin: 0; font-size: 12px; color: #aaa;">
                                If you didn't request this code, you can ignore this email.
                            </p>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</body>
</html>
                `
            });
            console.log(`✅ Verification code sent to ${email}: ${code}`);
        } catch (emailError: any) {
            console.error('❌ Resend Error:', emailError?.message || emailError);
            console.log(`📧 [DEV FALLBACK] Verification code for ${email}: ${code}`);
        }

        // NOTE: No user is created yet - only after OTP verification
        res.status(201).json({
            message: 'Verification code sent. Please check your email.',
            email: email
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

        // 2. Get registration data from stored metadata
        let registrationData: { name: string; password: string };
        try {
            registrationData = JSON.parse(record.metadata || '{}');
            if (!registrationData.name || !registrationData.password) {
                throw new Error('Missing registration data');
            }
        } catch (e) {
            res.status(400).json({ error: 'Invalid registration data. Please register again.' });
            return;
        }

        // 3. Create auth user NOW (after OTP verification)
        const { data: authData, error: authError } = await supabaseAdmin.auth.admin.createUser({
            email,
            password: registrationData.password,
            email_confirm: true, // Already verified via OTP
            user_metadata: { name: registrationData.name }
        });

        if (authError) {
            console.error('Supabase CreateUser Error:', authError);
            res.status(400).json({ error: authError.message });
            return;
        }

        const user = authData.user;
        if (!user) {
            res.status(500).json({ error: 'User creation failed' });
            return;
        }

        const targetUserId = user.id;
        const userName = registrationData.name;

        // 4. Create user profile
        await supabaseAdmin.from('user_profiles').insert({
            id: targetUserId,
            name: userName,
            avatar_url: `https://ui-avatars.com/api/?name=${encodeURIComponent(userName)}&background=f9d406&color=1c1a0d&bold=true`,
            current_course: 'AB',
            problems_solved: 0,
            study_hours: [0, 0, 0, 0, 0, 0, 0],
            streak_days: 0,
            percentile: 0
        });

        // 5. Initialize topic mastery
        const topics = ['Limits', 'Derivatives', 'Composite', 'Contextual Applications',
            'Analytical Applications', 'Integration', 'Diff Eq', 'App of Int',
            'Parametric/Polar', 'Series'];

        for (const topic of topics) {
            await supabaseAdmin.from('topic_mastery').insert({
                user_id: targetUserId,
                subject: topic,
                mastery_score: 0,
                full_mark: 100
            });
        }

        // 6. Welcome notification
        await supabaseAdmin.from('notifications').insert({
            user_id: targetUserId,
            text: 'Welcome to NewMaoS! Start your first session.',
            link: '/practice',
            unread: true
        });

        // 7. Initialize course progress
        for (const courseId of ['AB', 'BC']) {
            await supabaseAdmin.from('course_progress').insert({
                user_id: targetUserId,
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

        console.log(`✅ User and profile created for: ${email}`);

        // 8. Cleanup verification code
        await supabaseAdmin.from('verification_codes').delete().eq('email', email);
        res.json({ success: true, message: 'Email verified and account created successfully!' });

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

        // Get user name from auth
        const { data: { users } } = await supabaseAdmin.auth.admin.listUsers();
        const found = users.find(u => u.email === email);
        const userName = found?.user_metadata?.name || email.split('@')[0];

        const code = generateCode();
        const expiresAt = new Date(Date.now() + 10 * 60 * 1000); // 10 minutes

        await supabaseAdmin
            .from('verification_codes')
            .upsert({ email, code, expires_at: expiresAt.toISOString() });

        try {
            await resend.emails.send({
                from: 'NewMaoS <noreply@newmaos.com>',
                to: email,
                subject: 'Your Verification Code - NewMaoS',
                html: `
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body style="margin: 0; padding: 0; font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif; background-color: #f5f5f5;">
    <table role="presentation" width="100%" cellspacing="0" cellpadding="0" style="min-width: 100%; background-color: #f5f5f5;">
        <tr>
            <td align="center" style="padding: 40px 20px;">
                <table role="presentation" width="100%" cellspacing="0" cellpadding="0" style="max-width: 480px; background-color: #ffffff; border-radius: 16px; box-shadow: 0 4px 24px rgba(0,0,0,0.08);">
                    <tr>
                        <td style="padding: 40px 40px 24px; text-align: center;">
                            <div style="display: inline-block; background: #f9d406; width: 56px; height: 56px; border-radius: 14px; line-height: 56px; font-size: 28px; font-weight: 900; color: #1c1a0d;">∫</div>
                            <h1 style="margin: 20px 0 0; font-size: 24px; font-weight: 800; color: #1c1a0d;">Your Verification Code</h1>
                        </td>
                    </tr>
                    <tr>
                        <td style="padding: 0 40px 32px;">
                            <p style="margin: 0 0 24px; font-size: 16px; line-height: 1.6; color: #4a4a4a; text-align: center;">
                                Hi <strong>${userName}</strong>, use this code to verify your email:
                            </p>
                            <div style="background: #f5f5f5; border-radius: 12px; padding: 20px; text-align: center; margin-bottom: 24px;">
                                <span style="font-size: 36px; font-weight: 900; letter-spacing: 8px; color: #1c1a0d;">${code}</span>
                            </div>
                            <p style="margin: 0; font-size: 13px; color: #888; text-align: center;">
                                This code expires in 15 minutes.
                            </p>
                        </td>
                    </tr>
                    <tr>
                        <td style="padding: 24px 40px 32px; text-align: center; border-top: 1px solid #eee;">
                            <p style="margin: 0; font-size: 12px; color: #aaa;">
                                If you didn't request this code, you can ignore this email.
                            </p>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</body>
</html>
                `
            });
            console.log(`✅ Verification code resent to ${email}: ${code}`);
        } catch (emailError: any) {
            console.error('❌ Resend Error:', emailError?.message || emailError);
            console.log(`📧 [DEV FALLBACK] Verification code for ${email}: ${code}`);
        }

        res.json({ message: 'Verification code sent successfully' });
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
