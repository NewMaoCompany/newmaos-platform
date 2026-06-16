import React, { useState, useEffect } from 'react';
import { useApp } from '../AppContext';
import { supabase } from '../src/services/supabaseClient';

export const OnboardingFlow: React.FC = () => {
    const { user, isAuthenticated, isPro, updateUser, awardPoints, redeemProWithPoints } = useApp();
    const [step, setStep] = useState<'hidden' | 'welcome_gift' | 'pro_upgrade'>('hidden');
    const [isClaiming, setIsClaiming] = useState(false);
    const [isUpgrading, setIsUpgrading] = useState(false);

    useEffect(() => {
        // Only run for authenticated users who haven't claimed the gift
        if (!isAuthenticated || !user?.id) return;
        if (user.hasClaimedWelcomeGift || localStorage.getItem(`welcome_claimed_${user.id}`)) return;

        // Start step 1 after 1.5 seconds
        const timer = setTimeout(() => {
            setStep('welcome_gift');
        }, 1500);

        return () => clearTimeout(timer);
    }, [isAuthenticated, user?.id, user?.hasClaimedWelcomeGift]);

    const handleClaimGift = async (e: React.MouseEvent) => {
        if (isClaiming) return;
        setIsClaiming(true);

        // Get click coordinates for coin animation
        const rect = (e.currentTarget as HTMLElement).getBoundingClientRect();
        const x = rect.left + rect.width / 2;
        const y = rect.top + rect.height / 2;

        try {
            // Remove direct supabase.update which fails due to RLS.
            // updateUser() context will sync it to backend API securely.


            // Award 200 points (this automatically plays animation)
            // idempotency key is global per user → DB-level guarantee of one-time only
            const result = await awardPoints(200, 'manual_adjustment', 'onboarding_gift', 'Welcome Gift', `welcome_gift_${user.id}`, x, y);

            // result.success=true  → first-time claim, coins awarded
            // result.reason==='duplicate' → already claimed before (idempotency block), just close
            const alreadyClaimed = (result as any).reason === 'duplicate';

            if (result.success || alreadyClaimed) {
                // Update local context and localStorage fallback so modal won't reappear this session
                updateUser({ hasClaimedWelcomeGift: true });
                localStorage.setItem(`welcome_claimed_${user.id}`, 'true');

                // Hide current popup
                setStep('hidden');
                setIsClaiming(false);

                // Wait 2.5 seconds (allow animation to finish), then show Pro upgrade popup
                setTimeout(() => {
                    if (!isPro) {
                        setStep('pro_upgrade');
                    }
                }, 2500);
            } else {
                console.error("awardPoints failed:", result);
                setIsClaiming(false);
            }
        } catch (err: any) {
            console.error("Error claiming gift:", err);
            alert("Error claiming gift: " + err.message);
            setIsClaiming(false);
        }
    };

    const handleUpgradePro = async () => {
        if (isUpgrading) return;
        setIsUpgrading(true);

        try {
            const result = await redeemProWithPoints();
            if (result.success) {
                setStep('hidden');
            } else {
                console.error("Upgrade failed:", result.reason);
                alert("Upgrade failed: " + (result.reason || 'Unknown error'));
                setIsUpgrading(false);
            }
        } catch (err) {
            console.error("Error upgrading:", err);
            setIsUpgrading(false);
        }
    };

    const handleCloseProPopup = () => {
        setStep('hidden');
    };

    if (step === 'hidden') return null;

    return (
        <div className="fixed inset-0 z-[9999] flex items-center justify-center bg-black/60 backdrop-blur-sm animate-fade-in px-4">
            {step === 'welcome_gift' && (
                <div className="bg-white dark:bg-surface-dark w-full max-w-sm rounded-2xl shadow-2xl p-6 text-center transform animate-scale-up border border-gray-100 dark:border-gray-800 relative overflow-hidden">
                    {/* Decorative Background */}
                    <div className="absolute -top-10 -left-10 w-32 h-32 bg-primary/20 rounded-full blur-3xl pointer-events-none"></div>
                    <div className="absolute -bottom-10 -right-10 w-32 h-32 bg-yellow-400/20 rounded-full blur-3xl pointer-events-none"></div>

                    <div className="relative z-10">
                        <div className="w-16 h-16 bg-gradient-to-br from-yellow-300 to-yellow-500 rounded-2xl mx-auto mb-4 flex items-center justify-center shadow-lg transform rotate-3">
                            <span className="material-symbols-outlined text-white text-3xl font-bold">celebration</span>
                        </div>
                        <h2 className="text-2xl font-black text-text-main dark:text-white mb-2">Welcome!</h2>
                        <p className="text-sm font-medium text-text-secondary dark:text-gray-400 mb-6 leading-relaxed">
                            Thank you for joining NewMaoS. To get you started, here is a newcomer gift package.
                        </p>

                        <div className="bg-yellow-50 dark:bg-yellow-900/10 border border-yellow-200 dark:border-yellow-700/30 rounded-xl p-4 mb-6 flex items-center justify-center gap-2">
                            <span className="material-symbols-outlined text-yellow-500 text-2xl font-bold" style={{ fontVariationSettings: "'FILL' 1" }}>toll</span>
                            <span className="text-2xl font-black text-text-main dark:text-white">+200 Coins</span>
                        </div>

                        <button
                            onClick={handleClaimGift}
                            disabled={isClaiming}
                            className="w-full bg-primary hover:bg-primary-hover text-text-main font-bold py-3.5 rounded-xl shadow-[0_4px_14px_0_rgba(249,212,6,0.39)] transition-all hover:-translate-y-0.5 active:translate-y-0 active:shadow-none flex items-center justify-center gap-2 disabled:opacity-70 disabled:cursor-not-allowed"
                        >
                            {isClaiming ? (
                                <div className="w-5 h-5 border-2 border-text-main border-t-transparent rounded-full animate-spin"></div>
                            ) : (
                                <>
                                    <span>Claim your free 200 coins</span>
                                    <span className="material-symbols-outlined text-[18px]">arrow_forward</span>
                                </>
                            )}
                        </button>
                        {/* Note: Deliberately no close button as this is non-dismissible */}
                    </div>
                </div>
            )}

            {step === 'pro_upgrade' && (
                <div className="bg-white dark:bg-surface-dark w-full max-w-sm rounded-2xl shadow-2xl p-6 text-center transform animate-scale-up border border-gray-100 dark:border-gray-800 relative">
                    <button 
                        onClick={handleCloseProPopup}
                        className="absolute top-4 right-4 w-8 h-8 flex items-center justify-center rounded-full bg-gray-100 dark:bg-gray-800 text-gray-500 hover:bg-gray-200 dark:hover:bg-gray-700 transition-colors"
                    >
                        <span className="material-symbols-outlined text-[18px]">close</span>
                    </button>

                    <div className="w-16 h-16 bg-gradient-to-br from-purple-500 to-indigo-600 rounded-2xl mx-auto mb-4 flex items-center justify-center shadow-lg">
                        <span className="material-symbols-outlined text-white text-3xl font-bold">workspace_premium</span>
                    </div>
                    
                    <h2 className="text-2xl font-black text-transparent bg-clip-text bg-gradient-to-r from-purple-600 to-indigo-500 mb-2">Upgrade to Pro</h2>
                    
                    <p className="text-sm font-medium text-text-secondary dark:text-gray-400 mb-4 leading-relaxed">
                        Unlock advanced AI Analysis, Community Forum, and premium features. You can upgrade now using your welcome coins!
                    </p>

                    <div className="bg-purple-50 dark:bg-purple-900/10 border border-purple-200 dark:border-purple-700/30 rounded-xl p-4 mb-6">
                        <div className="flex items-center justify-between mb-2">
                            <span className="text-sm font-bold text-gray-600 dark:text-gray-300">Cost:</span>
                            <div className="flex items-center gap-1 font-black text-lg text-text-main dark:text-white">
                                19 <span className="material-symbols-outlined text-yellow-500 text-[18px]" style={{ fontVariationSettings: "'FILL' 1" }}>toll</span>
                            </div>
                        </div>
                        <div className="text-xs text-purple-600 dark:text-purple-400 font-medium">
                            You can always upgrade later from Settings → Subscription.
                        </div>
                    </div>

                    <div className="flex flex-col gap-3">
                        <button
                            onClick={handleUpgradePro}
                            disabled={isUpgrading}
                            className="w-full bg-gradient-to-r from-purple-600 to-indigo-600 hover:from-purple-500 hover:to-indigo-500 text-white font-bold py-3.5 rounded-xl shadow-[0_4px_14px_0_rgba(124,58,237,0.39)] transition-all hover:-translate-y-0.5 active:translate-y-0 active:shadow-none flex items-center justify-center gap-2 disabled:opacity-70 disabled:cursor-not-allowed"
                        >
                            {isUpgrading ? (
                                <div className="w-5 h-5 border-2 border-white border-t-transparent rounded-full animate-spin"></div>
                            ) : (
                                <>
                                    <span>Upgrade Now (19 Coins)</span>
                                    <span className="material-symbols-outlined text-[18px]">lock_open</span>
                                </>
                            )}
                        </button>
                        <button
                            onClick={handleCloseProPopup}
                            className="w-full bg-gray-100 hover:bg-gray-200 dark:bg-white/5 dark:hover:bg-white/10 text-text-main dark:text-white font-bold py-3 rounded-xl transition-colors"
                        >
                            Maybe Later
                        </button>
                    </div>
                </div>
            )}
        </div>
    );
};
