
import re
import os

input_file = '/Users/zhuchen/Downloads/questions_rows (18).sql'
output_file = '/Users/zhuchen/Downloads/newmaos---ap-calculus-mastery/database/upsert_unit1.sql'

def transform_sql():
    try:
        with open(input_file, 'r', encoding='utf-8') as f:
            content = f.read()
    except FileNotFoundError:
        print(f"Error: Input file {input_file} not found.")
        return

    # 1. Parse columns from the INSERT statement
    match = re.search(r'INSERT INTO "public"\."questions" \((.*?)\) VALUES', content, re.DOTALL)
    if not match:
        print("Could not parse columns from INSERT statement.")
        return

    columns_str = match.group(1)
    # Remove quotes and spaces to get clean column names
    column_names = [c.strip().strip('"') for c in columns_str.split(',')]
    
    print(f"Parsed {len(column_names)} columns: {column_names}")

    # 2. Build the ON CONFLICT clause
    # Exclude 'id' (primary key) and 'created_at' (usually preserved on update)
    # But usually for a raw sync, we might update everything except ID.
    # Let's update all non-PK columns to ensure data matches the source.
    
    update_parts = []
    for col in column_names:
        if col != 'id':
            update_parts.append(f'"{col}" = EXCLUDED."{col}"')
    
    update_clause = 'ON CONFLICT ("id") DO UPDATE SET\n    ' + ',\n    '.join(update_parts) + ';'

    # 3. Modify the SQL content
    # Remove the final semicolon and append the update clause
    # We assume the file ends with a semicolon for the INSERT statement.
    content = content.rstrip().rstrip(';') 
    
    final_sql = content + '\n' + update_clause
    
    # 4. Write to output file
    os.makedirs(os.path.dirname(output_file), exist_ok=True)
    with open(output_file, 'w', encoding='utf-8') as f:
        f.write(final_sql)
        
    print(f"Successfully created {output_file}")

if __name__ == '__main__':
    transform_sql()
