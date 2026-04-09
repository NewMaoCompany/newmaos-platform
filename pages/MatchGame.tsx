import React, { useState, useEffect, useCallback, useRef } from 'react';
import { useApp } from '../AppContext';

const GRID_SIZE = 8;
const CELL_SIZE = 48;
const GAP = 6;

const LEVELS = [
  { id: 1, target: 1000, moves: 30, reward: 50, title: 'Prism Start' },
  { id: 2, target: 2500, moves: 25, reward: 100, title: 'Iridescent' },
  { id: 3, target: 5000, moves: 22, reward: 200, title: 'Neon Flux' },
  { id: 4, target: 7500, moves: 20, reward: 400, title: 'Rainbow Tide' },
  { id: 5, target: 10000, moves: 18, reward: 800, title: 'Chroma Core' },
  { id: 6, target: 15000, moves: 18, reward: 1200, title: 'Prismatic Rain' },
  { id: 7, target: 20000, moves: 15, reward: 2000, title: 'Elite Spectrum' },
  { id: 8, target: 30000, moves: 15, reward: 3500, title: 'Infinite RGB' },
];

const GEMS = [
  { color: '#FF3B30', glow: 'rgba(255,59,48,0.7)', gradient: 'radial-gradient(circle at 35% 35%, #ff7b71, #FF3B30 60%, #b32a21)' },
  { color: '#FF9500', glow: 'rgba(255,149,0,0.7)', gradient: 'radial-gradient(circle at 35% 35%, #ffbd5c, #FF9500 60%, #b36b00)' },
  { color: '#FFD60A', glow: 'rgba(255,214,10,0.7)', gradient: 'radial-gradient(circle at 35% 35%, #fff15e, #FFD60A 60%, #b39600)' },
  { color: '#34C759', glow: 'rgba(52,199,89,0.7)', gradient: 'radial-gradient(circle at 35% 35%, #88e09e, #34C759 60%, #248a3e)' },
  { color: '#007AFF', glow: 'rgba(0,122,255,0.7)', gradient: 'radial-gradient(circle at 35% 35%, #6bb1ff, #007AFF 60%, #0056b3)' },
  { color: '#AF52DE', glow: 'rgba(175,82,222,0.7)', gradient: 'radial-gradient(circle at 35% 35%, #da9eff, #AF52DE 60%, #7a399b)' },
];

const RAINBOW_GRADIENT = "linear-gradient(45deg, #ff0000, #ff7f00, #ffff00, #00ff00, #0000ff, #4b0082, #8b00ff)";

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
  const { awardPoints, saveSectionProgress, getSectionProgress, sectionProgressMap } = useApp();
  const [stage, setStage] = useState<'selector' | 'game'>('selector');
  const [currentLevelId, setCurrentLevelId] = useState(1);
  const [board, setBoard] = useState<Cell[][]>(() => createBoard());
  const [selected, setSelected] = useState<[number, number] | null>(null);
  const [score, setScore] = useState(0);
  const [moves, setMoves] = useState(30);
  const [combo, setCombo] = useState(0);
  const [animating, setAnimating] = useState(false);
  const [gameResult, setGameResult] = useState<'win' | 'lose' | null>(null);
  const [showCombo, setShowCombo] = useState(false);
  const [isFlashActive, setIsFlashActive] = useState(false);
  const [particles, setParticles] = useState<{ id: number; x: number; y: number; color: string; dx: number; dy: number; size: number }[]>([]);
  const [popups, setPopups] = useState<{ id: number; x: number; y: number; text: string; color: string }[]>([]);
  const [isShaking, setIsShaking] = useState(false);
  const particleId = useRef(0);
  const popupId = useRef(0);

  const level = LEVELS.find(l => l.id === currentLevelId) || LEVELS[0];

  const addParticles = useCallback((row: number, col: number, color: string) => {
    const newParticles = Array.from({ length: 16 }, () => ({
      id: particleId.current++,
      x: col * (CELL_SIZE + GAP) + CELL_SIZE / 2,
      y: row * (CELL_SIZE + GAP) + CELL_SIZE / 2,
      color,
      dx: (Math.random() - 0.5) * 180,
      dy: (Math.random() - 0.5) * 180,
      size: Math.random() * 12 + 4,
    }));
    setParticles(prev => [...prev, ...newParticles]);
    setTimeout(() => {
      setParticles(prev => prev.filter(p => !newParticles.find(np => np.id === p.id)));
    }, 1000);
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
    const points = matchCount * 25 * newCombo;
    setCombo(newCombo);
    
    // Trigger Flash & Shake
    setIsFlashActive(true);
    setIsShaking(true);
    setTimeout(() => { setIsFlashActive(false); setIsShaking(false); }, 350);
    
    if (newCombo > 1) {
      setShowCombo(true);
      setTimeout(() => setShowCombo(false), 1000);
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
    if (animating || gameResult) return;
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
  }, [board, animating, gameResult, processBoard]);

  const handleCellClick = useCallback((r: number, c: number) => {
    if (animating || gameResult) return;
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
  }, [selected, animating, gameResult, swap]);

  const startLevel = (id: number) => {
    const l = LEVELS.find(lvl => lvl.id === id) || LEVELS[0];
    setCurrentLevelId(id);
    setBoard(createBoard());
    setScore(0);
    setMoves(l.moves);
    setCombo(0);
    setGameResult(null);
    setAnimating(false);
    setSelected(null);
    setStage('game');
  };

  useEffect(() => {
    if (score >= level.target && !animating && !gameResult) {
      setGameResult('win');
      saveSectionProgress(`match3_level_${currentLevelId}`, { highScore: score }, { completed: 1, total: 1, score: score });
      awardPoints(level.reward, 'game_win', `match3_lvl_${currentLevelId}`, `Cleared Match 3 Level ${currentLevelId}`);
    } else if (moves <= 0 && score < level.target && !animating && !gameResult) {
      setGameResult('lose');
    }
  }, [score, moves, animating, level, gameResult, currentLevelId, saveSectionProgress, awardPoints]);

  const gridPx = GRID_SIZE * CELL_SIZE + (GRID_SIZE - 1) * GAP;

  // Render Level Selector - Rainbow Prism & Liquid Blobs
  if (stage === 'selector') {
    return (
      <div className="fixed inset-0 z-[100] flex flex-col items-center select-none overflow-hidden bg-white">
        {/* Animated Prism Mesh Background */}
        <div className="absolute inset-0 bg-[#f8f9ff]" />
        <div className="absolute inset-0 opacity-40 animate-rainbow-fade mix-blend-overlay" style={{ background: RAINBOW_GRADIENT, backgroundSize: '400% 400%' }} />
        <div className="absolute top-[-25%] left-[-25%] w-[80%] h-[80%] bg-[hsl(200,100%,80%)] rounded-full blur-[150px] animate-blob-morph" />
        <div className="absolute bottom-[-10%] right-[-10%] w-[60%] h-[60%] bg-[hsl(300,100%,85%)] rounded-full blur-[130px] animate-blob-morph-alt" />

        <div className="w-full flex items-center justify-between px-10 py-12 z-50">
          <button onClick={onBack} className="w-16 h-16 rounded-[28px] bg-white/40 backdrop-blur-3xl border border-white/60 flex items-center justify-center hover:bg-white/60 active:scale-90 transition-all shadow-xl">
            <span className="material-symbols-outlined text-black text-3xl">arrow_back</span>
          </button>
          <div className="text-center">
            <h1 className="text-5xl font-black italic uppercase text-transparent bg-clip-text bg-gradient-to-r from-blue-600 via-purple-600 to-pink-500 tracking-tighter">Rainbow Prism</h1>
            <p className="text-[12px] font-black tracking-[0.6em] opacity-40 uppercase mt-2 text-black">Liquid Gems Odyssey</p>
          </div>
          <div className="w-16" />
        </div>

        <div className="relative z-50 flex-1 w-full max-w-[1200px] overflow-y-auto px-10 pb-20 custom-scrollbar mt-4">
          <div className="grid grid-cols-2 sm:grid-cols-4 gap-12 sm:gap-16 justify-items-center">
            {LEVELS.map((l, idx) => {
              const progress = sectionProgressMap[`match3_level_${l.id}`];
              const isPrevCompleted = idx === 0 || !!sectionProgressMap[`match3_level_${l.id - 1}`];
              const isLocked = !isPrevCompleted;

              return (
                <button
                  key={l.id}
                  disabled={isLocked}
                  onClick={() => startLevel(l.id)}
                  className={`group relative w-40 h-40 sm:w-48 sm:h-48 flex flex-col items-center justify-center transition-all duration-700 ${isLocked ? 'opacity-30 grayscale cursor-not-allowed' : 'hover:scale-105 active:scale-95'}`}
                >
                  {/* The Liquid Blob Shape */}
                  <div className={`absolute inset-0 animate-blob-morph transition-all duration-700 ${isLocked ? 'bg-gray-200 border-gray-300' : 'bg-white/60 backdrop-blur-3xl border border-white/80 shadow-2xl group-hover:bg-white/80'}`} />
                  
                  <div className="relative z-10 flex flex-col items-center">
                    {isLocked ? (
                      <span className="material-symbols-outlined text-5xl text-gray-400">lock</span>
                    ) : (
                      <>
                        <span className="text-5xl font-black text-black mb-1 drop-shadow-sm">{l.id}</span>
                        <span className="text-[11px] font-black text-black/40 uppercase tracking-widest text-center px-4 leading-tight mb-4">{l.title}</span>
                        <div className="flex flex-col items-center gap-2">
                           <div className="px-4 py-1.5 rounded-full bg-black/5 text-[10px] font-black text-blue-600 border border-black/5">
                             {l.target.toLocaleString()} PTS
                           </div>
                           {progress?.status === 'completed' && (
                             <span className="material-symbols-outlined text-green-500 text-2xl fill-1">verified</span>
                           )}
                        </div>
                      </>
                    )}
                  </div>
                </button>
              );
            })}
          </div>
        </div>
      </div>
    );
  }

  // Render Game Stage - Prism Glass Style
  return (
    <div className="fixed inset-0 z-[100] flex flex-col items-center select-none overflow-hidden bg-[#fafaff] text-black font-sans">
      <div className="absolute inset-0 opacity-20 animate-rainbow-fade" style={{ background: RAINBOW_GRADIENT, backgroundSize: '400% 400%' }} />
      <div className="absolute top-[-10%] left-[-10%] w-[50%] h-[50%] bg-blue-300 rounded-full blur-[120px] animate-blob-morph" />
      <div className="absolute bottom-[-10%] right-[-10%] w-[50%] h-[50%] bg-pink-300 rounded-full blur-[120px] animate-blob-morph-alt" />

      {/* Matching Flash Overlay */}
      <div className={`fixed inset-0 z-[200] bg-white transition-opacity duration-300 pointer-events-none ${isFlashActive ? 'opacity-30' : 'opacity-0'}`} />

      {/* Header */}
      <div className="w-full flex items-center justify-between px-12 py-8 z-50 bg-white/40 backdrop-blur-3xl border-b border-white/60 shadow-lg">
        <button onClick={() => setStage('selector')} className="flex items-center gap-4 group">
          <div className="w-14 h-14 rounded-[22px] bg-white/60 border border-white shadow-md flex items-center justify-center group-active:scale-90 transition-transform">
            <span className="material-symbols-outlined text-black text-3xl">apps</span>
          </div>
          <div>
            <p className="text-[11px] font-black text-black/40 uppercase tracking-widest">Stage {level.id}</p>
            <p className="font-black text-lg uppercase tracking-tighter italic text-transparent bg-clip-text bg-gradient-to-r from-blue-600 to-purple-600">{level.title}</p>
          </div>
        </button>

        <div className="flex flex-col items-center flex-1">
          <div className="w-full max-w-[300px] h-4 bg-black/5 rounded-full overflow-hidden mb-3 border border-black/5 shadow-inner">
            <div 
              className="h-full bg-gradient-to-r from-blue-500 via-purple-500 to-pink-500 shadow-[0_0_20px_rgba(168,85,247,0.5)] transition-all duration-700"
              style={{ width: `${Math.min(100, (score / level.target) * 100)}%` }}
            />
          </div>
          <p className="text-[12px] font-black uppercase tracking-[0.2em] text-black/60">
            Goal: <span className="text-black font-black">{score.toLocaleString()}</span> / {level.target.toLocaleString()}
          </p>
        </div>

        <button onClick={() => startLevel(currentLevelId)} className="w-14 h-14 rounded-[22px] bg-white/60 border border-white shadow-md flex items-center justify-center active:rotate-180 transition-transform duration-700">
          <span className="material-symbols-outlined text-black text-2xl">sync</span>
        </button>
      </div>

      {/* Hero Stats */}
      <div className="flex items-center gap-20 mt-12 mb-10 z-50">
        <div className="flex flex-col items-center">
          <span className="text-[12px] font-black text-black/30 uppercase tracking-[0.4em] mb-2">Points</span>
          <span className="text-7xl font-black tracking-tighter tabular-nums drop-shadow-md bg-clip-text text-transparent bg-gradient-to-b from-black to-black/60">
            {score.toLocaleString()}
          </span>
        </div>
        <div className="w-px h-20 bg-black/10" />
        <div className="flex flex-col items-center">
          <span className="text-[12px] font-black text-black/30 uppercase tracking-[0.4em] mb-2">Moves</span>
          <span className={`text-7xl font-black tracking-tighter tabular-nums ${moves <= 5 ? 'text-red-600 animate-pulse' : 'text-black/80'}`}>
            {moves}
          </span>
        </div>
      </div>

      {/* Combo Badge */}
      <div className={`h-16 flex items-center justify-center mb-10 z-50 transition-all duration-700 ${showCombo ? 'scale-110 opacity-100' : 'scale-50 opacity-0'}`}>
        <div className="px-10 py-3.5 rounded-full bg-gradient-to-r from-red-500 via-orange-500 to-yellow-500 text-white font-black text-2xl shadow-2xl border-2 border-white/40 italic tracking-tighter animate-bounce">
          🌈 {combo}x PRISM COMBO!
        </div>
      </div>

      {/* Board Container - Prism Glass */}
      <div className={`relative p-3 rounded-[52px] border border-white/80 shadow-[0_40px_100px_rgba(0,0,0,0.1)] bg-white/40 backdrop-blur-[100px] ${isShaking ? 'animate-vibration' : ''}`}>
        <div 
          className="relative rounded-[40px] bg-white/10 overflow-hidden"
          style={{ width: gridPx + 24, height: gridPx + 24, padding: 12 }}
        >
          {/* Particles */}
          {particles.map(p => (
            <div
              key={p.id}
              className="absolute pointer-events-none rounded-sm"
              style={{
                left: p.x + 12,
                top: p.y + 12,
                width: p.size,
                height: p.size,
                background: RAINBOW_GRADIENT,
                backgroundSize: '400% 400%',
                boxShadow: `0 0 10px ${p.color}`,
                animation: `burst 1s ease-out forwards, rainbow-fade 1s linear infinite`,
                '--tx': `${p.dx}px`,
                '--ty': `${p.dy}px`
              } as any}
            />
          ))}

          {/* Gems - Rainbow Style */}
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
                    ? `0 0 0 6px #fff, 0 0 50px ${gem.glow}, 0 0 30px rgba(0,0,0,0.1)` 
                    : `0 12px 25px -8px ${gem.glow}, inset 0 2px 10px rgba(255,255,255,0.5)`,
                  transform: cell.removing ? 'scale(0) rotate(360deg)' : isSelected ? 'scale(1.25)' : 'scale(1)',
                  opacity: cell.removing ? 0 : 1,
                  zIndex: isSelected ? 50 : 1,
                }}
              >
                <div className="absolute inset-x-2.5 top-2.5 h-1/2 bg-gradient-to-b from-white/60 to-transparent rounded-full opacity-70 pointer-events-none" />
                <div className="absolute inset-0 rounded-full opacity-20 mix-blend-overlay" style={{ background: RAINBOW_GRADIENT, backgroundSize: '200% 200%' }} />
              </div>
            );
          }))}

          {/* Popups */}
          {popups.map(p => (
            <div
              key={p.id}
              className="absolute pointer-events-none z-[100] font-black text-4xl drop-shadow-xl flex items-center gap-1 tracking-tighter italic"
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

      {/* Result Screen - Premium Prism */}
      {gameResult && (
        <div className="fixed inset-0 z-[300] flex items-center justify-center bg-white/60 backdrop-blur-[120px] animate-fade-in px-8">
          <div className="w-full max-w-[480px] bg-white/90 border-4 border-white rounded-[64px] p-16 text-center shadow-[0_50px_100px_rgba(0,0,0,0.2)]">
            <div className={`w-32 h-32 rounded-full animate-blob-morph flex items-center justify-center mx-auto mb-10 shadow-3xl ${gameResult === 'win' ? 'bg-gradient-to-br from-yellow-400 to-orange-500' : 'bg-gradient-to-br from-red-500 to-pink-600'}`}>
              <span className="material-symbols-outlined text-white text-7xl">
                {gameResult === 'win' ? 'verified' : 'error'}
              </span>
            </div>
            
            <h3 className="text-5xl font-black text-black mb-4 uppercase tracking-tighter italic bg-clip-text text-transparent bg-gradient-to-r from-blue-700 to-pink-700">
              {gameResult === 'win' ? 'VICTORY!' : 'PRISM SHATTERED'}
            </h3>
            <p className="text-black/30 text-[12px] font-black uppercase tracking-[0.4em] mb-12">
              Score: <span className="text-black">{score.toLocaleString()}</span>
            </p>

            <div className="flex flex-col gap-6">
              {gameResult === 'win' ? (
                <>
                   <div className="bg-black/5 rounded-[32px] p-6 mb-2 flex items-center justify-center gap-8 border border-black/5">
                      <div className="flex flex-col items-center">
                        <span className="text-[11px] font-black text-blue-600 uppercase tracking-widest mb-1">XP Points</span>
                        <span className="text-2xl font-black text-black">+{level.reward}</span>
                      </div>
                      <div className="w-px h-10 bg-black/10" />
                      <div className="flex flex-col items-center">
                        <span className="text-[11px] font-black text-purple-600 uppercase tracking-widest mb-1">Stardust</span>
                        <span className="text-2xl font-black text-black">+1</span>
                      </div>
                   </div>
                   <button
                    onClick={() => {
                        if (currentLevelId < LEVELS.length) startLevel(currentLevelId + 1);
                        else setStage('selector');
                    }}
                    className="w-full py-7 bg-black text-white rounded-[32px] font-black text-2xl active:scale-[0.96] transition-transform shadow-[0_20px_40px_rgba(0,0,0,0.3)]"
                  >
                    CONTINUE
                  </button>
                </>
              ) : (
                <button
                  onClick={() => startLevel(currentLevelId)}
                  className="w-full py-7 bg-black text-white rounded-[32px] font-black text-2xl active:scale-[0.96] transition-transform shadow-[0_20px_40px_rgba(0,0,0,0.3)]"
                >
                  RETRY
                </button>
              )}
              <button
                onClick={() => setStage('selector')}
                className="w-full py-4 text-black/40 rounded-[32px] font-black text-sm active:opacity-60 transition-opacity uppercase tracking-widest"
              >
                Exit to Selection
              </button>
            </div>
          </div>
        </div>
      )}

      <style>{`
        @keyframes rainbow-fade {
          0% { background-position: 0% 50%; }
          50% { background-position: 100% 50%; }
          100% { background-position: 0% 50%; }
        }
        @keyframes blob-morph {
          0%, 100% { border-radius: 60% 40% 30% 70% / 60% 30% 70% 40%; transform: scale(1); }
          50% { border-radius: 30% 60% 70% 40% / 50% 60% 30% 60%; transform: scale(1.05); }
        }
        @keyframes blob-morph-alt {
          0%, 100% { border-radius: 40% 60% 60% 40% / 40% 60% 60% 40%; transform: scale(1.1); }
          50% { border-radius: 60% 40% 40% 60% / 60% 40% 40% 60%; transform: scale(1); }
        }
        @keyframes burst {
          0% { transform: translate(0, 0) scale(1) rotate(0deg); opacity: 1; }
          100% { transform: translate(var(--tx), var(--ty)) scale(0) rotate(720deg); opacity: 0; }
        }
        @keyframes land {
          0% { transform: scale(1.2, 0.8); }
          50% { transform: scale(0.85, 1.15); }
          100% { transform: scale(1, 1); }
        }
        @keyframes popup-float {
          0% { transform: translate(-50%, 0) scale(0.5); opacity: 0; }
          20% { transform: translate(-50%, -60px) scale(1.5); opacity: 1; }
          100% { transform: translate(-50%, -180px) scale(1); opacity: 0; }
        }
        @keyframes vibration {
          0%, 100% { transform: translate(0, 0); }
          25% { transform: translate(-8px, 8px) rotate(-1.5deg); }
          50% { transform: translate(8px, -8px) rotate(1.5deg); }
          75% { transform: translate(-4px, 4px) rotate(-0.5deg); }
        }
        .animate-rainbow-fade { animation: rainbow-fade 10s linear infinite; }
        .animate-blob-morph { animation: blob-morph 12s ease-in-out infinite; }
        .animate-blob-morph-alt { animation: blob-morph-alt 15s ease-in-out infinite; }
        .animate-vibration { animation: vibration 0.4s ease-in-out; }
        .animate-land { animation: land 0.6s cubic-bezier(0.34, 1.56, 0.64, 1); }
        .animate-fade-in { animation: fadeIn 0.5s ease-out; }
        @keyframes fadeIn { from { opacity: 0; } to { opacity: 1; } }
        .custom-scrollbar::-webkit-scrollbar { width: 5px; }
        .custom-scrollbar::-webkit-scrollbar-thumb { background: rgba(0,0,0,0.1); border-radius: 10px; }
      `}</style>
    </div>
  );
};
