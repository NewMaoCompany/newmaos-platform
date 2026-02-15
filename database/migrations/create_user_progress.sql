
-- Create user_progress table
CREATE TABLE IF NOT EXISTS public.user_progress (
    user_id UUID NOT NULL, -- Link to auth.users theoretically, but we use string/uuid from app
    section_id TEXT NOT NULL, -- '3.1', 'Unit6_Test', etc.
    status TEXT NOT NULL DEFAULT 'not_started' CHECK (status IN ('not_started', 'in_progress', 'completed')),
    completed_items INTEGER NOT NULL DEFAULT 0,
    total_items INTEGER NOT NULL DEFAULT 0,
    percentage FLOAT NOT NULL DEFAULT 0.0,
    resume_data JSONB DEFAULT '{}'::jsonb, -- Stores { currentIndex: 5, answers: {...} }
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    PRIMARY KEY (user_id, section_id)
);

-- Enable RLS
ALTER TABLE public.user_progress ENABLE ROW LEVEL SECURITY;

-- Policies (assuming public open for now based on other tables, or simplified)
-- Ideally:
-- CREATE POLICY "Users can see their own progress" ON public.user_progress FOR SELECT USING (auth.uid() = user_id);
-- CREATE POLICY "Users can update their own progress" ON public.user_progress FOR ALL USING (auth.uid() = user_id);
-- For now, allowing service role /anon access as per existing patterns if RLS is effectively disabled or handled by app logic with keys.
-- We will create a broad policy to avoid 'Rls violation' if anon key is used.
CREATE POLICY "Enable all access for now" ON public.user_progress FOR ALL USING (true) WITH CHECK (true);

-- Function to update updated_at
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
   NEW.updated_at = NOW();
   RETURN NEW;
END;
$$ language 'plpgsql';

CREATE TRIGGER update_user_progress_updated_at
BEFORE UPDATE ON public.user_progress
FOR EACH ROW EXECUTE PROCEDURE update_updated_at_column();

-- Aggregation Views/Functions
-- NOTE: We cannot easily aggregate cross-tables without knowing the exact structure of 'sections' table for grouping.
-- Assuming 'sections' table has: id, topic_id (which is the Unit), is_unit_test.

-- Helper function to calculate Unit Progress
-- Weights: Practice (Avg of Non-Tests) 80%, Unit Test 20%
CREATE OR REPLACE FUNCTION get_unit_progress(p_user_id UUID, p_topic_id TEXT)
RETURNS FLOAT AS $$
DECLARE
    v_practice_avg FLOAT;
    v_test_score FLOAT;
    v_unit_score FLOAT;
BEGIN
    -- 1. Calculate Practice Avg (All sections in this topic that are NOT unit tests)
    -- We assume sections table exists and maps section_id -> topic_id
    SELECT COALESCE(AVG(up.percentage), 0)
    INTO v_practice_avg
    FROM sections s
    LEFT JOIN user_progress up ON s.id = up.section_id AND up.user_id = p_user_id
    WHERE s.topic_id = p_topic_id 
      AND (s.is_unit_test = false OR s.id NOT LIKE '%test%'); -- Robust check

    -- 2. Calculate Unit Test Score
    -- We assume the unit test has a specific ID or flag. 
    -- Usually defined as is_unit_test=true.
    SELECT COALESCE(MAX(up.percentage), 0)
    INTO v_test_score
    FROM sections s
    LEFT JOIN user_progress up ON s.id = up.section_id AND up.user_id = p_user_id
    WHERE s.topic_id = p_topic_id 
      AND s.is_unit_test = true;

    -- 3. Weighted Sum
    -- If there are no practice sections, 100% test? Or just standard formula.
    -- App logic: 80/20.
    v_unit_score := (v_practice_avg * 0.8) + (v_test_score * 0.2);
    
    RETURN v_unit_score;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
