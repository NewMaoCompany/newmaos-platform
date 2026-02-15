import { Router, Request, Response } from 'express';
import { supabaseAdmin } from '../config/supabase';
import { authMiddleware } from '../middleware/auth';

const router = Router();

// GET /api/progress/mastery - Get user's topic mastery (radar data)
router.get('/mastery', authMiddleware, async (req: Request, res: Response): Promise<void> => {
    try {
        const userId = req.user!.id;

        const { data, error } = await supabaseAdmin
            .from('unit_mastery')
            .select('*')
            .eq('user_id', userId);

        if (error) {
            res.status(400).json({ error: error.message });
            return;
        }

        // Transform to radar data format
        const radarData = (data || []).map((item: { subject: string; mastery_score: number; full_mark: number }) => ({
            subject: item.subject,
            A: item.mastery_score || 0,
            fullMark: item.full_mark || 100
        }));

        res.json(radarData);
    } catch (error) {
        console.error('Get mastery error:', error);
        res.status(500).json({ error: 'Failed to get mastery data' });
    }
});

// GET /api/progress/activities - Get user's activity history
router.get('/activities', authMiddleware, async (req: Request, res: Response): Promise<void> => {
    try {
        const userId = req.user!.id;
        const { limit = 20 } = req.query;

        const { data, error } = await supabaseAdmin
            .from('activities')
            .select('*')
            .eq('user_id', userId)
            .order('created_at', { ascending: false })
            .limit(Number(limit));

        if (error) {
            res.status(400).json({ error: error.message });
            return;
        }

        // Transform to frontend format
        const activities = (data || []).map((item: { id: number; type: string; title: string; description: string; created_at: string; score: number }) => ({
            id: item.id,
            type: item.type,
            title: item.title,
            description: item.description,
            timestamp: getRelativeTime(new Date(item.created_at)),
            score: item.score
        }));

        res.json(activities);
    } catch (error) {
        console.error('Get activities error:', error);
        res.status(500).json({ error: 'Failed to get activities' });
    }
});

// GET /api/progress/line-data - Get performance trend data
router.get('/line-data', authMiddleware, async (req: Request, res: Response): Promise<void> => {
    try {
        const userId = req.user!.id;

        // Get activities from last 7 days
        const sevenDaysAgo = new Date();
        sevenDaysAgo.setDate(sevenDaysAgo.getDate() - 6);

        const { data } = await supabaseAdmin
            .from('activities')
            .select('score, created_at')
            .eq('user_id', userId)
            .eq('type', 'practice')
            .gte('created_at', sevenDaysAgo.toISOString())
            .order('created_at', { ascending: true });

        // Build line chart data
        const lineData: { day: string; value: number }[] = [];
        for (let i = 6; i >= 0; i--) {
            const date = new Date();
            date.setDate(date.getDate() - i);
            const dayStr = i === 0 ? 'Today' : `Day ${7 - i}`;

            // Calculate average score for this day
            const dayActivities = (data || []).filter((a: { score?: number; created_at: string }) => {
                const actDate = new Date(a.created_at);
                return actDate.toDateString() === date.toDateString();
            });

            let avgScore: number;
            if (dayActivities.length > 0) {
                avgScore = Math.round(dayActivities.reduce((sum: number, a: { score?: number }) => sum + (a.score || 0), 0) / dayActivities.length);
            } else {
                avgScore = lineData.length > 0 ? lineData[lineData.length - 1].value : 0;
            }

            lineData.push({ day: dayStr, value: avgScore });
        }

        res.json(lineData);
    } catch (error) {
        console.error('Get line data error:', error);
        res.status(500).json({ error: 'Failed to get trend data' });
    }
});

// GET /api/progress/courses - Get course progress data
router.get('/courses', authMiddleware, async (req: Request, res: Response): Promise<void> => {
    try {
        const userId = req.user!.id;

        const { data, error } = await supabaseAdmin
            .from('course_progress')
            .select('*')
            .eq('user_id', userId);

        if (error) {
            res.status(400).json({ error: error.message });
            return;
        }

        // Transform to courses format
        const courses: Record<string, any> = {};
        (data || []).forEach((item: { course_id: string; status: string; current_module_index: number; modules: any[] }) => {
            courses[item.course_id] = {
                id: item.course_id,
                title: item.course_id === 'AB' ? 'AP Calculus AB' : 'AP Calculus BC',
                status: item.status,
                currentModuleIndex: item.current_module_index,
                modules: item.modules || []
            };
        });

        res.json(courses);
    } catch (error) {
        console.error('Get courses error:', error);
        res.status(500).json({ error: 'Failed to get course progress' });
    }
});

// Helper function to get relative time
function getRelativeTime(date: Date): string {
    const now = new Date();
    const diffMs = now.getTime() - date.getTime();
    const diffMins = Math.floor(diffMs / 60000);
    const diffHours = Math.floor(diffMs / 3600000);
    const diffDays = Math.floor(diffMs / 86400000);

    if (diffMins < 1) return 'Just now';
    if (diffMins < 60) return `${diffMins}m ago`;
    if (diffHours < 24) return `${diffHours}h ago`;
    if (diffDays < 7) return `${diffDays}d ago`;
    return date.toLocaleDateString();
}

export default router;
