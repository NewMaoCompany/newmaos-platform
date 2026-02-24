import React, { useState, useEffect } from 'react';
import { useApp } from '../AppContext';
import { supabase } from '../src/services/supabaseClient'; // Import Supabase client
import { Navbar } from '../components/Navbar';
import { useNavigate, Link } from 'react-router-dom';
import { CourseType } from '../types';
import { WelcomeGiftModal } from '../components/WelcomeGiftModal';
import { PrestigeWidget } from '../components/PrestigeWidget';

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

const CourseCard = ({
  type,
  onSelect,
  onStart
}: {
  type: CourseType;
  onSelect: () => void;
  onStart: (e: React.MouseEvent) => void;
}) => {
  const { user, courses, getSectionStatus, getCourseProgress } = useApp();
  const course = courses[type];
  const isActive = user.currentCourse === type;
  const [progress, setProgress] = useState(0);

  // Use Synchronous lookup from Cache (no async flickering)
  const courseStatus = getSectionStatus(type);

  useEffect(() => {
    if (user?.id) {
      getCourseProgress(type).then(data => {
        if (data) setProgress(data.progress_percentage || 0);
      });
    }
  }, [type, user?.id]);

  return (
    <div
      onClick={onSelect}
      className={`group relative overflow-hidden bg-surface-light dark:bg-surface-dark rounded-2xl sm:rounded-[32px] p-5 sm:p-8 border-2 transition-[border-color,box-shadow,transform] duration-300 cursor-pointer flex flex-col justify-between min-h-[280px] sm:min-h-[340px]
          ${isActive ? 'border-primary shadow-soft scale-[1.01] z-10' : 'border-white dark:border-white/5 hover:border-gray-200 dark:hover:border-gray-700'}`}
    >
      {/* Background Icon */}
      <div className="absolute top-8 right-8 opacity-5 pointer-events-none">
        <span className={`material-symbols-outlined text-[140px] ${isActive ? 'text-primary' : 'text-gray-500'}`}>
          {type === 'AB' ? 'functions' : 'all_inclusive'}
        </span>
      </div>

      <div className="relative z-10 flex flex-col items-start">
        <div className={`inline-flex items-center gap-2 px-3 py-1 rounded-full text-[10px] font-bold uppercase tracking-wider mb-6
                  ${courseStatus === 'in_progress'
            ? 'bg-yellow-100 text-yellow-700 dark:bg-yellow-900/30 dark:text-yellow-400'
            : courseStatus === 'completed'
              ? 'bg-green-100 text-green-700 dark:bg-green-900/30 dark:text-green-400'
              : 'bg-gray-100 text-gray-500 dark:bg-white/10 dark:text-gray-400'}`}>
          <span>{courseStatus === 'in_progress' ? 'In Progress' : courseStatus === 'completed' ? 'Completed' : 'Not Started'}</span>
          {(courseStatus === 'in_progress' || courseStatus === 'completed') && (
            <span className="opacity-70">• {Math.round(progress)}%</span>
          )}
        </div>

        <h3 className="text-3xl font-black text-text-main dark:text-white mb-2 tracking-tight">{course.title}</h3>

        <p className="text-text-secondary dark:text-gray-400 font-medium leading-relaxed max-w-[85%]">
          {type === 'AB'
            ? 'Track your progress across all 8 units.'
            : 'Start your journey with Unit 1.'
          }
        </p>
      </div>

      <div className="relative z-10 mt-8 w-full">
        {isActive && progress > 0 && (
          <div className="mb-4 h-2 w-full bg-gray-100 dark:bg-white/5 rounded-full overflow-hidden">
            <div className="h-full bg-primary transition-all duration-1000 ease-out" style={{ width: `${progress}%` }}></div>
          </div>
        )}
        <button
          onClick={onStart}
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

export const Dashboard = () => {
  const { user, courses, toggleCourse, startCourse, lineData, isAuthenticated, isAuthLoading, hasDismissedLoginPrompt, dismissLoginPrompt, getCourseMastery, performDailyCheckin, getCheckinStatus, checkinStatus, notifications, markNotificationRead } = useApp();
  const navigate = useNavigate();
  const [showLoginPrompt, setShowLoginPrompt] = useState(false);
  const [todayIndex, setTodayIndex] = useState(0);
  const [showWelcomeGift, setShowWelcomeGift] = useState(false);

  // Red dot driven by unread check-in notification (unified source of truth)
  const needsCheckin = notifications.some(n => n.unread && n.link === '/checkin');

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

  // Welcome Gift Logic: Show if user is authenticated and hasn't claimed yet
  useEffect(() => {
    if (isAuthLoading || !isAuthenticated || !user?.id) return;

    let timer: ReturnType<typeof setTimeout> | null = null;
    let cancelled = false;

    const checkWelcomeGift = async () => {
      try {
        const { data, error } = await supabase
          .from('points_ledger')
          .select('id')
          .eq('user_id', user.id)
          .eq('description', 'Welcome Gift')
          .limit(1);

        if (cancelled) return;

        if (error) {
          console.error('Welcome gift check error:', error);
          // On error, default to showing the popup (better to show twice than never)
          timer = setTimeout(() => { if (!cancelled) setShowWelcomeGift(true); }, 1500);
          return;
        }

        // If no "Welcome Gift" transaction found, show the modal
        if (!data || data.length === 0) {
          timer = setTimeout(() => { if (!cancelled) setShowWelcomeGift(true); }, 1500);
        }
      } catch (err) {
        console.error('Welcome gift check exception:', err);
        // On exception, still show the popup
        if (!cancelled) {
          timer = setTimeout(() => { if (!cancelled) setShowWelcomeGift(true); }, 1500);
        }
      }
    };

    checkWelcomeGift();

    return () => {
      cancelled = true;
      if (timer) clearTimeout(timer);
    };
  }, [isAuthenticated, isAuthLoading, user?.id]);

  // Determine current day of the week (0=Sun, 1=Mon... 6=Sat) on mount
  useEffect(() => {
    setTodayIndex(new Date().getDay());
  }, []);

  // Check-in red dot: derived from global checkinStatus (no local state needed)

  // --- Daily Stats for "24h Refresh" ---
  const [dailyStats, setDailyStats] = useState({
    total_time_seconds: 0,
    unique_questions_solved: 0,
    correct_attempts: 0,
    total_attempts: 0,
    accuracy_rate: 0
  });

  const [connectionStatus, setConnectionStatus] = useState<'checking' | 'connected' | 'error'>('checking');

  useEffect(() => {
    const checkConnection = async () => {
      try {
        const { data, error } = await supabase.from('questions').select('id', { count: 'exact', head: true }).limit(1);
        if (error) throw error;
        setConnectionStatus('connected');
        console.log('✅ Supabase connected from Dashboard');
      } catch (err) {
        console.error('❌ Supabase connection check failed:', err);
        setConnectionStatus('error');
      }
    };
    checkConnection();
  }, []);

  useEffect(() => {
    const fetchDailyStats = async () => {
      if (!isAuthenticated || !user?.id) return;

      // Use Start of Today (Midnight) instead of rolling 24h
      const startOfDay = new Date();
      startOfDay.setHours(0, 0, 0, 0);

      try {
        // Direct Query to 'question_attempts' (Most robust method)
        const { data, error } = await supabase
          .from('question_attempts')
          .select('question_id, is_correct, time_spent_seconds, created_at')
          .eq('user_id', user.id)
          .gte('created_at', startOfDay.toISOString());

        if (error) {
          console.error('Fetch daily stats failed:', error);
          return;
        }

        if (data) {
          const totalAttempts = data.length;

          // 1. Group attempts by question_id
          const attemptsMap = new Map<string, any[]>();
          data.forEach(d => {
            const arr = attemptsMap.get(d.question_id) || [];
            arr.push(d);
            attemptsMap.set(d.question_id, arr);
          });

          const uniqueAttemptedCount = attemptsMap.size;
          const uniqueQuestionIds = Array.from(attemptsMap.keys());

          // 2. Calculate Weighted Accuracy
          // Rules:
          // 1st try correct = 100%
          // 2nd try correct = 80%
          // 3rd try correct = 70%
          // ... -10% ...
          // Floor = 40%

          let totalScore = 0;

          attemptsMap.forEach((attempts, qId) => {
            // Sort by time ascending
            attempts.sort((a, b) => new Date(a.created_at).getTime() - new Date(b.created_at).getTime());

            // Find first correct attempt index (1-based)
            const firstCorrectIndex = attempts.findIndex(a => a.is_correct);

            if (firstCorrectIndex === -1) {
              // Never solved today -> 0 score (or should it be partial? Assuming 0 for "Correctness")
              totalScore += 0;
            } else {
              const k = firstCorrectIndex + 1; // Attempt # where it was solved
              let score = 0;
              if (k === 1) score = 100;
              else if (k === 2) score = 80;
              else {
                // k=3 -> 70, k=4 -> 60...
                // Formula: 70 - (k-3)*10
                score = 70 - (k - 3) * 10;
              }
              // Floor at 40
              if (score < 40) score = 40;

              totalScore += score;
            }
          });

          // 3. Count unique questions correctly solved (ANY attempt today is correct)
          let solvedCount = 0;
          attemptsMap.forEach((attempts) => {
            // Check if user has ANY correct attempt for this question ID today
            if (attempts.some(a => a.is_correct)) {
              solvedCount++;
            }
          });

          const weightedAccuracy = uniqueAttemptedCount > 0 ? totalScore / uniqueAttemptedCount : 0;
          const totalTimeSeconds = data.reduce((acc, curr) => acc + (Number(curr.time_spent_seconds) || 0), 0);

          setDailyStats({
            total_time_seconds: totalTimeSeconds,
            unique_questions_solved: solvedCount,
            correct_attempts: 0, // Unused display
            total_attempts: totalAttempts,
            accuracy_rate: Math.round(weightedAccuracy),
          });
        }
      } catch (err) {
        console.error('Fetch daily stats exception:', err);
      }
    };

    if (!isAuthLoading && isAuthenticated && user?.id) {
      fetchDailyStats();
    }
  }, [user?.id, isAuthenticated, isAuthLoading]);

  const handleDismissPrompt = () => {
    setShowLoginPrompt(false);
    dismissLoginPrompt();
  };

  // Show loading spinner while auth is being determined to prevent flash
  // MOVED AFTER HOOKS to avoid hook violation
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

  const weekDays = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];

  return (
    <div className="h-full w-full flex flex-col bg-background-light dark:bg-background-dark text-text-main dark:text-gray-100 font-sans overflow-x-hidden overflow-y-hidden">
      <Navbar />

      <main className="flex-grow max-w-7xl mx-auto px-4 sm:px-6 py-6 sm:py-10 flex flex-col gap-8 sm:gap-12 w-full overflow-y-auto">

        <header className="flex flex-col md:flex-row md:items-center justify-between gap-6">
          <div className="flex flex-col gap-2">
            <h2 className="text-3xl sm:text-4xl md:text-5xl font-black tracking-tight text-text-main dark:text-white">
              Hello, {(() => {
                if (!user.name) return 'Student';
                let n = user.name.split(' ')[0];
                if (n.toLowerCase() === 'newmaos.com' || n.includes('@')) {
                  const fallback = user.email ? user.email.split('@')[0] : 'Student';
                  return fallback.charAt(0).toUpperCase() + fallback.slice(1);
                }
                return n;
              })()}
            </h2>
            <p className="text-xl text-text-secondary dark:text-gray-400 font-medium">
              Ready to conquer <span className="font-bold text-text-main dark:text-white">{courses[user.currentCourse].title}</span>
            </p>
          </div>
          <div className="w-full md:max-w-md lg:max-w-xl">
            <PrestigeWidget wide />
          </div>
        </header>

        <section className="flex flex-col gap-8">
          {/* Prominent Daily Check-in Button */}
          <div
            onClick={() => {
              // Mark all check-in notifications as read (clears all red dots)
              notifications.filter(n => n.unread && n.link === '/checkin').forEach(n => markNotificationRead(n.id));
              navigate('/checkin');
            }}
            className="w-full bg-white dark:bg-surface-dark rounded-[28px] p-5 sm:p-6 border border-white dark:border-white/5 shadow-sm hover:shadow-md transition-[box-shadow,transform] cursor-pointer flex items-center justify-between group animate-fade-in relative"
          >
            {needsCheckin && (
              <div className="absolute top-4 right-4 flex h-3 w-3">
                <span className="animate-ping absolute inline-flex h-full w-full rounded-full bg-red-400 opacity-75"></span>
                <span className="relative inline-flex rounded-full h-3 w-3 bg-red-500"></span>
              </div>
            )}
            <div className="flex items-center gap-4 sm:gap-6">
              <div className="p-3 sm:p-4 bg-primary rounded-2xl text-text-main shadow-glow-sm group-hover:scale-110 transition-transform rotate-3 group-hover:rotate-0">
                <span className="material-symbols-outlined text-2xl sm:text-3xl block">calendar_today</span>
              </div>
              <div className="flex flex-col">
                <h3 className="text-lg sm:text-xl font-black text-text-main dark:text-white tracking-tight">Daily Check-in</h3>
                <p className="text-xs sm:text-sm font-medium text-text-secondary dark:text-gray-400">Maintain your streak & earn daily rewards</p>
              </div>
            </div>
            <div className="flex items-center gap-2">
              <span className="hidden sm:block text-[10px] font-bold uppercase tracking-widest text-primary opacity-0 group-hover:opacity-100 transition-opacity">Go Now</span>
              <span className="material-symbols-outlined text-gray-300 group-hover:translate-x-1 group-hover:text-primary transition-all">arrow_forward</span>
            </div>
          </div>

          <div className="grid grid-cols-1 md:grid-cols-2 gap-6 items-stretch">
            <CourseCard
              type="AB"
              onSelect={() => handleCardSelect('AB')}
              onStart={(e) => handleStartSession(e, 'AB')}
            />
            <CourseCard
              type="BC"
              onSelect={() => handleCardSelect('BC')}
              onStart={(e) => handleStartSession(e, 'BC')}
            />
          </div>
        </section>

        <section>
          <div className="mb-6">
            <h3 className="text-lg font-bold text-text-main dark:text-white flex items-center gap-2">
              <span className="p-1.5 bg-primary rounded-md text-text-main">
                <span className="material-symbols-outlined text-lg block">analytics</span>
              </span>
              Current Performance
            </h3>
          </div>

          <div className="grid grid-cols-1 md:grid-cols-3 gap-6">

            {/* Card 1: Accuracy Rate (24h) */}
            <div
              className="bg-white dark:bg-surface-dark rounded-3xl p-6 border border-white dark:border-white/5 shadow-sm hover:shadow-md transition-all cursor-pointer flex items-center justify-between"
              onClick={() => navigate('/analysis')}
            >
              <div className="flex flex-col gap-2">
                <span className="text-sm font-bold text-gray-500 dark:text-gray-400">Accuracy Rate <span className="text-[10px] text-gray-400 font-normal">(Today)</span></span>
                <div className="flex flex-col items-start">
                  <span className="text-4xl font-black text-text-main dark:text-white tracking-tighter">{dailyStats.accuracy_rate.toFixed(0)}%</span>
                  {/* Reuse trend or show streak? Keeping trend for now or just generic + */}
                  <span className={`text-xs font-bold px-1.5 py-0.5 rounded mt-1 bg-green-100 text-green-700 dark:bg-green-900/30 dark:text-green-400`}>
                    Today
                  </span>
                </div>
              </div>
              <RadialProgress percentage={dailyStats.accuracy_rate} />
            </div>

            {/* Card 2: Problems Solved (24h) */}
            <div
              className="bg-white dark:bg-surface-dark rounded-3xl p-6 border border-white dark:border-white/5 shadow-sm hover:shadow-md transition-all cursor-pointer flex flex-col justify-between min-h-[160px]"
              onClick={() => navigate('/practice')}
            >
              <div className="flex justify-between items-start">
                <span className="text-sm font-bold text-gray-500 dark:text-gray-400">Problems Solved <span className="text-[10px] text-gray-400 font-normal block sm:inline">(Today)</span></span>
                <div className="bg-primary/20 p-2 rounded-lg text-yellow-700 dark:text-primary">
                  <span className="material-symbols-outlined block text-lg">edit_note</span>
                </div>
              </div>
              <div>
                <span className="text-4xl font-black text-text-main dark:text-white tracking-tighter">{dailyStats.unique_questions_solved}</span>
                <p className="text-xs font-bold text-gray-400 mt-1">Unique questions today</p>
              </div>
            </div>

            {/* Card 3: Study Time */}
            <div
              className="bg-white dark:bg-surface-dark rounded-3xl p-6 border border-white dark:border-white/5 shadow-sm hover:shadow-md transition-all cursor-pointer flex flex-col justify-between min-h-[160px]"
              onClick={() => navigate('/analysis')}
            >
              <div className="flex flex-col gap-1 mb-2">
                <span className="text-sm font-bold text-gray-500 dark:text-gray-400">Study Time <span className="text-[10px] text-gray-400 font-normal">(Today)</span></span>
                <div className="flex items-baseline gap-1">
                  {/* Show Today's Stats from DB or fallback to calculation */}
                  <span className="text-4xl font-black text-text-main dark:text-white tracking-tighter">
                    {(dailyStats.total_time_seconds / 60).toFixed(0)}
                  </span>
                  <span className="text-lg font-bold text-gray-400">mins</span>
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
      {
        showLoginPrompt && (
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
                  Save your progress, track your completion, and get personalized AI recommendations.
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
        )
      }

      {/* Welcome Gift Modal */}
      {showWelcomeGift && (
        <WelcomeGiftModal onClaimed={() => setShowWelcomeGift(false)} />
      )}
    </div >
  );
};