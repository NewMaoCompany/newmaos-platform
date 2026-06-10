import json

with open('/Users/zhuchen/.gemini/antigravity/brain/bc0a696d-f42a-4696-b13f-85777781db3b/.system_generated/logs/transcript.jsonl', 'r') as f:
    for line in f:
        data = json.loads(line)
        if 'content' in data:
            if 'CREATE OR REPLACE FUNCTION get_user_badges' in data['content']:
                print(data['content'])
