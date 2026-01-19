import React, { useState, useEffect, useRef } from 'react';
import { useApp } from '../AppContext';
import { useNavigate, useLocation } from 'react-router-dom';
import { COURSE_CONTENT_DATA } from '../constants';
import { SessionMode, Question } from '../types';
import { Navbar } from '../components/Navbar';
import { AdvancedCalculator } from '../components/AdvancedCalculator';
import { SessionSummary } from '../components/SessionSummary';
import { useToast } from '../components/Toast';

// Markdown-ish renderer for the lesson content
const ContentRenderer = ({ content }: { content: string }) => {
    if (!content) return <div className="text-gray-400 italic">No lesson content available for this topic yet.</div>;

    // Basic splitting by double newline for paragraphs
    const blocks = content.split('\n');
    return (
        <div className="space-y-4 text-text-main dark:text-gray-200">
            {blocks.map((block, idx) => {
                if (block.startsWith('### ')) {
                    return <h3 key={idx} className="text-xl font-bold text-primary mt-6 mb-2">{block.replace('### ', '')}</h3>
                }
                if (block.startsWith('**') && block.endsWith('**')) {
                    return <strong key={idx} className="block font-bold">{block.replace(/\*\*/g, '')}</strong>
                }
                if (block.trim().startsWith('* ')) {
                    return <li key={idx} className="ml-4 list-disc">{block.replace('* ', '')}</li>
                }
                if (block.includes('$')) {
                    // Very crude "math" detection for this demo
                    return <div key={idx} className="font-math text-lg bg-gray-50 dark:bg-white/5 p-3 rounded-lg border-l-4 border-primary my-2">{block.replace(/\$/g, '')}</div>
                }
                if (block.trim() === '') return null;
                return <p key={idx} className="leading-relaxed">{block}</p>
            })}
        </div>
    )
}






export const Practice = () => {
    const { user, completePractice, questions: allQuestions, topicContent, submitAttempt, getTopicProgress, saveSectionProgress, completeSectionSession, getSectionProgress } = useApp();
    const navigate = useNavigate();
    const { showToast } = useToast();
    const location = useLocation();
    const topicParam = location.state?.topic || 'General'; // This might be "AB_Limits" or just "Limits"
    const subTopicId = location.state?.subTopicId;
    const sessionMode: SessionMode = location.state?.mode || 'Adaptive';

    // Derived Clean Topic - available to all functions in component
    const cleanTopic = topicParam.includes('_') ? topicParam.split('_')[1] : topicParam;

    // If subTopicId exists AND it is NOT 'unit_test', we start in 'Lesson' view, otherwise 'Practice'
    const [viewState, setViewState] = useState<'lesson' | 'practice'>(
        subTopicId && subTopicId !== 'unit_test' ? 'lesson' : 'practice'
    );
    const [subTopicData, setSubTopicData] = useState<any>(null);

    // Check for previous progress or saved session
    useEffect(() => {
        const checkProgress = async () => {
            if (subTopicId && subTopicId !== 'unit_test' && topicParam) {
                // 1. Check for Saved Session (In Progress)
                const savedSession = await getSectionProgress(subTopicId);

                if (savedSession && savedSession.status === 'in_progress' && savedSession.data) {
                    showToast('Resuming your previous session...', 'info');

                    // Restore Answers
                    if (savedSession.data.userAnswers) {
                        setUserAnswers(savedSession.data.userAnswers);
                    }

                    // Restore Timer (if saved)
                    if (savedSession.data.timeSpent) {
                        // We don't have a direct setTimeSpent state, but could adjust startTime
                        // For now, just acknowledged. 
                    }
                }
                // 2. Check for Completed Progress (if not in progress)
                else {
                    const progressMap = await getTopicProgress(topicParam);
                    const progress = progressMap[subTopicId];
                    if (progress && progress.attemptedQuestions > 0) {
                        showToast(
                            `You have already practiced this topic (Completed: ${progress.correctQuestions}/${progress.attemptedQuestions})`,
                            'info'
                        );
                    }
                }
            }
        };
        // Only run once on mount per subtopic
        checkProgress();
    }, [subTopicId, topicParam]);
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
    const [showReportModal, setShowReportModal] = useState(false);
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
    const [showSubmitConfirm, setShowSubmitConfirm] = useState(false);

    // Agent Insight: Track time spent on each question
    const questionStartTimeRef = useRef<number>(Date.now());

    const toggleMark = (qId: string) => {
        const newSet = new Set(markedQuestions);
        if (newSet.has(qId)) newSet.delete(qId);
        else newSet.add(qId);
        setMarkedQuestions(newSet);
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
    const [questions, setQuestions] = useState<Question[]>([]);

    // Helper to determine display title
    const getTopicDisplayTitle = () => {
        // Special case for Unit Test
        if (subTopicId === 'unit_test') {
            return 'Unit Test';
        }

        // If valid unit in content data, use its title
        if (COURSE_CONTENT_DATA[topicParam]) {
            return COURSE_CONTENT_DATA[topicParam].title;
        }
        // Fallback to clean name
        return cleanTopic;
    };

    useEffect(() => {
        if (!allQuestions || allQuestions.length === 0) return;

        let filtered = [];

        // Base Filter: Match Course Context (AB sees 'AB'|'Both', BC sees 'BC'|'Both')
        // and Match Topic string (using topicParam which is the unit ID like 'AB_Limits')
        const baseQuestions = allQuestions.filter(q => {
            const isCourseMatch = q.course === user.currentCourse || q.course === 'Both';
            // Match topic by unit ID (topicParam) or legacy cleanTopic for backwards compatibility
            const isTopicMatch = q.topic === topicParam || q.topic === cleanTopic;
            // Only allow Published questions (or legacy ones with no status)
            const isStatusValid = q.status === 'published' || !q.status;
            return isCourseMatch && isTopicMatch && isStatusValid;
        });

        // 1. Filter by SubTopic if provided (Strict Subdivision)
        if (subTopicId) {
            if (subTopicId === 'unit_test') {
                // Filter questions explicitly tagged as 'unit_test'
                // OR include all questions from the unit if we want the test to be comprehensive?
                // The requirement was: "add questions directly under the Unit column, it should be classified into unit test"
                // This implies a specific classification.
                // Let's filter for questions that are specifically 'unit_test' OR have no subTopicId set (legacy behavior for "Unit level" questions)
                filtered = baseQuestions.filter(q => q.subTopicId === 'unit_test' || !q.subTopicId);
            } else {
                // First try to match questions specifically tagged with this subTopicId
                filtered = baseQuestions.filter(q => q.subTopicId === subTopicId);

                if (subTopicId) {
                    // Debug Log
                    console.log('DEBUG: Practice useEffect running');
                    console.log('DEBUG: topicParam:', topicParam);
                    console.log('DEBUG: subTopicId:', subTopicId);

                    const dbUnit = topicContent[topicParam];
                    console.log('DEBUG: Found dbUnit:', !!dbUnit);

                    if (dbUnit) {
                        const dbSubTopic = dbUnit.subTopics?.find((s: any) => s.id === subTopicId);
                        console.log('DEBUG: Found dbSubTopic:', dbSubTopic);
                        if (dbSubTopic) {
                            setSubTopicData(dbSubTopic);
                        }
                        // Fallback to static if DB content exists but specific subtopic not found (shouldn't happen if structure matches)
                        else {
                            console.warn('DEBUG: dbSubTopic not found in dbUnit, falling back to static');
                            if (COURSE_CONTENT_DATA[topicParam]) {
                                const sub = COURSE_CONTENT_DATA[topicParam].subTopics.find(s => s.id === subTopicId);
                                setSubTopicData(sub);
                            }
                        }
                    } else {
                        console.warn('DEBUG: dbUnit not found, falling back to static');
                        if (COURSE_CONTENT_DATA[topicParam]) {
                            const sub = COURSE_CONTENT_DATA[topicParam].subTopics.find(s => s.id === subTopicId);
                            setSubTopicData(sub);
                        }
                    }
                }
            }
        }
        // 2. Otherwise filter by Unit Topic (General Practice)
        else {
            filtered = baseQuestions;
        }

        // --- APPLY MODE LOGIC (Only if not in strict subtopic mode, or randomize order within subtopic) ---
        if (sessionMode === 'Random') {
            filtered = [...filtered].sort(() => Math.random() - 0.5);
        } else if (sessionMode === 'Review') {
            filtered = [...filtered].reverse();
        }

        setQuestions(filtered);
    }, [topicParam, subTopicId, user.currentCourse, sessionMode, allQuestions, cleanTopic, topicContent]);

    const [currentQuestionIndex, setCurrentQuestionIndex] = useState(0);
    const [selectedAnswer, setSelectedAnswer] = useState<string | null>(null);
    const [isSubmitted, setIsSubmitted] = useState(false);
    const [feedback, setFeedback] = useState<'correct' | 'incorrect' | null>(null);
    const [sessionResults, setSessionResults] = useState({ correct: 0, total: 0 });

    const question = questions[currentQuestionIndex];
    const progress = questions.length > 0 ? ((currentQuestionIndex) / questions.length) * 100 : 0;

    // --- State Sync on Navigation ---
    useEffect(() => {
        if (!question) return;

        // Sync selected answer from stored user answers
        const savedAnswer = userAnswers[question.id];
        setSelectedAnswer(savedAnswer || null);

        // Sync submission/feedback state
        // If we have a result, it means it was graded (immediate mode)
        // If it's just in userAnswers but no result, it's saved (batch mode) -> NOT submitted
        if (questionResults[question.id]) {
            setIsSubmitted(true);
            setFeedback(questionResults[question.id]);
        } else {
            setIsSubmitted(false);
            setFeedback(null);
        }
    }, [currentQuestionIndex, question, userAnswers, questionResults]);

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
            await submitAttempt({
                questionId: question.id,
                isCorrect,
                selectedOptionId: selectedAnswer,
                timeSpentSeconds: timeSpent,
                errorTags: isCorrect ? [] : (question.errorTags || [])
            });
        } catch (error) {
            console.error('Failed to submit attempt:', error);
        }

        if (isCorrect) {
            setFeedback('correct');
            setSessionResults(prev => ({ ...prev, correct: prev.correct + 1 }));
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
    const handleBatchSubmit = () => {
        // Include current selection
        const allAnswers = selectedAnswer
            ? { ...userAnswers, [question.id]: selectedAnswer }
            : userAnswers;

        let correctCount = 0;
        questions.forEach(q => {
            const userAnswer = allAnswers[q.id];
            const isCorrect = userAnswer === q.correctOptionId;
            setQuestionResults(prev => ({
                ...prev,
                [q.id]: isCorrect ? 'correct' : 'incorrect'
            }));
            if (isCorrect) correctCount++;
        });

        setSessionResults({ correct: correctCount, total: questions.length });
        setShowSummary(true);
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

    // Show summary instead of immediate navigation
    // Show summary instead of immediate navigation
    const finishSession = async () => {
        // Mark section as completed in granular progress tracking
        if (subTopicId && subTopicId !== 'unit_test') {
            await completeSectionSession(
                subTopicId,
                sessionResults.correct,
                questions.length, // Total questions in this session
                sessionResults.correct,
                {
                    userAnswers,
                    questionResults,
                    timestamp: new Date().toISOString()
                }
            );
        }

        completePractice({
            correct: sessionResults.correct,
            total: questions.length,
            topic: question?.topic || cleanTopic
        });
        setShowSummary(true);
    };

    // Exit from summary page
    const handleExitSummary = () => {
        if (subTopicId) {
            navigate(`/practice/unit/${topicParam}`);
        } else {
            navigate('/practice');
        }
    };

    const handleExitRequest = () => {
        if (viewState === 'practice' && subTopicId && subTopicId !== 'unit_test') {
            setShowExitConfirm(true); // Show confirmation dialog
        } else {
            navigate('/practice');
        }
    };

    const confirmSaveAndExit = async () => {
        setIsSaving(true);
        // Save current state
        if (subTopicId) {
            const success = await saveSectionProgress(subTopicId, {
                userAnswers,
                currentQuestionIndex
            }, 0); // TODO: Track actual cumulative time

            if (success) {
                showToast('Progress saved successfully', 'success');
            } else {
                showToast('Failed to save progress', 'error');
            }
        }
        setIsSaving(false);
        setShowExitConfirm(false);
        navigate(`/practice/${topicParam}`); // Go back to Unit Detail
    };

    const confirmExitWithoutSave = () => {
        setShowExitConfirm(false);
        navigate(`/practice/${topicParam}`);
    };

    // Kept for backward compatibility if needed, but mainly replaced by confirmSaveAndExit
    const handleConfirmExit = () => {
        confirmSaveAndExit();
    };

    const handleReportSubmit = () => {
        setIsReporting(true);
        setTimeout(() => {
            setIsReporting(false);
            setShowReportModal(false);
            alert("Thank you for your report. We will review this question shortly.");
        }, 800);
    };

    const renderContent = (content: string, type?: 'text' | 'image') => {
        if (!content) return null;

        let isImage = false;
        if (type) {
            isImage = type === 'image';
        } else {
            // Fallback heuristic if type is missing (legacy questions)
            isImage = content.trim().startsWith('http') ||
                content.trim().startsWith('data:image') ||
                content.trim().startsWith('/');
        }

        if (isImage) {
            return (
                <div className="flex justify-center my-4">
                    <img
                        src={content}
                        alt="Content"
                        className="max-w-full rounded-lg border border-gray-200 dark:border-gray-700 shadow-sm"
                        style={{ maxHeight: '400px' }}
                    />
                </div>
            );
        }

        return <span className="whitespace-pre-wrap">{content}</span>;
    };

    const renderMath = (latex?: string) => {
        if (!latex) return null;

        // Improved "Generic" renderer that attempts to display any LaTeX reasonably well in HTML

        // Check for specific demo patterns first (Hardcoded for perfect presentation of demo content)
        if (latex.includes("\\frac") && latex.includes("sin")) {
            return (
                <div className="text-3xl md:text-4xl font-math text-text-main dark:text-white flex items-center gap-2">
                    <span className="italic">f</span>(x) =
                    <div className="inline-flex flex-col items-center justify-center align-middle mx-2">
                        <div className="border-b border-text-main dark:border-white pb-1 mb-1 px-1">sin(5<span className="italic">x</span>)</div>
                        <div><span className="italic">x</span></div>
                    </div>
                </div>
            );
        }

        // Generic Fraction Renderer: Matches \frac{...}{...}
        // Note: This is a simple regex parser for visual feedback, not a full LaTeX engine.
        const fracMatch = latex.match(/\\frac\{(.+?)\}\{(.+?)\}/);
        if (fracMatch) {
            const numerator = fracMatch[1].replace(/\\/g, '');
            const denominator = fracMatch[2].replace(/\\/g, '');
            return (
                <div className="text-3xl md:text-4xl font-math text-text-main dark:text-white flex items-center gap-2">
                    <div className="inline-flex flex-col items-center justify-center align-middle mx-2">
                        <div className="border-b border-text-main dark:border-white pb-1 mb-1 px-1">{numerator}</div>
                        <div>{denominator}</div>
                    </div>
                </div>
            );
        }

        // Generic display for other LaTeX (Integrals, Sums) if not matched above
        // Replaces common latex symbols with unicode chars for better raw display
        const formatted = latex
            .replace(/\\sum/g, '∑')
            .replace(/\\int/g, '∫')
            .replace(/\\infty/g, '∞')
            .replace(/\\pi/g, 'π')
            .replace(/\\approx/g, '≈')
            .replace(/\\neq/g, '≠')
            .replace(/\\le/g, '≤')
            .replace(/\\ge/g, '≥')
            .replace(/\\to/g, '→')
            .replace(/\\/g, '') // remove remaining backslashes
            .replace(/_\{(.+?)\}\^\{(.+?)\}/g, ' ($1 to $2) ') // crude bounds handling
            .replace(/\^\{(.+?)\}/g, ' sup($1) ')
            .replace(/\^2/g, '²')
            .replace(/\^3/g, '³');

        return (
            <div className="text-2xl md:text-4xl font-math text-text-main dark:text-white text-center leading-relaxed">
                {formatted}
            </div>
        )
    };

    const getModeLabel = (mode: SessionMode) => {
        switch (mode) {
            case 'Adaptive': return 'Adaptive Session';
            case 'Random': return 'Randomized Drill';
            case 'Review': return 'Weakness Review';
            default: return 'Practice Session';
        }
    };

    // --- RENDER LESSON VIEW ---
    if (viewState === 'lesson' && subTopicData) {
        return (
            <div className="bg-background-light dark:bg-background-dark min-h-screen flex flex-col antialiased animate-fade-in">
                <header className="sticky top-0 z-50 flex items-center justify-between border-b border-gray-200 dark:border-gray-800 bg-surface-light/80 dark:bg-surface-dark/80 backdrop-blur-md px-6 py-3 h-16">
                    <div className="flex items-center gap-4">
                        <button onClick={handleExitRequest} className="p-2 rounded-full hover:bg-gray-100 dark:hover:bg-white/10 transition-colors">
                            <span className="material-symbols-outlined text-text-main dark:text-white">arrow_back</span>
                        </button>
                        <h1 className="text-lg font-bold text-text-main dark:text-white truncate">{subTopicData.title}</h1>
                    </div>
                    <div className="px-3 py-1 bg-primary/10 text-yellow-700 dark:text-primary rounded text-xs font-bold uppercase tracking-wider">
                        Lesson Mode
                    </div>
                </header>

                <main className="flex-grow flex flex-col items-center justify-center py-12 px-4 sm:px-6">
                    <div className="max-w-4xl w-full bg-surface-light dark:bg-surface-dark p-12 rounded-3xl shadow-lg border border-gray-100 dark:border-gray-800">
                        <div className="mb-8 border-b border-gray-100 dark:border-gray-800 pb-8">
                            <h2 className="text-3xl font-black mb-2">{subTopicData.title}</h2>
                            <div className="text-sm font-bold text-gray-500 uppercase tracking-widest mb-4">{subTopicData.description}</div>

                            {subTopicData.description2 && (
                                <p className="text-lg text-text-secondary dark:text-gray-400 font-medium leading-relaxed mb-6">
                                    {subTopicData.description2}
                                </p>
                            )}

                            <div className="flex flex-wrap items-center gap-3">
                                {(subTopicData.hasLesson !== false) && (
                                    <span className="inline-flex items-center gap-1.5 px-3 py-1 bg-yellow-100 text-yellow-800 rounded-lg text-xs font-bold uppercase tracking-wider">
                                        <span className="material-symbols-outlined text-[16px]">menu_book</span>
                                        Lesson
                                    </span>
                                )}
                                {(subTopicData.hasPractice !== false) && (
                                    <span className="inline-flex items-center gap-1.5 px-3 py-1 bg-blue-100 text-blue-800 rounded-lg text-xs font-bold uppercase tracking-wider">
                                        <span className="material-symbols-outlined text-[16px]">exercise</span>
                                        Practice
                                    </span>
                                )}
                                <span className="inline-flex items-center gap-1.5 px-3 py-1 bg-gray-100 text-gray-600 rounded-lg text-xs font-bold uppercase tracking-wider">
                                    <span className="material-symbols-outlined text-[16px]">schedule</span>
                                    {subTopicData.estimatedMinutes} min
                                </span>
                            </div>
                        </div>
                        <div className="mt-10 flex justify-center">
                            <button
                                onClick={() => setViewState('practice')}
                                className="bg-primary text-black px-8 py-4 rounded-xl font-bold flex items-center gap-3 hover:shadow-lg hover:scale-[1.02] transition-all text-lg"
                            >
                                <span>Start Practice Questions</span>
                                <span className="material-symbols-outlined">arrow_forward</span>
                            </button>
                        </div>
                    </div>
                </main>

                {/* Reuse Exit Modal for Lesson view */}
                {showExitConfirm && (
                    <div className="fixed inset-0 z-[100] flex items-center justify-center p-4 bg-black/50 backdrop-blur-sm animate-fade-in">
                        <div className="bg-white dark:bg-surface-dark rounded-2xl shadow-2xl max-w-sm w-full p-6 border border-gray-100 dark:border-gray-800">
                            <div className="flex flex-col items-center text-center gap-4 mb-6">
                                <h3 className="text-xl font-bold text-text-main dark:text-white">Exit Lesson?</h3>
                                <p className="text-gray-500 dark:text-gray-400 text-sm">
                                    You can return to this lesson later.
                                </p>
                            </div>
                            <div className="flex gap-3">
                                <button onClick={() => setShowExitConfirm(false)} className="flex-1 py-3 rounded-xl font-bold text-gray-600 dark:text-gray-300 hover:bg-gray-100 dark:hover:bg-white/10">Cancel</button>
                                <button onClick={handleConfirmExit} className="flex-1 py-3 rounded-xl font-bold bg-primary text-text-main">Exit</button>
                            </div>
                        </div>
                    </div>
                )}
            </div>
        )
    }

    // --- RENDER EMPTY STATE (NO QUESTIONS FOUND) ---
    if (!question) {
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
                    </p>
                    <div className="flex gap-4">
                        <button
                            onClick={() => navigate(-1)}
                            className="px-6 py-3 bg-gray-100 dark:bg-white/10 hover:bg-gray-200 dark:hover:bg-white/20 text-text-main dark:text-white rounded-xl font-bold transition-colors"
                        >
                            Go Back
                        </button>
                        {/* Fallback to general practice if possible */}
                        <button
                            onClick={() => {
                                // Try generic limits pool for demo purposes if stuck
                                navigate('/practice');
                            }}
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
                    // Optional: Implement reset logic if needed later
                    handleExitSummary();
                }}
            />
        );
    }

    // --- RENDER PRACTICE VIEW ---
    return (
        <div className="bg-background-light dark:bg-background-dark text-text-main font-display min-h-screen flex flex-col overflow-x-hidden antialiased animate-fade-in">

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

            <header className="sticky top-0 z-50 flex items-center justify-between border-b border-border-light dark:border-gray-800 bg-surface-light/80 dark:bg-surface-dark/80 backdrop-blur-md px-6 py-3 lg:px-12 h-16">
                <div className="flex items-center gap-4">
                    <div className="size-8 flex items-center justify-center text-text-main dark:text-white bg-primary rounded-lg">
                        <span className="material-symbols-outlined text-xl font-bold">functions</span>
                    </div>
                    <h1 className="text-text-main dark:text-white text-lg font-bold tracking-tight">NewMaoS</h1>
                </div>
                <div className="flex items-center gap-6">
                    <button onClick={handleExitRequest} className="group flex items-center gap-2 text-sm font-medium text-text-muted hover:text-text-main dark:text-gray-400 dark:hover:text-white transition-colors">
                        <span className="material-symbols-outlined text-lg">arrow_back</span>
                        <span>Exit Session</span>
                    </button>
                    <div className="h-6 w-px bg-gray-200 dark:bg-gray-800 mx-2"></div>
                    <div
                        className="bg-center bg-no-repeat bg-cover rounded-full size-9 ring-2 ring-transparent group-hover:ring-primary transition-all cursor-pointer"
                        style={{ backgroundImage: `url(${user.avatarUrl})` }}
                    ></div>
                </div>
            </header>

            <main className="flex-grow flex justify-center pt-8 pb-24 px-4 sm:px-6 lg:px-8 relative">
                <div className="w-full max-w-[1280px] flex gap-8">

                    <div className="flex-1 flex flex-col gap-6">
                        <div className="flex flex-col md:flex-row md:items-end justify-between gap-4 px-1">
                            <div className="flex flex-col gap-1">
                                <div className="flex items-center gap-2 text-sm font-medium text-text-muted text-gray-500">
                                    <span>Calculus {user.currentCourse}</span>
                                    <span className="text-gray-300">/</span>
                                    <span className="font-bold text-primary">{subTopicData ? subTopicData.title : (sessionMode === 'Adaptive' ? getTopicDisplayTitle() : getModeLabel(sessionMode))}</span>
                                    <span className="text-gray-300">/</span>
                                    <span>{question.topic}</span>
                                </div>
                                <h2 className="text-2xl font-bold text-text-main dark:text-white tracking-tight">Practice Session</h2>
                            </div>
                            <div className="w-full md:w-1/3 flex flex-col gap-2">
                                <div className="flex justify-between items-center text-xs font-semibold uppercase tracking-wider text-text-muted">
                                    <span>Question {currentQuestionIndex + 1} of {questions.length}</span>
                                    <button
                                        onClick={() => toggleMark(question.id)}
                                        className={`flex items-center gap-1 px-2 py-0.5 rounded transition-colors ${markedQuestions.has(question.id) ? 'bg-orange-100 text-orange-600' : 'hover:bg-gray-100 text-gray-400'}`}
                                    >
                                        <span className={`material-symbols-outlined text-sm ${markedQuestions.has(question.id) ? 'filled' : ''}`}>flag</span>
                                        Mark
                                    </button>
                                </div>
                                {/* Segmented Progress Bar */}
                                <div className="flex gap-1 h-1.5 w-full">
                                    {questions.map((q, idx) => {
                                        const result = questionResults[q.id];
                                        let bgClass = 'bg-gray-200 dark:bg-gray-800';
                                        if (idx === currentQuestionIndex) bgClass = 'bg-primary';
                                        else if (result === 'correct') bgClass = 'bg-green-500';
                                        else if (result === 'incorrect') bgClass = 'bg-red-500';

                                        return (
                                            <div
                                                key={q.id}
                                                className={`h-full flex-1 rounded-full transition-colors duration-300 ${bgClass}`}
                                            ></div>
                                        );
                                    })}
                                </div>
                            </div>
                        </div>

                        <div className="grid grid-cols-1 lg:grid-cols-12 gap-6 lg:gap-8 items-start relative">

                            {/* Tool Overlay Panel (Formula only - Calculator is now independent) */}
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
                                    <div className="p-6">
                                        <div className="grid grid-cols-1 md:grid-cols-2 gap-8 text-sm max-h-[400px] overflow-y-auto pr-2">
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

                            {/* Independent Calculator Window */}
                            {activeTool === 'calculator' && (
                                <AdvancedCalculator
                                    onInput={handleCalcInput}
                                    display={calcDisplay}
                                    calculatorAllowed={question.calculatorAllowed}
                                    position={calcPosition}
                                    onClose={() => setActiveTool('none')}
                                    onPositionChange={setCalcPosition}
                                />
                            )}

                            <div className="lg:col-span-7 flex flex-col min-h-[350px]">
                                <div className="bg-surface-light dark:bg-surface-dark border border-gray-200 dark:border-gray-800 rounded-2xl p-8 shadow-apple flex flex-col gap-6 relative overflow-hidden">
                                    <div className="flex justify-end items-start">
                                        <button
                                            onClick={() => setShowReportModal(true)}
                                            className="text-text-muted hover:text-red-500 transition-colors"
                                            title="Report Issue"
                                        >
                                            <span className="material-symbols-outlined text-xl text-gray-400 hover:text-red-500 transition-colors">flag</span>
                                        </button>
                                    </div>

                                    <div className="flex-grow flex flex-col gap-6">
                                        <div className="text-lg md:text-xl text-text-main dark:text-gray-100 font-medium leading-relaxed">
                                            {renderContent(question.prompt, question.promptType)}
                                        </div>

                                        <div className="flex justify-center py-8">
                                            {renderMath(question.latex)}
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div className="lg:col-span-5 flex flex-col gap-6">
                                <div className="bg-surface-light dark:bg-surface-dark border border-gray-200 dark:border-gray-800 rounded-2xl p-6 md:p-8 shadow-apple flex flex-col gap-6">
                                    <div>
                                        <h3 className="text-text-main dark:text-white text-lg font-bold mb-1">
                                            {isSubmitted ? (feedback === 'correct' ? 'Correct!' : 'Incorrect') : 'Select your answer'}
                                        </h3>
                                        <p className={`text-sm ${isSubmitted ? (feedback === 'correct' ? 'text-green-600' : 'text-red-500') : 'text-gray-500'}`}>
                                            {isSubmitted ? (feedback === 'correct' ? 'Great job! See explanation below.' : 'Try to review the concept.') : 'Choose the best option below.'}
                                        </p>
                                    </div>

                                    <div className="flex flex-col gap-3 mt-4">
                                        {question.options.map((opt) => {
                                            const isSelected = selectedAnswer === opt.id;
                                            const isCorrect = question.correctOptionId === opt.id;
                                            const isEliminated = (eliminatedOptions[question.id] || []).includes(opt.id);

                                            let borderClass = 'border-gray-200 dark:border-gray-700';
                                            let bgClass = 'bg-background-light dark:bg-background-dark';
                                            let textClass = 'text-text-main dark:text-gray-200';

                                            if (isEliminated && !isSubmitted) {
                                                borderClass = 'border-gray-100 dark:border-gray-800 opacity-50';
                                                bgClass = 'bg-gray-50/50 dark:bg-white/5';
                                                textClass = 'text-gray-400 line-through decoration-2 decoration-gray-400';
                                            } else if (isSubmitted) {
                                                if (isCorrect) {
                                                    borderClass = 'border-green-500 bg-green-50 dark:bg-green-900/20';
                                                } else if (isSelected && !isCorrect) {
                                                    borderClass = 'border-red-500 bg-red-50 dark:bg-red-900/20';
                                                }
                                            } else if (isSelected) {
                                                borderClass = 'border-primary';
                                                bgClass = 'bg-white dark:bg-surface-dark ring-1 ring-primary';
                                            }

                                            return (
                                                <label key={opt.id} className={`group relative flex cursor-pointer rounded-xl border ${borderClass} ${bgClass} p-4 transition-all duration-200 ${!isSubmitted && !isEliminated && 'hover:border-primary/50'}`}>
                                                    <input
                                                        type="radio"
                                                        name="answer"
                                                        className="peer sr-only"
                                                        value={opt.id}
                                                        checked={isSelected}
                                                        onChange={() => !isSubmitted && !isEliminated && setSelectedAnswer(opt.id)}
                                                        disabled={isSubmitted || isEliminated}
                                                    />
                                                    <div className="flex items-center gap-4 relative z-10 w-full pr-8">
                                                        {/* Eliminate Button - Right Side */}
                                                        {!isSubmitted && (
                                                            <button
                                                                onClick={(e) => toggleEliminate(question.id, opt.id, e)}
                                                                className={`absolute -right-2 top-1/2 -translate-y-1/2 p-2 rounded-full text-gray-300 hover:text-red-500 hover:bg-red-50 transition-all ${isEliminated ? 'text-red-500 opacity-100' : 'opacity-0 group-hover:opacity-100'}`}
                                                                title={isEliminated ? "Restore Option" : "Eliminate Option"}
                                                            >
                                                                <span className="material-symbols-outlined text-xl">{isEliminated ? 'visibility' : 'visibility_off'}</span>
                                                            </button>
                                                        )}

                                                        <div className={`flex h-8 w-8 items-center justify-center rounded-full border text-sm font-bold transition-colors ${isSelected || (isSubmitted && isCorrect) ? 'bg-primary border-primary text-black' : 'bg-white dark:bg-white/10 border-gray-200 dark:border-gray-700 text-gray-500'}`}>
                                                            {opt.label}
                                                        </div>
                                                        <div className={`font-math text-lg w-full ${textClass}`}>
                                                            {renderContent(opt.value, opt.type)}
                                                        </div>
                                                        {isSubmitted && isCorrect && <span className="material-symbols-outlined ml-auto text-green-600">check_circle</span>}
                                                        {isSubmitted && isSelected && !isCorrect && <span className="material-symbols-outlined ml-auto text-red-500">cancel</span>}
                                                    </div>
                                                </label>
                                            );
                                        })}
                                    </div>

                                    {isSubmitted && (
                                        <div className="text-sm text-gray-600 dark:text-gray-300 bg-gray-50 dark:bg-white/5 p-4 rounded-lg animate-fade-in">
                                            <span className="font-bold">Explanation:</span> {question.explanation}
                                        </div>
                                    )}

                                    <div className="pt-6 mt-4">
                                        {!isSubmitted ? (
                                            <div className="flex gap-3">
                                                {currentQuestionIndex > 0 && (
                                                    <button
                                                        onClick={() => setCurrentQuestionIndex(prev => prev - 1)}
                                                        className="flex items-center justify-center gap-1 rounded-xl border-2 border-gray-200 dark:border-gray-700 hover:border-gray-400 dark:hover:border-gray-500 py-3.5 px-4 text-gray-600 dark:text-gray-300 font-bold transition-all active:scale-[0.98]"
                                                        title="Previous Question"
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
                                                    title={currentQuestionIndex === questions.length - 1 ? "Submit all answers" : "Save answer and check later"}
                                                >
                                                    <span>{currentQuestionIndex === questions.length - 1 ? 'Submit All' : 'Save & Next'}</span>
                                                    <span className="material-symbols-outlined text-lg">{currentQuestionIndex === questions.length - 1 ? 'done_all' : 'save_as'}</span>
                                                </button>
                                            </div>
                                        ) : (
                                            <div className="flex gap-3">
                                                {currentQuestionIndex > 0 && (
                                                    <button
                                                        onClick={() => setCurrentQuestionIndex(prev => prev - 1)}
                                                        className="flex items-center justify-center gap-1 rounded-xl border-2 border-gray-200 dark:border-gray-700 hover:border-gray-400 dark:hover:border-gray-500 py-3.5 px-4 text-gray-600 dark:text-gray-300 font-bold transition-all active:scale-[0.98]"
                                                        title="Previous Question"
                                                    >
                                                        <span className="material-symbols-outlined text-lg">arrow_back</span>
                                                    </button>
                                                )}
                                                <button
                                                    onClick={handleNext}
                                                    className="w-full flex items-center justify-center gap-2 rounded-xl bg-black dark:bg-white hover:bg-gray-800 dark:hover:bg-gray-200 py-3.5 px-4 text-white dark:text-black font-bold shadow-sm transition-all active:scale-[0.98]"
                                                >
                                                    <span>{currentQuestionIndex < questions.length - 1 ? 'Next Question' : 'Finish Practice'}</span>
                                                    <span className="material-symbols-outlined text-lg">arrow_forward</span>
                                                </button>
                                            </div>
                                        )}
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    {/* Sidebar Tools */}
                    <div className="hidden lg:flex flex-col gap-4 w-16 pt-32 sticky top-0 h-screen">
                        <div className="flex flex-col items-center gap-4 bg-surface-light dark:bg-surface-dark border border-gray-200 dark:border-gray-800 rounded-full py-6 px-2 shadow-float">
                            <button
                                onClick={() => setActiveTool(activeTool === 'scratchpad' ? 'none' : 'scratchpad')}
                                className={`group relative flex items-center justify-center size-10 rounded-full transition-all ${activeTool === 'scratchpad' ? 'text-primary bg-black/5 dark:bg-white/10' : 'text-gray-500 hover:text-text-main hover:bg-gray-100 dark:hover:bg-white/10'}`}
                            >
                                <span className="material-symbols-outlined">draw</span>
                                <div className="absolute right-14 top-1/2 -translate-y-1/2 px-2 py-1 bg-black text-white text-xs rounded opacity-0 group-hover:opacity-100 transition-opacity whitespace-nowrap pointer-events-none">Scratchpad</div>
                            </button>
                            <button
                                onClick={() => setActiveTool(activeTool === 'formula' ? 'none' : 'formula')}
                                className={`group relative flex items-center justify-center size-10 rounded-full transition-all ${activeTool === 'formula' ? 'text-primary bg-black/5 dark:bg-white/10' : 'text-gray-500 hover:text-text-main hover:bg-gray-100 dark:hover:bg-white/10'}`}
                            >
                                <span className="material-symbols-outlined">function</span>
                                <div className="absolute right-14 top-1/2 -translate-y-1/2 px-2 py-1 bg-black text-white text-xs rounded opacity-0 group-hover:opacity-100 transition-opacity whitespace-nowrap pointer-events-none">Formulas</div>
                            </button>
                            <button
                                onClick={() => setActiveTool(activeTool === 'calculator' ? 'none' : 'calculator')}
                                className={`group relative flex items-center justify-center size-10 rounded-full transition-all ${activeTool === 'calculator' ? 'text-primary bg-black/5 dark:bg-white/10' : 'text-gray-500 hover:text-text-main hover:bg-gray-100 dark:hover:bg-white/10'} ${!question.calculatorAllowed && 'hidden'}`}
                                disabled={!question.calculatorAllowed}
                            >
                                <span className="material-symbols-outlined">calculate</span>
                                <div className="absolute right-14 top-1/2 -translate-y-1/2 px-2 py-1 bg-black text-white text-xs rounded opacity-0 group-hover:opacity-100 transition-opacity whitespace-nowrap pointer-events-none">
                                    {question.calculatorAllowed ? 'Calculator' : 'No Calc'}
                                </div>
                            </button>
                        </div>
                    </div>

                </div>
            </main >

            {/* Exit Confirmation Modal */}
            {
                showExitConfirm && (
                    <div className="fixed inset-0 z-[100] flex items-center justify-center p-4 bg-black/50 backdrop-blur-sm animate-fade-in">
                        <div className="bg-white dark:bg-surface-dark rounded-2xl shadow-2xl max-w-sm w-full p-6 border border-gray-100 dark:border-gray-800 transform transition-all scale-100">
                            <div className="flex flex-col items-center text-center gap-4 mb-6">
                                <div className="w-12 h-12 bg-yellow-100 dark:bg-yellow-900/20 text-yellow-600 dark:text-yellow-500 rounded-full flex items-center justify-center">
                                    <span className="material-symbols-outlined text-2xl">save</span>
                                </div>
                                <div>
                                    <h3 className="text-xl font-bold text-text-main dark:text-white">Save Progress?</h3>
                                    <p className="text-gray-500 dark:text-gray-400 text-sm mt-2">
                                        You are about to exit. Would you like to save your progress to resume later, or exit without saving?
                                    </p>
                                </div>
                            </div>
                            <div className="flex gap-3">
                                <button
                                    onClick={confirmExitWithoutSave}
                                    disabled={isSaving}
                                    className="flex-1 py-3 rounded-xl font-bold text-gray-600 dark:text-gray-300 hover:bg-gray-100 dark:hover:bg-white/10 transition-colors disabled:opacity-50"
                                >
                                    Don't Save
                                </button>
                                <button
                                    onClick={confirmSaveAndExit}
                                    disabled={isSaving}
                                    className="flex-1 py-3 rounded-xl font-bold bg-primary text-text-main hover:brightness-105 transition-all flex items-center justify-center gap-2 shadow-sm disabled:opacity-70"
                                >
                                    {isSaving ? (
                                        <>
                                            <span className="material-symbols-outlined animate-spin text-lg">progress_activity</span>
                                            Saving...
                                        </>
                                    ) : (
                                        'Save & Exit'
                                    )}
                                </button>
                            </div>
                        </div>
                    </div>
                )
            }

            {/* Submit All Confirmation Modal */}
            {
                showSubmitConfirm && (
                    <div className="fixed inset-0 z-[100] flex items-center justify-center p-4 bg-black/50 backdrop-blur-sm animate-fade-in">
                        <div className="bg-white dark:bg-surface-dark rounded-2xl shadow-2xl max-w-sm w-full p-6 border border-gray-100 dark:border-gray-800 transform transition-all scale-100">
                            <div className="flex flex-col items-center text-center gap-4 mb-6">
                                <div className="w-12 h-12 bg-blue-100 dark:bg-blue-900/20 text-blue-600 dark:text-blue-500 rounded-full flex items-center justify-center">
                                    <span className="material-symbols-outlined text-2xl">publish</span>
                                </div>
                                <div>
                                    <h3 className="text-xl font-bold text-text-main dark:text-white">Submit All Answers?</h3>
                                    <p className="text-gray-500 dark:text-gray-400 text-sm mt-2">
                                        You are about to submit your practice session. You can review your results immediately after.
                                    </p>
                                </div>
                            </div>
                            <div className="flex gap-3">
                                <button
                                    onClick={() => setShowSubmitConfirm(false)}
                                    className="flex-1 py-3 rounded-xl font-bold text-gray-600 dark:text-gray-300 hover:bg-gray-100 dark:hover:bg-white/10 transition-colors"
                                >
                                    Cancel
                                </button>
                                <button
                                    onClick={() => {
                                        setShowSubmitConfirm(false);
                                        // handleBatchSubmit is not defined in this scope yet, we need to ensure it is or use handleNext equivalent
                                        // Assuming handleBatchSubmit logic is needed here or standard finish
                                        finishSession();
                                    }}
                                    className="flex-1 py-3 rounded-xl font-bold bg-black dark:bg-white text-white dark:text-black hover:opacity-90 transition-all shadow-sm"
                                >
                                    Submit
                                </button>
                            </div>
                        </div>
                    </div>
                )
            }

            {/* Bottom Overview Bar - Floating Compact Style */}
            <div className="fixed bottom-6 left-1/2 -translate-x-1/2 z-40">
                <div className="bg-white dark:bg-surface-dark border border-gray-200 dark:border-gray-800 shadow-xl rounded-2xl px-4 py-3 flex items-center gap-4 animate-fade-in-up">
                    <span className="text-xs font-bold text-gray-400 uppercase tracking-wider shrink-0 hidden sm:block">Questions</span>
                    <div className="flex items-center gap-2 max-w-[80vw] overflow-x-auto no-scrollbar mask-gradient-x p-2">
                        {questions.map((q, idx) => {
                            const isCurrent = idx === currentQuestionIndex;
                            const isMarked = markedQuestions.has(q.id);
                            const result = questionResults[q.id];

                            // Determine border/bg color based on status
                            let buttonClass = 'bg-gray-50 dark:bg-white/5 text-gray-500 hover:bg-gray-100';
                            if (isCurrent) buttonClass = 'bg-primary text-black font-bold ring-2 ring-primary ring-offset-2 dark:ring-offset-surface-dark';
                            else if (result === 'correct') buttonClass = 'bg-green-100 text-green-700 dark:bg-green-900/30 dark:text-green-400';
                            else if (result === 'incorrect') buttonClass = 'bg-red-100 text-red-700 dark:bg-red-900/30 dark:text-red-400';

                            return (
                                <button
                                    key={q.id}
                                    onClick={() => setCurrentQuestionIndex(idx)}
                                    className={`relative shrink-0 w-9 h-9 rounded-lg flex items-center justify-center text-sm transition-all ${buttonClass}`}
                                >
                                    {idx + 1}
                                    {isMarked && <div className="absolute -top-1 -right-1 w-2.5 h-2.5 bg-orange-500 rounded-full border-2 border-white dark:border-surface-dark"></div>}
                                </button>
                            );
                        })}
                    </div>
                </div>
            </div>

            {/* Report Modal */}
            {
                showReportModal && (
                    <div className="fixed inset-0 z-[100] flex items-center justify-center p-4 bg-black/50 backdrop-blur-sm animate-fade-in">
                        <div className="bg-white dark:bg-surface-dark rounded-2xl shadow-2xl max-w-md w-full p-6 border border-gray-100 dark:border-gray-800 transform transition-all scale-100">
                            <div className="flex justify-between items-center mb-4">
                                <h3 className="text-xl font-bold text-text-main dark:text-white flex items-center gap-2">
                                    <span className="material-symbols-outlined text-red-500">flag</span>
                                    Report Issue
                                </h3>
                                <button onClick={() => setShowReportModal(false)} className="text-gray-400 hover:text-text-main dark:hover:text-white">
                                    <span className="material-symbols-outlined">close</span>
                                </button>
                            </div>

                            <div className="flex flex-col gap-4">
                                <div className="flex flex-col gap-2">
                                    <label className="text-sm font-bold text-gray-700 dark:text-gray-300">Issue Type</label>
                                    <select
                                        value={reportReason}
                                        onChange={(e) => setReportReason(e.target.value)}
                                        className="w-full p-3 rounded-xl border border-gray-200 dark:border-gray-700 bg-transparent outline-none focus:ring-2 focus:ring-primary/50 text-sm"
                                    >
                                        <option value="content_error">Content Error (Question/Answer)</option>
                                        <option value="formatting">Formatting/Display Issue</option>
                                        <option value="explanation">Explanation is confusing</option>
                                        <option value="other">Other</option>
                                    </select>
                                </div>
                                <div className="flex flex-col gap-2">
                                    <label className="text-sm font-bold text-gray-700 dark:text-gray-300">Details (Optional)</label>
                                    <textarea
                                        placeholder="Please describe the issue..."
                                        className="w-full p-3 rounded-xl border border-gray-200 dark:border-gray-700 bg-transparent outline-none focus:ring-2 focus:ring-primary/50 text-sm h-24 resize-none"
                                    ></textarea>
                                </div>
                            </div>

                            <div className="flex gap-3 mt-6">
                                <button
                                    onClick={() => setShowReportModal(false)}
                                    disabled={isReporting}
                                    className="flex-1 py-3 rounded-xl font-bold text-gray-600 dark:text-gray-300 hover:bg-gray-100 dark:hover:bg-white/10 transition-colors disabled:opacity-50"
                                >
                                    Cancel
                                </button>
                                <button
                                    onClick={handleReportSubmit}
                                    disabled={isReporting}
                                    className="flex-1 py-3 rounded-xl font-bold bg-black dark:bg-white text-white dark:text-black hover:opacity-90 transition-all flex items-center justify-center gap-2 shadow-sm disabled:opacity-70"
                                >
                                    {isReporting ? (
                                        <>
                                            <span className="material-symbols-outlined animate-spin text-lg">progress_activity</span>
                                            Sending...
                                        </>
                                    ) : (
                                        'Submit Report'
                                    )}
                                </button>
                            </div>
                        </div>
                    </div>
                )
            }
        </div >
    );
};