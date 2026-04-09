import React, { useState, useEffect, useCallback, useRef } from 'react';
import { useNavigate } from 'react-router-dom';
import { useApp } from '../AppContext';

const COLS = 10;
const ROWS = 20;

const TETROMINOS = {
  I: { shape: [[1, 1, 1, 1]], color: '#64D2FF' },
  J: { shape: [[1, 0, 0], [1, 1, 1]], color: '#007AFF' },
  L: { shape: [[0, 0, 1], [1, 1, 1]], color: '#FF9500' },
  O: { shape: [[1, 1], [1, 1]], color: '#FFCC00' },
  S: { shape: [[0, 1, 1], [1, 1, 0]], color: '#34C759' },
  T: { shape: [[0, 1, 0], [1, 1, 1]], color: '#AF52DE' },
  Z: { shape: [[1, 1, 0], [0, 1, 1]], color: '#FF3B30' },
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
  const gameLoopRef = useRef<NodeJS.Timeout | null>(null);

  const spawnPiece = useCallback(() => {
    const types = Object.keys(TETROMINOS);
    const type = types[Math.floor(Math.random() * types.length)] as keyof typeof TETROMINOS;
    const piece = TETROMINOS[type];
    const newPos = { x: Math.floor((COLS - piece.shape[0].length) / 2), y: 0 };
    
    if (checkCollision(newPos, piece.shape, grid)) {
        setGameOver(true);
        if (score > 500) awardPoints(Math.floor(score / 50), 'Played Tetris: Aurora Grid');
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

  const rotate = (shape: number[][]) => {
    const newShape = shape[0].map((_, i) => shape.map(row => row[i]).reverse());
    return newShape;
  };

  const handleRotate = () => {
    if (!activePiece || gameOver) return;
    const newShape = rotate(activePiece.shape);
    if (!checkCollision(pos, newShape, grid)) {
        setActivePiece({ ...activePiece, shape: newShape });
    }
  };

  const placePiece = useCallback(() => {
    const newGrid = grid.map(row => [...row]);
    activePiece.shape.forEach((row: number[], r: number) => {
      row.forEach((val, c) => {
        if (val) {
          const newY = pos.y + r;
          const newX = pos.x + c;
          if (newY >= 0) newGrid[newY][newX] = activePiece.color;
        }
      });
    });

    // Line clearing
    let linesCleared = 0;
    const filteredGrid = newGrid.filter(row => {
        const full = row.every(cell => cell !== '');
        if (full) linesCleared++;
        return !full;
    });
    while (filteredGrid.length < ROWS) {
        filteredGrid.unshift(Array(COLS).fill(''));
    }

    setGrid(filteredGrid);
    setScore(s => s + [0, 100, 300, 500, 800][linesCleared]);
    spawnPiece();
  }, [activePiece, grid, pos, spawnPiece]);

  const moveDown = useCallback(() => {
    if (!activePiece || gameOver) return;
    const newPos = { ...pos, y: pos.y + 1 };
    if (checkCollision(newPos, activePiece.shape, grid)) {
        placePiece();
    } else {
        setPos(newPos);
    }
  }, [activePiece, gameOver, pos, grid, placePiece]);

  useEffect(() => {
    if (gameStarted && !gameOver) {
        gameLoopRef.current = setInterval(moveDown, Math.max(100, 800 - Math.floor(score / 1000) * 100));
    } else {
        if (gameLoopRef.current) clearInterval(gameLoopRef.current);
    }
    return () => { if (gameLoopRef.current) clearInterval(gameLoopRef.current); };
  }, [gameStarted, gameOver, moveDown, score]);

  useEffect(() => {
    const handleKey = (e: KeyboardEvent) => {
        if (e.key === 'ArrowLeft') {
            const newPos = { ...pos, x: pos.x - 1 };
            if (!checkCollision(newPos, activePiece?.shape, grid)) setPos(newPos);
        }
        if (e.key === 'ArrowRight') {
            const newPos = { ...pos, x: pos.x + 1 };
            if (!checkCollision(newPos, activePiece?.shape, grid)) setPos(newPos);
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
    <div className="fixed inset-0 z-[110] flex flex-col items-center bg-[#05050a] text-[#00f2ff] font-mono overflow-hidden">
      {/* Deep Space Parallax Background */}
      <div className="absolute inset-0 pointer-events-none overflow-hidden">
        <div className="absolute inset-0 bg-[url('https://www.transparenttextures.com/patterns/stardust.png')] opacity-40 animate-parallax" />
        <div className="absolute top-[20%] left-[10%] w-[150px] h-[150px] bg-purple-500/20 rounded-full blur-[100px] animate-pulse" />
        <div className="absolute bottom-[30%] right-[5%] w-[200px] h-[200px] bg-blue-500/10 rounded-full blur-[120px]" />
      </div>

      {/* Sci-Fi HUD Header */}
      <div className="w-full flex items-center justify-between px-10 py-10 z-50">
        <button 
            onClick={() => navigate('/games')} 
            className="group flex flex-col items-center gap-1 opacity-60 hover:opacity-100 transition-opacity"
        >
          <div className="w-12 h-12 border border-[#00f2ff]/30 flex items-center justify-center bg-[#00f2ff]/5">
            <span className="material-symbols-outlined text-xl">close</span>
          </div>
          <span className="text-[9px] font-bold uppercase tracking-[0.2em]">Abort</span>
        </button>
        <div className="text-center">
          <div className="flex items-center gap-4 justify-center mb-1">
             <div className="w-8 h-[1px] bg-[#00f2ff]/40" />
             <h2 className="text-2xl font-black uppercase tracking-[0.3em] text-[#00f2ff] drop-shadow-[0_0_10px_#00f2ff]">Orbital.Stack</h2>
             <div className="w-8 h-[1px] bg-[#00f2ff]/40" />
          </div>
          <div className="text-[10px] font-bold flex items-center justify-center gap-4 opacity-50 uppercase tracking-widest">
             <div className="flex items-center gap-1">
                <span>Sector:</span>
                <span className="text-white">Alpha-9</span>
             </div>
             <div className="flex items-center gap-1">
                <span>Core_Power:</span>
                <span className="text-[#34C759]">Nominal</span>
             </div>
          </div>
        </div>
        <div className="flex flex-col items-end gap-1 px-4 py-2 border border-[#00f2ff]/20 bg-[#00f2ff]/5">
           <span className="text-[8px] font-bold uppercase opacity-40 tracking-widest">Calculated_Mass</span>
           <span className="text-xl font-bold tabular-nums text-white">{score}</span>
        </div>
      </div>

      {/* Main Containment Field (Game Board) */}
      <div className="relative flex-1 w-full flex flex-col items-center justify-center px-4 pb-12">
        <div className="relative h-[78vh] aspect-[1/2] bg-black/80 rounded-sm border border-[#00f2ff]/30 shadow-[0_0_50px_rgba(0,242,255,0.05)] overflow-hidden">
          {/* Target Grid */}
          <div className="grid grid-cols-10 grid-rows-20 w-full h-full gap-[1px]">
             {grid.map((row, r) => row.map((color, c) => (
                <div key={`${r}-${c}`} className="relative border-[0.5px] border-[#00f2ff]/5" style={{ background: color ? `${color}dd` : 'transparent' }}>
                    {color && (
                        <>
                            <div className="absolute inset-0 bg-gradient-to-tr from-black/60 to-transparent" />
                            <div className="absolute inset-[2px] border border-white/20 opacity-30" />
                            <div className="absolute top-0 left-0 w-full h-full shadow-[inset_0_0_10px_rgba(0,242,255,0.2)]" />
                        </>
                    )}
                </div>
             )))}
          </div>

          {/* Holographic Active Transponder */}
          {activePiece && (
              <div className="absolute inset-0 pointer-events-none">
                  {activePiece.shape.map((row: number[], r: number) => row.map((val, c) => {
                      if (!val) return null;
                      const x = pos.x + c;
                      const y = pos.y + r;
                      if (y < 0) return null;
                      return (
                        <div 
                            key={`${r}-${c}`}
                            className="absolute w-[10%] h-[5%] p-[1px]"
                            style={{ left: `${x * 10}%`, top: `${y * 5}%` }}
                        >
                            <div className="w-full h-full relative shadow-[0_0_20px_rgba(0,242,255,0.4)]" style={{ background: activePiece.color }}>
                                <div className="absolute inset-0 bg-gradient-to-br from-white/60 to-transparent" />
                                <div className="absolute inset-[2px] border-2 border-white/40 opacity-40" />
                                <div className="absolute top-1 left-1 w-1 h-1 bg-white rounded-full glow shadow-[0_0_5px_#fff]" />
                            </div>
                        </div>
                      );
                  }))}
              </div>
          )}

          {/* Start/End Overlays */}
          {!gameStarted && (
              <div className="absolute inset-0 z-50 flex items-center justify-center bg-black/90">
                 <button 
                   onClick={startGame}
                   className="px-10 py-4 border border-[#00f2ff] text-[#00f2ff] bg-transparent font-bold text-xs uppercase tracking-[0.4em] hover:bg-[#00f2ff]/10 active:scale-95 transition-all shadow-[0_0_20px_rgba(0,242,255,0.2)]"
                >
                   Initiate_Orbital
                </button>
              </div>
          )}

          {gameOver && (
              <div className="absolute inset-0 z-50 flex flex-col items-center justify-center bg-[#ff3b30]/10 backdrop-blur-xl border-x-[1px] border-[#ff3b30]/40">
                <span className="text-[10px] font-bold text-[#ff3b30] uppercase tracking-[0.8em] mb-4 animate-pulse">Structural_Collapse</span>
                <h3 className="text-5xl font-black uppercase text-white mb-12">Hull_Failure</h3>
                <button 
                   onClick={startGame}
                   className="px-12 py-5 border border-white text-white bg-transparent font-bold text-xs uppercase tracking-[0.4em] hover:bg-white/10 active:scale-95 transition-all"
                >
                   Rebuild_Core
                </button>
              </div>
          )}
        </div>
      </div>

      {/* Control Surface */}
      <div className="absolute bottom-10 left-0 w-full flex justify-center gap-8 py-6 px-10 z-50 bg-[#05050a]/80 backdrop-blur-md border-t border-white/5">
         <div className="grid grid-cols-2 gap-4">
            <NavBtn icon="west" onClick={() => {
                const newPos = { ...pos, x: pos.x - 1 };
                if (!checkCollision(newPos, activePiece?.shape, grid)) setPos(newPos);
            }} />
            <NavBtn icon="east" onClick={() => {
                const newPos = { ...pos, x: pos.x + 1 };
                if (!checkCollision(newPos, activePiece?.shape, grid)) setPos(newPos);
            }} />
         </div>
         <div className="grid grid-cols-2 gap-4">
            <NavBtn icon="south" onClick={moveDown} />
            <NavBtn icon="cached" onClick={handleRotate} />
         </div>
      </div>

      <style>{`
        @keyframes parallax {
            from { background-position: 0 0; }
            to { background-position: 0 1000px; }
        }
        .animate-parallax { animation: parallax 60s linear infinite; }
      `}</style>
    </div>
  );
};

const NavBtn = ({ icon, onClick }: { icon: string; onClick: () => void }) => (
    <button 
        onClick={onClick}
        className="w-14 h-14 border border-[#00f2ff]/20 bg-[#00f2ff]/5 flex items-center justify-center active:scale-90 active:bg-[#00f2ff]/10 transition-all"
    >
        <span className="material-symbols-outlined text-[#00f2ff] text-3xl opacity-60">{icon}</span>
    </button>
);
