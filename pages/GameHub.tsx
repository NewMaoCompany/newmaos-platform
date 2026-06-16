import React, { useEffect, useState, useRef } from 'react';
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
    description: 'Liquid gems odyssey. Master the spectrum.',
    cost: 5
  },
  {
    id: 'snake',
    title: 'Neon Snake',
    subtitle: 'Hyper-Noir',
    icon: 'terminal',
    color: '#00f2ff',
    path: '/games/snake',
    description: 'Neural uplink established. Execute sequence.',
    cost: 5
  },
  {
    id: '2048',
    title: '2048',
    subtitle: 'Washi Zen',
    icon: 'potted_plant',
    color: '#8D7B68',
    path: '/games/2048',
    description: 'Harmony in motion. Seek the ultimate fusion.',
    cost: 5
  },
  {
    id: 'tetris',
    title: 'Tetris',
    subtitle: 'Orbital HUD',
    icon: 'rocket_launch',
    color: '#AF52DE',
    path: '/games/tetris',
    description: 'Command center stable. Cargo stabilization active.',
    cost: 10
  },
  {
    id: 'memory',
    title: 'Memory Matrix',
    subtitle: 'Neural Link',
    icon: 'memory',
    color: '#00f2ff',
    path: '/games/memory',
    description: 'Establish sequence protocol. Test your cortical limits.',
    cost: 5
  },
  {
    id: 'minesweeper',
    title: 'Neon Mines',
    subtitle: 'Cyber Sweeper',
    icon: 'crisis_alert',
    color: '#00ff88',
    path: '/games/minesweeper',
    description: 'Defuse the glowing grid. Logic is your only shield.',
    cost: 10
  },
  {
    id: 'neon-knight',
    title: 'Neon Knight',
    subtitle: 'Rogue Protocol',
    icon: 'swords',
    color: '#ff0055',
    path: '/games/neon-knight',
    description: 'Dive into the neon dungeon. Survive the swarm.',
    cost: 15
  },
  {
    id: 'defenders',
    title: 'Garden Defenders',
    subtitle: 'Lane Tactics',
    icon: 'forest',
    color: '#34c759',
    path: '/games/defenders',
    description: 'Deploy units. Defend the core from neon bugs.',
    cost: 15
  },
  {
    id: 'sky-roller',
    title: 'Sky Roller',
    subtitle: 'Velocity Dash',
    icon: 'sports_volleyball',
    color: '#ff9500',
    path: '/games/sky-roller',
    description: 'Navigate the skies. Reflexes are everything.',
    cost: 10
  },
  {
    id: 'brawl-arena',
    title: 'Brawl Arena',
    subtitle: 'Survival Clash',
    icon: 'sports_martial_arts',
    color: '#ffcc00',
    path: '/games/brawl-arena',
    description: 'Enter the arena. Last one standing takes all.',
    cost: 20
  }
];

export const GameHub = () => {
  const navigate = useNavigate();
  const { userPoints, userPrestige } = useApp();
  const [orbs, setOrbs] = useState<{ id: number; x: number; y: number; size: number; color: string; delay: number }[]>([]);
  
  const hoverSound = useRef<HTMLAudioElement | null>(null);
  const clickSound = useRef<HTMLAudioElement | null>(null);

  useEffect(() => {
    setOrbs(Array.from({ length: 12 }).map((_, i) => ({
      id: i,
      x: Math.random() * 100,
      y: Math.random() * 100,
      size: 100 + Math.random() * 400,
      color: ['#ff0055', '#00f2ff', '#34c759', '#ffcc00', '#AF52DE'][i % 5],
      delay: Math.random() * 5
    })));

    hoverSound.current = new Audio('https://assets.mixkit.co/active_storage/sfx/2571/2571-preview.mp3');
    hoverSound.current.volume = 0.1;
    clickSound.current = new Audio('https://assets.mixkit.co/active_storage/sfx/2568/2568-preview.mp3');
    clickSound.current.volume = 0.3;
  }, []);

  const playHover = () => {
    if (hoverSound.current) {
      hoverSound.current.currentTime = 0;
      hoverSound.current.play().catch(() => {});
    }
  };

  const playClick = () => {
    if (clickSound.current) {
      clickSound.current.currentTime = 0;
      clickSound.current.play().catch(() => {});
    }
  };

  const handleGameSelect = (path: string) => {
    playClick();
    setTimeout(() => {
      navigate(path);
    }, 300);
  };

  return (
    <div className="fixed inset-0 z-[100] flex flex-col items-center bg-[#050510] text-white font-sans select-none overflow-hidden">
      
      {/* Premium Aurora Background */}
      <div className="absolute inset-0 pointer-events-none">
        <div className="absolute inset-0 bg-gradient-to-br from-[#050510] via-[#0a0a25] to-[#050510]" />
        {orbs.map(orb => (
          <div 
            key={orb.id}
            className="absolute rounded-full blur-[120px] opacity-[0.15] animate-blob-morph"
            style={{ 
              left: `${orb.x}%`, 
              top: `${orb.y}%`, 
              width: orb.size, 
              height: orb.size, 
              background: orb.color,
              animationDelay: `${orb.delay}s`,
              animationDuration: `${10 + orb.delay}s`
            }}
          />
        ))}
        <div className="absolute inset-0 bg-[url('https://www.transparenttextures.com/patterns/carbon-fibre.png')] opacity-[0.05]" />
      </div>

      {/* Header - Premium Minimalist */}
      <div className="w-full flex items-center justify-between px-8 sm:px-14 py-8 sm:py-12 z-50 shrink-0">
        <button 
            onClick={() => { playClick(); navigate('/lobby'); }}
            onMouseEnter={playHover}
            className="group w-12 h-12 sm:w-16 sm:h-16 rounded-[24px] bg-white/5 backdrop-blur-3xl border border-white/10 flex items-center justify-center hover:bg-white/10 active:scale-90 transition-all shadow-2xl"
        >
          <span className="material-symbols-outlined text-white/60 text-2xl sm:text-3xl group-hover:text-white transition-colors">arrow_back</span>
        </button>
        
        <div className="text-center">
          <h1 className="text-4xl sm:text-7xl font-black italic uppercase tracking-tighter bg-clip-text text-transparent bg-gradient-to-r from-blue-400 via-purple-400 to-pink-500 drop-shadow-2xl pr-4">Arcade Vault</h1>
          <div className="flex items-center justify-center gap-4 mt-2 sm:mt-4">
             <div className="h-[1px] w-10 bg-white/10" />
             <p className="text-[10px] sm:text-[12px] font-black tracking-[0.6em] opacity-40 uppercase animate-pulse">Advanced Entertainment System</p>
             <div className="h-[1px] w-10 bg-white/10" />
          </div>
        </div>
        
        <div className="flex gap-4">
            {/* Star Dust */}
            <div className="flex items-center gap-3 bg-indigo-900/20 backdrop-blur-3xl px-4 sm:px-6 py-3 sm:py-4 rounded-[28px] border border-indigo-500/20 shadow-2xl group transition-all hover:border-indigo-500/50">
               <span className="material-symbols-outlined text-indigo-400 fill-1 text-2xl group-hover:animate-pulse">auto_awesome</span>
               <div className="flex flex-col">
                  <span className="text-[9px] font-black opacity-40 uppercase tracking-widest text-indigo-300">Stardust</span>
                  <span className="font-black text-lg sm:text-2xl tabular-nums leading-none tracking-tighter text-indigo-100">{userPrestige?.current_stardust || 0}</span>
               </div>
            </div>
            {/* Coins */}
            <div className="flex items-center gap-3 bg-amber-900/20 backdrop-blur-3xl px-4 sm:px-6 py-3 sm:py-4 rounded-[28px] border border-amber-500/20 shadow-2xl group transition-all hover:border-amber-500/50">
               <span className="material-symbols-outlined text-amber-400 fill-1 text-2xl group-hover:rotate-12 transition-transform">monetization_on</span>
               <div className="flex flex-col">
                  <span className="text-[9px] font-black opacity-40 uppercase tracking-widest text-amber-300">Coins</span>
                  <span className="font-black text-lg sm:text-2xl tabular-nums leading-none tracking-tighter text-amber-100">{userPoints.balance.toLocaleString()}</span>
               </div>
            </div>
        </div>
      </div>

      {/* Adaptive Game Carousel/Grid */}
      <div className="relative z-50 flex-1 w-full flex flex-col items-center justify-start p-6 sm:p-12 overflow-y-auto custom-scrollbar min-h-0">
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-2 xl:grid-cols-2 2xl:grid-cols-3 gap-8 sm:gap-10 w-full max-w-[1400px] pb-24">
          {GAMES.map((game, idx) => (
            <button
              key={game.id}
              onClick={() => handleGameSelect(game.path)}
              onMouseEnter={playHover}
              className="group relative flex flex-col sm:flex-row items-start sm:items-center p-6 sm:p-8 rounded-[40px] bg-white/[0.03] backdrop-blur-xl border border-white/10 shadow-2xl transition-all duration-500 hover:-translate-y-2 hover:bg-white/[0.08] active:scale-[0.98] text-left overflow-hidden isolate"
              style={{ animation: `fadeUp 0.5s ease-out ${idx * 0.05}s both` }}
            >
              {/* Animated Accent */}
              <div 
                className="absolute inset-x-0 bottom-0 h-[4px] opacity-40 group-hover:h-full group-hover:opacity-[0.05] transition-all duration-500 z-[-1]"
                style={{ background: game.color }}
              />
              
              {/* Dynamic Glow Orb */}
              <div 
                className="absolute -right-20 -top-20 w-64 h-64 rounded-full blur-[80px] opacity-10 transition-all duration-700 group-hover:opacity-30 group-hover:scale-150 z-[-1]"
                style={{ background: game.color }}
              />

              {/* Icon Container - Premium Circle */}
              <div 
                className="w-20 h-20 sm:w-28 sm:h-28 rounded-[32px] sm:rounded-[40px] flex items-center justify-center relative shadow-3xl mb-6 sm:mb-0 sm:mr-8 shrink-0 transition-all duration-700 group-hover:shadow-[0_0_50px_rgba(255,255,255,0.15)] group-hover:rotate-[-5deg] overflow-hidden"
                style={{ background: 'rgba(255,255,255,0.02)', border: `1px solid ${game.color}40` }}
              >
                <div className="absolute inset-0 bg-gradient-to-tr from-white/10 to-transparent opacity-40" />
                <span 
                    className="material-symbols-outlined z-10 font-[variation-settings:'FILL' 1] transition-transform duration-500 group-hover:scale-110" 
                    style={{ fontSize: '48px', color: game.color, filter: `drop-shadow(0 0 20px ${game.color})` }}
                >
                  {game.icon}
                </span>
                <div className="absolute inset-0 bg-white/5 opacity-0 group-hover:opacity-100 transition-opacity" />
              </div>

              <div className="flex-1 min-w-0 pr-4">
                <div className="flex items-center gap-3 mb-2">
                   <p className="text-[10px] sm:text-[12px] font-black uppercase tracking-[0.3em] opacity-60 group-hover:opacity-100 transition-opacity" style={{ color: game.color }}>{game.subtitle}</p>
                   <div className="h-[1px] flex-1" style={{ background: `linear-gradient(90deg, ${game.color}40, transparent)` }} />
                </div>
                <h3 className="text-3xl sm:text-4xl font-black italic uppercase tracking-tighter mb-3 drop-shadow-md">{game.title}</h3>
                <p className="text-white/50 text-[13px] sm:text-[15px] font-medium leading-relaxed max-w-[320px] group-hover:text-white/80 transition-colors line-clamp-2">
                  {game.description}
                </p>
                <div className="mt-4 flex items-center gap-2 bg-black/40 w-max px-3 py-1.5 rounded-full border border-white/5">
                   <span className="material-symbols-outlined text-amber-400 text-sm">monetization_on</span>
                   <span className="text-xs font-bold text-white/80">{game.cost} Coins per play</span>
                </div>
              </div>

              <div className="absolute right-8 top-1/2 -translate-y-1/2 opacity-0 group-hover:opacity-100 transition-all duration-500 -translate-x-10 group-hover:translate-x-0 hidden sm:block">
                 <div className="w-12 h-12 rounded-full bg-white/10 flex items-center justify-center backdrop-blur-md">
                   <span className="material-symbols-outlined text-white">play_arrow</span>
                 </div>
              </div>
            </button>
          ))}
        </div>
      </div>

      <style>{`
        @keyframes blob-morph {
          0%, 100% { border-radius: 60% 40% 30% 70% / 60% 30% 70% 40%; transform: translate(0,0) scale(1) rotate(0deg); }
          33% { border-radius: 40% 60% 70% 30% / 50% 60% 40% 50%; transform: translate(30px, -30px) scale(1.1) rotate(10deg); }
          66% { border-radius: 70% 30% 50% 50% / 40% 50% 60% 30%; transform: translate(-30px, 30px) scale(0.9) rotate(-10deg); }
        }
        @keyframes fadeUp {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .custom-scrollbar::-webkit-scrollbar { width: 6px; }
        .custom-scrollbar::-webkit-scrollbar-track { background: transparent; }
        .custom-scrollbar::-webkit-scrollbar-thumb { background: rgba(255,255,255,0.1); border-radius: 10px; }
        .custom-scrollbar::-webkit-scrollbar-thumb:hover { background: rgba(255,255,255,0.2); }
      `}</style>
    </div>
  );
};
