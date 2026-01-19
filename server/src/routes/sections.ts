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

// PUT /api/sections/:topicId/:sectionId - Update or create section (upsert)
router.put('/:topicId/:sectionId', authMiddleware, async (req: Request, res: Response): Promise<void> => {
    console.log('📝 Section update request received');
    console.log('📝 topicId:', req.params.topicId, 'sectionId:', req.params.sectionId);
    console.log('📝 body:', JSON.stringify(req.body));
    console.log('📝 user:', req.user);

    try {
        const userId = req.user!.id;
        const userEmail = req.user!.email;
        const { topicId, sectionId } = req.params;
        const updateData = req.body;

        console.log('📝 Checking if user is creator...');

        // Check if user is creator (allow super admin bypass)
        const SUPER_ADMIN_EMAIL = 'newmao6120@gmail.com';
        const isSuperAdmin = userEmail === SUPER_ADMIN_EMAIL;

        // Only check is_creator in DB if not super admin
        let isCreator = isSuperAdmin;
        if (!isSuperAdmin) {
            const { data: profile } = await supabaseAdmin
                .from('user_profiles')
                .select('is_creator')
                .eq('id', userId)
                .single();
            isCreator = profile?.is_creator || false;
        }

        console.log('📝 isCreator:', isCreator, 'isSuperAdmin:', isSuperAdmin);

        if (!isCreator && !isSuperAdmin) {
            res.status(403).json({ error: 'Creator access required' });
            return;
        }

        // Prepare data
        const sectionData = {
            id: sectionId,
            topic_id: topicId,
            title: updateData.title || `Section ${sectionId}`,
            description: updateData.description || '',
            description2: updateData.description2 || null,
            estimated_minutes: updateData.estimated_minutes || 15,
            has_lesson: updateData.has_lesson !== false,
            has_practice: updateData.has_practice !== false,
            sort_order: updateData.sort_order || 0,
            updated_at: new Date().toISOString()
        };

        // First, try to check if section exists
        const { data: existing } = await supabaseAdmin
            .from('sections')
            .select('id')
            .eq('topic_id', topicId)
            .eq('id', sectionId)
            .single();

        let data, error;

        if (existing) {
            // Update existing section
            const result = await supabaseAdmin
                .from('sections')
                .update({
                    title: sectionData.title,
                    description: sectionData.description,
                    description2: sectionData.description2,
                    estimated_minutes: sectionData.estimated_minutes,
                    has_lesson: sectionData.has_lesson,
                    has_practice: sectionData.has_practice,
                    updated_at: sectionData.updated_at
                })
                .eq('topic_id', topicId)
                .eq('id', sectionId)
                .select()
                .single();
            data = result.data;
            error = result.error;
        } else {
            // Insert new section
            const result = await supabaseAdmin
                .from('sections')
                .insert(sectionData)
                .select()
                .single();
            data = result.data;
            error = result.error;
        }

        if (error) {
            console.error('Section save error:', error);
            res.status(400).json({ error: error.message });
            return;
        }

        console.log(`✅ Section ${topicId}/${sectionId} saved`);
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
