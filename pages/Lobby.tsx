import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { useApp } from '../AppContext';
import { MatchGame } from './MatchGame';
import { PointsCoin } from '../components/PointsCoin';

// --- iOS Components ---

// Analog Clock Widget
const AnalogClock = ({ date }: { date: Date }) => {
  const seconds = date.getSeconds();
  const minutes = date.getMinutes();
  const hours = date.getHours();

  return (
    <div className="w-full h-full relative flex items-center justify-center p-2">
      <div className="w-[105px] h-[105px] rounded-full bg-white/10 backdrop-blur-md border border-white/20 relative shadow-inner">
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
          className="absolute top-1/2 left-1/2 -mt-12 -ml-[0.5px] w-[1px] h-12 bg-[#FF3B30] rounded-full origin-bottom"
          style={{ transform: `rotate(${seconds * 6}deg)` }}
        />
        <div className="absolute top-1/2 left-1/2 -mt-[2px] -ml-[2px] w-1 h-1 bg-white rounded-full shadow-sm" />
      </div>
    </div>
  );
};

// Generic Widget Wrapper
const Widget = ({ children, className = '', title = '', icon = '' }: { children: React.ReactNode; className?: string; title?: string; icon?: string }) => (
  <div className={`aspect-square bg-white/10 backdrop-blur-3xl rounded-[28px] p-4 border border-white/20 shadow-xl overflow-hidden relative group active:scale-[0.98] transition-transform ${className}`}>
    <div className="absolute inset-0 bg-gradient-to-br from-white/5 to-transparent opacity-50" />
    <div className="relative z-10 h-full flex flex-col">
      {title && (
        <div className="flex items-center gap-1.5 mb-2 opacity-40">
          {icon && <span className="material-symbols-outlined text-[12px]">{icon}</span>}
          <span className="text-[9px] font-black uppercase tracking-[0.1em]">{title}</span>
        </div>
      )}
      <div className="flex-1 min-h-0">
        {children}
      </div>
    </div>
  </div>
);

// App Icon Component
const AppIcon = ({ 
  icon, 
  label, 
  gradient, 
  onClick, 
  badge,
  isDock = false,
  fillIcon = true
}: { 
  icon: string; 
  label: string; 
  gradient: string; 
  onClick: () => void; 
  badge?: number;
  isDock?: boolean;
  fillIcon?: boolean;
}) => (
  <button onClick={onClick} className={`flex flex-col items-center gap-1.5 group select-none ${isDock ? 'mt-[-8px]' : ''}`}>
    <div 
      className={`rounded-[22%] flex items-center justify-center shadow-lg relative active:scale-[0.85] active:brightness-90 transition-all duration-300 ${isDock ? 'w-[52px] h-[52px] sm:w-[60px] sm:h-[60px]' : 'w-[62px] h-[62px] sm:w-[68px] sm:h-[68px]'}`}
      style={{ 
        background: gradient,
        boxShadow: '0 8px 20px -5px rgba(0,0,0,0.4)',
      }}
    >
      <div className="absolute inset-0 bg-white/10 rounded-[22%] opacity-0 group-hover:opacity-100 transition-opacity" />
      <span className="material-symbols-outlined text-white" style={{ fontSize: isDock ? '30px' : '34px', fontVariationSettings: fillIcon ? "'FILL' 1" : "'FILL' 0" }}>
        {icon}
      </span>
      {badge && badge > 0 && (
        <span className="absolute -top-1.5 -right-1.5 min-w-[20px] h-5 flex items-center justify-center bg-[#FF3B30] text-white text-[10px] font-black rounded-full px-1.5 shadow-lg border-2 border-white/20 animate-bounce-subtle">
          {badge > 99 ? '99+' : badge}
        </span>
      )}
    </div>
    {!isDock && (
      <span className="text-[11px] font-semibold text-white/90 drop-shadow-md tracking-tight">
        {label}
      </span>
    )}
  </button>
);

export const Lobby = () => {
  const navigate = useNavigate();
  const { isAuthenticated, user, notifications, userPoints, userPrestige, checkinStatus } = useApp();
  const [showMatchGame, setShowMatchGame] = useState(false);
  const [currentTime, setCurrentTime] = useState(new Date());

  useEffect(() => {
    const timer = setInterval(() => setCurrentTime(new Date()), 1000);
    return () => clearInterval(timer);
  }, []);

  const unreadCount = notifications.filter(n => n.unread).length;

  if (showMatchGame) return <MatchGame onBack={() => setShowMatchGame(false)} />;

  return (
    <div className="fixed inset-0 z-[90] flex flex-col items-center bg-[#000] overflow-hidden text-white selection:bg-primary/30">
      {/* --- Wallpaper --- */}
      <div className="absolute inset-0 transition-all duration-1000 overflow-hidden">
        {/* Dynamic Liquid background */}
        <div className="absolute inset-0 bg-gradient-to-br from-[#1a1a40] via-[#2d1b69] to-[#0a0a1a]" />
        <div className="absolute top-[-10%] left-[-10%] w-[60%] h-[60%] bg-[#007AFF]/20 rounded-full blur-[120px] animate-liquid-pulse" />
        <div className="absolute bottom-[-10%] right-[-10%] w-[60%] h-[60%] bg-[#5856D6]/20 rounded-full blur-[120px] animate-liquid-pulse-slow" />
        <div className="absolute top-[30%] right-[10%] w-[40%] h-[40%] bg-[#FF2D55]/10 rounded-full blur-[100px] animate-liquid-pulse" />
      </div>

      {/* --- Status Bar --- */}
      <div className="w-full flex items-center justify-between px-8 py-3 z-50 font-semibold text-[13px] tracking-tight backdrop-blur-sm bg-black/5">
        <div className="flex items-center gap-1">
          <span className="tabular-nums">{currentTime.toLocaleTimeString('en-US', { hour: 'numeric', minute: '2-digit', hour12: false })}</span>
          <span>{currentTime.toLocaleDateString('en-US', { weekday: 'short', month: 'short', day: 'numeric' })}</span>
        </div>
        <div className="flex items-center gap-2 opacity-90">
          <span className="material-symbols-outlined text-[18px]">signal_cellular_alt</span>
          <span className="material-symbols-outlined text-[18px]">wifi</span>
          <div className="flex items-center gap-1 ml-1 px-1.5 py-0.5 rounded-md bg-white/10">
            <span className="text-[10px] font-bold">85%</span>
            <span className="material-symbols-outlined text-[16px]">battery_80</span>
          </div>
        </div>
      </div>

      {/* --- Main iPad Root --- */}
      <div className="relative z-50 flex-1 w-full flex flex-col items-center px-4 sm:px-8 pt-6 sm:pt-10 overflow-y-auto overflow-x-hidden scroll-none">
        
        {/* WIDGET ROW: Explicit flex/grid to prevent overlap */}
        <div className="w-full max-w-[1000px] flex flex-wrap justify-center gap-6 mb-10">
          
          {/* Clock Widget (2x1 equivalent) */}
          <Widget title="Clock" icon="schedule" className="w-full sm:w-[480px] h-[165px]">
            <div className="flex items-center gap-4 sm:gap-8 h-full px-4">
              <AnalogClock date={currentTime} />
              <div className="flex flex-col justify-center gap-1 min-w-0">
                <p className="text-xl sm:text-2xl font-black truncate">{currentTime.toLocaleDateString('en-US', { month: 'long', day: 'numeric' })}</p>
                <p className="text-xs sm:text-sm font-bold text-white/50">{currentTime.toLocaleDateString('en-US', { weekday: 'long' })}</p>
                <div className="mt-2 text-[10px] sm:text-xs font-bold text-primary flex items-center gap-1 underline underline-offset-4 cursor-pointer">
                  Check Schedule <span className="material-symbols-outlined text-[14px]">arrow_forward</span>
                </div>
              </div>
            </div>
          </Widget>

          {/* Learning Status Widget (2x1 equivalent) */}
          <Widget title="Learning Status" icon="analytics" className="w-full sm:w-[480px] h-[165px]">
            <div className="flex items-center gap-4 sm:gap-6 h-full px-4 justify-around">
               <div className="flex flex-col items-center">
                  <div className="w-10 h-10 sm:w-12 sm:h-12 rounded-full bg-blue-500/20 flex items-center justify-center mb-2">
                    <PointsCoin size="sm" />
                  </div>
                  <span className="text-sm sm:text-lg font-black">{userPoints.balance}</span>
                  <span className="text-[8px] sm:text-[9px] font-bold text-white/40 uppercase">Balance</span>
               </div>
               <div className="w-px h-10 sm:h-12 bg-white/10" />
               <div className="flex flex-col items-center">
                  <div className="w-10 h-10 sm:w-12 sm:h-12 rounded-full bg-purple-500/20 flex items-center justify-center mb-2">
                    <span className="material-symbols-outlined text-purple-400">auto_awesome</span>
                  </div>
                  <span className="text-sm sm:text-lg font-black">{userPrestige?.current_stardust || 0}</span>
                  <span className="text-[8px] sm:text-[9px] font-bold text-white/40 uppercase">Stardust</span>
               </div>
               <div className="w-px h-10 sm:h-12 bg-white/10" />
               <div className="flex flex-col items-center">
                  <div className="w-10 h-10 sm:w-12 sm:h-12 rounded-full bg-orange-500/20 flex items-center justify-center mb-2">
                    <span className="material-symbols-outlined text-orange-400">verified</span>
                  </div>
                  <span className="text-sm sm:text-lg font-black">{userPrestige?.world_rank || '-'}</span>
                  <span className="text-[8px] sm:text-[9px] font-bold text-white/40 uppercase">Rank</span>
               </div>
            </div>
          </Widget>

        </div>

        {/* APP GRID: Only Two Apps */}
        <div className="w-full max-w-[1000px] flex justify-center gap-12 sm:gap-20 mb-20">
          <AppIcon 
            icon="function" 
            label="Learning" 
            gradient="linear-gradient(135deg, #f9d406, #FF9500)" 
            onClick={() => navigate('/dashboard')} 
            badge={unreadCount}
          />
          <AppIcon 
            icon="grid_view" 
            label="Game Hub" 
            gradient="linear-gradient(135deg, #FF2D55, #FF6B9D)" 
            onClick={() => setShowMatchGame(true)} 
          />
        </div>

        {/* Page Indicators */}
        <div className="fixed bottom-28 sm:bottom-36 flex items-center gap-1.5 pointer-events-none">
          <div className="w-1.5 h-1.5 rounded-full bg-white shadow-sm" />
          <div className="w-1.5 h-1.5 rounded-full bg-white/30" />
          <div className="w-1.5 h-1.5 rounded-full bg-white/30" />
        </div>
      </div>

      {/* --- IPAD DOCK (Expanded) --- */}
      <div className="fixed bottom-6 sm:bottom-10 left-6 right-6 z-[100] flex justify-center pointer-events-none">
        <div className="w-full max-w-[700px] h-[80px] sm:h-[92px] bg-white/10 backdrop-blur-[50px] rounded-[30px] sm:rounded-[40px] p-2 sm:p-4 border border-white/20 shadow-2xl flex items-center justify-around pointer-events-auto ring-1 ring-white/10">
          <AppIcon icon="forum" label="" gradient="linear-gradient(135deg, #5856D6, #AF52DE)" onClick={() => navigate('/forum')} isDock />
          <AppIcon icon="school" label="" gradient="linear-gradient(135deg, #34C759, #28CD41)" onClick={() => navigate('/practice')} isDock />
          <AppIcon icon="analytics" label="" gradient="linear-gradient(135deg, #007AFF, #00BFFF)" onClick={() => navigate('/analysis')} isDock />
          <AppIcon icon="local_fire_department" label="" gradient="linear-gradient(135deg, #ff9f43, #ff6b6b)" onClick={() => navigate('/dashboard')} isDock badge={checkinStatus === 'not_checked_in' ? 1 : 0} />
          <div className="w-[1px] h-10 bg-white/10 rounded-full mx-1 sm:mx-2" />
          <AppIcon icon="menu_book" label="" gradient="linear-gradient(135deg, #f9d406, #e67e22)" onClick={() => {}} isDock />
          <AppIcon icon="person" label="" gradient="linear-gradient(135deg, #8E8E93, #AEAEB2)" onClick={() => navigate('/settings')} isDock />
        </div>
      </div>

      {/* iPad Home Indicator */}
      <div className="absolute bottom-1.5 left-1/2 -translate-x-1/2 w-40 h-1 bg-white/20 rounded-full z-[101]" />

      <style>{`
        @keyframes liquid-pulse {
          0%, 100% { transform: scale(1) translate(0, 0); }
          50% { transform: scale(1.1) translate(30px, -30px); opacity: 0.3; }
        }
        @keyframes liquid-pulse-slow {
          0%, 100% { transform: scale(1) translate(0, 0); }
          50% { transform: scale(1.05) translate(-20px, 20px); opacity: 0.2; }
        }
        @keyframes bounce-subtle {
          0%, 100% { transform: translateY(0); }
          50% { transform: translateY(-3px); }
        }
        .animate-liquid-pulse { animation: liquid-pulse 20s ease-in-out infinite; }
        .animate-liquid-pulse-slow { animation: liquid-pulse-slow 25s ease-in-out infinite; }
        .animate-bounce-subtle { animation: bounce-subtle 4s ease-in-out infinite; }
        .scroll-none::-webkit-scrollbar { display: none; }
      `}</style>
    </div>
  );
};
