import React, { useState, useEffect, useCallback, useRef } from 'react';

const GRID_SIZE = 8;
const CELL_SIZE = 48; // Slightly larger for iPad
const GAP = 6;

const GEMS = [
  { color: '#FF3B30', glow: 'rgba(255,59,48,0.6)', gradient: 'radial-gradient(circle at 35% 35%, #ff7b71, #FF3B30 60%, #b32a21)' },
  { color: '#FF9500', glow: 'rgba(255,149,0,0.6)', gradient: 'radial-gradient(circle at 35% 35%, #ffbd5c, #FF9500 60%, #b36b00)' },
  { color: '#FFD60A', glow: 'rgba(255,214,10,0.6)', gradient: 'radial-gradient(circle at 35% 35%, #fff15e, #FFD60A 60%, #b39600)' },
  { color: '#34C759', glow: 'rgba(52,199,89,0.6)', gradient: 'radial-gradient(circle at 35% 35%, #88e09e, #34C759 60%, #248a3e)' },
  { color: '#007AFF', glow: 'rgba(0,122,255,0.6)', gradient: 'radial-gradient(circle at 35% 35%, #6bb1ff, #007AFF 60%, #0056b3)' },
  { color: '#AF52DE', glow: 'rgba(175,82,222,0.6)', gradient: 'radial-gradient(circle at 35% 35%, #da9eff, #AF52DE 60%, #7a399b)' },
];

type Cell = {
  type: number;
  id: number;
  removing?: boolean;
  falling?: boolean;
  isNew?: boolean;
};

let cellIdCounter = 0;
const newCell = (type: number): Cell => ({ type, id: cellIdCounter++, removing: false });

const randomType = () => Math.floor(Math.random() * GEMS.length);

const createBoard = (): Cell[][] => {
  const board: Cell[][] = [];
  for (let r = 0; r < GRID_SIZE; r++) {
    board[r] = [];
    for (let c = 0; c < GRID_SIZE; c++) {
      let t: number;
      do {
        t = randomType();
      } while (
        (c >= 2 && board[r][c - 1].type === t && board[r][c - 2].type === t) ||
        (r >= 2 && board[r - 1][c].type === t && board[r - 2][c].type === t)
      );
      board[r][c] = newCell(t);
    }
  }
  return board;
};

const cloneBoard = (b: Cell[][]): Cell[][] => b.map(row => row.map(cell => ({ ...cell })));

const findMatches = (board: Cell[][]): boolean[][] => {
  const matched: boolean[][] = Array.from({ length: GRID_SIZE }, () => Array(GRID_SIZE).fill(false));

  for (let r = 0; r < GRID_SIZE; r++) {
    for (let c = 0; c < GRID_SIZE - 2; c++) {
      const t = board[r][c].type;
      if (t >= 0 && board[r][c + 1].type === t && board[r][c + 2].type === t) {
        matched[r][c] = matched[r][c + 1] = matched[r][c + 2] = true;
      }
    }
  }

  for (let c = 0; c < GRID_SIZE; c++) {
    for (let r = 0; r < GRID_SIZE - 2; r++) {
      const t = board[r][c].type;
      if (t >= 0 && board[r + 1][c].type === t && board[r + 2][c].type === t) {
        matched[r][c] = matched[r + 1][c] = matched[r + 2][c] = true;
      }
    }
  }

  return matched;
};

const hasAnyMatch = (matched: boolean[][]): boolean => {
  for (let r = 0; r < GRID_SIZE; r++)
    for (let c = 0; c < GRID_SIZE; c++)
      if (matched[r][c]) return true;
  return false;
};

const countMatched = (matched: boolean[][]): number => {
  let count = 0;
  for (let r = 0; r < GRID_SIZE; r++)
    for (let c = 0; c < GRID_SIZE; c++)
      if (matched[r][c]) count++;
  return count;
};

export const MatchGame = ({ onBack }: { onBack: () => void }) => {
  const [board, setBoard] = useState<Cell[][]>(() => createBoard());
  const [selected, setSelected] = useState<[number, number] | null>(null);
  const [score, setScore] = useState(0);
  const [moves, setMoves] = useState(30);
  const [combo, setCombo] = useState(0);
  const [animating, setAnimating] = useState(false);
  const [gameOver, setGameOver] = useState(false);
  const [showCombo, setShowCombo] = useState(false);
  const [particles, setParticles] = useState<{ id: number; x: number; y: number; color: string; dx: number; dy: number }[]>([]);
  const [popups, setPopups] = useState<{ id: number; x: number; y: number; text: string; color: string }[]>([]);
  const [isShaking, setIsShaking] = useState(false);
  const particleId = useRef(0);
  const popupId = useRef(0);

  const addParticles = useCallback((row: number, col: number, color: string) => {
    const newParticles = Array.from({ length: 8 }, () => ({
      id: particleId.current++,
      x: col * (CELL_SIZE + GAP) + CELL_SIZE / 2,
      y: row * (CELL_SIZE + GAP) + CELL_SIZE / 2,
      color,
      dx: (Math.random() - 0.5) * 100,
      dy: (Math.random() - 0.5) * 100,
    }));
    setParticles(prev => [...prev, ...newParticles]);
    setTimeout(() => {
      setParticles(prev => prev.filter(p => !newParticles.find(np => np.id === p.id)));
    }, 800);
  }, []);

  const addScorePopup = useCallback((row: number, col: number, text: string, color: string) => {
    const id = popupId.current++;
    const newPopup = {
      id,
      x: col * (CELL_SIZE + GAP) + CELL_SIZE / 2,
      y: row * (CELL_SIZE + GAP) + CELL_SIZE / 2,
      text,
      color
    };
    setPopups(prev => [...prev, newPopup]);
    setTimeout(() => {
      setPopups(prev => prev.filter(p => p.id !== id));
    }, 1200);
  }, []);

  const processBoard = useCallback(async (b: Cell[][], comboCount: number = 0) => {
    const matched = findMatches(b);
    if (!hasAnyMatch(matched)) {
      setAnimating(false);
      setCombo(0);
      return;
    }

    const matchCount = countMatched(matched);
    const newCombo = comboCount + 1;
    const points = matchCount * 15 * newCombo;
    setCombo(newCombo);
    setIsShaking(true);
    setTimeout(() => setIsShaking(false), 300);
    
    if (newCombo > 1) {
      setShowCombo(true);
      setTimeout(() => setShowCombo(false), 900);
    }

    let avgR = 0, avgC = 0, firstMatchColor = '#fff';
    let count = 0;
    for(let r=0; r<GRID_SIZE; r++) {
      for(let c=0; c<GRID_SIZE; c++) {
        if(matched[r][c]) {
          avgR += r; avgC += c; count++;
          if (count === 1) firstMatchColor = GEMS[b[r][c].type]?.color;
        }
      }
    }
    addScorePopup(avgR/count, avgC/count, `+${points}`, firstMatchColor);

    const nb = cloneBoard(b);
    for (let r = 0; r < GRID_SIZE; r++) {
      for (let c = 0; c < GRID_SIZE; c++) {
        if (matched[r][c]) {
          nb[r][c] = { ...nb[r][c], removing: true };
          addParticles(r, c, GEMS[nb[r][c].type]?.color || '#fff');
        }
      }
    }
    setBoard(nb);

    await new Promise(res => setTimeout(res, 400));
    setScore(prev => prev + points);

    const afterRemove = cloneBoard(nb);
    for (let c = 0; c < GRID_SIZE; c++) {
      let writeRow = GRID_SIZE - 1;
      for (let r = GRID_SIZE - 1; r >= 0; r--) {
        if (!afterRemove[r][c].removing) {
          if (writeRow !== r) {
            afterRemove[writeRow][c] = { ...afterRemove[r][c], falling: true };
            afterRemove[r][c] = newCell(-1);
          }
          writeRow--;
        }
      }
      for (let r = writeRow; r >= 0; r--) {
        afterRemove[r][c] = { ...newCell(randomType()), isNew: true };
      }
    }
    setBoard(afterRemove);

    await new Promise(res => setTimeout(res, 450));

    const clean = cloneBoard(afterRemove);
    for (let r = 0; r < GRID_SIZE; r++) {
      for (let c = 0; c < GRID_SIZE; c++) {
        clean[r][c].falling = false;
        clean[r][c].isNew = false;
        clean[r][c].removing = false;
      }
    }
    setBoard(clean);
    processBoard(clean, newCombo);
  }, [addParticles, addScorePopup]);

  const swap = useCallback((r1: number, c1: number, r2: number, c2: number) => {
    if (animating || gameOver) return;
    const nb = cloneBoard(board);
    [nb[r1][c1], nb[r2][c2]] = [nb[r2][c2], nb[r1][c1]];

    if (hasAnyMatch(findMatches(nb))) {
      setAnimating(true);
      setBoard(nb);
      setMoves(prev => prev - 1);
      setSelected(null);
      setTimeout(() => processBoard(nb, 0), 200);
    } else {
      setAnimating(true);
      setBoard(nb);
      setSelected(null);
      setTimeout(() => {
        setBoard(board);
        setAnimating(false);
      }, 300);
    }
  }, [board, animating, gameOver, processBoard]);

  const handleCellClick = useCallback((r: number, c: number) => {
    if (animating || gameOver) return;
    if (selected) {
      const [sr, sc] = selected;
      if (Math.abs(sr - r) + Math.abs(sc - c) === 1) {
        swap(sr, sc, r, c);
      } else {
        setSelected([r, c]);
      }
    } else {
      setSelected([r, c]);
    }
  }, [selected, animating, gameOver, swap]);

  useEffect(() => {
    if (moves <= 0 && !animating) setGameOver(true);
  }, [moves, animating]);

  const resetGame = () => {
    setBoard(createBoard());
    setScore(0);
    setMoves(30);
    setCombo(0);
    setGameOver(false);
    setSelected(null);
    setAnimating(false);
  };

  const gridPx = GRID_SIZE * CELL_SIZE + (GRID_SIZE - 1) * GAP;

  return (
    <div className="fixed inset-0 z-[100] flex flex-col items-center select-none overflow-hidden bg-[#0a0a1f] text-white">
      <div className="absolute inset-0 bg-gradient-to-b from-blue-900/20 to-transparent" />
      
      {/* Liquid Elements */}
      <div className="absolute top-[-10%] left-[-10%] w-[50%] h-[50%] bg-blue-500/10 rounded-full blur-[100px] animate-blob-1" />
      <div className="absolute bottom-[-10%] right-[-10%] w-[50%] h-[50%] bg-purple-500/10 rounded-full blur-[100px] animate-blob-2" />

      {/* Header */}
      <div className="w-full flex items-center justify-between px-10 py-6 z-50 backdrop-blur-md bg-white/5 border-b border-white/10">
        <button onClick={onBack} className="flex items-center gap-2 group">
          <div className="w-10 h-10 rounded-full bg-white/10 flex items-center justify-center group-active:scale-90 transition-transform">
            <span className="material-symbols-outlined text-xl">arrow_back</span>
          </div>
          <span className="font-bold text-lg opacity-80">Exit</span>
        </button>
        <div className="flex flex-col items-center">
          <h2 className="text-2xl font-black tracking-tighter uppercase opaciy-90">MATCH 3</h2>
          <div className="flex items-center gap-1.5 mt-0.5">
            <div className="w-1.5 h-1.5 rounded-full bg-green-400 animate-pulse" />
            <span className="text-[10px] font-black text-green-400 uppercase tracking-widest">Live Game</span>
          </div>
        </div>
        <button onClick={resetGame} className="w-10 h-10 rounded-full bg-white/10 flex items-center justify-center active:rotate-180 transition-transform duration-500">
          <span className="material-symbols-outlined text-xl">refresh</span>
        </button>
      </div>

      {/* Hero Stats */}
      <div className="flex items-center gap-10 mt-12 mb-10 z-50">
        <div className="flex flex-col items-center">
          <span className="text-[11px] font-black text-white/30 uppercase tracking-[0.2em] mb-1">Score</span>
          <span className="text-5xl font-black tracking-tighter tabular-nums text-transparent bg-clip-text bg-gradient-to-b from-white to-white/60">
            {score.toLocaleString()}
          </span>
        </div>
        <div className="w-px h-12 bg-white/10" />
        <div className="flex flex-col items-center">
          <span className="text-[11px] font-black text-white/30 uppercase tracking-[0.2em] mb-1">Moves</span>
          <span className={`text-5xl font-black tracking-tighter tabular-nums ${moves <= 5 ? 'text-red-500 animate-pulse' : 'text-transparent bg-clip-text bg-gradient-to-b from-white to-white/60'}`}>
            {moves}
          </span>
        </div>
      </div>

      {/* Combo Badge */}
      <div className={`h-12 flex items-center justify-center mb-6 z-50 transition-all duration-500 ${showCombo ? 'scale-110 opacity-100' : 'scale-75 opacity-0'}`}>
        <div className="px-6 py-2 rounded-2xl bg-gradient-to-r from-orange-500 via-red-500 to-pink-500 text-white font-black text-lg shadow-2xl shadow-red-500/40 border border-white/20">
          🔥 {combo}x COMBO!
        </div>
      </div>

      {/* Game Board Container */}
      <div className={`relative p-2 rounded-[40px] border border-white/10 shadow-3xl bg-white/5 backdrop-blur-[50px] ${isShaking ? 'animate-vibration' : ''}`}>
        <div 
          className="relative rounded-[32px] bg-black/20 overflow-hidden"
          style={{ width: gridPx + 24, height: gridPx + 24, padding: 12 }}
        >
          {/* Rendering Particles */}
          {particles.map(p => (
            <div
              key={p.id}
              className="absolute pointer-events-none rounded-full blur-[2px]"
              style={{
                left: p.x + 12,
                top: p.y + 12,
                width: 8,
                height: 8,
                background: p.color,
                boxShadow: `0 0 10px ${p.color}`,
                animation: `burst 0.8s ease-out forwards`,
                transform: `translate(${p.dx}px, ${p.dy}px)`,
                '--tx': `${p.dx}px`,
                '--ty': `${p.dy}px`
              } as any}
            />
          ))}

          {/* Rendering Board Gems */}
          {board.map((row, r) => row.map((cell, c) => {
            const gem = GEMS[cell.type];
            if (!gem) return null;
            const isSelected = selected && selected[0] === r && selected[1] === c;

            return (
              <div
                key={cell.id}
                onClick={() => handleCellClick(r, c)}
                className={`absolute rounded-full cursor-pointer transition-all duration-700 ease-[cubic-bezier(0.34,1.56,0.64,1)] ${cell.falling ? 'animate-land' : ''}`}
                style={{
                  width: CELL_SIZE,
                  height: CELL_SIZE,
                  left: c * (CELL_SIZE + GAP) + 12,
                  top: r * (CELL_SIZE + GAP) + 12,
                  background: gem.gradient,
                  boxShadow: isSelected 
                    ? `0 0 0 4px #fff, 0 0 30px ${gem.glow}` 
                    : `0 8px 16px -4px ${gem.glow}, inset 0 2px 5px rgba(255,255,255,0.4)`,
                  transform: cell.removing ? 'scale(0) rotate(180deg)' : isSelected ? 'scale(1.15)' : 'scale(1)',
                  opacity: cell.removing ? 0 : 1,
                  zIndex: isSelected ? 50 : 1,
                }}
              >
                {/* Gloss/Reflection Layer */}
                <div className="absolute inset-x-2 top-1.5 h-1/2 bg-gradient-to-b from-white/40 to-transparent rounded-full opacity-60 pointer-events-none" />
              </div>
            );
          }))}

          {/* Floating Score Popups */}
          {popups.map(p => (
            <div
              key={p.id}
              className="absolute pointer-events-none z-[100] font-black text-2xl drop-shadow-2xl flex items-center gap-1"
              style={{
                left: p.x + 12,
                top: p.y,
                transform: 'translate(-50%, -50%)',
                animation: 'popup-float 1.2s cubic-bezier(0.18, 0.89, 0.32, 1.28) forwards',
                color: p.color
              }}
            >
              {p.text}
            </div>
          ))}
        </div>
      </div>

      {/* Game Over Screen */}
      {gameOver && (
        <div className="fixed inset-0 z-[300] flex items-center justify-center bg-black/80 backdrop-blur-2xl animate-fade-in px-6">
          <div className="w-full max-w-[400px] bg-white/5 border border-white/20 rounded-[48px] p-10 text-center shadow-4xl ring-1 ring-white/10">
            <div className="w-24 h-24 bg-gradient-to-br from-blue-500 to-indigo-600 rounded-[32px] flex items-center justify-center mx-auto mb-6 shadow-2xl">
              <span className="material-symbols-outlined text-white text-5xl">emoji_events</span>
            </div>
            <h3 className="text-3xl font-black text-white mb-2 uppercase tracking-tighter italic">FINISH LINE</h3>
            <p className="text-white/40 text-sm font-bold uppercase tracking-widest mb-8">Score Achieved</p>
            <div className="text-7xl font-black mb-10 text-transparent bg-clip-text bg-gradient-to-b from-white to-white/40 tabular-nums tracking-tighter">
              {score.toLocaleString()}
            </div>
            <div className="flex flex-col gap-4">
              <button
                onClick={resetGame}
                className="w-full py-5 bg-white text-black rounded-[24px] font-black text-lg active:scale-[0.96] transition-transform shadow-xl"
              >
                RESTART GAME
              </button>
              <button
                onClick={onBack}
                className="w-full py-4 text-white/50 rounded-[24px] font-bold text-sm active:opacity-60 transition-opacity"
              >
                BACK TO LOBBY
              </button>
            </div>
          </div>
        </div>
      )}

      <style>{`
        @keyframes burst {
          0% { transform: translate(0, 0) scale(1); opacity: 1; }
          100% { transform: translate(var(--tx), var(--ty)) scale(0); opacity: 0; }
        }
        @keyframes land {
          0% { transform: scale(1.1, 0.9); }
          50% { transform: scale(0.9, 1.1); }
          100% { transform: scale(1, 1); }
        }
        @keyframes popup-float {
          0% { transform: translate(-50%, 0) scale(0.5); opacity: 0; }
          20% { transform: translate(-50%, -40px) scale(1.3); opacity: 1; }
          100% { transform: translate(-50%, -120px) scale(1); opacity: 0; }
        }
        @keyframes vibration {
          0%, 100% { transform: translate(0, 0); }
          25% { transform: translate(-4px, 4px); }
          50% { transform: translate(4px, -4px); }
          75% { transform: translate(-2px, 2px); }
        }
        @keyframes blob-1 {
          0%, 100% { transform: translate(0, 0) scale(1); }
          50% { transform: translate(50px, -50px) scale(1.2); }
        }
        @keyframes blob-2 {
          0%, 100% { transform: translate(0, 0) scale(1); }
          50% { transform: translate(-50px, 50px) scale(1.2); }
        }
        .animate-blob-1 { animation: blob-1 20s ease-in-out infinite; }
        .animate-blob-2 { animation: blob-2 25s ease-in-out infinite; }
        .animate-vibration { animation: vibration 0.4s ease-in-out; }
        .animate-land { animation: land 0.5s cubic-bezier(0.34, 1.56, 0.64, 1); }
        .animate-fade-in { animation: fadeIn 0.4s ease-out; }
        @keyframes fadeIn { from { opacity: 0; } to { opacity: 1; } }
      `}</style>
    </div>
  );
};
