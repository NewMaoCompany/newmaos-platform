
import os
import json
from supabase import create_client, Client
from dotenv import load_dotenv

load_dotenv('.env.local')
url = os.environ.get("VITE_SUPABASE_URL")
key = os.environ.get("VITE_SUPABASE_ANON_KEY")
supabase: Client = create_client(url, key)

def debug_unit2():
    print("--- Checking constraints ---")
    # This query might fail depending on permissions, but let's try to infer from data or use a simpler check.
    # Actually, we can just check distinct values for 'course'.
    try:
        res = supabase.table('questions').select('course').limit(10).execute()
        courses = set(r['course'] for r in res.data if r['course'])
        print(f"Existing course values: {courses}")
    except Exception as e:
        print(f"Error checking course: {e}")

    print("\n--- Listing Unit 2 Candidates ---")
    # Search for questions that might be the targets.
    # User's JSON has sub_topic_id "2.1", "2.2".
    # Existing ones might have "2.1", "2.2", "Unit2", "C2.1"...
    try:
        # Fetch by sub_topic_id
        res = supabase.table('questions').select('id, title, course, sub_topic_id, section_id').or_('sub_topic_id.eq.2.1,sub_topic_id.eq.2.2,title.ilike.%2.1%,title.ilike.%2.2%').execute()
        
        print(f"Found {len(res.data)} matching questions:")
        for q in res.data:
            print(f"ID: {q['id']} | Title: {q['title']} | Course: {q['course']} | Sub: {q['sub_topic_id']}")
            
    except Exception as e:
        print(f"Error fetching questions: {e}")

if __name__ == "__main__":
    debug_unit2()
