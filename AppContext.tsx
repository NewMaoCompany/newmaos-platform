import React, { createContext, useContext, useState, useEffect, ReactNode } from 'react';
import { User, CourseType, Activity, TopicMastery, CourseState, Recommendation, SessionMode, Question, AppNotification, UnitContent, SubTopic } from './types';
import { INITIAL_USER, INITIAL_ACTIVITIES, INITIAL_RADAR_DATA, INITIAL_LINE_DATA, INITIAL_COURSES, PRACTICE_QUESTIONS, INITIAL_NOTIFICATIONS, COURSE_CONTENT_DATA } from './constants';
import { supabase } from './src/services/supabaseClient';

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

    login: (email: string, username?: string) => void;
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
    loginCreator: (password: string) => boolean;

    // Notification Methods
    markAllNotificationsRead: () => void;
    markNotificationRead: (id: number) => void;

    // Helper for Dashboard
    getCourseMastery: (course: CourseType) => number;
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

    // Algorithmic Recommendation State - Initial State for New User
    const [recommendation, setRecommendation] = useState<Recommendation>({
        topic: 'Limits',
        reason: 'Start your AP Calculus journey with the fundamentals.',
        currentMastery: 0,
        targetMastery: 80,
        mode: 'Adaptive'
    });

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
            try {
                const { data: { session } } = await supabase.auth.getSession();
                if (session?.user) {
                    const email = session.user.email || '';
                    const name = session.user.user_metadata?.name || email.split('@')[0];
                    setIsAuthenticated(true);
                    setUser(prev => ({
                        ...prev,
                        name: name.charAt(0).toUpperCase() + name.slice(1),
                        email: email,
                        avatarUrl: `https://ui-avatars.com/api/?name=${encodeURIComponent(name)}&background=f9d406&color=1c1a0d&bold=true`
                    }));
                    console.log('✅ Session restored for:', email);
                }
            } catch (error) {
                console.log('No existing session found');
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
        // If user has no data, keep the generic start message
        const isNewUser = user.problemsSolved === 0;

        if (user.currentCourse === 'AB') {
            setRecommendation(prev => ({
                ...prev,
                topic: 'Limits',
                reason: isNewUser ? 'Start your AP Calculus journey with the fundamentals.' : 'Detected repeated errors in one-sided limits.',
                currentMastery: isNewUser ? 0 : 62,
                targetMastery: 85
            }));
        } else {
            // BC also starts with Limits (Unit 1), Series is Unit 10.
            // Default to Limits for new BC students as well.
            setRecommendation(prev => ({
                ...prev,
                topic: isNewUser ? 'Limits' : 'Series',
                reason: isNewUser ? 'Begin with Unit 1: Limits and Continuity.' : 'Gap detected in Ratio Test application.',
                currentMastery: isNewUser ? 0 : 45,
                targetMastery: 75
            }));
        }
    }, [user.currentCourse, user.problemsSolved]);

    const login = (email: string, username?: string) => {
        setIsAuthenticated(true);
        // Use username if provided, otherwise derive from email
        const displayName = username || email.split('@')[0];
        const formattedName = displayName.charAt(0).toUpperCase() + displayName.slice(1);

        setUser(prev => ({
            ...prev,
            name: formattedName || "Student",
            email: email,
            avatarUrl: `https://ui-avatars.com/api/?name=${encodeURIComponent(formattedName || 'Student')}&background=f9d406&color=1c1a0d&bold=true`
        }));
    };

    const logout = async () => {
        try {
            await supabase.auth.signOut();
        } catch (error) {
            console.error('Error signing out:', error);
        }
        setIsAuthenticated(false);
        setIsCreatorAuthenticated(false); // Reset creator access on logout
        setHasDismissedLoginPrompt(false); // Reset prompt state on logout so next user sees it
        sessionStorage.removeItem('hasDismissedLoginPrompt'); // Also clear from sessionStorage
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
        setUser(prev => ({ ...prev, ...updates }));
    };

    const setSessionMode = (mode: SessionMode) => {
        setRecommendation(prev => ({ ...prev, mode }));
    };

    const dismissLoginPrompt = () => {
        setHasDismissedLoginPrompt(true);
        sessionStorage.setItem('hasDismissedLoginPrompt', 'true');
    };

    // Creator Area Logic - SIMULATING BACKEND BEHAVIOR
    const addQuestion = (q: Omit<Question, 'id' | 'options'> & { options: { label: string; value: string }[] }) => {
        // 1. Generate Main ID
        const newQuestionId = generateUUID();

        // 2. Generate Option IDs and structure
        const processedOptions = q.options.map(opt => ({
            ...opt,
            id: generateUUID() // Generate unique option_id
        }));

        // 3. Auto-fix correctOptionId if it was referring to a label (A/B) instead of the new ID
        // (In a real backend, we'd handle this mapping logic server-side)
        let finalCorrectId = q.correctOptionId;
        if (q.type === 'MCQ') {
            const matchingOpt = processedOptions.find(o => o.label === q.correctOptionId);
            if (matchingOpt) {
                finalCorrectId = matchingOpt.id;
            }
        }

        const finalQuestion: Question = {
            ...q,
            id: newQuestionId,
            options: processedOptions,
            correctOptionId: finalCorrectId
        };

        setQuestions(prev => [...prev, finalQuestion]);
    };

    const updateQuestion = (updatedQ: Question) => {
        setQuestions(prev => prev.map(q => q.id === updatedQ.id ? updatedQ : q));
    };

    const deleteQuestion = (id: string) => {
        setQuestions(prev => prev.filter(q => q.id !== id));
    };

    const updateTopic = (unitId: string, subTopicId: string | null, data: any) => {
        setTopicContent(prev => {
            const next = { ...prev };
            const unit = next[unitId];

            if (!unit) return next;

            if (subTopicId === 'unit_test') {
                // Update Unit Test Config
                // Fallback default if not yet initialized
                const currentConfig = unit.unitTest || {
                    title: 'Unit Test',
                    description: `Comprehensive assessment covering all topics in ${unit.title}.`,
                    estimatedMinutes: 45
                };
                next[unitId] = { ...unit, unitTest: { ...currentConfig, ...data } };
            } else if (subTopicId) {
                // Helper to find and update a subtopic within a unit
                const updateSubInList = (u: UnitContent) => {
                    const idx = u.subTopics.findIndex(s => s.id === subTopicId);
                    if (idx !== -1) {
                        const newSubs = [...u.subTopics];
                        newSubs[idx] = { ...newSubs[idx], ...data };
                        return { ...u, subTopics: newSubs };
                    }
                    return u;
                };

                // 1. Update the specific unit requested
                next[unitId] = updateSubInList(unit);

                // 2. Propagate to other units that might share this subtopic ID (e.g. AB_Limits and BC_Limits share '1.1')
                for (const key in next) {
                    if (key !== unitId) {
                        next[key] = updateSubInList(next[key]);
                    }
                }
            } else {
                // Update Unit metadata itself (title, description)
                next[unitId] = { ...unit, ...data };
            }

            return next;
        });
    };

    const loginCreator = (password: string) => {
        if (password === 'CzLjc6120') {
            setIsCreatorAuthenticated(true);
            return true;
        }
        return false;
    };

    // Notification Logic
    const markAllNotificationsRead = () => {
        setNotifications(prev => prev.map(n => ({ ...n, unread: false })));
    };

    const markNotificationRead = (id: number) => {
        setNotifications(prev => prev.map(n => n.id === id ? ({ ...n, unread: false }) : n));
    };

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
            loginCreator,
            markAllNotificationsRead,
            markNotificationRead,
            getCourseMastery
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
