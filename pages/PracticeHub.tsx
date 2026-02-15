import React, { useState, useRef, useEffect, useMemo } from 'react';
import { useNavigate, Link } from 'react-router-dom';
import { useApp } from '../AppContext';
import { Navbar } from '../components/Navbar';
import { COURSE_TOPICS, COURSE_CONTENT_DATA } from '../constants';
import { SessionMode, Question } from '../types';

// Sub-component for Unit Card to handle its own async progress fetching
const UnitCard = ({ topic, idx, onClick }: { topic: any, idx: number, onClick: () => void }) => {
    const { getUnitProgress, topicContent, questions, sections, getSectionStatus } = useApp();
    const [progress, setProgress] = useState(0);

    const content = topicContent[topic.id];
    const staticContent = COURSE_CONTENT_DATA[topic.id] || { subTopics: [] };

    useEffect(() => {
        getUnitProgress(topic.id).then(data => {
            if (data) setProgress(Math.round(data.progress_percentage || 0));
        });
    }, [topic.id]);

    // Icon helper
    const getTopicIcon = (id: string) => {
        if (id.includes('Limits')) return 'waves';
        if (id.includes('Derivatives')) return 'trending_up';
        if (id.includes('Composite')) return 'hub';
        if (id.includes('Applications')) return 'speed';
        if (id.includes('Analytical')) return 'insights';
        if (id.includes('Integration')) return 'waterfall_chart';
        if (id.includes('DiffEq')) return 'wind_power';
        if (id.includes('AppIntegration')) return 'view_in_ar';
        if (id.includes('Unit9') || id.includes('Parametric')) return 'radar';
        if (id.includes('Series')) return 'all_inclusive';
        return 'calculate';
    };

    // Calculate Counts
    const topicQuestions = questions.filter((q: Question) => {
        const qBase = q.topic.includes('_') ? q.topic.split('_')[1] : q.topic;
        const tBase = topic.id.includes('_') ? topic.id.split('_')[1] : topic.id;
        const isMatch = q.topic === topic.id || (q.course === 'Both' && qBase === tBase);
        const isStatusValid = q.status === 'published' || !q.status;
        return isMatch && isStatusValid;
    });
    const totalQuestions = topicQuestions.length;

    // Use static structure for chapter count
    const chapterCount = (staticContent.subTopics || []).length;

    // Time estimate
    const topicSections = sections[topic.id] || [];
    const totalMinutes = topicSections.reduce((sum: number, sec: any) => sum + (Number(sec.estimated_minutes) || 0), 0);
    const totalHours = Math.floor(totalMinutes / 60);
    const remainingMinutes = totalMinutes % 60;

    return (
        <div
            onClick={onClick}
            className="bg-surface-light dark:bg-surface-dark border border-gray-200 dark:border-gray-800 p-5 rounded-2xl hover:border-primary/50 hover:shadow-md transition-all cursor-pointer group flex flex-col justify-between"
        >
            <div>
                <div className="flex justify-between items-start mb-3">
                    <div className="flex flex-col gap-2">
                        <div className="p-2 w-10 h-10 flex items-center justify-center rounded-lg bg-gray-100 dark:bg-white/5 text-gray-500 group-hover:bg-primary/20 group-hover:text-yellow-700 dark:group-hover:text-primary transition-colors">
                            <span className="material-symbols-outlined">{getTopicIcon(topic.id)}</span>
                        </div>
                        {getSectionStatus(topic.id) !== 'not_started' && (
                            <span className={`inline-block px-2 py-0.5 rounded text-[10px] font-bold uppercase tracking-wider w-fit
                                ${getSectionStatus(topic.id) === 'in_progress'
                                    ? 'bg-yellow-100 text-yellow-700 dark:bg-yellow-900/30 dark:text-yellow-400'
                                    : 'bg-green-100 text-green-700 dark:bg-green-900/30 dark:text-green-400'}`}>
                                {getSectionStatus(topic.id) === 'in_progress' ? 'In Progress' : 'Completed'}
                            </span>
                        )}
                    </div>
                    <span className="text-xs font-bold bg-gray-100 dark:bg-white/10 px-2 py-1 rounded text-gray-500">
                        {content ? (content.title.includes(':') ? content.title.split(':')[0] : `Unit ${idx + 1}`) : `Unit ${idx + 1}`}
                    </span>
                </div>
                <h4 className="font-bold text-lg mb-1">{content ? content.title : topic.subject}</h4>

                {content?.description && (
                    <p className="text-xs text-text-secondary dark:text-gray-500 mb-2 line-clamp-2">
                        {content.description}
                    </p>
                )}

                <div className="flex flex-col gap-1">
                    <p className="text-sm text-gray-500 dark:text-gray-400">
                        {totalQuestions} questions • {chapterCount} chapters
                    </p>
                    <p className="text-xs text-gray-400 font-bold uppercase tracking-wider">
                        Est. Time: {totalHours > 0 ? `${totalHours}h ` : ''}{remainingMinutes}m
                    </p>
                </div>
            </div>

            <div className="mt-2">
                <div className="flex justify-between items-end mb-1.5">
                    <span className="text-xs font-bold text-text-secondary dark:text-gray-500 uppercase tracking-wider">Mastery</span>
                    <span className="text-xs font-bold text-primary">{progress}%</span>
                </div>
                <div className="w-full h-2 bg-gray-100 dark:bg-white/5 rounded-full overflow-hidden">
                    <div
                        className="h-full bg-primary rounded-full transition-all duration-1000 ease-out relative group-hover:shadow-[0_0_8px_rgba(249,212,6,0.6)]"
                        style={{ width: `${progress}%` }}
                    >
                        <div className="absolute top-0 left-0 right-0 bottom-0 bg-gradient-to-b from-white/20 to-transparent"></div>
                    </div>
                </div>
            </div>
        </div>
    );
};

// Helper Component for Grouped History
const HistoryGroupCard = ({ sectionId, activities }: { sectionId: string, activities: any[] }) => {
    const [isExpanded, setIsExpanded] = useState(false);

    // Aggregate Info
    const latest = activities[0]; // Assuming sorted desc
    const title = latest.title || 'Unknown Topic';
    const lastTime = latest.timestamp;

    // Sort chronological for display inside
    const sortedDetails = [...activities].sort((a, b) => new Date(b.created_at).getTime() - new Date(a.created_at).getTime());

    return (
        <div className="bg-surface-light dark:bg-surface-dark border border-gray-200 dark:border-gray-800 rounded-2xl overflow-hidden transition-all duration-300">
            {/* Summary Header - Click to Expand */}
            <div
                onClick={() => setIsExpanded(!isExpanded)}
                className="p-4 flex items-center justify-between cursor-pointer hover:bg-gray-50 dark:hover:bg-white/5 transition-colors"
            >
                <div className="flex items-center gap-3">
                    <div className="w-10 h-10 rounded-xl bg-primary/10 text-primary flex items-center justify-center">
                        <span className="material-symbols-outlined">history_edu</span>
                    </div>
                    <div>
                        <h4 className="font-bold text-sm text-text-main dark:text-white">{title}</h4>
                        <p className="text-[10px] text-gray-500 uppercase tracking-wider font-bold">
                            {activities.length} Session{activities.length > 1 ? 's' : ''} • Last: {lastTime}
                        </p>
                    </div>
                </div>
                <button className={`w-8 h-8 flex items-center justify-center rounded-full hover:bg-gray-200 dark:hover:bg-white/10 transition-transform duration-300 ${isExpanded ? 'rotate-180' : ''}`}>
                    <span className="material-symbols-outlined text-gray-500">expand_more</span>
                </button>
            </div>

            {/* Expanded Details */}
            {isExpanded && (
                <div className="border-t border-gray-100 dark:border-white/5 bg-gray-50/50 dark:bg-black/20 animate-fade-in">
                    {sortedDetails.map((activity, idx) => (
                        <div key={activity.id || idx} className="p-3 pl-16 border-b last:border-0 border-gray-100 dark:border-white/5 flex justify-between items-center hover:bg-white dark:hover:bg-white/5 transition-colors">
                            <div>
                                <div className="text-xs font-bold text-gray-700 dark:text-gray-300">
                                    {activity.description?.includes('Review') ? activity.description : (activity.attemptType === 'review' ? 'Review Session' : activity.label || 'Practice Session')}
                                </div>
                                <div className="text-[10px] text-gray-400">
                                    {activity.timestamp && !activity.timestamp.includes('Just')
                                        ? new Date(activity.timestamp).toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' })
                                        : (activity.timestamp || 'Unknown time')}
                                </div>
                            </div>
                            {activity.score !== undefined && (
                                <span className={`text-[10px] font-bold px-2 py-0.5 rounded-full ${activity.score >= 80 ? 'bg-green-100 text-green-700' : 'bg-yellow-100 text-yellow-700'}`}>
                                    {activity.score}%
                                </span>
                            )}
                        </div>
                    ))}
                </div>
            )}
        </div>
    );
};

export const PracticeHub = () => {
    const { user, activities, courses, recommendation, setSessionMode, radarData, topicContent, questions, sections } = useApp();
    const navigate = useNavigate();
    const [isDropdownOpen, setIsDropdownOpen] = useState(false);
    const dropdownRef = useRef<HTMLDivElement>(null);

    const practiceHistory = activities.filter(a => a.type === 'practice');
    const course = courses[user.currentCourse];
    const topics = COURSE_TOPICS[user.currentCourse];

    // Resolve Full Title if available in Unit Content (Using dynamic topicContent)
    const activeUnit = topicContent[recommendation.topic];
    const displayTitle = activeUnit ? activeUnit.title : (recommendation.topic || 'Select a Topic');

    // Resolve Background Icon based on topic string
    const getBackgroundIcon = (topic: string) => {
        const t = topic.toLowerCase();
        if (t.includes('limit')) return 'function';
        if (t.includes('series')) return 'all_inclusive';
        if (t.includes('deriv')) return 'trending_up';
        if (t.includes('integral')) return 'area_chart';
        return 'school';
    }

    // Customize Topic Icon Logic
    const getTopicIcon = (id: string) => {
        // Unit 1: Limits & Continuity
        if (id.includes('Limits')) return 'waves';
        // Unit 2: Differentiation Definition
        if (id.includes('Derivatives')) return 'trending_up';
        // Unit 3: Composite/Implicit (Chain Rule)
        if (id.includes('Composite')) return 'hub';
        // Unit 4: Contextual Applications (Motion/Rates)
        if (id.includes('Applications')) return 'speed';
        // Unit 5: Analytical Applications (Graph Analysis)
        if (id.includes('Analytical')) return 'insights';
        // Unit 6: Integration (Accumulation/Riemann)
        if (id.includes('Integration')) return 'waterfall_chart';
        // Unit 7: Diff Eq (Slope Fields)
        if (id.includes('DiffEq')) return 'wind_power';
        // Unit 8: App of Integration (Volumes)
        if (id.includes('AppIntegration')) return 'view_in_ar';
        // Unit 9: Parametric/Polar
        if (id.includes('Unit9') || id.includes('Parametric')) return 'radar';
        // Unit 10: Infinite Series
        if (id.includes('Series')) return 'all_inclusive';

        return 'calculate';
    };

    // Use synchronous helper for instant status
    const { getSectionStatus } = useApp();

    // Async loading removed in favor of AppContext caching




    // Close dropdown when clicking outside
    useEffect(() => {
        const handleClickOutside = (event: MouseEvent) => {
            if (dropdownRef.current && !dropdownRef.current.contains(event.target as Node)) {
                setIsDropdownOpen(false);
            }
        };
        document.addEventListener('mousedown', handleClickOutside);
        return () => document.removeEventListener('mousedown', handleClickOutside);
    }, []);

    const handleTopicClick = (topicId: string) => {
        navigate(`/practice/unit/${topicId}`);
    };

    const handleModeSelect = (mode: SessionMode) => {
        setSessionMode(mode);
        setIsDropdownOpen(false);
    }

    const handleStartSession = (e: React.MouseEvent) => {
        e.stopPropagation();
        navigate('/practice/session', {
            state: {
                topic: recommendation.topic,
                mode: recommendation.mode
            }
        });
    }

    const getModeIcon = (mode: SessionMode) => {
        switch (mode) {
            case 'Adaptive': return 'psychology';
            case 'Review': return 'history_edu';
            case 'Random': return 'shuffle';
            default: return 'settings';
        }
    }

    const getModeDescription = (mode: SessionMode) => {
        switch (mode) {
            case 'Adaptive': return "Maximizes expected mastery gain based on your learning curve.";
            case 'Review': return "Focuses strictly on previously incorrect concepts.";
            case 'Random': return "Randomized mix of topics for general retention.";
            default: return "";
        }
    }

    // Group History by SectionId
    const groupedHistory = useMemo(() => {
        const groups: Record<string, any[]> = {};
        practiceHistory.forEach((act: any) => {
            // Fallback to title if sectionId missing, or group unrelated items under 'misc'
            const key = act.sectionId || act.title || 'misc';
            if (!groups[key]) groups[key] = [];
            groups[key].push(act);
        });
        // Convert to array and sort by most recent activity in group
        return Object.entries(groups).map(([key, items]) => ({
            sectionId: key,
            activities: items,
            latestTime: items.reduce((max, item) => {
                const t = new Date(item.created_at || item.timestamp).getTime();
                return t > max ? t : max;
            }, 0)
        })).sort((a, b) => b.latestTime - a.latestTime);
    }, [practiceHistory]);

    return (
        <div className="h-full flex flex-col bg-background-light dark:bg-background-dark text-text-main dark:text-gray-100 overflow-hidden">
            <Navbar />

            <main className="flex-grow w-full max-w-7xl mx-auto px-4 sm:px-6 py-6 sm:py-10 flex flex-col gap-6 sm:gap-10 overflow-y-auto scroll-bounce">

                <header>
                    <h1 className="text-2xl sm:text-3xl md:text-4xl font-black tracking-tight mb-2">Practice Center</h1>
                    <p className="text-text-secondary dark:text-gray-400 text-lg">
                        Select a topic to start a new session or review your recent performance in <span className="font-bold text-text-main dark:text-white">{course.title}</span>.
                    </p>
                </header>

                <section>
                    {/* Algorithmic Decision Card */}
                    <div
                        className="bg-gradient-to-r from-primary/90 to-primary rounded-2xl sm:rounded-3xl p-4 sm:p-6 md:p-8 text-text-main shadow-lg relative overflow-visible group border border-yellow-400/50 hover:shadow-xl transition-all"
                    >
                        {/* Background Decor */}
                        <div className="absolute right-0 top-0 h-full w-1/3 opacity-10 pointer-events-none overflow-hidden rounded-r-3xl">
                            <span className="material-symbols-outlined text-[300px] absolute -top-10 -right-10 rotate-12 transition-transform duration-700 group-hover:rotate-45">
                                {getBackgroundIcon(recommendation.topic)}
                            </span>
                        </div>

                        <div className="relative z-10 flex flex-col gap-6 items-start max-w-2xl">

                            {/* Layer 1: Header & Title */}
                            <div>
                                <div className="flex items-center gap-2 mb-2">
                                    <span className="bg-black/5 backdrop-blur-sm border border-black/5 px-2 py-0.5 rounded text-[10px] font-black uppercase tracking-widest flex items-center gap-1 shadow-sm">
                                        <span className="material-symbols-outlined text-[12px] animate-pulse">psychology</span>
                                        Algorithmic Choice
                                    </span>
                                </div>
                                <h2 className="text-2xl sm:text-3xl md:text-4xl font-black tracking-tight group-hover:translate-x-1 transition-transform cursor-default">
                                    {displayTitle}
                                </h2>
                            </div>

                            {/* Layer 2: Explainable AI "Why" */}
                            <div className="flex flex-col gap-1">
                                <div className="flex items-center gap-2 text-sm font-bold opacity-80">
                                    <span className="material-symbols-outlined text-[18px]">info</span>
                                    <span>Why this session?</span>
                                </div>
                                <p className="font-mono text-xs md:text-sm opacity-90 bg-white/20 px-3 py-2 rounded-lg backdrop-blur-sm border border-black/5 inline-block shadow-sm">
                                    {recommendation.reason}
                                </p>
                            </div>

                            {/* Layer 3: Metrics & Mode */}
                            <div className="w-full flex flex-col md:flex-row md:items-end gap-6 mt-2">

                                {/* Metrics Visualization */}
                                <div className="flex-grow max-w-sm">
                                    <div className="flex justify-between text-xs font-bold uppercase tracking-wider mb-1.5 opacity-80">
                                        <span>Current Mastery {recommendation.currentMastery}%</span>
                                        <span>Target {recommendation.targetMastery}%</span>
                                    </div>
                                    <div className="h-2 w-full bg-black/10 rounded-full relative overflow-hidden shadow-inner">
                                        <div
                                            className="absolute top-0 bottom-0 w-0.5 bg-black/40 z-10"
                                            style={{ left: `${recommendation.targetMastery}%` }}
                                            title="Target Mastery"
                                        ></div>
                                        <div
                                            className="h-full bg-black/80 rounded-full transition-all duration-1000 shadow-[0_0_10px_rgba(0,0,0,0.2)]"
                                            style={{ width: `${recommendation.currentMastery}%` }}
                                        ></div>
                                    </div>
                                </div>

                                {/* Controls */}
                                <div className="flex flex-col sm:flex-row items-stretch sm:items-center gap-3 z-50">
                                    {/* Custom Dropdown */}
                                    <div className="relative" ref={dropdownRef}>
                                        <button
                                            onClick={() => setIsDropdownOpen(!isDropdownOpen)}
                                            className="w-full sm:w-auto bg-white/20 hover:bg-white/30 border border-black/10 rounded-xl pl-4 pr-10 py-3 text-sm font-bold flex items-center gap-2 transition-all shadow-sm outline-none focus:ring-2 focus:ring-black/20 text-left min-w-[180px]"
                                        >
                                            <span className="material-symbols-outlined text-[18px]">{getModeIcon(recommendation.mode)}</span>
                                            <span>{recommendation.mode} Mode</span>
                                            <span className={`material-symbols-outlined absolute right-3 top-1/2 -translate-y-1/2 text-lg opacity-70 transition-transform duration-200 ${isDropdownOpen ? 'rotate-180' : ''}`}>expand_more</span>
                                        </button>

                                        {isDropdownOpen && (
                                            <div className="absolute bottom-full left-0 mb-2 w-full sm:w-64 bg-white/95 dark:bg-[#2c2c2e]/95 backdrop-blur-xl rounded-xl shadow-2xl border border-gray-200 dark:border-gray-700 overflow-hidden animate-fade-in origin-bottom-left flex flex-col z-[100]">
                                                <div className="p-2 border-b border-gray-100 dark:border-white/10 text-[10px] font-bold uppercase tracking-wider text-gray-500 px-3">
                                                    Select Mode
                                                </div>
                                                {(['Adaptive', 'Review', 'Random'] as SessionMode[]).map((mode) => (
                                                    <button
                                                        key={mode}
                                                        onClick={() => handleModeSelect(mode)}
                                                        className={`text-left px-4 py-3 text-sm font-medium flex items-start gap-3 hover:bg-primary/10 transition-colors ${recommendation.mode === mode ? 'text-primary bg-primary/5' : 'text-text-main dark:text-white'}`}
                                                    >
                                                        <span className={`material-symbols-outlined text-[20px] mt-0.5 ${recommendation.mode === mode ? 'text-primary' : 'text-gray-400'}`}>
                                                            {getModeIcon(mode)}
                                                        </span>
                                                        <div>
                                                            <div className={`font-bold ${recommendation.mode === mode ? 'text-black dark:text-primary' : ''}`}>{mode}</div>
                                                            <div className="text-[10px] text-gray-500 leading-tight mt-0.5">{getModeDescription(mode)}</div>
                                                        </div>
                                                        {recommendation.mode === mode && (
                                                            <span className="material-symbols-outlined text-[16px] text-primary ml-auto mt-1">check</span>
                                                        )}
                                                    </button>
                                                ))}
                                            </div>
                                        )}
                                    </div>

                                    <button
                                        onClick={handleStartSession}
                                        className="bg-black text-white px-6 py-3 rounded-xl font-bold flex items-center justify-center gap-2 hover:scale-105 hover:shadow-lg transition-all active:scale-95 shadow-md whitespace-nowrap"
                                    >
                                        <span>Start</span>
                                        <span className="material-symbols-outlined">arrow_forward</span>
                                    </button>
                                </div>

                            </div>
                        </div>
                    </div>
                </section>

                <div className="grid grid-cols-1 lg:grid-cols-3 gap-6 sm:gap-10">

                    <section className="lg:col-span-2 flex flex-col gap-6">
                        <h3 className="text-xl font-bold flex items-center gap-2">
                            <span className="material-symbols-outlined text-primary">grid_view</span>
                            Units
                        </h3>
                        <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                            {topics.map((topic, idx) => (
                                <UnitCard
                                    key={topic.id}
                                    topic={topic}
                                    idx={idx}
                                    onClick={() => handleTopicClick(topic.id)}
                                />
                            ))}
                        </div>
                    </section>

                    <aside className="flex flex-col gap-6">
                        <div className="flex items-center justify-between">
                            <h3 className="text-xl font-bold flex items-center gap-2">
                                <span className="material-symbols-outlined text-primary">history</span>
                                Recent History
                            </h3>
                        </div>

                        <div className="flex flex-col gap-4">
                            {groupedHistory.length > 0 ? (
                                groupedHistory.slice(0, 5).map((group) => (
                                    <HistoryGroupCard
                                        key={group.sectionId}
                                        sectionId={group.sectionId}
                                        activities={group.activities}
                                    />
                                ))
                            ) : (
                                <div className="p-8 text-center text-gray-500 bg-surface-light dark:bg-surface-dark rounded-2xl border border-dashed border-gray-200 dark:border-gray-800">
                                    No practice history yet. Start your first session!
                                </div>
                            )}
                        </div>
                    </aside>

                </div>

                <footer className="mt-10 border-t border-gray-200 dark:border-white/10 pt-8 pb-10 flex flex-col md:flex-row justify-between items-center text-text-secondary text-sm">
                    <p>© 2026 NewMaoS Learning. All rights reserved.</p>
                    <div className="flex gap-6 mt-4 md:mt-0">
                        <Link to="/privacy" className="hover:text-text-main dark:hover:text-white transition-colors">Privacy</Link>
                        <Link to="/terms" className="hover:text-text-main dark:hover:text-white transition-colors">Terms</Link>
                        <Link to="/support" className="hover:text-text-main dark:hover:text-white transition-colors">Support</Link>
                    </div>
                </footer>
            </main >
        </div >
    );
};