import React, { useEffect, useRef, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { useApp } from '../AppContext';

export const NeonKnight = () => {
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
            const res = await spendPoints(15, 'neon_knight');
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

        const keys: Record<string, boolean> = {};
        const mouse = { x: canvas.width / 2, y: canvas.height / 2 };

        const handleKeyDown = (e: KeyboardEvent) => { keys[e.key.toLowerCase()] = true; };
        const handleKeyUp = (e: KeyboardEvent) => { keys[e.key.toLowerCase()] = false; };
        const handleMouseMove = (e: MouseEvent) => { mouse.x = e.clientX; mouse.y = e.clientY; };

        window.addEventListener('keydown', handleKeyDown);
        window.addEventListener('keyup', handleKeyUp);
        window.addEventListener('mousemove', handleMouseMove);

        class Player {
            x = canvas!.width / 2;
            y = canvas!.height / 2;
            radius = 15;
            color = '#00f2ff';
            speed = 5;
            health = 100;

            draw() {
                ctx!.beginPath();
                ctx!.arc(this.x, this.y, this.radius, 0, Math.PI * 2);
                ctx!.fillStyle = this.color;
                ctx!.shadowBlur = 20;
                ctx!.shadowColor = this.color;
                ctx!.fill();
                ctx!.shadowBlur = 0;

                // Health bar
                ctx!.fillStyle = 'red';
                ctx!.fillRect(this.x - 20, this.y + 25, 40, 5);
                ctx!.fillStyle = '#00ff88';
                ctx!.fillRect(this.x - 20, this.y + 25, (this.health / 100) * 40, 5);
            }

            update() {
                if (keys['w'] || keys['arrowup']) this.y -= this.speed;
                if (keys['s'] || keys['arrowdown']) this.y += this.speed;
                if (keys['a'] || keys['arrowleft']) this.x -= this.speed;
                if (keys['d'] || keys['arrowright']) this.x += this.speed;

                this.x = Math.max(this.radius, Math.min(canvas!.width - this.radius, this.x));
                this.y = Math.max(this.radius, Math.min(canvas!.height - this.radius, this.y));
                this.draw();
            }
        }

        class Projectile {
            x: number; y: number; radius = 4; color = '#ff0055'; velocity: {x: number, y: number};
            constructor(x: number, y: number, velocity: {x: number, y: number}) {
                this.x = x; this.y = y; this.velocity = velocity;
            }
            draw() {
                ctx!.beginPath();
                ctx!.arc(this.x, this.y, this.radius, 0, Math.PI * 2);
                ctx!.fillStyle = this.color;
                ctx!.shadowBlur = 10;
                ctx!.shadowColor = this.color;
                ctx!.fill();
                ctx!.shadowBlur = 0;
            }
            update() {
                this.x += this.velocity.x;
                this.y += this.velocity.y;
                this.draw();
            }
        }

        class Enemy {
            x: number; y: number; radius: number; color = '#AF52DE'; velocity: {x: number, y: number}; speed: number;
            constructor(x: number, y: number, radius: number, speed: number) {
                this.x = x; this.y = y; this.radius = radius; this.speed = speed; this.velocity = {x:0, y:0};
            }
            draw() {
                ctx!.beginPath();
                ctx!.arc(this.x, this.y, this.radius, 0, Math.PI * 2);
                ctx!.fillStyle = this.color;
                ctx!.shadowBlur = 15;
                ctx!.shadowColor = this.color;
                ctx!.fill();
                ctx!.shadowBlur = 0;
            }
            update(px: number, py: number) {
                const angle = Math.atan2(py - this.y, px - this.x);
                this.velocity.x = Math.cos(angle) * this.speed;
                this.velocity.y = Math.sin(angle) * this.speed;
                this.x += this.velocity.x;
                this.y += this.velocity.y;
                this.draw();
            }
        }

        class Particle {
            x: number; y: number; radius: number; color: string; velocity: {x: number, y: number}; alpha = 1;
            constructor(x: number, y: number, radius: number, color: string, velocity: {x: number, y: number}) {
                this.x = x; this.y = y; this.radius = radius; this.color = color; this.velocity = velocity;
            }
            draw() {
                ctx!.save();
                ctx!.globalAlpha = this.alpha;
                ctx!.beginPath();
                ctx!.arc(this.x, this.y, this.radius, 0, Math.PI * 2);
                ctx!.fillStyle = this.color;
                ctx!.fill();
                ctx!.restore();
            }
            update() {
                this.x += this.velocity.x;
                this.y += this.velocity.y;
                this.alpha -= 0.02;
                this.draw();
            }
        }

        const player = new Player();
        const projectiles: Projectile[] = [];
        const enemies: Enemy[] = [];
        const particles: Particle[] = [];

        let animationId: number;
        let scoreCount = 0;
        let frames = 0;
        let lastShot = 0;

        const handleMouseClick = () => {
            const now = Date.now();
            if (now - lastShot < 150) return;
            lastShot = now;
            const angle = Math.atan2(mouse.y - player.y, mouse.x - player.x);
            const velocity = { x: Math.cos(angle) * 12, y: Math.sin(angle) * 12 };
            projectiles.push(new Projectile(player.x, player.y, velocity));
        };
        window.addEventListener('mousedown', handleMouseClick);

        const spawnEnemies = () => {
            const radius = Math.random() * 10 + 10;
            let x, y;
            if (Math.random() < 0.5) {
                x = Math.random() < 0.5 ? 0 - radius : canvas!.width + radius;
                y = Math.random() * canvas!.height;
            } else {
                x = Math.random() * canvas!.width;
                y = Math.random() < 0.5 ? 0 - radius : canvas!.height + radius;
            }
            const speed = Math.random() * 2 + 1 + (scoreCount * 0.01);
            enemies.push(new Enemy(x, y, radius, speed));
        };

        const animate = () => {
            animationId = requestAnimationFrame(animate);
            ctx!.fillStyle = 'rgba(5, 5, 10, 0.3)';
            ctx!.fillRect(0, 0, canvas!.width, canvas!.height);
            
            // Grid background
            ctx!.strokeStyle = 'rgba(0, 242, 255, 0.05)';
            ctx!.lineWidth = 1;
            ctx!.beginPath();
            for(let i = 0; i < canvas!.width; i += 50) { ctx!.moveTo(i, 0); ctx!.lineTo(i, canvas!.height); }
            for(let i = 0; i < canvas!.height; i += 50) { ctx!.moveTo(0, i); ctx!.lineTo(canvas!.width, i); }
            ctx!.stroke();

            player.update();

            particles.forEach((particle, index) => {
                if (particle.alpha <= 0) particles.splice(index, 1);
                else particle.update();
            });

            projectiles.forEach((projectile, index) => {
                projectile.update();
                if (projectile.x - projectile.radius < 0 || projectile.x + projectile.radius > canvas!.width ||
                    projectile.y - projectile.radius < 0 || projectile.y + projectile.radius > canvas!.height) {
                    setTimeout(() => projectiles.splice(index, 1), 0);
                }
            });

            enemies.forEach((enemy, index) => {
                enemy.update(player.x, player.y);

                const dist = Math.hypot(player.x - enemy.x, player.y - enemy.y);
                if (dist - enemy.radius - player.radius < 1) {
                    player.health -= 20;
                    enemies.splice(index, 1);
                    if (player.health <= 0) {
                        cancelAnimationFrame(animationId);
                        setGameOver(true);
                        setScore(scoreCount);
                        const earned = Math.floor(scoreCount / 10);
                        if (earned > 0) awardPoints(earned, 'Played Neon Knight');
                        saveGameStats('neon_knight', { high_score: scoreCount, coins_earned: earned });
                    }
                }

                projectiles.forEach((projectile, pIndex) => {
                    const dist = Math.hypot(projectile.x - enemy.x, projectile.y - enemy.y);
                    if (dist - enemy.radius - projectile.radius < 1) {
                        for(let i=0; i<8; i++) {
                            particles.push(new Particle(projectile.x, projectile.y, Math.random()*3, enemy.color, {
                                x: (Math.random() - 0.5) * (Math.random()*8), y: (Math.random() - 0.5) * (Math.random()*8)
                            }));
                        }
                        setTimeout(() => {
                            enemies.splice(index, 1);
                            projectiles.splice(pIndex, 1);
                            scoreCount += 10;
                            setScore(scoreCount);
                        }, 0);
                    }
                });
            });

            if (frames % Math.max(30, 100 - Math.floor(scoreCount / 50)) === 0) {
                spawnEnemies();
            }
            frames++;
        };

        animate();

        return () => {
            cancelAnimationFrame(animationId);
            window.removeEventListener('keydown', handleKeyDown);
            window.removeEventListener('keyup', handleKeyUp);
            window.removeEventListener('mousemove', handleMouseMove);
            window.removeEventListener('mousedown', handleMouseClick);
        };
    }, [gameStarted, gameOver, saveGameStats, awardPoints]);

    return (
        <div className="fixed inset-0 z-[110] bg-[#05050a] overflow-hidden select-none">
            <canvas ref={canvasRef} className="block cursor-crosshair" />

            {/* Header overlay */}
            <div className="absolute top-0 w-full p-6 flex justify-between items-start pointer-events-none">
               <button onClick={() => navigate('/games')} className="pointer-events-auto w-12 h-12 rounded-full bg-white/10 flex items-center justify-center hover:bg-white/20 active:scale-95 transition-all backdrop-blur-md">
                   <span className="material-symbols-outlined text-white">arrow_back</span>
               </button>
               {gameStarted && !gameOver && (
                   <div className="flex flex-col items-end">
                       <span className="text-[10px] font-black uppercase tracking-[0.4em] text-white/50">Score</span>
                       <span className="text-3xl font-black text-white drop-shadow-[0_0_10px_#00f2ff] tabular-nums">{score}</span>
                   </div>
               )}
            </div>

            {!gameStarted && !gameOver && (
                <div className="absolute inset-0 z-50 flex flex-col items-center justify-center bg-black/80 backdrop-blur-sm pointer-events-auto">
                    <h1 className="text-6xl font-black italic text-transparent bg-clip-text bg-gradient-to-br from-[#00f2ff] to-[#ff0055] drop-shadow-[0_0_20px_#ff0055] mb-4 uppercase tracking-tighter">Neon Knight</h1>
                    <p className="text-white/60 text-sm tracking-widest uppercase mb-12 max-w-md text-center leading-relaxed">
                        Survive the endless swarm. Use WASD to move and Mouse to shoot.
                    </p>
                    {errorMsg && <p className="text-red-500 mb-4 font-bold bg-black/50 px-4 py-2 rounded border border-red-500/50">{errorMsg}</p>}
                    <button onClick={handleStart} className="px-14 py-5 bg-white text-black font-black uppercase tracking-[0.4em] rounded-full hover:scale-105 active:scale-95 transition-all shadow-[0_0_30px_rgba(255,255,255,0.3)]">
                        Enter Dungeon (15 Coins)
                    </button>
                </div>
            )}

            {gameOver && (
                <div className="absolute inset-0 z-50 flex flex-col items-center justify-center bg-[#ff0055]/10 backdrop-blur-md pointer-events-auto border-[2px] border-[#ff0055]/40 animate-pulse">
                    <h2 className="text-5xl font-black italic text-white drop-shadow-[0_0_20px_#ff0055] mb-4 uppercase tracking-tighter">Overwhelmed</h2>
                    <div className="bg-black/60 px-8 py-4 rounded-2xl border border-white/10 mb-10 flex flex-col items-center">
                        <span className="text-[10px] font-black uppercase tracking-[0.3em] text-white/50 mb-1">Final Score</span>
                        <span className="text-4xl font-black text-white tabular-nums">{score}</span>
                    </div>
                    <button onClick={handleStart} className="px-14 py-5 bg-white text-black font-black uppercase tracking-[0.4em] rounded-full hover:scale-105 active:scale-95 transition-all shadow-[0_0_30px_rgba(255,255,255,0.3)]">
                        Retry (15 Coins)
                    </button>
                </div>
            )}
        </div>
    );
};
