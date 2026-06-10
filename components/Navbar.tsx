import React, { useState, useEffect, useRef } from 'react';
import { useApp } from '../AppContext';
import { Link, useLocation, useNavigate } from 'react-router-dom';
import { useToast } from './Toast';
import confetti from 'canvas-confetti';
import { supabase } from '../src/services/supabaseClient';
import { notificationsApi } from '../src/services/api';
import { AchievementUnlockModal } from './AchievementUnlockModal';
import { PointsBalanceBadge, PointsCoin } from './PointsCoin';
import { PrestigeWidget } from './PrestigeWidget';
import { AvatarAura } from './AvatarAura';

export const Navbar = ({ minimal = false }: { minimal?: boolean }) => {
  const {
    user, logout, isAuthenticated, isPro,
    newlyUnlockedTitle, setNewlyUnlockedTitle,
    showPaywall, setShowPaywall, unreadCounts, clearUnread,
    userPoints, pointsBalanceRef, fetchUserPoints, getCheckinStatus, awardPoints,
    checkinStatus, userPrestige, navRedDots
  } = useApp();
  const location = useLocation();
  const navigate = useNavigate();
  const { showToast } = useToast();
  const [showProfileMenu, setShowProfileMenu] = useState(false);
  const [showMobileMenu, setShowMobileMenu] = useState(false);

  const playSuccessSound = () => {
    if (user.preferences && user.preferences.soundEffects === false) return;
    try {
      const AudioContextClass = (window as any).AudioContext || (window as any).webkitAudioContext;
      const ctx = new AudioContextClass();
      const playNote = (freq: number, startTime: number, duration: number) => {
        const osc = ctx.createOscillator();
        const gain = ctx.createGain();
        osc.type = 'triangle';
        osc.frequency.setValueAtTime(freq, startTime);
        gain.gain.setValueAtTime(0, startTime);
        gain.gain.linearRampToValueAtTime(0.2, startTime + 0.05);
        gain.gain.exponentialRampToValueAtTime(0.001, startTime + duration);
        osc.connect(gain);
        gain.connect(ctx.destination);
        osc.start(startTime);
        osc.stop(startTime + duration);
      };
      const now = ctx.currentTime;
      playNote(523.25, now, 0.3);      // C5
      playNote(659.25, now + 0.15, 0.3); // E5
      playNote(783.99, now + 0.3, 0.3);  // G5
      playNote(1046.50, now + 0.45, 0.6); // C6
    } catch (err) {
      console.error('Failed to play success sound:', err);
    }
  };



  const profileRef = useRef<HTMLDivElement>(null);

  const isActive = (path: string) => location.pathname.startsWith(path);
  const [mutedChats, setMutedChats] = useState<Set<string>>(() => {
    try {
      const saved = localStorage.getItem('forum_muted_chats');
      return saved ? new Set(JSON.parse(saved)) : new Set();
    } catch { return new Set(); }
  });

  // Listen for storage events (e.g. from Forum.tsx)
  useEffect(() => {
    const handleStorageChange = () => {
      try {
        const saved = localStorage.getItem('forum_muted_chats');
        setMutedChats(saved ? new Set(JSON.parse(saved)) : new Set());
      } catch { }
    };
    window.addEventListener('storage', handleStorageChange);
    window.addEventListener('forum_muted_chats_updated', handleStorageChange);
    return () => {
      window.removeEventListener('storage', handleStorageChange);
      window.removeEventListener('forum_muted_chats_updated', handleStorageChange);
    };
  }, []);


  // Check-in red dot: derived from global checkinStatus (no local state needed)

  // Pro upgrade red dot: derived from global state (no local state needed)

  // Red dots are now globally managed and injected via navRedDots from AppContext

  // Close dropdowns when clicking outside
  useEffect(() => {
    const handleClickOutside = (event: MouseEvent) => {
      if (profileRef.current && !profileRef.current.contains(event.target as Node)) {
        setShowProfileMenu(false);
      }
    };

    document.addEventListener('mousedown', handleClickOutside);
    return () => document.removeEventListener('mousedown', handleClickOutside);
  }, []);

  const handleLogout = async () => {
    await logout();
    showToast('Signed out successfully', 'success');
    navigate('/dashboard');
  };



  // Update document title with unread count
  // Update document title with unread forum messages count (if any)
  useEffect(() => {
    if (navRedDots.forum > 0) {
      document.title = `(${navRedDots.forum}) NewMaoS`;
    } else {
      document.title = 'NewMaoS';
    }
  }, [navRedDots.forum]);

  return (
    <>
      <nav className="sticky top-0 z-50 w-full border-b border-gray-200/70 dark:border-gray-800 bg-surface-light/80 dark:bg-surface-dark/80 backdrop-blur-md supports-[backdrop-filter]:bg-surface-light/60 h-20 min-h-[80px] flex-shrink-0 flex items-center overflow-visible">
        <div className="w-full max-w-none h-full px-6 flex items-center justify-between relative mx-0">
          {/* Left Side Group (Logo + Notification) */}
          <div className="flex items-center h-full">
            {/* Logo Area - Always Visible */}
            <Link 
              to="/lobby"
              className="flex items-center gap-2 group cursor-pointer shrink-0"
            >
              <div className="w-8 h-8 bg-primary rounded-lg flex items-center justify-center text-text-main shadow-glow transition-transform group-hover:scale-105 overflow-hidden">
                <span className="material-symbols-outlined font-bold" style={{ fontSize: '20px' }}>function</span>
              </div>
              <h1 className="text-lg sm:text-xl font-bold tracking-tight text-text-main dark:text-white">NewMaoS</h1>
            </Link>
          </div>


          {/* Central Navigation - Absolutely Centered */}
          {minimal ? (
            <div className="absolute left-1/2 top-1/2 -translate-x-1/2 -translate-y-1/2">
              <button
                onClick={() => navigate(-1)}
                className="flex items-center gap-2 px-4 py-2 bg-gray-100 hover:bg-gray-200 dark:bg-white/10 dark:hover:bg-white/20 rounded-full transition-colors text-sm font-bold text-text-secondary dark:text-gray-300 ring-1 ring-black/5 dark:ring-white/10"
              >
                <span className="material-symbols-outlined text-lg">keyboard_return</span>
                <span>Return</span>
              </button>
            </div>
          ) : (
            <div
              className="absolute left-1/2 top-1/2 -translate-x-1/2 -translate-y-1/2 hidden md:flex items-center justify-center gap-1 h-full pointer-events-none"
            >
              <div className="pointer-events-auto flex items-center gap-1">
                <Link
                  to="/dashboard"
                  className={`shrink-0 text-sm font-medium px-3 py-1.5 rounded-lg relative whitespace-nowrap ${location.pathname === '/dashboard' ? 'text-text-main dark:text-white bg-primary/15 font-bold' : 'text-text-secondary dark:text-gray-400 hover:text-text-main dark:hover:text-white hover:bg-gray-100 dark:hover:bg-white/5'}`}
                >
                  <span>Dashboard</span>
                  {navRedDots.dashboard && (
                    <span className="absolute top-1.5 right-1.5 w-2 h-2 bg-red-500 rounded-full shadow-sm ring-1 ring-white dark:ring-surface-dark transition-transform"></span>
                  )}
                </Link>
                <Link to="/practice" className={`shrink-0 text-sm font-medium px-3 py-1.5 rounded-lg relative whitespace-nowrap ${isActive('/practice') ? 'text-text-main dark:text-white bg-primary/15 font-bold' : 'text-text-secondary dark:text-gray-400 hover:text-text-main dark:hover:text-white hover:bg-gray-100 dark:hover:bg-white/5'}`}>
                  <span>Practice</span>
                  {navRedDots.practice && (
                    <span className="absolute top-1.5 right-1.5 w-2 h-2 bg-red-500 rounded-full shadow-sm ring-1 ring-white dark:ring-surface-dark transition-transform group-hover:scale-110"></span>
                  )}
                </Link>
                <Link to={isAuthenticated ? "/analysis" : "/login"} className={`shrink-0 text-sm font-medium px-3 py-1.5 rounded-lg flex items-center gap-1.5 relative whitespace-nowrap ${isActive('/analysis') ? 'text-text-main dark:text-white bg-primary/15 font-bold' : 'text-text-secondary dark:text-gray-400 hover:text-text-main dark:hover:text-white hover:bg-gray-100 dark:hover:bg-white/5'}`}>
                  <span>Analysis</span>
                  {!isPro && isAuthenticated && <span className="material-symbols-outlined text-[16px] ml-0.5 opacity-60">lock</span>}
                  {navRedDots.analysis && (
                    <span className="absolute top-1.5 right-1.5 w-2 h-2 bg-red-500 rounded-full shadow-sm ring-1 ring-white dark:ring-surface-dark transition-transform group-hover:scale-110"></span>
                  )}
                </Link>
                <Link to={isAuthenticated ? "/forum" : "/login"} className={`shrink-0 text-sm font-medium px-3 py-1.5 rounded-lg flex items-center gap-1.5 relative whitespace-nowrap ${isActive('/forum') ? 'text-text-main dark:text-white bg-primary/15 font-bold' : 'text-text-secondary dark:text-gray-400 hover:text-text-main dark:hover:text-white hover:bg-gray-100 dark:hover:bg-white/5'}`}>
                  <span>Forum</span>
                  {!isPro && isAuthenticated && <span className="material-symbols-outlined text-[16px] ml-0.5 opacity-60">lock</span>}
                  {navRedDots.forum > 0 && (
                    <span className="absolute -top-1 -right-1 min-w-[16px] h-4 flex items-center justify-center bg-red-500 text-white text-[9px] font-black rounded-full px-1 shadow-sm ring-2 ring-white dark:ring-surface-dark group-hover:scale-110 transition-transform">
                      {navRedDots.forum > 99 ? '99+' : navRedDots.forum}
                    </span>
                  )}
                </Link>
                {isAuthenticated ? (
                  <Link
                    to="/settings"
                    className={`shrink-0 text-sm font-medium px-3 py-1.5 rounded-lg relative whitespace-nowrap ${isActive('/settings') ? 'text-text-main dark:text-white bg-primary/15 font-bold' : 'text-text-secondary dark:text-gray-400 hover:text-text-main dark:hover:text-white hover:bg-gray-100 dark:hover:bg-white/5'}`}
                  >
                    <span>Settings</span>
                    {navRedDots.settings && (
                      <span className="absolute top-1.5 right-1.5 w-2 h-2 bg-red-500 rounded-full shadow-sm ring-1 ring-white dark:ring-surface-dark transition-transform group-hover:scale-110"></span>
                    )}
                  </Link>
                ) : (
                  <div className="relative group shrink-0">
                    <div className="text-sm font-medium px-3 py-1.5 rounded-lg flex items-center gap-1.5 text-text-secondary dark:text-gray-400 cursor-not-allowed opacity-60 whitespace-nowrap">
                      <span>Settings</span>
                      <span className="material-symbols-outlined text-[16px] ml-0.5">lock</span>
                    </div>
                    <div className="absolute bottom-full left-1/2 -translate-x-1/2 mb-2 px-3 py-1.5 bg-gray-900 dark:bg-gray-700 text-white text-xs rounded-lg whitespace-nowrap opacity-0 group-hover:opacity-100 transition-opacity pointer-events-none">
                      Sign in required
                      <div className="absolute top-full left-1/2 -translate-x-1/2 -mt-1 border-4 border-transparent border-t-gray-900 dark:border-t-gray-700"></div>
                    </div>
                  </div>
                )}
              </div>
            </div>
          )}

          {/* Right Actions - Always Visible */}
          <div className="flex items-center gap-2 md:gap-4 shrink-0">


            {/* Mobile Menu Button - DISABLED FOR DESKTOP ONLY MODE */}
            {/* <button
            onClick={() => setShowMobileMenu(!showMobileMenu)}
            className="sm:hidden w-9 h-9 flex items-center justify-center rounded-lg text-text-secondary hover:bg-gray-100 dark:hover:bg-white/10 transition-colors"
          >
            <span className="material-symbols-outlined">{showMobileMenu ? 'close' : 'menu'}</span>
          </button> */}

            {isAuthenticated ? (
              <>
                {/* Points Balance */}
                {/* Points Balance - Standalone Widget */}
                <PointsBalanceBadge
                  balance={userPoints.balance}
                  ref={pointsBalanceRef as any}
                  onClick={() => navigate('/points')}
                  className="h-8 px-2.5 md:h-10 md:px-4 flex items-center gap-1.5 md:gap-2 rounded-full border border-gray-200 dark:border-gray-700 bg-white dark:bg-surface-dark shadow-sm hover:shadow-md transition-all cursor-pointer font-bold text-xs md:text-sm"
                />



                {/* User Menu */}
                <div className="relative" ref={profileRef}>
                  <div
                    onClick={() => setShowProfileMenu(!showProfileMenu)}
                    className="relative w-9 h-9 rounded-full bg-gray-200 overflow-hidden ring-2 ring-white dark:ring-gray-700 shadow-sm cursor-pointer hover:ring-primary transition-all group"
                  >
                    <div className="absolute inset-0 z-0 bg-cover bg-center" style={{ backgroundImage: `url(${user.avatarUrl})` }} />
                    {userPrestige?.planet_level && <AvatarAura level={userPrestige.planet_level} />}
                  </div>

                  {/* Profile Dropdown */}
                  {showProfileMenu && (
                    <div className="absolute right-0 mt-2 w-56 bg-white dark:bg-surface-dark rounded-xl shadow-xl border border-gray-200 dark:border-gray-800 overflow-hidden animate-fade-in origin-top-right">
                      <div className="p-4 border-b border-gray-100 dark:border-gray-800/50">
                        <p className="text-sm font-bold text-text-main dark:text-white truncate">{user.name}</p>
                        <p className="text-xs text-gray-500 truncate">{user.email}</p>


                      </div>
                      <div className="p-1.5 flex flex-col gap-1">
                        <button
                          onClick={() => { navigate('/settings/profile'); setShowProfileMenu(false); }}
                          className="w-full text-left flex items-center gap-2 px-3 py-2 rounded-lg text-sm text-gray-600 dark:text-gray-300 hover:bg-gray-100 dark:hover:bg-white/10 transition-colors"
                        >
                          <span className="material-symbols-outlined text-[18px]">person</span>
                          Profile
                        </button>
                        <button
                          onClick={() => { navigate('/settings'); setShowProfileMenu(false); }}
                          className="w-full text-left flex items-center gap-2 px-3 py-2 rounded-lg text-sm text-gray-600 dark:text-gray-300 hover:bg-gray-100 dark:hover:bg-white/10 transition-colors"
                        >
                          <span className="material-symbols-outlined text-[18px]">settings</span>
                          Settings
                        </button>
                        <div className="h-px bg-gray-100 dark:bg-gray-800 my-0.5"></div>
                        <button
                          onClick={handleLogout}
                          className="w-full text-left flex items-center gap-2 px-3 py-2 rounded-lg text-sm text-red-500 hover:bg-red-50 dark:hover:bg-red-900/20 transition-colors"
                        >
                          <span className="material-symbols-outlined text-[18px]">logout</span>
                          Sign Out
                        </button>
                      </div>
                    </div>
                  )}
                </div>
              </>
            ) : (
              /* Guest Actions */
              <div className="flex items-center gap-2 sm:gap-3 shrink-0">
                <Link
                  to="/login"
                  className="text-sm font-bold text-text-secondary hover:text-text-main dark:text-gray-400 dark:hover:text-white transition-colors"
                >
                  Sign In
                </Link>
                <Link
                  to="/signup"
                  className="px-3 py-1.5 sm:px-4 sm:py-2 bg-black dark:bg-white text-white dark:text-black rounded-lg text-sm font-bold shadow-sm hover:opacity-80 transition-all"
                >
                  Sign Up
                </Link>
              </div>
            )}

          </div>
        </div>

        {/* Mobile Menu Overlay - DISABLED */}
        {/* {showMobileMenu && (
        <div className="md:hidden fixed inset-0 top-16 bg-black/50 z-40" onClick={() => setShowMobileMenu(false)} />
      )} */}

        {/* Mobile Menu Panel - DISABLED */}
        {/* <div className={`md:hidden fixed top-16 left-0 right-0 bg-white dark:bg-surface-dark border-b border-gray-200 dark:border-gray-800 shadow-lg z-50 transform transition-transform duration-200 ${showMobileMenu ? 'translate-y-0' : '-translate-y-full pointer-events-none'}`}>
          ... (mobile menu content) ...
      </div> */}



        {
          newlyUnlockedTitle && (
            <AchievementUnlockModal
              title={newlyUnlockedTitle}
              onClose={() => setNewlyUnlockedTitle(null)}
            />
          )
        }
      </nav >

      {/* Mobile Bottom Navigation Tab Bar — OUTSIDE nav to avoid backdrop-filter breaking fixed positioning */}
      {isAuthenticated && !minimal && (
        <div
          className="md:hidden fixed bottom-0 left-0 right-0 z-[999] bg-white/95 dark:bg-surface-dark/95 backdrop-blur-md border-t border-gray-200 dark:border-gray-700 w-full"
          style={{ paddingBottom: 'env(safe-area-inset-bottom, 20px)' }}
        >
          <div className="flex items-center justify-around h-[60px] px-1">
            {/* Dashboard */}
            <Link
              to="/dashboard"
              className={`flex flex-col items-center justify-center gap-0.5 flex-1 py-1.5 relative ${location.pathname === '/dashboard' ? 'text-primary' : 'text-gray-400 dark:text-gray-500'}`}
            >
              <span className="material-symbols-outlined text-xl" style={{ fontVariationSettings: location.pathname === '/dashboard' ? "'FILL' 1" : "'FILL' 0" }}>dashboard</span>
              <span className="text-[10px] font-semibold leading-none">Dashboard</span>
              {navRedDots.dashboard && (
                <span className="absolute top-1 right-1/4 w-2 h-2 bg-red-500 rounded-full shadow-sm ring-1 ring-white dark:ring-surface-dark transition-transform"></span>
              )}
            </Link>

            {/* Practice */}
            <Link
              to="/practice"
              className={`flex flex-col items-center justify-center gap-0.5 flex-1 py-1.5 relative ${isActive('/practice') ? 'text-primary' : 'text-gray-400 dark:text-gray-500'}`}
            >
              <span className="material-symbols-outlined text-xl" style={{ fontVariationSettings: isActive('/practice') ? "'FILL' 1" : "'FILL' 0" }}>edit_note</span>
              <span className="text-[10px] font-semibold leading-none">Practice</span>
              {navRedDots.practice && (
                <span className="absolute top-1 right-1/4 w-2 h-2 bg-red-500 rounded-full shadow-sm ring-1 ring-white dark:ring-surface-dark transition-transform"></span>
              )}
            </Link>

            {/* Analysis */}
            <Link
              to="/analysis"
              className={`flex flex-col items-center justify-center gap-0.5 flex-1 py-1.5 relative ${isActive('/analysis') ? 'text-primary' : 'text-gray-400 dark:text-gray-500'}`}
            >
              <span className="material-symbols-outlined text-xl" style={{ fontVariationSettings: isActive('/analysis') ? "'FILL' 1" : "'FILL' 0" }}>analytics</span>
              <span className="text-[10px] font-semibold leading-none flex items-center gap-0.5">
                Analysis
                {!isPro && <span className="material-symbols-outlined text-[8px] opacity-60">lock</span>}
              </span>
              {navRedDots.analysis && (
                <span className="absolute top-1 right-1/4 w-2 h-2 bg-red-500 rounded-full shadow-sm ring-1 ring-white dark:ring-surface-dark transition-transform"></span>
              )}
            </Link>

            {/* Forum */}
            <Link
              to="/forum"
              className={`flex flex-col items-center justify-center gap-0.5 flex-1 py-1.5 relative ${isActive('/forum') ? 'text-primary' : 'text-gray-400 dark:text-gray-500'}`}
            >
              <span className="material-symbols-outlined text-xl" style={{ fontVariationSettings: isActive('/forum') ? "'FILL' 1" : "'FILL' 0" }}>forum</span>
              <span className="text-[10px] font-semibold leading-none flex items-center gap-0.5">
                Forum
                {!isPro && <span className="material-symbols-outlined text-[8px] opacity-60">lock</span>}
              </span>
              {navRedDots.forum > 0 && (
                <span className="absolute top-0.5 right-1/4 min-w-[14px] h-3.5 flex items-center justify-center bg-red-500 text-white text-[8px] font-black rounded-full px-0.5">
                  {navRedDots.forum > 99 ? '99+' : navRedDots.forum}
                </span>
              )}
            </Link>

            {/* Settings */}
            <Link
              to="/settings"
              className={`flex flex-col items-center justify-center gap-0.5 flex-1 py-1.5 relative ${isActive('/settings') ? 'text-primary' : 'text-gray-400 dark:text-gray-500'}`}
            >
              <span className="material-symbols-outlined text-xl" style={{ fontVariationSettings: isActive('/settings') ? "'FILL' 1" : "'FILL' 0" }}>settings</span>
              <span className="text-[10px] font-semibold leading-none">Settings</span>
              {navRedDots.settings && (
                <span className="absolute top-1 right-1/4 w-2 h-2 bg-red-500 rounded-full shadow-sm ring-1 ring-white dark:ring-surface-dark transition-transform"></span>
              )}
            </Link>
          </div>
        </div>
      )}
    </>
  );
};