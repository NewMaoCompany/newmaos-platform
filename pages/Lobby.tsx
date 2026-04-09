import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { useApp } from '../AppContext';
import { MatchGame } from './MatchGame';
import { PointsCoin } from '../components/PointsCoin';

// --- Premium iOS Components ---

// Analog Clock Widget
const AnalogClock = ({ date }: { date: Date }) => {
  const seconds = date.getSeconds();
  const minutes = date.getMinutes();
  const hours = date.getHours();

  return (
    <div className="w-full h-full relative flex items-center justify-center">
      <div className="w-[100px] h-[100px] rounded-full bg-white/5 backdrop-blur-xl border border-white/10 relative shadow-2xl">
        {/* Clock Marks */}
        {[...Array(12)].map((_, i) => (
          <div
            key={i}
            className="absolute top-0 left-1/2 -ml-[1px] h-full w-[2px]"
            style={{ transform: `rotate(${i * 30}deg)` }}
          >
            <div className="h-2 w-full bg-white/20 rounded-full" />
          </div>
        ))}
        {/* Hands */}
        <div 
          className="absolute top-1/2 left-1/2 -mt-10 -ml-[1.5px] w-[3px] h-10 bg-white rounded-full origin-bottom"
          style={{ transform: `rotate(${(hours % 12) * 30 + minutes * 0.5}deg)` }}
        />
        <div 
          className="absolute top-1/2 left-1/2 -mt-12 -ml-[1px] w-[2px] h-12 bg-white/80 rounded-full origin-bottom"
          style={{ transform: `rotate(${minutes * 6}deg)` }}
        />
        <div 
          className="absolute top-1/2 left-1/2 -mt-12 -ml-[0.5px] w-[1px] h-12 bg-[#FF3B30] rounded-full origin-bottom shadow-[0_0_8px_rgba(255,59,48,0.5)]"
          style={{ transform: `rotate(${seconds * 6}deg)` }}
        />
        <div className="absolute top-1/2 left-1/2 -mt-[2px] -ml-[2px] w-1 h-1 bg-white rounded-full" />
      </div>
    </div>
  );
};

// Minimalist High-End Widget
const Widget = ({ children, className = '', title = '', icon = '' }: { children: React.ReactNode; className?: string; title?: string; icon?: string }) => (
  <div className={`bg-white/5 backdrop-blur-[40px] rounded-[32px] p-5 border border-white/10 shadow-2xl overflow-hidden relative group active:scale-[0.98] transition-all duration-500 hover:bg-white/10 ${className}`}>
    <div className="relative z-10 h-full flex flex-col">
      {title && (
        <div className="flex items-center gap-2 mb-3 opacity-30">
          {icon && <span className="material-symbols-outlined text-[14px]">{icon}</span>}
          <span className="text-[10px] font-bold uppercase tracking-[0.2em]">{title}</span>
        </div>
      )}
      <div className="flex-1 min-h-0">
        {children}
      </div>
    </div>
  </div>
);

// App Icon Component (Vibrant iOS Style)
const AppIcon = ({ 
  icon, 
  label, 
  gradient, 
  onClick, 
  badge
}: { 
  icon: string; 
  label: string; 
  gradient: string; 
  onClick: () => void; 
  badge?: number;
}) => (
  <button onClick={onClick} className="flex flex-col items-center gap-3 group select-none transition-transform duration-300 hover:scale-105 active:scale-90">
    <div 
      className="w-[72px] h-[72px] sm:w-[84px] sm:h-[84px] rounded-[22%] flex items-center justify-center relative shadow-2xl transition-all duration-500"
      style={{ 
        background: gradient,
        boxShadow: '0 15px 35px -5px rgba(0,0,0,0.5), inset 0 2px 8px rgba(255,255,255,0.2)',
      }}
    >
      <div className="absolute inset-0 bg-white/10 rounded-[22%] opacity-0 group-hover:opacity-100 transition-opacity" />
      <span className="material-symbols-outlined text-white" style={{ fontSize: '40px', fontVariationSettings: "'FILL' 1" }}>
        {icon}
      </span>
      {badge && badge > 0 && (
        <span className="absolute -top-1 -right-1 min-w-[24px] h-6 flex items-center justify-center bg-[#FF3B30] text-white text-[12px] font-black rounded-full px-1.5 shadow-lg border-2 border-white/20 animate-pulse">
          {badge > 99 ? '99+' : badge}
        </span>
      )}
    </div>
    <span className="text-[13px] font-bold text-white tracking-wide drop-shadow-lg opacity-90 group-hover:opacity-100 transition-opacity">
      {label}
    </span>
  </button>
);

export const Lobby = () => {
  const navigate = useNavigate();
  const { isAuthenticated, notifications, userPoints, userPrestige } = useApp();
  const [showMatchGame, setShowMatchGame] = useState(false);
  const [currentTime, setCurrentTime] = useState(new Date());

  useEffect(() => {
    const timer = setInterval(() => setCurrentTime(new Date()), 1000);
    return () => clearInterval(timer);
  }, []);

  const unreadCount = notifications.filter(n => n.unread).length;

  if (showMatchGame) return <MatchGame onBack={() => setShowMatchGame(false)} />;

  return (
    <div className="fixed inset-0 z-[90] flex flex-col items-center bg-[#000] overflow-hidden text-white font-sans selection:bg-white/20">
      
      {/* --- Premium Liquid Background --- */}
      <div className="absolute inset-0 overflow-hidden pointer-events-none">
        <div className="absolute inset-0 bg-[#0a0a0f]" />
        {/* Dynamic Blobs with Intense Vibrant Colors */}
        <div className="absolute top-[-10%] left-[-10%] w-[70%] h-[70%] bg-[hsl(215,100%,40%)]/30 rounded-full blur-[120px] animate-blob-1" />
        <div className="absolute bottom-[-10%] right-[-10%] w-[70%] h-[70%] bg-[hsl(275,100%,40%)]/25 rounded-full blur-[140px] animate-blob-2" />
        <div className="absolute top-[20%] right-[-5%] w-[50%] h-[50%] bg-[hsl(330,100%,40%)]/20 rounded-full blur-[110px] animate-blob-3" />
        {/* Subtle texture/grain can be added here if needed */}
      </div>

      {/* --- Minimalist Status Bar (Clock Only) --- */}
      <div className="w-full flex items-center justify-between px-10 py-5 z-50 font-bold text-[15px] tracking-tight opacity-90">
        <div>
          <span className="tabular-nums drop-shadow-sm">
            {currentTime.toLocaleTimeString('en-US', { hour: 'numeric', minute: '2-digit', hour12: false })}
          </span>
        </div>
        <div>
          {/* Icons removed as requested */}
        </div>
      </div>

      {/* --- Main Content --- */}
      <div className="relative z-50 flex-1 w-full flex flex-col items-center px-8 pt-4 sm:pt-10 overflow-hidden">
        
        {/* WIDGET GRID (Bulletproof spacing to prevent overlap) */}
        <div className="w-full max-w-[1100px] flex flex-wrap justify-center items-center gap-8 mb-16">
          
          <Widget title="Today" icon="calendar_today" className="w-[320px] sm:w-[460px] h-[180px]">
            <div className="flex items-center gap-6 h-full px-4">
              <AnalogClock date={currentTime} />
              <div className="flex flex-col justify-center min-w-0">
                <p className="text-2xl sm:text-3xl font-black tracking-tighter truncate">
                  {currentTime.toLocaleDateString('en-US', { month: 'long', day: 'numeric' })}
                </p>
                <p className="text-[15px] font-bold text-white/40 mb-3 tracking-wide">
                  {currentTime.toLocaleDateString('en-US', { weekday: 'long' })}
                </p>
                <div className="flex items-center gap-2 text-xs font-black text-blue-400 bg-blue-400/10 self-start px-3 py-1.5 rounded-full border border-blue-400/20 active:scale-95 transition-transform cursor-pointer">
                  SIGN SCHEDULE <span className="material-symbols-outlined text-[14px]">chevron_right</span>
                </div>
              </div>
            </div>
          </Widget>

          <Widget title="Activity" icon="bolt" className="w-[320px] sm:w-[460px] h-[180px]">
            <div className="flex items-center h-full px-2 justify-between gap-2 overflow-hidden">
               <div className="flex-1 flex flex-col items-center">
                  <div className="w-12 h-12 rounded-2xl bg-gradient-to-br from-yellow-400/20 to-orange-500/10 flex items-center justify-center mb-2 shadow-inner">
                    <PointsCoin size="sm" />
                  </div>
                  <span className="text-xl font-black tracking-tight">{userPoints.balance.toLocaleString()}</span>
                  <span className="text-[9px] font-black text-white/30 uppercase tracking-widest mt-0.5">Points</span>
               </div>
               <div className="w-px h-10 bg-white/5" />
               <div className="flex-1 flex flex-col items-center">
                  <div className="w-12 h-12 rounded-2xl bg-gradient-to-br from-purple-400/20 to-indigo-500/10 flex items-center justify-center mb-2 shadow-inner">
                    <span className="material-symbols-outlined text-purple-400" style={{ fontVariationSettings: "'FILL' 1" }}>auto_awesome</span>
                  </div>
                  <span className="text-xl font-black tracking-tight">{(userPrestige?.current_stardust || 0).toLocaleString()}</span>
                  <span className="text-[9px] font-black text-white/30 uppercase tracking-widest mt-0.5">Stardust</span>
               </div>
               <div className="w-px h-10 bg-white/5" />
               <div className="flex-1 flex flex-col items-center">
                  <div className="w-12 h-12 rounded-2xl bg-gradient-to-br from-blue-400/20 to-cyan-500/10 flex items-center justify-center mb-2 shadow-inner">
                    <span className="material-symbols-outlined text-cyan-400" style={{ fontVariationSettings: "'FILL' 1" }}>verified</span>
                  </div>
                  <span className="text-xl font-black tracking-tight">{userPrestige?.world_rank || '-'}</span>
                  <span className="text-[9px] font-black text-white/30 uppercase tracking-widest mt-0.5">Global Rank</span>
               </div>
            </div>
          </Widget>

        </div>

        {/* MAIN APP GRID: STRICTLY TWO APPS */}
        <div className="w-full max-w-[800px] flex justify-center gap-16 sm:gap-28 mt-4 animate-scale-in">
          <AppIcon 
            icon="school" 
            label="Learning" 
            gradient="linear-gradient(135deg, #FF9500, #FF5E00)" 
            onClick={() => navigate('/dashboard')} 
            badge={unreadCount}
          />
          <AppIcon 
            icon="stadia_controller" 
            label="Game Hub" 
            gradient="linear-gradient(135deg, #FF2D55, #C40030)" 
            onClick={() => setShowMatchGame(true)} 
          />
        </div>

      </div>

      {/* --- Footer Elements Removed (Dock, Indicator, Dots) --- */}

      <style>{`
        @keyframes blob-1 {
          0%, 100% { transform: translate(0, 0) scale(1); }
          33% { transform: translate(40px, -60px) scale(1.1); }
          66% { transform: translate(-20px, 40px) scale(0.9); }
        }
        @keyframes blob-2 {
          0%, 100% { transform: translate(0, 0) scale(1); }
          33% { transform: translate(-50px, 40px) scale(1.05); }
          66% { transform: translate(40px, -30px) scale(0.95); }
        }
        @keyframes blob-3 {
          0%, 100% { transform: translate(0, 0) scale(1); }
          33% { transform: translate(30px, 30px) scale(1.1); }
          66% { transform: translate(-40px, -20px) scale(0.9); }
        }
        .animate-blob-1 { animation: blob-1 25s ease-in-out infinite; }
        .animate-blob-2 { animation: blob-2 30s ease-in-out infinite; }
        .animate-blob-3 { animation: blob-3 22s ease-in-out infinite; }
        .animate-scale-in { animation: scaleIn 0.8s cubic-bezier(0.16, 1, 0.3, 1); }
        @keyframes scaleIn {
          from { transform: scale(0.8); opacity: 0; }
          to { transform: scale(1); opacity: 1; }
        }
      `}</style>
    </div>
  );
};
