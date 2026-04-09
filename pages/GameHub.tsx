import React, { useState } from 'react';
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
    description: 'Swap liquid gems to clear the board.'
  },
  {
    id: 'snake',
    title: 'Snake',
    subtitle: 'Radiant Path',
    icon: 'gesture',
    color: '#34C759',
    path: '/games/snake',
    description: 'Grow your glowing trail in a prismatic world.'
  },
  {
    id: '2048',
    title: '2048',
    subtitle: 'Liquid Fusion',
    icon: 'filter_2',
    color: '#FF9500',
    path: '/games/2048',
    description: 'Merge blobs to reach the ultimate fusion.'
  },
  {
    id: 'tetris',
    title: 'Tetris',
    subtitle: 'Aurora Grid',
    icon: 'grid_view',
    color: '#5856D6',
    path: '/games/tetris',
    description: 'Stack crystalline blocks under the aurora.'
  }
];

export const GameHub = () => {
  const navigate = useNavigate();
  const { userPoints } = useApp();

  return (
    <div className="fixed inset-0 z-[100] flex flex-col items-center bg-[#fafaff] text-black font-sans select-none overflow-hidden">
      {/* Prismatic Background */}
      <div className="absolute inset-0 opacity-20 animate-rainbow-fade" style={{ background: 'linear-gradient(45deg, #ff0000, #ff7f00, #ffff00, #00ff00, #0000ff, #4b0082, #8b00ff)', backgroundSize: '400% 400%' }} />
      <div className="absolute top-[-10%] left-[-10%] w-[60%] h-[60%] bg-blue-200 rounded-full blur-[140px] animate-blob-morph" />
      <div className="absolute bottom-[-10%] right-[-10%] w-[60%] h-[60%] bg-pink-200 rounded-full blur-[140px] animate-blob-morph-alt" />

      {/* Header */}
      <div className="w-full flex items-center justify-between px-10 py-10 z-50">
        <button 
            onClick={() => navigate('/lobby')} 
            className="w-14 h-14 rounded-3xl bg-white/40 backdrop-blur-3xl border border-white/60 flex items-center justify-center hover:bg-white/60 active:scale-90 transition-all shadow-xl"
        >
          <span className="material-symbols-outlined text-black text-3xl">arrow_back</span>
        </button>
        <div className="text-center">
          <h1 className="text-5xl font-black italic uppercase text-transparent bg-clip-text bg-gradient-to-r from-blue-600 via-purple-600 to-pink-500 tracking-tighter">Game Hub</h1>
          <p className="text-[11px] font-black tracking-[0.5em] opacity-40 uppercase mt-2 text-black">Prismatic Entertainment</p>
        </div>
        <div className="flex items-center gap-4 bg-white/40 backdrop-blur-3xl px-6 py-3 rounded-3xl border border-white/60 shadow-lg">
           <span className="material-symbols-outlined text-yellow-500 fill-1">monetization_on</span>
           <span className="font-black text-lg tabular-nums">{userPoints.balance.toLocaleString()}</span>
        </div>
      </div>

      {/* Game Grid */}
      <div className="relative z-50 flex-1 w-full max-w-[1200px] flex items-center justify-center px-10">
        <div className="grid grid-cols-1 sm:grid-cols-2 gap-10 sm:gap-14 w-full">
          {GAMES.map((game, idx) => (
            <button
              key={game.id}
              onClick={() => navigate(game.path)}
              className="group relative h-[180px] sm:h-[240px] flex items-center px-10 rounded-[52px] bg-white/40 backdrop-blur-3xl border border-white/60 shadow-2xl transition-all duration-700 hover:scale-[1.03] hover:bg-white/60 active:scale-95 text-left overflow-hidden"
            >
              <div 
                className="absolute inset-x-0 bottom-0 h-1 transition-all duration-700 group-hover:h-3"
                style={{ background: game.color }}
              />
              <div 
                className="absolute -right-20 -top-20 w-64 h-64 rounded-full blur-[80px] opacity-20 transition-opacity duration-700 group-hover:opacity-40"
                style={{ background: game.color }}
              />
              
              <div 
                className="w-24 h-24 sm:w-32 sm:h-32 rounded-[32%] flex items-center justify-center relative shadow-xl mr-8 shrink-0 transition-all duration-700 group-hover:shadow-[0_20px_40px_rgba(0,0,0,0.1)]"
                style={{ background: 'white' }}
              >
                <div className="absolute inset-0 bg-gradient-to-br from-white to-transparent opacity-60 rounded-[32%]" />
                <span 
                    className="material-symbols-outlined z-10 font-[variation-settings:'FILL' 1]" 
                    style={{ fontSize: '48px', color: game.color, filter: `drop-shadow(0 0 12px ${game.color}66)` }}
                >
                  {game.icon}
                </span>
                {/* Internal Blob Animation in icon */}
                <div 
                    className="absolute inset-2 bg-gradient-to-br opacity-5 rounded-[28%] animate-blob-morph" 
                    style={{ background: game.color }}
                />
              </div>

              <div className="flex-1 min-w-0">
                <p className="text-[12px] font-black uppercase tracking-[0.4em] mb-1" style={{ color: game.color }}>{game.subtitle}</p>
                <h3 className="text-4xl sm:text-5xl font-black text-black italic uppercase tracking-tighter mb-2">{game.title}</h3>
                <p className="text-black/40 text-[13px] font-bold leading-snug max-w-[280px] group-hover:text-black/60 transition-colors">
                  {game.description}
                </p>
              </div>

              <div className="ml-4 opacity-0 group-hover:opacity-100 transition-all duration-700 -translate-x-10 group-hover:translate-x-0">
                 <span className="material-symbols-outlined text-4xl text-black/20">arrow_forward_ios</span>
              </div>
            </button>
          ))}
        </div>
      </div>

      <style>{`
        @keyframes rainbow-fade {
          0% { background-position: 0% 50%; }
          50% { background-position: 100% 50%; }
          100% { background-position: 0% 50%; }
        }
        @keyframes blob-morph {
          0%, 100% { border-radius: 60% 40% 30% 70% / 60% 30% 70% 40%; transform: scale(1) rotate(0deg); }
          50% { border-radius: 30% 60% 70% 40% / 50% 60% 30% 60%; transform: scale(1.08) rotate(5deg); }
        }
        @keyframes blob-morph-alt {
          0%, 100% { border-radius: 40% 60% 60% 40% / 40% 60% 60% 40%; transform: scale(1.1) rotate(0deg); }
          50% { border-radius: 60% 40% 40% 60% / 60% 40% 40% 60%; transform: scale(1) rotate(-5deg); }
        }
        .animate-rainbow-fade { animation: rainbow-fade 12s linear infinite; }
        .animate-blob-morph { animation: blob-morph 15s ease-in-out infinite; }
        .animate-blob-morph-alt { animation: blob-morph-alt 18s ease-in-out infinite; }
      `}</style>
    </div>
  );
};
