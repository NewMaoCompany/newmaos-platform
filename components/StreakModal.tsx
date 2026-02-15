import React, { useEffect, useState } from 'react';
import confetti from 'canvas-confetti';
import { PointsCoin } from './PointsCoin';

interface StreakModalProps {
    isOpen: boolean;
    streak: number;
    onClose: () => void;
    isRecovery?: boolean;
    // Points check-in result
    checkinResult?: {
        basePoints?: number;
        bonusPoints?: number;
        totalPoints?: number;
        isMilestone?: boolean;
        alreadyCheckedIn?: boolean;
    } | null;
}

// 30-Day Blueprint Preview
const BLUEPRINT: { day: number; base: number; bonus: number }[] = [
    { day: 7, base: 10, bonus: 50 },
    { day: 14, base: 15, bonus: 80 },
    { day: 21, base: 20, bonus: 120 },
    { day: 30, base: 25, bonus: 300 },
];

export const StreakModal: React.FC<StreakModalProps> = ({ isOpen, streak, onClose, isRecovery, checkinResult }) => {
    const [visible, setVisible] = useState(false);

    const points = checkinResult?.totalPoints || 0;
    const bonus = checkinResult?.bonusPoints || 0;
    const base = checkinResult?.basePoints || 0;
    const isMilestone = checkinResult?.isMilestone || false;
    const alreadyCheckedIn = checkinResult?.alreadyCheckedIn || false;

    const coinRef = React.useRef<HTMLDivElement>(null);

    useEffect(() => {
        if (isOpen) {
            setVisible(true);
            // Confetti effect
            if (!alreadyCheckedIn) {
                const duration = isMilestone ? 5000 : 2500;
                const end = Date.now() + duration;
                const colors = isMilestone
                    ? ['#FFD700', '#FFA500', '#FF6347', '#f9d406', '#34C759']
                    : ['#ff5722', '#ff9800', '#ffd600'];

                const frame = () => {
                    confetti({
                        particleCount: isMilestone ? 6 : 2,
                        angle: 60,
                        spread: isMilestone ? 80 : 55,
                        origin: { x: 0 },
                        colors
                    });
                    confetti({
                        particleCount: isMilestone ? 6 : 2,
                        angle: 120,
                        spread: isMilestone ? 80 : 55,
                        origin: { x: 1 },
                        colors
                    });

                    if (Date.now() < end) {
                        requestAnimationFrame(frame);
                    }
                };
                frame();

                // Trigger Flying Coins Animation (after modal transition)
                if (points > 0) {
                    setTimeout(() => {
                        if (coinRef.current) {
                            const rect = coinRef.current.getBoundingClientRect();
                            const event = new CustomEvent('coin-collect', {
                                detail: {
                                    amount: points,
                                    x: rect.left + rect.width / 2,
                                    y: rect.top + rect.height / 2
                                }
                            });
                            window.dispatchEvent(event);
                        }
                    }, 600); // Wait for modal entry animation
                }
            }
        } else {
            setTimeout(() => setVisible(false), 300);
        }
    }, [isOpen]);

    if (!visible && !isOpen) return null;

    // Find next milestone
    const nextMilestone = BLUEPRINT.find(m => m.day > streak) || BLUEPRINT[BLUEPRINT.length - 1];

    return (
        <div className={`fixed inset-0 z-50 flex items-center justify-center transition-all duration-300 ${isOpen ? 'opacity-100' : 'opacity-0 pointer-events-none'}`}>
            {/* Backdrop */}
            <div className={`absolute inset-0 bg-black/60 backdrop-blur-sm transition-all duration-500 ${isOpen ? 'animate-fade-in' : 'animate-fade-out'}`} onClick={onClose}></div>

            {/* Modal Content */}
            <div className={`relative bg-white dark:bg-zinc-900 rounded-3xl p-8 max-w-sm w-full mx-4 shadow-2xl transform transition-all duration-500 ${isOpen ? 'animate-modal-in' : 'animate-modal-out'}`}>

                {/* Milestone Glow */}
                {isMilestone && (
                    <div className="absolute inset-0 rounded-3xl bg-gradient-to-br from-primary/20 via-transparent to-amber-500/20 animate-pulse pointer-events-none" />
                )}

                <div className="flex flex-col items-center text-center relative">
                    {/* Icon */}
                    <div className={`w-24 h-24 rounded-full flex items-center justify-center mb-6 shadow-lg ${isMilestone ? 'bg-gradient-to-br from-yellow-400 via-primary to-amber-600 animate-bounce' : 'bg-gradient-to-br from-orange-400 to-red-500 animate-bounce'}`}>
                        {isMilestone ? (
                            <span className="text-5xl">🏆</span>
                        ) : alreadyCheckedIn ? (
                            <span className="text-5xl">✅</span>
                        ) : (
                            <span className="text-5xl">🔥</span>
                        )}
                    </div>

                    {/* Title */}
                    <h2 className={`text-3xl font-black mb-2 ${isMilestone ? 'text-transparent bg-clip-text bg-gradient-to-r from-yellow-500 via-primary to-amber-600' : 'text-transparent bg-clip-text bg-gradient-to-r from-orange-500 to-red-600'}`}>
                        {alreadyCheckedIn ? 'Already Checked In!' : isMilestone ? `Day ${streak} Milestone!` : isRecovery ? 'Streak Restored!' : 'Check-in Complete!'}
                    </h2>

                    {/* Streak Count */}
                    <div className="text-6xl font-black text-gray-800 dark:text-white mb-1 font-mono">
                        {streak}
                    </div>
                    <p className="text-gray-500 dark:text-gray-400 font-medium text-xs uppercase tracking-widest mb-4">
                        {streak === 1 ? 'Day Streak Started' : 'Days in a Row'}
                    </p>

                    {/* Points Reward */}
                    {!alreadyCheckedIn && points > 0 && (
                        <div ref={coinRef} className="w-full p-4 rounded-2xl bg-primary/5 border border-primary/20 mb-4">
                            <div className="flex items-center justify-center gap-3">
                                <PointsCoin size="md" />
                                <span className="text-3xl font-black text-primary">+{points}</span>
                            </div>
                            {bonus > 0 && (
                                <div className="flex items-center justify-center gap-2 mt-2">
                                    <span className="text-xs font-bold text-gray-500">Base: +{base}</span>
                                    <span className="text-xs font-black text-amber-500 bg-amber-50 dark:bg-amber-900/20 px-2 py-0.5 rounded-full">
                                        🎉 Bonus: +{bonus}
                                    </span>
                                </div>
                            )}
                        </div>
                    )}

                    {/* Next Milestone Preview */}
                    {!isMilestone && nextMilestone && streak < 30 && (
                        <div className="w-full mb-4">
                            <div className="flex items-center justify-between bg-gray-50 dark:bg-white/5 rounded-xl px-4 py-2.5">
                                <span className="text-xs text-gray-500 font-medium">
                                    Next milestone: Day {nextMilestone.day}
                                </span>
                                <span className="text-xs font-black text-primary flex items-center gap-1">
                                    <PointsCoin size="sm" showGlow={false} />
                                    +{nextMilestone.bonus} bonus
                                </span>
                            </div>
                        </div>
                    )}

                    <button
                        onClick={onClose}
                        className="w-full py-4 bg-gray-900 dark:bg-white text-white dark:text-black rounded-xl font-bold hover:scale-[1.02] active:scale-[0.98] transition-all"
                    >
                        {alreadyCheckedIn ? 'Got it!' : isMilestone ? '🎉 Amazing!' : 'Keep it up!'}
                    </button>
                </div>
            </div>
        </div>
    );
};
