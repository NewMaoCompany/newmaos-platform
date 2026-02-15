import { Router, Request, Response } from 'express';
import { supabaseAdmin } from '../config/supabase';
import { authMiddleware } from '../middleware/auth';

const router = Router();

// POST /api/practice/complete - Record a completed practice session
router.post('/complete', authMiddleware, async (req: Request, res: Response): Promise<void> => {
    try {
        const userId = req.user!.id;
        const { correct, total, topic } = req.body;

        if (correct === undefined || total === undefined || !topic) {
            res.status(400).json({ error: 'correct, total, and topic are required' });
            return;
        }

        // 1. Update user stats
        const { data: profile } = await supabaseAdmin
            .from('user_profiles')
            .select('*')
            .eq('id', userId)
            .single();

        if (profile) {
            const newSolved = (profile.problems_solved || 0) + total;
            const todayIndex = new Date().getDay();
            const studyHours = profile.study_hours || [0, 0, 0, 0, 0, 0, 0];
            studyHours[todayIndex] = parseFloat((studyHours[todayIndex] + 0.2).toFixed(1));

            const performanceFactor = correct / total;
            const newPercentile = profile.percentile === 0
                ? 50
                : Math.max(1, profile.percentile - (performanceFactor > 0.5 ? 1 : 0));

            await supabaseAdmin
                .from('user_profiles')
                .update({
                    problems_solved: newSolved,
                    study_hours: studyHours,
                    percentile: newPercentile,
                    updated_at: new Date().toISOString()
                })
                .eq('id', userId);
        }

        // 2. Add activity record
        const cleanTopic = topic.includes('_') ? topic.split('_')[1] : topic;
        await supabaseAdmin.from('activities').insert({
            user_id: userId,
            type: 'practice',
            title: `Practice: ${cleanTopic}`,
            description: `Solved ${correct}/${total} problems correctly.`,
            score: Math.round((correct / total) * 100)
        });

        // 3. Update topic mastery
        const accuracy = correct / total;
        let gain = 0;
        if (accuracy === 1) gain = 15;
        else if (accuracy >= 0.8) gain = 10;
        else if (accuracy >= 0.5) gain = 5;

        const { data: existingMastery } = await supabaseAdmin
            .from('unit_mastery')
            .select('*')
            .eq('user_id', userId)
            .eq('subject', cleanTopic)
            .single();

        if (existingMastery) {
            const newScore = Math.min(100, (existingMastery.mastery_score || 0) + gain);
            await supabaseAdmin
                .from('unit_mastery')
                .update({ mastery_score: newScore, updated_at: new Date().toISOString() })
                .eq('id', existingMastery.id);
        } else {
            await supabaseAdmin.from('unit_mastery').insert({
                user_id: userId,
                subject: cleanTopic,
                mastery_score: gain,
                full_mark: 100
            });
        }

        // 4. Update course progress status
        if (profile?.current_course) {
            await supabaseAdmin
                .from('course_progress')
                .update({ status: 'In Progress', updated_at: new Date().toISOString() })
                .eq('user_id', userId)
                .eq('course_id', profile.current_course);
        }

        res.json({
            message: 'Practice session recorded',
            stats: {
                correct,
                total,
                accuracy: Math.round((correct / total) * 100),
                masteryGain: gain
            }
        });
    } catch (error) {
        console.error('Complete practice error:', error);
        res.status(500).json({ error: 'Failed to record practice session' });
    }
});

// GET /api/practice/recommendation - Get AI-powered recommendation
router.get('/recommendation', authMiddleware, async (req: Request, res: Response): Promise<void> => {
    try {
        const userId = req.user!.id;

        // Get user profile and mastery data
        const { data: profile } = await supabaseAdmin
            .from('user_profiles')
            .select('*')
            .eq('id', userId)
            .single();

        const { data: mastery } = await supabaseAdmin
            .from('unit_mastery')
            .select('*')
            .eq('user_id', userId)
            .order('mastery_score', { ascending: true });

        // Find the topic with lowest mastery
        const weakestTopic = mastery && mastery.length > 0
            ? mastery[0]
            : { subject: 'Limits', mastery_score: 0 };

        const isNewUser = (profile?.problems_solved || 0) === 0;
        const currentCourse = profile?.current_course || 'AB';

        let recommendation;
        if (isNewUser) {
            recommendation = {
                topic: 'Limits',
                reason: 'Start your AP Calculus journey with the fundamentals.',
                currentMastery: 0,
                targetMastery: 80,
                mode: 'Adaptive'
            };
        } else {
            recommendation = {
                topic: weakestTopic.subject,
                reason: `This topic has lower mastery (${weakestTopic.mastery_score}%). Focus here to improve.`,
                currentMastery: weakestTopic.mastery_score || 0,
                targetMastery: 85,
                mode: 'Adaptive'
            };
        }

        res.json(recommendation);
    } catch (error) {
        console.error('Get recommendation error:', error);
        res.status(500).json({ error: 'Failed to get recommendation' });
    }
});

export default router;
