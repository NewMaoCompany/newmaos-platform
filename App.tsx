import React from 'react';
import { HashRouter as Router, Routes, Route, Navigate, useLocation } from 'react-router-dom';
import { AppProvider, useApp } from './AppContext';
import { ToastProvider } from './components/Toast';
import { ErrorBoundary } from './components/ErrorBoundary';
import { Login } from './pages/Login';
import { Dashboard } from './pages/Dashboard';
import { PracticeHub } from './pages/PracticeHub';
import { Practice } from './pages/Practice';
import { Analysis } from './pages/Analysis';
import { Forum } from './pages/Forum';
import { Settings } from './pages/Settings';
import { ProfileSettings, SecuritySettings, SubscriptionSettings } from './pages/SettingsSubpages';
import { Privacy, Terms, Support, Signup } from './pages/StaticPages';
import { ResetPassword } from './pages/ResetPassword';
import { VerifyEmail } from './pages/VerifyEmail';
import { TopicDetail } from './pages/TopicDetail';
import { QuestionCreator } from './pages/QuestionCreator';
import { Insights } from './pages/Insights';
import { Profile } from './pages/Profile';
import { PointsPage } from './pages/PointsPage';
import { CheckinPage } from './pages/CheckinPage';
import { DebugQA } from './pages/DebugQA';
import { PrestigePage } from './pages/PrestigePage';
import { StardustPage } from './pages/StardustPage';
import { ProWelcomeModal } from './components/ProWelcomeModal';
import { useNavigate } from 'react-router-dom';
import { StreakModal } from './components/StreakModal';
import { useState, useEffect } from 'react';
import { CoinCollector } from './components/CoinCollector';

const ProtectedRoute = ({ children }: React.PropsWithChildren) => {
  const { isAuthenticated, isAuthLoading } = useApp();

  // Show nothing while restoring session
  if (isAuthLoading) {
    return (
      <div className="flex items-center justify-center min-h-screen bg-surface-light dark:bg-surface-dark">
        <div className="w-8 h-8 border-4 border-primary border-t-transparent rounded-full animate-spin"></div>
      </div>
    );
  }

  if (!isAuthenticated) {
    return <Navigate to="/login" replace />;
  }
  return <>{children}</>;
};

const PageLayer = ({ active, children, zIndex = 0 }: { active: boolean; children: React.ReactNode; zIndex?: number }) => (
  <div
    className={`absolute inset-0 ${active ? 'opacity-100 pointer-events-auto' : 'opacity-0 pointer-events-none'}`}
    style={{ zIndex }}
  >
    {children}
  </div>
);

// --- Auto-Read Notifications on Route Change ---
const AutoReadHandler = () => {
  const location = useLocation();
  const { notifications, markNotificationRead } = useApp();

  useEffect(() => {
    const currentPath = location.pathname + location.search;

    // Find unread notifications whose link matches current path
    const matchingNotifications = notifications.filter(n =>
      n.unread &&
      (n.link === currentPath || (n.link === '/dashboard' && location.pathname === '/'))
    );

    matchingNotifications.forEach(n => {
      console.log(`[AutoRead] Marking notification ${n.id} as read (linked to ${n.link})`);
      markNotificationRead(n.id);
    });
  }, [location.pathname, location.search, notifications, markNotificationRead]);

  return null;
};

const AppRoutes = () => {
  const { isAuthLoading, isAuthenticated, user, recordLoginStreak, setIsStreakModalOpen } = useApp();
  const location = useLocation();
  const path = location.pathname;

  // Streak Modal State
  const [showStreakModal, setShowStreakModal] = useState(false);
  const [streakCount, setStreakCount] = useState(0);
  const [checkinResult, setCheckinResult] = useState<any>(null);
  const [isStreakRecovery, setIsStreakRecovery] = useState(false);

  // --- Handle Login Streak (Global Trigger — separate from manual check-in) ---
  useEffect(() => {
    const doLoginStreak = async () => {
      if (!isAuthenticated || !user?.id) return;

      // Only trigger on "Main" entry pages (Dashboard or Practice) 
      const isEntryPage = path === '/dashboard' || path === '/' || path === '/practice';
      if (!isEntryPage) return;

      try {
        const hasLoggedToday = sessionStorage.getItem('login_streak_today');
        if (hasLoggedToday) return;

        const result = await recordLoginStreak();

        if (result.success) {
          sessionStorage.setItem('login_streak_today', 'true');
          setStreakCount(result.streak || 1);
          setIsStreakRecovery(false);
          setCheckinResult({
            basePoints: result.points || 10,
            bonusPoints: 0,
            totalPoints: result.points || 10,
            isMilestone: false,
            alreadyCheckedIn: false,
          });
          setIsStreakModalOpen(true);
          setShowStreakModal(true);
        } else if (result.reason === 'already_logged_today') {
          sessionStorage.setItem('login_streak_today', 'true');
        }
      } catch (err) {
        console.error('Login streak exception:', err);
      }
    };

    doLoginStreak();
  }, [isAuthenticated, user?.id, path, recordLoginStreak]);

  if (isAuthLoading) {
    return (
      <div className="flex items-center justify-center min-h-screen bg-surface-light dark:bg-surface-dark">
        <div className="w-8 h-8 border-4 border-primary border-t-transparent rounded-full animate-spin"></div>
      </div>
    );
  }


  // Define Main Pages
  const isDashboard = path === '/dashboard' || path === '/';
  const isPractice = path === '/practice';
  const isAnalysis = path === '/analysis';
  const isForum = path.startsWith('/forum');
  const isSettings = path === '/settings';

  // Check if we are on any main page
  const isOnMainPage = isDashboard || isPractice || isAnalysis || isForum || isSettings;
  const isPracticeSession = path.startsWith('/practice/session') || path.startsWith('/practice/unit/');

  return (
    <div className={`h-screen w-full bg-surface-light dark:bg-surface-dark overflow-x-auto overflow-y-hidden relative ${isPracticeSession ? '' : 'min-w-[360px]'}`}>


      {/* Persistent Page Layers (Main 5) */}
      <>
        <PageLayer active={isDashboard} zIndex={isDashboard ? 40 : 10}>
          <Dashboard />
        </PageLayer>

        <PageLayer active={isPractice} zIndex={isPractice ? 40 : 10}>
          <PracticeHub />
        </PageLayer>

        {isAuthenticated && (
          <>
            <PageLayer active={isAnalysis} zIndex={isAnalysis ? 40 : 10}>
              <Analysis />
            </PageLayer>

            <PageLayer active={isForum} zIndex={isForum ? 50 : 10}>
              <Forum />
            </PageLayer>

            <PageLayer active={isSettings} zIndex={isSettings ? 40 : 10}>
              <Settings />
            </PageLayer>
          </>
        )}
      </>

      {/* Redirect to login if unauthenticated and on a main page that REQUIRES auth */}
      {!isAuthenticated && (isAnalysis || isForum || isSettings) && <Navigate to="/login" replace />}

      {/* Sub-Routes & Non-Main Pages Layer (Always visible if NOT on a main page layer) */}
      <div className={`absolute inset-0 z-[60] overflow-y-auto transition-opacity duration-300 ${isOnMainPage ? 'opacity-0 pointer-events-none' : 'opacity-100 pointer-events-auto'}`}>
        <Routes>
          {/* Auth Pages (Always visible if not on main page) */}
          {!isAuthenticated && (
            <>
              <Route path="/login" element={<Login />} />
              <Route path="/signup" element={<Signup />} />
              <Route path="/reset-password" element={<ResetPassword />} />
              <Route path="/verify-email" element={<VerifyEmail />} />
            </>
          )}

          {/* Sub-pages and Details (Overlay on main layers) */}
          <Route path="/practice/unit/:unitId" element={<TopicDetail />} />
          <Route path="/practice/session" element={<Practice />} />
          <Route path="/insights" element={<ProtectedRoute><Insights /></ProtectedRoute>} />
          <Route path="/prestige" element={<ProtectedRoute><PrestigePage /></ProtectedRoute>} />
          <Route path="/stardust" element={<ProtectedRoute><StardustPage /></ProtectedRoute>} />
          <Route path="/profile/:userId" element={<ProtectedRoute><Profile /></ProtectedRoute>} />
          <Route path="/points" element={<ProtectedRoute><PointsPage /></ProtectedRoute>} />
          <Route path="/checkin" element={<ProtectedRoute><CheckinPage /></ProtectedRoute>} />

          {/* Settings Subpages */}
          <Route path="/settings/profile" element={<ProtectedRoute><ProfileSettings /></ProtectedRoute>} />
          <Route path="/settings/security" element={<ProtectedRoute><SecuritySettings /></ProtectedRoute>} />
          <Route path="/settings/subscription" element={<ProtectedRoute><SubscriptionSettings /></ProtectedRoute>} />
          <Route path="/settings/creator" element={<ProtectedRoute><QuestionCreator /></ProtectedRoute>} />
          <Route path="/debug-qa" element={<ProtectedRoute><DebugQA /></ProtectedRoute>} />

          {/* Static Pages */}
          <Route path="/privacy" element={<Privacy />} />
          <Route path="/terms" element={<Terms />} />
          <Route path="/support" element={<Support />} />

          {/* Catch-all to make the URL reflect the state, though the layers handle visibility */}
          <Route path="/dashboard" element={<div />} />
          <Route path="/practice" element={<div />} />
          <Route path="/analysis" element={<div />} />
          <Route path="/forum" element={<div />} />
          <Route path="/settings" element={<div />} />
          <Route path="/" element={<Navigate to="/dashboard" replace />} />
        </Routes>
      </div>

      {/* Global Daily Streak Modal */}
      <StreakModal
        isOpen={showStreakModal}
        streak={streakCount}
        onClose={() => { setShowStreakModal(false); setIsStreakModalOpen(false); }}
        isRecovery={isStreakRecovery}
        checkinResult={checkinResult}
      />
    </div>
  );
};

const App = () => {
  return (
    <ToastProvider>
      <ErrorBoundary>
        <AppProvider>
          <Router>
            <AutoReadHandler />
            <CoinCollector />
            <AppRoutes />
            <ProWelcomeModal />
          </Router>
        </AppProvider>
      </ErrorBoundary>
    </ToastProvider>
  );
};

export default App;