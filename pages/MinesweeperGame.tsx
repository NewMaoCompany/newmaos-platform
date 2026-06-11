import React, { useState, useEffect, useCallback } from 'react';
import { useNavigate } from 'react-router-dom';

type Cell = { row: number; col: number; isMine: boolean; isRevealed: boolean; isFlagged: boolean; neighborMines: number };

export const MinesweeperGame = () => {
  const navigate = useNavigate();
  const [board, setBoard] = useState<Cell[][]>([]);
  const [gameOver, setGameOver] = useState(false);
  const [gameWon, setGameWon] = useState(false);
  const [mineCount, setMineCount] = useState(10);
  const [rows] = useState(10);
  const [cols] = useState(10);
  const [bestTime, setBestTime] = useState<number | null>(null);
  const [time, setTime] = useState(0);
  const [isPlaying, setIsPlaying] = useState(false);

  useEffect(() => {
    const saved = localStorage.getItem('arcade_minesweeper_best');
    if (saved) setBestTime(parseInt(saved, 10));
  }, []);

  const initBoard = useCallback(() => {
    const newBoard: Cell[][] = Array.from({ length: rows }, (_, r) => 
      Array.from({ length: cols }, (_, c) => ({
        row: r, col: c, isMine: false, isRevealed: false, isFlagged: false, neighborMines: 0
      }))
    );

    let minesPlaced = 0;
    while (minesPlaced < mineCount) {
      const r = Math.floor(Math.random() * rows);
      const c = Math.floor(Math.random() * cols);
      if (!newBoard[r][c].isMine) {
        newBoard[r][c].isMine = true;
        minesPlaced++;
      }
    }

    for (let r = 0; r < rows; r++) {
      for (let c = 0; c < cols; c++) {
        if (!newBoard[r][c].isMine) {
          let count = 0;
          for (let dr = -1; dr <= 1; dr++) {
            for (let dc = -1; dc <= 1; dc++) {
              if (r+dr >= 0 && r+dr < rows && c+dc >= 0 && c+dc < cols && newBoard[r+dr][c+dc].isMine) {
                count++;
              }
            }
          }
          newBoard[r][c].neighborMines = count;
        }
      }
    }
    
    setBoard(newBoard);
    setGameOver(false);
    setGameWon(false);
    setTime(0);
    setIsPlaying(false);
  }, [rows, cols, mineCount]);

  useEffect(() => { initBoard(); }, [initBoard]);

  useEffect(() => {
    let interval: NodeJS.Timeout;
    if (isPlaying && !gameOver && !gameWon) {
      interval = setInterval(() => setTime(t => t + 1), 1000);
    }
    return () => clearInterval(interval);
  }, [isPlaying, gameOver, gameWon]);

  const revealCell = (r: number, c: number) => {
    if (gameOver || gameWon || board[r][c].isRevealed || board[r][c].isFlagged) return;
    if (!isPlaying) setIsPlaying(true);

    const newBoard = [...board.map(row => [...row])];
    
    if (newBoard[r][c].isMine) {
      // Game Over
      newBoard.forEach(row => row.forEach(cell => { if (cell.isMine) cell.isRevealed = true; }));
      setBoard(newBoard);
      setGameOver(true);
      setIsPlaying(false);
      return;
    }

    const revealEmpty = (row: number, col: number) => {
      if (row < 0 || row >= rows || col < 0 || col >= cols || newBoard[row][col].isRevealed) return;
      newBoard[row][col].isRevealed = true;
      if (newBoard[row][col].neighborMines === 0) {
        for (let dr = -1; dr <= 1; dr++) {
          for (let dc = -1; dc <= 1; dc++) {
            revealEmpty(row + dr, col + dc);
          }
        }
      }
    };

    revealEmpty(r, c);
    setBoard(newBoard);

    // Check Win
    let unrevealedSafe = 0;
    newBoard.forEach(row => row.forEach(cell => {
      if (!cell.isMine && !cell.isRevealed) unrevealedSafe++;
    }));
    if (unrevealedSafe === 0) {
      setGameWon(true);
      setIsPlaying(false);
      if (!bestTime || time < bestTime) {
        setBestTime(time);
        localStorage.setItem('arcade_minesweeper_best', time.toString());
      }
    }
  };

  const toggleFlag = (e: React.MouseEvent, r: number, c: number) => {
    e.preventDefault();
    if (gameOver || gameWon || board[r][c].isRevealed) return;
    const newBoard = [...board.map(row => [...row])];
    newBoard[r][c].isFlagged = !newBoard[r][c].isFlagged;
    setBoard(newBoard);
  };

  const flagsUsed = board.flat().filter(c => c.isFlagged).length;

  return (
    <div className="fixed inset-0 z-[110] flex flex-col items-center bg-[#0a0f0d] text-white font-sans select-none overflow-hidden">
      <div className="absolute inset-0 bg-[radial-gradient(ellipse_at_center,_var(--tw-gradient-stops))] from-[#132a21] via-[#0a0f0d] to-[#0a0f0d] opacity-80" />
      
      <div className="w-full flex items-center justify-between px-8 sm:px-16 py-6 z-50">
        <button onClick={() => navigate('/games')} className="w-12 h-12 rounded-full bg-white/5 border border-white/10 flex items-center justify-center hover:bg-white/10 active:scale-90 transition-all">
          <span className="material-symbols-outlined">arrow_back</span>
        </button>
        <div className="text-center">
          <h2 className="text-3xl font-black italic tracking-widest text-[#00ff88] drop-shadow-[0_0_15px_rgba(0,255,136,0.5)]">NEON MINES</h2>
          <div className="flex gap-4 justify-center mt-2 text-xs text-white/50 tracking-widest font-mono">
             <span>MINES: {mineCount - flagsUsed}</span>
             <span>TIME: {time}s</span>
          </div>
        </div>
        <div className="text-right flex flex-col items-end">
          <p className="text-xs text-white/50 tracking-widest uppercase">Record</p>
          <p className="text-xl font-bold tabular-nums text-[#00ff88] drop-shadow-[0_0_10px_rgba(0,255,136,0.5)]">{bestTime ? `${bestTime}s` : '--'}</p>
        </div>
      </div>

      <div className="flex-1 flex flex-col items-center justify-center w-full z-10 p-4">
        <div className="bg-white/5 backdrop-blur-xl rounded-xl border border-white/10 shadow-[0_0_40px_rgba(0,255,136,0.05)] p-4 sm:p-6 inline-block">
          {board.map((row, r) => (
            <div key={r} className="flex">
              {row.map((cell, c) => (
                <button
                  key={`${r}-${c}`}
                  onClick={() => revealCell(r, c)}
                  onContextMenu={(e) => toggleFlag(e, r, c)}
                  className={`w-8 h-8 sm:w-10 sm:h-10 m-[2px] rounded-md font-bold text-lg flex items-center justify-center transition-all ${
                    cell.isRevealed
                      ? cell.isMine 
                         ? 'bg-red-500/80 shadow-[0_0_15px_red] text-white'
                         : 'bg-white/10 border border-white/5 text-[#00ff88]'
                      : 'bg-white/20 hover:bg-white/30 border border-white/10 shadow-inner'
                  }`}
                  style={cell.isRevealed && cell.neighborMines > 0 && !cell.isMine ? { color: ['#00ff88', '#00e5ff', '#b000ff', '#ff00aa', '#ffaa00'][cell.neighborMines-1] || 'white' } : {}}
                >
                  {cell.isRevealed 
                    ? cell.isMine ? '💣' : (cell.neighborMines > 0 ? cell.neighborMines : '')
                    : cell.isFlagged ? '🚩' : ''}
                </button>
              ))}
            </div>
          ))}
        </div>

        {(gameOver || gameWon) && (
          <div className="mt-8 flex flex-col items-center animate-fade-in bg-black/50 p-6 rounded-2xl backdrop-blur-md border border-white/10">
            <h3 className={`text-3xl font-black tracking-widest mb-4 uppercase drop-shadow-lg ${gameWon ? 'text-[#00ff88]' : 'text-red-500'}`}>
              {gameWon ? 'SYSTEM CLEARED' : 'CRITICAL FAILURE'}
            </h3>
            <button onClick={initBoard} className="px-8 py-3 bg-white/10 border border-white/20 rounded-full hover:bg-white/20 transition-all uppercase tracking-widest text-sm font-bold">
              Restart Mission
            </button>
          </div>
        )}
      </div>
    </div>
  );
};
