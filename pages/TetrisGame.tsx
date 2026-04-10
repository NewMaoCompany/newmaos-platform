import React, { useState, useEffect, useCallback, useRef } from 'react';
import { useNavigate } from 'react-router-dom';
import { useApp } from '../AppContext';

const COLS = 10;
const ROWS = 20;

const TETROMINOS = {
  I: { shape: [[1, 1, 1, 1]], color: '#00f2ff', glow: 'rgba(0, 242, 255, 0.6)' },
  J: { shape: [[1, 0, 0], [1, 1, 1]], color: '#007AFF', glow: 'rgba(0, 122, 255, 0.6)' },
  L: { shape: [[0, 0, 1], [1, 1, 1]], color: '#FF9500', glow: 'rgba(255, 149, 0, 0.6)' },
  O: { shape: [[1, 1], [1, 1]], color: '#FFD60A', glow: 'rgba(255, 214, 10, 0.6)' },
  S: { shape: [[0, 1, 1], [1, 1, 0]], color: '#34C759', glow: 'rgba(52, 199, 89, 0.6)' },
  T: { shape: [[0, 1, 0], [1, 1, 1]], color: '#AF52DE', glow: 'rgba(175, 82, 222, 0.6)' },
  Z: { shape: [[1, 1, 0], [0, 1, 1]], color: '#FF3B30', glow: 'rgba(255, 59, 48, 0.6)' },
};

export const TetrisGame = () => {
  const navigate = useNavigate();
  const { awardPoints } = useApp();
  const [grid, setGrid] = useState<string[][]>(Array(ROWS).fill(null).map(() => Array(COLS).fill('')));
  const [activePiece, setActivePiece] = useState<any>(null);
  const [pos, setPos] = useState({ x: 3, y: 0 });
  const [score, setScore] = useState(0);
  const [gameOver, setGameOver] = useState(false);
  const [gameStarted, setGameStarted] = useState(false);
  const [pulse, setPulse] = useState(false);
  const gameLoopRef = useRef<NodeJS.Timeout | null>(null);

  const spawnPiece = useCallback(() => {
    const types = Object.keys(TETROMINOS);
    const type = types[Math.floor(Math.random() * types.length)] as keyof typeof TETROMINOS;
    const piece = TETROMINOS[type];
    const newPos = { x: Math.floor((COLS - piece.shape[0].length) / 2), y: 0 };
    if (checkCollision(newPos, piece.shape, grid)) {
        setGameOver(true);
        if (score > 500) awardPoints(Math.floor(score / 50), 'Played Tetris: Orbital HUD');
    } else {
        setActivePiece(piece);
        setPos(newPos);
    }
  }, [grid, score, awardPoints]);

  const checkCollision = (p: { x: number; y: number }, shape: number[][], currentGrid: string[][]) => {
    for (let r = 0; r < shape.length; r++) {
      for (let c = 0; c < shape[r].length; c++) {
        if (shape[r][c]) {
          const newX = p.x + c;
          const newY = p.y + r;
          if (newX < 0 || newX >= COLS || newY >= ROWS || (newY >= 0 && currentGrid[newY][newX])) return true;
        }
      }
    }
    return false;
  };

  const handleRotate = () => {
    if (!activePiece || gameOver) return;
    const newShape = activePiece.shape[0].map((_: any, i: any) => activePiece.shape.map((row: any) => row[i]).reverse());
    if (!checkCollision(pos, newShape, grid)) setActivePiece({ ...activePiece, shape: newShape });
  };

  const moveDown = useCallback(() => {
    if (!activePiece || gameOver) return;
    const newPos = { ...pos, y: pos.y + 1 };
    if (checkCollision(newPos, activePiece.shape, grid)) {
        const newGrid = grid.map(row => [...row]);
        activePiece.shape.forEach((row: any, r: any) => row.forEach((val: any, c: any) => {
            if (val) {
              const ny = pos.y + r;
              const nx = pos.x + c;
              if (ny >= 0) newGrid[ny][nx] = activePiece.color;
            }
        }));
        let cleared = 0;
        const filtered = newGrid.filter(row => {
            const isFull = row.every(cell => cell !== '');
            if (isFull) cleared++;
            return !isFull;
        });
        while (filtered.length < ROWS) filtered.unshift(Array(COLS).fill(''));
        setGrid(filtered);
        if (cleared > 0) {
            setScore(s => s + [0, 100, 300, 700, 1500][cleared]);
            setPulse(true);
            setTimeout(() => setPulse(false), 300);
        }
        spawnPiece();
    } else {
        setPos(newPos);
    }
  }, [activePiece, gameOver, pos, grid, spawnPiece]);

  useEffect(() => {
    if (gameStarted && !gameOver) {
        gameLoopRef.current = setInterval(moveDown, Math.max(120, 850 - Math.floor(score / 1500) * 80));
    } else {
        if (gameLoopRef.current) clearInterval(gameLoopRef.current);
    }
    return () => { if (gameLoopRef.current) clearInterval(gameLoopRef.current); };
  }, [gameStarted, gameOver, moveDown, score]);

  useEffect(() => {
    const handleKey = (e: KeyboardEvent) => {
        if (e.key === 'ArrowLeft') {
            const np = { ...pos, x: pos.x - 1 };
            if (!checkCollision(np, activePiece?.shape, grid)) setPos(np);
        }
        if (e.key === 'ArrowRight') {
            const np = { ...pos, x: pos.x + 1 };
            if (!checkCollision(np, activePiece?.shape, grid)) setPos(np);
        }
        if (e.key === 'ArrowDown') moveDown();
        if (e.key === 'ArrowUp') handleRotate();
    };
    window.addEventListener('keydown', handleKey);
    return () => window.removeEventListener('keydown', handleKey);
  }, [pos, activePiece, grid, moveDown]);

  const startGame = () => {
      setGrid(Array(ROWS).fill(null).map(() => Array(COLS).fill('')));
      setScore(0);
      setGameOver(false);
      setGameStarted(true);
      spawnPiece();
  };

  return (
    <div className={`fixed inset-0 z-[110] flex flex-col items-center bg-[#020205] text-[#00f2ff] font-mono overflow-hidden select-none transition-all duration-300 ${pulse ? 'brightness-125 saturate-150 scale-[1.005]' : ''}`}>
      
      {/* Deep Space Background */}
      <div className="absolute inset-0 pointer-events-none">
        <div className="absolute inset-0 bg-[#020205] bg-[url('https://www.transparenttextures.com/patterns/stardust.png')] opacity-20 animate-parallax-slow" />
        <div className="absolute top-[25%] left-[15%] w-96 h-96 bg-blue-900/10 rounded-full blur-[120px] animate-pulse" />
        <div className="absolute bottom-[20%] right-[10%] w-80 h-80 bg-purple-900/10 rounded-full blur-[100px]" />
        
        {/* Rotating HUD Geometry */}
        <div className="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 w-[600px] h-[600px] border border-cyan-500/5 rounded-full animate-rotate-slow pointer-events-none flex items-center justify-center">
           <div className="w-[80%] h-[80%] border border-cyan-500/10 rounded-full animate-rotate-reverse-slow" />
           <div className="absolute inset-0 bg-[radial-gradient(circle_at_center,_#00f2ff05_0%,_transparent_70%)]" />
        </div>
      </div>

      {/* Sci-Fi HUD Header - Adaptive */}
      <div className="w-full flex items-center justify-between px-6 sm:px-12 py-6 sm:py-10 z-50 shrink-0">
        <button 
            onClick={() => navigate('/games')} 
            className="group flex flex-col items-center gap-1 opacity-50 hover:opacity-100 transition-opacity"
        >
          <div className="w-10 h-10 sm:w-14 sm:h-14 border border-cyan-500/40 bg-cyan-900/20 backdrop-blur-md flex items-center justify-center group-hover:bg-cyan-500/30">
            <span className="material-symbols-outlined text-cyan-400 text-2xl">power_settings_new</span>
          </div>
          <span className="text-[8px] font-black tracking-widest uppercase">System.Exit</span>
        </button>
        
        <div className="text-center px-4">
          <div className="flex items-center gap-3 justify-center mb-1">
             <div className="h-[1px] w-4 sm:w-10 bg-cyan-400/30" />
             <h2 className="text-lg sm:text-3xl font-black uppercase tracking-[0.3em] drop-shadow-[0_0_15px_rgba(0,242,255,0.6)]">Orbital.Stack</h2>
             <div className="h-[1px] w-4 sm:w-10 bg-cyan-400/30" />
          </div>
          <p className="text-[9px] font-bold opacity-40 uppercase tracking-[0.5em]">Command Center v0.42</p>
        </div>
        
        <div className="flex flex-col items-end gap-1 px-3 sm:px-6 py-2 border border-cyan-500/20 bg-cyan-500/10 backdrop-blur-sm min-w-[120px]">
           <span className="text-[9px] font-black uppercase tracking-widest opacity-40">Cargo_Mass</span>
           <span className="text-xl sm:text-3xl font-black tabular-nums transition-all duration-300">{score.toLocaleString()}</span>
        </div>
      </div>

      {/* Main Containment (Game Board) - ADAPTIVE SIZING */}
      <div className="relative flex-1 w-full flex flex-col items-center justify-center p-4 min-h-0">
        <div 
          className="relative aspect-[1/2] h-[min(100%,70vh)] max-w-[min(90vw,35vh)] bg-black/80 border-2 border-cyan-500/30 shadow-[0_0_100px_rgba(0,0,0,0.5),0_0_20px_rgba(0,242,255,0.1)] overflow-hidden rounded-md"
        >
          {/* Subtle Scanning Lines */}
          <div className="absolute inset-0 bg-[linear-gradient(rgba(18,16,16,0)_50%,rgba(0,0,0,0.1)_50%)] bg-[length:100%_4px] opacity-20 pointer-events-none" />
          
          {/* Containment Grid Overlay */}
          <div className="grid grid-cols-10 grid-rows-20 w-full h-full gap-[1px] opacity-[0.05]">
             {[...Array(200)].map((_, i) => (
                <div key={i} className="border-[0.5px] border-cyan-500" />
             ))}
          </div>

          {/* Settled Blocks Grid */}
          <div className="absolute inset-0 pointer-events-none">
             {grid.map((row, r) => row.map((color, c) => (
                color ? (
                    <div 
                        key={`${r}-${c}`}
                        className="absolute w-[10%] h-[5%] p-[1px] transition-all duration-300"
                        style={{ left: `${c * 10}%`, top: `${r * 5}%` }}
                    >
                        <div 
                            className="w-full h-full border border-white/20 relative animate-block-settle"
                            style={{ 
                                background: `linear-gradient(135deg, ${color}dd, ${color}99)`,
                                boxShadow: `inset 2px 2px 5px rgba(255,255,255,0.2), 0 0 10px ${color}44` 
                            }}
                        />
                    </div>
                ) : null
             )))}
          </div>

          {/* Active Unit (Ghost & Piece) */}
          {activePiece && !gameOver && (
              <div className="absolute inset-0 pointer-events-none z-10">
                  {activePiece.shape.map((row: any, r: any) => row.map((val: any, c: any) => {
                      if (!val) return null;
                      const x = pos.x + c;
                      const y = pos.y + r;
                      if (y < 0) return null;
                      return (
                        <div 
                            key={`${r}-${c}`}
                            className="absolute w-[10%] h-[5%] p-[1px] transition-all duration-[100ms] ease-linear"
                            style={{ left: `${x * 10}%`, top: `${y * 5}%` }}
                        >
                            <div className="w-full h-full border-2 border-white/40 shadow-[0_0_25px_rgba(255,255,255,0.2)] animate-pulse" style={{ background: activePiece.color }}>
                                <div className="absolute inset-0 bg-gradient-to-tr from-black/40 to-transparent" />
                                <div className="absolute top-1 left-1 w-[20%] h-[20%] bg-white rounded-full blur-[2px]" />
                            </div>
                        </div>
                      );
                  }))}
              </div>
          )}

          {/* Game Over / Start Interfaces */}
          {!gameStarted && (
              <div className="absolute inset-0 z-50 flex flex-col items-center justify-center bg-black/95">
                 <div className="mb-10 w-20 h-20 border-2 border-cyan-500 animate-spin flex items-center justify-center" style={{ animationDuration: '3s' }}>
                    <div className="w-12 h-12 border-2 border-cyan-300 animate-spin" style={{ animationDuration: '1s', animationDirection: 'reverse' }} />
                 </div>
                 <button 
                   onClick={startGame}
                   className="px-12 py-4 border border-cyan-500/50 text-cyan-400 font-black text-sm uppercase tracking-[0.5em] hover:bg-cyan-400/20 active:scale-95 transition-all shadow-[0_0_30px_rgba(0,242,255,0.2)]"
                >
                   Initiate Stack
                </button>
              </div>
          )}

          {gameOver && (
              <div className="absolute inset-0 z-50 flex flex-col items-center justify-center bg-[#ff3b30]/10 backdrop-blur-xl border-[1px] border-[#ff3b30]/40 p-8 text-center">
                <span className="text-[10px] font-black text-[#ff3b30] uppercase tracking-[0.8em] mb-4 animate-pulse">Critical_Atmosphere_Lost</span>
                <h3 className="text-4xl sm:text-6xl font-black uppercase text-white drop-shadow-[0_0_20px_#ff3b30] mb-12 italic">Total Breach</h3>
                
                <div className="px-6 py-4 border border-cyan-500/30 bg-black/80 mb-12">
                   <div className="text-[8px] font-black uppercase tracking-widest opacity-40 mb-1">Recovered_Data</div>
                   <div className="text-2xl font-black text-white">{score} UNITS</div>
                </div>

                <button 
                   onClick={startGame}
                   className="px-14 py-5 bg-white text-black font-black text-xs uppercase tracking-[0.4em] shadow-[0_20px_50px_rgba(0,0,0,0.5)] active:scale-95 transition-all w-full"
                >
                   Stabilize Hull
                </button>
              </div>
          )}
        </div>
      </div>

      {/* Control Surface - HUD Interface */}
      <div className="w-full flex justify-center items-center gap-10 py-10 px-10 z-50 bg-black/60 backdrop-blur-md border-t border-cyan-500/20 shrink-0">
         <div className="grid grid-cols-2 gap-4 sm:gap-6">
            <NavBtn icon="chevron_left" onClick={() => {
                const np = { ...pos, x: pos.x - 1 };
                if (!checkCollision(np, activePiece?.shape, grid)) setPos(np);
            }} />
            <NavBtn icon="chevron_right" onClick={() => {
                const np = { ...pos, x: pos.x + 1 };
                if (!checkCollision(np, activePiece?.shape, grid)) setPos(np);
            }} />
         </div>
         <div className="grid grid-cols-2 gap-4 sm:gap-6">
            <NavBtn icon="keyboard_double_arrow_down" onClick={moveDown} />
            <NavBtn icon="sync" onClick={handleRotate} />
         </div>
      </div>

      <style>{`
        @keyframes parallax-slow {
            from { background-position: 0 0; }
            to { background-position: 1000px 1000px; }
        }
        @keyframes rotate-slow {
            from { transform: rotate(0deg); }
            to { transform: rotate(360deg); }
        }
        @keyframes rotate-reverse-slow {
            from { transform: rotate(360deg); }
            to { transform: rotate(0deg); }
        }
        @keyframes block-settle {
            0% { transform: scale(1.1); filter: brightness(2); }
            100% { transform: scale(1); filter: brightness(1); }
        }
        .animate-parallax-slow { animation: parallax-slow 120s linear infinite; }
        .animate-rotate-slow { animation: rotate-slow 20s linear infinite; }
        .animate-rotate-reverse-slow { animation: rotate-reverse-slow 15s linear infinite; }
        .animate-block-settle { animation: block-settle 0.3s cubic-bezier(0.18, 0.89, 0.32, 1.28); }
      `}</style>
    </div>
  );
};

const NavBtn = ({ icon, onClick }: { icon: string; onClick: () => void }) => (
    <button 
        onClick={onClick}
        className="w-14 h-14 sm:w-20 sm:h-20 border border-cyan-500/30 bg-cyan-950/20 flex items-center justify-center active:scale-90 active:bg-cyan-500/30 transition-all shadow-[inset_0_0_15px_rgba(0,0,0,0.5)] group"
    >
        <span className="material-symbols-outlined text-cyan-400 text-3xl sm:text-5xl opacity-40 group-active:opacity-100">{icon}</span>
    </button>
);
