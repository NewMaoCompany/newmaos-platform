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

// iOS App Icon Component
const AppIcon = ({
  icon,
  label,
  gradient,
  onClick,
  badge,
  size = 'normal'
}: {
  icon: string;
  label: string;
  gradient: string;
  onClick: () => void;
  badge?: number;
  size?: 'normal' | 'small';
}) => (
  <button
    onClick={onClick}
    className="flex flex-col items-center gap-1.5 group"
  >
    <div
      className={`${size === 'small' ? 'w-14 h-14 rounded-[14px]' : 'w-[60px] h-[60px] rounded-[15px]'} flex items-center justify-center shadow-lg relative active:scale-[0.9] transition-transform duration-150`}
      style={{ background: gradient }}
    >
      <span className="material-symbols-outlined text-white" style={{ fontSize: size === 'small' ? '26px' : '30px', fontVariationSettings: "'FILL' 1" }}>
        {icon}
      </span>
      {badge && badge > 0 && (
        <span className="absolute -top-1.5 -right-1.5 min-w-[20px] h-5 flex items-center justify-center bg-red-500 text-white text-[11px] font-bold rounded-full px-1.5 shadow-md border-2 border-white">
          {badge > 99 ? '99+' : badge}
        </span>
      )}
    </div>
    <span className="text-[11px] font-medium text-white/90 drop-shadow-sm truncate max-w-[70px]">
      {label}
    </span>
  </button>
);

// Organic Liquid Blob Decoration
const LiquidBlob = ({ className, delay = '0s' }: { className: string; delay?: string }) => (
  <div 
    className={`absolute rounded-full blur-[60px] opacity-20 mix-blend-screen pointer-events-none animate-liquid-blob ${className}`}
    style={{ animationDelay: delay }}
  />
);

export const Lobby = () => {
  const navigate = useNavigate();
  const { isAuthenticated, user, notifications, userPoints, userPrestige } = useApp();
  const [showLoginModal, setShowLoginModal] = useState(false);
  const [showMatchGame, setShowMatchGame] = useState(false);
  const [currentTime, setCurrentTime] = useState(new Date());

  // Update time every minute
  useEffect(() => {
    const timer = setInterval(() => setCurrentTime(new Date()), 60000);
    return () => clearInterval(timer);
  }, []);

  const unreadCount = notifications.filter(n => n.unread).length;

  const handleGameClick = () => {
    if (!isAuthenticated) {
      setShowLoginModal(true);
      return;
    }
    setShowMatchGame(true);
  };

  const timeStr = currentTime.toLocaleTimeString('en-US', { hour: 'numeric', minute: '2-digit', hour12: true });
  const dateStr = currentTime.toLocaleDateString('en-US', { weekday: 'long', month: 'long', day: 'numeric' });

  if (showMatchGame) {
    return <MatchGame onBack={() => setShowMatchGame(false)} />;
  }

  return (
    <div className="fixed inset-0 z-[90] flex flex-col select-none mesh-liquid overflow-hidden"
      style={{
        background: 'linear-gradient(160deg, #1a1a2e 0%, #16213e 25%, #0f3460 50%, #533483 75%, #e94560 100%)',
      }}
    >
      {/* Liquid Elements */}
      <LiquidBlob className="top-[-10%] left-[-10%] w-[50%] h-[50%] bg-blue-500" />
      <LiquidBlob className="bottom-[-10%] right-[-10%] w-[60%] h-[60%] bg-purple-500" delay="2s" />
      <LiquidBlob className="top-[30%] left-[20%] w-[30%] h-[30%] bg-pink-500/40" delay="4s" />
      <LiquidBlob className="bottom-[40%] right-[10%] w-[25%] h-[25%] bg-cyan-500/30" delay="6s" />
      {/* iOS Status Bar */}
      <div className="flex items-center justify-between px-6 pt-3 pb-1 text-white/80 text-xs font-medium">
        <span className="w-20">{timeStr}</span>
        <div className="flex items-center gap-1">
          <span className="material-symbols-outlined text-[14px]">signal_cellular_alt</span>
          <span className="material-symbols-outlined text-[14px]">wifi</span>
          <span className="material-symbols-outlined text-[14px]">battery_full</span>
        </div>
      </div>

      {/* Date & Time Display + Cosmic Wallet */}
      <div className="flex flex-col items-center mt-6 mb-4 px-6 gap-6">
        <div className="text-center">
          <p className="text-white/60 text-sm font-medium tracking-wide">{dateStr}</p>
          <h1 className="text-white text-6xl font-thin tracking-tight mt-1" style={{ fontFamily: '-apple-system, BlinkMacSystemFont, "SF Pro Display", sans-serif' }}>
            {currentTime.toLocaleTimeString('en-US', { hour: 'numeric', minute: '2-digit', hour12: false })}
          </h1>
        </div>

        {/* Liquid Wallet Widget */}
        <div className="w-full max-w-[340px] bg-white/10 backdrop-blur-2xl rounded-[32px] p-5 border border-white/20 shadow-2xl relative overflow-hidden group">
          <div className="absolute inset-0 bg-gradient-to-br from-purple-500/10 to-blue-500/10 opacity-50 group-hover:opacity-100 transition-opacity"></div>
          <div className="relative z-10 flex items-center justify-between">
            {/* Points */}
            <div className="flex flex-col gap-1">
              <span className="text-[10px] font-black text-white/40 uppercase tracking-widest pl-1">Wallet (NMS)</span>
              <div className="flex items-center gap-2 bg-black/20 px-3 py-1.5 rounded-2xl border border-white/5">
                <PointsCoin size={18} />
                <span className="text-xl font-bold text-white tabular-nums">
                  {userPoints.balance.toLocaleString()}
                </span>
              </div>
            </div>
            {/* Stardust */}
            <div className="flex flex-col gap-1 items-end">
              <span className="text-[10px] font-black text-white/40 uppercase tracking-widest pr-1">Stardust</span>
              <div className="flex items-center gap-2 bg-black/20 px-3 py-1.5 rounded-2xl border border-white/5">
                <span className="material-symbols-outlined text-purple-400 text-[18px]" style={{ fontVariationSettings: "'FILL' 1" }}>auto_awesome</span>
                <span className="text-xl font-bold text-white tabular-nums">
                  {(userPrestige?.current_stardust || 0).toLocaleString()}
                </span>
              </div>
            </div>
          </div>
        </div>
      </div>

      {/* App Grid */}
      <div className="flex-1 overflow-y-auto px-6 pb-32">
        {/* Row 1 - Main Apps */}
        <div className="grid grid-cols-4 gap-y-6 gap-x-4 justify-items-center mb-8 max-w-[400px] mx-auto">
          <AppIcon
            icon="dashboard"
            label="Dashboard"
            gradient="linear-gradient(135deg, #FF9500, #FF6B00)"
            onClick={() => navigate('/dashboard')}
          />
          <AppIcon
            icon="edit_note"
            label="Practice"
            gradient="linear-gradient(135deg, #34C759, #248A3D)"
            onClick={() => navigate('/practice')}
          />
          <AppIcon
            icon="analytics"
            label="Analysis"
            gradient="linear-gradient(135deg, #007AFF, #0055CC)"
            onClick={() => navigate('/analysis')}
          />
          <AppIcon
            icon="forum"
            label="Forum"
            gradient="linear-gradient(135deg, #5856D6, #3634A3)"
            onClick={() => navigate('/forum')}
          />

          <AppIcon
            icon="settings"
            label="Settings"
            gradient="linear-gradient(135deg, #8E8E93, #636366)"
            onClick={() => navigate('/settings')}
          />
          <AppIcon
            icon="notifications"
            label="Alerts"
            gradient="linear-gradient(135deg, #FF3B30, #D70015)"
            onClick={() => navigate('/dashboard')}
            badge={unreadCount}
          />
          <AppIcon
            icon="emoji_events"
            label="Points"
            gradient="linear-gradient(135deg, #FFD60A, #FFB800)"
            onClick={() => navigate('/points')}
          />
          <AppIcon
            icon="menu_book"
            label="Textbooks"
            gradient="linear-gradient(135deg, #FF6482, #D63B5E)"
            onClick={() => navigate('/textbooks/AB/1')}
          />

          <AppIcon
            icon="auto_awesome"
            label="Prestige"
            gradient="linear-gradient(135deg, #BF5AF2, #9933CC)"
            onClick={() => navigate('/prestige')}
          />
          <AppIcon
            icon="check_circle"
            label="Check-In"
            gradient="linear-gradient(135deg, #30D158, #28A745)"
            onClick={() => navigate('/checkin')}
          />
          <AppIcon
            icon="error_med"
            label="Mistakes"
            gradient="linear-gradient(135deg, #FF9F0A, #E68A00)"
            onClick={() => navigate('/wrong-answers')}
          />
          <AppIcon
            icon="insights"
            label="Insights"
            gradient="linear-gradient(135deg, #64D2FF, #00A8E8)"
            onClick={() => navigate('/insights')}
          />
        </div>

        {/* Section Divider */}
        <div className="flex items-center gap-3 mb-5 max-w-[400px] mx-auto">
          <div className="h-px flex-1 bg-white/10"></div>
          <span className="text-white/40 text-[11px] font-semibold tracking-widest uppercase">Games</span>
          <div className="h-px flex-1 bg-white/10"></div>
        </div>

        {/* Games Row */}
        <div className="grid grid-cols-4 gap-y-6 gap-x-4 justify-items-center max-w-[400px] mx-auto">
          <AppIcon
            icon="grid_view"
            label="Match 3"
            gradient="linear-gradient(135deg, #FF2D55, #FF6B9D)"
            onClick={handleGameClick}
          />
          {/* Placeholder coming soon apps */}
          <div className="flex flex-col items-center gap-1.5">
            <div className="w-[60px] h-[60px] rounded-[15px] flex items-center justify-center bg-white/5 border border-white/10 border-dashed">
              <span className="material-symbols-outlined text-white/20 text-2xl">add</span>
            </div>
            <span className="text-[11px] font-medium text-white/30">Coming Soon</span>
          </div>
          <div className="flex flex-col items-center gap-1.5">
            <div className="w-[60px] h-[60px] rounded-[15px] flex items-center justify-center bg-white/5 border border-white/10 border-dashed">
              <span className="material-symbols-outlined text-white/20 text-2xl">add</span>
            </div>
            <span className="text-[11px] font-medium text-white/30">Coming Soon</span>
          </div>
          <div className="flex flex-col items-center gap-1.5">
            <div className="w-[60px] h-[60px] rounded-[15px] flex items-center justify-center bg-white/5 border border-white/10 border-dashed">
              <span className="material-symbols-outlined text-white/20 text-2xl">add</span>
            </div>
            <span className="text-[11px] font-medium text-white/30">Coming Soon</span>
          </div>
        </div>
      </div>

      {/* iOS Dock */}
      <div className="absolute bottom-0 left-0 right-0 pb-[calc(env(safe-area-inset-bottom,20px)+8px)] pt-4 px-6">
        <div className="max-w-[400px] mx-auto bg-white/15 backdrop-blur-2xl rounded-[22px] px-6 py-3 flex items-center justify-around border border-white/10 shadow-2xl">
          <button onClick={() => navigate('/dashboard')} className="flex flex-col items-center gap-0.5 active:scale-90 transition-transform">
            <span className="material-symbols-outlined text-white text-[22px]" style={{ fontVariationSettings: "'FILL' 1" }}>home</span>
            <span className="text-[10px] text-white/70 font-medium">Home</span>
          </button>
          <button onClick={() => navigate('/practice')} className="flex flex-col items-center gap-0.5 active:scale-90 transition-transform">
            <span className="material-symbols-outlined text-white text-[22px]" style={{ fontVariationSettings: "'FILL' 1" }}>school</span>
            <span className="text-[10px] text-white/70 font-medium">Learn</span>
          </button>
          <button onClick={handleGameClick} className="flex flex-col items-center gap-0.5 active:scale-90 transition-transform">
            <span className="material-symbols-outlined text-white text-[22px]" style={{ fontVariationSettings: "'FILL' 1" }}>stadia_controller</span>
            <span className="text-[10px] text-white/70 font-medium">Play</span>
          </button>
          <button onClick={() => navigate('/settings')} className="flex flex-col items-center gap-0.5 active:scale-90 transition-transform">
            <span className="material-symbols-outlined text-white text-[22px]" style={{ fontVariationSettings: "'FILL' 1" }}>person</span>
            <span className="text-[10px] text-white/70 font-medium">Profile</span>
          </button>
        </div>
      </div>

      {/* Home Indicator */}
      <div className="absolute bottom-1 left-1/2 -translate-x-1/2 w-32 h-1 bg-white/30 rounded-full"></div>

      {/* Login Modal */}
      {showLoginModal && (
        <LoginModal
          onClose={() => setShowLoginModal(false)}
          onLogin={() => {
            setShowLoginModal(false);
            navigate('/login');
          }}
        />
      )}
    </div>
    <style>{`
      @keyframes liquid-blob {
        0%, 100% { transform: translate(0, 0) scale(1); }
        33% { transform: translate(30px, -50px) scale(1.1); }
        66% { transform: translate(-20px, 20px) scale(0.9); }
      }
      .animate-liquid-blob {
        animation: liquid-blob 15s ease-in-out infinite;
      }
    `}</style>
  );
};
