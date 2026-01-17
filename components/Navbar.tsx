import React, { useState, useEffect, useRef } from 'react';
import { useApp } from '../AppContext';
import { Link, useLocation, useNavigate } from 'react-router-dom';
import { useToast } from './Toast';

export const Navbar = () => {
  const { user, logout, isAuthenticated, notifications, markAllNotificationsRead, markNotificationRead } = useApp();
  const location = useLocation();
  const navigate = useNavigate();
  const { showToast } = useToast();
  const [showNotifications, setShowNotifications] = useState(false);
  const [showProfileMenu, setShowProfileMenu] = useState(false);
  const [viewAll, setViewAll] = useState(false); // State for View All

  const notifRef = useRef<HTMLDivElement>(null);
  const profileRef = useRef<HTMLDivElement>(null);

  const isActive = (path: string) => location.pathname.startsWith(path);
  const unreadCount = notifications.filter(n => n.unread).length;

  // Logic: Show 3 by default, or all if viewAll is true
  const displayedNotifications = viewAll ? notifications : notifications.slice(0, 3);

  // Close dropdowns when clicking outside
  useEffect(() => {
    const handleClickOutside = (event: MouseEvent) => {
      if (notifRef.current && !notifRef.current.contains(event.target as Node)) {
        setShowNotifications(false);
        setViewAll(false); // Reset view all on close
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
    const newState = !showNotifications;
    setShowNotifications(newState);
    if (newState && unreadCount > 0) {
      // Clear red dot on open
      markAllNotificationsRead();
    }
  };

  const handleNotificationClick = (id: number, link: string) => {
    // Navigate
    navigate(link);
    setShowNotifications(false);
  };

  return (
    <nav className="sticky top-0 z-50 w-full border-b border-gray-200/70 dark:border-gray-800 bg-surface-light/80 dark:bg-surface-dark/80 backdrop-blur-md supports-[backdrop-filter]:bg-surface-light/60">
      <div className="max-w-7xl mx-auto px-6 h-16 flex items-center justify-between">
        {/* Logo Area */}
        <Link to="/dashboard" className="flex items-center gap-2 group cursor-pointer">
          <div className="w-8 h-8 bg-primary rounded-lg flex items-center justify-center text-text-main shadow-glow transition-transform group-hover:scale-105">
            <span className="material-symbols-outlined font-bold" style={{ fontSize: '20px' }}>function</span>
          </div>
          <h1 className="text-xl font-bold tracking-tight text-text-main dark:text-white">NewMaoS</h1>
        </Link>

        {/* Central Navigation */}
        <div className="hidden md:flex items-center gap-8">
          <Link to="/dashboard" className={`text-sm font-medium transition-colors ${location.pathname === '/dashboard' ? 'text-text-main dark:text-white' : 'text-text-secondary dark:text-gray-400 hover:text-text-main dark:hover:text-white'}`}>
            Dashboard
          </Link>
          <Link to="/practice" className={`text-sm font-medium transition-colors ${isActive('/practice') ? 'text-text-main dark:text-white' : 'text-text-secondary dark:text-gray-400 hover:text-text-main dark:hover:text-white'}`}>
            Practice
          </Link>
          <Link to="/analysis" className={`text-sm font-medium transition-colors ${isActive('/analysis') ? 'text-text-main dark:text-white' : 'text-text-secondary dark:text-gray-400 hover:text-text-main dark:hover:text-white'}`}>
            Analysis
          </Link>
          <Link to="/settings" className={`text-sm font-medium transition-colors ${isActive('/settings') ? 'text-text-main dark:text-white' : 'text-text-secondary dark:text-gray-400 hover:text-text-main dark:hover:text-white'}`}>
            Settings
          </Link>
        </div>

        {/* Right Actions */}
        <div className="flex items-center gap-4">

          {isAuthenticated ? (
            <>
              {/* Notifications */}
              <div className="relative" ref={notifRef}>
                <button
                  onClick={handleBellClick}
                  className={`w-8 h-8 flex items-center justify-center rounded-full transition-colors ${showNotifications ? 'bg-primary/20 text-text-main' : 'text-text-secondary hover:bg-gray-100 dark:hover:bg-white/10'}`}
                >
                  <span className="material-symbols-outlined" style={{ fontSize: '20px' }}>notifications</span>
                  {unreadCount > 0 && (
                    <span className="absolute top-1.5 right-1.5 w-2 h-2 bg-red-500 rounded-full border border-white dark:border-surface-dark animate-pulse"></span>
                  )}
                </button>

                {/* Notification Dropdown */}
                {showNotifications && (
                  <div className="absolute right-0 mt-2 w-80 bg-white dark:bg-surface-dark rounded-xl shadow-xl border border-gray-200 dark:border-gray-800 overflow-hidden animate-fade-in origin-top-right">
                    <div className="p-3 border-b border-gray-100 dark:border-gray-800/50 flex justify-between items-center">
                      <span className="text-sm font-bold">Notifications</span>
                    </div>
                    <div className="max-h-[300px] overflow-y-auto">
                      {notifications.length > 0 ? (
                        displayedNotifications.map(notif => (
                          <div
                            key={notif.id}
                            onClick={() => handleNotificationClick(notif.id, notif.link)}
                            className={`p-3 border-b border-gray-100 dark:border-gray-800/50 hover:bg-gray-50 dark:hover:bg-white/5 transition-colors cursor-pointer flex gap-3 ${notif.unread ? 'bg-blue-50/50 dark:bg-blue-900/20' : ''}`}
                          >
                            <div className={`mt-1.5 min-w-[8px] h-2 rounded-full ${notif.unread ? 'bg-primary' : 'bg-transparent'}`}></div>
                            <div className="flex flex-col gap-0.5">
                              <p className={`text-xs ${notif.unread ? 'font-bold text-text-main dark:text-white' : 'font-medium text-gray-600 dark:text-gray-300'}`}>
                                {notif.text}
                              </p>
                              <p className="text-[10px] text-gray-400">{notif.time}</p>
                            </div>
                          </div>
                        ))
                      ) : (
                        <div className="p-4 text-center text-xs text-gray-400">
                          No notifications
                        </div>
                      )}
                    </div>
                    {notifications.length > 3 && !viewAll && (
                      <div className="p-2 text-center border-t border-gray-100 dark:border-gray-800/50">
                        <button
                          onClick={() => setViewAll(true)}
                          className="text-xs font-semibold text-gray-500 hover:text-text-main transition-colors"
                        >
                          View All
                        </button>
                      </div>
                    )}
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
    </nav>
  );
};