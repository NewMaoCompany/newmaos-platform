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
  const [isHighScoreAnim, setIsHighScoreAnim] = useState(false);
  const gameLoopRef = useRef<NodeJS.Timeout | null>(null);
  const lastDirRef = useRef(INITIAL_DIRECTION);

  const generateFood = useCallback((currentSnake: { x: number; y: number }[]) => {
    let newFood;
    while (true) {
      newFood = {
        x: Math.floor(Math.random() * GRID_SIZE),
        y: Math.floor(Math.random() * GRID_SIZE),
      };
      if (!currentSnake.some(segment => segment.x === newFood!.x && segment.y === newFood!.y)) {
        break;
      }
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

      // Check collision with self
      if (prevSnake.some(segment => segment.x === newHead.x && segment.y === newHead.y)) {
        setGameOver(true);
        if (score > 100) awardPoints(Math.floor(score / 10), 'Played Snake: Radiant Path');
        return prevSnake;
      }

      const newSnake = [newHead, ...prevSnake];

      // Check food
      if (newHead.x === food.x && newHead.y === food.y) {
        setScore(s => s + 50);
        setFood(generateFood(newSnake));
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
    <div className="fixed inset-0 z-[110] flex flex-col items-center bg-[#0a0a12] text-[#00f2ff] font-mono overflow-hidden">
      {/* Cyberpunk Background & Scanlines */}
      <div className="absolute inset-0 pointer-events-none overflow-hidden">
        <div className="absolute inset-0 bg-[linear-gradient(rgba(18,16,16,0)_50%,rgba(0,0,0,0.25)_50%),linear-gradient(90deg,rgba(255,0,0,0.06),rgba(0,255,0,0.02),rgba(0,0,255,0.06))] z-10 bg-[length:100%_2px,3px_100%]" />
        <div className="absolute inset-0 bg-[radial-gradient(circle_at_center,_#222_0%,_#0a0a12_100%)]" />
        <div className="absolute top-0 w-full h-[2px] bg-[#00f2ff] opacity-20 shadow-[0_0_15px_#00f2ff] animate-scanline" />
      </div>

      {/* Header HUD */}
      <div className="w-full flex items-center justify-between px-8 py-6 z-50">
        <button 
            onClick={() => navigate('/games')} 
            className="w-12 h-12 rounded-lg bg-[#00f2ff]/10 border border-[#00f2ff]/30 flex items-center justify-center hover:bg-[#00f2ff]/20 active:scale-90 transition-all shadow-[0_0_10px_rgba(0,242,255,0.2)]"
        >
          <span className="material-symbols-outlined text-[#00f2ff] text-2xl">arrow_back</span>
        </button>
        <div className="text-center">
          <h2 className="text-2xl font-black uppercase tracking-[0.2em] text-[#00f2ff] drop-shadow-[0_0_8px_#00f2ff]">Snake.sys</h2>
          <div className="flex items-center justify-center gap-2 mt-1">
             <span className="text-[10px] font-bold uppercase opacity-60">Memory_Gained:</span>
             <span className="text-lg font-bold tabular-nums text-[#ff00ff] drop-shadow-[0_0_5px_#ff00ff]">{score}</span>
          </div>
        </div>
        <div className="w-12 h-12 flex items-center justify-center">
            <div className="w-2 h-2 bg-[#ff00ff] rounded-full animate-ping" />
        </div>
      </div>

      {/* Game Board Container */}
      <div className="relative flex-1 w-full flex flex-col items-center justify-center px-6">
        <div 
          className="relative aspect-square w-full max-w-[500px] bg-black/80 rounded-sm border-2 border-[#00f2ff]/40 shadow-[0_0_30px_rgba(0,242,255,0.1)] overflow-hidden"
          style={{ padding: '0px' }}
        >
          {/* Cyber Grid */}
          <div className="absolute inset-0 grid grid-cols-20 grid-rows-20 pointer-events-none">
             {[...Array(400)].map((_, i) => (
                <div key={i} className="border-[0.5px] border-[#00f2ff]/5" />
             ))}
          </div>

          <div className="relative w-full h-full">
            {/* Digital Bit (Food) */}
            <div 
                className="absolute w-[5%] h-[5%] transition-all duration-300 z-20 flex items-center justify-center"
                style={{ 
                    left: `${food.x * 5}%`, 
                    top: `${food.y * 5}%`,
                }}
            >
                <div className="w-3 h-3 bg-[#ff00ff] shadow-[0_0_15px_#ff00ff] animate-pulse" />
                <div className="absolute inset-0 bg-[#ff00ff]/20 blur-[5px]" />
            </div>

            {/* Snake Segments (Digital Blocks) */}
            {snake.map((segment, i) => (
                <div 
                    key={i}
                    className="absolute w-[5%] h-[5%] transition-all duration-[120ms] ease-linear z-10 flex items-center justify-center"
                    style={{ 
                        left: `${segment.x * 5}%`, 
                        top: `${segment.y * 5}%`,
                    }}
                >
                    <div 
                        className={`w-[90%] h-[90%] border-2 ${i === 0 ? 'bg-white border-[#00f2ff]' : 'bg-transparent border-[#00f2ff]/60'} shadow-[0_0_10px_rgba(0,242,255,0.3)]`}
                        style={{ 
                            boxShadow: i === 0 ? '0 0 15px #00f2ff' : 'none'
                        }} 
                    />
                </div>
            ))}
          </div>

          {/* Overlays */}
          {!gameStarted && (
             <div className="absolute inset-0 z-50 flex flex-col items-center justify-center bg-black/90">
                <div className="mb-8 font-bold text-[#00f2ff] animate-pulse whitespace-nowrap overflow-hidden border-r-2 border-[#00f2ff] pr-1">
                   [SYSTEM_READY: PRESS START]
                </div>
                <button 
                   onClick={resetGame}
                   className="px-12 py-4 border-2 border-[#00f2ff] text-[#00f2ff] bg-transparent font-bold text-sm uppercase tracking-[0.4em] hover:bg-[#00f2ff]/10 active:scale-95 transition-all shadow-[0_0_20px_rgba(0,242,255,0.2)]"
                >
                   EXECUTE_INIT
                </button>
             </div>
          )}

          {gameOver && (
             <div className="absolute inset-0 z-50 flex flex-col items-center justify-center bg-[#ff0055]/10 backdrop-blur-md border-[20px] border-[#ff0055]/20">
                <h3 className="text-5xl font-black uppercase italic tracking-tighter text-[#ff0055] drop-shadow-[0_0_15px_#ff0055] mb-2">SYSTEM_CRASH</h3>
                <p className="font-mono text-[10px] text-[#ff0055] animate-pulse mb-8">ERROR_CODE: COLLISION_DETECTED</p>
                
                <div className="text-xl font-bold mb-10 text-white/80 border-l-4 border-[#ff0055] pl-4">
                   DATA_RECOVERED: <span className="text-[#00f2ff]">{score} Bits</span>
                </div>

                <button 
                   onClick={resetGame}
                   className="px-12 py-4 border-2 border-white text-white bg-transparent font-bold text-sm uppercase tracking-[0.4em] hover:bg-white/10 active:scale-95 transition-all shadow-[0_0_20px_rgba(255,255,255,0.2)]"
                >
                   REBOOT_SYSTEM
                </button>
             </div>
          )}
        </div>

        {/* Controls HUD */}
        <div className="mt-12 grid grid-cols-3 gap-6">
           <div />
           <ControlBtn icon="expand_less" onClick={() => lastDirRef.current.y === 0 && setDirection({ x: 0, y: -1 })} />
           <div />
           <ControlBtn icon="chevron_left" onClick={() => lastDirRef.current.x === 0 && setDirection({ x: -1, y: 0 })} />
           <ControlBtn icon="expand_more" onClick={() => lastDirRef.current.y === 0 && setDirection({ x: 0, y: 1 })} />
           <ControlBtn icon="chevron_right" onClick={() => lastDirRef.current.x === 0 && setDirection({ x: 1, y: 0 })} />
        </div>
      </div>

      <style>{`
        @keyframes scanline {
          0% { top: -10%; }
          100% { top: 110%; }
        }
        .animate-scanline { animation: scanline 8s linear infinite; }
      `}</style>
    </div>
  );
};

const ControlBtn = ({ icon, onClick }: { icon: string; onClick: () => void }) => (
    <button 
        onClick={onClick}
        className="w-16 h-16 bg-[#00f2ff]/5 border border-[#00f2ff]/30 flex items-center justify-center active:scale-90 active:bg-[#00f2ff]/20 transition-all shadow-[0_0_15px_rgba(0,242,255,0.1)]"
    >
        <span className="material-symbols-outlined text-[#00f2ff] text-4xl">{icon}</span>
    </button>
);
