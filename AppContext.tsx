import React, { createContext, useContext, useState, useEffect, ReactNode } from 'react';
import { User, CourseType, Activity, TopicMastery, CourseState, Recommendation, SessionMode, Question, AppNotification, UnitContent, SubTopic } from './types';
import { INITIAL_USER, INITIAL_ACTIVITIES, INITIAL_RADAR_DATA, INITIAL_LINE_DATA, INITIAL_COURSES, PRACTICE_QUESTIONS, INITIAL_NOTIFICATIONS, COURSE_CONTENT_DATA } from './constants';
import { supabase } from './src/services/supabaseClient';
import { notificationsApi, contentApi, questionsApi, sectionsApi } from './src/services/api';

interface AppContextType {
    user: User;
    isAuthenticated: boolean;
    activities: Activity[];
    radarData: TopicMastery[];
    lineData: { day: string; value: number }[];
    courses: Record<CourseType, CourseState>;
    recommendation: Recommendation;
    hasDismissedLoginPrompt: boolean;
    questions: Question[]; // Dynamic Question Bank
    notifications: AppNotification[]; // Global Notifications
    isCreatorAuthenticated: boolean; // Creator Access State
    topicContent: Record<string, UnitContent>; // Dynamic Content Data
    skills: { id: string; name: string; unit: string; prerequisites: string[] }[]; // Skills for Question Editor
    sections: Record<string, any[]>; // Sections by topic_id for Chapter Settings

    login: (email: string, username?: string, id?: string) => void;
    logout: () => Promise<void>;
    toggleCourse: (course: CourseType) => void;
    startCourse: (course: CourseType) => void;
    updateUser: (updates: Partial<User>) => void;
    completePractice: (results: { correct: number; total: number; topic: string }) => void;
    setSessionMode: (mode: SessionMode) => void;
    dismissLoginPrompt: () => void;

    // Creator Area Methods
    addQuestion: (q: Omit<Question, 'id' | 'options'> & { options: { label: string; value: string }[] }) => void;
    updateQuestion: (q: Question) => void;
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
    const [user, setUser] = useState<User>(INITIAL_USER);
    const [isAuthenticated, setIsAuthenticated] = useState(false); // Default to false for secure start
    const [isAuthLoading, setIsAuthLoading] = useState(true);
    // Initialize from localStorage so the prompt state persists across page refreshes
    // Use sessionStorage so popup appears once per browser session (closing tab resets it)
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
    const [lineData, setLineData] = useState(INITIAL_LINE_DATA);
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

    // Algorithmic Recommendation State - Initial State for New User
    const [recommendation, setRecommendation] = useState<Recommendation>({
        topic: 'Limits',
        reason: 'Start your AP Calculus journey with the fundamentals.',
        currentMastery: 0,
        targetMastery: 80,
        mode: 'Adaptive'
    });

    // Fetch all sections from database
    const fetchSections = async () => {
        try {
            console.log('🔄 Fetching sections...');
            const data = await sectionsApi.getSections();
            // Group by topic_id
            const grouped: Record<string, any[]> = {};
            data.forEach((section: any) => {
                if (!grouped[section.topic_id]) {
                    grouped[section.topic_id] = [];
                }
                grouped[section.topic_id].push(section);
            });
            setSections(grouped);
            console.log(`✅ Loaded ${data.length} sections`);
        } catch (error) {
            console.error('Failed to fetch sections:', error);
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
                setTopicContent(data);
                console.log('✅ Content synced from backend');
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
            const data = await questionsApi.getQuestions();
            if (data && data.length > 0) {
                // Merge with static questions, preferring DB versions for duplicates
                setQuestions(prev => {
                    const dbQuestionIds = new Set(data.map(q => q.id));
                    const staticOnly = prev.filter(q => !dbQuestionIds.has(q.id));
                    return [...data, ...staticOnly];
                });
                console.log('✅ Questions loaded from DB:', data.length);
            } else {
                console.log('ℹ️ No questions in DB, using static data');
            }
        } catch (error) {
            console.error('Failed to fetch questions:', error);
            // Keep static questions as fallback
        }
    };

    const markAllNotificationsRead = async () => {
        setNotifications(prev => prev.map(n => ({ ...n, unread: false })));
        try {
            await notificationsApi.markAllAsRead();
        } catch (error) {
            console.error('Failed to mark all read:', error);
        }
    };

    const markNotificationRead = async (id: number) => {
        setNotifications(prev => prev.map(n => n.id === id ? ({ ...n, unread: false }) : n));
        try {
            await notificationsApi.markAsRead(id);
        } catch (error) {
            console.error('Failed to mark read:', error);
        }
    };

    // Calculate Course Mastery dynamically from Radar Data
    const getCourseMastery = (courseType: CourseType) => {
        // Define which topics belong to which course
        // AB uses Units 1-8. BC uses Units 1-10.
        // Mapping radarData subjects to Units:
        const abTopics = ['Limits', 'Derivatives', 'Composite', 'Contextual Applications', 'Analytical Applications', 'Integration', 'Diff Eq', 'App of Int'];
        const bcTopics = [...abTopics, 'Parametric/Polar', 'Series'];

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
                    const name = session.user.user_metadata?.name || email.split('@')[0];
                    // Fetch full profile to get is_creator status
                    const { data: profile } = await supabase
                        .from('user_profiles')
                        .select('is_creator')
                        .eq('id', session.user.id)
                        .single();

                    const isSuperAdmin = email === 'newmao6120@gmail.com';

                    setIsAuthenticated(true);
                    setUser(prev => ({
                        ...prev,
                        id: session.user.id,
                        name: name.charAt(0).toUpperCase() + name.slice(1),
                        email: email,
                        avatarUrl: `https://ui-avatars.com/api/?name=${encodeURIComponent(name)}&background=f9d406&color=1c1a0d&bold=true`,
                        isCreator: isSuperAdmin || profile?.is_creator || false
                    }));
                    console.log('✅ Session restored for:', email);
                    fetchNotifications(); // Fetch notifications on restore
                    fetchContent(); // Fetch dynamic content on restore
                    fetchSkills(); // Fetch skills for Question Editor
                    fetchSections(); // Fetch sections for Chapter Settings
                    fetchQuestions(); // Fetch questions from DB for Practice
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
            }
        });

        return () => subscription.unsubscribe();
    }, []);

    // Effect: Update recommendation when course changes
    useEffect(() => {
        // ... (existing recommendation logic)
    }, [user.currentCourse, user.problemsSolved]);

    const login = (email: string, username?: string, id?: string) => {
        setIsAuthenticated(true);
        // Use username if provided, otherwise derive from email
        const displayName = username || email.split('@')[0];
        const formattedName = displayName.charAt(0).toUpperCase() + displayName.slice(1);

        const isSuperAdmin = email === 'newmao6120@gmail.com';

        setUser(prev => ({
            ...prev,
            id: id || prev.id || '', // Use provided ID, or keep existing, or empty
            name: formattedName || "Student",
            email: email,
            avatarUrl: `https://ui-avatars.com/api/?name=${encodeURIComponent(formattedName || 'Student')}&background=f9d406&color=1c1a0d&bold=true`,
            isCreator: isSuperAdmin || prev.isCreator //Preserve existing or auto-grant
        }));
        fetchNotifications(); // Synced on login
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
        localStorage.removeItem('auth_token'); // Clear auth token
        setUser(INITIAL_USER); // Reset to empty on logout
    };

    const toggleCourse = (course: CourseType) => {
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
    };

    const updateUser = (updates: Partial<User>) => {
        setUser(prev => {
            const newState = { ...prev, ...updates };
            // If name is being updated, regenerate avatar
            if (updates.name) {
                const displayName = updates.name;
                newState.avatarUrl = `https://ui-avatars.com/api/?name=${encodeURIComponent(displayName)}&background=f9d406&color=1c1a0d&bold=true`;
            }
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
    const addQuestion = async (q: Omit<Question, 'id' | 'options'> & { options: { label: string; value: string }[] }) => {
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
        } catch (error) {
            console.error('Failed to create question:', error);
            alert('Failed to save question. Please try again.');
            return false;
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
        } catch (error) {
            console.error('Failed to update question:', error);
            alert('Failed to update question. Please try again.');
            return false;
        }
    };

    const deleteQuestion = async (id: string) => {
        try {
            // Optimistic delete
            setQuestions(prev => prev.filter(q => q.id !== id));

            // Call backend API to delete from Supabase
            await questionsApi.deleteQuestion(id);
            await questionsApi.deleteQuestion(id);
            console.log('✅ Question deleted from Supabase:', id);
            return true;
        } catch (error) {
            console.error('Failed to delete question:', error);
            alert('Failed to delete question. Please check connection.');
            return false;
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
            // Robust matching: Check exact match OR match against cleaned version if prefix exists
            const cleanIncoming = topic.includes('_') ? topic.split('_')[1] : topic;

            let match = item.subject === cleanIncoming;
            // Fallback fuzzy matching for complex names
            if (cleanIncoming.includes('Derivatives') && item.subject === 'Derivatives') match = true;
            if (cleanIncoming.includes('Integration') && !cleanIncoming.includes('App') && item.subject === 'Integration') match = true;

            if (match) {
                // Calculate gain based on performance
                const currentScore = item.A;
                const accuracy = correct / total;

                // Logic: High accuracy increases score, low accuracy decreases slightly or stays same
                let gain = 0;
                if (accuracy === 1) gain = 15;
                else if (accuracy >= 0.8) gain = 10;
                else if (accuracy >= 0.5) gain = 5;
                else gain = 0; // Don't punish too hard in this demo

                return { ...item, A: Math.min(100, currentScore + gain) };
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

        // 6. Update Recommendation Metric
        // Check against both raw and clean topic
        const cleanTopic = topic.includes('_') ? topic.split('_')[1] : topic;
        if (topic === recommendation.topic || cleanTopic === recommendation.topic) {
            setRecommendation(prev => ({
                ...prev,
                currentMastery: Math.min(prev.targetMastery, prev.currentMastery + 15),
                reason: 'Great start! Keep practicing to build consistency.'
            }));
        }
    };

    return (
        <AppContext.Provider value={{
            user,
            isAuthenticated,
            isAuthLoading,
            activities,
            radarData,
            lineData,
            courses,
            recommendation,
            hasDismissedLoginPrompt,
            questions,
            notifications,
            isCreatorAuthenticated,
            topicContent,
            skills,
            sections,
            login,
            logout,
            toggleCourse,
            startCourse,
            updateUser,
            completePractice,
            setSessionMode,
            dismissLoginPrompt,
            addQuestion,
            updateQuestion,
            deleteQuestion,
            updateTopic,
            updateSection,
            verifyAccessCode,
            markAllNotificationsRead,
            markNotificationRead,
            getCourseMastery,
            getSectionsForTopic
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
