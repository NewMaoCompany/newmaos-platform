import cron from 'node-cron';
import { supabaseAdmin } from '../config/supabase';
import { sendEmail } from './emailService';
import dotenv from 'dotenv';

dotenv.config();

// ==========================================
// 1. Weekly Progress (Gold/Black - Premium)
// ==========================================
// ... (templates remain the same)
const templateWeeklyProgress = (name: string) => `
<!DOCTYPE html>
<html>
<body style="margin:0;padding:0;font-family:'Helvetica Neue',Helvetica,Arial,sans-serif;background-color:#f4f4f4;">
    <table width="100%" cellpadding="0" cellspacing="0" style="background-color:#f4f4f4;padding:40px 0;">
        <tr>
            <td align="center">
                <table width="600" cellpadding="0" cellspacing="0" style="background-color:#ffffff;border-radius:16px;overflow:hidden;box-shadow:0 8px 30px rgba(0,0,0,0.12);">
                    <!-- Header -->
                    <tr>
                        <td style="background-color:#1c1a0d;padding:40px;text-align:center;">
                            <div style="display:inline-block;width:60px;height:60px;background:#f9d406;border-radius:14px;line-height:60px;font-size:32px;font-weight:bold;color:#1c1a0d;">∫</div>
                            <h1 style="color:#ffffff;margin-top:20px;font-size:24px;letter-spacing:1px;">WEEKLY MASTERY</h1>
                        </td>
                    </tr>
                    <!-- Body -->
                    <tr>
                        <td style="padding:40px;">
                            <p style="font-size:18px;color:#333;line-height:1.6;">Hello <strong>${name}</strong>,</p>
                            <p style="font-size:16px;color:#555;line-height:1.6;">Your weekly calculus analysis is ready. You've shown consistent progress in <strong>Derivatives</strong> and <strong>Integrals</strong>.</p>
                            
                            <div style="margin:30px 0;background:#fcfcfc;border:1px solid #eee;border-radius:12px;padding:20px;">
                                <table width="100%">
                                    <tr>
                                        <td align="center" style="border-right:1px solid #eee;">
                                            <div style="font-size:32px;font-weight:bold;color:#1c1a0d;">85%</div>
                                            <div style="font-size:12px;color:#888;text-transform:uppercase;letter-spacing:1px;">Accuracy</div>
                                        </td>
                                        <td align="center">
                                            <div style="font-size:32px;font-weight:bold;color:#f9d406;">12</div>
                                            <div style="font-size:12px;color:#888;text-transform:uppercase;letter-spacing:1px;">Problems Solved</div>
                                        </td>
                                    </tr>
                                </table>
                            </div>

                            <a href="https://newmaos.com/dashboard" style="display:block;width:100%;background:#1c1a0d;color:#ffffff;text-align:center;padding:16px 0;border-radius:8px;text-decoration:none;font-weight:bold;font-size:16px;">View Full Report</a>
                        </td>
                    </tr>
                    <!-- Footer -->
                    <tr>
                        <td style="background-color:#f9f9f9;padding:20px;text-align:center;font-size:12px;color:#888;">
                            © 2026 NewMaoS Learning. All rights reserved.
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</body>
</html>
`;

// ==========================================
// 2. Math Challenge (Vibrant Purple - Interactive)
// ==========================================
const templateMathChallenge = (name: string) => `
<!DOCTYPE html>
<html>
<body style="margin:0;padding:0;font-family:'Segoe UI',Roboto,Arial,sans-serif;background-color:#f0f0ff;">
    <table width="100%" cellpadding="0" cellspacing="0" style="background-color:#f0f0ff;padding:40px 0;">
        <tr>
            <td align="center">
                <table width="600" cellpadding="0" cellspacing="0" style="background-color:#ffffff;border-radius:20px;overflow:hidden;box-shadow:0 10px 40px rgba(100,0,255,0.15);">
                    <!-- Header -->
                    <tr>
                        <td style="background:linear-gradient(135deg, #6366f1 0%, #a855f7 100%);padding:50px;text-align:center;">
                            <h1 style="color:#ffffff;margin:0;font-size:32px;font-weight:900;text-shadow:0 2px 10px rgba(0,0,0,0.2);">CHALLENGE ACCEPTED?</h1>
                            <p style="color:rgba(255,255,255,0.9);font-size:18px;margin-top:10px;">Weekly problem #42 is live.</p>
                        </td>
                    </tr>
                    <!-- Body -->
                    <tr>
                        <td style="padding:40px;text-align:center;">
                            <p style="font-size:18px;color:#333;">Hey ${name}, are you ready to test your limits?</p>
                            
                            <div style="margin:30px auto;padding:20px;background:#fdf4ff;border:2px dashed #d8b4fe;border-radius:12px;display:inline-block;text-align:left;">
                                <p style="font-family:monospace;font-size:16px;color:#6b21a8;margin:0;">
                                    lim (x→0) [sin(3x) / (e^(2x) - 1)] = ?
                                </p>
                            </div>

                            <p style="color:#666;margin-bottom:30px;">Solve this correctly to earn the "Limit Breaker" badge on your profile.</p>

                            <a href="https://newmaos.com/practice" style="display:inline-block;background:#8b5cf6;color:#ffffff;padding:16px 40px;border-radius:50px;text-decoration:none;font-weight:bold;font-size:16px;box-shadow:0 4px 15px rgba(139,92,246,0.3);">Solve Now</a>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</body>
</html>
`;

// ==========================================
// 3. Motivation Streak (Minimalist Green - Zen)
// ==========================================
const templateMotivation = (name: string) => `
<!DOCTYPE html>
<html>
<body style="margin:0;padding:0;font-family:'Georgia',serif;background-color:#f7f9f7;">
    <table width="100%" cellpadding="0" cellspacing="0" style="background-color:#f7f9f7;padding:40px 0;">
        <tr>
            <td align="center">
                <table width="600" cellpadding="0" cellspacing="0" style="background-color:#ffffff;border:1px solid #e0e7e0;box-shadow:0 4px 12px rgba(0,0,0,0.05);">
                    <!-- Body -->
                    <tr>
                        <td style="padding:60px;text-align:center;">
                            <div style="font-size:48px;color:#15803d;margin-bottom:20px;">❝</div>
                            <p style="font-size:24px;font-style:italic;color:#333;line-height:1.5;margin-bottom:30px;">
                                "Mathematics is not about numbers, equations, computations, or algorithms: it is about understanding."
                            </p>
                            <p style="font-size:14px;color:#15803d;font-weight:bold;letter-spacing:2px;text-transform:uppercase;">— William Paul Thurston</p>
                            
                            <hr style="border:0;border-top:1px solid #eee;margin:40px 0;">
                            
                            <p style="font-family:'Helvetica',sans-serif;font-size:16px;color:#555;">
                                Keep going, ${name}. Consistency is key to mastery. You're building something great, one problem at a time.
                            </p>
                            
                            <a href="https://newmaos.com/dashboard" style="display:inline-block;margin-top:20px;font-family:'Helvetica',sans-serif;font-size:14px;color:#15803d;text-decoration:none;border-bottom:1px solid #15803d;padding-bottom:2px;">Continue Your Streak →</a>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</body>
</html>
`;

// ==========================================
// 4. Exam Countdown (Urgent Red - Focus)
// ==========================================
const templateExamCountdown = (name: string) => `
<!DOCTYPE html>
<html>
<body style="margin:0;padding:0;font-family:-apple-system,BlinkMacSystemFont,'Segoe UI',Roboto,Helvetica,Arial,sans-serif;background-color:#fff1f2;">
    <table width="100%" cellpadding="0" cellspacing="0" style="background-color:#fff1f2;padding:40px 0;">
        <tr>
            <td align="center">
                <table width="500" cellpadding="0" cellspacing="0" style="background-color:#ffffff;border-radius:8px;border-top:4px solid #e11d48;box-shadow:0 2px 10px rgba(0,0,0,0.1);">
                    <!-- Header -->
                    <tr>
                        <td style="padding:30px;text-align:left;">
                            <h2 style="color:#9f1239;margin:0;font-size:20px;text-transform:uppercase;letter-spacing:0.5px;">AP Exam Countdown</h2>
                        </td>
                        <td style="padding:30px;text-align:right;">
                            <span style="background:#ffe4e6;color:#e11d48;padding:6px 12px;border-radius:4px;font-size:12px;font-weight:bold;">CRITICAL</span>
                        </td>
                    </tr>
                    <!-- Body -->
                    <tr>
                        <td colspan="2" style="padding:0 30px 40px;">
                            <div style="font-size:42px;font-weight:800;color:#1c1917;margin-bottom:10px;">116 Days</div>
                            <p style="font-size:16px;color:#57534e;margin:0 0 20px;">until the AP Calculus Exam (May 2026).</p>
                            
                            <div style="background:#fafaf9;border-left:3px solid #57534e;padding:15px;margin-bottom:25px;">
                                <p style="margin:0;font-size:14px;color:#444;"><strong>Tip of the Week:</strong> Don't forget the +C in indefinite integrals! It's the most common point deduction.</p>
                            </div>

                            <a href="https://newmaos.com/practice?mode=exam" style="display:block;background:#e11d48;color:#ffffff;text-align:center;padding:14px;border-radius:6px;text-decoration:none;font-weight:bold;">Start Timed Simulation</a>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</body>
</html>
`;

// ==========================================
// 5. New Content (Modern Blue - News)
// ==========================================
const templateNewContent = (name: string) => `
<!DOCTYPE html>
<html>
<body style="margin:0;padding:0;font-family:'Inter',sans-serif;background-color:#ecfeff;">
    <table width="100%" cellpadding="0" cellspacing="0" style="background-color:#ecfeff;padding:40px 0;">
        <tr>
            <td align="center">
                <table width="600" cellpadding="0" cellspacing="0" style="background-color:#ffffff;border-radius:24px;overflow:hidden;">
                    <!-- Image Area -->
                    <tr>
                        <td style="background-color:#0ea5e9;padding:40px;text-align:center;background-image:linear-gradient(45deg, #0ea5e9 25%, #0284c7 25%, #0284c7 50%, #0ea5e9 50%, #0ea5e9 75%, #0284c7 75%, #0284c7 100%);background-size:20px 20px;">
                            <img src="https://cdn-icons-png.flaticon.com/512/2997/2997235.png" alt="New Content" width="80" style="background:white;padding:15px;border-radius:50%;">
                        </td>
                    </tr>
                    <!-- Body -->
                    <tr>
                        <td style="padding:40px;">
                            <small style="color:#0ea5e9;font-weight:bold;text-transform:uppercase;">Just Released</small>
                            <h2 style="margin:10px 0 20px;color:#0f172a;font-size:28px;">Mastering Series Convergence</h2>
                            <p style="font-size:16px;color:#475569;line-height:1.6;margin-bottom:30px;">
                                We've added 50 new practice problems focused on Ratio and Root tests. Perfect for BC students looking to secure that 5.
                            </p>
                            
                            <table width="100%">
                                <tr>
                                    <td>
                                        <a href="https://newmaos.com/dashboard" style="background:#0ea5e9;color:white;padding:12px 24px;border-radius:12px;text-decoration:none;font-weight:bold;">Try New Problems</a>
                                    </td>
                                    <td align="right">
                                        <span style="color:#94a3b8;font-size:14px;">Review Topic 10.5</span>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</body>
</html>
`;

// Helper: Get Random Template
const getRandomTemplate = (name: string) => {
    const templates = [
        { subject: 'Your Weekly Calculus Report 📊', html: templateWeeklyProgress(name) },
        { subject: 'Can you solve this? 🧠', html: templateMathChallenge(name) },
        { subject: 'Monday Motivation: Keep Grinding 🌱', html: templateMotivation(name) },
        { subject: 'AP Exam Countdown: Time check ⏰', html: templateExamCountdown(name) },
        { subject: 'New Practice Problems Added 📘', html: templateNewContent(name) },
    ];
    return templates[Math.floor(Math.random() * templates.length)];
};

// Scheduler Logic
export const initEmailScheduler = () => {
    // Schedule for Monday at 9:00 AM
    cron.schedule('0 9 * * 1', async () => {
        console.log('⏰ Running Weekly Email Notification Job...');

        try {
            // 1. Fetch Users with Email Notifications Enabled
            const { data: users, error } = await supabaseAdmin
                .from('user_profiles')
                .select('id, email, name, email_notifications')
                .eq('email_notifications', true);

            if (error) throw error;
            if (!users || users.length === 0) {
                console.log('No users subscribed to email notifications.');
                return;
            }

            console.log(`📧 Found ${users.length} users subscribed.`);

            // 2. Send Emails
            for (const user of users) {
                const { subject, html } = getRandomTemplate(user.name || 'Student');

                try {
                    await sendEmail(
                        user.email,
                        subject,
                        html
                    );
                    console.log(`✅ Sent weekly email to ${user.email}`);

                    // 3. Insert In-App Notification
                    // Clean subject for notification text (remove emojis if needed, or keep them)
                    const notifText = subject;

                    // Determine link based on subject
                    let link = '/dashboard';
                    if (subject.includes('Challenge')) link = '/practice';
                    else if (subject.includes('Exam')) link = '/practice?mode=exam';
                    else if (subject.includes('New Practice')) link = '/practice';

                    await supabaseAdmin.from('notifications').insert({
                        user_id: user.id,
                        text: notifText,
                        link: link,
                        unread: true,
                        created_at: new Date().toISOString()
                    });

                } catch (sendError) {
                    console.error(`❌ Failed to send to ${user.email}:`, sendError);
                }
            }
        } catch (err) {
            console.error('🔥 Fatal Error in Email Scheduler:', err);
        }
    });

    // ------------------------------------------
    // 2. Daily Notification Cleanup (3:00 AM)
    // ------------------------------------------
    cron.schedule('0 3 * * *', async () => {
        console.log('⏰ Running Daily Notification Cleanup Job...');
        try {
            const { error } = await supabaseAdmin.rpc('cleanup_read_notifications');
            if (error) throw error;
            console.log('✅ Cleaned up old read notifications');
        } catch (err) {
            console.error('❌ Notification Cleanup Error:', err);
        }
    });

    console.log('✅ Email Scheduler Initialized (Weekly Emails + Daily Cleanup)');
};
