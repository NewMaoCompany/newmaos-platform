-- ============================================================
-- Cleanup: Remove OLD 10.1/10.2 questions by their known IDs
-- These are the original IDs from the first batch of inserts
-- Run in Supabase SQL Editor
-- ============================================================
BEGIN;

ALTER TABLE public.questions DISABLE TRIGGER USER;

-- Clean up all FK references first
DELETE FROM public.question_skills WHERE question_id IN (
  '0f3b5c8a-7e1f-4b67-bc66-2d1b76a7b2e1',
  '2a0f7f4d-6dd0-4c8a-9fb6-5b2d4d6b7a9a',
  '7b6f6f2a-0c5b-44b0-9b4b-7c4a76f1b2c7',
  'c9b8f1e1-3c11-4a54-9b9f-41a1c4c0b6d0',
  '5f0d8a2b-1f8b-4cc6-8c59-9c61a8b6a9f3',
  'a7d9a6d4-62aa-4f75-9a61-5d6ed5c3d1c4',
  'e1a7c8f5-3e57-4f2a-9b2e-3b9bca8b5d0e',
  '3b2c9f3a-9c79-4cda-9b13-9a3cf6b5dce1',
  '8a8b9a2a-2f7d-4c1a-9b5a-7ed2d5c8a1f9',
  '1d6c4f5b-3f2b-4b4f-8bb7-9f2a3c4d5e6f'
);

DELETE FROM public.question_error_patterns WHERE question_id IN (
  '0f3b5c8a-7e1f-4b67-bc66-2d1b76a7b2e1',
  '2a0f7f4d-6dd0-4c8a-9fb6-5b2d4d6b7a9a',
  '7b6f6f2a-0c5b-44b0-9b4b-7c4a76f1b2c7',
  'c9b8f1e1-3c11-4a54-9b9f-41a1c4c0b6d0',
  '5f0d8a2b-1f8b-4cc6-8c59-9c61a8b6a9f3',
  'a7d9a6d4-62aa-4f75-9a61-5d6ed5c3d1c4',
  'e1a7c8f5-3e57-4f2a-9b2e-3b9bca8b5d0e',
  '3b2c9f3a-9c79-4cda-9b13-9a3cf6b5dce1',
  '8a8b9a2a-2f7d-4c1a-9b5a-7ed2d5c8a1f9',
  '1d6c4f5b-3f2b-4b4f-8bb7-9f2a3c4d5e6f'
);

DELETE FROM public.question_versions WHERE question_id IN (
  '0f3b5c8a-7e1f-4b67-bc66-2d1b76a7b2e1',
  '2a0f7f4d-6dd0-4c8a-9fb6-5b2d4d6b7a9a',
  '7b6f6f2a-0c5b-44b0-9b4b-7c4a76f1b2c7',
  'c9b8f1e1-3c11-4a54-9b9f-41a1c4c0b6d0',
  '5f0d8a2b-1f8b-4cc6-8c59-9c61a8b6a9f3',
  'a7d9a6d4-62aa-4f75-9a61-5d6ed5c3d1c4',
  'e1a7c8f5-3e57-4f2a-9b2e-3b9bca8b5d0e',
  '3b2c9f3a-9c79-4cda-9b13-9a3cf6b5dce1',
  '8a8b9a2a-2f7d-4c1a-9b5a-7ed2d5c8a1f9',
  '1d6c4f5b-3f2b-4b4f-8bb7-9f2a3c4d5e6f'
);

DELETE FROM public.user_question_state WHERE question_id IN (
  '0f3b5c8a-7e1f-4b67-bc66-2d1b76a7b2e1',
  '2a0f7f4d-6dd0-4c8a-9fb6-5b2d4d6b7a9a',
  '7b6f6f2a-0c5b-44b0-9b4b-7c4a76f1b2c7',
  'c9b8f1e1-3c11-4a54-9b9f-41a1c4c0b6d0',
  '5f0d8a2b-1f8b-4cc6-8c59-9c61a8b6a9f3',
  'a7d9a6d4-62aa-4f75-9a61-5d6ed5c3d1c4',
  'e1a7c8f5-3e57-4f2a-9b2e-3b9bca8b5d0e',
  '3b2c9f3a-9c79-4cda-9b13-9a3cf6b5dce1',
  '8a8b9a2a-2f7d-4c1a-9b5a-7ed2d5c8a1f9',
  '1d6c4f5b-3f2b-4b4f-8bb7-9f2a3c4d5e6f'
);

DELETE FROM public.recommendations WHERE question_id IN (
  '0f3b5c8a-7e1f-4b67-bc66-2d1b76a7b2e1',
  '2a0f7f4d-6dd0-4c8a-9fb6-5b2d4d6b7a9a',
  '7b6f6f2a-0c5b-44b0-9b4b-7c4a76f1b2c7',
  'c9b8f1e1-3c11-4a54-9b9f-41a1c4c0b6d0',
  '5f0d8a2b-1f8b-4cc6-8c59-9c61a8b6a9f3',
  'a7d9a6d4-62aa-4f75-9a61-5d6ed5c3d1c4',
  'e1a7c8f5-3e57-4f2a-9b2e-3b9bca8b5d0e',
  '3b2c9f3a-9c79-4cda-9b13-9a3cf6b5dce1',
  '8a8b9a2a-2f7d-4c1a-9b5a-7ed2d5c8a1f9',
  '1d6c4f5b-3f2b-4b4f-8bb7-9f2a3c4d5e6f'
);

DELETE FROM public.question_attempts WHERE question_id IN (
  '0f3b5c8a-7e1f-4b67-bc66-2d1b76a7b2e1',
  '2a0f7f4d-6dd0-4c8a-9fb6-5b2d4d6b7a9a',
  '7b6f6f2a-0c5b-44b0-9b4b-7c4a76f1b2c7',
  'c9b8f1e1-3c11-4a54-9b9f-41a1c4c0b6d0',
  '5f0d8a2b-1f8b-4cc6-8c59-9c61a8b6a9f3',
  'a7d9a6d4-62aa-4f75-9a61-5d6ed5c3d1c4',
  'e1a7c8f5-3e57-4f2a-9b2e-3b9bca8b5d0e',
  '3b2c9f3a-9c79-4cda-9b13-9a3cf6b5dce1',
  '8a8b9a2a-2f7d-4c1a-9b5a-7ed2d5c8a1f9',
  '1d6c4f5b-3f2b-4b4f-8bb7-9f2a3c4d5e6f'
);

-- Finally delete the questions themselves
DELETE FROM public.questions WHERE id IN (
  '0f3b5c8a-7e1f-4b67-bc66-2d1b76a7b2e1',
  '2a0f7f4d-6dd0-4c8a-9fb6-5b2d4d6b7a9a',
  '7b6f6f2a-0c5b-44b0-9b4b-7c4a76f1b2c7',
  'c9b8f1e1-3c11-4a54-9b9f-41a1c4c0b6d0',
  '5f0d8a2b-1f8b-4cc6-8c59-9c61a8b6a9f3',
  'a7d9a6d4-62aa-4f75-9a61-5d6ed5c3d1c4',
  'e1a7c8f5-3e57-4f2a-9b2e-3b9bca8b5d0e',
  '3b2c9f3a-9c79-4cda-9b13-9a3cf6b5dce1',
  '8a8b9a2a-2f7d-4c1a-9b5a-7ed2d5c8a1f9',
  '1d6c4f5b-3f2b-4b4f-8bb7-9f2a3c4d5e6f'
);

ALTER TABLE public.questions ENABLE TRIGGER USER;

COMMIT;
