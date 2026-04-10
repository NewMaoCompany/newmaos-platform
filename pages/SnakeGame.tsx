import React, { useState, useEffect, useCallback, useRef } from 'react';
import { useNavigate } from 'react-router-dom';
import { useApp } from '../AppContext';

const GRID_SIZE = 20;
const INITIAL_SNAKE = [{ x: 10, y: 10 }, { x: 10, y: 11 }, { x: 10, y: 12 }];
const INITIAL_DIRECTION = { x: 0, y: -1 };
const BASE_SPEED = 140;

export const SnakeGame = () => {
  const navigate = useNavigate();
  const { awardPoints } = useApp();
  const [snake, setSnake] = useState(INITIAL_SNAKE);
  const [direction, setDirection] = useState(INITIAL_DIRECTION);
  const [food, setFood] = useState({ x: 5, y: 5 });
  const [score, setScore] = useState(0);
  const [gameOver, setGameOver] = useState(false);
  const [gameStarted, setGameStarted] = useState(false);
  const [glitch, setGlitch] = useState(false);
  
  const gameLoopRef = useRef<NodeJS.Timeout | null>(null);
  const lastDirRef = useRef(INITIAL_DIRECTION);

  const triggerGlitch = () => {
    setGlitch(true);
    setTimeout(() => setGlitch(false), 150);
  };

  const generateFood = useCallback((currentSnake: { x: number; y: number }[]) => {
    let newFood;
    while (true) {
      newFood = {
        x: Math.floor(Math.random() * GRID_SIZE),
        y: Math.floor(Math.random() * GRID_SIZE),
      };
      if (!currentSnake.some(segment => segment.x === newFood!.x && segment.y === newFood!.y)) break;
    }
    return newFood;
  }, []);

  const resetGame = () => {
    setSnake(INITIAL_SNAKE);
    setDirection(INITIAL_DIRECTION);
    lastDirRef.current = INITIAL_DIRECTION;
    setFood(generateFood(INITIAL_SNAKE));
    setScore(0);
    setGameOver(false);
    setGameStarted(true);
  };

  const moveSnake = useCallback(() => {
    setSnake(prevSnake => {
      const head = prevSnake[0];
      const newHead = {
        x: (head.x + direction.x + GRID_SIZE) % GRID_SIZE,
        y: (head.y + direction.y + GRID_SIZE) % GRID_SIZE,
      };

      if (prevSnake.some(segment => segment.x === newHead.x && segment.y === newHead.y)) {
        setGameOver(true);
        if (score > 100) awardPoints(Math.floor(score / 10), 'Played Snake: Hyper-Noir');
        return prevSnake;
      }

      const newSnake = [newHead, ...prevSnake];

      if (newHead.x === food.x && newHead.y === food.y) {
        setScore(s => s + 50);
        setFood(generateFood(newSnake));
        triggerGlitch();
      } else {
        newSnake.pop();
      }

      lastDirRef.current = direction;
      return newSnake;
    });
  }, [direction, food, generateFood, score, awardPoints]);

  useEffect(() => {
    if (gameStarted && !gameOver) {
      const speed = Math.max(60, BASE_SPEED - Math.floor(score / 200) * 5);
      gameLoopRef.current = setInterval(moveSnake, speed);
    } else {
      if (gameLoopRef.current) clearInterval(gameLoopRef.current);
    }
    return () => { if (gameLoopRef.current) clearInterval(gameLoopRef.current); };
  }, [gameStarted, gameOver, moveSnake, score]);

  useEffect(() => {
    const handleKeydown = (e: KeyboardEvent) => {
      if (!gameStarted) return;
      const key = e.key;
      if (key === 'ArrowUp' && lastDirRef.current.y === 0) setDirection({ x: 0, y: -1 });
      if (key === 'ArrowDown' && lastDirRef.current.y === 0) setDirection({ x: 0, y: 1 });
      if (key === 'ArrowLeft' && lastDirRef.current.x === 0) setDirection({ x: -1, y: 0 });
      if (key === 'ArrowRight' && lastDirRef.current.x === 0) setDirection({ x: 1, y: 0 });
    };
    window.addEventListener('keydown', handleKeydown);
    return () => window.removeEventListener('keydown', handleKeydown);
  }, [gameStarted]);

  return (
    <div className={`fixed inset-0 z-[110] flex flex-col items-center bg-[#050508] text-[#00f2ff] font-mono overflow-hidden transition-all duration-75 ${glitch ? 'scale-[1.01] invert-[0.05]' : 'scale-100'}`}>
      
      {/* Dynamic Background */}
      <div className="absolute inset-0 pointer-events-none">
        <div className="absolute inset-0 opacity-20 bg-[url('https://www.transparenttextures.com/patterns/asfalt-dark.png')]" />
        <div className="absolute inset-0 bg-[radial-gradient(circle_at_50%_50%,_#1a1a2e_0%,_#050508_100%)]" />
        <div className="absolute top-0 w-full h-full opacity-10 bg-[linear-gradient(rgba(18,16,16,0)_50%,rgba(0,0,0,0.25)_50%),linear-gradient(90deg,rgba(255,0,0,0.06),rgba(0,255,0,0.02),rgba(0,0,255,0.06))] z-10 bg-[length:100%_2px,3px_100%]" />
        <div className="absolute top-0 w-full h-[3px] bg-cyan-500/10 shadow-[0_0_20px_rgba(0,242,255,0.4)] animate-scanline" />
      </div>

      {/* Header Container - Adaptive */}
      <div className="w-full flex items-center justify-between px-6 sm:px-12 py-4 sm:py-8 z-50 shrink-0">
        <button 
            onClick={() => navigate('/games')} 
            className="w-10 h-10 sm:w-14 sm:h-14 bg-black/40 border border-cyan-500/30 flex items-center justify-center hover:bg-cyan-500/20 active:scale-90 transition-all shadow-[0_0_15px_rgba(0,242,255,0.1)] group"
        >
          <span className="material-symbols-outlined text-cyan-400 text-xl sm:text-3xl group-hover:drop-shadow-[0_0_5px_#00f2ff]">close</span>
        </button>
        <div className="text-center">
          <h2 className={`text-xl sm:text-3xl font-black uppercase tracking-[0.3em] transition-all ${glitch ? 'translate-x-1 skew-x-12' : 'translate-x-0'}`}>Snake.exe</h2>
          <div className="flex items-center justify-center gap-3 mt-1">
             <div className="h-[2px] w-8 bg-cyan-500/20" />
             <span className="text-xs sm:text-sm font-bold tabular-nums text-pink-500 drop-shadow-[0_0_8px_#ff00ff]">{score.toString().padStart(6, '0')}</span>
             <div className="h-[2px] w-8 bg-cyan-500/20" />
          </div>
        </div>
        <div className="hidden sm:block w-14" />
      </div>

      {/* Adaptive Game Field Container */}
      <div className="relative flex-1 w-full flex flex-col items-center justify-center p-4 min-h-0 overflow-hidden">
        <div 
          className="relative aspect-square w-full max-w-[min(85vw,calc(100vh-320px))] bg-black/90 border-2 border-cyan-500/20 shadow-[0_0_50px_rgba(0,242,255,0.05)] overflow-hidden"
        >
          {/* Chromatic Aberration Layers */}
          <div className={`absolute inset-0 pointer-events-none transition-opacity duration-300 ${glitch ? 'opacity-100' : 'opacity-0'}`}>
             <div className="absolute inset-0 bg-red-500/10 -translate-x-1" />
             <div className="absolute inset-0 bg-blue-500/10 translate-x-1" />
          </div>

          {/* Micro Grid */}
          <div className="absolute inset-0 grid grid-cols-20 grid-rows-20 pointer-events-none opacity-[0.05]">
             {[...Array(400)].map((_, i) => (
                <div key={i} className="border-[0.5px] border-cyan-500" />
             ))}
          </div>

          <div className="relative w-full h-full">
            {/* Pulsing Food */}
            <div 
                className="absolute w-[5%] h-[5%] z-20 flex items-center justify-center"
                style={{ left: `${food.x * 5}%`, top: `${food.y * 5}%` }}
            >
                <div className="w-2 h-2 sm:w-3 sm:h-3 bg-[#ff00ff] shadow-[0_0_20px_#ff00ff] animate-pulse rotate-45" />
                <div className="absolute inset-0 bg-[#ff00ff]/30 blur-[4px] animate-ping" />
            </div>

            {/* Snake Body - Cyber Style */}
            {snake.map((segment, i) => (
                <div 
                    key={i}
                    className="absolute w-[5%] h-[5%] transition-all duration-[110ms] ease-linear z-10 flex items-center justify-center"
                    style={{ left: `${segment.x * 5}%`, top: `${segment.y * 5}%` }}
                >
                    <div 
                        className={`w-[90%] h-[90%] border ${i === 0 ? 'bg-cyan-400 border-white shadow-[0_0_15px_#00f2ff]' : 'bg-cyan-900/40 border-cyan-500/50'}`}
                    >
                       {i === 0 && <div className="w-full h-full bg-white/20 animate-pulse" />}
                    </div>
                    {/* Directional Indicator for head */}
                    {i === 0 && (
                        <div className="absolute w-[30%] h-[30%] bg-white rounded-full blur-[1px]" />
                    )}
                </div>
            ))}
          </div>

          {/* Overlays */}
          {!gameStarted && (
             <div className="absolute inset-0 z-50 flex flex-col items-center justify-center bg-black/95 backdrop-blur-sm">
                <div className="mb-8 p-6 border-l-2 border-cyan-500 bg-cyan-500/5">
                   <p className="text-[10px] sm:text-xs text-cyan-400/60 leading-relaxed max-w-[200px] uppercase">
                     Initialization in progress...<br/>
                     Neural uplink established.<br/>
                     Ready for execution.
                   </p>
                </div>
                <button 
                   onClick={resetGame}
                   className="px-12 py-4 border border-cyan-500/50 text-cyan-400 font-black text-sm uppercase tracking-[0.5em] hover:bg-cyan-500/10 active:scale-95 transition-all shadow-[0_0_30px_rgba(0,242,255,0.1)] relative overflow-hidden group"
                >
                   <div className="absolute inset-0 bg-cyan-500/10 translate-x-[-100%] group-hover:translate-x-0 transition-transform duration-500" />
                   <span className="relative">Boot Sequence</span>
                </button>
             </div>
          )}

          {gameOver && (
             <div className="absolute inset-0 z-50 flex flex-col items-center justify-center bg-[#ff3b30]/10 backdrop-blur-lg">
                <div className="absolute inset-0 opacity-20 bg-[url('https://www.transparenttextures.com/patterns/brushed-alum.png')] animate-pulse" />
                <h3 className="text-4xl sm:text-6xl font-black uppercase italic tracking-tighter text-[#ff0055] drop-shadow-[0_0_20px_#ff0055] mb-4 animate-bounce">System_Failure</h3>
                
                <div className="p-4 border border-white/20 bg-black/60 mb-10 flex flex-col items-center">
                   <span className="text-[10px] uppercase opacity-40 mb-1">Recovery Data</span>
                   <span className="text-3xl font-bold text-white tabular-nums drop-shadow-[0_0_10px_rgba(255,255,255,0.5)]">{score} BITS</span>
                </div>

                <button 
                   onClick={resetGame}
                   className="px-14 py-5 bg-white text-black font-black text-xs uppercase tracking-[0.4em] shadow-[0_20px_50px_rgba(0,0,0,0.5)] active:scale-95 transition-all h-[60px]"
                >
                   Reboot Controller
                </button>
             </div>
          )}
        </div>

        {/* HUD Controls - Responsive DPAD */}
        <div className="mt-8 sm:mt-12 grid grid-cols-3 gap-2 sm:gap-6 shrink-0">
           <div />
           <ControlBtn icon="north" onClick={() => lastDirRef.current.y === 0 && setDirection({ x: 0, y: -1 })} />
           <div />
           <ControlBtn icon="west" onClick={() => lastDirRef.current.x === 0 && setDirection({ x: -1, y: 0 })} />
           <ControlBtn icon="circle" onClick={() => {}} className="pointer-events-none opacity-20" />
           <ControlBtn icon="east" onClick={() => lastDirRef.current.x === 0 && setDirection({ x: 1, y: 0 })} />
           <div />
           <ControlBtn icon="south" onClick={() => lastDirRef.current.y === 0 && setDirection({ x: 0, y: 1 })} />
           <div />
        </div>
      </div>

      <style>{`
        @keyframes scanline {
          0% { top: -5%; }
          100% { top: 105%; }
        }
        .animate-scanline { animation: scanline 4s linear infinite; }
      `}</style>
    </div>
  );
};

const ControlBtn = ({ icon, onClick, className = '' }: { icon: string; onClick: () => void; className?: string }) => (
    <button 
        onClick={onClick}
        className={`w-14 h-14 sm:w-20 sm:h-20 bg-black/40 border border-cyan-500/20 flex items-center justify-center active:scale-90 active:bg-cyan-500/20 transition-all shadow-[0_0_20px_rgba(0,242,255,0.05)] ${className}`}
    >
        <span className="material-symbols-outlined text-cyan-400 text-3xl sm:text-5xl opacity-40 group-active:opacity-100">{icon}</span>
    </button>
);
