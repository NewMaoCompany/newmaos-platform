import React, { useState, useRef, useEffect, useMemo } from 'react';
import { useNavigate, Link } from 'react-router-dom';
import { useApp } from '../AppContext';
import { Navbar } from '../components/Navbar';
import { COURSE_TOPICS, COURSE_CONTENT_DATA } from '../constants';
import { SessionMode, Question } from '../types';

// Sub-component for Unit Card to handle its own async progress fetching
const UnitCard = ({ topic, idx, onClick, hasNotification }: { topic: any, idx: number, onClick: () => void, hasNotification?: boolean }) => {
    const { getUnitProgress, topicContent, questions, sections, getSectionStatus, user } = useApp();
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

        // Match if IDs are identical OR if the base topic matches AND the course is compatible
        const isMatch = q.topic === topic.id || (
            qBase === tBase && (
                q.course === 'Both' ||
                q.course === user.currentCourse ||
                !q.course // Fallback for legacy data
            )
        );

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
                        <div className="p-2 w-10 h-10 flex items-center justify-center rounded-lg bg-gray-100 dark:bg-white/5 text-gray-500 group-hover:bg-primary/20 group-hover:text-yellow-700 dark:group-hover:text-primary transition-colors relative">
                            <span className="material-symbols-outlined">{getTopicIcon(topic.id)}</span>
                            {hasNotification && (
                                <span className="absolute -top-1 -right-1 w-3 h-3 bg-red-500 border-2 border-surface-light dark:border-surface-dark rounded-full shadow-sm"></span>
                            )}
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
                    <span className="text-xs font-bold text-text-secondary dark:text-gray-500 uppercase tracking-wider">Progress</span>
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

// Component for rendering algorithmic practice history with dropdown support
const RecentSessionCard = ({ session, navigate }: { session: any, navigate: any }) => {
    const [isExpanded, setIsExpanded] = useState(false);

    const firstAttemptData = session.data?.firstAttempt;
    const reviewHistory = (session.data?.summaryHistory || []).filter((h: any) => h.type !== 'first_attempt');
    const hasHistory = reviewHistory.length > 0;
    const mode = session.data?.sessionMode || 'Adaptive';
    const displayTopic = session.data?.sessionTopic || 'Calculus AB';
    const cleanTopic = displayTopic.includes('_') ? displayTopic.split('_')[1] : displayTopic;
    const totalQ = session.data?.questionIds?.length || session.total_questions || 1;

    let mainScore = 0;
    let mainIsPerfect = false;

    // Use first attempt for main score, or fallback to capped total correct
    if (firstAttemptData && firstAttemptData.questionResults) {
        const correctCount = Object.values(firstAttemptData.questionResults).filter((r) => r === 'correct').length;
        const totalFirst = firstAttemptData.questionIds?.length || Object.keys(firstAttemptData.questionResults).length || totalQ;
        mainScore = Math.min(100, Math.round((correctCount / (totalFirst || 1)) * 100));
        mainIsPerfect = mainScore === 100;
    } else {
        mainScore = Math.min(100, Math.round(((session.correct_questions || 0) / totalQ) * 100));
        mainIsPerfect = mainScore === 100;
    }

    const overallScore = Math.min(100, Math.round(((session.correct_questions || 0) / totalQ) * 100));
    const overallIsPerfect = overallScore === 100;

    return (
        <div className="bg-white dark:bg-[#1a1a24] border border-gray-100 dark:border-white/10 p-5 rounded-2xl shadow-sm flex flex-col gap-4 animate-fade-in-up transition-all hover:shadow-md">
            <div className="flex justify-between items-start gap-2">
                <div>
                    <h3 className="font-bold text-base line-clamp-2 mb-1">{mode} Practice: {cleanTopic}</h3>
                    <div className="flex flex-wrap items-center gap-2 sm:gap-3 text-[10px] sm:text-xs font-bold uppercase tracking-wider text-gray-400">
                        <span className="flex items-center gap-1">
                            <span className="material-symbols-outlined text-[14px]">psychology</span>
                            Algorithmic
                        </span>
                        {session.last_accessed_at && (
                            <span className="whitespace-nowrap">{new Date(session.last_accessed_at).toLocaleDateString('en-US', { month: 'short', day: 'numeric' })}</span>
                        )}
                    </div>
                </div>
                {hasHistory && (
                    <button
                        onClick={() => setIsExpanded(!isExpanded)}
                        className={`w-8 h-8 rounded-full text-gray-400 hover:text-text-main dark:hover:text-white hover:bg-gray-100 dark:hover:bg-white/10 transition-all flex items-center justify-center ${isExpanded ? 'bg-gray-100 dark:bg-white/10 text-text-main dark:text-white rotate-180' : ''}`}
                        title="View Attempt History"
                    >
                        <span className="material-symbols-outlined transition-transform duration-300">expand_more</span>
                    </button>
                )}
            </div>

            <div className={`flex flex-wrap items-center justify-between mt-1 pt-3 border-t border-gray-100 dark:border-white/5 gap-3 ${isExpanded ? 'border-b pb-4 mb-2 -mx-5 px-5 bg-gray-50/50 dark:bg-white/[0.02]' : ''}`}>
                <div className="flex items-center gap-2">
                    <span className={`px-3 py-1.5 rounded-md text-[10px] sm:text-xs font-bold whitespace-nowrap ${mainIsPerfect ? 'bg-green-100 text-green-700 dark:bg-green-900/30 dark:text-green-400' : 'bg-red-50 text-red-600 dark:bg-red-900/20 dark:text-red-400'}`}>
                        Score: {mainScore}%
                    </span>
                    {isExpanded && (
                        <span className="text-[10px] sm:text-xs font-bold text-gray-400 uppercase tracking-wide hidden sm:inline-block">First Attempt</span>
                    )}
                </div>

                <div className="flex items-center gap-2">
                    {!overallIsPerfect && (
                        <button
                            onClick={() => navigate('/practice/session', { state: { topic: displayTopic, mode: 'Review', sessionId: session.section_id, forceStartNew: true } })}
                            className="bg-red-50 hover:bg-red-100 text-red-600 font-bold px-3 py-1.5 rounded-lg text-[10px] sm:text-xs transition-colors flex items-center justify-center gap-1 shadow-sm h-8"
                        >
                            <span className="material-symbols-outlined text-[14px]">rule</span>
                            Review
                        </button>
                    )}
                    <button
                        onClick={() => navigate('/practice/session', { state: { topic: displayTopic, mode: 'Summary', sessionId: session.section_id, showSummary: true } })}
                        className="bg-gray-100 dark:bg-white/5 hover:bg-gray-200 dark:hover:bg-white/10 text-text-main dark:text-gray-300 font-bold px-3 py-1.5 rounded-lg text-[10px] sm:text-xs transition-colors flex items-center justify-center gap-1 shadow-sm h-8"
                    >
                        <span className="material-symbols-outlined text-[14px]">analytics</span>
                        Summary
                    </button>
                </div>
            </div>

            {isExpanded && hasHistory && (
                <div className="flex flex-col gap-2 mt-4 pt-4 border-t border-gray-100 dark:border-white/5 bg-gray-50/50 dark:bg-black/20 p-4 rounded-xl">
                    {reviewHistory.map((historyItem: any, i: number) => {
                        const histScore = historyItem.score !== undefined ? historyItem.score : 0;
                        const histIsPerfect = histScore >= 100;
                        return (
                            <div key={`hist_${i}`} className="flex items-center justify-between p-3 rounded-xl bg-white dark:bg-white/5 border border-gray-100 dark:border-white/10 hover:shadow-md transition-all group">
                                <div className="flex items-center gap-3">
                                    <div className={`w-2 h-2 rounded-full shadow-sm ${histIsPerfect ? 'bg-green-500 shadow-green-500/50' : 'bg-red-500 shadow-red-500/50'}`}></div>
                                    <div className="flex flex-col">
                                        <span className="text-[11px] sm:text-xs font-bold text-text-main dark:text-gray-200">{historyItem.label || `Review attempt ${i + 1}`}</span>
                                        {historyItem.timestamp && (
                                            <span className="text-[9px] sm:text-[10px] text-gray-500 mt-0.5">{new Date(historyItem.timestamp).toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' })}</span>
                                        )}
                                    </div>
                                </div>
                                <div className="flex items-center gap-3">
                                    <span className={`text-[10px] sm:text-xs font-black px-2.5 py-1 rounded-lg ${histIsPerfect ? 'text-green-700 bg-green-100 dark:text-green-400 dark:bg-green-900/40' : 'text-red-700 bg-red-100 dark:text-red-400 dark:bg-red-900/40'}`}>
                                        {histScore}%
                                    </span>
                                    <button
                                        onClick={() => navigate('/practice/session', { state: { topic: displayTopic, mode: 'Summary', sessionId: session.section_id, showSummary: true, historyTarget: historyItem.label } })}
                                        className="text-[10px] uppercase font-bold text-white hover:bg-primary/90 transition-colors bg-primary px-3 py-1.5 rounded-lg shadow-sm"
                                    >
                                        View
                                    </button>
                                </div>
                            </div>
                        );
                    })}
                </div>
            )}
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
    const { user, activities, courses, recommendation, setSessionMode, setRecommendationTopic, radarData, topicContent, sections, getSectionStatus, sectionProgressMap, saveSectionProgress, notifications, markLinkAsRead } = useApp();
    const navigate = useNavigate();
    const [isDropdownOpen, setIsDropdownOpen] = useState(false);
    const [isUnitDropdownOpen, setIsUnitDropdownOpen] = useState(false);
    const dropdownRef = useRef<HTMLDivElement>(null);
    const unitDropdownRef = useRef<HTMLDivElement>(null);

    const practiceHistory = activities.filter(a => a.type === 'practice');
    const course = courses[user.currentCourse];
    const topics = COURSE_TOPICS[user.currentCourse];

    // Resolve Full Title if available in Unit Content (Using dynamic topicContent)
    // recommendation.topic might be "Limits" but topicContent keys are "Both_Limits"
    const activeUnit = topicContent[recommendation.topic]
        || Object.values(topicContent).find(u => u.id.includes(recommendation.topic));
    const displayTitle = activeUnit ? activeUnit.title : (recommendation.topic || 'Select a Topic');

    // Find the single most recent algorithmic session for this topic AND the currently selected mode.
    // This ensures Adaptive, Review, and Random are treated as 3 completely independent save files.
    const currentModeAlgorithmicSession = Object.values(sectionProgressMap || {})
        .filter((p: any) => p.entity_type === 'algorithmic' && p.data?.sessionTopic === recommendation.topic && (p.data?.mode?.toLowerCase() === recommendation.mode.toLowerCase() || (!p.data?.mode && recommendation.mode === 'Adaptive')))
        .sort((a: any, b: any) => new Date(b.last_accessed_at || 0).getTime() - new Date(a.last_accessed_at || 0).getTime())[0];


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
    // const { getSectionStatus } = useApp(); // Already destructured above

    // Async loading removed in favor of AppContext caching




    // Close dropdown when clicking outside
    useEffect(() => {
        const handleClickOutside = (event: MouseEvent) => {
            if (dropdownRef.current && !dropdownRef.current.contains(event.target as Node)) {
                setIsDropdownOpen(false);
            }
            if (unitDropdownRef.current && !unitDropdownRef.current.contains(event.target as Node)) {
                setIsUnitDropdownOpen(false);
            }
        };
        document.addEventListener('mousedown', handleClickOutside);
        return () => document.removeEventListener('mousedown', handleClickOutside);
    }, []);

    const handleTopicClick = (topicId: string) => {
        markLinkAsRead(`/practice/unit/${topicId}`);
        navigate(`/practice/unit/${topicId}`);
    };

    const handleModeSelect = (mode: SessionMode) => {
        setSessionMode(mode);
        setIsDropdownOpen(false);
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
        <div className="h-full w-full flex flex-col bg-background-light dark:bg-background-dark text-text-main dark:text-gray-100 overflow-x-hidden overflow-y-auto">
            <Navbar />

            <main className="flex-grow w-full max-w-7xl mx-auto px-4 sm:px-6 py-6 sm:py-10 flex flex-col gap-6 sm:gap-10 overflow-y-auto scroll-bounce">

                <header>
                    <h1 className="text-2xl sm:text-3xl md:text-4xl font-black tracking-tight mb-2">Practice Center</h1>
                    <p className="text-text-secondary dark:text-gray-400 text-lg">
                        Select a topic to start a new session or review your recent performance in <span className="font-bold text-text-main dark:text-white">{course.title}</span>.
                    </p>
                </header>

                <section>
                    {!recommendation.hasData ? (
                        /* No Data — Get Started Card */
                        <div className="bg-gradient-to-r from-gray-800 to-gray-900 rounded-2xl sm:rounded-3xl p-4 sm:p-6 md:p-8 text-white shadow-lg relative overflow-hidden group border border-gray-700/50">
                            <div className="absolute right-0 top-0 h-full w-1/3 opacity-5 pointer-events-none overflow-hidden rounded-r-3xl">
                                <span className="material-symbols-outlined text-[300px] absolute -top-10 -right-10 rotate-12">school</span>
                            </div>
                            <div className="relative z-10 flex flex-col gap-4 items-start w-full lg:max-w-4xl">
                                <div className="flex items-center gap-2 mb-1">
                                    <span className="bg-white/10 backdrop-blur-sm border border-white/10 px-2 py-0.5 rounded text-[10px] font-black uppercase tracking-widest flex items-center gap-1">
                                        <span className="material-symbols-outlined text-[12px]">waving_hand</span>
                                        Welcome
                                    </span>
                                </div>
                                <h2 className="text-2xl sm:text-3xl md:text-4xl font-black tracking-tight">
                                    Ready to Start Practicing?
                                </h2>
                                <p className="text-sm sm:text-base opacity-70 max-w-lg">
                                    Pick any unit below to begin your first practice session. Once you complete some questions, the algorithm will analyze your performance and recommend your next focus area.
                                </p>
                                <div className="flex items-center gap-3 mt-2">
                                    <span className="material-symbols-outlined text-primary text-2xl animate-bounce">arrow_downward</span>
                                    <span className="text-sm font-bold opacity-60">Choose a unit below to get started</span>
                                </div>
                            </div>
                        </div>
                    ) : (
                        /* Has Data — Algorithmic Decision Card */
                        <div
                            className="bg-gradient-to-r from-primary/90 to-primary rounded-2xl sm:rounded-3xl p-4 sm:p-6 md:p-8 text-text-main shadow-lg relative overflow-visible group border border-yellow-400/50 hover:shadow-xl transition-all"
                        >
                            {/* Background Decor */}
                            <div className="absolute right-0 top-0 h-full w-1/3 opacity-10 pointer-events-none overflow-hidden rounded-r-3xl">
                                <span className="material-symbols-outlined text-[300px] absolute -top-10 -right-10 rotate-12 transition-transform duration-700 group-hover:rotate-45">
                                    {getBackgroundIcon(recommendation.topic)}
                                </span>
                            </div>

                            <div className="relative z-10 flex flex-col gap-6 items-start w-full lg:max-w-4xl">

                                {/* Layer 1: Header & Title with Unit Switcher */}
                                <div className="relative" ref={unitDropdownRef}>
                                    <div className="flex items-center gap-2 mb-2">
                                        <span className="bg-black/5 backdrop-blur-sm border border-black/5 px-2 py-0.5 rounded text-[10px] font-black uppercase tracking-widest flex items-center gap-1 shadow-sm">
                                            <span className="material-symbols-outlined text-[12px] animate-pulse">psychology</span>
                                            Algorithmic Choice
                                        </span>
                                    </div>
                                    <button
                                        onClick={() => setIsUnitDropdownOpen(!isUnitDropdownOpen)}
                                        className="flex items-center gap-2 group/title"
                                    >
                                        <h2 className="text-2xl sm:text-3xl md:text-4xl font-black tracking-tight group-hover/title:translate-x-1 transition-transform cursor-pointer">
                                            {displayTitle}
                                        </h2>
                                        <span className={`material-symbols-outlined text-2xl opacity-60 transition-transform ${isUnitDropdownOpen ? 'rotate-180' : ''}`}>expand_more</span>
                                    </button>

                                    {/* Unit Switcher Dropdown */}
                                    {isUnitDropdownOpen && (
                                        <div className="absolute top-full left-0 mt-2 w-full sm:w-96 bg-white/95 dark:bg-[#2c2c2e]/95 backdrop-blur-xl rounded-xl shadow-2xl border border-gray-200 dark:border-gray-700 overflow-hidden animate-fade-in z-[100] max-h-[400px] overflow-y-auto">
                                            <div className="p-2 border-b border-gray-100 dark:border-white/10 text-[10px] font-bold uppercase tracking-wider text-gray-500 px-3">
                                                Switch Unit — {user.currentCourse === 'AB' ? 'AP Calculus AB' : 'AP Calculus BC'}
                                            </div>
                                            {topics.map((topic) => {
                                                const unitLabel = topic.subject.split(':')[0].trim();
                                                const radar = radarData.find(r => r.subject === unitLabel);
                                                const score = radar?.A ?? 0;
                                                const topicName = topic.id.includes('_') ? topic.id.split('_').slice(1).join('_') : topic.id;
                                                const isActive = recommendation.topic === topicName;
                                                return (
                                                    <button
                                                        key={topic.id}
                                                        onClick={() => {
                                                            setRecommendationTopic(topic.id);
                                                            setIsUnitDropdownOpen(false);
                                                        }}
                                                        className={`w-full text-left px-4 py-3 text-sm font-medium flex items-center justify-between gap-3 hover:bg-primary/10 transition-colors ${isActive ? 'bg-primary/5 text-primary' : 'text-text-main dark:text-white'}`}
                                                    >
                                                        <div className="flex items-center gap-3 flex-1 min-w-0">
                                                            <span className={`text-[10px] sm:text-xs font-black w-14 sm:w-16 flex-shrink-0 text-center py-1 rounded-md transition-shadow ${isActive ? 'bg-primary text-black shadow-sm' : 'bg-gray-100 dark:bg-white/10 text-gray-500'}`}>
                                                                {unitLabel}
                                                            </span>
                                                            <span className={`truncate text-xs ${isActive ? 'opacity-100 font-bold' : 'opacity-80 font-medium'}`}>{topic.subject.split(':').slice(1).join(':').trim()}</span>
                                                        </div>
                                                        <div className="flex items-center gap-2 shrink-0">
                                                            <div className="w-16 h-1.5 bg-gray-200 dark:bg-white/10 rounded-full overflow-hidden">
                                                                <div className="h-full bg-primary rounded-full transition-all" style={{ width: `${score}%` }}></div>
                                                            </div>
                                                            <span className={`text-xs font-bold ${score > 0 ? 'text-primary' : 'text-gray-400'}`}>{score}%</span>
                                                            {isActive && <span className="material-symbols-outlined text-primary text-[16px]">check_circle</span>}
                                                        </div>
                                                    </button>
                                                );
                                            })}
                                        </div>
                                    )}
                                </div>

                                {/* Layer 2: Enterprise Scoring Explanation */}
                                <div className="flex flex-col gap-2">
                                    <div className="flex items-center gap-2 text-sm font-bold opacity-80">
                                        <span className="material-symbols-outlined text-[18px]">analytics</span>
                                        <span>Multi-Factor Analysis</span>
                                        {recommendation.confidenceLevel && (
                                            <span className={`text-[9px] font-black uppercase tracking-widest px-1.5 py-0.5 rounded ${recommendation.confidenceLevel === 'high' ? 'bg-green-500/20 text-green-900' :
                                                recommendation.confidenceLevel === 'medium' ? 'bg-yellow-600/20 text-yellow-900' :
                                                    'bg-red-500/20 text-red-900'
                                                }`}>
                                                {recommendation.confidenceLevel} confidence
                                            </span>
                                        )}
                                    </div>
                                    <p className="font-mono text-xs md:text-sm opacity-90 bg-white/20 px-3 py-2 rounded-lg backdrop-blur-sm border border-black/5 inline-block shadow-sm">
                                        {recommendation.reason}
                                    </p>
                                    {/* Factor Breakdown Bars */}
                                    {recommendation.scoringFactors && (
                                        <div className="flex flex-wrap gap-x-4 gap-y-1 mt-1">
                                            {[
                                                { key: 'masteryGap', label: 'Gap', icon: 'trending_down' },
                                                { key: 'recencyDecay', label: 'Recency', icon: 'schedule' },
                                                { key: 'coverageGap', label: 'Coverage', icon: 'grid_view' },
                                                { key: 'sequentialBonus', label: 'Sequence', icon: 'route' },
                                                { key: 'weakBoost', label: 'Reinforce', icon: 'shield' },
                                            ].map(f => {
                                                const val = (recommendation.scoringFactors as any)?.[f.key] ?? 0;
                                                return (
                                                    <div key={f.key} className="flex items-center gap-1.5 text-[10px] opacity-70">
                                                        <span className="material-symbols-outlined text-[12px]">{f.icon}</span>
                                                        <span className="font-bold w-14 truncate">{f.label}</span>
                                                        <div className="w-12 h-1 bg-black/10 rounded-full overflow-hidden">
                                                            <div className={`h-full rounded-full transition-all ${val > 0.5 ? 'bg-black/70' : 'bg-black/40'}`} style={{ width: `${Math.max(val * 100, 2)}%` }}></div>
                                                        </div>
                                                        <span className="font-mono w-6 text-right">{Math.round(val * 100)}</span>
                                                    </div>
                                                );
                                            })}
                                        </div>
                                    )}
                                </div>

                                {/* Layer 3: Metrics & Mode */}
                                <div className="w-full flex flex-col md:flex-row md:items-end gap-6 mt-2">

                                    {/* Metrics Visualization */}
                                    <div className="flex-grow max-w-sm">
                                        <div className="flex justify-between text-xs font-bold uppercase tracking-wider mb-1.5 opacity-80">
                                            <span>Current Progress {recommendation.currentMastery}%</span>
                                            <span>Target {recommendation.targetMastery}%</span>
                                        </div>
                                        <div className="h-2 w-full bg-black/10 rounded-full relative overflow-hidden shadow-inner">
                                            <div
                                                className="absolute top-0 bottom-0 w-0.5 bg-black/40 z-10"
                                                style={{ left: `${recommendation.targetMastery}%` }}
                                                title="Target"
                                            ></div>
                                            <div
                                                className="h-full bg-black/80 rounded-full transition-all duration-1000 shadow-[0_0_10px_rgba(0,0,0,0.2)]"
                                                style={{ width: `${recommendation.currentMastery}%` }}
                                            ></div>
                                        </div>
                                    </div>

                                    {/* Controls */}
                                    <div className="flex items-center gap-3 z-50 flex-wrap lg:flex-nowrap">
                                        {/* Custom Dropdown */}
                                        <div className="relative z-20 shrink-0" ref={dropdownRef}>
                                            <button
                                                onClick={() => setIsDropdownOpen(!isDropdownOpen)}
                                                className="relative bg-white/20 hover:bg-white/30 border border-black/10 rounded-xl pl-4 pr-10 py-3 text-sm font-bold flex items-center gap-2 transition-all shadow-sm outline-none focus:ring-2 focus:ring-black/20 text-left min-w-[160px]"
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

                                        {(() => {
                                            const mainProgress = currentModeAlgorithmicSession;
                                            const progressData = mainProgress?.data;

                                            const firstAttempt = progressData?.firstAttempt;
                                            const review = progressData?.review;

                                            let buttonState: 'NOT_STARTED' | 'FIRST_ATTEMPT_IN_PROGRESS' | 'FIRST_ATTEMPT_COMPLETED' | 'REVIEW_IN_PROGRESS' | 'STILL_HAS_ERRORS' | 'COMPLETED' = 'NOT_STARTED';

                                            let actualIncorrectIds: string[] = [];
                                            const computeActualIncorrectIds = (): string[] => {
                                                // Ground truth: compute from merged questionResults (includes first attempt + review corrections)
                                                if (progressData?.questionResults) {
                                                    return Object.keys(progressData.questionResults).filter((id: string) => progressData.questionResults[id] === false || progressData.questionResults[id] === 'incorrect');
                                                }
                                                if (firstAttempt?.questionResults) {
                                                    return Object.keys(firstAttempt.questionResults).filter((id: string) => firstAttempt.questionResults[id] === false || firstAttempt.questionResults[id] === 'incorrect');
                                                }
                                                // Fallback to stored array only if no questionResults available
                                                if (progressData?.currentIncorrectIds && progressData.currentIncorrectIds.length > 0) {
                                                    return progressData.currentIncorrectIds;
                                                }
                                                return [];
                                            };
                                            actualIncorrectIds = computeActualIncorrectIds();
                                            const actualIncorrectCount = actualIncorrectIds.length;

                                            if (firstAttempt && firstAttempt.status !== 'not_started') {
                                                if (firstAttempt.status === 'in_progress') {
                                                    buttonState = 'FIRST_ATTEMPT_IN_PROGRESS';
                                                } else if (firstAttempt.status === 'completed') {
                                                    if (review?.status === 'in_progress') {
                                                        buttonState = 'REVIEW_IN_PROGRESS';
                                                    } else if (actualIncorrectCount > 0) {
                                                        buttonState = 'STILL_HAS_ERRORS';
                                                    } else {
                                                        buttonState = 'COMPLETED';
                                                    }
                                                }
                                            }

                                            // Fallback legacy evaluation
                                            if (buttonState === 'NOT_STARTED' && mainProgress) {
                                                const hasLegacyData = mainProgress.correct_questions > 0 || (progressData?.userAnswers && Object.keys(progressData.userAnswers).length > 0);
                                                if (mainProgress.status === 'completed' || (mainProgress.status === 'in_progress' && mainProgress.data?.summaryHistory?.length > 0)) {
                                                    buttonState = actualIncorrectCount > 0 ? 'STILL_HAS_ERRORS' : 'COMPLETED';
                                                } else if (hasLegacyData || mainProgress.status === 'in_progress') {
                                                    buttonState = 'FIRST_ATTEMPT_IN_PROGRESS';
                                                }
                                            }

                                            const handleSmartClick = (mode: SessionMode, isResuming: boolean, forceStartNew: boolean) => {
                                                navigate('/practice/session', {
                                                    state: {
                                                        topic: recommendation.topic,
                                                        mode: mode,
                                                        sessionId: mainProgress?.section_id,
                                                        isResuming,
                                                        forceStartNew
                                                    }
                                                });
                                            };

                                            const handleErrorReviewClick = (e: React.MouseEvent) => {
                                                e.preventDefault();
                                                if (!mainProgress) return;
                                                const reviewData = mainProgress.data?.review;
                                                const currentRound = reviewData?.round || 0;
                                                const newData = {
                                                    ...(mainProgress.data || {}),
                                                    currentIncorrectIds: actualIncorrectIds,
                                                    review: {
                                                        ...(reviewData || {}),
                                                        status: 'in_progress',
                                                        round: currentRound + 1,
                                                        targetQuestionIds: actualIncorrectIds,
                                                        userAnswers: {},
                                                        questionResults: {},
                                                        currentQuestionIndex: 0
                                                    }
                                                };
                                                saveSectionProgress(mainProgress.section_id, newData, { completed: 0, total: 0, score: 0 }, 'algorithmic', true);

                                                navigate('/practice/session', {
                                                    state: {
                                                        topic: recommendation.topic,
                                                        mode: recommendation.mode,
                                                        sessionId: mainProgress.section_id,
                                                        isResuming: true,
                                                        forceStartNew: false,
                                                        isErrorReviewAction: true
                                                    }
                                                });
                                            };

                                            const viewSummaryBtn = buttonState !== 'NOT_STARTED' && buttonState !== 'FIRST_ATTEMPT_IN_PROGRESS' ? (
                                                <button
                                                    onClick={(e) => {
                                                        e.preventDefault();
                                                        navigate('/practice/session', { state: { topic: recommendation.topic, mode: 'Summary', sessionId: mainProgress?.section_id, showSummary: true } });
                                                    }}
                                                    className="bg-gray-100 dark:bg-white/5 hover:bg-gray-200 dark:hover:bg-white/10 text-text-main dark:text-gray-300 font-bold px-4 py-3 rounded-xl transition-colors flex items-center justify-center gap-2 shrink-0 shadow-sm h-full whitespace-nowrap"
                                                >
                                                    <span className="material-symbols-outlined text-[18px]">analytics</span>
                                                    View Summary
                                                </button>
                                            ) : null;

                                            return (
                                                <div className="flex items-center gap-2 shrink-0">
                                                    {buttonState === 'NOT_STARTED' && (
                                                        <button
                                                            onClick={(e) => { e.preventDefault(); handleSmartClick(recommendation.mode, false, false); }}
                                                            className="bg-black hover:bg-gray-900 text-white font-bold py-3 px-8 rounded-xl transition-all flex items-center gap-2 shadow-lg hover:shadow-xl hover:-translate-y-0.5"
                                                        >
                                                            Start <span className="material-symbols-outlined text-[20px]">play_arrow</span>
                                                        </button>
                                                    )}

                                                    {buttonState === 'FIRST_ATTEMPT_IN_PROGRESS' && (
                                                        <button
                                                            onClick={(e) => { e.preventDefault(); handleSmartClick(progressData?.mode || recommendation.mode, true, false); }}
                                                            className="bg-black hover:bg-gray-900 text-white font-bold py-3 px-8 rounded-xl transition-all flex items-center gap-2 shadow-lg hover:shadow-xl hover:-translate-y-0.5"
                                                        >
                                                            Resume <span className="material-symbols-outlined text-[20px]">history</span>
                                                        </button>
                                                    )}

                                                    {buttonState === 'REVIEW_IN_PROGRESS' && (
                                                        <>
                                                            <button
                                                                onClick={(e) => {
                                                                    e.preventDefault();
                                                                    navigate('/practice/session', { state: { topic: recommendation.topic, mode: recommendation.mode, sessionId: mainProgress?.section_id, isResuming: true, isErrorReviewAction: true } });
                                                                }}
                                                                className="bg-red-50 hover:bg-red-100 text-red-600 font-bold px-4 py-3 rounded-xl transition-colors flex items-center justify-center gap-2 shrink-0 shadow-sm h-full whitespace-nowrap"
                                                            >
                                                                <span className="material-symbols-outlined text-[18px]">history</span>
                                                                Resume Review
                                                            </button>
                                                            {viewSummaryBtn}
                                                        </>
                                                    )}

                                                    {buttonState === 'STILL_HAS_ERRORS' && (
                                                        <>
                                                            <button
                                                                onClick={handleErrorReviewClick}
                                                                className="bg-red-50 hover:bg-red-100 text-red-600 font-bold px-4 py-3 rounded-xl transition-colors flex items-center justify-center gap-2 shrink-0 shadow-sm h-full whitespace-nowrap"
                                                            >
                                                                <span className="material-symbols-outlined text-[18px]">history_edu</span>
                                                                Review Errors
                                                            </button>
                                                            {viewSummaryBtn}
                                                        </>
                                                    )}

                                                    {buttonState === 'COMPLETED' && (
                                                        <>
                                                            <button
                                                                onClick={(e) => { e.preventDefault(); handleSmartClick(recommendation.mode, false, true); }}
                                                                className="bg-green-50 dark:bg-green-900/10 hover:bg-green-100 dark:hover:bg-green-900/20 text-green-600 dark:text-green-400 font-bold px-4 py-3 rounded-xl transition-colors flex items-center justify-center gap-2 shrink-0 shadow-sm h-full whitespace-nowrap"
                                                            >
                                                                <span className="material-symbols-outlined text-[18px]">refresh</span>
                                                                Start Over
                                                            </button>
                                                            {viewSummaryBtn}
                                                        </>
                                                    )}
                                                </div>
                                            );
                                        })()}
                                    </div>

                                </div>
                            </div>
                        </div>
                    )}
                </section>

                <div className="flex flex-col gap-6 sm:gap-10">

                    <section className="flex flex-col gap-6">
                        <h3 className="text-xl font-bold flex items-center gap-2">
                            <span className="material-symbols-outlined text-primary">grid_view</span>
                            Units
                        </h3>
                        <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                            {topics.map((topic, idx) => {
                                const hasNotif = notifications.some((n: any) => n.unread && n.link === `/practice/unit/${topic.id}`);
                                return (
                                    <UnitCard
                                        key={topic.id}
                                        topic={topic}
                                        idx={idx}
                                        onClick={() => handleTopicClick(topic.id)}
                                        hasNotification={hasNotif}
                                    />
                                );
                            })}
                        </div>
                    </section>

                    <aside className="flex flex-col gap-6">
                        <div className="flex items-center justify-between">
                            <h3 className="text-xl font-bold flex items-center gap-2">
                                <span className="material-symbols-outlined text-primary">history</span>
                                Recent History
                            </h3>
                        </div>

                        {(() => {
                            const recentSessions = Object.values(sectionProgressMap || {})
                                .filter(p => (p.status === 'completed' || (p.status === 'in_progress' && p.data?.summaryHistory?.length > 0)) && p.entity_type === 'algorithmic')
                                .sort((a, b) => new Date(b.last_accessed_at || 0).getTime() - new Date(a.last_accessed_at || 0).getTime())
                                .slice(0, 3);

                            if (recentSessions.length === 0) {
                                return (
                                    <div className="bg-white/40 dark:bg-black/20 rounded-2xl p-6 border border-black/5 dark:border-white/5 border-dashed flex items-center justify-center text-gray-500 h-32 text-sm">
                                        No recent algorithmic history yet. Start your first session!
                                    </div>
                                );
                            }

                            return (
                                <div className="flex flex-col gap-4">
                                    {recentSessions.map(session => (
                                        <RecentSessionCard key={session.section_id} session={session} navigate={navigate} />
                                    ))}
                                </div>
                            );
                        })()}
                    </aside>
                </div>

                <footer className="mt-auto border-t border-gray-200 dark:border-white/10 pt-8 pb-4 flex flex-col md:flex-row justify-between items-center text-text-secondary text-sm shrink-0 w-full">
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