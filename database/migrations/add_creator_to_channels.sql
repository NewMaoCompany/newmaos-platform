-- Add creator_id to forum_channels if not exists
DO $$ 
BEGIN 
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'forum_channels' AND column_name = 'creator_id') THEN 
        ALTER TABLE public.forum_channels ADD COLUMN creator_id UUID REFERENCES auth.users(id) ON DELETE SET NULL; 
    END IF; 
END $$;
