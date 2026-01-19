import React, { useState } from 'react';
import { Question } from '../types';
import { InlineMath } from 'react-katex';
import 'katex/dist/katex.min.css';

interface SessionSummaryProps {
    questions: Question[];
    userAnswers: Record<string, string>;
    questionResults: Record<string, 'correct' | 'incorrect'>;
    onExit: () => void;
    onRetake: () => void;
}

export const SessionSummary = ({
    questions,
    userAnswers,
    questionResults,
    onExit,
    onRetake
}: SessionSummaryProps) => {
    const [viewMode, setViewMode] = useState<'overview' | 'review'>('overview');

    // Calculate Stats
    const total = questions.length;
    const correctCount = Object.values(questionResults).filter(r => r === 'correct').length;
    const accuracy = total > 0 ? Math.round((correctCount / total) * 100) : 0;
    const incorrectCount = total - correctCount;

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

    const incorrectQuestions = questions.filter(q => questionResults[q.id] === 'incorrect');

    if (viewMode === 'review') {
        return (
            <div className="min-h-screen bg-gray-50 dark:bg-black p-4 md:p-8 animate-fade-in flex flex-col items-center">
                <div className="w-full max-w-3xl">
                    <div className="mb-6 flex items-center justify-between">
                        <button
                            onClick={() => setViewMode('overview')}
                            className="flex items-center gap-2 text-gray-600 dark:text-gray-400 hover:text-black dark:hover:text-white transition-colors"
                        >
                            <span className="material-symbols-outlined">arrow_back</span>
                            Back to Summary
                        </button>
                        <h2 className="text-xl font-bold">Review Mistakes ({incorrectCount})</h2>
                    </div>

                    <div className="space-y-6">
                        {incorrectQuestions.map((q, idx) => {
                            const userAnswerId = userAnswers[q.id];
                            const userAnswer = q.options.find(o => o.id === userAnswerId);
                            const correctAnswer = q.options.find(o => o.id === q.correctOptionId);

                            return (
                                <div key={q.id} className="bg-white dark:bg-zinc-900 rounded-2xl p-6 shadow-sm border border-gray-100 dark:border-gray-800">
                                    <div className="flex items-start gap-4 mb-4">
                                        <div className="w-8 h-8 rounded-full bg-red-100 dark:bg-red-900/30 flex items-center justify-center shrink-0 text-red-600 dark:text-red-400 font-bold text-sm">
                                            {idx + 1}
                                        </div>
                                        <div className="flex-1">
                                            <div className="prose dark:prose-invert max-w-none text-base">
                                                {/* Use ContentRenderer concept or simple HTML if trusted */}
                                                <div dangerouslySetInnerHTML={{ __html: q.prompt }} />
                                            </div>
                                        </div>
                                    </div>

                                    <div className="grid grid-cols-1 md:grid-cols-2 gap-4 ml-12">
                                        <div className="p-4 rounded-xl bg-red-50 dark:bg-red-900/10 border border-red-100 dark:border-red-900/30">
                                            <div className="text-xs font-bold text-red-500 uppercase tracking-widest mb-2 flex items-center gap-1">
                                                <span className="material-symbols-outlined text-sm">close</span>
                                                Your Answer
                                            </div>
                                            <div className="text-gray-800 dark:text-gray-200">
                                                {userAnswer ? (
                                                    <InlineMath>{userAnswer.value}</InlineMath> // Assuming simple text or latex
                                                ) : <span className="text-gray-400 italic">No answer selected</span>}
                                            </div>
                                        </div>

                                        <div className="p-4 rounded-xl bg-green-50 dark:bg-green-900/10 border border-green-100 dark:border-green-900/30">
                                            <div className="text-xs font-bold text-green-600 uppercase tracking-widest mb-2 flex items-center gap-1">
                                                <span className="material-symbols-outlined text-sm">check</span>
                                                Correct Answer
                                            </div>
                                            <div className="text-gray-800 dark:text-gray-200">
                                                {correctAnswer ? (
                                                    <InlineMath>{correctAnswer.value}</InlineMath>
                                                ) : <span className="text-gray-400 italic">Unknown</span>}
                                            </div>
                                        </div>
                                    </div>

                                    {q.explanation && (
                                        <div className="mt-4 ml-12 p-4 bg-blue-50 dark:bg-blue-900/10 rounded-xl border border-blue-100 dark:border-blue-900/30">
                                            <div className="text-xs font-bold text-blue-500 uppercase tracking-widest mb-1">Explanation</div>
                                            <p className="text-sm text-gray-700 dark:text-gray-300 leading-relaxed">{q.explanation}</p>
                                        </div>
                                    )}
                                </div>
                            );
                        })}
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

            <div className="w-full max-w-md bg-white/80 dark:bg-black/40 backdrop-blur-xl rounded-[2.5rem] p-8 md:p-12 text-center shadow-[0_20px_60px_-15px_rgba(0,0,0,0.1)] border border-white/50 dark:border-white/10 relative">

                {/* Floating Icon Header */}
                <div className="absolute -top-12 left-1/2 -translate-x-1/2">
                    <div className="w-24 h-24 bg-white dark:bg-zinc-900 rounded-full shadow-xl flex items-center justify-center border-4 border-white dark:border-zinc-800">
                        <span className={`material-symbols-outlined text-5xl ${config.iconColor} drop-shadow-sm`}>
                            {config.icon}
                        </span>
                    </div>
                </div>

                <div className="mt-10 mb-8">
                    <h1 className="text-3xl md:text-4xl font-black mb-3 text-gray-900 dark:text-white tracking-tight">
                        {config.title}
                    </h1>
                    <p className="text-lg text-gray-500 dark:text-gray-400 leading-relaxed max-w-xs mx-auto">
                        {config.subtitle}
                    </p>
                </div>

                {/* Vertical Stack Stats */}
                <div className="flex flex-col gap-4 mb-10">
                    <div className="flex items-center justify-between p-4 bg-gray-50 dark:bg-white/5 rounded-2xl">
                        <div className="flex items-center gap-3">
                            <div className="w-10 h-10 rounded-full bg-green-100 dark:bg-green-900/30 flex items-center justify-center text-green-600 dark:text-green-400">
                                <span className="material-symbols-outlined">check_circle</span>
                            </div>
                            <div className="text-left">
                                <div className="text-sm font-semibold text-gray-500 dark:text-gray-400">Correct</div>
                                <div className="text-xl font-bold text-gray-900 dark:text-white">{correctCount}</div>
                            </div>
                        </div>
                        <div className="h-8 w-px bg-gray-200 dark:bg-gray-700"></div>
                        <div className="flex items-center gap-3">
                            <div className="w-10 h-10 rounded-full bg-red-100 dark:bg-red-900/30 flex items-center justify-center text-red-600 dark:text-red-400">
                                <span className="material-symbols-outlined">cancel</span>
                            </div>
                            <div className="text-left">
                                <div className="text-sm font-semibold text-gray-500 dark:text-gray-400">Mistakes</div>
                                <div className="text-xl font-bold text-gray-900 dark:text-white">{incorrectCount}</div>
                            </div>
                        </div>
                    </div>

                    <div className="relative p-6 bg-gradient-to-r from-gray-900 to-gray-800 dark:from-zinc-800 dark:to-zinc-900 rounded-2xl text-white overflow-hidden shadow-lg group">
                        <div className="relative z-10 flex flex-col items-center">
                            <div className="text-5xl font-black tracking-tight mb-1">{accuracy}%</div>
                            <div className="text-xs font-bold uppercase tracking-widest opacity-60">Accuracy Score</div>
                        </div>
                        {/* Decorative Chart Line */}
                        <div className="absolute bottom-0 left-0 w-full h-12 opacity-20">
                            <svg className="w-full h-full" viewBox="0 0 100 40" preserveAspectRatio="none">
                                <path d="M0,40 Q25,10 50,30 T100,20 V40 H0 Z" fill="currentColor" />
                            </svg>
                        </div>
                    </div>
                </div>

                {/* Actions */}
                <div className="space-y-3">
                    {incorrectCount > 0 && (
                        <button
                            onClick={() => setViewMode('review')}
                            className="w-full py-3.5 rounded-xl font-bold border-2 border-gray-200 dark:border-gray-700 text-gray-700 dark:text-gray-200 hover:border-primary hover:text-primary transition-all flex items-center justify-center gap-2 group"
                        >
                            <span className="material-symbols-outlined group-hover:scale-110 transition-transform">history_edu</span>
                            Review Mistakes
                        </button>
                    )}

                    <button
                        onClick={onExit}
                        className="w-full py-4 rounded-xl font-bold bg-primary text-black hover:brightness-105 hover:shadow-lg hover:shadow-primary/20 transition-all flex items-center justify-center gap-2"
                    >
                        <span className="material-symbols-outlined">done_all</span>
                        Complete Session
                    </button>
                </div>
            </div>
        </div>
    );
};
