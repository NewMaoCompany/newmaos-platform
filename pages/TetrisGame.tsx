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
    <div className="fixed inset-0 z-[110] flex flex-col items-center bg-[#0a0a1a] text-white font-sans overflow-hidden">
      {/* Aurora Background Effect */}
      <div className="absolute inset-0 z-0">
          <div className="absolute top-0 left-0 w-full h-full bg-gradient-to-br from-purple-900/40 via-blue-900/40 to-green-900/40" />
          <div className="absolute inset-0 opacity-30 animate-aurora mix-blend-screen" style={{ background: 'linear-gradient(110deg, transparent 40%, #5AC8FA 45%, #64D2FF 50%, #5AC8FA 55%, transparent 60%)', backgroundSize: '300% 100%' }} />
      </div>

      {/* Header */}
      <div className="w-full flex items-center justify-between px-10 py-10 z-50">
        <button 
            onClick={() => navigate('/lobby')} 
            className="w-14 h-14 rounded-3xl bg-white/5 backdrop-blur-3xl border border-white/10 flex items-center justify-center hover:bg-white/10 active:scale-90 transition-all shadow-2xl"
        >
          <span className="material-symbols-outlined text-white text-3xl">arrow_back</span>
        </button>
        <div className="text-center">
          <h2 className="text-4xl font-black italic uppercase tracking-tighter text-transparent bg-clip-text bg-gradient-to-r from-blue-400 via-indigo-400 to-purple-500">Aurora Grid</h2>
          <div className="flex items-center justify-center gap-3 mt-1 opacity-60">
             <span className="text-[10px] font-black uppercase tracking-widest">Score</span>
             <span className="font-black tabular-nums">{score}</span>
          </div>
        </div>
        <div className="w-14" />
      </div>

      {/* Tetris Board */}
      <div className="relative flex-1 w-full flex flex-col items-center justify-center px-4 pb-12">
        <div className="relative h-[80vh] aspect-[1/2] bg-white/[0.04] backdrop-blur-2xl rounded-[32px] p-2 border border-white/10 shadow-[0_0_80px_rgba(0,0,0,0.4)] overflow-hidden">
          {/* Grid View */}
          <div className="grid grid-cols-10 grid-rows-20 w-full h-full gap-[1px]">
             {grid.map((row, r) => row.map((color, c) => (
                <div key={`${r}-${c}`} className="relative rounded-[4px] overflow-hidden" style={{ background: color ? `${color}44` : 'rgba(255,255,255,0.02)' }}>
                    {color && (
                        <>
                            <div className="absolute inset-0 bg-gradient-to-br from-white/20 to-transparent" />
                            <div className="absolute inset-[2px] rounded-[3px] border border-white/40 opacity-40" />
                            <div className="absolute top-1 left-1 w-1 h-1 bg-white rounded-full blur-[1px] opacity-60" />
                        </>
                    )}
                </div>
             )))}
          </div>

          {/* Active Piece */}
          {activePiece && (
              <div className="absolute inset-2 pointer-events-none">
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
                            <div className="w-full h-full rounded-[4px] relative shadow-[0_0_15px_rgba(255,255,255,0.2)]" style={{ background: activePiece.color }}>
                                <div className="absolute inset-0 bg-gradient-to-br from-white/40 to-transparent" />
                                <div className="absolute inset-[2px] border border-white/60 rounded-[3px] opacity-40" />
                            </div>
                        </div>
                      );
                  }))}
              </div>
          )}

          {!gameStarted && (
              <div className="absolute inset-0 z-50 flex items-center justify-center bg-black/40 backdrop-blur-md">
                 <button 
                   onClick={startGame}
                   className="px-12 py-5 bg-white text-black rounded-full font-black text-sm uppercase tracking-[0.3em] shadow-2xl active:scale-95 transition-all"
                >
                   Stabilize Grid
                </button>
              </div>
          )}

          {gameOver && (
              <div className="absolute inset-0 z-50 flex flex-col items-center justify-center bg-red-900/20 backdrop-blur-xl animate-fade-in">
                <span className="text-[12px] font-black text-white/50 uppercase tracking-[0.6em] mb-2">Atmosphere Collapse</span>
                <h3 className="text-6xl font-black italic uppercase tracking-tighter mb-8">Game Over</h3>
                <button 
                   onClick={startGame}
                   className="px-12 py-5 bg-white text-black rounded-full font-black text-sm uppercase tracking-[0.3em] shadow-2xl active:scale-95 transition-all"
                >
                   Relight Aurora
                </button>
              </div>
          )}
        </div>
      </div>

      <style>{`
        @keyframes aurora {
            0% { background-position: -150% 0; }
            100% { background-position: 150% 0; }
        }
        .animate-aurora { animation: aurora 8s linear infinite; }
      `}</style>
    </div>
  );
};
