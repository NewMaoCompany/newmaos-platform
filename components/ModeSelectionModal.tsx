import React, { useState } from 'react';
import { SessionMode } from '../types';

interface ModeSelectionModalProps {
    onSelect: (mode: 'Adaptive' | 'Review' | 'Random') => void;
}

const MODES: { mode: 'Adaptive' | 'Review' | 'Random'; icon: string; title: string; description: string; color: string }[] = [
    {
        mode: 'Adaptive',
        icon: 'psychology',
        title: 'Adaptive Mode',
        description: 'AI analyzes your learning curve and maximizes mastery gain. Best for systematic improvement.',
        color: 'from-blue-500 to-indigo-600'
    },
    {
        mode: 'Review',
        icon: 'history_edu',
        title: 'Review Mode',
        description: 'Focuses strictly on previously incorrect concepts. Best for fixing weak spots.',
        color: 'from-red-500 to-rose-600'
    },
    {
        mode: 'Random',
        icon: 'shuffle',
        title: 'Random Mode',
        description: 'Randomized mix of all topics for general retention. Best for broad practice.',
        color: 'from-emerald-500 to-teal-600'
    }
];

export const ModeSelectionModal: React.FC<ModeSelectionModalProps> = ({ onSelect }) => {
    const [selected, setSelected] = useState<'Adaptive' | 'Review' | 'Random' | null>(null);
    const [confirming, setConfirming] = useState(false);
    const [isSubmitting, setIsSubmitting] = useState(false);

    const handleConfirm = async () => {
        if (!selected || isSubmitting) return;
        setIsSubmitting(true);
        await onSelect(selected);
        setIsSubmitting(false);
    };

    return (
        <div className="fixed inset-0 z-[9999] flex items-center justify-center bg-black/60 backdrop-blur-sm animate-fade-in px-4">
            <div className="bg-white dark:bg-[#1a1a24] rounded-3xl shadow-2xl border border-gray-200 dark:border-gray-800 max-w-lg w-full p-6 sm:p-8 animate-fade-in-up">
                {/* Header */}
                <div className="text-center mb-6">
                    <div className="inline-flex items-center justify-center w-14 h-14 rounded-2xl bg-primary/10 mb-4">
                        <span className="material-symbols-outlined text-3xl text-primary">tune</span>
                    </div>
                    <h2 className="text-2xl font-black tracking-tight text-text-main dark:text-white mb-2">
                        Choose Your Practice Mode
                    </h2>
                    <p className="text-sm text-gray-500 dark:text-gray-400">
                        This will be your practice mode for the next <span className="font-bold text-text-main dark:text-white">6 months</span>.
                        Choose carefully — you won't be able to switch during this period.
                    </p>
                </div>

                {/* Mode Cards */}
                <div className="flex flex-col gap-3 mb-6">
                    {MODES.map((m) => (
                        <button
                            key={m.mode}
                            onClick={() => { setSelected(m.mode); setConfirming(false); }}
                            className={`text-left p-4 rounded-2xl border-2 transition-all duration-200 flex items-start gap-4 group
                                ${selected === m.mode
                                    ? 'border-primary bg-primary/5 dark:bg-primary/10 shadow-lg scale-[1.02]'
                                    : 'border-gray-200 dark:border-gray-700 hover:border-gray-300 dark:hover:border-gray-600 hover:bg-gray-50 dark:hover:bg-white/5'
                                }`}
                        >
                            <div className={`w-11 h-11 rounded-xl bg-gradient-to-br ${m.color} flex items-center justify-center shrink-0 shadow-md`}>
                                <span className="material-symbols-outlined text-white text-xl">{m.icon}</span>
                            </div>
                            <div className="flex-1 min-w-0">
                                <div className="flex items-center gap-2">
                                    <span className="font-bold text-sm text-text-main dark:text-white">{m.title}</span>
                                    {selected === m.mode && (
                                        <span className="material-symbols-outlined text-primary text-[18px]">check_circle</span>
                                    )}
                                </div>
                                <p className="text-xs text-gray-500 dark:text-gray-400 mt-0.5 leading-relaxed">{m.description}</p>
                            </div>
                        </button>
                    ))}
                </div>

                {/* Confirm Section */}
                {selected && !confirming && (
                    <button
                        onClick={() => setConfirming(true)}
                        className="w-full py-3.5 rounded-xl bg-primary text-black font-bold text-sm hover:bg-yellow-400 transition-all shadow-lg hover:shadow-xl hover:-translate-y-0.5 flex items-center justify-center gap-2"
                    >
                        Select {selected} Mode
                        <span className="material-symbols-outlined text-[18px]">arrow_forward</span>
                    </button>
                )}

                {selected && confirming && (
                    <div className="space-y-3">
                        <div className="bg-amber-50 dark:bg-amber-900/10 border border-amber-200 dark:border-amber-800 rounded-xl p-3 flex items-start gap-2.5">
                            <span className="material-symbols-outlined text-amber-600 dark:text-amber-400 text-lg mt-0.5">warning</span>
                            <p className="text-xs text-amber-800 dark:text-amber-300 leading-relaxed">
                                Are you sure? <strong>{selected} Mode</strong> will be locked for 6 months. This cannot be undone.
                            </p>
                        </div>
                        <div className="flex gap-3">
                            <button
                                onClick={() => setConfirming(false)}
                                className="flex-1 py-3 rounded-xl border border-gray-200 dark:border-gray-700 text-gray-600 dark:text-gray-400 font-bold text-sm hover:bg-gray-50 dark:hover:bg-white/5 transition-all"
                            >
                                Go Back
                            </button>
                            <button
                                onClick={handleConfirm}
                                disabled={isSubmitting}
                                className="flex-1 py-3 rounded-xl bg-primary text-black font-bold text-sm hover:bg-yellow-400 transition-all shadow-lg disabled:opacity-50 disabled:cursor-not-allowed flex items-center justify-center gap-2"
                            >
                                {isSubmitting ? (
                                    <>
                                        <span className="material-symbols-outlined text-[18px] animate-spin">progress_activity</span>
                                        Locking...
                                    </>
                                ) : (
                                    <>
                                        <span className="material-symbols-outlined text-[18px]">lock</span>
                                        Confirm & Lock
                                    </>
                                )}
                            </button>
                        </div>
                    </div>
                )}

                {!selected && (
                    <div className="text-center text-xs text-gray-400 dark:text-gray-500">
                        Select a mode above to continue
                    </div>
                )}
            </div>
        </div>
    );
};
