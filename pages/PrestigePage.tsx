
import React, { useState, useMemo, useRef, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { useApp } from '../AppContext';

import { StarBackground, ShootingStars, PlanetVisual, getPlanetName } from '../components/SpaceVisuals';
import { PointsCoin } from '../components/PointsCoin';

// Simple Synth for Sound Effects (reused logic)
const playSound = (type: 'coin' | 'stardust' | 'celebration') => {
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
        } else if (type === 'stardust') {
            // Magical shimmer
            osc.type = 'triangle';
            osc.frequency.setValueAtTime(400, now);
            osc.frequency.linearRampToValueAtTime(800, now + 0.2);
            gain.gain.setValueAtTime(0.1, now);
            gain.gain.linearRampToValueAtTime(0, now + 0.5);
            osc.start(now);
            osc.stop(now + 0.5);
        } else if (type === 'celebration') {
            // Arpeggio / Multi-tone celebration
            [0, 0.05, 0.1, 0.15].forEach((delay, i) => {
                const o = ctx.createOscillator();
                const g = ctx.createGain();
                o.connect(g);
                g.connect(ctx.destination);
                o.type = 'sine';
                o.frequency.setValueAtTime(440 * (i + 1), now + delay);
                o.frequency.exponentialRampToValueAtTime(880 * (i + 1), now + delay + 0.2);
                g.gain.setValueAtTime(0.05, now + delay);
                g.gain.exponentialRampToValueAtTime(0.001, now + delay + 0.4);
                o.start(now + delay);
                o.stop(now + delay + 0.4);
            });
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

    const [flyItems, setFlyItems] = useState<{ id: number; type: 'coin' | 'stardust' | 'cosmic'; start: Rect; end: Rect }[]>([]);
    const [balanceChanges, setBalanceChanges] = useState<{ id: number; type: 'points' | 'stardust'; amount: number }[]>([]);

    const costs = useMemo(() => {
        const base = 100 * Math.pow(5, level - 1);
        return [
            base,       // 0 -> 1 star
            base * 2.5, // 1 -> 2 stars
            base * 5,   // 2 -> 3 stars
            base * 10,  // 3 -> 4 stars (Next Level Ready)
            base * 10   // Fallback
        ];
    }, [level]);

    const nextStarCost = costs[stars] || 1000 * level;

    // Per-planet progress logic
    const displayedStars = useMemo(() => {
        const planetLevelOfIndex = activeIndex + 1;
        if (planetLevelOfIndex < level) return 4; // Previously completed
        if (planetLevelOfIndex === level) return stars; // Currently progressing
        return 0; // Future planet
    }, [activeIndex, level, stars]);

    const canUpgrade = currentStardust >= nextStarCost;
    const isViewedPlanetCompleted = (activeIndex + 1) < level;
    const isReadyToEvolve = stars >= 4;
    const isFuturePlanet = (activeIndex + 1) > level;

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
            // Show -Points label
            const labelId = Date.now();
            setBalanceChanges(prev => [...prev, { id: labelId, type: 'points', amount: -buyAmount }]);
            setTimeout(() => setBalanceChanges(prev => prev.filter(l => l.id !== labelId)), 2000);

            // 3. Cinematic Stardust Animation (Buy Button -> Stardust Counter)
            if (stardustRef.current) {
                const stardustEnd = stardustRef.current.getBoundingClientRect();
                const stardustStart = buyButtonRef.current.getBoundingClientRect();

                // Single Large Cosmic Star flight
                playSound('celebration'); // Use celebration for cinematic effect
                setFlyItems(prev => [...prev, {
                    id: Date.now() + 100,
                    type: 'cosmic',
                    start: { top: stardustStart.top, left: stardustStart.left + stardustStart.width / 2, width: 0, height: 0 },
                    end: { top: stardustEnd.top, left: stardustEnd.left + stardustEnd.width / 2, width: stardustEnd.width, height: stardustEnd.height }
                }]);

                // Show +Stardust label after a delay
                setTimeout(() => {
                    const stardustLabelId = Date.now() + 1;
                    setBalanceChanges(prev => [...prev, { id: stardustLabelId, type: 'stardust', amount: buyAmount }]);
                    setTimeout(() => setBalanceChanges(prev => prev.filter(l => l.id !== stardustLabelId)), 2000);
                }, 1500);
            }
        } else {
            alert(result.message || 'Purchase failed');
        }

        setIsBuying(false);
    };

    const handleInject = async () => {
        const result = await injectStardust(nextStarCost);
        if (result.success) {
            // Show -Stardust label
            const labelId = Date.now();
            setBalanceChanges(prev => [...prev, { id: labelId, type: 'stardust', amount: -nextStarCost }]);
            setTimeout(() => setBalanceChanges(prev => prev.filter(l => l.id !== labelId)), 2000);
        } else {
            alert(result.message || 'Injection failed');
        }
    };

    const lastLevelRef = useRef(level);

    // Initialize/Auto-scroll when level changes
    useEffect(() => {
        const targetIndex = Math.max(0, level - 1);
        setActiveIndex(targetIndex);

        const step = 600;
        const targetTranslate = -targetIndex * step;

        // If level increased, animate
        if (level > lastLevelRef.current && containerRef.current) {
            containerRef.current.style.transition = 'transform 1.2s cubic-bezier(0.22, 1, 0.36, 1)';
        } else if (containerRef.current) {
            containerRef.current.style.transition = 'none';
        }

        setCurrentTranslate(targetTranslate);
        setPrevTranslate(targetTranslate);
        lastLevelRef.current = level;
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

    // Wheel Event Handler for Trackpad
    const wheelTimeoutRef = useRef<NodeJS.Timeout | null>(null);

    const handleWheel = (e: React.WheelEvent) => {
        // Horizontal scroll preferred, but vertical also works for convenience
        const delta = Math.abs(e.deltaX) > Math.abs(e.deltaY) ? e.deltaX : e.deltaY;

        // Update translate
        setCurrentTranslate(prev => prev - delta * 1.5); // 1.5 multiplier for sensitivity

        // Debounce snap
        if (wheelTimeoutRef.current) clearTimeout(wheelTimeoutRef.current);
        wheelTimeoutRef.current = setTimeout(() => {
            // Trigger snap logic manually since we can't reuse handleTouchEnd easily without refactoring
            const step = 600;
            let nextIndex = -Math.round(currentTranslate / step);
            // Re-calculate nextIndex based on the *latest* currentTranslate not the closure one? 
            // Actually closure might be stale. Use ref or functional update if needed, but here we need current value.
            // Let's rely on the fact that standard state update might be enough or use a ref for currentTranslate if jittery.
            // For now, let's use a simple approach: call a snap function that uses the state.
            // But wait, setTimeout closure will have stale state. 
            // We need a ref to track currentTranslate for the timeout callback.
        }, 150);
    };

    // Ref for currentTranslate to access in timeout
    const currentTranslateRef = useRef(currentTranslate);
    useEffect(() => { currentTranslateRef.current = currentTranslate; }, [currentTranslate]);

    const performSnap = () => {
        const step = 600;
        let nextIndex = -Math.round(currentTranslateRef.current / step);
        nextIndex = Math.max(0, Math.min(9, nextIndex));
        setActiveIndex(nextIndex);
        const finalTranslate = -nextIndex * step;
        setCurrentTranslate(finalTranslate);
        setPrevTranslate(finalTranslate);
        if (containerRef.current) {
            containerRef.current.style.transition = 'transform 0.5s cubic-bezier(0.2, 0.8, 0.2, 1)';
        }
    };

    // Update the wheel handler to use performSnap
    const handleWheelOptimized = (e: React.WheelEvent) => {
        const delta = Math.abs(e.deltaX) > Math.abs(e.deltaY) ? e.deltaX : e.deltaY;

        // Immediate update
        setCurrentTranslate(prev => prev - delta * 2);

        // Clear existing transition
        if (containerRef.current) containerRef.current.style.transition = 'none';

        // Debounce snap
        if (wheelTimeoutRef.current) clearTimeout(wheelTimeoutRef.current);
        wheelTimeoutRef.current = setTimeout(performSnap, 100);
    };

    return (
        <div
            className="fixed inset-0 w-full h-[100dvh] bg-black text-white font-sans flex flex-col overflow-hidden select-none"
            style={{ overscrollBehavior: 'none' }}
            onWheel={handleWheelOptimized}
        >
            {/* Dynamic Space Background */}
            <div className="absolute inset-0 z-0 pointer-events-none bg-black">
                <StarBackground />
                <ShootingStars />

                {/* SOLID DISTANT SUN - ULTRA HIGH DETAIL */}
                <div className="absolute top-[-10%] right-[-10%] w-[60vh] h-[60vh] z-0 pointer-events-none">
                    {/* The Corona / Rays */}
                    <div className="absolute inset-0 bg-[radial-gradient(circle,#f59e0b_0%,transparent_70%)] opacity-40 animate-pulse" />

                    {/* Rotating Sun Flares */}
                    <div className="absolute inset-[15%] opacity-30 animate-spin-slower"
                        style={{
                            background: 'conic-gradient(from 0deg, transparent 0%, #f59e0b 5%, transparent 10%, #fbbf24 15%, transparent 20%, #f59e0b 25%, transparent 30%, #fb923c 35%, transparent 40%)',
                            filter: 'blur(15px)'
                        }}
                    />
                    );

                    {/* The Solid Body - REMOVED RING / INCREASED DETAIL */}
                    <div className="absolute inset-[25%] rounded-full bg-[#fcd34d] shadow-[0_0_120px_rgba(245,158,11,0.6),inset_-40px_-40px_80px_rgba(0,0,0,0.8),inset_20px_20px_40px_rgba(255,255,255,0.4)] overflow-hidden">
                        {/* Base Surface with Solar Granulation */}
                        <div className="absolute inset-0 bg-gradient-to-br from-yellow-400 via-orange-500 to-red-600" />

                        {/* High Detail Noise Overlay (Granulation) */}
                        <div className="absolute inset-0 opacity-40 mix-blend-overlay bg-[url('https://www.transparenttextures.com/patterns/stardust.png')] filter contrast-150 scale-150" />

                        {/* Conic Swirl (Solar Rotation) */}
                        <div className="absolute inset-0 opacity-30 animate-spin-slow"
                            style={{ background: 'conic-gradient(from 0deg, #f59e0b, #fbbf24, #ef4444, #f59e0b)', filter: 'blur(20px)' }} />

                        {/* High Detail Sunspots (Realistic Texture) */}
                        <div className="absolute top-[25%] left-[30%] w-12 h-10 bg-black/80 rounded-full blur-[3px] rotate-45 mix-blend-multiply" />
                        <div className="absolute top-[28%] left-[33%] w-6 h-5 bg-black/90 rounded-full blur-[1px]" />

                        <div className="absolute bottom-[35%] right-[20%] w-14 h-12 bg-black/60 rounded-full blur-[5px] -rotate-12 mix-blend-multiply" />
                        <div className="absolute bottom-[38%] right-[23%] w-7 h-6 bg-black/80 rounded-full blur-[2px]" />

                        <div className="absolute top-[55%] left-[50%] w-5 h-5 bg-black/70 rounded-full blur-[2px] opacity-60" />

                        {/* Specular Highlights */}
                        <div className="absolute top-[10%] left-[10%] w-full h-full bg-radial-gradient from-white/20 to-transparent blur-[40px]" />
                    </div>

                    {/* Intense Bloom */}
                    <div className="absolute inset-[20%] rounded-full bg-yellow-400/10 blur-[80px]" />
                </div>
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

            <div className="absolute top-6 right-4 z-50 flex items-center gap-3 w-full max-w-[320px] pointer-events-none">
                {/* Made container full width within max-width constraints, buttons flex-1 for equal sizing */}
                <div className="flex items-stretch bg-black/40 rounded-full backdrop-blur-md border border-white/10 shadow-xl overflow-hidden w-full pointer-events-auto">
                    {/* Money Section - LEFT */}
                    <button
                        ref={moneyRef}
                        onClick={() => navigate('/points', { state: { from: 'prestige' } })}
                        className="flex-1 flex items-center justify-center gap-2 px-4 py-3 hover:bg-white/10 transition-colors relative border-r border-white/10 group"
                    >
                        <PointsCoin size="sm" />
                        <span className="text-amber-400 font-bold text-sm tabular-nums group-hover:scale-105 transition-transform">{userPoints.balance.toLocaleString()}</span>

                        {/* Floating Change Label */}
                        {balanceChanges.filter(c => c.type === 'points').map(c => (
                            <div key={c.id} className="absolute -bottom-8 left-1/2 -translate-x-1/2 text-amber-500 font-black text-xs animate-bounce whitespace-nowrap drop-shadow-lg scale-125 z-50">
                                {c.amount > 0 ? '+' : ''}{c.amount.toLocaleString()}
                            </div>
                        ))}
                    </button>

                    {/* Stardust Section - RIGHT */}
                    <button
                        ref={stardustRef}
                        onClick={() => navigate('/stardust', { state: { from: 'prestige' } })}
                        className="flex-1 flex items-center justify-center gap-2 px-4 py-3 hover:bg-white/10 transition-colors relative group"
                    >
                        <PointsCoin type="stardust" size="sm" className="group-hover:rotate-12 transition-transform" />
                        <span className="text-purple-300 font-bold text-sm tabular-nums group-hover:scale-105 transition-transform">{currentStardust.toLocaleString()}</span>

                        {/* Floating Change Label */}
                        {balanceChanges.filter(c => c.type === 'stardust').map(c => (
                            <div key={c.id} className="absolute -bottom-8 left-1/2 -translate-x-1/2 text-purple-400 font-black text-xs animate-bounce whitespace-nowrap drop-shadow-lg scale-125 z-50">
                                {c.amount > 0 ? '+' : ''}{c.amount.toLocaleString()}
                            </div>
                        ))}
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

                                    {/* PLANET NAME - Visually Centered (Compensating for letter spacing) */}
                                    <div className={`text-center transition-all duration-700 ${distance === 0 ? 'opacity-100 translate-y-0 scale-100' : 'opacity-0 translate-y-4 scale-95'} pointer-events-none absolute -top-24 w-full flex flex-col items-center justify-center pl-[0.2em]`}>
                                        <div className="relative">
                                            <h2 className="text-6xl md:text-8xl font-black uppercase tracking-[0.4em] text-transparent bg-clip-text bg-gradient-to-b from-white via-white/70 to-white/10 drop-shadow-[0_10px_30px_rgba(255,255,255,0.2)] font-mono leading-none mr-[-0.4em]">
                                                {name}
                                            </h2>
                                        </div>
                                        <div className="h-1 w-24 bg-gradient-to-r from-transparent via-white/20 to-transparent mt-4 mr-[0.2em]" />
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
                            <span className={`px-6 py-2.5 rounded-2xl bg-white/5 border border-white/10 text-[11px] uppercase tracking-[0.4em] font-black shadow-2xl backdrop-blur-2xl transition-all duration-500
                                ${isFuturePlanet ? 'text-white/20' : isViewedPlanetCompleted ? 'text-amber-400 border-amber-500/30' : 'text-white/40'}`}>
                                {isViewedPlanetCompleted ? 'Planet Mastery Attained' : isFuturePlanet ? 'Coordinates Locked' : `System Status: Level ${level}`}
                            </span>
                        </div>

                        {/* 4-Vertex Progress Bar - VISIBILITY RESTORED */}
                        <div className="relative w-full h-[5px] flex items-center justify-between">
                            {/* Track Background */}
                            <div className="absolute inset-0 bg-white/10 rounded-full" />

                            {/* Filling Effect */}
                            <div
                                className="absolute left-0 top-0 h-full bg-gradient-to-r from-[#FFCC00] via-amber-400 to-[#FFCC00] rounded-full transition-all duration-1000 shadow-[0_0_20px_rgba(251,191,36,0.6)]"
                                style={{ width: `${displayedStars > 0 ? ((Math.min(4, displayedStars) - 1) / 3) * 100 : 0}%` }}
                            />

                            {/* Vertices (4 Dots) - Z-Index Boosted */}
                            {[1, 2, 3, 4].map((i) => {
                                // Logic: 
                                // i=1: One Star Achieved
                                // i=2: Two Stars Achieved
                                // i=3: Three Stars Achieved
                                // i=4: Next Level Achieved (Evolution Ready)
                                const isReached = displayedStars >= i;
                                const labels = ["One Star", "Two Stars", "Three Stars", "Next Level"];
                                return (
                                    <div key={i} className="relative z-20 flex flex-col items-center">
                                        {/* Dot with glow */}
                                        <div
                                            className={`w-5 h-5 rounded-full transition-all duration-700 border-2 ${isReached
                                                ? 'bg-[#FFCC00] border-amber-200 scale-110 shadow-[0_0_20px_rgba(251,191,36,0.8)]'
                                                : 'bg-[#050505] border-white/10 scale-90'
                                                }`}
                                        />
                                        {/* Vertex Labels - RESTORED */}
                                        <div className={`absolute -bottom-14 whitespace-nowrap flex flex-col items-center transition-all duration-700 ${isReached ? 'opacity-100 translate-y-0' : 'opacity-30 translate-y-4'}`}>
                                            <span className={`text-[10px] font-black uppercase tracking-[0.15em] ${i === 4 ? 'text-amber-400' : 'text-white/70'}`}>
                                                {labels[i - 1]}
                                            </span>
                                            <div className="mt-2 flex items-center justify-center">
                                                {i === 4 ? (
                                                    <span className={`material-symbols-outlined text-xl ${isReached ? 'text-amber-400' : 'text-white/20'} transition-colors`}>
                                                        {isReached ? 'check_circle' : 'rocket_launch'}
                                                    </span>
                                                ) : (
                                                    <div className="flex gap-0.5">
                                                        {Array.from({ length: i }).map((_, si) => (
                                                            <span key={si} className={`material-symbols-outlined text-[10px] ${isReached ? 'text-amber-500' : 'text-white/20'}`} style={{ fontVariationSettings: "'FILL' 1" }}>
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
                    <div className="w-full flex flex-col items-center gap-6 pt-10 px-8">
                        {/* Action Button */}
                        <button
                            onClick={() => {
                                if (isViewedPlanetCompleted || isFuturePlanet) {
                                    const targetIndex = Math.min(9, level - 1);
                                    const step = 600;
                                    const finalTranslate = -targetIndex * step;
                                    setActiveIndex(targetIndex);
                                    setCurrentTranslate(finalTranslate);
                                    setPrevTranslate(finalTranslate);
                                    if (containerRef.current) {
                                        containerRef.current.style.transition = 'transform 0.8s cubic-bezier(0.2, 0.8, 0.2, 1)';
                                    }
                                } else {
                                    handleInject();
                                }
                            }}
                            disabled={!canUpgrade && !isViewedPlanetCompleted && !isFuturePlanet}
                            className={`w-full max-w-sm h-20 rounded-[32px] font-black text-[13px] tracking-[0.3em] uppercase flex flex-col items-center justify-center gap-1 transition-all duration-400 relative overflow-hidden group shadow-[0_20px_40px_-15px_rgba(0,0,0,0.5)]
                                    ${isViewedPlanetCompleted || isFuturePlanet
                                    ? 'bg-white/10 hover:bg-white/15 text-white/80 border border-white/10'
                                    : canUpgrade
                                        ? 'bg-[#FFCC00] hover:bg-[#ffda33] text-black hover:translate-y-[-2px] active:translate-y-[1px]'
                                        : 'bg-white/5 text-white/10 cursor-not-allowed border border-white/5'}`}
                        >
                            <div className="flex items-center gap-2.5 z-10 transition-transform group-hover:scale-110">
                                <span className="material-symbols-outlined text-2xl font-black">
                                    {isViewedPlanetCompleted ? 'keyboard_double_arrow_right' : isFuturePlanet ? 'lock' : displayedStars >= 4 ? 'auto_mode' : 'offline_bolt'}
                                </span>
                                <span className="drop-shadow-sm font-black">
                                    {isViewedPlanetCompleted ? 'Move to Current Planet' : isFuturePlanet ? 'Locked' : displayedStars >= 4 ? 'Evolve Planet' : 'Inject Stardust'}
                                </span>
                            </div>
                            {!isViewedPlanetCompleted && !isFuturePlanet && (
                                <span className={`text-[11px] z-10 tracking-widest transition-opacity duration-300 ${canUpgrade ? 'text-black/50 font-black' : 'text-white/5'}`}>
                                    {nextStarCost.toLocaleString()} UNITS
                                </span>
                            )}
                            {canUpgrade && !isViewedPlanetCompleted && !isFuturePlanet && <div className="absolute inset-0 bg-[radial-gradient(circle_at_center,rgba(255,255,255,0.4)_0%,transparent_70%)] opacity-0 group-hover:opacity-100 transition-opacity duration-500" />}
                        </button>

                        {/* Market/Buy Panel */}
                        <div className="w-full flex flex-col items-center gap-3">
                            <div className="w-full max-w-sm h-16 bg-black/60 backdrop-blur-2xl rounded-2xl border border-white/10 flex items-center justify-between px-1.5 py-1.5 gap-2 shadow-2xl relative">
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
                                        type="text"
                                        inputMode="numeric"
                                        pattern="[0-9]*"
                                        min="0"
                                        value={buyAmount === 0 ? '' : buyAmount}
                                        placeholder="0"
                                        onChange={(e) => {
                                            const val = e.target.value;
                                            if (val === '') {
                                                setBuyAmount(0);
                                            } else {
                                                const parsed = parseInt(val.replace(/\D/g, ''));
                                                if (!isNaN(parsed)) setBuyAmount(parsed);
                                            }
                                        }}
                                        autoComplete="off"
                                        spellCheck="false"
                                        className="bg-transparent w-full h-full outline-none font-black text-white text-center text-xl appearance-none m-0 p-0 shadow-none border-none ring-0 no-spin caret-[#FFCC00]"
                                    />
                                </div>
                                {/* Buy Button */}
                                <button
                                    ref={buyButtonRef}
                                    onClick={handleBuy}
                                    disabled={isBuying || userPoints.balance < buyAmount || buyAmount <= 0}
                                    className={`h-full px-8 font-black text-[11px] uppercase tracking-[0.2em] rounded-xl transition-all shadow-[0_10px_20px_-10px_rgba(255,204,0,0.5)] active:scale-95 disabled:opacity-30 disabled:grayscale disabled:cursor-not-allowed whitespace-nowrap flex items-center justify-center relative overflow-hidden
                                        ${isBuying ? 'bg-white/10 text-white' : 'bg-[#FFCC00] hover:bg-[#ffda33] text-black'}`}
                                >
                                    {isBuying ? <span className="material-symbols-outlined animate-spin text-sm">refresh</span> : 'Purchase'}
                                </button>
                            </div>

                            {/* Receive Info */}
                            {buyAmount > 0 && (
                                <div className="flex items-center gap-2 text-[10px] uppercase tracking-[0.3em] font-black text-white/30 animate-in fade-in slide-in-from-bottom-1 duration-500">
                                    <span>You will receive</span>
                                    <div className="flex items-center gap-1 text-purple-400">
                                        <span className="text-sm font-black text-purple-300">{(buyAmount * 10).toLocaleString()}</span>
                                        <span className="material-symbols-outlined text-xs" style={{ fontVariationSettings: "'FILL' 1" }}>auto_awesome</span>
                                    </div>
                                </div>
                            )}
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
                        /* Fix autofill blue bar */
                        input:-webkit-autofill,
                        input:-webkit-autofill:hover, 
                        input:-webkit-autofill:focus,
                        input:-webkit-autofill:active {
                            -webkit-box-shadow: 0 0 0 1000px black inset !important;
                            -webkit-text-fill-color: white !important;
                            transition: background-color 5000s ease-in-out 0s;
                        }
                        @keyframes spin {
                            from { transform: rotate(0deg); }
                            to { transform: rotate(360deg); }
                        }
                        .animate-spin-slow {
                            animation: spin 30s linear infinite;
                        }
                        .animate-spin-slower {
                            animation: spin 60s linear infinite;
                        }
                        @keyframes pulse-slow {
                            0%, 100% { opacity: 0.3; }
                            50% { opacity: 0.6; }
                        }
                        .animate-pulse-slow {
                            animation: pulse-slow 4s ease-in-out infinite;
                        }
                    `}} />
        </div >
    );
};

const FlyingItem = ({ item, onComplete }: { item: { type: 'coin' | 'stardust' | 'cosmic'; start: Rect; end: Rect }; onComplete: () => void }) => {
    const isCosmic = item.type === 'cosmic';
    const duration = isCosmic ? 1.8 : 1.2;

    const [style, setStyle] = useState<React.CSSProperties>({
        top: item.start.top,
        left: item.start.left,
        opacity: isCosmic ? 0 : 1,
        transform: isCosmic ? 'scale(0.5) rotate(-45deg)' : 'scale(1) rotate(0deg)',
        position: 'fixed',
        zIndex: 1000,
        pointerEvents: 'none',
        transition: `all ${duration}s cubic-bezier(0.34, 1.56, 0.64, 1)`
    });

    useEffect(() => {
        // Trigger flight next tick
        requestAnimationFrame(() => {
            setStyle({
                top: item.end.top,
                left: item.end.left,
                opacity: isCosmic ? 1 : 0,
                transform: isCosmic ? 'scale(1.2) rotate(720deg)' : 'scale(0.3) rotate(720deg)',
                position: 'fixed',
                zIndex: 1000,
                pointerEvents: 'none',
                transition: `all ${duration}s ${isCosmic ? 'cubic-bezier(0.16, 1, 0.3, 1)' : 'cubic-bezier(0.2, 1, 0.3, 1)'}`
            });

            // If cosmic, fade out at the very end
            if (isCosmic) {
                setTimeout(() => {
                    setStyle(prev => ({ ...prev, opacity: 0, transform: 'scale(0.5) rotate(1080deg)', transition: 'all 0.4s ease-out' }));
                }, (duration - 0.4) * 1000);
            }
        });

        const timer = setTimeout(onComplete, duration * 1000 + 400);
        return () => clearTimeout(timer);
    }, []);

    return (
        <div style={style}>
            {item.type === 'coin' ? (
                <PointsCoin size="sm" animate />
            ) : item.type === 'stardust' ? (
                <div className="relative">
                    <span className="material-symbols-outlined text-purple-400 text-2xl drop-shadow-[0_0_15px_rgba(192,132,252,1)]" style={{ fontVariationSettings: "'FILL' 1" }}>
                        auto_awesome
                    </span>
                    <div className="absolute inset-0 bg-purple-500/20 blur-md rounded-full scale-110" />
                </div>
            ) : (
                /* Cinematic Large Cosmic Star */
                <div className="relative group">
                    {/* Primary Star */}
                    <div className="relative z-10 w-12 h-12 bg-gradient-to-br from-purple-300 via-purple-500 to-indigo-600 rounded-2xl flex items-center justify-center shadow-[0_0_30px_rgba(168,85,247,0.8)] rotate-12 animate-pulse">
                        <span className="material-symbols-outlined text-white text-3xl font-bold" style={{ fontVariationSettings: "'FILL' 1" }}>auto_awesome</span>
                    </div>
                    {/* Trailing Glow / Aura */}
                    <div className="absolute inset-[-20px] bg-purple-500/30 blur-2xl rounded-full animate-pulse decoration-clone" />
                    <div className="absolute inset-[-10px] border-2 border-purple-400/50 rounded-2xl rotate-45 animate-spin duration-[3s]" />
                </div>
            )}
        </div>
    );
};
