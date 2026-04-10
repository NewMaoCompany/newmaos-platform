import React, { useEffect, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { useApp } from '../AppContext';

const GAMES = [
  {
    id: 'match3',
    title: 'Match 3',
    subtitle: 'Rainbow Prism',
    icon: 'apps',
    color: '#FF2D55',
    path: '/games/match3',
    description: 'Liquid gems odyssey. Master the spectrum.'
  },
  {
    id: 'snake',
    title: 'Snake',
    subtitle: 'Hyper-Noir',
    icon: 'terminal',
    color: '#00f2ff',
    path: '/games/snake',
    description: 'Neural uplink established. Execute sequence.'
  },
  {
    id: '2048',
    title: '2048',
    subtitle: 'Washi Zen',
    icon: 'potted_plant',
    color: '#8D7B68',
    path: '/games/2048',
    description: 'Harmony in motion. Seek the ultimate fusion.'
  },
  {
    id: 'tetris',
    title: 'Tetris',
    subtitle: 'Orbital HUD',
    icon: 'rocket_launch',
    color: '#AF52DE',
    path: '/games/tetris',
    description: 'Command center stable. Cargo stabilization active.'
  }
];

export const GameHub = () => {
  const navigate = useNavigate();
  const { userPoints } = useApp();
  const [orbs, setOrbs] = useState<{ id: number; x: number; y: number; size: number; color: string; delay: number }[]>([]);

  useEffect(() => {
    setOrbs(Array.from({ length: 8 }).map((_, i) => ({
      id: i,
      x: Math.random() * 100,
      y: Math.random() * 100,
      size: 200 + Math.random() * 300,
      color: ['#ff00ff', '#00ffff', '#ffff00', '#00ff00'][i % 4],
      delay: Math.random() * 10
    })));
  }, []);

  return (
    <div className="fixed inset-0 z-[100] flex flex-col items-center bg-[#050510] text-white font-sans select-none overflow-hidden">
      
      {/* Premium Aurora Background */}
      <div className="absolute inset-0 pointer-events-none">
        <div className="absolute inset-0 bg-gradient-to-br from-[#050510] via-[#0a0a25] to-[#050510]" />
        {orbs.map(orb => (
          <div 
            key={orb.id}
            className="absolute rounded-full blur-[120px] opacity-10 animate-blob-morph"
            style={{ 
              left: `${orb.x}%`, 
              top: `${orb.y}%`, 
              width: orb.size, 
              height: orb.size, 
              background: orb.color,
              animationDelay: `${orb.delay}s`,
              animationDuration: `${15 + orb.delay}s`
            }}
          />
        ))}
        <div className="absolute inset-0 bg-[url('https://www.transparenttextures.com/patterns/carbon-fibre.png')] opacity-[0.03]" />
      </div>

      {/* Header - Premium Minimalist */}
      <div className="w-full flex items-center justify-between px-8 sm:px-14 py-8 sm:py-12 z-50 shrink-0">
        <button 
            onClick={() => navigate('/lobby')} 
            className="group w-12 h-12 sm:w-16 sm:h-16 rounded-[24px] bg-white/5 backdrop-blur-3xl border border-white/10 flex items-center justify-center hover:bg-white/10 active:scale-90 transition-all shadow-2xl"
        >
          <span className="material-symbols-outlined text-white/60 text-2xl sm:text-3xl group-hover:text-white transition-colors">arrow_back</span>
        </button>
        
        <div className="text-center">
          <h1 className="text-4xl sm:text-7xl font-black italic uppercase tracking-tighter bg-clip-text text-transparent bg-gradient-to-r from-blue-400 via-purple-400 to-pink-500 drop-shadow-2xl">Arcade Vault</h1>
          <div className="flex items-center justify-center gap-4 mt-2 sm:mt-4">
             <div className="h-[1px] w-10 bg-white/10" />
             <p className="text-[10px] sm:text-[12px] font-black tracking-[0.6em] opacity-40 uppercase">Premium Interactive Lab</p>
             <div className="h-[1px] w-10 bg-white/10" />
          </div>
        </div>
        
        <div className="flex items-center gap-4 bg-white/5 backdrop-blur-3xl px-4 sm:px-8 py-3 sm:py-4 rounded-[28px] border border-white/10 shadow-2xl group hover:border-white/30 transition-all">
           <span className="material-symbols-outlined text-yellow-400 fill-1 text-2xl group-hover:rotate-12 transition-transform">monetization_on</span>
           <div className="flex flex-col">
              <span className="text-[9px] font-black opacity-30 uppercase tracking-widest">Balance</span>
              <span className="font-black text-lg sm:text-2xl tabular-nums leading-none tracking-tighter">{userPoints.balance.toLocaleString()}</span>
           </div>
        </div>
      </div>

      {/* Adaptive Game Carousel/Grid */}
      <div className="relative z-50 flex-1 w-full flex flex-col items-center justify-center p-6 sm:p-12 overflow-y-auto custom-scrollbar min-h-0">
        <div className="grid grid-cols-1 md:grid-cols-2 gap-8 sm:gap-12 w-full max-w-6xl pb-10">
          {GAMES.map((game, idx) => (
            <button
              key={game.id}
              onClick={() => navigate(game.path)}
              className="group relative flex items-center p-8 sm:p-10 rounded-[48px] bg-white/5 backdrop-blur-2xl border border-white/10 shadow-2xl transition-all duration-700 hover:scale-[1.02] hover:bg-white/10 active:scale-[0.98] text-left overflow-hidden"
            >
              {/* Animated Accent */}
              <div 
                className="absolute inset-x-0 bottom-0 h-[2px] opacity-30 group-hover:h-2 group-hover:opacity-100 transition-all duration-500"
                style={{ background: game.color, filter: `drop-shadow(0 0 10px ${game.color})` }}
              />
              
              {/* Dynamic Glow Orb */}
              <div 
                className="absolute -right-16 -top-16 w-56 h-56 rounded-full blur-[70px] opacity-10 transition-all duration-700 group-hover:opacity-30 group-hover:scale-125"
                style={{ background: game.color }}
              />

              {/* Icon Container - Premium Circle */}
              <div 
                className="w-20 h-20 sm:w-28 sm:h-28 rounded-full flex items-center justify-center relative shadow-3xl mr-6 sm:mr-10 shrink-0 transition-all duration-700 group-hover:shadow-[0_0_40px_rgba(255,255,255,0.1)] overflow-hidden"
                style={{ background: 'rgba(255,255,255,0.03)', border: '1px solid rgba(255,255,255,0.1)' }}
              >
                <div className="absolute inset-0 bg-gradient-to-tr from-white/10 to-transparent opacity-40" />
                <span 
                    className="material-symbols-outlined z-10 font-[variation-settings:'FILL' 1]" 
                    style={{ fontSize: '40px', color: game.color, filter: `drop-shadow(0 0 15px ${game.color})` }}
                >
                  {game.icon}
                </span>
                <div className="absolute inset-0 bg-white/5 opacity-0 group-hover:opacity-100 transition-opacity" />
              </div>

              <div className="flex-1 min-w-0 pr-4">
                <div className="flex items-center gap-3 mb-1">
                   <p className="text-[10px] sm:text-[11px] font-black uppercase tracking-[0.4em] opacity-40 group-hover:opacity-80 transition-opacity" style={{ color: game.color }}>{game.subtitle}</p>
                   <div className="h-[1px] flex-1 bg-white/5" />
                </div>
                <h3 className="text-3xl sm:text-5xl font-black italic uppercase tracking-tighter mb-2 sm:mb-3 drop-shadow-md">{game.title}</h3>
                <p className="text-white/40 text-[12px] sm:text-[14px] font-medium leading-relaxed max-w-[320px] group-hover:text-white/60 transition-colors line-clamp-2">
                  {game.description}
                </p>
              </div>

              <div className="hidden sm:block opacity-0 group-hover:opacity-100 transition-all duration-700 -translate-x-10 group-hover:translate-x-0">
                 <span className="material-symbols-outlined text-4xl text-white/10 group-hover:text-white/30 transition-all">chevron_right</span>
              </div>
            </button>
          ))}
        </div>
      </div>

      <style>{`
        @keyframes blob-morph {
          0%, 100% { border-radius: 60% 40% 30% 70% / 60% 30% 70% 40%; transform: translate(0,0) scale(1) rotate(0deg); }
          33% { border-radius: 40% 60% 70% 30% / 50% 60% 40% 50%; transform: translate(20px, -20px) scale(1.1) rotate(5deg); }
          66% { border-radius: 70% 30% 50% 50% / 40% 50% 60% 30%; transform: translate(-20px, 20px) scale(0.9) rotate(-5deg); }
        }
        .custom-scrollbar::-webkit-scrollbar { width: 4px; }
        .custom-scrollbar::-webkit-scrollbar-thumb { background: rgba(255,255,255,0.05); border-radius: 10px; }
        .custom-scrollbar::-webkit-scrollbar-thumb:hover { background: rgba(255,255,255,0.1); }
      `}</style>
    </div>
  );
};
