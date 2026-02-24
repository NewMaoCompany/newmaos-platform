import { Router, Request, Response } from 'express';
import { createClient } from '@supabase/supabase-js';
import { supabaseUrl, supabaseAnonKey, supabaseAdmin } from '../config/supabase';
import { authMiddleware, optionalAuthMiddleware } from '../middleware/auth';

const router = Router();

// Helper to get authenticated client
const getAuthenticatedClient = (req: Request) => {
    const authHeader = req.headers.authorization;
    if (authHeader) {
        return createClient(supabaseUrl!, supabaseAnonKey!, {
            global: { headers: { Authorization: authHeader } }
        });
    }
    // Fallback if no auth (e.g. public access), though RLS might restrict it
    return createClient(supabaseUrl!, supabaseAnonKey!);
};

// GET /api/questions - Get questions with optional filters
router.get('/', optionalAuthMiddleware, async (req: Request, res: Response): Promise<void> => {
    try {
        const { course, topic, subTopicId, difficulty, limit = 10000 } = req.query;

        // Use Admin client to bypass RLS issues on production
        // and manually enforce security logic below.
        const supabase = supabaseAdmin;

        let query = supabase
            .from('questions')
            .select(`
                id, title, status, course, topic, topic_id, sub_topic_id, section_id,
                type, calculator_allowed, difficulty, target_time_seconds,
                skill_tags, error_tags, primary_skill_id, supporting_skill_ids,
                prompt, prompt_type, latex, options, correct_option_id, tolerance,
                explanation, micro_explanations, recommendation_reasons,
                version, source, source_year, notes, weight_primary, weight_supporting,
                question_skills(skill_id, role, weight),
                question_error_patterns(error_tag_id)
            `)
            .order('created_at', { ascending: true })
            .limit(Number(limit));

        if (course) {
            query = query.or(`course.eq.${course},course.eq.Both`);
        }
        if (subTopicId) {
            query = query.eq('sub_topic_id', subTopicId);
        }

        if (topic) {
            // Check for cross-course shared topic
            // Enhanced Logic for Unified ABBC Content
            const topicStr = String(topic);
            const isAb = topicStr.startsWith('AB_');
            const isBc = topicStr.startsWith('BC_');
            const isUnified = topicStr.startsWith('ABBC_');

            if (isUnified) {
                // If requesting ABBC_Limits, we want limits from AB OR BC OR ABBC
                const base = topicStr.substring(5); // Remove ABBC_ prefix
                // Search for: ABBC_Limits OR AB_Limits OR BC_Limits
                // This covers all bases: new content (if labeled ABBC), and old content (AB/BC tags)
                query = query.or(`topic.eq.${topicStr},topic.eq.AB_${base},topic.eq.BC_${base}`);
            } else if (isAb || isBc) {
                // Legacy: If explicitly asking for AB_Limits, try to find counterpart too if it's shared
                // (Though simpler to just let frontend ask for ABBC now)
                const base = topicStr.substring(3);
                const counterpart = isAb ? `BC_${base}` : `AB_${base}`;
                const unified = `ABBC_${base}`;

                // Search: requested, counterpart (if shared), or Unified ID
                query = query.or(`topic.eq.${topicStr},and(topic.eq.${counterpart},course.eq.Both),topic.eq.${unified}`);
            } else {
                query = query.eq('topic', topic);
            }
        }
        if (difficulty) {
            query = query.eq('difficulty', Number(difficulty));
        }

        // --- Manual Security Logic ---
        // 1. If user is NOT authenticated, or NOT a creator, only show 'published' questions.
        // 2. Creators and Super Admin see everything (drafts + published).
        const userId = req.user?.id;
        const userEmail = req.user?.email;
        const SUPER_ADMIN_EMAIL = 'newmao6120@gmail.com';
        const isSuperAdmin = userEmail === SUPER_ADMIN_EMAIL;

        let shouldFilterDrafts = true;

        if (userId) {
            if (isSuperAdmin) {
                shouldFilterDrafts = false;
            } else {
                const { data: profile } = await supabaseAdmin
                    .from('user_profiles')
                    .select('is_creator')
                    .eq('id', userId)
                    .single();
                if (profile?.is_creator) {
                    shouldFilterDrafts = false;
                }
            }
        }

        if (shouldFilterDrafts) {
            query = query.eq('status', 'published');
        }

        const { data, error } = await query;

        if (error) {
            res.status(400).json({ error: error.message });
            return;
        }

        // Transform snake_case to camelCase for frontend
        // Transform snake_case to camelCase for frontend while preserving ALL original columns
        const transformed = (data || []).map((q: any) => {
            const skills = q.question_skills || [];
            const primary = skills.find((s: any) => s.role === 'primary');
            const supporting = skills.filter((s: any) => s.role === 'supporting').map((s: any) => s.skill_id);
            const errorPatterns = (q.question_error_patterns || []).map((e: any) => e.error_tag_id);

            // Construct result by spreading the original object to ensure no data (like title, status) is lost
            return {
                ...q,
                // Add camelCase aliases that the frontend expects
                topicId: q.topic_id || q.topic,
                subTopicId: q.sub_topic_id || q.section_id,
                sectionId: q.section_id || q.sub_topic_id,
                correctOptionId: q.correct_option_id,
                calculatorAllowed: q.calculator_allowed,
                targetTimeSeconds: q.target_time_seconds,

                skillTags: q.skill_tags || [],
                errorTags: q.error_tags || [],

                primarySkillId: q.primary_skill_id || primary?.skill_id,
                supportingSkillIds: (q.supporting_skill_ids && q.supporting_skill_ids.length > 0) ? q.supporting_skill_ids : supporting,
                errorPatternIds: errorPatterns.length > 0 ? errorPatterns : (q.error_tags || []),

                promptType: q.prompt_type || (q.prompt && (String(q.prompt).startsWith('http') || String(q.prompt).startsWith('data:')) ? 'image' : 'text'),
                // explanationType: q.explanation_type || (q.explanation && (String(q.explanation).startsWith('http') || String(q.explanation).startsWith('data:')) ? 'image' : 'text'),

                microExplanations: q.micro_explanations,
                recommendationReasons: q.recommendation_reasons,
                sourceYear: q.source_year,
                weightPrimary: q.weight_primary,
                weightSupporting: q.weight_supporting,

                // Explicitly ensure title and status are mapped if spread didn't work for some reason
                title: q.title,
                status: q.status
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
        const supabase = supabaseAdmin;

        // Check creator status using AUTHENTICATED client (RLS safe)
        const { data: profile } = await supabase
            .from('user_profiles')
            .select('is_creator')
            .eq('id', userId)
            .single();

        if (!profile?.is_creator) {
            res.status(403).json({ error: 'Creator access required' });
            return;
        }
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

        // 1. Insert question using Admin client
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
                weight_supporting: weightSupporting || 0.5,
                // DUAL WRITE: Write to new columns
                primary_skill_id: primarySkillId,
                supporting_skill_ids: supportingSkillIds || []
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
            snapshot: question
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
        const supabase = supabaseAdmin;

        // DEV MODE: Allow any authenticated user to update questions
        const { data: profile } = await supabase
            .from('user_profiles')
            .select('is_creator')
            .eq('id', userId)
            .single();

        if (!profile?.is_creator) {
            res.status(403).json({ error: 'Creator access required' });
            return;
        }
        console.log(`📝 User ${userId} updating question ${id} (is_creator: ${profile?.is_creator})`);

        const {
            course, topic, topicId, subTopicId, title, type, calculatorAllowed, difficulty,
            targetTimeSeconds, skillTags, errorTags, prompt, promptType, latex, options,
            correctOptionId, tolerance, explanation, microExplanations, recommendationReasons,
            primarySkillId, supportingSkillIds,
            source, sourceYear, notes, status, weightPrimary, weightSupporting, errorPatternIds
        } = req.body;

        // Get current version
        const { data: currentQ } = await supabase
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
        // Process options and map correct ID (same as POST)
        let processedOptions = options;
        if (options) {
            processedOptions = options.map((opt: any, index: number) => ({
                ...opt,
                id: opt.id || `opt_${Date.now()}_${index}`
            }));
            updates.options = processedOptions;
        }

        if (correctOptionId !== undefined) {
            let finalCorrectId = correctOptionId;
            // If correctOptionId is a label (A/B/C/D) and we have options, find the matching ID
            // If options were not updated in this request, we might need to fetch current ones, 
            // but typically frontend sends both. For now, assuming if correctOptionId changes, options usually come with it or exist.
            // If options IS passed, user processedOptions.
            if (type === 'MCQ' && processedOptions) {
                const matchingOpt = processedOptions.find((o: any) => o.label === correctOptionId);
                if (matchingOpt) {
                    finalCorrectId = matchingOpt.id;
                }
            }
            updates.correct_option_id = finalCorrectId;
        }
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

        // DUAL WRITE: Update new columns
        if (primarySkillId !== undefined) updates.primary_skill_id = primarySkillId;
        if (supportingSkillIds !== undefined) updates.supporting_skill_ids = supportingSkillIds;

        // 1. Update question
        const { data, error } = await supabase
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
            await supabase.from('question_skills').delete().eq('question_id', id);

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
                await supabase.from('question_skills').insert(skillRows);
            }
        }

        // 3. Update error patterns
        if (errorPatternIds !== undefined) {
            await supabase.from('question_error_patterns').delete().eq('question_id', id);
            if (errorPatternIds.length > 0) {
                const errorRows = errorPatternIds.map((tagId: string) => ({
                    question_id: id,
                    error_tag_id: tagId
                }));
                await supabase.from('question_error_patterns').insert(errorRows);
            }
        }

        // 4. Create version snapshot
        await supabase.from('question_versions').insert({
            question_id: id,
            version: newVersion,
            snapshot: data
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
        const supabase = supabaseAdmin;

        // DEV MODE: Allow any authenticated user to delete questions
        const { data: profile } = await supabase
            .from('user_profiles')
            .select('is_creator')
            .eq('id', userId)
            .single();

        if (!profile?.is_creator) {
            res.status(403).json({ error: 'Creator access required' });
            return;
        }
        console.log(`🗑️ User ${userId} deleting question ${id} (is_creator: ${profile?.is_creator})`);

        const { error } = await supabase
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
