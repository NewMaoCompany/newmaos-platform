
import re
import os

input_file = '/Users/zhuchen/Downloads/questions_rows (18).sql'
output_file = '/Users/zhuchen/Downloads/newmaos---ap-calculus-mastery/database/upsert_unit1_explicit.sql'

def parse_csv_robust(row_str):
    # Robust CSV parser for SQL values that respects quotes and nesting [], {}, ()
    vals = []
    current_val = []
    in_string = False
    paren_depth = 0
    bracket_depth = 0
    brace_depth = 0
    
    i = 0
    length = len(row_str)
    
    while i < length:
        char = row_str[i]
        
        if in_string:
            if char == "'":
                # Check for escaped quote ''
                if i + 1 < length and row_str[i+1] == "'":
                    current_val.append("'")
                    current_val.append("'")
                    i += 1
                else:
                    in_string = False
                    current_val.append(char)
            else:
                current_val.append(char)
        else:
            if char == "'":
                in_string = True
                current_val.append(char)
            elif char == '(':
                paren_depth += 1
                current_val.append(char)
            elif char == ')':
                paren_depth -= 1
                current_val.append(char)
            elif char == '[':
                bracket_depth += 1
                current_val.append(char)
            elif char == ']':
                bracket_depth -= 1
                current_val.append(char)
            elif char == '{':
                brace_depth += 1
                current_val.append(char)
            elif char == '}':
                brace_depth -= 1
                current_val.append(char)
            elif char == ',':
                # Split only if not nested and not in string
                if paren_depth == 0 and bracket_depth == 0 and brace_depth == 0:
                    val = "".join(current_val).strip()
                    vals.append(val)
                    current_val = []
                else:
                    current_val.append(char)
            else:
                current_val.append(char)
        i += 1
    
    # Append last
    if current_val:
        vals.append("".join(current_val).strip())
        
    return vals

def custom_row_parser(content):
    # Find the start of values
    start_match = re.search(r'VALUES\s*\(', content, re.DOTALL)
    if not start_match:
        return []
    
    values_body = content[start_match.start() + 7:].strip()
    if values_body.endswith(';'):
        values_body = values_body[:-1]
        
    rows = []
    current_val = [] # Buffer for the entire row string "(val1, val2)"
    
    in_string = False
    paren_depth = 0
    
    # We want to split the huge string into row strings: "(...)", "(...)"
    # Then parse each row string individually.
    
    i = 0
    length = len(values_body)
    
    while i < length:
        char = values_body[i]
        
        if in_string:
            if char == "'":
                if i + 1 < length and values_body[i+1] == "'":
                    current_val.append("''")
                    i += 1
                else:
                    in_string = False
                    current_val.append(char)
            else:
                current_val.append(char)
        else:
            if char == "'":
                in_string = True
                current_val.append(char)
            elif char == '(':
                if paren_depth == 0:
                    # Start of a row
                    current_val = [] # Don't include the opening paren in buffer for simplicity? 
                    # Actually, better to keep it clean.
                else:
                    current_val.append(char)
                paren_depth += 1
            elif char == ')':
                paren_depth -= 1
                if paren_depth == 0:
                    # End of a row
                    row_str = "".join(current_val)
                    # Parse the contents
                    rows.append(parse_csv_robust(row_str))
                    current_val = []
                    
                    # Skip comma/whitespace until next (
                    while i + 1 < length and values_body[i+1] != '(':
                        i += 1
                else:
                    current_val.append(char)
            else:
                if paren_depth > 0:
                    current_val.append(char)
        i += 1
        
    return rows

def generate_script():
    try:
        with open(input_file, 'r', encoding='utf-8') as f:
            content = f.read()
    except Exception as e:
        print(f"Error reading file: {e}")
        return

    # 1. Get Columns
    col_match = re.search(r'INSERT INTO "public"\."questions" \((.*?)\) VALUES', content, re.DOTALL)
    if not col_match:
        print("Columns not found.")
        return
    
    columns = [c.strip().strip('"') for c in col_match.group(1).split(',')]
    print(f"Parsed columns: {len(columns)}")
    
    # 2. Get Rows
    rows = custom_row_parser(content)
    print(f"Parsed {len(rows)} rows.")
    
    # 3. Generate SQL
    sql_blocks = []
    
    for row in rows:
        if len(row) != len(columns):
            print(f"Row length mismatch: Expected {len(columns)}, got {len(row)}")
            # print(f"Row content: {row}") 
            continue
            
        row_dict = dict(zip(columns, row))
        
        # Filter for 1.1 and 1.2 as requested
        sub_topic = row_dict.get('sub_topic_id', '').replace("'", "")
        if sub_topic not in ['1.1', '1.2']:
            continue

        # Extract Key Fields
        title_raw = row_dict.get('title', 'NULL')
        
        # Unquote title for use in SQL string
        if title_raw.startswith("'") and title_raw.endswith("'"):
            title_val = title_raw[1:-1].replace("''", "'")
        else:
            title_val = title_raw
            
        safe_title = title_val.replace("'", "''")
        
        # Build SET clause
        set_parts = []
        for col, val in row_dict.items():
            if col in ['id', 'created_at', 'title']:
                continue
            
            # FIX: Convert ARRAY["..."] to ARRAY['...'] to avoid "column does not exist" error
            if val.startswith('ARRAY['):
                val = val.replace('"', "'")
            
            # FIX: Reduce excessive backslashes (8 -> 4) for KaTeX compatibility
            # Found that 8 backslashes in SQL -> 2 in JS -> KaTeX sees \\ (newline) instead of \command
            # Target: 4 in SQL -> 1 in JS -> KaTeX sees \command
            if isinstance(val, str):
                 val = val.replace(r'\\\\\\\\', r'\\\\')

            if col == 'updated_at':
                set_parts.append('updated_at = NOW()')
                continue
            
            if col == 'options':
                set_parts.append(f'options = {val}::jsonb')
            else:
                set_parts.append(f'{col} = {val}')
                
        set_clause = ",\n        ".join(set_parts)
        
        # Build INSERT clause
        insert_cols = []
        insert_vals = []
        for col, val in row_dict.items():
            insert_cols.append(col)
            
            # FIX: Convert ARRAY["..."] to ARRAY['...'] here too
            if val.startswith('ARRAY['):
                val = val.replace('"', "'")
            
            # FIX: Reduce backslashes
            if isinstance(val, str):
                 val = val.replace(r'\\\\\\\\', r'\\\\')
                
            if col == 'updated_at':
                insert_vals.append('NOW()')
            elif col == 'options':
                insert_vals.append(f'{val}::jsonb')
            else:
                insert_vals.append(val)
        
        insert_cols_str = ", ".join(insert_cols)
        insert_vals_str = ", ".join(insert_vals)
        
        block = f"""
DO $do$
BEGIN
    -- Update based on title
    UPDATE public.questions
    SET
        {set_clause}
    WHERE title = '{safe_title}';

    -- Insert if not found
    IF NOT FOUND THEN
        INSERT INTO public.questions ({insert_cols_str})
        VALUES ({insert_vals_str});
    END IF;
END $do$;
"""
        sql_blocks.append(block)

    # Write Output
    with open(output_file, 'w', encoding='utf-8') as f:
        f.write("-- Explicit Title-based UPSERT Script\n")
        f.write("-- Generated matching user request for explicit update blocks + Insert fallback\n")
        f.write("\n".join(sql_blocks))
        
    print(f"Created {output_file} with {len(sql_blocks)} blocks.")

if __name__ == '__main__':
    generate_script()
