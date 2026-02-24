import cron from 'node-cron';
import { supabaseAdmin } from '../config/supabase';

// ==========================================
// Daily System Notification Bulk Generator
// Runs exactly at midnight (00:00) server time.
// ==========================================
export const initNotificationScheduler = () => {
    // Schedule for 00:00 every day
    // The cron expression '0 0 * * *' means: minute 0, hour 0, every day of month, every month, every day of week
    cron.schedule('0 0 * * *', async () => {
        console.log('⏰ [00:00] Running Daily System Notification Bulk Generation...');

        try {
            // Trigger the bulk generation RPC in the database
            const { error } = await supabaseAdmin.rpc('generate_daily_notifications_bulk');

            if (error) {
                console.error('❌ Failed to execute generate_daily_notifications_bulk:', error);
                throw error;
            }

            console.log('✅ Successfully completed Daily System Notification Bulk Generation for all active users.');
        } catch (err) {
            console.error('🔥 Fatal Error in Notification Bulk Scheduler:', err);
        }
    });

    console.log('✅ Daily Notification Scheduler Initialized (Midnight Bulk Generation)');
};
