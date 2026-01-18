import { Router, Request, Response } from 'express';
import { supabaseAdmin } from '../config/supabase';
import { authMiddleware } from '../middleware/auth';
import multer from 'multer';

const router = Router();

// Configure multer for memory storage
const upload = multer({
    storage: multer.memoryStorage(),
    limits: {
        fileSize: 5 * 1024 * 1024, // 5MB limit
    },
    fileFilter: (_req, file, cb) => {
        if (file.mimetype.startsWith('image/')) {
            cb(null, true);
        } else {
            cb(new Error('Only images are allowed'));
        }
    }
});

// POST /api/upload/image - Upload image to Supabase Storage
router.post('/image', authMiddleware, upload.single('image'), async (req: Request, res: Response): Promise<void> => {
    try {
        const userId = req.user!.id;
        const file = req.file;

        if (!file) {
            res.status(400).json({ error: 'No image file provided' });
            return;
        }

        // Generate unique filename
        const ext = file.originalname.split('.').pop() || 'png';
        const filename = `questions/${userId}/${Date.now()}_${Math.random().toString(36).substring(7)}.${ext}`;

        // Upload to Supabase Storage
        const { data, error } = await supabaseAdmin.storage
            .from('images')
            .upload(filename, file.buffer, {
                contentType: file.mimetype,
                upsert: false
            });

        if (error) {
            console.error('Supabase upload error:', error);
            res.status(500).json({ error: error.message });
            return;
        }

        // Get public URL
        const { data: urlData } = supabaseAdmin.storage
            .from('images')
            .getPublicUrl(filename);

        console.log(`✅ Image uploaded: ${filename}`);
        res.json({
            url: urlData.publicUrl,
            path: data.path
        });
    } catch (error) {
        console.error('Upload error:', error);
        res.status(500).json({ error: 'Failed to upload image' });
    }
});

// DELETE /api/upload/image - Delete image from storage
router.delete('/image', authMiddleware, async (req: Request, res: Response): Promise<void> => {
    try {
        const { path } = req.body;

        if (!path) {
            res.status(400).json({ error: 'Image path required' });
            return;
        }

        const { error } = await supabaseAdmin.storage
            .from('images')
            .remove([path]);

        if (error) {
            res.status(500).json({ error: error.message });
            return;
        }

        res.json({ success: true });
    } catch (error) {
        console.error('Delete error:', error);
        res.status(500).json({ error: 'Failed to delete image' });
    }
});

export default router;
