import React, { useState, useEffect, useMemo, useCallback, useRef } from 'react';
import { useNavigate } from 'react-router-dom';
import { useApp } from '../AppContext';
import { Navbar } from '../components/Navbar';
import { MathRenderer } from '../components/MathRenderer';
import { ConfirmModal } from '../components/ConfirmModal';
import { supabase } from '../src/services/supabaseClient';

// Types
interface WrongAnswerItem {
    questionId: string;
    wrongCount: number;
    lastWrongAt: string;
    firstWrongAt: string;
    lastSelectedOptionId: string | null;
    question: {
        id: string;
        title: string;
        topic: string;
        sub_topic_id: string;
        type: string;
        difficulty: number;
        prompt: string;
        prompt_type: string;
        options: any[];
        correct_option_id: string;
        explanation: string;
        calculator_allowed: boolean;
        latex?: string;
    } | null;
}

// Custom Dropdown Component
const CustomDropdown = ({ value, options, onChange, placeholder }: {
    value: string;
    options: { value: string; label: string }[];
    onChange: (val: string) => void;
    placeholder?: string;
}) => {
    const [isOpen, setIsOpen] = useState(false);
    const ref = useRef<HTMLDivElement>(null);
    const selectedLabel = options.find(o => o.value === value)?.label || placeholder || 'Select';

    useEffect(() => {
        const handler = (e: MouseEvent) => {
            if (ref.current && !ref.current.contains(e.target as Node)) setIsOpen(false);
        };
        document.addEventListener('mousedown', handler);
        return () => document.removeEventListener('mousedown', handler);
    }, []);

    return (
        <div ref={ref} className="relative">
            <button
                onClick={() => setIsOpen(!isOpen)}
                className={`flex items-center justify-between w-[190px] px-4 py-2.5 rounded-xl text-sm font-semibold transition-all border ${isOpen
                    ? 'border-primary bg-primary/5 text-text-main dark:text-white shadow-sm'
                    : 'border-gray-200 dark:border-gray-700 bg-white dark:bg-white/5 text-text-main dark:text-gray-300 hover:border-gray-300 dark:hover:border-gray-600'
                    }`}
            >
                <span className="truncate flex-1 text-left mr-2">{selectedLabel}</span>
                <span className={`material-symbols-outlined text-[16px] shrink-0 transition-transform ${isOpen ? 'rotate-180' : ''}`}>expand_more</span>
            </button>
            {isOpen && (
                <div className="absolute top-full left-0 mt-1.5 w-[220px] bg-white dark:bg-[#1e1e2a] border border-gray-200 dark:border-gray-700 rounded-xl shadow-xl z-50 py-1.5 max-h-[320px] overflow-y-auto animate-fade-in custom-scrollbar">
                    {options.map(opt => (
                        <button
                            key={opt.value}
                            onClick={() => { onChange(opt.value); setIsOpen(false); }}
                            className={`w-full text-left px-4 py-2.5 text-sm transition-colors ${value === opt.value
                                ? 'bg-primary/10 text-primary font-bold'
                                : 'text-text-main dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-white/5'
                                }`}
                        >
                            {opt.label}
                        </button>
                    ))}
                </div>
            )}
        </div>
    );
};

// helpers
const getTopicDisplayName = (topic: string): string => {
    const clean = topic?.includes('_') ? topic.split('_').slice(1).join('_') : topic;
    return clean || 'Unknown';
};

const getDifficultyLabel = (d: number) => {
    switch (d) {
        case 1: return { text: 'Easy', color: 'bg-green-100 text-green-700 dark:bg-green-900/30 dark:text-green-400' };
        case 2: return { text: 'Medium', color: 'bg-yellow-100 text-yellow-700 dark:bg-yellow-900/30 dark:text-yellow-400' };
        case 3: return { text: 'Hard', color: 'bg-orange-100 text-orange-700 dark:bg-orange-900/30 dark:text-orange-400' };
        case 4: return { text: 'Expert', color: 'bg-red-100 text-red-700 dark:bg-red-900/30 dark:text-red-400' };
        case 5: return { text: 'Master', color: 'bg-purple-100 text-purple-700 dark:bg-purple-900/30 dark:text-purple-400' };
        default: return { text: 'Unknown', color: 'bg-gray-100 text-gray-700' };
    }
};

const getTopicIcon = (id: string) => {
    if (id?.includes('Limits')) return 'waves';
    if (id?.includes('Derivatives')) return 'trending_up';
    if (id?.includes('Composite')) return 'hub';
    if (id?.includes('Applications')) return 'speed';
    if (id?.includes('Analytical')) return 'insights';
    if (id?.includes('Integration')) return 'waterfall_chart';
    if (id?.includes('DiffEq')) return 'wind_power';
    if (id?.includes('AppIntegration')) return 'view_in_ar';
    if (id?.includes('Unit9') || id?.includes('Parametric')) return 'radar';
    if (id?.includes('Series')) return 'all_inclusive';
    if (id?.includes('Series')) return 'all_inclusive';
    return 'calculate';
};

const UNIT_NAME_MAP: Record<string, string> = {
    'Limits': 'Unit 1: Limits & Continuity (AB/BC)',
    'Derivatives': 'Unit 2: Differentiation (AB/BC)',
    'Composite': 'Unit 3: Composite Rules (AB/BC)',
    'Applications': 'Unit 4: Contextual Apps (AB/BC)',
    'Analytical': 'Unit 5: Analytical Apps (AB/BC)',
    'Integration': 'Unit 6: Integration (AB/BC)',
    'DiffEq': 'Unit 7: Differential Equations (AB/BC)',
    'AppIntegration': 'Unit 8: Apps of Integration (AB/BC)',
    'Unit9': 'Unit 9: Parametric & Polar (BC Only)',
    'Parametric': 'Unit 9: Parametric & Polar (BC Only)',
    'Series': 'Unit 10: Sequences & Series (BC Only)'
};

const UNIT_ORDER: Record<string, number> = {
    'Limits': 1,
    'Derivatives': 2,
    'Composite': 3,
    'Applications': 4,
    'Analytical': 5,
    'Integration': 6,
    'DiffEq': 7,
    'AppIntegration': 8,
    'Unit9': 9,
    'Parametric': 9,
    'Series': 10
};

const getUnitLabel = (topicStr: string) => UNIT_NAME_MAP[topicStr] || topicStr;

const extractSearchableText = (content: any): string => {
    if (!content) return '';
    if (typeof content !== 'string') {
        try { return JSON.stringify(content); } catch { return ''; }
    }
    let text = content;
    try {
        if (text.trim().startsWith('[')) {
            const arr = JSON.parse(text);
            if (Array.isArray(arr)) {
                text = arr.map((item: any) => typeof item === 'string' ? item : (item.text || JSON.stringify(item))).join(' ');
            }
        }
    } catch { }
    // Remove basic HTML tags to prevent matching them
    return text.replace(/<[^>]*>?/gm, ' ').replace(/\s+/g, ' ').toLowerCase();
};

// ═══════════════════════════════════════════
// Single wrong answer card (screenshot 2 style)
// ═══════════════════════════════════════════
const WrongAnswerCard = ({ item, onDismiss, onExpand, isExpanded }: {
    item: WrongAnswerItem;
    onDismiss: (id: string) => void;
    onExpand: (id: string) => void;
    isExpanded: boolean;
}) => {
    const q = item.question!;
    const diffLabel = getDifficultyLabel(q.difficulty);
    const topicName = getTopicDisplayName(q.topic);
    const topicIcon = getTopicIcon(q.topic);

    const options = Array.isArray(q.options) ? q.options :
        (typeof q.options === 'string' ? JSON.parse(q.options) : []);

    const correctOption = options.find((o: any) => o.id === q.correct_option_id);
    const userWrongOption = options.find((o: any) => o.id === item.lastSelectedOptionId && o.id !== q.correct_option_id);

    const timeAgo = (dateStr: string) => {
        const date = new Date(dateStr);
        const now = new Date();
        // Use calendar days (midnight boundary) not raw 24h diff
        const todayStart = new Date(now.getFullYear(), now.getMonth(), now.getDate());
        const dateStart = new Date(date.getFullYear(), date.getMonth(), date.getDate());
        const daysDiff = Math.round((todayStart.getTime() - dateStart.getTime()) / (1000 * 60 * 60 * 24));
        if (daysDiff === 0) return 'Today';
        if (daysDiff === 1) return 'Yesterday';
        if (daysDiff < 7) return `${daysDiff}d ago`;
        if (daysDiff < 30) return `${Math.floor(daysDiff / 7)}w ago`;
        return `${Math.floor(daysDiff / 30)}mo ago`;
    };

    return (
        <div className={`bg-white dark:bg-[#1a1a24] rounded-2xl overflow-hidden transition-all duration-300 ${isExpanded
            ? 'shadow-lg ring-1 ring-primary/20'
            : 'shadow-sm hover:shadow-md border border-gray-100 dark:border-gray-800 hover:border-gray-200 dark:hover:border-gray-700'
            }`}>

            {/* Collapsed Header */}
            <div
                className="px-5 py-4 cursor-pointer flex items-center gap-4"
                onClick={() => onExpand(item.questionId)}
            >
                {/* Number badge */}
                <div className={`w-10 h-10 rounded-xl flex items-center justify-center shrink-0 ${isExpanded
                    ? 'bg-primary text-black'
                    : 'bg-red-50 dark:bg-red-900/20 text-red-500'
                    }`}>
                    <span className="material-symbols-outlined text-[20px]">{topicIcon}</span>
                </div>

                <div className="flex-1 min-w-0 flex flex-col justify-center pr-2 sm:pr-4">
                    <h3 className="font-bold text-[15px] text-text-main dark:text-white truncate">
                        {q.title || `${topicName} — Q${q.sub_topic_id}`}
                    </h3>
                    <div className="text-[13px] text-gray-500 dark:text-gray-400 mt-0.5 opacity-90 max-w-[200px] sm:max-w-md md:max-w-lg lg:max-w-xl xl:max-w-2xl overflow-hidden whitespace-nowrap text-ellipsis">
                        {(() => {
                            if (!q.prompt) return 'View question...';
                            try {
                                let text = q.prompt;
                                if (text.trim().startsWith('[')) {
                                    const parsed = JSON.parse(text);
                                    if (Array.isArray(parsed)) {
                                        text = parsed.map((c: any) => typeof c === 'string' ? c : (c.text || '')).join(' ');
                                    }
                                }
                                text = text.replace(/<[^>]*>?/gm, ' ').replace(/\s+/g, ' ').trim();
                                return <MathRenderer content={text} />;
                            } catch {
                                const fallback = typeof q.prompt === 'string' ? q.prompt.replace(/<[^>]*>?/gm, ' ').replace(/\s+/g, ' ').trim() : '';
                                return fallback ? <MathRenderer content={fallback} /> : 'View question...';
                            }
                        })()}
                    </div>
                    <div className="flex items-center gap-2 mt-1.5 flex-wrap">
                        <span className="text-[11px] text-gray-400 uppercase tracking-wide font-medium">{topicName}</span>
                        <span className="text-gray-300 dark:text-gray-600">·</span>
                        <span className="text-[11px] text-gray-400">§ {q.sub_topic_id}</span>
                        <span className={`text-[10px] font-bold uppercase tracking-wider px-1.5 py-0.5 rounded-md ${diffLabel.color}`}>
                            {diffLabel.text}
                        </span>
                        <span className="text-[11px] font-semibold text-red-500 flex items-center gap-0.5">
                            × {item.wrongCount}
                        </span>
                    </div>
                </div>

                <div className="flex items-center gap-2 sm:gap-4 shrink-0 pl-2">
                    <div className="hidden sm:flex flex-col items-end justify-center">
                        <span className="text-[11px] text-gray-400 font-medium whitespace-nowrap">
                            {new Date(item.lastWrongAt).toLocaleDateString('en-US', { month: 'short', day: 'numeric' })}
                        </span>
                        <span className="text-[10px] text-gray-300 dark:text-gray-500 whitespace-nowrap">
                            {new Date(item.lastWrongAt).toLocaleTimeString('en-US', { hour: 'numeric', minute: '2-digit' })}
                        </span>
                    </div>

                    <button
                        onClick={(e) => { e.stopPropagation(); onDismiss(item.questionId); }}
                        className="w-8 h-8 rounded-full flex items-center justify-center text-gray-300 hover:text-red-500 hover:bg-red-50 dark:hover:bg-red-900/20 transition-all"
                        title="Remove from Notebook"
                    >
                        <span className="material-symbols-outlined text-[18px]">delete</span>
                    </button>

                    <div className={`w-8 h-8 rounded-full flex items-center justify-center bg-gray-50 dark:bg-white/5 text-gray-500 transition-transform duration-200 ${isExpanded ? 'rotate-180 bg-primary/10 text-primary dark:bg-primary/20' : ''}`}>
                        <span className="material-symbols-outlined text-[20px]">expand_more</span>
                    </div>
                </div>
            </div>

            {/* Expanded Content — Screenshot 2 style */}
            {isExpanded && (
                <div className="animate-fade-in">
                    {/* Question prompt */}
                    <div className="px-5 pb-4 border-t border-gray-100 dark:border-white/5 pt-4">
                        <div className="flex items-center gap-3 mb-3">
                            <div className="w-8 h-8 rounded-lg bg-red-50 dark:bg-red-900/20 text-red-500 flex items-center justify-center text-sm font-black shrink-0">
                                {item.wrongCount}
                            </div>
                            <div className="text-[15px] text-text-main dark:text-gray-200 leading-relaxed flex-1">
                                <MathRenderer content={q.prompt || ''} />
                            </div>
                        </div>
                    </div>

                    {/* YOUR ANSWER / CORRECT ANSWER side by side — matching screenshot 2 */}
                    <div className="px-5 pb-4 grid grid-cols-1 sm:grid-cols-2 gap-3">
                        {/* Your (Wrong) Answer */}
                        <div className="rounded-xl border border-red-200 dark:border-red-800/40 bg-red-50/50 dark:bg-red-900/10 p-4">
                            <div className="flex items-center gap-2 mb-2">
                                <span className="material-symbols-outlined text-red-500 text-[16px]">close</span>
                                <span className="text-[11px] font-bold uppercase tracking-wider text-red-500">Your Answer</span>
                            </div>
                            <div className="text-sm text-text-main dark:text-gray-300">
                                {userWrongOption ? (
                                    <MathRenderer content={userWrongOption.value || userWrongOption.text || ''} />
                                ) : (
                                    <span className="text-gray-400 italic">No answer selected</span>
                                )}
                            </div>
                        </div>

                        {/* Correct Answer */}
                        <div className="rounded-xl border border-green-200 dark:border-green-800/40 bg-green-50/50 dark:bg-green-900/10 p-4">
                            <div className="flex items-center gap-2 mb-2">
                                <span className="material-symbols-outlined text-green-600 text-[16px]">check</span>
                                <span className="text-[11px] font-bold uppercase tracking-wider text-green-600">
                                    Correct Answer {correctOption?.label ? `(${correctOption.label})` : ''}
                                </span>
                            </div>
                            <div className="text-sm text-text-main dark:text-gray-300 font-medium">
                                {correctOption ? (
                                    <MathRenderer content={correctOption.value || correctOption.text || ''} />
                                ) : (
                                    <span className="text-gray-400 italic">—</span>
                                )}
                            </div>
                        </div>
                    </div>

                    {/* Explanation */}
                    {q.explanation && (
                        <div className="px-5 pb-4">
                            <div className="rounded-xl border border-gray-100 dark:border-white/5 bg-gray-50/50 dark:bg-white/[0.02] p-4">
                                <div className="text-[11px] font-bold uppercase tracking-wider text-gray-400 mb-2">Explanation</div>
                                <div className="text-sm text-text-main dark:text-gray-300 leading-relaxed">
                                    <MathRenderer content={q.explanation || ''} />
                                </div>
                            </div>
                        </div>
                    )}

                    {/* Footer actions */}
                    <div className="px-5 py-3 border-t border-gray-100 dark:border-white/5 bg-gray-50/30 dark:bg-black/10 flex items-center justify-between gap-3">
                        <div className="text-[10px] text-gray-400 font-bold uppercase tracking-wider">
                            Wrong {item.wrongCount}× · First: {new Date(item.firstWrongAt).toLocaleDateString('en-US', { month: 'short', day: 'numeric' })}
                        </div>
                        <button
                            onClick={(e) => { e.stopPropagation(); onDismiss(item.questionId); }}
                            className="flex items-center gap-1.5 px-3.5 py-2 rounded-xl bg-green-50 hover:bg-green-100 dark:bg-green-900/20 dark:hover:bg-green-900/40 text-green-700 dark:text-green-400 text-xs font-bold transition-all"
                        >
                            <span className="material-symbols-outlined text-[14px]">check_circle</span>
                            Mastered
                        </button>
                    </div>
                </div>
            )}
        </div>
    );
};


export const WrongAnswerBook = () => {
    const { user, incorrectQuestionIds, wrongAnswersCache, fetchWrongAnswersCache } = useApp();
    const navigate = useNavigate();

    const wrongAnswers = wrongAnswersCache.items;
    const [isLoading, setIsLoading] = useState(!wrongAnswers || wrongAnswers.length === 0);
    const [error, setError] = useState<string | null>(null);
    const [expandedId, setExpandedId] = useState<string | null>(null);

    // Filters
    const [filterTopic, setFilterTopic] = useState<string>('all');
    const [filterDifficulty, setFilterDifficulty] = useState<number>(0);
    const [sortBy, setSortBy] = useState<'recent' | 'count' | 'difficulty'>('recent');
    const [searchQuery, setSearchQuery] = useState('');
    const [confirmDismissId, setConfirmDismissId] = useState<string | null>(null);
    const [stats, setStats] = useState({ total: 0, todayNew: 0, thisWeekNew: 0 });
    const [visibleCount, setVisibleCount] = useState(20);

    const [dismissedMap, setDismissedMap] = useState<Record<string, string>>(() => {
        try {
            const saved = localStorage.getItem(`wrong_answer_dismissed_map_${user?.id}`);
            return saved ? JSON.parse(saved) : {};
        } catch { return {}; }
    });

    const fetchAndSync = useCallback(async () => {
        // If we already have items in cache, we assume loading is instant
        if (wrongAnswersCache.items.length > 0) {
            setIsLoading(false);
        }

        try {
            await fetchWrongAnswersCache();
            // Recalculate stats based on latest cache
            const result = wrongAnswersCache.items;
            const now = Date.now();
            const todayStart = new Date().setHours(0, 0, 0, 0);
            const weekStart = now - 7 * 24 * 60 * 60 * 1000;
            setStats({
                total: result.length,
                todayNew: result.filter(w => new Date(w.lastWrongAt).getTime() > todayStart).length,
                thisWeekNew: result.filter(w => new Date(w.lastWrongAt).getTime() > weekStart).length
            });
        } catch (err: any) {
            console.error('Failed to sync wrong answers in background:', err);
            // Only set error if we have nothing to show at all
            if (wrongAnswersCache.items.length === 0) {
                setError(err.message || 'Failed to load');
            }
        } finally {
            setIsLoading(false);
        }
    }, [user?.id, dismissedMap, fetchWrongAnswersCache, wrongAnswersCache.items.length]);

    useEffect(() => {
        // Always run sync on mount to ensure freshness, but it won't block UI if cache exists
        fetchAndSync();
    }, [fetchAndSync]);

    const handleDismiss = async (questionId: string) => {
        const newDismissedMap = { ...dismissedMap, [questionId]: new Date().toISOString() };
        setDismissedMap(newDismissedMap);
        localStorage.setItem(`wrong_answer_dismissed_map_${user?.id}`, JSON.stringify(newDismissedMap));

        // Also try standard API, but we depend on the timestamp logic locally to ensure it works
        try {
            const isProd = window.location.hostname !== 'localhost' && window.location.hostname !== '127.0.0.1';
            const API_BASE = isProd ? 'https://newmaos-api.vercel.app/api' : '/api';
            const { data: { session } } = await supabase.auth.getSession();
            const token = session?.access_token;
            if (token) {
                fetch(`${API_BASE}/wrong-answers/dismiss`, {
                    method: 'POST', headers: { 'Authorization': `Bearer ${token}`, 'Content-Type': 'application/json' },
                    body: JSON.stringify({ questionId })
                }).catch(() => { });
            }
        } catch { }

        // Updating cache immediately for immediate UI response, server handles actual deletion asynchronously
        const newItems = wrongAnswers.filter(w => w.questionId !== questionId);
        // We use the same stats update logic safely since cache will mirror this fast
        setStats(prev => ({ ...prev, total: prev.total - 1 }));
        setConfirmDismissId(null);
        setExpandedId(null);
        // Notice: `wrongAnswers` is derived from cache, actual sync relies on the refetch or hard refresh
        // For 0-latency perceived speed, we just trigger refetch in background:
        fetchWrongAnswersCache();
    };

    const filteredAnswers = useMemo(() => {
        let result = [...wrongAnswers];
        if (filterTopic !== 'all') {
            const target = filterTopic.toLowerCase();
            result = result.filter(w => {
                const qTopic = w.question?.topic || '';
                const clean = qTopic.includes('_') ? qTopic.split('_').slice(1).join('_') : qTopic;
                return clean.toLowerCase() === target || qTopic.toLowerCase() === target;
            });
        }
        if (filterDifficulty > 0) result = result.filter(w => w.question?.difficulty === filterDifficulty);
        if (searchQuery.trim()) {
            const q = searchQuery.toLowerCase();
            result = result.filter(w => {
                const titleMatch = (w.question?.title || '').toLowerCase().includes(q);
                const subTopicMatch = (w.question?.sub_topic_id || '').toLowerCase().includes(q);

                const promptText = extractSearchableText(w.question?.prompt);
                const explanationText = extractSearchableText(w.question?.explanation);
                const optionsText = extractSearchableText(
                    typeof w.question?.options === 'string'
                        ? w.question.options
                        : JSON.stringify(w.question?.options || [])
                );

                return titleMatch ||
                    subTopicMatch ||
                    promptText.includes(q) ||
                    explanationText.includes(q) ||
                    optionsText.includes(q);
            });
        }
        switch (sortBy) {
            case 'count': result.sort((a, b) => b.wrongCount - a.wrongCount); break;
            case 'difficulty': result.sort((a, b) => (b.question?.difficulty || 0) - (a.question?.difficulty || 0)); break;
            default: result.sort((a, b) => new Date(b.lastWrongAt).getTime() - new Date(a.lastWrongAt).getTime());
        }
        return result;
    }, [wrongAnswers, filterTopic, filterDifficulty, sortBy, searchQuery]);

    // Only reset visible count when user explicitly changes a filter/sort, 
    // NOT when background data (wrongAnswers) refetches
    useEffect(() => {
        setVisibleCount(20);
    }, [filterTopic, filterDifficulty, sortBy, searchQuery]);

    const availableTopics = useMemo(() => {
        const topicSet = new Set<string>();
        wrongAnswers.forEach(w => {
            const clean = w.question?.topic?.includes('_') ? w.question.topic.split('_').slice(1).join('_') : w.question?.topic;
            if (clean) topicSet.add(clean);
        });
        // Convert to array and sort numerically by Unit Order
        return Array.from(topicSet).sort((a, b) => {
            const orderA = UNIT_ORDER[a] || 99;
            const orderB = UNIT_ORDER[b] || 99;
            return orderA - orderB;
        });
    }, [wrongAnswers]);

    // Dropdown options mapped to unit names
    const topicOptions = [{ value: 'all', label: 'All Units' }, ...availableTopics.map(t => ({ value: t, label: getUnitLabel(t) }))];
    const difficultyOptions = [
        { value: '0', label: 'All Difficulty' },
        { value: '1', label: 'Easy' }, { value: '2', label: 'Medium' },
        { value: '3', label: 'Hard' }, { value: '4', label: 'Expert' }, { value: '5', label: 'Master' }
    ];
    const sortOptions = [
        { value: 'recent', label: 'Most Recent' },
        { value: 'count', label: 'Most Wrong' },
        { value: 'difficulty', label: 'Hardest First' }
    ];

    return (
        <div className="h-full w-full flex flex-col bg-background-light dark:bg-background-dark text-text-main dark:text-gray-100 overflow-hidden">
            <Navbar />

            <main className="flex-grow w-full max-w-4xl mx-auto px-4 sm:px-6 py-6 flex flex-col gap-5 overflow-y-auto scroll-bounce">

                {/* Header */}
                <header className="flex items-center gap-3">
                    <button
                        onClick={() => navigate(-1)}
                        className="w-9 h-9 rounded-xl bg-gray-100 dark:bg-white/5 hover:bg-gray-200 dark:hover:bg-white/10 flex items-center justify-center transition-colors shrink-0"
                    >
                        <span className="material-symbols-outlined text-[20px]">arrow_back</span>
                    </button>
                    <div className="p-2 rounded-xl bg-red-50 dark:bg-red-900/20 text-red-500 shrink-0">
                        <span className="material-symbols-outlined text-[24px]">menu_book</span>
                    </div>
                    <div className="min-w-0">
                        <h1 className="text-xl sm:text-2xl font-black tracking-tight">Error Notebook</h1>
                        <p className="text-xs text-gray-500 dark:text-gray-400">Review and master every question you've gotten wrong</p>
                    </div>
                </header>

                {/* Stats — compact inline pills */}
                <div className="flex items-center gap-2 flex-wrap">
                    <div className="flex items-center gap-1.5 px-3 py-1.5 rounded-full bg-red-50 dark:bg-red-900/20 border border-red-100 dark:border-red-900/30">
                        <span className="text-lg font-black text-red-500">{stats.total}</span>
                        <span className="text-[10px] font-bold uppercase tracking-wider text-red-400">Total</span>
                    </div>
                    <div className="flex items-center gap-1.5 px-3 py-1.5 rounded-full bg-orange-50 dark:bg-orange-900/20 border border-orange-100 dark:border-orange-900/30">
                        <span className="text-lg font-black text-orange-500">{stats.todayNew}</span>
                        <span className="text-[10px] font-bold uppercase tracking-wider text-orange-400">Today</span>
                    </div>
                    <div className="flex items-center gap-1.5 px-3 py-1.5 rounded-full bg-blue-50 dark:bg-blue-900/20 border border-blue-100 dark:border-blue-900/30">
                        <span className="text-lg font-black text-blue-500">{stats.thisWeekNew}</span>
                        <span className="text-[10px] font-bold uppercase tracking-wider text-blue-400">This Week</span>
                    </div>
                </div>

                {/* Filters — custom dropdowns */}
                <div className="flex items-center gap-2 flex-wrap">
                    <div className="relative flex-1 min-w-[180px]">
                        <span className="absolute left-3 top-1/2 -translate-y-1/2 material-symbols-outlined text-gray-400 text-[18px]">search</span>
                        <input
                            type="text"
                            placeholder="Search questions..."
                            value={searchQuery}
                            onChange={e => setSearchQuery(e.target.value)}
                            className="w-full pl-9 pr-4 py-2.5 bg-white dark:bg-white/5 rounded-xl text-sm border border-gray-200 dark:border-gray-700 focus:border-primary focus:ring-1 focus:ring-primary/30 outline-none transition-all font-medium"
                        />
                    </div>
                    <CustomDropdown value={filterTopic} options={topicOptions} onChange={setFilterTopic} />
                    <CustomDropdown value={String(filterDifficulty)} options={difficultyOptions} onChange={(v) => setFilterDifficulty(Number(v))} />
                    <CustomDropdown value={sortBy} options={sortOptions} onChange={(v) => setSortBy(v as any)} />
                </div>

                {/* Loading */}
                {isLoading && (
                    <div className="flex items-center justify-center py-16">
                        <div className="flex flex-col items-center gap-3">
                            <div className="w-8 h-8 border-3 border-primary border-t-transparent rounded-full animate-spin"></div>
                            <span className="text-xs text-gray-500 font-medium">Loading...</span>
                        </div>
                    </div>
                )}

                {/* Error */}
                {!isLoading && error && (
                    <div className="flex items-center justify-center py-16">
                        <div className="flex flex-col items-center gap-3 text-center">
                            <span className="material-symbols-outlined text-3xl text-red-400">error</span>
                            <p className="text-sm text-gray-500">{error}</p>
                            <button onClick={fetchAndSync} className="px-4 py-2 bg-primary text-black font-bold rounded-xl text-xs hover:bg-primary/80 transition-colors">Retry</button>
                        </div>
                    </div>
                )}

                {/* Empty */}
                {!isLoading && !error && filteredAnswers.length === 0 && (
                    <div className="flex items-center justify-center py-16">
                        <div className="flex flex-col items-center gap-3 text-center max-w-sm">
                            <div className="w-16 h-16 rounded-2xl bg-green-50 dark:bg-green-900/20 flex items-center justify-center">
                                <span className="material-symbols-outlined text-4xl text-green-500">emoji_events</span>
                            </div>
                            <h3 className="text-lg font-black">{wrongAnswers.length === 0 ? 'No Errors Yet!' : 'No Matches'}</h3>
                            <p className="text-xs text-gray-500">
                                {wrongAnswers.length === 0
                                    ? 'Start practicing—any wrong answers will appear here.'
                                    : 'Try adjusting your filters.'}
                            </p>
                            {wrongAnswers.length === 0 && (
                                <button onClick={() => navigate('/practice')} className="px-5 py-2.5 bg-primary text-black font-bold rounded-xl text-sm hover:bg-primary/80 transition-colors flex items-center gap-1.5">
                                    <span className="material-symbols-outlined text-[16px]">play_arrow</span>
                                    Start Practicing
                                </button>
                            )}
                        </div>
                    </div>
                )}

                {/* List */}
                {!isLoading && !error && filteredAnswers.length > 0 && (
                    <div className="flex flex-col gap-2.5 pb-6">
                        <div className="text-[11px] font-bold uppercase tracking-wider text-gray-400">
                            Showing {Math.min(visibleCount, filteredAnswers.length)} of {filteredAnswers.length} questions
                        </div>
                        {filteredAnswers.slice(0, visibleCount).map(item => (
                            <WrongAnswerCard
                                key={item.questionId}
                                item={item}
                                onDismiss={(id) => setConfirmDismissId(id)}
                                onExpand={(id) => setExpandedId(expandedId === id ? null : id)}
                                isExpanded={expandedId === item.questionId}
                            />
                        ))}
                        {visibleCount < filteredAnswers.length && (
                            <button
                                onClick={() => setVisibleCount(v => v + 20)}
                                className="mt-6 w-full py-4 rounded-2xl text-sm font-black text-white relative group overflow-hidden transition-all duration-300 transform hover:-translate-y-1 hover:shadow-2xl shadow-lg shadow-primary/20"
                            >
                                <div className="absolute inset-0 bg-gradient-to-r from-primary via-yellow-400 to-orange-400 opacity-90 group-hover:opacity-100 transition-opacity"></div>
                                <div className="absolute inset-0 bg-[url('https://www.transparenttextures.com/patterns/cubes.png')] opacity-10 mix-blend-overlay"></div>
                                <div className="relative z-10 flex items-center justify-center gap-2">
                                    <span className="material-symbols-outlined text-[20px] animate-bounce">keyboard_double_arrow_down</span>
                                    UNVEIL MORE MISSING CONCEPTS
                                </div>
                            </button>
                        )}
                    </div>
                )}
            </main>

            <ConfirmModal
                isOpen={!!confirmDismissId}
                title="Remove from Error Notebook?"
                message="Are you sure you've mastered this question? This will remove it from your error notebook. You can always add it back if you get it wrong again."
                confirmText="Yes, I've Mastered It"
                cancelText="Keep Reviewing"
                onConfirm={() => confirmDismissId && handleDismiss(confirmDismissId)}
                onCancel={() => setConfirmDismissId(null)}
            />
        </div>
    );
};
