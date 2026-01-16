/**
 * API Integration Hooks
 * Provides hooks for integrating with the backend API while maintaining
 * backward compatibility with the mock implementation.
 */

import { useState, useCallback, useEffect } from 'react';
import api, { authApi, usersApi, questionsApi, practiceApi, progressApi, contentApi, notificationsApi, checkApiHealth } from './api';
import supabase from './supabaseClient';

// Check if API/Supabase is configured
const isApiConfigured = () => {
    const supabaseUrl = import.meta.env.VITE_SUPABASE_URL;
    return supabaseUrl && supabaseUrl !== 'your_supabase_project_url';
};

/**
 * Hook for authentication state management with Supabase
 */
export function useAuth() {
    const [session, setSession] = useState<any>(null);
    const [loading, setLoading] = useState(true);
    const [isOnline, setIsOnline] = useState(false);

    useEffect(() => {
        // Check API availability
        checkApiHealth().then(setIsOnline);

        if (!isApiConfigured()) {
            setLoading(false);
            return;
        }

        // Get initial session
        supabase.auth.getSession().then(({ data: { session } }) => {
            setSession(session);
            if (session) {
                localStorage.setItem('auth_token', session.access_token);
            }
            setLoading(false);
        });

        // Listen for auth changes
        const { data: { subscription } } = supabase.auth.onAuthStateChange(
            async (event, session) => {
                setSession(session);
                if (session) {
                    localStorage.setItem('auth_token', session.access_token);
                } else {
                    localStorage.removeItem('auth_token');
                }
            }
        );

        return () => subscription.unsubscribe();
    }, []);

    const signIn = useCallback(async (email: string, password: string) => {
        if (!isApiConfigured()) {
            // Offline mode - just return success
            return { success: true, offline: true };
        }

        try {
            const { data, error } = await supabase.auth.signInWithPassword({
                email,
                password
            });

            if (error) throw error;

            localStorage.setItem('auth_token', data.session?.access_token || '');
            return { success: true, user: data.user, session: data.session };
        } catch (error: any) {
            return { success: false, error: error.message };
        }
    }, []);

    const signUp = useCallback(async (email: string, password: string, name: string) => {
        if (!isApiConfigured()) {
            return { success: true, offline: true };
        }

        try {
            const { data, error } = await supabase.auth.signUp({
                email,
                password,
                options: {
                    data: { name }
                }
            });

            if (error) throw error;

            return { success: true, user: data.user, session: data.session };
        } catch (error: any) {
            return { success: false, error: error.message };
        }
    }, []);

    const signOut = useCallback(async () => {
        if (!isApiConfigured()) {
            return { success: true };
        }

        try {
            const { error } = await supabase.auth.signOut();
            if (error) throw error;
            localStorage.removeItem('auth_token');
            return { success: true };
        } catch (error: any) {
            return { success: false, error: error.message };
        }
    }, []);

    return {
        session,
        loading,
        isOnline,
        isAuthenticated: !!session,
        user: session?.user,
        signIn,
        signUp,
        signOut,
        isConfigured: isApiConfigured()
    };
}

/**
 * Hook for syncing data with the backend
 */
export function useDataSync() {
    const [syncing, setSyncing] = useState(false);
    const [lastSyncError, setLastSyncError] = useState<string | null>(null);

    const syncUserData = useCallback(async () => {
        if (!isApiConfigured()) {
            return null;
        }

        setSyncing(true);
        setLastSyncError(null);

        try {
            const data = await usersApi.getFullUserData();
            setSyncing(false);
            return data;
        } catch (error: any) {
            setLastSyncError(error.message);
            setSyncing(false);
            return null;
        }
    }, []);

    const syncQuestions = useCallback(async (params?: any) => {
        if (!isApiConfigured()) {
            return null;
        }

        try {
            return await questionsApi.getQuestions(params);
        } catch (error: any) {
            console.error('Failed to sync questions:', error);
            return null;
        }
    }, []);

    const syncTopicContent = useCallback(async () => {
        if (!isApiConfigured()) {
            return null;
        }

        try {
            return await contentApi.getTopics();
        } catch (error: any) {
            console.error('Failed to sync topic content:', error);
            return null;
        }
    }, []);

    return {
        syncing,
        lastSyncError,
        syncUserData,
        syncQuestions,
        syncTopicContent,
        isConfigured: isApiConfigured()
    };
}

/**
 * Hook for practice operations with backend sync
 */
export function usePracticeSync() {
    const completePractice = useCallback(async (data: { correct: number; total: number; topic: string }) => {
        if (!isApiConfigured()) {
            return { success: true, offline: true };
        }

        try {
            const result = await practiceApi.completePractice(data);
            return { success: true, ...result };
        } catch (error: any) {
            return { success: false, error: error.message };
        }
    }, []);

    const getRecommendation = useCallback(async () => {
        if (!isApiConfigured()) {
            return null;
        }

        try {
            return await practiceApi.getRecommendation();
        } catch (error: any) {
            console.error('Failed to get recommendation:', error);
            return null;
        }
    }, []);

    return {
        completePractice,
        getRecommendation,
        isConfigured: isApiConfigured()
    };
}

/**
 * Hook for question management with backend sync
 */
export function useQuestionSync() {
    const createQuestion = useCallback(async (question: any) => {
        if (!isApiConfigured()) {
            return { success: true, offline: true };
        }

        try {
            const result = await questionsApi.createQuestion(question);
            return { success: true, question: result };
        } catch (error: any) {
            return { success: false, error: error.message };
        }
    }, []);

    const updateQuestion = useCallback(async (id: string, updates: any) => {
        if (!isApiConfigured()) {
            return { success: true, offline: true };
        }

        try {
            const result = await questionsApi.updateQuestion(id, updates);
            return { success: true, question: result };
        } catch (error: any) {
            return { success: false, error: error.message };
        }
    }, []);

    const deleteQuestion = useCallback(async (id: string) => {
        if (!isApiConfigured()) {
            return { success: true, offline: true };
        }

        try {
            await questionsApi.deleteQuestion(id);
            return { success: true };
        } catch (error: any) {
            return { success: false, error: error.message };
        }
    }, []);

    return {
        createQuestion,
        updateQuestion,
        deleteQuestion,
        isConfigured: isApiConfigured()
    };
}

/**
 * Hook for notifications with backend sync
 */
export function useNotificationsSync() {
    const markAsRead = useCallback(async (id: number) => {
        if (!isApiConfigured()) {
            return { success: true, offline: true };
        }

        try {
            await notificationsApi.markAsRead(id);
            return { success: true };
        } catch (error: any) {
            return { success: false, error: error.message };
        }
    }, []);

    const markAllAsRead = useCallback(async () => {
        if (!isApiConfigured()) {
            return { success: true, offline: true };
        }

        try {
            await notificationsApi.markAllAsRead();
            return { success: true };
        } catch (error: any) {
            return { success: false, error: error.message };
        }
    }, []);

    return {
        markAsRead,
        markAllAsRead,
        isConfigured: isApiConfigured()
    };
}

export default {
    useAuth,
    useDataSync,
    usePracticeSync,
    useQuestionSync,
    useNotificationsSync,
    isApiConfigured
};
