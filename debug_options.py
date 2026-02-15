
import os
import json
from supabase import create_client, Client
from dotenv import load_dotenv

# Load .env.local
load_dotenv('.env.local')

# Use VITE_ keys present in .env.local
url = os.environ.get("VITE_SUPABASE_URL")
key = os.environ.get("VITE_SUPABASE_ANON_KEY")

supabase: Client = create_client(url, key)

try:
    # Fetch a specific question from 1.10 to inspect options structure
    response = supabase.table("questions") \
        .select("id, title, options") \
        .eq("title", "U1C10Q2_Remove_Discontinuity_By_Definition") \
        .execute()
        
    if response.data:
        q = response.data[0]
        print(f"ID: {q['id']}")
        print(f"Title: {q['title']}")
        print("Options Dump:")
        print(json.dumps(q['options'], indent=2))
    else:
        print("Question not found")

except Exception as e:
    print(f"Error: {e}")
