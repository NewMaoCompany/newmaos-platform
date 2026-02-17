import React, { createContext, useContext, useState, useEffect, ReactNode, useMemo, useCallback } from 'react';
import { User, CourseType, Activity, TopicMastery, Title, CourseState, Recommendation, SessionMode, Question, AppNotification, UnitContent, SubTopic, UserInsights, SubmitAttemptParams, SubmitAttemptResult, ReviewQueueItem, SubTopicProgress, UserSectionProgress, UserPrestige } from './types';
import { INITIAL_USER, INITIAL_ACTIVITIES, INITIAL_RADAR_DATA, INITIAL_LINE_DATA, INITIAL_COURSES, PRACTICE_QUESTIONS, INITIAL_NOTIFICATIONS, COURSE_CONTENT_DATA } from './constants';
import { supabase } from './src/services/supabaseClient';
import { notificationsApi, contentApi, questionsApi, sectionsApi } from './src/services/api';

interface AppContextType {
    user: User;
    isAuthenticated: boolean;
    isAuthLoading: boolean;
    activities: Activity[];
    radarData: TopicMastery[];
    lineData: { day: string; value: number }[];
    accuracyHistory: { date: string; accuracy: number; totalAttempts: number }[];
    courses: Record<CourseType, CourseState>;
    recommendation: Recommendation;
    hasDismissedLoginPrompt: boolean;
    questions: Question[]; // Dynamic Question Bank
    notifications: AppNotification[]; // Global Notifications
    isCreatorAuthenticated: boolean; // Creator Access State
    topicContent: Record<string, UnitContent>; // Dynamic Content Data
    skills: { id: string; name: string; unit: string; prerequisites: string[] }[]; // Skills for Question Editor
    sections: Record<string, any[]>; // Sections by topic_id for Chapter Settings
    userInsights: UserInsights | null; // Agent Insight data
    reviewQueue: ReviewQueueItem[]; // Spaced repetition queue
    newlyUnlockedTitle: Title | null; // For achievement celebration
    setNewlyUnlockedTitle: (title: Title | null) => void;
    availableTitles: Title[];
    isPro: boolean;
    showPaywall: boolean;
    setShowPaywall: (show: boolean) => void;

    // Points Economy
    userPoints: { balance: number; lifetimeEarned: number };
    pointsBalanceRef: React.RefObject<HTMLElement>;
    awardPoints: (amount: number, type: string, sourceId?: string, description?: string, idempotencyKey?: string, x?: number, y?: number) => Promise<{ success: boolean; newBalance?: number }>;
    triggerCoinAnimation: (amount: number, x?: number, y?: number, mode?: 'earn' | 'spend') => void;
    redeemProWithPoints: () => Promise<{ success: boolean; reason?: string; newBalance?: number; shortfall?: number }>;
    performDailyCheckin: () => Promise<{ success: boolean; streakDay?: number; basePoints?: number; bonusPoints?: number; totalPoints?: number; isMilestone?: boolean; reason?: string }>;
    recordLoginStreak: () => Promise<{ success: boolean; streak?: number; points?: number; reason?: string }>;
    getCheckinStatus: () => Promise<{ checkedInToday: boolean; currentStreak: number; monthCheckins: number; monthCalendar: any[] }>;
    fetchUserPoints: () => Promise<void>;

    login: (email: string, username?: string, id?: string, subscriptionTier?: 'basic' | 'pro', subscriptionPeriodEnd?: string, hasSeenProIntro?: boolean) => void;
    logout: () => Promise<void>;
    toggleCourse: (course: CourseType) => void;
    startCourse: (course: CourseType) => void;
    updateUser: (updates: Partial<User>) => void;
    claimFreePro: () => Promise<boolean>;
    recentPointsTransaction: { amount: number; description: string } | null;
    markProIntroSeen: () => Promise<void>;
    completePractice: (results: { correct: number; total: number; topic: string }) => void;
    setSessionMode: (mode: SessionMode) => void;
    dismissLoginPrompt: () => void;

    // Creator Area Methods
    addQuestion: (q: Partial<Question> & { options: any[] }) => Promise<boolean>;
    updateQuestion: (q: Question) => Promise<boolean>;
    deleteQuestion: (id: string) => void;
    updateTopic: (unitId: string, subTopicId: string | null, data: any) => void;
    updateSection: (topicId: string, sectionId: string, data: any) => Promise<void>;
    verifyAccessCode: (code: string) => Promise<{ success: boolean; message?: string }>;

    // Notification Methods
    markAllNotificationsRead: () => void;
    markNotificationRead: (id: number) => void;

    // Helper for Dashboard
    getCourseMastery: (course: CourseType) => number;
    getSectionsForTopic: (topicId: string) => any[];
    fetchSections: () => Promise<void>;
    fetchQuestions: () => Promise<void>;

    // Agent Insight Methods
    submitAttempt: (params: SubmitAttemptParams) => Promise<SubmitAttemptResult>;
    getUserInsights: () => Promise<UserInsights | null>;
    getReviewQueue: (limit?: number) => Promise<ReviewQueueItem[]>;
    toggleQuestionStarred: (questionId: string) => Promise<boolean>;
    toggleQuestionFlagged: (questionId: string) => Promise<boolean>;
    getTopicProgress: (topicId: string) => Promise<Record<string, SubTopicProgress>>;
    fetchAllUserProgress: () => Promise<void>;

    // Session Persistence Methods
    // Session Persistence Methods
    saveSectionProgress: (sectionId: string, data: any, stats?: { completed: number; total: number; score: number }, entityType?: 'course' | 'unit' | 'section', skipStatusUpdate?: boolean) => Promise<boolean>;
    completeSectionSession: (sectionId: string, score: number, totalQuestions: number, correctQuestions: number, data: any, entityType?: 'course' | 'unit' | 'section', skipStatusUpdate?: boolean) => Promise<boolean>;
    getUnitProgress: (unitId: string) => Promise<any>;
    getCourseProgress: (courseScope: string) => Promise<any>;
    getSectionProgress: (sectionId: string) => Promise<UserSectionProgress | null>;
    getTopicSectionProgress: (topicId: string) => Promise<UserSectionProgress[]>;
    // New synchronous access to cached progress
    sectionProgressMap: Record<string, UserSectionProgress>;
    getSectionStatus: (sectionId: string) => 'not_started' | 'in_progress' | 'completed';
    getSectionProgressData: (sectionId: string) => UserSectionProgress | undefined;
    resetSectionProgress: (sectionId: string) => Promise<boolean>;
    sectionTimes: Record<string, number>;
    incorrectQuestionIds: Set<string>;
    fetchIncorrectQuestions: () => Promise<void>;
    diagSupabase: () => Promise<void>;

    // New Activity Tracking
    logUserActivity: (params: { sectionId: string; attemptType: 'first_attempt' | 'review'; score: number; correctCount: number; totalQuestions: number; data: any }) => Promise<string | null>;
    getUserActivities: (sectionId: string) => Promise<any[]>;
    fetchAccuracyHistory: (range: '1W' | '1M' | '1Y' | 'ALL') => Promise<void>;
    friendIds: Set<string>;
    fetchFriends: () => Promise<void>;
    unreadCounts: Record<string, number>;
    clearUnread: (id: string) => void;
    checkinStatus: 'checked_in' | 'not_checked_in' | 'loading';
    refreshCheckinStatus: () => Promise<void>;

    // Pro Upgrade Red Dot
    proUpgradeDismissed: boolean;
    dismissProUpgrade: () => void;

    // Modal Orchestration
    isStreakModalOpen: boolean;
    setIsStreakModalOpen: (isOpen: boolean) => void;

    // Prestige System
    userPrestige: UserPrestige | null;
    fetchUserPrestige: () => Promise<void>;
    purchaseStardust: (amountCoins: number) => Promise<{ success: boolean; message?: string }>;
    injectStardust: (amount: number) => Promise<{ success: boolean; message?: string }>;
}

const AppContext = createContext<AppContextType | undefined>(undefined);

// Helper for simulating Backend ID generation
const generateUUID = () => {
    return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function (c) {
        var r = Math.random() * 16 | 0, v = c == 'x' ? r : (r & 0x3 | 0x8);
        return v.toString(16);
    });
};

export const AppProvider = ({ children }: React.PropsWithChildren) => {
    const [user, setUser] = useState<User>(() => {
        // Safe check for window
        if (typeof window !== 'undefined') {
            const savedCourse = localStorage.getItem('user_course_mode');
            const cachedUser = localStorage.getItem('user_profile_cache');

            let baseUser = { ...INITIAL_USER };
            if (cachedUser) {
                try {
                    baseUser = { ...baseUser, ...JSON.parse(cachedUser) };
                } catch (e) { console.error('Error parsing user cache', e); }
            }

            return {
                ...baseUser,
                currentCourse: (savedCourse === 'AB' || savedCourse === 'BC') ? (savedCourse as CourseType) : baseUser.currentCourse
            };
        }
        return INITIAL_USER;
    });
    const [isAuthenticated, setIsAuthenticated] = useState(() => {
        if (typeof window !== 'undefined') {
            return localStorage.getItem('user_profile_cache') !== null;
        }
        return false;
    }); // Optimistic auth from cache
    const [isAuthLoading, setIsAuthLoading] = useState(true);
    // Initialize from localStorage so the prompt state persists across page refreshes
    // Use sessionStorage so popup appears once per browser session (closing tab resets it)
    const [availableTitles, setAvailableTitles] = useState<Title[]>([]);
    const [hasDismissedLoginPrompt, setHasDismissedLoginPrompt] = useState(() => {
        if (typeof window !== 'undefined') {
            return sessionStorage.getItem('hasDismissedLoginPrompt') === 'true';
        }
        return false;
    });
    const [isCreatorAuthenticated, setIsCreatorAuthenticated] = useState(false);

    // Dynamic Data States
    const [activities, setActivities] = useState<Activity[]>(INITIAL_ACTIVITIES);
    const [radarData, setRadarData] = useState<TopicMastery[]>(INITIAL_RADAR_DATA);
    const [incorrectQuestionIds, setIncorrectQuestionIds] = useState<Set<string>>(new Set());
    const [lineData, setLineData] = useState(INITIAL_LINE_DATA);
    const [accuracyHistory, setAccuracyHistory] = useState<{ date: string; accuracy: number; totalAttempts: number }[]>([]);
    const [courses, setCourses] = useState(INITIAL_COURSES);

    // Lifted Question State
    const [questions, setQuestions] = useState<Question[]>(PRACTICE_QUESTIONS);

    // Lifted Topic Content State
    const [topicContent, setTopicContent] = useState<Record<string, UnitContent>>(COURSE_CONTENT_DATA);

    // Lifted Notification State
    const [notifications, setNotifications] = useState<AppNotification[]>(INITIAL_NOTIFICATIONS);

    // Skills data for Question Editor
    const [skills, setSkills] = useState<{ id: string; name: string; unit: string; prerequisites: string[] }[]>([]);

    // Sections data from database (keyed by topic_id)
    const [sections, setSections] = useState<Record<string, any[]>>({});
    const [friendIds, setFriendIds] = useState<Set<string>>(new Set());

    // Cache for section progress to prevent UI lag
    const [sectionProgressMap, setSectionProgressMap] = useState<Record<string, UserSectionProgress>>({});

    const [userInsights, setUserInsights] = useState<UserInsights | null>(null);
    const [reviewQueue, setReviewQueue] = useState<ReviewQueueItem[]>([]);
    const [newlyUnlockedTitle, setNewlyUnlockedTitle] = useState<Title | null>(null);
    const [showPaywall, setShowPaywall] = useState(false);

    // Points Economy State
    const [userPoints, setUserPoints] = useState<{ balance: number; lifetimeEarned: number }>({ balance: 0, lifetimeEarned: 0 });
    const pointsBalanceRef = React.useRef<HTMLElement>(null);
    const [userPrestige, setUserPrestige] = useState<UserPrestige | null>(null);

    const [recentPointsTransaction, setRecentPointsTransaction] = useState<{ amount: number; description: string } | null>(null);
    const [checkinStatus, setCheckinStatus] = useState<'checked_in' | 'not_checked_in' | 'loading'>('loading');
    const [isStreakModalOpen, setIsStreakModalOpen] = useState(false);

    const [unreadCounts, setUnreadCounts] = useState<Record<string, number>>(() => {
        if (typeof window !== 'undefined') {
            const saved = localStorage.getItem('global_unread_counts');
            return saved ? JSON.parse(saved) : {};
        }
        return {};
    });

    const clearUnread = async (id: string) => {
        // 1. Update local state
        setUnreadCounts(prev => {
            if (!prev[id]) return prev;
            const next = { ...prev };
            delete next[id];
            localStorage.setItem('global_unread_counts', JSON.stringify(next));
            return next;
        });

        // 2. Clear from database if user is authenticated
        if (user?.id) {
            try {
                // Determine if ID is for a channel or chat
                // In our current system, we store chat_id or channel_id in the notifications table
                await supabase
                    .from('notifications')
                    .update({ unread: false })
                    .match({ user_id: user.id, unread: true })
                    .or(`chat_id.eq.${id},channel_id.eq.${id}`);

                // Refresh counts from backend if possible
                const { data } = await supabase
                    .from('notifications')
                    .select('id', { count: 'exact' })
                    .eq('user_id', user.id)
                    .eq('unread', true);
            } catch (err) {
                console.error('Failed to clear notifications in DB:', err);
            }
        }
    };

    // Global Message Subscriptions for Unread Badges
    useEffect(() => {
        if (!user?.id || !isAuthenticated) return;

        const handleNewMsg = (payload: any, type: 'channel' | 'dm') => {
            const newMsg = payload.new;
            const targetId = type === 'channel' ? newMsg.channel_id : newMsg.chat_id;

            // We don't know the "active" chat here easily without passing it up, 
            // but we can increment it always and Forum.tsx will clear it.
            // Or better: The Forum component already manages active IDs. 
            // Let's just increment if it's not from us.
            if (newMsg.user_id !== user.id) {
                setUnreadCounts(prev => {
                    const next = {
                        ...prev,
                        [targetId]: (prev[targetId] || 0) + 1
                    };
                    localStorage.setItem('global_unread_counts', JSON.stringify(next));
                    return next;
                });
            }
        };

        const channel = supabase.channel('global-chat-notifications')
            .on('postgres_changes', { event: 'INSERT', schema: 'public', table: 'forum_messages' }, (payload) => handleNewMsg(payload, 'channel'))
            .on('postgres_changes', { event: 'INSERT', schema: 'public', table: 'direct_messages' }, (payload) => handleNewMsg(payload, 'dm'))
            .subscribe();

        return () => {
            supabase.removeChannel(channel);
        };
    }, [user?.id, isAuthenticated]);

    // Handle Daily Login Streak (Run once per session/user load)
    useEffect(() => {
        if (!user?.id) return;

        const checkLoginStreak = async () => {
            try {
                // Determine timezone
                const tz = Intl.DateTimeFormat().resolvedOptions().timeZone;
                const { data, error } = await supabase.rpc('handle_daily_login', {
                    user_uuid: user.id,
                    p_timezone: tz
                });

                if (error) throw error;
                if (data) {
                    console.log('🔥 Daily Login processed:', data);
                }
            } catch (error) {
                console.error('Failed to process daily login:', error);
            }
        };

        checkLoginStreak();
    }, [user?.id]);

    // Algorithmic Recommendation State - Initial State for New User
    const [recommendation, setRecommendation] = useState<Recommendation>({
        topic: 'Limits',
        reason: 'Start your AP Calculus journey with the fundamentals.',
        currentMastery: 0,
        targetMastery: 80,
        mode: 'Adaptive'
    });

    // Fetch all sections from database and merge into topicContent for Practice display
    const fetchSections = async () => {
        try {
            console.log('🔄 Fetching sections...');
            const data = await sectionsApi.getSections();

            // Group by topic_id
            const grouped: Record<string, any[]> = {};
            data.forEach((section: any) => {
                // Standardize topic_id: Map legacy ABBC_ to Both_ to match frontend constants
                let topicKey = section.topic_id;
                let originalKey = section.topic_id; // TRACK ORIGINAL

                if (topicKey.startsWith('ABBC_')) {
                    topicKey = 'Both_' + topicKey.substring(5);
                } else if (topicKey.startsWith('AB_') || topicKey.startsWith('BC_')) {
                    // Optional: Handle other legacy formats if needed, but ABBC is the main culprit
                    // Ensure we don't break strict AB/BC units, but normally shared is Both
                    // For now, only fix ABBC -> Both as that is the confirmed mismatch
                }

                if (!grouped[topicKey]) {
                    grouped[topicKey] = [];
                }
                grouped[topicKey].push(section);

                // Debug log for one specific mapping to see if it works
                if (originalKey.includes('ABBC_Limits')) {
                    console.log(`[AppContext] Mapped ${originalKey} -> ${topicKey}`);
                }
            });
            console.log(`[AppContext] Grouped sections keys:`, Object.keys(grouped));
            setSections(grouped);

            // Also update topicContent with sections data for Practice display
            setTopicContent(prev => {
                const updated = { ...prev };

                Object.keys(grouped).forEach(topicId => {
                    if (!updated[topicId]) return;

                    const topicSections = grouped[topicId];

                    // Find unit_test section and update unitTest config
                    const unitTestSection = topicSections.find(s => s.id === 'unit_test');
                    if (unitTestSection) {
                        updated[topicId] = {
                            ...updated[topicId],
                            unitTest: {
                                title: unitTestSection.title || 'Unit Test',
                                description: unitTestSection.description || '',
                                estimatedMinutes: unitTestSection.estimated_minutes || 45
                            }
                        };
                    }

                    // Find overview section (Unit Settings) and update topic config
                    const overviewSection = topicSections.find(s => s.id === 'overview');
                    if (overviewSection) {
                        updated[topicId] = {
                            ...updated[topicId],
                            title: overviewSection.title,
                            description: overviewSection.description
                        };
                    }

                    // Update subTopics with section data (excluding unit_test)
                    const subSections = topicSections.filter(s => s.id !== 'unit_test');

                    // CRITICAL FIX: If subTopics is empty in state, use static data as the base
                    // This prevents optimistic overwrite of subTopics if the DB doesn't return all of them
                    const baseSubTopics = (updated[topicId].subTopics && updated[topicId].subTopics.length > 0)
                        ? updated[topicId].subTopics
                        : COURSE_CONTENT_DATA[topicId]?.subTopics || [];

                    if (subSections.length > 0 && baseSubTopics.length > 0) {
                        updated[topicId] = {
                            ...updated[topicId],
                            subTopics: baseSubTopics.map((sub: any) => {
                                // Relaxed find: Check for string vs number ID mismatch
                                const dbSection = subSections.find(s => String(s.id) === String(sub.id));
                                if (dbSection) {

                                    return {
                                        ...sub,
                                        title: dbSection.title ?? sub.title,
                                        description: dbSection.description ?? sub.description,
                                        // Mapped to description_2
                                        description_2: dbSection.description_2 || dbSection.chapter_detailed_description || dbSection.description2 || dbSection.detailed_description || sub.description_2 || null,
                                        courseScope: dbSection.course_scope || sub.courseScope,
                                        estimatedMinutes: dbSection.estimated_minutes || sub.estimatedMinutes,
                                        hasLesson: dbSection.has_lesson !== false,
                                        hasPractice: dbSection.has_practice !== false
                                    };
                                }
                                return sub;
                            })
                        };
                    }
                });

                // Debug verification key check
                const sampleKey = Object.keys(grouped)[0];
                if (sampleKey && updated[sampleKey]) {
                    console.log(`DEBUG: Merged content for ${sampleKey}. Subtopics count: ${updated[sampleKey].subTopics?.length}`);
                }

                return updated;
            });

            console.log(`✅ Loaded ${data.length} sections`);



            console.log('✅ Updated topicContent with DB sections');
        } catch (error: any) {
            console.error('❌ Failed to fetch sections from backend:', error);
            // Provide visual feedback if we're in development
            if (window.location.hostname === 'localhost') {
                console.warn('⚠️ LOCALHOST SYNC ERROR: Ensure backend is running on port 4005');
            }
        }
    };

    // Calculate Unit Mastery for Radar Chart
    const fetchRadarData = async () => {
        if (!user || !user.id) return;

        // Definition of Units for Radar Axis (AB & BC)
        const UNIT_MAPPING: { id: string; label: string }[] = [
            { id: 'Both_Limits', label: 'Unit 1' },
            { id: 'Both_Derivatives', label: 'Unit 2' },
            { id: 'Both_Composite', label: 'Unit 3' },
            { id: 'Both_Applications', label: 'Unit 4' },
            { id: 'Both_Analytical', label: 'Unit 5' },
            { id: 'Both_Integration', label: 'Unit 6' },
            { id: 'Both_DiffEq', label: 'Unit 7' },
            { id: 'Both_AppIntegration', label: 'Unit 8' },
            { id: 'BC_Unit9', label: 'Unit 9' },
            { id: 'BC_Series', label: 'Unit 10' }
        ];

        try {
            const unitIds = UNIT_MAPPING.map(u => u.id);
            const { data, error } = await supabase.rpc('get_unit_scores', {
                p_unit_ids: unitIds
            });

            if (error) throw error;

            const scoresMap: Record<string, number> = {};
            if (data) {
                data.forEach((row: any) => {
                    // Use the database-calculated mastery score (which already handles 85% threshold and 50/50 split)
                    scoresMap[row.unit_id] = Number(row.score) || 0;
                });
            }

            const newRadarData = UNIT_MAPPING.map(u => ({
                subject: u.label,
                A: Math.round(scoresMap[u.id] || 0), // Use calculated mastery or 0
                fullMark: 100
            }));

            setRadarData(newRadarData);

            // Sync recommendation with current mastery if topic matches
            setRecommendation(prev => {
                const cleanRecTopic = prev.topic.includes('_') ? prev.topic.split('_')[1] : prev.topic;
                const matchingUnit = UNIT_MAPPING.find(u => u.id.includes(cleanRecTopic) || u.label.includes(cleanRecTopic));
                if (matchingUnit) {
                    const latestScore = Math.round(scoresMap[matchingUnit.id] || 0);
                    return { ...prev, currentMastery: latestScore };
                }
                return prev;
            });
        } catch (error) {
            console.error('fetchRadarData error:', error);
        }
    };

    // Calculate Performance Trend (Daily Mastery Index)
    const fetchLineData = async () => {
        if (!user || !user.id) return;

        try {
            // We want last 7 days including today
            const days = [];
            for (let i = 6; i >= 0; i--) {
                const d = new Date();
                d.setDate(d.getDate() - i);
                days.push(d);
            }

            // Fetch stats for each day (inefficient but simple for now, or use a better RPC if available)
            // For "Daily Mastery Index", we can use adherence or score. 
            // Let's use `get_daily_user_stats` for Today, and mock or fetch history if needed.
            // Currently `get_daily_user_stats` gets aggregate since timestamp.

            // BETTER APPROACH:
            // Since we don't have a rigid "daily history" table, we can query `question_attempts` grouped by day.
            // But to save RPC complexity, let's just show "Today" accurately and keep others static or simple for now, 
            // unless we want to write a complex history RPC.
            // The requirement is "Performance Trend".
            // Let's use a new RPC or just query attempts. Since we crave accuracy:

            const { data, error } = await supabase.rpc('get_daily_user_stats', { p_start_timestamp: new Date(Date.now() - 24 * 60 * 60 * 1000).toISOString() });

            if (error) throw error;

            const todayStats = data?.[0]; // { total_time_seconds, unique_questions_solved, correct_attempts, total_attempts }

            // Calculate "Mastery Index" for today (simple formula: Accuracy * Volume factor)
            // This is arbitrary but valid for a dashboard metric
            let todayValue = 0;
            if (todayStats && todayStats.total_attempts > 0) {
                const accuracy = (todayStats.correct_attempts / todayStats.total_attempts) * 100;
                // Cap it at 100, maybe scale by volume? For now just show Accuracy.
                todayValue = Math.round(accuracy);
            }

            setLineData(prev => {
                const next = [...prev];
                // Update "Today" (last element)
                next[next.length - 1] = { ...next[next.length - 1], value: todayValue };
                return next;
            });

        } catch (error) {
            console.error('fetchLineData error:', error);
        }
    };

    // Fetch Recent Activities (Global)
    const fetchRecentActivities = async () => {
        if (!user || !user.id) return;

        try {
            const { data, error } = await supabase.rpc('get_recent_activities', { p_limit: 10 });

            if (error) {
                // Graceful fallback if RPC doesn't exist yet (during migration)
                console.warn('get_recent_activities RPC missing or failed, using local activity state.');
                return;
            };

            if (data) {
                const mappedActivities: Activity[] = data.map((d: any) => ({

                    // Activity type 'id' is number in types.ts? Let's check constraints.
                    // If types.ts says number, we might need to change it or hash the UUID.
                    // Workaround: Use timestamp as ID for frontend key if unique enough, or just cast to any.
                    // See types.ts content... id is number.
                    // Temporary fix: Use Date.parse(created_at) or hash for ID if strict, 
                    // BUT better to update the type definition to string | number.
                    // See types.ts content... id is number.
                    // Workaround: Use timestamp as ID for frontend key, plus random to avoid duplicates
                    id: new Date(d.created_at).getTime() + Math.random(),
                    type: d.type === 'practice' ? 'quiz' : 'assignment', // Map to frontend types
                    title: d.title,
                    description: d.description,
                    timestamp: new Date(d.created_at).toLocaleDateString() === new Date().toLocaleDateString()
                        ? 'Today'
                        : new Date(d.created_at).toLocaleDateString(),
                    score: d.score
                }));
                setActivities(mappedActivities);
            }
        } catch (error) {
            console.error('fetchRecentActivities error:', error);
        }
    };

    // Fetch Accuracy History for Chart
    const fetchAccuracyHistory = async (range: '1W' | '1M' | '1Y' | 'ALL') => {
        if (!user || !user.id) return;

        let days = null;
        if (range === '1W') days = 7;
        else if (range === '1M') days = 30;
        else if (range === '1Y') days = 365;

        try {
            const { data, error } = await supabase.rpc('get_accuracy_history', { p_days: days });

            if (error) {
                console.error('get_accuracy_history RPC error:', error);
                return;
            }

            if (data) {
                const mapped = data.map((d: any) => ({
                    date: d.date,
                    accuracy: Number(d.accuracy),
                    totalAttempts: d.total_attempts
                }));
                setAccuracyHistory(mapped);
            }
        } catch (err) {
            console.error('fetchAccuracyHistory error:', err);
        }
    };

    // Update a section in the database
    const updateSection = async (topicId: string, sectionId: string, data: any) => {
        try {
            // 1. Optimistic update to sections state
            setSections(prev => {
                const updated = { ...prev };
                if (updated[topicId]) {
                    const idx = updated[topicId].findIndex(s => s.id === sectionId);
                    if (idx !== -1) {
                        updated[topicId] = [...updated[topicId]];
                        updated[topicId][idx] = { ...updated[topicId][idx], ...data };
                    }
                }
                return updated;
            });

            // 2. Also update topicContent.subTopics so Practice area shows updated data
            setTopicContent(prev => {
                const unit = prev[topicId];
                if (!unit) return prev;

                // Handle unit_test separately
                if (sectionId === 'unit_test') {
                    return {
                        ...prev,
                        [topicId]: {
                            ...unit,
                            unitTest: {
                                ...unit.unitTest,
                                title: data.title ?? unit.unitTest?.title ?? 'Unit Test',
                                description: data.description ?? unit.unitTest?.description,
                                estimatedMinutes: data.estimated_minutes ?? unit.unitTest?.estimatedMinutes ?? 45
                            }
                        }
                    };
                }

                // Handle subTopics
                if (!unit.subTopics) return prev;

                const updatedSubTopics = unit.subTopics.map(sub => {
                    if (sub.id === sectionId) {
                        return {
                            ...sub,
                            title: data.title ?? sub.title,
                            description: data.description ?? sub.description,
                            description_2: data.description_2 ?? sub.description_2,
                            estimatedMinutes: data.estimated_minutes ?? sub.estimatedMinutes,
                            hasLesson: data.has_lesson ?? sub.hasLesson,
                            hasPractice: data.has_practice ?? sub.hasPractice
                        };
                    }
                    return sub;
                });

                return {
                    ...prev,
                    [topicId]: { ...unit, subTopics: updatedSubTopics }
                };
            });

            // 3. Call API to persist
            await sectionsApi.updateSection(topicId, sectionId, data);
            console.log(`✅ Section ${topicId}/${sectionId} saved to Supabase`);
        } catch (error) {
            console.error('Failed to update section:', error);
            throw error;
        }
    };

    // Helper to get sections for a topic (with fallback to COURSE_CONTENT_DATA)
    const getSectionsForTopic = (topicId: string): any[] => {
        if (sections[topicId] && sections[topicId].length > 0) {
            return sections[topicId];
        }
        // Fallback to constants data
        return COURSE_CONTENT_DATA[topicId]?.subTopics || [];
    };

    const fetchNotifications = async () => {
        try {
            const data = await notificationsApi.getNotifications();
            setNotifications(data);
        } catch (error) {
            console.error('Failed to fetch notifications:', error);
        }
    };

    // Expose fetchNotifications to window for cross-component refresh
    useEffect(() => {
        (window as any).__refreshNotifications = fetchNotifications;
        return () => { delete (window as any).__refreshNotifications; };
    }, []);

    const markNotificationRead = async (id: number) => {
        try {
            await notificationsApi.markAsRead(id);
            setNotifications(prev => prev.map(n => n.id === id ? { ...n, unread: false } : n));
        } catch (e) {
            console.error('Failed to mark notification as read:', e);
        }
    };

    // Pro Upgrade Dismissal: Computed from notification state
    // A user "dismissed" pro upgrade if there are NO unread [Membership] notifications
    const membershipNotifs = notifications.filter(n => n.unread && n.text?.startsWith('[Membership]'));
    const proUpgradeDismissed = membershipNotifs.length === 0;

    // dismissProUpgrade: Mark all [Membership] notifications as read
    const dismissProUpgrade = useCallback(() => {
        membershipNotifs.forEach(n => markNotificationRead(n.id));
    }, [membershipNotifs, markNotificationRead]);

    // --- Content Methods ---
    const fetchContent = async () => {
        try {
            console.log('🔄 Fetching course content...');
            // 1. Try to get content from DB
            let data = await contentApi.getTopics();

            // 2. If empty, auto-seed
            if (!data || Object.keys(data).length === 0) {
                console.warn('⚠️ No content found. Seeding database...');
                await contentApi.seedContent();
                // Re-fetch after seeding
                data = await contentApi.getTopics();
            }

            if (data && Object.keys(data).length > 0) {
                // CRITICAL FIX: Merge backend data into static COURSE_CONTENT_DATA
                // instead of replacing entirely. The DB topic_content table may have
                // empty sub_topics arrays, which would wipe the static chapter definitions.
                setTopicContent(prev => {
                    const merged = { ...prev };
                    Object.keys(data).forEach(topicId => {
                        const dbTopic = data[topicId];
                        const staticTopic = merged[topicId] || COURSE_CONTENT_DATA[topicId];
                        if (!staticTopic) {
                            // New topic from DB that doesn't exist in static data
                            merged[topicId] = dbTopic;
                            return;
                        }
                        merged[topicId] = {
                            ...staticTopic,
                            // Override title/description from DB if available
                            title: dbTopic.title || staticTopic.title,
                            description: dbTopic.description || staticTopic.description,
                            unitTest: dbTopic.unitTest || staticTopic.unitTest,
                            // ONLY override subTopics if DB actually has non-empty data
                            subTopics: (dbTopic.subTopics && dbTopic.subTopics.length > 0)
                                ? dbTopic.subTopics
                                : staticTopic.subTopics || [],
                        };
                    });
                    return merged;
                });
                console.log('✅ Content merged from backend (preserved static subTopics)');
            }
        } catch (error) {
            console.error('Failed to sync content:', error);
            // Fallback to static data is already handled by initial state
        }
    };

    // --- Skills Methods ---
    const fetchSkills = async () => {
        try {
            const data = await contentApi.getSkills();
            if (data && data.length > 0) {
                setSkills(data);
                console.log('✅ Skills loaded:', data.length);
            }
        } catch (error) {
            console.error('Failed to fetch skills:', error);
        }
    };

    // --- Questions Methods (fetch from DB) ---
    const fetchQuestions = async () => {
        try {
            console.log('🔄 Fetching questions from database...');
            const data = await questionsApi.getQuestions({ limit: 10000 });

            if (data && data.length > 0) {
                // Merge with static questions, preferring DB versions for duplicates
                setQuestions(prev => {
                    const dbQuestionIds = new Set(data.map(q => q.id));
                    const staticOnly = prev.filter(q => !dbQuestionIds.has(q.id));
                    return [...data, ...staticOnly];
                });
                console.log('✅ Questions loaded from DB:', data.length);
                if (data.status === 'error') {
                    console.error('❌ Backend returned error in data payload:', data);
                }
            } else {
                console.log('ℹ️ No questions in DB (empty array returned), using static data');
                if (data === null || data === undefined) {
                    console.warn('⚠️ data is null/undefined during fetchQuestions');
                }
            }
        } catch (error) {
            console.error('Failed to fetch questions:', error);
            // Keep static questions as fallback
        }
    };

    // --- Real-time Notifications Listener (Improved for DM background alerts) ---
    useEffect(() => {
        if (!user || !isAuthenticated || !user.id) return;

        let generalChannelId: string | undefined;
        let forumSubscription: any;
        let dmSubscription: any;
        let userNotifSub: any;
        let titleSub: any;

        const setupListener = async () => {
            // 1. Get 'General' channel ID
            try {
                const { data: channels } = await supabase
                    .from('forum_channels')
                    .select('id, name')
                    .ilike('name', 'general')
                    .single();
                if (channels) generalChannelId = channels.id;
            } catch (e) {
                console.warn('Failed to find General channel for notifications', e);
            }

            // 2a. Subscribe to forum_messages for in-app notifications
            forumSubscription = supabase.channel('global-notifications-v1')
                .on(
                    'postgres_changes',
                    { event: 'INSERT', schema: 'public', table: 'forum_messages' },
                    async (payload: any) => {
                        const newMsg = payload.new;
                        if (newMsg.user_id === user.id) return;

                        // Check muted channels
                        try {
                            const mutedRaw = localStorage.getItem('forum_muted_channels');
                            if (mutedRaw) {
                                const mutedSet = new Set(JSON.parse(mutedRaw));
                                if (mutedSet.has(newMsg.channel_id)) return;
                            }
                        } catch { }

                        let notifText = '';
                        let senderName = '';
                        let shouldNotify = false;

                        const { data: senderProfile } = await supabase
                            .from('user_profiles')
                            .select('name')
                            .eq('id', newMsg.user_id)
                            .single();

                        const rawSenderName = senderProfile?.name || 'Someone';
                        const isFriend = friendIds.has(newMsg.user_id);
                        const snippet = newMsg.content.length > 60
                            ? newMsg.content.substring(0, 60) + '...'
                            : newMsg.content;

                        if (generalChannelId && newMsg.channel_id === generalChannelId) {
                            shouldNotify = true;
                            const channelDisplayName = 'General Community';
                            if (isFriend) {
                                notifText = `${rawSenderName} in ${channelDisplayName}: "${snippet}"`;
                                senderName = rawSenderName;
                            } else {
                                notifText = `New message in ${channelDisplayName}: "${snippet}"`;
                            }
                        }

                        if (newMsg.reply_to_id) {
                            const { data: parent } = await supabase
                                .from('forum_messages')
                                .select('user_id')
                                .eq('id', newMsg.reply_to_id)
                                .single();

                            if (parent && parent.user_id === user.id) {
                                shouldNotify = true;
                                notifText = `${rawSenderName} replied to your message: "${snippet}"`;
                                senderName = rawSenderName;
                            }
                        }

                        if (shouldNotify) {
                            const newNotif: AppNotification = {
                                id: Date.now(),
                                text: notifText || 'New notification',
                                time: 'Just now',
                                unread: true,
                                link: `/forum?channel_id=${newMsg.channel_id}&message_id=${newMsg.id}`,
                                channelId: newMsg.channel_id,
                                messageId: newMsg.id,
                                senderName: senderName,
                                senderId: newMsg.user_id
                            };
                            setNotifications(prev => [newNotif, ...prev]);
                        }
                    }
                )
                .subscribe();

            // 2b. Subscribe to direct_messages for background alerts
            dmSubscription = supabase.channel('global-dm-notifications-v2')
                .on(
                    'postgres_changes',
                    { event: 'INSERT', schema: 'public', table: 'direct_messages' },
                    async (payload: any) => {
                        const newMsg = payload.new;
                        if (newMsg.user_id === user.id) return;

                        const { data: senderProfile } = await supabase
                            .from('user_profiles')
                            .select('name')
                            .eq('id', newMsg.user_id)
                            .single();

                        const rawSenderName = senderProfile?.name || 'Someone';
                        const snippet = newMsg.content.length > 60
                            ? newMsg.content.substring(0, 60) + '...'
                            : newMsg.content;

                        const newNotif: AppNotification = {
                            id: Date.now(),
                            text: `${rawSenderName} sent you a message: "${snippet}"`,
                            time: 'Just now',
                            unread: true,
                            link: `/forum?chat_id=${newMsg.chat_id}`,
                            chatId: newMsg.chat_id,
                            messageId: newMsg.id,
                            senderName: rawSenderName,
                            senderId: newMsg.user_id,
                            type: 'dm'
                        };
                        setNotifications(prev => [newNotif, ...prev]);
                    }
                )
                .subscribe();

            // 3. User notifications
            userNotifSub = supabase.channel('user-notifications-v1')
                .on(
                    'postgres_changes',
                    {
                        event: 'INSERT',
                        schema: 'public',
                        table: 'notifications',
                        filter: `user_id=eq.${user.id}`
                    },
                    (payload: any) => {
                        const newNotif = payload.new;
                        const appNotif: AppNotification = {
                            id: newNotif.id,
                            text: newNotif.text,
                            time: 'Just now',
                            unread: newNotif.unread,
                            link: newNotif.link || '/dashboard',
                            type: newNotif.type,
                            metadata: newNotif.metadata,
                            chatId: newNotif.chat_id
                        };
                        setNotifications(prev => [appNotif, ...prev]);
                    }
                )
                .subscribe();

            // 4. Achievement unlocks
            titleSub = supabase.channel('achievement-unlocks')
                .on(
                    'postgres_changes',
                    {
                        event: 'INSERT',
                        schema: 'public',
                        table: 'user_titles',
                        filter: `user_id=eq.${user.id}`
                    },
                    async (payload: any) => {
                        const { title_id } = payload.new;
                        const { data } = await supabase
                            .from('titles')
                            .select('*')
                            .eq('id', title_id)
                            .single();
                        if (data) setNewlyUnlockedTitle(data as Title);
                    }
                )
                .subscribe();
        };

        setupListener();

        return () => {
            if (forumSubscription) supabase.removeChannel(forumSubscription);
            if (dmSubscription) supabase.removeChannel(dmSubscription);
            if (userNotifSub) supabase.removeChannel(userNotifSub);
            if (titleSub) supabase.removeChannel(titleSub);
        };
    }, [user.id, isAuthenticated]);

    // Memoized section times calculation for all pages to share
    const sectionTimes = useMemo(() => {
        const times: Record<string, number> = {};
        questions.forEach(q => {
            const sid = q.sectionId || q.subTopicId;
            if (!sid) return;
            // Map course properly (BC includes all AB content, AB only includes AB content)
            const isMatch = q.course === 'Both' ||
                (user.currentCourse === 'AB' && q.course === 'AB') ||
                (user.currentCourse === 'BC');

            if (!isMatch) return;

            times[sid] = (times[sid] || 0) + (q.targetTimeSeconds || 120);
        });
        return times;
    }, [questions, user.currentCourse]);

    const markAllNotificationsRead = async () => {
        // Skip unclaimed gift_claim notifications — they should only be read after claiming
        setNotifications(prev => prev.map(n => {
            if (n.type === 'gift_claim' && !n.metadata?.claimed) return n; // Keep unread
            return { ...n, unread: false };
        }));
        dismissProUpgrade(); // Also dismiss pro upgrade pseudo-notification
        try {
            // Mark all non-gift-claim as read on backend
            // For gift_claim, only mark if already claimed
            const toMark = notifications.filter(n =>
                n.unread && (n.type !== 'gift_claim' || n.metadata?.claimed)
            );
            if (toMark.length > 0) {
                await notificationsApi.markAllAsRead();
                // But re-set unclaimed gift_claim back to unread
                const unclaimedGifts = notifications.filter(n =>
                    n.type === 'gift_claim' && n.unread && !n.metadata?.claimed
                );
                for (const g of unclaimedGifts) {
                    try {
                        await supabase.from('notifications').update({ unread: true }).eq('id', g.id);
                    } catch { }
                }
            }
        } catch (error) {
            console.error('Failed to mark all read:', error);
        }
    };



    // =====================================================
    // AGENT INSIGHT RPC FUNCTIONS
    // =====================================================

    const submitAttempt = async (params: SubmitAttemptParams): Promise<SubmitAttemptResult> => {
        try {
            const { data, error } = await supabase.rpc('submit_attempt', {
                p_question_id: params.questionId,
                p_is_correct: params.isCorrect,
                p_selected_option_id: params.selectedOptionId || null,
                p_answer_numeric: params.answerNumeric || null,
                p_time_spent_seconds: params.timeSpentSeconds,
                p_error_tags: params.errorTags
            });

            if (error) {
                console.error('submit_attempt RPC error:', error);
                return { success: false, error: error.message };
            }

            console.log('✅ Attempt submitted via RPC:', data);

            // Refresh insights after submission
            getUserInsights();

            const result = {
                success: data?.success ?? false,
                attemptId: data?.attempt_id,
                attemptNo: data?.attempt_no,
                isCorrect: data?.is_correct,
                error: data?.error
            };

            if (result.success) {
                if (params.isCorrect === false) {
                    setIncorrectQuestionIds(prev => {
                        const next = new Set(prev);
                        next.add(params.questionId);
                        return next;
                    });
                } else {
                    setIncorrectQuestionIds(prev => {
                        const next = new Set(prev);
                        next.delete(params.questionId);
                        return next;
                    });
                }
            }

            return result as SubmitAttemptResult;
        } catch (error: any) {
            console.error('submitAttempt error:', error);
            return { success: false, error: error.message };
        }
    };

    const getUserInsights = async (): Promise<UserInsights | null> => {
        try {
            const { data, error } = await supabase.rpc('get_user_insights');

            if (error) {
                console.error('get_user_insights RPC error:', error);
                return null;
            }

            const insights: UserInsights = {
                stats: {
                    userId: user.id,
                    totalAttempts: data?.stats?.total_attempts ?? 0,
                    correctAttempts: data?.stats?.correct_attempts ?? 0,
                    accuracyRate: data?.stats?.accuracy_rate ?? 0,
                    uniqueQuestionsAttempted: data?.stats?.unique_questions ?? 0,
                    streakCorrect: data?.stats?.streak_correct ?? 0,
                    streakWrong: data?.stats?.streak_wrong ?? 0,
                    currentStreakDays: data?.stats?.streak_days ?? 0,
                    longestStreakDays: data?.stats?.longest_streak ?? 0,
                    totalTimeMinutes: data?.stats?.total_time_minutes ?? 0,
                    lastPracticed: data?.stats?.last_practiced ?? null
                },
                weakSkills: (data?.weak_skills ?? []).map((s: any) => ({
                    skillId: s.skill_id,
                    skillName: s.skill_name,
                    mastery: s.mastery,
                    confidence: s.confidence,
                    streakWrong: s.streak_wrong,
                    lastPracticed: null
                })),
                topErrors: (data?.top_errors ?? []).map((e: any) => ({
                    errorTagId: e.error_tag_id,
                    errorName: e.error_name,
                    category: e.category,
                    count: e.count
                })),
                reviewQueue: (data?.review_queue ?? []).map((r: any) => ({
                    questionId: r.question_id,
                    nextReviewAt: r.next_review_at,
                    reviewCount: r.review_count,
                    intervalDays: r.interval_days,
                    isOverdue: false
                })),
                recommendations: (data?.recommendations ?? []).map((rec: any) => ({
                    questionId: rec.question_id,
                    score: rec.score,
                    reason: rec.reason,
                    reasonDetail: rec.reason_detail,
                    skillId: rec.skill_id
                }))
            };

            setUserInsights(insights);
            console.log('✅ User insights loaded:', insights);
            return insights;
        } catch (error) {
            console.error('getUserInsights error:', error);
            return null;
        }
    };

    const getReviewQueue = async (limit: number = 20): Promise<ReviewQueueItem[]> => {
        try {
            const { data, error } = await supabase.rpc('get_review_queue', { p_limit: limit });

            if (error) {
                console.error('get_review_queue RPC error:', error);
                return [];
            }

            const queue: ReviewQueueItem[] = (data ?? []).map((item: any) => ({
                questionId: item.question_id,
                nextReviewAt: item.next_review_at,
                reviewCount: item.review_count,
                intervalDays: item.interval_days,
                isOverdue: item.is_overdue,
                questionTopic: item.question_topic,
                questionPrompt: item.question_prompt
            }));

            setReviewQueue(queue);
            return queue;
        } catch (error) {
            console.error('getReviewQueue error:', error);
            return [];
        }
    };

    const toggleQuestionStarred = async (questionId: string): Promise<boolean> => {
        try {
            const { data, error } = await supabase.rpc('toggle_question_starred', {
                p_question_id: questionId
            });

            if (error) {
                console.error('toggle_question_starred RPC error:', error);
                return false;
            }

            console.log('✅ Question starred toggled:', data);
            return data ?? false;
        } catch (error) {
            console.error('toggleQuestionStarred error:', error);
            return false;
        }
    };

    const toggleQuestionFlagged = async (questionId: string): Promise<boolean> => {
        try {
            const { data, error } = await supabase.rpc('toggle_question_flagged', {
                p_question_id: questionId
            });

            if (error) {
                console.error('toggle_question_flagged RPC error:', error);
                return false;
            }

            console.log('✅ Question flagged toggled:', data);
            return data ?? false;
        } catch (error) {
            console.error('toggleQuestionFlagged error:', error);
            return false;
        }
    };

    const getTopicProgress = async (topicId: string): Promise<Record<string, SubTopicProgress>> => {
        try {
            const { data, error } = await supabase.rpc('get_topic_progress', {
                p_topic_id: topicId,
                p_user_id: user.id
            });

            if (error) {
                console.error('get_topic_progress RPC error:', error);
                return {};
            }

            // Convert array to record keyed by subTopicId
            const progressMap: Record<string, SubTopicProgress> = {};
            (data || []).forEach((item: any) => {
                progressMap[item.sub_topic_id] = {
                    subTopicId: item.sub_topic_id,
                    totalQuestions: item.total_questions,
                    attemptedQuestions: item.attempted_questions,
                    correctQuestions: item.correct_questions,
                    lastActivity: item.last_activity
                };
            });

            return progressMap;
        } catch (error) {
            console.error('getTopicProgress error:', error);
            return {};
        }
    };

    // --- Session Persistence Methods ---

    const saveSectionProgress = async (
        sectionId: string,
        data: any,
        stats: { completed: number; total: number; score: number } = { completed: 0, total: 0, score: 0 },
        entityType: 'course' | 'unit' | 'section' = 'section',
        skipStatusUpdate: boolean = false
    ): Promise<boolean> => {
        if (!isAuthenticated || !user?.id) {
            console.warn('⚠️ Cannot save progress: User not authenticated');
            return false;
        }

        try {
            const payload: any = {
                p_section_id: sectionId,
                p_user_id: user.id,
                p_data: data,
                p_completed_items: stats.completed,
                p_total_items: stats.total,
                p_status: skipStatusUpdate ? undefined : 'in_progress',
                p_score: stats.score,
                p_entity_type: entityType
            };

            // console.log('📡 Calling save_section_progress:', { sectionId, stats, skipStatusUpdate });
            const { data: rpcData, error } = await supabase.rpc('save_section_progress', payload);

            if (error) {
                console.error('❌ save_section_progress error:', error);
                return false;
            }

            // OPTIMISTIC UPDATE: Update local cache immediately
            setSectionProgressMap(prev => {
                const existing = prev[sectionId];
                const newStatus = skipStatusUpdate ? (existing?.status || 'in_progress') : (existing?.status === 'completed' ? 'completed' : 'in_progress');

                return {
                    ...prev,
                    [sectionId]: {
                        ...existing,
                        section_id: sectionId,
                        status: newStatus,
                        data: data,
                        correct_questions: stats.completed,
                        total_questions: stats.total,
                        score: stats.score,
                        last_accessed_at: new Date().toISOString(),
                        user_id: user.id
                    } as UserSectionProgress
                };
            });

            return true;
        } catch (error) {
            console.error('saveSectionProgress error:', error);
            return false;
        }
    };

    const completeSectionSession = async (sectionId: string, score: number, totalQuestions: number, correctQuestions: number, data: any, entityType: 'course' | 'unit' | 'section' = 'section', skipStatusUpdate: boolean = false): Promise<boolean> => {
        if (!isAuthenticated || !user?.id) {
            console.warn('⚠️ Cannot complete session: User not authenticated');
            return false;
        }

        try {
            // Use save_section_progress but force status to completed (unless skipped)
            const payload: any = {
                p_section_id: sectionId,
                p_user_id: user.id,
                p_data: data,
                p_completed_items: correctQuestions,
                p_total_items: totalQuestions,
                p_status: skipStatusUpdate ? undefined : 'completed',
                p_score: score,
                p_entity_type: entityType
            };

            const { data: rpcData, error } = await supabase.rpc('save_section_progress', payload);

            if (error) {
                console.error('❌ complete_section_session (via save) error:', error);
                return false;
            }

            // OPTIMISTIC UPDATE: Update local status
            setSectionProgressMap(prev => {
                const existing = prev[sectionId];
                const newStatus = skipStatusUpdate ? (existing?.status || 'in_progress') : 'completed';

                return {
                    ...prev,
                    [sectionId]: {
                        ...existing,
                        section_id: sectionId,
                        status: newStatus,
                        score: score,
                        correct_questions: correctQuestions,
                        total_questions: totalQuestions,
                        data: data,
                        last_accessed_at: new Date().toISOString(),
                        user_id: user.id
                    } as UserSectionProgress
                };
            });

            if (activities.length === 0) {
                setActivities(INITIAL_ACTIVITIES);
            }

            return true;
        } catch (error) {
            console.error('completeSectionSession error:', error);
            return false;
        }
    };

    // --- Aggregation Methods ---

    const getUnitProgress = async (unitId: string) => {
        if (!user?.id) return null;
        const { data, error } = await supabase.rpc('get_unit_progress_stats', { p_user_id: user.id, p_topic_id: unitId });
        if (error) {
            console.error('getUnitProgress error:', error);
            return null;
        }
        return data;
    };

    const getCourseProgress = async (courseScope: string) => {
        if (!user?.id) return null;
        const { data, error } = await supabase.rpc('get_course_progress_stats', { p_user_id: user.id, p_course_scope: courseScope });
        if (error) {
            console.error('getCourseProgress error:', error);
            return null;
        }
        return data;
    };

    const diagSupabase = async () => {
        console.log('🔍 Running Supabase Diagnostics...');
        try {
            const { data, error } = await supabase.rpc('diagnose_supabase_connection');
            if (error) {
                console.error('❌ Diagnostic Error:', error);
                alert(`Supabase Connection Problem: ${error.message}`);
            } else {
                console.log('✅ Diagnostic Data:', data);
                alert(`Supabase Connection OK! User: ${data.authenticated_user || 'Guest'}`);
            }
        } catch (err: any) {
            console.error('❌ Diagnostic Exception:', err);
            alert(`Diagnostic Failed: ${err.message}`);
        }
    };

    const fetchFriends = async () => {
        if (!user?.id) return;
        try {
            const { data, error } = await supabase
                .from('friend_requests')
                .select('sender_id, receiver_id')
                .eq('status', 'accepted')
                .or(`sender_id.eq.${user.id},receiver_id.eq.${user.id}`);

            if (error) throw error;

            const ids = new Set<string>(data.map((req: any) =>
                req.sender_id === user.id ? req.receiver_id : req.sender_id
            ));
            setFriendIds(ids);
            console.log('✅ Friends loaded:', ids.size);
        } catch (err) {
            console.error('Error fetching friends:', err);
        }
    };

    const resetSectionProgress = async (sectionId: string): Promise<boolean> => {
        try {
            const { error } = await supabase
                .from('user_section_progress')
                .delete()
                .eq('user_id', user.id)
                .eq('section_id', sectionId);

            if (error) throw error;

            setSectionProgressMap(prev => {
                const next = { ...prev };
                delete next[sectionId];
                return next;
            });
            return true;
        } catch (error) {
            console.error('resetSectionProgress error:', error);
            return false;
        }
    };

    const logUserActivity = async (params: {
        sectionId: string;
        attemptType: 'first_attempt' | 'review';
        score: number;
        correctCount: number;
        totalQuestions: number;
        data: any;
    }): Promise<string | null> => {
        if (!isAuthenticated || !user?.id) return null;

        try {
            const { data, error } = await supabase.rpc('log_user_activity', {
                p_section_id: params.sectionId,
                p_attempt_type: params.attemptType,
                p_score: params.score,
                p_correct_count: params.correctCount,
                p_total_questions: params.totalQuestions,
                p_data: params.data
            });

            if (error) {
                console.error('Error logging activity:', error);
                return null;
            }

            return data; // returns the UUID of the activity
        } catch (error) {
            console.error('logUserActivity exception:', error);
            return null;
        }
    };

    const getUserActivities = async (sectionId: string): Promise<any[]> => {
        if (!isAuthenticated || !user?.id) return [];

        try {
            const { data, error } = await supabase.rpc('get_user_activities', {
                p_section_id: sectionId
            });

            if (error) {
                console.error('Error fetching activities:', error);
                return [];
            }

            return data || [];
        } catch (error) {
            console.error('getUserActivities exception:', error);
            return [];
        }
    };

    const getSectionProgress = async (sectionId: string): Promise<UserSectionProgress | null> => {
        try {
            const { data, error } = await supabase.rpc('get_section_progress', {
                p_section_id: sectionId
            });

            if (error) throw error;
            if (data && data.length > 0) {
                return data[0] as UserSectionProgress;
            }
            return null;
        } catch (error) {
            console.error('Error fetching section progress:', error);
            return null;
        }
    };

    // --- Bulk Fetch Logic for Caching ---
    const fetchIncorrectQuestions = async () => {
        if (!user?.id) return;
        try {
            // Get questions where the LATEST attempt is incorrect
            const { data, error } = await supabase.rpc('get_current_incorrect_questions');

            if (error) {
                // Fallback to simple query if RPC missing
                const { data: qData, error: qError } = await supabase
                    .from('question_attempts')
                    .select('question_id, is_correct, created_at')
                    .eq('user_id', user.id)
                    .order('created_at', { ascending: false });

                if (qError) throw qError;

                const currentIncorrect = new Set<string>();
                const seen = new Set<string>();
                (qData as any[])?.forEach(attempt => {
                    if (!seen.has(attempt.question_id)) {
                        seen.add(attempt.question_id);
                        if (!attempt.is_correct) {
                            currentIncorrect.add(attempt.question_id);
                        }
                    }
                });
                setIncorrectQuestionIds(currentIncorrect);
            } else if (data) {
                const ids = new Set<string>((data as any[]).map((d: any) => d.question_id as string));
                setIncorrectQuestionIds(ids);
            }
        } catch (err) {
            console.error('Error fetching incorrect questions in AppContext:', err);
        }
    };

    const fetchAllUserProgress = async () => {
        if (!user?.id) return;
        try {
            // Parallelize for performance
            await Promise.all([
                (async () => {
                    const { data, error } = await supabase.rpc('get_all_user_progress');
                    if (error) {
                        console.error('Error fetching all user progress:', error);
                        return;
                    }
                    if (data) {
                        const map: Record<string, UserSectionProgress> = {};
                        data.forEach((p: any) => {
                            map[p.section_id] = p;
                        });
                        setSectionProgressMap(map);
                    }
                })(),
                fetchIncorrectQuestions()
            ]);
        } catch (error) {
            console.error('fetchAllUserProgress error:', error);
        }
    };

    // Load public data on mount
    useEffect(() => {
        fetchSections();
        fetchContent();
        fetchSkills();
        fetchQuestions();
    }, []);

    // Load user-specific data when user authenticates
    useEffect(() => {
        if (user.id && isAuthenticated) {
            const loadData = async () => {
                // 1. Generate/Update Automated System Notifications (Atomic DB check)
                await supabase.rpc('generate_system_notifications', { p_user_id: user.id });

                // 2. Load all user data
                await Promise.all([
                    fetchAllUserProgress(),
                    fetchRadarData(),
                    fetchLineData(),
                    fetchRecentActivities(),
                    fetchNotifications(),
                    getUserInsights(),
                    fetchFriends(),
                    fetchUserPoints(),
                    fetchQuestions()
                ]);
            };
            loadData();
        } else {
            setSectionProgressMap({});
            setFriendIds(new Set());
        }
    }, [user.id, isAuthenticated]);

    const getSectionStatus = (sectionId: string): 'not_started' | 'in_progress' | 'completed' => {
        // Direct Lookup
        if (sectionProgressMap[sectionId]) return sectionProgressMap[sectionId].status;

        // COMPAT: Fallback Lookup for Unified IDs (ABBC_ -> AB_/BC_ or vice versa)
        const base = sectionId.replace(/^(ABBC_|AB_|BC_|Both_)/, '');

        // 1. If we have ABBC_Limits, check if we have AB_Limits status stored
        const legacyAB = `AB_${base}`;
        if (sectionProgressMap[legacyAB]) return sectionProgressMap[legacyAB].status;

        const legacyBC = `BC_${base}`;
        if (sectionProgressMap[legacyBC]) return sectionProgressMap[legacyBC].status;

        // 2. If we asked for AB_Limits, check if ABBC_Limits exists
        const unified = `ABBC_${base}`;
        if (sectionProgressMap[unified]) return sectionProgressMap[unified].status;

        // 3. Finally try the raw base itself
        if (sectionProgressMap[base]) return sectionProgressMap[base].status;

        return 'not_started';
    };

    const getSectionProgressData = (sectionId: string): UserSectionProgress | undefined => {
        if (!sectionId) return undefined;
        if (sectionProgressMap[sectionId]) return sectionProgressMap[sectionId];

        // Try normalized IDs
        const base = sectionId.replace(/^(ABBC_|AB_|BC_|Both_)/, '');

        // 1. If we have ABBC_Limits, check if we have AB_Limits status stored
        const legacyAB = `AB_${base}`;
        if (sectionProgressMap[legacyAB]) return sectionProgressMap[legacyAB];

        const legacyBC = `BC_${base}`;
        if (sectionProgressMap[legacyBC]) return sectionProgressMap[legacyBC];

        // 2. If we asked for AB_Limits, check if ABBC_Limits exists
        const unified = `ABBC_${base}`;
        if (sectionProgressMap[unified]) return sectionProgressMap[unified];

        // 2. Finally try the raw base itself
        if (sectionProgressMap[base]) return sectionProgressMap[base];

        return undefined;
    };

    const getTopicSectionProgress = async (topicId: string): Promise<UserSectionProgress[]> => {
        try {
            const { data, error } = await supabase.rpc('get_topic_section_progress', {
                p_topic_id: topicId
            });

            if (error) throw error;
            return (data || []) as UserSectionProgress[];
        } catch (error) {
            console.error('Error fetching topic section progress:', error);
            return [];
        }
    };



    // Calculate Course Mastery dynamically from Radar Data
    const getCourseMastery = (courseType: CourseType) => {
        // Define which topics belong to which course
        // AB uses Units 1-8. BC uses Units 1-10.
        const abTopics = ['Unit 1', 'Unit 2', 'Unit 3', 'Unit 4', 'Unit 5', 'Unit 6', 'Unit 7', 'Unit 8'];
        const bcTopics = [...abTopics, 'Unit 9', 'Unit 10'];

        const relevantTopics = courseType === 'AB' ? abTopics : bcTopics;

        const totalScore = radarData.reduce((acc, item) => {
            if (relevantTopics.includes(item.subject)) {
                return acc + item.A;
            }
            return acc;
        }, 0);

        // Return average
        return Math.round(totalScore / relevantTopics.length);
    };

    // Effect: Check for existing Supabase session on app start (persistent login)
    useEffect(() => {
        const restoreSession = async () => {
            // Safety valve: Force stop loading after 5 seconds to prevent white screen
            const safetyTimeout = setTimeout(() => {
                console.warn('⚠️ Session restore timed out, forcing load completion.');
                setIsAuthLoading(false);
            }, 5000);

            try {
                const { data: { session } } = await supabase.auth.getSession();
                if (session?.user) {
                    const email = session.user.email || '';
                    // Fetch full profile to get is_creator status AND latest name AND subscription data
                    const { data: profile } = await supabase
                        .from('user_profiles')
                        .select('is_creator, name, avatar_url, subscription_tier, subscription_period_end, has_seen_pro_intro, bio, avatar_color, show_name, show_email, show_bio, streak_days, equipped_title_id, equipped_title:titles(*)')
                        .eq('id', session.user.id)
                        .single();

                    // Parallel fetch for stats and titles
                    const { data: statsData } = await supabase.rpc('get_user_stats', { target_user_id: session.user.id });

                    const { data: allTitles } = await supabase
                        .from('titles')
                        .select('*')
                        .order('threshold', { ascending: true });

                    if (allTitles) setAvailableTitles(allTitles);

                    // 优先使用user_profiles中的name（用户可能在Settings里更新过）
                    const rawName = profile?.name || session.user.user_metadata?.name || email.split('@')[0];
                    const name = rawName.charAt(0).toUpperCase() + rawName.slice(1);

                    // ✅ Authorization Logic Source of Truth:
                    // Database Table: public.user_profiles
                    // Column: is_creator (boolean)
                    // Hardcoded Overrides: newmao6120@gmail.com OR *@newmaos.com
                    const isSuperAdmin = email === 'newmao6120@gmail.com';
                    const isAuthorizedDomain = email.toLowerCase().endsWith('@newmaos.com');

                    // 优先使用user_profiles中的avatar_url
                    const dbAvatarUrl = profile?.avatar_url;
                    const finalAvatarUrl = dbAvatarUrl || `https://ui-avatars.com/api/?name=${encodeURIComponent(name)}&background=f9d406&color=1c1a0d&bold=true`;

                    setIsAuthenticated(true);
                    setUser(prev => {
                        const updatedUser = {
                            ...prev,
                            id: session.user.id,
                            name: name,
                            email: email,
                            avatarUrl: finalAvatarUrl,
                            isCreator: isSuperAdmin || isAuthorizedDomain || profile?.is_creator || false,
                            subscriptionTier: profile?.subscription_tier || 'basic',
                            subscriptionPeriodEnd: profile?.subscription_period_end,
                            hasSeenProIntro: profile?.has_seen_pro_intro || false,
                            equippedTitle: profile?.equipped_title ? (() => {
                                const t = Array.isArray(profile.equipped_title) ? profile.equipped_title[0] : profile.equipped_title;
                                return {
                                    id: profile.equipped_title_id || '',
                                    name: t.name,
                                    category: t.category,
                                    description: t.description || '',
                                    threshold: t.threshold || 0
                                };
                            })() : undefined,
                            stats: statsData || { posts: 0, friends: 0, channels: 0 },
                            bio: profile?.bio || '',
                            avatarColor: profile?.avatar_color || 'linear-gradient(135deg, #FFD700 0%, #FF8C00 100%)',
                            showName: profile?.show_name ?? true,
                            showEmail: profile?.show_email ?? false,
                            showBio: profile?.show_bio ?? true,
                            streakDays: profile?.streak_days || 0,
                            equippedTitleId: profile?.equipped_title_id,
                            preferences: {
                                emailNotifications: (profile as any)?.email_notifications ?? true,
                                soundEffects: (profile as any)?.sound_effects ?? true
                            }
                        };
                        localStorage.setItem('user_profile_cache', JSON.stringify(updatedUser));
                        return updatedUser;
                    });

                    // ONLY Sync to DB if the database has NO avatar_url (initial setup)
                    if (!dbAvatarUrl) {
                        console.log('[Auth] Profile has no avatar. Syncing default UI Avatar to DB.');
                        supabase.from('user_profiles')
                            .upsert({
                                id: session.user.id,
                                avatar_url: finalAvatarUrl,
                                name: name // Ensure name is also synced if profile is new
                            })
                            .then(({ error }) => {
                                if (error) console.error('Failed to sync default profile to user_profiles:', error);
                            });
                    }
                    console.log('✅ Session restored for:', email);
                }
            } catch (error) {
                console.log('No existing session found');
            } finally {
                clearTimeout(safetyTimeout);
                setIsAuthLoading(false); // Stop loading regardless of result
            }
        };

        restoreSession();

        // Listen for auth state changes
        const { data: { subscription } } = supabase.auth.onAuthStateChange((event, session) => {
            if (event === 'SIGNED_OUT') {
                setIsAuthenticated(false);
                setUser(INITIAL_USER);
                localStorage.removeItem('user_profile_cache');
                localStorage.removeItem('auth_token');
                localStorage.removeItem('user_course_mode');
                localStorage.removeItem('forum_channels_cache');
                localStorage.removeItem('forum_activeChannelId');
                localStorage.removeItem('global_unread_counts');
                sessionStorage.removeItem('streak_checked_today');
            } else if (event === 'SIGNED_IN' && session) {
                // Trigger a restore if not already handled
                if (!isAuthenticated) restoreSession();
            }
        });

        return () => subscription.unsubscribe();
    }, []);

    // Effect: Update recommendation when course changes
    useEffect(() => {
        // ... (existing recommendation logic)
    }, [user.currentCourse, user.problemsSolved]);

    const login = (
        email: string,
        username?: string,
        id?: string,
        subscriptionTier: 'basic' | 'pro' = 'basic',
        subscriptionPeriodEnd?: string,
        hasSeenProIntro: boolean = false
    ) => {
        setIsAuthenticated(true);
        // Use username if provided, otherwise derive from email
        const displayName = username || email.split('@')[0];
        const formattedName = displayName.charAt(0).toUpperCase() + displayName.slice(1);

        const isSuperAdmin = email === 'newmao6120@gmail.com';

        setUser(prev => {
            const updatedUser = {
                ...prev,
                id: id || prev.id || '',
                name: formattedName || "Student",
                email: email,
                avatarUrl: `https://ui-avatars.com/api/?name=${encodeURIComponent(formattedName || 'Student')}&background=f9d406&color=1c1a0d&bold=true`,
                isCreator: isSuperAdmin || prev.isCreator,
                subscriptionTier: subscriptionTier,
                subscriptionPeriodEnd: subscriptionPeriodEnd,
                hasSeenProIntro: hasSeenProIntro
            };
            localStorage.setItem('user_profile_cache', JSON.stringify(updatedUser));
            return updatedUser;
        });
    };

    const isPro = useMemo(() => {
        return user.subscriptionTier === 'pro';
    }, [user.subscriptionTier]);

    const claimFreePro = async () => {
        if (!isAuthenticated || !user.id) return false;

        try {
            const periodEnd = new Date();
            periodEnd.setMonth(periodEnd.getMonth() + 1);
            const periodEndStr = periodEnd.toISOString();

            const { error } = await supabase
                .from('user_profiles')
                .upsert({
                    id: user.id,
                    subscription_tier: 'pro',
                    subscription_period_end: periodEndStr
                });

            if (error) throw error;

            setUser(prev => {
                const updated: User = {
                    ...prev,
                    subscriptionTier: 'pro' as const,
                    subscriptionPeriodEnd: periodEndStr
                };
                localStorage.setItem('user_profile_cache', JSON.stringify(updated));
                return updated;
            });

            return true;
        } catch (error) {
            console.error('Failed to claim free pro:', error);
            return false;
        }
    };

    // =====================================================
    // POINTS ECONOMY FUNCTIONS
    // =====================================================

    const fetchUserPoints = async () => {
        if (!user.id) return;
        try {
            const { data, error } = await supabase.rpc('get_points_summary', { p_user_id: user.id });
            if (error) {
                console.error('fetchUserPoints error:', error);
                return;
            }
            if (data) {
                setUserPoints({
                    balance: data.balance || 0,
                    lifetimeEarned: data.lifetime_earned || 0
                });
            }
        } catch (err) {
            console.error('fetchUserPoints error:', err);
        }
    };

    const triggerCoinAnimation = (amount: number, x?: number, y?: number, mode: 'earn' | 'spend' = 'earn') => {
        // Default to center of screen if no coordinates provided
        const posX = x ?? window.innerWidth / 2;
        const posY = y ?? window.innerHeight / 2;

        // Dispatch custom event that CoinCollector component will listen to
        const event = new CustomEvent('coin-collect', {
            detail: { amount, x: posX, y: posY, mode }
        });
        window.dispatchEvent(event);
    };

    // Pre-unlock AudioContext during user gesture (before async work)
    // Browsers block AudioContext creation outside of user interaction
    const unlockAudioContext = () => {
        try {
            const ctx = new (window.AudioContext || (window as any).webkitAudioContext)();
            // Resume if suspended (required by Chrome autoplay policy)
            if (ctx.state === 'suspended') ctx.resume();
            // Dispatch a silent unlock event that CoinCollector can pick up
            window.dispatchEvent(new CustomEvent('audio-unlock'));
        } catch { }
    };

    const awardPoints = async (
        amount: number,
        type: string,
        sourceId?: string,
        description?: string,
        idempotencyKey?: string,
        x?: number,
        y?: number
    ): Promise<{ success: boolean; newBalance?: number }> => {
        if (!user.id || amount <= 0) return { success: false };
        try {
            // Pre-unlock audio context IMMEDIATELY on user gesture (before async)
            unlockAudioContext();

            const { data, error } = await supabase.rpc('award_points', {
                p_user_id: user.id,
                p_amount: amount,
                p_type: type,
                p_source_id: sourceId || null,
                p_description: description || '',
                p_idempotency_key: idempotencyKey || null
            });
            if (data?.success) {
                // ✅ Trigger animation ONLY on successful award
                triggerCoinAnimation(amount, x, y);

                setUserPoints(prev => ({
                    balance: data.new_balance,
                    lifetimeEarned: prev.lifetimeEarned + amount
                }));

                setRecentPointsTransaction({ amount, description: description || type });
                // Auto-clear after animation
                setTimeout(() => setRecentPointsTransaction(null), 2000);
                return { success: true, newBalance: data.new_balance };
            }
            return { success: false };
        } catch (err) {
            console.error('awardPoints error:', err);
            return { success: false };
        }
    };

    const redeemProWithPoints = async (): Promise<{ success: boolean; reason?: string; newBalance?: number; shortfall?: number }> => {
        if (!user.id) return { success: false, reason: 'not_authenticated' };
        try {
            const { data, error } = await supabase.rpc('redeem_pro_with_points', { p_user_id: user.id });
            if (error) {
                console.error('redeemProWithPoints RPC error:', error);
                return { success: false, reason: error.message };
            }
            if (data?.success) {
                // Update local state
                setUserPoints(prev => ({ ...prev, balance: data.new_balance }));
                setUser(prev => {
                    const updated: User = {
                        ...prev,
                        subscriptionTier: 'pro' as const,
                        subscriptionPeriodEnd: data.period_end
                    };
                    localStorage.setItem('user_profile_cache', JSON.stringify(updated));
                    return updated;
                });
                return { success: true, newBalance: data.new_balance };
            }
            return { success: false, reason: data?.reason, shortfall: data?.shortfall };
        } catch (err: any) {
            console.error('redeemProWithPoints error:', err);
            return { success: false, reason: err.message };
        }
    };

    const fetchUserPrestige = useCallback(async () => {
        if (!user?.id) return;
        try {
            const { data, error } = await supabase
                .from('user_prestige')
                .select('*')
                .eq('user_id', user.id)
                .single();

            if (error && error.code !== 'PGRST116') {
                console.error('Error fetching prestige:', error);
            }

            if (data) {
                setUserPrestige(data);
            } else {
                // Default / Initial State
                setUserPrestige({
                    user_id: user.id,
                    planet_level: 1,
                    star_level: 0,
                    current_stardust: 0,
                    total_stardust_collected: 0
                });
            }
        } catch (err) {
            console.error('Exception fetching prestige:', err);
        }
    }, [user?.id]);

    const purchaseStardust = async (amountCoins: number) => {
        if (!user?.id) return { success: false, message: 'User not found' };
        try {
            const { data, error } = await supabase.rpc('purchase_stardust', { amount_coins: amountCoins });
            if (error) throw error;

            if (data.success) {
                await fetchUserPoints();
                await fetchUserPrestige();
                return { success: true };
            } else {
                return { success: false, message: data.message };
            }
        } catch (err: any) {
            console.error('Purchase stardust failed:', err);
            return { success: false, message: err.message || 'Transaction failed' };
        }
    };

    const injectStardust = async (amount: number) => {
        if (!user?.id) return { success: false, message: 'User not found' };
        try {
            const { data, error } = await supabase.rpc('inject_stardust', { amount_to_inject: amount });
            if (error) throw error;

            if (data.success) {
                await fetchUserPrestige();
                return { success: true };
            } else {
                return { success: false, message: data.message };
            }
        } catch (err: any) {
            console.error('Inject stardust failed:', err);
            return { success: false, message: err.message || 'Injection failed' };
        }
    };

    useEffect(() => {
        if (isAuthenticated) {
            fetchUserPrestige();
        }
    }, [isAuthenticated, fetchUserPrestige]);

    const performDailyCheckin = useCallback(async () => {
        if (!user.id) return { success: false, reason: 'not_authenticated' };
        try {
            const localDate = new Date().toLocaleDateString('en-CA');
            const { data, error } = await supabase.rpc('perform_daily_checkin', {
                p_user_id: user.id,
                p_client_date: localDate
            });
            if (error) {
                console.error('performDailyCheckin RPC error:', error);
                return { success: false, reason: error.message };
            }
            if (data?.success) {
                // Refresh points balance
                await fetchUserPoints();

                // Trigger animation (default to center)
                triggerCoinAnimation(data.total_points || 20);

                // Mark check-in status as done globally
                setCheckinStatus('checked_in');
                sessionStorage.setItem('streak_checked_today', 'true');

                // Clear any check-in notifications
                setNotifications(prev => {
                    const checkinNotifs = prev.filter(n => n.link === '/checkin' && n.unread);
                    checkinNotifs.forEach(n => markNotificationRead(n.id));
                    return prev;
                });

                return {
                    success: true,
                    streakDay: data.streak_day,
                    basePoints: data.base_points,
                    bonusPoints: data.bonus_points,
                    totalPoints: data.total_points,
                    isMilestone: data.is_milestone
                };
            }
            return { success: false, reason: data?.reason, streakDay: data?.streak_day };
        } catch (err: any) {
            console.error('performDailyCheckin error:', err);
            return { success: false, reason: err.message };
        }
    }, [user.id, fetchUserPoints]);

    const recordLoginStreak = useCallback(async () => {
        if (!user.id) return { success: false, reason: 'not_authenticated' };
        try {
            const localDate = new Date().toLocaleDateString('en-CA');
            const { data, error } = await supabase.rpc('record_login_streak', {
                p_user_id: user.id,
                p_client_date: localDate
            });
            if (error) {
                console.error('recordLoginStreak RPC error:', error);
                return { success: false, reason: error.message };
            }
            if (data?.success) {
                await fetchUserPoints();
                return {
                    success: true,
                    streak: data.streak,
                    points: data.points
                };
            }
            return { success: false, reason: data?.reason, streak: data?.streak };
        } catch (err: any) {
            console.error('recordLoginStreak error:', err);
            return { success: false, reason: err.message };
        }
    }, [user.id, fetchUserPoints]);

    const getCheckinStatus = useCallback(async () => {
        if (!user.id) return { checkedInToday: false, currentStreak: 0, monthCheckins: 0, monthCalendar: [] };
        try {
            const localDate = new Date().toLocaleDateString('en-CA');
            const { data, error } = await supabase.rpc('get_checkin_status', {
                p_user_id: user.id,
                p_client_date: localDate
            });
            if (error) {
                console.error('getCheckinStatus RPC error:', error);
                return { checkedInToday: false, currentStreak: 0, monthCheckins: 0, monthCalendar: [] };
            }
            // Calculate display logic:
            // If NOT checked in today, we want to show "Yesterday's Streak" instead of 0
            // so the user sees what they are maintaining.
            let displayStreak = data?.current_streak || 0;
            const checkedInToday = data?.checked_in_today || false;

            if (!checkedInToday && data?.month_calendar) {
                // Find yesterday's record
                const yesterday = new Date();
                yesterday.setDate(yesterday.getDate() - 1);
                const yStr = yesterday.toLocaleDateString('en-CA');

                const yRecord = data.month_calendar.find((d: any) => d.date === yStr);
                if (yRecord) {
                    displayStreak = yRecord.streak_day;
                }
            }

            return {
                checkedInToday: checkedInToday,
                currentStreak: displayStreak, // Use modified display streak
                monthCheckins: data?.month_checkins || 0,
                monthCalendar: data?.month_calendar || []
            };
        } catch (err) {
            console.error('getCheckinStatus error:', err);
            return { checkedInToday: false, currentStreak: 0, monthCheckins: 0, monthCalendar: [] };
        }
    }, [user.id]);

    const refreshCheckinStatus = useCallback(async () => {
        if (!user.id) return;
        const status = await getCheckinStatus();
        if (status.checkedInToday) {
            setCheckinStatus('checked_in');
            sessionStorage.setItem('streak_checked_today', 'true');
        } else {
            setCheckinStatus('not_checked_in');
            sessionStorage.removeItem('streak_checked_today');
        }
    }, [user.id, getCheckinStatus]);

    useEffect(() => {
        if (user.id) refreshCheckinStatus();
    }, [user.id]);

    const markProIntroSeen = async () => {
        if (!isAuthenticated || !user.id) return;

        console.log('[ProIntro] Marking as seen for user:', user.id);

        try {
            const { error } = await supabase
                .from('user_profiles')
                .update({ has_seen_pro_intro: true })
                .eq('id', user.id);

            if (error) {
                console.error('[ProIntro] Database update failed:', error);
                throw error;
            }

            console.log('[ProIntro] Database updated successfully');

            setUser(prev => {
                const updated = { ...prev, hasSeenProIntro: true };
                localStorage.setItem('user_profile_cache', JSON.stringify(updated));
                console.log('[ProIntro] Local state and cache updated');
                return updated;
            });
        } catch (error) {
            console.error('[ProIntro] Failed to mark pro intro as seen:', error);
        }
    };

    const logout = async () => {
        try {
            await supabase.auth.signOut();
        } catch (error) {
            console.error('Error signing out:', error);
        }
        setIsAuthenticated(false);
        setIsCreatorAuthenticated(false); // Reset creator access on logout
        setHasDismissedLoginPrompt(true); // Don't show popup immediately after logout
        sessionStorage.setItem('hasDismissedLoginPrompt', 'true'); // Persist dismissed state for this session

        // CLEAR ALL STORAGE
        localStorage.removeItem('auth_token');
        localStorage.removeItem('user_profile_cache');
        localStorage.removeItem('user_course_mode');
        localStorage.removeItem('forum_channels_cache');
        localStorage.removeItem('forum_activeChannelId');
        localStorage.removeItem('global_unread_counts');
        localStorage.removeItem('forum_dm_cache');
        sessionStorage.removeItem('streak_checked_today');
        // Clear cached messages if any
        Object.keys(localStorage).forEach(key => {
            if (key.startsWith('forum_messages_cache_')) {
                localStorage.removeItem(key);
            }
        });

        sessionStorage.removeItem('streak_checked_today');

        setUser(INITIAL_USER); // Reset to empty on logout
    };

    const toggleCourse = (course: CourseType) => {
        localStorage.setItem('user_course_mode', course);
        setUser(prev => ({ ...prev, currentCourse: course }));
    };

    const startCourse = (courseId: CourseType) => {
        setCourses(prev => ({
            ...prev,
            [courseId]: {
                ...prev[courseId],
                status: 'In Progress'
            }
        }));
        setUser(prev => ({ ...prev, currentCourse: courseId }));
        localStorage.setItem('user_course_mode', courseId);
    };

    const updateUser = (updates: Partial<User>) => {
        setUser(prev => {
            const newState = { ...prev, ...updates };

            // If name is being updated AND no avatarUrl is provided in this update, 
            // AND the user doesn't already have a custom avatar, regenerate default.
            if (updates.name && !updates.avatarUrl) {
                const hasCustomAvatar = prev.avatarUrl && !prev.avatarUrl.includes('ui-avatars.com');
                if (!hasCustomAvatar) {
                    const displayName = updates.name;
                    const newAvatarUrl = `https://ui-avatars.com/api/?name=${encodeURIComponent(displayName)}&background=f9d406&color=1c1a0d&bold=true`;
                    newState.avatarUrl = newAvatarUrl;
                }
            }

            // Sync to DB if authenticated
            if (prev.id) {
                // Prepare sync object with all profile fields
                const syncData: any = {
                    name: newState.name,
                    avatar_url: newState.avatarUrl,
                    subscription_tier: newState.subscriptionTier,
                    subscription_period_end: newState.subscriptionPeriodEnd,
                    has_seen_pro_intro: newState.hasSeenProIntro,
                    bio: newState.bio,
                    avatar_color: newState.avatarColor,
                    show_name: newState.showName,
                    show_email: newState.showEmail,
                    show_bio: newState.showBio,
                    equipped_title_id: newState.equippedTitleId,
                    email_notifications: newState.preferences?.emailNotifications,
                    sound_effects: newState.preferences?.soundEffects
                };

                supabase.from('user_profiles')
                    .upsert({
                        id: prev.id,
                        ...syncData
                    })
                    .then(({ error }) => {
                        if (error) console.error('Failed to sync profile to user_profiles:', error);
                    });
            }

            localStorage.setItem('user_profile_cache', JSON.stringify(newState));
            return newState;
        });
    };

    const setSessionMode = (mode: SessionMode) => {
        setRecommendation(prev => ({ ...prev, mode }));
    };

    const dismissLoginPrompt = () => {
        setHasDismissedLoginPrompt(true);
        sessionStorage.setItem('hasDismissedLoginPrompt', 'true');
    };

    // Creator Area Logic - Syncs to Supabase via Backend API
    const addQuestion = async (q: Partial<Question> & { options: any[] }) => {
        try {
            // Call backend API to create question in Supabase
            const newQuestion = await questionsApi.createQuestion({
                ...q,
                topic: q.topic,
                topicId: (q as any).topicId,
                subTopicId: q.subTopicId,
                primarySkillId: (q as any).primarySkillId,
                supportingSkillIds: (q as any).supportingSkillIds || [],
            });

            // Update local state with the returned question
            setQuestions(prev => [...prev, newQuestion]);
            console.log('✅ Question created and synced to Supabase:', newQuestion.id);
            return true;
        } catch (error: any) {
            console.error('Failed to create question:', error);
            throw error; // Propagate to caller for handling
        }
    };

    const updateQuestion = async (updatedQ: Question) => {
        try {
            // Optimistic update
            setQuestions(prev => prev.map(q => q.id === updatedQ.id ? updatedQ : q));

            // Call backend API to update in Supabase
            await questionsApi.updateQuestion(updatedQ.id!, {
                ...updatedQ,
                topicId: (updatedQ as any).topicId,
                primarySkillId: (updatedQ as any).primarySkillId,
                supportingSkillIds: (updatedQ as any).supportingSkillIds || [],
            });
            console.log('✅ Question updated and synced to Supabase:', updatedQ.id);
            return true;
        } catch (error: any) {
            console.error('Failed to update question:', error);
            throw error; // Propagate to caller
        }
    };

    const deleteQuestion = async (id: string) => {
        try {
            // Optimistic delete
            setQuestions(prev => prev.filter(q => q.id !== id));

            // Call backend API to delete from Supabase
            await questionsApi.deleteQuestion(id);
            console.log('✅ Question deleted from Supabase:', id);
            return true;
        } catch (error: any) {
            console.error('Failed to delete question:', error);
            throw error;
        }
    };

    const updateTopic = async (unitId: string, subTopicId: string | null, data: any) => {
        // 1. Optimistic Update (UI updates immediately)
        setTopicContent(prev => {
            const next = { ...prev };
            const unit = next[unitId];

            if (!unit) return next;

            if (subTopicId === 'unit_test') {
                const currentConfig = unit.unitTest || {
                    title: 'Unit Test',
                    description: `Comprehensive assessment covering all topics in ${unit.title}.`,
                    estimatedMinutes: 45
                };
                next[unitId] = { ...unit, unitTest: { ...currentConfig, ...data } };
            } else if (subTopicId) {
                const updateSubInList = (u: UnitContent) => {
                    const idx = u.subTopics.findIndex(s => s.id === subTopicId);
                    if (idx !== -1) {
                        const newSubs = [...u.subTopics];
                        newSubs[idx] = { ...newSubs[idx], ...data };
                        return { ...u, subTopics: newSubs };
                    }
                    return u;
                };

                // Update specific unit and propagate to shared units (e.g. AB/BC sharing)
                next[unitId] = updateSubInList(unit);
                for (const key in next) {
                    if (key !== unitId) next[key] = updateSubInList(next[key]);
                }
            } else {
                next[unitId] = { ...unit, ...data };
            }

            return next;
        });

        // 2. Persist to Backend
        try {
            if (subTopicId) {
                // Update SubTopic or Unit Test
                await contentApi.updateSubTopic(unitId, subTopicId, data);
            } else {
                // Update Unit Metadata
                await contentApi.updateTopic(unitId, data);
            }
            console.log('✅ Topic settings saved to database');
        } catch (error) {
            console.error('❌ Failed to save topic settings:', error);
            // Ideally revert state here or show toast, but keeping simple for now
        }
    };

    const verifyAccessCode = async (code: string): Promise<{ success: boolean; message?: string }> => {
        try {
            const response = await fetch(`${import.meta.env.VITE_API_URL}/auth/verify-access-code`, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ code, userId: user.id })
            });
            const data = await response.json();

            if (data.success) {
                // Update local state immediately
                setUser(prev => ({ ...prev, isCreator: true }));
                setIsCreatorAuthenticated(true); // Keep legacy state for now just in case
                return { success: true };
            }
            return { success: false, message: data.error || 'Verification failed' };
        } catch (error: any) {
            console.error('Verify access code error:', error);
            return { success: false, message: error.message || 'Network error' };
        }
    };

    // Notification Methods moved to top


    const completePractice = ({ correct, total, topic }: { correct: number; total: number; topic: string }) => {
        // 1. Update User Stats
        setUser(prev => {
            const newSolved = prev.problemsSolved + total;
            // Simple mock mastery calculation logic (starts aggressive for new users)
            const performanceFactor = correct / total;

            // Add study time to "Today" dynamically (Sun=0, Sat=6)
            const todayIndex = new Date().getDay();
            const newStudyHours = [...prev.studyHours];
            newStudyHours[todayIndex] = parseFloat((newStudyHours[todayIndex] + 0.2).toFixed(1)); // Add 0.2 hours per session

            // Improve percentile from 0 if new
            const newPercentile = prev.percentile === 0 ? 50 : Math.max(1, prev.percentile - (performanceFactor > 0.5 ? 1 : 0));

            return {
                ...prev,
                problemsSolved: newSolved,
                // masteryRate is now derived from getCourseMastery in UI, but we keep this for legacy or specific use
                masteryRate: prev.masteryRate,
                studyHours: newStudyHours,
                percentile: newPercentile
            };
        });

        // 2. Add Activity
        const newActivity: Activity = {
            id: Date.now(),
            type: 'practice',
            title: `Practice: ${topic.includes('_') ? topic.split('_')[1] : topic}`, // Clean title for display
            description: `Solved ${correct}/${total} problems correctly.`,
            timestamp: 'Just now',
            score: Math.round((correct / total) * 100)
        };
        setActivities(prev => [newActivity, ...prev]);

        // 3. Update Radar Data for Topic
        // Note: The 'topic' string passed here must match 'subject' in radarData (e.g., 'Limits', not 'AB_Limits')
        // QuestionCreator and Practice logic ensure we pass the clean name.
        setRadarData(prev => prev.map(item => {
            const cleanIncoming = topic.includes('_') ? topic.split('_')[1] : topic;
            let expectedLabel = '';
            if (cleanIncoming.includes('Limits')) expectedLabel = 'Unit 1';
            else if (cleanIncoming.includes('Derivatives')) expectedLabel = 'Unit 2';
            else if (cleanIncoming.includes('Composite')) expectedLabel = 'Unit 3';
            else if (cleanIncoming.includes('Applications')) expectedLabel = 'Unit 4';
            else if (cleanIncoming.includes('Analytical')) expectedLabel = 'Unit 5';
            else if (cleanIncoming.includes('Integration')) expectedLabel = 'Unit 6';
            else if (cleanIncoming.includes('DiffEq')) expectedLabel = 'Unit 7';
            else if (cleanIncoming.includes('AppIntegration')) expectedLabel = 'Unit 8';
            else if (cleanIncoming.includes('Unit9') || cleanIncoming.includes('Parametric')) expectedLabel = 'Unit 9';
            else if (cleanIncoming.includes('Series')) expectedLabel = 'Unit 10';

            if (item.subject === expectedLabel) {
                // Return item as is, but we could do a local update if we wanted.
                // However, the user wants accuracy, so we rely on fetchRadarData which is called later.
                return item;
            }
            return item;
        }));

        // 4. Update Line Chart
        setLineData(prev => {
            const newData = [...prev];
            const lastEntry = newData[newData.length - 1];
            // Bump today's value based on activity
            newData[newData.length - 1] = { ...lastEntry, value: Math.min(100, lastEntry.value + 5) };
            return newData;
        });

        // 5. Update Course Status (Just ensure it's 'In Progress')
        setCourses(prev => {
            const courseId = user.currentCourse;
            return {
                ...prev,
                [courseId]: {
                    ...prev[courseId],
                    status: 'In Progress'
                }
            };
        });

        // 6. Refresh Radar/Mastery from Database to ensure accuracy
        // 6. Refresh Radar/Mastery from Database to ensure accuracy
        fetchRadarData();
        fetchLineData();
        fetchRecentActivities();
    };

    return (
        <AppContext.Provider value={{
            user,
            isAuthenticated,
            isAuthLoading,
            activities,
            radarData,
            lineData,
            accuracyHistory,
            courses,
            recommendation,
            hasDismissedLoginPrompt,
            questions,
            notifications,
            isCreatorAuthenticated,
            topicContent,
            skills,
            sections,
            userInsights,
            reviewQueue,
            login,
            logout,
            toggleCourse,
            startCourse,
            updateUser,
            completePractice,
            setSessionMode,
            dismissLoginPrompt,
            availableTitles,
            addQuestion,
            updateQuestion,
            deleteQuestion,
            updateTopic,
            updateSection,
            verifyAccessCode,
            markAllNotificationsRead,
            markNotificationRead,
            getCourseMastery,
            getSectionsForTopic,
            fetchSections,
            fetchQuestions,
            submitAttempt,
            getUserInsights,
            getReviewQueue,
            toggleQuestionStarred,
            toggleQuestionFlagged,
            getTopicProgress,
            saveSectionProgress,
            completeSectionSession,
            getUnitProgress,
            getCourseProgress,
            getSectionProgress,
            getTopicSectionProgress,
            fetchAllUserProgress,
            sectionProgressMap,
            getSectionStatus,
            getSectionProgressData,
            resetSectionProgress,
            sectionTimes,
            incorrectQuestionIds,
            fetchIncorrectQuestions,
            diagSupabase,
            logUserActivity,
            getUserActivities,
            fetchAccuracyHistory,
            friendIds,
            fetchFriends,
            newlyUnlockedTitle,
            setNewlyUnlockedTitle,
            isPro,
            claimFreePro,
            markProIntroSeen,
            showPaywall,
            setShowPaywall,
            unreadCounts,
            clearUnread,
            // Points Economy
            userPoints,
            pointsBalanceRef,
            awardPoints,
            triggerCoinAnimation,
            redeemProWithPoints,
            performDailyCheckin,
            recordLoginStreak,
            getCheckinStatus,
            fetchUserPoints,
            recentPointsTransaction,
            isStreakModalOpen,
            setIsStreakModalOpen,

            checkinStatus,
            refreshCheckinStatus,
            proUpgradeDismissed,
            dismissProUpgrade,
            // Prestige
            userPrestige,
            fetchUserPrestige,
            purchaseStardust,
            injectStardust
        }}>
            {children}
        </AppContext.Provider>
    );
};

export const useApp = () => {
    const context = useContext(AppContext);
    if (context === undefined) {
        throw new Error('useApp must be used within an AppProvider');
    }
    return context;
};
