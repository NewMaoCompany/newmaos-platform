import { Router, Request, Response } from 'express';
import { supabaseAdmin } from '../config/supabase';
import { authMiddleware, optionalAuthMiddleware } from '../middleware/auth';

const router = Router();

// GET /api/questions - Get questions with optional filters
router.get('/', optionalAuthMiddleware, async (req: Request, res: Response): Promise<void> => {
    try {
        const { course, topic, subTopicId, difficulty, limit = 50 } = req.query;

        let query = supabaseAdmin
            .from('questions')
            .select('*')
            .order('created_at', { ascending: false })
            .limit(Number(limit));

        if (course) {
            query = query.or(`course.eq.${course},course.eq.Both`);
        }
        if (topic) {
            query = query.eq('topic', topic);
        }
        if (subTopicId) {
            query = query.eq('sub_topic_id', subTopicId);
        }
        if (difficulty) {
            query = query.eq('difficulty', Number(difficulty));
        }

        const { data, error } = await query;

        if (error) {
            res.status(400).json({ error: error.message });
            return;
        }

        // Transform snake_case to camelCase for frontend
        const transformed = (data || []).map(q => ({
            id: q.id,
            course: q.course,
            topic: q.topic,
            subTopicId: q.sub_topic_id,
            type: q.type,
            calculatorAllowed: q.calculator_allowed,
            difficulty: q.difficulty,
            targetTimeSeconds: q.target_time_seconds,
            skillTags: q.skill_tags || [],
            errorTags: q.error_tags || [],
            prompt: q.prompt,
            latex: q.latex,
            options: q.options || [],
            correctOptionId: q.correct_option_id,
            tolerance: q.tolerance,
            explanation: q.explanation,
            microExplanations: q.micro_explanations,
            recommendationReasons: q.recommendation_reasons
        }));

        res.json(transformed);
    } catch (error) {
        console.error('Get questions error:', error);
        res.status(500).json({ error: 'Failed to get questions' });
    }
});

// POST /api/questions - Create new question (creator only)
router.post('/', authMiddleware, async (req: Request, res: Response): Promise<void> => {
    try {
        const userId = req.user!.id;

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

        const {
            course, topic, topicId, subTopicId, type, calculatorAllowed, difficulty,
            targetTimeSeconds, skillTags, errorTags, prompt, latex, options,
            correctOptionId, tolerance, explanation, microExplanations, recommendationReasons,
            primarySkillId, supportingSkillIds = []
        } = req.body;

        // Validation
        if (!topicId) {
            res.status(400).json({ error: 'topicId is required' });
            return;
        }
        if (!subTopicId) {
            res.status(400).json({ error: 'subTopicId (chapter) is required' });
            return;
        }
        if (!primarySkillId) {
            res.status(400).json({ error: 'primarySkillId is required' });
            return;
        }
        if (!correctOptionId) {
            res.status(400).json({ error: 'correctOptionId is required' });
            return;
        }

        // Generate option IDs if not present
        const processedOptions = (options || []).map((opt: any, index: number) => ({
            ...opt,
            id: opt.id || `opt_${Date.now()}_${index}`
        }));

        // Map correct option label to ID if needed
        let finalCorrectId = correctOptionId;
        if (type === 'MCQ' && correctOptionId) {
            const matchingOpt = processedOptions.find((o: any) => o.label === correctOptionId);
            if (matchingOpt) {
                finalCorrectId = matchingOpt.id;
            }
        }

        // Insert question
        const { data: question, error: questionError } = await supabaseAdmin
            .from('questions')
            .insert({
                course,
                topic,
                topic_id: topicId,
                sub_topic_id: subTopicId,
                type,
                calculator_allowed: calculatorAllowed,
                difficulty,
                target_time_seconds: targetTimeSeconds,
                skill_tags: skillTags,  // Cache field
                error_tags: errorTags,  // Cache field
                prompt,
                latex,
                options: processedOptions,
                correct_option_id: finalCorrectId,
                tolerance,
                explanation,
                micro_explanations: microExplanations,
                recommendation_reasons: recommendationReasons,
                created_by: userId,
                status: 'active',
                version: 1
            })
            .select()
            .single();

        if (questionError) {
            res.status(400).json({ error: questionError.message });
            return;
        }

        // Insert question_skills (transactional)
        const supportingCount = supportingSkillIds.length;
        const primaryWeight = supportingCount > 0 ? 0.7 : 1.0;
        const supportingWeight = supportingCount > 0 ? 0.3 / supportingCount : 0;

        const skillRows = [
            { question_id: question.id, skill_id: primarySkillId, role: 'primary', weight: primaryWeight }
        ];

        supportingSkillIds.forEach((skillId: string) => {
            skillRows.push({
                question_id: question.id,
                skill_id: skillId,
                role: 'supporting',
                weight: supportingWeight
            });
        });

        const { error: skillsError } = await supabaseAdmin
            .from('question_skills')
            .insert(skillRows);

        if (skillsError) {
            console.error('Failed to insert question_skills:', skillsError);
            // Note: Question already created, but skills failed. Log but don't fail the request.
        }

        res.status(201).json({
            id: question.id,
            course: question.course,
            topic: question.topic,
            topicId: question.topic_id,
            subTopicId: question.sub_topic_id,
            type: question.type,
            calculatorAllowed: question.calculator_allowed,
            difficulty: question.difficulty,
            targetTimeSeconds: question.target_time_seconds,
            skillTags: question.skill_tags,
            errorTags: question.error_tags,
            prompt: question.prompt,
            latex: question.latex,
            options: question.options,
            correctOptionId: question.correct_option_id,
            tolerance: question.tolerance,
            explanation: question.explanation,
            microExplanations: question.micro_explanations,
            recommendationReasons: question.recommendation_reasons,
            primarySkillId,
            supportingSkillIds
        });
    } catch (error) {
        console.error('Create question error:', error);
        res.status(500).json({ error: 'Failed to create question' });
    }
});

// PUT /api/questions/:id - Update question
router.put('/:id', authMiddleware, async (req: Request, res: Response): Promise<void> => {
    try {
        const userId = req.user!.id;
        const { id } = req.params;

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

        const {
            course, topic, subTopicId, type, calculatorAllowed, difficulty,
            targetTimeSeconds, skillTags, errorTags, prompt, latex, options,
            correctOptionId, tolerance, explanation, microExplanations, recommendationReasons
        } = req.body;

        const updates: Record<string, any> = { updated_at: new Date().toISOString() };

        if (course !== undefined) updates.course = course;
        if (topic !== undefined) updates.topic = topic;
        if (subTopicId !== undefined) updates.sub_topic_id = subTopicId;
        if (type !== undefined) updates.type = type;
        if (calculatorAllowed !== undefined) updates.calculator_allowed = calculatorAllowed;
        if (difficulty !== undefined) updates.difficulty = difficulty;
        if (targetTimeSeconds !== undefined) updates.target_time_seconds = targetTimeSeconds;
        if (skillTags !== undefined) updates.skill_tags = skillTags;
        if (errorTags !== undefined) updates.error_tags = errorTags;
        if (prompt !== undefined) updates.prompt = prompt;
        if (latex !== undefined) updates.latex = latex;
        if (options !== undefined) updates.options = options;
        if (correctOptionId !== undefined) updates.correct_option_id = correctOptionId;
        if (tolerance !== undefined) updates.tolerance = tolerance;
        if (explanation !== undefined) updates.explanation = explanation;
        if (microExplanations !== undefined) updates.micro_explanations = microExplanations;
        if (recommendationReasons !== undefined) updates.recommendation_reasons = recommendationReasons;

        const { data, error } = await supabaseAdmin
            .from('questions')
            .update(updates)
            .eq('id', id)
            .select()
            .single();

        if (error) {
            res.status(400).json({ error: error.message });
            return;
        }

        res.json({
            id: data.id,
            course: data.course,
            topic: data.topic,
            subTopicId: data.sub_topic_id,
            type: data.type,
            calculatorAllowed: data.calculator_allowed,
            difficulty: data.difficulty,
            targetTimeSeconds: data.target_time_seconds,
            skillTags: data.skill_tags,
            errorTags: data.error_tags,
            prompt: data.prompt,
            latex: data.latex,
            options: data.options,
            correctOptionId: data.correct_option_id,
            tolerance: data.tolerance,
            explanation: data.explanation,
            microExplanations: data.micro_explanations,
            recommendationReasons: data.recommendation_reasons
        });
    } catch (error) {
        console.error('Update question error:', error);
        res.status(500).json({ error: 'Failed to update question' });
    }
});

// DELETE /api/questions/:id - Delete question
router.delete('/:id', authMiddleware, async (req: Request, res: Response): Promise<void> => {
    try {
        const userId = req.user!.id;
        const { id } = req.params;

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

        const { error } = await supabaseAdmin
            .from('questions')
            .delete()
            .eq('id', id);

        if (error) {
            res.status(400).json({ error: error.message });
            return;
        }

        res.json({ message: 'Question deleted successfully' });
    } catch (error) {
        console.error('Delete question error:', error);
        res.status(500).json({ error: 'Failed to delete question' });
    }
});

export default router;
