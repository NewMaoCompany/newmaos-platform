import json
import os

def escape_sql(value):
    if value is None:
        return "NULL"
    if isinstance(value, str):
        return "'" + value.replace("'", "''") + "'"
    if isinstance(value, bool):
        return "TRUE" if value else "FALSE"
    return str(value)

def escape_json(value):
    if value is None:
        return "null"
    return json.dumps(value)

def map_difficulty(level_str):
    mapping = {
        "Level1": 1,
        "Level2": 2,
        "Level3": 3,
        "Level4": 4,
        "Level5": 5
    }
    return mapping.get(level_str, 3)

def generate_sql():
    # Load the new questions
    with open('database/limits_update_part6.json', 'r') as f:
        new_questions = json.load(f)

    sql_statements = []
    
    # Mapping from sub_topic_id to original title
    # 1.13 Questions
    id_map = {
        # Unit 1.13
        "U1_C13_R1": "1.13-P1",
        "U1_C13_R2": "1.13-P2",
        "U1_C13_R3": "1.13-P3",
        "U1_C13_R4": "1.13-P4",
        "U1_C13_R5": "1.13-P5",
        # Unit 1.14
        "U1_C14_V1": "1.14-P1",
        "U1_C14_V2": "1.14-P2",
        "U1_C14_V3": "1.14-P3",
        "U1_C14_V4": "1.14-P4",
        "U1_C14_V5": "1.14-P5"
    }

    for q in new_questions:
        sub_id = q.get('sub_topic_id')
        if sub_id not in id_map:
            print(f"Skipping unknown ID: {sub_id}")
            continue

        original_title = id_map[sub_id]
        
        # Build UPDATE statement
        updates = []
        
        # Map course to schema-compliant values
        raw_course = q.get('course', 'Both')
        course_map = {
            "AP_Calculus_AB": "AB",
            "AP_Calculus_BC": "BC", # or Both, but let's stick to valid short codes. 
            # Actually, Unit 1 is usually 'Both'. The user's JSON had 'AP_Calculus_BC'.
            # If I look at the seed for 1.13, it says 'Both'.
            # I will map AP_Calculus_BC to 'Both' for Unit 1 context, or 'BC' if strictly BC.
            # But the seed had 'Both'.
        }
        # Force 'Both' for Unit 1 as per previous parts
        course = "Both" 
        updates.append(f"course = '{course}'")
        updates.append(f"topic = {escape_sql(q.get('topic', 'Both_Limits'))}")
        
        # Fix sub_topic_id to be bare (e.g. 1.13 or 1.14) without U1_ prefix for the DB column if needed,
        # but usually we map the Question ID. 
        # Actually, look at the valid seed: sub_topic_id is '1.13' or '1.14'.
        # The JSON has U1_C13_R1.
        # We should extract the section ID "1.13" or "1.14".
        
        section_id = "1.13" if "C13" in sub_id else "1.14"
        updates.append(f"sub_topic_id = '{section_id}'")
        updates.append(f"section_id = '{section_id}'")
        
        # Enforce uppercase MCQ
        q_type = q.get('type', 'MCQ').upper()
        if q_type == 'MCQ': 
            updates.append(f"type = 'MCQ'")
        else:
            updates.append(f"type = {escape_sql(q_type)}")

        updates.append(f"calculator_allowed = {escape_sql(q.get('calculator_allowed', False))}")
        updates.append(f"difficulty = {map_difficulty(q.get('difficulty'))}")
        updates.append(f"target_time_seconds = {q.get('target_time_seconds', 60)}")
        
        # Skill tags - extract skill_id if it's a list of dicts, or use as is if list of strings
        # In Part 6 JSON, skill_tags is a list of strings: ["Detect_Removable_Discontinuity", ...]
        # checking the JSON content...
        # "skill_tags": ["Detect_Removable_Discontinuity", ...]
        # So we just convert to SQL array literal
        
        skills = q.get('skill_tags', [])
        if skills and isinstance(skills[0], dict):
             skills = [s['skill_id'] for s in skills]
        
        if skills:
            skills_sql = "ARRAY[" + ", ".join(f"'{s}'" for s in skills) + "]"
            updates.append(f"skill_tags = {skills_sql}")
        else:
             updates.append("skill_tags = ARRAY[]::text[]")

        # Error tags
        error_tags = q.get('error_tags', [])
        if error_tags:
            errors_sql = "ARRAY[" + ", ".join(f"'{e}'" for e in error_tags) + "]"
            updates.append(f"error_tags = {errors_sql}")
        
        updates.append(f"prompt = {escape_sql(q.get('prompt'))}")
        updates.append(f"latex = {escape_sql(q.get('latex'))}")
        
        # Options - strictly format as JSON
        options = q.get('options', [])
        updates.append(f"options = {escape_sql(json.dumps(options))}")
        
        updates.append(f"correct_option_id = {escape_sql(q.get('correct_option_id'))}")
        updates.append(f"explanation = {escape_sql(q.get('explanation'))}")
        
        # Recommendation reasons
        recs = q.get('recommendation_reasons', [])
        if recs:
             recs_sql = "ARRAY[" + ", ".join(f"'{r}'" for r in recs) + "]"
             updates.append(f"recommendation_reasons = {recs_sql}")

        updates.append(f"status = {escape_sql(q.get('status', 'published'))}")
        
        # VERSION INCREMENT to avoid unique constraint violation
        updates.append(f"version = version + 1")
        
        # Reasoning level - explicit int check
        rl = q.get('reasoning_level')
        if isinstance(rl, str):
            # Map strings if they appear, though JSON has ints
            rl_map = {"Conceptual": 2, "fluency": 1, "skill": 2, "application": 3}
            rl = rl_map.get(rl.lower(), 2)
        updates.append(f"reasoning_level = {rl}")
        
        updates.append(f"mastery_weight = {escape_sql(q.get('mastery_weight', 1.0))}")
        updates.append(f"source = {escape_sql(q.get('source', 'NewMaoS'))}")
        updates.append(f"source_year = {q.get('source_year', 2026)}")
        updates.append(f"notes = {escape_sql(q.get('notes'))}")
        
        updates.append(f"weight_primary = {q.get('weight_primary', 1.0)}")
        updates.append(f"weight_supporting = {q.get('weight_supporting', 0.0)}")
        
        updates.append(f"prompt_type = {escape_sql(q.get('prompt_type', 'text'))}")
        
        # Representation type
        updates.append(f"representation_type = {escape_sql(q.get('representation_type', 'symbolic'))}")

        
        updates.append("updated_at = NOW()")

        
        set_clause = ",\n  ".join(updates)
        
        sql = f"""
UPDATE public.questions
SET
  {set_clause}
WHERE title = '{original_title}';
"""
        sql_statements.append(sql)

    # Write to file
    with open('database/update_unit1_limits_part6.sql', 'w') as f:
        f.write("-- Update script for Unit 1.13 & 1.14 (Part 6)\n")
        f.write("\n".join(sql_statements))
        
    print("Generated database/update_unit1_limits_part6.sql")

if __name__ == "__main__":
    generate_sql()
