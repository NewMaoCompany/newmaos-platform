
import re
import os

input_file = '/Users/zhuchen/Downloads/questions_rows (18).sql'
output_file = '/Users/zhuchen/Downloads/newmaos---ap-calculus-mastery/database/upsert_unit1_by_title.sql'

def transform_sql():
    try:
        with open(input_file, 'r', encoding='utf-8') as f:
            content = f.read()
    except FileNotFoundError:
        print(f"Error: Input file {input_file} not found.")
        return

    # 1. Parse columns from the INSERT statement to build the UPDATE clause
    match = re.search(r'INSERT INTO "public"\."questions" \((.*?)\) VALUES', content, re.DOTALL)
    if not match:
        print("Could not parse columns from INSERT statement.")
        return

    columns_str = match.group(1)
    column_names = [c.strip().strip('"') for c in columns_str.split(',')]
    
    print(f"Parsed {len(column_names)} columns.")

    # 2. Build the UPDATE clause
    # Logic: UPDATE public.questions q SET col = i.col ... FROM unit1_import i WHERE q.title = i.title
    # Exclude 'id' and 'created_at' from update generally, but definitely exclude 'id'.
    # Also exclude 'title' from SET (it's the join key).
    
    update_parts = []
    for col in column_names:
        if col not in ['id', 'created_at', 'title']:
            update_parts.append(f'"{col}" = i."{col}"')
    
    update_sql = f"""
    -- Update existing questions by Title
    UPDATE public.questions q
    SET
        {', '.join(update_parts)},
        updated_at = NOW()
    FROM unit1_import i
    WHERE q.title = i.title;
    """

    # 3. Build the INSERT clause for new rows
    # Logic: INSERT INTO public.questions SELECT * FROM unit1_import i WHERE NOT EXISTS (SELECT 1 FROM public.questions q WHERE q.title = i.title)
    # We copy strictly what's in the import. 
    # NOTE: This carries a risk of PK collision on 'id' if the import ID exists but title is different.
    # But usually this is the desired behavior for "add missing".
    
    insert_sql = """
    -- Insert new questions (where Title does not exist)
    INSERT INTO public.questions
    SELECT * FROM unit1_import i
    WHERE NOT EXISTS (
        SELECT 1 FROM public.questions q WHERE q.title = i.title
    );
    """

    # 4. Transform the main content to insert into Temp Table
    # Replace the INSERT target
    # The file has: INSERT INTO "public"."questions" ...
    # We change to: INSERT INTO unit1_import ...
    
    # We assume standard formatting from the dump.
    import_sql = content.replace(
        'INSERT INTO "public"."questions"', 
        'INSERT INTO unit1_import'
    )
    
    # 5. Assemble the final script
    final_sql = f"""
    -- Safe UPSERT by Title
    -- 1. Create Temp Table structure
    DROP TABLE IF EXISTS unit1_import;
    CREATE TEMP TABLE unit1_import AS TABLE public.questions WITH NO DATA;

    -- 2. Validate Temp Table creation
    DO $$
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM information_schema.tables WHERE table_name = 'unit1_import') THEN
            RAISE EXCEPTION 'Failed to create temp table unit1_import';
        END IF;
    END $$;

    -- 3. Load data into Temp Table
    {import_sql}

    -- 4. Update existing records
    {update_sql}

    -- 5. Insert new records
    {insert_sql}

    -- 6. Cleanup
    DROP TABLE unit1_import;
    """
    
    # 6. Write to output
    os.makedirs(os.path.dirname(output_file), exist_ok=True)
    with open(output_file, 'w', encoding='utf-8') as f:
        f.write(final_sql)
        
    print(f"Successfully created {output_file}")

if __name__ == '__main__':
    transform_sql()
