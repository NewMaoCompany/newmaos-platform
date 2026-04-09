import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { useApp } from '../AppContext';
import { MatchGame } from './MatchGame';
import { PointsCoin } from '../components/PointsCoin';

// Login Required Modal
const LoginModal = ({ onClose, onLogin }: { onClose: () => void; onLogin: () => void }) => (
  <div className="fixed inset-0 z-[200] flex items-center justify-center p-4 bg-black/60 backdrop-blur-xl animate-fade-in" onClick={onClose}>
    <div
      className="bg-white/90 dark:bg-[#1c1c1e]/90 backdrop-blur-2xl rounded-[28px] p-8 max-w-[340px] w-full text-center shadow-2xl border border-white/20 animate-fade-in-up"
      onClick={e => e.stopPropagation()}
    >
      <div className="w-16 h-16 mx-auto mb-5 bg-gradient-to-br from-blue-500 to-blue-600 rounded-[18px] flex items-center justify-center shadow-lg">
        <span className="material-symbols-outlined text-white text-3xl">lock</span>
      </div>
      <h3 className="text-xl font-bold text-[#1c1c1e] dark:text-white mb-2">Sign In Required</h3>
      <p className="text-sm text-gray-500 dark:text-gray-400 mb-6 leading-relaxed">
        Please sign in to your NewMaoS account to play games and access all features.
      </p>
      <button
        onClick={onLogin}
        className="w-full py-3.5 bg-[#007AFF] text-white rounded-2xl font-semibold text-[15px] active:scale-[0.97] transition-transform mb-3"
      >
        Sign In
      </button>
      <button
        onClick={onClose}
        className="w-full py-3 text-[#007AFF] rounded-2xl font-medium text-[15px] active:opacity-60 transition-opacity"
      >
        Cancel
      </button>
    </div>
  </div>
);

// iOS Style App Icon
const AppIcon = ({ 
  icon, 
  label, 
  gradient, 
  onClick, 
  badge,
  isLarge = false 
}: { 
  icon: string; 
  label: string; 
  gradient: string; 
  onClick: () => void; 
  badge?: number;
  isLarge?: boolean;
}) => (
  <button onClick={onClick} className="flex flex-col items-center gap-2 group transition-all">
    <div 
      className={`rounded-[22%] flex items-center justify-center shadow-2xl relative active:scale-[0.85] transition-all duration-300 ${isLarge ? 'w-[72px] h-[72px]' : 'w-[62px] h-[62px]'}`}
      style={{ 
        background: gradient,
        boxShadow: '0 10px 25px -5px rgba(0,0,0,0.3)',
      }}
    >
      <div className="absolute inset-0 bg-white/10 rounded-[22%] opacity-0 group-hover:opacity-100 transition-opacity" />
      <span className="material-symbols-outlined text-white" style={{ fontSize: isLarge ? '36px' : '30px', fontVariationSettings: "'FILL' 1" }}>
        {icon}
      </span>
      {badge && badge > 0 && (
        <span className="absolute -top-1.5 -right-1.5 min-w-[20px] h-5 flex items-center justify-center bg-[#FF3B30] text-white text-[11px] font-bold rounded-full px-1.5 shadow-lg border-2 border-white/20 backdrop-blur-md">
          {badge > 99 ? '99+' : badge}
        </span>
      )}
    </div>
    <span className="text-[11px] font-bold text-white/90 drop-shadow-md tracking-tight">
      {label}
    </span>
  </button>
);

// iOS Widget (2x2)
const CurrencyWidget = ({ points, stardust }: { points: number; stardust: number }) => (
  <div className="w-[155px] h-[155px] bg-white/10 backdrop-blur-3xl rounded-[28px] p-4 border border-white/20 shadow-2xl flex flex-col justify-between relative overflow-hidden group active:scale-[0.98] transition-transform">
    {/* Liquid Background for Widget */}
    <div className="absolute inset-0 mesh-liquid opacity-40 group-hover:opacity-60 transition-opacity" style={{ background: 'linear-gradient(135deg, #FF3B3011, #5856D611)' }}></div>
    
    <div className="relative z-10 flex items-center justify-between">
      <span className="material-symbols-outlined text-white/40 text-sm">account_balance_wallet</span>
      <span className="text-[9px] font-black text-white/30 uppercase tracking-[0.15em] font-sans">Wallet</span>
    </div>

    <div className="relative z-10 space-y-3">
      <div className="flex flex-col">
        <div className="flex items-center gap-1.5">
          <PointsCoin size="sm" />
          <span className="text-xl font-black text-white tabular-nums drop-shadow-sm leading-none">{points.toLocaleString()}</span>
        </div>
        <span className="text-[9px] font-bold text-white/40 uppercase ml-5 mt-0.5 tracking-wider">NMS Points</span>
      </div>

      <div className="flex flex-col">
        <div className="flex items-center gap-1.5">
          <span className="material-symbols-outlined text-purple-400 text-[14px]" style={{ fontVariationSettings: "'FILL' 1" }}>auto_awesome</span>
          <span className="text-xl font-black text-white tabular-nums drop-shadow-sm leading-none">{stardust.toLocaleString()}</span>
        </div>
        <span className="text-[9px] font-bold text-white/40 uppercase ml-5 mt-0.5 tracking-wider">Stardust</span>
      </div>
    </div>
  </div>
);

export const Lobby = () => {
  const navigate = useNavigate();
  const { isAuthenticated, user, notifications, userPoints, userPrestige } = useApp();
  const [showLoginModal, setShowLoginModal] = useState(false);
  const [showMatchGame, setShowMatchGame] = useState(false);
  const [currentTime, setCurrentTime] = useState(new Date());

  useEffect(() => {
    const timer = setInterval(() => setCurrentTime(new Date()), 1000);
    return () => clearInterval(timer);
  }, []);

  const unreadCount = notifications.filter(n => n.unread).length;

  const handleGameLaunch = (gameId: string) => {
    if (!isAuthenticated) return setShowLoginModal(true);
    if (gameId === 'match3') setShowMatchGame(true);
  };

  if (showMatchGame) return <MatchGame onBack={() => setShowMatchGame(false)} />;

  return (
    <div className="fixed inset-0 z-[90] flex flex-col items-center bg-black overflow-hidden font-sans">
      {/* Primary Liquid Wallpaper */}
      <div className="absolute inset-0 mesh-liquid transition-all duration-1000" 
        style={{ 
          background: 'linear-gradient(215deg, #0a0a1a 0%, #1a1a40 25%, #2d1b69 50%, #4a1b4d 75%, #1a0a2e 100%)',
          filter: 'contrast(1.2) brightness(1.2)'
        }}
      />
      
      {/* Secondary Liquid Shapes */}
      <div className="absolute top-[10%] left-[-20%] w-[100%] h-[100%] rounded-full bg-blue-600/30 blur-[120px] animate-liquid-pulse pointer-events-none" />
      <div className="absolute bottom-[-20%] right-[-10%] w-[120%] h-[120%] rounded-full bg-purple-600/20 blur-[150px] animate-liquid-pulse-slow pointer-events-none" />

      {/* iOS Status Bar */}
      <div className="w-full flex items-center justify-between px-8 pt-3 pb-1 z-50 text-white font-semibold text-[13px]">
        <span className="w-20 tabular-nums">
          {currentTime.toLocaleTimeString('en-US', { hour: 'numeric', minute: '2-digit', hour12: false })}
        </span>
        <div className="flex items-center gap-1.5 opacity-90">
          <span className="material-symbols-outlined text-[17px]">signal_cellular_alt</span>
          <span className="material-symbols-outlined text-[17px]">wifi</span>
          <span className="material-symbols-outlined text-[17px]">battery_80</span>
        </div>
      </div>

      {/* Main Screen Content */}
      <div className="relative z-50 flex-1 w-full max-w-[420px] flex flex-col items-center px-6 pt-10">
        
        {/* iOS Clock Header */}
        <div className="text-center mb-12 animate-page-in">
          <p className="text-white/80 text-[20px] font-semibold tracking-tight uppercase">
            {currentTime.toLocaleDateString('en-US', { weekday: 'long', month: 'long', day: 'numeric' })}
          </p>
          <h1 className="text-white text-[88px] font-thin tracking-tighter -mt-2 drop-shadow-xl" style={{ fontFamily: '"SF Pro Display", -apple-system, sans-serif' }}>
            {currentTime.toLocaleTimeString('en-US', { hour: 'numeric', minute: '2-digit', hour12: false })}
          </h1>
        </div>

        {/* Widgets & Apps Section */}
        <div className="w-full grid grid-cols-2 gap-6 items-start mb-8">
          {/* Top Left: Wallet Widget */}
          <CurrencyWidget points={userPoints.balance} stardust={userPrestige?.current_stardust || 0} />
          
          {/* Top Right: Apps Grid */}
          <div className="grid grid-cols-2 gap-y-6 gap-x-2 h-full">
            <AppIcon 
              icon="function" 
              label="Learning" 
              gradient="linear-gradient(135deg, #f9d406, #FF9500)" 
              onClick={() => navigate('/dashboard')}
              badge={unreadCount}
              isLarge
            />
            <AppIcon 
              icon="grid_view" 
              label="Match 3" 
              gradient="linear-gradient(135deg, #FF2D55, #FF6B9D)" 
              onClick={() => handleGameLaunch('match3')}
              isLarge
            />
          </div>
        </div>

        {/* Page Indicators */}
        <div className="flex items-center gap-1.5 mb-10">
          <div className="w-1.5 h-1.5 rounded-full bg-white shadow-sm" />
          <div className="w-1.5 h-1.5 rounded-full bg-white/30" />
        </div>
      </div>

      {/* Floating Bottom Dock */}
      <div className="absolute bottom-10 left-6 right-6 z-50 flex justify-center">
        <div className="w-full max-w-[360px] bg-white/10 backdrop-blur-3xl rounded-[36px] p-3 border border-white/20 shadow-2xl flex items-center justify-around">
          <AppIcon icon="forum" label="" gradient="linear-gradient(135deg, #5856D6, #AF52DE)" onClick={() => navigate('/forum')} />
          <AppIcon icon="school" label="" gradient="linear-gradient(135deg, #34C759, #28CD41)" onClick={() => navigate('/practice')} />
          <AppIcon icon="analytics" label="" gradient="linear-gradient(135deg, #007AFF, #00BFFF)" onClick={() => navigate('/analysis')} />
          <AppIcon icon="person" label="" gradient="linear-gradient(135deg, #8E8E93, #AEAEB2)" onClick={() => navigate('/settings')} />
        </div>
      </div>

      {/* Home Indicator */}
      <div className="absolute bottom-2 left-1/2 -translate-x-1/2 w-32 h-1 bg-white/30 rounded-full z-50" />

      {/* Modals */}
      {showLoginModal && (
        <LoginModal 
          onClose={() => setShowLoginModal(false)} 
          onLogin={() => { setShowLoginModal(false); navigate('/login'); }} 
        />
      )}

      {/* Global Styles for True Liquid */}
      <style>{`
        @keyframes liquid-pulse {
          0%, 100% { transform: scale(1) translate(0, 0); }
          50% { transform: scale(1.1) translate(20px, -20px); }
        }
        @keyframes liquid-pulse-slow {
          0%, 100% { transform: scale(1) translate(0, 0); }
          50% { transform: scale(1.05) translate(-10px, 10px); }
        }
        .animate-liquid-pulse { animation: liquid-pulse 20s ease-in-out infinite; }
        .animate-liquid-pulse-slow { animation: liquid-pulse-slow 25s ease-in-out infinite; }
        .mesh-liquid {
          background-size: 400% 400% !important;
          animation: mesh-liquid-anim 30s ease infinite !important;
        }
        @keyframes mesh-liquid-anim {
          0% { background-position: 0% 50%; }
          50% { background-position: 100% 50%; }
          100% { background-position: 0% 50%; }
        }
      `}</style>
    </div>
  );
};
