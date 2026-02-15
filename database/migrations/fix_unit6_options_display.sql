DO $$
DECLARE
    q_rec RECORD;
    new_opts JSONB;
    opt JSONB;
    opt_expl TEXT;
    i INT;
    has_changes BOOLEAN;
BEGIN
    FOR q_rec IN 
        SELECT id, options, micro_explanations 
        FROM public.questions 
        WHERE (sub_topic_id LIKE '6.%' OR sub_topic_id = 'unit_test' OR topic LIKE 'Unit6%')
          AND options IS NOT NULL
    LOOP
        new_opts := '[]'::jsonb;
        has_changes := FALSE;

        IF jsonb_typeof(q_rec.options) = 'array' THEN
            FOR i IN 0 .. jsonb_array_length(q_rec.options) - 1 LOOP
                opt := q_rec.options->i;
                
                -- Fix 1: Rename 'text' to 'value' for Frontend Compatibility
                IF opt ? 'text' AND NOT (opt ? 'value') THEN
                    opt := opt || jsonb_build_object('value', opt->>'text');
                    opt := opt - 'text';
                    has_changes := TRUE;
                END IF;

                -- Fix 2: Merge micro_explanations into option.explanation
                IF q_rec.micro_explanations IS NOT NULL THEN
                    -- Check both ID and keys like "A", "B" just in case
                    opt_expl := q_rec.micro_explanations->>(opt->>'id');
                    
                    IF opt_expl IS NOT NULL AND opt_expl <> '' THEN
                        opt := opt || jsonb_build_object('explanation', opt_expl);
                        has_changes := TRUE;
                    END IF;
                END IF;

                new_opts := new_opts || opt;
            END LOOP;
        END IF;

        IF has_changes THEN
            UPDATE public.questions 
            SET options = new_opts 
            WHERE id = q_rec.id;
        END IF;
    END LOOP;
END $$;
