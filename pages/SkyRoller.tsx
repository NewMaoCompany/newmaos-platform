import React, { useEffect, useRef, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { useApp } from '../AppContext';

export const SkyRoller = () => {
    const navigate = useNavigate();
    const { spendPoints, awardPoints, saveGameStats } = useApp();
    const canvasRef = useRef<HTMLCanvasElement>(null);
    const [gameStarted, setGameStarted] = useState(false);
    const [gameOver, setGameOver] = useState(false);
    const [score, setScore] = useState(0);
    const [errorMsg, setErrorMsg] = useState<string | null>(null);

    const handleStart = async () => {
        setErrorMsg("Starting...");
        try {
            const res = await spendPoints(10, 'sky_roller');
            if (!res.success) {
                setErrorMsg(`Failed: ${res.reason || "Unknown error"}`);
                return;
            }
            setErrorMsg(null);
            setScore(0);
            setGameOver(false);
            setGameStarted(true);
        } catch (e: any) {
            setErrorMsg(`Exception: ${e.message}`);
        }
    };

    useEffect(() => {
        if (!gameStarted || gameOver) return;
        const canvas = canvasRef.current;
        if (!canvas) return;
        const ctx = canvas.getContext('2d');
        if (!ctx) return;

        canvas.width = window.innerWidth;
        canvas.height = window.innerHeight;

        let animationId: number;
        let distance = 0;
        let speed = 5;

        // Player state
        let playerX = 0; // -1 to 1 range (relative to center)
        let targetPlayerX = 0;

        const handleKeyDown = (e: KeyboardEvent) => {
            if (e.key === 'ArrowLeft' || e.key === 'a') targetPlayerX -= 0.5;
            if (e.key === 'ArrowRight' || e.key === 'd') targetPlayerX += 0.5;
            targetPlayerX = Math.max(-1, Math.min(1, targetPlayerX));
        };
        const handleTouch = (e: TouchEvent) => {
            const touch = e.touches[0];
            const half = window.innerWidth / 2;
            if (touch.clientX < half) targetPlayerX -= 0.5;
            else targetPlayerX += 0.5;
            targetPlayerX = Math.max(-1, Math.min(1, targetPlayerX));
        };

        window.addEventListener('keydown', handleKeyDown);
        window.addEventListener('touchstart', handleTouch);

        class Obstacle {
            x: number; z: number; width: number;
            constructor(z: number) {
                this.x = (Math.random() * 2 - 1) * 1.5; // -1.5 to 1.5
                this.z = z;
                this.width = Math.random() * 0.5 + 0.3;
            }
            update() {
                this.z -= speed * 0.01;
            }
        }

        const obstacles: Obstacle[] = [];
        for (let i = 0; i < 20; i++) {
            obstacles.push(new Obstacle(10 + i * 2));
        }

        const project = (x: number, y: number, z: number) => {
            const focalLength = 300;
            const scale = focalLength / (focalLength + z * 100);
            const px = (x * 300 * scale) + canvas!.width / 2;
            const py = canvas!.height / 2 + (y * 300 * scale) + (100 * scale); // fake horizon
            return { x: px, y: py, scale };
        };

        const animate = () => {
            animationId = requestAnimationFrame(animate);
            ctx!.clearRect(0, 0, canvas!.width, canvas!.height);
            
            // Sky gradient
            const grad = ctx!.createLinearGradient(0, 0, 0, canvas!.height);
            grad.addColorStop(0, '#0a0a2a');
            grad.addColorStop(0.5, '#1a1a4a');
            grad.addColorStop(1, '#ff0055');
            ctx!.fillStyle = grad;
            ctx!.fillRect(0, 0, canvas!.width, canvas!.height);

            // Ground grid
            ctx!.strokeStyle = 'rgba(0, 242, 255, 0.2)';
            ctx!.lineWidth = 2;
            ctx!.beginPath();
            const horizonY = canvas!.height / 2;
            for(let i = -5; i <= 5; i++) {
                const p1 = project(i, 1, 0);
                const p2 = project(i, 1, 50);
                ctx!.moveTo(p1.x, p1.y);
                ctx!.lineTo(p2.x, p2.y);
            }
            for(let z = 0; z < 50; z += 2) {
                const p1 = project(-5, 1, (z - (distance * 0.01) % 2));
                const p2 = project(5, 1, (z - (distance * 0.01) % 2));
                ctx!.moveTo(p1.x, p1.y);
                ctx!.lineTo(p2.x, p2.y);
            }
            ctx!.stroke();

            // Smooth player movement
            playerX += (targetPlayerX - playerX) * 0.2;

            // Draw player (Ball)
            const playerPos = project(playerX, 0.5, 1);
            ctx!.beginPath();
            ctx!.arc(playerPos.x, playerPos.y, 20 * playerPos.scale, 0, Math.PI * 2);
            ctx!.fillStyle = '#00f2ff';
            ctx!.shadowBlur = 20;
            ctx!.shadowColor = '#00f2ff';
            ctx!.fill();
            ctx!.shadowBlur = 0;

            // Draw obstacles
            // Sort by Z to draw back to front
            obstacles.sort((a, b) => b.z - a.z);

            let hit = false;
            obstacles.forEach(obs => {
                obs.update();
                if (obs.z < 1) {
                    obs.z += 40;
                    obs.x = (Math.random() * 2 - 1) * 1.5;
                }
                
                // Collision check
                if (obs.z > 0.8 && obs.z < 1.2 && Math.abs(playerX - obs.x) < (obs.width / 2 + 0.2)) {
                    hit = true;
                }

                if (obs.z > 0) {
                    const pTopLeft = project(obs.x - obs.width/2, -0.5, obs.z);
                    const pBottomRight = project(obs.x + obs.width/2, 1, obs.z);
                    
                    ctx!.fillStyle = '#ff9500';
                    ctx!.fillRect(pTopLeft.x, pTopLeft.y, pBottomRight.x - pTopLeft.x, pBottomRight.y - pTopLeft.y);
                    ctx!.strokeStyle = '#fff';
                    ctx!.strokeRect(pTopLeft.x, pTopLeft.y, pBottomRight.x - pTopLeft.x, pBottomRight.y - pTopLeft.y);
                }
            });

            distance += speed;
            speed += 0.001; // accelerate
            
            if (hit) {
                cancelAnimationFrame(animationId);
                setGameOver(true);
                const finalScore = Math.floor(distance / 10);
                setScore(finalScore);
                const earned = Math.floor(finalScore / 100);
                if (earned > 0) awardPoints(earned, 'Played Sky Roller');
                saveGameStats('sky_roller', { high_score: finalScore, coins_earned: earned });
            } else {
                setScore(Math.floor(distance / 10));
            }
        };

        animate();

        return () => {
            cancelAnimationFrame(animationId);
            window.removeEventListener('keydown', handleKeyDown);
            window.removeEventListener('touchstart', handleTouch);
        };
    }, [gameStarted, gameOver, awardPoints, saveGameStats]);

    return (
        <div className="fixed inset-0 z-[110] bg-[#0a0a2a] overflow-hidden select-none">
            <canvas ref={canvasRef} className="block w-full h-full" />

            <button onClick={() => navigate('/games')} className="absolute top-6 left-6 z-50 w-12 h-12 rounded-full bg-white/10 flex items-center justify-center hover:bg-white/20 active:scale-95 transition-all backdrop-blur-md">
                <span className="material-symbols-outlined text-white">arrow_back</span>
            </button>

            {gameStarted && !gameOver && (
                <div className="absolute top-6 right-6 flex flex-col items-end pointer-events-none">
                    <span className="text-[10px] font-black uppercase tracking-[0.4em] text-white/50">Distance</span>
                    <span className="text-4xl font-black text-white drop-shadow-[0_0_10px_#ff9500] tabular-nums">{score}m</span>
                </div>
            )}

            {!gameStarted && !gameOver && (
                <div className="absolute inset-0 z-50 flex flex-col items-center justify-center bg-black/60 backdrop-blur-md pointer-events-auto">
                    <h1 className="text-6xl sm:text-8xl font-black italic text-transparent bg-clip-text bg-gradient-to-b from-[#ff9500] to-[#ff0055] drop-shadow-[0_0_30px_#ff9500] mb-4 uppercase tracking-tighter">Sky Roller</h1>
                    <p className="text-white/60 text-sm tracking-widest uppercase mb-12 max-w-md text-center leading-relaxed">
                        Dodge the obstacles. Use Left/Right arrows or tap sides of screen to move.
                    </p>
                    {errorMsg && <p className="text-red-500 mb-4 font-bold bg-black/50 px-4 py-2 rounded border border-red-500/50">{errorMsg}</p>}
                    <button onClick={handleStart} className="px-14 py-5 bg-gradient-to-r from-[#ff9500] to-[#ff0055] text-white font-black uppercase tracking-[0.4em] rounded-full hover:scale-105 active:scale-95 transition-all shadow-[0_0_40px_rgba(255,149,0,0.4)]">
                        Launch Sequence (10 Coins)
                    </button>
                </div>
            )}

            {gameOver && (
                <div className="absolute inset-0 z-50 flex flex-col items-center justify-center bg-[#ff9500]/10 backdrop-blur-lg pointer-events-auto animate-fade-in border-[2px] border-[#ff9500]/30">
                    <h2 className="text-5xl font-black italic text-white drop-shadow-[0_0_20px_#ff9500] mb-4 uppercase tracking-tighter">Crash Landing</h2>
                    <div className="bg-black/40 px-10 py-6 rounded-3xl border border-white/20 mb-10 flex flex-col items-center">
                        <span className="text-[10px] font-black uppercase tracking-[0.3em] text-[#ff9500] mb-2">Distance Covered</span>
                        <span className="text-5xl font-black text-white tabular-nums">{score}m</span>
                    </div>
                    <button onClick={handleStart} className="px-14 py-5 bg-white text-black font-black uppercase tracking-[0.4em] rounded-full hover:scale-105 active:scale-95 transition-all shadow-[0_0_30px_rgba(255,255,255,0.3)]">
                        Retry Jump (10 Coins)
                    </button>
                </div>
            )}
        </div>
    );
};
