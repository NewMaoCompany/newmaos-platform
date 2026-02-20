import React, { useState, useEffect, useCallback } from 'react';
import { useApp } from '../AppContext';
import { supabase } from '../src/services/supabaseClient';

interface UnlockedTitle {
    title_id: string;
    title_name: string;
    title_description: string;
    title_category: string;
    unlocked_at: string;
}

const CATEGORY_ICONS: Record<string, string> = {
    streak: 'local_fire_department',
    seniority: 'military_tech',
    mastery_unit: 'school',
    mastery_course: 'emoji_events',
    social: 'group',
    influence: 'public',
    questions: 'quiz',
    posts: 'forum',
};

const CATEGORY_COLORS: Record<string, { from: string; to: string; glow: string }> = {
    streak: { from: '#f97316', to: '#ef4444', glow: 'rgba(249,115,22,0.4)' },
    seniority: { from: '#8b5cf6', to: '#6366f1', glow: 'rgba(139,92,246,0.4)' },
    mastery_unit: { from: '#10b981', to: '#059669', glow: 'rgba(16,185,129,0.4)' },
    mastery_course: { from: '#f59e0b', to: '#d97706', glow: 'rgba(245,158,11,0.4)' },
    social: { from: '#3b82f6', to: '#2563eb', glow: 'rgba(59,130,246,0.4)' },
    influence: { from: '#ec4899', to: '#db2777', glow: 'rgba(236,72,153,0.4)' },
    questions: { from: '#14b8a6', to: '#0d9488', glow: 'rgba(20,184,166,0.4)' },
    posts: { from: '#6366f1', to: '#4f46e5', glow: 'rgba(99,102,241,0.4)' },
};

export const AchievementPopupManager: React.FC = () => {
    const { user, isPro } = useApp();
    const [queue, setQueue] = useState<UnlockedTitle[]>([]);
    const [currentPopup, setCurrentPopup] = useState<UnlockedTitle | null>(null);
    const [isAnimating, setIsAnimating] = useState(false);
    const [hasFetched, setHasFetched] = useState(false);

    // Fetch unnotified titles when user is Pro
    const fetchUnnotified = useCallback(async () => {
        if (!user?.id || !isPro) return;
        try {
            const { data, error } = await supabase.rpc('get_unnotified_titles', {
                p_user_id: user.id
            });
            if (error) {
                console.error('[Achievement] Fetch error:', error);
                return;
            }
            if (data && data.length > 0) {
                setQueue(data);
            }
        } catch (err) {
            console.error('[Achievement] Exception:', err);
        }
    }, [user?.id, isPro]);

    // Fetch on mount & when isPro changes (handles re-subscription)
    useEffect(() => {
        if (isPro && user?.id && !hasFetched) {
            // Also squash analysis notifications on Pro activation
            const init = async () => {
                try {
                    await supabase.rpc('squash_analysis_notifications', { p_user_id: user!.id });
                    console.log('[Achievement] Analysis notifications squashed');
                } catch (err) {
                    console.error('[Achievement] Squash error:', err);
                }
                await fetchUnnotified();
            };
            init();
            setHasFetched(true);
        }
        // Reset fetch flag when user loses Pro so re-sub triggers again
        if (!isPro) {
            setHasFetched(false);
        }
    }, [isPro, user?.id, hasFetched, fetchUnnotified]);

    // Dequeue: show next popup from queue
    useEffect(() => {
        if (queue.length > 0 && !currentPopup && !isAnimating) {
            const next = queue[0];
            setCurrentPopup(next);
            setIsAnimating(true);
            // Remove from queue
            setQueue(prev => prev.slice(1));
        }
    }, [queue, currentPopup, isAnimating]);

    const handleDismiss = useCallback(async () => {
        if (!currentPopup || !user?.id) return;

        // Mark as notified in DB
        try {
            await supabase.rpc('mark_title_notified', {
                p_user_id: user.id,
                p_title_id: currentPopup.title_id
            });
        } catch (err) {
            console.error('[Achievement] Mark notified error:', err);
        }

        // Animate out
        setIsAnimating(false);
        setTimeout(() => {
            setCurrentPopup(null);
        }, 400);
    }, [currentPopup, user?.id]);

    if (!currentPopup) return null;

    const colors = CATEGORY_COLORS[currentPopup.title_category] || CATEGORY_COLORS.questions;
    const icon = CATEGORY_ICONS[currentPopup.title_category] || 'emoji_events';

    return (
        <div className="fixed inset-0 z-[9999] flex items-center justify-center pointer-events-none">
            {/* Backdrop */}
            <div
                className={`absolute inset-0 bg-black/60 backdrop-blur-sm transition-opacity duration-500 pointer-events-auto ${isAnimating ? 'opacity-100' : 'opacity-0'}`}
                onClick={handleDismiss}
            />

            {/* Popup Card */}
            <div
                className={`relative pointer-events-auto transition-all duration-500 ease-out ${isAnimating ? 'opacity-100 scale-100 translate-y-0' : 'opacity-0 scale-90 translate-y-8'}`}
                style={{
                    maxWidth: 420,
                    width: '90vw',
                }}
            >
                <div className="rounded-[2.5rem] overflow-hidden shadow-2xl"
                    style={{
                        background: `linear-gradient(135deg, ${colors.from}, ${colors.to})`,
                        boxShadow: `0 25px 80px ${colors.glow}, 0 0 120px ${colors.glow}`,
                    }}
                >
                    {/* Decorative glow circles */}
                    <div className="absolute -top-20 -right-20 w-48 h-48 bg-white/10 rounded-full blur-3xl" />
                    <div className="absolute -bottom-16 -left-16 w-40 h-40 bg-white/10 rounded-full blur-3xl" />

                    <div className="relative z-10 p-10 flex flex-col items-center text-center text-white">
                        {/* Badge */}
                        <div className="text-[10px] font-black uppercase tracking-[0.3em] opacity-70 mb-6">
                            Achievement Unlocked
                        </div>

                        {/* Icon */}
                        <div className="w-24 h-24 rounded-full bg-white/20 backdrop-blur-sm flex items-center justify-center mb-6 shadow-lg">
                            <span className="material-symbols-outlined text-[52px] text-white">{icon}</span>
                        </div>

                        {/* Title Name */}
                        <h2 className="text-3xl font-black tracking-tight mb-3">
                            {currentPopup.title_name}
                        </h2>

                        {/* Description */}
                        <p className="text-white/80 text-sm font-medium leading-relaxed mb-8 max-w-xs">
                            {currentPopup.title_description}
                        </p>

                        {/* CTA */}
                        <button
                            onClick={handleDismiss}
                            className="w-full py-4 bg-white/20 hover:bg-white/30 backdrop-blur-sm rounded-2xl font-black text-sm uppercase tracking-widest transition-all hover:scale-[1.02] active:scale-95"
                        >
                            Awesome!
                        </button>

                        {/* Queue indicator */}
                        {queue.length > 0 && (
                            <p className="mt-4 text-[11px] font-bold opacity-50">
                                +{queue.length} more achievement{queue.length > 1 ? 's' : ''} unlocked
                            </p>
                        )}
                    </div>
                </div>
            </div>
        </div>
    );
};
