import React, { useState, useEffect, useRef } from 'react';
import { supabase } from '../src/services/supabaseClient';
import { useApp } from '../AppContext';
import { useToast } from './Toast';
import confetti from 'canvas-confetti';

interface WelcomeGiftModalProps {
    onClaimed: () => void;
}

export const WelcomeGiftModal: React.FC<WelcomeGiftModalProps> = ({ onClaimed }) => {
    const [isClaiming, setIsClaiming] = useState(false);
    const [claimed, setClaimed] = useState(false);
    const { user, fetchUserPoints, triggerCoinAnimation } = useApp();
    const { showToast } = useToast();
    const modalRef = useRef<HTMLDivElement>(null);

    // ─── Confetti Effects ────────────────────────────────────

    const fireEntranceConfetti = () => {
        const zIndex = 300;
        const colors = ['#FFD700', '#FFA500', '#FF6347', '#FF1493', '#00CED1', '#7B68EE', '#FFEC44'];
        // Left + Right cannons
        confetti({ particleCount: 60, angle: 60, spread: 55, origin: { x: 0, y: 0.65 }, zIndex, colors });
        confetti({ particleCount: 60, angle: 120, spread: 55, origin: { x: 1, y: 0.65 }, zIndex, colors });
        setTimeout(() => {
            confetti({ particleCount: 80, startVelocity: 30, spread: 360, origin: { x: 0.5, y: 0.4 }, zIndex, ticks: 80, colors });
        }, 200);
    };

    const fireClaimConfetti = () => {
        const zIndex = 300;
        const colors = ['#FFD700', '#FFA500', '#FF6347', '#FF1493', '#00CED1', '#7B68EE', '#FFEC44'];
        // Continuous side cannons for 2 seconds
        const end = Date.now() + 2000;
        const frame = () => {
            confetti({ particleCount: 3, angle: 60, spread: 55, origin: { x: 0, y: 0.6 }, zIndex, colors });
            confetti({ particleCount: 3, angle: 120, spread: 55, origin: { x: 1, y: 0.6 }, zIndex, colors });
            if (Date.now() < end) requestAnimationFrame(frame);
        };
        frame();
        // Big center bursts
        confetti({ particleCount: 150, startVelocity: 45, spread: 100, origin: { x: 0.5, y: 0.5 }, zIndex, colors, ticks: 120 });
        setTimeout(() => {
            confetti({ particleCount: 100, startVelocity: 35, spread: 160, origin: { x: 0.5, y: 0.4 }, zIndex, colors, scalar: 1.2, ticks: 100 });
        }, 400);
    };

    // ─── Sound Effects ───────────────────────────────────────

    const playEntranceChime = () => {
        if (user.preferences && user.preferences.soundEffects === false) return;
        try {
            const AudioCtx = (window as any).AudioContext || (window as any).webkitAudioContext;
            const ctx = new AudioCtx();
            [880, 1320].forEach((freq, i) => {
                const osc = ctx.createOscillator();
                const gain = ctx.createGain();
                osc.type = 'sine';
                osc.frequency.setValueAtTime(freq, ctx.currentTime + i * 0.12);
                gain.gain.setValueAtTime(0, ctx.currentTime + i * 0.12);
                gain.gain.linearRampToValueAtTime(0.08, ctx.currentTime + i * 0.12 + 0.03);
                gain.gain.exponentialRampToValueAtTime(0.001, ctx.currentTime + i * 0.12 + 0.4);
                osc.connect(gain);
                gain.connect(ctx.destination);
                osc.start(ctx.currentTime + i * 0.12);
                osc.stop(ctx.currentTime + i * 0.12 + 0.4);
            });
        } catch { }
    };

    // ─── Entrance Effects ────────────────────────────────────

    useEffect(() => {
        const t1 = setTimeout(() => {
            playEntranceChime();
            fireEntranceConfetti();
        }, 500);
        return () => clearTimeout(t1);
    }, []);

    // ─── Claim Handler ───────────────────────────────────────

    const handleClaim = async () => {
        if (isClaiming || claimed) return;
        setIsClaiming(true);

        // Pre-warm audio context during user gesture
        window.dispatchEvent(new Event('audio-unlock'));

        try {
            const { data, error } = await supabase.rpc('claim_welcome_gift');

            if (error) throw error;

            if (data?.success) {
                setClaimed(true);

                // Use the SAME coin animation as Forum claim
                // triggerCoinAnimation dispatches 'coin-collect' event
                // CoinCollector renders gold PointsCoin with sound + fly animation
                triggerCoinAnimation(200);

                // Fire big confetti
                fireClaimConfetti();

                // Refresh points balance
                await fetchUserPoints();

                showToast('🎁 Welcome Gift Claimed! +200 NMS Points!', 'success');

                // Close modal after effects
                setTimeout(() => onClaimed(), 2800);
            } else {
                showToast('Gift already claimed!', 'info');
                onClaimed();
            }
        } catch (err: any) {
            console.error('Failed to claim welcome gift:', err);
            showToast('Failed to claim gift. Please try again.', 'error');
            setIsClaiming(false);
        }
    };

    // ─── Render ──────────────────────────────────────────────

    return (
        <div className="fixed inset-0 z-[200] flex items-center justify-center p-4 bg-black/80 backdrop-blur-md no-select"
            style={{ animation: 'wgFadeIn 0.4s ease-out' }}>
            <div
                ref={modalRef}
                className="relative bg-surface-light dark:bg-surface-dark w-full max-w-md rounded-[40px] p-8 shadow-2xl border border-white/20 overflow-hidden"
                style={{ animation: 'wgBounceIn 0.8s cubic-bezier(0.34, 1.56, 0.64, 1)' }}
            >
                {/* Background Glows */}
                <div className="absolute -top-24 -left-24 w-48 h-48 bg-primary/20 blur-[80px] rounded-full"></div>
                <div className="absolute -bottom-24 -right-24 w-48 h-48 bg-primary/20 blur-[80px] rounded-full"></div>

                {/* Sparkle particles */}
                <div className="absolute inset-0 overflow-hidden pointer-events-none">
                    {[...Array(6)].map((_, i) => (
                        <div key={i}
                            className="absolute w-1.5 h-1.5 bg-primary rounded-full"
                            style={{
                                left: `${15 + i * 15}%`,
                                top: `${10 + (i % 3) * 25}%`,
                                animation: `wgSparkle ${1.5 + i * 0.3}s ease-in-out infinite ${i * 0.2}s`,
                                opacity: 0,
                            }}
                        ></div>
                    ))}
                </div>

                <div className="relative z-10 flex flex-col items-center text-center">
                    {/* Animated Gift Icon */}
                    <div className="relative mb-8">
                        <div className="absolute inset-0 bg-primary/30 blur-2xl rounded-full scale-150"
                            style={{ animation: 'wgPulse 2s ease-in-out infinite' }}></div>
                        <div
                            className="w-24 h-24 bg-gradient-to-br from-primary to-yellow-400 rounded-3xl flex items-center justify-center text-text-main shadow-glow"
                            style={{ animation: 'wgFloat 3s ease-in-out infinite' }}
                        >
                            <span className="material-symbols-outlined text-6xl">redeem</span>
                        </div>
                        {/* Orbiting mini icons */}
                        <div
                            className="absolute -top-4 -right-4 w-10 h-10 bg-white dark:bg-zinc-800 rounded-full flex items-center justify-center shadow-lg"
                            style={{ animation: 'wgFloat 3s ease-in-out infinite 1.5s' }}
                        >
                            <span className="material-symbols-outlined text-primary text-xl">payments</span>
                        </div>
                        <div
                            className="absolute -bottom-2 -left-4 w-8 h-8 bg-white dark:bg-zinc-800 rounded-full flex items-center justify-center shadow-lg"
                            style={{ animation: 'wgFloat 2.5s ease-in-out infinite 0.8s' }}
                        >
                            <span className="material-symbols-outlined text-yellow-500 text-lg">star</span>
                        </div>
                    </div>

                    <h2 className="text-3xl font-black text-text-main dark:text-white mb-3 tracking-tight">
                        Welcome to NewMaoS!
                    </h2>

                    <p className="text-text-secondary dark:text-gray-400 font-medium mb-8 leading-relaxed px-4">
                        We're excited to have you here. Here's a little something to jump-start your learning journey!
                    </p>

                    <div className="bg-gray-50 dark:bg-white/5 rounded-3xl p-6 w-full mb-8 border border-gray-100 dark:border-white/5 flex flex-col gap-1 items-center">
                        <span className="text-sm font-bold text-gray-400 uppercase tracking-widest">You Received</span>
                        <div className="flex items-center gap-3">
                            <span className="text-5xl font-black text-primary drop-shadow-sm"
                                style={{ animation: claimed ? 'wgCountUp 0.5s ease-out' : 'none' }}>200</span>
                            <div className="flex flex-col items-start leading-none">
                                <span className="text-xl font-bold text-text-main dark:text-white">NMS</span>
                                <span className="text-xs font-bold text-gray-400">POINTS</span>
                            </div>
                        </div>
                    </div>

                    <button
                        onClick={handleClaim}
                        disabled={isClaiming || claimed}
                        className={`w-full py-5 rounded-2xl font-black text-lg transition-all transform active:scale-95 shadow-glow
                            ${claimed
                                ? 'bg-green-500 text-white cursor-default'
                                : isClaiming
                                    ? 'bg-gray-200 dark:bg-zinc-800 text-gray-400 cursor-wait'
                                    : 'bg-primary text-text-main hover:scale-[1.02] hover:brightness-105'
                            }
                        `}
                    >
                        {claimed ? (
                            <div className="flex items-center justify-center gap-3">
                                <span className="material-symbols-outlined">check_circle</span>
                                <span>CLAIMED!</span>
                            </div>
                        ) : isClaiming ? (
                            <div className="flex items-center justify-center gap-3">
                                <div className="w-5 h-5 border-3 border-text-main border-t-transparent rounded-full animate-spin"></div>
                                <span>CLAIMING...</span>
                            </div>
                        ) : (
                            'CLAIM GIFT & START LEARNING'
                        )}
                    </button>

                    <p className="mt-6 text-[10px] font-bold text-gray-500 dark:text-zinc-500 uppercase tracking-[0.2em]">
                        One-time newcomer reward
                    </p>
                </div>

                {/* Top accent bar */}
                <div className="absolute top-0 left-0 w-full h-1 bg-gradient-to-r from-transparent via-primary to-transparent"></div>
            </div>

            <style>{`
                @keyframes wgFadeIn {
                    from { opacity: 0; }
                    to { opacity: 1; }
                }
                @keyframes wgBounceIn {
                    0% { opacity: 0; transform: scale(0.3); }
                    50% { opacity: 1; transform: scale(1.05); }
                    70% { transform: scale(0.9); }
                    100% { transform: scale(1); }
                }
                @keyframes wgFloat {
                    0%, 100% { transform: translateY(0) rotate(6deg); }
                    50% { transform: translateY(-10px) rotate(8deg); }
                }
                @keyframes wgPulse {
                    0%, 100% { opacity: 0.3; transform: scale(1.5); }
                    50% { opacity: 0.6; transform: scale(1.8); }
                }
                @keyframes wgCountUp {
                    0% { transform: scale(1); }
                    50% { transform: scale(1.3); }
                    100% { transform: scale(1); }
                }
                @keyframes wgSparkle {
                    0%, 100% { opacity: 0; transform: scale(0); }
                    50% { opacity: 0.8; transform: scale(1); }
                }
                .no-select { user-select: none; }
            `}</style>
        </div>
    );
};
