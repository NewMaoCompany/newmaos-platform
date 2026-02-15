
import json
import os

INPUT_JSON = 'database/unit1_restore.json'
OUTPUT_SQL = 'database/restore_unit1_questions.sql'

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
        f_out.write("-- Restore Unit 1.3 and 1.4 Questions\n")
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

            # DELETE existing question to avoid conflict and ensure clean state
            f_out.write(f"DELETE FROM questions WHERE title = {escape_sql(title)};\n")

            # Prepare fields
            # Handle Options: map 'text' to 'value'
            options = []
            if 'options' in q:
                for opt in q['options']:
                    new_opt = opt.copy()
                    if 'text' in new_opt:
                        new_opt['value'] = new_opt.pop('text')
                    # Ensure label exists
                    if 'id' in new_opt and 'label' not in new_opt:
                        new_opt['label'] = new_opt['id']
                    options.append(new_opt)
            
            options_json = json.dumps(options).replace("'", "''")

            # Handle arrays for SQL
            skill_tags = q.get('skill_tags', [])
            # Extract just skill_ids if it's object, or use as is if string?
            # JSON has objects: { "skill_id": "...", "weight": ... }
            # DB `skill_tags` column is usually text[] or jsonb?
            # Looking at previous scripts, it seems we might store IDs in `skill_tags` column (text[])? 
            # Or is there a separate relation?
            # `QuestionCreator.tsx` loads `skillTags` as string[].
            # Let's assume `skill_tags` column expects string array of IDs.
            # But wait, `skill_tags` in JSON has weights.
            # `QuestionCreator` uses `primarySkillId` and `supportingSkillIds`.
            # The DB has `primary_skill_id` and `supporting_skill_ids` columns.
            # `skill_tags` column might be legacy or for simple tags.
            # Let's convert `skill_tags` objects to a list of IDs for the `skill_tags` column if it exists.
            
            skill_ids = [s['skill_id'] for s in skill_tags if 'skill_id' in s]
            skill_tags_sql = "'{" + ",".join(skill_ids) + "}'"
            
            error_tags = q.get('error_tags', [])
            error_tags_sql = "'{" + ",".join(error_tags) + "}'"

            supporting_ids = q.get('supporting_skill_ids', [])
            supporting_ids_sql = "'{" + ",".join(supporting_ids) + "}'"

            # Fields
            # section_id: "1.3" or "1.4"
            # sub_topic_id: "U1_C3_Q1" (from JSON) -> User wants this?
            # User said "Re-adding Chapter 1.3 prompt", so maybe I should use "1.3" as sub_topic_id?
            # But JSON has "sub_topic_id": "U1_C3_Q1".
            # If I use "U1_C3_Q1", will it show in 1.3 list?
            # `QuestionCreator` logic: `q.sectionId === selectedSubTopicId || q.subTopicId === selectedSubTopicId`
            # If selectedSubTopicId is '1.3', then `q.sectionId` MUST be '1.3'.
            # JSON has `"section_id": "1.3"`. So it SHOULD work.
            
            f_out.write("INSERT INTO questions (")
            f_out.write("title, prompt, prompt_type, type, difficulty, reasoning_level, ")
            f_out.write("course, topic, sub_topic_id, section_id, ")
            f_out.write("primary_skill_id, supporting_skill_ids, skill_tags, error_tags, ")
            f_out.write("options, correct_option_id, explanation, tolerance, status, version")
            f_out.write(") VALUES (")
            
            f_out.write(f"{escape_sql(title)}, ")
            f_out.write(f"{escape_sql(q.get('prompt'))}, ")
            f_out.write(f"{escape_sql(q.get('prompt_type'))}, ")
            f_out.write(f"{escape_sql(q.get('type'))}, ")
            f_out.write(f"{escape_sql(q.get('difficulty'))}, ")
            f_out.write(f"{q.get('reasoning_level', 1)}, ")
            
            f_out.write(f"{escape_sql(q.get('course'))}, ")
            f_out.write(f"{escape_sql(q.get('topic'))}, ") # 'Both_Limits'
            f_out.write(f"{escape_sql(q.get('sub_topic_id'))}, ") # 'U1_C3_Q1'
            f_out.write(f"{escape_sql(q.get('section_id'))}, ") # '1.3'
            
            f_out.write(f"{escape_sql(q.get('primary_skill_id'))}, ")
            f_out.write(f"{supporting_ids_sql}, ")
            f_out.write(f"{skill_tags_sql}, ")
            f_out.write(f"{error_tags_sql}, ")
            
            f_out.write(f"'{options_json}'::jsonb, ")
            f_out.write(f"{escape_sql(q.get('correct_option_id'))}, ")
            f_out.write(f"{escape_sql(q.get('explanation'))}, ")
            f_out.write(f"{q.get('tolerance', 0)}, ")
            f_out.write(f"{escape_sql(q.get('status'))}, ")
            f_out.write(f"{q.get('version', 1)}")
            
            f_out.write(");\n\n")

        f_out.write("COMMIT;\n")

if __name__ == "__main__":
    generate_sql()
    print(f"Generated {OUTPUT_SQL}")
