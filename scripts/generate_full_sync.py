
import json
import os

def generate_perfect_name(tag_id):
    # Remove prefixes
    clean_id = tag_id
    if clean_id.startswith('SK_'):
        clean_id = clean_id[3:]
    elif clean_id.startswith('ERR_'):
        clean_id = clean_id[4:]
    
    # Handle Unit prefixes strictly for extraction but keep part of name if meaningful?
    # e.g. UNIT5_MVT -> MVT. 
    # But "Unit 5 MVT" is better description? 
    # User said "perfect detailed name". "Mean Value Theorem (Unit 5)" is good.
    
    parts = clean_id.split('_')
    name_parts = []
    unit_name = ""
    
    for part in parts:
        if part.startswith('UNIT'):
            # Extract unit number
            unit_num = part.replace('UNIT', '')
            if unit_num.isdigit():
                unit_name = f"Unit {unit_num}"
            else:
                name_parts.append(part.title())
        elif part == 'BC':
            name_parts.append('BC')
        elif part == 'AB':
            name_parts.append('AB')
        elif part == 'MCQ':
            name_parts.append('MCQ')
        elif part == 'FRQ':
            name_parts.append('FRQ')
        else:
            name_parts.append(part.replace('-', ' ').title())
            
    name = " ".join(name_parts)
    
    # Beautify common terms
    replacements = {
        "Mvt": "Mean Value Theorem",
        "Ivt": "Intermediate Value Theorem",
        "Evt": "Extreme Value Theorem",
        "Lhopital": "L'Hopital's Rule",
        "Lhr": "L'Hopital's Rule",
        "Ftc": "Fundamental Theorem of Calculus",
        "Diff": "Differentiation",
        "Func": "Function",
        "Trig": "Trigonometry",
        "Inv": "Inverse",
        "Derv": "Derivative",
        "Int": "Integration",
        "Apps": "Applications",
        "Vol": "Volume",
        "Sa": "Surface Area",
        "Len": "Length",
        "Param": "Parametric",
        "Vec": "Vector",
        "Seq": "Sequence",
        "Ser": "Series",
        "Conv": "Convergence",
        "Div": "Divergence",
        "Geom": "Geometric",
        "Harm": "Harmonic",
        "Alt": "Alternating",
        "Tele": "Telescoping",
        "Pser": "P-Series",
        "Taylor": "Taylor Series",
        "Mac": "Maclaurin Series",
        "Lagrange": "Lagrange Error Bound",
        "Polar": "Polar Coordinates",
        "Log": "Logarithmic",
        "Exp": "Exponential",
        "Growth": "Growth & Decay",
        "Sep": "Separable",
        "Slope": "Slope Fields",
        "Euler": "Euler's Method",
        "Logist": "Logistic Models",
        "Imp": "Implicit",
        "Rel": "Related Rates",
        "Opt": "Optimization",
        "Conc": "Concavity",
        "Incr": "Increasing",
        "Decr": "Decreasing",
        "Infl": "Inflection Points",
        "Crit": "Critical Points",
        "Ext": "Extrema",
        "Loc": "Local",
        "Abs": "Absolute",
        "Avg": "Average Value",
        "Mv": "Mean Value",
        "Cont": "Continuity",
        "Disc": "Discontinuity",
        "Diffability": "Differentiability",
        "Quot": "Quotient Rule",
        "Prod": "Product Rule",
        "Const": "Constant",
        "Mult": "Multiple",
        "Sum": "Sum",
        "Lim": "Limits",
        "Inf": "Infinity",
        "Hole": "Removable Discontinuity",
        "Jump": "Jump Discontinuity",
        "Vert": "Vertical",
        "Horiz": "Horizontal",
        "Asymp": "Asymptotes",
        "Sandwich": "Squeeze Theorem",
        "Squeeze": "Squeeze Theorem",
        "Alg": "Algebraic",
        "Calc": "Calculation",
        "Arith": "Arithmetic",
        "Sign": "Sign Error",
        "Unit": "Unit Circle",
        "Graph": "Graphing",
        "Read": "Reading",
        "Interp": "Interpretation",
        "Just": "Justification",
        "Not": "Notation",
        "Form": "Formula",
        "Thm": "Theorem",
        "Def": "Definition",
        "App": "Application",
        "Id": "Identity",
        "Sub": "Substitution",
        "Parts": "Integration by Parts",
        "Part": "Partial Fractions",
        "Improper": "Improper Integrals"
    }
    
    # Replace whole words
    words = name.split()
    new_words = []
    
    # Pre-checking for specific combinations to avoid double replacement or bad mapping
    # e.g. "Ratio Test" -> "Ratio Test Test" if "Ratio"->"Ratio Test"
    
    for w in words:
        new_words.append(replacements.get(w, w))
    
    final_name = " ".join(new_words)
    
    # Clean up redundancies
    redundancies = [
        ("Test Test", "Test"),
        ("Rule Rule", "Rule"),
        ("Sum Sum", "Sum"),
        ("Integral Integration", "Integration"),
        ("Series Series", "Series"),
        ("Theorem Theorem", "Theorem"),
        ("Slope Fields Field", "Slope Field"),
        ("Value Value", "Value")
    ]
    
    for bad, good in redundancies:
        final_name = final_name.replace(bad, good)
    
    if unit_name:
        final_name = f"{final_name} ({unit_name})"
        
    # Fallback if empty (e.g. SK_UNIT1)
    if not final_name.strip() and unit_name:
        final_name = f"General {unit_name} Skill"
    elif not final_name.strip():
        final_name = clean_id.replace('_', ' ').title()
        
    return final_name

def extract_unit(tag_id):
    parts = tag_id.split('_')
    for part in parts:
        if part.startswith('UNIT'):
            return part.replace('UNIT', 'Unit ')
    return 'General'

def generate_sql():
    with open('exported_tags.json', 'r') as f:
        questions = json.load(f)
        
    unique_skills = set()
    unique_errors = set()
    
    # Collect unique tags
    for q in questions:
        if q.get('skill_tags'):
            for s in q['skill_tags']:
                unique_skills.add(s)
        if q.get('error_tags'):
            for e in q['error_tags']:
                unique_errors.add(e)
                
    sql_lines = []
    sql_lines.append("-- Syncing Tags to Relation Tables (Clean Slate)")
    sql_lines.append("-- Generated by script with FULL CLEANUP of old data")
    
    # Collect unique IDs
    skills_list = []
    error_tags_list = []
    
    for s_id in sorted(list(unique_skills)):
        skills_list.append(f"'{s_id}'")
        
    for e_id in sorted(list(unique_errors)):
        error_tags_list.append(f"'{e_id}'")
        
    skills_in_clause = ", ".join(skills_list)
    error_tags_in_clause = ", ".join(error_tags_list)

    # 1. Clear Dependencies (Relations & References)
    sql_lines.append("\n-- 1. Clear Relation Tables & Remove References to Old Skills/Errors")
    sql_lines.append("DELETE FROM public.question_skills;")
    sql_lines.append("DELETE FROM public.question_error_patterns;")
    
    # We must set primary_skill_id to NULL to avoid foreign key constraints when deleting old skills
    sql_lines.append("UPDATE public.questions SET primary_skill_id = NULL, supporting_skill_ids = NULL;")
    
    # 2. Delete Unused Skills and Error Tags
    sql_lines.append("\n-- 2. Delete Unused Skills & Error Tags (Cleanup)")
    if skills_in_clause:
        sql_lines.append(f"DELETE FROM public.skills WHERE id NOT IN ({skills_in_clause});")
    
    if error_tags_in_clause:
        sql_lines.append(f"DELETE FROM public.error_tags WHERE id NOT IN ({error_tags_in_clause});")

    # 3. Upsert New Definitions
    sql_lines.append("\n-- 3. Upsert Skills Definitions")
    for s_id in sorted(list(unique_skills)):
        name = generate_perfect_name(s_id)
        unit = extract_unit(s_id)
        safe_name = name.replace("'", "''")
        sql_lines.append(f"INSERT INTO public.skills (id, name, unit) VALUES ('{s_id}', '{safe_name}', '{unit}') ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, unit = EXCLUDED.unit;")
        
    sql_lines.append("\n-- 4. Upsert Error Tag Definitions")
    for e_id in sorted(list(unique_errors)):
        name = generate_perfect_name(e_id)
        unit = extract_unit(e_id)
        safe_name = name.replace("'", "''")
        sql_lines.append(f"INSERT INTO public.error_tags (id, name, category, severity, unit) VALUES ('{e_id}', '{safe_name}', 'General', 1, '{unit}') ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name;")

    sql_lines.append("\n-- 5. Insert Relations and Update Questions")
    for q in questions:
        q_id = q['id']
        skill_tags = q.get('skill_tags', [])
        error_tags = q.get('error_tags', [])
        
        # Skill Relations
        if skill_tags:
            primary = skill_tags[0]
            supporting = skill_tags[1:]
            
            # Primary
            sql_lines.append(f"INSERT INTO public.question_skills (question_id, skill_id, role, weight) VALUES ('{q_id}', '{primary}', 'primary', 1.0) ON CONFLICT DO NOTHING;")
            
            # Supporting
            for s in supporting:
                sql_lines.append(f"INSERT INTO public.question_skills (question_id, skill_id, role, weight) VALUES ('{q_id}', '{s}', 'supporting', 0.5) ON CONFLICT DO NOTHING;")
            
            # Update Question Columns
            if supporting:
                supp_array = "ARRAY[" + ", ".join([f"'{s}'" for s in supporting]) + "]"
            else:
                supp_array = "'{}'"
            
            sql_lines.append(f"UPDATE public.questions SET primary_skill_id = '{primary}', supporting_skill_ids = {supp_array} WHERE id = '{q_id}';")
            
        else:
             # Look for no skills case? Usually shouldn't happen if we trust source.
             pass

        # Error Relations
        if error_tags:
            for e in error_tags:
                # question_error_patterns needs a UUID PK. Using gen_random_uuid() is fine.
                # It has (id, question_id, error_tag_id, description, created_at)
                sql_lines.append(f"INSERT INTO public.question_error_patterns (question_id, error_tag_id, description) VALUES ('{q_id}', '{e}', NULL) ON CONFLICT DO NOTHING;")
                
    with open('database/sync_all_tags_relations.sql', 'w') as f:
        f.write('\n'.join(sql_lines))
        
    print(f"Generated database/sync_all_tags_relations.sql with {len(sql_lines)} lines.")

if __name__ == '__main__':
    generate_sql()
