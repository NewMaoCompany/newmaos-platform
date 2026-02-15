import React, { useEffect, useState } from 'react';
import { useApp } from '../AppContext';
import confetti from 'canvas-confetti';
import { PointsCoin } from './PointsCoin';

export const ProWelcomeModal = () => {
    const { user, isPro, markProIntroSeen, redeemProWithPoints, showPaywall, setShowPaywall, userPoints, isStreakModalOpen, triggerCoinAnimation } = useApp();
    const [isVisible, setIsVisible] = useState(false);
    const [isClosing, setIsClosing] = useState(false);
    const [isRedeeming, setIsRedeeming] = useState(false);
    const [redeemError, setRedeemError] = useState<string | null>(null);

    const PRO_COST = 199;
    const canAfford = userPoints.balance >= PRO_COST;
    const shortfall = PRO_COST - userPoints.balance;

    const playSuccessSound = () => {
        if (user.preferences && user.preferences.soundEffects === false) return;
        try {
            const AudioContextClass = window.AudioContext || (window as any).webkitAudioContext;
            const ctx = new AudioContextClass();

            const playNote = (freq: number, startTime: number, duration: number) => {
                const osc = ctx.createOscillator();
                const gain = ctx.createGain();

                osc.type = 'triangle';
                osc.frequency.setValueAtTime(freq, startTime);

                gain.gain.setValueAtTime(0, startTime);
                gain.gain.linearRampToValueAtTime(0.2, startTime + 0.05);
                gain.gain.exponentialRampToValueAtTime(0.001, startTime + duration);

                osc.connect(gain);
                gain.connect(ctx.destination);

                osc.start(startTime);
                osc.stop(startTime + duration);
            };

            const now = ctx.currentTime;
            // Success Fanfare: C5, E5, G5, C6
            playNote(523.25, now, 0.3);      // C5
            playNote(659.25, now + 0.15, 0.3); // E5
            playNote(783.99, now + 0.3, 0.3);  // G5
            playNote(1046.50, now + 0.45, 0.6); // C6
        } catch (err) {
            console.error('Failed to play success sound:', err);
        }
    };

    // Trigger visibility logic:
    // Only show when explicitly requested via setShowPaywall (e.g. from gift claim or lock icon)
    // Removed auto-show on mount to prevent spamming the user.
    useEffect(() => {
        if (showPaywall) {
            setIsVisible(true);
            setIsClosing(false);
            if (isPro) {
                // Play celebration effects
                playSuccessSound();
                confetti({
                    particleCount: 200,
                    spread: 100,
                    origin: { y: 0.6 },
                    colors: ['#f9d406', '#34C759', '#ffffff', '#FFD700']
                });
            }
        }
    }, [showPaywall, isPro]);

    if (!isVisible) return null;

    const handleDismiss = () => {
        // Trigger exit animation
        setIsClosing(true);
        // Wait for animation to finish (duration-500)
        setTimeout(() => {
            // Always mark as seen when dismissing to ensure persistence
            markProIntroSeen();
            setShowPaywall(false);
            setIsVisible(false);
            setIsClosing(false);
            setRedeemError(null);
        }, 500);
    };

    const handleRedeem = async (e: React.MouseEvent) => {
        // Capture button position immediately
        const btnRect = e.currentTarget.getBoundingClientRect();
        const targetX = btnRect.left + btnRect.width / 2;
        const targetY = btnRect.top + btnRect.height / 2;

        setIsRedeeming(true);
        setRedeemError(null);
        const result = await redeemProWithPoints();
        if (result.success) {
            // Trigger spend animation (Wallet -> Button)
            triggerCoinAnimation(PRO_COST, targetX, targetY, 'spend');

            // Play celebration effects immediately
            playSuccessSound();

            confetti({
                particleCount: 200,
                spread: 100,
                origin: { y: 0.6 },
                colors: ['#f9d406', '#34C759', '#ffffff']
            });
            setTimeout(() => {
                handleDismiss();
            }, 2000);
        } else {
            setRedeemError(
                result.reason === 'insufficient_points'
                    ? `Not enough points! Need ${result.shortfall} more.`
                    : result.reason === 'already_redeemed_this_month'
                        ? 'Already redeemed this month!'
                        : 'Redemption failed. Please try again.'
            );
            setIsRedeeming(false);
        }
    };

    return (
        <div className={`fixed inset-0 z-[100] flex items-center justify-center p-4 sm:p-6 overflow-hidden ${isClosing ? 'pointer-events-none' : ''}`}>
            {/* Dark Backdrop with heavy blur */}
            <div
                className={`absolute inset-0 bg-black/60 backdrop-blur-xl transition-all duration-500 ${isClosing ? 'animate-fade-out' : 'animate-fade-in'}`}
                onClick={handleDismiss}
            />

            {/* Modal Card */}
            <div className={`relative w-full max-w-lg bg-white/10 dark:bg-black/40 border border-white/20 backdrop-blur-2xl rounded-[2rem] shadow-2xl overflow-hidden transition-all duration-500 max-h-[90vh] overflow-y-auto ${isClosing ? 'animate-modal-out' : 'animate-modal-in'}`}>

                {/* Conditional Close Button (Only for Upsell state) */}
                {!isPro && (
                    <button
                        onClick={handleDismiss}
                        className="absolute top-6 right-6 z-10 w-8 h-8 flex items-center justify-center rounded-full bg-white/10 text-white/60 hover:bg-white/20 hover:text-white transition-all active:scale-95"
                    >
                        <span className="material-symbols-outlined text-xl">close</span>
                    </button>
                )}

                {/* Decorative Gradients */}
                <div className="absolute top-0 left-0 w-full h-2 bg-gradient-to-r from-primary via-amber-400 to-yellow-600" />
                <div className="absolute -top-24 -right-24 w-48 h-48 bg-primary/20 rounded-full blur-3xl animate-pulse" />
                <div className="absolute -bottom-24 -left-24 w-48 h-48 bg-primary/10 rounded-full blur-3xl" />

                <div className="p-6 sm:p-8 relative flex flex-col items-center text-center">

                    {/* Pro Badge/Icon */}
                    <div className="w-16 h-16 bg-gradient-to-br from-primary to-amber-500 rounded-2xl flex items-center justify-center shadow-lg shadow-primary/20 mb-6 rotate-12 hover:rotate-0 transition-transform duration-500 group">
                        <span className="material-symbols-outlined text-black text-3xl font-bold animate-bounce mt-1">auto_awesome</span>
                    </div>

                    <h2 className="text-3xl sm:text-4xl font-black text-white mb-3 tracking-tight">
                        {isPro ? (
                            <>Upgrade <span className="text-primary">Successful!</span></>
                        ) : (
                            <>Unlock <span className="text-primary">NewMaoS Pro</span></>
                        )}
                    </h2>

                    <p className="text-lg text-gray-300 mb-6 max-w-md leading-relaxed">
                        {isPro
                            ? "Your master path to AP Calculus has just reached the next level. Enjoy full access to all premium tools."
                            : "Use your earned points to unlock premium features and supercharge your AP Calculus journey."
                        }
                    </p>

                    {/* Features Grid */}
                    <div className="grid grid-cols-1 sm:grid-cols-2 gap-3 w-full mb-6">
                        {[
                            { icon: 'forum', text: 'Community Forum', color: 'text-blue-400' },
                            { icon: 'analytics', text: 'Deep Analytics', color: 'text-green-400' },
                            { icon: 'palette', text: 'Profile Customization', color: 'text-purple-400' },
                            { icon: 'verified', text: 'Pro Badges', color: 'text-amber-400' }
                        ].map((feat, i) => (
                            <div key={i} className="flex items-center gap-2.5 p-3 bg-white/5 border border-white/10 rounded-xl hover:bg-white/10 transition-colors">
                                <span className={`material-symbols-outlined text-base ${feat.color}`}>{feat.icon}</span>
                                <span className="text-white font-bold text-xs">{feat.text}</span>
                            </div>
                        ))}
                    </div>

                    {/* Points Cost Display */}
                    {!isPro && (
                        <div className="mb-6 w-full">
                            <div className="p-5 rounded-2xl bg-white/5 border border-white/10">
                                <div className="flex items-center justify-between mb-3">
                                    <span className="text-sm text-gray-400 font-medium">Your Balance</span>
                                    <div className="flex items-center gap-2">
                                        <PointsCoin size="sm" showGlow={false} />
                                        <span className="text-lg font-black text-white">{userPoints.balance.toLocaleString()}</span>
                                    </div>
                                </div>
                                <div className="flex items-center justify-between mb-3">
                                    <span className="text-sm text-gray-400 font-medium">Pro Monthly Cost</span>
                                    <div className="flex items-center gap-2">
                                        <span className="text-lg font-black text-primary">{PRO_COST.toLocaleString()}</span>
                                        <PointsCoin size="sm" showGlow={false} />
                                    </div>
                                </div>
                                {!canAfford && (
                                    <div className="mt-3 p-3 bg-red-500/10 border border-red-500/20 rounded-xl">
                                        <p className="text-xs text-red-400 font-bold">
                                            Need {shortfall.toLocaleString()} more points — keep practicing and checking in!
                                        </p>
                                    </div>
                                )}
                            </div>
                        </div>
                    )}

                    {/* Error Display */}
                    {redeemError && (
                        <div className="mb-4 p-3 bg-red-500/10 border border-red-500/20 rounded-xl w-full">
                            <p className="text-sm text-red-400 font-bold">{redeemError}</p>
                        </div>
                    )}

                    {/* Action Button */}
                    <button
                        onClick={(e) => isPro ? handleDismiss() : handleRedeem(e)}
                        disabled={isRedeeming || (!isPro && !canAfford)}
                        className={`w-full py-4 ${isPro ? 'bg-white text-black' : canAfford ? 'bg-primary text-black' : 'bg-gray-600 text-gray-400 cursor-not-allowed'} hover:brightness-110 active:scale-[0.98] font-black text-lg rounded-xl transition-all shadow-xl ${isPro ? 'shadow-white/10' : 'shadow-primary/20'} flex items-center justify-center gap-3 group disabled:hover:brightness-100`}
                    >
                        {isRedeeming ? (
                            <span className="material-symbols-outlined animate-spin text-sm">progress_activity</span>
                        ) : (
                            <>
                                {isPro ? (
                                    <span>Let's Get Started</span>
                                ) : canAfford ? (
                                    <>
                                        <PointsCoin size="sm" showGlow={false} />
                                        <span>Redeem {PRO_COST.toLocaleString()} NMS Points for Pro</span>
                                    </>
                                ) : (
                                    <span>Not Enough NMS Points</span>
                                )}
                                {(isPro || canAfford) && (
                                    <span className="material-symbols-outlined group-hover:translate-x-1 transition-transform">
                                        {isPro ? 'celebration' : 'arrow_forward'}
                                    </span>
                                )}
                            </>
                        )}
                    </button>

                    {/* Maybe Later Button - Only show for upsell (non-Pro) */}
                    {!isPro && (
                        <button
                            onClick={handleDismiss}
                            disabled={isRedeeming}
                            className="w-full py-3 text-sm font-bold text-white/60 hover:text-white/80 transition-colors flex items-center justify-center gap-2 disabled:opacity-50"
                        >
                            <span>Maybe Later</span>
                        </button>
                    )}


                </div>
            </div>
        </div>
    );
};
