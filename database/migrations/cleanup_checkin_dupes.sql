-- Quick cleanup: remove duplicate check-in notifications
-- Keep only the most recent check-in notification per user (any format)

-- Step 1: Delete ALL old check-in notifications (both formats)
DELETE FROM public.notifications 
WHERE id IN (
    SELECT id FROM (
        SELECT id, ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY created_at DESC) as rn
        FROM public.notifications
        WHERE text LIKE '%Daily Check-in%' OR text LIKE '%daily reward%'
    ) ranked
    WHERE rn > 1
);

-- Step 2: Reset last_notif_generated_at so fresh notifications are generated
UPDATE public.user_profiles 
SET last_notif_generated_at = NULL;
