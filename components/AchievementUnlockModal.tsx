import React, { useEffect, useState } from 'react';
import { Title } from '../types';
import confetti from 'canvas-confetti';
import { useNavigate } from 'react-router-dom';
import { getUniqueTitleStyle } from '../src/utils/titleStyles';

interface AchievementUnlockModalProps {
    title: Title;
    onClose: () => void;
}

export const AchievementUnlockModal: React.FC<AchievementUnlockModalProps> = ({ title, onClose }) => {
    const [isVisible, setIsVisible] = useState(false);
    const navigate = useNavigate();
    const style = getUniqueTitleStyle(title.category, title.threshold);

    useEffect(() => {
        // Entrance animation
        const timer = setTimeout(() => setIsVisible(true), 100);

        // 1. Play Sound
        try {
            const audio = new Audio('/sounds/unlock.mp3'); // Assuming file exists or fails silently
            audio.volume = 0.5;
            audio.play().catch(() => { }); // Ignore interaction errors
        } catch (e) { }

        // 2. Fire Confetti
        const duration = 3000;
        const end = Date.now() + duration;

        const frame = () => {
            confetti({
                particleCount: 5,
                angle: 60,
                spread: 55,
                origin: { x: 0 },
                colors: ['#FFD700', '#FFA500', '#FF4500']
            });
            confetti({
                particleCount: 5,
                angle: 120,
                spread: 55,
                origin: { x: 1 },
                colors: ['#00BFFF', '#1E90FF', '#4169E1']
            });

            if (Date.now() < end) {
                requestAnimationFrame(frame);
            }
        };
        frame();

        // Auto-close after 10 seconds (extended time for celebration)
        const autoClose = setTimeout(() => {
            handleClose();
        }, 10000);

        return () => {
            clearTimeout(timer);
            clearTimeout(autoClose);
        };
    }, []);

    const handleClose = () => {
        setIsVisible(false);
        setTimeout(onClose, 500); // Wait for exit animation
    };

    const handleViewProfile = () => {
        handleClose();
        setTimeout(() => {
            // Navigate to profile to see the new title
            // We use 'me' or the actual ID if available in context, but here we just go to dashboard or profile
            // Best interaction: Go to Profile
            // Assuming User ID is available in parent or we can redirect to /profile/me if supported, 
            // but safe bet is just close or maybe navigate specific route if we had user context here.
            // Since we don't have user ID in props, we'll just close for now, 
            // or adding a "Go to Profile" if we can simply navigate.
            // We'll stick to closing for "Awesome" and offer a "View in Profile" which might require ID.
            // Let's just make the main button actionable.
        }, 300);
    };

    return (
        <div className={`fixed inset-0 z-[100] flex items-center justify-center p-4 transition-all duration-500 ${isVisible ? 'opacity-100' : 'opacity-0 pointer-events-none'}`}>
            {/* Backdrop */}
            <div
                className={`absolute inset-0 bg-black/80 backdrop-blur-lg transition-all duration-500 ${isVisible ? 'animate-fade-in' : 'animate-fade-out'}`}
                onClick={handleClose}
            />

            {/* Modal Card */}
            <div className={`relative bg-surface-light dark:bg-surface-dark border border-white/20 dark:border-white/10 w-full max-w-md rounded-[3rem] p-8 shadow-2xl transition-all duration-700 ${isVisible ? 'animate-modal-in' : 'animate-modal-out'} overflow-hidden`}>

                {/* Celebratory Background Effect - matches title color */}
                <div className={`absolute top-0 left-1/2 -translate-x-1/2 w-80 h-80 bg-gradient-to-br ${style.bg} opacity-20 rounded-full blur-[80px] -z-10 animate-pulse`} />

                <div className="flex flex-col items-center text-center gap-6 relative z-10">
                    {/* Icon / Trophy Container */}
                    <div className="relative mb-4">
                        <div className={`w-32 h-32 bg-gradient-to-br ${style.bg} rounded-[2rem] flex items-center justify-center shadow-2xl shadow-primary/30 rotate-12 animate-bounce-slow border-4 ${style.border}`}>
                            <span className={`material-symbols-outlined text-6xl ${style.text} drop-shadow-lg`}>{style.icon}</span>
                        </div>
                        {/* Floating Sparkles */}
                        <span className="material-symbols-outlined absolute -top-6 -right-6 text-yellow-400 animate-pulse text-4xl drop-shadow-lg">auto_awesome</span>
                        <span className="material-symbols-outlined absolute -bottom-4 -left-8 text-yellow-400 animate-pulse delay-700 text-3xl drop-shadow-lg">star</span>
                    </div>

                    <div className="space-y-3">
                        <h2 className="text-sm font-black text-primary uppercase tracking-[0.3em] animate-pulse">Unlocekd</h2>
                        <h1 className="text-4xl font-black text-transparent bg-clip-text bg-gradient-to-br from-text-main to-gray-500 dark:from-white dark:to-gray-400 leading-tight">
                            {title.name}
                        </h1>
                        <div className={`inline-flex items-center gap-2 px-3 py-1 rounded-full border ${style.border} bg-white/5`}>
                            <span className="material-symbols-outlined text-xs text-gray-400">category</span>
                            <span className="text-xs font-bold uppercase tracking-wider text-gray-500 dark:text-gray-400">{title.category.replace('_', ' ')}</span>
                        </div>
                    </div>

                    <p className="text-gray-600 dark:text-gray-300 font-medium leading-relaxed text-lg max-w-[80%]">
                        {title.description}
                    </p>

                    <div className="w-full h-px bg-gradient-to-r from-transparent via-gray-200 dark:via-gray-700 to-transparent my-2" />

                    <div className="flex flex-col w-full gap-3">
                        <button
                            onClick={handleClose}
                            className={`w-full py-4 rounded-2xl font-black text-lg shadow-xl hover:scale-[1.02] active:scale-[0.98] transition-all bg-gradient-to-r ${style.bg} ${style.text}`}
                        >
                            CLAIM TITLE
                        </button>

                        <button
                            onClick={handleClose}
                            className="text-sm font-bold text-gray-400 hover:text-text-main dark:hover:text-white transition-colors py-2"
                        >
                            Close
                        </button>
                    </div>
                </div>
            </div>
        </div>
    );
};
