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
    <div className="fixed inset-0 z-[110] flex flex-col items-center bg-[#050510] text-white font-sans overflow-hidden">
      {/* Background Decor */}
      <div className="absolute inset-0 opacity-10 bg-[radial-gradient(circle_at_center,_#ffffff10_0%,_transparent_100%)]" />
      <div className="absolute top-0 w-full h-1 bg-gradient-to-r from-transparent via-green-500 to-transparent opacity-30" />

      {/* Header */}
      <div className="w-full flex items-center justify-between px-8 py-6 z-50">
        <button 
            onClick={() => navigate('/lobby')} 
            className="w-12 h-12 rounded-2xl bg-white/5 backdrop-blur-xl border border-white/10 flex items-center justify-center hover:bg-white/10 active:scale-90 transition-all"
        >
          <span className="material-symbols-outlined text-white text-2xl">arrow_back</span>
        </button>
        <div className="text-center">
          <h2 className="text-2xl font-black italic uppercase tracking-tighter text-transparent bg-clip-text bg-gradient-to-r from-green-400 to-blue-500">Radiant Path</h2>
          <div className="flex items-center justify-center gap-2 opacity-50">
             <span className="text-[10px] font-black uppercase tracking-[0.3em]">Score</span>
             <span className="text-lg font-black tabular-nums text-white">{score}</span>
          </div>
        </div>
        <div className="w-12" />
      </div>

      {/* Game Board Container */}
      <div className="relative flex-1 w-full flex flex-col items-center justify-center px-6">
        <div 
          className="relative aspect-square w-full max-w-[500px] bg-white/[0.03] backdrop-blur-md rounded-[40px] border border-white/10 shadow-[0_0_100px_rgba(0,0,0,0.5)] overflow-hidden"
          style={{ padding: '10px' }}
        >
          {/* Grid Lines */}
          <div className="absolute inset-0 grid grid-cols-20 grid-rows-20 opacity-5 pointer-events-none">
             {[...Array(400)].map((_, i) => (
                <div key={i} className="border-[0.5px] border-white/30" />
             ))}
          </div>

          <div className="relative w-full h-full">
            {/* Food */}
            <div 
                className="absolute w-[5%] h-[5%] transition-all duration-300 z-20"
                style={{ 
                    left: `${food.x * 5}%`, 
                    top: `${food.y * 5}%`,
                }}
            >
                <div className="w-full h-full bg-white rounded-full shadow-[0_0_20px_#fff] animate-pulse scale-90" />
                <div className="absolute inset-0 bg-blue-500 rounded-full blur-[10px] opacity-60" />
            </div>

            {/* Snake Body */}
            {snake.map((segment, i) => {
                const color = `hsl(${(i * 10 + score) % 360}, 80%, 60%)`;
                return (
                    <div 
                        key={i}
                        className="absolute w-[5%] h-[5%] transition-all duration-[120ms] ease-linear z-10"
                        style={{ 
                            left: `${segment.x * 5}%`, 
                            top: `${segment.y * 5}%`,
                            opacity: 1 - (i / (snake.length + 5))
                        }}
                    >
                        <div 
                            className={`w-full h-full rounded-full shadow-lg ${i === 0 ? 'scale-110' : 'scale-90'}`}
                            style={{ 
                                background: i === 0 ? 'white' : color,
                                boxShadow: `0 0 15px ${i === 0 ? '#fff' : color}` 
                            }} 
                        />
                        {i === 0 && (
                            <div className="absolute -inset-1 bg-white/20 rounded-full blur-[6px] animate-pulse" />
                        )}
                    </div>
                );
            })}
          </div>

          {/* Start/Game Over Overlays */}
          {!gameStarted && (
             <div className="absolute inset-0 z-50 flex flex-col items-center justify-center bg-black/40 backdrop-blur-sm">
                <div className="w-24 h-24 rounded-full bg-green-500/20 flex items-center justify-center mb-6 animate-pulse border border-green-500/30">
                   <span className="material-symbols-outlined text-green-400 text-5xl">play_arrow</span>
                </div>
                <button 
                   onClick={resetGame}
                   className="px-10 py-4 bg-white text-black rounded-full font-black text-sm uppercase tracking-[0.3em] shadow-2xl active:scale-95 transition-all"
                >
                   Start Trail
                </button>
             </div>
          )}

          {gameOver && (
             <div className="absolute inset-0 z-50 flex flex-col items-center justify-center bg-red-500/10 backdrop-blur-md">
                <span className="text-[12px] font-black text-red-500 uppercase tracking-[0.6em] mb-2">Trail Terminated</span>
                <h3 className="text-6xl font-black italic uppercase tracking-tighter mb-8">Game Over</h3>
                <div className="text-3xl font-black mb-10 flex items-center gap-4">
                   <span className="opacity-40">Final Score:</span>
                   <span className="text-green-400 tabular-nums">{score}</span>
                </div>
                <button 
                   onClick={resetGame}
                   className="px-12 py-5 bg-white text-black rounded-full font-black text-sm uppercase tracking-[0.3em] shadow-xl active:scale-95 transition-all"
                >
                   Retry Path
                </button>
             </div>
          )}
        </div>

        {/* Controls - Mobile Friendly DPAD */}
        <div className="mt-12 grid grid-cols-3 gap-4">
           <div />
           <ControlBtn icon="arrow_upward" onClick={() => lastDirRef.current.y === 0 && setDirection({ x: 0, y: -1 })} />
           <div />
           <ControlBtn icon="arrow_back" onClick={() => lastDirRef.current.x === 0 && setDirection({ x: -1, y: 0 })} />
           <ControlBtn icon="arrow_downward" onClick={() => lastDirRef.current.y === 0 && setDirection({ x: 0, y: 1 })} />
           <ControlBtn icon="arrow_forward" onClick={() => lastDirRef.current.x === 0 && setDirection({ x: 1, y: 0 })} />
        </div>
      </div>
    </div>
  );
};

const ControlBtn = ({ icon, onClick }: { icon: string; onClick: () => void }) => (
    <button 
        onClick={onClick}
        className="w-16 h-16 rounded-3xl bg-white/5 border border-white/10 flex items-center justify-center active:scale-90 active:bg-white/20 transition-all backdrop-blur-md"
    >
        <span className="material-symbols-outlined text-white/40 text-3xl group-active:text-white transition-colors">{icon}</span>
    </button>
);
