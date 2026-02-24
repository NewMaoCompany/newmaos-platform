import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { Question } from '../types';
import { MathRenderer } from '../components/MathRenderer';
import { InlineMath } from 'react-katex';
import { QuestionCommentSection } from './QuestionCommentSection';
import { useApp } from '../AppContext';
import 'katex/dist/katex.min.css';

interface SessionSummaryProps {
    questions: Question[];
    userAnswers: Record<string, string>;
    questionResults: Record<string, 'correct' | 'incorrect' | boolean>;
    onExit: () => void;
    onRetake: () => void;
    onReviewErrors?: () => void;
    summaryHistory?: {
        type?: 'first_attempt' | 'review';
        attemptNumber?: number;
        round?: number;
        label: string;
        timestamp: string;
        score?: number;
        userAnswers: Record<string, string>;
        questionResults: Record<string, 'correct' | 'incorrect' | boolean>;
    }[];
    justCompletedSessionLabel?: string | null;
    discussSlug?: string | null;
}

export const SessionSummary = ({
    questions,
    userAnswers: initialUserAnswers,
    questionResults: initialQuestionResults,
    onExit,
    onRetake,
    onReviewErrors,
    summaryHistory = [],
    justCompletedSessionLabel = null,
    discussSlug = null
}: SessionSummaryProps) => {
    // Determine default selection:
    // Use justCompletedSessionLabel to find and auto-select the session that was just completed
    const getDefaultIndex = () => {
        console.log('🔍 [SessionSummary] getDefaultIndex called');
        console.log('  justCompletedSessionLabel:', justCompletedSessionLabel);
        console.log('  summaryHistory length:', summaryHistory.length);
        console.log('  summaryHistory labels:', summaryHistory.map(h => h.label));

        if (justCompletedSessionLabel && summaryHistory.length > 0) {
            // Find the index of the session with matching label
            const index = summaryHistory.findIndex(h => h.label === justCompletedSessionLabel);
            console.log('  Found index:', index);
            if (index !== -1) {
                return index; // Auto-select the just-completed session
            }
        }
        // Fallback: select newest history or Current Session
        const fallback = summaryHistory.length > 0 ? 0 : -1;
        console.log('  Using fallback:', fallback);
        return fallback;
    };

    // Calculate initial index to avoid button delay
    const getInitialIndex = () => {
        if (justCompletedSessionLabel && summaryHistory.length > 0) {
            const index = summaryHistory.findIndex(h => h.label === justCompletedSessionLabel);
            if (index !== -1) return index;
        }
        // FIX: If we have current results (props), prefer showing them immediately (index -1)
        // instead of falling back to old history (index 0) which causes a "flash" of old scores.
        if (initialQuestionResults && Object.keys(initialQuestionResults).length > 0) {
            return -1;
        }
        return summaryHistory.length > 0 ? 0 : -1;
    };

    const [selectedHistoryIndex, setSelectedHistoryIndex] = useState<number>(getInitialIndex());
    const [historyExpanded, setHistoryExpanded] = useState(false); // Controls history dropdown
    const navigate = useNavigate();

    // useEffect to auto-select the just-completed session when props update
    useEffect(() => {
        console.log('🔍 [SessionSummary useEffect] triggered');
        console.log('  justCompletedSessionLabel:', justCompletedSessionLabel);
        console.log('  summaryHistory length:', summaryHistory.length);

        if (justCompletedSessionLabel && summaryHistory.length > 0) {
            const index = summaryHistory.findIndex(h => h.label === justCompletedSessionLabel);
            console.log('  Found index for label:', index);
            if (index !== -1) {
                setSelectedHistoryIndex(index);
                return;
            }
        }

        // Fallback Logic:
        // Only switch to history[0] if we DON'T have a valid current session to show.
        // If we have current session results, stay on -1.
        if (summaryHistory.length > 0) {
            const hasCurrentResults = initialQuestionResults && Object.keys(initialQuestionResults).length > 0;
            if (!hasCurrentResults && !justCompletedSessionLabel) {
                setSelectedHistoryIndex(0);
            }
        }
    }, [justCompletedSessionLabel, summaryHistory, initialQuestionResults]);

    // Derived Data based on selection
    const activeUserAnswers = selectedHistoryIndex === -1
        ? initialUserAnswers
        : summaryHistory[selectedHistoryIndex]?.userAnswers || {};

    const activeQuestionResults = selectedHistoryIndex === -1
        ? (initialQuestionResults && Object.keys(initialQuestionResults).length > 0 ? initialQuestionResults : (summaryHistory[summaryHistory.length - 1]?.questionResults || {}))
        : summaryHistory[selectedHistoryIndex]?.questionResults || {};

    // View State
    const [viewMode, setViewMode] = useState<'overview' | 'review'>('overview');
    const [reviewFilter, setReviewFilter] = useState<'all' | 'correct' | 'incorrect'>('all');
    const [visibleComments, setVisibleComments] = useState<Record<string, boolean>>({});

    // Safety check: Filter results that actually match passed questions
    const validResults = Object.entries(activeQuestionResults).filter(([qid]) => questions.some(q => q.id === qid));

    // Calculate Stats for ACTIVE selection
    // Dynamic Total: Use the actual number of results recorded for this session round.
    // This fixes the bug where Review rounds (subset of questions) incorrectly used the full chapter length.
    const total = selectedHistoryIndex === -1
        ? (Object.keys(activeQuestionResults).length > 0 ? Object.keys(activeQuestionResults).length : questions.length)
        : (validResults.length > 0 ? validResults.length : questions.length);

    // Count correct answers
    const correctCount = selectedHistoryIndex === -1
        ? Object.values(activeQuestionResults).filter(r => r === 'correct' || r === true).length
        : validResults.filter(([, r]) => r === 'correct' || r === true).length;

    // ROBUST: incorrectCount = total - correctCount (ensures they always add up)
    const incorrectCount = total - correctCount;

    // Accuracy based on total questions
    const attemptedCount = total;
    const accuracy = attemptedCount > 0 ? Math.round((correctCount / attemptedCount) * 100) : 0;

    // Determine Theme Configuration
    const getConfig = () => {
        if (accuracy >= 90) {
            return {
                icon: 'trophy',
                iconColor: 'text-yellow-500',
                title: 'Outstanding!',
                subtitle: 'You demonstrated mastery of this topic.',
                gradient: 'from-amber-400 to-orange-500',
                bgGradient: 'bg-gradient-to-br from-amber-50 to-orange-50 dark:from-amber-900/20 dark:to-orange-900/20'
            };
        } else if (accuracy >= 70) {
            return {
                icon: 'star',
                iconColor: 'text-emerald-500',
                title: 'Great Job!',
                subtitle: 'You\'re making solid progress.',
                gradient: 'from-emerald-400 to-teal-500',
                bgGradient: 'bg-gradient-to-br from-emerald-50 to-teal-50 dark:from-emerald-900/20 dark:to-teal-900/20'
            };
        } else if (accuracy >= 50) {
            return {
                icon: 'trending_up',
                iconColor: 'text-blue-500',
                title: 'Keep Going!',
                subtitle: 'Practice makes perfect.',
                gradient: 'from-blue-400 to-indigo-500',
                bgGradient: 'bg-gradient-to-br from-blue-50 to-indigo-50 dark:from-blue-900/20 dark:to-indigo-900/20'
            };
        } else {
            return {
                icon: 'psychology', // Brain icon instead of books
                iconColor: 'text-purple-500',
                title: 'Keep Practicing',
                subtitle: 'Review your mistakes to improve.',
                gradient: 'from-purple-400 to-pink-500',
                bgGradient: 'bg-gradient-to-br from-purple-50 to-pink-50 dark:from-purple-900/20 dark:to-pink-900/20'
            };
        }
    };

    const config = getConfig();

    const incorrectQuestions = questions.filter(q => activeQuestionResults[q.id] === 'incorrect' || activeQuestionResults[q.id] === false);

    const renderContent = (content: string, type?: 'text' | 'image', options: { noBorder?: boolean } = {}) => {
        if (!content) return null;

        let isImage = false;
        if (type) {
            isImage = type === 'image';
        } else {
            isImage = content.trim().startsWith('http') ||
                content.trim().startsWith('data:image') ||
                content.trim().startsWith('/');
        }

        if (isImage) {
            // Try to parse array for multiple images
            let imageUrls: string[] = [];
            try {
                const parsed = JSON.parse(content);
                if (Array.isArray(parsed)) imageUrls = parsed;
                else imageUrls = [content];
            } catch (e) {
                imageUrls = [content];
            }

            return (
                <div className={`flex flex-wrap gap-4 ${options.noBorder ? '' : 'p-4 rounded-xl bg-gray-50 dark:bg-zinc-800'}`}>
                    {imageUrls.map((url, i) => (
                        <img key={i} src={url} alt="Content" className="max-w-full h-auto rounded-lg shadow-sm" />
                    ))}
                </div>
            );
        }

        // Text content - use MathRenderer
        return <MathRenderer content={content} />;
    };

    if (viewMode === 'review') {
        return (
            <div className="min-h-screen max-h-screen overflow-y-auto bg-gray-50 dark:bg-black p-4 md:p-8 animate-fade-in flex flex-col items-center">
                <div className="w-full max-w-3xl pb-10">
                    <div className="mb-6 flex items-center justify-between">
                        <button
                            onClick={() => setViewMode('overview')}
                            className="flex items-center gap-2 text-gray-600 dark:text-gray-400 hover:text-black dark:hover:text-white transition-colors"
                        >
                            <span className="material-symbols-outlined">arrow_back</span>
                            Back
                        </button>
                        <div className="flex bg-gray-100 dark:bg-white/5 p-1 rounded-xl">
                            {(['all', 'correct', 'incorrect'] as const).map((f) => (
                                <button
                                    key={f}
                                    onClick={() => setReviewFilter(f)}
                                    className={`px-4 py-1.5 rounded-lg text-sm font-bold transition-all ${reviewFilter === f
                                        ? 'bg-white dark:bg-zinc-800 text-black dark:text-white shadow-sm'
                                        : 'text-gray-500 hover:text-gray-700 dark:hover:text-gray-300'
                                        }`}
                                >
                                    {f.charAt(0).toUpperCase() + f.slice(1)}
                                </button>
                            ))}
                        </div>
                    </div>

                    <div className="space-y-6">
                        {(() => {
                            const filteredQuestions = questions.filter(q => {
                                const result = activeQuestionResults[q.id];
                                // ONLY show questions that were part of this specific attempt (active set)
                                if (result === undefined || result === null) return false;

                                if (reviewFilter === 'all') return true;
                                if (reviewFilter === 'correct') return result === 'correct' || result === true;
                                if (reviewFilter === 'incorrect') return result === 'incorrect' || result === false;
                                return false;
                            });

                            if (filteredQuestions.length === 0) {
                                return (
                                    <div className="flex flex-col items-center justify-center py-20 px-4 text-center bg-white dark:bg-zinc-900 rounded-2xl border border-dashed border-gray-200 dark:border-gray-800">
                                        <div className="w-16 h-16 bg-gray-50 dark:bg-zinc-800 rounded-full flex items-center justify-center mb-4">
                                            <span className="material-symbols-outlined text-3xl text-gray-400">
                                                {reviewFilter === 'correct' ? 'sentiment_dissatisfied' : 'celebration'}
                                            </span>
                                        </div>
                                        <h3 className="text-lg font-bold text-gray-900 dark:text-white mb-1">
                                            {reviewFilter === 'correct' ? 'No correct questions found' : (reviewFilter === 'incorrect' ? 'No mistakes, great job!' : 'The list is empty')}
                                        </h3>
                                        <p className="text-sm text-gray-500 dark:text-gray-400">
                                            {reviewFilter === 'correct'
                                                ? 'Keep working hard! Review your materials and try again.'
                                                : (reviewFilter === 'incorrect' ? 'Congratulations! You answered all questions correctly.' : 'No questions to display under the current filter.')}
                                        </p>
                                    </div>
                                );
                            }

                            return filteredQuestions.map((q, idx) => {
                                const userAnswerId = activeUserAnswers[q.id];
                                const userAnswer = q.options.find(o => o.id === userAnswerId);
                                const correctAnswer = q.options.find(o => o.id === q.correctOptionId);

                                return (
                                    <div key={q.id} className="bg-white dark:bg-zinc-900 rounded-2xl p-6 shadow-sm border border-gray-100 dark:border-gray-800">
                                        <div className="flex items-start gap-4 mb-4">
                                            <div className={`w-8 h-8 rounded-full flex items-center justify-center shrink-0 font-bold text-sm ${(activeQuestionResults[q.id] === 'correct' || activeQuestionResults[q.id] === true)
                                                ? 'bg-green-100 dark:bg-green-900/30 text-green-600 dark:text-green-400'
                                                : 'bg-red-100 dark:bg-red-900/30 text-red-600 dark:text-red-400'
                                                }`}>
                                                {idx + 1}
                                            </div>
                                            <div className="flex-1">
                                                <div className="text-base text-gray-900 dark:text-gray-100 font-medium font-bold">
                                                    {renderContent(q.prompt, q.promptType, { noBorder: true })}
                                                </div>
                                            </div>
                                        </div>

                                        <div className="grid grid-cols-1 md:grid-cols-2 gap-4 ml-12">
                                            <div className={`p-4 rounded-xl border ${(activeQuestionResults[q.id] === 'correct' || activeQuestionResults[q.id] === true) ? 'bg-green-50 dark:bg-green-900/10 border-green-100 dark:border-green-900/30' : 'bg-red-50 dark:bg-red-900/10 border-red-100 dark:border-red-900/30'}`}>
                                                <div className={`text-xs font-bold uppercase tracking-widest mb-2 flex items-center gap-1 ${(activeQuestionResults[q.id] === 'correct' || activeQuestionResults[q.id] === true) ? 'text-green-600' : 'text-red-500'}`}>
                                                    <span className="material-symbols-outlined text-sm">{(activeQuestionResults[q.id] === 'correct' || activeQuestionResults[q.id] === true) ? 'check' : 'close'}</span>
                                                    Your Answer {userAnswerId ? `(${userAnswerId})` : ''}
                                                </div>
                                                <div className="text-gray-800 dark:text-gray-200">
                                                    {userAnswer ? (
                                                        renderContent(userAnswer.value, userAnswer.type, { noBorder: true })
                                                    ) : <span className="text-gray-400 italic">No answer selected</span>}
                                                </div>
                                            </div>

                                            <div className="p-4 rounded-xl bg-green-50 dark:bg-green-900/10 border border-green-100 dark:border-green-900/30">
                                                <div className="text-xs font-bold text-green-600 uppercase tracking-widest mb-2 flex items-center gap-1">
                                                    <span className="material-symbols-outlined text-sm">check</span>
                                                    Correct Answer ({q.correctOptionId})
                                                </div>
                                                <div className="text-gray-800 dark:text-gray-200">
                                                    {correctAnswer ? (
                                                        renderContent(correctAnswer.value || (correctAnswer as any).text || '', correctAnswer.type, { noBorder: true })
                                                    ) : <span className="text-gray-400 italic">Unknown</span>}
                                                </div>
                                            </div>
                                        </div>

                                        {/* Option Feedback (Micro Explanations) */}
                                        {userAnswerId && (userAnswer?.explanation || q.microExplanations?.[userAnswerId]) && (
                                            <div className="mt-4 ml-12 p-3 bg-gray-50 dark:bg-white/5 rounded-xl border border-gray-100 dark:border-gray-800">
                                                <div className="text-[10px] font-bold text-primary uppercase tracking-widest mb-1 flex items-center gap-1">
                                                    <span className="material-symbols-outlined text-xs">lightbulb</span>
                                                    Option Feedback
                                                </div>
                                                <div className="text-xs text-gray-600 dark:text-gray-400">
                                                    {renderContent(userAnswer?.explanation || q.microExplanations?.[userAnswerId] || '', 'text', { noBorder: true })}
                                                </div>
                                            </div>
                                        )}

                                        {q.explanation && (
                                            <div className="mt-4 ml-12 p-4 bg-white dark:bg-white/5 rounded-xl border border-gray-100 dark:border-gray-800">
                                                <div className="text-xs font-bold text-blue-500 uppercase tracking-widest mb-1">Explanation</div>
                                                <div className="text-sm text-gray-700 dark:text-gray-300 leading-relaxed">
                                                    {renderContent(q.explanation, q.explanationType, { noBorder: true })}
                                                </div>
                                            </div>
                                        )}

                                        <div className="mt-4 ml-12 flex justify-start">
                                            <button
                                                onClick={() => setVisibleComments(prev => ({ ...prev, [q.id]: !prev[q.id] }))}
                                                className={`flex items-center gap-2 px-4 py-2 rounded-lg text-xs font-bold transition-all ${visibleComments[q.id] ? 'bg-primary text-white shadow-sm' : 'bg-indigo-50 dark:bg-indigo-900/10 text-indigo-600 dark:text-indigo-400 hover:bg-indigo-100 dark:hover:bg-indigo-900/20'}`}
                                            >
                                                <span className="material-symbols-outlined text-sm">forum</span>
                                                {visibleComments[q.id] ? 'Hide Comments' : 'Discuss this Question'}
                                            </button>
                                        </div>

                                        {visibleComments[q.id] && (
                                            <div className="mt-2 ml-12">
                                                <QuestionCommentSection
                                                    questionId={q.id}
                                                    channelSlug={discussSlug}
                                                />
                                            </div>
                                        )}
                                    </div>
                                );
                            });
                        })()}
                    </div>
                </div>
            </div>
        );
    }

    return (
        <div className="min-h-screen bg-background-light dark:bg-background-dark flex flex-col items-center justify-center p-6 animate-fade-in relative overflow-hidden">
            {/* Background Decorations */}
            <div className={`absolute top-0 left-0 w-full h-[40vh] bg-gradient-to-b ${config.bgGradient} opacity-50 -z-10`}></div>
            <div className="absolute top-1/4 left-1/4 w-64 h-64 bg-primary/20 rounded-full blur-3xl -z-10 animate-pulse-slow"></div>

            {/* Content Card */}
            <div className="w-full max-w-xl bg-white/80 dark:bg-black/40 backdrop-blur-xl rounded-[2.5rem] p-8 md:p-10 text-center shadow-[0_20px_60px_-15px_rgba(0,0,0,0.1)] border border-white/50 dark:border-white/10 relative">

                {/* Floating Icon Header */}
                <div className="absolute -top-7 left-1/2 -translate-x-1/2">
                    <div className="w-12 h-12 bg-white dark:bg-zinc-900 rounded-full shadow-xl flex items-center justify-center border-4 border-white dark:border-zinc-800">
                        <span className={`material-symbols-outlined text-xl ${config.iconColor} drop-shadow-sm`}>
                            {config.icon}
                        </span>
                    </div>
                </div>

                <div className="mt-2 mb-2">
                    <h1 className="text-lg md:text-xl font-black mb-1 text-gray-900 dark:text-white tracking-tight">
                        {config.title}
                    </h1>
                    <p className="text-xs text-gray-500 dark:text-gray-400 leading-relaxed max-w-xs mx-auto">
                        {config.subtitle}
                    </p>
                </div>

                {/* History Selector - Vertical Dropdown Style */}
                {summaryHistory.length > 0 && (
                    <div className="mb-6 relative">
                        {/* Current Selection Button */}
                        <button
                            onClick={() => setHistoryExpanded(!historyExpanded)}
                            className="w-full flex items-center justify-between p-3 bg-gray-50 dark:bg-white/5 rounded-2xl border border-gray-200 dark:border-gray-700 hover:border-gray-300 dark:hover:border-gray-600 transition-all"
                        >
                            <div className="flex items-center gap-3">
                                <div className={`w-8 h-8 rounded-full flex items-center justify-center ${selectedHistoryIndex === -1
                                    ? 'bg-blue-100 dark:bg-blue-900/30 text-blue-600 dark:text-blue-400'
                                    : 'bg-zinc-100 dark:bg-zinc-800 text-zinc-600 dark:text-zinc-400'
                                    }`}>
                                    <span className="material-symbols-outlined text-lg">
                                        history
                                    </span>
                                </div>
                                <div className="text-left">
                                    <div className="font-bold text-gray-900 dark:text-white leading-tight">
                                        <span className="text-xs font-bold opacity-60">
                                            {selectedHistoryIndex === -1 ? 'Current Session' : (summaryHistory[selectedHistoryIndex]?.label || 'Past Attempt')}
                                        </span>
                                    </div>
                                    <div className="text-[10px] text-gray-500 dark:text-gray-400">
                                        {selectedHistoryIndex === -1
                                            ? 'Latest results'
                                            : new Date(summaryHistory[selectedHistoryIndex]?.timestamp).toLocaleDateString()
                                        }
                                    </div>
                                </div>
                            </div>
                            <span className={`material-symbols-outlined text-gray-400 transition-transform ${historyExpanded ? 'rotate-180' : ''}`}>
                                expand_more
                            </span>
                        </button>

                        {/* Dropdown List */}
                        {historyExpanded && (
                            <div className="absolute top-full left-0 right-0 mt-2 bg-white dark:bg-zinc-900 rounded-2xl shadow-2xl border border-gray-200 dark:border-gray-700 z-50 max-h-64 overflow-y-auto scroll-bounce">
                                <div className="py-2">
                                    {/* Link to Current Props Results if viewing history */}
                                    {initialQuestionResults && Object.keys(initialQuestionResults).length > 0 && (
                                        <button
                                            onClick={() => { setSelectedHistoryIndex(-1); setHistoryExpanded(false); }}
                                            className={`w-full text-left px-5 py-3 hover:bg-gray-50 dark:hover:bg-white/5 transition-colors flex items-center justify-between ${selectedHistoryIndex === -1 ? 'text-primary' : 'text-text-main dark:text-white'}`}
                                        >
                                            <div className="flex items-center gap-3">
                                                <span className="material-symbols-outlined text-[18px]">bolt</span>
                                                <span className="font-bold text-sm">Current Session</span>
                                                <span className="text-[9px] opacity-50">Latest cumulative</span>
                                            </div>
                                            {selectedHistoryIndex === -1 && <span className="material-symbols-outlined text-[18px]">check_circle</span>}
                                        </button>
                                    )}

                                    {[...summaryHistory].reverse().map((hist, idx) => {
                                        const actualIndex = summaryHistory.length - 1 - idx;
                                        return (
                                            <button
                                                key={hist.timestamp + actualIndex}
                                                onClick={() => { setSelectedHistoryIndex(actualIndex); setHistoryExpanded(false); }}
                                                className={`w-full text-left px-5 py-3 hover:bg-gray-50 dark:hover:bg-white/5 transition-colors flex items-center justify-between ${selectedHistoryIndex === actualIndex ? 'text-primary' : 'text-text-main dark:text-white'}`}
                                            >
                                                <div className="flex items-center gap-3">
                                                    <span className="material-symbols-outlined text-[18px]">
                                                        {hist.type === 'review' ? 'history_edu' : 'first_page'}
                                                    </span>
                                                    <div className="flex flex-col">
                                                        <span className="font-bold text-sm">{hist.label}</span>
                                                        <span className="text-[9px] opacity-50">{new Date(hist.timestamp).toLocaleString()}</span>
                                                    </div>
                                                </div>
                                                <div className="flex items-center gap-2">
                                                    <span className="text-xs font-black">{hist.score}%</span>
                                                    {selectedHistoryIndex === actualIndex && <span className="material-symbols-outlined text-[18px]">check_circle</span>}
                                                </div>
                                            </button>
                                        );
                                    })}
                                </div>
                            </div>
                        )}
                    </div>
                )}

                {/* Vertical Stack Stats */}
                <div className="flex flex-col gap-3 mb-6">
                    <div className="flex items-center justify-between p-3 bg-gray-50 dark:bg-white/5 rounded-2xl">
                        <div className="flex items-center gap-3">
                            <div className="w-8 h-8 rounded-full bg-green-100 dark:bg-green-900/30 flex items-center justify-center text-green-600 dark:text-green-400">
                                <span className="material-symbols-outlined text-lg">check_circle</span>
                            </div>
                            <div className="text-left">
                                <div className="text-[10px] font-semibold text-gray-500 dark:text-gray-400 uppercase tracking-wider">Correct</div>
                                <div className="text-lg font-black text-gray-900 dark:text-white leading-tight">{correctCount}</div>
                            </div>
                        </div>
                        <div className="h-8 w-px bg-gray-200 dark:bg-gray-700"></div>
                        <div className="flex items-center gap-3">
                            <div className="w-8 h-8 rounded-full bg-red-100 dark:bg-red-900/30 flex items-center justify-center text-red-600 dark:text-red-400">
                                <span className="material-symbols-outlined text-lg">cancel</span>
                            </div>
                            <div className="text-left">
                                <div className="text-[10px] font-semibold text-gray-500 dark:text-gray-400 uppercase tracking-wider">Mistakes</div>
                                <div className="text-lg font-black text-gray-900 dark:text-white leading-tight">{incorrectCount}</div>
                            </div>
                        </div>
                        <div className="h-8 w-px bg-gray-200 dark:bg-gray-700"></div>
                        <div className="flex items-center gap-3">
                            <div className="w-8 h-8 rounded-full bg-amber-100 dark:bg-amber-900/30 flex items-center justify-center text-amber-600 dark:text-amber-400">
                                <span className="material-symbols-outlined text-lg">monetization_on</span>
                            </div>
                            <div className="text-left">
                                <div className="text-[10px] font-semibold text-gray-500 dark:text-gray-400 uppercase tracking-wider">Coins</div>
                                <div className="text-lg font-black text-gray-900 dark:text-white leading-tight">+{correctCount * 5}</div>
                            </div>
                        </div>
                    </div>

                    <div className="relative p-4 bg-gradient-to-r from-gray-900 to-gray-800 dark:from-zinc-800 dark:to-zinc-900 rounded-2xl text-white overflow-hidden shadow-lg group">
                        <div className="relative z-10 flex flex-col items-center">
                            <div className="text-4xl font-black tracking-tight mb-0.5">{accuracy}%</div>
                            <div className="text-[10px] font-bold uppercase tracking-widest opacity-60">Accuracy Score</div>
                        </div>
                        <div className="absolute bottom-0 left-0 w-full h-8 opacity-20">
                            <svg className="w-full h-full" viewBox="0 0 100 40" preserveAspectRatio="none">
                                <path d="M0,40 Q25,10 50,30 T100,20 V40 H0 Z" fill="currentColor" />
                            </svg>
                        </div>
                    </div>
                </div>

                {/* Actions */}
                <div className="space-y-2.5 min-h-[160px] flex flex-col justify-end">
                    {/* 1. Review Errors (Priority if mistakes exist) - Show for Current Session AND Review entries */}
                    {incorrectCount > 0 && onReviewErrors && (
                        <button
                            onClick={onReviewErrors}
                            className="w-full py-3.5 rounded-xl font-bold bg-red-500 text-white hover:brightness-110 hover:shadow-lg hover:shadow-red-500/30 transition-all flex items-center justify-center gap-2"
                        >
                            <span className="material-symbols-outlined text-[20px]">replay_circle_filled</span>
                            Review Errors ({incorrectCount})
                        </button>
                    )}



                    {/* 3. Review Questions (Internal View) */}
                    <button
                        onClick={() => {
                            setReviewFilter('all');
                            setViewMode('review');
                        }}
                        className="w-full py-3 rounded-xl font-bold border-2 border-gray-200 dark:border-gray-700 text-gray-700 dark:text-gray-200 hover:border-gray-400 dark:hover:border-gray-500 transition-all flex items-center justify-center gap-2 group text-sm"
                    >
                        <span className="material-symbols-outlined text-[20px] group-hover:scale-110 transition-transform">history_edu</span>
                        View Summary Details
                    </button>

                    {/* Forum Shortcut (Only if NO pending errors to review) */}
                    {(selectedHistoryIndex !== -1 || incorrectCount === 0) && (
                        <button
                            onClick={() => navigate('/forum')}
                            className="w-full py-3 rounded-xl font-bold border-2 border-indigo-100 dark:border-indigo-900/30 text-indigo-600 dark:text-indigo-400 bg-indigo-50 dark:bg-indigo-900/10 hover:bg-indigo-100 dark:hover:bg-indigo-900/20 transition-all flex items-center justify-center gap-2 group text-sm"
                        >
                            <span className="material-symbols-outlined text-[20px]">forum</span>
                            Discuss in Forum
                        </button>
                    )}

                    {/* 4. Complete / Back */}
                    <button
                        onClick={onExit}
                        className={`w-full py-3.5 rounded-xl font-bold ${selectedHistoryIndex === -1 && incorrectCount === 0 ? 'bg-primary text-black' : 'bg-gray-100 dark:bg-white/10 text-gray-900 dark:text-white'} hover:brightness-105 transition-all flex items-center justify-center gap-2 text-sm`}
                    >
                        <span className="material-symbols-outlined text-[20px]">done_all</span>
                        {selectedHistoryIndex === -1 && incorrectCount === 0 ? 'Finish Practice' : 'Back to List'}
                    </button>
                </div>
            </div>
        </div>
    );
};
