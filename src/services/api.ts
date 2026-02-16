/**
 * API Service
 * Handles all communication with the backend server
 */

// In production, force use of Railway backend to bypass broken Vercel env var or routing
const isProd = import.meta.env.PROD || window.location.hostname !== 'localhost';
const API_BASE_URL = import.meta.env.VITE_API_URL || (isProd ? 'https://cheerful-patience-production-206d.up.railway.app/api' : 'http://localhost:4005/api');

// Helper to get auth token from Supabase session
const getAuthToken = (): string | null => {
    // Supabase v2 stores session with a key like: sb-<project-ref>-auth-token
    // We need to find it dynamically
    for (let i = 0; i < localStorage.length; i++) {
        const key = localStorage.key(i);
        if (key && key.includes('-auth-token')) {
            try {
                const session = localStorage.getItem(key);
                if (session) {
                    const parsed = JSON.parse(session);
                    // Supabase v2 format
                    if (parsed.access_token) {
                        return parsed.access_token;
                    }
                    // Legacy format
                    if (parsed.currentSession?.access_token) {
                        return parsed.currentSession.access_token;
                    }
                }
            } catch {
                continue;
            }
        }
    }
    // Fallback: check for direct token storage
    return localStorage.getItem('auth_token');
};

// Helper for API requests
async function apiRequest<T>(
    endpoint: string,
    options: RequestInit = {}
): Promise<T> {
    const token = getAuthToken();

    const headers: HeadersInit = {
        'Content-Type': 'application/json',
        ...options.headers,
    };

    if (token) {
        (headers as Record<string, string>)['Authorization'] = `Bearer ${token}`;
    }

    const response = await fetch(`${API_BASE_URL}${endpoint}`, {
        ...options,
        headers,
    });

    if (!response.ok) {
        const error = await response.json().catch(() => ({ error: 'Request failed' }));
        throw new Error(error.error || error.message || 'Request failed');
    }

    return response.json();
}

// =====================================
// Auth API
// =====================================

export const authApi = {
    async register(email: string, password: string, name: string) {
        return apiRequest<{ user: any; session: any; profile: any }>('/auth/register', {
            method: 'POST',
            body: JSON.stringify({ email, password, name }),
        });
    },

    async login(email: string, password: string) {
        return apiRequest<{ user: any; session: any; profile: any }>('/auth/login', {
            method: 'POST',
            body: JSON.stringify({ email, password }),
        });
    },

    async logout() {
        return apiRequest<{ message: string }>('/auth/logout', {
            method: 'POST',
        });
    },

    async forgotPassword(email: string) {
        return apiRequest<{ message: string }>('/auth/forgot-password', {
            method: 'POST',
            body: JSON.stringify({ email }),
        });
    },

    async verifyResetCode(email: string, code: string) {
        return apiRequest<{ success: boolean }>('/auth/verify-reset-code', {
            method: 'POST',
            body: JSON.stringify({ email, code }),
        });
    },

    async resetPassword(email: string, code: string, password: string) {
        return apiRequest<{ message: string; session?: any; user?: any; profile?: any }>('/auth/reset-password', {
            method: 'POST',
            body: JSON.stringify({ email, code, password }),
        });
    },

    async changePassword(userId: string, currentPassword: string, newPassword: string) {
        return apiRequest<{ success: boolean; message: string }>('/auth/change-password', {
            method: 'POST',
            body: JSON.stringify({ userId, currentPassword, newPassword }),
        });
    },

    async verifyCreator(password: string, userId?: string) {
        return apiRequest<{ success: boolean }>('/auth/verify-creator', {
            method: 'POST',
            body: JSON.stringify({ password, userId }),
        });
    },

    async verifyEmail(email: string, code: string) {
        return apiRequest<{ success: boolean; message: string }>('/auth/verify-email', {
            method: 'POST',
            body: JSON.stringify({ email, code }),
        });
    },

    async resendVerification(email: string) {
        return apiRequest<{ message: string }>('/auth/resend-verification', {
            method: 'POST',
            body: JSON.stringify({ email }),
        });
    },

    async initiateChangeEmail(email: string) {
        return apiRequest<{ message: string }>('/auth/initiate-change-email', {
            method: 'POST',
            body: JSON.stringify({ email }),
        });
    },

    async verifyChangeEmail(email: string, code: string, userId: string) {
        return apiRequest<{ success: boolean; message: string }>('/auth/verify-change-email', {
            method: 'POST',
            body: JSON.stringify({ email, code, userId }),
        });
    },
};

// =====================================
// Users API
// =====================================

export const usersApi = {
    async getProfile() {
        return apiRequest<any>('/users/me');
    },

    async updateProfile(updates: { name?: string; avatar_url?: string; current_course?: string }) {
        return apiRequest<any>('/users/me', {
            method: 'PUT',
            body: JSON.stringify(updates),
        });
    },

    async updatePreferences(preferences: { email_notifications?: boolean; sound_effects?: boolean }) {
        return apiRequest<any>('/users/preferences', {
            method: 'PUT',
            body: JSON.stringify(preferences),
        });
    },

    async sendFriendRequest(identifier: string) {
        return apiRequest<{ success: boolean; message: string }>('/users/friend-request', {
            method: 'POST',
            body: JSON.stringify({ identifier }),
        });
    },

    async getFullUserData() {
        return apiRequest<{
            profile: any;
            mastery: any[];
            courseProgress: any[];
            activities: any[];
            notifications: any[];
        }>('/users/full');
    },
};

// =====================================
// Questions API
// =====================================

export const questionsApi = {
    async getQuestions(params?: {
        course?: string;
        topic?: string;
        subTopicId?: string;
        difficulty?: number;
        limit?: number;
    }) {
        const searchParams = new URLSearchParams();
        if (params?.course) searchParams.set('course', params.course);
        if (params?.topic) searchParams.set('topic', params.topic);
        if (params?.subTopicId) searchParams.set('subTopicId', params.subTopicId);
        if (params?.difficulty) searchParams.set('difficulty', String(params.difficulty));
        if (params?.limit) searchParams.set('limit', String(params.limit));

        const queryString = searchParams.toString();
        return apiRequest<any[]>(`/questions${queryString ? `?${queryString}` : ''}`);
    },

    async createQuestion(question: any) {
        return apiRequest<any>('/questions', {
            method: 'POST',
            body: JSON.stringify(question),
        });
    },

    async updateQuestion(id: string, updates: any) {
        return apiRequest<any>(`/questions/${id}`, {
            method: 'PUT',
            body: JSON.stringify(updates),
        });
    },

    async deleteQuestion(id: string) {
        return apiRequest<{ message: string }>(`/questions/${id}`, {
            method: 'DELETE',
        });
    },
};

// =====================================
// Practice API
// =====================================

export const practiceApi = {
    async completePractice(data: { correct: number; total: number; topic: string }) {
        return apiRequest<{ message: string; stats: any }>('/practice/complete', {
            method: 'POST',
            body: JSON.stringify(data),
        });
    },

    async getRecommendation() {
        return apiRequest<{
            topic: string;
            reason: string;
            currentMastery: number;
            targetMastery: number;
            mode: string;
        }>('/practice/recommendation');
    },
};

// =====================================
// Progress API
// =====================================

export const progressApi = {
    async getMastery() {
        return apiRequest<{ subject: string; A: number; fullMark: number }[]>('/progress/mastery');
    },

    async getActivities(limit = 20) {
        return apiRequest<any[]>(`/progress/activities?limit=${limit}`);
    },

    async getLineData() {
        return apiRequest<{ day: string; value: number }[]>('/progress/line-data');
    },

    async getCourses() {
        return apiRequest<Record<string, any>>('/progress/courses');
    },
};

// =====================================
// Content API
// =====================================

export const contentApi = {
    async getTopics() {
        return apiRequest<Record<string, any>>('/content/topics');
    },

    async updateTopic(unitId: string, data: any) {
        return apiRequest<any>(`/content/topics/${unitId}`, {
            method: 'PUT',
            body: JSON.stringify(data),
        });
    },

    async updateSubTopic(unitId: string, subTopicId: string, data: any) {
        return apiRequest<any>(`/content/topics/${unitId}/subtopics/${subTopicId}`, {
            method: 'PUT',
            body: JSON.stringify(data),
        });
    },

    async seedContent() {
        return apiRequest<{ message: string; count: number }>('/content/seed', {
            method: 'POST',
        });
    },

    async getSkills() {
        return apiRequest<{ id: string; name: string; unit: string; prerequisites: string[] }[]>('/content/skills');
    },
};

// =====================================
// Sections API
// =====================================

export const sectionsApi = {
    async getSections(topicId?: string) {
        const query = topicId ? `?topicId=${topicId}` : '';
        return apiRequest<any[]>(`/sections${query}`);
    },

    async getSection(topicId: string, sectionId: string) {
        return apiRequest<any>(`/sections/${topicId}/${sectionId}`);
    },

    async updateSection(topicId: string, sectionId: string, data: any) {
        return apiRequest<any>(`/sections/${topicId}/${sectionId}`, {
            method: 'PUT',
            body: JSON.stringify(data),
        });
    },

    async createSection(data: any) {
        return apiRequest<any>('/sections', {
            method: 'POST',
            body: JSON.stringify(data),
        });
    },
};

// =====================================
// Notifications API
// =====================================

export const notificationsApi = {
    async getNotifications(limit = 50) {
        return apiRequest<any[]>(`/notifications?limit=${limit}`);
    },

    async markAsRead(id: string | number) {
        return apiRequest<{ message: string }>(`/notifications/${id}/read`, {
            method: 'PUT',
        });
    },

    async markAllAsRead() {
        return apiRequest<{ message: string }>('/notifications/read-all', {
            method: 'PUT',
        });
    },

    async acceptFriend(notifId: string | number) {
        return apiRequest<{ success: boolean }>(`/notifications/${notifId}/accept-friend`, {
            method: 'POST',
        });
    },
};

// =====================================
// Health Check
// =====================================

export async function checkApiHealth(): Promise<boolean> {
    try {
        const response = await fetch(`${API_BASE_URL}/health`);
        return response.ok;
    } catch {
        return false;
    }
}

export default {
    auth: authApi,
    users: usersApi,
    questions: questionsApi,
    practice: practiceApi,
    progress: progressApi,
    content: contentApi,
    notifications: notificationsApi,
    upload: {
        async uploadImage(file: File) {
            const formData = new FormData();
            formData.append('image', file);

            // We need to use raw fetch here because apiRequest assumes JSON content-type by default usually, 
            // or we need to update apiRequest to handle FormData. 
            // Let's just use the helper but we need to handle the headers carefully.
            // Actually, if we pass body as FormData, fetch usually sets Content-Type to multipart/form-data automatically 
            // WITH the boundary. If we manually set Content-Type to 'multipart/form-data', it might fail because of missing boundary.
            // So we should probably override the default Content-Type header to undefined/null for this request.

            const token = localStorage.getItem('auth_token') ||
                JSON.parse(localStorage.getItem(Object.keys(localStorage).find(k => k.includes('-auth-token')) || '') || '{}').access_token;

            const res = await fetch(`${import.meta.env.VITE_API_URL || '/api'}/upload/image`, {
                method: 'POST',
                headers: {
                    'Authorization': `Bearer ${token}`
                },
                body: formData
            });

            if (!res.ok) {
                const err = await res.json().catch(() => ({ error: 'Upload failed' }));
                throw new Error(err.error || 'Upload failed');
            }

            return res.json() as Promise<{ url: string; path: string }>;
        }
    },
    checkHealth: checkApiHealth,
};
