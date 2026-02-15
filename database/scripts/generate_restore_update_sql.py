
import json
import os
from supabase import create_client, Client
from dotenv import load_dotenv

# Load env
load_dotenv('.env.local')
url = os.environ.get("VITE_SUPABASE_URL")
key = os.environ.get("VITE_SUPABASE_ANON_KEY")

if not url or not key:
    print("Error: VITE_SUPABASE_URL or VITE_SUPABASE_ANON_KEY not set")
    exit(1)

supabase: Client = create_client(url, key)

INPUT_JSON = 'database/unit1_restore.json'
OUTPUT_SQL = 'database/restore_unit1_update.sql'

def escape_sql(text):
    if text is None:
        return 'NULL'
    return "'" + str(text).replace("'", "''") + "'"

def generate_update_sql():
    if not os.path.exists(INPUT_JSON):
        print(f"Error: {INPUT_JSON} not found")
        return

    with open(INPUT_JSON, 'r') as f:
        questions = json.load(f)

    with open(OUTPUT_SQL, 'w') as f_out:
        f_out.write("-- Restore Unit 1.3 and 1.4 Prompts (UPDATE ONLY)\n")
        f_out.write("BEGIN;\n\n")

        processed_titles = set()

        for q in questions:
            title = q.get('title')
            if not title:
                print("Skipping question without title")
                continue
            
            if title in processed_titles:
                continue
            processed_titles.add(title)

            # Fetch ID and current Prompt from DB
            try:
                res = supabase.table('questions').select('id, prompt').eq('title', title).execute()
                if not res.data:
                    print(f"Warning: Question not found in DB: {title}")
                    f_out.write(f"-- SKIPPED: {title} (Not found in DB)\n")
                    continue
                
                db_record = res.data[0]
                db_id = db_record['id']
                current_prompt = db_record.get('prompt')

                # Logic to preserve existing images
                # User says prompt is currently an array containing image addresses.
                # It might be a string (URL) or a JSON list string '["url"]'.
                
                existing_images = []
                
                if current_prompt:
                    # Try to parse if it's a string looking like JSON
                    if isinstance(current_prompt, str):
                        current_prompt = current_prompt.strip()
                        if current_prompt.startswith('[') or current_prompt.startswith('{'):
                            try:
                                parsed = json.loads(current_prompt)
                                if isinstance(parsed, list):
                                    # Extract items that look like URLs
                                    for item in parsed:
                                        if isinstance(item, str) and (item.startswith('http') or '/storage/' in item):
                                            existing_images.append(item)
                                elif isinstance(parsed, dict):
                                     if parsed.get('image'):
                                         existing_images.append(parsed['image'])
                            except:
                                pass # parse error
                        # If simple string and looks like URL
                        elif current_prompt.startswith('http') or '/storage/' in current_prompt:
                            existing_images.append(current_prompt)
                    elif isinstance(current_prompt, list):
                         for item in current_prompt:
                            if isinstance(item, str) and (item.startswith('http') or '/storage/' in item):
                                existing_images.append(item)

                # Construct new prompt array: [Text, Image(s)]
                # User JSON has "prompt": "Use the graph..."
                text_content = q.get('prompt', '')
                
                new_prompt_list = [text_content] + existing_images
                
                # Deduplicate? (Maybe user uploaded same image twice?)
                # unique_list = sorted(set(new_prompt_list), key=new_prompt_list.index) 
                # Keep it simple: Text first, then images.
                
                new_prompt_json = json.dumps(new_prompt_list).replace("'", "''")

                f_out.write(f"-- Update {title} ({db_id})\n")
                f_out.write(f"UPDATE questions SET \n")
                f_out.write(f"    prompt = '{new_prompt_json}'::jsonb\n")
                # Removed options update as requested
                f_out.write(f"WHERE id = '{db_id}' AND title = {escape_sql(title)};\n\n")
                
            except Exception as e:
                print(f"Error checking {title}: {e}")

        f_out.write("COMMIT;\n")

if __name__ == "__main__":
    generate_update_sql()
    print(f"Generated {OUTPUT_SQL}")
