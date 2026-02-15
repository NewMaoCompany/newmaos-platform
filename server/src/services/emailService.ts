import { Resend } from 'resend';
import dotenv from 'dotenv';

dotenv.config();

const RESEND_API_KEY = process.env.RESEND_API_KEY || '';
const resend = RESEND_API_KEY ? new Resend(RESEND_API_KEY) : null;

export const sendEmail = async (to: string, subject: string, html: string, from?: string) => {
    if (!resend) {
        console.warn('⚠️ RESEND_API_KEY is not set. Email not sent.');
        return;
    }

    // Use verified domain for production sending
    const sender = from || 'NewMaoS <noreply@newmaos.com>';

    try {
        const { data, error } = await resend.emails.send({
            from: sender,
            to,
            subject,
            html,
        });

        if (error) {
            console.error('❌ Resend Error:', error);
            throw error;
        }

        console.log(`✅ Email sent to ${to} via Resend: ${data?.id}`);
    } catch (error: any) {
        console.error('❌ Email Service Error:', error.message);
        throw error;
    }
};
