
import re
import os

input_file = 'database/update_unit2_part3.sql'
output_file = 'database/update_unit2_part3.sql'

def process_file():
    with open(input_file, 'r') as f:
        content = f.read()

    # Regex to find skill_tags lines
    # skill_tags = ARRAY['SK_AVG_ROC', 'SK_SECANT_SLOPE', 'SK_FUNC_EVAL', 'SK_UNITS_INTERPRET'],
    pattern = re.compile(r"skill_tags = ARRAY\[(.*?)\]", re.MULTILINE)

    def replacement(match):
        full_match = match.group(0)
        skills_str = match.group(1)
        
        # Split by comma and strip quotes/whitespace
        skills = [s.strip().strip("'") for s in skills_str.split(',') if s.strip()]
        
        if not skills:
            return full_match

        primary = skills[0]
        supporting = skills[1:]
        
        # Format the new lines
        primary_line = f"primary_skill_id = '{primary}'"
        
        if supporting:
            supporting_str = ", ".join([f"'{s}'" for s in supporting])
            supporting_line = f"supporting_skill_ids = ARRAY[{supporting_str}]"
        else:
            supporting_line = "supporting_skill_ids = ARRAY[]::text[]"

        # Return the original line + new lines
        # Add comma after full_match because it is followed by more SET items
        return f"{full_match},\n  {primary_line},\n  {supporting_line}"

    new_content = pattern.sub(replacement, content)

    with open(output_file, 'w') as f:
        f.write(new_content)
    
    print(f"Successfully updated {output_file} with skill IDs.")

if __name__ == "__main__":
    process_file()
