import React, { useMemo, useEffect, useState } from 'react';

/**
 * High-detail Starry Background with 3-layer parallax effect.
 */
export const StarBackground: React.FC = () => {
    return (
        <div className="absolute inset-0 pointer-events-none overflow-hidden bg-black flex items-center justify-center">
            {/* Layer 1: Dense micro stars - ULTRA DENSITY x4 */}
            <div className="absolute inset-0 opacity-80"
                style={{
                    backgroundImage: `
                        radial-gradient(1.5px 1.5px at 10px 10px, #fff, rgba(0,0,0,0)), 
                        radial-gradient(1px 1px at 50px 80px, #eef, rgba(0,0,0,0)), 
                        radial-gradient(1.5px 1.5px at 120px 40px, #fff, rgba(0,0,0,0)), 
                        radial-gradient(1px 1px at 200px 150px, #dde, rgba(0,0,0,0)), 
                        radial-gradient(1.5px 1.5px at 160px 220px, #fff, rgba(0,0,0,0)),
                        radial-gradient(1px 1px at 250px 30px, #ccf, rgba(0,0,0,0)),
                        radial-gradient(1.5px 1.5px at 40px 280px, #fff, rgba(0,0,0,0))
                    `,
                    backgroundSize: '300px 300px',
                    animation: 'space-drift 200s linear infinite'
                }}
            />
            {/* Layer 2: Mid-sized diverse stars - BRIGHTER & DENSER */}
            <div className="absolute inset-0 opacity-70"
                style={{
                    backgroundImage: `
                        radial-gradient(2px 2px at 80px 120px, #fff, rgba(0,0,0,0)), 
                        radial-gradient(2.5px 2.5px at 220px 40px, #a5b4fc, rgba(0,0,0,0)), 
                        radial-gradient(2px 2px at 150px 200px, #fcd34d, rgba(0,0,0,0)), 
                        radial-gradient(2.5px 2.5px at 300px 300px, #fff, rgba(0,0,0,0)),
                        radial-gradient(2px 2px at 380px 100px, #c084fc, rgba(0,0,0,0))
                    `,
                    backgroundSize: '450px 450px',
                    animation: 'space-drift 120s linear infinite reverse'
                }}
            />
            {/* Layer 3: Large stars / Distant Clusters */}
            <div className="absolute inset-0 opacity-50"
                style={{
                    backgroundImage: 'radial-gradient(3px 3px at 50% 50%, #fff, rgba(0,0,0,0)), radial-gradient(4px 4px at 20% 80%, #fff, rgba(0,0,0,0)), radial-gradient(3px 3px at 80% 20%, #bfdbfe, rgba(0,0,0,0))',
                    backgroundSize: '800px 800px',
                    filter: 'blur(0.5px)'
                }}
            />

            {/* Subtle nebula clouds - Darker/Deeper */}
            <div className="absolute inset-0 opacity-10 filter blur-[120px]"
                style={{
                    background: 'radial-gradient(circle at 10% 20%, #312e81 0%, transparent 50%), radial-gradient(circle at 90% 80%, #1e1b4b 0%, transparent 50%)'
                }}
            />

            {/* Distant Solar System Elements */}
            <div className="absolute top-[15%] left-[10%] w-16 h-16 rounded-full bg-orange-950/10 blur-[8px] border border-orange-900/5" />
            <div className="absolute top-[70%] right-[15%] w-32 h-32 rounded-full bg-blue-900/5 blur-[12px] border border-blue-800/5" />

            <style dangerouslySetInnerHTML={{
                __html: `
                @keyframes space-drift {
                    from { transform: translateY(0); }
                    to { transform: translateY(-1000px); }
                }
            `}} />
        </div>
    );
};

/**
 * Randomly appearing shooting stars.
 */
export const ShootingStars: React.FC = () => {
    const [stars, setStars] = useState<{ id: number; top: string; left: string; delay: string; duration: string }[]>([]);

    useEffect(() => {
        const createStar = () => {
            const id = Date.now();
            const top = Math.random() * 50 + '%';
            const left = Math.random() * 100 + '%';
            const delay = '0s';
            const duration = (Math.random() * 1 + 0.5) + 's';

            setStars(prev => [...prev, { id, top, left, delay, duration }]);

            setTimeout(() => {
                setStars(prev => prev.filter(s => s.id !== id));
            }, 2000);
        };

        const interval = setInterval(() => {
            if (stars.length < 3) createStar();
        }, 4000);

        return () => clearInterval(interval);
    }, [stars.length]);

    return (
        <div className="absolute inset-0 pointer-events-none overflow-hidden z-0">
            {stars.map(star => (
                <div
                    key={star.id}
                    className="absolute h-[2px] bg-gradient-to-l from-transparent via-white to-transparent rounded-full shadow-[0_0_15px_#fff]"
                    style={{
                        top: star.top,
                        left: star.left,
                        width: '150px',
                        animation: `shooting-star ${star.duration} ease-out forwards`,
                        transformOrigin: 'left center'
                    }}
                />
            ))}
            <style dangerouslySetInnerHTML={{
                __html: `
                @keyframes shooting-star {
                    0% { transform: translateX(0) translateY(0) rotate(45deg) scaleX(0.5); opacity: 0; }
                    10% { opacity: 1; transform: translateX(20px) translateY(20px) rotate(45deg) scaleX(1); }
                    100% { transform: translateX(300px) translateY(300px) rotate(45deg) scaleX(0.8); opacity: 0; }
                }
            `}} />
        </div>
    );
};

interface PlanetVisualProps {
    level: number;
    size?: 'sm' | 'md' | 'lg' | 'xl' | '2xl' | 'widget';
    className?: string;
    style?: React.CSSProperties;
    showAtmosphere?: boolean;
    floating?: boolean;
    isUnlocked?: boolean;
}

/**
 * High-detail Planet Visuals for all 10 Prestige Tiers.
 */
export const PlanetVisual: React.FC<PlanetVisualProps> = ({
    level,
    size = 'lg',
    className = '',
    style = {},
    showAtmosphere = true,
    floating = true,
    isUnlocked = true
}) => {
    const sizeMap = {
        sm: 'w-8 h-8 aspect-square flex-shrink-0',
        md: 'w-12 h-12 aspect-square flex-shrink-0',
        lg: 'w-32 h-32 md:w-48 md:h-48 aspect-square flex-shrink-0',
        xl: 'w-64 h-64 sm:w-80 sm:h-80 md:w-[520px] md:h-[520px] aspect-square flex-shrink-0', // HARDCODED 520px (approx 384 * 1.35)
        '2xl': 'w-[520px] h-[520px] aspect-square flex-shrink-0',
        widget: 'w-24 h-24 sm:w-28 sm:h-28 aspect-square flex-shrink-0'
    };

    const planetIndex = (level - 1) % 5;

    const renderPlanetContent = () => {
        switch (planetIndex) {
            case 0: // Celestia (Moon) - PURE IMAGE (Clean Slate)
                return (
                    <div className="relative w-full h-full aspect-square rounded-full bg-transparent overflow-visible group flex-shrink-0" style={{ transform: 'translateX(-1.5%)' }}>
                        {/* Celestia Majestic Aura */}
                        {isUnlocked && (
                            <div className="absolute inset-[-30%] pointer-events-none -z-10 mix-blend-screen transition-opacity duration-1000" style={{ transform: 'translate(1.5%, 0.7%)' }}>
                                {/* Inner soft glow */}
                                <div className="absolute inset-[10%] bg-[radial-gradient(circle_at_center,rgba(255,255,255,0.4)_0%,transparent_70%)] blur-lg" />
                                {/* Rotating subtle rays */}
                                <div className="absolute inset-0 bg-[conic-gradient(from_0deg,transparent_0%,rgba(255,255,255,0.2)_10%,transparent_20%,transparent_50%,rgba(255,255,255,0.2)_60%,transparent_70%)] animate-[spin_60s_linear_infinite] rounded-full blur-sm" />
                                {/* Sharp outer pulse ring */}
                                <div className="absolute inset-[15%] rounded-full border border-white/30 shadow-[0_0_30px_rgba(255,255,255,0.3)] animate-[pulse_4s_ease-in-out_infinite]" />
                            </div>
                        )}
                        <div className="absolute inset-0 rounded-full aspect-square">
                            <div className="absolute inset-0 rounded-full aspect-square overflow-hidden" style={{ animationDuration: '240s' }}>
                                <img
                                    src="assets/planets/Celestia.png"
                                    alt="Celestia"
                                    draggable={false}
                                    className="w-full h-full object-cover aspect-square select-none"
                                    style={{
                                        filter: 'contrast(1.2) brightness(1.15) drop-shadow(0 0 2px rgba(255,255,255,0.9)) drop-shadow(0 0 15px rgba(255,255,255,0.4))',
                                        imageRendering: '-webkit-optimize-contrast' as any
                                    }}
                                />
                            </div>
                        </div>
                    </div>
                );
            case 1: // Ignis (Volcanic)
                return (
                    <div className="relative w-full h-full aspect-square rounded-full bg-transparent overflow-visible group flex-shrink-0">
                        {/* Ignis Majestic Aura */}
                        {isUnlocked && (
                            <div className="absolute inset-[-40%] pointer-events-none -z-10 mix-blend-screen transition-opacity duration-1000" style={{ transform: 'translateY(0.5%)' }}>
                                {/* Core heat */}
                                <div className="absolute inset-[10%] bg-[radial-gradient(circle_at_center,rgba(249,115,22,0.5)_0%,transparent_70%)] blur-xl" />
                                {/* Thick fire spin */}
                                <div className="absolute inset-0 bg-[conic-gradient(from_0deg,transparent_0%,rgba(239,68,68,0.4)_20%,transparent_40%,transparent_60%,rgba(249,115,22,0.4)_80%,transparent_100%)] animate-[spin_20s_linear_infinite] rounded-full blur-md" />
                                {/* Chaotic flare pulses */}
                                <div className="absolute inset-[5%] rounded-full border-2 border-orange-500/20 shadow-[0_0_50px_rgba(239,68,68,0.5)] animate-[pulse_2s_ease-in-out_infinite]" />
                                <div className="absolute inset-[20%] rounded-full border border-yellow-500/40 shadow-[0_0_20px_rgba(253,224,71,0.6)] animate-[pulse_1.5s_ease-in-out_infinite]" />
                            </div>
                        )}
                        <div className="absolute inset-0 rounded-full aspect-square">
                            <div className="absolute inset-0 rounded-full aspect-square overflow-hidden" style={{ animationDuration: '240s' }}>
                                <img
                                    src="assets/planets/Ignis.png"
                                    alt="Ignis"
                                    draggable={false}
                                    className="w-full h-full object-cover aspect-square select-none"
                                    style={{
                                        filter: 'contrast(1.2) brightness(1.15) drop-shadow(0 0 2px rgba(239,68,68,0.9)) drop-shadow(0 0 15px rgba(185,28,28,0.4))',
                                        imageRendering: '-webkit-optimize-contrast' as any
                                    }}
                                />
                            </div>
                        </div>
                    </div>
                );
            case 2: // Terra (Earth-like)
                return (
                    <div className="relative w-full h-full aspect-square rounded-full bg-transparent overflow-visible group flex-shrink-0">
                        {/* Terra Majestic Aura */}
                        {isUnlocked && (
                            <div className="absolute inset-[-35%] pointer-events-none -z-10 mix-blend-screen transition-opacity duration-1000" style={{ transform: 'translate(-1%, 0.915%)' }}>
                                {/* Atmosphere bleed */}
                                <div className="absolute inset-[10%] bg-[radial-gradient(circle_at_center,rgba(16,185,129,0.4)_0%,transparent_70%)] blur-xl" />
                                {/* Dual nature currents */}
                                <div className="absolute inset-0 bg-[conic-gradient(from_0deg,transparent_0%,rgba(52,211,153,0.3)_25%,transparent_50%,transparent_50%,rgba(56,189,248,0.3)_75%,transparent_100%)] animate-[spin_40s_linear_infinite_reverse] rounded-full blur-sm" />
                                {/* Emerald energy ring */}
                                <div className="absolute inset-[15%] rounded-full border-[1.5px] border-emerald-400/40 shadow-[0_0_40px_rgba(16,185,129,0.4)] animate-[pulse_5s_ease-in-out_infinite]" />
                            </div>
                        )}
                        <div className="absolute inset-0 rounded-full aspect-square">
                            <div className="absolute inset-0 rounded-full aspect-square overflow-hidden" style={{ animationDuration: '240s' }}>
                                <img
                                    src="assets/planets/Terra.png"
                                    alt="Terra"
                                    draggable={false}
                                    className="w-full h-full object-cover aspect-square select-none"
                                    style={{
                                        filter: 'contrast(1.2) brightness(1.15) drop-shadow(0 0 2px rgba(59,130,246,0.9)) drop-shadow(0 0 15px rgba(16,185,129,0.4))',
                                        imageRendering: '-webkit-optimize-contrast' as any
                                    }}
                                />
                            </div>
                        </div>
                    </div>
                );
            case 3: // Glacies (Ice)
                return (
                    <div className="relative w-full h-full aspect-square rounded-full bg-transparent overflow-visible group flex-shrink-0" style={{ transform: 'scale(1.05)' }}>
                        {/* Glacies Majestic Aura */}
                        {isUnlocked && (
                            <div className="absolute inset-[-30%] pointer-events-none -z-10 mix-blend-screen transition-opacity duration-1000" style={{ transform: 'translate(-0.11%, -1.7%)' }}>
                                {/* Frost core */}
                                <div className="absolute inset-[5%] bg-[radial-gradient(circle_at_center,rgba(6,182,212,0.4)_0%,transparent_70%)] blur-lg" />
                                {/* Sharp ice ring spin */}
                                <div className="absolute inset-[-10%] bg-[conic-gradient(from_0deg,transparent_0%,rgba(165,243,252,0.4)_10%,transparent_20%,transparent_33%,rgba(165,243,252,0.4)_43%,transparent_53%,transparent_66%,rgba(165,243,252,0.4)_76%,transparent_86%)] animate-[spin_50s_linear_infinite] rounded-full blur-[2px]" />
                                {/* Multiple crystalline borders */}
                                <div className="absolute inset-[10%] rounded-full border-[2px] border-cyan-300/30 shadow-[0_0_30px_rgba(34,211,238,0.5)]" />
                                <div className="absolute inset-[20%] rounded-full border border-sky-200/50 shadow-[0_0_15px_rgba(186,230,253,0.8)] animate-[pulse_3s_ease-in-out_infinite]" />
                            </div>
                        )}
                        {/* Planet Image (Shifted Left) */}
                        <div className="absolute inset-0 w-full h-full" style={{ transform: 'translateX(-5%)' }}>
                            <div className="absolute inset-0 rounded-full aspect-square">
                                <div className="absolute inset-0 rounded-full aspect-square overflow-hidden" style={{ animationDuration: '240s' }}>
                                    <img
                                        src="assets/planets/Glacies.png"
                                        alt="Glacies"
                                        draggable={false}
                                        className="w-full h-full object-cover aspect-square select-none"
                                        style={{
                                            filter: 'contrast(1.2) brightness(1.15) drop-shadow(0 0 2px rgba(224,242,254,0.9)) drop-shadow(0 0 15px rgba(6,182,212,0.4))',
                                            imageRendering: '-webkit-optimize-contrast' as any
                                        }}
                                    />
                                </div>
                            </div>
                        </div>
                    </div>
                );
            case 4: // Fulata (Gas Giant)
                return (
                    <div className="relative w-full h-full aspect-square rounded-full bg-transparent overflow-visible group flex-shrink-0" style={{ transform: 'scale(1.2)' }}>
                        {/* Fulata Majestic Aura */}
                        {isUnlocked && (
                            <div className="absolute inset-[-45%] pointer-events-none -z-10 mix-blend-screen transition-opacity duration-1000" style={{ transform: 'translate(0.2%, -2.1%)' }}>
                                {/* Deep dimension core */}
                                <div className="absolute inset-0 bg-[radial-gradient(circle_at_center,rgba(168,85,247,0.4)_0%,transparent_70%)] blur-xl" />
                                {/* Twin galaxy intertwine */}
                                <div className="absolute inset-[-10%] bg-[conic-gradient(from_0deg,transparent_0%,rgba(147,51,234,0.5)_25%,transparent_50%,transparent_50%,rgba(217,119,6,0.5)_75%,transparent_100%)] animate-[spin_35s_linear_infinite] rounded-full blur-md" />
                                <div className="absolute inset-[5%] bg-[conic-gradient(from_0deg,transparent_0%,rgba(234,179,8,0.3)_25%,transparent_50%,transparent_50%,rgba(192,132,252,0.3)_75%,transparent_100%)] animate-[spin_25s_linear_infinite_reverse] rounded-full blur-sm" />
                                {/* Cosmic horizon ring */}
                                <div className="absolute inset-[15%] rounded-full border-2 border-fuchsia-500/30 shadow-[0_0_50px_rgba(192,132,252,0.6)] animate-[pulse_4s_ease-in-out_infinite]" />
                                <div className="absolute inset-[25%] rounded-full border border-amber-400/40 shadow-[0_0_20px_rgba(251,191,36,0.5)]" />
                            </div>
                        )}
                        <div className="absolute inset-0 rounded-full aspect-square">
                            <div className="absolute inset-0 rounded-full aspect-square overflow-hidden" style={{ animationDuration: '240s' }}>
                                <img
                                    src="assets/planets/Fulata.png"
                                    alt="Fulata"
                                    draggable={false}
                                    className="w-full h-full object-cover aspect-square select-none"
                                    style={{
                                        filter: 'contrast(1.2) brightness(1.15) drop-shadow(0 0 2px rgba(251,191,36,0.9)) drop-shadow(0 0 15px rgba(217,119,6,0.4))',
                                        imageRendering: '-webkit-optimize-contrast' as any
                                    }}
                                />
                            </div>
                        </div>
                    </div>
                );
            default:
                return <div className="w-full h-full rounded-full bg-gray-500" />;
        }
    };

    const blurScaleMap = {
        sm: 0.2,
        md: 0.4,
        lg: 1,
        xl: 2
    };
    const bScale = blurScaleMap[size];

    const mergedStyle: React.CSSProperties = {
        ...style,
        position: 'relative'
    };

    return (
        <div
            className={`relative ${sizeMap[size]} transition-all ${className}`}
            style={mergedStyle}
        >
            <svg style={{ position: 'absolute', width: 0, height: 0 }} aria-hidden="true">
                <defs>
                    <filter id="organic-surface" x="-20%" y="-20%" width="140%" height="140%">
                        <feTurbulence type="fractalNoise" baseFrequency="0.04" numOctaves="5" seed="88" result="noise" />
                        <feDiffuseLighting in="noise" lightingColor="#fff" surfaceScale="12" result="diffuse">
                            <feDistantLight azimuth="45" elevation="60" />
                        </feDiffuseLighting>
                        <feComposite in="SourceGraphic" in2="diffuse" operator="arithmetic" k1="1" k2="0.6" />
                    </filter>
                    <filter id="fluid-flow" x="-50%" y="-50%" width="200%" height="200%">
                        <feTurbulence type="turbulence" baseFrequency="0.012 0.025" numOctaves="4" seed="12" result="flow">
                            <animate attributeName="seed" from="1" to="1000" dur="120s" repeatCount="indefinite" />
                        </feTurbulence>
                        <feDisplacementMap in="SourceGraphic" in2="flow" scale="60" xChannelSelector="R" yChannelSelector="G" />
                    </filter>
                    <filter id="solar-granulation-v2" x="-20%" y="-20%" width="140%" height="140%">
                        <feTurbulence type="fractalNoise" baseFrequency="0.92" numOctaves="4" seed="3" result="grain" />
                        <feColorMatrix in="grain" type="matrix" values="1 0 0 0 0 0 1 0 0 0 0 0 1 0 0 0 0 0 4 -1.5" />
                        <feGaussianBlur stdDeviation="0.5" />
                    </filter>
                    <filter id="relativistic-warp" x="-200%" y="-200%" width="500%" height="500%">
                        <feTurbulence type="fractalNoise" baseFrequency="0.008" numOctaves="6" seed="99">
                            <animate attributeName="seed" from="1" to="100" dur="90s" repeatCount="indefinite" />
                        </feTurbulence>
                        <feDisplacementMap in="SourceGraphic" scale="180" />
                    </filter>
                    <filter id="sharpen">
                        <feConvolveMatrix order="3" kernelMatrix="0 -1 0 -1 5 -1 0 -1 0" preserveAlpha="true" />
                    </filter>
                    <filter id="micro-detail">
                        <feTurbulence type="fractalNoise" baseFrequency="0.65" numOctaves="1" seed="1" />
                        <feColorMatrix type="saturate" values="0" />
                        <feComponentTransfer>
                            <feFuncA type="linear" slope="0.15" />
                        </feComponentTransfer>
                    </filter>
                </defs>
            </svg>



            <div className={`w-full h-full aspect-square relative z-10 rounded-full group flex-shrink-0 transition-all duration-1000 ${!isUnlocked ? 'grayscale brightness-[0.4] opacity-50' : 'grayscale-0 brightness-100 opacity-100'}`}>
                <div className="absolute inset-0 rounded-full aspect-square transform-gpu transition-transform duration-700 group-hover:scale-[1.02]">
                    {renderPlanetContent()}
                </div>
            </div>

            <style dangerouslySetInnerHTML={{
                __html: `
                .animate-float {
                    animation: float 12s ease-in-out infinite;
                }
                @keyframes float {
                    0%, 100% { transform: translateY(0px) rotate(0deg); }
                    50% { transform: translateY(-20px) rotate(1.5deg); }
                }
                .animate-spin-cinematic {
                    animation: spin-cinematic 80s linear infinite;
                }
                @keyframes spin-cinematic {
                    from { transform: rotate(0deg); }
                    to { transform: rotate(360deg); }
                }
                .animate-surface-drift {
                    animation: surface-drift 100s ease-in-out infinite alternate;
                }
                @keyframes surface-drift {
                    from { transform: scale(1.15) translate(-2%, -2%) rotate(0deg); }
                    to { transform: scale(1.15) translate(2%, 2%) rotate(2deg); }
                }
                .animate-glimmer {
                    animation: glimmer 6s ease-in-out infinite;
                }
                @keyframes glimmer {
                    0%, 100% { opacity: 0.7; filter: brightness(1) saturate(1); }
                    50% { opacity: 1; filter: brightness(1.2) saturate(1.1); }
                }
                .animate-aura-pulse {
                    animation: aura-pulse 8s ease-in-out infinite;
                }
                @keyframes aura-pulse {
                    0%, 100% { transform: scale(1); opacity: 0.5; }
                    50% { transform: scale(1.15); opacity: 0.8; }
                }
                .animate-aura-warp {
                    animation: aura-warp 15s ease-in-out infinite alternate;
                }
                @keyframes aura-warp {
                    0% { border-radius: 50% 50% 50% 50%; transform: rotate(0deg) scale(1); }
                    33% { border-radius: 45% 55% 48% 52%; transform: rotate(5deg) scale(1.02); }
                    66% { border-radius: 53% 47% 55% 45%; transform: rotate(-3deg) scale(1); }
                    100% { border-radius: 50% 50% 50% 50%; transform: rotate(0deg) scale(1.05); }
                }
                @keyframes aura-rotate {
                    from { transform: rotate(0deg); }
                    to { transform: rotate(360deg); }
                }
            `}} />
        </div>
    );
};

export const getPlanetName = (level: number) => {
    const names = [
        'Celestia', 'Ignis', 'Terra', 'Glacies', 'Fulata'
    ];
    return names[(level - 1) % names.length] || 'Unknown';
};
