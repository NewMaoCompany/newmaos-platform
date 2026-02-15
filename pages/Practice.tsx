import React, { useState, useEffect, useRef, useMemo } from 'react';
import { useApp } from '../AppContext';
import { useNavigate, useLocation } from 'react-router-dom';
import { COURSE_CONTENT_DATA } from '../constants';
import { SessionMode, Question } from '../types';
import { Navbar } from '../components/Navbar';
import { AdvancedCalculator } from '../components/AdvancedCalculator';
import { SessionSummary } from '../components/SessionSummary';
import { useToast } from '../components/Toast';
import { MathRenderer } from '../components/MathRenderer';
import { questionsApi, practiceApi, contentApi, sectionsApi } from '../src/services/api';
import { supabase } from '../src/services/supabaseClient';
import { QuestionCommentSection } from '../components/QuestionCommentSection';

// Markdown-ish renderer for the lesson content
// Markdown-ish renderer for the lesson content
// Markdown-ish renderer for the lesson content
// MathRenderer handles Markdown and LaTeX now
// Replaced ContentRenderer with direct usage or wrapper if needed
const LessonRenderer = ({ content }: { content: string }) => {
    return (
        <div className="space-y-4 text-text-main dark:text-gray-200 font-sans [&_*]:font-sans [&_p]:font-sans [&_li]:font-sans">
            <MathRenderer content={content} className="text-lg leading-relaxed font-medium" />
        </div>
    )
}

// Helper function to convert numbers to ordinals (Second, Third, Fourth, etc.)
const getOrdinal = (n: number): string => {
    if (n === 1) return 'First';
    if (n === 2) return 'Second';
    if (n === 3) return 'Third';
    if (n === 4) return 'Fourth';
    if (n === 5) return 'Fifth';
    return `${n}th`;
};








export const Practice = () => {
    const { user, completePractice, questions: allQuestions, topicContent, submitAttempt, getTopicProgress, saveSectionProgress, completeSectionSession, getSectionProgress, sections, incorrectQuestionIds, resetSectionProgress, getSectionProgressData, fetchAllUserProgress, logUserActivity, getUserActivities } = useApp();
    const navigate = useNavigate();
    const { showToast } = useToast();
    const location = useLocation();

    // Session Recovery Logic (Safe Mode)
    const effectiveState = useMemo(() => {
        if (location.state) return location.state;

        // Only attempt recovery if state is missing (e.g. refresh)
        if (typeof sessionStorage !== 'undefined') {
            try {
                const saved = sessionStorage.getItem('last_practice_session');
                return saved ? JSON.parse(saved) : null;
            } catch (e) {
                return null;
            }
        }
        return null;
    }, [location.state]);

    const topicParamRaw = effectiveState?.topic || 'General';
    // Case-insensitive match to find valid DB topic ID
    const topicParam = useMemo(() => {
        const keys = Object.keys(COURSE_CONTENT_DATA);
        return keys.find(k => k.toLowerCase() === topicParamRaw.toLowerCase()) || topicParamRaw;
    }, [topicParamRaw]);

    const subTopicId = effectiveState?.subTopicId;
    const sessionMode: SessionMode = effectiveState?.mode || 'Adaptive';

    // Derived Clean Topic - available to all functions in component
    const cleanTopic = topicParam.includes('_') ? topicParam.split('_')[1] : topicParam;

    // If subTopicId exists AND it is NOT 'unit_test', we start in 'Lesson' view, otherwise 'Practice'
    // Exception: If mode is 'Review', Resuming, or Force Start, skip lesson
    const [viewState, setViewState] = useState<'lesson' | 'practice'>(
        sessionMode === 'Review' || effectiveState?.isResuming === true || effectiveState?.forceStartNew === true || !subTopicId
            ? 'practice'
            : 'lesson'
    );

    // Track session start time for accurate duration logging
    const sessionStartTimeRef = useRef<number>(Date.now());

    // Reset start time when valid questions are loaded or practice starts
    useEffect(() => {
        if (viewState === 'practice') {
            sessionStartTimeRef.current = Date.now();
        }
    }, [viewState]);

    // UNIQUE ID LOGIC: Prefix unit_test with topic to avoid collisions across units
    // Ensure we use the case-corrected topicParam
    const effectiveSectionId = subTopicId === 'unit_test' ? `${topicParam}_unit_test` : subTopicId;


    // -------------------------------------------------------------------------
    // REFACTOR: Derive Static Data Synchronously to prevent content mismatch flicker
    // -------------------------------------------------------------------------
    const currentStaticData = useMemo(() => {
        if (topicParam && COURSE_CONTENT_DATA[topicParam]) {
            return COURSE_CONTENT_DATA[topicParam].subTopics.find(s => s.id === subTopicId) || null;
        }
        return null;
    }, [topicParam, subTopicId]);

    // Derived Forum Slug for "Discuss" button
    const discussSlug = useMemo(() => {
        const coursePrefix = (user?.currentCourse || 'AB').toLowerCase();
        return `ap-calculus-${coursePrefix}`;
    }, [user?.currentCourse]);

    // Only store DB overrides in state, not the full data
    const [dbSubTopicData, setDbSubTopicData] = useState<any>(null);

    // NEW: Frozen snapshot of incorrect question IDs for Review mode
    // This prevents questions from disappearing when user answers correctly during review
    const [frozenReviewQuestionIds, setFrozenReviewQuestionIds] = useState<Set<string>>(new Set());

    // UI States
    const [showComments, setShowComments] = useState(false);

    // Merge Static + DB Data (DB wins if ID matches)
    const subTopicData = useMemo(() => {
        if (dbSubTopicData && (dbSubTopicData.id === subTopicId || dbSubTopicData.id === effectiveSectionId)) {
            return { ...currentStaticData, ...dbSubTopicData };
        }
        return currentStaticData;
    }, [currentStaticData, dbSubTopicData, subTopicId, effectiveSectionId]);

    // Robust numbering fix for Practice Hub & Header
    const correctedSubTopicTitle = useMemo(() => {
        if (!subTopicData || !subTopicData.title || subTopicId === 'unit_test') return subTopicData?.title || (subTopicId === 'unit_test' ? 'Unit Test' : '');

        const allSubTopics = COURSE_CONTENT_DATA[topicParam]?.subTopics || [];

        const BC_ONLY_IDS = [
            '6.11', '6.12', '6.13',
            '7.5', '7.9',
            '8.13',
            '9.1', '9.2', '9.3', '9.4', '9.5', '9.6', '9.7', '9.8', '9.9',
            '10.1', '10.2', '10.3', '10.4', '10.5', '10.6', '10.7', '10.8', '10.9', '10.10', '10.11', '10.12', '10.13', '10.14', '10.15'
        ];

        const filtered = allSubTopics.filter(s => {
            if (s.id === 'unit_test' || s.id === 'overview') return false;
            if (user.currentCourse === 'AB' && BC_ONLY_IDS.includes(s.id)) return false;
            if (!s.courseScope || s.courseScope === 'both') return true;
            if (user.currentCourse === 'AB') return s.courseScope !== 'bc_only';
            if (user.currentCourse === 'BC') return s.courseScope !== 'ab_only';
            return true;
        });

        const index = filtered.findIndex(s => s.id === subTopicId);
        if (index === -1) return subTopicData.title;

        const cleanTitle = subTopicData.title.replace(/^\d+\.\d+\s*/, '');
        const unitPrefix = subTopicData.title.match(/^\d+/)?.[0] || '';
        return unitPrefix ? `${unitPrefix}.${index + 1} ${cleanTitle}` : subTopicData.title;
    }, [subTopicData, topicParam, subTopicId, user.currentCourse]);

    // AUTO-SKIP LESSON: DISABLED - User wants to see intro page always
    /*
    useEffect(() => {
        if (subTopicData && subTopicData.hasLesson === false && viewState === 'lesson') {
            // Only skip if we haven't already made a choice (e.g. implicitly)
            // But if user WANTS to see intro, we might keep it? 
            // For now, respect the "Has Lesson" flag. If false, go strictly to practice.
            setViewState('practice');
        }
    }, [subTopicData, viewState]);
    */

    // RENDER-PHASE RESET: Force state reset immediately when subTopicId changes
    // This runs BEFORE paint, preventing any frame of stale content
    const [prevSubTopicId, setPrevSubTopicId] = useState(subTopicId);
    if (subTopicId !== prevSubTopicId) {
        setPrevSubTopicId(subTopicId);
        setDbSubTopicData(null); // Reset async data immediately
        // Note: We don't return null; we let it render with static data (which is correct)
    }

    // Check for previous progress or saved session

    // Check for previous progress or saved session
    useEffect(() => {
        const checkProgress = async () => {
            try {
                if (effectiveSectionId && topicParam) {
                    // 1. Check for Saved Session (In Progress OR Completed)
                    const savedSession = await getSectionProgress(effectiveSectionId);

                    // --- NEW: Load History from Main Section (for Review Mode access) or Current ---
                    const mainId = subTopicId.endsWith('_review') ? subTopicId.replace('_review', '') : subTopicId;

                    // Helper function to rebuild history from old data structure
                    const rebuildHistoryFromData = (data: any): any[] => {
                        if (data?.summaryHistory?.length > 0) {
                            return data.summaryHistory;
                        }

                        // Backward compatibility: rebuild from firstAttempt if exists
                        const history: any[] = [];
                        const fa = data?.firstAttempt;
                        if (fa?.status === 'completed') {
                            const faResults = fa.questionResults || data.questionResults || {};
                            const faCorrect = Object.values(faResults).filter((r: any) => r === 'correct').length;
                            const faTotal = fa.questionIds?.length || Object.keys(faResults).length || 5;
                            history.push({
                                type: 'first_attempt',
                                attemptNumber: 1,
                                label: 'First Attempt',
                                timestamp: fa.completedAt || data.timestamp || new Date().toISOString(),
                                score: faTotal > 0 ? Math.round((faCorrect / faTotal) * 100) : 0,
                                userAnswers: fa.userAnswers || data.userAnswers || {},
                                questionResults: faResults
                            });
                        }
                        return history;
                    };

                    if (mainId !== effectiveSectionId) {
                        // We are in Review/Unit Test with suffix? Fetch Main for History
                        getSectionProgress(mainId).then(mainP => {
                            if (mainP?.data) setSessionHistory(rebuildHistoryFromData(mainP.data));
                        });
                    } else if (savedSession?.data) {
                        setSessionHistory(rebuildHistoryFromData(savedSession.data));
                    }

                    // --- NEW: Handle Summary Mode (View Last Results) ---
                    if (sessionMode === 'Summary' && savedSession) {
                        if (savedSession.data) {
                            setUserAnswers(savedSession.data.userAnswers || {});
                            setQuestionResults(savedSession.data.questionResults || {});
                            setSessionResults({
                                correct: savedSession.correct_questions || 0,
                                total: savedSession.total_questions || (savedSession.data.questions?.length || 0)
                            });
                            // Ensure history is set from rebuilt data
                            const rebuiltHistory = rebuildHistoryFromData(savedSession.data);
                            console.log('🔍 [Summary Mode] rebuiltHistory:', rebuiltHistory.map(h => ({ type: h.type, label: h.label, round: h.round })));
                            setSessionHistory(rebuiltHistory);
                        }
                        setShowSummary(true);
                        setViewState('practice');
                        setIsInitializing(false);
                        return;
                    }

                    // Allow resume if there are answers OR we are past the first question
                    // === NEW STATE MACHINE RESTORATION ===
                    const data = savedSession?.data;
                    const firstAttempt = data?.firstAttempt;
                    const review = data?.review;

                    // Check for progress using new structure (with legacy fallback)
                    const hasFirstAttemptProgress = firstAttempt?.status === 'in_progress' || (
                        !firstAttempt && (
                            Object.keys(data?.userAnswers || {}).length > 0 ||
                            (data?.currentQuestionIndex || 0) > 0
                        )
                    );

                    // Restore marked questions if they exist
                    if (data?.markedQuestionIds) {
                        setMarkedQuestions(new Set(data.markedQuestionIds));
                    }

                    const hasReviewProgress = review?.status === 'in_progress';

                    if (sessionMode === 'Review') {
                        // --- REVIEW MODE ---
                        if (hasReviewProgress && effectiveState?.isResuming) {
                            // Resume existing review
                            setUserAnswers(review.userAnswers || {});
                            setQuestionResults(review.questionResults || {});
                            setCurrentQuestionIndex(review.currentQuestionIndex || 0);
                            // Accuracy Fix: Count correct answers ONLY within this review round
                            const reviewCorrect = Object.values(review.questionResults || {}).filter(r => r === 'correct').length;
                            setSessionResults({
                                correct: reviewCorrect,
                                total: review.targetQuestionIds?.length || questions.length || 0
                            });
                            // NEW: Ensure isSubmitted is synced immediately for the resumed review question
                            const reviewTargetIds = review.targetQuestionIds || [];
                            const resumeIdx = review.currentQuestionIndex || 0;
                            const currentQId = reviewTargetIds[resumeIdx];
                            const reviewResults = review.questionResults || {};
                            if (currentQId && (reviewResults[currentQId] === 'correct' || reviewResults[currentQId] === 'incorrect')) {
                                setIsSubmitted(true);
                                setFeedback(reviewResults[currentQId]);
                            } else {
                                setIsSubmitted(false);
                                setFeedback(null);
                            }

                            // Use saved target question IDs as frozen set
                            if (review.targetQuestionIds?.length > 0) {
                                setFrozenReviewQuestionIds(new Set(review.targetQuestionIds));
                            }
                            setShowResumePrompt(false);
                            setIsInitializing(false);
                            return;
                        } else {
                            // --- FRESH REVIEW ---
                            setUserAnswers({});
                            setQuestionResults({});
                            setMarkedQuestions(new Set());
                            setCurrentQuestionIndex(0);
                            setShowSummary(false);

                            // Use currentIncorrectIds from saved data, or fall back to global incorrectQuestionIds
                            const targetIds = data?.currentIncorrectIds?.length > 0
                                ? new Set(data.currentIncorrectIds as string[])
                                : incorrectQuestionIds;
                            setFrozenReviewQuestionIds(targetIds);
                            // Continue to init logic below
                        }
                    }

                    // --- NORMAL/ADAPTIVE RESTORATION (Explicit Resume) ---
                    if (hasFirstAttemptProgress && effectiveState?.isResuming) {
                        // Directly apply data and SKIP pending state to avoid any prompts
                        // Use new structure if available, fallback to legacy
                        const resumeAnswers = firstAttempt?.userAnswers || data?.userAnswers || {};
                        const resumeResults = firstAttempt?.questionResults || data?.questionResults || {};
                        const resumeIndex = firstAttempt?.currentQuestionIndex ?? data?.currentQuestionIndex ?? 0;

                        setUserAnswers(resumeAnswers);
                        setCurrentQuestionIndex(resumeIndex);
                        setQuestionResults(resumeResults);

                        // NEW: Ensure isSubmitted is synced immediately for the resumed question
                        const currentQuestionId = firstAttempt?.questionIds?.[resumeIndex] || data?.questionIds?.[resumeIndex];
                        if (currentQuestionId && (resumeResults[currentQuestionId] === 'correct' || resumeResults[currentQuestionId] === 'incorrect')) {
                            setIsSubmitted(true);
                            setFeedback(resumeResults[currentQuestionId]);
                        } else {
                            setIsSubmitted(false);
                            setFeedback(null);
                        }

                        setShowResumePrompt(false);
                        setIsInitializing(false);
                        return;
                    }

                    // If we have progress but we are NOT resuming (e.g. Start Over or Review mode), 
                    // we show the data in pending but don't return, allowing a new session to init if needed
                    if (hasFirstAttemptProgress) {
                        setPendingResumeData(savedSession.data);
                        // Special Case: In Review mode or Start Over, we ignore the old session's answers
                        if ((sessionMode as SessionMode) === 'Review' || effectiveState?.forceStartNew) {
                            // Continue to init new session logic
                            // CRITICAL: Clear locally frozen IDs so we don't carry over old questions
                            if (effectiveState?.forceStartNew) {
                                console.log('🔄 [checkProgress] Force Start New: Clearing frozen IDs');
                                setFrozenReviewQuestionIds(new Set());
                                setMarkedQuestions(new Set());
                            }
                        } else {
                            setIsInitializing(false); // Fix: Ensure loading state is cleared
                            return; // Show prompt (since isResuming is false)
                        }
                    }

                    // 2. Initialize new session if NOT resuming
                    // Refined Logic warning: if hasFirstAttemptProgress is true, we returned above.
                    if (effectiveState?.forceStartNew && effectiveSectionId && sessionMode !== 'Review') {
                        await resetSectionProgress(effectiveSectionId);
                    }

                    // 3. If NO session exists or we just reset, initialize as 'in_progress' immediately
                    // But don't do this for 'Summary' mode which should only READ.
                    // CRITICAL CHANGE: Only initialize if we are actually in PRACTICE mode (user clicked Start)
                    if (viewState === 'practice' && sessionMode !== 'Summary' && (!savedSession || effectiveState?.forceStartNew)) {
                        const initData = {
                            ...(savedSession?.data || {}),
                            userAnswers: {},
                            currentQuestionIndex: 0,
                            questionIds: savedSession?.data?.questionIds || questions.map(q => q.id)
                        };

                        // If starting fresh Review, preserve history but reset review object
                        if (sessionMode === 'Review') {
                            // Use empty set if we just cleared, otherwise use current incorrect
                            // Note: frozenReviewQuestionIds might be empty here due to async set above.
                            // We should recalculate targets here or let the useEffect handle it.
                            console.log('🔄 [checkProgress] Init Review. Frozen Size:', frozenReviewQuestionIds.size);

                            initData.review = {
                                status: 'in_progress' as const,
                                round: (savedSession?.data?.review?.round || 0) + 1,
                                targetQuestionIds: [], // Start empty, let useEffect populate from incorrect
                                userAnswers: {},
                                questionResults: {},
                                currentQuestionIndex: 0
                            };
                        }

                        await saveSectionProgress(effectiveSectionId, initData, { completed: 0, total: 0, score: 0 }, 'section', (sessionMode as SessionMode) === 'Review');

                        // Save UNIT progress (bubbling up) - Only if not Review
                        if (topicParam && (sessionMode as SessionMode) !== 'Review') {
                            await saveSectionProgress(topicParam, {}, { completed: 0, total: 0, score: 0 }, 'unit');
                        }

                        // Save COURSE progress (bubbling up)
                        if (user.currentCourse) {
                            await saveSectionProgress(user.currentCourse, {}, { completed: 0, total: 0, score: 0 }, 'course');
                        }
                    }
                }
            } catch (err) {
                console.error("Error checking progress:", err);
            } finally {
                setIsInitializing(false);
            }
        };
        // Only run when subTopicId/topicParam changes OR when viewState changes (to trigger init on start)
        checkProgress();
    }, [subTopicId, topicParam, viewState, sessionMode, location.key]);
    // State for Sidebar Tools
    const [activeTool, setActiveTool] = useState<'none' | 'calculator' | 'formula' | 'scratchpad'>('none');

    // Add calc position state
    const [calcPosition, setCalcPosition] = useState({ x: window.innerWidth / 2 - 320, y: window.innerHeight / 2 - 200 });

    // --- Scratchpad State & Logic ---
    const canvasRef = useRef<HTMLCanvasElement>(null);
    const [isDrawing, setIsDrawing] = useState(false);
    const [penColor, setPenColor] = useState('#f9d406'); // Default primary color

    // --- Calculator State ---
    const [calcDisplay, setCalcDisplay] = useState('0');

    // State for Modals
    const [showExitConfirm, setShowExitConfirm] = useState(false);
    // const [showReportModal, setShowReportModal] = useState(false); // REMOVED
    const [isSaving, setIsSaving] = useState(false);
    const [isReporting, setIsReporting] = useState(false);
    const [reportReason, setReportReason] = useState('content_error');

    // CollegeBoard Features State
    const [markedQuestions, setMarkedQuestions] = useState<Set<string>>(new Set());
    const [eliminatedOptions, setEliminatedOptions] = useState<Record<string, string[]>>({}); // qId -> [optIds]
    const [questionResults, setQuestionResults] = useState<Record<string, 'correct' | 'incorrect'>>({}); // qId -> status

    // Dual Submission Mode States
    const [submitMode, setSubmitMode] = useState<'immediate' | 'batch'>('immediate');
    const [userAnswers, setUserAnswers] = useState<Record<string, string>>({}); // qId -> selectedOptionId for batch mode
    const [showSummary, setShowSummary] = useState(false);
    const [justCompletedSessionLabel, setJustCompletedSessionLabel] = useState<string | null>(null);
    const [showSubmitConfirm, setShowSubmitConfirm] = useState(false);

    // Agent Insight: Track time spent on each question
    const questionStartTimeRef = useRef<number>(Date.now());

    // --- Resume Session Logic ---
    const [showResumePrompt, setShowResumePrompt] = useState(false);
    const [pendingResumeData, setPendingResumeData] = useState<any>(null);

    const handleConfirmResume = () => {
        if (pendingResumeData) {
            if (pendingResumeData.userAnswers) {
                setUserAnswers(pendingResumeData.userAnswers);
            }
            if (pendingResumeData.currentQuestionIndex !== undefined) {
                // Ensure index is within bounds of current question set
                const index = Math.min(pendingResumeData.currentQuestionIndex, questions.length - 1);
                setCurrentQuestionIndex(index >= 0 ? index : 0);
            }
            if (pendingResumeData.questionResults) {
                setQuestionResults(pendingResumeData.questionResults);
            }
            // User requested: "不需要右上角出现弹窗" (Remove toast)
        }
        setViewState('practice'); // Directly enter practice view as requested
        setShowResumePrompt(false);
    };

    const handleStartNewSession = () => {
        // Start fresh
        setPendingResumeData(null);
        setViewState('practice');
    };

    // Fix flicker by enforcing loading state during transition
    const handleStartPractice = () => {
        setIsInitializing(true); // Force loading spinner
        setViewState('practice');
        // useEffect [subTopicId, topicParam, viewState] will run checkProgress
        // checkProgress finally block will set isInitializing(false)
    };

    const toggleMark = (qId: string) => {
        const newSet = new Set(markedQuestions);
        if (newSet.has(qId)) newSet.delete(qId);
        else newSet.add(qId);
        setMarkedQuestions(newSet);

        // Persistent save on toggle
        const markedArray = Array.from(newSet);
        if (effectiveSectionId) {
            // MERGE with existing data to prevent wiping history/results
            getSectionProgress(effectiveSectionId).then(p => {
                const existing = p?.data || {};
                const newData = {
                    ...existing,
                    userAnswers,
                    currentQuestionIndex,
                    markedQuestionIds: markedArray
                };
                saveSectionProgress(effectiveSectionId, newData, { completed: Object.keys(userAnswers).length, total: questions.length, score: 0 });
            });
        }
    };

    const toggleEliminate = (qId: string, optId: string, e: React.MouseEvent) => {
        e.stopPropagation(); // Prevent selecting the option
        e.preventDefault();
        setEliminatedOptions(prev => {
            const current = prev[qId] || [];
            const newOpts = current.includes(optId)
                ? current.filter(id => id !== optId)
                : [...current, optId];
            return { ...prev, [qId]: newOpts };
        });
    };

    // Filter questions based on topic/course dynamically

    // Debounce empty state to prevent flash of "No Questions" during rapid transitions
    const [showEmptyState, setShowEmptyState] = useState(false);
    const [isInitializing, setIsInitializing] = useState(false);

    // Helper to determine display title
    const getTopicDisplayTitle = () => {
        // Special case for Unit Test
        if (subTopicId === 'unit_test') {
            if (COURSE_CONTENT_DATA[topicParam]) {
                return COURSE_CONTENT_DATA[topicParam].title;
            }
            return cleanTopic;
        }

        // If valid unit in content data, use its title
        if (COURSE_CONTENT_DATA[topicParam]) {
            return COURSE_CONTENT_DATA[topicParam].title;
        }
        // Fallback to clean name
        return cleanTopic;
    };

    // Local state to fetch questions if global store is missing them (e.g. API limits)
    const [localQuestions, setLocalQuestions] = useState<Question[]>([]);

    useEffect(() => {
        const fetchLocal = async () => {
            if (topicParam && (!allQuestions || allQuestions.length < 1000)) { // aggressive fetch if global seems limited
                try {
                    // Try specific subtopic first for speed
                    const qData = await questionsApi.getQuestions({
                        topic: topicParam,
                        limit: 200 // Fetch plenty for this topic
                    });
                    if (qData && qData.length > 0) {
                        setLocalQuestions(qData);
                    }
                } catch (err) {
                    console.error("Local fetch failed", err);
                }
            }
        }
        fetchLocal();
    }, [topicParam, allQuestions.length]);

    // -------------------------------------------------------------------------
    // REFACTOR: Use useMemo for synchronous filtering to eliminate render flash
    // -------------------------------------------------------------------------
    const questions = React.useMemo(() => {
        // Merge global questions with locally fetched ones, deduplicating by ID
        const combinedRaw = [...allQuestions, ...localQuestions];
        const uniqueMap = new Map();
        combinedRaw.forEach(q => uniqueMap.set(q.id, q));
        const combined = Array.from(uniqueMap.values());

        if (combined.length === 0) return [];

        let filtered = [];

        // Base Filter
        const baseQuestions = combined.filter(q => {
            // NEW: Support for Unit 10 (BC_Series) which is BC only.
            // If the user's current course is BC, they should see everything.
            // If the question is 'Both', everyone sees it.
            const isCourseMatch = user.currentCourse === 'BC' || q.course === user.currentCourse || q.course === 'Both';

            const qBase = q.topic.includes('_') ? q.topic.split('_')[1] : q.topic;
            const isTopicMatch =
                q.topic === topicParam ||
                q.topicId === topicParam || // NEW: Check unified ID field
                q.topic === cleanTopic ||
                qBase === cleanTopic ||
                // NEW: Handle cases where the database uses the full human title
                q.topic === 'Infinite Sequences and Series' && topicParam === 'BC_Series';

            // Relax status check for Unit 10/BC content to avoid "draft" items being hidden accidentally
            // or if the status field is missing.
            const isStatusValid = q.status === 'published' || !q.status || q.status === 'draft';

            return isCourseMatch && isTopicMatch && isStatusValid;
        });

        if (baseQuestions.length > 0 && combined.length > 0 && baseQuestions.length === 0) {
            console.log('⚠️ [Practice] Questions were found in combined but filtered out by base filter:', {
                count: combined.length,
                topicParam,
                cleanTopic,
                course: user.currentCourse
            });
        }

        // 1. Filter by SubTopic
        if (subTopicId) {
            if (subTopicId === 'unit_test') {
                filtered = baseQuestions.filter(q => q.subTopicId === 'unit_test' || !q.subTopicId);
            } else {
                // Robustly strip '_review' suffix to find questions for the underlying section
                const realSubTopicId = subTopicId.replace('_review', '');
                filtered = baseQuestions.filter(q => q.subTopicId === realSubTopicId);
            }
        }
        // 2. Otherwise filter by Unit Topic
        else {
            filtered = baseQuestions;
        }

        // --- APPLY MODE LOGIC ---
        // NEW: If showing summary (overlay), strictly return ALL relevant questions for the section
        // This ensures the SessionSummary component can render ANY historical attempt, even if
        // the current session was just a small subset.
        if (sessionMode === 'Summary' || showSummary) {
            return filtered;
        } else if (sessionMode === 'Random') {
            return [...filtered].sort(() => Math.random() - 0.5);
        } else if (sessionMode === 'Review') {
            // NEW STATE MACHINE: Use review.targetQuestionIds first
            const savedData = getSectionProgressData(effectiveSectionId)?.data;
            const reviewData = savedData?.review;

            // Priority 1: Use review.targetQuestionIds (new structure) if resuming
            if (!effectiveState?.forceStartNew && reviewData?.targetQuestionIds?.length > 0) {
                const orderMap = new Map(reviewData.targetQuestionIds.map((id: string, index: number) => [id, index]));
                return baseQuestions.filter(q => orderMap.has(q.id))
                    .sort((a, b) => (Number(orderMap.get(a.id)) || 0) - (Number(orderMap.get(b.id)) || 0));
            }

            // Priority 2: Use frozen snapshot (set in checkProgress or fresh start)
            if (frozenReviewQuestionIds.size > 0) {
                return filtered.filter(q => frozenReviewQuestionIds.has(q.id));
            }

            // Priority 3: Use currentIncorrectIds from saved data
            if (savedData?.currentIncorrectIds?.length > 0) {
                const incorrectSet = new Set(savedData.currentIncorrectIds);
                return filtered.filter(q => incorrectSet.has(q.id));
            }

            // Fallback: Use global incorrectQuestionIds
            return filtered.filter(q => incorrectQuestionIds.has(q.id));
        }

        return filtered;
    }, [allQuestions, localQuestions, user.currentCourse, topicParam, subTopicId, cleanTopic, sessionMode, incorrectQuestionIds, effectiveSectionId, getSectionProgressData, questionResults, frozenReviewQuestionIds]);

    const isLoadingQuestions = false; // No longer needed as useMemo is sync (cached)

    // --- Dynamic Time Calculation ---
    const dynamicEstimatedMinutes = React.useMemo(() => {
        if (questions.length === 0) return 0;
        const totalSeconds = questions.reduce((acc, q) => acc + (q.targetTimeSeconds || 120), 0);
        return Math.ceil(totalSeconds / 60);
    }, [questions]);


    // --- Separated Effect for Metadata Sync (Lesson Content) ---
    useEffect(() => {
        if (subTopicId && subTopicId !== 'unit_test' && topicParam) {
            const dbUnit = topicContent[topicParam];
            if (dbUnit) {
                const dbSubTopic = dbUnit.subTopics?.find((s: any) => s.id === subTopicId);
                if (dbSubTopic) {
                    // Validate: Use functional update to preserve description_2 if already fetched
                    setDbSubTopicData((prev: any) => {
                        if (prev && prev.id === dbSubTopic.id && prev.description_2 && !dbSubTopic.description_2) {
                            return { ...dbSubTopic, description_2: prev.description_2 };
                        }
                        return dbSubTopic;
                    });

                    // Direct fetch for description2 if missing logic (simplified for brevity as it was already handled well elsewhere)
                } else if (COURSE_CONTENT_DATA[topicParam]) {
                    // Logic handled by static derivation, no need to set state
                }
            } else if (COURSE_CONTENT_DATA[topicParam]) {
                // Logic handled by static derivation, no need to set state
            }
            // Note: The specific description2 fetcher effect handles the heavy lifting
        }
    }, [subTopicId, topicParam, topicContent]); // Removed questions dependency


    // Handle Empty State Debounce
    useEffect(() => {
        if (!isLoadingQuestions && questions.length === 0) {
            const timer = setTimeout(() => setShowEmptyState(true), 200); // 200ms grace period
            return () => clearTimeout(timer);
        } else {
            setShowEmptyState(false);
        }
    }, [questions.length, isLoadingQuestions]);

    const [currentQuestionIndex, setCurrentQuestionIndex] = useState(0);
    const [selectedAnswer, setSelectedAnswer] = useState<string | null>(null);
    const [isSubmitted, setIsSubmitted] = useState(false);
    const [feedback, setFeedback] = useState<'correct' | 'incorrect' | null>(null);
    const [sessionResults, setSessionResults] = useState({ correct: 0, total: 0 });
    const [viewingOptionId, setViewingOptionId] = useState<string | null>(null);
    const [sessionHistory, setSessionHistory] = useState<any[]>([]); // NEW: Store history of attempts

    // Fetch and sync session history when summary is shown
    useEffect(() => {
        if (showSummary && effectiveSectionId) {
            const syncHistory = async () => {
                const activities = await getUserActivities(effectiveSectionId);
                console.log('🔄 Syncing session history from DB:', activities?.length, 'activities found');
                if (activities && activities.length > 0) {
                    const mapped = activities.map((a: any, idx: number) => {
                        const isFirst = a.attempt_type === 'first_attempt';
                        // Determine attempt number from activities
                        const attemptsBeforeThis = activities.slice(0, idx).filter((x: any) => x.attempt_type === 'first_attempt').length;
                        const currentAttemptNumber = attemptsBeforeThis + 1;

                        // Count reviews for THIS specific attempt
                        const reviewsForCurrentAttempt = activities.slice(0, idx + 1).filter((x: any, i: number) => {
                            if (x.attempt_type !== 'review') return false;
                            // Find the last first_attempt before this review
                            const lastAttemptBeforeReview = activities.slice(0, i).filter((y: any) => y.attempt_type === 'first_attempt').length;
                            return lastAttemptBeforeReview === attemptsBeforeThis;
                        }).length;

                        const attemptLabel = currentAttemptNumber === 1 ? 'First Attempt' : `${getOrdinal(currentAttemptNumber)} Attempt`;

                        return {
                            type: a.attempt_type,
                            attemptNumber: currentAttemptNumber,
                            label: isFirst ? attemptLabel : `Review ${attemptLabel} #${reviewsForCurrentAttempt}`,
                            timestamp: a.created_at,
                            score: a.score || 0,
                            userAnswers: a.data?.userAnswers || {},
                            questionResults: a.data?.questionResults || {},
                            round: isFirst ? undefined : reviewsForCurrentAttempt
                        };
                    });
                    setSessionHistory(mapped.reverse()); // Show newest at top of dropdown (or bottom depending on array.map order)
                }
            };
            syncHistory();
        }
    }, [showSummary, effectiveSectionId]);

    // --- State Sync on Navigation ---
    useEffect(() => {
        const question = questions[currentQuestionIndex];
        if (!question) return;

        // Sync selected answer from stored user answers
        const savedAnswer = userAnswers[question.id];
        setSelectedAnswer(savedAnswer || null);

        // Sync submission/feedback state
        if (questionResults[question.id]) {
            setIsSubmitted(true);
            setFeedback(questionResults[question.id]);
            setViewingOptionId(savedAnswer || null);
        } else {
            setIsSubmitted(false);
            setFeedback(null);
            setViewingOptionId(null);
        }
    }, [currentQuestionIndex, questions, userAnswers, questionResults]);

    // Update viewing option when submitted
    useEffect(() => {
        if (isSubmitted && selectedAnswer) {
            setViewingOptionId(selectedAnswer);
        }
    }, [isSubmitted, selectedAnswer]);

    // --- Scratchpad Canvas Setup ---
    useEffect(() => {
        if (activeTool === 'scratchpad' && canvasRef.current) {
            const canvas = canvasRef.current;
            const ctx = canvas.getContext('2d');

            // Set canvas size to full window
            const resize = () => {
                canvas.width = window.innerWidth;
                canvas.height = window.innerHeight;
                // Restore context settings after resize
                if (ctx) {
                    ctx.strokeStyle = penColor;
                    ctx.lineWidth = 3;
                    ctx.lineCap = 'round';
                    ctx.lineJoin = 'round';
                }
            };

            resize();
            window.addEventListener('resize', resize);
            return () => window.removeEventListener('resize', resize);
        }
    }, [activeTool, penColor]);

    // Update pen color when state changes
    useEffect(() => {
        if (canvasRef.current) {
            const ctx = canvasRef.current.getContext('2d');
            if (ctx) ctx.strokeStyle = penColor;
        }
    }, [penColor]);

    // --- Dynamic Content Fetch for Lesson Mode (Aggressive Sync) ---
    useEffect(() => {
        if (viewState === 'lesson' && topicParam && subTopicId) {
            // Correct ID for unit tests
            const actualSectionId = subTopicId === 'unit_test' ? `${topicParam}_unit_test` : subTopicId;
            console.log('[Practice] Fetching lesson content:', { topicParam, subTopicId, actualSectionId });

            sectionsApi.getSection(topicParam, actualSectionId)
                .then(data => {
                    console.log('[Practice] Fetch response:', data);
                    if (data) {
                        // Force update ALL fields from DB to ensure UI is 100% in sync
                        setDbSubTopicData((prev: any) => ({
                            ...prev,
                            id: data.id || prev?.id, // STRICT: Don't fallback to subTopicId to avoid masquerading
                            title: data.title || (subTopicId === 'unit_test' ? 'Unit Test' : prev?.title) || 'Untitled',
                            description: data.description || prev?.description,
                            description_2: data.description_2 || data.chapter_detailed_description || data.description2 || data.detailed_description || null,
                            estimatedMinutes: data.estimated_minutes || prev?.estimatedMinutes,
                            hasLesson: data.has_lesson !== false,
                            hasPractice: data.has_practice !== false
                        }));
                    }
                })
                .catch(err => console.error('Failed to fetch lesson content:', err));
        }
    }, [viewState, topicParam, subTopicId]);

    const question = questions[currentQuestionIndex];
    const progress = questions.length > 0 ? ((currentQuestionIndex) / questions.length) * 100 : 0;


    const startDrawing = (e: React.MouseEvent | React.TouchEvent) => {
        setIsDrawing(true);
        draw(e);
    };

    const stopDrawing = () => {
        setIsDrawing(false);
        if (canvasRef.current) {
            const ctx = canvasRef.current.getContext('2d');
            ctx?.beginPath();
        }
    };

    const draw = (e: React.MouseEvent | React.TouchEvent) => {
        if (!isDrawing || !canvasRef.current) return;
        const canvas = canvasRef.current;
        const ctx = canvas.getContext('2d');
        if (!ctx) return;

        let clientX, clientY;
        if ('touches' in e) {
            clientX = e.touches[0].clientX;
            clientY = e.touches[0].clientY;
        } else {
            clientX = (e as React.MouseEvent).clientX;
            clientY = (e as React.MouseEvent).clientY;
        }

        ctx.lineTo(clientX, clientY);
        ctx.stroke();
        ctx.beginPath();
        ctx.moveTo(clientX, clientY);
    };

    const clearCanvas = () => {
        if (canvasRef.current) {
            const ctx = canvasRef.current.getContext('2d');
            ctx?.clearRect(0, 0, canvasRef.current.width, canvasRef.current.height);
        }
    };

    // --- Calculator Logic ---
    const handleCalcInput = (val: string) => {
        if (val === 'C') {
            setCalcDisplay('0');
        } else if (val === '=') {
            try {
                // Safe math evaluation for the demo
                const expr = calcDisplay
                    .replace(/×/g, '*')
                    .replace(/÷/g, '/')
                    .replace(/π/g, 'Math.PI')
                    .replace(/e/g, 'Math.E');

                // eslint-disable-next-line no-new-func
                const result = new Function('return ' + expr)();

                // Format result to avoid long decimals
                const formatted = String(Math.round(result * 100000000) / 100000000);
                setCalcDisplay(formatted);
            } catch (e) {
                setCalcDisplay('Error');
            }
        } else if (['sin', 'cos', 'tan', 'ln'].includes(val)) {
            // Placeholder for advanced functions in this demo context
            setCalcDisplay('Feature in Pro');
            setTimeout(() => setCalcDisplay(calcDisplay), 800);
        } else {
            setCalcDisplay(prev => prev === '0' && val !== '.' ? val : prev + val);
        }
    };

    // --- Show Answer (Surrender) Logic ---
    const playCorrectSound = () => {
        if (user.preferences && user.preferences.soundEffects === false) return;
        try {
            const AudioContextClass = window.AudioContext || (window as any).webkitAudioContext;
            const ctx = new AudioContextClass();
            const now = ctx.currentTime;

            const osc = ctx.createOscillator();
            const gain = ctx.createGain();

            osc.type = 'sine';
            osc.frequency.setValueAtTime(880, now); // A5
            osc.frequency.exponentialRampToValueAtTime(1320, now + 0.1); // E6

            gain.gain.setValueAtTime(0, now);
            gain.gain.linearRampToValueAtTime(0.1, now + 0.01);
            gain.gain.exponentialRampToValueAtTime(0.001, now + 0.3);

            osc.connect(gain);
            gain.connect(ctx.destination);

            osc.start(now);
            osc.stop(now + 0.3);
        } catch (err) {
            console.error('Failed to play correct sound:', err);
        }
    };

    const handleShowAnswer = async () => {
        setIsSubmitted(true);
        setFeedback('incorrect');
        // Clear selection to indicate "no answer given"
        setSelectedAnswer(null);

        // Update visual progress state
        setQuestionResults(prev => ({
            ...prev,
            [question.id]: 'incorrect'
        }));

        const startTime = questionStartTimeRef.current || Date.now();
        const timeSpent = Math.round((Date.now() - startTime) / 1000);

        try {
            await submitAttempt({
                questionId: question.id,
                isCorrect: false,
                selectedOptionId: null,
                timeSpentSeconds: timeSpent,
                errorTags: question.errorTags || []
            });
        } catch (error) {
            console.error('Failed to submit "show answer" attempt:', error);
        }
    };

    // Immediate mode: submit and show feedback right away
    const handleSubmit = async () => {
        if (!selectedAnswer) return;

        setIsSubmitted(true);
        const isCorrect = selectedAnswer === question.correctOptionId;

        // Persist answer for mixed-mode scoring (e.g. if batch submit is triggered later)
        setUserAnswers(prev => ({ ...prev, [question.id]: selectedAnswer }));

        // Update visual progress state
        setQuestionResults(prev => ({
            ...prev,
            [question.id]: isCorrect ? 'correct' : 'incorrect'
        }));

        // Submit to Agent Insight system
        const startTime = questionStartTimeRef.current || Date.now();
        const timeSpent = Math.round((Date.now() - startTime) / 1000);

        try {
            const result = await submitAttempt({
                questionId: question.id,
                isCorrect,
                selectedOptionId: selectedAnswer,
                timeSpentSeconds: timeSpent,
                errorTags: isCorrect ? [] : (question.errorTags || [])
            });

            if (!result.success) {
                console.error('Submission failed result:', result);
                console.error(`Submission failed. Error: ${result.error || 'Unknown'}`);
            } else {
                console.log('Submission successful:', result);
                // alert('Debug: Submission successful! Attempt logged.'); // Optional: Uncomment if needed
            }
        } catch (error: any) {
            console.error('Failed to submit attempt:', error);
            console.error(`Submission exception: ${error.message || error}`);
        }

        if (isCorrect) {
            setFeedback('correct');
            setSessionResults(prev => ({ ...prev, correct: prev.correct + 1 }));
            playCorrectSound();
        } else {
            setFeedback('incorrect');
        }
    };

    // Batch mode: save answer and go to next question without immediate feedback
    const handleSkipToNext = () => {
        if (selectedAnswer) {
            setUserAnswers(prev => ({ ...prev, [question.id]: selectedAnswer }));
        }

        if (currentQuestionIndex < questions.length - 1) {
            setCurrentQuestionIndex(prev => prev + 1);
            setSelectedAnswer(userAnswers[questions[currentQuestionIndex + 1]?.id] || null);
            setIsSubmitted(false);
            setFeedback(null);
            questionStartTimeRef.current = Date.now(); // Reset timer for new question
        } else {
            // Last question - Confirm before submit
            setShowSubmitConfirm(true);
        }
    };

    // Batch submit all answers at once
    const handleBatchSubmit = async () => {
        // Include current selection if exists
        const allAnswers = selectedAnswer
            ? { ...userAnswers, [question.id]: selectedAnswer }
            : userAnswers;

        let correctCount = 0;
        const submissionPromises: Promise<any>[] = [];
        const localResults: Record<string, 'correct' | 'incorrect'> = {};

        // Calculate Average Time per Question relative to session start
        const now = Date.now();
        const durationSeconds = (now - sessionStartTimeRef.current) / 1000;
        const timePerQuestion = Math.max(5, Math.round(durationSeconds / Math.max(1, questions.length)));

        console.log(`⏱️ [handleBatchSubmit] Session Duration: ${durationSeconds.toFixed(1)}s, Avg per Q: ${timePerQuestion}s`);

        // Process all questions
        for (const q of questions) {
            const userAnswer = allAnswers[q.id];
            const alreadySubmitted = questionResults[q.id] !== undefined;

            // If answered, check correctness and log attempt
            if (userAnswer) {
                // Robust comparison: handle string/number conversion and whitespace
                const isCorrect = String(userAnswer).trim() === String(q.correctOptionId).trim();

                if (isCorrect) correctCount++;

                // Update local visual state
                localResults[q.id] = isCorrect ? 'correct' : 'incorrect';

                // Only submit if NOT already submitted individually
                if (!alreadySubmitted) {
                    const promise = submitAttempt({
                        questionId: q.id,
                        isCorrect: isCorrect,
                        selectedOptionId: userAnswer,
                        timeSpentSeconds: timePerQuestion,
                        errorTags: isCorrect ? [] : (q.errorTags || [])
                    });
                    submissionPromises.push(promise);
                } else {
                    // Already submitted individually, preserve existing result
                    localResults[q.id] = questionResults[q.id];
                    if (questionResults[q.id] === 'correct') {
                        // Ensure correctCount includes individually submitted correct answers
                        // (already counted above if userAnswer matches correctOptionId)
                    }
                }
            } else {
                // Unanswered treated as incorrect visually AND submitted as wrong attempt
                localResults[q.id] = 'incorrect';

                // Only submit if NOT already submitted individually
                if (!alreadySubmitted) {
                    const promise = submitAttempt({
                        questionId: q.id,
                        isCorrect: false,
                        selectedOptionId: null,
                        timeSpentSeconds: timePerQuestion,
                        errorTags: q.errorTags || []
                    });
                    submissionPromises.push(promise);
                }
            }
        }

        // Recalculate correctCount from final localResults (includes both batch and individually submitted)
        correctCount = Object.values(localResults).filter(r => r === 'correct').length;

        // 1. Instantly update all local session states to avoid intermediate flashes
        console.log('🚀 [handleBatchSubmit] Processing', questions.length, 'questions');
        console.log('🚀 [handleBatchSubmit] Local Results:', localResults);
        console.log('🚀 [handleBatchSubmit] Correct Count:', correctCount);

        setUserAnswers(allAnswers);
        setQuestionResults(localResults);
        setSessionResults({ correct: correctCount, total: questions.length });
        setShowSummary(true); // Jump directly to summary
        setMarkedQuestions(new Set()); // Clear marks upon submission

        // 2. Wait for all to finish before finalizing session (Sequencing is critical for history reliability)
        try {
            await Promise.allSettled(submissionPromises);
            console.log('✅ Batch attempts settled');

            // 3. Finalize Session (Activity Log) AFTER attempts are secured
            await finishSession(correctCount, allAnswers, localResults);
        } catch (err) {
            console.error('❌ Critical error in batch submit:', err);
            // Still try to finish session even if some attempts failed
            finishSession(correctCount, allAnswers, localResults);
        }
    };

    // NEW: Handle explicit "Submit All" click from UI
    const handleSubmitAll = () => {
        const currentAnsweredCount = Object.keys(userAnswers).length + (selectedAnswer && !userAnswers[question.id] ? 1 : 0);
        if (currentAnsweredCount < questions.length) {
            setShowSubmitConfirm(true);
        } else {
            handleBatchSubmit();
        }
    };

    // Next after immediate submission
    const handleNext = () => {
        if (currentQuestionIndex < questions.length - 1) {
            setCurrentQuestionIndex(prev => prev + 1);
            setSelectedAnswer(null);
            setIsSubmitted(false);
            setFeedback(null);
            questionStartTimeRef.current = Date.now(); // Reset timer for new question
        } else {
            finishSession();
        }
    };

    // --- Keyboard Navigation ---
    useEffect(() => {
        const handleKeyDown = (e: KeyboardEvent) => {
            // Ignore if input/textarea is focused or if modifiers are pressed
            if (['INPUT', 'TEXTAREA'].includes((document.activeElement as HTMLElement)?.tagName)) return;
            if (e.metaKey || e.ctrlKey || e.altKey || e.shiftKey) return;

            if (e.key === 'ArrowLeft') {
                if (currentQuestionIndex > 0) {
                    setCurrentQuestionIndex(prev => prev - 1);
                }
            } else if (e.key === 'ArrowRight') {
                if (isSubmitted) {
                    // If submitted, ArrowRight acts as "Next Question" or "Finish"
                    handleNext();
                } else {
                    // If not submitted, ArrowRight acts as "Skip/Next" (Batch Mode navigation)
                    handleSkipToNext();
                }
            }
        };

        window.addEventListener('keydown', handleKeyDown);
        return () => window.removeEventListener('keydown', handleKeyDown);
    }, [currentQuestionIndex, isSubmitted, questions.length, handleNext, handleSkipToNext]);

    // Show summary instead of immediate navigation
    const finishSession = async (overrideCorrect?: number, overrideAnswers?: any, overrideResults?: any) => {
        // --- NEW: Skip progress persistence if in Summary mode ---
        if (sessionMode === 'Summary') {
            setShowSummary(true);
            return;
        }

        const finalCorrectCount = overrideCorrect !== undefined ? overrideCorrect : sessionResults.correct;
        const finalAnswers = overrideAnswers || userAnswers;
        const finalResults = overrideResults || questionResults;
        const mainSectionId = subTopicId.endsWith('_review') ? subTopicId.replace('_review', '') : subTopicId;

        // 2. Fetch Latest Main Data (Background Fetch for Accuracy)
        let existingData: any = {};
        let mainTotalQuestions = questions.length;

        try {
            const mainP = await getSectionProgress(mainSectionId);
            existingData = mainP?.data || {};
            if (mainP?.total_questions) mainTotalQuestions = mainP.total_questions;

            // DEBUG: Check what summaryHistory is being loaded
            console.log('🔍 [finishSession] existingData.summaryHistory:', existingData.summaryHistory);
            console.log('🔍 [finishSession] existingData keys:', Object.keys(existingData));
        } catch (e) { console.error('Failed to fetch main data', e); }

        // === NEW STATE MACHINE DATA STRUCTURE ===

        if (sessionMode === 'Review') {
            // --- REVIEW SESSION COMPLETION ---

            // 1. Calculate which questions are still incorrect after this review round
            const stillIncorrectIds: string[] = [];
            questions.forEach(q => {
                if (finalResults[q.id] !== 'correct') {
                    stillIncorrectIds.push(q.id);
                }
            });

            // 2. Update main userAnswers and questionResults with fixes
            const mainUserAnswers = { ...(existingData.userAnswers || {}) };
            const mainQuestionResults = { ...(existingData.questionResults || {}) };

            Object.keys(finalResults).forEach(qid => {
                if (finalResults[qid] === 'correct') {
                    mainUserAnswers[qid] = finalAnswers[qid];
                    mainQuestionResults[qid] = 'correct';
                }
            });

            // 3. Create summary history entry (label will be set after attemptLabel calculation)
            const reviewRound = existingData.review?.round || 1;

            // Get existing history, with backward compatibility
            let existingHistory = existingData.summaryHistory || [];
            console.log('🔍 [Review finishSession] existingHistory from DB:', existingHistory);

            // Backward compatibility: If no history but firstAttempt exists, rebuild first entry
            if (existingHistory.length === 0 && existingData.firstAttempt?.status === 'completed') {
                console.log('🔄 [Review finishSession] Rebuilding First Attempt from firstAttempt data');
                const fa = existingData.firstAttempt;
                const faResults = fa.questionResults || existingData.questionResults || {};
                const faAnswers = fa.userAnswers || existingData.userAnswers || {};
                const faCorrect = Object.values(faResults).filter(r => r === 'correct').length;
                const faTotal = fa.questionIds?.length || Object.keys(faResults).length || 5;

                existingHistory = [{
                    type: 'first_attempt' as const,
                    attemptNumber: 1,
                    label: 'First Attempt',
                    timestamp: fa.completedAt || existingData.timestamp || new Date().toISOString(),
                    score: faTotal > 0 ? Math.round((faCorrect / faTotal) * 100) : 0,
                    userAnswers: faAnswers,
                    questionResults: faResults
                }];
                console.log('✅ [Review finishSession] Rebuilt existingHistory:', existingHistory);
            }

            // Determine current attempt number and generate label
            const attemptCount = existingHistory.filter((h: any) => h.type === 'first_attempt').length;
            const currentAttemptNumber = attemptCount > 0 ? attemptCount : 1;
            const reviewsForCurrentAttempt = existingHistory.filter((h: any) => h.type === 'review' && h.attemptNumber === currentAttemptNumber).length;
            const attemptLabel = currentAttemptNumber === 1 ? 'First Attempt' : `${getOrdinal(currentAttemptNumber)} Attempt`;

            // Now create current snapshot with correct label
            const currentSnapshot = {
                type: 'review' as const,
                attemptNumber: currentAttemptNumber,
                round: reviewRound,
                label: `Review ${attemptLabel} #${reviewsForCurrentAttempt + 1}`,
                timestamp: new Date().toISOString(),
                // Clamp score to 100% and ensure it's based on the questions in THIS session
                score: questions.length > 0 ? Math.min(100, Math.round((finalCorrectCount / questions.length) * 100)) : 0,
                userAnswers: finalAnswers,
                questionResults: finalResults
            };

            // Deduplicate history by label/timestamp to prevent duplicates during rapid clicks/saves
            const newHistory = [...existingHistory];
            const isDuplicate = newHistory.some(h => h.label === currentSnapshot.label && Math.abs(new Date(h.timestamp).getTime() - new Date(currentSnapshot.timestamp).getTime()) < 1000);
            if (!isDuplicate) {
                newHistory.push(currentSnapshot);
            }

            console.log('📝 [Review finishSession] newHistory to save:', newHistory.map(h => ({ type: h.type, label: h.label, round: h.round })));
            setSessionHistory(newHistory);
            setJustCompletedSessionLabel(currentSnapshot.label); // Mark which session was just completed

            // 4. Calculate new stats for main record
            const mainTotal = mainTotalQuestions;
            const mainCorrect = Object.values(mainQuestionResults).filter(r => r === 'correct').length;
            const mainScore = mainTotal > 0 ? (mainCorrect / mainTotal) * 100 : 0;

            // 5. Build new data structure
            const newData = {
                // Legacy fields (for backward compatibility)
                userAnswers: mainUserAnswers,
                questionResults: mainQuestionResults,
                questionIds: existingData.questionIds || existingData.firstAttempt?.questionIds || questions.map(q => q.id),
                summaryHistory: newHistory,

                // NEW: firstAttempt (preserve existing or create from legacy)
                firstAttempt: existingData.firstAttempt || {
                    status: 'completed' as const,
                    userAnswers: existingData.userAnswers || mainUserAnswers,
                    questionResults: existingData.questionResults || mainQuestionResults,
                    currentQuestionIndex: existingData.currentQuestionIndex || 0,
                    questionIds: existingData.questionIds || questions.map(q => q.id),
                    completedAt: existingData.timestamp || new Date().toISOString()
                },

                // NEW: review (mark as completed or preserve round)
                review: {
                    status: 'completed' as const,
                    round: reviewRound,
                    targetQuestionIds: questions.map(q => q.id),
                    userAnswers: finalAnswers,
                    questionResults: finalResults,
                    currentQuestionIndex: questions.length
                },

                // NEW: currentIncorrectIds (the remaining errors)
                currentIncorrectIds: stillIncorrectIds,
                markedQuestionIds: [] // Marks 'die' after submission
            };

            await saveSectionProgress(mainSectionId, newData, {
                completed: Object.keys(mainUserAnswers).length,
                total: mainTotal,
                score: mainScore
            }, 'section', true);

            // 6. Explicit Activity Logging
            await logUserActivity({
                sectionId: mainSectionId,
                attemptType: 'review',
                score: questions.length > 0 ? Math.round((finalCorrectCount / questions.length) * 100) : 0,
                correctCount: finalCorrectCount,
                totalQuestions: questions.length,
                data: { userAnswers: finalAnswers, questionResults: finalResults }
            });

            await fetchAllUserProgress();

            // Update state to show cumulative results in Current Session
            setQuestionResults(mainQuestionResults);
            setUserAnswers(mainUserAnswers);

            // Play correct sound if the review was successful (simplified: just if score > 0 or 100%)
            if (questions.length > 0 && finalCorrectCount === questions.length) {
                playCorrectSound();
            }

        } else {
            // --- FIRST ATTEMPT COMPLETION ---

            // 1. Find incorrect questions
            const incorrectIds: string[] = [];
            questions.forEach(q => {
                if (finalResults[q.id] !== 'correct') {
                    incorrectIds.push(q.id);
                }
            });

            // 2. Create summary history entry
            // Calculate ordinal label based on existing summaryHistory (more reliable than fetching activities)
            const existingHistory = existingData.summaryHistory || [];
            const attemptCount = existingHistory.filter((h: any) => h.type === 'first_attempt').length;
            const ordinal = attemptCount === 0 ? 'First'
                : attemptCount === 1 ? 'Second'
                    : attemptCount === 2 ? 'Third'
                        : `${attemptCount + 1}th`;
            console.log(`📊 [finishSession] Found ${attemptCount} past first_attempts in summaryHistory. Label: ${ordinal} Attempt`);

            const currentSnapshot = {
                type: 'first_attempt' as const,
                label: `${ordinal} Attempt`,
                timestamp: new Date().toISOString(),
                score: questions.length > 0 ? Math.round((finalCorrectCount / questions.length) * 100) : 0,
                userAnswers: finalAnswers,
                questionResults: finalResults
            };

            console.log('🔍 [First Attempt finishSession] existingHistory:', existingHistory);
            const newHistory = [...existingHistory, currentSnapshot];
            console.log('📝 [First Attempt finishSession] newHistory to save:', newHistory.map(h => ({ type: h.type, label: h.label })));
            setSessionHistory(newHistory);
            setJustCompletedSessionLabel(currentSnapshot.label); // Mark which session was just completed

            // 3. Build new data structure
            const newData = {
                // Legacy fields (for backward compatibility)
                userAnswers: finalAnswers,
                questionResults: finalResults,
                questionIds: questions.map(q => q.id),
                timestamp: new Date().toISOString(),
                summaryHistory: newHistory,

                // NEW: firstAttempt
                firstAttempt: {
                    status: 'completed' as const,
                    userAnswers: finalAnswers,
                    questionResults: finalResults,
                    currentQuestionIndex: questions.length,
                    questionIds: questions.map(q => q.id),
                    completedAt: new Date().toISOString()
                },

                // NEW: review (not started yet)
                review: {
                    status: 'not_started' as const,
                    round: 0,
                    targetQuestionIds: [],
                    userAnswers: {},
                    questionResults: {},
                    currentQuestionIndex: 0
                },

                // NEW: currentIncorrectIds
                currentIncorrectIds: incorrectIds,
                markedQuestionIds: [] // Marks 'die' after submission
            };

            await completeSectionSession(
                effectiveSectionId,
                finalCorrectCount,
                questions.length,
                finalCorrectCount,
                newData,
                'section',
                false
            );

            // 4. Explicit Activity Logging
            await logUserActivity({
                sectionId: effectiveSectionId,
                attemptType: 'first_attempt',
                score: questions.length > 0 ? Math.round((finalCorrectCount / questions.length) * 100) : 0,
                correctCount: finalCorrectCount,
                totalQuestions: questions.length,
                data: {
                    userAnswers: finalAnswers,
                    questionResults: finalResults,
                    label: `${ordinal} Attempt`
                }
            });

            await fetchAllUserProgress();

            // Unit completion check
            if (topicParam) {
                const unitSections = sections[topicParam] || [];
                if (unitSections.length > 0) {
                    const progressChecks = await Promise.all(unitSections.map(async (sec: any) => {
                        if (sec.id === subTopicId) return true;
                        const p = await getSectionProgress(sec.id);
                        return p && p.status === 'completed';
                    }));
                    if (progressChecks.every(isComplete => isComplete)) {
                        // Unit complete
                    }
                }
            }
        }

        completePractice({
            correct: finalCorrectCount,
            total: questions.length,
            topic: question?.topic || cleanTopic
        });
        setShowSummary(true);
    };



    // Exit from summary page
    const handleExitSummary = () => {
        if (subTopicId) {
            navigate(`/practice/unit/${topicParam}`, { state: { scrollToSubTopicId: subTopicId } });
        } else {
            navigate('/practice');
        }
    };

    const handleExitRequest = () => {
        if (viewState === 'practice' && subTopicId) {
            setShowExitConfirm(true); // Show confirmation dialog for ALL practice types
        } else {
            // Check if we have a subTopicId to scroll back to
            if (subTopicId) {
                navigate(`/practice/unit/${topicParam}`, { state: { scrollToSubTopicId: subTopicId } });
            } else {
                navigate('/practice');
            }
        }
    };

    const confirmSaveAndExit = async () => {
        setIsSaving(true);
        try {
            // Save current state
            if (subTopicId) {
                // Fetch existing data to preserve other fields
                let existingData: any = {};
                try {
                    const mainP = await getSectionProgress(effectiveSectionId);
                    existingData = mainP?.data || {};
                } catch (e) { console.error('Failed to fetch existing data', e); }

                if (sessionMode === 'Review') {
                    // === REVIEW MODE: Save to review field ===
                    const reviewState = {
                        status: 'in_progress' as const,
                        round: existingData.review?.round || 1,
                        targetQuestionIds: questions.map(q => q.id),
                        userAnswers,
                        questionResults,
                        currentQuestionIndex
                    };

                    const newData = {
                        ...existingData,
                        // Preserve firstAttempt
                        firstAttempt: existingData.firstAttempt || {
                            status: 'completed' as const,
                            userAnswers: existingData.userAnswers || {},
                            questionResults: existingData.questionResults || {},
                            currentQuestionIndex: 0,
                            questionIds: existingData.questionIds || questions.map(q => q.id),
                            completedAt: existingData.timestamp || new Date().toISOString()
                        },
                        // Update review
                        review: reviewState,
                        // MERGE into top-level questionResults for cumulative progress
                        questionResults: {
                            ...(existingData.questionResults || {}),
                            ...questionResults
                        },
                        // Preserve currentIncorrectIds
                        currentIncorrectIds: existingData.currentIncorrectIds || [],
                        markedQuestionIds: Array.from(markedQuestions)
                    };

                    await saveSectionProgress(effectiveSectionId, newData,
                        { completed: 0, total: 0, score: 0 }, 'section', true);
                } else {
                    // === FIRST ATTEMPT MODE: Save to firstAttempt field ===
                    const firstAttemptState = {
                        status: 'in_progress' as const,
                        userAnswers,
                        questionResults,
                        currentQuestionIndex,
                        questionIds: questions.map(q => q.id)
                    };

                    const currentCompleted = Object.keys(userAnswers).length;
                    const currentScore = questions.length > 0 ? (sessionResults.correct / questions.length) * 100 : 0;

                    const newData = {
                        // Legacy fields for backward compatibility
                        userAnswers,
                        currentQuestionIndex,
                        questionResults,
                        // NEW: firstAttempt
                        firstAttempt: firstAttemptState,
                        // Preserve review if exists
                        review: existingData.review || {
                            status: 'not_started' as const,
                            round: 0,
                            targetQuestionIds: [],
                            userAnswers: {},
                            questionResults: {},
                            currentQuestionIndex: 0
                        },
                        // Preserve other fields
                        summaryHistory: existingData.summaryHistory || [],
                        currentIncorrectIds: existingData.currentIncorrectIds || [],
                        markedQuestionIds: Array.from(markedQuestions)
                    };

                    await saveSectionProgress(effectiveSectionId, newData, {
                        completed: currentCompleted,
                        total: questions.length,
                        score: currentScore
                    });
                }

                showToast('Progress saved successfully', 'success');
            }
        } catch (error) {
            console.error('Save failed:', error);
            showToast('Failed to save progress, but exiting anyway', 'error');
        } finally {
            setIsSaving(false);
            setShowExitConfirm(false);
            navigate(`/practice/unit/${topicParam}`, { state: { scrollToSubTopicId: subTopicId } });
        }
    };

    const confirmExitWithoutSave = () => {
        setShowExitConfirm(false);
        navigate(`/practice/unit/${topicParam}`, { state: { scrollToSubTopicId: subTopicId } });
    };

    // Kept for backward compatibility if needed, but mainly replaced by confirmSaveAndExit
    const handleConfirmExit = () => {
        confirmSaveAndExit();
    };

    // Report functionality removed
    const handleReportSubmit = () => {
        // Redundant
    };

    const renderContent = (content: string, type?: 'text' | 'image', options: { noBorder?: boolean } = {}) => {
        if (!content) return null;
        // Delegate all rendering (Mixed Arrays, Single Images, LaTeX/Text) to the smart MathRenderer
        return <MathRenderer content={content} className={options.noBorder ? '' : ''} />;
    };



    const getModeLabel = (mode: SessionMode) => {
        switch (mode) {
            case 'Adaptive': return 'Adaptive Session';
            case 'Random': return 'Randomized Drill';
            case 'Review': return 'Weakness Review';
            default: return 'Practice Session';
        }
    };

    // Early return for initialization to prevent flashes - MUST be after hooks
    // Also show loading if we are in practice mode but questions are still calculating
    // OR if questions are empty but the grace period (showEmptyState) hasn't passed yet
    // OPTIMIZED LOADING CONDTION:
    // If viewState is 'lesson', we allow rendering immediately (using sync subTopicData) even if session check is pending.
    // We only block for loading if we are in 'practice' mode (where questions/progress are critical).
    if (viewState === 'practice' && (isLoadingQuestions || (questions.length === 0 && !showEmptyState))) {
        return (
            <div className="min-h-screen bg-background-light dark:bg-background-dark flex items-center justify-center">
                <div className="flex flex-col items-center gap-4">
                    <div className="w-8 h-8 border-4 border-primary border-t-transparent rounded-full animate-spin"></div>
                    <p className="text-gray-500 font-bold animate-pulse text-sm uppercase tracking-widest">Loading Practice Session...</p>
                </div>
            </div>
        );
    }

    if (viewState === 'lesson') {
        // Strictly use the "Detailed Description (For Card)" from settings
        // If the user kept it EMPTY in Supabase, we show empty as requested.
        const lessonContent = subTopicData?.description_2 || "No detailed description available.";

        return (
            <div key={subTopicId} className="h-screen bg-background-light dark:bg-background-dark text-text-main dark:text-gray-100 flex flex-col overflow-hidden">
                <Navbar />
                <main className="flex-grow w-full max-w-4xl mx-auto px-6 py-12 overflow-y-auto scroll-bounce">
                    <header className="mb-10">
                        {/* Back Button Added */}
                        <button
                            onClick={() => navigate(`/practice/unit/${topicParam}`, { state: { selectedSubTopicId: subTopicId } })}
                            className="mb-6 flex items-center gap-2 text-gray-400 hover:text-black dark:hover:text-white transition-colors text-sm font-bold uppercase tracking-wider group"
                        >
                            <span className="material-symbols-outlined text-lg group-hover:-translate-x-1 transition-transform">arrow_back</span>
                            Back
                        </button>

                        <div className="flex items-center gap-3 mb-4">
                            <span className="px-3 py-1 bg-yellow-100 text-yellow-800 rounded-lg text-xs font-bold uppercase tracking-widest">
                                {(subTopicData?.hasLesson !== false && subTopicData?.hasPractice !== false) ? 'LESSON & PRACTICE' :
                                    (subTopicData?.hasLesson === false && subTopicData?.hasPractice !== false) ? 'PRACTICE ONLY' :
                                        'LESSON ONLY'}
                            </span>
                            <span className="text-sm font-bold text-gray-500 uppercase tracking-widest">{topicParam}</span>
                        </div>
                        <h1 className="text-4xl font-black mb-4">{correctedSubTopicTitle || 'Loading...'}</h1>


                        {/* Dynamic Metadata Badges */}
                        <div className="flex flex-wrap items-center gap-3 mb-8">
                            {/* Time Badge - NOW DYNAMIC */}
                            <div className="flex items-center gap-1.5 px-3 py-1.5 rounded-lg bg-gray-100 dark:bg-white/10 text-gray-600 dark:text-gray-300 text-xs font-bold uppercase tracking-wider">
                                <span className="material-symbols-outlined text-sm">schedule</span>
                                <span>{dynamicEstimatedMinutes || subTopicData?.estimatedMinutes || 10} MIN</span>
                            </div>

                            {/* Type Badge */}
                            {subTopicData?.hasLesson !== false && (
                                <div className="flex items-center gap-1.5 px-3 py-1.5 rounded-lg bg-green-100 dark:bg-green-900/30 text-green-700 dark:text-green-400 text-xs font-bold uppercase tracking-wider">
                                    <span className="material-symbols-outlined text-sm">menu_book</span>
                                    <span>Lesson</span>
                                </div>
                            )}

                            {/* Practice Badge - Show count */}
                            {subTopicData?.hasPractice !== false && (
                                <div className="flex items-center gap-1.5 px-3 py-1.5 rounded-lg bg-blue-100 dark:bg-blue-900/30 text-blue-700 dark:text-blue-400 text-xs font-bold uppercase tracking-wider">
                                    <span className="material-symbols-outlined text-sm">exercise</span>
                                    <span>Practice • {questions.length} Qs</span>
                                </div>
                            )}
                        </div>


                    </header>

                    <div className="bg-surface-light dark:bg-surface-dark rounded-3xl p-8 md:p-12 border border-gray-100 dark:border-gray-800 shadow-sm leading-relaxed mb-12 min-h-[200px]">
                        {lessonContent ? (
                            <LessonRenderer content={lessonContent} />
                        ) : (
                            <div className="flex flex-col items-center justify-center h-full text-gray-400 py-10">
                                <span className="material-symbols-outlined text-4xl mb-2 opacity-50">description</span>
                                <p className="text-sm uppercase tracking-widest font-bold">No lesson content available</p>
                                <p className="text-xs text-center mt-2 opacity-70">Add a detailed description in Component Settings.</p>
                            </div>
                        )}
                    </div>

                    <div className="flex flex-col sm:flex-row items-center justify-center gap-6 py-8">
                        {pendingResumeData ? (
                            <>
                                <button
                                    onClick={handleStartNewSession}
                                    className="px-8 py-4 rounded-xl font-bold flex items-center gap-3 border-2 border-gray-200 dark:border-gray-700 text-gray-500 hover:text-gray-700 dark:hover:text-gray-300 hover:bg-gray-50 dark:hover:bg-white/5 transition-all text-lg"
                                >
                                    <span className="material-symbols-outlined">restart_alt</span>
                                    <span>Start Over</span>
                                </button>
                                <button
                                    onClick={handleConfirmResume}
                                    className="bg-primary text-black px-8 py-4 rounded-xl font-bold flex items-center gap-3 hover:shadow-lg hover:scale-[1.02] transition-all text-lg"
                                >
                                    <span>Resume Session</span>
                                    <span className="material-symbols-outlined">history</span>
                                </button>
                            </>
                        ) : (
                            (subTopicData?.hasPractice !== false) && (
                                <button
                                    onClick={handleStartPractice}
                                    className="group flex items-center gap-3 px-10 py-5 bg-black dark:bg-white text-white dark:text-black rounded-2xl font-black text-lg hover:scale-[1.02] active:scale-95 transition-all shadow-xl shadow-black/10"
                                >
                                    Start Practice
                                    <span className="material-symbols-outlined group-hover:translate-x-1 transition-transform">arrow_forward</span>
                                </button>
                            )
                        )}
                    </div>
                </main>
            </div >
        );
    }

    // --- FROM HERE DOWN IS PRACTICE VIEW ---
    // --- RENDER EMPTY STATE (NO QUESTIONS FOUND) ---
    // Added showEmptyState check to prevent flicker during debounce period
    if (!question && !isInitializing && showEmptyState) {
        return (
            <div className="min-h-screen flex flex-col bg-background-light dark:bg-background-dark text-text-main dark:text-white">
                <Navbar />
                <div className="flex-grow flex flex-col items-center justify-center p-6 text-center animate-fade-in">
                    <div className="w-20 h-20 bg-gray-100 dark:bg-white/5 rounded-full flex items-center justify-center mb-6">
                        <span className="material-symbols-outlined text-4xl text-gray-400">quiz</span>
                    </div>
                    <h2 className="text-2xl font-bold mb-2">No Questions Available</h2>
                    <p className="text-gray-500 mb-8 max-w-md">
                        {subTopicId === 'unit_test'
                            ? `No Unit Test questions found for ${getTopicDisplayTitle()}.`
                            : `We are currently building the problem set for ${subTopicData ? subTopicData.title : 'this topic'}.`
                        }
                        <br /><span className="text-sm mt-2 block opacity-70">Hint: Add questions in the Creator Area!</span>
                        <div className="mt-4 p-2 bg-red-100 text-red-800 text-xs font-mono text-left rounded overflow-auto max-h-40">
                            <strong>Debug Info:</strong><br />
                            topicParam: {topicParam}<br />
                            subTopicId: {subTopicId} ({typeof subTopicId})<br />
                            allQuestions: {allQuestions?.length}<br />
                            filtered: {questions.length}<br />
                            cleanTopic: {cleanTopic}<br />
                            Example Q Topics: {allQuestions?.slice(0, 3).map(q => q.topic).join(', ')}<br />
                            User Course: {user.currentCourse}
                        </div>
                    </p>
                    <div className="flex gap-4">
                        <button
                            onClick={() => navigate(-1)}
                            className="px-6 py-3 bg-gray-100 dark:bg-white/10 hover:bg-gray-200 dark:hover:bg-white/20 text-text-main dark:text-white rounded-xl font-bold transition-colors"
                        >
                            Go Back
                        </button>
                        <button
                            onClick={() => navigate('/practice')}
                            className="px-6 py-3 bg-primary text-black rounded-xl font-bold hover:shadow-lg transition-all"
                        >
                            Return to Hub
                        </button>
                    </div>
                </div>
            </div>
        );
    }

    // --- RENDER CELEBRATION SUMMARY VIEW ---
    if (showSummary) {
        return (
            <SessionSummary
                questions={questions}
                userAnswers={userAnswers}
                questionResults={questionResults}
                onExit={handleExitSummary}
                onRetake={() => {
                    setShowSummary(false);
                    handleStartNewSession();
                }}
                onReviewErrors={() => {
                    navigate('/practice/session', {
                        state: {
                            topic: topicParam,
                            subTopicId: subTopicId,
                            mode: 'Review',
                            forceStartNew: true
                        },
                        replace: true
                    });
                }}
                summaryHistory={sessionHistory}
                justCompletedSessionLabel={justCompletedSessionLabel}
                discussSlug={discussSlug}
            />
        );
    }

    // --- RENDER PRACTICE VIEW ---
    return (
        <div className="bg-background-light dark:bg-background-dark text-text-main font-display h-screen flex flex-col overflow-hidden antialiased animate-fade-in">

            {/* Scratchpad Overlay */}
            {activeTool === 'scratchpad' && (
                <div className="fixed inset-0 z-[60] cursor-crosshair animate-fade-in">
                    <canvas
                        ref={canvasRef}
                        className="w-full h-full touch-none"
                        onMouseDown={startDrawing}
                        onMouseMove={draw}
                        onMouseUp={stopDrawing}
                        onMouseLeave={stopDrawing}
                        onTouchStart={startDrawing}
                        onTouchMove={draw}
                        onTouchEnd={stopDrawing}
                    />

                    {/* Scratchpad Controls */}
                    <div className="absolute bottom-10 left-1/2 -translate-x-1/2 bg-white dark:bg-surface-dark border border-gray-200 dark:border-gray-800 rounded-full shadow-2xl p-2 flex items-center gap-4">
                        <div className="flex items-center gap-2 px-2">
                            <button onClick={() => setPenColor('#f9d406')} className={`w-6 h-6 rounded-full bg-[#f9d406] ring-2 ${penColor === '#f9d406' ? 'ring-black dark:ring-white scale-110' : 'ring-transparent'}`}></button>
                            <button onClick={() => setPenColor('#ef4444')} className={`w-6 h-6 rounded-full bg-red-500 ring-2 ${penColor === '#ef4444' ? 'ring-black dark:ring-white scale-110' : 'ring-transparent'}`}></button>
                            <button onClick={() => setPenColor('#000000')} className={`w-6 h-6 rounded-full bg-black ring-2 ${penColor === '#000000' ? 'ring-gray-300 dark:ring-white scale-110' : 'ring-transparent'}`}></button>
                        </div>
                        <div className="h-6 w-px bg-gray-200 dark:bg-gray-700"></div>
                        <button onClick={clearCanvas} className="p-2 hover:bg-gray-100 dark:hover:bg-white/10 rounded-full text-gray-600 dark:text-gray-300" title="Clear All">
                            <span className="material-symbols-outlined">delete</span>
                        </button>
                        <button onClick={() => setActiveTool('none')} className="px-4 py-2 bg-black dark:bg-white text-white dark:text-black rounded-full text-sm font-bold shadow-sm">
                            Done
                        </button>
                    </div>
                </div>
            )}

            <header className="sticky top-0 z-50 flex items-center justify-between border-b border-border-light dark:border-gray-800 bg-surface-light/80 dark:bg-surface-dark/80 backdrop-blur-md px-4 sm:px-6 lg:px-12 h-16 shrink-0">
                <div className="flex items-center gap-3 sm:gap-4 overflow-hidden">
                    <div className="size-8 flex items-center justify-center text-text-main dark:text-white bg-primary rounded-lg shrink-0">
                        <span className="material-symbols-outlined text-xl font-bold">functions</span>
                    </div>
                    <h1 className="text-text-main dark:text-white text-lg font-bold tracking-tight truncate hidden sm:block">NewMaoS</h1>
                </div>
                <div className="flex items-center gap-4 sm:gap-6 shrink-0">
                    <button onClick={handleExitRequest} className="group flex items-center gap-2 text-sm font-medium text-text-muted hover:text-text-main dark:text-gray-400 dark:hover:text-white transition-colors">
                        <span className="material-symbols-outlined text-lg">logout</span>
                        <span className="hidden sm:inline">Exit</span>
                    </button>
                    <div className="h-6 w-px bg-gray-200 dark:bg-gray-800 mx-1 sm:mx-2"></div>
                    <div
                        className="bg-center bg-no-repeat bg-cover rounded-full size-9 ring-2 ring-transparent group-hover:ring-primary transition-all cursor-pointer shrink-0"
                        style={{ backgroundImage: `url(${user.avatarUrl})` }}
                    ></div>
                </div>
            </header>

            <main className="flex-grow flex justify-center pt-6 pb-24 px-4 sm:px-6 relative overflow-y-auto scroll-bounce">
                <div className="w-full max-w-[1600px] flex gap-6">

                    <div className="flex-1 flex flex-col gap-6">
                        <div className="flex flex-col md:flex-row md:items-end justify-between gap-4 px-1">
                            <div className="flex flex-col gap-1">
                                <div className="flex items-center gap-2 text-sm font-medium text-text-muted text-gray-500">
                                    <span>Calculus {user.currentCourse}</span>
                                    <span className="text-gray-300">/</span>
                                    <span className="font-bold text-primary">
                                        {subTopicId === 'unit_test' ? 'Unit Test' : (correctedSubTopicTitle || (sessionMode === 'Adaptive' ? getTopicDisplayTitle() : getModeLabel(sessionMode)))}
                                    </span>
                                </div>
                                <h2 className="text-2xl font-bold text-text-main dark:text-white tracking-tight">Practice Session</h2>
                            </div>
                            <div className="w-full md:w-1/3 flex flex-col gap-2">
                                <div className="flex justify-between items-center text-xs font-semibold uppercase tracking-wider text-text-muted">
                                    <span>Question {currentQuestionIndex + 1} of {questions.length}</span>
                                    <button
                                        onClick={handleSubmitAll}
                                        className="flex items-center gap-1 px-2 py-0.5 rounded text-gray-400 hover:text-gray-600 transition-colors lowercase font-bold whitespace-nowrap"
                                    >
                                        submit all
                                        <span className="material-symbols-outlined text-[14px]">arrow_forward</span>
                                    </button>
                                </div>
                                {/* Segmented Progress Bar */}
                                <div className="flex gap-1 h-6 w-full">
                                    {questions.map((q, idx) => {
                                        const result = questionResults[q.id];
                                        let bgClass = 'bg-gray-200 dark:bg-gray-800 text-gray-400';
                                        if (idx === currentQuestionIndex) bgClass = 'bg-primary text-black font-bold ring-2 ring-primary ring-offset-1 dark:ring-offset-black';
                                        else if (result === 'correct') bgClass = 'bg-green-500 text-white';
                                        else if (result === 'incorrect') bgClass = 'bg-red-500 text-white';

                                        return (
                                            <div
                                                key={q.id}
                                                onClick={() => setCurrentQuestionIndex(idx)}
                                                className={`h-full flex-1 rounded-md transition-all duration-300 ${bgClass} flex items-center justify-center text-[10px] cursor-pointer hover:opacity-80 relative`}
                                            >
                                                {idx + 1}
                                                {markedQuestions.has(q.id) && (
                                                    <div className="absolute -top-1.5 -right-1.5 w-3.5 h-3.5 bg-red-500 rounded-full border-2 border-white dark:border-zinc-900 shadow-md z-20 animate-pulse-subtle" />
                                                )}
                                            </div>
                                        );
                                    })}
                                </div>
                            </div>
                        </div>

                        <div className="grid grid-cols-1 lg:grid-cols-12 gap-4 items-stretch relative">
                            {/* Formulas/Reference Panel */}
                            {activeTool === 'formula' && (
                                <div className="absolute top-0 left-0 right-0 z-20 bg-white dark:bg-surface-dark border border-gray-200 dark:border-gray-800 rounded-2xl shadow-xl animate-fade-in-up overflow-hidden ring-1 ring-black/5">
                                    <div className="flex justify-between items-center p-4 bg-gray-50 dark:bg-black/20 border-b border-gray-100 dark:border-gray-800">
                                        <h3 className="font-bold text-lg flex items-center gap-2">
                                            <span className="material-symbols-outlined">function</span>
                                            Reference Sheet
                                        </h3>
                                        <button onClick={() => setActiveTool('none')} className="text-gray-500 hover:text-black dark:hover:text-white">
                                            <span className="material-symbols-outlined">close</span>
                                        </button>
                                    </div>
                                    <div className="p-6 overflow-y-auto scroll-bounce max-h-[500px]">
                                        <div className="grid grid-cols-1 md:grid-cols-2 gap-8 text-sm">
                                            <div>
                                                <h4 className="font-bold mb-3 text-primary border-b border-gray-200 dark:border-gray-700 pb-1">Derivatives</h4>
                                                <ul className="space-y-2 text-gray-600 dark:text-gray-300 font-math">
                                                    <li className="flex justify-between"><span>d/dx(xⁿ)</span> <span>nxⁿ⁻¹</span></li>
                                                    <li className="flex justify-between"><span>d/dx(sin x)</span> <span>cos x</span></li>
                                                    <li className="flex justify-between"><span>d/dx(cos x)</span> <span>-sin x</span></li>
                                                    <li className="flex justify-between"><span>d/dx(eˣ)</span> <span>eˣ</span></li>
                                                    <li className="flex justify-between"><span>d/dx(ln x)</span> <span>1/x</span></li>
                                                    <li className="flex justify-between"><span>d/dx(uv)</span> <span>u'v + uv'</span></li>
                                                </ul>
                                            </div>
                                            <div>
                                                <h4 className="font-bold mb-3 text-primary border-b border-gray-200 dark:border-gray-700 pb-1">Integrals</h4>
                                                <ul className="space-y-2 text-gray-600 dark:text-gray-300 font-math">
                                                    <li className="flex justify-between"><span>∫ xⁿ dx</span> <span>xⁿ⁺¹/(n+1)</span></li>
                                                    <li className="flex justify-between"><span>∫ 1/x dx</span> <span>ln|x|</span></li>
                                                    <li className="flex justify-between"><span>∫ eˣ dx</span> <span>eˣ</span></li>
                                                    <li className="flex justify-between"><span>∫ sin x dx</span> <span>-cos x</span></li>
                                                    <li className="flex justify-between"><span>∫ cos x dx</span> <span>sin x</span></li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            )}

                            {/* Calculator */}
                            {activeTool === 'calculator' && question && (
                                <AdvancedCalculator
                                    onInput={handleCalcInput}
                                    display={calcDisplay}
                                    calculatorAllowed={question.calculatorAllowed}
                                    position={calcPosition}
                                    onClose={() => setActiveTool('none')}
                                    onPositionChange={setCalcPosition}
                                />
                            )}

                            {/* Question Section */}
                            <div className={`lg:col-span-7 flex flex-col ${isSubmitted ? 'min-h-[250px]' : 'h-[calc(100vh-280px)] min-h-[450px]'}`}>
                                <div className={`bg-surface-light dark:bg-surface-dark border border-gray-200 dark:border-gray-800 rounded-2xl shadow-apple flex flex-col gap-4 relative h-full scroll-bounce ${isSubmitted ? 'p-3 opacity-90' : 'p-6'}`}>
                                    <div className="flex justify-between items-start border-b border-gray-100 dark:border-gray-800 pb-3 mb-2">
                                        <div className="flex items-center gap-2 mr-6">
                                            <button onClick={() => setActiveTool(activeTool === 'scratchpad' ? 'none' : 'scratchpad')} className={`flex items-center gap-1 px-3 py-1.5 rounded-lg text-sm font-bold transition-all ${activeTool === 'scratchpad' ? 'bg-black text-white dark:bg-white dark:text-black' : 'bg-gray-100 dark:bg-white/10 text-gray-600 dark:text-gray-300'}`}>
                                                <span className="material-symbols-outlined text-lg">draw</span>
                                                <span className="hidden sm:inline">Scratchpad</span>
                                            </button>
                                            <button onClick={() => setActiveTool(activeTool === 'formula' ? 'none' : 'formula')} className={`flex items-center gap-1 px-3 py-1.5 rounded-lg text-sm font-bold transition-all ${activeTool === 'formula' ? 'bg-black text-white dark:bg-white dark:text-black' : 'bg-gray-100 dark:bg-white/10 text-gray-600 dark:text-gray-300'}`}>
                                                <span className="material-symbols-outlined text-lg">function</span>
                                                <span className="hidden sm:inline">Formulas</span>
                                            </button>
                                            {question?.calculatorAllowed ? (
                                                <button
                                                    onClick={() => setActiveTool(activeTool === 'calculator' ? 'none' : 'calculator')}
                                                    className={`flex items-center gap-1 px-3 py-1.5 rounded-lg text-sm font-bold transition-all ${activeTool === 'calculator' ? 'bg-black text-white dark:bg-white dark:text-black' : 'bg-gray-100 dark:bg-white/5 text-gray-600 dark:text-gray-300 hover:bg-gray-200'}`}
                                                >
                                                    <span className="material-symbols-outlined text-lg">calculate</span>
                                                    <span className="hidden sm:inline">Calculator</span>
                                                </button>
                                            ) : (
                                                <div className="flex items-center gap-1 px-3 py-1.5 rounded-lg text-sm font-bold invisible select-none">
                                                    <span className="material-symbols-outlined text-lg">calculate</span>
                                                    <span className="hidden sm:inline">Calculator</span>
                                                </div>
                                            )}
                                        </div>
                                        <div className="flex items-center gap-4">
                                            {!isSubmitted && (
                                                <button
                                                    onClick={handleShowAnswer}
                                                    className="flex items-center gap-1 px-3 py-1.5 rounded-lg text-sm font-bold transition-all bg-amber-50 dark:bg-amber-900/20 text-amber-600 dark:text-amber-500 border border-amber-200 dark:border-amber-900/30 hover:bg-amber-100 dark:hover:bg-amber-900/40 whitespace-nowrap"
                                                    title="Give up and show solution"
                                                >
                                                    <span>Show Answer</span>
                                                </button>
                                            )}
                                            <button
                                                onClick={() => toggleMark(question.id)}
                                                className={`transition-colors ${markedQuestions.has(question.id) ? 'text-orange-500' : 'text-gray-400 hover:text-orange-500'}`}
                                                title="Mark this question"
                                            >
                                                <span className={`material-symbols-outlined text-xl ${markedQuestions.has(question.id) ? 'filled' : ''}`}>flag</span>
                                            </button>
                                        </div>
                                    </div>

                                    <div className="flex-grow overflow-y-auto">
                                        <div className={`font-math text-text-main dark:text-gray-100 font-medium leading-relaxed ${isSubmitted ? 'text-sm' : 'text-lg md:text-xl'} overflow-x-auto max-w-full`}>
                                            {renderContent(question.prompt || '', question.promptType || 'text', { noBorder: true })}
                                        </div>
                                    </div>
                                </div>
                            </div>

                            {/* Options Section */}
                            <div className={`lg:col-span-5 flex flex-col gap-4 ${isSubmitted ? 'min-h-[250px]' : 'h-[calc(100vh-280px)] min-h-[450px]'}`}>
                                <div className={`bg-surface-light dark:bg-surface-dark border border-gray-200 dark:border-gray-800 rounded-2xl shadow-apple flex flex-col h-full ${isSubmitted ? 'p-2' : 'p-6'}`}>
                                    {/* Hide Header on Submit to save space as requested */}
                                    {!isSubmitted && (
                                        <div>
                                            <h3 className="text-text-main dark:text-white text-lg font-bold mb-1">
                                                Select your answer
                                            </h3>
                                            <p className="text-gray-500 text-sm">
                                                Choose the best option below.
                                            </p>
                                        </div>
                                    )}

                                    <div className="flex-grow overflow-y-auto scroll-bounce p-1.5 flex flex-col gap-3">
                                        {question.options.map((opt, idx) => {
                                            const isSelected = selectedAnswer === opt.id;
                                            const isCorrect = question.correctOptionId === opt.id;
                                            const isEliminated = (eliminatedOptions[question.id] || []).includes(opt.id);
                                            const isViewing = viewingOptionId === opt.id;

                                            let borderClass = 'border-gray-200 dark:border-gray-800';
                                            let bgClass = 'bg-white dark:bg-surface-dark';
                                            let textClass = 'text-text-main dark:text-gray-100';

                                            if (isEliminated && !isSubmitted) {
                                                borderClass = 'border-gray-100 dark:border-gray-800 opacity-50';
                                                bgClass = 'bg-gray-50/50 dark:bg-white/5';
                                                textClass = 'text-gray-400 line-through decoration-2 decoration-gray-400';
                                            } else if (isSubmitted) {
                                                if (isCorrect) {
                                                    borderClass = 'border-green-500';
                                                    bgClass = 'bg-green-50 dark:bg-green-900/20';
                                                } else if (isSelected && !isCorrect) {
                                                    borderClass = 'border-red-500';
                                                    bgClass = 'bg-red-50 dark:bg-red-900/20';
                                                }
                                                // Highlight viewing option if distinct from selection
                                                if (isViewing) {
                                                    bgClass += ' ring-2 ring-primary ring-offset-2 dark:ring-offset-black';
                                                }
                                            } else if (isSelected) {
                                                borderClass = 'border-primary';
                                                bgClass = 'bg-white dark:bg-surface-dark ring-1 ring-primary';
                                            }

                                            return (
                                                <div
                                                    key={opt.id}
                                                    onClick={() => {
                                                        if (!isSubmitted && !isEliminated) {
                                                            setSelectedAnswer(opt.id);
                                                            // Auto-save progress on selection
                                                            const nextAnswers = { ...userAnswers, [question.id]: opt.id };
                                                            setUserAnswers(nextAnswers);
                                                            if (subTopicId) {
                                                                // MERGE with existing data to prevent wiping history/results
                                                                getSectionProgress(effectiveSectionId).then(p => {
                                                                    const existing = p?.data || {};
                                                                    const newData = {
                                                                        ...existing,
                                                                        userAnswers: nextAnswers,
                                                                        currentQuestionIndex,
                                                                        markedQuestionIds: Array.from(markedQuestions)
                                                                    };
                                                                    saveSectionProgress(effectiveSectionId, newData, { completed: Object.keys(nextAnswers).length, total: questions.length, score: 0 });
                                                                });
                                                            }
                                                        }
                                                        if (isSubmitted) setViewingOptionId(opt.id);
                                                    }}
                                                    className={`group relative flex cursor-pointer rounded-xl border ${borderClass} ${bgClass} transition-all duration-200 ${isSubmitted ? 'p-2' : 'p-4'} ${!isSubmitted && !isEliminated && 'hover:border-primary/50'}`}
                                                >
                                                    <div className="peer sr-only"></div>
                                                    <div className="flex items-center gap-4 relative z-10 w-full overflow-hidden sm:pr-8 pr-2">
                                                        {/* Eliminate Button - Right Side */}
                                                        {!isSubmitted && (
                                                            <button
                                                                onClick={(e) => { e.stopPropagation(); toggleEliminate(question.id, opt.id, e); }}
                                                                className={`absolute -right-2 top-1/2 -translate-y-1/2 p-2 rounded-full text-gray-300 hover:text-red-500 hover:bg-red-50 transition-all ${isEliminated ? 'text-red-500 opacity-100' : 'opacity-0 group-hover:opacity-100'}`}
                                                                title={isEliminated ? "Restore Option" : "Eliminate Option"}
                                                            >
                                                                <span className="material-symbols-outlined text-xl">{isEliminated ? 'visibility' : 'visibility_off'}</span>
                                                            </button>
                                                        )}

                                                        <div className={`flex items-center justify-center rounded-full border font-bold transition-all shrink-0 ${isSelected || (isSubmitted && isCorrect) ? 'bg-primary border-primary text-black' : 'bg-white dark:bg-white/10 border-gray-200 dark:border-gray-700 text-gray-500'} ${isSubmitted ? 'h-5 w-5 text-xs' : 'h-8 w-8 text-sm'}`}>
                                                            {opt.label || opt.id || String.fromCharCode(65 + idx)}
                                                        </div>
                                                        <div className={`font-math w-full transition-all duration-500 overflow-x-auto ${textClass} ${isSubmitted ? 'text-sm' : 'text-lg'}`}>
                                                            {renderContent(opt.value || (opt as any).text || '', opt.type, { noBorder: true })}
                                                        </div>
                                                        {isSubmitted && isCorrect && <span className="material-symbols-outlined ml-auto text-green-600">check_circle</span>}
                                                        {isSubmitted && isSelected && !isCorrect && <span className="material-symbols-outlined ml-auto text-red-500">cancel</span>}
                                                    </div>
                                                </div>
                                            );
                                        })}
                                    </div>

                                    <div className="mt-auto pt-2">
                                        {!isSubmitted ? (
                                            <div className="flex gap-3">
                                                {currentQuestionIndex > 0 && (
                                                    <button
                                                        onClick={() => setCurrentQuestionIndex(prev => prev - 1)}
                                                        className="flex items-center justify-center gap-1 rounded-xl border-2 border-gray-200 dark:border-gray-700 hover:border-gray-400 dark:hover:border-gray-500 py-3.5 px-4 text-gray-600 dark:text-gray-300 font-bold transition-all active:scale-[0.98]"
                                                        title="Previous Question (Left Arrow)"
                                                    >
                                                        <span className="material-symbols-outlined text-lg">arrow_back</span>
                                                    </button>
                                                )}



                                                <button
                                                    onClick={handleSubmit}
                                                    disabled={!selectedAnswer}
                                                    className="flex-1 flex items-center justify-center gap-2 rounded-xl bg-primary hover:bg-primary-hover py-3.5 px-4 text-text-main font-bold shadow-sm transition-all active:scale-[0.98] disabled:opacity-50 disabled:cursor-not-allowed"
                                                >
                                                    <span>Submit Answer</span>
                                                    <span className="material-symbols-outlined text-lg">check</span>
                                                </button>
                                                <button
                                                    onClick={handleSkipToNext}
                                                    className={`flex items-center justify-center gap-1 rounded-xl border-2 py-3.5 px-5 font-bold transition-all active:scale-[0.98] ${currentQuestionIndex === questions.length - 1
                                                        ? 'bg-black dark:bg-white text-white dark:text-black border-transparent hover:opacity-90 shadow-sm'
                                                        : 'border-gray-200 dark:border-gray-700 hover:border-gray-400 dark:hover:border-gray-500 text-gray-600 dark:text-gray-300'
                                                        }`}
                                                    title={currentQuestionIndex === questions.length - 1 ? "Submit all answers" : "Go to next question"}
                                                >
                                                    <span>{currentQuestionIndex === questions.length - 1 ? 'Submit All' : 'Next'}</span>
                                                    <span className="material-symbols-outlined text-lg">{currentQuestionIndex === questions.length - 1 ? 'done_all' : 'arrow_forward'}</span>
                                                </button>
                                            </div>
                                        ) : (
                                            <div className="flex gap-3 w-full">
                                                {currentQuestionIndex > 0 && (
                                                    <button
                                                        onClick={() => setCurrentQuestionIndex(prev => prev - 1)}
                                                        className="flex items-center justify-center gap-1 rounded-xl border-2 border-gray-200 dark:border-gray-700 hover:border-gray-400 dark:hover:border-gray-500 py-4 px-6 text-gray-600 dark:text-gray-300 font-bold transition-all active:scale-[0.98] h-full"
                                                        title="Previous Question"
                                                    >
                                                        <span className="material-symbols-outlined text-xl">arrow_back</span>
                                                    </button>
                                                )}
                                                <button
                                                    onClick={handleNext}
                                                    className="flex-1 flex items-center justify-center gap-2 rounded-xl bg-black dark:bg-white hover:bg-gray-800 dark:hover:bg-gray-200 py-4 px-6 text-white dark:text-black font-bold shadow-sm transition-all active:scale-[0.98] h-full"
                                                >
                                                    <span>{currentQuestionIndex < questions.length - 1 ? 'Next Question' : 'Finish Practice'}</span>
                                                    <span className="material-symbols-outlined text-xl">arrow_forward</span>
                                                </button>
                                            </div>
                                        )}
                                    </div>
                                </div>
                            </div>
                        </div>

                        {/* Full Width Feedback Section (Below Grid) */}
                        {isSubmitted && (
                            <div className="w-full bg-surface-light dark:bg-surface-dark border border-gray-200 dark:border-gray-800 rounded-2xl p-4 shadow-apple flex flex-col gap-3 animate-fade-in-up mb-2">
                                <div className="flex items-center gap-3 border-b border-gray-100 dark:border-gray-800 pb-2 shrink-0">
                                    <div className={`p-1 rounded-full ${feedback === 'correct' ? 'bg-green-100 text-green-600' : 'bg-red-100 text-red-500'}`}>
                                        <span className="material-symbols-outlined text-xl">{feedback === 'correct' ? 'check_circle' : 'cancel'}</span>
                                    </div>
                                    <div>
                                        <h3 className="text-lg font-bold text-text-main dark:text-white">
                                            {feedback === 'correct' ? 'Excellent Work!' : 'Review & Learn'}
                                        </h3>
                                        <p className="text-xs text-text-muted">
                                            {feedback === 'correct' ? 'You got it right. Detailed solution below.' : 'Check the solution below to improve.'}
                                        </p>
                                    </div>
                                    <button
                                        onClick={() => setShowComments(!showComments)}
                                        className={`ml-auto flex items-center gap-1.5 px-3 py-1.5 rounded-lg text-xs font-bold transition-all ${showComments ? 'bg-primary text-white shadow-sm' : 'bg-indigo-50 dark:bg-indigo-900/20 text-indigo-600 dark:text-indigo-400 hover:bg-indigo-100 dark:hover:bg-indigo-900/30'}`}
                                    >
                                        <span className="material-symbols-outlined text-sm">forum</span>
                                        {showComments ? 'Hide Comments' : 'Discuss'}
                                    </button>
                                </div>

                                <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                                    {/* Specific Feedback */}
                                    <div className="flex flex-col gap-2 h-full">
                                        <h4 className="font-bold text-primary uppercase tracking-wider text-[10px] flex items-center gap-2 shrink-0">
                                            <span className="material-symbols-outlined text-xs">lightbulb</span>
                                            Option Feedback
                                        </h4>
                                        {viewingOptionId ? (
                                            <div className="bg-white dark:bg-surface-dark p-4 rounded-xl border border-gray-100 dark:border-gray-800 min-h-[150px]">
                                                <div className="font-math text-text-secondary dark:text-gray-300 leading-relaxed text-sm">
                                                    {(() => {
                                                        const opt = question.options.find(o => o.id === viewingOptionId);
                                                        const microExpl = question.microExplanations?.[viewingOptionId];
                                                        const feedback = opt?.explanation || microExpl;

                                                        if (feedback) {
                                                            return renderContent(feedback, opt?.explanationType || 'text', { noBorder: true });
                                                        }
                                                        return <span className="italic text-gray-400">No specific feedback for this option. See solution.</span>;
                                                    })()}
                                                </div>
                                            </div>
                                        ) : (
                                            <div className="text-gray-400 italic bg-white dark:bg-surface-dark p-4 rounded-xl border border-gray-100 dark:border-gray-800 h-full flex items-center justify-center text-sm">
                                                Select an option...
                                            </div>
                                        )}
                                    </div>

                                    <div className="flex flex-col gap-2 h-full">
                                        <h4 className="font-bold text-primary uppercase tracking-wider text-[10px] flex items-center gap-2 shrink-0">
                                            <span className="material-symbols-outlined text-xs">school</span>
                                            General Solution
                                        </h4>
                                        <div className="font-math bg-white dark:bg-surface-dark p-4 rounded-xl border border-gray-100 dark:border-gray-800 text-text-secondary dark:text-gray-300 leading-relaxed text-sm min-h-[150px]">
                                            {renderContent(question.explanation, question.explanationType, { noBorder: true })}
                                        </div>
                                    </div>
                                </div>

                                {/* In-Place Question Comments */}
                                {showComments && (
                                    <QuestionCommentSection
                                        questionId={question.id}
                                        channelSlug={discussSlug}
                                    />
                                )}
                            </div>
                        )}
                    </div>
                </div>
            </main>

            {/* Modals Section */}
            {showExitConfirm && (
                <div className="fixed inset-0 z-[100] flex items-center justify-center p-4 bg-black/50 backdrop-blur-sm animate-fade-in">
                    <div className="bg-white dark:bg-surface-dark rounded-2xl shadow-2xl max-w-sm w-full p-6 border border-gray-100 dark:border-gray-800 transform transition-all scale-100">
                        <div className="flex flex-col items-center text-center gap-4 mb-6">
                            <div className="w-12 h-12 bg-red-100 dark:bg-red-900/20 text-red-600 dark:text-red-500 rounded-full flex items-center justify-center">
                                <span className="material-symbols-outlined text-2xl">logout</span>
                            </div>
                            <div>
                                <h3 className="text-xl font-bold text-text-main dark:text-white">Exit Session?</h3>
                                <p className="text-gray-500 dark:text-gray-400 text-sm mt-2">
                                    Are you sure you want to exit? Your current progress will be saved automatically.
                                </p>
                            </div>
                        </div>
                        <div className="flex gap-3">
                            <button
                                onClick={() => setShowExitConfirm(false)}
                                disabled={isSaving}
                                className="flex-1 py-3 rounded-xl font-bold text-gray-600 dark:text-gray-300 hover:bg-gray-100 dark:hover:bg-white/10 transition-colors disabled:opacity-50"
                            >
                                Stay
                            </button>
                            <button
                                onClick={confirmSaveAndExit}
                                disabled={isSaving}
                                className="flex-1 py-3 rounded-xl font-bold bg-black dark:bg-white text-white dark:text-black hover:opacity-90 transition-all flex items-center justify-center gap-2 shadow-sm disabled:opacity-70"
                            >
                                {isSaving ? (
                                    <>
                                        <span className="material-symbols-outlined animate-spin text-lg">progress_activity</span>
                                        Exiting...
                                    </>
                                ) : (
                                    'Yes, Exit'
                                )}
                            </button>
                        </div>
                    </div>
                </div>
            )}

            {showSubmitConfirm && (() => {
                const currentAnsweredCount = Object.keys(userAnswers).length + (selectedAnswer && !userAnswers[question.id] ? 1 : 0);
                const isUnderfilled = currentAnsweredCount < questions.length;
                return (
                    <div className="fixed inset-0 z-[100] flex items-center justify-center p-4 bg-black/50 backdrop-blur-sm animate-fade-in">
                        <div className="bg-white dark:bg-surface-dark rounded-2xl shadow-2xl max-w-md w-full p-6 border border-gray-100 dark:border-gray-800 transform transition-all scale-100">
                            <div className="flex flex-col items-center text-center gap-4 mb-6">
                                <div className={`w-12 h-12 ${isUnderfilled ? 'bg-amber-100 dark:bg-amber-900/20 text-amber-600 dark:text-amber-500' : 'bg-blue-100 dark:bg-blue-900/20 text-blue-600 dark:text-blue-500'} rounded-full flex items-center justify-center`}>
                                    <span className="material-symbols-outlined text-2xl">{isUnderfilled ? 'warning' : 'done_all'}</span>
                                </div>
                                <div>
                                    <h3 className="text-xl font-bold text-text-main dark:text-white">
                                        {isUnderfilled ? 'Unfinished Questions' : 'Ready to Finish?'}
                                    </h3>
                                    <p className="text-gray-500 dark:text-gray-400 text-sm mt-2">
                                        {isUnderfilled
                                            ? `You still have ${questions.length - currentAnsweredCount} questions unanswered. Are you sure you want to submit all and finish?`
                                            : 'You have reached the end of the session. Would you like to submit all your answers now?'}
                                    </p>
                                </div>
                            </div>
                            <div className="flex gap-3">
                                <button
                                    onClick={() => setShowSubmitConfirm(false)}
                                    className="flex-1 py-3 rounded-xl font-bold text-gray-600 dark:text-gray-300 hover:bg-gray-100 dark:hover:bg-white/10 transition-colors"
                                >
                                    Not Yet
                                </button>
                                <button
                                    onClick={async () => {
                                        setShowSubmitConfirm(false);
                                        await handleBatchSubmit();
                                    }}
                                    className="flex-1 py-3 rounded-xl font-bold bg-black dark:bg-white text-white dark:text-black hover:opacity-90 transition-all shadow-sm"
                                >
                                    Submit All
                                </button>
                            </div>
                        </div>
                    </div>
                );
            })()
            }

            {/* Report Modal Removed */}
        </div >
    );
};