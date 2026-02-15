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
    # Load both parts
    with open('database/unit1_test_part1.json', 'r') as f:
        part1 = json.load(f)
    with open('database/unit1_test_part2.json', 'r') as f:
        part2 = json.load(f)
        
    all_questions = part1 + part2
    
    sql_statements = []
    
    for q in all_questions:
        title = q.get('title') # "UT1-Q01-..."
        if not title:
            print("Skipping question without title")
            continue

        # Fields to insert
        # course, topic, sub_topic_id, section_id, type, calculator_allowed, difficulty, target_time_seconds,
        # skill_tags, error_tags, prompt, latex, options, correct_option_id, explanation, micro_explanations,
        # recommendation_reasons, status, version, reasoning_level, mastery_weight, representation_type,
        # topic_id, source, source_year, notes, weight_primary, weight_supporting, title, prompt_type,
        # primary_skill_id, supporting_skill_ids
        
        # Mappings
        course = "Both" 
        topic = "Both_Limits"
        # User requested both to be unit_test based on screenshot
        sub_topic_id = "unit_test" 
        section_id = "unit_test"
        
        q_type = q.get('type', 'MCQ').upper()
        
        prompt_type = q.get('prompt_type', 'text')
        if prompt_type == 'image':
            prompt_type = 'text_and_image'
            
        reasoning_level = q.get('reasoning_level', 2)
        
        # Skill tags
        skills = q.get('skill_tags', [])
        skills_sql = "ARRAY[" + ", ".join(f"'{s}'" for s in skills) + "]::text[]" if skills else "ARRAY[]::text[]"
        
        # Error tags
        errors = q.get('error_tags', [])
        errors_sql = "ARRAY[" + ", ".join(f"'{e}'" for e in errors) + "]::text[]" if errors else "ARRAY[]::text[]"
        
        # Recommendation reasons
        recs = q.get('recommendation_reasons', [])
        recs_sql = "ARRAY[" + ", ".join(f"'{r}'" for r in recs) + "]::text[]" if recs else "ARRAY[]::text[]"
        
        # JSON fields
        options_json = escape_sql(json.dumps(q.get('options', [])))
        micro_explanations_json = escape_sql(json.dumps(q.get('micro_explanations', [])))
        
        # Calculate weight_supporting sum
        ws_data = q.get('weight_supporting', [])
        ws_val = 0.0
        if isinstance(ws_data, list):
            for item in ws_data:
                if isinstance(item, dict):
                    ws_val += item.get('weight', 0.0)
                elif isinstance(item, (int, float)):
                    ws_val += float(item)
        elif isinstance(ws_data, (int, float)):
            ws_val = float(ws_data)
            
        weight_supporting_str = str(ws_val)
        
        supporting_skill_ids = q.get('supporting_skill_ids', [])
        supporting_skill_ids_sql = "ARRAY[" + ", ".join(f"'{s}'" for s in supporting_skill_ids) + "]::text[]" if supporting_skill_ids else "ARRAY[]::text[]"

        # Columns and Values
        # Note: Removing topic_id as 'Both_Limits' is likely not in topic_content table (FK constraint).
        # Existing seeds (e.g. 1.1) do not set topic_id, only topic.
        columns = [
            "course", "topic", "sub_topic_id", "section_id", "type", 
            "calculator_allowed", "difficulty", "target_time_seconds",
            "skill_tags", "error_tags", "prompt", "latex", 
            "options", "correct_option_id", "explanation", "micro_explanations",
            "recommendation_reasons", "status", "version", "reasoning_level",
            "mastery_weight", "representation_type", 
            "source", "source_year", "notes", "weight_primary", "weight_supporting",
            "title", "prompt_type", "primary_skill_id", "supporting_skill_ids",
            "updated_at", "created_at"
        ]
        
        values = [
            f"'{course}'", f"'{topic}'", f"'{sub_topic_id}'", f"'{section_id}'", f"'{q_type}'",
            escape_sql(q.get('calculator_allowed')), str(map_difficulty(q.get('difficulty'))), str(q.get('target_time_seconds', 60)),
            skills_sql, errors_sql, escape_sql(q.get('prompt')), escape_sql(q.get('latex')),
            options_json, escape_sql(q.get('correct_option_id')), escape_sql(q.get('explanation')), micro_explanations_json,
            recs_sql, f"'{q.get('status', 'published')}'", "1", str(reasoning_level),
            str(q.get('mastery_weight', 1.0)), escape_sql(q.get('representation_type', 'symbolic')),
            escape_sql(q.get('source', 'NewMaoS')), str(q.get('source_year', 2026)), escape_sql(q.get('notes')), 
            str(q.get('weight_primary', 1.0)), weight_supporting_str,
            f"'{title}'", f"'{prompt_type}'", escape_sql(q.get('primary_skill_id')), supporting_skill_ids_sql,
            "NOW()", "NOW()"
        ]
        
        # ---------------------------------------------------------
        # GENERATE SQL
        # ---------------------------------------------------------

        # 1. DELETE existing question by title to ensure clean slate (simulates UPSERT without unique constraint)
        sql_statements.append(f"-- Question: {title}")
        sql_statements.append(f"DELETE FROM public.questions WHERE title = '{title}';")
        
        # 2. INSERT new question
        columns_str = ", ".join(columns)
        values_str = ", ".join(values)
        
        insert_sql = f"""INSERT INTO public.questions ({columns_str})
VALUES ({values_str});"""
        
        sql_statements.append(insert_sql)
        sql_statements.append("") # Empty line between statements

    # Write to file
    with open('database/update_unit1_test_questions.sql', 'w') as f:
        f.write("-- Insert/Update script for Unit 1 Unit Test Questions\n")
        f.write("BEGIN;\n")
        f.write("\n".join(sql_statements))
        f.write("COMMIT;\n")
        
    print("Generated database/update_unit1_test_questions.sql")

if __name__ == "__main__":
    generate_sql()
