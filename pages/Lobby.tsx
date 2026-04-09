import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { useApp } from '../AppContext';
import { MatchGame } from './MatchGame';
import { PointsCoin } from '../components/PointsCoin';

// --- Premium iOS Components ---

// Analog Clock Widget (World Clock Style)
const AnalogClock = ({ date }: { date: Date }) => {
  const seconds = date.getSeconds();
  const minutes = date.getMinutes();
  const hours = date.getHours();

  return (
    <div className="w-[100px] h-[100px] rounded-full bg-white/10 backdrop-blur-2xl border border-white/30 relative shadow-2xl shrink-0">
      {/* Clock Marks */}
      {[...Array(12)].map((_, i) => (
        <div
          key={i}
          className="absolute top-0 left-1/2 -ml-[1px] h-full w-[2px]"
          style={{ transform: `rotate(${i * 30}deg)` }}
        >
          <div className="h-2 w-full bg-white/40 rounded-full" />
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
  );
};

// Mini Calendar Grid Component
const MiniCalendar = () => {
  const now = new Date();
  const month = now.getMonth();
  const year = now.getFullYear();
  const today = now.getDate();
  const firstDay = new Date(year, month, 1).getDay();
  const daysInMonth = new Date(year, month + 1, 0).getDate();
  
  const days = [];
  for (let i = 0; i < firstDay; i++) days.push(null);
  for (let i = 1; i <= daysInMonth; i++) days.push(i);

  return (
    <div className="flex flex-col h-full justify-center">
      <div className="flex items-center justify-between mb-2">
        <span className="text-[12px] font-black text-red-500 uppercase tracking-tighter">
          {now.toLocaleString('en-US', { month: 'long' })}
        </span>
        <span className="text-[10px] font-bold opacity-30">{year}</span>
      </div>
      <div className="grid grid-cols-7 gap-1 text-center">
        {['S','M','T','W','T','F','S'].map(d => (
          <div key={d} className="text-[7px] font-black opacity-30 mb-1">{d}</div>
        ))}
        {days.slice(0, 35).map((d, i) => (
          <div 
            key={i} 
            className={`w-5 h-5 flex items-center justify-center text-[10px] font-bold rounded-full transition-colors ${d === today ? 'bg-white text-black font-black' : d ? 'hover:bg-white/10' : ''}`}
          >
            {d}
          </div>
        ))}
      </div>
    </div>
  );
};

// Minimalist High-End Widget
const Widget = ({ children, className = '', title = '', icon = '', onClick }: { children: React.ReactNode; className?: string; title?: string; icon?: string; onClick?: () => void }) => (
  <div 
    onClick={onClick}
    className={`bg-white/12 backdrop-blur-[60px] rounded-[36px] p-6 border border-white/40 shadow-2xl overflow-hidden relative group active:scale-[0.98] transition-all duration-500 hover:bg-white/18 ${onClick ? 'cursor-pointer' : ''} ${className}`}
  >
    <div className="absolute inset-0 bg-gradient-to-br from-white/20 to-transparent opacity-40" />
    <div className="relative z-10 h-full flex flex-col">
      {title && (
        <div className="flex items-center gap-2 mb-4 opacity-50">
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
  badge = 0
}: { 
  icon: string; 
  label: string; 
  glowColor: string; 
  onClick: () => void; 
  badge?: number;
}) => (
  <button onClick={onClick} className="flex flex-col items-center gap-4 group select-none transition-transform duration-500 hover:scale-105 active:scale-90">
    <div 
      className="w-[80px] h-[80px] sm:w-[92px] sm:h-[92px] rounded-[22%] flex items-center justify-center relative shadow-2xl transition-all duration-500 bg-white/15 backdrop-blur-[45px] border border-white/40"
      style={{ 
        boxShadow: `0 15px 35px -5px rgba(0,0,0,0.3), 0 0 20px -5px ${glowColor}66, inset 0 2px 10px rgba(255,255,255,0.4)`,
      }}
    >
      <div className="absolute inset-0 bg-gradient-to-br from-white/25 to-transparent rounded-[22%] opacity-60" />
      <span className="material-symbols-outlined text-white z-10" style={{ fontSize: '44px', fontVariationSettings: "'FILL' 1", filter: `drop-shadow(0 0 8px ${glowColor})` }}>
        {icon}
      </span>
      {typeof badge === 'number' && badge > 0 && (
        <span className="absolute -top-1 -right-1 min-w-[26px] h-6.5 flex items-center justify-center bg-[#FF3B30] text-white text-[12px] font-black rounded-full px-1.5 shadow-lg border-2 border-white/40 animate-pulse z-20">
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
  const { isAuthenticated, notifications, userPoints, userPrestige, checkinStatus } = useApp();
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
    <div className="fixed inset-0 z-[90] flex flex-col items-center bg-[#151525] overflow-hidden text-white font-sans selection:bg-white/30">
      
      {/* --- Premium Brightened Liquid Background --- */}
      <div className="absolute inset-0 overflow-hidden pointer-events-none">
        <div className="absolute inset-0 bg-gradient-to-br from-[#1d1d3d] via-[#151525] to-[#2d1b55]" />
        {/* Intense Vibrant Dynamic Blobs */}
        <div className="absolute top-[-10%] left-[-10%] w-[80%] h-[80%] bg-[hsl(215,100%,70%)]/30 rounded-full blur-[140px] animate-blob-1" />
        <div className="absolute bottom-[-10%] right-[-10%] w-[80%] h-[80%] bg-[hsl(275,100%,70%)]/25 rounded-full blur-[160px] animate-blob-2" />
        <div className="absolute top-[20%] right-[-10%] w-[60%] h-[60%] bg-[hsl(330,100%,80%)]/20 rounded-full blur-[130px] animate-blob-3" />
        <div className="absolute inset-0 bg-white/[0.04]" />
      </div>

      {/* --- Minimalist Status Bar (Clock Only) --- */}
      <div className="w-full flex items-center justify-between px-12 py-6 z-50 font-black text-[18px] tracking-tight opacity-100">
        <div>
          <span className="tabular-nums drop-shadow-xl text-white">
            {currentTime.toLocaleTimeString('en-US', { hour: 'numeric', minute: '2-digit', hour12: false })}
          </span>
        </div>
        <div />
      </div>

      {/* --- Main Content --- */}
      <div className="relative z-50 flex-1 w-full flex flex-col items-center px-10 pt-6 sm:pt-14 overflow-hidden">
        
        {/* WIDGET GRID (Optimized Spacing) */}
        <div className="w-full max-w-[1200px] flex flex-wrap justify-center items-center gap-12 mb-20 animate-scale-in">
          
          <Widget 
            title="Today" 
            icon="event_note" 
            className="w-[340px] sm:w-[540px] h-[220px]"
          >
            <div className="flex items-center justify-between h-full px-4 gap-10">
              <div className="flex flex-col items-center gap-2 shrink-0">
                <AnalogClock date={currentTime} />
                <span className="text-[9px] font-black opacity-40 uppercase tracking-[0.2em]">World Clock</span>
              </div>
              
              <div className="w-px h-24 bg-white/20" />
              
              <div className="flex-1 min-w-0">
                <MiniCalendar />
              </div>

              <div className="shrink-0 flex flex-col justify-center">
                <button 
                  onClick={() => navigate('/checkin')}
                  className="w-12 h-12 rounded-full bg-white/20 flex items-center justify-center border border-white/40 active:scale-90 transition-all hover:bg-white/30 backdrop-blur-md shadow-lg"
                >
                  <span className="material-symbols-outlined text-white text-2xl">chevron_right</span>
                </button>
              </div>
            </div>
          </Widget>

          <Widget title="Activity" icon="bolt" className="w-[340px] sm:w-[540px] h-[220px]">
            <div className="flex items-center h-full px-8 justify-around gap-8 overflow-hidden">
               <div className="flex-1 flex flex-col items-center min-w-0">
                  <div className="w-16 h-16 rounded-3xl bg-white/15 backdrop-blur-md flex items-center justify-center mb-4 shadow-inner border border-white/30 shrink-0">
                    <PointsCoin size="md" />
                  </div>
                  <span className="text-2xl sm:text-3xl font-black tracking-tight whitespace-nowrap overflow-visible drop-shadow-md">
                    {userPoints.balance.toLocaleString()}
                  </span>
                  <span className="text-[11px] font-black text-white/50 uppercase tracking-widest mt-1">Points</span>
               </div>
               
               <div className="w-px h-20 bg-white/20" />
               
               <div className="flex-1 flex flex-col items-center min-w-0">
                  <div className="w-16 h-16 rounded-3xl bg-white/15 backdrop-blur-md flex items-center justify-center mb-4 shadow-inner border border-white/30 shrink-0">
                    <span className="material-symbols-outlined text-purple-300" style={{ fontSize: '32px', fontVariationSettings: "'FILL' 1", filter: 'drop-shadow(0 0 10px rgba(168,85,247,0.6))' }}>auto_awesome</span>
                  </div>
                  <span className="text-2xl sm:text-3xl font-black tracking-tight whitespace-nowrap drop-shadow-md">{(userPrestige?.current_stardust || 0).toLocaleString()}</span>
                  <span className="text-[11px] font-black text-white/50 uppercase tracking-widest mt-1">Stardust</span>
               </div>
            </div>
          </Widget>

        </div>

        {/* MAIN APP GRID: TRANSLUCENT STYLE - 4 COLUMN GRID */}
        <div className="w-full max-w-[950px] grid grid-cols-2 sm:grid-cols-4 gap-12 sm:gap-20 mt-6 animate-scale-in px-10 justify-items-center">
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
          <AppIcon 
            icon="workspace_premium" 
            label="Prestige" 
            glowColor="#FFD60A" 
            onClick={() => navigate('/prestige')} 
          />
          <AppIcon 
            icon="public" 
            label="Browser" 
            glowColor="#007AFF" 
            onClick={() => navigate('/browser')} 
          />
        </div>

      </div>

      <style>{`
        @keyframes blob-1 {
          0%, 100% { transform: translate(0, 0) scale(1.1); }
          33% { transform: translate(70px, -90px) scale(1.25); }
          66% { transform: translate(-40px, 70px) scale(0.95); }
        }
        @keyframes blob-2 {
          0%, 100% { transform: translate(0, 0) scale(1.1); }
          33% { transform: translate(-80px, 70px) scale(1.2); }
          66% { transform: translate(70px, -60px) scale(0.9); }
        }
        @keyframes blob-3 {
          0%, 100% { transform: translate(0, 0) scale(1.1); }
          33% { transform: translate(60px, 60px) scale(1.25); }
          66% { transform: translate(-70px, -40px) scale(0.9); }
        }
        .animate-blob-1 { animation: blob-1 25s ease-in-out infinite; }
        .animate-blob-2 { animation: blob-2 30s ease-in-out infinite; }
        .animate-blob-3 { animation: blob-3 22s ease-in-out infinite; }
        .animate-scale-in { animation: scaleIn 1.2s cubic-bezier(0.16, 1, 0.3, 1); }
        @keyframes scaleIn {
          from { transform: scale(0.8); opacity: 0; }
          to { transform: scale(1); opacity: 1; }
        }
      `}</style>
    </div>
  );
};
