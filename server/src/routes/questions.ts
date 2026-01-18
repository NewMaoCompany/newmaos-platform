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
            .select(`
                *,
                question_skills(skill_id, role, weight),
                question_error_patterns(error_tag_id)
            `)
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
        const transformed = (data || []).map((q: any) => {
            const skills = q.question_skills || [];
            const primary = skills.find((s: any) => s.role === 'primary');
            const supporting = skills.filter((s: any) => s.role === 'supporting').map((s: any) => s.skill_id);
            const errorPatterns = (q.question_error_patterns || []).map((e: any) => e.error_tag_id);

            return {
                id: q.id,
                title: q.title || `Question ${q.id.substr(0, 8)}`, // Fallback for old questions
                course: q.course,
                topic: q.topic,
                subTopicId: q.sub_topic_id,
                sectionId: q.section_id,
                type: q.type,
                calculatorAllowed: q.calculator_allowed,
                difficulty: q.difficulty,
                targetTimeSeconds: q.target_time_seconds,

                skillTags: q.skill_tags || [],
                errorTags: q.error_tags || [],
                primarySkillId: primary?.skill_id,
                supportingSkillIds: supporting,
                errorPatternIds: errorPatterns.length > 0 ? errorPatterns : (q.error_tags || []),

                prompt: q.prompt,
                promptType: q.prompt_type || (q.prompt && (q.prompt.startsWith('http') || q.prompt.startsWith('data:')) ? 'image' : 'text'),
                latex: q.latex,
                options: q.options || [],
                correctOptionId: q.correct_option_id,
                tolerance: q.tolerance,
                explanation: q.explanation,
                microExplanations: q.micro_explanations,
                recommendationReasons: q.recommendation_reasons,

                // New Metadata
                status: q.status,
                version: q.version,
                source: q.source,
                sourceYear: q.source_year,
                notes: q.notes,
                weightPrimary: q.weight_primary,
                weightSupporting: q.weight_supporting
            };
        });

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

        // DEV MODE: Allow any authenticated user to create questions
        // In production, uncomment the is_creator check below
        const { data: profile } = await supabaseAdmin
            .from('user_profiles')
            .select('is_creator')
            .eq('id', userId)
            .single();

        // Temporarily disabled for development - any logged-in user can create questions
        // if (!profile?.is_creator) {
        //     res.status(403).json({ error: 'Creator access required' });
        //     return;
        // }
        console.log(`📝 User ${userId} creating question (is_creator: ${profile?.is_creator})`);

        const {
            course, topic, topicId, subTopicId, title, type, calculatorAllowed, difficulty,
            targetTimeSeconds, skillTags, errorTags, prompt, promptType, latex, options,
            correctOptionId, tolerance, explanation, microExplanations, recommendationReasons,
            primarySkillId, supportingSkillIds = [],
            source, sourceYear, notes, status, weightPrimary, weightSupporting, errorPatternIds = []
        } = req.body;

        // Validation
        if (!title) {
            res.status(400).json({ error: 'Title is required' });
            return;
        }
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

        // 1. Insert question
        const { data: question, error: questionError } = await supabaseAdmin
            .from('questions')
            .insert({
                course,
                topic,
                topic_id: topicId,
                sub_topic_id: subTopicId,
                section_id: subTopicId,
                title,
                type,
                calculator_allowed: calculatorAllowed,
                difficulty,
                target_time_seconds: targetTimeSeconds,
                skill_tags: skillTags,  // Cache field
                error_tags: errorTags,  // Cache field
                prompt,
                prompt_type: promptType || 'text',
                latex,
                options: processedOptions,
                correct_option_id: finalCorrectId,
                tolerance,
                explanation,
                micro_explanations: microExplanations,
                recommendation_reasons: recommendationReasons,
                created_by: userId,
                status: status || 'draft',
                version: 1,
                source: source || 'self',
                source_year: sourceYear,
                notes: notes,
                weight_primary: weightPrimary || 1.0,
                weight_supporting: weightSupporting || 0.5
            })
            .select()
            .single();

        if (questionError) {
            res.status(400).json({ error: questionError.message });
            return;
        }

        // 2. Insert question_skills (transactional-like)
        const skillRows = [
            { question_id: question.id, skill_id: primarySkillId, role: 'primary', weight: weightPrimary || 1.0 }
        ];

        supportingSkillIds.forEach((skillId: string) => {
            skillRows.push({
                question_id: question.id,
                skill_id: skillId,
                role: 'supporting',
                weight: weightSupporting || 0.5
            });
        });

        await supabaseAdmin.from('question_skills').insert(skillRows);

        // 3. Insert question_error_patterns
        if (errorPatternIds && errorPatternIds.length > 0) {
            const errorRows = errorPatternIds.map((tagId: string) => ({
                question_id: question.id,
                error_tag_id: tagId
            }));
            await supabaseAdmin.from('question_error_patterns').insert(errorRows);
        }

        // 4. Create initial version snapshot
        await supabaseAdmin.from('question_versions').insert({
            question_id: question.id,
            version: 1,
            data: question,
            created_by: userId
        });

        res.status(201).json({ ...question, primarySkillId, supportingSkillIds, errorPatternIds });
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

        // DEV MODE: Allow any authenticated user to update questions
        const { data: profile } = await supabaseAdmin
            .from('user_profiles')
            .select('is_creator')
            .eq('id', userId)
            .single();

        // Temporarily disabled for development
        // if (!profile?.is_creator) {
        //     res.status(403).json({ error: 'Creator access required' });
        //     return;
        // }
        console.log(`📝 User ${userId} updating question ${id} (is_creator: ${profile?.is_creator})`);

        const {
            course, topic, topicId, subTopicId, title, type, calculatorAllowed, difficulty,
            targetTimeSeconds, skillTags, errorTags, prompt, promptType, latex, options,
            correctOptionId, tolerance, explanation, microExplanations, recommendationReasons,
            primarySkillId, supportingSkillIds,
            source, sourceYear, notes, status, weightPrimary, weightSupporting, errorPatternIds
        } = req.body;

        // Get current version
        const { data: currentQ } = await supabaseAdmin
            .from('questions')
            .select('version')
            .eq('id', id)
            .single();

        const newVersion = (currentQ?.version || 0) + 1;

        const updates: Record<string, any> = {
            updated_at: new Date().toISOString(),
            version: newVersion
        };

        if (course !== undefined) updates.course = course;
        if (topic !== undefined) updates.topic = topic;
        if (topicId !== undefined) updates.topic_id = topicId;
        if (title !== undefined) updates.title = title;
        if (subTopicId !== undefined) {
            updates.sub_topic_id = subTopicId;
            updates.section_id = subTopicId;
        }
        if (type !== undefined) updates.type = type;
        if (calculatorAllowed !== undefined) updates.calculator_allowed = calculatorAllowed;
        if (difficulty !== undefined) updates.difficulty = difficulty;
        if (targetTimeSeconds !== undefined) updates.target_time_seconds = targetTimeSeconds;
        if (skillTags !== undefined) updates.skill_tags = skillTags;
        if (errorTags !== undefined) updates.error_tags = errorTags;
        if (prompt !== undefined) updates.prompt = prompt;
        if (promptType !== undefined) updates.prompt_type = promptType;
        if (latex !== undefined) updates.latex = latex;
        if (options !== undefined) updates.options = options;
        if (correctOptionId !== undefined) updates.correct_option_id = correctOptionId;
        if (tolerance !== undefined) updates.tolerance = tolerance;
        if (explanation !== undefined) updates.explanation = explanation;
        if (microExplanations !== undefined) updates.micro_explanations = microExplanations;
        if (recommendationReasons !== undefined) updates.recommendation_reasons = recommendationReasons;

        // New fields
        if (source !== undefined) updates.source = source;
        if (sourceYear !== undefined) updates.source_year = sourceYear;
        if (notes !== undefined) updates.notes = notes;
        if (status !== undefined) updates.status = status;
        if (weightPrimary !== undefined) updates.weight_primary = weightPrimary;
        if (weightSupporting !== undefined) updates.weight_supporting = weightSupporting;

        // 1. Update question
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

        // 2. Update skills (delete and recreate)
        if (primarySkillId !== undefined || supportingSkillIds !== undefined) {
            await supabaseAdmin.from('question_skills').delete().eq('question_id', id);

            // We need to ensure we have values if only one was passed (unlikely but safe)
            // Ideally frontend sends both if updating skills.
            // For now assume passed if changing structure.
            if (primarySkillId) {
                const skillRows = [
                    { question_id: id, skill_id: primarySkillId, role: 'primary', weight: weightPrimary || 1.0 }
                ];
                if (supportingSkillIds && supportingSkillIds.length > 0) {
                    supportingSkillIds.forEach((sid: string) => {
                        skillRows.push({ question_id: id, skill_id: sid, role: 'supporting', weight: weightSupporting || 0.5 });
                    });
                }
                await supabaseAdmin.from('question_skills').insert(skillRows);
            }
        }

        // 3. Update error patterns
        if (errorPatternIds !== undefined) {
            await supabaseAdmin.from('question_error_patterns').delete().eq('question_id', id);
            if (errorPatternIds.length > 0) {
                const errorRows = errorPatternIds.map((tagId: string) => ({
                    question_id: id,
                    error_tag_id: tagId
                }));
                await supabaseAdmin.from('question_error_patterns').insert(errorRows);
            }
        }

        // 4. Create version snapshot
        await supabaseAdmin.from('question_versions').insert({
            question_id: id,
            version: newVersion,
            data: data,
            created_by: userId
        });

        res.json({ ...data, primarySkillId, supportingSkillIds, errorPatternIds });
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

        // DEV MODE: Allow any authenticated user to delete questions
        const { data: profile } = await supabaseAdmin
            .from('user_profiles')
            .select('is_creator')
            .eq('id', userId)
            .single();

        // Temporarily disabled for development
        // if (!profile?.is_creator) {
        //     res.status(403).json({ error: 'Creator access required' });
        //     return;
        // }
        console.log(`🗑️ User ${userId} deleting question ${id} (is_creator: ${profile?.is_creator})`);

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
