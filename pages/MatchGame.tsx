import React, { useState, useEffect, useCallback, useRef } from 'react';

const GRID_SIZE = 8;
const CELL_SIZE = 44;
const GAP = 4;

const GEMS = [
  { emoji: '🔴', color: '#FF3B30', glow: 'rgba(255,59,48,0.4)' },
  { emoji: '🟠', color: '#FF9500', glow: 'rgba(255,149,0,0.4)' },
  { emoji: '🟡', color: '#FFD60A', glow: 'rgba(255,214,10,0.4)' },
  { emoji: '🟢', color: '#34C759', glow: 'rgba(52,199,89,0.4)' },
  { emoji: '🔵', color: '#007AFF', glow: 'rgba(0,122,255,0.4)' },
  { emoji: '🟣', color: '#AF52DE', glow: 'rgba(175,82,222,0.4)' },
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

  // Horizontal
  for (let r = 0; r < GRID_SIZE; r++) {
    for (let c = 0; c < GRID_SIZE - 2; c++) {
      const t = board[r][c].type;
      if (t >= 0 && board[r][c + 1].type === t && board[r][c + 2].type === t) {
        matched[r][c] = matched[r][c + 1] = matched[r][c + 2] = true;
      }
    }
  }

  // Vertical
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
  const [particles, setParticles] = useState<{ id: number; x: number; y: number; color: string }[]>([]);
  const [popups, setPopups] = useState<{ id: number; x: number; y: number; text: string; color: string }[]>([]);
  const [isShaking, setIsShaking] = useState(false);
  const particleId = useRef(0);
  const popupId = useRef(0);
  const boardRef = useRef<HTMLDivElement>(null);

  // Touch drag state
  const touchStart = useRef<{ r: number; c: number; x: number; y: number } | null>(null);

  const addParticles = useCallback((row: number, col: number, color: string) => {
    const newParticles = Array.from({ length: 6 }, () => ({
      id: particleId.current++,
      x: col * (CELL_SIZE + GAP) + CELL_SIZE / 2,
      y: row * (CELL_SIZE + GAP) + CELL_SIZE / 2,
      color,
    }));
    setParticles(prev => [...prev, ...newParticles]);
    setTimeout(() => {
      setParticles(prev => prev.filter(p => !newParticles.find(np => np.id === p.id)));
    }, 600);
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
    }, 1000);
  }, []);

  const processBoard = useCallback(async (b: Cell[][], comboCount: number = 0) => {
    const matched = findMatches(b);
    if (!hasAnyMatch(matched)) {
      setAnimating(false);
      setCombo(0);
      return;
    }

    const newCombo = comboCount + 1;
    const points = matchCount * 10 * newCombo;
    setCombo(newCombo);
    setIsShaking(true);
    setTimeout(() => setIsShaking(false), 200);
    
    if (newCombo > 1) {
      setShowCombo(true);
      setTimeout(() => setShowCombo(false), 800);
    }

    // Add score popup at center of match
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

    // Mark removing
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

    // Wait for remove animation
    await new Promise(res => setTimeout(res, 300));

    setScore(prev => prev + points);

    // Gravity: drop cells down
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
      // Fill empty cells at top
      for (let r = writeRow; r >= 0; r--) {
        afterRemove[r][c] = { ...newCell(randomType()), isNew: true };
      }
    }
    setBoard(afterRemove);

    // Wait for fall animation
    await new Promise(res => setTimeout(res, 350));

    // Clear animation flags
    const clean = cloneBoard(afterRemove);
    for (let r = 0; r < GRID_SIZE; r++) {
      for (let c = 0; c < GRID_SIZE; c++) {
        clean[r][c].falling = false;
        clean[r][c].isNew = false;
        clean[r][c].removing = false;
      }
    }
    setBoard(clean);

    // Cascade
    processBoard(clean, newCombo);
  }, [addParticles]);

  const swap = useCallback((r1: number, c1: number, r2: number, c2: number) => {
    if (animating || gameOver) return;
    if (r2 < 0 || r2 >= GRID_SIZE || c2 < 0 || c2 >= GRID_SIZE) return;
    const dr = Math.abs(r1 - r2);
    const dc = Math.abs(c1 - c2);
    if (dr + dc !== 1) return;

    const nb = cloneBoard(board);
    [nb[r1][c1], nb[r2][c2]] = [nb[r2][c2], nb[r1][c1]];

    const matched = findMatches(nb);
    if (hasAnyMatch(matched)) {
      setAnimating(true);
      setBoard(nb);
      setMoves(prev => prev - 1);
      setSelected(null);
      setTimeout(() => processBoard(nb, 0), 200);
    } else {
      // Invalid swap: visually swap then swap back
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
      if (sr === r && sc === c) {
        setSelected(null);
        return;
      }
      swap(sr, sc, r, c);
    } else {
      setSelected([r, c]);
    }
  }, [selected, animating, gameOver, swap]);

  // Touch handling for swipe gestures
  const handleTouchStart = useCallback((r: number, c: number, e: React.TouchEvent) => {
    if (animating || gameOver) return;
    const touch = e.touches[0];
    touchStart.current = { r, c, x: touch.clientX, y: touch.clientY };
  }, [animating, gameOver]);

  const handleTouchEnd = useCallback((e: React.TouchEvent) => {
    if (!touchStart.current || animating || gameOver) return;
    const touch = e.changedTouches[0];
    const dx = touch.clientX - touchStart.current.x;
    const dy = touch.clientY - touchStart.current.y;
    const { r, c } = touchStart.current;
    touchStart.current = null;

    const threshold = 20;
    if (Math.abs(dx) < threshold && Math.abs(dy) < threshold) {
      handleCellClick(r, c);
      return;
    }

    let tr = r, tc = c;
    if (Math.abs(dx) > Math.abs(dy)) {
      tc = dx > 0 ? c + 1 : c - 1;
    } else {
      tr = dy > 0 ? r + 1 : r - 1;
    }
    swap(r, c, tr, tc);
  }, [animating, gameOver, handleCellClick, swap]);

  // Check game over
  useEffect(() => {
    if (moves <= 0 && !animating) {
      setGameOver(true);
    }
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
    <div
      className="fixed inset-0 z-[100] flex flex-col items-center select-none overflow-hidden"
      style={{
        background: 'linear-gradient(180deg, #0a0a1a 0%, #1a1040 40%, #2d1b69 100%)',
      }}
    >
      <div className="absolute inset-0 mesh-liquid opacity-30 pointer-events-none"></div>

      {/* Header */}
      <div className="w-full flex items-center justify-between px-4 pt-[env(safe-area-inset-top,12px)] pb-3 bg-white/5 backdrop-blur-xl border-b border-white/10 z-50">
        <button
          onClick={onBack}
          className="flex items-center gap-1 text-white/70 active:text-white transition-colors px-2 py-2"
        >
          <span className="material-symbols-outlined text-xl">arrow_back_ios</span>
          <span className="text-sm font-semibold">Back</span>
        </button>
        <h2 className="text-white font-bold text-lg tracking-tight" style={{ fontFamily: '-apple-system, BlinkMacSystemFont, "SF Pro Display", sans-serif' }}>
          Match 3
        </h2>
        <button
          onClick={resetGame}
          className="text-white/50 active:text-white transition-colors px-2 py-2"
        >
          <span className="material-symbols-outlined text-xl">refresh</span>
        </button>
      </div>

      {/* Score & Moves */}
      <div className="flex items-center justify-center gap-6 px-6 py-3 mb-4">
        <div className="flex flex-col items-center">
          <span className="text-white/50 text-[10px] font-bold uppercase tracking-widest">Score</span>
          <span className="text-white text-3xl font-black tabular-nums" style={{ fontFamily: '-apple-system, BlinkMacSystemFont, sans-serif' }}>
            {score.toLocaleString()}
          </span>
        </div>
        <div className="w-px h-10 bg-white/10" />
        <div className="flex flex-col items-center">
          <span className="text-white/50 text-[10px] font-bold uppercase tracking-widest">Moves</span>
          <span className={`text-3xl font-black tabular-nums ${moves <= 5 ? 'text-red-400' : 'text-white'}`} style={{ fontFamily: '-apple-system, BlinkMacSystemFont, sans-serif' }}>
            {moves}
          </span>
        </div>
      </div>

      {/* Combo indicator */}
      <div className={`h-8 flex items-center justify-center mb-2 transition-all duration-300 ${showCombo ? 'opacity-100 scale-100' : 'opacity-0 scale-75'}`}>
        {combo > 1 && (
          <div className="px-4 py-1 rounded-full bg-gradient-to-r from-yellow-400 to-orange-500 text-white font-black text-sm shadow-lg shadow-orange-500/30 animate-bounce">
            🔥 {combo}x COMBO!
          </div>
        )}
      </div>

      {/* Board */}
      <div
        ref={boardRef}
        className={`relative rounded-[32px] p-4 ${isShaking ? 'animate-liquid-shake' : ''}`}
        style={{
          width: gridPx + 32,
          height: gridPx + 32,
          background: 'rgba(255,255,255,0.03)',
          border: '1px solid rgba(255,255,255,0.1)',
          boxShadow: '0 20px 50px -10px rgba(0,0,0,0.5), inset 0 0 20px rgba(255,255,255,0.05)',
          backdropFilter: 'blur(30px)',
        }}
      >
        {/* Particles */}
        {particles.map(p => (
          <div
            key={p.id}
            className="absolute pointer-events-none"
            style={{
              left: p.x + 12,
              top: p.y + 12,
              width: 6,
              height: 6,
              borderRadius: '50%',
              background: p.color,
              boxShadow: `0 0 8px ${p.color}`,
              animation: `particle-burst 0.6s ease-out forwards`,
              transform: `translate(${(Math.random() - 0.5) * 60}px, ${(Math.random() - 0.5) * 60}px)`,
              opacity: 0,
            }}
          />
        ))}

        {/* Score Popups */}
        {popups.map(p => (
          <div
            key={p.id}
            className="absolute pointer-events-none z-50 font-black text-lg text-white drop-shadow-[0_2px_4px_rgba(0,0,0,0.5)] flex items-center gap-1"
            style={{
              left: p.x + 12,
              top: p.y + 12,
              transform: 'translate(-50%, -50%)',
              animation: 'score-float 1s ease-out forwards',
              color: p.color
            }}
          >
            {p.text}
          </div>
        ))}

        {/* Grid cells */}
        {board.map((row, r) =>
          row.map((cell, c) => {
            const isSelected = selected && selected[0] === r && selected[1] === c;
            const gem = GEMS[cell.type];
            if (!gem) return null;

            return (
              <div
                key={cell.id}
                onClick={() => handleCellClick(r, c)}
                onTouchStart={(e) => handleTouchStart(r, c, e)}
                onTouchEnd={handleTouchEnd}
                className="absolute flex items-center justify-center cursor-pointer touch-manipulation"
                style={{
                  width: CELL_SIZE,
                  height: CELL_SIZE,
                  left: c * (CELL_SIZE + GAP) + 12,
                  top: r * (CELL_SIZE + GAP) + 12,
                  borderRadius: 12,
                  background: cell.removing
                    ? 'transparent'
                    : `radial-gradient(circle at 35% 35%, ${gem.color}ee, ${gem.color}88)`,
                  boxShadow: isSelected
                    ? `0 0 0 3px #fff, 0 0 20px ${gem.glow}`
                    : cell.removing
                      ? 'none'
                      : `0 2px 8px ${gem.glow}, inset 0 1px 2px rgba(255,255,255,0.3)`,
                  transform: cell.removing
                    ? 'scale(0)'
                    : isSelected
                      ? 'scale(1.1)'
                      : 'scale(1)',
                  opacity: cell.removing ? 0 : 1,
                  transition: cell.removing
                    ? 'transform 0.25s cubic-bezier(0.4,0,1,1), opacity 0.25s ease'
                    : cell.isNew
                      ? 'top 0.3s cubic-bezier(0.34,1.56,0.64,1), opacity 0.2s ease'
                      : 'transform 0.15s ease, box-shadow 0.15s ease, top 0.3s cubic-bezier(0.34,1.56,0.64,1)',
                  zIndex: isSelected ? 10 : 1,
                }}
              >
                <span
                  style={{
                    fontSize: 24,
                    filter: cell.removing ? 'blur(4px)' : 'none',
                    transition: 'filter 0.2s',
                    lineHeight: 1,
                  }}
                >
                  {gem.emoji}
                </span>
                {/* Shine effect */}
                <div
                  className="absolute inset-0 rounded-[12px] pointer-events-none"
                  style={{
                    background: 'linear-gradient(135deg, rgba(255,255,255,0.3) 0%, transparent 50%)',
                  }}
                />
              </div>
            );
          })
        )}
      </div>

      {/* Game Over Overlay */}
      {gameOver && (
        <div className="fixed inset-0 z-[200] flex items-center justify-center bg-black/70 backdrop-blur-xl animate-fade-in">
          <div className="bg-white/10 backdrop-blur-2xl rounded-[28px] p-8 max-w-[320px] w-full mx-4 text-center border border-white/15 shadow-2xl">
            <div className="text-6xl mb-4">🎮</div>
            <h3 className="text-2xl font-black text-white mb-1">Game Over!</h3>
            <p className="text-white/60 text-sm mb-2">Final Score</p>
            <p className="text-5xl font-black text-transparent bg-clip-text bg-gradient-to-r from-yellow-300 to-orange-400 mb-6">
              {score.toLocaleString()}
            </p>
            <div className="flex flex-col gap-3">
              <button
                onClick={resetGame}
                className="w-full py-3.5 bg-gradient-to-r from-blue-500 to-blue-600 text-white rounded-2xl font-bold text-[15px] active:scale-[0.97] transition-transform shadow-lg shadow-blue-500/30"
              >
                Play Again
              </button>
              <button
                onClick={onBack}
                className="w-full py-3 text-white/60 rounded-2xl font-medium text-[15px] active:opacity-60 transition-opacity"
              >
                Back to Lobby
              </button>
            </div>
          </div>
        </div>
      )}

      {/* Inline CSS for particle animation */}
      <style>{`
        @keyframes particle-burst {
          0% {
            opacity: 1;
            transform: translate(0, 0) scale(1);
          }
          100% {
            opacity: 0;
            transform: translate(var(--tx, 30px), var(--ty, -30px)) scale(0);
          }
        }
        @keyframes pulse-liquid-gem {
          0%, 100% { transform: scale(1); filter: brightness(1); }
          50% { transform: scale(1.02); filter: brightness(1.2); }
        }
        @keyframes score-float {
          0% { transform: translate(-50%, -20%) scale(0.5); opacity: 0; }
          20% { transform: translate(-50%, -100%) scale(1.2); opacity: 1; }
          100% { transform: translate(-50%, -250%) scale(1); opacity: 0; }
        }
        @keyframes liquid-shake {
          0%, 100% { transform: translate(0, 0); }
          25% { transform: translate(-2px, 2px); }
          50% { transform: translate(2px, -2px); }
          75% { transform: translate(-1px, -1px); }
        }
        .animate-liquid-shake {
          animation: liquid-shake 0.2s ease-in-out;
        }
        .animate-fade-in {
          animation: fadeIn 0.3s ease-out;
        }
        @keyframes fadeIn {
          from { opacity: 0; }
          to { opacity: 1; }
        }
      `}</style>
    </div>
  );
};
