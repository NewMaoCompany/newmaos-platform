import React, { useState, useEffect } from 'react';
import { useApp } from '../AppContext';
import { Navbar } from '../components/Navbar';
import { useNavigate } from 'react-router-dom';
import { PointsCoin } from '../components/PointsCoin';
import { useToast } from '../components/Toast';
import { supabase } from '../src/services/supabaseClient';
import confetti from 'canvas-confetti';

export type DayState = 'checked' | 'missed' | 'future' | 'before_registration' | 'today_missed';

export const CheckinPage = () => {
    const { user, isAuthenticated, performDailyCheckin, getCheckinStatus, fetchUserPoints, triggerCoinAnimation, notifications, markNotificationRead, refreshCheckinStatus } = useApp();
    const { showToast } = useToast();
    const navigate = useNavigate();
    const [checkinData, setCheckinData] = useState<any>(null);
    const [loading, setLoading] = useState(true);
    const [performingCheckin, setPerformingCheckin] = useState(false);
    const [isRepairing, setIsRepairing] = useState(false);

    const today = new Date();
    const currentMonth = today.toLocaleString('en-US', { month: 'long' });
    const currentYear = today.getFullYear();
    const daysInMonth = new Date(currentYear, today.getMonth() + 1, 0).getDate();
    const firstDayOfMonth = new Date(currentYear, today.getMonth(), 1).getDay();
    const calendarDays = Array.from({ length: daysInMonth }, (_, i) => i + 1);
    const paddingDays = Array.from({ length: firstDayOfMonth }, (_, i) => i);

    const [selectedDay, setSelectedDay] = useState<number>(today.getDate());
    const [checkinReward, setCheckinReward] = useState<{ base: number; bonus: number; total: number; streak: number; isMilestone: boolean } | null>(null);

    const refreshStatus = async () => {
        if (!isAuthenticated) return;
        try {
            const data = await getCheckinStatus();
            setCheckinData({
                hasCheckedToday: data.checkedInToday,
                streak: data.currentStreak,
                history: data.monthCalendar,
                repairCost: data.repairCost || 100
            });
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

    // Auto-clear check-in notifications when entering this page
    useEffect(() => {
        notifications
            .filter(n => n.unread && n.link === '/checkin')
            .forEach(n => markNotificationRead(n.id));
    }, [notifications, markNotificationRead]);

    const handleRepair = async (dayToRepair: number) => {
        if (isRepairing) return;
        setIsRepairing(true);

        // Compute screen center for coin animation
        const targetX = window.innerWidth / 4;
        const targetY = window.innerHeight / 2;

        const targetDateStr = `${currentYear}-${String(today.getMonth() + 1).padStart(2, '0')}-${String(dayToRepair).padStart(2, '0')}`;

        try {
            const { data, error } = await supabase.rpc('repair_specific_day', { user_uuid: user?.id, target_date: targetDateStr });
            if (error) throw error;

            if (data.success) {
                triggerCoinAnimation(data.cost || repairCost, targetX, targetY, 'spend');
                showToast(`Streak repaired! New streak: ${data.new_current_streak}`, 'success');
                await refreshStatus();
            } else {
                showToast(data.reason === 'insufficient_points' ? 'Insufficient points' : data.message, 'error');
            }
        } catch (err: any) {
            showToast(err.message || 'Failed to repair day', 'error');
        } finally {
            setIsRepairing(false);
        }
    };

    const handleCheckin = async (e?: React.MouseEvent) => {
        if (performingCheckin || checkinData?.hasCheckedToday) return;

        let posX = window.innerWidth / 4;
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
                showToast(`Check-in successful! +${result.totalPoints} NMS Points`, 'success');

                confetti({
                    particleCount: 150,
                    spread: 70,
                    origin: { y: 0.6 },
                    colors: ['#FFD700', '#FFA500', '#FF6347', '#f9d406', '#34C759']
                });

                await refreshStatus();
                await refreshCheckinStatus();
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

    const history = checkinData?.history || [];
    const getCheckedData = (day: number) => {
        const dateStr = `${currentYear}-${String(today.getMonth() + 1).padStart(2, '0')}-${String(day).padStart(2, '0')}`;
        return history.find((h: any) => h.date === dateStr);
    };

    const getDayState = (day: number): DayState => {
        const targetDate = new Date(currentYear, today.getMonth(), day);
        targetDate.setHours(0, 0, 0, 0);

        const currentToday = new Date();
        currentToday.setHours(0, 0, 0, 0);

        const createdDate = user?.createdAt ? new Date(user.createdAt) : new Date();
        createdDate.setHours(0, 0, 0, 0);

        const isChecked = !!getCheckedData(day);

        if (targetDate.getTime() > currentToday.getTime()) return 'future';
        if (targetDate.getTime() < createdDate.getTime()) return 'before_registration';
        if (targetDate.getTime() === currentToday.getTime()) {
            return isChecked ? 'checked' : 'today_missed';
        }
        return isChecked ? 'checked' : 'missed';
    };

    const selectedState = getDayState(selectedDay);
    const selectedCheckinData = getCheckedData(selectedDay);

    // For the dynamic top card only (changes with selected day)
    let activeStreakForCalc = checkinData?.streak || 0;
    if (selectedState === 'checked' && selectedCheckinData) {
        activeStreakForCalc = selectedCheckinData.streak_day;
    } else if (selectedState === 'today_missed') {
        activeStreakForCalc = (checkinData?.streak || 0) + 1;
    } else if (selectedState === 'missed') {
        activeStreakForCalc = 1;
    }

    // 30-Day Blueprint — matches backend perform_daily_checkin exactly
    const get30DayReward = (streak: number) => {
        let base = 10, bonus = 0;
        if (streak >= 1 && streak <= 6) { base = 10; }
        else if (streak === 7) { base = 10; bonus = 50; }
        else if (streak >= 8 && streak <= 13) { base = 15; }
        else if (streak === 14) { base = 15; bonus = 80; }
        else if (streak >= 15 && streak <= 20) { base = 20; }
        else if (streak === 21) { base = 20; bonus = 120; }
        else if (streak >= 22 && streak <= 29) { base = 25; }
        else if (streak === 30) { base = 25; bonus = 300; }
        return { base, bonus, total: base + bonus };
    };

    // CURRENT REWARDS: Always shows TODAY's values (never changes with selected day)
    const todayStreak = checkinData?.hasCheckedToday
        ? (checkinData?.streak || 1)  // Already checked in today — show current streak
        : (checkinData?.streak || 0) + 1;  // Not yet — show what they WOULD get
    const todayRewardInfo = get30DayReward(todayStreak);
    const repairCost = checkinData?.repairCost || 100;

    return (
        <div className="h-screen bg-surface-light dark:bg-surface-dark text-text-main dark:text-gray-100 flex flex-col overflow-hidden">
            <Navbar />

            <div className="flex-1 w-full overflow-y-auto scroll-bounce">
                <div className="max-w-[1440px] mx-auto p-6 sm:p-10 pb-32 flex flex-col gap-10 animate-fade-in mt-8">

                    <div className="flex items-center gap-6">
                        <button
                            onClick={() => navigate(-1)}
                            className="w-14 h-14 -ml-2 rounded-full flex items-center justify-center hover:bg-gray-100 dark:hover:bg-white/10 transition-colors"
                        >
                            <span className="material-symbols-outlined text-3xl">arrow_back</span>
                        </button>
                        <h1 className="text-4xl font-black tracking-tight">Daily Check-in</h1>
                    </div>

                    <div className="grid grid-cols-1 lg:grid-cols-3 gap-10">

                        {/* LEFT COLUMN: CONTEXTUAL INFO PANEL */}
                        <div className="lg:col-span-1 flex flex-col gap-8">
                            {/* Dynamic Top Card */}
                            <div className="p-8 rounded-[2.5rem] relative overflow-hidden group shadow-2xl transition-all duration-300
                                ${selectedState === 'today_missed' ? 'bg-gradient-to-br from-primary to-amber-500 shadow-primary/20 text-black' : ''}
                                ${selectedState === 'checked' ? 'bg-gradient-to-br from-emerald-400 to-green-500 shadow-emerald-500/20 text-white' : ''}
                                ${selectedState === 'missed' ? 'bg-gradient-to-br from-red-500 to-rose-600 shadow-red-500/20 text-white' : ''}
                                ${(selectedState === 'future' || selectedState === 'before_registration') ? 'bg-gray-100 dark:bg-white/5 border border-gray-200 dark:border-white/10 text-gray-400' : ''}
                            "
                                style={{
                                    background: selectedState === 'today_missed' ? 'linear-gradient(to bottom right, #f9d406, #f59e0b)' :
                                        selectedState === 'checked' ? 'linear-gradient(to bottom right, #10b981, #22c55e)' :
                                            selectedState === 'missed' ? 'linear-gradient(to bottom right, #ef4444, #e11d48)' : undefined
                                }}
                            >
                                <div className="absolute -top-10 -right-10 w-32 h-32 bg-white/20 rounded-full blur-2xl group-hover:scale-150 transition-transform duration-700" />

                                <div className="relative z-10 flex flex-col items-center text-center">
                                    <span className={`text-sm font-black uppercase tracking-[0.2em] mb-6 
                                        ${selectedState === 'today_missed' ? 'opacity-70 text-black' : selectedState === 'checked' || selectedState === 'missed' ? 'opacity-80 text-white' : 'opacity-60'}
                                    `}>
                                        {selectedState === 'today_missed' && 'Today'}
                                        {selectedState === 'checked' && `Day ${selectedDay} Checked In`}
                                        {selectedState === 'missed' && `Day ${selectedDay} Missed`}
                                        {selectedState === 'future' && `Day ${selectedDay} is in the future`}
                                        {selectedState === 'before_registration' && `Day ${selectedDay} is unplayable`}
                                    </span>

                                    {selectedState === 'today_missed' && (
                                        <>
                                            <div className="flex items-baseline gap-2 text-black">
                                                <span className="text-9xl font-black tracking-tighter">{activeStreakForCalc}</span>
                                                <span className="text-2xl font-bold uppercase italic">Days</span>
                                            </div>
                                            <button
                                                onClick={(e) => handleCheckin(e)}
                                                disabled={performingCheckin}
                                                className="mt-8 w-full py-5 rounded-2xl font-black text-lg uppercase tracking-widest transition-all flex items-center justify-center gap-3 bg-black text-white hover:scale-[1.02] active:scale-95 shadow-2xl shadow-black/30"
                                            >
                                                {performingCheckin ? 'Checking In...' : 'Check In Now'}
                                            </button>
                                        </>
                                    )}

                                    {selectedState === 'checked' && (
                                        <>
                                            <div className="w-28 h-28 rounded-full bg-white/20 flex items-center justify-center mb-6">
                                                <span className="material-symbols-outlined text-[56px] text-white">check_circle</span>
                                            </div>
                                            <div className="flex items-center gap-3 bg-black/20 px-6 py-3 rounded-2xl mt-4">
                                                <PointsCoin size="md" />
                                                <span className="text-3xl font-black text-white">+{selectedCheckinData?.points || 0}</span>
                                            </div>
                                        </>
                                    )}

                                    {selectedState === 'missed' && (
                                        <>
                                            <div className="w-28 h-28 rounded-full bg-black/20 flex items-center justify-center mb-8">
                                                <span className="material-symbols-outlined text-[56px] text-white">build</span>
                                            </div>
                                            <span className="text-white/80 text-base font-bold leading-relaxed mb-8 px-4">
                                                Restore your streak to ensure your multiplier keeps growing. Cost resets at the start of next month.
                                            </span>

                                            <button
                                                onClick={() => handleRepair(selectedDay)}
                                                disabled={isRepairing}
                                                className="w-full py-5 bg-black hover:scale-[1.02] active:scale-95 text-white font-black text-base uppercase tracking-widest rounded-2xl transition-all shadow-2xl shadow-black/30 flex items-center justify-center gap-3"
                                            >
                                                {isRepairing ? 'Repairing...' : 'Repair Streak'}
                                                <div className="w-px h-4 bg-white/20 mx-2" />
                                                <span className="text-amber-400 font-black">{repairCost}</span>
                                                <PointsCoin size="sm" />
                                            </button>
                                        </>
                                    )}

                                    {(selectedState === 'future' || selectedState === 'before_registration') && (
                                        <>
                                            <div className="w-28 h-28 rounded-full bg-gray-200 dark:bg-white/10 flex items-center justify-center mb-6">
                                                <span className="material-symbols-outlined text-[56px] opacity-40">calendar_add_on</span>
                                            </div>
                                            <p className="text-sm font-medium opacity-60 mt-4 px-6 leading-relaxed">
                                                {selectedState === 'future' ? "You can't check in to a day that hasn't happened yet." : "You cannot repair dates before your account was created."}
                                            </p>
                                        </>
                                    )}
                                </div>
                            </div>

                            {/* Rewards Detail Panel — ALWAYS shows TODAY's values */}
                            <div className="p-10 rounded-[2.5rem] bg-white dark:bg-white/5 border border-gray-100 dark:border-white/5 shadow-xl">
                                <h3 className="text-base font-black uppercase tracking-widest text-gray-400 mb-6">Current Rewards</h3>
                                <div className="space-y-6">
                                    <div className="flex items-center justify-between">
                                        <span className="text-base font-bold">Streak Day</span>
                                        <span className="text-lg font-black text-amber-500 font-mono">Day {todayStreak}</span>
                                    </div>
                                    <div className="flex items-center justify-between">
                                        <span className="text-base font-bold">Base Reward</span>
                                        <span className="text-lg font-black text-primary flex items-center gap-2">
                                            <PointsCoin size="md" /> {todayRewardInfo.base}
                                        </span>
                                    </div>
                                    {todayRewardInfo.bonus > 0 && (
                                        <div className="flex items-center justify-between">
                                            <span className="text-base font-bold">Milestone Bonus</span>
                                            <span className="text-lg font-black text-emerald-500 flex items-center gap-2">
                                                <PointsCoin size="md" /> +{todayRewardInfo.bonus}
                                            </span>
                                        </div>
                                    )}
                                    <div className="pt-6 border-t border-gray-100 dark:border-white/5 flex items-center justify-between">
                                        <span className="text-base font-bold">Today's Total</span>
                                        <span className="text-2xl font-black text-emerald-500 flex items-center gap-2">
                                            <PointsCoin size="md" /> {todayRewardInfo.total}
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>

                        {/* RIGHT COLUMN: CALENDAR */}
                        <div className="lg:col-span-2 flex flex-col gap-10">
                            <div className="p-12 rounded-[3.5rem] bg-white dark:bg-white/5 border border-gray-100 dark:border-white/5 shadow-2xl min-h-[700px] flex flex-col">
                                <div className="flex items-center justify-between mb-12">
                                    <div>
                                        <h2 className="text-4xl font-black tracking-tighter">{currentMonth}</h2>
                                        <p className="text-lg font-bold text-gray-400 mt-1">{currentYear}</p>
                                    </div>
                                    <div className="flex gap-4">
                                        <div className="px-5 py-2.5 rounded-2xl bg-gray-50 dark:bg-white/5 text-xs font-black uppercase tracking-widest text-gray-400 flex items-center gap-3 border border-gray-100 dark:border-white/5">
                                            <div className="w-3 h-3 rounded-full bg-primary shadow-[0_0_15px_rgba(249,212,6,0.5)]" />
                                            Checked
                                        </div>
                                        <div className="px-5 py-2.5 rounded-2xl bg-gray-50 dark:bg-white/5 text-xs font-black uppercase tracking-widest text-gray-400 flex items-center gap-3 border border-gray-100 dark:border-white/5">
                                            <div className="w-3 h-3 rounded-full bg-red-500 shadow-[0_0_15px_rgba(239,68,68,0.5)]" />
                                            Missed
                                        </div>
                                    </div>
                                </div>

                                <div className="grid grid-cols-7 gap-4 mb-4">
                                    {['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'].map(day => (
                                        <div key={day} className="text-center text-xs font-black uppercase tracking-widest text-gray-400 py-3">
                                            {day}
                                        </div>
                                    ))}
                                </div>

                                <div className="grid grid-cols-7 gap-4 flex-1">
                                    {paddingDays.map(i => (
                                        <div key={`pad-${i}`} className="aspect-square" />
                                    ))}
                                    {calendarDays.map(day => {
                                        const state = getDayState(day);
                                        const isSelected = selectedDay === day;

                                        // Colors mapping correctly handling the visual states request
                                        let bgClass = 'bg-gray-50 dark:bg-white/5 border border-dashed border-gray-200 dark:border-white/5 opacity-40';
                                        let textClass = 'text-gray-400';
                                        let extraClasses = 'cursor-pointer hover:opacity-100';

                                        if (state === 'checked') {
                                            bgClass = 'bg-primary text-black shadow-xl shadow-primary/20';
                                            textClass = 'text-black';
                                        } else if (state === 'missed') {
                                            bgClass = 'bg-red-50 dark:bg-red-500/10 border-red-200 dark:border-red-500/30';
                                            textClass = 'text-red-500';
                                        } else if (state === 'today_missed') {
                                            bgClass = 'bg-gray-50 dark:bg-white/5 border-2 border-primary/50 shadow-lg shadow-primary/10';
                                            textClass = 'text-primary';
                                        } else if (state === 'future' || state === 'before_registration') {
                                            extraClasses = 'cursor-default opacity-30';
                                        }

                                        return (
                                            <div
                                                key={day}
                                                onClick={() => setSelectedDay(day)}
                                                className={`aspect-square rounded-[2rem] flex flex-col items-center justify-center relative transition-all duration-300 group ${bgClass} ${extraClasses} ${isSelected ? 'ring-8 ring-black/5 dark:ring-white/5 scale-110 z-10' : 'hover:scale-105'}`}
                                            >
                                                <span className={`text-xl font-black ${textClass}`}>
                                                    {day}
                                                </span>
                                                {state === 'checked' && (
                                                    <span className="material-symbols-outlined text-lg font-black absolute top-2 right-2 opacity-80">check</span>
                                                )}
                                                {state === 'missed' && (
                                                    <span className="material-symbols-outlined text-base font-black absolute top-2 right-2 text-red-500 opacity-60">close</span>
                                                )}
                                            </div>
                                        );
                                    })}
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    );
};
