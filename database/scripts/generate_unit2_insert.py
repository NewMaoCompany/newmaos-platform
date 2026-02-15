
import json
import os

INPUT_JSON = 'database/unit2_questions.json'
OUTPUT_SQL = 'database/insert_unit2_questions.sql'

def escape_sql(text):
    if text is None:
        return 'NULL'
    return "'" + str(text).replace("'", "''") + "'"

def generate_sql():
    if not os.path.exists(INPUT_JSON):
        print(f"Error: {INPUT_JSON} not found")
        return

    with open(INPUT_JSON, 'r') as f:
        questions = json.load(f)

    with open(OUTPUT_SQL, 'w') as f_out:
        f_out.write("-- Insert Unit 2 Questions\n")
        f_out.write("BEGIN;\n\n")

        processed_titles = set()

        for q in questions:
            title = q.get('title')
            if not title:
                print("Skipping question without title")
                continue
            
            if title in processed_titles:
                print(f"Skipping duplicate title in JSON: {title}")
                continue
            processed_titles.add(title)

            # DELETE existing question by title
            f_out.write(f"DELETE FROM questions WHERE title = {escape_sql(title)};\n")

            # Prepare fields
            # Handle Options: map 'text' to 'value'
            options = []
            if 'options' in q:
                for opt in q['options']:
                    new_opt = opt.copy()
                    if 'text' in new_opt:
                        new_opt['value'] = new_opt.pop('text')
                    if 'id' in new_opt and 'label' not in new_opt:
                        new_opt['label'] = new_opt['id']
                    options.append(new_opt)
            
            options_json = json.dumps(options).replace("'", "''")

            # Handle arrays for SQL
            skill_tags = q.get('skill_tags', [])
            # Map simplified string tags to skill_ids if possible, or just skip if not standard?
            # User JSON has simple strings: ["Average rate of change", ...]
            # and explicit `primary_skill_id` / `supporting_skill_ids` with CODEs (e.g. SK_AVG_ROC).
            # I will prioritize `primary_skill_id` and `supporting_skill_ids` for columns.
            # `skill_tags` column (if used) can store the string tags.
            
            skill_tags_sql = "'{" + ",".join([s.replace("'", "''") for s in skill_tags]) + "}'"
            
            error_tags = q.get('error_tags', [])
            error_tags_sql = "'{" + ",".join([s.replace("'", "''") for s in error_tags]) + "}'"

            supporting_ids = q.get('supporting_skill_ids', [])
            supporting_ids_sql = "'{" + ",".join(supporting_ids) + "}'"

            # Fields
            # section_id: JSON has "Unit2".
            # sub_topic_id: JSON has "2.1" or "2.2".
            # topic: JSON has "Both_Derivatives".
            
            f_out.write("INSERT INTO questions (")
            f_out.write("title, prompt, prompt_type, type, difficulty, reasoning_level, ")
            f_out.write("course, topic, sub_topic_id, section_id, ")
            f_out.write("primary_skill_id, supporting_skill_ids, skill_tags, error_tags, ")
            f_out.write("options, correct_option_id, explanation, tolerance, status, version")
            f_out.write(") VALUES (")
            
            f_out.write(f"{escape_sql(title)}, ")
            # Ensure prompt is stored as JSON array ["Text"] for consistency with recent fixes?
            # Or just string?
            # User said "prompt is array" in previous turn.
            # To be safe and forward-compatible, store as `["Text"]` array.
            # But the 'text' prompt type in frontend handles strings too.
            # Let's stick to string 'text' as provided in JSON for now, unless instructed otherwise.
            # Wait, if I use string, and the user adds an image later, my new logic `handleSelectQuestion` 
            # might try to parse it. 
            # `handleSelectQuestion` handles string and object.
            # I'll stick to string as it's cleaner unless mixed.
            f_out.write(f"{escape_sql(q.get('prompt'))}, ")
            
            f_out.write(f"{escape_sql(q.get('prompt_type', 'text'))}, ")
            f_out.write(f"{escape_sql(q.get('type'))}, ")
            f_out.write(f"{escape_sql(q.get('difficulty'))}, ")
            f_out.write(f"{q.get('reasoning_level', 1)}, ")
            
            f_out.write(f"{escape_sql(q.get('course'))}, ")
            f_out.write(f"{escape_sql(q.get('topic'))}, ") 
            f_out.write(f"{escape_sql(q.get('sub_topic_id'))}, ") 
            f_out.write(f"{escape_sql(q.get('section_id'))}, ") 
            
            f_out.write(f"{escape_sql(q.get('primary_skill_id'))}, ")
            f_out.write(f"{supporting_ids_sql}, ")
            f_out.write(f"{skill_tags_sql}, ")
            f_out.write(f"{error_tags_sql}, ")
            
            f_out.write(f"'{options_json}'::jsonb, ")
            f_out.write(f"{escape_sql(q.get('correct_option_id'))}, ")
            f_out.write(f"{escape_sql(q.get('explanation'))}, ")
            f_out.write(f"{'NULL' if q.get('tolerance') is None else q.get('tolerance')}, ")
            f_out.write(f"{escape_sql(q.get('status'))}, ")
            f_out.write(f"{q.get('version', 1)}")
            
            f_out.write(");\n\n")

        f_out.write("COMMIT;\n")

if __name__ == "__main__":
    generate_sql()
    print(f"Generated {OUTPUT_SQL}")
