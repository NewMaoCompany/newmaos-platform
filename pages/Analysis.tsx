import React from 'react';
import { Navbar } from '../components/Navbar';
import { useApp } from '../AppContext';
import { Link, useNavigate } from 'react-router-dom';
import {
    Radar, RadarChart, PolarGrid, PolarAngleAxis, ResponsiveContainer,
    LineChart, Line, XAxis, YAxis, Tooltip
} from 'recharts';

export const Analysis = () => {
    const { user, activities, radarData, lineData } = useApp();
    const navigate = useNavigate();

    // Sort radar data to find weakest areas
    const focusAreas = [...radarData].sort((a, b) => a.A - b.A).slice(0, 3);
    const strongestTopic = radarData.reduce((prev, current) => (prev.A > current.A) ? prev : current).subject;

    // Dynamic Trend Calculation
    const currentMetric = lineData[lineData.length - 1].value;
    const previousMetric = lineData.length > 1 ? lineData[lineData.length - 2].value : currentMetric;
    const trendValue = (currentMetric - previousMetric).toFixed(1);
    const isPositive = parseFloat(trendValue) >= 0;

    const handleFocusClick = (subject: string) => {
        navigate('/practice/session', { state: { topic: subject } });
    };

    return (
        <div className="min-h-screen flex flex-col bg-background-light dark:bg-background-dark text-text-main dark:text-gray-100">
            <Navbar />
            <main className="flex-grow w-full max-w-7xl mx-auto px-4 sm:px-6 py-6 sm:py-10 animate-fade-in flex flex-col gap-6 sm:gap-10 overflow-y-auto">
                <div className="mb-2">
                    <h1 className="text-2xl sm:text-3xl md:text-4xl lg:text-5xl font-black tracking-tight mb-3">Progress Analysis</h1>
                    <p className="text-text-secondary dark:text-gray-400 text-lg md:text-xl font-medium max-w-2xl">
                        You are in the <span className="text-yellow-600 dark:text-primary font-bold">Top {user.percentile}%</span> for {strongestTopic} based on your recent performance.
                    </p>
                </div>

                <div className="grid grid-cols-1 lg:grid-cols-3 gap-4 sm:gap-6 lg:gap-8">

                    <div className="lg:col-span-2 bg-surface-light dark:bg-surface-dark rounded-2xl border border-gray-200 dark:border-gray-800 p-6 md:p-8 flex flex-col shadow-sm">
                        <div className="flex justify-between items-start mb-6">
                            <div>
                                <h3 className="text-lg font-bold">Performance Trend</h3>
                                <p className="text-sm text-gray-500">Daily Mastery Index</p>
                            </div>
                            <div className="text-right">
                                <div className="text-3xl font-bold tracking-tight">{currentMetric}%</div>
                                <div className={`flex items-center justify-end gap-1 ${isPositive ? 'text-green-600' : 'text-red-500'} text-sm font-bold`}>
                                    <span className="material-symbols-outlined text-[16px]">{isPositive ? 'trending_up' : 'trending_down'}</span>
                                    <span>{isPositive ? '+' : ''}{trendValue}%</span>
                                </div>
                            </div>
                        </div>
                        <div className="h-[300px] w-full">
                            <ResponsiveContainer width="100%" height="100%">
                                <LineChart data={lineData}>
                                    <XAxis
                                        dataKey="day"
                                        axisLine={false}
                                        tickLine={false}
                                        tick={{ fontSize: 10, fill: '#86868b' }}
                                        dy={10}
                                    />
                                    <YAxis
                                        hide
                                        domain={[0, 100]}
                                    />
                                    <Tooltip
                                        contentStyle={{ borderRadius: '8px', border: 'none', boxShadow: '0 4px 12px rgba(0,0,0,0.1)' }}
                                        cursor={{ stroke: '#f9d406', strokeWidth: 1, strokeDasharray: '5 5' }}
                                    />
                                    <Line
                                        type="monotone"
                                        dataKey="value"
                                        stroke="#f9d406"
                                        strokeWidth={3}
                                        dot={false}
                                        activeDot={{ r: 6, fill: '#f9d406', stroke: '#fff', strokeWidth: 2 }}
                                    />
                                </LineChart>
                            </ResponsiveContainer>
                        </div>
                    </div>

                    <div className="bg-surface-light dark:bg-surface-dark rounded-2xl border border-gray-200 dark:border-gray-800 p-6 md:p-8 flex flex-col shadow-sm">
                        <div className="mb-6">
                            <h3 className="text-lg font-bold">Topic Mastery</h3>
                            <p className="text-sm text-gray-500">Strengths across core pillars</p>
                        </div>
                        <div className="h-[300px] w-full flex-grow overflow-hidden relative">
                            <ResponsiveContainer width="100%" height="100%">
                                <RadarChart cx="50%" cy="50%" outerRadius="55%" data={radarData}>
                                    <PolarGrid stroke="#e5e7eb" />
                                    <PolarAngleAxis
                                        dataKey="subject"
                                        tick={{ fontSize: 9, fontWeight: 'bold', fill: '#86868b' }}
                                    />
                                    <Radar
                                        name="Mastery"
                                        dataKey="A"
                                        stroke="#f9d406"
                                        strokeWidth={2}
                                        fill="#f9d406"
                                        fillOpacity={0.4}
                                    />
                                </RadarChart>
                            </ResponsiveContainer>
                        </div>
                        <div className="mt-4 flex flex-wrap gap-2 justify-center">
                            {radarData.slice(0, 3).map((d, i) => (
                                <span key={i} className="px-2 py-1 rounded-md bg-gray-50 dark:bg-white/5 border border-gray-100 dark:border-gray-700 text-xs font-medium">
                                    {d.subject.substring(0, 5)}: {d.A}%
                                </span>
                            ))}
                        </div>
                    </div>
                </div>

                <div className="grid grid-cols-1 md:grid-cols-2 gap-12">

                    <div>
                        <h2 className="text-2xl font-bold mb-6">Focus Areas</h2>
                        <div className="space-y-6">
                            {focusAreas.map((item, idx) => (
                                <div
                                    key={idx}
                                    onClick={() => handleFocusClick(item.subject)}
                                    className="group bg-surface-light dark:bg-surface-dark rounded-xl p-4 border border-transparent hover:border-primary/50 hover:shadow-md transition-all cursor-pointer"
                                >
                                    <div className="flex justify-between items-end mb-2">
                                        <div>
                                            <h4 className="font-bold group-hover:text-primary transition-colors">{item.subject}</h4>
                                            <p className="text-xs text-gray-500 mt-1">Recommended Practice</p>
                                        </div>
                                        <span className="text-sm font-bold">{item.A}%</span>
                                    </div>
                                    <div className="h-2 w-full bg-gray-100 dark:bg-gray-700 rounded-full overflow-hidden">
                                        <div className="h-full bg-primary rounded-full" style={{ width: `${item.A}%` }}></div>
                                    </div>
                                </div>
                            ))}
                        </div>
                    </div>

                    <div className="space-y-6">
                        <h2 className="text-2xl font-bold mb-6">Recent Activity</h2>
                        <div className="relative pl-6 border-l border-gray-200 dark:border-gray-800 space-y-8">
                            {activities.slice(0, 5).map((act, index) => (
                                <div key={act.id} className="relative animate-fade-in-up" style={{ animationDelay: `${index * 100}ms` }}>
                                    <div className={`absolute -left-[29px] top-1 size-3.5 rounded-full border-2 border-background-light dark:border-background-dark ${index === 0 ? 'bg-primary' : 'bg-gray-300 dark:bg-gray-600'}`}></div>
                                    <div className="flex flex-col gap-1">
                                        <span className="text-xs font-bold text-gray-500 uppercase tracking-wider">{act.timestamp}</span>
                                        <p className="font-medium">{act.type === 'quiz' ? <span>Completed <span className="font-bold">{act.title}</span></span> : act.description}</p>
                                    </div>
                                </div>
                            ))}
                        </div>

                        <div className="mt-8 bg-gradient-to-br from-gray-50 to-gray-100 dark:from-surface-dark dark:to-background-dark p-6 rounded-2xl border border-gray-200 dark:border-gray-800">
                            <div className="flex items-start gap-4">
                                <div className="p-2 bg-primary/20 rounded-lg text-yellow-700 dark:text-primary">
                                    <span className="material-symbols-outlined">lightbulb</span>
                                </div>
                                <div>
                                    <h4 className="font-bold text-sm uppercase tracking-wide text-gray-500 mb-1">Study Tip</h4>
                                    <p className="text-sm font-medium leading-relaxed">Focus on <span className="font-bold">{focusAreas[0]?.subject}</span> this week to improve your overall mastery score.</p>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>

                <footer className="mt-10 border-t border-gray-200 dark:border-white/10 pt-8 pb-10 flex flex-col md:flex-row justify-between items-center text-text-secondary text-sm">
                    <p>© 2026 NewMaoS Learning. All rights reserved.</p>
                    <div className="flex gap-6 mt-4 md:mt-0">
                        <Link to="/privacy" className="hover:text-text-main dark:hover:text-white transition-colors">Privacy</Link>
                        <Link to="/terms" className="hover:text-text-main dark:hover:text-white transition-colors">Terms</Link>
                        <Link to="/support" className="hover:text-text-main dark:hover:text-white transition-colors">Support</Link>
                    </div>
                </footer>
            </main>
        </div>
    );
};