ALTER TABLE public.recommendations
ADD COLUMN IF NOT EXISTS status VARCHAR(50) DEFAULT 'pending';

ALTER TABLE public.recommendations
DROP CONSTRAINT IF EXISTS recommendations_user_id_question_id_key;

ALTER TABLE public.recommendations
ADD CONSTRAINT recommendations_user_id_question_id_mode_status_key UNIQUE (user_id, question_id, mode, status);
