import React, { useEffect, useMemo, useState } from 'react';
import { useParams, useNavigate, useLocation } from 'react-router-dom';
import { Navbar } from '../components/Navbar';
import { useApp } from '../AppContext';
import { COURSE_CONTENT_DATA } from '../constants';
import { SubTopicProgress, UserSectionProgress, SubTopic, SessionMode } from '../types';
import { supabase } from '../src/services/supabaseClient';
import { ConfirmModal } from '../components/ConfirmModal';
import { MathRenderer } from '../components/MathRenderer';

export const TopicDetail = () => {
    const { unitId } = useParams();
    const navigate = useNavigate();
    const location = useLocation();
    const { topicContent, user, isAuthenticated, getTopicProgress, getSectionStatus, getSectionProgressData, questions: allQuestions, sections, sectionTimes, fetchAllUserProgress, sectionProgressMap, incorrectQuestionIds, getUnitProgress, saveSectionProgress } = useApp();


    // Custom UI Modal State
    const [confirmState, setConfirmState] = useState<{
        isOpen: boolean;
        title: string;
        message: string;
        onConfirm: () => void;
    }>({
        isOpen: false,
        title: '',
        message: '',
        onConfirm: () => { }
    });

    const triggerConfirm = (title: string, message: string, onConfirm: () => void) => {
        setConfirmState({
            isOpen: true,
            title,
            message,
            onConfirm: () => {
                onConfirm();
                setConfirmState(prev => ({ ...prev, isOpen: false }));
            }
        });
    };

    // Helper to check if a subtopic/unit test has any errors based on global state
    const checkHasErrors = (id: string) => {
        const relevantQuestions = allQuestions.filter(q => {
            const qBase = q.topic.includes('_') ? q.topic.split('_')[1] : q.topic;
            const unitBase = unitId?.includes('_') ? unitId.split('_')[1] : unitId;
            const isTopicMatch = qBase === unitBase;

            const isSubTopicMatch = id === 'unit_test'
                ? (q.subTopicId === 'unit_test' || !q.subTopicId)
                : (q.subTopicId === id);
            return isTopicMatch && isSubTopicMatch;
        });

        return relevantQuestions.some(q => incorrectQuestionIds.has(q.id));
    };

    // Handle legacy IDs (e.g. AB_Limits -> ABBC_Limits)
    const effectiveUnitId = useMemo(() => {
        if (!unitId) return '';
        // Special case: Unit 9 and Unit 10 are BC-only and should keep BC_ prefix
        if (unitId === 'BC_Unit9' || unitId === 'BC_Series') return unitId;

        let resolvedId = unitId;
        if (unitId.startsWith('Both_')) resolvedId = unitId;
        // Prioritize Both_ over ABBC_ if legacy passed
        else if (unitId.startsWith('ABBC_')) resolvedId = 'Both_' + unitId.split('ABBC_')[1];
        else if (unitId.startsWith('AB_') || unitId.startsWith('BC_')) {
            resolvedId = 'Both_' + unitId.split('_')[1];
        }

        console.log(`[TopicDetail] ID Resolution: Input=${unitId} -> Output=${resolvedId}`);
        return resolvedId;
    }, [unitId]);


    const [unitProgress, setUnitProgress] = useState<any>(null);

    useEffect(() => {
        if (effectiveUnitId && user?.id) {
            getUnitProgress(effectiveUnitId).then(data => setUnitProgress(data));
        }
    }, [effectiveUnitId, user?.id, sectionProgressMap]);


    const handleSubTopicClick = (subTopicId: string, customMode?: SessionMode, forceStartNew?: boolean) => {
        // Robust progress check for both regular sections and unit tests
        const effectiveId = subTopicId === 'unit_test' ? `${unitId}_unit_test` : subTopicId;

        // Fetch current snapshot
        const progress = getSectionProgressData(effectiveId);
        const progressData = progress?.data;
        const status = getSectionStatus(effectiveId);

        // Determine isResuming accurately by looking explicitly at the relevant mode
        let isResuming = false;
        if (!forceStartNew) {
            if (customMode === 'Review') {
                isResuming = progressData?.review?.status === 'in_progress';
            } else if (customMode === 'Adaptive' || !customMode) {
                // If it's adaptive, we resume if firstAttempt is in progress. 
                // Legacy fallback: if firstAttempt doesn't exist, we resume if global status is in_progress
                isResuming = progressData?.firstAttempt?.status === 'in_progress' ||
                    (!progressData?.firstAttempt && status === 'in_progress');
            }
        }

        // --- NEW: Review Round Management ---
        if (customMode === 'Review') {
            // If starting a BRAND NEW review session, increment the round number immediately
            // to lock it in and avoid double-incrementing during multiple saves/reloads.
            if (!isResuming) {
                const currentRound = progressData?.review?.round || 0;
                const nextRound = currentRound + 1;

                // Pre-save the next round number so the Practice page sees it immediately
                const existingData = progress?.data || {};
                const newData = {
                    ...existingData,
                    review: {
                        ...(progressData?.review || {}),
                        status: 'in_progress' as const,
                        round: nextRound,
                        targetQuestionIds: [], // Will be populated by Practice.tsx
                        userAnswers: {},
                        questionResults: {},
                        currentQuestionIndex: 0
                    }
                };

                // Foreground save to ensure it finishes before navigation
                saveSectionProgress(effectiveId, newData, { completed: 0, total: 0, score: 0 }, 'section', true);
            }
        }

        // Backup session context for refresh recovery (Safe Mode: Write Only)
        if (typeof sessionStorage !== 'undefined') {
            try {
                sessionStorage.setItem('last_practice_session', JSON.stringify({
                    topic: effectiveUnitId || unitId,
                    subTopicId: subTopicId,
                    mode: customMode || 'Adaptive',
                    isResuming: isResuming,
                    forceStartNew: forceStartNew
                }));
            } catch (e) {
                // Ignore storage errors
            }
        }

        navigate('/practice/session', {
            state: {
                topic: effectiveUnitId || unitId, // Use standardized ID
                subTopicId: subTopicId,
                mode: customMode || 'Adaptive',
                isResuming: isResuming,
                forceStartNew: forceStartNew
            }
        });
    };

    // Scroll to specific subtopic if returning from practice, otherwise top
    useEffect(() => {
        // slight delay to allow rendering
        const timer = setTimeout(() => {
            if (location.state && (location.state as any).scrollToSubTopicId) {
                const targetId = (location.state as any).scrollToSubTopicId;
                const element = document.getElementById(`subtopic-${targetId}`);
                if (element) {
                    element.scrollIntoView({ behavior: 'smooth', block: 'center' });
                    // clear state to prevent sticking? (React Router state persists, but typically okay here as user usually wants this context)
                }
            } else {
                window.scrollTo(0, 0);
            }
        }, 100);

        return () => clearTimeout(timer);
    }, [unitId, location.state]);

    // Safety check reference (moved render logic to bottom)
    // COMPAT LAYER: Handle stale server state where topicContent still has 'AB_' keys
    const unitContent = useMemo(() => {
        if (!effectiveUnitId) return null;
        if (topicContent[effectiveUnitId]) return topicContent[effectiveUnitId];

        // Fallback: If Both_ is missing, try legacy AB_ or BC_ keys (if server is stale)
        if (effectiveUnitId.startsWith('Both_')) {
            const suffix = effectiveUnitId.replace('Both_', '');
            return topicContent[`AB_${suffix}`] || topicContent[`BC_${suffix}`] || topicContent[`ABBC_${suffix}`] || null;
        }
        return null;
    }, [effectiveUnitId, topicContent]);

    // Use dynamic Unit Test config or fall back to defaults
    const unitTestConfig = unitContent?.unitTest || {
        title: 'Unit Test',
        description: unitContent ? `Comprehensive assessment covering all topics in ${unitContent.title}.` : '',
        estimatedMinutes: 45
    };

    // Simplified progress loading: only need to ensure global progress is synced
    useEffect(() => {
        if (effectiveUnitId && user?.id) {
            fetchAllUserProgress(); // Ensure global cache is fresh for this user
        }
    }, [effectiveUnitId, user?.id]);

    // 2. Derive sub-topics from unitContent (static COURSE_CONTENT_DATA, enriched by fetchSections merge)
    // CRITICAL: Always use unitContent.subTopics as the canonical chapter list.
    // Never use sections[] state directly — it may be incomplete (DB sections table 
    // might only have unit_test/overview rows), causing chapters to flash then disappear.
    const subTopics = useMemo(() => {
        const raw: SubTopic[] = unitContent?.subTopics || [];
        console.log(`[TopicDetail] Raw subtopics for ${unitContent?.title}:`, raw.length, raw);

        // Filter based on Course Scope and User's Current Course
        const filtered = raw.filter(s => {
            // Filter out Unit Test and Overview since they have dedicated rendering
            if (s.id === 'unit_test' || s.id === 'overview') return false;
            const titleLower = (s.title || '').toLowerCase();
            if (titleLower.includes('unit test') ||
                titleLower.includes('unit overview') ||
                (titleLower.includes('test') && titleLower.includes('unit')) ||
                titleLower === 'unit test' ||
                titleLower === 'test') return false;

            // --- FORCE BC FILTERING (Hardcoded Guardrail) ---
            const BC_ONLY_IDS = [
                '6.11', '6.12', '6.13',
                '7.5', '7.9',
                '8.13',
                '9.1', '9.2', '9.3', '9.4', '9.5', '9.6', '9.7', '9.8', '9.9',
                '10.1', '10.2', '10.3', '10.4', '10.5', '10.6', '10.7', '10.8', '10.9', '10.10', '10.11', '10.12', '10.13', '10.14', '10.15'
            ];

            if (user.currentCourse === 'AB' && BC_ONLY_IDS.includes(s.id)) {
                console.log(`[TopicDetail] Filtering BC-only topic for AB user: ${s.id}`);
                return false;
            }

            if (!s.courseScope || s.courseScope === 'both') return true;
            if (user.currentCourse === 'AB') {
                if (s.courseScope === 'bc_only') {
                    console.log(`[TopicDetail] Filtering bc_only scope for AB user: ${s.id}`);
                    return false;
                }
                return true;
            }
            if (user.currentCourse === 'BC') {
                if (s.courseScope === 'ab_only') {
                    console.log(`[TopicDetail] Filtering ab_only scope for BC user: ${s.id}`);
                    return false;
                }
                return true;
            }
            return true;
        });

        console.log(`[TopicDetail] Filtered subtopics: ${filtered.length}`, filtered);
        return filtered;
    }, [unitContent, user.currentCourse]);


    // Helper to calculate dynamic time
    const calculateTime = (sectionId: string) => {
        const totalSeconds = sectionTimes[sectionId] || 0;
        return Math.ceil(totalSeconds / 60) || 10; // Default to 10 min if 0/empty
    };

    // --- RENDER ---

    if (!unitContent) {
        return (
            <div className="h-full bg-background-light dark:bg-background-dark text-text-main dark:text-white flex flex-col overflow-hidden">
                <Navbar />
                <div className="flex-grow flex flex-col items-center justify-center p-6 text-center">
                    <span className="material-symbols-outlined text-6xl text-gray-300 mb-4">folder_off</span>
                    <h2 className="text-2xl font-bold mb-2">Unit Content Not Found</h2>
                    <p className="text-gray-500 mb-6 font-mono text-xs text-left bg-gray-100 p-4 rounded max-w-lg">
                        <strong>Debug Info (v1.0.1-debug):</strong><br />
                        Requested ID: {unitId || 'null'} <br />
                        Effective ID: {effectiveUnitId} <br />
                        Keys: {Object.keys(topicContent).length}
                    </p>
                    <button onClick={() => navigate('/practice')} className="px-6 py-2 bg-black dark:bg-white text-white dark:text-black rounded-lg font-bold">
                        Back to Hub
                    </button>
                </div>
            </div>
        );
    }

    return (
        <div className="h-full bg-background-light dark:bg-background-dark text-text-main dark:text-gray-100 flex flex-col overflow-hidden">
            <Navbar />
            <main className="flex-grow w-full max-w-5xl mx-auto px-6 py-10 overflow-y-auto scroll-bounce">

                <button
                    onClick={() => navigate('/practice')}
                    className="flex items-center gap-2 text-sm font-bold text-gray-500 hover:text-text-main dark:text-gray-400 dark:hover:text-white transition-colors mb-8"
                >
                    <span className="material-symbols-outlined">arrow_back</span>
                    Back to Practice Hub
                </button>

                <header className="mb-10">
                    <div className="flex items-center gap-3 mb-2">
                        <div className="p-2 bg-primary/20 rounded-lg text-yellow-700 dark:text-primary">
                            <span className="material-symbols-outlined">topic</span>
                        </div>
                        <span className="text-sm font-bold uppercase tracking-wider text-gray-500">Unit Overview</span>
                    </div>
                    <h1 className="text-4xl md:text-5xl font-black tracking-tight mb-4">{unitContent.title}</h1>
                    <p className="text-xl text-text-secondary dark:text-gray-400 max-w-2xl leading-relaxed mb-6">
                        {unitContent.description}
                    </p>


                </header>

                {!isAuthenticated && (
                    <div className="mb-10 p-5 bg-amber-50 dark:bg-amber-900/10 border border-amber-200 dark:border-amber-800 rounded-3xl flex items-center gap-4 text-amber-800 dark:text-amber-400 animate-fade-in">
                        <span className="material-symbols-outlined text-3xl">info</span>
                        <div>
                            <p className="font-bold">Not Logged In</p>
                            <p className="text-sm opacity-90">Progress tracking and AI recommendations require an account. <button onClick={() => navigate('/login')} className="font-bold underline">Log in now</button> to save your work.</p>
                        </div>
                    </div>
                )}

                <section className="grid grid-cols-1 gap-6">
                    {/* Render subtopics immediately (will fall back to static data if dynamic is missing) */}
                    {subTopics.map((sub, index) => (
                        <div
                            key={sub.id}
                            id={`subtopic-${sub.id}`}
                            onDoubleClick={() => handleSubTopicClick(sub.id)}
                            className="group bg-surface-light dark:bg-surface-dark border border-gray-200 dark:border-gray-700 rounded-3xl p-6 md:p-8 hover:border-primary shadow-sm hover:shadow-lg transition-all flex flex-col md:flex-row gap-6 md:items-center relative overflow-hidden cursor-pointer"
                        >
                            {/* Decorative Index */}
                            <span className="absolute -left-2 -top-4 text-[120px] font-black text-gray-100 dark:text-white/5 pointer-events-none select-none transition-colors group-hover:text-primary/10">
                                {index + 1}
                            </span>

                            <div className="flex-1 relative z-10 pl-4 md:pl-10">
                                <div className="text-2xl font-bold mb-1 group-hover:text-primary transition-colors [&_.markdown-body]:font-sans [&_.markdown-body_p]:font-bold [&_.markdown-body_p]:inline [&_.katex]:font-serif text-left">
                                    {(() => {
                                        // Use sub.id as the number if it's X.Y format, otherwise try to extract/keep numbering
                                        const cleanTitle = sub.title.replace(/^\d+\.\d+\s*/, '');
                                        const isNumericId = /^\d+\.\d+$/.test(sub.id);
                                        const displayTitle = isNumericId ? `${sub.id} ${cleanTitle}` : sub.title;
                                        return <MathRenderer content={displayTitle} />;
                                    })()}
                                </div>
                                <div className="text-sm font-bold text-gray-500 uppercase tracking-widest mb-3 text-left">{sub.description}</div>

                                <div className="flex flex-wrap items-center gap-3">

                                    {(sub.hasPractice !== false) && (
                                        <span className="inline-flex items-center gap-1.5 px-3 py-1 bg-blue-100 text-blue-800 rounded-lg text-xs font-bold uppercase tracking-wider">
                                            <span className="material-symbols-outlined text-[16px]">exercise</span>
                                            Practice
                                            {/* Show time here mostly as it relates to practice length */}
                                            {` • ${calculateTime(sub.id)}m`}
                                        </span>
                                    )}

                                    {/* Progress Badge */}
                                    {(() => {
                                        const progress = getSectionProgressData(sub.id);
                                        const progressData = progress?.data;
                                        const firstAttempt = progressData?.firstAttempt;

                                        // Only show progress if first attempt has started
                                        if (!firstAttempt || firstAttempt.status === 'not_started') {
                                            return null;
                                        }

                                        // Robust total questions detection
                                        const relevantUnitQuestions = allQuestions.filter(q => {
                                            const qBase = q.topic.includes('_') ? q.topic.split('_')[1] : q.topic;
                                            const unitBase = unitId?.includes('_') ? unitId.split('_')[1] : unitId;
                                            return qBase === unitBase && q.subTopicId === sub.id;
                                        });
                                        const totalQuestions = relevantUnitQuestions.length || progress?.total_questions || 5;

                                        // Aggregate correct answers
                                        const aggregatedResults: Record<string, any> = {
                                            ...(firstAttempt?.questionResults || {}),
                                            ...(progressData?.questionResults || {})
                                        };

                                        if (progressData?.review?.questionResults) {
                                            Object.assign(aggregatedResults, progressData.review.questionResults);
                                        }

                                        const correctCount = Object.values(aggregatedResults).filter((r: any) => r === true || r === 'correct').length;
                                        const percent = totalQuestions > 0 ? Math.round((correctCount / totalQuestions) * 100) : 0;

                                        // 100% = Completed
                                        // LOGIC UPDATE: Trust local calculation IF we have verified questions locally.
                                        // Otherwise (if filter failed), fall back to strict DB status to avoid premature completion.
                                        const actualIncorrectCount = progressData?.currentIncorrectIds?.length || 0;
                                        const status = getSectionStatus(sub.id);
                                        const hasVerifiedQuestions = relevantUnitQuestions.length > 0;
                                        const isLocallyCompleted = hasVerifiedQuestions && percent === 100 && actualIncorrectCount === 0;

                                        if ((status === 'completed' || isLocallyCompleted)) {
                                            return (
                                                <span className="inline-flex items-center gap-2 px-4 py-2 rounded-xl text-sm font-bold bg-green-100 text-green-700 dark:bg-green-900/30 dark:text-green-400">
                                                    <span className="material-symbols-outlined text-[18px]">check_circle</span>
                                                    Completed
                                                </span>
                                            );
                                        }

                                        // In Progress with percentage
                                        return (
                                            <div className="flex flex-col gap-1">
                                                <span className="inline-flex items-center gap-2 px-4 py-2 rounded-xl text-sm font-bold bg-yellow-100 text-yellow-700 dark:bg-yellow-900/30 dark:text-yellow-400">
                                                    <span className="material-symbols-outlined text-[18px]">hourglass_top</span>
                                                    In Progress
                                                    <span className="ml-1">{percent}%</span>
                                                </span>
                                                <div className="h-1.5 w-full bg-yellow-200 dark:bg-yellow-900/30 rounded-full overflow-hidden">
                                                    <div
                                                        className="h-full bg-yellow-500 rounded-full transition-all"
                                                        style={{ width: `${percent}%` }}
                                                    ></div>
                                                </div>
                                            </div>
                                        );
                                    })()}
                                </div>
                            </div>

                            <div className="relative z-10 shrink-0 flex flex-col sm:flex-row gap-2">
                                {(() => {
                                    // NEW STATE MACHINE LOGIC
                                    const mainProgress = getSectionProgressData(sub.id);
                                    const progressData = mainProgress?.data;

                                    // Determine button state using new logic
                                    const firstAttempt = progressData?.firstAttempt;
                                    const review = progressData?.review;
                                    const currentIncorrectIds = progressData?.currentIncorrectIds || [];

                                    // Calculate state
                                    let buttonState: 'NOT_STARTED' | 'FIRST_ATTEMPT_IN_PROGRESS' | 'FIRST_ATTEMPT_COMPLETED' | 'REVIEW_IN_PROGRESS' | 'STILL_HAS_ERRORS' | 'COMPLETED' = 'NOT_STARTED';

                                    // Compute actual incorrect count with absolute priority to questionResults (ground truth)
                                    const computeActualIncorrectCount = (): number => {
                                        // 1. Ground truth: compute from merged questionResults (includes first attempt + review corrections)
                                        if (progressData?.questionResults) {
                                            return Object.values(progressData.questionResults).filter((r: any) => r === false || r === 'incorrect').length;
                                        }

                                        // 2. Fallback: compute from firstAttempt.questionResults
                                        if (firstAttempt?.questionResults) {
                                            return Object.values(firstAttempt.questionResults).filter((r: any) => r === false || r === 'incorrect').length;
                                        }

                                        // 3. Last fallback: stored array only if no questionResults available
                                        if (progressData?.currentIncorrectIds && progressData.currentIncorrectIds.length > 0) {
                                            return progressData.currentIncorrectIds.length;
                                        }

                                        return 0;
                                    };
                                    const actualIncorrectCount = computeActualIncorrectCount();

                                    if (firstAttempt && firstAttempt.status !== 'not_started') {
                                        if (firstAttempt.status === 'in_progress') {
                                            buttonState = 'FIRST_ATTEMPT_IN_PROGRESS';
                                        } else if (firstAttempt.status === 'completed') {
                                            if (review?.status === 'in_progress') {
                                                buttonState = 'REVIEW_IN_PROGRESS';
                                            } else if (actualIncorrectCount > 0) {
                                                buttonState = 'STILL_HAS_ERRORS';
                                            } else {
                                                buttonState = 'COMPLETED';
                                            }
                                        }
                                    }

                                    // Fallback: Check legacy data structure
                                    if (buttonState === 'NOT_STARTED' && mainProgress) {
                                        const hasLegacyData = mainProgress.correct_questions > 0 ||
                                            (progressData?.userAnswers && Object.keys(progressData.userAnswers).length > 0);
                                        const status = getSectionStatus(sub.id);

                                        if (status === 'completed') {
                                            buttonState = checkHasErrors(sub.id) ? 'STILL_HAS_ERRORS' : 'COMPLETED';
                                        } else if (hasLegacyData || status === 'in_progress') {
                                            buttonState = 'FIRST_ATTEMPT_IN_PROGRESS';
                                        }
                                    }

                                    // View Summary button (shown when first attempt is completed)
                                    const showViewSummary = buttonState !== 'NOT_STARTED' && buttonState !== 'FIRST_ATTEMPT_IN_PROGRESS';
                                    const viewSummaryBtn = showViewSummary ? (
                                        <button
                                            onClick={(e) => { e.stopPropagation(); navigate('/practice/session', { state: { topic: effectiveUnitId || unitId, subTopicId: sub.id, mode: 'Summary' } }); }}
                                            className="px-3 py-2 bg-gray-100 dark:bg-white/5 text-text-main dark:text-white rounded-xl font-bold hover:bg-primary hover:text-black transition-all flex items-center justify-center gap-2 text-xs border border-transparent hover:border-primary/20"
                                        >
                                            <span className="material-symbols-outlined text-[16px]">analytics</span>
                                            View Summary
                                        </button>
                                    ) : null;

                                    // Render buttons based on state
                                    switch (buttonState) {
                                        case 'NOT_STARTED':
                                            return (
                                                <button
                                                    onClick={(e) => { e.stopPropagation(); handleSubTopicClick(sub.id); }}
                                                    className="w-full md:w-auto px-6 py-3 bg-gray-100 dark:bg-white/5 text-text-main dark:text-white rounded-xl font-bold group-hover:bg-primary group-hover:text-black transition-all flex items-center justify-center gap-2"
                                                >
                                                    Start
                                                    <span className="material-symbols-outlined">play_arrow</span>
                                                </button>
                                            );

                                        case 'FIRST_ATTEMPT_IN_PROGRESS':
                                            return (
                                                <button
                                                    onClick={(e) => { e.stopPropagation(); handleSubTopicClick(sub.id, 'Adaptive'); }}
                                                    className="px-6 py-2.5 bg-black dark:bg-white text-white dark:text-black rounded-xl font-bold hover:scale-105 transition-all flex items-center justify-center gap-2 shadow-md"
                                                >
                                                    Resume
                                                    <span className="material-symbols-outlined">history</span>
                                                </button>
                                            );

                                        case 'REVIEW_IN_PROGRESS':
                                            return (
                                                <div className="flex gap-2">
                                                    <button
                                                        onClick={(e) => { e.stopPropagation(); handleSubTopicClick(sub.id, 'Review'); }}
                                                        className="px-4 py-2.5 bg-red-50 dark:bg-red-900/10 text-red-600 dark:text-red-400 rounded-xl font-bold hover:bg-red-100 dark:hover:bg-red-900/20 transition-all flex items-center justify-center gap-2 text-sm border border-red-100 dark:border-red-900/20"
                                                    >
                                                        <span className="material-symbols-outlined text-[18px]">history</span>
                                                        Resume Review
                                                    </button>
                                                    {viewSummaryBtn}
                                                </div>
                                            );

                                        case 'STILL_HAS_ERRORS':
                                            return (
                                                <div className="flex gap-2">
                                                    <button
                                                        onClick={(e) => { e.stopPropagation(); handleSubTopicClick(sub.id, 'Review', true); }}
                                                        className="px-4 py-2.5 bg-red-50 dark:bg-red-900/10 text-red-600 dark:text-red-400 rounded-xl font-bold hover:bg-red-100 dark:hover:bg-red-900/20 transition-all flex items-center justify-center gap-2 text-sm border border-red-100 dark:border-red-900/20"
                                                    >
                                                        <span className="material-symbols-outlined text-[18px]">history_edu</span>
                                                        Review Errors
                                                    </button>
                                                    {viewSummaryBtn}
                                                </div>
                                            );

                                        case 'COMPLETED':
                                            return (
                                                <div className="flex gap-2">
                                                    <button
                                                        onClick={(e) => {
                                                            e.stopPropagation();
                                                            triggerConfirm(
                                                                'Start Over?',
                                                                'You have mastered this topic! Do you want to practice again?',
                                                                () => handleSubTopicClick(sub.id, 'Adaptive', true)
                                                            );
                                                        }}
                                                        className="px-4 py-2.5 bg-green-50 dark:bg-green-900/10 text-green-600 dark:text-green-400 rounded-xl font-bold hover:bg-green-100 dark:hover:bg-green-900/20 transition-all flex items-center justify-center gap-2 text-sm border border-green-100 dark:border-green-900/20"
                                                    >
                                                        <span className="material-symbols-outlined text-[18px]">refresh</span>
                                                        Start Over
                                                    </button>
                                                    {viewSummaryBtn}
                                                </div>
                                            );

                                        default:
                                            return (
                                                <button
                                                    onClick={(e) => { e.stopPropagation(); handleSubTopicClick(sub.id); }}
                                                    className="w-full md:w-auto px-6 py-3 bg-gray-100 dark:bg-white/5 text-text-main dark:text-white rounded-xl font-bold group-hover:bg-primary group-hover:text-black transition-all flex items-center justify-center gap-2"
                                                >
                                                    Start
                                                    <span className="material-symbols-outlined">play_arrow</span>
                                                </button>
                                            );
                                    }
                                })()}
                            </div>
                        </div>
                    ))
                    }

                    {/* UNIT TEST CARD */}
                    <div
                        id="subtopic-unit_test"
                        onDoubleClick={() => handleSubTopicClick('unit_test')}
                        className="group bg-gradient-to-br from-gray-50 to-gray-100 dark:from-surface-dark dark:to-black border-2 border-dashed border-gray-200 dark:border-gray-700 rounded-3xl p-6 md:p-8 hover:border-primary shadow-sm hover:shadow-lg transition-all flex flex-col md:flex-row gap-6 md:items-center relative overflow-hidden cursor-pointer"
                    >
                        <div className="flex-1 relative z-10 pl-4 md:pl-10">
                            <h3 className="text-2xl font-black mb-2 group-hover:text-primary transition-colors flex items-center gap-2">
                                <span className="material-symbols-outlined">verified</span>
                                {unitTestConfig.title}
                            </h3>
                            <p className="text-text-secondary dark:text-gray-400 font-medium mb-4">
                                {unitTestConfig.description}
                            </p>
                            <div className="flex flex-wrap gap-2 mt-2">
                                <div className="flex items-center gap-4 text-xs font-bold uppercase tracking-wider text-gray-500">
                                    <span className="flex items-center gap-1">
                                        <span className="material-symbols-outlined text-[16px]">timer</span>
                                        ~45-60 min
                                    </span>
                                    <span className="flex items-center gap-1">
                                        <span className="material-symbols-outlined text-[16px]">grade</span>
                                        Scored
                                    </span>
                                </div>
                                {/* Unit Test Progress - Robust Check */}
                                {(() => {
                                    const status1 = getSectionStatus(`${effectiveUnitId}_unit_test`);
                                    const status2 = getSectionStatus(`${unitId}_unit_test`);
                                    const status3 = getSectionStatus('unit_test');
                                    const finalStatus = status1 !== 'not_started' ? status1 : (status2 !== 'not_started' ? status2 : status3);

                                    const progress = getSectionProgressData(
                                        status1 !== 'not_started' ? `${effectiveUnitId}_unit_test` :
                                            (status2 !== 'not_started' ? `${unitId}_unit_test` : 'unit_test')
                                    );
                                    // Check if actually started (has answers OR moved past index 0)
                                    // Robust check: Look for direct data OR firstAttempt data
                                    const data = progress?.data;
                                    const firstAttempt = data?.firstAttempt;

                                    const hasActualProgress = progress && (
                                        progress.status === 'in_progress' ||
                                        progress.correct_questions > 0 ||
                                        // Check answers
                                        (data?.userAnswers && Object.keys(data.userAnswers).length > 0) ||
                                        (data?.questionResults && Object.keys(data.questionResults).length > 0) ||
                                        (firstAttempt?.userAnswers && Object.keys(firstAttempt.userAnswers).length > 0) ||
                                        (firstAttempt?.questionResults && Object.keys(firstAttempt.questionResults).length > 0) ||
                                        // Check position
                                        (typeof data?.currentQuestionIndex === 'number' && data.currentQuestionIndex > 0) ||
                                        (typeof firstAttempt?.currentQuestionIndex === 'number' && firstAttempt.currentQuestionIndex > 0)
                                    );

                                    // Calculate percent for Unit Test
                                    const totalQuestions = progress?.total_questions || data?.firstAttempt?.questionIds?.length || data?.questionIds?.length || 30;

                                    // Calculate correct count looking in all places
                                    let correctCount = progress?.correct_questions || 0;
                                    if (correctCount === 0) {
                                        const results = firstAttempt?.questionResults || data?.questionResults;
                                        if (results) {
                                            correctCount = Object.values(results).filter((r: any) => r === true || r === 'correct').length;
                                        }
                                    }

                                    const percent = totalQuestions > 0 ? Math.round((correctCount / totalQuestions) * 100) : 0;

                                    if (finalStatus === 'completed') {
                                        return (
                                            <span className="inline-flex items-center gap-1 px-2 py-0.5 rounded text-[10px] font-bold uppercase tracking-wider bg-green-100 text-green-800 dark:bg-green-900/30 dark:text-green-400">
                                                <span className="material-symbols-outlined text-[12px]">check_circle</span>
                                                Completed
                                            </span>
                                        );
                                    }

                                    if (finalStatus === 'in_progress' && hasActualProgress) {
                                        return (
                                            <div className="flex flex-col gap-1 w-32">
                                                <span className="inline-flex items-center gap-2 px-2 py-1 rounded-xl text-[10px] font-bold bg-yellow-100 text-yellow-700 dark:bg-yellow-900/30 dark:text-yellow-400">
                                                    <span className="material-symbols-outlined text-[14px]">hourglass_top</span>
                                                    In Progress
                                                    <span className="ml-1">{percent}%</span>
                                                </span>
                                                <div className="h-1 w-full bg-yellow-200 dark:bg-yellow-900/30 rounded-full overflow-hidden">
                                                    <div
                                                        className="h-full bg-yellow-500 rounded-full transition-all"
                                                        style={{ width: `${percent}%` }}
                                                    ></div>
                                                </div>
                                            </div>
                                        );
                                    }
                                    return null;
                                })()}
                            </div>
                        </div>

                        <div className="relative z-10 shrink-0 flex flex-col sm:flex-row gap-2">
                            {(() => {
                                const s1 = getSectionStatus(`${effectiveUnitId}_unit_test`);
                                const s2 = getSectionStatus(`${unitId}_unit_test`);
                                const s3 = getSectionStatus('unit_test');
                                const finalStatus = s1 !== 'not_started' ? s1 : (s2 !== 'not_started' ? s2 : s3);

                                const progress = getSectionProgressData(
                                    s1 !== 'not_started' ? `${effectiveUnitId}_unit_test` :
                                        (s2 !== 'not_started' ? `${unitId}_unit_test` : 'unit_test')
                                );
                                const isCompleted = finalStatus === 'completed';
                                // Check if actually started (has answers)
                                // Robust check: Look for direct data OR firstAttempt data
                                const data = progress?.data;
                                const firstAttempt = data?.firstAttempt;

                                const hasActualProgress = progress && (
                                    progress.status === 'in_progress' ||
                                    progress.correct_questions > 0 ||
                                    (data?.userAnswers && Object.keys(data.userAnswers).length > 0) ||
                                    (data?.questionResults && Object.keys(data.questionResults).length > 0) ||
                                    (firstAttempt?.userAnswers && Object.keys(firstAttempt.userAnswers).length > 0) ||
                                    (firstAttempt?.questionResults && Object.keys(firstAttempt.questionResults).length > 0) ||
                                    (typeof data?.currentQuestionIndex === 'number' && data.currentQuestionIndex > 0) ||
                                    (typeof firstAttempt?.currentQuestionIndex === 'number' && firstAttempt.currentQuestionIndex > 0)
                                );

                                if (isCompleted || hasActualProgress) {
                                    return (
                                        <>
                                            {/* 1. Review Errors Button */}
                                            {/* Only available if completed AND has errors */}
                                            {isCompleted && checkHasErrors('unit_test') && (
                                                <button
                                                    onClick={(e) => { e.stopPropagation(); navigate('/review/unit_test'); }}
                                                    className="px-6 py-3 bg-red-100 dark:bg-red-900/20 text-red-700 dark:text-red-400 rounded-xl font-bold hover:bg-red-200 dark:hover:bg-red-900/30 transition-all flex items-center justify-center gap-2"
                                                >
                                                    <span className="material-symbols-outlined text-[18px]">history_edu</span>
                                                    Review Errors
                                                </button>
                                            )}

                                            {/* 2. Resume Test Button */}
                                            {/* Only available if In Progress (not completed) */}
                                            {!isCompleted && (
                                                <button
                                                    onClick={(e) => { e.stopPropagation(); handleSubTopicClick('unit_test'); }}
                                                    className="px-6 py-3 bg-black dark:bg-white text-white dark:text-black rounded-xl font-bold hover:bg-gray-800 dark:hover:bg-gray-200 transition-all flex items-center justify-center gap-2 shadow-lg hover:shadow-xl transform hover:-translate-y-0.5"
                                                >
                                                    Resume Test
                                                    <span className="material-symbols-outlined">history</span>
                                                </button>
                                            )}

                                            {/* 3. Start Over Button */}
                                            {isCompleted && (
                                                <button
                                                    onClick={(e) => {
                                                        e.stopPropagation();
                                                        // triggerConfirm implementation or direct restart
                                                        handleSubTopicClick('unit_test', 'Adaptive', true);
                                                    }}
                                                    className="px-4 py-3 bg-gray-100 dark:bg-white/5 text-gray-600 dark:text-gray-300 rounded-xl font-bold hover:bg-gray-200 dark:hover:bg-white/10 transition-all flex items-center justify-center gap-2 border border-gray-200 dark:border-gray-700"
                                                >
                                                    <span className="material-symbols-outlined text-[18px]">refresh</span>
                                                    Start Over
                                                </button>
                                            )}

                                            {/* 4. View Summary Button */}
                                            {isCompleted && (
                                                <button
                                                    onClick={(e) => { e.stopPropagation(); navigate('/practice/session', { state: { topic: effectiveUnitId || unitId, subTopicId: 'unit_test', mode: 'Summary' } }); }}
                                                    className="px-4 py-3 bg-gray-100 dark:bg-white/5 text-text-main dark:text-white rounded-xl font-bold hover:bg-primary hover:text-black transition-all flex items-center justify-center gap-2 text-sm border border-transparent hover:border-primary/20"
                                                >
                                                    <span className="material-symbols-outlined text-[18px]">analytics</span>
                                                    Summary
                                                </button>
                                            )}
                                        </>
                                    );
                                }

                                // 3. Start Test Button (Default if not completed and no progress)
                                return (
                                    <button
                                        onClick={(e) => { e.stopPropagation(); handleSubTopicClick('unit_test'); }}
                                        className="px-8 py-4 bg-black dark:bg-white text-white dark:text-black rounded-xl font-bold hover:bg-gray-800 dark:hover:bg-gray-200 transition-all flex items-center gap-2 shadow-xl hover:shadow-2xl transform hover:-translate-y-1 text-lg"
                                    >
                                        Start Test
                                        <span className="material-symbols-outlined">play_arrow</span>
                                    </button>
                                );
                            })()}
                        </div>
                    </div>

                </section>

                {/* EMPTY STATE - Only show if truly empty after resolving data */}
                {
                    (subTopics.length === 0) && (
                        <div className="p-12 border-2 border-dashed border-gray-200 dark:border-gray-800 rounded-3xl text-center text-gray-400 flex flex-col items-center justify-center gap-4">
                            <span>No sub-topics found for this unit.</span>
                            <div className="text-gray-500 font-mono text-xs text-left bg-gray-100 p-4 rounded max-w-lg">
                                <strong>Debug Info (v1.0.2-fix):</strong><br />
                                Requested ID: {unitId || 'null'} <br />
                                Effective ID: {effectiveUnitId} <br />
                                Keys: {Object.keys(topicContent).length} <br />
                                Subtopics (Raw): {unitContent?.subTopics?.length || 0} <br />
                                Current Course: {user.currentCourse}
                            </div>
                        </div>
                    )
                }

                <ConfirmModal
                    isOpen={confirmState.isOpen}
                    title={confirmState.title}
                    message={confirmState.message}
                    onConfirm={confirmState.onConfirm}
                    onCancel={() => setConfirmState(prev => ({ ...prev, isOpen: false }))}
                    confirmText="Yes, Start Over"
                    cancelText="Cancel"
                />
            </main>
        </div >
    );
};
