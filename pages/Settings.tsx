import React, { useState, useEffect } from 'react';
import { useApp } from '../AppContext';
import { useNavigate } from 'react-router-dom';
import { Navbar } from '../components/Navbar';

export const Settings = () => {
  const { user, updateUser, toggleCourse, logout, isCreatorAuthenticated, loginCreator } = useApp();
  const navigate = useNavigate();
  
  // Local state for toggles
  const [preferences, setPreferences] = useState(user.preferences);
  const [isSaving, setIsSaving] = useState(false);
  const [saveMessage, setSaveMessage] = useState('Save Changes');

  // Creator Area State
  const [showCreatorAuth, setShowCreatorAuth] = useState(false);
  const [creatorPassword, setCreatorPassword] = useState('');
  const [authError, setAuthError] = useState('');

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

  const handleSave = () => {
    setIsSaving(true);
    setSaveMessage('Saving...');
    
    // Simulate network delay
    setTimeout(() => {
        updateUser({ preferences });
        setIsSaving(false);
        setSaveMessage('Changes Saved!');
        
        // Reset message after a delay
        setTimeout(() => setSaveMessage('Save Changes'), 2000);
    }, 800);
  };

  const handleCreatorAccess = () => {
      if (loginCreator(creatorPassword)) {
          setAuthError('');
          setCreatorPassword('');
          setShowCreatorAuth(false);
          navigate('/settings/creator');
      } else {
          setAuthError('Access Denied: Invalid Credentials');
      }
  };

  return (
    <div className="min-h-screen flex flex-col bg-background-light dark:bg-background-dark text-text-main dark:text-gray-100">
        <Navbar />

        <main className="flex-grow w-full max-w-4xl mx-auto px-6 py-10 animate-fade-in flex flex-col gap-10">
            
            <header className="flex flex-col gap-2">
                <h1 className="text-4xl font-black tracking-tight text-text-main dark:text-white">Settings</h1>
                <p className="text-gray-500 dark:text-gray-400 text-lg font-normal">Manage your account and system configurations.</p>
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
                        <button 
                            onClick={() => navigate('/settings/profile')}
                            className="px-4 py-2 rounded-lg bg-gray-100 dark:bg-gray-800 hover:bg-gray-200 dark:hover:bg-gray-700 text-text-main dark:text-white text-sm font-semibold transition-colors"
                        >
                            Edit Profile
                        </button>
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
                            onClick={() => navigate('/settings/billing')}
                            className="flex items-center justify-between p-4 px-6 hover:bg-gray-50 dark:hover:bg-gray-800/30 transition-colors cursor-pointer"
                        >
                            <div className="flex items-center gap-3">
                                <span className="material-symbols-outlined text-gray-400">credit_card</span>
                                <span className="text-sm font-medium">Subscription & Billing</span>
                            </div>
                            <div className="flex items-center gap-2">
                                <span className="text-xs font-semibold text-gray-500 dark:text-gray-400">Basic</span>
                                <span className="material-symbols-outlined text-gray-400 text-lg">chevron_right</span>
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
                    onClick={() => isCreatorAuthenticated ? navigate('/settings/creator') : setShowCreatorAuth(true)}
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
                    <span className="material-symbols-outlined text-gray-400 group-hover:text-primary group-hover:translate-x-1 transition-all">arrow_forward</span>
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
                    <p className="text-gray-400 text-xs font-medium">NewMaoS v1.0.0</p>
                </div>
            </div>

        </main>

        {/* Creator Authentication Modal */}
        {showCreatorAuth && (
            <div className="fixed inset-0 z-[100] flex items-center justify-center p-4 bg-black/60 backdrop-blur-sm animate-fade-in">
                <div className="bg-white dark:bg-surface-dark w-full max-w-sm rounded-3xl p-6 shadow-2xl border border-gray-200 dark:border-gray-800 relative animate-fade-in-up">
                    <button 
                        onClick={() => { setShowCreatorAuth(false); setCreatorPassword(''); setAuthError(''); }}
                        className="absolute top-4 right-4 p-1 rounded-full hover:bg-gray-100 dark:hover:bg-white/10 transition-colors text-gray-400"
                    >
                        <span className="material-symbols-outlined text-xl">close</span>
                    </button>

                    <div className="flex flex-col items-center text-center mt-2 mb-6">
                        <div className="w-14 h-14 bg-gray-100 dark:bg-white/10 rounded-2xl flex items-center justify-center text-text-main dark:text-white mb-4">
                            <span className="material-symbols-outlined text-3xl">admin_panel_settings</span>
                        </div>
                        <h3 className="text-xl font-black text-text-main dark:text-white">Creator Access</h3>
                        <p className="text-sm text-gray-500 mt-1">Restricted area for content managers.</p>
                    </div>

                    <form onSubmit={(e) => { e.preventDefault(); handleCreatorAccess(); }} className="flex flex-col gap-4">
                        <div className="space-y-1">
                            <input 
                                type="password" 
                                autoFocus
                                value={creatorPassword}
                                onChange={(e) => setCreatorPassword(e.target.value)}
                                placeholder="Enter Access Code"
                                className="w-full p-3.5 rounded-xl border border-gray-200 dark:border-gray-700 bg-gray-50 dark:bg-black/20 outline-none focus:ring-2 focus:ring-primary/50 text-center tracking-widest"
                            />
                            {authError && <p className="text-xs text-red-500 font-bold text-center animate-pulse">{authError}</p>}
                        </div>
                        <button 
                            type="submit"
                            className="w-full py-3.5 bg-black dark:bg-white text-white dark:text-black rounded-xl font-bold shadow-md hover:opacity-90 active:scale-95 transition-all"
                        >
                            Verify & Enter
                        </button>
                    </form>
                </div>
            </div>
        )}
    </div>
  );
};