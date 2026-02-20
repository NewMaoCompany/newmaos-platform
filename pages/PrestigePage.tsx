
import React, { useState, useMemo, useRef, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { useApp } from '../AppContext';

import { StarBackground, ShootingStars, PlanetVisual, getPlanetName } from '../components/SpaceVisuals';
import { PointsCoin } from '../components/PointsCoin';
import { ProGateOverlay } from '../components/ProGateOverlay';

// Shared Audio Context to prevent reaching hardware limit 
let sharedAudioCtx: AudioContext | null = null;

// Simple Synth for Sound Effects (reused logic)
const playSound = (type: 'coin' | 'stardust' | 'celebration') => {
    try {
        if (!sharedAudioCtx) {
            const AudioContextClass = (window as any).AudioContext || (window as any).webkitAudioContext;
            sharedAudioCtx = new AudioContextClass();
        }
        const ctx = sharedAudioCtx;

        // Resume if suspended (browser autoplay policy)
        if (ctx.state === 'suspended') {
            ctx.resume();
        }

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
    const { user, userPoints, userPrestige, purchaseStardust, injectStardust, isPro } = useApp();
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

    // Clamped Variables for Corrupted State Protection
    const rawLevel = userPrestige?.planet_level || 1;
    const level = Math.min(5, rawLevel);
    const stars = rawLevel >= 5 ? Math.min(3, userPrestige?.star_level || 0) : (userPrestige?.star_level || 0);
    const currentStardust = userPrestige?.current_stardust || 0;

    const [flyItems, setFlyItems] = useState<{ id: number; type: 'coin' | 'stardust' | 'cosmic'; start: Rect; end: Rect; burst?: { x: number; y: number; rotate: number } }[]>([]);
    const [balanceChanges, setBalanceChanges] = useState<{ id: number; type: 'points' | 'stardust'; amount: number; location: string }[]>([]);

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

    const isMaxLevel = level >= 5 && stars >= 3;
    const canUpgrade = currentStardust >= nextStarCost && !isMaxLevel;
    const isViewedPlanetCompleted = (activeIndex + 1) < level;
    const isReadyToEvolve = stars >= 4;
    const isFuturePlanet = (activeIndex + 1) > level;

    // Refs for Animation Targets
    const moneyRef = useRef<HTMLButtonElement>(null);
    const stardustRef = useRef<HTMLButtonElement>(null);
    const buyButtonRef = useRef<HTMLButtonElement>(null);
    const injectButtonRef = useRef<HTMLButtonElement>(null);

    const handleBuy = async () => {
        if (!buyButtonRef.current || !moneyRef.current) return;
        setIsBuying(true);

        // Show -Points label at the points wallet when coins begin to leave
        const coinLabelId = Date.now() + Math.random();
        setBalanceChanges(prev => [...prev, { id: coinLabelId, type: 'points', amount: -buyAmount, location: 'points-wallet' }]);
        setTimeout(() => setBalanceChanges(prev => prev.filter(l => l.id !== coinLabelId)), 2000);

        // 1. Coin Animation (Money -> Buy Button)
        const startRect = moneyRef.current.getBoundingClientRect();
        const endRect = buyButtonRef.current.getBoundingClientRect();

        // Spawn multiple coins slowly
        for (let i = 0; i < 5; i++) {
            setTimeout(() => {
                playSound('coin');
                const burstAngle = (Math.PI * 2 * i) / 5 + (Math.random() - 0.5) * 0.4;
                const burstDist = 30 + Math.random() * 20;

                setFlyItems(prev => [...prev, {
                    id: Date.now() + Math.random(),
                    type: 'coin',
                    start: { top: startRect.top, left: startRect.left, width: startRect.width, height: startRect.height },
                    end: { top: endRect.top + endRect.height / 2, left: endRect.left + endRect.width / 2, width: 0, height: 0 },
                    burst: { x: Math.cos(burstAngle) * burstDist, y: Math.sin(burstAngle) * burstDist, rotate: Math.random() * 360 }
                }]);
            }, i * 150); // Slower spacing
        }

        // Wait for coins to arrive (longer duration)
        await new Promise(r => setTimeout(r, 1200));

        // 2. Perform Purchase
        const result = await purchaseStardust(buyAmount);

        if (result.success) {
            // 3. Stardust Swarm Animation (Buy Button -> Stardust Counter)
            if (stardustRef.current) {
                const stardustEnd = stardustRef.current.getBoundingClientRect();
                const stardustStart = buyButtonRef.current.getBoundingClientRect();

                // Swarm effect (12 items)
                const count = 12;
                for (let i = 0; i < count; i++) {
                    setTimeout(() => {
                        playSound('stardust');
                        const burstAngle = (Math.PI * 2 * i) / count + (Math.random() - 0.5) * 0.4;
                        const burstDist = 40 + Math.random() * 30;

                        setFlyItems(prev => [...prev, {
                            id: Date.now() + Math.random(),
                            type: 'stardust',
                            start: { top: stardustStart.top + stardustStart.height / 2, left: stardustStart.left + stardustStart.width / 2, width: 0, height: 0 },
                            end: { top: stardustEnd.top + stardustEnd.height / 2, left: stardustEnd.left + stardustEnd.width / 2, width: 0, height: 0 },
                            burst: { x: Math.cos(burstAngle) * burstDist, y: Math.sin(burstAngle) * burstDist, rotate: Math.random() * 360 }
                        }]);
                    }, i * 100);
                }

                // Show +Stardust label after flight completes
                setTimeout(() => {
                    const stardustLabelId = Date.now() + 1;
                    setBalanceChanges(prev => [...prev, { id: stardustLabelId, type: 'stardust', amount: buyAmount * 10, location: 'stardust-wallet' }]);
                    setTimeout(() => setBalanceChanges(prev => prev.filter(l => l.id !== stardustLabelId)), 2500);
                }, count * 100 + 1200);
            }
        }
        else {
            alert(result.message || 'Purchase failed');
        }

        setIsBuying(false);
    };

    const handleInject = async () => {
        const result = await injectStardust(nextStarCost);
        if (result.success) {
            // Show -Stardust label at the stardust wallet
            const labelId = Date.now();
            setBalanceChanges(prev => [...prev, { id: labelId, type: 'stardust', amount: -nextStarCost, location: 'stardust-wallet' }]);
            setTimeout(() => setBalanceChanges(prev => prev.filter(l => l.id !== labelId)), 2000);
        } else {
            alert(result.message || 'Injection failed');
        }
    };

    const lastLevelRef = useRef(level);

    // Initialize/Auto-scroll when level changes
    useEffect(() => {
        const targetIndex = Math.min(4, Math.max(0, level - 1));
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
        const nextTranslate = prevTranslate + diff * 0.85;
        // Clamp to valid range [-2400, 0] (5 planets * 600px step)
        // Allow tiny overscroll resistance? For now, strict clamp to fix "out of boundary" issue.
        setCurrentTranslate(Math.max(-2400, Math.min(0, nextTranslate)));
    };

    const handleTouchEnd = () => {
        setIsDragging(false);
        setDragStartX(null);

        // Snap Logic
        const step = 600; // Wide spacing
        // Calculate nearest index
        let nextIndex = -Math.round(currentTranslate / step);
        // Clamp to valid range [0, 4]
        nextIndex = Math.max(0, Math.min(4, nextIndex));

        setActiveIndex(nextIndex);

        const finalTranslate = -nextIndex * step;
        setCurrentTranslate(finalTranslate);
        setPrevTranslate(finalTranslate);

        if (containerRef.current) {
            containerRef.current.style.transition = 'transform 0.4s cubic-bezier(0.2, 0.8, 0.2, 1)';
        }
    };

    // Wheel Event Handler for Trackpad
    const wheelTimeoutRef = useRef<NodeJS.Timeout | null>(null);
    const lastWheelTime = useRef(0); // Cooldown tracker

    // Ref for currentTranslate to access in timeout
    const currentTranslateRef = useRef(currentTranslate);
    useEffect(() => { currentTranslateRef.current = currentTranslate; }, [currentTranslate]);

    const performSnap = () => {
        const step = 600;
        let nextIndex = -Math.round(currentTranslateRef.current / step);
        nextIndex = Math.max(0, Math.min(4, nextIndex));
        setActiveIndex(nextIndex);
        const finalTranslate = -nextIndex * step;
        setCurrentTranslate(finalTranslate);
        setPrevTranslate(finalTranslate);
        if (containerRef.current) {
            containerRef.current.style.transition = 'transform 0.4s cubic-bezier(0.2, 0.8, 0.2, 1)';
        }
    };

    // Update the wheel handler to use DISCRETE NAVIGATION
    const handleWheelOptimized = (e: React.WheelEvent) => {
        const now = Date.now();
        // Cooldown check (800ms)
        if (now - lastWheelTime.current < 800) return;

        const delta = Math.abs(e.deltaX) > Math.abs(e.deltaY) ? e.deltaX : e.deltaY;
        const threshold = 20; // Sensitivity threshold for swipe detection

        if (Math.abs(delta) > threshold) {
            // Positive Delta = Scroll Right/Down = Next Index
            const direction = delta > 0 ? 1 : -1;

            // Calculate next index
            let nextIndex = activeIndex + direction;
            // Clamp [0, 4]
            nextIndex = Math.max(0, Math.min(4, nextIndex));

            if (nextIndex !== activeIndex) {
                setActiveIndex(nextIndex);
                const finalTranslate = -nextIndex * 600;
                setCurrentTranslate(finalTranslate);
                setPrevTranslate(finalTranslate);

                // Animate
                if (containerRef.current) {
                    containerRef.current.style.transition = 'transform 0.6s cubic-bezier(0.22, 1, 0.36, 1)';
                }

                // Set cooldown
                lastWheelTime.current = now;
            }
        }
    };

    return (
        <div
            className="fixed inset-0 w-full h-[100dvh] bg-black text-white font-sans flex flex-col select-none"
            style={{ overscrollBehavior: 'none' }}
            onWheel={handleWheelOptimized}
        >
            {/* Pro Gate */}
            {!isPro && <ProGateOverlay featureName="Prestige" />}
            {/* 
                PHASE 7 GLOW FIX: 
                The root container NO LONGER has 'overflow-hidden'. 
                This ensures the Sun's massive atmospheric glow is never clipped into a square.
                Background stars/shimmer are moved to a child container.
            */}
            <div className="absolute inset-0 z-0 pointer-events-none bg-black overflow-hidden">
                <StarBackground />
                <ShootingStars />
            </div>

            <div className="relative flex-1 flex flex-col items-center justify-center z-10 overflow-x-hidden">
                {/* CINEMATIC SOLAR SYSTEM (Sun Removed) */}

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

            <div className="absolute top-6 right-4 z-50 flex items-center gap-3 w-full max-w-[320px] pointer-events-auto">
                {/* Made container full width within max-width constraints, buttons flex-1 for equal sizing */}
                <div className="flex items-stretch bg-black/40 rounded-full backdrop-blur-md border border-white/10 shadow-xl w-full">
                    {/* Money Section - LEFT */}
                    <button
                        ref={moneyRef}
                        onClick={() => navigate('/points')}
                        className="flex-1 flex items-center justify-center gap-2 px-4 py-3 hover:bg-white/10 transition-colors relative border-r border-white/10 rounded-l-full group"
                    >
                        <PointsCoin size="sm" />
                        <span className="text-amber-400 font-bold text-sm tabular-nums group-hover:scale-105 transition-transform">{userPoints.balance.toLocaleString()}</span>

                        {/* Floating Change Label */}
                        {balanceChanges.filter(c => c.type === 'points' && c.location === 'points-wallet').map((c, i) => (
                            <div key={c.id} className="absolute left-1/2 -translate-x-1/2 text-amber-400 font-black text-lg animate-[flyDownFade_1.5s_ease-out_forwards] whitespace-nowrap drop-shadow-[0_0_10px_rgba(251,191,36,0.6)] z-50 pointer-events-none" style={{ bottom: `-${32 + i * 24}px` }}>
                                {c.amount > 0 ? '+' : ''}{c.amount.toLocaleString()}
                            </div>
                        ))}
                    </button>

                    {/* Stardust Section - RIGHT */}
                    <button
                        ref={stardustRef}
                        onClick={() => navigate('/stardust')}
                        className="flex-1 flex items-center justify-center gap-2 px-4 py-3 hover:bg-white/10 transition-colors relative rounded-r-full group"
                    >
                        <PointsCoin type="stardust" size="sm" className="group-hover:rotate-12 transition-transform" />
                        <span className="text-purple-300 font-bold text-sm tabular-nums group-hover:scale-105 transition-transform">{currentStardust.toLocaleString()}</span>

                        {/* Floating Change Label */}
                        {balanceChanges.filter(c => c.type === 'stardust' && c.location === 'stardust-wallet').map((c, i) => (
                            <div key={c.id} className="absolute left-1/2 -translate-x-1/2 text-purple-300 font-black text-lg animate-[flyDownFade_1.5s_ease-out_forwards] whitespace-nowrap drop-shadow-[0_0_10px_rgba(192,132,252,0.6)] z-50 pointer-events-none" style={{ bottom: `-${32 + i * 24}px` }}>
                                {c.amount > 0 ? '+' : ''}{c.amount.toLocaleString()}
                            </div>
                        ))}
                    </button>
                </div>
            </div>

            {/* FLYING ITEMS LAYER */}
            {
                flyItems.map(item => (
                    <FlyingItem key={item.id} item={item} onComplete={() => setFlyItems(prev => prev.filter(i => i.id !== item.id))} />
                ))
            }

            {/* GALAXY RING SWIPER */}
            <main
                className="absolute inset-0 z-10 flex flex-col justify-center items-center overflow-hidden"
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
                        {Array.from({ length: 5 }).map((_, i) => {
                            const planetLevel = i + 1;
                            const isUnlocked = planetLevel <= level;
                            const isNext = planetLevel === level + 1;
                            const name = getPlanetName(planetLevel);

                            // Distance from active center
                            const distance = Math.abs(i - activeIndex);
                            // Scale logic
                            const scale = distance === 0 ? 1.2 : Math.max(0.4, 0.8 - (distance * 0.2));
                            const opacity = distance === 0 ? 1 : Math.max(0.3, 0.7 - (distance * 0.15));

                            return (
                                <div
                                    key={i}
                                    className="relative flex flex-col items-center justify-center transition-all duration-500 ease-out"
                                    style={{
                                        width: '600px',
                                        transform: `scale(${scale})`,
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
                                        <div className="transition-all duration-700">
                                            <PlanetVisual level={planetLevel} isUnlocked={isUnlocked} size="xl" className="drop-shadow-[0_0_50px_rgba(255,255,255,0.05)]" />
                                        </div>

                                        {!isUnlocked && (
                                            <div className="absolute top-4 right-4 text-white/30 drop-shadow-md">
                                                <span className="material-symbols-outlined text-4xl">lock</span>
                                            </div>
                                        )}
                                    </div>

                                    {/* PLANET NAME - Visually Centered (Compensating for letter spacing) */}
                                    <div className={`text-center transition-all duration-700 ${distance === 0 ? 'opacity-100 translate-y-[20%] scale-100' : 'opacity-0 translate-y-4 scale-95'} ${!isUnlocked ? 'grayscale brightness-75' : ''} pointer-events-none absolute -top-24 w-full flex flex-col items-center justify-center pl-[0.2em]`}>
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
            <div
                className="absolute bottom-0 w-full z-40 bg-gradient-to-t from-black via-black/80 to-transparent pb-16 pt-40 px-4 flex flex-col items-center pointer-events-none transition-transform duration-700 ease-in-out"
                style={{ transform: 'translateX(0)' }}
            >
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

                        {/* Dynamic Progress Bar - 3 Vertices for Fulata, 4 for others */}
                        {(() => {
                            const isFulata = (activeIndex + 1) === 5;
                            const vertices = isFulata ? [1, 2, 3] : [1, 2, 3, 4];
                            const maxNodes = vertices.length;
                            const fillPercentage = displayedStars > 0 ? ((Math.min(maxNodes, displayedStars) - 1) / (maxNodes - 1)) * 100 : 0;

                            return (
                                <div className="relative w-full h-[5px] flex items-center isolate overflow-visible mt-3 mb-3">
                                    {/* Track Background */}
                                    <div className="absolute left-[10px] right-[10px] top-0 bottom-0 bg-white/10 rounded-full shadow-inner" />

                                    {/* Filling Effect */}
                                    <div className="absolute left-[10px] right-[10px] top-0 bottom-0">
                                        <div
                                            className="absolute left-0 top-0 bottom-0 bg-gradient-to-r from-[#FFCC00] via-amber-400 to-[#FFCC00] rounded-full transition-all duration-1000 shadow-[0_0_20px_rgba(251,191,36,0.6)] z-10"
                                            style={{ width: `${fillPercentage}%` }}
                                        />
                                    </div>

                                    {/* Vertices */}
                                    <div className="absolute inset-x-0 flex justify-between items-center z-20 pointer-events-none">
                                        {vertices.map((i) => {
                                            const isReached = displayedStars >= i;
                                            const labels = isFulata ? ["One Star", "Two Stars", "Max Mastery"] : ["One Star", "Two Stars", "Three Stars", "Next Level"];
                                            const isLastNode = i === maxNodes;

                                            return (
                                                <div key={i} className="relative z-20 flex flex-col items-center shrink-0 w-5 h-5 pointer-events-auto">
                                                    {/* Dot with glow */}
                                                    <div
                                                        className={`absolute inset-0 rounded-full transition-all duration-700 border-2 ${isReached
                                                            ? 'bg-[#FFCC00] border-amber-200 scale-110 shadow-[0_0_20px_rgba(251,191,36,0.8)]'
                                                            : 'bg-[#050505] border-white/10 scale-90'
                                                            }`}
                                                    />
                                                    {/* Vertex Labels */}
                                                    <div className={`absolute -bottom-14 whitespace-nowrap flex flex-col items-center transition-all duration-700 ${isReached ? 'opacity-100 translate-y-0' : 'opacity-30 translate-y-4'}`}>
                                                        <span className={`text-[10px] font-black uppercase tracking-[0.15em] ${isLastNode ? 'text-amber-400' : 'text-white/70'}`}>
                                                            {labels[i - 1]}
                                                        </span>
                                                        <div className="mt-2 flex items-center justify-center">
                                                            {isLastNode ? (
                                                                <span className={`material-symbols-outlined text-xl ${isReached ? 'text-amber-400' : 'text-white/20'} transition-colors`}>
                                                                    {isReached ? 'check_circle' : (isFulata ? 'stars' : 'rocket_launch')}
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
                            );
                        })()}

                    </div>

                    {/* Controls */}
                    <div className="w-full flex flex-col items-center gap-6 pt-10 px-8">
                        {/* Action Button */}
                        {(!isMaxLevel || activeIndex < 4) && (
                            <button
                                ref={injectButtonRef}
                                onClick={() => {
                                    if (isViewedPlanetCompleted || isFuturePlanet) {
                                        const targetIndex = Math.min(4, level - 1);
                                        const step = 600;
                                        const finalTranslate = -targetIndex * step;
                                        setActiveIndex(targetIndex);
                                        setCurrentTranslate(finalTranslate);
                                        setPrevTranslate(finalTranslate);
                                        if (containerRef.current) {
                                            containerRef.current.style.transition = 'transform 0.8s cubic-bezier(0.2, 0.8, 0.2, 1)';
                                        }
                                    } else if (!isMaxLevel) {
                                        handleInject();
                                    }
                                }}
                                disabled={!canUpgrade && !isViewedPlanetCompleted && !isFuturePlanet}
                                className={`w-full max-w-sm h-20 rounded-[32px] font-black text-[13px] tracking-[0.3em] uppercase flex flex-col items-center justify-center gap-1 transition-all duration-400 relative overflow-hidden group shadow-[0_20px_40px_-15px_rgba(0,0,0,0.5)]
                                    ${isViewedPlanetCompleted || isFuturePlanet
                                        ? 'bg-white/10 hover:bg-white/15 text-white/80 border border-white/10'
                                        : isMaxLevel
                                            ? 'bg-amber-400/20 text-amber-500/50 cursor-not-allowed border-2 border-amber-500/20 shadow-[0_0_30px_rgba(251,191,36,0.1)_inset]'
                                            : canUpgrade
                                                ? 'bg-[#FFCC00] hover:bg-[#ffda33] text-black hover:translate-y-[-2px] active:translate-y-[1px]'
                                                : 'bg-white/5 text-white/10 cursor-not-allowed border border-white/5'}`}
                            >
                                <div className="flex items-center gap-2.5 z-10 transition-transform group-hover:scale-110">
                                    <span className="material-symbols-outlined text-2xl font-black">
                                        {isViewedPlanetCompleted ? 'keyboard_double_arrow_right' : isFuturePlanet ? 'lock' : isMaxLevel ? 'public' : displayedStars >= 4 ? 'auto_mode' : 'offline_bolt'}
                                    </span>
                                    <span className="drop-shadow-sm font-black">
                                        {isViewedPlanetCompleted ? 'Move to Current Planet' : isFuturePlanet ? 'Locked' : isMaxLevel ? 'Current Planet' : displayedStars >= 4 ? 'Evolve Planet' : 'Inject Stardust'}
                                    </span>
                                </div>
                                {!isViewedPlanetCompleted && !isFuturePlanet && !isMaxLevel && (
                                    <span className={`text-[11px] z-10 tracking-widest transition-opacity duration-300 ${canUpgrade ? 'text-black/50 font-black' : 'text-white/5'}`}>
                                        {nextStarCost.toLocaleString()} UNITS
                                    </span>
                                )}
                                {canUpgrade && !isViewedPlanetCompleted && !isFuturePlanet && <div className="absolute inset-0 bg-[radial-gradient(circle_at_center,rgba(255,255,255,0.4)_0%,transparent_70%)] opacity-0 group-hover:opacity-100 transition-opacity duration-500" />}

                                {/* Floating Change Label */}
                                {balanceChanges.filter(c => c.type === 'stardust' && c.location === 'inject-button').map(c => (
                                    <div key={c.id} className="absolute -top-12 left-1/2 -translate-x-1/2 text-purple-400 font-black text-2xl animate-bounce whitespace-nowrap drop-shadow-[0_0_15px_rgba(168,85,247,0.6)] z-50">
                                        {c.amount > 0 ? '+' : ''}{c.amount.toLocaleString()}
                                    </div>
                                ))}
                            </button>
                        )}

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
                        @keyframes flyUpFade {
                            0% { transform: translate(-50%, 0px) scale(0.8); opacity: 0; }
                            20% { transform: translate(-50%, -10px) scale(1.1); opacity: 1; }
                            80% { transform: translate(-50%, -25px) scale(1); opacity: 1; }
                            100% { transform: translate(-50%, -35px) scale(0.9); opacity: 0; }
                        }
                        @keyframes flyDownFade {
                            0% { transform: translate(-50%, 0px) scale(0.8); opacity: 0; }
                            20% { transform: translate(-50%, 10px) scale(1.1); opacity: 1; }
                            80% { transform: translate(-50%, 25px) scale(1); opacity: 1; }
                            100% { transform: translate(-50%, 35px) scale(0.9); opacity: 0; }
                        }
                    `}} />
        </div >
    );
};

const FlyingItem = ({ item, onComplete }: { item: { type: 'coin' | 'stardust' | 'cosmic'; start: Rect; end: Rect; burst?: { x: number; y: number; rotate: number } }; onComplete: () => void }) => {
    const isCosmic = item.type === 'cosmic';
    const isStardust = item.type === 'stardust';
    const duration = isCosmic ? 2.0 : (isStardust ? 1.4 : 1.2);
    const burstDuration = 0.4;
    const flyDuration = duration - burstDuration;

    const [style, setStyle] = useState<React.CSSProperties>({
        top: item.start.top,
        left: item.start.left,
        opacity: 0,
        transform: 'translate(-50%, -50%) scale(0) rotate(0deg)',
        position: 'fixed',
        zIndex: 1000,
        pointerEvents: 'none',
    });

    useEffect(() => {
        // Phase 1: Burst
        requestAnimationFrame(() => {
            setStyle({
                top: item.start.top,
                left: item.start.left,
                opacity: 1,
                transform: `translate(${item.burst?.x || 0}px, ${item.burst?.y || 0}px) scale(1) rotate(${item.burst?.rotate || 0}deg)`,
                position: 'fixed',
                zIndex: 1000,
                pointerEvents: 'none',
                transition: `all ${burstDuration}s cubic-bezier(0.175, 0.885, 0.32, 1.275)`
            });
        });

        // Phase 2: Flight
        const flyTimer = setTimeout(() => {
            setStyle({
                top: item.end.top,
                left: item.end.left,
                opacity: isCosmic ? 1 : 0,
                transform: `translate(0, 0) scale(${isCosmic ? 1.2 : 0.4}) rotate(${isCosmic ? 720 : 360}deg)`,
                position: 'fixed',
                zIndex: 1000,
                pointerEvents: 'none',
                transition: `all ${flyDuration}s cubic-bezier(0.5, 0, 0.5, 1)`
            });

            if (isCosmic) {
                setTimeout(() => {
                    setStyle(prev => ({ ...prev, opacity: 0, transform: 'scale(0.5) rotate(1080deg)', transition: 'all 0.4s ease-out' }));
                }, (flyDuration - 0.4) * 1000);
            }
        }, burstDuration * 1000);

        const completeTimer = setTimeout(onComplete, duration * 1000 + 400);
        return () => {
            clearTimeout(flyTimer);
            clearTimeout(completeTimer);
        };
    }, []);

    return (
        <div style={style}>
            {item.type === 'coin' ? (
                <PointsCoin size="md" animate />
            ) : item.type === 'stardust' ? (
                <PointsCoin type="stardust" size="sm" animate />
            ) : (
                /* Cinematic Large Cosmic Star */
                <div className="relative group">
                    <div className="relative z-10 w-12 h-12 bg-gradient-to-br from-purple-300 via-purple-500 to-indigo-600 rounded-2xl flex items-center justify-center shadow-[0_0_30px_rgba(168,85,247,0.8)] rotate-12 animate-pulse">
                        <span className="material-symbols-outlined text-white text-3xl font-bold" style={{ fontVariationSettings: "'FILL' 1" }}>auto_awesome</span>
                    </div>
                    <div className="absolute inset-[-20px] bg-purple-500/30 blur-2xl rounded-full animate-pulse decoration-clone" />
                </div>
            )}
        </div>
    );
};
