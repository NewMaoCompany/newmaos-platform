-- Forum Channels 种子数据
-- 执行此SQL在Supabase SQL Editor中

-- 清空现有数据（如需要）
-- DELETE FROM forum_channels;

-- Information 区域（仅 newmao6120@gmail.com 可发送）
INSERT INTO forum_channels (slug, name, category, description, position) VALUES
  ('announcements', 'Announcements', 'Information', 'Official announcements from NewMaoS', 10),
  ('updates', 'Updates', 'Information', 'Platform updates and new features', 11);

-- General Community 区域（所有人可发送）
INSERT INTO forum_channels (slug, name, category, description, position) VALUES
  ('general', 'General', 'Community', 'General discussion for all topics', 20),
  ('feedback', 'Feedback', 'Community', 'Share your feedback and suggestions', 21),
  ('help', 'Help', 'Community', 'Ask for help from the community', 22);
