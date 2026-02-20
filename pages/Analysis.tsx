import React, { useState, useEffect } from 'react';
import { Navbar } from '../components/Navbar';
import { useApp } from '../AppContext';
import { PointsCoin } from '../components/PointsCoin';
import { supabase } from '../src/services/supabaseClient';
import { Link, useNavigate, useLocation } from 'react-router-dom';
import { useToast } from '../components/Toast';
import { ProGateOverlay } from '../components/ProGateOverlay';
import {
    Radar, RadarChart, PolarGrid, PolarAngleAxis, PolarRadiusAxis, ResponsiveContainer,
    LineChart, Line, XAxis, YAxis, Tooltip, CartesianGrid, AreaChart, Area
} from 'recharts';

// --- Helper Functions ---

// Get local date string YYYY-MM-DD
const getLocalDateString = (date: Date) => {
    const y = date.getFullYear();
    const m = String(date.getMonth() + 1).padStart(2, '0');
    const d = String(date.getDate()).padStart(2, '0');
    return `${y}-${m}-${d}`;
};

// Parse YYYY-MM-DD
const parseLocalDate = (dateStr: string) => {
    if (!dateStr) return new Date();
    const [y, m, d] = dateStr.split('-').map(Number);
    return new Date(y, m - 1, d);
};

// Calculate proportional ticks for XAxis
const getChartTicks = (data: { date: string }[], range: '1W' | '1M' | '1Y' | 'ALL') => {
    if (data.length === 0) return [];
    const ticks: string[] = [];

    if (range === '1W') {
        // Show every day for a week
        return data.map(d => d.date);
    }

    if (range === '1M') {
        // Show Day 1, 10, 20, and Last Day
        data.forEach(d => {
            const date = parseLocalDate(d.date);
            const day = date.getDate();
            if (day === 1 || day === 10 || day === 20 || d.date === data[data.length - 1].date) {
                if (!ticks.includes(d.date)) ticks.push(d.date);
            }
        });
        return ticks;
    }

    if (range === '1Y') {
        // Show 1st of each month
        data.forEach(d => {
            const date = parseLocalDate(d.date);
            if (date.getDate() === 1) {
                ticks.push(d.date);
            }
        });
        return ticks;
    }

    if (range === 'ALL') {
        // Show 1st of each Year, or every 6 months if range is small
        const sessions = new Set<string>();
        data.forEach(d => {
            const date = parseLocalDate(d.date);
            if (date.getMonth() === 0 && date.getDate() === 1) {
                ticks.push(d.date);
            }
        });
        // If less than 2 years, show every quarter
        if (ticks.length < 2) {
            data.forEach(d => {
                const date = parseLocalDate(d.date);
                if (date.getDate() === 1 && (date.getMonth() % 3 === 0)) {
                    if (!ticks.includes(d.date)) ticks.push(d.date);
                }
            });
        }
        return ticks.sort();
    }

    return [];
};

// Fill data gaps based on range logic
const fillDataGaps = (data: { date: string; value: number }[], range: '1W' | '1M' | '1Y' | 'ALL') => {
    if (range === 'ALL' && data.length > 0) {
        // Fill gaps between first and last date
        const start = parseLocalDate(data[0].date);
        const end = new Date(); // today
        const filled: { date: string; value: number | null }[] = [];
        for (let d = new Date(start); d <= end; d.setDate(d.getDate() + 1)) {
            const dateStr = getLocalDateString(d);
            const existing = data.find(item => item.date === dateStr);
            filled.push(existing ? { ...existing, value: Number(existing.value) } : { date: dateStr, value: 0 });
        }
        return filled;
    }

    const today = new Date();
    today.setHours(0, 0, 0, 0);

    let startDate = new Date(today);
    let endDate = new Date(today);

    if (range === '1W') {
        const day = today.getDay(); // 0 is Sunday
        const diff = today.getDate() - day;
        startDate.setDate(diff); // Start Sunday
        endDate = new Date(startDate);
        endDate.setDate(startDate.getDate() + 6); // End Saturday
    } else if (range === '1M') {
        startDate = new Date(today.getFullYear(), today.getMonth(), 1);
        endDate = new Date(today.getFullYear(), today.getMonth() + 1, 0);
    } else if (range === '1Y') {
        startDate = new Date(today.getFullYear(), 0, 1);
        endDate = new Date(today.getFullYear(), 11, 31);
    }

    const fullData: { date: string; value: number | null }[] = [];
    for (let d = new Date(startDate); d <= endDate; d.setDate(d.getDate() + 1)) {
        const dateStr = getLocalDateString(d);
        const existing = data.find(item => item.date === dateStr);
        // Use 0 for missing values to ensure line continuity, or null if strict gap wanted. User said "point per day", usually implies 0 if no data.
        fullData.push(existing ? { ...existing, value: Number(existing.value) } : { date: dateStr, value: 0 });
    }
    // Aggregate for 1Y view to Months if too many points? 
    // User requested "12 months... proportional". 
    // If we have daily data, sending 365 points is fine for Recharts, but we can aggregate if needed.
    // For now, daily plots for 1Y is detailed but acceptable.
    return fullData;
};


export const Analysis = () => {
    const {
        user, radarData, accuracyHistory, fetchAccuracyHistory,
        notifications, markNotificationRead, fetchUserPoints, userPoints, triggerCoinAnimation,
        isPro
    } = useApp();
    const { showToast } = useToast();
    const navigate = useNavigate();
    const location = useLocation();




    // --- State ---
    const [timeRange, setTimeRange] = useState<'1W' | '1M' | '1Y' | 'ALL'>('1W');
    const [studyTimeRange, setStudyTimeRange] = useState<'1W' | '1M' | '1Y' | 'ALL'>('1W');
    const [studyTimeData, setStudyTimeData] = useState<{ date: string; value: number }[]>([]);
    const [totalStudyMinutes, setTotalStudyMinutes] = useState(0);
    const [profile, setProfile] = useState<{ streak_days: number; last_login_at: string | null; last_repair_at: string | null } | null>(null);
    const [pointsHistoryData, setPointsHistoryData] = useState<{ date: string; income: number; expense: number }[]>([]); // [NEW] moved up

    // [NEW] Fetch Points History
    const fetchPointsHistory = async () => {
        if (!user?.id) return;
        try {
            const { data, error } = await supabase.rpc('get_points_history', { p_user_id: user.id, p_days: 7 });
            if (error) throw error;
            if (data) {
                // Ensure data structure matches Recharts expectation
                setPointsHistoryData(data.map((d: any) => ({
                    date: d.date,
                    income: d.income,
                    expense: d.expense
                })));
            }
        } catch (err) {
            console.error('Failed to fetch points history:', err);
        }
    };

    // Initial Fetch
    useEffect(() => {
        fetchAccuracyHistory('1W');
        fetchStudyTimeHistory('1W');
        fetchProfileData();
        fetchPointsHistory(); // [NEW]
    }, [user?.id]);
    // Real-time Profile Subscription (Streak Updates)
    useEffect(() => {
        if (!user?.id) return;

        const channel = supabase.channel(`analysis-profile-${user.id}`)
            .on(
                'postgres_changes',
                {
                    event: 'UPDATE',
                    schema: 'public',
                    table: 'user_profiles',
                    filter: `id=eq.${user.id}`
                },
                (payload) => {
                    const newProfile = payload.new;
                    if (newProfile) {
                        setProfile(prev => prev ? ({
                            ...prev,
                            streak_days: newProfile.streak_days,
                            last_login_at: newProfile.last_login_at,
                            last_repair_at: newProfile.last_repair_at
                        }) : {
                            streak_days: newProfile.streak_days,
                            last_login_at: newProfile.last_login_at,
                            last_repair_at: newProfile.last_repair_at
                        });
                        // Also refresh points if needed, or rely on AppContext
                        if (newProfile.points_balance !== undefined) {
                            fetchUserPoints();
                        }
                    }
                }
            )
            .subscribe();

        return () => {
            supabase.removeChannel(channel);
        };
    }, [user?.id]);

    const fetchStudyTimeHistory = async (range: '1W' | '1M' | '1Y' | 'ALL') => {
        if (!user?.id) return;
        try {
            const { data, error } = await supabase.rpc('get_study_time_history', {
                target_user_id: user.id,
                range_type: range
            });

            if (error) {
                console.error('Error fetching study time:', error);
                return;
            }

            const formatted = (data || []).map((d: any) => ({ date: d.date, value: Number(d.minutes) }));
            setStudyTimeData(formatted);
            const total = formatted.reduce((acc: number, curr: any) => acc + (curr.value || 0), 0);
            setTotalStudyMinutes(total);

        } catch (err) {
            console.error(err);
        }
    };

    const fetchProfileData = async () => {
        if (!user?.id) return;
        try {
            const { data, error } = await supabase
                .from('user_profiles')
                .select('streak_days, last_login_at, last_repair_at')
                .eq('id', user.id)
                .single();
            if (data) setProfile(data);
        } catch (err) {
            console.error(err);
        }
    };

    const handleUseRepair = async (e?: React.MouseEvent) => {
        if (!user?.id) return;

        // Capture button position for animation target
        const btnRect = e?.currentTarget.getBoundingClientRect();
        const targetX = btnRect ? btnRect.left + btnRect.width / 2 : window.innerWidth / 2;
        const targetY = btnRect ? btnRect.top + btnRect.height / 2 : window.innerHeight / 2;

        try {
            const { data, error } = await supabase.rpc('use_monthly_repair', { user_uuid: user.id });
            if (error) throw error;

            if (data.success) {
                // Trigger spend animation (Wallet -> Repair Button)
                triggerCoinAnimation(100, targetX, targetY, 'spend');

                showToast(`Streak repaired! New streak: ${data.new_streak}`, 'success');
                fetchProfileData();
                fetchUserPoints(); // Refresh balance after deduction
            } else if (data.reason === 'insufficient_points') {
                showToast('Insufficient NMS Points to repair streak.', 'error');
            } else {
                showToast(data.message || 'Repair failed', 'error');
            }
        } catch (e: any) {
            console.error(e);
            showToast(e.message || 'Failed to repair streak', 'error');
        }
    };

    const handleAccuracyRangeChange = (range: '1W' | '1M' | '1Y' | 'ALL') => {
        setTimeRange(range);
        fetchAccuracyHistory(range);
    };

    const handleStudyTimeRangeChange = (range: '1W' | '1M' | '1Y' | 'ALL') => {
        setStudyTimeRange(range);
        fetchStudyTimeHistory(range);
    };

    // --- Notification Tracking (unified: all cards share one notification) ---
    const analysisNotifs = notifications.filter(n => n.unread && n.link === '/analysis');
    const hasAnalysisNotif = analysisNotifs.length > 0;

    const clearAllAnalysisNotifs = () => {
        analysisNotifs.forEach(n => markNotificationRead(n.id));
    };

    // --- Metrics & Trends ---

    // Accuracy Logic
    const currentAccuracy = accuracyHistory.length > 0 ? accuracyHistory[accuracyHistory.length - 1].accuracy : 0;
    let accTrend = 0;
    if (accuracyHistory.length >= 2) {
        accTrend = accuracyHistory[accuracyHistory.length - 1].accuracy - accuracyHistory[accuracyHistory.length - 2].accuracy;
    }

    // Study Time Logic (Compare last data point vs previous)
    // Note: studyTimeData is sparse (only days with data). We use processed data for chart, but trend should be based on real latest activity?
    // Let's use processed data to be consistent with chart visualization.
    const processedStudyData = fillDataGaps(studyTimeData, studyTimeRange);
    let studyTrend = 0;
    const lastStudyIndex = processedStudyData.length - 1;
    if (lastStudyIndex >= 1) {
        const curr = processedStudyData[lastStudyIndex].value || 0;
        const prev = processedStudyData[lastStudyIndex - 1].value || 0;
        studyTrend = curr - prev;
    }

    // Process Accuracy Data for Chart
    // Accuracy data needs to be populated carefully. If no attempt, accuracy is null? Or carry forward? 
    // Usually accuracy is "average up to that point" or "daily average". 
    // Assuming backend returns snapshot or daily avg. Let's start with 0 for empty days or null to break line.
    // User wants "connect lines", so 0 is better if it implies 0%. If it implies "no attempts", we might want to connect gaps.
    // Let's use 0 for now as it's a "Rate".
    const processedAccuracyData = fillDataGaps(accuracyHistory.map(d => ({ ...d, value: d.accuracy })), timeRange);


    const [viewCourse, setViewCourse] = React.useState<'AB' | 'BC'>(user.currentCourse || 'AB');
    const filteredRadarData = radarData.filter(d => {
        if (viewCourse === 'AB') {
            const unitNum = parseInt(d.subject.replace('Unit ', ''));
            return unitNum >= 1 && unitNum <= 8;
        }
        return true;
    });
    const strongestTopic = filteredRadarData.length > 0
        ? filteredRadarData.reduce((prev, current) => (prev.A > current.A) ? prev : current).subject
        : 'Calculating...';

    const repairsRemaining = (() => {
        if (!profile) return 0;
        if (!profile.last_repair_at) return 1;
        const lastRepair = new Date(profile.last_repair_at);
        const now = new Date();
        if (lastRepair.getMonth() === now.getMonth() && lastRepair.getFullYear() === now.getFullYear()) {
            return 0;
        }
        return 1;
    })();

    const isStreakValid = (() => {
        if (!profile?.last_login_at) return true;
        const lastDate = new Date(profile.last_login_at);
        const now = new Date();
        const lastMidnight = new Date(lastDate.getFullYear(), lastDate.getMonth(), lastDate.getDate());
        const nowMidnight = new Date(now.getFullYear(), now.getMonth(), now.getDate());
        const diffDays = Math.floor((nowMidnight.getTime() - lastMidnight.getTime()) / (1000 * 60 * 60 * 24));
        return diffDays <= 1;
    })();

    const displayStreak = isStreakValid ? (profile?.streak_days || 0) : 0;

    return (
        <div className="h-full flex flex-col bg-background-light dark:bg-background-dark text-text-main dark:text-gray-100 overflow-x-auto overflow-y-hidden">
            {/* Pro Gate */}
            {!isPro && location.pathname === '/analysis' && <ProGateOverlay featureName="Analysis" />}
            {/* Global Style overrides for Charts */}
            <style>{`
                .recharts-cartesian-grid-horizontal line, .recharts-cartesian-grid-vertical line { stroke-opacity: 0.1; }
                .recharts-xAxis .recharts-cartesian-axis-tick-value { font-size: 11px; fill: #9CA3AF; }
                .recharts-yAxis .recharts-cartesian-axis-tick-value { font-size: 11px; fill: #9CA3AF; }
            `}</style>

            <Navbar />
            <main className="flex-grow w-full max-w-7xl mx-auto px-4 sm:px-6 py-6 sm:py-10 animate-fade-in flex flex-col gap-6 sm:gap-10 overflow-y-auto scroll-bounce">
                <div className="mb-2">
                    <h1 className="text-2xl sm:text-3xl md:text-4xl lg:text-5xl font-black tracking-tight mb-3">Progress Analysis</h1>
                    <p className="text-text-secondary dark:text-gray-400 text-lg md:text-xl font-medium max-w-2xl">
                        You are in the <span className="text-yellow-600 dark:text-primary font-bold">Top {user.percentile}%</span> for {strongestTopic} based on your recent performance.
                    </p>
                </div>

                <div className="grid grid-cols-1 lg:grid-cols-3 gap-4 sm:gap-6 lg:gap-8">

                    {/* Accuracy Rate Chart */}
                    <div
                        onClick={() => clearAllAnalysisNotifs()}
                        className="lg:col-span-2 bg-white dark:bg-surface-dark rounded-3xl border border-gray-100 dark:border-gray-800 p-8 flex flex-col shadow-sm relative group/chart cursor-pointer transition-all hover:border-primary/30"
                    >
                        {hasAnalysisNotif && (
                            <span className="absolute top-6 left-6 w-2.5 h-2.5 bg-red-500 rounded-full shadow-lg shadow-red-500/50 animate-pulse z-30"></span>
                        )}

                        {/* Header */}
                        <div className="flex justify-between items-start mb-8">
                            <div>
                                <h3 className="text-xl font-bold text-stone-900 dark:text-white">Accuracy Rate</h3>
                                <p className="text-sm text-stone-500 mt-1">Daily Trend (24h refresh)</p>
                            </div>
                            <div className="text-right">
                                <div className="text-4xl font-black text-stone-900 dark:text-white mb-1">{currentAccuracy}%</div>
                                <div className={`flex items-center justify-end gap-1 text-sm font-bold ${accTrend >= 0 ? 'text-green-500' : 'text-red-500'}`}>
                                    {accTrend >= 0 ? (
                                        <span className="material-symbols-outlined text-[16px]">trending_up</span>
                                    ) : (
                                        <span className="material-symbols-outlined text-[16px]">trending_down</span>
                                    )}
                                    {Math.abs(accTrend).toFixed(1)}%
                                </div>
                            </div>
                        </div>

                        {/* Filters */}
                        <div className="flex gap-2 mb-6">
                            {(['1W', '1M', '1Y', 'ALL'] as const).map(range => (
                                <button
                                    key={range}
                                    onClick={() => handleAccuracyRangeChange(range)}
                                    className={`px-4 py-1.5 rounded-full text-xs font-bold transition-all ${timeRange === range
                                        ? 'bg-stone-900 text-white dark:bg-white dark:text-black shadow-md'
                                        : 'bg-gray-100 text-stone-500 hover:bg-gray-200 dark:bg-white/5 dark:text-gray-400 dark:hover:bg-white/10'
                                        }`}
                                >
                                    {range}
                                </button>
                            ))}
                        </div>

                        {/* Chart Area */}
                        <div className="h-[300px] w-full mt-auto">
                            <ResponsiveContainer width="100%" height="100%">
                                <LineChart
                                    data={processedAccuracyData}
                                    margin={{ top: 10, right: 10, left: -20, bottom: 0 }}
                                >
                                    <CartesianGrid strokeDasharray="3 3" vertical={false} stroke="#E5E7EB" />
                                    <XAxis
                                        dataKey="date"
                                        axisLine={false}
                                        tickLine={false}
                                        dy={10}
                                        ticks={getChartTicks(processedAccuracyData, timeRange)}
                                        tickFormatter={(date) => {
                                            if (!date) return '';
                                            const d = parseLocalDate(date);
                                            if (timeRange === '1W') return d.toLocaleDateString('en-US', { weekday: 'short' });
                                            if (timeRange === '1M') return d.getDate().toString();
                                            if (timeRange === '1Y') return d.toLocaleDateString('en-US', { month: 'short' });
                                            if (timeRange === 'ALL') return d.getFullYear().toString();
                                            return '';
                                        }}
                                        label={{ value: 'Date', position: 'insideBottom', offset: -10, style: { fill: '#9CA3AF', fontSize: 10, fontWeight: 600 } }}
                                    />
                                    <YAxis
                                        domain={[0, 100]}
                                        axisLine={false}
                                        tickLine={false}
                                        tickCount={5}
                                        label={{ value: 'Accuracy Rate', angle: -90, position: 'insideLeft', style: { fill: '#9CA3AF', fontSize: 10, fontWeight: 600 } }}
                                    />
                                    <Tooltip
                                        cursor={{ stroke: '#E5E7EB', strokeWidth: 2 }}
                                        contentStyle={{ borderRadius: '12px', border: 'none', boxShadow: '0 4px 20px -5px rgba(0,0,0,0.1)' }}
                                    />
                                    <Line
                                        type="monotone"
                                        dataKey="value"
                                        stroke="#FACC15"
                                        strokeWidth={2}
                                        dot={(timeRange === '1Y' || timeRange === 'ALL') ? false : { r: 3, fill: '#FACC15', strokeWidth: 1.5, stroke: '#fff' }}
                                        activeDot={{ r: 5, strokeWidth: 0 }}
                                    />
                                </LineChart>
                            </ResponsiveContainer>
                        </div>
                    </div>

                    {/* Unit Mastery Radar */}
                    <div
                        onClick={() => clearAllAnalysisNotifs()}
                        className="bg-white dark:bg-surface-dark rounded-3xl border border-gray-100 dark:border-gray-800 p-8 flex flex-col shadow-sm relative group/chart cursor-pointer transition-all hover:border-primary/30"
                    >
                        {hasAnalysisNotif && (
                            <span className="absolute top-6 left-6 w-2.5 h-2.5 bg-red-500 rounded-full shadow-lg shadow-red-500/50 animate-pulse z-30"></span>
                        )}
                        <div className="flex justify-between items-center mb-6">
                            <div>
                                <h3 className="text-xl font-bold text-stone-900 dark:text-white">Unit Mastery</h3>
                                <p className="text-sm text-stone-500 mt-1">Strengths & Weaknesses</p>
                            </div>
                            <div className="flex bg-gray-100 dark:bg-gray-800 p-1 rounded-xl">
                                <button onClick={() => setViewCourse('AB')} className={`px-3 py-1.5 rounded-lg text-xs font-black transition-all ${viewCourse === 'AB' ? 'bg-white dark:bg-gray-700 shadow-sm text-primary' : 'text-gray-500 hover:text-text-main'}`}>AB</button>
                                <button onClick={() => setViewCourse('BC')} className={`px-3 py-1.5 rounded-lg text-xs font-black transition-all ${viewCourse === 'BC' ? 'bg-white dark:bg-gray-700 shadow-sm text-primary' : 'text-gray-500 hover:text-text-main'}`}>BC</button>
                            </div>
                        </div>
                        <div className="h-[300px] w-full flex-grow">
                            <ResponsiveContainer width="100%" height="100%">
                                <RadarChart cx="50%" cy="50%" outerRadius="65%" data={filteredRadarData}>
                                    <PolarGrid stroke="#e5e7eb" />
                                    <PolarAngleAxis dataKey="subject" tick={{ fontSize: 10, fontWeight: 700, fill: '#9CA3AF' }} />
                                    <PolarRadiusAxis angle={30} domain={[0, 100]} tick={false} axisLine={false} />
                                    <Radar name="Mastery" dataKey="A" stroke="#FACC15" strokeWidth={3} fill="#FACC15" fillOpacity={0.3} />
                                </RadarChart>
                            </ResponsiveContainer>
                        </div>
                    </div>
                </div>

                <div className="grid grid-cols-1 lg:grid-cols-3 gap-4 sm:gap-6 lg:gap-8">

                    {/* Study Time Chart */}
                    <div
                        onClick={() => clearAllAnalysisNotifs()}
                        className="lg:col-span-2 bg-white dark:bg-surface-dark rounded-3xl border border-gray-100 dark:border-gray-800 p-8 flex flex-col shadow-sm relative group/chart cursor-pointer transition-all hover:border-primary/30"
                    >
                        {hasAnalysisNotif && (
                            <span className="absolute top-6 left-6 w-2.5 h-2.5 bg-red-500 rounded-full shadow-lg shadow-red-500/50 animate-pulse z-30"></span>
                        )}

                        <div className="flex justify-between items-start mb-8">
                            <div>
                                <h3 className="text-xl font-bold text-stone-900 dark:text-white">Study Time</h3>
                                <p className="text-sm text-stone-500 mt-1">Total Duration</p>
                            </div>
                            <div className="text-right">
                                <div className="text-4xl font-black text-stone-900 dark:text-white mb-1">
                                    {Math.round(totalStudyMinutes)} <span className="text-xl text-stone-400 font-bold">mins</span>
                                </div>
                                <div className={`flex items-center justify-end gap-1 text-sm font-bold ${studyTrend >= 0 ? 'text-green-500' : 'text-red-500'}`}>
                                    {studyTrend >= 0 ? (
                                        <span className="material-symbols-outlined text-[16px]">trending_up</span>
                                    ) : (
                                        <span className="material-symbols-outlined text-[16px]">trending_down</span>
                                    )}
                                    {Math.abs(studyTrend)} mins
                                </div>
                            </div>
                        </div>

                        <div className="flex gap-2 mb-6">
                            {(['1W', '1M', '1Y', 'ALL'] as const).map(range => (
                                <button
                                    key={range}
                                    onClick={() => handleStudyTimeRangeChange(range)}
                                    className={`px-4 py-1.5 rounded-full text-xs font-bold transition-all ${studyTimeRange === range
                                        ? 'bg-stone-900 text-white dark:bg-white dark:text-black shadow-md'
                                        : 'bg-gray-100 text-stone-500 hover:bg-gray-200 dark:bg-white/5 dark:text-gray-400 dark:hover:bg-white/10'
                                        }`}
                                >
                                    {range}
                                </button>
                            ))}
                        </div>

                        <div className="h-[300px] w-full mt-auto">
                            <ResponsiveContainer width="100%" height="100%">
                                <LineChart
                                    data={processedStudyData}
                                    margin={{ top: 10, right: 10, left: -20, bottom: 0 }}
                                >
                                    <CartesianGrid strokeDasharray="3 3" vertical={false} stroke="#E5E7EB" />
                                    <XAxis
                                        dataKey="date"
                                        axisLine={false}
                                        tickLine={false}
                                        dy={10}
                                        ticks={getChartTicks(processedStudyData, studyTimeRange)}
                                        tickFormatter={(date) => {
                                            if (!date) return '';
                                            const d = parseLocalDate(date);
                                            if (studyTimeRange === '1W') return d.toLocaleDateString('en-US', { weekday: 'short' });
                                            if (studyTimeRange === '1M') return d.getDate().toString();
                                            if (studyTimeRange === '1Y') return d.toLocaleDateString('en-US', { month: 'short' });
                                            if (studyTimeRange === 'ALL') return d.getFullYear().toString();
                                            return '';
                                        }}
                                        label={{ value: 'Date', position: 'insideBottom', offset: -10, style: { fill: '#9CA3AF', fontSize: 10, fontWeight: 600 } }}
                                    />
                                    <YAxis
                                        axisLine={false}
                                        tickLine={false}
                                        tickCount={5}
                                        label={{ value: 'Time (mins)', angle: -90, position: 'insideLeft', style: { fill: '#9CA3AF', fontSize: 10, fontWeight: 600 } }}
                                    />
                                    <Tooltip
                                        cursor={{ stroke: '#E5E7EB', strokeWidth: 2 }}
                                        contentStyle={{ borderRadius: '12px', border: 'none', boxShadow: '0 4px 20px -5px rgba(0,0,0,0.1)' }}
                                        formatter={(value: number) => [`${value} mins`, 'Study Time']}
                                    />
                                    <Line
                                        type="monotone"
                                        dataKey="value"
                                        stroke="#8B5CF6"
                                        strokeWidth={2}
                                        dot={(studyTimeRange === '1Y' || studyTimeRange === 'ALL') ? false : { r: 3, fill: '#8B5CF6', strokeWidth: 1.5, stroke: '#fff' }}
                                        activeDot={{ r: 5, strokeWidth: 0 }}
                                    />
                                </LineChart>
                            </ResponsiveContainer>
                        </div>
                    </div>

                    {/* Points History Chart */}
                    <div
                        onClick={() => clearAllAnalysisNotifs()}
                        className="bg-white dark:bg-surface-dark rounded-3xl border border-gray-100 dark:border-gray-800 p-8 flex flex-col shadow-sm relative group/chart cursor-pointer transition-all hover:border-primary/30"
                    >
                        {hasAnalysisNotif && (
                            <span className="absolute top-6 left-6 w-2.5 h-2.5 bg-red-500 rounded-full shadow-lg shadow-red-500/50 animate-pulse z-30"></span>
                        )}

                        <div className="flex justify-between items-start mb-6">
                            <div>
                                <h3 className="text-xl font-bold text-stone-900 dark:text-white">NMS Points History</h3>
                                <p className="text-sm text-stone-500 mt-1">Income & Expenditure</p>
                            </div>
                        </div>

                        {/* Chart */}
                        <div className="h-[300px] w-full mt-auto">
                            <ResponsiveContainer width="100%" height="100%">
                                <AreaChart
                                    data={pointsHistoryData}
                                    margin={{ top: 10, right: 10, left: -20, bottom: 0 }}
                                >
                                    <defs>
                                        <linearGradient id="colorIncome" x1="0" y1="0" x2="0" y2="1">
                                            <stop offset="5%" stopColor="#10B981" stopOpacity={0.1} />
                                            <stop offset="95%" stopColor="#10B981" stopOpacity={0} />
                                        </linearGradient>
                                        <linearGradient id="colorExpense" x1="0" y1="0" x2="0" y2="1">
                                            <stop offset="5%" stopColor="#EF4444" stopOpacity={0.1} />
                                            <stop offset="95%" stopColor="#EF4444" stopOpacity={0} />
                                        </linearGradient>
                                    </defs>
                                    <CartesianGrid strokeDasharray="3 3" vertical={false} stroke="#E5E7EB" />
                                    <XAxis
                                        dataKey="date"
                                        axisLine={false}
                                        tickLine={false}
                                        dy={10}
                                        tickFormatter={(date) => {
                                            if (!date) return '';
                                            const d = parseLocalDate(date);
                                            return d.toLocaleDateString('en-US', { weekday: 'short' });
                                        }}
                                        label={{ value: 'Date', position: 'insideBottom', offset: -10, style: { fill: '#9CA3AF', fontSize: 10, fontWeight: 600 } }}
                                    />
                                    <YAxis
                                        axisLine={false}
                                        tickLine={false}
                                        tickCount={5}
                                        label={{ value: 'Points', angle: -90, position: 'insideLeft', style: { fill: '#9CA3AF', fontSize: 10, fontWeight: 600 } }}
                                    />
                                    <Tooltip
                                        cursor={{ stroke: '#E5E7EB', strokeWidth: 2 }}
                                        contentStyle={{ borderRadius: '12px', border: 'none', boxShadow: '0 4px 20px -5px rgba(0,0,0,0.1)' }}
                                    />
                                    <Area
                                        type="monotone"
                                        dataKey="income"
                                        stroke="#10B981"
                                        fillOpacity={1}
                                        fill="url(#colorIncome)"
                                        strokeWidth={2}
                                        name="Income"
                                    />
                                    <Area
                                        type="monotone"
                                        dataKey="expense"
                                        stroke="#EF4444"
                                        fillOpacity={1}
                                        fill="url(#colorExpense)"
                                        strokeWidth={2}
                                        name="Expense"
                                    />
                                </AreaChart>
                            </ResponsiveContainer>
                        </div>
                    </div>
                </div>

                <footer className="mt-10 border-t border-gray-200 dark:border-white/10 pt-8 pb-10 flex flex-col md:flex-row justify-between items-center text-text-secondary text-sm">
                    <p>© 2026 NewMaoS Learning. All rights reserved.</p>
                </footer>
            </main>
        </div>
    );
};