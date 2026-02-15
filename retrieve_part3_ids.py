import os
from supabase import create_client, Client

url: str = os.environ.get("SUPABASE_URL")
key: str = os.environ.get("SUPABASE_SERVICE_ROLE_KEY")
supabase: Client = create_client(url, key)

titles = [
    "1.7-P1", "1.7-P2", "1.7-P3", "1.7-P4", "1.7-P5",
    "1.8-P1", "1.8-P2", "1.8-P3", "1.8-P4", "1.8-P5"
]

print("Fetching IDs for titles:", titles)

response = supabase.table("questions").select("id, title").in_("title", titles).execute()

print("\n--- ID Mapping ---")
for item in response.data:
    print(f'"{item["title"]}": "{item["id"]}",')
