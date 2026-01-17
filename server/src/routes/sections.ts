import express, { Request, Response } from 'express';
import { supabaseAdmin } from '../config/supabase';
import { authMiddleware, optionalAuthMiddleware } from '../middleware/auth';

const router = express.Router();

// GET /api/sections?topicId=X - Get all sections for a topic
router.get('/', optionalAuthMiddleware, async (req: Request, res: Response): Promise<void> => {
    try {
        const { topicId } = req.query;

        let query = supabaseAdmin
            .from('sections')
            .select('*')
            .order('sort_order', { ascending: true });

        if (topicId) {
            query = query.eq('topic_id', topicId);
        }

        const { data, error } = await query;

        if (error) {
            res.status(400).json({ error: error.message });
            return;
        }

        res.json(data || []);
    } catch (error) {
        console.error('Get sections error:', error);
        res.status(500).json({ error: 'Failed to get sections' });
    }
});

// GET /api/sections/:topicId/:sectionId - Get single section
router.get('/:topicId/:sectionId', optionalAuthMiddleware, async (req: Request, res: Response): Promise<void> => {
    try {
        const { topicId, sectionId } = req.params;

        const { data, error } = await supabaseAdmin
            .from('sections')
            .select('*')
            .eq('topic_id', topicId)
            .eq('id', sectionId)
            .single();

        if (error) {
            res.status(404).json({ error: 'Section not found' });
            return;
        }

        res.json(data);
    } catch (error) {
        console.error('Get section error:', error);
        res.status(500).json({ error: 'Failed to get section' });
    }
});

// PUT /api/sections/:topicId/:sectionId - Update section
router.put('/:topicId/:sectionId', authMiddleware, async (req: Request, res: Response): Promise<void> => {
    try {
        const userId = req.user!.id;
        const { topicId, sectionId } = req.params;
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

        // Remove fields that shouldn't be updated
        delete updateData.id;
        delete updateData.topic_id;
        delete updateData.created_at;

        // Add updated_at timestamp
        updateData.updated_at = new Date().toISOString();

        const { data, error } = await supabaseAdmin
            .from('sections')
            .update(updateData)
            .eq('topic_id', topicId)
            .eq('id', sectionId)
            .select()
            .single();

        if (error) {
            console.error('Update section error:', error);
            res.status(400).json({ error: error.message });
            return;
        }

        console.log(`✅ Section ${topicId}/${sectionId} updated`);
        res.json(data);
    } catch (error) {
        console.error('Update section error:', error);
        res.status(500).json({ error: 'Failed to update section' });
    }
});

// POST /api/sections - Create new section (optional, for custom sections)
router.post('/', authMiddleware, async (req: Request, res: Response): Promise<void> => {
    try {
        const userId = req.user!.id;
        const sectionData = req.body;

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

        // Validate required fields
        if (!sectionData.id || !sectionData.topic_id || !sectionData.title) {
            res.status(400).json({ error: 'id, topic_id, and title are required' });
            return;
        }

        const { data, error } = await supabaseAdmin
            .from('sections')
            .insert(sectionData)
            .select()
            .single();

        if (error) {
            console.error('Create section error:', error);
            res.status(400).json({ error: error.message });
            return;
        }

        console.log(`✅ Section ${sectionData.topic_id}/${sectionData.id} created`);
        res.status(201).json(data);
    } catch (error) {
        console.error('Create section error:', error);
        res.status(500).json({ error: 'Failed to create section' });
    }
});

export default router;
