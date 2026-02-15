import React, { useState, useEffect } from 'react';
import { useApp } from '../AppContext';
import { useNavigate } from 'react-router-dom';
import { Navbar } from '../components/Navbar';
import { usersApi } from '../src/services/api';

export const Settings = () => {
    const {
        user, updateUser, toggleCourse, logout, isPro,
        notifications, markNotificationRead, userPoints, proUpgradeDismissed
    } = useApp();
    const navigate = useNavigate();

    const membershipNotifs = notifications.filter(n => n.unread && n.text?.startsWith('[Membership]'));
    const hasMembershipAlert = membershipNotifs.length > 0;
    const needsProUpgrade = !isPro && userPoints.balance >= 199 && hasMembershipAlert;

    // Local state for toggles
    const [preferences, setPreferences] = useState(user.preferences);
    const [isSaving, setIsSaving] = useState(false);
    const [saveMessage, setSaveMessage] = useState('Save Changes');

    // Creator Area State
    const [showAccessModal, setShowAccessModal] = useState(false);



    // Creator Area Access - Strictly from Context (which handles @newmaos.com and super admin)
    const hasCreatorAccess = user.isCreator;

    // Sync local state if user context updates from other sources
    useEffect(() => {
        setPreferences(user.preferences);
    }, [user.preferences]);

    const handleLogout = () => {
        logout();
        navigate('/login');
    };

    const handleToggle = (key: keyof typeof preferences) => {
        setPreferences(prev => ({ ...prev, [key]: !prev[key] }));
    };

    const handleSave = async () => {
        setIsSaving(true);
        setSaveMessage('Saving...');

        try {
            // 1. Persist to Backend
            await usersApi.updatePreferences({
                email_notifications: preferences.emailNotifications,
                sound_effects: preferences.soundEffects
            });

            // 2. Update Local State (Context)
            updateUser({ preferences });

            setIsSaving(false);
            setSaveMessage('Changes Saved!');
        } catch (error) {
            console.error('Failed to save settings:', error);
            setSaveMessage('Error Saving');
            setIsSaving(false);
        } finally {
            // Reset message after a delay
            setTimeout(() => setSaveMessage('Save Changes'), 2000);
        }
    };

    return (
        <div className="h-full flex flex-col bg-background-light dark:bg-background-dark text-text-main dark:text-gray-100 overflow-hidden">
            <Navbar />

            <main className="flex-grow w-full max-w-4xl mx-auto px-4 sm:px-6 py-6 sm:py-10 animate-fade-in flex flex-col gap-6 sm:gap-10 overflow-y-auto scroll-bounce">

                <header className="flex flex-col gap-2">
                    <h1 className="text-2xl sm:text-3xl md:text-4xl font-black tracking-tight text-text-main dark:text-white">Settings</h1>
                    <p className="text-gray-500 dark:text-gray-400 text-sm sm:text-lg font-normal">Manage your account and system configurations.</p>
                </header>

                <div className="h-px w-full bg-gray-200 dark:bg-gray-800"></div>

                {/* Account Info */}
                <section className="flex flex-col gap-4">
                    <h2 className="text-sm font-bold uppercase tracking-wider text-gray-500 dark:text-gray-400 px-1">Account Info</h2>
                    <div className="bg-white dark:bg-surface-dark rounded-2xl border border-gray-200 dark:border-gray-800 overflow-hidden shadow-sm">
                        <div className="flex flex-col sm:flex-row items-start sm:items-center justify-between p-6 gap-4 border-b border-gray-100 dark:border-gray-800/50">
                            <div className="flex items-center gap-4">
                                <div className="bg-center bg-no-repeat bg-cover rounded-full h-16 w-16 shadow-inner" style={{ backgroundImage: `url(${user.avatarUrl})` }}></div>
                                <div className="flex flex-col">
                                    <p className="text-lg font-bold text-text-main dark:text-white">{user.name}</p>
                                    <p className="text-gray-500 dark:text-gray-400 text-sm">{user.email}</p>
                                </div>
                            </div>
                            <div className="flex items-center gap-3">
                                <button
                                    onClick={() => navigate('/settings/profile')}
                                    className="px-4 py-2 rounded-lg bg-black text-white hover:bg-gray-800 dark:bg-white dark:text-black dark:hover:bg-gray-200 text-sm font-bold transition-all shadow-md active:scale-95 flex items-center gap-2"
                                >
                                    <span className="material-symbols-outlined text-lg">edit</span>
                                    Edit Profile
                                </button>
                            </div>
                        </div>
                        <div className="flex flex-col">
                            <div
                                onClick={() => navigate('/settings/security')}
                                className="flex items-center justify-between p-4 px-6 hover:bg-gray-50 dark:hover:bg-gray-800/30 transition-colors cursor-pointer border-b border-gray-100 dark:border-gray-800/50"
                            >
                                <div className="flex items-center gap-3">
                                    <span className="material-symbols-outlined text-gray-400">lock</span>
                                    <span className="text-sm font-medium">Password & Security</span>
                                </div>
                                <span className="material-symbols-outlined text-gray-400 text-lg">chevron_right</span>
                            </div>
                            <div
                                onClick={() => navigate('/settings/subscription')}
                                className="flex items-center justify-between p-4 px-6 hover:bg-gray-50 dark:hover:bg-gray-800/30 transition-colors cursor-pointer group/row"
                            >
                                <div className="flex items-center gap-3 relative">
                                    <span className="material-symbols-outlined text-gray-400">credit_card</span>
                                    <span className="text-sm font-medium">Subscription</span>
                                    {(hasMembershipAlert || needsProUpgrade) && (
                                        <span className="absolute -top-1 -left-1 w-2 h-2 bg-red-500 rounded-full shadow-sm animate-pulse"></span>
                                    )}
                                </div>
                                <div className="flex items-center gap-2">
                                    <span className="text-xs font-semibold text-gray-500 dark:text-gray-400">{isPro ? 'Pro' : 'Basic'}</span>
                                    <span className="material-symbols-outlined text-gray-400 text-lg group-hover/row:translate-x-1 transition-transform">chevron_right</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>

                {/* System */}
                <section className="flex flex-col gap-4">
                    <h2 className="text-sm font-bold uppercase tracking-wider text-gray-500 dark:text-gray-400 px-1">System</h2>
                    <div className="bg-white dark:bg-surface-dark rounded-2xl border border-gray-200 dark:border-gray-800 overflow-hidden shadow-sm">
                        <div className="flex items-center justify-between p-5 border-b border-gray-100 dark:border-gray-800/50">
                            <div className="flex flex-col gap-0.5">
                                <span className="text-sm font-semibold">Email Notifications</span>
                                <span className="text-xs text-gray-500 dark:text-gray-400">Receive weekly progress reports.</span>
                            </div>
                            <label className="relative inline-flex items-center cursor-pointer">
                                <input
                                    type="checkbox"
                                    className="sr-only peer"
                                    checked={preferences.emailNotifications}
                                    onChange={() => handleToggle('emailNotifications')}
                                />
                                <div className="w-11 h-6 bg-gray-200 peer-focus:outline-none rounded-full peer dark:bg-gray-700 peer-checked:after:translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-[2px] after:left-[2px] after:bg-white after:border-gray-300 after:border after:rounded-full after:h-5 after:w-5 after:transition-all peer-checked:bg-primary"></div>
                            </label>
                        </div>
                        <div className="flex items-center justify-between p-5 border-b border-gray-100 dark:border-gray-800/50">
                            <div className="flex flex-col gap-0.5">
                                <span className="text-sm font-semibold">Sound Effects</span>
                                <span className="text-xs text-gray-500 dark:text-gray-400">Play sounds on correct answers.</span>
                            </div>
                            <label className="relative inline-flex items-center cursor-pointer">
                                <input
                                    type="checkbox"
                                    className="sr-only peer"
                                    checked={preferences.soundEffects}
                                    onChange={() => handleToggle('soundEffects')}
                                />
                                <div className="w-11 h-6 bg-gray-200 peer-focus:outline-none rounded-full peer dark:bg-gray-700 peer-checked:after:translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-[2px] after:left-[2px] after:bg-white after:border-gray-300 after:border after:rounded-full after:h-5 after:w-5 after:transition-all peer-checked:bg-primary"></div>
                            </label>
                        </div>
                    </div>
                </section>

                {/* Admin / Creator Area */}
                <section className="flex flex-col gap-4">
                    <h2 className="text-sm font-bold uppercase tracking-wider text-gray-500 dark:text-gray-400 px-1">Administration</h2>
                    <button
                        onClick={() => hasCreatorAccess ? navigate('/settings/creator') : setShowAccessModal(true)}
                        className="bg-white dark:bg-surface-dark rounded-2xl border border-gray-200 dark:border-gray-800 p-6 shadow-sm flex items-center justify-between hover:border-primary/50 transition-colors group"
                    >
                        <div className="flex items-center gap-4">
                            <div className="p-3 bg-gray-100 dark:bg-gray-800 rounded-xl group-hover:bg-primary group-hover:text-black transition-colors">
                                <span className="material-symbols-outlined">edit_square</span>
                            </div>
                            <div className="flex flex-col items-start">
                                <span className="text-base font-bold text-text-main dark:text-white">Creator Area</span>
                                <span className="text-sm text-gray-500 dark:text-gray-400">Manage question bank and content.</span>
                            </div>
                        </div>
                        {hasCreatorAccess ? (
                            <div className="flex items-center gap-2 text-green-500">
                                <span className="text-sm font-bold">Authorized</span>
                                <span className="material-symbols-outlined">check_circle</span>
                            </div>
                        ) : (
                            <div className="flex items-center gap-2 text-blue-500 group-hover:text-primary transition-colors">
                                <span className="text-xs font-bold">Request Access</span>
                                <span className="material-symbols-outlined">lock</span>
                            </div>
                        )}
                    </button>
                </section>

                <div className="flex flex-col items-center gap-6 mt-4 pb-12">
                    <button
                        onClick={handleSave}
                        disabled={isSaving}
                        className="w-full py-3.5 px-4 rounded-xl bg-primary text-text-main text-sm font-bold shadow-md hover:brightness-105 active:scale-[0.99] transition-all flex justify-center items-center gap-2 disabled:opacity-70"
                    >
                        {isSaving && <span className="material-symbols-outlined animate-spin text-sm">progress_activity</span>}
                        {saveMessage}
                    </button>
                    <button
                        onClick={handleLogout}
                        className="text-gray-500 hover:text-red-600 text-sm font-medium transition-colors flex items-center gap-2"
                    >
                        <span className="material-symbols-outlined text-[18px]">logout</span>
                        Sign Out
                    </button>
                    <div className="flex flex-col items-center">
                        <p className="text-gray-400 text-xs font-medium">NewMaoS v2.0.0</p>
                    </div>
                </div>

            </main>

            {/* Request Access Modal */}
            {showAccessModal && (
                <div className="fixed inset-0 z-[100] flex items-center justify-center p-4 bg-black/60 backdrop-blur-sm animate-fade-in">
                    <div className="bg-white dark:bg-surface-dark w-full max-w-sm rounded-3xl p-6 shadow-2xl border border-gray-200 dark:border-gray-800 relative animate-fade-in-up">
                        <button
                            onClick={() => setShowAccessModal(false)}
                            className="absolute top-4 right-4 p-1 rounded-full hover:bg-gray-100 dark:hover:bg-white/10 transition-colors text-gray-400"
                        >
                            <span className="material-symbols-outlined text-xl">close</span>
                        </button>

                        <div className="flex flex-col items-center text-center mt-2 mb-6">
                            <div className="w-14 h-14 bg-gray-100 dark:bg-white/10 rounded-2xl flex items-center justify-center text-text-main dark:text-white mb-4">
                                <span className="material-symbols-outlined text-3xl">lock_person</span>
                            </div>
                            <h3 className="text-xl font-black text-text-main dark:text-white">Restricted Access</h3>
                            <p className="text-sm text-gray-500 mt-2 px-2">
                                The Creator Area is restricted to authorized content managers only.
                            </p>
                        </div>

                        <div className="flex flex-col gap-4 text-center">
                            <div className="bg-gray-50 dark:bg-black/20 p-4 rounded-xl text-sm text-gray-600 dark:text-gray-300">
                                To request access, please email the administrator:
                                <a href="mailto:newmao6120@gmail.com" className="block mt-2 font-bold text-primary hover:underline">
                                    newmao6120@gmail.com
                                </a>
                            </div>

                            <p className="text-xs text-gray-400">
                                Once your request is approved, refresh this page to enter.
                            </p>

                            <button
                                onClick={() => window.location.reload()}
                                className="w-full py-3.5 bg-black dark:bg-white text-white dark:text-black rounded-xl font-bold shadow-md hover:opacity-90 active:scale-95 transition-all"
                            >
                                I've been approved (Refresh)
                            </button>
                        </div>
                    </div>
                </div>
            )}


        </div>
    );
};