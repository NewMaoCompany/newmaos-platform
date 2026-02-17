
import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';
import fs from 'fs';

// Load env vars
dotenv.config({ path: '.env.local' });

const supabaseUrl = process.env.VITE_SUPABASE_URL;
const supabaseKey = process.env.VITE_SUPABASE_ANON_KEY;

if (!supabaseUrl || !supabaseKey) {
    console.error('Missing Supabase credentials in .env.local');
    process.exit(1);
}

const supabase = createClient(supabaseUrl, supabaseKey);

// 2. Mock Static Data (from constants.ts - partial)
const UNIT3_SUBTOPICS = [
    { id: '3.2', title: '3.2 Implicit Differentiation', description: 'Implicit', estimatedMinutes: 20, content: '' },
];

const COURSE_CONTENT_DATA = {
    'Both_Composite': {
        id: 'Both_Composite',
        title: 'Unit 3: Differentiation: Composite, Implicit, and Inverse Functions',
        description: 'Composite Functions',
        subTopics: UNIT3_SUBTOPICS
    }
};

let topicContent = { ...COURSE_CONTENT_DATA };

// Real DB fetch
async function simulateFetchSections() {
    console.log('--- Simulating fetchSections with REAL DATA ---');

    // Fetch sections for 'Both_Composite'
    const { data: dbSections, error } = await supabase
        .from('sections')
        .select('*')
        .eq('topic_id', 'Both_Composite');

    if (error) {
        console.error('Fetch error:', error);
        return;
    }

    console.log(`Fetched ${dbSections?.length} sections from DB.`);

    const topicId = 'Both_Composite';
    const subSections = dbSections.filter(s => s.id !== 'unit_test');

    // Base subtopics from state or constant fallback
    // Simulate AppContext: updated[topicId] is initially from COURSE_CONTENT_DATA
    const baseSubTopics = topicContent[topicId].subTopics;

    console.log(`Processing topic: ${topicId}`);
    console.log(`DB Sections count: ${subSections.length}`);
    console.log(`Base SubTopics count: ${baseSubTopics.length}`);

    if (subSections.length > 0 && baseSubTopics.length > 0) {
        topicContent[topicId] = {
            ...topicContent[topicId],
            subTopics: baseSubTopics.map(sub => {
                const dbSection = subSections.find(s => String(s.id) === String(sub.id));

                if (dbSection) {
                    console.log(`Found DB match for ${sub.id}`);
                    // console.log('DB Section:', JSON.stringify(dbSection, null, 2));
                    return {
                        ...sub,
                        title: dbSection.title ?? sub.title,
                        description: dbSection.description ?? sub.description,
                        // Key line from AppContext.tsx:
                        description_2: dbSection.description_2 || dbSection.chapter_detailed_description || dbSection.description2 || dbSection.detailed_description || sub.description_2 || null,
                        courseScope: dbSection.course_scope || sub.courseScope,
                        estimatedMinutes: dbSection.estimated_minutes || sub.estimatedMinutes,
                        hasLesson: dbSection.has_lesson !== false,
                        hasPractice: dbSection.has_practice !== false
                    };
                }
                return sub;
            })
        };
    }

    // Inspect Result
    console.log('--- Result ---');
    const resultSubTopic = topicContent[topicId].subTopics.find(s => s.id === '3.2');
    console.log('Merged 3.2 SubTopic:', JSON.stringify(resultSubTopic, null, 2));

    if (resultSubTopic.description_2) {
        console.log('SUCCESS: description_2 is present.');
    } else {
        console.log('FAILURE: description_2 is MISSING.');
    }
}

simulateFetchSections();
