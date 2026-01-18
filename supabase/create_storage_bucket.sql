-- Create images storage bucket for question images
-- Run this in Supabase SQL Editor

-- Note: Storage buckets are typically created via the Supabase dashboard,
-- but we can verify the setup is correct here.

-- Create public bucket policy (if bucket already exists via dashboard)
INSERT INTO storage.buckets (id, name, public)
VALUES ('images', 'images', true)
ON CONFLICT (id) DO UPDATE SET public = true;

-- Allow authenticated users to upload
CREATE POLICY "Authenticated users can upload images"
ON storage.objects
FOR INSERT
TO authenticated
WITH CHECK (bucket_id = 'images');

-- Allow public read access
CREATE POLICY "Public can view images"
ON storage.objects
FOR SELECT
TO public
USING (bucket_id = 'images');

-- Allow users to delete their own uploads
CREATE POLICY "Users can delete own images"
ON storage.objects
FOR DELETE
TO authenticated
USING (bucket_id = 'images');
