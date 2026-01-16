import { Router, Request, Response } from 'express';
import { supabaseAdmin } from '../config/supabase';
import { authMiddleware, optionalAuthMiddleware } from '../middleware/auth';

const router = Router();

// GET /api/content/topics - Get all topic content
router.get('/topics', optionalAuthMiddleware, async (req: Request, res: Response): Promise<void> => {
    try {
        const { data, error } = await supabaseAdmin
            .from('topic_content')
            .select('*');

        if (error) {
            res.status(400).json({ error: error.message });
            return;
        }

        // Transform to frontend format (Record<string, UnitContent>)
        const topicContent: Record<string, any> = {};
        (data || []).forEach((item: { id: string; title: string; description: string; sub_topics: any[]; unit_test: any }) => {
            topicContent[item.id] = {
                id: item.id,
                title: item.title,
                description: item.description,
                subTopics: item.sub_topics || [],
                unitTest: item.unit_test
            };
        });

        res.json(topicContent);
    } catch (error) {
        console.error('Get topics error:', error);
        res.status(500).json({ error: 'Failed to get topic content' });
    }
});

// PUT /api/content/topics/:unitId - Update unit content
router.put('/topics/:unitId', authMiddleware, async (req: Request, res: Response): Promise<void> => {
    try {
        const userId = req.user!.id;
        const { unitId } = req.params;
        const { title, description, unitTest } = req.body;

        // Check if user is creator
        const { data: profile } = await supabaseAdmin
            .from('user_profiles')
            .select('is_creator')
            .eq('id', userId)
            .single();

        if (!profile?.is_creator) {
            res.status(403).json({ error: 'Creator access required' });
            return;
        }

        const updates: Record<string, any> = { updated_at: new Date().toISOString() };
        if (title !== undefined) updates.title = title;
        if (description !== undefined) updates.description = description;
        if (unitTest !== undefined) updates.unit_test = unitTest;

        const { data, error } = await supabaseAdmin
            .from('topic_content')
            .update(updates)
            .eq('id', unitId)
            .select()
            .single();

        if (error) {
            res.status(400).json({ error: error.message });
            return;
        }

        res.json({
            id: data.id,
            title: data.title,
            description: data.description,
            subTopics: data.sub_topics,
            unitTest: data.unit_test
        });
    } catch (error) {
        console.error('Update unit error:', error);
        res.status(500).json({ error: 'Failed to update unit' });
    }
});

// PUT /api/content/topics/:unitId/subtopics/:subTopicId - Update subtopic
router.put('/topics/:unitId/subtopics/:subTopicId', authMiddleware, async (req: Request, res: Response): Promise<void> => {
    try {
        const userId = req.user!.id;
        const { unitId, subTopicId } = req.params;
        const updateData = req.body;

        // Check if user is creator
        const { data: profile } = await supabaseAdmin
            .from('user_profiles')
            .select('is_creator')
            .eq('id', userId)
            .single();

        if (!profile?.is_creator) {
            res.status(403).json({ error: 'Creator access required' });
            return;
        }

        // Get current content
        const { data: current } = await supabaseAdmin
            .from('topic_content')
            .select('*')
            .eq('id', unitId)
            .single();

        if (!current) {
            res.status(404).json({ error: 'Unit not found' });
            return;
        }

        // Handle unit_test update
        if (subTopicId === 'unit_test') {
            const currentUnitTest = current.unit_test || {
                title: 'Unit Test',
                description: `Comprehensive assessment covering all topics in ${current.title}.`,
                estimatedMinutes: 45
            };

            const { data, error } = await supabaseAdmin
                .from('topic_content')
                .update({
                    unit_test: { ...currentUnitTest, ...updateData },
                    updated_at: new Date().toISOString()
                })
                .eq('id', unitId)
                .select()
                .single();

            if (error) {
                res.status(400).json({ error: error.message });
                return;
            }

            res.json({ message: 'Unit test updated', unitTest: data.unit_test });
            return;
        }

        // Update subtopic in the array
        const subTopics = current.sub_topics || [];
        const subTopicIndex = subTopics.findIndex((s: any) => s.id === subTopicId);

        if (subTopicIndex === -1) {
            res.status(404).json({ error: 'Subtopic not found' });
            return;
        }

        subTopics[subTopicIndex] = { ...subTopics[subTopicIndex], ...updateData };

        const { data, error } = await supabaseAdmin
            .from('topic_content')
            .update({
                sub_topics: subTopics,
                updated_at: new Date().toISOString()
            })
            .eq('id', unitId)
            .select()
            .single();

        if (error) {
            res.status(400).json({ error: error.message });
            return;
        }

        res.json({
            message: 'Subtopic updated',
            subTopic: subTopics[subTopicIndex]
        });
    } catch (error) {
        console.error('Update subtopic error:', error);
        res.status(500).json({ error: 'Failed to update subtopic' });
    }
});

// POST /api/content/seed - Seed initial topic content (one-time setup)
router.post('/seed', async (req: Request, res: Response): Promise<void> => {
    try {
        // Check if already seeded
        const { count } = await supabaseAdmin
            .from('topic_content')
            .select('*', { count: 'exact', head: true });

        if (count && count > 0) {
            res.json({ message: 'Already seeded', count });
            return;
        }

        // Import the course content data structure from constants
        // This is a simplified version - the full data would come from the COURSE_CONTENT_DATA constant
        const seedData = [
            { id: 'AB_Limits', title: 'Unit 1: Limits and Continuity', description: 'Limits and Continuity', sub_topics: [] },
            { id: 'AB_Derivatives', title: 'Unit 2: Differentiation: Definition and Fundamental Properties', description: 'Differentiation Definition', sub_topics: [] },
            { id: 'AB_Composite', title: 'Unit 3: Differentiation: Composite, Implicit, and Inverse Functions', description: 'Composite Functions', sub_topics: [] },
            { id: 'AB_Applications', title: 'Unit 4: Contextual Applications of Differentiation', description: 'Contextual Applications', sub_topics: [] },
            { id: 'AB_Analytical', title: 'Unit 5: Analytical Applications of Differentiation', description: 'Analytical Applications', sub_topics: [] },
            { id: 'AB_Integration', title: 'Unit 6: Integration and Accumulation of Change', description: 'Integration and Accumulation of Change', sub_topics: [] },
            { id: 'AB_DiffEq', title: 'Unit 7: Differential Equations', description: 'Differential Equations', sub_topics: [] },
            { id: 'AB_AppIntegration', title: 'Unit 8: Applications of Integration', description: 'Applications of Integration', sub_topics: [] },
            { id: 'BC_Limits', title: 'Unit 1: Limits and Continuity', description: 'Limits and Continuity', sub_topics: [] },
            { id: 'BC_Derivatives', title: 'Unit 2: Differentiation: Definition and Fundamental Properties', description: 'Differentiation Definition', sub_topics: [] },
            { id: 'BC_Composite', title: 'Unit 3: Differentiation: Composite, Implicit, and Inverse Functions', description: 'Composite Functions', sub_topics: [] },
            { id: 'BC_Applications', title: 'Unit 4: Contextual Applications of Differentiation', description: 'Contextual Applications', sub_topics: [] },
            { id: 'BC_Analytical', title: 'Unit 5: Analytical Applications of Differentiation', description: 'Analytical Applications', sub_topics: [] },
            { id: 'BC_Integration', title: 'Unit 6: Integration and Accumulation of Change', description: 'Integration and Accumulation of Change', sub_topics: [] },
            { id: 'BC_DiffEq', title: 'Unit 7: Differential Equations', description: 'Differential Equations', sub_topics: [] },
            { id: 'BC_AppIntegration', title: 'Unit 8: Applications of Integration', description: 'Applications of Integration', sub_topics: [] },
            { id: 'BC_Unit9', title: 'Unit 9: Parametric Equations, Polar Coordinates, and Vector-Valued Functions', description: 'Parametric/Polar/Vector', sub_topics: [] },
            { id: 'BC_Series', title: 'Unit 10: Infinite Sequences and Series', description: 'Infinite Series', sub_topics: [] },
        ];

        const { error } = await supabaseAdmin.from('topic_content').insert(seedData);

        if (error) {
            res.status(400).json({ error: error.message });
            return;
        }

        res.json({ message: 'Seed complete', count: seedData.length });
    } catch (error) {
        console.error('Seed error:', error);
        res.status(500).json({ error: 'Failed to seed content' });
    }
});

export default router;
