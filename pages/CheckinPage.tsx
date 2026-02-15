import React, { useState, useEffect } from 'react';
import { useApp } from '../AppContext';
import { Navbar } from '../components/Navbar';
import { useNavigate } from 'react-router-dom';
import { PointsCoin } from '../components/PointsCoin';
import { useToast } from '../components/Toast';
import { supabase } from '../src/services/supabaseClient';
import confetti from 'canvas-confetti';

export const CheckinPage = () => {
    const { user, isAuthenticated, performDailyCheckin, getCheckinStatus, fetchUserPoints, triggerCoinAnimation } = useApp();
    const { showToast } = useToast();
    const navigate = useNavigate();
    const [checkinData, setCheckinData] = useState<any>(null);
    const [loading, setLoading] = useState(true);
    const [performingCheckin, setPerformingCheckin] = useState(false);
    const [isRepairing, setIsRepairing] = useState(false);
    const [profile, setProfile] = useState<{ last_repair_at: string | null } | null>(null);
    const [justCheckedIn, setJustCheckedIn] = useState(false);
    const [checkinReward, setCheckinReward] = useState<{ base: number; bonus: number; total: number; streak: number; isMilestone: boolean } | null>(null);

    const handleRepair = async (e: React.MouseEvent) => {
        e.stopPropagation();
        if (isRepairing) return;

        setIsRepairing(true);
        const btnRect = e.currentTarget.getBoundingClientRect();
        const targetX = btnRect.left + btnRect.width / 2;
        const targetY = btnRect.top + btnRect.height / 2;

        try {
            const { data, error } = await supabase.rpc('use_monthly_repair', { user_uuid: user?.id });
            if (error) throw error;

            if (data.success) {
                triggerCoinAnimation(100, targetX, targetY, 'spend');
                showToast(`Streak repaired! New streak: ${data.new_streak}`, 'success');
                refreshStatus();
            } else {
                showToast(data.reason === 'insufficient_points' ? 'Insufficient points' : data.message, 'error');
            }
        } catch (err: any) {
            showToast(err.message, 'error');
        } finally {
            setIsRepairing(false);
        }
    };

    const refreshStatus = async () => {
        if (!isAuthenticated) return;
        try {
            const data = await getCheckinStatus();
            setCheckinData({
                hasCheckedToday: data.checkedInToday,
                streak: data.currentStreak,
                history: data.monthCalendar
            });

            const { data: profData } = await supabase
                .from('user_profiles')
                .select('last_repair_at')
                .eq('id', user?.id)
                .single();
            if (profData) setProfile(profData);

            await fetchUserPoints();
        } catch (err) {
            console.error('Failed to fetch checkin status:', err);
        } finally {
            setLoading(false);
        }
    };

    useEffect(() => {
        refreshStatus();
    }, [isAuthenticated]);

    const handleCheckin = async (e?: React.MouseEvent) => {
        if (performingCheckin || checkinData?.hasCheckedToday) return;

        let posX = window.innerWidth / 2;
        let posY = window.innerHeight / 2;

        if (e) {
            posX = e.clientX;
            posY = e.clientY;
        }

        setPerformingCheckin(true);
        try {
            const result = await performDailyCheckin();
            if (result.success) {
                triggerCoinAnimation(result.totalPoints || 10, posX, posY);
                setCheckinReward({
                    base: result.basePoints || 10,
                    bonus: result.bonusPoints || 0,
                    total: result.totalPoints || 10,
                    streak: result.streakDay || 1,
                    isMilestone: result.isMilestone || false
                });
                setJustCheckedIn(true);
                showToast(`Check-in successful! +${result.totalPoints} NMS Points`, 'success');

                // Trigger confetti effect
                confetti({
                    particleCount: 150,
                    spread: 70,
                    origin: { y: 0.6 },
                    colors: ['#FFD700', '#FFA500', '#FF6347', '#f9d406', '#34C759']
                });

                await refreshStatus();
            } else if (result.reason === 'already_checked_in') {
                showToast('You have already checked in today.', 'info');
                await refreshStatus();
            } else {
                showToast(result.reason || 'Check-in failed', 'error');
            }
        } catch (err: any) {
            console.error('Checkin failed:', err);
            showToast('An unexpected error occurred.', 'error');
        } finally {
            setPerformingCheckin(false);
        }
    };

    if (loading) {
        return (
            <div className="min-h-screen bg-surface-light dark:bg-surface-dark flex flex-col">
                <Navbar />
                <div className="flex-1 flex items-center justify-center">
                    <div className="w-12 h-12 border-4 border-primary border-t-transparent rounded-full animate-spin"></div>
                </div>
            </div>
        );
    }

    const today = new Date();
    const currentMonth = today.toLocaleString('en-US', { month: 'long' });
    const currentYear = today.getFullYear();
    const daysInMonth = new Date(currentYear, today.getMonth() + 1, 0).getDate();
    const firstDayOfMonth = new Date(currentYear, today.getMonth(), 1).getDay();
    const calendarDays = Array.from({ length: daysInMonth }, (_, i) => i + 1);
    const paddingDays = Array.from({ length: firstDayOfMonth }, (_, i) => i);

    const history = checkinData?.history || [];
    const isDayChecked = (day: number) => {
        const dateStr = `${currentYear}-${String(today.getMonth() + 1).padStart(2, '0')}-${String(day).padStart(2, '0')}`;
        return history.find((h: any) => h.date === dateStr);
    };

    const streak = checkinData?.streak || 0;
    const multiplier = 1 + streak * 0.1;
    const baseReward = streak <= 6 ? 10 : streak <= 13 ? 15 : streak <= 20 ? 20 : 25;
    const todayReward = Math.round(baseReward * multiplier);

    // Repair eligibility
    const canRepair = (() => {
        if (!profile) return false;
        const now = new Date();
        if (profile.last_repair_at) {
            const lastDate = new Date(profile.last_repair_at);
            if (lastDate.getMonth() === now.getMonth() && lastDate.getFullYear() === now.getFullYear()) return false;
        }
        return true;
    })();

    return (
        <div className="h-screen bg-surface-light dark:bg-surface-dark text-text-main dark:text-gray-100 flex flex-col overflow-hidden">
            <Navbar />

            <div className="flex-1 w-full overflow-y-auto scroll-bounce">
                <div className="max-w-4xl mx-auto p-4 sm:p-6 pb-24 flex flex-col gap-6 animate-fade-in mt-4">

                    {/* Header */}
                    <div className="flex items-center gap-4">
                        <button
                            onClick={() => navigate(-1)}
                            className="w-10 h-10 -ml-2 rounded-full flex items-center justify-center hover:bg-gray-100 dark:hover:bg-white/10 transition-colors"
                        >
                            <span className="material-symbols-outlined">arrow_back</span>
                        </button>
                        <h1 className="text-2xl font-black tracking-tight">Daily Check-in</h1>
                    </div>

                    <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">

                        {/* Streak Stats Side */}
                        <div className="lg:col-span-1 flex flex-col gap-5">
                            {/* Streak Card */}
                            <div className="p-8 rounded-[2.5rem] bg-gradient-to-br from-primary to-amber-500 shadow-2xl shadow-primary/20 text-black relative overflow-hidden group">
                                <div className="absolute -top-10 -right-10 w-32 h-32 bg-white/20 rounded-full blur-2xl group-hover:scale-150 transition-transform duration-700" />

                                <div className="relative z-10 flex flex-col items-center text-center">
                                    <span className="text-xs font-black uppercase tracking-[0.2em] opacity-70 mb-2">Current Streak</span>
                                    <div className="flex items-baseline gap-1">
                                        <span className="text-7xl font-black tracking-tighter">{streak}</span>
                                        <span className="text-xl font-bold uppercase italic">Days</span>
                                    </div>
                                    <div className="mt-6 w-full p-4 bg-black/10 rounded-2xl border border-black/5 backdrop-blur-sm">
                                        <div className="flex justify-between items-center mb-1">
                                            <span className="text-[10px] font-black uppercase tracking-widest">Next Milestone</span>
                                            <span className="text-[10px] font-black italic">{streak % 7} / 7</span>
                                        </div>
                                        <div className="h-2 w-full bg-black/10 rounded-full overflow-hidden">
                                            <div
                                                className="h-full bg-black transition-all duration-1000 ease-out"
                                                style={{ width: `${((streak % 7) / 7) * 100}%` }}
                                            />
                                        </div>
                                    </div>

                                    {/* Repair Button */}
                                    {canRepair && (
                                        <div className="mt-4 w-full px-2">
                                            <button
                                                onClick={handleRepair}
                                                disabled={isRepairing}
                                                className="w-full py-2 bg-white/10 hover:bg-white/20 border border-white/20 backdrop-blur-md text-[10px] font-black uppercase tracking-[0.12em] rounded-xl transition-all flex items-center justify-center gap-2 shadow-lg shadow-black/5 hover:scale-[1.02] active:scale-95 group"
                                            >
                                                <span className="material-symbols-outlined text-[16px] group-hover:rotate-12 transition-transform">build</span>
                                                <span>Repair Streak</span>
                                                <div className="w-px h-2.5 bg-black/10 mx-0.5" />
                                                <div className="flex items-center gap-1 opacity-80">
                                                    <span>100</span>
                                                    <PointsCoin size="sm" />
                                                </div>
                                            </button>
                                        </div>
                                    )}
                                </div>
                            </div>

                            {/* Check-in Button / Success Card */}
                            {justCheckedIn && checkinReward ? (
                                <div className="p-6 rounded-[2rem] bg-gradient-to-br from-emerald-50 to-green-50 dark:from-emerald-900/20 dark:to-green-900/10 border-2 border-emerald-200 dark:border-emerald-700/30 shadow-xl shadow-emerald-500/10 animate-fade-in">
                                    <div className="flex flex-col items-center gap-3">
                                        <div className="w-16 h-16 rounded-full bg-emerald-500 flex items-center justify-center shadow-lg shadow-emerald-500/30 animate-bounce">
                                            <span className="material-symbols-outlined fill-1 text-white text-3xl">check_circle</span>
                                        </div>
                                        <span className="text-lg font-black text-emerald-700 dark:text-emerald-400">Checked In!</span>
                                        <div className="flex items-center gap-2 bg-white/80 dark:bg-white/10 px-4 py-2 rounded-xl">
                                            <PointsCoin size="md" />
                                            <span className="text-2xl font-black text-primary">+{checkinReward.total}</span>
                                        </div>
                                        {checkinReward.bonus > 0 && (
                                            <div className="px-3 py-1 bg-amber-100 dark:bg-amber-900/20 rounded-full">
                                                <span className="text-xs font-black text-amber-600 dark:text-amber-400">🎉 Milestone Bonus +{checkinReward.bonus}</span>
                                            </div>
                                        )}
                                    </div>
                                </div>
                            ) : checkinData?.hasCheckedToday ? (
                                <div className="w-full py-5 rounded-[2rem] font-black text-lg bg-gray-100 dark:bg-white/5 text-gray-400 flex items-center justify-center gap-3 cursor-default">
                                    <span className="material-symbols-outlined fill-1">task_alt</span>
                                    Checked In
                                </div>
                            ) : (
                                <button
                                    onClick={(e) => handleCheckin(e)}
                                    disabled={performingCheckin}
                                    className="w-full py-5 rounded-[2rem] font-black text-lg transition-all shadow-xl flex items-center justify-center gap-3 bg-primary text-black hover:scale-[1.02] active:scale-95 shadow-primary/30 group"
                                >
                                    {performingCheckin ? (
                                        <span className="w-6 h-6 border-3 border-black border-t-transparent rounded-full animate-spin"></span>
                                    ) : (
                                        <>
                                            <PointsCoin size="sm" animate />
                                            <span>Check In Now</span>
                                            <span className="text-sm font-bold opacity-60 ml-1">+{todayReward}</span>
                                        </>
                                    )}
                                </button>
                            )}

                            {/* Rewards Panel */}
                            <div className="p-6 rounded-[2rem] bg-white dark:bg-white/5 border border-gray-100 dark:border-white/5">
                                <h3 className="text-sm font-black uppercase tracking-widest text-gray-400 mb-4">Rewards</h3>
                                <div className="space-y-4">
                                    <div className="flex items-center justify-between">
                                        <span className="text-sm font-bold">Base Reward</span>
                                        <span className="text-sm font-black text-primary flex items-center gap-1">
                                            <PointsCoin size="sm" /> {baseReward}
                                        </span>
                                    </div>
                                    <div className="flex items-center justify-between">
                                        <span className="text-sm font-bold">Streak Multiplier</span>
                                        <span className="text-sm font-black text-amber-500">x{multiplier.toFixed(1)}</span>
                                    </div>
                                    <div className="pt-3 border-t border-gray-100 dark:border-white/5 flex items-center justify-between">
                                        <span className="text-sm font-bold">Today's Reward</span>
                                        <span className="text-sm font-black text-emerald-500 flex items-center gap-1">
                                            <PointsCoin size="sm" /> {todayReward}
                                        </span>
                                    </div>
                                    <div className="pt-3 border-t border-gray-100 dark:border-white/5 flex items-center justify-between">
                                        <span className="text-xs font-bold text-gray-400 italic">Next bonus in {7 - (streak % 7)} days</span>
                                        <span className="material-symbols-outlined text-primary">stars</span>
                                    </div>
                                </div>
                            </div>
                        </div>

                        {/* Calendar Side */}
                        <div className="lg:col-span-2 flex flex-col gap-6">
                            <div className="p-8 rounded-[2.5rem] bg-white dark:bg-white/5 border border-gray-100 dark:border-white/5 shadow-sm min-h-[500px] flex flex-col">
                                <div className="flex items-center justify-between mb-8">
                                    <div>
                                        <h2 className="text-2xl font-black tracking-tight">{currentMonth}</h2>
                                        <p className="text-sm font-bold text-gray-400">{currentYear}</p>
                                    </div>
                                    <div className="flex gap-2">
                                        <div className="px-3 py-1.5 rounded-xl bg-gray-50 dark:bg-white/5 text-[10px] font-black uppercase tracking-widest text-gray-400 flex items-center gap-2 border border-gray-100 dark:border-white/5">
                                            <div className="w-2 h-2 rounded-full bg-primary shadow-glow shadow-primary/50" />
                                            Checked
                                        </div>
                                    </div>
                                </div>

                                <div className="grid grid-cols-7 gap-2 mb-2">
                                    {['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'].map(day => (
                                        <div key={day} className="text-center text-[10px] font-black uppercase tracking-widest text-gray-400 py-2">
                                            {day}
                                        </div>
                                    ))}
                                </div>

                                <div className="grid grid-cols-7 gap-2 flex-1">
                                    {paddingDays.map(i => (
                                        <div key={`pad-${i}`} className="aspect-square" />
                                    ))}
                                    {calendarDays.map(day => {
                                        const checkin = isDayChecked(day);
                                        const checked = !!checkin;
                                        const isToday = day === today.getDate();
                                        const points = checkin?.points || 0;
                                        return (
                                            <div
                                                key={day}
                                                className={`aspect-square rounded-2xl flex flex-col items-center justify-center relative transition-all duration-500 group ${checked
                                                    ? 'bg-primary text-black shadow-lg shadow-primary/20 scale-[0.98]'
                                                    : isToday
                                                        ? 'bg-gray-100 dark:bg-white/10 ring-2 ring-primary/30'
                                                        : day < today.getDate()
                                                            ? 'bg-gray-50 dark:bg-white/5 border border-dashed border-gray-200 dark:border-white/5 opacity-30'
                                                            : 'bg-gray-50 dark:bg-white/5 border border-dashed border-gray-200 dark:border-white/5 opacity-40'
                                                    }`}
                                            >
                                                <span className={`text-sm font-black ${checked ? 'text-black' : isToday ? 'text-primary' : ''}`}>
                                                    {day}
                                                </span>
                                                {checked && points > 0 && (
                                                    <span className="text-[8px] font-black opacity-70 absolute bottom-1.5">+{points}</span>
                                                )}
                                                {checked && (
                                                    <span className="material-symbols-outlined text-[10px] font-black absolute top-1.5 right-1.5">check</span>
                                                )}
                                            </div>
                                        );
                                    })}
                                </div>

                                <div className="mt-8 p-4 rounded-2xl bg-amber-50 dark:bg-amber-900/10 border border-amber-100 dark:border-amber-900/20 flex items-start gap-3">
                                    <span className="material-symbols-outlined text-amber-500 fill-1">info</span>
                                    <p className="text-[11px] font-medium text-amber-800 dark:text-amber-400 leading-relaxed">
                                        Check in every day to increase your multiplier. Missing a day will reset your streak! Completing 7-day milestones awards extra bonus NMS Points.
                                    </p>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    );
};
