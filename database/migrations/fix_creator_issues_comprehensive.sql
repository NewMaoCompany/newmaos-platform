-- =================================================================
-- COMPREHENSIVE FIX FOR CREATOR ISSUES (TITLES & IMAGE UPLOADS)
-- =================================================================

-- 1. FIX STORAGE PERMISSIONS (Enable Image Uploads)
-- Ensure the 'images' bucket exists and is public
INSERT INTO storage.buckets (id, name, public)
VALUES ('images', 'images', true)
ON CONFLICT (id) DO UPDATE SET public = true;

-- Drop existing policies to avoid conflicts/duplicates and ensure clean slate
DROP POLICY IF EXISTS "Authenticated users can upload images" ON storage.objects;
DROP POLICY IF EXISTS "Public can view images" ON storage.objects;
DROP POLICY IF EXISTS "Users can update own images" ON storage.objects;
DROP POLICY IF EXISTS "Users can delete own images" ON storage.objects;

-- Create robust RLS policies for storage.objects
-- Allow any authenticated user to upload (simplest fix for creators)
CREATE POLICY "Authenticated users can upload images"
ON storage.objects FOR INSERT
TO authenticated
WITH CHECK (bucket_id = 'images');

-- Allow public access to view images
CREATE POLICY "Public can view images"
ON storage.objects FOR SELECT
TO public
USING (bucket_id = 'images');

-- Allow users to update/delete their own uploads (optional but good practice)
CREATE POLICY "Users can update own images"
ON storage.objects FOR UPDATE
TO authenticated
USING (bucket_id = 'images' AND owner = auth.uid());

CREATE POLICY "Users can delete own images"
ON storage.objects FOR DELETE
TO authenticated
USING (bucket_id = 'images' AND owner = auth.uid());


-- 2. FIX QUESTIONS RELIABILITY (No Title Issue)
-- Backfill any existing questions that have NULL or empty titles
UPDATE public.questions
SET title = CASE 
    WHEN prompt IS NOT NULL AND length(prompt) > 0 THEN 
        substring(prompt from 1 for 40) || '...'
    ELSE 
        'Untitled Question'
    END
WHERE title IS NULL OR length(trim(title)) = 0;

-- Enforce Title Integrity at Database Level
-- This prevents any future inserts from having NULL titles
ALTER TABLE public.questions
ALTER COLUMN title SET DEFAULT 'Untitled Question',
ALTER COLUMN title SET NOT NULL;


-- 3. VERIFY CREATOR PERMISSIONS (Just in case)
-- Ensure creators can definitely insert questions
DROP POLICY IF EXISTS "Creators can insert questions" ON public.questions;
CREATE POLICY "Creators can insert questions" ON public.questions
  FOR INSERT WITH CHECK (
    EXISTS (SELECT 1 FROM public.user_profiles WHERE id = auth.uid() AND is_creator = true)
  );

-- Ensure creators can update questions
DROP POLICY IF EXISTS "Creators can update questions" ON public.questions;
CREATE POLICY "Creators can update questions" ON public.questions
  FOR UPDATE USING (
    EXISTS (SELECT 1 FROM public.user_profiles WHERE id = auth.uid() AND is_creator = true)
  );

-- =================================================================
-- END OF FIX
-- =================================================================
