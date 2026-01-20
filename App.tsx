import React from 'react';
import { HashRouter as Router, Routes, Route, Navigate } from 'react-router-dom';
import { AppProvider, useApp } from './AppContext';
import { ToastProvider } from './components/Toast';
import { ErrorBoundary } from './components/ErrorBoundary';
import { Login } from './pages/Login';
import { Dashboard } from './pages/Dashboard';
import { PracticeHub } from './pages/PracticeHub';
import { Practice } from './pages/Practice';
import { Analysis } from './pages/Analysis';
import { Settings } from './pages/Settings';
import { ProfileSettings, SecuritySettings, BillingSettings } from './pages/SettingsSubpages';
import { Privacy, Terms, Support, Signup } from './pages/StaticPages';
import { ResetPassword } from './pages/ResetPassword';
import { VerifyEmail } from './pages/VerifyEmail';
import { TopicDetail } from './pages/TopicDetail';
import { QuestionCreator } from './pages/QuestionCreator';
import { Insights } from './pages/Insights';

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

const AppRoutes = () => {
  return (
    <Routes>
      <Route path="/login" element={<Login />} />
      <Route path="/signup" element={<Signup />} />
      <Route path="/reset-password" element={<ResetPassword />} />
      <Route path="/verify-email" element={<VerifyEmail />} />

      {/* Main Pages - Accessible to Guests now */}
      <Route path="/dashboard" element={<Dashboard />} />
      <Route path="/practice" element={<PracticeHub />} />
      <Route path="/practice/unit/:unitId" element={<TopicDetail />} />
      <Route path="/practice/session" element={<Practice />} />
      <Route path="/analysis" element={<Analysis />} />
      <Route path="/insights" element={<ProtectedRoute><Insights /></ProtectedRoute>} />

      {/* Settings - Keep Protected or handle logic inside */}
      <Route path="/settings" element={<ProtectedRoute><Settings /></ProtectedRoute>} />
      <Route path="/settings/profile" element={<ProtectedRoute><ProfileSettings /></ProtectedRoute>} />
      <Route path="/settings/security" element={<ProtectedRoute><SecuritySettings /></ProtectedRoute>} />
      <Route path="/settings/billing" element={<ProtectedRoute><BillingSettings /></ProtectedRoute>} />
      <Route path="/settings/creator" element={<ProtectedRoute><QuestionCreator /></ProtectedRoute>} />

      {/* Static Pages */}
      <Route path="/privacy" element={<Privacy />} />
      <Route path="/terms" element={<Terms />} />
      <Route path="/support" element={<Support />} />

      <Route path="/" element={<Navigate to="/dashboard" replace />} />
      <Route path="*" element={<Navigate to="/dashboard" replace />} />
    </Routes>
  )
}

const App = () => {
  return (
    <ToastProvider>
      <ErrorBoundary>
        <AppProvider>
          <Router>
            <AppRoutes />
          </Router>
        </AppProvider>
      </ErrorBoundary>
    </ToastProvider>
  );
};

export default App;