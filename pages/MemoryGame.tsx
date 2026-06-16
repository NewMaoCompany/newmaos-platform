import React, { useState, useEffect, useCallback } from 'react';
import { useNavigate } from 'react-router-dom';
import { useApp } from '../AppContext';

export const MemoryGame = () => {
  const navigate = useNavigate();
  const { awardPoints, spendPoints, saveGameStats } = useApp();
  const [sequence, setSequence] = useState<number[]>([]);
  const [playerSequence, setPlayerSequence] = useState<number[]>([]);
  const [isPlaying, setIsPlaying] = useState(false);
  const [isShowingSequence, setIsShowingSequence] = useState(false);
  const [score, setScore] = useState(0);
  const [highScore, setHighScore] = useState(0);
  const [activeButton, setActiveButton] = useState<number | null>(null);
  const [gameOver, setGameOver] = useState(false);

  useEffect(() => {
    const saved = localStorage.getItem('arcade_memory_highscore');
    if (saved) setHighScore(parseInt(saved, 10));
  }, []);

  const saveHighScore = (newScore: number) => {
    if (newScore > highScore) {
      setHighScore(newScore);
      localStorage.setItem('arcade_memory_highscore', newScore.toString());
    }
  };

  const playSequence = useCallback(async (seq: number[]) => {
    setIsShowingSequence(true);
    for (let i = 0; i < seq.length; i++) {
      await new Promise(resolve => setTimeout(resolve, 500));
      setActiveButton(seq[i]);
      await new Promise(resolve => setTimeout(resolve, 500));
      setActiveButton(null);
    }
    setIsShowingSequence(false);
  }, []);

  const startGame = () => {
    const firstStep = Math.floor(Math.random() * 9);
    setSequence([firstStep]);
    setPlayerSequence([]);
    setScore(0);
    setGameOver(false);
    setIsPlaying(true);
    playSequence([firstStep]);
  };

  const handleStart = async () => {
    const res = await spendPoints(5, 'memory_game');
    if (!res.success) {
      alert("Not enough coins to play! (Cost: 5 Coins)");
      return;
    }
    startGame();
  };

  const handleButtonClick = (index: number) => {
    if (!isPlaying || isShowingSequence || gameOver) return;

    setActiveButton(index);
    setTimeout(() => setActiveButton(null), 200);

    const newPlayerSeq = [...playerSequence, index];
    setPlayerSequence(newPlayerSeq);

    const isCorrect = newPlayerSeq.every((val, i) => val === sequence[i]);

    if (!isCorrect) {
      setGameOver(true);
      setIsPlaying(false);
      saveHighScore(score);
      const earned = score > 3 ? Math.floor(score / 3) : 0;
      if (earned > 0) awardPoints(earned, 'Played Memory Matrix');
      saveGameStats('memory', { high_score: score, coins_earned: earned });
      return;
    }

    if (newPlayerSeq.length === sequence.length) {
      const newScore = score + 1;
      setScore(newScore);
      saveHighScore(newScore);
      setPlayerSequence([]);
      
      const nextSequence = [...sequence, Math.floor(Math.random() * 9)];
      setSequence(nextSequence);
      setTimeout(() => playSequence(nextSequence), 1000);
    }
  };

  return (
    <div className="fixed inset-0 z-[110] flex flex-col items-center bg-[#0B0F19] text-white font-sans select-none overflow-hidden">
      <div className="absolute inset-0 bg-[radial-gradient(ellipse_at_center,_var(--tw-gradient-stops))] from-[#1a233a] via-[#0B0F19] to-[#0B0F19] opacity-80" />
      
      <div className="w-full flex items-center justify-between px-8 sm:px-16 py-6 z-50">
        <button onClick={() => navigate('/games')} className="w-12 h-12 rounded-full bg-white/5 border border-white/10 flex items-center justify-center hover:bg-white/10 active:scale-90 transition-all">
          <span className="material-symbols-outlined">arrow_back</span>
        </button>
        <div className="text-center">
          <h2 className="text-3xl font-black italic tracking-widest text-[#00f2ff] drop-shadow-[0_0_15px_rgba(0,242,255,0.5)]">MEMORY MATRIX</h2>
          <p className="text-xs text-white/50 tracking-[0.3em] uppercase mt-1">Level {score}</p>
        </div>
        <div className="text-right">
          <p className="text-xs text-white/50 tracking-widest uppercase">Best</p>
          <p className="text-xl font-bold tabular-nums text-pink-500 drop-shadow-[0_0_10px_rgba(236,72,153,0.5)]">{highScore}</p>
        </div>
      </div>

      <div className="flex-1 flex flex-col items-center justify-center w-full z-10">
        <div className="grid grid-cols-3 gap-4 p-6 bg-white/5 backdrop-blur-md rounded-3xl border border-white/10 shadow-[0_0_50px_rgba(0,242,255,0.1)]">
          {[...Array(9)].map((_, i) => (
            <button
              key={i}
              onClick={() => handleButtonClick(i)}
              className={`w-20 h-20 sm:w-28 sm:h-28 rounded-2xl transition-all duration-200 ${
                activeButton === i 
                  ? 'bg-[#00f2ff] shadow-[0_0_30px_#00f2ff] scale-95' 
                  : 'bg-white/5 hover:bg-white/10 border border-white/10 shadow-inner'
              }`}
            />
          ))}
        </div>

        {!isPlaying && !gameOver && (
          <button onClick={handleStart} className="mt-12 px-12 py-4 bg-gradient-to-r from-[#00f2ff] to-[#ec4899] rounded-full font-black tracking-widest uppercase shadow-[0_0_20px_rgba(0,242,255,0.3)] hover:scale-105 active:scale-95 transition-all">
            Initialize Sequence (5 Coins)
          </button>
        )}

        {gameOver && (
          <div className="mt-8 flex flex-col items-center animate-fade-in">
            <h3 className="text-2xl font-bold text-red-500 mb-4 drop-shadow-[0_0_10px_rgba(239,68,68,0.5)]">SEQUENCE FAILED</h3>
            <button onClick={handleStart} className="px-8 py-3 border border-white/20 rounded-full hover:bg-white/10 transition-all uppercase tracking-widest text-sm">
              Reboot System (5 Coins)
            </button>
          </div>
        )}
      </div>
    </div>
  );
};
