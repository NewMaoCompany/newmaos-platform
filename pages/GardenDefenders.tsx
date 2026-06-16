import React, { useEffect, useRef, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { useApp } from '../AppContext';

export const GardenDefenders = () => {
    const navigate = useNavigate();
    const { spendPoints, awardPoints, saveGameStats } = useApp();
    const canvasRef = useRef<HTMLCanvasElement>(null);
    const [gameStarted, setGameStarted] = useState(false);
    const [gameOver, setGameOver] = useState(false);
    const [score, setScore] = useState(0);

    const handleStart = async () => {
        const res = await spendPoints(15, 'garden_defenders');
        if (!res.success) {
            alert(`Failed to start: ${res.reason || "Unknown error"}`);
            return;
        }
        setScore(0);
        setGameOver(false);
        setGameStarted(true);
    };

    useEffect(() => {
        if (!gameStarted || gameOver) return;
        const canvas = canvasRef.current;
        if (!canvas) return;
        const ctx = canvas.getContext('2d');
        if (!ctx) return;

        canvas.width = 900;
        canvas.height = 600;

        const cellSize = 100;
        const cellGap = 3;
        const topBarHeight = 80;
        
        let sun = 300;
        let scoreCount = 0;
        let frames = 0;
        let animationId: number;

        const mouse = { x: -1, y: -1, clicked: false };

        const handleMouseMove = (e: MouseEvent) => { 
            const rect = canvas.getBoundingClientRect();
            mouse.x = e.clientX - rect.left; 
            mouse.y = e.clientY - rect.top; 
        };
        const handleMouseDown = () => { mouse.clicked = true; };
        const handleMouseUp = () => { mouse.clicked = false; };

        canvas.addEventListener('mousemove', handleMouseMove);
        canvas.addEventListener('mousedown', handleMouseDown);
        canvas.addEventListener('mouseup', handleMouseUp);
        canvas.addEventListener('mouseleave', () => { mouse.x = -1; mouse.y = -1; });

        class Cell {
            x: number; y: number; width: number; height: number;
            constructor(x: number, y: number) {
                this.x = x; this.y = y; this.width = cellSize; this.height = cellSize;
            }
            draw() {
                if (mouse.x && mouse.y && 
                    mouse.x >= this.x && mouse.x <= this.x + this.width &&
                    mouse.y >= this.y && mouse.y <= this.y + this.height) {
                    ctx!.fillStyle = 'rgba(255, 255, 255, 0.1)';
                    ctx!.fillRect(this.x, this.y, this.width, this.height);
                }
                ctx!.strokeStyle = 'rgba(255, 255, 255, 0.05)';
                ctx!.strokeRect(this.x, this.y, this.width, this.height);
            }
        }

        const gameGrid: Cell[] = [];
        for(let y = topBarHeight; y < canvas.height; y += cellSize) {
            for(let x = 0; x < canvas.width; x += cellSize) {
                gameGrid.push(new Cell(x, y));
            }
        }

        class Defender {
            x: number; y: number; health = 100; timer = 0;
            constructor(x: number, y: number) { this.x = x; this.y = y; }
            draw() {
                ctx!.fillStyle = '#34c759';
                ctx!.beginPath();
                ctx!.roundRect(this.x + 20, this.y + 20, cellSize - 40, cellSize - 40, 15);
                ctx!.fill();
                ctx!.fillStyle = '#fff';
                ctx!.font = '20px sans-serif';
                ctx!.fillText(Math.floor(this.health).toString(), this.x + 35, this.y + 80);
            }
            update() {
                this.timer++;
                if (this.timer % 100 === 0) {
                    projectiles.push(new Projectile(this.x + 70, this.y + 50));
                }
                this.draw();
            }
        }

        class Enemy {
            x: number; y: number; health = 100; speed = Math.random() * 0.4 + 0.4 + (scoreCount * 0.01); width = cellSize - 40; height = cellSize - 40;
            constructor(y: number) { this.x = canvas!.width; this.y = y; }
            draw() {
                ctx!.fillStyle = '#ff3b30';
                ctx!.beginPath();
                ctx!.roundRect(this.x, this.y + 20, this.width, this.height, 10);
                ctx!.fill();
                ctx!.fillStyle = '#fff';
                ctx!.font = '20px sans-serif';
                ctx!.fillText(Math.floor(this.health).toString(), this.x + 35, this.y + 80);
            }
            update() {
                this.x -= this.speed;
                this.draw();
            }
        }

        class Projectile {
            x: number; y: number; speed = 5; power = 20; radius = 10;
            constructor(x: number, y: number) { this.x = x; this.y = y; }
            draw() {
                ctx!.fillStyle = '#00f2ff';
                ctx!.beginPath();
                ctx!.arc(this.x, this.y, this.radius, 0, Math.PI * 2);
                ctx!.fill();
            }
            update() {
                this.x += this.speed;
                this.draw();
            }
        }

        class Resource {
            x: number; y: number; amount = 25; width = 30; height = 30;
            constructor(x: number, y: number) { this.x = x; this.y = y; }
            draw() {
                ctx!.fillStyle = '#ffcc00';
                ctx!.beginPath();
                ctx!.arc(this.x + 15, this.y + 15, 15, 0, Math.PI * 2);
                ctx!.fill();
                ctx!.shadowBlur = 10;
                ctx!.shadowColor = '#ffcc00';
                ctx!.stroke();
                ctx!.shadowBlur = 0;
            }
            update() {
                this.draw();
            }
        }

        const defenders: Defender[] = [];
        const enemies: Enemy[] = [];
        const projectiles: Projectile[] = [];
        const resources: Resource[] = [];

        const animate = () => {
            ctx!.clearRect(0, 0, canvas!.width, canvas!.height);
            
            ctx!.fillStyle = '#0a100d';
            ctx!.fillRect(0, 0, canvas!.width, canvas!.height);

            // Top Bar
            ctx!.fillStyle = '#132a21';
            ctx!.fillRect(0, 0, canvas!.width, topBarHeight);
            ctx!.fillStyle = '#ffcc00';
            ctx!.font = '30px sans-serif font-black italic';
            ctx!.fillText(`SUN: ${sun}`, 20, 50);
            ctx!.fillStyle = '#fff';
            ctx!.fillText(`SCORE: ${scoreCount}`, 250, 50);

            gameGrid.forEach(cell => cell.draw());

            // Add Defender
            if (mouse.clicked && mouse.y > topBarHeight && sun >= 100) {
                const gridX = mouse.x - (mouse.x % cellSize);
                const gridY = mouse.y - (mouse.y % cellSize);
                const isOccupied = defenders.some(d => d.x === gridX && d.y === gridY);
                if (!isOccupied) {
                    defenders.push(new Defender(gridX, gridY));
                    sun -= 100;
                }
                mouse.clicked = false;
            }

            // Collect Resource
            if (mouse.clicked) {
                resources.forEach((res, i) => {
                    if (mouse.x >= res.x && mouse.x <= res.x + res.width && mouse.y >= res.y && mouse.y <= res.y + res.height) {
                        sun += res.amount;
                        resources.splice(i, 1);
                        mouse.clicked = false;
                    }
                });
            }

            defenders.forEach((defender, i) => {
                defender.update();
                let enemyAttacking = false;
                enemies.forEach(enemy => {
                    if (enemy.y === defender.y && enemy.x < defender.x + cellSize && enemy.x > defender.x) {
                        enemyAttacking = true;
                        enemy.x = defender.x + cellSize; // block movement
                        defender.health -= 0.2;
                    }
                });
                if (defender.health <= 0) defenders.splice(i, 1);
            });

            projectiles.forEach((proj, i) => {
                proj.update();
                let hit = false;
                enemies.forEach((enemy, j) => {
                    if (proj.y > enemy.y && proj.y < enemy.y + cellSize && proj.x > enemy.x && proj.x < enemy.x + enemy.width) {
                        enemy.health -= proj.power;
                        hit = true;
                        if (enemy.health <= 0) {
                            enemies.splice(j, 1);
                            scoreCount += 10;
                            setScore(scoreCount);
                        }
                    }
                });
                if (hit || proj.x > canvas!.width) projectiles.splice(i, 1);
            });

            enemies.forEach((enemy, i) => {
                enemy.update();
                if (enemy.x < 0) {
                    cancelAnimationFrame(animationId);
                    setGameOver(true);
                    setScore(scoreCount);
                    const earned = Math.floor(scoreCount / 10);
                    if (earned > 0) awardPoints(earned, 'Played Garden Defenders');
                    saveGameStats('garden_defenders', { high_score: scoreCount, coins_earned: earned });
                }
            });

            resources.forEach(res => res.update());

            if (frames % Math.max(60, 200 - Math.floor(scoreCount / 50)) === 0) {
                const y = Math.floor(Math.random() * 5 + 1) * cellSize - 20; // adjust offset based on layout
                enemies.push(new Enemy(y));
            }
            if (frames % 300 === 0) {
                resources.push(new Resource(Math.random() * (canvas!.width - 30), Math.random() * (canvas!.height - topBarHeight - 30) + topBarHeight));
            }

            frames++;
            animationId = requestAnimationFrame(animate);
        };

        animate();

        return () => {
            cancelAnimationFrame(animationId);
            canvas.removeEventListener('mousemove', handleMouseMove);
            canvas.removeEventListener('mousedown', handleMouseDown);
            canvas.removeEventListener('mouseup', handleMouseUp);
        };
    }, [gameStarted, gameOver, saveGameStats, awardPoints]);

    return (
        <div className="fixed inset-0 z-[110] bg-[#0a100d] flex items-center justify-center select-none overflow-hidden">
            
            <button onClick={() => navigate('/games')} className="absolute top-6 left-6 z-50 w-12 h-12 rounded-full bg-white/10 flex items-center justify-center hover:bg-white/20 active:scale-95 transition-all backdrop-blur-md">
                <span className="material-symbols-outlined text-white">arrow_back</span>
            </button>

            <div className="relative shadow-[0_0_50px_rgba(52,199,89,0.2)] border border-white/10 rounded-xl overflow-hidden">
                <canvas ref={canvasRef} className="block cursor-crosshair bg-black" style={{ width: 900, height: 600 }} />
                
                {!gameStarted && !gameOver && (
                    <div className="absolute inset-0 z-50 flex flex-col items-center justify-center bg-black/80 backdrop-blur-sm">
                        <h1 className="text-6xl font-black italic text-transparent bg-clip-text bg-gradient-to-br from-[#34c759] to-[#00f2ff] drop-shadow-[0_0_20px_#34c759] mb-4 uppercase tracking-tighter">Garden Defenders</h1>
                        <p className="text-white/60 text-sm tracking-widest uppercase mb-12 max-w-md text-center leading-relaxed">
                            Plant defenders to stop the neon bugs. Collect suns to plant. Cost: 100 Sun per defender.
                        </p>
                        <button onClick={handleStart} className="px-14 py-5 bg-[#34c759] text-black font-black uppercase tracking-[0.4em] rounded-full hover:scale-105 active:scale-95 transition-all shadow-[0_0_30px_rgba(52,199,89,0.3)]">
                            Protect Garden (15 Coins)
                        </button>
                    </div>
                )}

                {gameOver && (
                    <div className="absolute inset-0 z-50 flex flex-col items-center justify-center bg-[#ff3b30]/10 backdrop-blur-md border-[2px] border-[#ff3b30]/40 animate-pulse">
                        <h2 className="text-5xl font-black italic text-white drop-shadow-[0_0_20px_#ff3b30] mb-4 uppercase tracking-tighter">Core Breached</h2>
                        <div className="bg-black/60 px-8 py-4 rounded-2xl border border-white/10 mb-10 flex flex-col items-center">
                            <span className="text-[10px] font-black uppercase tracking-[0.3em] text-white/50 mb-1">Final Score</span>
                            <span className="text-4xl font-black text-white tabular-nums">{score}</span>
                        </div>
                        <button onClick={handleStart} className="px-14 py-5 bg-white text-black font-black uppercase tracking-[0.4em] rounded-full hover:scale-105 active:scale-95 transition-all shadow-[0_0_30px_rgba(255,255,255,0.3)]">
                            Retry Defense (15 Coins)
                        </button>
                    </div>
                )}
            </div>
        </div>
    );
};
