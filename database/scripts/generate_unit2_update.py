
import json
import os
import sys

# Since we are provided with the exact JSON data (including IDs),
# we load that source and generate UPDATE statements for each ID.

SOURCE_JSON = 'database/unit2_update_source.json'
OUTPUT_SQL = 'database/update_unit2_questions.sql'

def escape_sql_string(val):
    if val is None:
        return 'NULL'
    # Escape single quotes and backslashes for SQL
    # Note: simple replacement might not catch all edge cases, but suffices for standard text
    return "\'" + str(val).replace("\'", "\'\'") + "\'"

def format_array_literal(arr):
    if not arr:
        return "ARRAY[]::text[]"
    escaped_items = []
    for item in arr:
        escaped_items.append("\'" + item.replace("\'", "\'\'") + "\'")
    return "ARRAY[" + ", ".join(escaped_items) + "]"

def generate_update_sql():
    if not os.path.exists(SOURCE_JSON):
        print(f"Error: {SOURCE_JSON} not found. Run parse_unit2_sql.py first.")
        return

    with open(SOURCE_JSON, 'r') as f:
        questions = json.load(f)

    with open(OUTPUT_SQL, 'w') as f_out:
        f_out.write("-- Updated Unit 2 Questions Script\n")
        f_out.write("-- Generated from provided SQL values\n\n")

        for idx, q in enumerate(questions):
            db_id = q.get('id')
            title = q.get('title')
            
            if not db_id:
                print(f"Warning: Question {idx} has no ID, skipping.")
                continue

            f_out.write(f"-- Update {title} ({db_id})\n")
            f_out.write(f"UPDATE public.questions\n")
            f_out.write(f"SET\n")
            
            # --- Fields to update ---
            # 1. Title
            f_out.write(f"  title = {escape_sql_string(title)},\n")

            # 2. Course (Both)
            f_out.write(f"  course = 'Both',\n")
            
            # 3. Topic & Subtopic
            f_out.write(f"  topic = {escape_sql_string(q.get('topic'))},\n")
            f_out.write(f"  sub_topic_id = {escape_sql_string(q.get('sub_topic_id'))},\n")

            # 4. Type (Uppercase MCQ)
            q_type = q.get('type', 'MCQ').upper()
            f_out.write(f"  type = {escape_sql_string(q_type)},\n")
            
            # 5. Difficulty, Time, Allowed
            f_out.write(f"  difficulty = {q.get('difficulty', 3)},\n")
            # Ensure integer
            try:
                target_time = int(q.get('target_time_seconds', 120))
            except:
                target_time = 120
                
            f_out.write(f"  target_time_seconds = {target_time},\n") 
            f_out.write(f"  calculator_allowed = false,\n")

            # 6. Tags (Arrays)
            skill_tags = q.get('skill_tags', [])
            error_tags = q.get('error_tags', [])
            f_out.write(f"  skill_tags = {format_array_literal(skill_tags)},\n")
            f_out.write(f"  error_tags = {format_array_literal(error_tags)},\n")

            # 7. Content (Prompts, Options, Explain)
            f_out.write(f"  prompt = {escape_sql_string(q.get('prompt'))},\n")
            f_out.write(f"  latex = {escape_sql_string(q.get('prompt'))},\n") # Use prompt for latex
            
            # Options needs JSON dumping
            options_json = json.dumps(q.get('options', []))
            f_out.write(f"  options = {escape_sql_string(options_json)}::jsonb,\n")
            
            f_out.write(f"  correct_option_id = {escape_sql_string(q.get('correct_option_id'))},\n")
            f_out.write(f"  explanation = {escape_sql_string(q.get('explanation'))},\n")
            
            # 8. Meta
            f_out.write(f"  updated_at = NOW(),\n")
            
            # Version increment
            f_out.write(f"  version = version + 1\n") 
            
            # WHERE clause targeting the specific ID
            f_out.write(f"WHERE id = '{db_id}';\n\n")

    print(f"Generated {OUTPUT_SQL}")

if __name__ == "__main__":
    generate_update_sql()
