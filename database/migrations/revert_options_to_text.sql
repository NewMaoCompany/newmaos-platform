-- Revert "value" key back to "text" key for ALL questions
-- This undoes the standardization to "value" key, returning the table to a state where "text" key is used.
-- Note: This affects ALL questions in the table.

UPDATE public.questions
SET options = (
  SELECT jsonb_agg(
    CASE 
      WHEN elem ? 'value' THEN 
        (elem - 'value') || jsonb_build_object('text', elem->>'value')
      ELSE elem
    END
  )
  FROM jsonb_array_elements(options) AS elem
),
version = version + 1,
updated_at = NOW()
WHERE options->0 ? 'value';
