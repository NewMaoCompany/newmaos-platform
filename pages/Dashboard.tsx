import React, { useState, useEffect } from 'react';
import { useApp } from '../AppContext';
import { Navbar } from '../components/Navbar';
import { useNavigate, Link } from 'react-router-dom';
import { CourseType } from '../types';

const RadialProgress = ({ percentage }: { percentage: number }) => {
  const radius = 30;
  const circumference = 2 * Math.PI * radius;
  const strokeDashoffset = circumference - (percentage / 100) * circumference;

  return (
    <div className="relative w-20 h-20 flex items-center justify-center group">
      <svg className="w-full h-full -rotate-90" viewBox="0 0 80 80">
        <circle cx="40" cy="40" r={radius} fill="none" stroke="currentColor" strokeWidth="8" className="text-gray-100 dark:text-gray-800" />
        <circle
          cx="40"
          cy="40"
          r={radius}
          fill="none"
          stroke="currentColor"
          strokeWidth="8"
          strokeDasharray={circumference}
          strokeDashoffset={strokeDashoffset}
          strokeLinecap="round"
          className="text-primary transition-all duration-1000 ease-out"
        />
      </svg>
      <span className="absolute font-bold text-xl text-text-main dark:text-white group-hover:scale-110 transition-transform">
        {percentage === 0 ? '-' : (percentage >= 90 ? 'A' : percentage >= 80 ? 'B' : 'C')}
      </span>
    </div>
  );
};

export const Dashboard = () => {
  const { user, courses, toggleCourse, startCourse, lineData, isAuthenticated, isAuthLoading, hasDismissedLoginPrompt, dismissLoginPrompt, getCourseMastery } = useApp();
  const navigate = useNavigate();
  const [showLoginPrompt, setShowLoginPrompt] = useState(false);
  const [todayIndex, setTodayIndex] = useState(0);

  // Trigger login modal ONLY after auth loading completes and user is NOT authenticated
  useEffect(() => {
    // Don't decide until loading is done
    if (isAuthLoading) return;

    if (!isAuthenticated && !hasDismissedLoginPrompt) {
      // Small delay for smoother entrance
      const timer = setTimeout(() => setShowLoginPrompt(true), 500);
      return () => clearTimeout(timer);
    } else {
      // User is authenticated or has dismissed - ensure popup is hidden
      setShowLoginPrompt(false);
    }
  }, [isAuthenticated, isAuthLoading, hasDismissedLoginPrompt]);

  // Determine current day of the week (0=Sun, 1=Mon... 6=Sat) on mount
  useEffect(() => {
    setTodayIndex(new Date().getDay());
  }, []);

  // Show loading spinner while auth is being determined to prevent flash
  if (isAuthLoading) {
    return (
      <div className="flex items-center justify-center min-h-screen bg-surface-light dark:bg-surface-dark">
        <div className="flex flex-col items-center gap-4">
          <div className="w-10 h-10 border-4 border-primary border-t-transparent rounded-full animate-spin"></div>
          <span className="text-sm text-gray-500 font-medium">Loading...</span>
        </div>
      </div>
    );
  }

  const handleDismissPrompt = () => {
    setShowLoginPrompt(false);
    dismissLoginPrompt();
  };

  // Calculate dynamic trend based on the last two data points
  const currentMetric = lineData[lineData.length - 1].value;
  const previousMetric = lineData.length > 1 ? lineData[lineData.length - 2].value : currentMetric;
  const trendValue = (currentMetric - previousMetric).toFixed(1);
  const isPositive = parseFloat(trendValue) >= 0;

  // Get current course mastery dynamically
  const currentCourseMastery = getCourseMastery(user.currentCourse);

  const handleCardSelect = (type: CourseType) => {
    if (user.currentCourse !== type) {
      toggleCourse(type);
    }
  };

  const handleStartSession = (e: React.MouseEvent, type: CourseType) => {
    e.stopPropagation();
    const course = courses[type];

    // Logic: If Not Started, switch to In Progress.
    if (course.status === 'Not Started') {
      startCourse(type);
    } else if (user.currentCourse !== type) {
      // If already in progress but not active, just switch to it.
      toggleCourse(type);
    }
    // Navigate to practice hub
    navigate('/practice');
  };

  const CourseCard = ({ type }: { type: CourseType }) => {
    const course = courses[type];
    const isActive = user.currentCourse === type;
    // const currentModule = course.modules[course.currentModuleIndex]; // Deprecated for display
    const isInProgress = course.status === 'In Progress';
    const mastery = getCourseMastery(type);

    return (
      <div
        onClick={() => handleCardSelect(type)}
        className={`group relative overflow-hidden bg-surface-light dark:bg-surface-dark rounded-[32px] p-8 border-2 transition-all duration-300 cursor-pointer flex flex-col justify-between h-full min-h-[340px]
            ${isActive ? 'border-primary shadow-soft scale-[1.01] z-10' : 'border-white dark:border-white/5 hover:border-gray-200 dark:hover:border-gray-700'}`}
      >
        {/* Background Icon */}
        <div className="absolute top-8 right-8 opacity-5 pointer-events-none">
          <span className={`material-symbols-outlined text-[140px] ${isActive ? 'text-primary' : 'text-gray-500'}`}>
            {type === 'AB' ? 'functions' : 'all_inclusive'}
          </span>
        </div>

        <div className="relative z-10 flex flex-col items-start">
          <div className={`inline-flex items-center px-3 py-1 rounded-full text-[10px] font-bold uppercase tracking-wider mb-6
                    ${course.status === 'In Progress'
              ? 'bg-green-100 text-green-700 dark:bg-green-900/30 dark:text-green-400'
              : 'bg-gray-100 text-gray-500 dark:bg-white/10 dark:text-gray-400'}`}>
            {course.status}
          </div>

          <h3 className="text-3xl font-black text-text-main dark:text-white mb-2 tracking-tight">{course.title}</h3>

          <p className="text-text-secondary dark:text-gray-400 font-medium leading-relaxed max-w-[85%]">
            {type === 'AB'
              ? 'Track your mastery across all 8 units.'
              : 'Start your journey with Unit 1.'
            }
          </p>
        </div>

        <div className="relative z-10 mt-8 w-full">
          <button
            onClick={(e) => handleStartSession(e, type)}
            className={`w-full py-4 px-6 rounded-xl font-bold flex items-center justify-between gap-4 transition-all duration-200
                    ${isActive
                ? 'bg-primary text-text-main hover:brightness-105 shadow-md'
                : 'bg-gray-50 dark:bg-white/5 text-text-main dark:text-white hover:bg-gray-100 dark:hover:bg-white/10'
              }`}
          >
            <span className="truncate">{course.status === 'Not Started' ? 'Start Course' : 'Continue Learning'}</span>
            <span className="material-symbols-outlined shrink-0">arrow_forward</span>
          </button>
        </div>
      </div>
    );
  };

  const weekDays = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];

  return (
    <div className="min-h-screen flex flex-col bg-background-light dark:bg-background-dark text-text-main dark:text-gray-100 font-sans">
      <Navbar />

      <main className="flex-grow max-w-7xl mx-auto px-6 py-10 flex flex-col gap-12 w-full animate-fade-in">
        <header className="flex flex-col gap-2">
          <h2 className="text-4xl md:text-5xl font-black tracking-tight text-text-main dark:text-white">
            Hello, {user.name ? user.name.split(' ')[0] : 'Student'}
          </h2>
          <p className="text-xl text-text-secondary dark:text-gray-400 font-medium">
            Ready to conquer <span className="font-bold text-text-main dark:text-white">{courses[user.currentCourse].title}</span>
          </p>
        </header>

        <section className="flex flex-col gap-8">
          {/* Toggle - Visual only for quick switch context, actual switching happens on card click too */}
          <div className="flex justify-start">
            <div className="inline-flex bg-white dark:bg-white/5 p-1.5 rounded-2xl border border-gray-100 dark:border-white/5 shadow-sm">
              <button
                onClick={() => handleCardSelect('AB')}
                className={`px-6 py-2.5 rounded-xl text-sm font-bold transition-all duration-200 ${user.currentCourse === 'AB' ? 'bg-gray-100 text-black dark:bg-white dark:text-black shadow-sm' : 'text-gray-500 hover:text-gray-900 dark:text-gray-400'}`}
              >
                AP Calculus AB
              </button>
              <button
                onClick={() => handleCardSelect('BC')}
                className={`px-6 py-2.5 rounded-xl text-sm font-bold transition-all duration-200 ${user.currentCourse === 'BC' ? 'bg-gray-100 text-black dark:bg-white dark:text-black shadow-sm' : 'text-gray-500 hover:text-gray-900 dark:text-gray-400'}`}
              >
                AP Calculus BC
              </button>
            </div>
          </div>

          <div className="grid grid-cols-1 md:grid-cols-2 gap-6 items-stretch">
            <CourseCard type="AB" />
            <CourseCard type="BC" />
          </div>
        </section>

        <section>
          <h3 className="text-lg font-bold text-text-main dark:text-white mb-6 flex items-center gap-2">
            <span className="p-1.5 bg-primary rounded-md text-text-main">
              <span className="material-symbols-outlined text-lg block">analytics</span>
            </span>
            Current Performance
          </h3>

          <div className="grid grid-cols-1 md:grid-cols-3 gap-6">

            {/* Card 1: Mastery Rate */}
            <div
              className="bg-white dark:bg-surface-dark rounded-3xl p-6 border border-white dark:border-white/5 shadow-sm hover:shadow-md transition-all cursor-pointer flex items-center justify-between"
              onClick={() => navigate('/analysis')}
            >
              <div className="flex flex-col gap-2">
                <span className="text-sm font-bold text-gray-500 dark:text-gray-400">Mastery Rate</span>
                <div className="flex flex-col items-start">
                  <span className="text-4xl font-black text-text-main dark:text-white tracking-tighter">{currentCourseMastery}%</span>
                  <span className={`text-xs font-bold px-1.5 py-0.5 rounded mt-1 ${isPositive ? 'text-green-700 bg-green-100 dark:bg-green-900/30 dark:text-green-400' : 'text-red-600 bg-red-100'}`}>
                    {isPositive ? '+' : ''}{trendValue}%
                  </span>
                </div>
              </div>
              <RadialProgress percentage={currentCourseMastery} />
            </div>

            {/* Card 2: Problems Solved */}
            <div
              className="bg-white dark:bg-surface-dark rounded-3xl p-6 border border-white dark:border-white/5 shadow-sm hover:shadow-md transition-all cursor-pointer flex flex-col justify-between min-h-[160px]"
              onClick={() => navigate('/practice')}
            >
              <div className="flex justify-between items-start">
                <span className="text-sm font-bold text-gray-500 dark:text-gray-400">Problems Solved</span>
                <div className="bg-primary/20 p-2 rounded-lg text-yellow-700 dark:text-primary">
                  <span className="material-symbols-outlined block text-lg">edit_note</span>
                </div>
              </div>
              <div>
                <span className="text-4xl font-black text-text-main dark:text-white tracking-tighter">{user.problemsSolved}</span>
                <p className="text-xs font-bold text-gray-400 mt-1">Top {user.percentile}% of students</p>
              </div>
            </div>

            {/* Card 3: Study Time */}
            <div
              className="bg-white dark:bg-surface-dark rounded-3xl p-6 border border-white dark:border-white/5 shadow-sm hover:shadow-md transition-all cursor-pointer flex flex-col justify-between min-h-[160px]"
              onClick={() => navigate('/analysis')}
            >
              <div className="flex flex-col gap-1 mb-2">
                <span className="text-sm font-bold text-gray-500 dark:text-gray-400">Study Time</span>
                <div className="flex items-baseline gap-1">
                  {/* Dynamically show today's study hours */}
                  <span className="text-4xl font-black text-text-main dark:text-white tracking-tighter">{user.studyHours[todayIndex]}</span>
                  <span className="text-lg font-bold text-gray-400">hrs</span>
                </div>
              </div>

              <div className="flex flex-col gap-2">
                <div className="flex items-end gap-2 h-10 w-full">
                  {user.studyHours.map((hours, idx) => {
                    const isToday = idx === todayIndex;
                    const heightPercent = Math.max((hours / 6) * 100, 10); // Min height for visual
                    return (
                      <div key={idx} className="flex-1 flex flex-col justify-end h-full">
                        <div
                          className={`w-full rounded-sm transition-all duration-500 ${isToday ? 'bg-primary' : 'bg-gray-100 dark:bg-white/10'}`}
                          style={{ height: `${hours === 0 ? 4 : heightPercent}%` }}
                        ></div>
                      </div>
                    );
                  })}
                </div>
                <div className="flex justify-between text-[10px] font-bold text-gray-400 uppercase">
                  {/* Dynamically highlight current day letter */}
                  {weekDays.map((day, idx) => (
                    <span key={idx} className={idx === todayIndex ? "text-primary" : ""}>{day}</span>
                  ))}
                </div>
              </div>
            </div>

          </div>
        </section>

        <footer className="mt-10 border-t border-gray-200 dark:border-white/10 pt-8 pb-10 flex flex-col md:flex-row justify-between items-center text-text-secondary text-sm">
          <p>© 2026 NewMaoS Learning. All rights reserved.</p>
          <div className="flex gap-6 mt-4 md:mt-0">
            <Link to="/privacy" className="hover:text-text-main dark:hover:text-white transition-colors">Privacy</Link>
            <Link to="/terms" className="hover:text-text-main dark:hover:text-white transition-colors">Terms</Link>
            <Link to="/support" className="hover:text-text-main dark:hover:text-white transition-colors">Support</Link>
          </div>
        </footer>
      </main>

      {/* Login Prompt Modal for Guests */}
      {showLoginPrompt && (
        <div className="fixed inset-0 z-[100] flex items-center justify-center p-4 bg-black/60 backdrop-blur-sm animate-fade-in">
          <div className="bg-surface-light dark:bg-surface-dark w-full max-w-sm rounded-3xl p-6 shadow-2xl border border-white/20 relative animate-fade-in-up">
            {/* Close Button for Guest Mode */}
            <button
              onClick={handleDismissPrompt}
              className="absolute top-4 right-4 p-1 rounded-full hover:bg-gray-100 dark:hover:bg-white/10 transition-colors text-gray-400 hover:text-text-main dark:hover:text-white"
              title="Continue as Guest"
            >
              <span className="material-symbols-outlined text-xl">close</span>
            </button>

            <div className="flex flex-col items-center text-center mt-4">
              <div className="w-16 h-16 bg-primary rounded-2xl flex items-center justify-center text-text-main shadow-glow mb-6 rotate-3">
                <span className="material-symbols-outlined text-4xl">lock</span>
              </div>
              <h3 className="text-2xl font-black text-text-main dark:text-white mb-2">Sign In Required</h3>
              <p className="text-gray-500 dark:text-gray-400 mb-8">
                Save your progress, track your mastery, and get personalized AI recommendations.
              </p>

              <div className="flex flex-col gap-3 w-full">
                <button
                  onClick={() => navigate('/login')}
                  className="w-full py-3.5 bg-primary rounded-xl font-bold text-text-main shadow-md hover:brightness-105 active:scale-95 transition-all"
                >
                  Sign In
                </button>
                <button
                  onClick={() => navigate('/signup')}
                  className="w-full py-3.5 bg-white dark:bg-white/5 border border-gray-200 dark:border-gray-700 rounded-xl font-bold text-text-main dark:text-white hover:bg-gray-50 dark:hover:bg-white/10 transition-all"
                >
                  Create Account
                </button>
              </div>

              <p className="mt-6 text-xs text-gray-400 cursor-pointer hover:text-primary transition-colors" onClick={handleDismissPrompt}>
                Continue as Guest (Progress won't be saved)
              </p>
            </div>
          </div>
        </div>
      )}
    </div>
  );
};