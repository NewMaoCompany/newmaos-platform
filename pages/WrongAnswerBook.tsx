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
    return 'calculate';
};

const UNIT_NAME_MAP: Record<string, string> = {
    'Limits': 'Unit 1: Limits & Continuity',
    'Derivatives': 'Unit 2: Differentiation',
    'Composite': 'Unit 3: Composite Rules',
    'Applications': 'Unit 4: Contextual Apps',
    'Analytical': 'Unit 5: Analytical Apps',
    'Integration': 'Unit 6: Integration',
    'DiffEq': 'Unit 7: Differential Equations',
    'AppIntegration': 'Unit 8: Apps of Integration',
    'Unit9': 'Unit 9: Parametric & Polar',
    'Parametric': 'Unit 9: Parametric & Polar',
    'Series': 'Unit 10: Sequences & Series'
};

const UNIT_ORDER: Record<string, number> = {
    'Limits': 1, 'Derivatives': 2, 'Composite': 3, 'Applications': 4,
    'Analytical': 5, 'Integration': 6, 'DiffEq': 7, 'AppIntegration': 8,
    'Unit9': 9, 'Parametric': 9, 'Series': 10
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
    return text.replace(/<[^>]*>?/gm, ' ').replace(/\s+/g, ' ').toLowerCase();
};

// ═══════════════════════════════════════════
// Compact wrong answer row within a Unit Block
// ═══════════════════════════════════════════
const WrongAnswerRow = ({ item, onDismiss, onExpand, isExpanded }: {
    item: WrongAnswerItem;
    onDismiss: (id: string) => void;
    onExpand: (id: string) => void;
    isExpanded: boolean;
}) => {
    const q = item.question!;
    const diffLabel = getDifficultyLabel(q.difficulty);

    const options = Array.isArray(q.options) ? q.options :
        (typeof q.options === 'string' ? JSON.parse(q.options) : []);

    const correctOption = options.find((o: any) => o.id === q.correct_option_id);
    const userWrongOption = options.find((o: any) => o.id === item.lastSelectedOptionId && o.id !== q.correct_option_id);

    return (
        <div className={`transition-all duration-200 ${isExpanded ? 'bg-white dark:bg-[#1a1a24] rounded-xl shadow-md ring-1 ring-primary/20' : ''}`}>
            {/* Row */}
            <div
                className={`flex items-center gap-3 px-4 py-3 cursor-pointer transition-colors ${isExpanded ? '' : 'hover:bg-gray-50 dark:hover:bg-white/[0.03] rounded-lg'}`}
                onClick={() => onExpand(item.questionId)}
            >
                {/* Title + Preview */}
                <div className="flex-1 min-w-0">
                    <div className="flex items-center gap-2">
                        <span className="font-bold text-sm text-text-main dark:text-white whitespace-nowrap">{q.title || `§${q.sub_topic_id}`}</span>
                        <span className={`text-[9px] font-bold uppercase tracking-wider px-1.5 py-0.5 rounded ${diffLabel.color}`}>{diffLabel.text}</span>
                        <span className="text-[10px] font-semibold text-red-500">× {item.wrongCount}</span>
                    </div>
                    <div className="text-[12px] text-gray-400 mt-0.5 truncate max-w-md">
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
                                return text.slice(0, 80) + (text.length > 80 ? '...' : '');
                            } catch {
                                return 'View question...';
                            }
                        })()}
                    </div>
                </div>

                {/* Date + Actions */}
                <div className="flex items-center gap-2 shrink-0">
                    <span className="text-[10px] text-gray-400 hidden sm:block whitespace-nowrap">
                        {new Date(item.lastWrongAt).toLocaleDateString('en-US', { month: 'short', day: 'numeric' })}
                    </span>
                    <button
                        onClick={(e) => { e.stopPropagation(); onDismiss(item.questionId); }}
                        className="w-7 h-7 rounded-full flex items-center justify-center text-gray-300 hover:text-red-500 hover:bg-red-50 dark:hover:bg-red-900/20 transition-all"
                        title="Remove"
                    >
                        <span className="material-symbols-outlined text-[16px]">delete</span>
                    </button>
                    <div className={`w-7 h-7 rounded-full flex items-center justify-center transition-transform duration-200 ${isExpanded ? 'rotate-180 text-primary' : 'text-gray-400'}`}>
                        <span className="material-symbols-outlined text-[18px]">expand_more</span>
                    </div>
                </div>
            </div>

            {/* Expanded Detail */}
            {isExpanded && (
                <div className="px-4 pb-4 animate-fade-in">
                    {/* Prompt */}
                    <div className="mb-3 text-sm text-text-main dark:text-gray-200 leading-relaxed border-t border-gray-100 dark:border-white/5 pt-3">
                        <MathRenderer content={q.prompt || ''} />
                    </div>

                    {/* Your Answer / Correct Answer */}
                    <div className="grid grid-cols-1 sm:grid-cols-2 gap-2 mb-3">
                        <div className="rounded-lg border border-red-200 dark:border-red-800/40 bg-red-50/50 dark:bg-red-900/10 p-3">
                            <div className="flex items-center gap-1.5 mb-1">
                                <span className="material-symbols-outlined text-red-500 text-[14px]">close</span>
                                <span className="text-[10px] font-bold uppercase tracking-wider text-red-500">Your Answer</span>
                            </div>
                            <div className="text-sm text-text-main dark:text-gray-300">
                                {userWrongOption ? (
                                    <MathRenderer content={userWrongOption.value || userWrongOption.text || ''} />
                                ) : (
                                    <span className="text-gray-400 italic text-xs">No answer recorded</span>
                                )}
                            </div>
                        </div>
                        <div className="rounded-lg border border-green-200 dark:border-green-800/40 bg-green-50/50 dark:bg-green-900/10 p-3">
                            <div className="flex items-center gap-1.5 mb-1">
                                <span className="material-symbols-outlined text-green-600 text-[14px]">check</span>
                                <span className="text-[10px] font-bold uppercase tracking-wider text-green-600">
                                    Correct {correctOption?.label ? `(${correctOption.label})` : ''}
                                </span>
                            </div>
                            <div className="text-sm text-text-main dark:text-gray-300 font-medium">
                                {correctOption ? (
                                    <MathRenderer content={correctOption.value || correctOption.text || ''} />
                                ) : <span className="text-gray-400 italic">—</span>}
                            </div>
                        </div>
                    </div>

                    {/* Explanation */}
                    {q.explanation && (
                        <div className="rounded-lg border border-gray-100 dark:border-white/5 bg-gray-50/50 dark:bg-white/[0.02] p-3 mb-3">
                            <div className="text-[10px] font-bold uppercase tracking-wider text-gray-400 mb-1.5">Explanation</div>
                            <div className="text-sm text-text-main dark:text-gray-300 leading-relaxed">
                                <MathRenderer content={q.explanation} />
                            </div>
                        </div>
                    )}

                    {/* Footer */}
                    <div className="flex items-center justify-between pt-2 border-t border-gray-100 dark:border-white/5">
                        <span className="text-[10px] text-gray-400 font-bold uppercase tracking-wider">
                            Wrong {item.wrongCount}× · Since {new Date(item.firstWrongAt).toLocaleDateString('en-US', { month: 'short', day: 'numeric' })}
                        </span>
                        <button
                            onClick={(e) => { e.stopPropagation(); onDismiss(item.questionId); }}
                            className="flex items-center gap-1 px-3 py-1.5 rounded-lg bg-green-50 hover:bg-green-100 dark:bg-green-900/20 dark:hover:bg-green-900/40 text-green-700 dark:text-green-400 text-xs font-bold transition-all"
                        >
                            <span className="material-symbols-outlined text-[13px]">check_circle</span>
                            Mastered
                        </button>
                    </div>
                </div>
            )}
        </div>
    );
};


// ═══════════════════════════════════════════
// Unit Block — groups items by topic
// ═══════════════════════════════════════════
const UnitBlock = ({ topicKey, items, expandedId, onExpand, onDismiss }: {
    topicKey: string;
    items: WrongAnswerItem[];
    expandedId: string | null;
    onExpand: (id: string) => void;
    onDismiss: (id: string) => void;
}) => {
    const [isCollapsed, setIsCollapsed] = useState(false);
    const icon = getTopicIcon(topicKey);
    const label = getUnitLabel(topicKey);

    return (
        <div className="bg-white dark:bg-[#1a1a24] rounded-2xl border border-gray-100 dark:border-gray-800 overflow-hidden shadow-sm">
            {/* Block Header */}
            <div
                className="flex items-center gap-3 px-5 py-4 cursor-pointer hover:bg-gray-50 dark:hover:bg-white/[0.03] transition-colors select-none"
                onClick={() => setIsCollapsed(!isCollapsed)}
            >
                <div className="w-9 h-9 rounded-xl bg-primary/10 text-primary flex items-center justify-center shrink-0">
                    <span className="material-symbols-outlined text-[20px]">{icon}</span>
                </div>
                <div className="flex-1 min-w-0">
                    <h3 className="font-bold text-[15px] text-text-main dark:text-white truncate">{label}</h3>
                </div>
                <span className="text-xs font-black text-red-500 bg-red-50 dark:bg-red-900/20 px-2.5 py-1 rounded-full shrink-0">
                    {items.length}
                </span>
                <div className={`w-7 h-7 rounded-full flex items-center justify-center text-gray-400 transition-transform duration-200 ${isCollapsed ? '' : 'rotate-180'}`}>
                    <span className="material-symbols-outlined text-[18px]">expand_more</span>
                </div>
            </div>

            {/* Items */}
            {!isCollapsed && (
                <div className="border-t border-gray-100 dark:border-white/5">
                    {items.map(item => (
                        <WrongAnswerRow
                            key={item.questionId}
                            item={item}
                            onDismiss={onDismiss}
                            onExpand={onExpand}
                            isExpanded={expandedId === item.questionId}
                        />
                    ))}
                </div>
            )}
        </div>
    );
};


export const WrongAnswerBook = () => {
    const { user, wrongAnswersCache, fetchWrongAnswersCache } = useApp();
    const navigate = useNavigate();

    const wrongAnswers = wrongAnswersCache.items;
    const [isLoading, setIsLoading] = useState(!wrongAnswers || wrongAnswers.length === 0);
    const [error, setError] = useState<string | null>(null);
    const [expandedId, setExpandedId] = useState<string | null>(null);

    // Filters
    const [filterTopic, setFilterTopic] = useState<string>('all');
    const [filterDifficulty, setFilterDifficulty] = useState<number>(0);
    const [sortBy] = useState<'recent' | 'count' | 'difficulty'>('recent');
    const [confirmDismissId, setConfirmDismissId] = useState<string | null>(null);
    const [stats, setStats] = useState({ total: 0, todayNew: 0, thisWeekNew: 0 });
    const [isUnitDropdownOpen, setIsUnitDropdownOpen] = useState(false);
    const unitDropdownRef = useRef<HTMLDivElement>(null);

    const [dismissedMap, setDismissedMap] = useState<Record<string, string>>(() => {
        try {
            const saved = localStorage.getItem(`wrong_answer_dismissed_map_${user?.id}`);
            return saved ? JSON.parse(saved) : {};
        } catch { return {}; }
    });

    const fetchAndSync = useCallback(async () => {
        if (wrongAnswersCache.items.length > 0) {
            setIsLoading(false);
        }
        try {
            await fetchWrongAnswersCache();
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
            console.error('Failed to sync wrong answers:', err);
            if (wrongAnswersCache.items.length === 0) {
                setError(err.message || 'Failed to load');
            }
        } finally {
            setIsLoading(false);
        }
    }, [user?.id, dismissedMap, fetchWrongAnswersCache, wrongAnswersCache.items.length]);

    useEffect(() => {
        fetchAndSync();
    }, [fetchAndSync]);

    // Close unit dropdown on outside click
    useEffect(() => {
        const handler = (e: MouseEvent) => {
            if (unitDropdownRef.current && !unitDropdownRef.current.contains(e.target as Node)) setIsUnitDropdownOpen(false);
        };
        document.addEventListener('mousedown', handler);
        return () => document.removeEventListener('mousedown', handler);
    }, []);

    // Update stats when cache changes
    useEffect(() => {
        if (wrongAnswers.length > 0) {
            const now = Date.now();
            const todayStart = new Date().setHours(0, 0, 0, 0);
            const weekStart = now - 7 * 24 * 60 * 60 * 1000;
            setStats({
                total: wrongAnswers.length,
                todayNew: wrongAnswers.filter(w => new Date(w.lastWrongAt).getTime() > todayStart).length,
                thisWeekNew: wrongAnswers.filter(w => new Date(w.lastWrongAt).getTime() > weekStart).length
            });
        }
    }, [wrongAnswers]);

    const handleDismiss = async (questionId: string) => {
        const newDismissedMap = { ...dismissedMap, [questionId]: new Date().toISOString() };
        setDismissedMap(newDismissedMap);
        localStorage.setItem(`wrong_answer_dismissed_map_${user?.id}`, JSON.stringify(newDismissedMap));

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

        setStats(prev => ({ ...prev, total: prev.total - 1 }));
        setConfirmDismissId(null);
        setExpandedId(null);
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
        switch (sortBy) {
            case 'count': result.sort((a, b) => b.wrongCount - a.wrongCount); break;
            case 'difficulty': result.sort((a, b) => (b.question?.difficulty || 0) - (a.question?.difficulty || 0)); break;
            default: result.sort((a, b) => new Date(b.lastWrongAt).getTime() - new Date(a.lastWrongAt).getTime());
        }
        return result;
    }, [wrongAnswers, filterTopic, filterDifficulty, sortBy]);

    // Group by topic (Unit)
    const groupedByUnit = useMemo(() => {
        const groups: Record<string, WrongAnswerItem[]> = {};
        filteredAnswers.forEach(item => {
            const raw = item.question?.topic || 'Unknown';
            const clean = raw.includes('_') ? raw.split('_').slice(1).join('_') : raw;
            if (!groups[clean]) groups[clean] = [];
            groups[clean].push(item);
        });
        // Sort groups by unit order
        return Object.entries(groups)
            .sort(([a], [b]) => (UNIT_ORDER[a] || 99) - (UNIT_ORDER[b] || 99));
    }, [filteredAnswers]);

    const availableTopics = useMemo(() => {
        const topicSet = new Set<string>();
        wrongAnswers.forEach(w => {
            const clean = w.question?.topic?.includes('_') ? w.question.topic.split('_').slice(1).join('_') : w.question?.topic;
            if (clean) topicSet.add(clean);
        });
        return Array.from(topicSet).sort((a, b) => (UNIT_ORDER[a] || 99) - (UNIT_ORDER[b] || 99));
    }, [wrongAnswers]);

    // Simple inline filter pills instead of custom dropdowns (化繁为简)
    const difficultyOptions = [
        { value: 0, label: 'All' },
        { value: 1, label: 'Easy' }, { value: 2, label: 'Med' },
        { value: 3, label: 'Hard' }, { value: 4, label: 'Expert' }
    ];

    return (
        <div className="h-full w-full flex flex-col bg-background-light dark:bg-background-dark text-text-main dark:text-gray-100 overflow-hidden">
            <Navbar />

            <main className="flex-grow w-full max-w-4xl mx-auto px-4 sm:px-6 py-6 flex flex-col gap-4 overflow-y-auto scroll-bounce">

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

                {/* Filters — compact row */}
                <div className="flex items-center gap-2 flex-wrap">

                    {/* Unit Filter — Custom Dropdown */}
                    <div ref={unitDropdownRef} className="relative">
                        <button
                            onClick={() => setIsUnitDropdownOpen(!isUnitDropdownOpen)}
                            className={`flex items-center gap-2 px-3.5 py-2 rounded-xl text-sm font-bold transition-all border ${isUnitDropdownOpen
                                ? 'border-primary bg-primary/5 text-text-main dark:text-white shadow-sm'
                                : 'border-gray-200 dark:border-gray-700 bg-white dark:bg-white/5 text-text-main dark:text-gray-300 hover:border-gray-300 dark:hover:border-gray-600'
                                }`}
                        >
                            <span className="material-symbols-outlined text-[16px] text-primary shrink-0">filter_list</span>
                            <span className="truncate max-w-[160px]">{filterTopic === 'all' ? 'All Units' : getUnitLabel(filterTopic)}</span>
                            <span className={`material-symbols-outlined text-[16px] shrink-0 transition-transform ${isUnitDropdownOpen ? 'rotate-180' : ''}`}>expand_more</span>
                        </button>
                        {isUnitDropdownOpen && (
                            <div className="absolute top-full left-0 mt-1.5 w-[260px] bg-white dark:bg-[#1e1e2a] border border-gray-200 dark:border-gray-700 rounded-xl shadow-xl z-50 py-1 max-h-[320px] overflow-y-auto animate-fade-in">
                                <button
                                    onClick={() => { setFilterTopic('all'); setIsUnitDropdownOpen(false); }}
                                    className={`w-full text-left px-4 py-2.5 text-sm transition-colors ${filterTopic === 'all'
                                        ? 'bg-primary/10 text-primary font-bold'
                                        : 'text-text-main dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-white/5 font-medium'
                                        }`}
                                >
                                    All Units
                                </button>
                                {availableTopics.map(t => (
                                    <button
                                        key={t}
                                        onClick={() => { setFilterTopic(t); setIsUnitDropdownOpen(false); }}
                                        className={`w-full text-left px-4 py-2.5 text-sm transition-colors ${filterTopic === t
                                            ? 'bg-primary/10 text-primary font-bold'
                                            : 'text-text-main dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-white/5 font-medium'
                                            }`}
                                    >
                                        {getUnitLabel(t)}
                                    </button>
                                ))}
                            </div>
                        )}
                    </div>

                    {/* Difficulty pills */}
                    <div className="flex items-center gap-1">
                        {difficultyOptions.map(d => (
                            <button
                                key={d.value}
                                onClick={() => setFilterDifficulty(d.value)}
                                className={`px-2.5 py-1.5 rounded-lg text-[11px] font-bold transition-all ${filterDifficulty === d.value
                                    ? 'bg-primary text-black shadow-sm'
                                    : 'bg-gray-100 dark:bg-white/5 text-gray-500 hover:bg-gray-200 dark:hover:bg-white/10'
                                    }`}
                            >
                                {d.label}
                            </button>
                        ))}
                    </div>
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

                {/* Grouped Blocks */}
                {!isLoading && !error && groupedByUnit.length > 0 && (
                    <div className="flex flex-col gap-4 pb-6">
                        <div className="text-[11px] font-bold uppercase tracking-wider text-gray-400">
                            {filteredAnswers.length} questions across {groupedByUnit.length} unit{groupedByUnit.length > 1 ? 's' : ''}
                        </div>
                        {groupedByUnit.map(([topicKey, items]) => (
                            <UnitBlock
                                key={topicKey}
                                topicKey={topicKey}
                                items={items}
                                expandedId={expandedId}
                                onExpand={(id) => setExpandedId(expandedId === id ? null : id)}
                                onDismiss={(id) => setConfirmDismissId(id)}
                            />
                        ))}
                    </div>
                )}
            </main>

            <ConfirmModal
                isOpen={!!confirmDismissId}
                title="Remove from Error Notebook?"
                message="Are you sure you've mastered this question? This will remove it from your error notebook."
                confirmText="Yes, Mastered"
                cancelText="Keep"
                onConfirm={() => confirmDismissId && handleDismiss(confirmDismissId)}
                onCancel={() => setConfirmDismissId(null)}
            />
        </div>
    );
};
