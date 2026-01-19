import React, { useEffect, useState } from 'react';
import { useApp } from '../AppContext';
import { useNavigate } from 'react-router-dom';
import { Navbar } from '../components/Navbar';
import { UserInsights, UserSkillMastery, UserErrorStat, QuestionRecommendation, ReviewQueueItem } from '../types';

export const Insights = () => {
    const { user, isAuthenticated, getUserInsights, getReviewQueue, userInsights } = useApp();
    const navigate = useNavigate();
    const [loading, setLoading] = useState(true);
    const [insights, setInsights] = useState<UserInsights | null>(null);

    useEffect(() => {
        if (!isAuthenticated) {
            navigate('/login');
            return;
        }

        const fetchData = async () => {
            setLoading(true);
            const data = await getUserInsights();
            setInsights(data);
            setLoading(false);
        };

        fetchData();
    }, [isAuthenticated]);

    if (loading) {
        return (
            <div className="min-h-screen bg-surface-light dark:bg-surface-dark">
                <Navbar />
                <div className="flex items-center justify-center h-[80vh]">
                    <div className="animate-spin rounded-full h-12 w-12 border-4 border-primary border-t-transparent"></div>
                </div>
            </div>
        );
    }

    const stats = insights?.stats;
    const weakSkills = insights?.weakSkills || [];
    const topErrors = insights?.topErrors || [];
    const recommendations = insights?.recommendations || [];
    const reviewQueue = insights?.reviewQueue || [];

    return (
        <div className="min-h-screen bg-surface-light dark:bg-surface-dark">
            <Navbar />

            <div className="max-w-7xl mx-auto px-4 py-8">
                {/* Header */}
                <div className="mb-8">
                    <h1 className="text-3xl font-bold text-text-main dark:text-white flex items-center gap-3">
                        <span className="material-symbols-outlined text-4xl text-primary">psychology</span>
                        Your Learning Insights
                    </h1>
                    <p className="text-gray-600 dark:text-gray-400 mt-2">
                        Personalized analytics powered by your practice history
                    </p>
                </div>

                {/* Stats Overview */}
                <div className="grid grid-cols-2 md:grid-cols-4 gap-4 mb-8">
                    <StatCard
                        icon="assignment_turned_in"
                        label="Total Attempts"
                        value={stats?.totalAttempts || 0}
                        color="blue"
                    />
                    <StatCard
                        icon="check_circle"
                        label="Accuracy Rate"
                        value={`${stats?.accuracyRate?.toFixed(1) || 0}%`}
                        color="green"
                    />
                    <StatCard
                        icon="local_fire_department"
                        label="Day Streak"
                        value={stats?.currentStreakDays || 0}
                        color="orange"
                    />
                    <StatCard
                        icon="timer"
                        label="Total Study Time"
                        value={`${stats?.totalTimeMinutes || 0}m`}
                        color="purple"
                    />
                </div>

                {/* Main Content Grid */}
                <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">

                    {/* Weak Skills */}
                    <div className="bg-white dark:bg-white/5 rounded-2xl p-6 border border-gray-200 dark:border-white/10">
                        <h2 className="text-lg font-bold text-text-main dark:text-white flex items-center gap-2 mb-4">
                            <span className="material-symbols-outlined text-red-500">trending_down</span>
                            Skills to Improve
                        </h2>
                        {weakSkills.length === 0 ? (
                            <p className="text-gray-500 dark:text-gray-400 text-center py-8">
                                Complete more practice sessions to discover your weak areas
                            </p>
                        ) : (
                            <div className="space-y-3">
                                {weakSkills.map((skill, idx) => (
                                    <SkillBar key={skill.skillId} skill={skill} rank={idx + 1} />
                                ))}
                            </div>
                        )}
                    </div>

                    {/* Top Errors */}
                    <div className="bg-white dark:bg-white/5 rounded-2xl p-6 border border-gray-200 dark:border-white/10">
                        <h2 className="text-lg font-bold text-text-main dark:text-white flex items-center gap-2 mb-4">
                            <span className="material-symbols-outlined text-amber-500">error</span>
                            Common Mistakes
                        </h2>
                        {topErrors.length === 0 ? (
                            <p className="text-gray-500 dark:text-gray-400 text-center py-8">
                                No error patterns detected yet
                            </p>
                        ) : (
                            <div className="space-y-3">
                                {topErrors.map((error, idx) => (
                                    <ErrorCard key={error.errorTagId} error={error} rank={idx + 1} />
                                ))}
                            </div>
                        )}
                    </div>

                    {/* Recommendations */}
                    <div className="bg-white dark:bg-white/5 rounded-2xl p-6 border border-gray-200 dark:border-white/10">
                        <h2 className="text-lg font-bold text-text-main dark:text-white flex items-center gap-2 mb-4">
                            <span className="material-symbols-outlined text-primary">lightbulb</span>
                            Recommended Practice
                        </h2>
                        {recommendations.length === 0 ? (
                            <p className="text-gray-500 dark:text-gray-400 text-center py-8">
                                Complete a few practice sessions to get personalized recommendations
                            </p>
                        ) : (
                            <div className="space-y-3">
                                {recommendations.slice(0, 5).map((rec, idx) => (
                                    <RecommendationCard key={rec.questionId} rec={rec} />
                                ))}
                            </div>
                        )}
                    </div>

                    {/* Review Queue */}
                    <div className="bg-white dark:bg-white/5 rounded-2xl p-6 border border-gray-200 dark:border-white/10">
                        <h2 className="text-lg font-bold text-text-main dark:text-white flex items-center gap-2 mb-4">
                            <span className="material-symbols-outlined text-blue-500">schedule</span>
                            Spaced Repetition Queue
                        </h2>
                        {reviewQueue.length === 0 ? (
                            <p className="text-gray-500 dark:text-gray-400 text-center py-8">
                                No questions due for review
                            </p>
                        ) : (
                            <div className="space-y-3">
                                {reviewQueue.slice(0, 5).map((item, idx) => (
                                    <ReviewQueueCard key={item.questionId} item={item} />
                                ))}
                            </div>
                        )}
                    </div>
                </div>
            </div>
        </div>
    );
};

// --- Helper Components ---

const StatCard = ({ icon, label, value, color }: { icon: string; label: string; value: string | number; color: string }) => {
    const colorClasses: Record<string, string> = {
        blue: 'bg-blue-50 dark:bg-blue-900/20 text-blue-600 dark:text-blue-400',
        green: 'bg-green-50 dark:bg-green-900/20 text-green-600 dark:text-green-400',
        orange: 'bg-orange-50 dark:bg-orange-900/20 text-orange-600 dark:text-orange-400',
        purple: 'bg-purple-50 dark:bg-purple-900/20 text-purple-600 dark:text-purple-400',
    };

    return (
        <div className="bg-white dark:bg-white/5 rounded-2xl p-5 border border-gray-200 dark:border-white/10">
            <div className={`w-10 h-10 rounded-xl flex items-center justify-center mb-3 ${colorClasses[color]}`}>
                <span className="material-symbols-outlined">{icon}</span>
            </div>
            <div className="text-2xl font-bold text-text-main dark:text-white">{value}</div>
            <div className="text-sm text-gray-500 dark:text-gray-400">{label}</div>
        </div>
    );
};

const SkillBar = ({ skill, rank }: { skill: UserSkillMastery; rank: number }) => {
    const masteryColor = skill.mastery < 40 ? 'bg-red-500' : skill.mastery < 70 ? 'bg-amber-500' : 'bg-green-500';

    return (
        <div className="flex items-center gap-3">
            <div className="w-6 h-6 rounded-full bg-gray-100 dark:bg-white/10 flex items-center justify-center text-xs font-bold text-gray-600 dark:text-gray-400">
                {rank}
            </div>
            <div className="flex-1">
                <div className="flex justify-between items-center mb-1">
                    <span className="text-sm font-medium text-text-main dark:text-white">{skill.skillName}</span>
                    <span className="text-xs text-gray-500 dark:text-gray-400">{skill.mastery?.toFixed(0)}%</span>
                </div>
                <div className="h-2 bg-gray-100 dark:bg-white/10 rounded-full overflow-hidden">
                    <div
                        className={`h-full ${masteryColor} rounded-full transition-all`}
                        style={{ width: `${Math.min(100, skill.mastery)}%` }}
                    />
                </div>
            </div>
        </div>
    );
};

const ErrorCard = ({ error, rank }: { error: UserErrorStat; rank: number }) => {
    return (
        <div className="flex items-center gap-3 p-3 bg-gray-50 dark:bg-white/5 rounded-xl">
            <div className="w-8 h-8 rounded-full bg-red-100 dark:bg-red-900/30 flex items-center justify-center">
                <span className="text-red-600 dark:text-red-400 text-sm font-bold">{rank}</span>
            </div>
            <div className="flex-1">
                <div className="font-medium text-text-main dark:text-white text-sm">{error.errorName}</div>
                <div className="text-xs text-gray-500 dark:text-gray-400 capitalize">{error.category} error</div>
            </div>
            <div className="bg-red-100 dark:bg-red-900/30 text-red-600 dark:text-red-400 px-2 py-1 rounded-full text-xs font-bold">
                {error.count}x
            </div>
        </div>
    );
};

const RecommendationCard = ({ rec }: { rec: QuestionRecommendation }) => {
    const reasonLabels: Record<string, { label: string; color: string }> = {
        low_mastery: { label: 'Weak Skill', color: 'bg-red-100 text-red-600 dark:bg-red-900/30 dark:text-red-400' },
        spaced_review: { label: 'Review Due', color: 'bg-blue-100 text-blue-600 dark:bg-blue-900/30 dark:text-blue-400' },
        challenge: { label: 'Challenge', color: 'bg-purple-100 text-purple-600 dark:bg-purple-900/30 dark:text-purple-400' },
    };

    const reasonInfo = reasonLabels[rec.reason] || { label: rec.reason, color: 'bg-gray-100 text-gray-600' };

    return (
        <div className="p-3 bg-gray-50 dark:bg-white/5 rounded-xl border border-gray-100 dark:border-white/5">
            <div className="flex items-center gap-2 mb-2">
                <span className={`px-2 py-0.5 rounded-full text-xs font-bold ${reasonInfo.color}`}>
                    {reasonInfo.label}
                </span>
            </div>
            <p className="text-sm text-gray-600 dark:text-gray-400">{rec.reasonDetail}</p>
        </div>
    );
};

const ReviewQueueCard = ({ item }: { item: ReviewQueueItem }) => {
    const isOverdue = item.isOverdue;

    return (
        <div className={`p-3 rounded-xl border ${isOverdue ? 'bg-red-50 dark:bg-red-900/10 border-red-200 dark:border-red-900/30' : 'bg-gray-50 dark:bg-white/5 border-gray-100 dark:border-white/5'}`}>
            <div className="flex items-center justify-between">
                <div className="flex items-center gap-2">
                    <span className={`material-symbols-outlined text-lg ${isOverdue ? 'text-red-500' : 'text-blue-500'}`}>
                        {isOverdue ? 'warning' : 'schedule'}
                    </span>
                    <span className="text-sm font-medium text-text-main dark:text-white">
                        {item.questionTopic || 'Question'}
                    </span>
                </div>
                <div className="flex items-center gap-2">
                    <span className="text-xs text-gray-500 dark:text-gray-400">
                        Review #{item.reviewCount + 1}
                    </span>
                    {isOverdue && (
                        <span className="px-2 py-0.5 rounded-full text-xs font-bold bg-red-100 text-red-600 dark:bg-red-900/30 dark:text-red-400">
                            Overdue
                        </span>
                    )}
                </div>
            </div>
        </div>
    );
};
