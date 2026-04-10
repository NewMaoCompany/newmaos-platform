import React, { useState, useEffect, useCallback, useRef } from 'react';
import { useNavigate } from 'react-router-dom';
import { useApp } from '../AppContext';

type Tile = { id: number; value: number; row: number; col: number; mergedFrom?: Tile[] };

export const Game2048 = () => {
  const navigate = useNavigate();
  const { awardPoints } = useApp();
  const [board, setBoard] = useState<Tile[]>([]);
  const [score, setScore] = useState(0);
  const [gameOver, setGameOver] = useState(false);
  const [petals, setPetals] = useState<{ id: number; x: number; delay: number; duration: number; size: number }[]>([]);
  const nextIdRef = useRef(1);

  // Sakura Petals Generator
  useEffect(() => {
    const newPetals = Array.from({ length: 15 }).map((_, i) => ({
        id: i,
        x: Math.random() * 100,
        delay: Math.random() * 20,
        duration: 10 + Math.random() * 20,
        size: 8 + Math.random() * 20
    }));
    setPetals(newPetals);
  }, []);

  const spawnTile = useCallback((currentBoard: Tile[]) => {
    const occupied = new Set(currentBoard.map(t => `${t.row}-${t.col}`));
    const emptyPos = [];
    for (let r = 0; r < 4; r++) {
      for (let c = 0; c < 4; c++) {
        if (!occupied.has(`${r}-${c}`)) emptyPos.push({ r, c });
      }
    }
    if (emptyPos.length === 0) return currentBoard;
    const { r, c } = emptyPos[Math.floor(Math.random() * emptyPos.length)];
    const newTile: Tile = { id: nextIdRef.current++, value: Math.random() < 0.9 ? 2 : 4, row: r, col: c };
    return [...currentBoard, newTile];
  }, []);

  const initGame = useCallback(() => {
    let newBoard = spawnTile([]);
    newBoard = spawnTile(newBoard);
    setBoard(newBoard);
    setScore(0);
    setGameOver(false);
  }, [spawnTile]);

  useEffect(() => {
    initGame();
  }, [initGame]);

  const move = useCallback((direction: 'up' | 'down' | 'left' | 'right') => {
    if (gameOver) return;
    setBoard(prevBoard => {
      let moved = false;
      const newBoard: Tile[] = [];
      const scoreGain = { val: 0 };
      for (let i = 0; i < 4; i++) {
        const line = prevBoard.filter(t => (direction === 'left' || direction === 'right' ? t.row === i : t.col === i))
          .sort((a, b) => {
            const valA = direction === 'left' || direction === 'right' ? a.col : a.row;
            const valB = direction === 'left' || direction === 'right' ? b.col : b.row;
            return direction === 'left' || direction === 'up' ? valA - valB : valB - valA;
          });
        const newLine: Tile[] = [];
        for (let j = 0; j < line.length; j++) {
            const current = line[j];
            const next = line[j + 1];
            if (next && current.value === next.value) {
                newLine.push({ id: nextIdRef.current++, value: current.value * 2, row: 0, col: 0, mergedFrom: [current, next] });
                scoreGain.val += current.value * 2;
                j++;
                moved = true;
            } else {
                newLine.push({ ...current });
            }
        }
        newLine.forEach((tile, index) => {
            const finalPos = direction === 'left' || direction === 'up' ? index : 3 - index;
            if (direction === 'left' || direction === 'right') {
                if (tile.row !== i || tile.col !== finalPos) moved = true;
                tile.row = i; tile.col = finalPos;
            } else {
                if (tile.row !== finalPos || tile.col !== i) moved = true;
                tile.row = finalPos; tile.col = i;
            }
            newBoard.push(tile);
        });
      }
      if (!moved) return prevBoard;
      setScore(s => s + scoreGain.val);
      const withNew = spawnTile(newBoard);
      return withNew;
    });
  }, [gameOver, spawnTile]);

  useEffect(() => {
    const handleKey = (e: KeyboardEvent) => {
      if (e.key === 'ArrowUp') move('up');
      if (e.key === 'ArrowDown') move('down');
      if (e.key === 'ArrowLeft') move('left');
      if (e.key === 'ArrowRight') move('right');
    };
    window.addEventListener('keydown', handleKey);
    return () => window.removeEventListener('keydown', handleKey);
  }, [move]);

  const tileColors: Record<number, { bg: string, text: string, decoration: string }> = {
    2: { bg: '#F2ECE1', text: '#5D4037', decoration: 'rgba(93,64,55,0.05)' },
    4: { bg: '#E6D5C1', text: '#5D4037', decoration: 'rgba(93,64,55,0.08)' },
    8: { bg: '#C5B5A1', text: '#3E2723', decoration: 'rgba(255,255,255,0.2)' },
    16: { bg: '#8A7A6B', text: '#FAF9F6', decoration: 'rgba(255,255,255,0.1)' },
    32: { bg: '#728976', text: '#FAF9F6', decoration: 'rgba(255,255,255,0.1)' },
    64: { bg: '#506655', text: '#FAF9F6', decoration: 'rgba(255,255,255,0.15)' },
    128: { bg: '#A67B71', text: '#FAF9F6', decoration: 'rgba(255,255,255,0.1)' },
    256: { bg: '#8B5B4E', text: '#FAF9F6', decoration: 'rgba(0,0,0,0.1)' },
    512: { bg: '#4D3636', text: '#D7CCC8', decoration: 'rgba(255,100,100,0.1)' },
    1024: { bg: '#2D3436', text: '#E5E5E5', decoration: 'rgba(255,255,255,0.05)' },
    2048: { bg: '#1A1A1A', text: '#C5A059', decoration: 'rgba(197,160,89,0.2)' }
  };

  return (
    <div className="fixed inset-0 z-[110] flex flex-col items-center bg-[#F9F7F2] text-[#3E2723] font-serif overflow-hidden select-none">
      
      {/* Background Texture & Particles */}
      <div className="absolute inset-0 pointer-events-none opacity-[0.4] bg-[url('https://www.transparenttextures.com/patterns/pinstriped-suit.png')]" />
      <div className="absolute inset-0 pointer-events-none overflow-hidden">
         {petals.map(p => (
            <div 
                key={p.id}
                className="absolute bg-pink-200/40 rounded-full blur-[2px] animate-sakura-fall"
                style={{ 
                    left: `${p.x}%`, 
                    top: '-50px',
                    width: `${p.size}px`, 
                    height: `${p.size * 0.7}px`,
                    animationDelay: `${p.delay}s`,
                    animationDuration: `${p.duration}s`
                }}
            />
         ))}
      </div>

      {/* Header - Adaptive Layout */}
      <div className="w-full flex items-center justify-between px-8 sm:px-16 py-6 sm:py-12 z-50 shrink-0">
        <button 
            onClick={() => navigate('/games')} 
            className="group flex flex-col items-center gap-2 text-[#8D7B68] hover:text-[#3E2723] transition-all"
        >
          <div className="w-12 h-12 rounded-full border border-[#8D7B68]/30 flex items-center justify-center backdrop-blur-sm group-hover:bg-white/40 group-active:scale-90 transition-all">
             <span className="material-symbols-outlined font-light text-2xl">arrow_back</span>
          </div>
          <span className="text-[9px] font-black uppercase tracking-[0.4em] opacity-60">Restore</span>
        </button>
        
        <div className="text-center">
          <h2 className="text-3xl sm:text-5xl font-light italic text-[#3E2723] tracking-tighter drop-shadow-sm">Washi Fusion</h2>
          <div className="mt-4 flex flex-col items-center gap-1">
             <div className="h-[0.5px] w-12 bg-[#3E2723]/10" />
             <span className="text-xs font-bold tabular-nums opacity-60 mt-1">{score.toLocaleString()} Essence</span>
          </div>
        </div>
        
        <div className="hidden sm:flex flex-col items-end opacity-40">
           <span className="text-[10px] font-black uppercase tracking-[0.5em]">Session_01</span>
           <div className="h-[1px] w-full bg-[#3E2723]/20 mt-1" />
        </div>
      </div>

      {/* Game Field - Adaptive Responsive Container */}
      <div className="relative flex-1 w-full flex flex-col items-center justify-center p-6 min-h-0">
        <div 
          className="relative aspect-square w-full max-w-[min(90vw,calc(100vh-340px))] bg-white rounded-3xl shadow-[0_40px_100px_-20px_rgba(0,0,0,0.1),inset_0_2px_10px_rgba(0,0,0,0.02)] border-[12px] border-[#F2E8CF] overflow-hidden"
        >
          {/* Subtle Grid Lines */}
          <div className="absolute inset-0 grid grid-cols-4 grid-rows-4 gap-4 p-4 opacity-40">
             {[...Array(16)].map((_, i) => (
                <div key={i} className="bg-[#FAF9F6] border border-[#EBE3D5] rounded-xl" />
             ))}
          </div>

          <div className="absolute inset-[16px]">
            {board.map(tile => {
                const config = tileColors[tile.value] || tileColors[2048];
                return (
                    <div
                        key={tile.id}
                        className="absolute w-[22.5%] h-[22.5%] transition-all duration-[240ms] cubic-bezier(0.19, 1, 0.22, 1)"
                        style={{ left: `${tile.col * 25}%`, top: `${tile.row * 25}%` }}
                    >
                        <div 
                            className="w-full h-full rounded-xl flex flex-col items-center justify-center relative animate-washi-spawn overflow-hidden group shadow-md"
                            style={{ 
                                backgroundColor: config.bg,
                                color: config.text,
                                borderBottom: '3px solid rgba(0,0,0,0.08)'
                            }}
                        >
                            <span className="text-3xl sm:text-5xl font-light italic leading-none">{tile.value}</span>
                            
                            {/* Texture Decoration */}
                            <div className="absolute bottom-1 right-2 opacity-10 font-bold text-[8px] uppercase tracking-tighter">
                                {tile.value >= 128 ? 'Exalted' : 'Pristine'}
                            </div>
                            <div className="absolute inset-0 bg-gradient-to-br from-white/10 to-transparent pointer-events-none" />
                        </div>
                    </div>
                );
            })}
          </div>

          {/* Zen Game Over */}
          {gameOver && (
            <div className="absolute inset-0 z-50 flex flex-col items-center justify-center bg-[#F9F7F2]/90 backdrop-blur-md animate-fade-in p-10 text-center">
                <span className="text-[11px] font-black text-[#8D7B68] uppercase tracking-[0.6em] mb-4">Harmony Disturbed</span>
                <h3 className="text-4xl sm:text-6xl font-light italic text-[#3E2723] mb-12">The Cycle Concludes</h3>
                <button 
                   onClick={initGame}
                   className="px-14 py-5 border-[0.5px] border-[#3E2723]/30 rounded-full font-bold text-[10px] uppercase tracking-[0.4em] hover:bg-[#3E2723] hover:text-white transition-all shadow-sm active:scale-95"
                >
                   Begin Mediation
                </button>
            </div>
          )}
        </div>

        {/* Visual Swipe Icons - Minimalist */}
        <div className="mt-12 flex gap-12 opacity-10">
           <span className="material-symbols-outlined text-4xl">keyboard_arrow_up</span>
           <span className="material-symbols-outlined text-4xl">keyboard_arrow_left</span>
           <span className="material-symbols-outlined text-4xl">keyboard_arrow_down</span>
           <span className="material-symbols-outlined text-4xl">keyboard_arrow_right</span>
        </div>
      </div>

      <style>{`
        @keyframes washi-spawn {
            from { transform: scale(0.7) rotate(2deg); opacity: 0; filter: blur(5px); }
            to { transform: scale(1) rotate(0deg); opacity: 1; filter: blur(0); }
        }
        @keyframes sakura-fall {
            0% { transform: translateY(-50px) translateX(0) rotate(0deg); opacity: 0; }
            10% { opacity: 1; }
            100% { transform: translateY(110vh) translateX(100px) rotate(360deg); opacity: 0.2; }
        }
        .animate-sakura-fall { animation: sakura-fall linear infinite; }
        .animate-washi-spawn { animation: washi-spawn 0.45s cubic-bezier(0.175, 0.885, 0.32, 1.275); }
      `}</style>
    </div>
  );
};
