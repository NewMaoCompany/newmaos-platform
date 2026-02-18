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
    size?: 'sm' | 'md' | 'lg' | 'xl';
    className?: string;
    style?: React.CSSProperties;
    showAtmosphere?: boolean;
    floating?: boolean;
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
    floating = true
}) => {
    const sizeMap = {
        sm: 'w-8 h-8', // Increased from w-7 h-7 for better visibility in widget
        md: 'w-12 h-12',
        lg: 'w-32 h-32 md:w-48 md:h-48',
        xl: 'w-64 h-64 sm:w-80 sm:h-80 md:w-96 md:h-96'
    };

    const planetIndex = (level - 1) % 10;

    const renderPlanetContent = () => {
        switch (planetIndex) {
            case 0: // Celestia (Moon) - ULTRA REALISM UPGRADE
                return (
                    <div className="relative w-full h-full rounded-full bg-[#1a1b1e] overflow-visible">
                        {/* 1. Physically Based Surface Base */}
                        <div className="absolute inset-0 rounded-full bg-[#d1d5db] shadow-[inset_-10px_-10px_40px_rgba(0,0,0,0.4)]" />

                        {/* 2. Micro-High Frequency Noise (Dust & Regolith) */}
                        <div className="absolute inset-0 rounded-full opacity-80 mix-blend-multiply" style={{ filter: 'url(#surface-noise)' }} />

                        {/* 3. Large Lunar Maria (Impact Basins) */}
                        <div className="absolute top-[15%] left-[30%] w-[45%] h-[35%] bg-[#4b5563] blur-[25px] opacity-40 rounded-[60%_40%_70%_30%]" />
                        <div className="absolute bottom-[25%] left-[20%] w-[35%] h-[25%] bg-[#374151] blur-[30px] opacity-30 rounded-[40%_60%_30%_70%]" />

                        {/* 4. Realistic Craters with Ray Systems (Breaking silhouette) */}
                        {[
                            { t: '20%', l: '60%', s: '16%', r: '25deg', ray: true },
                            { t: '65%', l: '25%', s: '20%', r: '-20deg', ray: true },
                            { t: '40%', l: '40%', s: '10%', r: '15deg', ray: false }
                        ].map((c, i) => (
                            <div key={i} className="absolute overflow-visible" style={{ top: c.t, left: c.l, width: c.s, height: c.s }}>
                                {c.ray && (
                                    <div className="absolute inset-[-200%] opacity-20"
                                        style={{ background: 'conic-gradient(from 0deg, transparent, white 2%, transparent 5%, white 10%, transparent 15%)', filter: 'blur(5px)' }} />
                                )}
                                <div className="absolute inset-0 rounded-full bg-black/50 shadow-[inset_2px_2px_10px_rgba(0,0,0,0.9),1px_1px_3px_rgba(255,255,255,0.4)]" />
                            </div>
                        ))}

                        {/* 5. Realistic Global Shadow (Terminator Line) */}
                        <div className="absolute inset-0 rounded-full bg-gradient-to-tr from-black/80 via-transparent to-transparent" />
                    </div>
                );
            case 1: // Ignis (Volcanic) - ULTRA REALISM UPGRADE (Pulsing Lava)
                return (
                    <div className="relative w-full h-full rounded-full bg-black overflow-visible">
                        {/* 1. Magma Ocean (Pulsing Heat) */}
                        <div className="absolute inset-0 rounded-full bg-[#450a0a] overflow-hidden">
                            <div className="absolute inset-[-20%] opacity-100 mix-blend-screen animate-pulse"
                                style={{ background: 'radial-gradient(circle at 40% 40%, #ff4d00 0%, #ff1100 40%, transparent 70%)', filter: 'url(#lava-noise) blur(2px)' }} />
                        </div>

                        {/* 2. Basalt Crust Plates (Floating look) */}
                        <div className="absolute inset-[-5%] rounded-full opacity-95 mix-blend-multiply"
                            style={{ background: '#0a0a0a', filter: 'url(#surface-noise) contrast(2.5)' }} />

                        {/* 3. Intense Heat Fractures (Lava Veins) */}
                        <div className="absolute inset-0 opacity-70 mix-blend-color-dodge animate-pulse"
                            style={{
                                background: 'conic-gradient(from 0deg at 50% 50%, transparent, #ffbb00 1%, transparent 3%, #ff4d00 15%, transparent 20%)',
                                filter: 'url(#lava-noise) blur(1px)'
                            }} />

                        {/* 4. Sulfur Plumes & Atmospheric Glow */}
                        <div className="absolute inset-[-30%] opacity-30 mix-blend-screen"
                            style={{ background: 'radial-gradient(circle, #ff4d00 0%, transparent 70%)', filter: 'blur(40px)' }} />
                    </div>
                );
            case 2: // Terra (Earth-like) - ULTRA REALISM UPGRADE (Dual Layer Clouds)
                return (
                    <div className="relative w-full h-full rounded-full bg-[#001133] overflow-visible">
                        {/* 1. Surface: Continents & Shallows */}
                        <div className="absolute inset-0 rounded-full overflow-hidden">
                            <div className="absolute inset-[-10%] opacity-100"
                                style={{ background: 'radial-gradient(circle at 40% 40%, #1a4a1a 0%, #0d2a0d 45%, transparent 75%)', filter: 'url(#surface-noise) contrast(1.4)' }} />
                            <div className="absolute inset-0 opacity-50 mix-blend-screen"
                                style={{ background: 'radial-gradient(circle at 45% 45%, #00ffff 0%, transparent 65%)', filter: 'blur(15px)' }} />
                        </div>

                        {/* 2. Cloud Layer 1 (Low Cumulus) */}
                        <div className="absolute inset-[-15%] opacity-40 animate-drift-slow"
                            style={{ background: 'radial-gradient(circle at 50% 50%, white 0%, transparent 60%)', filter: 'url(#cloud-drift) blur(2px)' }} />

                        {/* 3. Cloud Layer 2 (High Cirrus - Opposite direction) */}
                        <div className="absolute inset-[-10%] opacity-20 scale-110"
                            style={{ background: 'radial-gradient(circle at 30% 30%, white 0%, transparent 50%)', filter: 'url(#cloud-drift) blur(1px)', animation: 'drift-slow 60s linear reverse infinite' }} />

                        {/* 4. Specular Ocean Glint & Rayleigh Edge */}
                        <div className="absolute inset-0 rounded-full shadow-[inset_0_0_90px_rgba(0,100,255,0.5),0_0_30px_rgba(0,150,255,0.4)]" />
                        <div className="absolute top-[25%] left-[25%] w-[35%] h-[35%] bg-white/20 blur-[25px] rounded-full mix-blend-screen" />
                    </div>
                );
            case 3: // Glacies (Ice) - ULTRA REALISM UPGRADE (Subsurface Glow)
                return (
                    <div className="relative w-full h-full rounded-full bg-[#f0f9ff] overflow-visible">
                        {/* 1. Deep Core & Fractures */}
                        <div className="absolute inset-0 rounded-full bg-gradient-to-br from-[#7dd3fc] via-[#0ea5e9] to-[#1e40af]" />
                        <div className="absolute inset-[-10%] opacity-70 mix-blend-overlay"
                            style={{ background: '#ffffff', filter: 'url(#surface-noise) contrast(2) brightness(1.6)' }} />

                        {/* 2. Nitro-Frost Haze (Breaking silhouette) */}
                        <div className="absolute inset-[-30%] opacity-40 mix-blend-screen"
                            style={{ background: 'radial-gradient(circle, #e0f2fe 0%, transparent 70%)', filter: 'url(#cloud-drift) blur(20px)' }} />

                        {/* 3. Crystalline Specular Glints */}
                        <div className="absolute top-[15%] left-[15%] w-[40%] h-[40%] bg-white/40 blur-[30px] rounded-full" />
                        <div className="absolute inset-0 rounded-full shadow-[inset_0_0_70px_rgba(0,255,255,0.4)]" />
                    </div>
                );
            case 4: // Fulata (Gas Giant) - ULTRA REALISM UPGRADE (Turbulent Bands)
                return (
                    <div className="relative w-full h-full rounded-full bg-[#3d2b1f] overflow-visible">
                        {/* 1. Banded Atmosphere */}
                        <div className="absolute inset-0 rounded-full overflow-hidden">
                            <div className="absolute inset-[-25%] opacity-90"
                                style={{ background: 'repeating-linear-gradient(0deg, #5c4033 0%, #8b4513 8%, #d2b48c 15%, #5c4033 25%)', filter: 'url(#cloud-drift) contrast(1.2)' }} />
                        </div>

                        {/* 2. Great Red Spot (Active Vortex) */}
                        <div className="absolute bottom-[28%] right-[22%] w-[28%] h-[18%] opacity-100 rotate-[12deg]"
                            style={{ background: 'radial-gradient(ellipse at center, #7f1d1d 0%, #451a03 70%, transparent 100%)', filter: 'url(#lava-noise) blur(1px)' }} />

                        {/* 3. High-Speed Storm Pearls */}
                        {[15, 45, 75].map((t, i) => (
                            <div key={i} className="absolute opacity-50 mix-blend-soft-light"
                                style={{ top: `${t}%`, left: `${15 + i * 25}%`, width: '10%', height: '8%', background: 'white', filter: 'url(#cloud-drift) blur(2px)' }} />
                        ))}
                    </div>
                );
            case 5: // Aureus (Golden Rings) - ULTRA REALISM UPGRADE (Complex Bands)
                return (
                    <div className="relative w-full h-full flex items-center justify-center overflow-visible">
                        {/* 1. Metallic Planet Body */}
                        <div className="relative w-full h-full rounded-full bg-[#b45309] z-10 overflow-hidden shadow-[inset_-20px_-20px_60px_rgba(0,0,0,0.8)]">
                            <div className="absolute inset-0 bg-gradient-to-br from-[#fcd34d] via-[#b45309] to-[#451a03]" />
                            <div className="absolute inset-[-20%] opacity-60 mix-blend-overlay rotate-[15deg]"
                                style={{ background: '#d1a000', filter: 'url(#bg-surface-noise) contrast(1.6)' }} />
                            {/* Ring Shadow Crossing Sphere */}
                            <div className="absolute top-[48%] left-[-20%] w-[140%] h-[10%] bg-black/95 blur-[4px] rotate-[-12deg]" />
                        </div>

                        {/* 2. Ring System (High Fidelity Straited Bands) */}
                        <div className="absolute w-[280%] h-[25%] z-20 pointer-events-none transform -rotate-12 scale-y-[0.35] overflow-visible">
                            {/* Main B-Ring */}
                            <div className="absolute inset-0 border-[35px] border-[#fef3c7]/70 rounded-[50%] blur-[0.2px]" style={{ clipPath: 'polygon(0 55%, 100% 55%, 100% 100%, 0 100%)' }} />
                            {/* Cassini Division */}
                            <div className="absolute inset-[-2%] border-[3px] border-black/60 rounded-[50%]" style={{ clipPath: 'polygon(0 55%, 100% 55%, 100% 100%, 0 100%)' }} />
                            {/* A-Ring with Encke Gap */}
                            <div className="absolute inset-[-15%] border-[20px] border-[#fbbf24]/40 rounded-[50%] blur-[1px]" style={{ clipPath: 'polygon(0 55%, 100% 55%, 100% 100%, 0 100%)' }} />
                            {/* Micro-Debris Grain */}
                            <div className="absolute inset-[-20%] opacity-20 mix-blend-screen" style={{ background: 'radial-gradient(circle, #fff 0%, transparent 75%)', filter: 'url(#bg-surface-noise)' }} />
                        </div>
                    </div>
                );
            case 6: // Nebula - ULTRA REALISM UPGRADE (Volumetric)
                return (
                    <div className="relative w-full h-full rounded-full overflow-visible">
                        {/* 1. Layered Ionized Gas Sheets */}
                        <div className="absolute inset-[-50%] opacity-70 mix-blend-screen animate-pulse"
                            style={{ background: 'radial-gradient(circle at 35% 45%, #581c87 0%, transparent 65%)', filter: 'url(#cloud-drift) blur(15px)' }} />
                        <div className="absolute inset-[-40%] opacity-60 mix-blend-color-dodge"
                            style={{ background: 'radial-gradient(circle at 65% 65%, #9d174d 0%, transparent 60%)', filter: 'url(#cloud-drift) blur(20px)' }} />

                        {/* 2. Dust Pillars & Filaments */}
                        <div className="absolute inset-[15%] opacity-90 mix-blend-multiply"
                            style={{ background: '#000', filter: 'url(#cloud-drift) contrast(1.8) blur(3px)' }} />

                        {/* 3. Stellar Nurseries (Flash hotspots) */}
                        {[20, 50, 80].map((t, i) => (
                            <div key={i} className="absolute rounded-full filter blur-[10px]"
                                style={{ top: `${t}%`, left: `${20 + i * 20}%`, width: '15%', height: '15%', background: '#60a5fa', opacity: 0.3 }} />
                        ))}
                    </div>
                );
            case 7: // Void (Black Hole) - ULTRA REALISM UPGRADE (Relativistic)
                return (
                    <div className="relative w-full h-full flex items-center justify-center scale-[1.3] overflow-visible">
                        {/* 1. Photon Sphere (Warped light) */}
                        <div className="absolute w-[220%] h-[220%] rounded-full bg-[radial-gradient(circle,rgba(255,255,255,0.1)_0%,transparent_75%)] blur-[45px] animate-pulse" />

                        {/* 2. Accretion Disk (Doppler Shift: Blue-shifted approach, Red-shifted recede) */}
                        <div className="absolute w-[300%] h-[300%] rotate-x-[78deg] rotate-y-[8deg] animate-spin-slow"
                            style={{
                                background: 'conic-gradient(from -90deg, transparent 0%, #00f 10%, #fff 15%, #a0f 30%, transparent 50%, #f00 75%, transparent 100%)',
                                filter: 'url(#lava-noise) blur(3px)'
                            }} />

                        {/* 3. Event Horizon & Rim Lensing */}
                        <div className="relative w-[48%] h-[48%] rounded-full bg-black z-20 shadow-[0_0_50px_rgba(0,0,0,1)]">
                            <div className="absolute inset-[-3px] rounded-full border-[1.5px] border-white/30 blur-[1px]" />
                        </div>
                    </div>
                );
            case 8: // Nova (Sun) - CORE CINEMATIC OVERHAUL (Phase 5)
                return (
                    <div className="relative w-full h-full rounded-full bg-white overflow-visible filter"
                        style={{ filter: 'url(#solar-heat-shimmer)' }}>
                        {/* 1. Photosphere & Extreme Limb Darkening */}
                        <div className="absolute inset-0 rounded-full bg-gradient-to-br from-white via-[#f59e0b] to-[#450a0a]" />
                        <div className="absolute inset-0 rounded-full bg-[radial-gradient(circle,rgba(255,255,255,0.3)_0%,transparent_55%,rgba(69,26,3,1)_100%)]" />

                        {/* 2. Solar Plasma Convection System */}
                        <div className="absolute inset-[-5%] opacity-100 mix-blend-screen"
                            style={{ filter: 'url(#solar-plasma-cells) contrast(1.6) brightness(1.1)' }} />

                        {/* 3. High-Detail Solar Prominences (Silhouette-breaking Loops) */}
                        {[
                            { r: 'rotate-0', top: '10%', left: '40%' },
                            { r: 'rotate-[45deg]', top: '20%', left: '70%' },
                            { r: 'rotate-[200deg]', top: '70%', left: '20%' },
                        ].map((p, i) => (
                            <div key={i} className={`absolute w-[30%] h-[30%] z-10 ${p.r} opacity-80 mix-blend-screen overflow-visible`} style={{ top: p.top, left: p.left }}>
                                <div className="w-full h-full border-[6px] border-amber-400/80 rounded-[60%_40%_70%_30%] blur-[4px] animate-pulse" />
                                <div className="absolute inset-0 border-[2px] border-white/60 rounded-[60%_40%_70%_30%] blur-[1px]" />
                            </div>
                        ))}

                        {/* 4. Realistic Sunspot Hubs */}
                        {[
                            { t: '35%', l: '40%', s: '18%' },
                            { t: '65%', l: '60%', s: '12%' }
                        ].map((s, i) => (
                            <div key={i} className="absolute flex items-center justify-center translate-x-[-50%] translate-y-[-50%]" style={{ top: s.t, left: s.l, width: s.s, height: s.s }}>
                                <div className="absolute w-[200%] h-[200%] rounded-full bg-[#450a0a]/90 blur-[3px] mix-blend-multiply" />
                                <div className="absolute w-full h-full rounded-full bg-black blur-[0.5px]" />
                            </div>
                        ))}

                        {/* 5. Radiant Solar Fringe */}
                        <div className="absolute inset-[-30%] opacity-30 mix-blend-screen animate-spin-slow"
                            style={{ background: 'radial-gradient(circle, white 0%, transparent 70%)', filter: 'url(#surface-noise) blur(10px)' }} />
                    </div>
                );
            case 9: // Singularity - ULTRA REALISM UPGRADE (Spacetime Threads)
                return (
                    <div className="relative w-full h-full flex items-center justify-center scale-[1.3] overflow-visible">
                        {/* 1. Glitch/Refraction Halo */}
                        <div className="absolute inset-[-50%] opacity-40 mix-blend-screen animate-spin-slow" style={{ filter: 'url(#lava-noise) blur(3px)' }}>
                            <div className="absolute inset-x-0 top-1/2 h-[2px] bg-white/50 shadow-[0_0_30px_white]" />
                            <div className="absolute inset-y-0 left-1/2 w-[2px] bg-white/50 shadow-[0_0_30px_white]" />
                        </div>

                        {/* 2. Core Singularity (Radiant Black) */}
                        <div className="relative w-[40%] h-[40%] rounded-full bg-black z-20 shadow-[0_0_120px_white]">
                            <div className="absolute inset-[-15%] opacity-70 mix-blend-color-dodge" style={{ filter: 'url(#surface-noise) contrast(6) brightness(2.5)' }} />
                            <div className="absolute inset-[20%] bg-white rounded-full blur-[25px] animate-pulse" />
                        </div>

                        {/* 3. Reality Threads (Thin spectral lines) */}
                        {[0, 30, 60, 90, 120, 150].map((r, i) => (
                            <div key={i} className="absolute w-[0.5px] h-[700%] bg-gradient-to-b from-transparent via-cyan-400/50 to-transparent opacity-30"
                                style={{ transform: `rotate(${r}deg)` }} />
                        ))}
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

    return (
        <div
            className={`relative ${sizeMap[size]} transition-all ${floating ? 'animate-float' : ''} ${className}`}
            style={style}
        >
            {/* 1. LAYERED BACKGROUND REUSABLE FILTERS */}
            <svg style={{ position: 'absolute', width: 0, height: 0 }} aria-hidden="true">
                <defs>
                    <filter id="surface-noise">
                        <feTurbulence type="fractalNoise" baseFrequency="0.65" numOctaves="3" stitchTiles="stitch" />
                        <feColorMatrix type="saturate" values="0" />
                        <feComponentTransfer>
                            <feFuncR type="linear" slope="1.5" intercept="-0.2" />
                            <feFuncG type="linear" slope="1.5" intercept="-0.2" />
                            <feFuncB type="linear" slope="1.5" intercept="-0.2" />
                        </feComponentTransfer>
                    </filter>
                    <filter id="lava-noise">
                        <feTurbulence type="turbulence" baseFrequency="0.02" numOctaves="4" seed="5" />
                        <feDisplacementMap in="SourceGraphic" scale="20" />
                    </filter>
                    <filter id="solar-granulation">
                        <feTurbulence type="fractalNoise" baseFrequency="0.9" numOctaves="4" seed="1" />
                        <feDiffuseLighting lightingColor="#fff" surfaceScale="2.5">
                            <feDistantLight azimuth="45" elevation="60" />
                        </feDiffuseLighting>
                        <feDisplacementMap in="SourceGraphic" scale="5" />
                    </filter>
                    <filter id="solar-plasma-cells">
                        <feTurbulence type="fractalNoise" baseFrequency="0.8" numOctaves="5" seed="8" result="noise" />
                        <feColorMatrix in="noise" type="matrix" values="1 0 0 0 0 0 1 0 0 0 0 0 1 0 0 0 0 0 5 -2" result="cells" />
                        <feGaussianBlur in="cells" stdDeviation="1" result="soft-cells" />
                        <feComposite operator="arithmetic" k1="1" k2="0.6" in="SourceGraphic" in2="soft-cells" />
                    </filter>
                    <filter id="solar-heat-shimmer">
                        <feTurbulence type="turbulence" baseFrequency="0.05 0.1" numOctaves="2" seed="5">
                            <animate attributeName="seed" from="1" to="100" dur="10s" repeatCount="indefinite" />
                        </feTurbulence>
                        <feDisplacementMap in="SourceGraphic" scale="8" />
                    </filter>
                    <filter id="cloud-drift">
                        <feTurbulence type="fractalNoise" baseFrequency="0.012" numOctaves="5" />
                        <feDisplacementMap in="SourceGraphic" scale="50" />
                    </filter>
                </defs>
            </svg>

            {/* Global Atmosphere Glow - Layered Radial Gradients for natural falloff */}
            {showAtmosphere && (
                <>
                    {/* Outer faint glow */}
                    <div
                        className="absolute inset-[-50%] rounded-full z-0 pointer-events-none opacity-30"
                        style={{
                            background: 'radial-gradient(circle, rgba(255,255,255,0.2) 0%, rgba(255,255,255,0.05) 40%, transparent 70%)',
                            filter: `blur(${40 * bScale}px)`,
                            transform: 'translateZ(0)' // Hardware acceleration
                        }}
                    />
                    {/* Inner intense glow */}
                    <div
                        className="absolute inset-[-10%] rounded-full z-0 pointer-events-none opacity-40 mix-blend-screen"
                        style={{
                            background: 'radial-gradient(circle, rgba(255,255,255,0.4) 0%, rgba(255,255,255,0.1) 60%, transparent 100%)',
                            filter: `blur(${20 * bScale}px)`,
                        }}
                    />
                </>
            )}

            {/* Planet Body Overlay Shadow - Softer terminator line */}
            <div className="absolute inset-0 rounded-full z-20 pointer-events-none bg-gradient-to-tr from-black/80 via-black/20 to-transparent opacity-80" />

            {/* Rim Light Effect */}
            <div className="absolute inset-0 rounded-full z-20 pointer-events-none shadow-[inset_2px_2px_10px_rgba(255,255,255,0.3)] opacity-60" />

            {/* Actual Planet Rendering */}
            <div className="w-full h-full relative z-10 overflow-hidden rounded-full">
                {renderPlanetContent()}
            </div>

            <style dangerouslySetInnerHTML={{
                __html: `
                .animate-float {
                    animation: float 6s ease-in-out infinite;
                }
                @keyframes float {
                    0%, 100% { transform: translateY(0px); }
                    50% { transform: translateY(-10px); }
                }
                .animate-spin-slow {
                    animation: spin 20s linear infinite;
                }
                @keyframes spin {
                    from { transform: rotate(0deg); }
                    to { transform: rotate(360deg); }
                }
                .animate-drift-slow {
                    animation: drift 40s ease-in-out infinite alternate;
                }
                @keyframes drift {
                    from { transform: translate(0, 0); }
                    to { transform: translate(15px, 10px); }
                }
            `}} />
        </div>
    );
};

export const getPlanetName = (level: number) => {
    const names = [
        'Celestia', 'Ignis', 'Terra', 'Glacies', 'Fulata',
        'Aureus', 'Nebula', 'Void', 'Nova', 'Singularity'
    ];
    return names[(level - 1) % names.length] || 'Unknown';
};
