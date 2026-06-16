import React, { useEffect, useRef, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { useApp } from '../AppContext';

export const BrawlArena = () => {
    const navigate = useNavigate();
    const { spendPoints, awardPoints, saveGameStats } = useApp();
    const canvasRef = useRef<HTMLCanvasElement>(null);
    const [gameStarted, setGameStarted] = useState(false);
    const [gameOver, setGameOver] = useState(false);
    const [score, setScore] = useState(0);

    const handleStart = async () => {
        const res = await spendPoints(20, 'brawl_arena');
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

        canvas.width = window.innerWidth;
        canvas.height = window.innerHeight;

        const keys: Record<string, boolean> = {};
        const mouse = { x: canvas.width / 2, y: canvas.height / 2, clicked: false };

        const handleKeyDown = (e: KeyboardEvent) => { keys[e.key.toLowerCase()] = true; };
        const handleKeyUp = (e: KeyboardEvent) => { keys[e.key.toLowerCase()] = false; };
        const handleMouseMove = (e: MouseEvent) => { mouse.x = e.clientX; mouse.y = e.clientY; };
        const handleMouseDown = () => { mouse.clicked = true; };
        const handleMouseUp = () => { mouse.clicked = false; };

        window.addEventListener('keydown', handleKeyDown);
        window.addEventListener('keyup', handleKeyUp);
        window.addEventListener('mousemove', handleMouseMove);
        window.addEventListener('mousedown', handleMouseDown);
        window.addEventListener('mouseup', handleMouseUp);

        class Player {
            x = canvas!.width / 2;
            y = canvas!.height / 2;
            radius = 25;
            color = '#ffcc00';
            speed = 6;
            health = 100;
            reloadTimer = 0;

            draw() {
                ctx!.save();
                ctx!.translate(this.x, this.y);
                const angle = Math.atan2(mouse.y - this.y, mouse.x - this.x);
                ctx!.rotate(angle);
                
                // Body
                ctx!.beginPath();
                ctx!.arc(0, 0, this.radius, 0, Math.PI * 2);
                ctx!.fillStyle = this.color;
                ctx!.shadowBlur = 15;
                ctx!.shadowColor = this.color;
                ctx!.fill();
                ctx!.shadowBlur = 0;

                // Gun
                ctx!.fillStyle = '#fff';
                ctx!.fillRect(this.radius - 5, -5, 20, 10);
                
                ctx!.restore();

                // Health bar
                ctx!.fillStyle = 'red';
                ctx!.fillRect(this.x - 25, this.y + 35, 50, 6);
                ctx!.fillStyle = '#00ff88';
                ctx!.fillRect(this.x - 25, this.y + 35, (this.health / 100) * 50, 6);
            }

            update() {
                if (keys['w'] || keys['arrowup']) this.y -= this.speed;
                if (keys['s'] || keys['arrowdown']) this.y += this.speed;
                if (keys['a'] || keys['arrowleft']) this.x -= this.speed;
                if (keys['d'] || keys['arrowright']) this.x += this.speed;

                this.x = Math.max(this.radius, Math.min(canvas!.width - this.radius, this.x));
                this.y = Math.max(this.radius, Math.min(canvas!.height - this.radius, this.y));
                
                this.reloadTimer++;
                if (mouse.clicked && this.reloadTimer > 15) {
                    const angle = Math.atan2(mouse.y - this.y, mouse.x - this.x);
                    const velocity = { x: Math.cos(angle) * 15, y: Math.sin(angle) * 15 };
                    projectiles.push(new Projectile(this.x + Math.cos(angle)*this.radius, this.y + Math.sin(angle)*this.radius, velocity, '#fff'));
                    this.reloadTimer = 0;
                }

                this.draw();
            }
        }

        class Projectile {
            x: number; y: number; radius = 6; color: string; velocity: {x: number, y: number};
            constructor(x: number, y: number, velocity: {x: number, y: number}, color: string) {
                this.x = x; this.y = y; this.velocity = velocity; this.color = color;
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

        class Brawler {
            x: number; y: number; radius = 25; color = '#ff0055'; speed: number; health = 50; reloadTimer = 0;
            constructor(x: number, y: number, speed: number) {
                this.x = x; this.y = y; this.speed = speed;
            }
            draw() {
                ctx!.save();
                ctx!.translate(this.x, this.y);
                const angle = Math.atan2(player.y - this.y, player.x - this.x);
                ctx!.rotate(angle);
                
                // Body
                ctx!.beginPath();
                ctx!.arc(0, 0, this.radius, 0, Math.PI * 2);
                ctx!.fillStyle = this.color;
                ctx!.fill();

                // Gun
                ctx!.fillStyle = '#333';
                ctx!.fillRect(this.radius - 5, -5, 20, 10);
                
                ctx!.restore();

                // Health bar
                ctx!.fillStyle = 'rgba(255,0,0,0.5)';
                ctx!.fillRect(this.x - 20, this.y + 35, 40, 4);
                ctx!.fillStyle = '#ff0055';
                ctx!.fillRect(this.x - 20, this.y + 35, (this.health / 50) * 40, 4);
            }
            update() {
                const angle = Math.atan2(player.y - this.y, player.x - this.x);
                const dist = Math.hypot(player.x - this.x, player.y - this.y);

                if (dist > 200) {
                    this.x += Math.cos(angle) * this.speed;
                    this.y += Math.sin(angle) * this.speed;
                }

                this.reloadTimer++;
                if (dist < 400 && this.reloadTimer > 100) {
                    const velocity = { x: Math.cos(angle) * 8, y: Math.sin(angle) * 8 };
                    enemyProjectiles.push(new Projectile(this.x + Math.cos(angle)*this.radius, this.y + Math.sin(angle)*this.radius, velocity, '#ff0055'));
                    this.reloadTimer = 0;
                }

                this.draw();
            }
        }

        class Powerup {
            x: number; y: number; radius = 15;
            constructor(x: number, y: number) { this.x = x; this.y = y; }
            draw() {
                ctx!.fillStyle = '#34c759';
                ctx!.beginPath();
                ctx!.arc(this.x, this.y, this.radius, 0, Math.PI * 2);
                ctx!.fill();
                ctx!.fillStyle = '#fff';
                ctx!.font = 'bold 20px Arial';
                ctx!.textAlign = 'center';
                ctx!.textBaseline = 'middle';
                ctx!.fillText('+', this.x, this.y);
            }
            update() { this.draw(); }
        }

        const player = new Player();
        const projectiles: Projectile[] = [];
        const enemyProjectiles: Projectile[] = [];
        const enemies: Brawler[] = [];
        const powerups: Powerup[] = [];

        let animationId: number;
        let scoreCount = 0;
        let frames = 0;

        const spawnEnemy = () => {
            const radius = 25;
            let x, y;
            if (Math.random() < 0.5) {
                x = Math.random() < 0.5 ? 0 - radius : canvas!.width + radius;
                y = Math.random() * canvas!.height;
            } else {
                x = Math.random() * canvas!.width;
                y = Math.random() < 0.5 ? 0 - radius : canvas!.height + radius;
            }
            const speed = Math.random() * 2 + 2;
            enemies.push(new Brawler(x, y, speed));
        };

        const animate = () => {
            animationId = requestAnimationFrame(animate);
            ctx!.fillStyle = '#111';
            ctx!.fillRect(0, 0, canvas!.width, canvas!.height);
            
            // Grid background
            ctx!.strokeStyle = 'rgba(255, 204, 0, 0.05)';
            ctx!.lineWidth = 2;
            ctx!.beginPath();
            for(let i = 0; i < canvas!.width; i += 60) { ctx!.moveTo(i, 0); ctx!.lineTo(i, canvas!.height); }
            for(let i = 0; i < canvas!.height; i += 60) { ctx!.moveTo(0, i); ctx!.lineTo(canvas!.width, i); }
            ctx!.stroke();

            powerups.forEach((pu, index) => {
                pu.update();
                if (Math.hypot(player.x - pu.x, player.y - pu.y) < player.radius + pu.radius) {
                    player.health = Math.min(100, player.health + 30);
                    powerups.splice(index, 1);
                }
            });

            player.update();

            projectiles.forEach((projectile, index) => {
                projectile.update();
                if (projectile.x < 0 || projectile.x > canvas!.width || projectile.y < 0 || projectile.y > canvas!.height) {
                    setTimeout(() => projectiles.splice(index, 1), 0);
                }
            });

            enemyProjectiles.forEach((projectile, index) => {
                projectile.update();
                if (projectile.x < 0 || projectile.x > canvas!.width || projectile.y < 0 || projectile.y > canvas!.height) {
                    setTimeout(() => enemyProjectiles.splice(index, 1), 0);
                } else if (Math.hypot(player.x - projectile.x, player.y - projectile.y) < player.radius + projectile.radius) {
                    player.health -= 15;
                    setTimeout(() => enemyProjectiles.splice(index, 1), 0);
                    if (player.health <= 0) {
                        cancelAnimationFrame(animationId);
                        setGameOver(true);
                        setScore(scoreCount);
                        const earned = Math.floor(scoreCount / 50);
                        if (earned > 0) awardPoints(earned, 'Played Brawl Arena');
                        saveGameStats('brawl_arena', { high_score: scoreCount, coins_earned: earned });
                    }
                }
            });

            enemies.forEach((enemy, index) => {
                enemy.update();

                projectiles.forEach((projectile, pIndex) => {
                    const dist = Math.hypot(projectile.x - enemy.x, projectile.y - enemy.y);
                    if (dist - enemy.radius - projectile.radius < 1) {
                        enemy.health -= 25;
                        setTimeout(() => projectiles.splice(pIndex, 1), 0);
                        if (enemy.health <= 0) {
                            setTimeout(() => {
                                enemies.splice(index, 1);
                                scoreCount += 50;
                                setScore(scoreCount);
                                if (Math.random() < 0.2) {
                                    powerups.push(new Powerup(enemy.x, enemy.y));
                                }
                            }, 0);
                        }
                    }
                });
            });

            if (frames % Math.max(60, 200 - Math.floor(scoreCount / 100)) === 0) {
                spawnEnemy();
            }
            frames++;
        };

        animate();

        return () => {
            cancelAnimationFrame(animationId);
            window.removeEventListener('keydown', handleKeyDown);
            window.removeEventListener('keyup', handleKeyUp);
            window.removeEventListener('mousemove', handleMouseMove);
            window.removeEventListener('mousedown', handleMouseDown);
            window.removeEventListener('mouseup', handleMouseUp);
        };
    }, [gameStarted, gameOver, awardPoints, saveGameStats]);

    return (
        <div className="fixed inset-0 z-[110] bg-[#111] overflow-hidden select-none cursor-crosshair">
            <canvas ref={canvasRef} className="block w-full h-full" />

            <button onClick={() => navigate('/games')} className="absolute top-6 left-6 z-50 w-12 h-12 rounded-full bg-white/10 flex items-center justify-center hover:bg-white/20 active:scale-95 transition-all backdrop-blur-md">
                <span className="material-symbols-outlined text-white">arrow_back</span>
            </button>

            {gameStarted && !gameOver && (
                <div className="absolute top-6 right-6 flex flex-col items-end pointer-events-none">
                    <span className="text-[10px] font-black uppercase tracking-[0.4em] text-white/50">Score</span>
                    <span className="text-4xl font-black text-white drop-shadow-[0_0_10px_#ffcc00] tabular-nums">{score}</span>
                </div>
            )}

            {!gameStarted && !gameOver && (
                <div className="absolute inset-0 z-50 flex flex-col items-center justify-center bg-black/80 backdrop-blur-sm pointer-events-auto">
                    <h1 className="text-6xl sm:text-8xl font-black italic text-[#ffcc00] drop-shadow-[0_0_30px_#ffcc00] mb-4 uppercase tracking-tighter">Brawl Arena</h1>
                    <p className="text-white/60 text-sm tracking-widest uppercase mb-12 max-w-md text-center leading-relaxed">
                        Last one standing takes all. Use WASD to move, Mouse to aim and shoot.
                    </p>
                    <button onClick={handleStart} className="px-14 py-5 bg-[#ffcc00] text-black font-black uppercase tracking-[0.4em] rounded-full hover:scale-105 active:scale-95 transition-all shadow-[0_0_40px_rgba(255,204,0,0.4)]">
                        Enter Arena (20 Coins)
                    </button>
                </div>
            )}

            {gameOver && (
                <div className="absolute inset-0 z-50 flex flex-col items-center justify-center bg-[#ff0055]/10 backdrop-blur-lg pointer-events-auto animate-fade-in border-[2px] border-[#ff0055]/30">
                    <h2 className="text-5xl font-black italic text-white drop-shadow-[0_0_20px_#ff0055] mb-4 uppercase tracking-tighter">Eliminated</h2>
                    <div className="bg-black/40 px-10 py-6 rounded-3xl border border-white/20 mb-10 flex flex-col items-center">
                        <span className="text-[10px] font-black uppercase tracking-[0.3em] text-[#ff0055] mb-2">Final Score</span>
                        <span className="text-5xl font-black text-white tabular-nums">{score}</span>
                    </div>
                    <button onClick={handleStart} className="px-14 py-5 bg-white text-black font-black uppercase tracking-[0.4em] rounded-full hover:scale-105 active:scale-95 transition-all shadow-[0_0_30px_rgba(255,255,255,0.3)]">
                        Rematch (20 Coins)
                    </button>
                </div>
            )}
        </div>
    );
};
