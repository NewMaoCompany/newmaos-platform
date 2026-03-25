import { Router, Request, Response } from 'express';
import { supabaseAdmin } from '../config/supabase';
import { authMiddleware } from '../middleware/auth';

const router = Router();

// Helper: Check if wrong_answer_dismissals table exists, silent fallback
let tableExists: boolean | null = null;

async function checkTableExists(): Promise<boolean> {
    if (tableExists !== null) return tableExists;
    try {
        const { error } = await supabaseAdmin
            .from('wrong_answer_dismissals')
            .select('id')
            .limit(0);

        // Code 42P01 = table doesn't exist
        tableExists = !error || error.code !== '42P01';
        if (!tableExists) {
            console.warn('[WrongAnswers] wrong_answer_dismissals table not found. Dismissals will not work until the table is created.');
        }
        return tableExists;
    } catch {
        tableExists = false;
        return false;
    }
}

// GET /api/wrong-answers - Get all wrong answers for the current user
router.get('/', authMiddleware, async (req: Request, res: Response): Promise<void> => {
    try {
        const userId = req.user!.id;

        // Get ALL question attempts by this user to determine current state
        const { data: allAttempts, error: attemptsError } = await supabaseAdmin
            .from('question_attempts')
            .select('question_id, is_correct, created_at, selected_option_id, time_spent_seconds')
            .eq('user_id', userId)
            .order('created_at', { ascending: false });

        if (attemptsError) {
            console.error('Error fetching question attempts:', attemptsError);
            res.status(500).json({ error: 'Failed to fetch wrong answers' });
            return;
        }

        // Get dismissals (graceful if table doesn't exist)
        let dismissedIds: Set<string> = new Set();
        const hasTable = await checkTableExists();
        if (hasTable) {
            try {
                const { data: dismissals, error: dismissError } = await supabaseAdmin
                    .from('wrong_answer_dismissals')
                    .select('question_id')
                    .eq('user_id', userId);

                if (!dismissError && dismissals) {
                    dismissedIds = new Set(dismissals.map((d: any) => d.question_id));
                }
            } catch {
                // Ignore dismissal errors
            }
        }

        // Process attempts to keep only questions where the LATEST attempt is wrong
        const uniqueQuestionIds = new Set<string>();
        const wrongAnswerMap: Record<string, any> = {};
        const seenQuestionIds = new Set<string>();

        for (const attempt of (allAttempts || [])) {
            const qid = attempt.question_id;
            if (dismissedIds.has(qid)) continue;

            if (!seenQuestionIds.has(qid)) {
                seenQuestionIds.add(qid);
                // This is the FIRST TIME we see this question ID (so it's the LATEST attempt)
                if (attempt.is_correct === false) {
                    uniqueQuestionIds.add(qid);
                    wrongAnswerMap[qid] = {
                        questionId: qid,
                        wrongCount: 1,
                        lastWrongAt: attempt.created_at,
                        firstWrongAt: attempt.created_at,
                        lastSelectedOptionId: attempt.selected_option_id,
                    };
                }
            } else {
                // We've seen a newer attempt for this question.
                // If the newer attempt was wrong, it is in uniqueQuestionIds.
                // We can update the start time and wrong count from older wrong attempts.
                if (uniqueQuestionIds.has(qid) && attempt.is_correct === false) {
                    wrongAnswerMap[qid].wrongCount++;
                    // Since attempts are ordered by created_at DESC, the older it is, the further back we go
                    wrongAnswerMap[qid].firstWrongAt = attempt.created_at;
                }
            }
        }

        // Fetch question details for all wrong questions
        const questionIds = Array.from(uniqueQuestionIds);

        if (questionIds.length === 0) {
            res.json({ wrongAnswers: [], total: 0 });
            return;
        }

        const { data: questionDetails, error: qError } = await supabaseAdmin
            .from('questions')
            .select('id, title, topic, sub_topic_id, type, difficulty, prompt, prompt_type, options, correct_option_id, explanation, calculator_allowed, latex')
            .in('id', questionIds);

        if (qError) {
            console.error('Error fetching question details:', qError);
        }

        // Build question details map
        const detailsMap: Record<string, any> = {};
        (questionDetails || []).forEach((q: any) => {
            detailsMap[q.id] = q;
        });

        // Build final response
        const wrongAnswers = questionIds
            .map(qid => ({
                ...wrongAnswerMap[qid],
                question: detailsMap[qid] || null
            }))
            .filter(w => w.question !== null)
            .sort((a, b) => new Date(b.lastWrongAt).getTime() - new Date(a.lastWrongAt).getTime());

        res.json({ wrongAnswers, total: wrongAnswers.length });

    } catch (error) {
        console.error('Get wrong answers error:', error);
        res.status(500).json({ error: 'Failed to fetch wrong answers' });
    }
});

// POST /api/wrong-answers/dismiss - Dismiss a wrong answer
router.post('/dismiss', authMiddleware, async (req: Request, res: Response): Promise<void> => {
    try {
        const userId = req.user!.id;
        const { questionId } = req.body;

        if (!questionId) {
            res.status(400).json({ error: 'questionId is required' });
            return;
        }

        const hasTable = await checkTableExists();
        if (!hasTable) {
            res.status(503).json({ error: 'Dismissal feature not yet available. Table needs to be created.' });
            return;
        }

        const { error } = await supabaseAdmin
            .from('wrong_answer_dismissals')
            .upsert({
                user_id: userId,
                question_id: questionId,
                dismissed_at: new Date().toISOString()
            }, { onConflict: 'user_id,question_id' });

        if (error) {
            console.error('Dismiss wrong answer error:', error);
            res.status(500).json({ error: 'Failed to dismiss wrong answer' });
            return;
        }

        res.json({ success: true, questionId });

    } catch (error) {
        console.error('Dismiss wrong answer error:', error);
        res.status(500).json({ error: 'Failed to dismiss wrong answer' });
    }
});

// POST /api/wrong-answers/restore - Restore a dismissed wrong answer
router.post('/restore', authMiddleware, async (req: Request, res: Response): Promise<void> => {
    try {
        const userId = req.user!.id;
        const { questionId } = req.body;

        if (!questionId) {
            res.status(400).json({ error: 'questionId is required' });
            return;
        }

        const hasTable = await checkTableExists();
        if (!hasTable) {
            res.status(503).json({ error: 'Restore feature not yet available.' });
            return;
        }

        const { error } = await supabaseAdmin
            .from('wrong_answer_dismissals')
            .delete()
            .eq('user_id', userId)
            .eq('question_id', questionId);

        if (error) {
            console.error('Restore wrong answer error:', error);
            res.status(500).json({ error: 'Failed to restore wrong answer' });
            return;
        }

        res.json({ success: true, questionId });

    } catch (error) {
        console.error('Restore wrong answer error:', error);
        res.status(500).json({ error: 'Failed to restore wrong answer' });
    }
});

export default router;
