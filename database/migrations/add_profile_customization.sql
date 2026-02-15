-- Add customization fields to user_profiles
ALTER TABLE public.user_profiles 
ADD COLUMN IF NOT EXISTS avatar_color TEXT DEFAULT '#FACC15',
ADD COLUMN IF NOT EXISTS bio TEXT;

-- Create storage bucket for avatars if not exists (This usually needs to be done via UI or specialized API, but we can try setting policy if bucket exists)
-- Policy to allow authenticated uploads to 'avatars' bucket
-- Note: You might need to create the bucket 'avatars' manually in Supabase dashboard if it doesn't exist.

-- RLS Policy for avatars bucket (if possible via SQL, otherwise user action)
-- INSERT INTO storage.buckets (id, name, public) VALUES ('avatars', 'avatars', true) ON CONFLICT DO NOTHING;

-- POLICY: Allow public read
-- CREATE POLICY "Public Access" ON storage.objects FOR SELECT USING ( bucket_id = 'avatars' );

-- POLICY: Allow authenticated upload
-- CREATE POLICY "Authenticated Upload" ON storage.objects FOR INSERT WITH CHECK ( bucket_id = 'avatars' AND auth.role() = 'authenticated' );

-- POLICY: Allow users to update their own avatar
-- CREATE POLICY "User Update Own Avatar" ON storage.objects FOR UPDATE USING ( bucket_id = 'avatars' AND auth.uid() = owner ) WITH CHECK ( bucket_id = 'avatars' AND auth.uid() = owner );
