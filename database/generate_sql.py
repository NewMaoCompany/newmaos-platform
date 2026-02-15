import json
import datetime

def escape_sql(value):
    if value is None:
        return "NULL"
    if isinstance(value, str):
        return "'" + value.replace("'", "''") + "'"
    if isinstance(value, bool):
        return "TRUE" if value else "FALSE"
    if isinstance(value, (int, float)):
        return str(value)
    if isinstance(value, list) or isinstance(value, dict):
        return "'" + json.dumps(value).replace("'", "''") + "'"
    return "NULL"

def escape_array(value):
    if value is None:
        return "NULL"
    # value is a list of strings
    # Postgres array literal: '{ "val1", "val2" }' or just '{val1,val2}'
    # Best is ARRAY['val1', 'val2']
    if not value:
        return "'{}'"
    escaped_items = [f"'{item.replace("'", "''")}'" for item in value]
    return f"ARRAY[{', '.join(escaped_items)}]"


def main():
    with open('unit10_questions.json', 'r') as f:
        questions = json.load(f)

    # Title mapping: JSON title (New) -> DB title (Old/Existing)
    # This maps the NEW content to the EXISTING row we want to overwrite.
    # The script will then UPDATE the title to the JSON title as well.
    title_map = {
        'C1Q1_Definition_of_Series_Convergence': 'U10-10.1-Q1_Convergent_vs_Divergent_Definition',
        'C1Q2_Partial_Sums_Telescoping_Form': 'U10-10.1-Q2_Partial_Sum_Evaluation',
        'C1Q3_Sequence_vs_Series_Identify': 'U10-10.1-Q3_Partial_Sums_Convergence',
        'C1Q4_Series_Value_From_Partial_Sum_Formula': 'U10-10.1-Q4_Terms_to_Zero_Not_Sufficient',
        'C1Q5_Bounded_Partial_Sums_When_Enough': 'U10-10.1-Q5_Sequence_vs_Series',
        'C2Q1_Geometric_Convergence_Criterion': 'U10-10.2-Q6_Common_Ratio_Identify',
        'C2Q2_Infinite_Geometric_Sum_Negative_Ratio': 'U10-10.2-Q7_Geometric_Area_Model',
        'C2Q3_Repeating_Decimal_As_Geometric_Series': 'U10-10.2-Q8_Infinite_Geometric_Sum',
        'C2Q4_Solve_For_R_From_Sum_And_Term': 'U10-10.2-Q9_Solve_for_First_Term',
        'C2Q5_Geometric_Series_Sigma_Notation_Indexing': 'U10-10.2-Q10_Geometric_Convergence_Condition'
    }
    
    current_time = datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S%z') 
    # Note: %z might be empty depending on system, but usually fine. 
    # Better to use a simpler format or explicit timezone if strict, 
    # but for this user 'real time' key is likely just avoiding "NOW()".
    # Let's use ISO format with Z
    current_time = datetime.datetime.utcnow().isoformat() + "+00:00"

    sql_statements = []
    
    for q in questions:
        json_title = q.get('title')
        # Map to DB title (existing)
        db_title = title_map.get(json_title)
        
        if not db_title:
             print(f"Warning: No mapping found for {json_title}. Skipping.")
             continue
            
        update_parts = []
        
        # Mapping JSON keys to columns
        # All simple keys
        simple_keys = [
            'topic', 'sub_topic_id', 'type', 'calculator_allowed',
            'target_time_seconds', 'prompt', 'latex',
            'correct_option_id', 'tolerance', 'explanation',
            'status', 'version',
            'mastery_weight', 'representation_type', 'topic_id', 'section_id',
            'source', 'source_year', 'notes', 'weight_primary', 'weight_supporting',
            'prompt_type', 'primary_skill_id'
        ]
        
        for key in simple_keys:
            if key in q:
                update_parts.append(f"{key} = {escape_sql(q[key])}")
        
        # Also update the TITLE itself to the new JSON title
        update_parts.append(f"title = {escape_sql(json_title)}")

        # Handle course mapping
        if 'course' in q:
            course_val = q['course']
            if course_val == 'AP_Calculus_BC':
                update_parts.append(f"course = 'BC'")
            elif course_val == 'AP_Calculus_AB':
                update_parts.append(f"course = 'AB'")
            else:
                update_parts.append(f"course = {escape_sql(course_val)}")

        # Handle difficulty: "Level2" -> 2
        if 'difficulty' in q:
            diff = q['difficulty']
            if isinstance(diff, str) and diff.startswith('Level'):
                try:
                    diff_val = int(diff.replace('Level', ''))
                    update_parts.append(f"difficulty = {diff_val}")
                except ValueError:
                    update_parts.append(f"difficulty = {escape_sql(diff)}") # Fallback
            else:
                update_parts.append(f"difficulty = {escape_sql(diff)}")

        # Handle reasoning_level: "conceptual" -> 2, etc.
        reasoning_map = {
            "recall": 1,
            "conceptual": 2,
            "procedural": 3,
            "strategic": 4,
            "extended": 5
        }
        if 'reasoning_level' in q:
            rl = q['reasoning_level']
            if isinstance(rl, str):
                rl_lower = rl.lower()
                if rl_lower in reasoning_map:
                    update_parts.append(f"reasoning_level = {reasoning_map[rl_lower]}")
                else:
                    # Default/Fallback or try parsing int
                     try:
                        update_parts.append(f"reasoning_level = {int(rl)}")
                     except:
                        update_parts.append(f"reasoning_level = {escape_sql(rl)}")
            else:
                update_parts.append(f"reasoning_level = {escape_sql(rl)}")

        # Complex fields
        if 'options' in q:
            # Transform options to match QuestionOption interface
            # User JSON: { "option_id": "A", "text": "..." }
            # Target: { "id": "A", "label": "A", "value": "...", "type": "text" }
            raw_options = q['options']
            transformed_options = []
            for opt in raw_options:
                new_opt = {}
                # Map option_id -> id and label
                oid = opt.get('option_id')
                if oid:
                    new_opt['id'] = oid
                    new_opt['label'] = oid
                
                # Map text -> value
                txt = opt.get('text')
                if txt:
                    new_opt['value'] = txt
                
                new_opt['type'] = 'text'
                
                # Preserve other fields if any
                for k, v in opt.items():
                    if k not in ['option_id', 'text']:
                        new_opt[k] = v
                
                transformed_options.append(new_opt)
            
            update_parts.append(f"options = {escape_sql(transformed_options)}::jsonb")
            
        if 'micro_explanations' in q:
            update_parts.append(f"micro_explanations = {escape_sql(q['micro_explanations'])}::jsonb")

        if 'error_tags' in q:
             # q['error_tags'] is a list of strings
            update_parts.append(f"error_tags = {escape_array(q['error_tags'])}")
            
        if 'recommendation_reasons' in q:
            update_parts.append(f"recommendation_reasons = {escape_array(q['recommendation_reasons'])}")

        if 'supporting_skill_ids' in q:
            update_parts.append(f"supporting_skill_ids = {escape_array(q['supporting_skill_ids'])}")
            
        # skill_tags special handling
        if 'skill_tags' in q:
            skills = q['skill_tags']
            if isinstance(skills, list) and len(skills) > 0 and isinstance(skills[0], dict):
                skill_ids = [s.get('skill_id') for s in skills if s.get('skill_id')]
                update_parts.append(f"skill_tags = {escape_array(skill_ids)}")
            elif isinstance(skills, list):
                 update_parts.append(f"skill_tags = {escape_array(skills)}")

        if update_parts:
            # Add updated_at
            update_parts.append(f"updated_at = '{current_time}'")
            
            set_clause = ",\n    ".join(update_parts)
            # Use mapped db_title in WHERE clause to find the row
            sql = f"""UPDATE public.questions
SET {set_clause}
WHERE title = {escape_sql(db_title)};
"""
            sql_statements.append(sql)

    output_file = 'update_unit10_questions.sql'
    with open(output_file, 'w') as f:
        f.write("-- SQL Update Script related to 'Unit 10 Questions'\n")
        f.write("-- Generated by Antigravity\n\n")
        f.write("\n".join(sql_statements))
        
    print(f"Generated {len(sql_statements)} update statements in {output_file}")

if __name__ == "__main__":
    main()
