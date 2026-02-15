-- Migration: Add is_creator column to user_profiles
-- This column is the source of truth for administrative/creator access in the application.

ALTER TABLE public.user_profiles 
ADD COLUMN IF NOT EXISTS is_creator BOOLEAN DEFAULT false;

-- Add a comment for clarity
COMMENT ON COLUMN public.user_profiles.is_creator IS 'True if the user is authorized to post in Information channels and access the Creator Area.';
