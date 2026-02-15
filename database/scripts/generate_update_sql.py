import json
import os

def escape_sql(value):
    if value is None:
        return "NULL"
    if isinstance(value, str):
        return "'" + value.replace("'", "''") + "'"
    if isinstance(value, bool):
        return "TRUE" if value else "FALSE"
    if isinstance(value, (int, float)):
        return str(value)
    if isinstance(value, (list, dict)):
        return "'" + json.dumps(value).replace("'", "''") + "'"
    return "NULL"

def escape_array(value, lowercase=False):
    if value is None:
        return "NULL"
    if not value:
        return "'{}'"
    # Check if list of dicts (user format) or list of strings
    formatted_items = []
    for v in value:
        if isinstance(v, dict):
            # Extract skill_id from object (handle both 'skill_id' and 'id')
            item_str = str(v.get('skill_id') or v.get('id') or '')
        else:
            item_str = str(v)
            
        if lowercase:
            item_str = item_str.lower()

        item_str = item_str.replace("'", "''")
        if item_str:
            formatted_items.append(f"'{item_str}'")
            
    return f"ARRAY[{', '.join(formatted_items)}]"

def main():
    input_file = 'database/limits_update_part2.json'
    output_file = 'database/update_unit1_limits_part2.sql'
    
    # ID Mapping for Part 2 (New Content: Limits at Infinity U1.15 & IVT U1.16)
    # Mapping replaced again with NEW data (Polynomials, etc.)
    # Reuse valid UUID slots for 1.5 and 1.6
    id_mapping = {
        # 1.5 Questions (New Titles)
        "U1C15_Q1_Polynomial_Limit_Substitution": "26c57f87-799d-4e6a-a786-96f77b64d5c9", # Slot 1 (1.5-P2 originally)
        "U1C15_Q2_GraphBased_Limit_Laws": "ee05cd56-783f-48e2-b2a5-3134c3b55c37", # Slot 2 (1.5-P1)
        "U1C15_Q3_Combine_Given_Limits": "5f960cac-a4ff-458c-a372-995fcb81d7f9", # Slot 3 (1.5-P3)
        "U1C15_Q4_Quotient_Denominator_Zero": "aaecf8d8-17f7-446d-938e-2c6bdebacde1", # Slot 4 (1.5-P4)
        "U1C15_Q5_Rational_Substitution_NonzeroDen": "ed9ed524-ace7-4e8f-831d-f9afe6fc1812", # Slot 5 (1.5-P5)
        
        # 1.6 Questions (New Titles)
        "U1C16_Q1_Factor_Cancel_Basic": "517f0d4c-d735-47fc-bbac-90231c61b275", # Slot 6 (1.6-P1)
        "U1C16_Q2_Rationalize_Sqrt_Classic": "4ab23ec2-7fee-4ecc-a197-8b7d7573d46d", # Slot 7 (1.6-P5)
        "U1C16_Q3_Rationalize_DiffOfRoots": "ea511a78-2b62-4d07-9573-a16f6180335a", # Slot 8 (1.6-P2)
        "U1C16_Q4_DiffOfCubes_Cancel": "93cff0de-5d7c-40ed-8492-2b741df23cad", # Slot 9 (1.6-P3)
        "U1C16_Q5_FillTheHole_Continuity": "51448cae-3144-4bde-b809-392cdfe4dfa2" # Slot 10 (1.6-P4)
    }

    with open(input_file, 'r') as f:
        questions = json.load(f)

    with open(output_file, 'w') as f:
        f.write("-- Update Unit 1 Limits Questions Part 2 (Chapters 1.5 & 1.6)\n")
        f.write("BEGIN;\n\n")

        for q in questions:
            title = q.get('title')
            # Look up ID by title
            if title not in id_mapping:
                print(f"Warning: No ID mapping for {title}")
                continue
            
            q_id = id_mapping[title]
            
            updates = []
            
            # Core fields
            updates.append(f"prompt = {escape_sql(q.get('prompt'))}")
            updates.append(f"latex = {escape_sql(q.get('latex'))}")
            updates.append(f"options = {escape_sql(q.get('options'))}::jsonb")
            updates.append(f"explanation = {escape_sql(q.get('explanation'))}")
            updates.append(f"micro_explanations = {escape_sql(q.get('micro_explanations'))}::jsonb")
            updates.append(f"correct_option_id = {escape_sql(q.get('correct_option_id'))}")
            
            # Tags (handle list of objects for skill_tags)
            # User requested lowercase tags
            updates.append(f"skill_tags = {escape_array(q.get('skill_tags'), lowercase=True)}")
            updates.append(f"error_tags = {escape_array(q.get('error_tags'), lowercase=True)}")
            updates.append(f"recommendation_reasons = {escape_array(q.get('recommendation_reasons'))}")
            
            # User Change: Lowercase primary skill ID if it exists? 
            prim_skill = q.get('primary_skill_id')
            if prim_skill:
                prim_skill = prim_skill.lower()
            updates.append(f"primary_skill_id = {escape_sql(prim_skill)}")
            
            updates.append(f"supporting_skill_ids = {escape_array(q.get('supporting_skill_ids'), lowercase=True)}")

            # Meta
            # User requested to use JSON values exactly, BUT 'Both_Limit' fails FK constraint.
            # Must map to valid ID 'Both_Limits'.
            topic_id = q.get('topic_id')
            if topic_id == 'Both_Limit':
                topic_id = 'Both_Limits'
            updates.append(f"topic_id = {escape_sql(topic_id)}")
            
            # User Change: sub_topic_id should come from JSON (e.g. "U1.15")
            # User Update: "sub topic 只用1.几就行了，不要U" -> Strip 'U' prefix
            # User Correction: "Not 1.15/1.16, but 1.5/1.6" (Enforce this mapping)
            # User Correction 2: Handle "U1-1.5" from new JSON
            raw_sub_topic = q.get('sub_topic_id')
            
            # Specific mapping overrides
            if raw_sub_topic in ['U1.15', '1.15', 'U1-1.5', '1.5']:
                raw_sub_topic = '1.5'
            elif raw_sub_topic in ['U1.16', '1.16', 'U1-1.6', '1.6']:
                raw_sub_topic = '1.6'
            elif raw_sub_topic and raw_sub_topic.startswith('U'):
                raw_sub_topic = raw_sub_topic[1:]
                
            updates.append(f"sub_topic_id = {escape_sql(raw_sub_topic)}")
            updates.append(f"section_id = {escape_sql(q.get('section_id'))}")
            
            # Difficulty
            diff = q.get('difficulty')
            if isinstance(diff, str) and diff.startswith('Level'):
                try:
                    diff_int = int(diff.replace('Level', ''))
                    updates.append(f"difficulty = {diff_int}")
                except:
                    updates.append(f"difficulty = {escape_sql(diff)}")
            else:
                updates.append(f"difficulty = {escape_sql(diff)}")

            updates.append(f"target_time_seconds = {escape_sql(q.get('target_time_seconds'))}")
            updates.append(f"updated_at = NOW()")
            updates.append(f"title = {escape_sql(title)}")
            
            # Additional Fields from User Request for Completeness
            course_map = {
                "AP_Calculus_BC": "BC",
                "AP_Calculus_AB": "AB",
                "Both": "Both"
            }
            raw_course = q.get('course')
            mapped_course = course_map.get(raw_course, raw_course) # Default to raw if not found, or maybe 'BC'?
            
            # If the raw course is longer than 10 and not in map, it might still fail.
            # But the user data has "AP_Calculus_BC".
            updates.append(f"course = {escape_sql(mapped_course)}")
            
            updates.append(f"type = {escape_sql(q.get('type'))}")
            updates.append(f"calculator_allowed = {escape_sql(q.get('calculator_allowed'))}")
            updates.append(f"tolerance = {escape_sql(q.get('tolerance'))}")
            updates.append(f"status = {escape_sql(q.get('status'))}")
            updates.append(f"version = {escape_sql(q.get('version'))}")
            updates.append(f"reasoning_level = {escape_sql(q.get('reasoning_level'))}")
            updates.append(f"mastery_weight = {escape_sql(q.get('mastery_weight'))}")
            updates.append(f"source = {escape_sql(q.get('source'))}")
            updates.append(f"source_year = {escape_sql(q.get('source_year'))}")
            updates.append(f"notes = {escape_sql(q.get('notes'))}")
            updates.append(f"weight_primary = {escape_sql(q.get('weight_primary'))}")
            updates.append(f"weight_supporting = {escape_sql(q.get('weight_supporting'))}")

            # Prompt Type Mapping
            # User: "impossible to appear image, only text or text_and_image"
            ptype = q.get('prompt_type')
            if ptype == 'image':
                ptype = 'text_and_image'
            updates.append(f"prompt_type = {escape_sql(ptype)}")
            
            # Representation type
            updates.append(f"representation_type = {escape_sql(q.get('representation_type'))}")

            f.write(f"-- Updating {title} ({q_id})\n")
            f.write(f"UPDATE public.questions SET\n  ")
            f.write(",\n  ".join(updates))
            f.write(f"\nWHERE id = '{q_id}';\n\n")

        f.write("COMMIT;\n")
    
    print(f"Generated {output_file}")

if __name__ == "__main__":
    main()
