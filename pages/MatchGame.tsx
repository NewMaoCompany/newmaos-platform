import React, { useState, useEffect, useCallback, useRef } from 'react';
import { useApp } from '../AppContext';

const GRID_SIZE = 8;
const BASE_CELL_SIZE = 48;
const GAP = 6;

const LEVELS = [
  { id: 1, target: 800, moves: 30, reward: 50, title: 'Prism Start' },
  { id: 2, target: 2000, moves: 25, reward: 100, title: 'Iridescent' },
  { id: 3, target: 4500, moves: 22, reward: 200, title: 'Neon Flux' },
  { id: 4, target: 6000, moves: 20, reward: 400, title: 'Rainbow Tide' },
  { id: 5, target: 8500, moves: 18, reward: 800, title: 'Chroma Core' },
  { id: 6, target: 12000, moves: 18, reward: 1200, title: 'Prismatic Rain' },
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

type Cell = { type: number; id: number; removing?: boolean; falling?: boolean; isNew?: boolean };
type PropType = 'hammer' | 'prism' | 'shuffle' | null;

let cellIdCounter = 0;
const newCell = (type: number): Cell => ({ type, id: cellIdCounter++, removing: false });
const randomType = () => Math.floor(Math.random() * GEMS.length);

const createBoard = (): Cell[][] => {
  const board: Cell[][] = [];
  for (let r = 0; r < GRID_SIZE; r++) {
    board[r] = [];
    for (let c = 0; c < GRID_SIZE; c++) {
      let t: number;
      do { t = randomType(); } while (
        (c >= 2 && board[r][c - 1].type === t && board[r][c - 2].type === t) ||
        (r >= 2 && board[r - 1][c].type === t && board[r - 2][c].type === t)
      );
      board[r][c] = newCell(t);
    }
  }
  return board;
};

const cloneBoard = (b: Cell[][]): Cell[][] => b.map(row => row.map(cell => ({ ...cell })));

export const MatchGame = ({ onBack }: { onBack: () => void }) => {
  const { awardPoints, saveSectionProgress, sectionProgressMap } = useApp();
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
  
  // Props
  const [activeProp, setActiveProp] = useState<PropType>(null);
  const [propCounts, setPropCounts] = useState<Record<string, number>>({ hammer: 1, prism: 1, shuffle: 1 });
  
  const particleId = useRef(0);
  const popupId = useRef(0);
  const level = LEVELS.find(l => l.id === currentLevelId) || LEVELS[0];

  const addParticles = useCallback((row: number, col: number, color: string) => {
    const newParticles = Array.from({ length: 12 }, () => ({
      id: particleId.current++,
      x: col * 12.5 + 6.25,
      y: row * 12.5 + 6.25,
      color,
      dx: (Math.random() - 0.5) * 40,
      dy: (Math.random() - 0.5) * 40,
      size: Math.random() * 4 + 2,
    }));
    setParticles(prev => [...prev, ...newParticles]);
    setTimeout(() => setParticles(prev => prev.filter(p => !newParticles.find(np => np.id === p.id))), 800);
  }, []);

  const addScorePopup = useCallback((row: number, col: number, text: string, color: string) => {
    const id = popupId.current++;
    setPopups(prev => [...prev, { id, x: col * 12.5 + 6.25, y: row * 12.5 + 6.25, text, color }]);
    setTimeout(() => setPopups(prev => prev.filter(p => p.id !== id)), 1000);
  }, []);

  const findMatches = (b: Cell[][]) => {
    const matched = Array.from({ length: GRID_SIZE }, () => Array(GRID_SIZE).fill(false));
    for (let r = 0; r < GRID_SIZE; r++)
      for (let c = 0; c < GRID_SIZE - 2; c++)
        if (b[r][c].type >= 0 && b[r][c].type === b[r][c+1].type && b[r][c].type === b[r][c+2].type) matched[r][c] = matched[r][c+1] = matched[r][c+2] = true;
    for (let c = 0; c < GRID_SIZE; c++)
      for (let r = 0; r < GRID_SIZE - 2; r++)
        if (b[r][c].type >= 0 && b[r][c].type === b[r+1][c].type && b[r][c].type === b[r+2][c].type) matched[r][c] = matched[r+1][c] = matched[r+2][c] = true;
    return matched;
  };

  const processBoard = useCallback(async (b: Cell[][], comboCount: number = 0) => {
    const matched = findMatches(b);
    let count = 0;
    for(let r=0; r<GRID_SIZE; r++) for(let c=0; c<GRID_SIZE; c++) if(matched[r][c]) count++;
    
    if (count === 0) { setAnimating(false); setCombo(0); return; }

    const newCombo = comboCount + 1;
    const points = count * 25 * newCombo;
    setCombo(newCombo);
    setIsFlashActive(true);
    setIsShaking(true);
    setTimeout(() => { setIsFlashActive(false); setIsShaking(false); }, 300);
    
    if (newCombo > 1) { setShowCombo(true); setTimeout(() => setShowCombo(false), 800); }

    const nb = cloneBoard(b);
    let avgR = 0, avgC = 0, firstCol = '#fff';
    for(let r=0; r<GRID_SIZE; r++) for(let c=0; c<GRID_SIZE; c++) if(matched[r][c]) {
      nb[r][c].removing = true;
      addParticles(r, c, GEMS[b[r][c].type]?.color || '#fff');
      avgR += r; avgC += c;
      if (firstCol === '#fff') firstCol = GEMS[b[r][c].type]?.color;
    }
    setBoard(nb);
    addScorePopup(avgR/count, avgC/count, `+${points}`, firstCol);
    await new Promise(res => setTimeout(res, 400));
    setScore(s => s + points);

    // Cascade
    const afterCascade = cloneBoard(nb);
    for (let c = 0; c < GRID_SIZE; c++) {
      let wr = GRID_SIZE - 1;
      for (let r = GRID_SIZE - 1; r >= 0; r--) if (!afterCascade[r][c].removing) {
        if (wr !== r) { afterCascade[wr][c] = { ...afterCascade[r][c], falling: true }; afterCascade[r][c] = newCell(-1); }
        wr--;
      }
      for (let r = wr; r >= 0; r--) afterCascade[r][c] = { ...newCell(randomType()), isNew: true };
    }
    setBoard(afterCascade);
    await new Promise(res => setTimeout(res, 400));
    
    const final = cloneBoard(afterCascade);
    final.forEach(r => r.forEach(c => { c.falling = c.isNew = c.removing = false; }));
    setBoard(final);
    processBoard(final, newCombo);
  }, [addParticles, addScorePopup]);

  const swap = useCallback((r1: number, c1: number, r2: number, c2: number) => {
    if (animating || gameResult) return;
    const nb = cloneBoard(board);
    [nb[r1][c1], nb[r2][c2]] = [nb[r2][c2], nb[r1][c1]];
    if (countMatched(findMatches(nb)) > 0) {
      setAnimating(true); setBoard(nb); setMoves(m => m - 1); setSelected(null);
      setTimeout(() => processBoard(nb, 0), 200);
    } else {
      setAnimating(true); setBoard(nb); setSelected(null);
      setTimeout(() => { setBoard(board); setAnimating(false); }, 300);
    }
  }, [board, animating, gameResult, processBoard]);

  const handleCellClick = useCallback((r: number, c: number) => {
    if (animating || gameResult) return;
    if (activeProp === 'hammer') {
       setAnimating(true); setPropCounts(p => ({ ...p, hammer: p.hammer - 1 })); setActiveProp(null);
       const nb = cloneBoard(board); nb[r][c].removing = true; setBoard(nb);
       addParticles(r, c, GEMS[nb[r][c].type].color);
       setTimeout(() => processBoard(nb, 0), 400);
       return;
    }
    if (selected) {
      const [sr, sc] = selected;
      if (Math.abs(sr - r) + Math.abs(sc - c) === 1) swap(sr, sc, r, c); else setSelected([r, c]);
    } else setSelected([r, c]);
  }, [selected, animating, gameResult, swap, activeProp, board, addParticles, processBoard]);

  const startLevel = (id: number) => {
    setCurrentLevelId(id); setBoard(createBoard()); setScore(0);
    setMoves(LEVELS.find(l => l.id === id)!.moves); setGameResult(null); setStage('game'); setPropCounts({ hammer: 1, prism: 1, shuffle: 1 });
  };

  useEffect(() => {
    if (score >= level.target && !animating && !gameResult) {
      setGameResult('win'); awardPoints(level.reward, 'game_win', `match3_${currentLevelId}`, 'Cleared Match 3');
      saveSectionProgress(`match3_lvl_${currentLevelId}`, { completed: 1 });
    } else if (moves <= 0 && score < level.target && !animating && !gameResult) setGameResult('lose');
  }, [score, moves, animating, level, gameResult, currentLevelId, awardPoints, saveSectionProgress]);

  const countMatched = (m: boolean[][]) => m.flat().filter(x => x).length;

  return (
    <div className="fixed inset-0 z-[110] flex flex-col items-center bg-[#fdfdff] text-black font-sans select-none overflow-hidden">
      {/* Premium Rainbow Background */}
      <div className="absolute inset-0 opacity-20 animate-rainbow-fade shadow-inner" style={{ background: RAINBOW_GRADIENT, backgroundSize: '400% 400%' }} />
      <div className="absolute top-[-15%] left-[-15%] w-[60%] h-[60%] bg-blue-200 rounded-full blur-[140px] animate-blob-morph" />
      <div className="absolute bottom-[-10%] right-[-10%] w-[50%] h-[50%] bg-pink-200 rounded-full blur-[130px] animate-blob-morph-alt" />

      {/* Stage Logic */}
      {stage === 'selector' ? (
        <div className="w-full h-full flex flex-col items-center z-50">
           <Header title="Game Library" onBack={onBack} />
           <div className="flex-1 w-full max-w-4xl px-8 flex items-center justify-center">
              <div className="grid grid-cols-2 sm:grid-cols-3 gap-8">
                 {LEVELS.map(l => (
                    <button key={l.id} onClick={() => startLevel(l.id)} className="w-32 h-32 sm:w-40 sm:h-40 rounded-[48px] bg-white/60 backdrop-blur-3xl border border-white flex flex-col items-center justify-center hover:scale-105 transition-all shadow-xl group">
                       <span className="text-3xl font-black mb-1 italic opacity-80">{l.id}</span>
                       <span className="text-[10px] font-bold uppercase tracking-widest opacity-40">{l.title}</span>
                       <div className="mt-4 px-3 py-1 rounded-full bg-blue-500 text-white text-[9px] font-black">{l.target} PT</div>
                    </button>
                 ))}
              </div>
           </div>
        </div>
      ) : (
        <div className="w-full h-full flex flex-col items-center z-50">
           <div className="w-full flex items-center justify-between px-10 py-8 shrink-0">
              <button onClick={() => setStage('selector')} className="w-12 h-12 rounded-2xl bg-white/50 border border-white flex items-center justify-center active:scale-90 transition-all shadow-lg">
                 <span className="material-symbols-outlined text-black font-bold">west</span>
              </button>
              <div className="text-center">
                 <h2 className="text-2xl font-black uppercase tracking-tighter italic text-transparent bg-clip-text bg-gradient-to-r from-blue-600 to-pink-600">Prism Level {level.id}</h2>
                 <div className="flex items-center gap-2 mt-1">
                    <div className="w-32 h-2 bg-black/5 rounded-full overflow-hidden border border-white/50">
                       <div className="h-full bg-gradient-to-r from-blue-500 to-indigo-500 transition-all duration-700" style={{ width: `${Math.min(100, (score/level.target)*100)}%` }} />
                    </div>
                    <span className="text-[10px] font-black opacity-30">{score}/{level.target}</span>
                 </div>
              </div>
              <div className="w-12" />
           </div>

           <div className="flex-1 w-full flex flex-col items-center justify-center min-h-0 p-4">
              <div className="mb-6 flex gap-12 sm:gap-20">
                 <Stat label="Moves" val={moves} color={moves <= 5 ? '#ff3b30' : '#000'} />
                 <Stat label="Score" val={score} color="#007aff" />
              </div>

              {/* Adaptive Board Container */}
              <div className={`relative aspect-square w-full max-w-[min(90vw,calc(100vh-420px))] bg-white/40 backdrop-blur-3xl border-[1px] border-white/60 rounded-[42px] shadow-2xl p-2 transition-transform ${isShaking ? 'animate-vibration' : ''}`}>
                 <div className="relative w-full h-full rounded-[38px] overflow-hidden bg-white/10">
                    {particles.map(p => (
                       <div key={p.id} className="absolute pointer-events-none rounded-sm bg-blue-500" style={{ left: `${p.x}%`, top: `${p.y}%`, width: p.size, height: p.size, background: RAINBOW_GRADIENT, filter: `drop-shadow(0 0 5px ${p.color})`, animation: `gem-burst 0.8s ease-out forwards`, '--dx': `${p.dx}%`, '--dy': `${p.dy}%` } as any} />
                    ))}
                    {board.map((row, r) => row.map((cell, c) => {
                       const gem = GEMS[cell.type]; if (!gem) return null;
                       const isSelected = selected?.[0] === r && selected?.[1] === c;
                       return (
                          <div key={cell.id} onClick={() => handleCellClick(r, c)} className={`absolute w-[12.5%] h-[12.5%] p-[1px] cursor-pointer transition-all duration-500 ${cell.falling ? 'animate-land' : ''}`} style={{ left: `${c * 12.5}%`, top: `${r * 12.5}%`, opacity: cell.removing ? 0 : 1, transform: cell.removing ? 'scale(0) rotate(180deg)' : isSelected ? 'scale(1.15)' : 'scale(1)', zIndex: isSelected ? 50 : 1 }}>
                             <div className="w-full h-full rounded-2xl relative shadow-md" style={{ background: gem.gradient, border: isSelected ? '3px solid white' : 'none', boxShadow: isSelected ? `0 0 30px ${gem.glow}` : 'none' }}>
                                <div className="absolute inset-0 bg-gradient-to-tr from-black/20 to-transparent rounded-2xl" />
                                <div className="absolute top-1 left-2 w-2 h-2 bg-white/40 rounded-full blur-[1px]" />
                             </div>
                          </div>
                    )}))}
                    {popups.map(p => (
                       <div key={p.id} className="absolute z-[100] font-black text-xl italic pointer-events-none animate-popup" style={{ left: `${p.x}%`, top: `${p.y}%`, color: p.color }}>{p.text}</div>
                    ))}
                 </div>
              </div>

              {/* Prop Bar */}
              <div className="mt-8 flex gap-6">
                 <button onClick={() => setActiveProp(activeProp==='hammer' ? null : 'hammer')} className={`w-14 h-14 rounded-2xl flex items-center justify-center transition-all ${activeProp==='hammer' ? 'bg-black text-white' : 'bg-white/60 border border-white text-black'}`}>
                    <span className="material-symbols-outlined">handyman</span>
                 </button>
              </div>
           </div>

           {gameResult && (
              <div className="absolute inset-0 z-[200] flex items-center justify-center bg-white/40 backdrop-blur-2xl p-10">
                 <div className="bg-white/95 rounded-[52px] border-4 border-white p-12 text-center shadow-3xl w-full max-w-sm">
                    <h3 className="text-5xl font-black italic uppercase tracking-tighter mb-4 text-transparent bg-clip-text bg-gradient-to-r from-blue-600 to-pink-600">{gameResult==='win' ? 'Pristine' : 'Fractured'}</h3>
                    <div className="text-2xl font-black mb-10 tabular-nums">{score} PTS</div>
                    <button onClick={() => gameResult==='win' ? (currentLevelId < LEVELS.length ? startLevel(currentLevelId+1) : setStage('selector')) : startLevel(currentLevelId)} className="w-full py-5 bg-black text-white rounded-[28px] font-black text-xl active:scale-95 transition-all">
                       {gameResult==='win' ? 'CONTINUE' : 'RESTORE'}
                    </button>
                 </div>
              </div>
           )}
        </div>
      )}

      <style>{`
        @keyframes rainbow-fade { 0% { background-position: 0% 50%; } 50% { background-position: 100% 50%; } 100% { background-position: 0% 50%; } }
        @keyframes blob-morph { 0%, 100% { border-radius: 60% 40% 30% 70% / 60% 30% 70% 40%; transform: rotate(0deg); } 50% { border-radius: 30% 60% 70% 40% / 50% 60% 30% 60%; transform: rotate(5deg); } }
        @keyframes gem-burst { 0% { transform: translate(0, 0) scale(1); opacity: 1; } 100% { transform: translate(var(--dx), var(--dy)) scale(0); opacity: 0; } }
        @keyframes land { 0% { transform: scale(1.3, 0.7); } 50% { transform: scale(0.8, 1.2); } 100% { transform: scale(1, 1); } }
        @keyframes popup { 0% { transform: translate(-50%, 0) scale(0.5); opacity: 0; } 20% { opacity: 1; } 100% { transform: translate(-50%, -100px) scale(1.5); opacity: 0; } }
        @keyframes vibration { 0%, 100% { transform: translate(0, 0); } 25% { transform: translate(-4px, 4px); } 50% { transform: translate(4px, -4px); } 75% { transform: translate(-2px, 2px); } }
        .animate-rainbow-fade { animation: rainbow-fade 12s linear infinite; }
        .animate-leak { animation: leak 4s infinite alternate ease-in-out; }
        .animate-vibration { animation: vibration 0.3s ease-in-out; }
        .animate-land { animation: land 0.5s cubic-bezier(0.18, 0.89, 0.32, 1.28); }
        .animate-popup { animation: popup 1s ease-out forwards; }
      `}</style>
    </div>
  );
};

const Header = ({ title, onBack }: any) => (
  <div className="w-full flex items-center justify-between px-10 py-10">
    <button onClick={onBack} className="w-14 h-14 rounded-3xl bg-white/40 border border-white flex items-center justify-center hover:bg-white shadow-xl transition-all">
       <span className="material-symbols-outlined text-black font-bold">west</span>
    </button>
    <div className="text-center">
       <h1 className="text-4xl font-black italic uppercase tracking-tighter text-transparent bg-clip-text bg-gradient-to-r from-blue-600 via-purple-600 to-pink-500">{title}</h1>
    </div>
    <div className="w-14" />
  </div>
);

const Stat = ({ label, val, color }: any) => (
   <div className="flex flex-col items-center">
      <span className="text-[10px] font-black uppercase tracking-widest opacity-30 mb-1">{label}</span>
      <span className="text-4xl sm:text-6xl font-black tracking-tighter tabular-nums" style={{ color }}>{val}</span>
   </div>
);
