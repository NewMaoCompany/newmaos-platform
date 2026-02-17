
import React, { useState, useMemo, useRef, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { useApp } from '../AppContext';

import { StarBackground, ShootingStars, PlanetVisual, getPlanetName } from '../components/SpaceVisuals';

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

    const nextStarCost = 100 * level;
    const canUpgrade = currentStardust >= nextStarCost;

    const handleBuy = async () => {
        setIsBuying(true);
        await purchaseStardust(buyAmount);
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
                <div className="flex items-center gap-4 bg-black/40 px-5 py-2.5 rounded-full backdrop-blur-md border border-white/10 shadow-xl">
                    <span className="text-amber-400 font-bold flex items-center gap-1.5 text-sm">
                        <span className="material-symbols-outlined text-base">monetization_on</span>
                        {userPoints.balance}
                    </span>
                    <span className="h-4 w-px bg-white/20"></span>
                    <span className="text-purple-300 font-bold flex items-center gap-1.5 text-sm">
                        <span className="material-symbols-outlined text-base">auto_awesome</span>
                        {currentStardust}
                    </span>
                </div>
            </div>

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

                                    {/* PLANET NAME - Moved Closer */}
                                    <div className={`text-center mt-6 transition-opacity duration-300 ${distance === 0 ? 'opacity-100' : 'opacity-0'} pointer-events-none`}>
                                        <h2 className="text-3xl md:text-5xl font-black uppercase tracking-[0.3em] text-transparent bg-clip-text bg-gradient-to-b from-white via-gray-200 to-gray-500 drop-shadow-lg font-mono">
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
            <div className="absolute bottom-0 w-full z-40 bg-gradient-to-t from-black via-black/90 to-transparent pb-10 pt-20 px-4 flex flex-col items-center pointer-events-none">
                <div className="pointer-events-auto w-full max-w-xl flex flex-col gap-6 items-center">

                    {/* Current Level Info */}
                    <div className="flex flex-col items-center">
                        <div className="flex items-center gap-3">
                            <span className="px-3 py-1 rounded-md bg-white/5 border border-white/10 text-[10px] uppercase tracking-widest font-bold text-white/40 shadow-inner">
                                Current: LVL {level}
                            </span>
                            <div className="flex gap-1.5">
                                {[1, 2, 3].map((s) => (
                                    <span key={s} className={`material-symbols-outlined text-sm ${s <= stars ? 'text-amber-400 drop-shadow-[0_0_8px_rgba(251,191,36,0.8)]' : 'text-white/10'}`} style={{ fontVariationSettings: "'FILL' 1" }}>
                                        star
                                    </span>
                                ))}
                            </div>
                        </div>
                    </div>

                    {/* Controls */}
                    <div className="w-full grid grid-cols-2 gap-4 md:gap-6">
                        {/* Inject Button */}
                        <button
                            onClick={handleInject}
                            disabled={!canUpgrade}
                            className={`col-span-1 h-16 rounded-2xl font-black text-sm tracking-[0.2em] uppercase flex flex-col items-center justify-center gap-1 transition-all duration-300 relative overflow-hidden group shadow-lg
                                ${canUpgrade
                                    ? 'bg-[#FFCC00] hover:bg-[#ffda33] text-black hover:scale-[1.02] active:scale-[0.98]'
                                    : 'bg-white/10 text-white/20 cursor-not-allowed'}`}
                        >
                            <div className="flex items-center gap-2 z-10">
                                <span className="material-symbols-outlined text-xl font-bold">{canUpgrade ? 'bolt' : 'lock'}</span>
                                <span>Inject</span>
                            </div>
                            <span className={`text-[10px] z-10 ${canUpgrade ? 'text-black/70 font-bold' : 'text-white/20'}`}>{nextStarCost} Stardust</span>
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
                                onClick={handleBuy}
                                disabled={isBuying || userPoints.balance < buyAmount}
                                className="h-full px-6 bg-[#FFCC00] hover:bg-[#ffda33] text-black font-black text-xs uppercase tracking-wider rounded-xl transition-all shadow-md active:scale-95 disabled:opacity-50 disabled:bg-gray-600 disabled:cursor-not-allowed whitespace-nowrap flex items-center justify-center"
                            >
                                {isBuying ? <span className="material-symbols-outlined animate-spin text-sm">refresh</span> : 'Buy'}
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
