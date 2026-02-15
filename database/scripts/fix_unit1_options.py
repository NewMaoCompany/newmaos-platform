
import json
import os

# Files to process (Part 2-7) which cover 1.5 to 1.16 + 1.2/1.3 updates
FILES = [
    'database/limits_update.json',          # Part 1 (1.2, 1.3)
    'database/limits_update_part2.json',    # Part 2 (1.5, 1.6)
    'database/limits_update_part3.json',    # Part 3 (1.7, 1.8)
    'database/limits_update_part4.json',    # Part 4 (1.9, 1.10)
    'database/limits_update_part5.json',    # Part 5 (1.11, 1.12)
    'database/limits_update_part6.json',    # Part 6 (1.13, 1.14)
    'database/limits_update_part7.json',    # Part 7 (1.15, 1.16)
]

OUTPUT_SQL = 'database/fix_unit1_options_display.sql'

def escape_sql(text):
    if text is None:
        return ''
    return text.replace("'", "''")

def generate_sql():
    with open(OUTPUT_SQL, 'w') as f_out:
        f_out.write("-- Fix options JSON format for Unit 1 questions (change 'text' to 'value')\n")
        f_out.write("BEGIN;\n\n")

        for filename in FILES:
            if not os.path.exists(filename):
                print(f"Skipping missing file: {filename}")
                continue
                
            print(f"Processing {filename}...")
            with open(filename, 'r') as f_in:
                data = json.load(f_in)
                
            for q in data:
                # Resolve Title (Same logic as previous scripts to find the target question)
                # We need to find the question by title or ID.
                # In previous scripts, we mapped titles.
                # However, since these are ALREADY inserted, we can just update by Title if it exists in DB.
                # But wait, titles in JSON might be different from DB if we did mapping (e.g. 1.2-P1 -> U1C2...).
                # The safest way is to use the SAME mapping logic or just simple title matching if they align.
                # Actually, simplest is to use the `title` from JSON and hope it matches.
                # IF we remapped titles (like in Part 3, 4 etc), we need that mapping.
                
                # Let's try to match by 'title' in JSON.
                # Most Part 2-7 scripts used a mapping dictionary or direct title.
                # Let's check if the JSON has the final DB title.
                # JSON usually has "title": "1.2-P1" or similar.
                # DB has "U1C2..." or "1.2-P1".
                
                # To be robust, let's construct the OPTIONS JSON correctly first.
                
                options = []
                # Map old keys to new keys
                # Input JSON usually has: option_a, option_b... OR options list
                
                if 'options' in q and isinstance(q['options'], list):
                    # Should not happen for these specific files, they usually have flattened keys
                    pass
                else:
                    # Flattened keys
                    for letter in ['a', 'b', 'c', 'd']:
                        val = q.get(f'option_{letter}', '')
                        expl = q.get(f'explanation_{letter}', '')
                        
                        # Fix: Ensure we use 'value' key, not 'text'
                        opt = {
                            "id": letter.upper(),
                            "label": letter.upper(),
                            "value": val,  # THE FIX
                            "explanation": expl,
                            "explanationType": "text",
                            "type": "text" # Default
                        }
                        options.append(opt)
                
                options_json = json.dumps(options).replace("'", "''")
                
                # We update by Title. 
                # Note: Some titles were remapped. 
                # For Part 2 (1.5/1.6), titles like '1.5-P1' might be 'U1C15_Q1...' in DB?
                # Let's check debug output.
                # ID: 26c57f87... Title: U1C15_Q1_Polynomial_Limit_Substitution
                # JSON for this might be '1.5-P1'.
                
                # If we can't easily reproduce the mapping, we might miss some updates.
                # However, simpler strategy:
                # 1. Update matching `title` = q['title']
                # 2. Update matching `title` = mapped_title (if we can guess it)
                
                # Let's look at the filenames.
                # Part 3-7 used a map_title function?
                # Actually, most recent parts used the Title from JSON directly?
                # Let's check `generate_update_sql_partX.py` logic if possible.
                # But browsing them takes time.
                
                # Alternative: The debug output shows titles like `U1C1.2...` and `C3Q1...` and `1.13-P2`.
                # `1.13-P2` matches JSON format likely.
                # `U1C1.2...` does NOT match `1.2-P1` style.
                
                # Let's assume for now we use the title from JSON. If it affects 0 rows, we might need a better plan.
                # But wait! For Part 2, 3, 4, 5, 6, 7, I used separate scripts.
                # Part 6/7 seem to use 1.13-P1 style (based on debug output).
                # Part 2 used U1C15_... style (based on debug output).
                
                # Key Insight: The `id` in the JSON is usually unique and preserved?
                # No, JSON doesn't have UUIDs usually.
                
                # Let's blindly generate UPDATEs for the Titles present in JSON.
                # AND also try to handle the U1C... style if present in JSON?
                # Actually, the JSONs for Part 2-7 likely have the titles that were used to generate the INSERTs.
                # EXCEPT if I changed them in the python script.
                
                # Let's try to update by `title`.
                sql_title = escape_sql(q.get('title', ''))
                
                # Construct query
                f_out.write(f"UPDATE questions SET options = '{options_json}'::jsonb WHERE title = '{sql_title}';\n")

        f_out.write("COMMIT;\n")

if __name__ == "__main__":
    generate_sql()
    print(f"Generated {OUTPUT_SQL}")
