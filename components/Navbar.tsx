import React, { useState, useEffect, useRef } from 'react';
import { useApp } from '../AppContext';
import { Link, useLocation, useNavigate } from 'react-router-dom';
import { useToast } from './Toast';
import confetti from 'canvas-confetti';
import { supabase } from '../src/services/supabaseClient';
import { notificationsApi } from '../src/services/api';
import { AchievementUnlockModal } from './AchievementUnlockModal';
import { PointsBalanceBadge } from './PointsCoin';

export const Navbar = () => {
  const {
    user, logout, isAuthenticated, isPro, notifications,
    markAllNotificationsRead, markNotificationRead,
    newlyUnlockedTitle, setNewlyUnlockedTitle,
    showPaywall, setShowPaywall, unreadCounts, clearUnread,
    userPoints, pointsBalanceRef, fetchUserPoints, getCheckinStatus, awardPoints,
    checkinStatus, proUpgradeDismissed, dismissProUpgrade
  } = useApp();
  const location = useLocation();
  const navigate = useNavigate();
  const { showToast } = useToast();
  const [showNotifications, setShowNotifications] = useState(false);
  const [showProfileMenu, setShowProfileMenu] = useState(false);
  const [showMobileMenu, setShowMobileMenu] = useState(false);

  const [processingNotifId, setProcessingNotifId] = useState<number | null>(null);
  const [acceptedNotifIds, setAcceptedNotifIds] = useState<Set<number>>(new Set());
  const needsCheckin = checkinStatus === 'not_checked_in';

  // Check for unread [Membership] notifications
  const membershipNotifs = notifications.filter(n => n.unread && n.text?.includes('[Membership]'));

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
  const needsProUpgrade = !isPro && userPoints.balance >= 199 && membershipNotifs.length > 0;



  const notifRef = useRef<HTMLDivElement>(null);
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

  // Trigger system notifications on login
  useEffect(() => {
    if (isAuthenticated && user?.id) {
      supabase.rpc('generate_system_notifications', { p_user_id: user.id })
        .then(({ error }) => {
          if (error) console.error('Error triggering system notifications:', error);
        });
    }
  }, [isAuthenticated, user?.id]);

  // Check-in red dot: derived from global checkinStatus (no local state needed)

  // Pro upgrade red dot: derived from global state (no local state needed)

  const isNotificationMuted = (n: any) => {
    // 1. Prefer robust chat_id check if available
    if (n.chatId) {
      return mutedChats.has(n.chatId);
    }

    // 2. Fallback to brittle link parsing (for old notifications)
    if (!n.link) return false;
    try {
      if (n.link.includes('chat_id=')) {
        const paramString = n.link.includes('?') ? n.link.split('?')[1] : n.link;
        const urlParams = new URLSearchParams(paramString);
        const chatId = urlParams.get('chat_id');
        return chatId ? mutedChats.has(chatId) : false;
      }
      return false;
    } catch { return false; }
  };

  const visibleNotifications = notifications.filter(n => !isNotificationMuted(n));
  const unreadCount = visibleNotifications.filter(n => n.unread).length;
  const totalUnreadChatCount = Object.values(unreadCounts).reduce((sum, count) => sum + count, 0);

  const displayedNotifications = visibleNotifications;

  // Close dropdowns when clicking outside
  useEffect(() => {
    const handleClickOutside = (event: MouseEvent) => {
      if (notifRef.current && !notifRef.current.contains(event.target as Node)) {
        setShowNotifications(false);
      }
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

  const handleBellClick = () => {
    setShowNotifications(!showNotifications);
  };

  const handleNotificationClick = (id: number, link: string, type?: string) => {
    // 1. Mark THIS notification as read
    if (type !== 'gift_claim') {
      markNotificationRead(id);
    }

    // 2. Also mark ALL notifications with the same link as read
    // This ensures that navigating to the target page clears all related notifications
    if (link) {
      const sameLink = visibleNotifications.filter(n => n.link === link && n.unread && n.id !== id);
      sameLink.forEach(n => {
        if (n.type !== 'gift_claim') {
          markNotificationRead(n.id);
        }
      });
    }

    // 3. Validate link and clear counts
    if (!link) {
      setShowNotifications(false);
      return;
    }

    // Preserve the current behavior of clearing unread counts from link params
    try {
      if (link.includes('?')) {
        const queryString = link.split('?')[1];
        const urlParams = new URLSearchParams(queryString);
        const chatId = urlParams.get('chat_id');
        const channelId = urlParams.get('channel_id');

        if (chatId) clearUnread(chatId);
        if (channelId) clearUnread(channelId);
      }
    } catch (e) {
      console.error('Error parsing notification link:', e);
    }

    // 4. Navigate with absolute path assurance
    const targetLink = link.startsWith('/') ? link : `/${link}`;
    navigate(targetLink);
    setShowNotifications(false);
  };




  const handleAcceptFriend = async (e: React.MouseEvent, notifId: number, senderId: string) => {
    e.stopPropagation();
    if (processingNotifId === notifId) return;
    setProcessingNotifId(notifId);

    try {
      // Call server endpoint which uses supabaseAdmin
      const result = await notificationsApi.acceptFriend(notifId);

      if (result.success) {
        showToast('Friend request accepted!', 'success');
        // Local state for immediate UI update
        setAcceptedNotifIds(prev => new Set(prev).add(notifId));
        markNotificationRead(notifId);
      }
    } catch (err: any) {
      console.error('Accept friend error:', err);
      showToast(err.message || 'Failed to accept request', 'error');
    } finally {
      setProcessingNotifId(null);
    }
  };


  const analysisUnreadCount = visibleNotifications.filter(n => n.unread && n.text?.startsWith('[Analysis -')).length;
  const settingsHasUnread = visibleNotifications.some(n => n.unread && n.text?.includes('[Membership]'));

  // No more pseudo notifications — all notifications come from the database
  const totalUnreadCount = unreadCount;
  const allDisplayed = displayedNotifications;

  return (
    <nav className="sticky top-0 z-50 w-full border-b border-gray-200/70 dark:border-gray-800 bg-surface-light/80 dark:bg-surface-dark/80 backdrop-blur-md supports-[backdrop-filter]:bg-surface-light/60 pt-6 pb-2 lg:pt-8 lg:pb-3 transition-padding duration-300">
      <div className="w-full px-4 sm:px-6 flex items-center justify-between min-h-[48px]">
        {/* Logo Area - Always Visible */}
        <Link to="/dashboard" className="flex items-center gap-2 group cursor-pointer shrink-0">
          <div className="w-8 h-8 bg-primary rounded-lg flex items-center justify-center text-text-main shadow-glow transition-transform group-hover:scale-105 overflow-hidden">
            <span className="material-symbols-outlined font-bold" style={{ fontSize: '20px' }}>function</span>
          </div>
          <h1 className="text-lg sm:text-xl font-bold tracking-tight text-text-main dark:text-white">NewMaoS</h1>
        </Link>

        {/* Central Navigation - Scrollable on mobile, Centered on desktop */}
        <div
          className="flex-1 flex items-center justify-start sm:justify-center gap-2 lg:gap-3 overflow-x-auto no-scrollbar mx-2 sm:mx-4 pl-2 pr-6 sm:px-0 [&::-webkit-scrollbar]:hidden"
          style={{
            scrollbarWidth: 'none',
            msOverflowStyle: 'none'
          }}
        >
          <Link
            to="/dashboard"
            className={`shrink-0 text-sm font-medium px-4 py-1.5 rounded-lg transition-all relative whitespace-nowrap ${location.pathname === '/dashboard' ? 'text-text-main dark:text-white bg-primary/15 font-bold' : 'text-text-secondary dark:text-gray-400 hover:text-text-main dark:hover:text-white hover:bg-gray-100 dark:hover:bg-white/5'}`}
          >
            <span>Dashboard</span>
            {needsCheckin && (
              <span className="absolute -top-1 -right-1 min-w-[14px] h-3.5 flex items-center justify-center bg-red-500 text-white text-[8px] font-black rounded-full px-1 shadow-sm ring-1 ring-white dark:ring-surface-dark">
                1
              </span>
            )}
          </Link>
          <Link to="/practice" className={`shrink-0 text-sm font-medium px-4 py-1.5 rounded-lg transition-all whitespace-nowrap ${isActive('/practice') ? 'text-text-main dark:text-white bg-primary/15 font-bold' : 'text-text-secondary dark:text-gray-400 hover:text-text-main dark:hover:text-white hover:bg-gray-100 dark:hover:bg-white/5'}`}>
            Practice
          </Link>
          {isAuthenticated && isPro ? (
            <Link to="/analysis" className={`shrink-0 text-sm font-medium px-4 py-1.5 rounded-lg transition-all flex items-center gap-1.5 relative whitespace-nowrap ${isActive('/analysis') ? 'text-text-main dark:text-white bg-primary/15 font-bold' : 'text-text-secondary dark:text-gray-400 hover:text-text-main dark:hover:text-white hover:bg-gray-100 dark:hover:bg-white/5'}`}>
              <span>Analysis</span>
              {analysisUnreadCount > 0 && (
                <span className="absolute -top-1 -right-1 min-w-[14px] h-3.5 flex items-center justify-center bg-red-500 text-white text-[8px] font-black rounded-full px-1 shadow-sm ring-1 ring-white dark:ring-surface-dark transition-transform group-hover:scale-110">
                  {analysisUnreadCount > 9 ? '9+' : analysisUnreadCount}
                </span>
              )}
            </Link>
          ) : (
            <div
              className="relative group cursor-pointer shrink-0"
              onClick={() => isAuthenticated ? setShowPaywall(true) : navigate('/login')}
            >
              <div className="text-sm font-medium px-4 py-1.5 rounded-lg transition-all flex items-center gap-1.5 text-text-secondary dark:text-gray-400 opacity-60 whitespace-nowrap">
                <span>Analysis</span>
                <span className="material-symbols-outlined text-[16px] ml-0.5">lock</span>
              </div>
              <div className="absolute bottom-full left-1/2 -translate-x-1/2 mb-2 px-3 py-1.5 bg-gray-900 dark:bg-gray-700 text-white text-xs rounded-lg whitespace-nowrap opacity-0 group-hover:opacity-100 transition-opacity pointer-events-none z-[100]">
                {!isAuthenticated ? "Sign in required" : "Pro Membership required"}
                <div className="absolute top-full left-1/2 -translate-x-1/2 -mt-1 border-4 border-transparent border-t-gray-900 dark:border-t-gray-700"></div>
              </div>
            </div>
          )}
          {isAuthenticated && isPro ? (
            <Link to="/forum" className={`shrink-0 text-sm font-medium px-4 py-1.5 rounded-lg transition-all flex items-center gap-1.5 relative whitespace-nowrap ${isActive('/forum') ? 'text-text-main dark:text-white bg-primary/15 font-bold' : 'text-text-secondary dark:text-gray-400 hover:text-text-main dark:hover:text-white hover:bg-gray-100 dark:hover:bg-white/5'}`}>
              <span>Forum</span>
              {totalUnreadChatCount > 0 && (
                <span className="absolute -top-1 -right-1 min-w-[16px] h-4 flex items-center justify-center bg-red-500 text-white text-[9px] font-black rounded-full px-1 shadow-sm ring-2 ring-white dark:ring-surface-dark group-hover:scale-110 transition-transform">
                  {totalUnreadChatCount > 99 ? '99+' : totalUnreadChatCount}
                </span>
              )}
            </Link>
          ) : (
            <div
              className="relative group cursor-pointer shrink-0"
              onClick={() => isAuthenticated ? setShowPaywall(true) : navigate('/login')}
            >
              <div className="text-sm font-medium px-4 py-1.5 rounded-lg transition-all flex items-center gap-1.5 text-text-secondary dark:text-gray-400 opacity-60 whitespace-nowrap">
                <span>Forum</span>
                <span className="material-symbols-outlined text-[16px] ml-0.5">lock</span>
              </div>
              <div className="absolute bottom-full left-1/2 -translate-x-1/2 mb-2 px-3 py-1.5 bg-gray-900 dark:bg-gray-700 text-white text-xs rounded-lg whitespace-nowrap opacity-0 group-hover:opacity-100 transition-opacity pointer-events-none z-[100]">
                {!isAuthenticated ? "Sign in required" : "Pro Membership required"}
                <div className="absolute top-full left-1/2 -translate-x-1/2 -mt-1 border-4 border-transparent border-t-gray-900 dark:border-t-gray-700"></div>
              </div>
            </div>
          )}
          {isAuthenticated ? (
            <Link
              to="/settings"
              className={`shrink-0 text-sm font-medium px-4 py-1.5 rounded-lg transition-all relative whitespace-nowrap ${isActive('/settings') ? 'text-text-main dark:text-white bg-primary/15 font-bold' : 'text-text-secondary dark:text-gray-400 hover:text-text-main dark:hover:text-white hover:bg-gray-100 dark:hover:bg-white/5'}`}
            >
              <span>Settings</span>
              {settingsHasUnread && (
                <span className="absolute -top-1 -right-1 min-w-[14px] h-3.5 flex items-center justify-center bg-red-500 text-white text-[8px] font-black rounded-full px-1 shadow-sm ring-1 ring-white dark:ring-surface-dark transition-transform group-hover:scale-110">
                  1
                </span>
              )}
            </Link>
          ) : (
            <div className="relative group shrink-0">
              <div className="text-sm font-medium px-4 py-1.5 rounded-lg transition-all flex items-center gap-1.5 text-text-secondary dark:text-gray-400 cursor-not-allowed opacity-60 whitespace-nowrap">
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

        {/* Right Actions - Always Visible */}
        <div className="flex items-center gap-2 sm:gap-4 shrink-0">

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
              <PointsBalanceBadge
                balance={userPoints.balance}
                onClick={() => navigate('/points')}
                ref={pointsBalanceRef as any}
              />
              {/* Notifications */}
              <div className="relative" ref={notifRef}>
                <button
                  onClick={handleBellClick}
                  className={`w-8 h-8 flex items-center justify-center rounded-full transition-colors ${showNotifications ? 'bg-primary/20 text-text-main' : 'text-text-secondary hover:bg-gray-100 dark:hover:bg-white/10'}`}
                >
                  <span className="material-symbols-outlined" style={{ fontSize: '20px' }}>notifications</span>
                  {totalUnreadCount > 0 && (
                    <span className="absolute -top-1 -right-1 min-w-[16px] h-4 flex items-center justify-center bg-red-500 text-white text-[9px] font-black rounded-full px-1 shadow-sm ring-2 ring-white dark:ring-surface-dark transition-transform">
                      {totalUnreadCount > 99 ? '99+' : totalUnreadCount}
                    </span>
                  )}
                </button>

                {/* Notification Dropdown */}
                {showNotifications && (
                  <div className="absolute right-0 mt-2 w-80 bg-white dark:bg-surface-dark rounded-xl shadow-xl border border-gray-200 dark:border-gray-800 overflow-hidden animate-fade-in origin-top-right">
                    <div className="p-3 border-b border-gray-100 dark:border-gray-800/50 flex justify-between items-center">
                      <span className="text-sm font-bold">Notifications</span>
                      {totalUnreadCount > 0 && (
                        <button
                          onClick={() => {
                            markAllNotificationsRead();
                            dismissProUpgrade();
                          }}
                          className="text-[10px] font-bold text-primary hover:text-primary/80 transition-colors"
                        >
                          Mark all read
                        </button>
                      )}
                    </div>
                    <div className="max-h-[300px] overflow-y-auto scroll-bounce">
                      {allDisplayed.length > 0 ? (
                        allDisplayed.map(notif => {


                          // Parse link for action
                          let senderId = null;
                          if (notif.link && notif.link.includes('action=friend_request')) {
                            const urlParams = new URLSearchParams(notif.link.split('?')[1]);
                            senderId = urlParams.get('sender_id');
                          }

                          // Check if item was already accepted (from persistent metadata or session state)
                          const isAccepted = notif.isAccepted ||
                            acceptedNotifIds.has(notif.id) ||
                            (notif.metadata?.accepted === true);

                          return (
                            <div
                              key={notif.id}
                              onClick={() => handleNotificationClick(notif.id, notif.link, notif.type)}
                              className={`p-3 border-b border-gray-100 dark:border-gray-800/50 hover:bg-gray-50 dark:hover:bg-white/5 transition-colors cursor-pointer flex gap-3 ${notif.unread ? 'bg-blue-50/50 dark:bg-blue-900/20' : ''}`}
                            >
                              <div className={`mt-1.5 min-w-[8px] h-2 rounded-full ${notif.unread ? 'bg-primary' : 'bg-transparent'}`}></div>
                              <div className="flex flex-col gap-0.5 w-full">
                                <p className={`text-[11px] leading-relaxed mb-0.5 ${notif.unread ? 'font-bold text-text-main dark:text-zinc-100' : 'font-medium text-text-secondary dark:text-gray-400'}`}>
                                  {notif.text}
                                </p>
                                {senderId && !isAccepted && (
                                  <div className="mt-2 flex gap-2">
                                    <button
                                      onClick={(e) => senderId && handleAcceptFriend(e, notif.id, senderId)}
                                      className="px-3 py-1 bg-black dark:bg-white text-white dark:text-black text-[10px] font-bold rounded-lg hover:opacity-80 transition-opacity"
                                    >
                                      Accept
                                    </button>
                                  </div>
                                )}
                                {isAccepted && notif.type !== 'gift_claim' && (
                                  <div className="mt-2">
                                    <span className="px-2 py-0.5 bg-green-100 text-green-700 dark:bg-green-900/30 dark:text-green-400 text-[10px] font-bold rounded">
                                      Accepted
                                    </span>
                                  </div>
                                )}
                                <p className="text-[10px] text-gray-400 mt-1">{notif.time}</p>
                              </div>
                            </div>
                          );
                        })
                      ) : (
                        <div className="p-4 text-center text-xs text-gray-400">
                          No notifications
                        </div>
                      )}
                    </div>

                  </div>
                )}
              </div>

              {/* User Menu */}
              <div className="relative" ref={profileRef}>
                <div
                  onClick={() => setShowProfileMenu(!showProfileMenu)}
                  className="w-9 h-9 rounded-full bg-gray-200 overflow-hidden ring-2 ring-white dark:ring-gray-700 shadow-sm cursor-pointer hover:ring-primary transition-all"
                  style={{ backgroundImage: `url(${user.avatarUrl})`, backgroundSize: 'cover' }}
                >
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
            <div className="flex items-center gap-3">
              <Link
                to="/login"
                className="hidden sm:block text-sm font-bold text-text-secondary hover:text-text-main dark:text-gray-400 dark:hover:text-white transition-colors"
              >
                Sign In
              </Link>
              <Link
                to="/signup"
                className="px-4 py-2 bg-black dark:bg-white text-white dark:text-black rounded-lg text-sm font-bold shadow-sm hover:opacity-80 transition-all"
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

      {newlyUnlockedTitle && (
        <AchievementUnlockModal
          title={newlyUnlockedTitle}
          onClose={() => setNewlyUnlockedTitle(null)}
        />
      )}
    </nav>
  );
};