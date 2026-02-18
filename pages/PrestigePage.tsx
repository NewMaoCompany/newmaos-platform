
import React, { useState, useMemo, useRef, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { useApp } from '../AppContext';

import { StarBackground, ShootingStars, PlanetVisual, getPlanetName } from '../components/SpaceVisuals';
import { PointsCoin } from '../components/PointsCoin';

// Simple Synth for Sound Effects (reused logic)
const playSound = (type: 'coin' | 'stardust') => {
    try {
        const AudioContextClass = (window as any).AudioContext || (window as any).webkitAudioContext;
        const ctx = new AudioContextClass();
        const now = ctx.currentTime;
        const osc = ctx.createOscillator();
        const gain = ctx.createGain();

        osc.connect(gain);
        gain.connect(ctx.destination);

        if (type === 'coin') {
            // High pitch ping
            osc.type = 'sine';
            osc.frequency.setValueAtTime(1200, now);
            osc.frequency.exponentialRampToValueAtTime(2000, now + 0.1);
            gain.gain.setValueAtTime(0.1, now);
            gain.gain.exponentialRampToValueAtTime(0.001, now + 0.3);
            osc.start(now);
            osc.stop(now + 0.3);
        } else {
            // Magical shimmer
            osc.type = 'triangle';
            osc.frequency.setValueAtTime(400, now);
            osc.frequency.linearRampToValueAtTime(800, now + 0.2);
            gain.gain.setValueAtTime(0.1, now);
            gain.gain.linearRampToValueAtTime(0, now + 0.5);
            osc.start(now);
            osc.stop(now + 0.5);
        }
    } catch (e) { console.error(e); }
};

interface Rect { top: number; left: number; width: number; height: number; }

export const PrestigePage = () => {
    const { user, userPoints, userPrestige, purchaseStardust, injectStardust } = useApp();
    const navigate = useNavigate();
    const [isBuying, setIsBuying] = useState(false);
    const [buyAmount, setBuyAmount] = useState(10); // Coins to spend

    // GALAXY RING STATE
    const containerRef = useRef<HTMLDivElement>(null);
    const [activeIndex, setActiveIndex] = useState(0);
    const [dragStartX, setDragStartX] = useState<number | null>(null);
    const [currentTranslate, setCurrentTranslate] = useState(0);
    const [prevTranslate, setPrevTranslate] = useState(0);
    const [isDragging, setIsDragging] = useState(false);

    // Fallback if null
    const level = userPrestige?.planet_level || 1;
    const stars = userPrestige?.star_level || 0;
    const currentStardust = userPrestige?.current_stardust || 0;

    const costs = useMemo(() => {
        const base = 100 * Math.pow(5, level - 1);
        return [
            base,       // 0 -> 1 star
            base * 2.5, // 1 -> 2 stars
            base * 5    // 2 -> 3 stars (Planet Up)
        ];
    }, [level]);

    const nextStarCost = costs[stars] || 500 * level;
    const canUpgrade = currentStardust >= nextStarCost;

    const [flyItems, setFlyItems] = useState<{ id: number; type: 'coin' | 'stardust'; start: Rect; end: Rect }[]>([]);

    // Refs for Animation Targets
    const moneyRef = useRef<HTMLButtonElement>(null);
    const stardustRef = useRef<HTMLButtonElement>(null);
    const buyButtonRef = useRef<HTMLButtonElement>(null);

    const handleBuy = async () => {
        if (!buyButtonRef.current || !moneyRef.current) return;
        setIsBuying(true);

        // 1. Coin Animation (Money -> Buy Button)
        const startRect = moneyRef.current.getBoundingClientRect();
        const endRect = buyButtonRef.current.getBoundingClientRect();

        // Spawn multiple coins
        for (let i = 0; i < 5; i++) {
            setTimeout(() => {
                playSound('coin');
                setFlyItems(prev => [...prev, {
                    id: Date.now() + Math.random(),
                    type: 'coin',
                    start: { top: startRect.top, left: startRect.left, width: startRect.width, height: startRect.height },
                    end: { top: endRect.top + endRect.height / 2, left: endRect.left + endRect.width / 2, width: 0, height: 0 }
                }]);
            }, i * 50);
        }

        // Wait for coins to arrive
        await new Promise(r => setTimeout(r, 600));

        // 2. Perform Purchase
        const result = await purchaseStardust(buyAmount);

        if (result.success) {
            // 3. Stardust Animation (Buy Button -> Stardust Counter)
            if (stardustRef.current) {
                const stardustEnd = stardustRef.current.getBoundingClientRect();
                const stardustStart = buyButtonRef.current.getBoundingClientRect();

                for (let i = 0; i < 8; i++) {
                    setTimeout(() => {
                        playSound('stardust');
                        setFlyItems(prev => [...prev, {
                            id: Date.now() + Math.random(),
                            type: 'stardust',
                            start: { top: stardustStart.top, left: stardustStart.left + stardustStart.width / 2, width: 0, height: 0 },
                            end: { top: stardustEnd.top, left: stardustEnd.left, width: stardustEnd.width, height: stardustEnd.height }
                        }]);
                    }, i * 40);
                }
            }
        } else {
            console.error(result.message);
        }

        setIsBuying(false);
    };

    const handleInject = async () => {
        await injectStardust(nextStarCost);
    };

    // Initialize to current level
    useEffect(() => {
        const initialIndex = Math.max(0, level - 1);
        setActiveIndex(initialIndex);
        // Calculate initial translate based on index
        // Item width is approx 300px + gap. Let's say step is 400px for wide spacing.
        const step = 600;
        const initialTranslate = -initialIndex * step;
        setCurrentTranslate(initialTranslate);
        setPrevTranslate(initialTranslate);
    }, [level]);

    // Touch/Mouse Handlers for Ring Swipe
    const handleTouchStart = (e: React.TouchEvent | React.MouseEvent) => {
        const clientX = 'touches' in e ? e.touches[0].clientX : (e as React.MouseEvent).clientX;
        setDragStartX(clientX);
        setIsDragging(true);
        if (containerRef.current) containerRef.current.style.transition = 'none';
    };

    const handleTouchMove = (e: React.TouchEvent | React.MouseEvent) => {
        if (!isDragging || dragStartX === null) return;
        const clientX = 'touches' in e ? e.touches[0].clientX : (e as React.MouseEvent).clientX;
        const diff = clientX - dragStartX;
        setCurrentTranslate(prevTranslate + diff);
    };

    const handleTouchEnd = () => {
        setIsDragging(false);
        setDragStartX(null);

        // Snap Logic
        const step = 600; // Wide spacing
        // Calculate nearest index
        let nextIndex = -Math.round(currentTranslate / step);
        // Clamp to valid range [0, 9]
        nextIndex = Math.max(0, Math.min(9, nextIndex));

        setActiveIndex(nextIndex);

        const finalTranslate = -nextIndex * step;
        setCurrentTranslate(finalTranslate);
        setPrevTranslate(finalTranslate);

        if (containerRef.current) {
            containerRef.current.style.transition = 'transform 0.5s cubic-bezier(0.2, 0.8, 0.2, 1)';
        }
    };

    return (
        <div className="fixed inset-0 w-full h-[100dvh] bg-black text-white font-sans flex flex-col overflow-hidden select-none" style={{ overscrollBehavior: 'none' }}>
            {/* Dynamic Space Background */}
            <div className="absolute inset-0 z-0 pointer-events-none bg-black">
                <StarBackground />
                <ShootingStars />

                {/* DISTANT SUN - Adjusted z-index and position */}
                <div className="absolute top-[-20%] right-[-20%] w-[80vh] h-[80vh] bg-[radial-gradient(circle,rgba(251,191,36,0.3)_0%,rgba(245,158,11,0.05)_60%,transparent_80%)] rounded-full blur-[80px] pointer-events-none z-0 animate-pulse" />
            </div>

            {/* Header */}
            <div className="absolute top-safe left-4 z-50 pt-4">
                <button
                    onClick={() => navigate(-1)}
                    className="flex items-center gap-2 text-white/60 hover:text-white transition-colors bg-black/20 backdrop-blur-sm px-4 py-2 rounded-full border border-white/5 hover:bg-white/10"
                >
                    <span className="material-symbols-outlined text-xl">arrow_back</span>
                    <span className="text-sm font-medium">Back</span>
                </button>
            </div>

            <div className="absolute top-6 right-4 z-50 flex items-center gap-3">
                <div className="flex items-center bg-black/40 rounded-full backdrop-blur-md border border-white/10 shadow-xl overflow-hidden">
                    {/* Money Section */}
                    <button
                        ref={moneyRef}
                        onClick={() => navigate('/wallet')}
                        className="flex items-center gap-2 px-4 py-2 hover:bg-white/10 transition-colors"
                    >
                        <PointsCoin size="sm" />
                        <span className="text-amber-400 font-bold text-sm tabular-nums">{userPoints.balance.toLocaleString()}</span>
                    </button>

                    <div className="w-px h-5 bg-white/20"></div>

                    {/* Stardust Section */}
                    <button
                        ref={stardustRef}
                        onClick={() => navigate('/prestige')}
                        className="flex items-center gap-2 px-4 py-2 hover:bg-white/10 transition-colors"
                    >
                        <span className="material-symbols-outlined text-purple-400 text-lg" style={{ fontVariationSettings: "'FILL' 1" }}>auto_awesome</span>
                        <span className="text-purple-300 font-bold text-sm tabular-nums">{currentStardust.toLocaleString()}</span>
                    </button>
                </div>
            </div>

            {/* FLYING ITEMS LAYER */}
            {flyItems.map(item => (
                <FlyingItem key={item.id} item={item} onComplete={() => setFlyItems(prev => prev.filter(i => i.id !== item.id))} />
            ))}

            {/* GALAXY RING SWIPER */}
            <main
                className="absolute inset-0 z-10 flex flex-col justify-center items-center overflow-hidden cursor-grab active:cursor-grabbing"
                style={{ touchAction: 'none' }}
                onMouseDown={handleTouchStart}
                onMouseMove={handleTouchMove}
                onMouseUp={handleTouchEnd}
                onMouseLeave={handleTouchEnd}
                onTouchStart={handleTouchStart}
                onTouchMove={handleTouchMove}
                onTouchEnd={handleTouchEnd}
            >
                {/* Track Container - Adjusted Height to avoid text overlap */}
                <div className="relative w-full h-[60vh] max-h-[800px] flex items-center justify-center perspective-[2000px] pointer-events-none">

                    {/* Transforming Track */}
                    <div
                        ref={containerRef}
                        className="absolute flex items-center h-full will-change-transform left-1/2 -ml-[300px] pointer-events-auto"
                        style={{ transform: `translateX(${currentTranslate}px)` }}
                    >
                        {Array.from({ length: 10 }).map((_, i) => {
                            const planetLevel = i + 1;
                            const isUnlocked = planetLevel <= level;
                            const isNext = planetLevel === level + 1;
                            const name = getPlanetName(planetLevel);

                            // Distance from active center
                            const distance = Math.abs(i - activeIndex);
                            // Scale logic
                            const scale = distance === 0 ? 1.2 : Math.max(0.4, 0.8 - (distance * 0.2));
                            const opacity = distance === 0 ? 1 : Math.max(0.3, 0.7 - (distance * 0.15));
                            const rotateY = (i - activeIndex) * 15;

                            return (
                                <div
                                    key={i}
                                    className="relative flex flex-col items-center justify-center transition-all duration-500 ease-out"
                                    style={{
                                        width: '600px',
                                        transform: `scale(${scale}) rotateY(${rotateY}deg)`,
                                        opacity: opacity,
                                        zIndex: 10 - distance,
                                        filter: distance > 2 ? 'blur(2px)' : 'none'
                                    }}
                                >
                                    <div className="relative group cursor-pointer" onClick={(e) => {
                                        e.stopPropagation(); // Prevent drag interference
                                        if (distance !== 0) {
                                            const step = 600;
                                            const target = -i * step;
                                            setActiveIndex(i);
                                            setCurrentTranslate(target);
                                            setPrevTranslate(target);
                                        }
                                    }}>
                                        {/* PLANET VISUAL */}
                                        <div className={`transition-all duration-700 ${!isUnlocked && distance > 0 ? 'brightness-[0.3] saturation-0' : ''}`}>
                                            <PlanetVisual level={planetLevel} size="xl" className="drop-shadow-[0_0_50px_rgba(255,255,255,0.05)]" />
                                        </div>

                                        {!isUnlocked && (
                                            <div className="absolute top-4 right-4 text-white/30 drop-shadow-md">
                                                <span className="material-symbols-outlined text-4xl">lock</span>
                                            </div>
                                        )}
                                    </div>

                                    {/* PLANET NAME - Moved much higher to avoid overlap */}
                                    <div className={`text-center transition-opacity duration-500 ${distance === 0 ? 'opacity-100' : 'opacity-0'} pointer-events-none absolute -top-16 w-full flex justify-center`}>
                                        <h2 className="text-5xl md:text-7xl font-black uppercase tracking-[0.5em] text-transparent bg-clip-text bg-gradient-to-b from-white/90 via-white/50 to-white/10 drop-shadow-[0_4px_12px_rgba(255,255,255,0.2)] font-mono whitespace-nowrap">
                                            {name}
                                        </h2>
                                    </div>
                                </div>
                            );
                        })}
                    </div>
                </div>
            </main>

            {/* Bottom Controls Area - Fixed at bottom */}
            <div className="absolute bottom-0 w-full z-40 bg-gradient-to-t from-black via-black/80 to-transparent pb-16 pt-40 px-4 flex flex-col items-center pointer-events-none">
                <div className="pointer-events-auto w-full max-w-xl flex flex-col gap-12 items-center">

                    {/* Current Level Info - Redesigned with 4-Vertex Progress Bar */}
                    <div className="flex flex-col items-center w-full max-w-xl px-12">
                        {/* Status Badge - Floating Above */}
                        <div className="flex items-center justify-center w-full mb-16">
                            <span className="px-6 py-2.5 rounded-2xl bg-white/5 border border-white/10 text-[11px] uppercase tracking-[0.4em] font-black text-white/40 shadow-2xl backdrop-blur-2xl">
                                Level {level} — {getPlanetName(level)}
                            </span>
                        </div>

                        {/* 4-Vertex Progress Bar */}
                        <div className="relative w-full h-[5px] bg-white/5 rounded-full flex items-center justify-between border border-white/5 px-0.5">
                            {/* Filling Effect */}
                            <div
                                className="absolute left-0 top-0 h-full bg-gradient-to-r from-[#FFCC00] via-amber-400 to-[#FFCC00] rounded-full transition-all duration-1000 shadow-[0_0_30px_rgba(251,191,36,0.5)]"
                                style={{ width: `${(stars / 3) * 100}%` }}
                            />

                            {/* Vertices (4 Dots) */}
                            {[0, 1, 2, 3].map((i) => {
                                const isReached = i <= stars;
                                const labels = ["1 Star", "2 Stars", "3 Stars", "Next Level"];
                                return (
                                    <div key={i} className="relative z-10 flex flex-col items-center">
                                        {/* Dot with glow */}
                                        <div
                                            className={`w-5 h-5 rounded-full transition-all duration-700 border-2 ${isReached
                                                    ? 'bg-[#FFCC00] border-amber-200 scale-125 shadow-[0_0_20px_rgba(251,191,36,1)]'
                                                    : 'bg-[#050505] border-white/10 scale-90'
                                                }`}
                                        />

                                        {/* Vertex Labels - Positioned to ensure no overlap */}
                                        <div className={`absolute -bottom-14 whitespace-nowrap flex flex-col items-center transition-all duration-700 ${isReached ? 'opacity-100 translate-y-0' : 'opacity-10 translate-y-4'}`}>
                                            <span className={`text-[10px] font-black uppercase tracking-[0.15em] ${i === 3 ? 'text-amber-400' : 'text-white/70'}`}>
                                                {labels[i]}
                                            </span>
                                            <div className="mt-2 flex items-center justify-center">
                                                {i === 3 ? (
                                                    <span className={`material-symbols-outlined text-xl ${isReached ? 'text-amber-400' : 'text-white/5'} transition-colors`}>
                                                        {isReached ? 'check_circle' : 'rocket_launch'}
                                                    </span>
                                                ) : (
                                                    <div className="flex gap-0.5">
                                                        {Array.from({ length: i + 1 }).map((_, si) => (
                                                            <span key={si} className={`material-symbols-outlined text-[10px] ${isReached ? 'text-amber-500' : 'text-white/5'}`} style={{ fontVariationSettings: "'FILL' 1" }}>
                                                                star
                                                            </span>
                                                        ))}
                                                    </div>
                                                )}
                                            </div>
                                        </div>
                                    </div>
                                );
                            })}
                        </div>
                    </div>

                    {/* Controls */}
                    <div className="w-full grid grid-cols-2 gap-6 md:gap-10 pt-10">
                        {/* Inject Button */}
                        <button
                            onClick={handleInject}
                            disabled={!canUpgrade}
                            className={`col-span-1 h-20 rounded-[32px] font-black text-[13px] tracking-[0.3em] uppercase flex flex-col items-center justify-center gap-1 transition-all duration-400 relative overflow-hidden group shadow-[0_20px_40px_-15px_rgba(0,0,0,0.5)]
                                ${canUpgrade
                                    ? 'bg-[#FFCC00] hover:bg-[#ffda33] text-black hover:translate-y-[-2px] active:translate-y-[1px]'
                                    : 'bg-white/5 text-white/5 cursor-not-allowed border border-white/5'}`}
                        >
                            <div className="flex items-center gap-2.5 z-10 transition-transform group-hover:scale-110">
                                <span className="material-symbols-outlined text-2xl font-black">{stars === 2 ? 'auto_mode' : 'offline_bolt'}</span>
                                <span className="drop-shadow-sm font-black">{stars === 2 ? 'Evolve Planet' : 'Inject Stardust'}</span>
                            </div>
                            <span className={`text-[11px] z-10 tracking-widest transition-opacity duration-300 ${canUpgrade ? 'text-black/50 font-black' : 'text-white/5'}`}>
                                {nextStarCost.toLocaleString()} UNITS
                            </span>
                            {/* Particle Effect for active button */}
                            {canUpgrade && <div className="absolute inset-0 bg-[radial-gradient(circle_at_center,rgba(255,255,255,0.4)_0%,transparent_70%)] opacity-0 group-hover:opacity-100 transition-opacity duration-500" />}
                        </button>

                        {/* Market/Buy Panel */}
                        <div className="col-span-1 h-16 bg-black/60 backdrop-blur-2xl rounded-2xl border border-white/10 flex items-center justify-between px-1.5 py-1.5 gap-2 shadow-2xl relative">
                            {/* Market Rate */}
                            <div className="flex flex-col items-center justify-center pl-3 pr-2 border-r border-white/5 h-full">
                                <span className="text-[8px] text-white/20 uppercase font-bold tracking-widest text-center">Rate</span>
                                <div className="flex items-center gap-0.5 text-xs font-bold text-[#FFCC00] mt-0.5">
                                    <span>10</span>
                                    <span className="material-symbols-outlined text-[10px]">auto_awesome</span>
                                </div>
                            </div>
                            {/* Input */}
                            <div className="flex-grow flex items-center justify-center relative h-full">
                                <input
                                    type="number"
                                    min="1"
                                    max={userPoints.balance}
                                    value={buyAmount}
                                    onChange={(e) => setBuyAmount(Math.max(1, parseInt(e.target.value) || 0))}
                                    className="bg-transparent w-full h-full outline-none font-black text-white text-center text-lg appearance-none m-0 p-0 shadow-none border-none ring-0 no-spin caret-[#FFCC00]"
                                />
                            </div>
                            {/* Buy Button */}
                            <button
                                ref={buyButtonRef}
                                onClick={handleBuy}
                                disabled={isBuying || userPoints.balance < buyAmount}
                                className="h-full px-6 bg-[#FFCC00] hover:bg-[#ffda33] text-black font-black text-xs uppercase tracking-wider rounded-xl transition-all shadow-md active:scale-95 disabled:opacity-50 disabled:bg-gray-600 disabled:cursor-not-allowed whitespace-nowrap flex items-center justify-center relative overflow-hidden"
                            >
                                {isBuying ? <span className="material-symbols-outlined animate-spin text-sm">refresh</span> : 'Buy'}
                                {/* Ripple or Shine effect could go here */}
                            </button>
                        </div>
                    </div>
                </div>
            </div>

            <style dangerouslySetInnerHTML={{
                __html: `
                input[type=number]::-webkit-inner-spin-button, 
                input[type=number]::-webkit-outer-spin-button { 
                    -webkit-appearance: none; 
                    margin: 0; 
                }
                input[type=number] {
                    -moz-appearance: textfield;
                }
            `}} />
        </div>
    );
};

const FlyingItem = ({ item, onComplete }: { item: { type: 'coin' | 'stardust'; start: Rect; end: Rect }; onComplete: () => void }) => {
    const [style, setStyle] = useState<React.CSSProperties>({
        top: item.start.top,
        left: item.start.left,
        opacity: 1,
        transform: 'scale(1)',
        position: 'fixed',
        zIndex: 100,
        pointerEvents: 'none',
        transition: 'all 0.6s cubic-bezier(0.2, 1, 0.3, 1)'
    });

    useEffect(() => {
        // Trigger flight next tick
        requestAnimationFrame(() => {
            setStyle({
                top: item.end.top,
                left: item.end.left,
                opacity: 0,
                transform: 'scale(0.5)',
                position: 'fixed',
                zIndex: 100,
                pointerEvents: 'none',
                transition: 'all 0.6s cubic-bezier(0.2, 1, 0.3, 1)'
            });
        });

        const timer = setTimeout(onComplete, 600);
        return () => clearTimeout(timer);
    }, []);

    return (
        <div style={style}>
            {item.type === 'coin' ? (
                <PointsCoin size="sm" animate />
            ) : (
                <span className="material-symbols-outlined text-purple-400 text-xl drop-shadow-[0_0_10px_rgba(192,132,252,0.8)]" style={{ fontVariationSettings: "'FILL' 1" }}>
                    auto_awesome
                </span>
            )}
        </div>
    );
};
