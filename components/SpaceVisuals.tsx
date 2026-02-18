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
            case 0: // Celestia (Moon) - ABSOLUTE REALISM OVERHAUL
                return (
                    <div className="relative w-full h-full rounded-full bg-[#1a1b1e] overflow-hidden">
                        {/* 1. Physically Based Surface Base */}
                        <div className="absolute inset-0 bg-[#d1d5db]" />

                        {/* 2. Micro-High Frequency Noise (Dust & Regolith) */}
                        <div className="absolute inset-0 opacity-80 mix-blend-multiply" style={{ filter: 'url(#surface-noise)' }} />

                        {/* 3. Large Lunar Maria (Impact Basins) - Non-repetitive organic shapes */}
                        <div className="absolute top-[10%] left-[25%] w-[40%] h-[30%] bg-[#4b5563] blur-[25px] opacity-40 rounded-[60%_40%_70%_30%]" />
                        <div className="absolute bottom-[20%] left-[15%] w-[35%] h-[25%] bg-[#374151] blur-[30px] opacity-30 rounded-[40%_60%_30%_70%]" />

                        {/* 4. Subsurface Displacement (SVG Noise based scattering) */}
                        <div className="absolute inset-0 opacity-10 mix-blend-overlay" style={{ filter: 'contrast(1.5) url(#surface-noise)' }} />

                        {/* 5. Precise Craters with Ray Systems (Ejecta) */}
                        {[
                            { t: '25%', l: '65%', s: '14%', r: '20deg', ray: true },
                            { t: '60%', l: '30%', s: '18%', r: '-15deg', ray: true },
                            { t: '45%', l: '45%', s: '8%', r: '10deg', ray: false },
                            { t: '75%', l: '55%', s: '10%', r: '45deg', ray: false },
                            { t: '15%', l: '35%', s: '5%', r: '0deg', ray: false }
                        ].map((c, i) => (
                            <div key={i} className="absolute overflow-visible" style={{ top: c.t, left: c.l, width: c.s, height: c.s }}>
                                {/* Ray System (Bright Ejecta) */}
                                {c.ray && (
                                    <div className="absolute inset-[-150%] opacity-20"
                                        style={{
                                            background: 'conic-gradient(from 0deg, transparent, white 2%, transparent 5%, white 10%, transparent 15%)',
                                            filter: 'blur(5px)'
                                        }}
                                    />
                                )}
                                {/* Crater Bowl */}
                                <div className="absolute inset-0 rounded-full bg-black/40 shadow-[inset_2px_2px_8px_rgba(0,0,0,0.8),1px_1px_2px_rgba(255,255,255,0.4)]"
                                    style={{ transform: `rotate(${c.r})` }} />
                            </div>
                        ))}

                        {/* 6. Realistic Global Shadow (Physically Correct Terminator) */}
                        <div className="absolute inset-0 bg-gradient-to-tr from-black/80 via-transparent to-transparent" />
                    </div>
                );
            case 1: // Ignis (Volcanic) - ABSOLUTE REALISM OVERHAUL
                return (
                    <div className="relative w-full h-full rounded-full bg-black overflow-hidden">
                        {/* 1. Deep Core Heat Foundation */}
                        <div className="absolute inset-0 bg-gradient-to-br from-[#1a0500] via-[#330000] to-black" />

                        {/* 2. Magma Ocean (Dynamic Noise based heat) */}
                        <div className="absolute inset-0 opacity-100 mix-blend-screen"
                            style={{ background: 'radial-gradient(circle at 40% 40%, #ff4d00 0%, #ff1100 30%, transparent 70%)', filter: 'url(#lava-noise) blur(2px)' }} />

                        {/* 3. Solidifying Basalt Crust (High-Frequency Displacement) */}
                        <div className="absolute inset-[-10%] opacity-95 mix-blend-multiply"
                            style={{ background: '#0a0a0a', filter: 'url(#surface-noise) contrast(2)' }} />

                        {/* 4. Heat Fractures (Lava venting through cracks) */}
                        <div className="absolute inset-0 opacity-60 mix-blend-color-dodge"
                            style={{
                                background: 'conic-gradient(from 0deg at 50% 50%, transparent, #ffbb00 1%, transparent 2%, #ff4d00 15%, transparent 16%)',
                                filter: 'url(#lava-noise) blur(1px)'
                            }} />

                        {/* 5. Gaseous Sulfur Clouds */}
                        <div className="absolute inset-[-20%] opacity-20 mix-blend-screen"
                            style={{
                                background: 'radial-gradient(circle at 20% 80%, rgba(255,255,100,0.1) 0%, transparent 50%)',
                                filter: 'blur(30px)'
                            }} />

                        {/* 6. Active Magma Plumes (Individual Hotspots) */}
                        {[
                            { t: '35%', l: '45%', s: '12%', color: '#ffcc00' },
                            { t: '65%', l: '25%', s: '8%', color: '#ff8800' },
                            { t: '20%', l: '60%', s: '10%', color: '#ff4411' }
                        ].map((p, i) => (
                            <div key={i} className="absolute rounded-full filter blur-[10px] animate-pulse"
                                style={{ top: p.t, left: p.l, width: p.s, height: p.s, background: p.color, opacity: 0.6 }} />
                        ))}

                        {/* 7. Rim Glow Correction */}
                        <div className="absolute inset-0 rounded-full shadow-[inset_0_0_40px_rgba(255,50,0,0.3)]" />
                    </div>
                );
            case 2: // Terra (Earth-like) - ABSOLUTE REALISM OVERHAUL
                return (
                    <div className="relative w-full h-full rounded-full bg-[#001133] overflow-hidden">
                        {/* 1. Deep Oceanic Abyss */}
                        <div className="absolute inset-0 bg-[#000d1a]" />

                        {/* 2. Continental Crust (High-Frequency organic shapes) */}
                        <div className="absolute inset-[-10%] opacity-100"
                            style={{
                                background: 'radial-gradient(circle at 40% 40%, #225522 0%, #113311 40%, transparent 70%)',
                                filter: 'url(#surface-noise) contrast(1.2)'
                            }} />

                        {/* 3. Coastal Shallows (Cyan/Turquoise glow around continents) */}
                        <div className="absolute inset-0 opacity-40 mix-blend-screen"
                            style={{
                                background: 'radial-gradient(circle at 45% 45%, #00ffff 0%, transparent 60%)',
                                filter: 'blur(20px)'
                            }} />

                        {/* 4. Polar Ice Sheets */}
                        <div className="absolute top-[-20%] left-[20%] w-[60%] h-[30%] bg-white/80 blur-[15px] rounded-[50%]" />
                        <div className="absolute bottom-[-20%] left-[25%] w-[50%] h-[25%] bg-blue-50/70 blur-[20px] rounded-[50%]" />

                        {/* 5. Cloud Systems - Layer 1 (Low Altitude Cumulus) */}
                        <div className="absolute inset-[-20%] opacity-40 animate-drift-slow"
                            style={{
                                background: 'radial-gradient(circle at 50% 50%, white 0%, transparent 50%)',
                                filter: 'url(#cloud-drift) blur(2px)'
                            }} />

                        {/* 6. Cloud Shadows (Cast onto surface) */}
                        <div className="absolute inset-[-18%] opacity-30 mix-blend-multiply animate-drift-slow translate-x-2 translate-y-2"
                            style={{
                                background: 'radial-gradient(circle at 50% 50%, black 0%, transparent 50%)',
                                filter: 'url(#cloud-drift) blur(5px)'
                            }} />

                        {/* 7. Limb Darkening & Rayleigh Scattering (Horizon Blue) */}
                        <div className="absolute inset-0 rounded-full shadow-[inset_0_0_80px_rgba(0,100,255,0.4),0_0_20px_rgba(0,150,255,0.3)]" />

                        {/* 8. Specular Water Glint (Simulating background Nova reflection) */}
                        <div className="absolute top-[30%] left-[30%] w-[20%] h-[20%] bg-white/20 blur-[30px] rounded-full" />
                    </div>
                );
            case 3: // Glacies (Ice) - ABSOLUTE REALISM OVERHAUL
                return (
                    <div className="relative w-full h-full rounded-full bg-[#e0f2fe] overflow-hidden">
                        {/* 1. Deep Subsurface Ice Abyss */}
                        <div className="absolute inset-0 bg-gradient-to-br from-[#7dd3fc] via-[#0ea5e9] to-[#1e40af]" />

                        {/* 2. Crystalline Fractures (SVG Noise based scattering) */}
                        <div className="absolute inset-[-10%] opacity-60 mix-blend-overlay"
                            style={{ background: '#ffffff', filter: 'url(#surface-noise) contrast(2) brightness(1.5)' }} />

                        {/* 3. Deep Shelf Cracks (Structural fractures) */}
                        <div className="absolute inset-0 opacity-40 mix-blend-multiply"
                            style={{
                                background: 'conic-gradient(from 0deg at 50% 50%, transparent, #001133 1%, transparent 2%, #001133 15%, transparent 16%)',
                                filter: 'url(#bg-surface-noise) blur(1px)'
                            }} />

                        {/* 4. Translucent Nitrogen Frost */}
                        <div className="absolute inset-[-20%] opacity-30 animate-drift-slow"
                            style={{
                                background: 'radial-gradient(circle at 30% 30%, white 0%, transparent 60%)',
                                filter: 'url(#cloud-drift) blur(10px)'
                            }} />

                        {/* 5. Sharp Specular Highlights (Icy Glint) */}
                        <div className="absolute top-[20%] left-[20%] w-[30%] h-[30%] bg-white/40 blur-[30px] rounded-full" />

                        {/* 6. Realistic Global Shadow (Simulating Nova lighting) */}
                        <div className="absolute inset-0 bg-gradient-to-tr from-[#000d1a]/80 via-transparent to-transparent" />

                        {/* 7. Limb Scattering (Cyan Glow) */}
                        <div className="absolute inset-0 rounded-full shadow-[inset_0_0_60px_rgba(0,255,255,0.3)]" />
                    </div>
                );
            case 4: // Fulata (Gas Giant) - ABSOLUTE REALISM OVERHAUL
                return (
                    <div className="relative w-full h-full rounded-full bg-[#3d2b1f] overflow-hidden">
                        {/* 1. Atmospheric Foundation */}
                        <div className="absolute inset-0 bg-gradient-to-b from-[#5c4033] via-[#3d2b1f] to-[#1a110a]" />

                        {/* 2. Turbulent Cloud Bands (SVG Noise Based) */}
                        <div className="absolute inset-[-20%] opacity-80"
                            style={{
                                background: 'repeating-linear-gradient(0deg, #5c4033 0%, #8b4513 10%, #d2b48c 20%, #5c4033 30%)',
                                filter: 'url(#cloud-drift) blur(1px)'
                            }} />

                        {/* 3. The Great Red Spot (Vortex Simulation) */}
                        <div className="absolute bottom-[25%] right-[25%] w-[25%] h-[15%] opacity-90 mix-blend-overlay rotate-[10deg]"
                            style={{
                                background: 'radial-gradient(ellipse at center, #991111 0%, #440000 60%, transparent 100%)',
                                filter: 'url(#lava-noise) blur(2px)'
                            }} />

                        {/* 4. Secondary Storm Vortices */}
                        {[
                            { t: '15%', l: '20%', s: '12%', color: '#d2b48c' },
                            { t: '45%', l: '60%', s: '8%', color: '#ffffff' },
                            { t: '70%', l: '15%', s: '10%', color: '#8b4513' }
                        ].map((s, i) => (
                            <div key={i} className="absolute opacity-40 mix-blend-soft-light"
                                style={{
                                    top: s.t, left: s.l, width: s.s, height: s.s,
                                    background: `radial-gradient(circle, ${s.color} 0%, transparent 70%)`,
                                    filter: 'url(#cloud-drift)'
                                }} />
                        ))}

                        {/* 5. High-Altitude Haze / Limb Effects */}
                        <div className="absolute inset-0 rounded-full shadow-[inset_0_0_60px_rgba(0,0,0,0.8),0_0_20px_rgba(255,255,255,0.1)]" />
                    </div>
                );
            case 5: // Aureus (Golden Rings) - ABSOLUTE REALISM OVERHAUL
                return (
                    <div className="relative w-full h-full flex items-center justify-center">
                        {/* 1. Main Metallic Sphere (Planet Body) */}
                        <div className="relative w-full h-full rounded-full bg-[#b45309] z-10 overflow-hidden">
                            {/* Base Gold/Copper Heat */}
                            <div className="absolute inset-0 bg-gradient-to-br from-[#fcd34d] via-[#b45309] to-[#451a03]" />

                            {/* Anisotropic Metallic Grain (SVG Noise) */}
                            <div className="absolute inset-[-20%] opacity-50 mix-blend-overlay rotate-[15deg]"
                                style={{ background: '#d1a000', filter: 'url(#bg-surface-noise) contrast(1.5) brightness(1.2)' }} />

                            {/* RING SHADOW (Physically correct onto surface) */}
                            <div className="absolute top-[48%] left-[-20%] w-[140%] h-[15%] bg-black/80 blur-[8px] rotate-[-12deg]" />

                            {/* Limb Darkness & Specular Glint */}
                            <div className="absolute inset-0 rounded-full shadow-[inset_0_0_80px_rgba(0,0,0,0.9)]" />
                            <div className="absolute top-[10%] left-[20%] w-[40%] h-[20%] bg-white/10 blur-[20px] rounded-full" />
                        </div>

                        {/* 2. Realistic Ring System (Back Portion) */}
                        <div className="absolute w-[240%] h-[20%] z-0 pointer-events-none transform -rotate-12 scale-y-[0.4]">
                            <div className="absolute inset-0 border-[40px] border-[#fbbf24]/20 rounded-[50%] blur-[2px]"
                                style={{ clipPath: 'polygon(0 0, 100% 0, 100% 45%, 0 45%)' }} />
                        </div>

                        {/* 3. Realistic Ring System (Front Portion - Multi-Staged Bands) */}
                        <div className="absolute w-[240%] h-[20%] z-20 pointer-events-none transform -rotate-12 scale-y-[0.4]">
                            {/* Main B-Ring (Brightest) */}
                            <div className="absolute inset-0 border-[30px] border-[#fef3c7]/60 rounded-[50%] blur-[0.5px]"
                                style={{ clipPath: 'polygon(0 55%, 100% 55%, 100% 100%, 0 100%)' }} />

                            {/* Cassini Division (The radial gap) */}
                            <div className="absolute inset-[-5%] border-[2px] border-black/40 rounded-[50%]"
                                style={{ clipPath: 'polygon(0 55%, 100% 55%, 100% 100%, 0 100%)' }} />

                            {/* A-Ring (Outer faint) */}
                            <div className="absolute inset-[-12%] border-[15px] border-[#fbbf24]/30 rounded-[50%] blur-[1px]"
                                style={{ clipPath: 'polygon(0 55%, 100% 55%, 100% 100%, 0 100%)' }} />

                            {/* C-Ring (Inner very faint/crepe) */}
                            <div className="absolute inset-[18%] border-[10px] border-[#451a03]/20 rounded-[50%] blur-[3px]"
                                style={{ clipPath: 'polygon(0 55%, 100% 55%, 100% 100%, 0 100%)' }} />

                            {/* Ring Micro-Debris Noise */}
                            <div className="absolute inset-[-15%] opacity-10 mix-blend-screen"
                                style={{ background: 'radial-gradient(circle, white 0%, transparent 70%)', filter: 'url(#bg-surface-noise)' }} />
                        </div>
                    </div>
                );
            case 6: // Nebula - ABSOLUTE REALISM OVERHAUL
                return (
                    <div className="relative w-full h-full rounded-full bg-transparent overflow-visible">
                        {/* 1. Volumetric Gas Sheets (Layered SVG Noise) */}
                        <div className="absolute inset-[-40%] opacity-60 mix-blend-screen"
                            style={{
                                background: 'radial-gradient(circle at 40% 40%, #4c1d95 0%, transparent 60%)',
                                filter: 'url(#cloud-drift) blur(10px)'
                            }} />
                        <div className="absolute inset-[-30%] opacity-50 mix-blend-color-dodge"
                            style={{
                                background: 'radial-gradient(circle at 60% 70%, #9d174d 0%, transparent 55%)',
                                filter: 'url(#cloud-drift) blur(15px)'
                            }} />
                        <div className="absolute inset-[-20%] opacity-40 mix-blend-screen"
                            style={{
                                background: 'radial-gradient(circle at 50% 30%, #075985 0%, transparent 45%)',
                                filter: 'url(#bg-surface-noise) blur(20px)'
                            }} />

                        {/* 2. Dark Interstellar Dust Lanes (Interfering noise) */}
                        <div className="absolute inset-[10%] opacity-80 mix-blend-multiply"
                            style={{
                                background: '#000000',
                                filter: 'url(#cloud-drift) contrast(1.5) blur(2px)'
                            }} />

                        {/* 3. Protostellar Hotspots (Localized stellar birth) */}
                        {[
                            { t: '30%', l: '40%', s: '15%', color: '#60a5fa' },
                            { t: '60%', l: '30%', s: '12%', color: '#f472b6' },
                            { t: '25%', l: '65%', s: '10%', color: '#ffffff' }
                        ].map((h, i) => (
                            <div key={i} className="absolute rounded-full filter blur-[10px] animate-pulse"
                                style={{ top: h.t, left: h.l, width: h.s, height: h.s, background: h.color, opacity: 0.4 }} />
                        ))}

                        {/* 4. Global Chromatic Bloom */}
                        <div className="absolute inset-[-50%] rounded-full bg-blue-500/5 blur-[50px] pointer-events-none" />
                    </div>
                );
            case 7: // Void (Black Hole) - ABSOLUTE REALISM OVERHAUL
                return (
                    <div className="relative w-full h-full flex items-center justify-center scale-[1.2]">
                        {/* 1. Photon Sphere & Gravitational Lensing (Outer distorting glow) */}
                        <div className="absolute w-[200%] h-[200%] rounded-full bg-[radial-gradient(circle,rgba(255,255,255,0.05)_0%,transparent_70%)] blur-[40px]" />

                        {/* 2. Accretion Disk (Physically asymmetric relativistic beaming) */}
                        <div className="absolute w-[250%] h-[250%] rotate-x-[75deg] rotate-y-[10deg] animate-spin-slow"
                            style={{
                                background: 'conic-gradient(from -90deg, transparent 0%, #3b82f6 10%, #fff 15%, #a855f7 25%, transparent 40%, #ec4899 70%, #fff 75%, #3b82f6 85%, transparent 100%)',
                                filter: 'url(#lava-noise) blur(4px)'
                            }} />

                        {/* 3. Event Horizon (The absolute black core) */}
                        <div className="relative w-[50%] h-[50%] rounded-full bg-black z-20 shadow-[0_0_40px_rgba(0,0,0,1)]">
                            {/* Inner Rim Light (Lensing artifacts) */}
                            <div className="absolute inset-[-2px] rounded-full border border-white/20 blur-[1px]" />
                        </div>

                        {/* 4. Polar Jets (Gamma Ray Bursts - Faint linear beams) */}
                        <div className="absolute w-[2px] h-[500%] bg-gradient-to-b from-transparent via-white/20 to-transparent blur-[3px] z-0 rotate-[-15deg]" />
                    </div>
                );
            case 8: // Nova (Active Star / SUN) - ABSOLUTE REALISM OVERHAUL
                return (
                    <div className="relative w-full h-full rounded-full bg-[#fbd34d] overflow-visible">
                        {/* 1. Photosphere with Limb Darkening (Critical for spherical feel) */}
                        <div className="absolute inset-0 rounded-full bg-gradient-to-br from-[#fff7ed] via-[#f59e0b] to-[#7f1d1d]" />
                        <div className="absolute inset-0 rounded-full bg-[radial-gradient(circle,transparent_50%,rgba(127,29,29,0.8)_100%)]" />

                        {/* 2. Solar Granulation (Boiling Convection Cells) */}
                        <div className="absolute inset-[-20%] opacity-95 mix-blend-overlay"
                            style={{ filter: 'url(#solar-granulation) contrast(1.8) brightness(1.3)' }} />

                        {/* 3. Solar Prominences (Plasma Loops breaking silhouette) */}
                        <div className="absolute inset-[-15%] opacity-60 mix-blend-color-dodge"
                            style={{
                                background: 'conic-gradient(from 0deg at 50% 50%, transparent, #ffcc00 1%, transparent 3%, #ff4d00 15%, transparent 18%)',
                                filter: 'url(#lava-noise) blur(1px)'
                            }} />

                        {/* 4. Realistic Sunspots (Umbra + Penumbra) */}
                        {[
                            { t: '30%', l: '40%', s: '18px' },
                            { t: '65%', l: '30%', s: '12px' },
                            { t: '25%', l: '65%', s: '8px' }
                        ].map((s, i) => (
                            <div key={i} className="absolute flex items-center justify-center" style={{ top: s.t, left: s.l, width: s.s, height: s.s }}>
                                {/* Penumbra (Lighter, structured rim) */}
                                <div className="absolute w-[140%] h-[140%] rounded-full bg-[#451a03]/60 blur-[1px] mix-blend-multiply" />
                                {/* Umbra (Dark central core) */}
                                <div className="absolute w-full h-full rounded-full bg-black blur-[0.2px]" />
                            </div>
                        ))}

                        {/* 5. Chromospheric Edge Bleed & Coronal Flow */}
                        <div className="absolute inset-0 rounded-full shadow-[inset_0_0_80px_rgba(245,158,11,0.6),0_0_40px_rgba(255,255,255,0.2)]" />
                        <div className="absolute inset-[-40%] opacity-20 mix-blend-screen"
                            style={{ background: 'radial-gradient(circle, white 0%, transparent 70%)', filter: 'url(#cloud-drift) blur(40px)' }} />
                    </div>
                );
            case 9: // Singularity - ABSOLUTE REALISM OVERHAUL
                return (
                    <div className="relative w-full h-full flex items-center justify-center scale-[1.3]">
                        {/* 1. Spacetime Distortion (High-frequency SVG interference) */}
                        <div className="absolute inset-[-40%] opacity-40 mix-blend-screen animate-spin-slow"
                            style={{ filter: 'url(#lava-noise) blur(2px)' }}>
                            <div className="absolute inset-x-0 top-1/2 h-1 bg-white/40 shadow-[0_0_20px_white]" />
                            <div className="absolute inset-y-0 left-1/2 w-1 bg-white/40 shadow-[0_0_20px_white]" />
                        </div>

                        {/* 2. The Monolith Core (Perfect Void) */}
                        <div className="relative w-[45%] h-[45%] rounded-full bg-black z-20 shadow-[0_0_100px_white]">
                            {/* Crystalline Artifacts (Non-Euclidean noise) */}
                            <div className="absolute inset-[-10%] opacity-60 mix-blend-color-dodge"
                                style={{ filter: 'url(#surface-noise) contrast(5) brightness(2)' }} />

                            {/* Inner Radiant Pulsar */}
                            <div className="absolute inset-[25%] bg-white rounded-full blur-[20px] animate-pulse" />
                        </div>

                        {/* 3. Reality Threads (Stretched Light Rays) */}
                        {[0, 45, 90, 135].map((r, i) => (
                            <div key={i} className="absolute w-[1px] h-[600%] bg-gradient-to-b from-transparent via-white/50 to-transparent opacity-20"
                                style={{ transform: `rotate(${r}deg)` }} />
                        ))}

                        {/* 4. Chromatic Aberration Halo */}
                        <div className="absolute inset-[-10%] border-4 border-red-500/20 blur-[5px] rounded-full animate-pulse" />
                        <div className="absolute inset-[-10%] border-4 border-cyan-500/20 blur-[5px] rounded-full animate-pulse delay-75" />
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
