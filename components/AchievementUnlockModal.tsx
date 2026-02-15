import React, { useEffect, useState } from 'react';
import { Title } from '../types';

interface AchievementUnlockModalProps {
    title: Title;
    onClose: () => void;
}

export const AchievementUnlockModal: React.FC<AchievementUnlockModalProps> = ({ title, onClose }) => {
    const [isVisible, setIsVisible] = useState(false);

    useEffect(() => {
        // Simple entrance animation trigger
        const timer = setTimeout(() => setIsVisible(true), 100);

        // Auto-close after 8 seconds if user doesn't dismiss
        const autoClose = setTimeout(() => {
            setIsVisible(false);
            setTimeout(onClose, 500);
        }, 8000);

        return () => {
            clearTimeout(timer);
            clearTimeout(autoClose);
        };
    }, [onClose]);

    const handleClose = () => {
        setIsVisible(false);
        setTimeout(onClose, 500); // Wait for exit animation
    };

    return (
        <div className={`fixed inset-0 z-[100] flex items-center justify-center p-4 transition-all duration-500 ${isVisible ? 'opacity-100' : 'opacity-0 pointer-events-none'}`}>
            {/* Backdrop */}
            <div
                className={`absolute inset-0 bg-black/60 backdrop-blur-md transition-all duration-500 ${isVisible ? 'animate-fade-in' : 'animate-fade-out'}`}
                onClick={handleClose}
            />

            {/* Modal Card */}
            <div className={`relative bg-surface-light dark:bg-surface-dark border border-white/20 dark:border-white/10 w-full max-w-md rounded-[2.5rem] p-8 shadow-2xl transition-all duration-700 ${isVisible ? 'animate-modal-in' : 'animate-modal-out'}`}>

                {/* Celebratory Background Effect */}
                <div className="absolute top-0 left-1/2 -translate-x-1/2 w-64 h-64 bg-primary/20 rounded-full blur-[80px] -z-10 animate-pulse" />

                <div className="flex flex-col items-center text-center gap-6">
                    {/* Icon / Trophy */}
                    <div className="relative">
                        <div className="w-24 h-24 bg-primary rounded-3xl flex items-center justify-center shadow-xl shadow-primary/30 rotate-12 animate-bounce-slow">
                            <span className="material-symbols-outlined text-5xl text-text-main">military_tech</span>
                        </div>
                        {/* Sparkles */}
                        <span className="material-symbols-outlined absolute -top-4 -right-4 text-primary animate-pulse text-3xl">auto_awesome</span>
                        <span className="material-symbols-outlined absolute -bottom-2 -left-6 text-primary animate-pulse delay-700 text-2xl">auto_awesome</span>
                    </div>

                    <div className="space-y-2">
                        <h2 className="text-sm font-black text-primary uppercase tracking-[0.2em]">New Achievement Unlocked!</h2>
                        <h1 className="text-3xl font-black text-text-main dark:text-white leading-tight">
                            {title.name}
                        </h1>
                    </div>

                    <p className="text-gray-500 dark:text-gray-400 font-medium leading-relaxed">
                        {title.description}
                    </p>

                    <div className="w-full h-px bg-gray-100 dark:bg-white/5" />

                    <div className="flex flex-col items-center gap-4 w-full">
                        <div className="flex items-center gap-2 bg-gray-50 dark:bg-white/5 px-4 py-2 rounded-2xl border border-gray-100 dark:border-white/5">
                            <span className="text-xs font-bold text-gray-400 dark:text-gray-500">CATEGORY:</span>
                            <span className="text-xs font-black text-text-main dark:text-gray-300 uppercase tracking-widest">{title.category.replace('_', ' ')}</span>
                        </div>

                        <button
                            onClick={handleClose}
                            className="w-full py-4 bg-primary rounded-2xl font-black text-lg text-text-main shadow-lg shadow-primary/20 hover:scale-[1.02] active:scale-[0.98] transition-all"
                        >
                            AWESOME!
                        </button>
                    </div>
                </div>

                {/* Close Button (X) */}
                <button
                    onClick={handleClose}
                    className="absolute top-6 right-6 text-gray-400 hover:text-text-main transition-colors"
                >
                    <span className="material-symbols-outlined">close</span>
                </button>
            </div>
        </div>
    );
};
