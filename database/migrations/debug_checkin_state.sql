-- Debug Checkin Query
-- Run this in Supabase SQL editor to see the explicit JSON response
SELECT get_checkin_status(auth.uid());

-- See if checkins are being recorded properly today
SELECT * FROM public.user_checkins WHERE checkin_date = CURRENT_DATE;

-- Testing the new extraction function
SELECT * FROM get_checkin_status('368e775a-d16c-4b68-8095-2df9db5568f0'::uuid);

-- Show points ledger insertions to see why no animations appear
SELECT * FROM public.points_ledger ORDER BY created_at DESC LIMIT 5;
