import React, { useEffect, useMemo, useState } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import { Navbar } from '../components/Navbar';
import { useApp } from '../AppContext';
import { COURSE_CONTENT_DATA } from '../constants';
import { SubTopicProgress, UserSectionProgress } from '../types';

export const TopicDetail = () => {
    const { unitId } = useParams();
    const navigate = useNavigate();
    const { topicContent } = useApp();

    // Ensure page starts at top when visiting a new unit
    useEffect(() => {
        window.scrollTo(0, 0);
    }, [unitId]);

    // Safety check: if topic doesn't exist in our data, show placeholder or redirect
    const unitContent = unitId ? topicContent[unitId] : null;

    if (!unitContent) {
        return (
            <div className="min-h-screen bg-background-light dark:bg-background-dark text-text-main dark:text-white flex flex-col">
                <Navbar />
                <div className="flex-grow flex flex-col items-center justify-center p-6 text-center">
                    <span className="material-symbols-outlined text-6xl text-gray-300 mb-4">folder_off</span>
                    <h2 className="text-2xl font-bold mb-2">Topic Content Not Found</h2>
                    <p className="text-gray-500 mb-6">The detailed content for this topic is currently being developed.</p>
                    <button onClick={() => navigate('/practice')} className="px-6 py-2 bg-black dark:bg-white text-white dark:text-black rounded-lg font-bold">
                        Back to Hub
                    </button>
                </div>
            </div>
        );
    }

    const handleSubTopicClick = (subTopicId: string) => {
        navigate('/practice/session', {
            state: {
                topic: unitId, // Pass the ID (e.g. AB_Limits) instead of title
                subTopicId: subTopicId,   // Specific sub-topic
                mode: 'Adaptive'
            }
        });
    };

    // Use dynamic Unit Test config or fall back to defaults
    const unitTestConfig = unitContent.unitTest || {
        title: 'Unit Test',
        description: `Comprehensive assessment covering all topics in ${unitContent.title}.`,
        estimatedMinutes: 45
    };

    // Use COURSE_CONTENT_DATA as fallback when DB subTopics is empty
    const subTopics = useMemo(() => {
        if (unitContent.subTopics && unitContent.subTopics.length > 0) {
            return unitContent.subTopics;
        }
        return COURSE_CONTENT_DATA[unitId!]?.subTopics || [];
    }, [unitContent, unitId]);

    // Progress State
    const [progressMap, setProgressMap] = useState<Record<string, SubTopicProgress>>({});
    const [sectionStatuses, setSectionStatuses] = useState<Record<string, UserSectionProgress>>({});
    const { getTopicProgress, getTopicSectionProgress, user } = useApp();

    useEffect(() => {
        const loadProgress = async () => {
            if (unitId && user?.id) {
                // Fetch aggregated stats (legacy/dashboard)
                getTopicProgress(unitId).then(data => setProgressMap(data));

                // Fetch granular statuses (badges)
                getTopicSectionProgress(unitId).then(data => {
                    const statusMap: Record<string, UserSectionProgress> = {};
                    data.forEach(item => {
                        statusMap[item.section_id] = item;
                    });
                    setSectionStatuses(statusMap);
                });
            }
        };
        loadProgress();
    }, [unitId, user?.id]);

    return (
        <div className="min-h-screen bg-background-light dark:bg-background-dark text-text-main dark:text-gray-100 flex flex-col">
            <Navbar />
            <main className="flex-grow w-full max-w-5xl mx-auto px-6 py-10 animate-fade-in">

                <button
                    onClick={() => navigate('/practice')}
                    className="flex items-center gap-2 text-sm font-bold text-gray-500 hover:text-text-main dark:text-gray-400 dark:hover:text-white transition-colors mb-8"
                >
                    <span className="material-symbols-outlined">arrow_back</span>
                    Back to Practice Hub
                </button>

                <header className="mb-10">
                    <div className="flex items-center gap-3 mb-2">
                        <div className="p-2 bg-primary/20 rounded-lg text-yellow-700 dark:text-primary">
                            <span className="material-symbols-outlined">topic</span>
                        </div>
                        <span className="text-sm font-bold uppercase tracking-wider text-gray-500">Unit Overview</span>
                    </div>
                    <h1 className="text-4xl md:text-5xl font-black tracking-tight mb-4">{unitContent.title}</h1>
                    <p className="text-xl text-text-secondary dark:text-gray-400 max-w-2xl leading-relaxed">
                        {unitContent.description}
                    </p>
                </header>

                <section className="grid grid-cols-1 gap-6">
                    {subTopics.map((sub, index) => (
                        <div
                            key={sub.id}
                            onClick={() => handleSubTopicClick(sub.id)}
                            className="group bg-surface-light dark:bg-surface-dark border border-gray-200 dark:border-gray-800 rounded-3xl p-6 md:p-8 hover:border-primary shadow-sm hover:shadow-lg transition-all cursor-pointer flex flex-col md:flex-row gap-6 md:items-center relative overflow-hidden"
                        >
                            {/* Decorative Index */}
                            <span className="absolute -left-2 -top-4 text-[120px] font-black text-gray-100 dark:text-white/5 pointer-events-none select-none transition-colors group-hover:text-primary/10">
                                {index + 1}
                            </span>

                            <div className="flex-1 relative z-10 pl-4 md:pl-10">
                                <h3 className="text-2xl font-bold mb-1 group-hover:text-primary transition-colors">{sub.title}</h3>
                                <div className="text-sm font-bold text-gray-500 uppercase tracking-widest mb-3">{sub.description}</div>

                                <div className="flex flex-wrap items-center gap-3">
                                    {(sub.hasLesson !== false) && (
                                        <span className="inline-flex items-center gap-1.5 px-3 py-1 bg-yellow-100 text-yellow-800 rounded-lg text-xs font-bold uppercase tracking-wider">
                                            <span className="material-symbols-outlined text-[16px]">menu_book</span>
                                            Lesson
                                        </span>
                                    )}
                                    {(sub.hasPractice !== false) && (
                                        <span className="inline-flex items-center gap-1.5 px-3 py-1 bg-blue-100 text-blue-800 rounded-lg text-xs font-bold uppercase tracking-wider">
                                            <span className="material-symbols-outlined text-[16px]">exercise</span>
                                            Practice
                                        </span>
                                    )}
                                    <span className="inline-flex items-center gap-1.5 px-3 py-1 bg-gray-100 text-gray-600 rounded-lg text-xs font-bold uppercase tracking-wider">
                                        <span className="material-symbols-outlined text-[16px]">schedule</span>
                                        {sub.estimatedMinutes} min
                                    </span>

                                    {/* Progress Badge */}
                                    {(() => {
                                        const status = sectionStatuses[sub.id]?.status;
                                        // Also support legacy check if no explicit status record exists yet
                                        const legacyCompleted = progressMap[sub.id]?.correctQuestions >= 3;

                                        if (status === 'completed' || legacyCompleted) {
                                            return (
                                                <span className="inline-flex items-center gap-1.5 px-3 py-1 rounded-lg text-xs font-bold uppercase tracking-wider bg-green-100 text-green-800 dark:bg-green-900/30 dark:text-green-400">
                                                    <span className="material-symbols-outlined text-[16px]">check_circle</span>
                                                    Completed
                                                </span>
                                            );
                                        } else if (status === 'in_progress' || (progressMap[sub.id]?.attemptedQuestions > 0)) {
                                            return (
                                                <span className="inline-flex items-center gap-1.5 px-3 py-1 rounded-lg text-xs font-bold uppercase tracking-wider bg-yellow-100 text-yellow-800 dark:bg-yellow-900/30 dark:text-yellow-400">
                                                    <span className="material-symbols-outlined text-[16px]">pending</span>
                                                    In Progress
                                                </span>
                                            );
                                        }
                                        return null;
                                    })()}
                                </div>
                            </div>

                            <div className="relative z-10 shrink-0">
                                <button className="w-full md:w-auto px-6 py-3 bg-gray-100 dark:bg-white/5 text-text-main dark:text-white rounded-xl font-bold group-hover:bg-primary group-hover:text-black transition-all flex items-center justify-center gap-2">
                                    Start
                                    <span className="material-symbols-outlined">arrow_forward</span>
                                </button>
                            </div>
                        </div>
                    ))}

                    {/* UNIT TEST CARD */}
                    <div
                        onClick={() => handleSubTopicClick('unit_test')}
                        className="group bg-gradient-to-br from-gray-50 to-gray-100 dark:from-surface-dark dark:to-black border-2 border-dashed border-gray-200 dark:border-gray-700 rounded-3xl p-6 md:p-8 hover:border-primary shadow-sm hover:shadow-lg transition-all cursor-pointer flex flex-col md:flex-row gap-6 md:items-center relative overflow-hidden"
                    >
                        <div className="flex-1 relative z-10 pl-4 md:pl-10">
                            <h3 className="text-2xl font-black mb-2 group-hover:text-primary transition-colors flex items-center gap-2">
                                <span className="material-symbols-outlined">verified</span>
                                {unitTestConfig.title}
                            </h3>
                            <p className="text-text-secondary dark:text-gray-400 font-medium mb-4">
                                {unitTestConfig.description}
                            </p>
                            <div className="flex items-center gap-4 text-xs font-bold uppercase tracking-wider text-gray-500">
                                <span className="flex items-center gap-1">
                                    <span className="material-symbols-outlined text-[16px]">timer</span>
                                    ~{unitTestConfig.estimatedMinutes} min
                                </span>
                                <span className="flex items-center gap-1">
                                    <span className="material-symbols-outlined text-[16px]">grade</span>
                                    Scored
                                </span>
                            </div>
                        </div>
                        <div className="relative z-10 shrink-0">
                            <button className="w-full md:w-auto px-6 py-3 bg-black dark:bg-white text-white dark:text-black rounded-xl font-bold group-hover:scale-105 transition-all flex items-center justify-center gap-2 shadow-md">
                                Start Test
                                <span className="material-symbols-outlined">play_arrow</span>
                            </button>
                        </div>
                    </div>

                </section>

                {subTopics.length === 0 && (
                    <div className="p-12 border-2 border-dashed border-gray-200 dark:border-gray-800 rounded-3xl text-center text-gray-400">
                        No sub-topics found for this unit.
                    </div>
                )}
            </main>
        </div>
    );
};
