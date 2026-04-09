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
      <div className="w-[100px] h-[100px] rounded-full bg-white/10 backdrop-blur-2xl border border-white/20 relative shadow-2xl">
        {/* Clock Marks */}
        {[...Array(12)].map((_, i) => (
          <div
            key={i}
            className="absolute top-0 left-1/2 -ml-[1px] h-full w-[2px]"
            style={{ transform: `rotate(${i * 30}deg)` }}
          >
            <div className="h-2 w-full bg-white/30 rounded-full" />
          </div>
        ))}
        {/* Hands */}
        <div 
          className="absolute top-1/2 left-1/2 -mt-10 -ml-[1.5px] w-[3px] h-10 bg-white rounded-full origin-bottom"
          style={{ transform: `rotate(${(hours % 12) * 30 + minutes * 0.5}deg)` }}
        />
        <div 
          className="absolute top-1/2 left-1/2 -mt-12 -ml-[1px] w-[2px] h-12 bg-white/90 rounded-full origin-bottom"
          style={{ transform: `rotate(${minutes * 6}deg)` }}
        />
        <div 
          className="absolute top-1/2 left-1/2 -mt-12 -ml-[0.5px] w-[1px] h-12 bg-[#FF3B30] rounded-full origin-bottom shadow-[0_0_10px_rgba(255,59,48,0.7)]"
          style={{ transform: `rotate(${seconds * 6}deg)` }}
        />
        <div className="absolute top-1/2 left-1/2 -mt-[2px] -ml-[2px] w-1 h-1 bg-white rounded-full" />
      </div>
    </div>
  );
};

// Minimalist High-End Widget
const Widget = ({ children, className = '', title = '', icon = '', onClick }: { children: React.ReactNode; className?: string; title?: string; icon?: string; onClick?: () => void }) => (
  <div 
    onClick={onClick}
    className={`bg-white/10 backdrop-blur-[60px] rounded-[36px] p-6 border border-white/30 shadow-2xl overflow-hidden relative group active:scale-[0.98] transition-all duration-500 hover:bg-white/15 ${onClick ? 'cursor-pointer' : ''} ${className}`}
  >
    <div className="absolute inset-0 bg-gradient-to-br from-white/10 to-transparent opacity-50" />
    <div className="relative z-10 h-full flex flex-col">
      {title && (
        <div className="flex items-center gap-2 mb-4 opacity-40">
          {icon && <span className="material-symbols-outlined text-[16px]">{icon}</span>}
          <span className="text-[11px] font-black uppercase tracking-[0.25em]">{title}</span>
        </div>
      )}
      <div className="flex-1 min-h-0">
        {children}
      </div>
    </div>
  </div>
);

// App Icon Component (Translucent Liquid Style)
const AppIcon = ({ 
  icon, 
  label, 
  glowColor, 
  onClick, 
  badge
}: { 
  icon: string; 
  label: string; 
  glowColor: string; 
  onClick: () => void; 
  badge?: number;
}) => (
  <button onClick={onClick} className="flex flex-col items-center gap-4 group select-none transition-transform duration-500 hover:scale-105 active:scale-90">
    <div 
      className="w-[80px] h-[80px] sm:w-[92px] sm:h-[92px] rounded-[22%] flex items-center justify-center relative shadow-2xl transition-all duration-500 bg-white/10 backdrop-blur-[40px] border border-white/30"
      style={{ 
        boxShadow: `0 15px 35px -5px rgba(0,0,0,0.3), 0 0 20px -5px ${glowColor}66, inset 0 2px 10px rgba(255,255,255,0.3)`,
      }}
    >
      <div className="absolute inset-0 bg-gradient-to-br from-white/20 to-transparent rounded-[22%] opacity-50" />
      <span className="material-symbols-outlined text-white z-10" style={{ fontSize: '44px', fontVariationSettings: "'FILL' 1", filter: `drop-shadow(0 0 8px ${glowColor})` }}>
        {icon}
      </span>
      {badge && badge > 0 && (
        <span className="absolute -top-1 -right-1 min-w-[26px] h-6.5 flex items-center justify-center bg-[#FF3B30] text-white text-[12px] font-black rounded-full px-1.5 shadow-lg border-2 border-white/30 animate-pulse z-20">
          {badge > 99 ? '99+' : badge}
        </span>
      )}
    </div>
    <span className="text-[14px] font-bold text-white tracking-wide drop-shadow-md opacity-80 group-hover:opacity-100 transition-opacity">
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

  const unreadCount = notifications.filter(n => {
    if (!n.unread) return false;
    const isCheckin = n.link?.includes('/checkin') || n.text?.includes('Daily Check-in');
    
    // Deduplicate and filter based on checkinStatus
    if (isCheckin) {
      if (checkinStatus !== 'not_checked_in') return false;
      const firstCheckin = notifications.find(notif => notif.unread && (notif.link?.includes('/checkin') || notif.text?.includes('Daily Check-in')));
      if (firstCheckin && firstCheckin.id !== n.id) return false;
    }
    return true;
  }).length;

  if (showMatchGame) return <MatchGame onBack={() => setShowMatchGame(false)} />;

  return (
    <div className="fixed inset-0 z-[90] flex flex-col items-center bg-[#101020] overflow-hidden text-white font-sans selection:bg-white/30">
      
      {/* --- Premium Brightened Liquid Background --- */}
      <div className="absolute inset-0 overflow-hidden pointer-events-none">
        <div className="absolute inset-0 bg-gradient-to-br from-[#1a1a35] via-[#101020] to-[#251545]" />
        {/* Lighter, More Vibrant Dynamic Blobs */}
        <div className="absolute top-[-15%] left-[-15%] w-[80%] h-[80%] bg-[hsl(215,100%,60%)]/25 rounded-full blur-[130px] animate-blob-1" />
        <div className="absolute bottom-[-15%] right-[-15%] w-[80%] h-[80%] bg-[hsl(275,100%,60%)]/20 rounded-full blur-[150px] animate-blob-2" />
        <div className="absolute top-[25%] right-[-10%] w-[60%] h-[60%] bg-[hsl(330,100%,70%)]/15 rounded-full blur-[120px] animate-blob-3" />
        <div className="absolute inset-0 bg-white/[0.02]" />
      </div>

      {/* --- Minimalist Status Bar (Clock Only) --- */}
      <div className="w-full flex items-center justify-between px-12 py-6 z-50 font-black text-[17px] tracking-tight opacity-100">
        <div>
          <span className="tabular-nums drop-shadow-lg text-white/90">
            {currentTime.toLocaleTimeString('en-US', { hour: 'numeric', minute: '2-digit', hour12: false })}
          </span>
        </div>
        <div />
      </div>

      {/* --- Main Content --- */}
      <div className="relative z-50 flex-1 w-full flex flex-col items-center px-10 pt-6 sm:pt-14 overflow-hidden">
        
        {/* WIDGET GRID (Bulletproof spacing to prevent overlap) */}
        <div className="w-full max-w-[1200px] flex flex-wrap justify-center items-center gap-10 mb-20">
          
          <Widget 
            title="Today" 
            icon="calendar_today" 
            className="w-[340px] sm:w-[500px] h-[200px]"
            onClick={() => navigate('/checkin')}
          >
            <div className="flex items-center gap-8 h-full px-6">
              <AnalogClock date={currentTime} />
              <div className="flex flex-col justify-center min-w-0 flex-1">
                <p className="text-3xl sm:text-4xl font-black tracking-tighter text-white whitespace-nowrap">
                  {currentTime.toLocaleDateString('en-US', { month: 'long', day: 'numeric' })}
                </p>
                <p className="text-[17px] font-bold text-white/50 mb-4 tracking-wide">
                  {currentTime.toLocaleDateString('en-US', { weekday: 'long' })}
                </p>
                <button 
                  onClick={(e) => { e.stopPropagation(); navigate('/checkin'); }}
                  className="flex items-center gap-2 text-xs font-black text-white bg-white/20 self-start px-4 py-2 rounded-full border border-white/30 active:scale-95 transition-all hover:bg-white/30 backdrop-blur-md"
                >
                  SIGN SCHEDULE <span className="material-symbols-outlined text-[16px]">chevron_right</span>
                </button>
              </div>
            </div>
          </Widget>

          <Widget title="Activity" icon="bolt" className="w-[340px] sm:w-[500px] h-[200px]">
            <div className="flex items-center h-full px-4 justify-between gap-4 overflow-hidden">
               <div className="flex-1 flex flex-col items-center min-w-0">
                  <div className="w-14 h-14 rounded-2xl bg-white/10 backdrop-blur-md flex items-center justify-center mb-3 shadow-inner border border-white/20 shrink-0">
                    <PointsCoin size="sm" />
                  </div>
                  <span className="text-lg sm:text-xl font-black tracking-tight whitespace-nowrap overflow-visible">
                    {userPoints.balance.toLocaleString()}
                  </span>
                  <span className="text-[10px] font-black text-white/40 uppercase tracking-widest mt-1">Points</span>
               </div>
               <div className="w-px h-12 bg-white/20" />
               <div className="flex-1 flex flex-col items-center">
                  <div className="w-14 h-14 rounded-2xl bg-white/10 backdrop-blur-md flex items-center justify-center mb-3 shadow-inner border border-white/20">
                    <span className="material-symbols-outlined text-purple-300" style={{ fontVariationSettings: "'FILL' 1", filter: 'drop-shadow(0 0 8px rgba(168,85,247,0.5))' }}>auto_awesome</span>
                  </div>
                  <span className="text-2xl font-black tracking-tight">{(userPrestige?.current_stardust || 0).toLocaleString()}</span>
                  <span className="text-[10px] font-black text-white/40 uppercase tracking-widest mt-1">Stardust</span>
               </div>
               <div className="w-px h-12 bg-white/20" />
               <div className="flex-1 flex flex-col items-center">
                  <div className="w-14 h-14 rounded-2xl bg-white/10 backdrop-blur-md flex items-center justify-center mb-3 shadow-inner border border-white/20">
                    <span className="material-symbols-outlined text-cyan-300" style={{ fontVariationSettings: "'FILL' 1", filter: 'drop-shadow(0 0 8px rgba(34,211,238,0.5))' }}>verified</span>
                  </div>
                  <span className="text-2xl font-black tracking-tight">{userPrestige?.world_rank || '-'}</span>
                  <span className="text-[10px] font-black text-white/40 uppercase tracking-widest mt-1">Global Rank</span>
               </div>
            </div>
          </Widget>

        </div>

        {/* MAIN APP GRID: STRICTLY TWO APPS - TRANSLUCENT STYLE */}
        <div className="w-full max-w-[900px] flex justify-center gap-20 sm:gap-32 mt-6 animate-scale-in">
          <AppIcon 
            icon="school" 
            label="Learning" 
            glowColor="#FF9500" 
            onClick={() => navigate('/dashboard')} 
            badge={unreadCount}
          />
          <AppIcon 
            icon="stadia_controller" 
            label="Game Hub" 
            glowColor="#FF2D55" 
            onClick={() => setShowMatchGame(true)} 
          />
        </div>

      </div>

      <style>{`
        @keyframes blob-1 {
          0%, 100% { transform: translate(0, 0) scale(1); }
          33% { transform: translate(50px, -70px) scale(1.15); }
          66% { transform: translate(-30px, 50px) scale(0.85); }
        }
        @keyframes blob-2 {
          0%, 100% { transform: translate(0, 0) scale(1); }
          33% { transform: translate(-60px, 50px) scale(1.1); }
          66% { transform: translate(50px, -40px) scale(0.9); }
        }
        @keyframes blob-3 {
          0%, 100% { transform: translate(0, 0) scale(1); }
          33% { transform: translate(40px, 40px) scale(1.15); }
          66% { transform: translate(-50px, -30px) scale(0.85); }
        }
        .animate-blob-1 { animation: blob-1 25s ease-in-out infinite; }
        .animate-blob-2 { animation: blob-2 30s ease-in-out infinite; }
        .animate-blob-3 { animation: blob-3 22s ease-in-out infinite; }
        .animate-scale-in { animation: scaleIn 1s cubic-bezier(0.16, 1, 0.3, 1); }
        @keyframes scaleIn {
          from { transform: scale(0.85); opacity: 0; }
          to { transform: scale(1); opacity: 1; }
        }
      `}</style>
    </div>
  );
};
