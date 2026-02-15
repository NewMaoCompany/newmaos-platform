
import os
import json
from supabase import create_client, Client
from dotenv import load_dotenv

# Load .env.local
load_dotenv('.env.local')

# Use VITE_ keys present in .env.local
url = os.environ.get("VITE_SUPABASE_URL")
key = os.environ.get("VITE_SUPABASE_ANON_KEY")

if not url or not key:
    print("Error: SUPABASE_URL or SUPABASE_SERVICE_ROLE_KEY not set")
    exit(1)

supabase: Client = create_client(url, key)

# Fetch questions for Unit 1
# We want to check questions where sub_topic_id is > 1.3 or is 'unit_test'
try:
    response = supabase.table("questions") \
        .select("id, title, topic, sub_topic_id, section_id, prompt, options") \
        .ilike("topic", "%Limits%") \
        .execute()
        
    questions = response.data
    
    print(f"Total Unit 1 Questions Found: {len(questions)}")
    
    # Analyze a few samples
    samples = {}
    for q in questions:
        stid = q.get('sub_topic_id')
        if stid not in samples:
            samples[stid] = []
        if len(samples[stid]) < 2:
            samples[stid].append(q)
            
    # Print analysis
    sorted_subtopics = sorted(samples.keys(), key=lambda x: str(x))
    
    for stid in sorted_subtopics:
        print(f"\n--- SubTopic: {stid} ---")
        for q in samples[stid]:
            print(f"ID: {q['id']}")
            print(f"Title: {q['title']}")
            print(f"Section ID: {q['section_id']}")
            print(f"Prompt (first 50): {q['prompt'][:50] if q['prompt'] else 'None'}")
            print(f"Options Count: {len(q['options']) if q['options'] else 0}")
            if q['options']:
                print(f"Option A Label: {q['options'][0].get('label', 'N/A')} Value: {q['options'][0].get('value', 'N/A')[:20]}")

except Exception as e:
    print(f"Error: {e}")
