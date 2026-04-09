import React, { useState, useEffect, useCallback, useRef } from 'react';
import { useApp } from '../AppContext';

const GRID_SIZE = 8;
const CELL_SIZE = 48;
const GAP = 6;

const LEVELS = [
  { id: 1, target: 1000, moves: 30, reward: 50, title: 'Introduction' },
  { id: 2, target: 2500, moves: 25, reward: 100, title: 'Deep Blue' },
  { id: 3, target: 5000, moves: 22, reward: 200, title: 'Neon Pulse' },
  { id: 4, target: 7500, moves: 20, reward: 400, title: 'Liquid Void' },
  { id: 5, target: 10000, moves: 18, reward: 800, title: 'Gravity Master' },
  { id: 6, target: 15000, moves: 18, reward: 1200, title: 'Stardust Rain' },
  { id: 7, target: 20000, moves: 15, reward: 2000, title: 'Elite Challenger' },
  { id: 8, target: 30000, moves: 15, reward: 3500, title: 'Infinity Core' },
];

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
  const [particles, setParticles] = useState<{ id: number; x: number; y: number; color: string; dx: number; dy: number }[]>([]);
  const [popups, setPopups] = useState<{ id: number; x: number; y: number; text: string; color: string }[]>([]);
  const [isShaking, setIsShaking] = useState(false);
  const particleId = useRef(0);
  const popupId = useRef(0);

  const level = LEVELS.find(l => l.id === currentLevelId) || LEVELS[0];

  const addParticles = useCallback((row: number, col: number, color: string) => {
    const newParticles = Array.from({ length: 8 }, () => ({
      id: particleId.current++,
      x: col * (CELL_SIZE + GAP) + CELL_SIZE / 2,
      y: row * (CELL_SIZE + GAP) + CELL_SIZE / 2,
      color,
      dx: (Math.random() - 0.5) * 120,
      dy: (Math.random() - 0.5) * 120,
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
      // Save Progress
      saveSectionProgress(`match3_level_${currentLevelId}`, { highScore: score }, { completed: 1, total: 1, score: score });
      awardPoints(level.reward, 'game_win', `match3_lvl_${currentLevelId}`, `Cleared Match 3 Level ${currentLevelId}`);
    } else if (moves <= 0 && score < level.target && !animating && !gameResult) {
      setGameResult('lose');
    }
  }, [score, moves, animating, level, gameResult, currentLevelId, saveSectionProgress, awardPoints]);

  const gridPx = GRID_SIZE * CELL_SIZE + (GRID_SIZE - 1) * GAP;

  // Render Level Selector
  if (stage === 'selector') {
    return (
      <div className="fixed inset-0 z-[100] flex flex-col items-center select-none overflow-hidden bg-[#0c0c2a] text-white">
        <div className="absolute inset-0 bg-gradient-to-b from-[#1a1a45] to-black opacity-60" />
        {/* Liquid Bubbles Background */}
        <div className="absolute top-[-20%] left-[-20%] w-[80%] h-[80%] bg-blue-500/10 rounded-full blur-[140px] animate-blob-rotate" />
        <div className="absolute bottom-[-20%] right-[-20%] w-[80%] h-[80%] bg-purple-500/10 rounded-full blur-[140px] animate-blob-rotate-slow" />

        {/* Header */}
        <div className="w-full flex items-center justify-between px-10 py-10 z-50">
          <button onClick={onBack} className="w-14 h-14 rounded-2xl bg-white/5 backdrop-blur-xl border border-white/10 flex items-center justify-center hover:bg-white/10 active:scale-90 transition-all">
            <span className="material-symbols-outlined text-2xl">arrow_back</span>
          </button>
          <div className="text-center">
            <h1 className="text-3xl font-black tracking-tighter italic uppercase text-transparent bg-clip-text bg-gradient-to-b from-white to-white/50">Level Selection</h1>
            <p className="text-[10px] font-black tracking-[0.4em] opacity-40 uppercase mt-1">Liquid Gems Journey</p>
          </div>
          <div className="w-14" />
        </div>

        {/* Levels Grid */}
        <div className="relative z-50 flex-1 w-full max-w-[1000px] overflow-y-auto px-10 pb-20 custom-scrollbar">
          <div className="grid grid-cols-2 sm:grid-cols-4 gap-8">
            {LEVELS.map((l, idx) => {
              const progress = sectionProgressMap[`match3_level_${l.id}`];
              const isPrevCompleted = idx === 0 || !!sectionProgressMap[`match3_level_${l.id - 1}`];
              const isLocked = !isPrevCompleted;

              return (
                <button
                  key={l.id}
                  disabled={isLocked}
                  onClick={() => startLevel(l.id)}
                  className={`aspect-square rounded-[36px] p-6 flex flex-col items-center justify-center relative border transition-all duration-500 ${isLocked ? 'bg-black/40 border-white/5 opacity-50' : 'bg-white/5 backdrop-blur-3xl border-white/15 hover:bg-white/10 hover:border-white/30 hover:-translate-y-2 active:scale-95'}`}
                >
                  {isLocked ? (
                    <span className="material-symbols-outlined text-4xl opacity-20">lock</span>
                  ) : (
                    <>
                      <div className="absolute top-4 right-4 text-[10px] font-black opacity-30">lvl {l.id}</div>
                      <span className="text-4xl font-black mb-1">{l.id}</span>
                      <span className="text-[10px] font-bold opacity-60 uppercase text-center leading-tight mb-4">{l.title}</span>
                      <div className="mt-auto w-full flex flex-col items-center gap-2">
                        <div className="text-[9px] font-black text-blue-400 bg-blue-400/10 px-3 py-1 rounded-full border border-blue-400/20">
                          {l.target.toLocaleString()} pts
                        </div>
                        {progress?.status === 'completed' && (
                          <span className="material-symbols-outlined text-green-400 text-lg">check_circle</span>
                        )}
                      </div>
                    </>
                  )}
                </button>
              );
            })}
          </div>
        </div>
      </div>
    );
  }

  // Render Game HUD & Grid
  return (
    <div className="fixed inset-0 z-[100] flex flex-col items-center select-none overflow-hidden bg-[#0a0a20] text-white font-sans">
      <div className="absolute inset-0 bg-gradient-to-b from-[#1a1a40] to-black opacity-80" />
      
      {/* Dynamic Background Blobs */}
      <div className="absolute top-[-10%] left-[-10%] w-[50%] h-[50%] bg-blue-600/10 rounded-full blur-[120px] animate-blob-1" />
      <div className="absolute bottom-[-10%] right-[-10%] w-[50%] h-[50%] bg-purple-600/10 rounded-full blur-[120px] animate-blob-2" />

      {/* Game Header */}
      <div className="w-full flex items-center justify-between px-10 py-6 z-50 backdrop-blur-2xl bg-white/5 border-b border-white/10">
        <button onClick={() => setStage('selector')} className="flex items-center gap-3 group">
          <div className="w-12 h-12 rounded-2xl bg-white/10 flex items-center justify-center group-active:scale-90 transition-transform">
            <span className="material-symbols-outlined text-2xl">grid_view</span>
          </div>
          <div>
            <p className="text-[10px] font-black opacity-40 uppercase tracking-widest">Stage {level.id}</p>
            <p className="font-black text-sm uppercase tracking-tighter">{level.title}</p>
          </div>
        </button>

        <div className="flex flex-col items-center flex-1">
          <div className="w-full max-w-[240px] h-3 bg-white/10 rounded-full overflow-hidden mb-2 border border-white/5">
            <div 
              className="h-full bg-gradient-to-r from-blue-400 to-indigo-500 shadow-[0_0_15px_rgba(59,130,246,0.5)] transition-all duration-700"
              style={{ width: `${Math.min(100, (score / level.target) * 100)}%` }}
            />
          </div>
          <p className="text-[11px] font-black uppercase tracking-widest">
            Target: <span className="text-blue-400">{score.toLocaleString()}</span> / {level.target.toLocaleString()}
          </p>
        </div>

        <button onClick={() => startLevel(currentLevelId)} className="w-12 h-12 rounded-2xl bg-white/10 flex items-center justify-center active:rotate-180 transition-transform duration-500 border border-white/5">
          <span className="material-symbols-outlined text-xl">refresh</span>
        </button>
      </div>

      {/* Hero Stats */}
      <div className="flex items-center gap-14 mt-10 mb-8 z-50">
        <div className="flex flex-col items-center">
          <span className="text-[11px] font-black text-white/30 uppercase tracking-[0.3em] mb-1">Score</span>
          <span className="text-6xl font-black tracking-tighter tabular-nums drop-shadow-2xl">
            {score.toLocaleString()}
          </span>
        </div>
        <div className="w-px h-16 bg-white/10" />
        <div className="flex flex-col items-center">
          <span className="text-[11px] font-black text-white/30 uppercase tracking-[0.3em] mb-1">Moves</span>
          <span className={`text-6xl font-black tracking-tighter tabular-nums ${moves <= 5 ? 'text-red-500 animate-pulse' : 'text-white/90'}`}>
            {moves}
          </span>
        </div>
      </div>

      {/* Combo Badge */}
      <div className={`h-14 flex items-center justify-center mb-8 z-50 transition-all duration-500 ${showCombo ? 'scale-110 opacity-100' : 'scale-75 opacity-0'}`}>
        <div className="px-8 py-2.5 rounded-3xl bg-gradient-to-r from-orange-400 via-red-500 to-pink-600 text-white font-black text-xl shadow-3xl shadow-red-500/40 border border-white/20 uppercase italic tracking-tighter">
          🔥 {combo}x COMBO!
        </div>
      </div>

      {/* Board Container */}
      <div className={`relative p-2 rounded-[44px] border border-white/15 shadow-4xl bg-white/5 backdrop-blur-[60px] ${isShaking ? 'animate-vibration' : ''}`}>
        <div 
          className="relative rounded-[36px] bg-black/30 overflow-hidden"
          style={{ width: gridPx + 24, height: gridPx + 24, padding: 12 }}
        >
          {/* Particles */}
          {particles.map(p => (
            <div
              key={p.id}
              className="absolute pointer-events-none rounded-full"
              style={{
                left: p.x + 12,
                top: p.y + 12,
                width: 8,
                height: 8,
                background: p.color,
                boxShadow: `0 0 15px ${p.color}`,
                animation: `burst 0.8s ease-out forwards`,
                '--tx': `${p.dx}px`,
                '--ty': `${p.dy}px`
              } as any}
            />
          ))}

          {/* Gems */}
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
                    ? `0 0 0 5px #fff, 0 0 40px ${gem.glow}` 
                    : `0 10px 20px -5px ${gem.glow}, inset 0 2px 6px rgba(255,255,255,0.4)`,
                  transform: cell.removing ? 'scale(0) rotate(180deg)' : isSelected ? 'scale(1.2)' : 'scale(1)',
                  opacity: cell.removing ? 0 : 1,
                  zIndex: isSelected ? 50 : 1,
                }}
              >
                <div className="absolute inset-x-2.5 top-2 h-1/2 bg-gradient-to-b from-white/40 to-transparent rounded-full opacity-60 pointer-events-none" />
              </div>
            );
          }))}

          {/* Popups */}
          {popups.map(p => (
            <div
              key={p.id}
              className="absolute pointer-events-none z-[100] font-black text-3xl drop-shadow-4xl flex items-center gap-1 tracking-tighter italic"
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

      {/* Result Screen */}
      {gameResult && (
        <div className="fixed inset-0 z-[300] flex items-center justify-center bg-black/85 backdrop-blur-3xl animate-fade-in px-8">
          <div className="w-full max-w-[450px] bg-white/5 border border-white/20 rounded-[56px] p-12 text-center shadow-5xl ring-1 ring-white/10">
            <div className={`w-28 h-28 rounded-[36px] flex items-center justify-center mx-auto mb-8 shadow-3xl ${gameResult === 'win' ? 'bg-gradient-to-br from-yellow-400 to-orange-500 shadow-orange-500/30' : 'bg-gradient-to-br from-red-500 to-pink-600 shadow-red-500/30'}`}>
              <span className="material-symbols-outlined text-white text-6xl">
                {gameResult === 'win' ? 'stars' : 'sentiment_very_dissatisfied'}
              </span>
            </div>
            
            <h3 className="text-4xl font-black text-white mb-2 uppercase tracking-tighter italic">
              {gameResult === 'win' ? 'LEVEL CLEARED!' : 'LEVEL FAILED'}
            </h3>
            <p className="text-white/40 text-[11px] font-black uppercase tracking-[0.3em] mb-10">
              Final Score: <span className="text-white">{score.toLocaleString()}</span>
            </p>

            <div className="flex flex-col gap-4">
              {gameResult === 'win' ? (
                <>
                   <div className="bg-white/10 rounded-3xl p-4 mb-2 flex items-center justify-center gap-4 border border-white/10">
                      <div className="flex flex-col items-center">
                        <span className="text-[10px] font-black text-blue-400 uppercase tracking-widest mb-1">XP Points</span>
                        <span className="text-xl font-black">+{level.reward}</span>
                      </div>
                      <div className="w-px h-8 bg-white/10" />
                      <div className="flex flex-col items-center">
                        <span className="text-[10px] font-black text-purple-400 uppercase tracking-widest mb-1">Stardust</span>
                        <span className="text-xl font-black">+1</span>
                      </div>
                   </div>
                   <button
                    onClick={() => {
                        if (currentLevelId < LEVELS.length) startLevel(currentLevelId + 1);
                        else setStage('selector');
                    }}
                    className="w-full py-6 bg-white text-black rounded-[28px] font-black text-xl active:scale-[0.96] transition-transform shadow-2xl"
                  >
                    NEXT LEVEL
                  </button>
                </>
              ) : (
                <button
                  onClick={() => startLevel(currentLevelId)}
                  className="w-full py-6 bg-white text-black rounded-[28px] font-black text-xl active:scale-[0.96] transition-transform shadow-2xl"
                >
                  RETRY LEVEL
                </button>
              )}
              <button
                onClick={() => setStage('selector')}
                className="w-full py-4 text-white/50 rounded-[28px] font-bold text-sm active:opacity-60 transition-opacity"
              >
                GO TO SELECTION
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
          0% { transform: scale(1.15, 0.85); }
          50% { transform: scale(0.9, 1.1); }
          100% { transform: scale(1, 1); }
        }
        @keyframes popup-float {
          0% { transform: translate(-50%, 0) scale(0.5); opacity: 0; }
          20% { transform: translate(-50%, -50px) scale(1.4); opacity: 1; }
          100% { transform: translate(-50%, -150px) scale(1); opacity: 0; }
        }
        @keyframes vibration {
          0%, 100% { transform: translate(0, 0) rotate(0); }
          25% { transform: translate(-5px, 5px) rotate(-1deg); }
          50% { transform: translate(5px, -5px) rotate(1deg); }
          75% { transform: translate(-3px, 3px) rotate(-0.5deg); }
        }
        @keyframes blob-rotate {
          0% { transform: translate(0, 0) rotate(0deg) scale(1); }
          50% { transform: translate(100px, 100px) rotate(180deg) scale(1.2); }
          100% { transform: translate(0, 0) rotate(360deg) scale(1); }
        }
        .animate-blob-rotate { animation: blob-rotate 40s linear infinite; }
        .animate-blob-rotate-slow { animation: blob-rotate 60s linear infinite reverse; }
        .animate-vibration { animation: vibration 0.4s ease-in-out; }
        .animate-land { animation: land 0.6s cubic-bezier(0.34, 1.56, 0.64, 1); }
        .custom-scrollbar::-webkit-scrollbar { width: 4px; }
        .custom-scrollbar::-webkit-scrollbar-thumb { background: rgba(255,255,255,0.1); border-radius: 10px; }
      `}</style>
    </div>
  );
};
