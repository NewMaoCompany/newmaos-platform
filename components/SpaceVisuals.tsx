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
            case 0: // Celestia (Moon) - HIGH DETAIL OVERHAUL
                return (
                    <div className="relative w-full h-full rounded-full bg-[#1a1a1a] shadow-[inset_-25px_-25px_60px_rgba(0,0,0,0.9),inset_10px_10px_30px_rgba(255,255,255,1)]">
                        {/* Base Solid Surface */}
                        <div className="absolute inset-0 rounded-full bg-slate-300" />

                        {/* Base Texture - High Contrast Noise */}
                        <div className="absolute inset-0 opacity-70 mix-blend-multiply bg-[url('https://www.transparenttextures.com/patterns/stardust.png')] filter contrast-150" />

                        {/* Gradient Mesh for Spherical Feel */}
                        <div className="absolute inset-0 bg-radial-gradient from-transparent via-slate-400/30 to-slate-950/90" />

                        {/* Large Lunar Maria (Dark Seas) - Layered for complexity */}
                        <div className="absolute top-[15%] left-[25%] w-[25%] h-[18%] bg-slate-700/30 rounded-[40%_60%_70%_30%] filter blur-[5px] mix-blend-multiply" />
                        <div className="absolute top-[40%] left-[10%] w-[35%] h-[28%] bg-slate-700/30 rounded-[60%_40%_30%_70%] filter blur-[8px] mix-blend-multiply" />
                        <div className="absolute bottom-[20%] right-[15%] w-[30%] h-[22%] bg-slate-700/30 rounded-[30%_70%_50%_50%] filter blur-[6px] mix-blend-multiply" />

                        {/* Detail Craters with Rim Lighting - Varied Sizes */}
                        {[
                            { t: '22%', l: '62%', s: '12%', op: 0.6 }, { t: '55%', l: '75%', s: '8%', op: 0.5 },
                            { t: '68%', l: '28%', s: '14%', op: 0.7 }, { t: '35%', l: '35%', s: '6%', op: 0.4 },
                            { t: '82%', l: '58%', s: '9%', op: 0.6 }, { t: '18%', l: '38%', s: '4%', op: 0.3 },
                            { t: '45%', l: '15%', s: '5%', op: 0.4 }, { t: '60%', l: '50%', s: '3%', op: 0.3 }
                        ].map((c, i) => (
                            <div key={i} className="absolute rounded-full bg-slate-500/20 shadow-[inset_2px_2px_5px_rgba(0,0,0,0.8),1px_1px_1px_rgba(255,255,255,0.5)]"
                                style={{ top: c.t, left: c.l, width: c.s, height: c.s, opacity: c.op }} />
                        ))}

                        {/* Surface Roughness / Micro-Impacts */}
                        <div className="absolute inset-0 opacity-20 bg-[url('https://www.transparenttextures.com/patterns/black-scales.png')] mix-blend-overlay" />
                    </div>
                );
            case 1: // Ignis (Volcanic) - HYPER REALISM OVERHAUL
                return (
                    <div className="relative w-full h-full rounded-full bg-black shadow-[inset_-30px_-30px_100px_rgba(0,0,0,1),inset_10px_10px_50px_rgba(255,50,0,0.4)] overflow-hidden">
                        {/* 1. Deep Core Heat */}
                        <div className="absolute inset-0 bg-gradient-to-br from-[#ff2200] via-[#550000] to-black" />

                        {/* 2. Molten Lava Veins - High-frequency noise simulation */}
                        <div className="absolute inset-0 opacity-100 mix-blend-screen mix-blend-color-dodge filter contrast-[3] brightness-[1.2]"
                            style={{
                                backgroundImage: `
                                    radial-gradient(circle at 35% 45%, #ff5500 0%, transparent 12%),
                                    radial-gradient(circle at 65% 55%, #ff8800 0%, transparent 15%),
                                    radial-gradient(circle at 50% 50%, #ff1100 0%, transparent 20%),
                                    conic-gradient(from 120deg at 40% 40%, transparent, #ff4400 5%, transparent 10%, #ff0000 25%, transparent 30%)
                                `
                            }}
                        />

                        {/* 3. Solidifying Basalt Crust (High-Detail Texture) */}
                        <div className="absolute inset-0 bg-[url('https://www.transparenttextures.com/patterns/black-mamba.png')] opacity-90 mix-blend-multiply scale-[2]" />
                        <div className="absolute inset-0 bg-[url('https://www.transparenttextures.com/patterns/asfalt-dark.png')] opacity-70 mix-blend-multiply" />

                        {/* 4. Large Continent Plates (Basalt) */}
                        <div className="absolute top-[15%] left-[10%] w-[40%] h-[30%] bg-[#080808] rounded-[60%_40%_70%_30%] filter blur-[3px] opacity-95 shadow-lg" />
                        <div className="absolute top-[50%] left-[55%] w-[35%] h-[35%] bg-[#050505] rounded-[40%_60%_30%_70%] filter blur-[4px] opacity-98" />
                        <div className="absolute bottom-[10%] left-[25%] w-[50%] h-[25%] bg-[#0a0a0a] rounded-[30%_70%_50%_40%] filter blur-[2px] opacity-95" />

                        {/* 5. Gaseous Sulfur Fumes / Volcanic Ash */}
                        <div className="absolute inset-0 opacity-20 bg-[radial-gradient(circle_at_40%_40%,_rgba(255,255,0,0.1),_transparent_60%)] mix-blend-overlay" />

                        {/* 6. Surface Micro-Texture & Crater Shadows */}
                        <div className="absolute inset-0 opacity-40 mix-blend-overlay bg-[url('https://www.transparenttextures.com/patterns/carbon-fibre.png')] scale-150 rotate-45" />

                        {/* 7. Rim Glow from Magma */}
                        <div className="absolute inset-0 rounded-full shadow-[inset_0_0_25px_rgba(255,68,0,0.5)]" />
                    </div>
                );
            case 2: // Terra (Earth-like) - NASA STYLE OVERHAUL
                return (
                    <div className="relative w-full h-full rounded-full bg-[#0a1e4d] shadow-[inset_-40px_-40px_80px_rgba(0,0,0,1),inset_15px_15px_40px_rgba(100,200,255,0.3)] overflow-hidden">
                        {/* 1. Deep Oceanic Abyss */}
                        <div className="absolute inset-0 bg-gradient-to-br from-[#1e40af] via-[#1e3a8a] to-[#0f172a]" />

                        {/* 2. Continental Crust (Layered Greens/Browns) */}
                        {/* Continent 1 */}
                        <div className="absolute top-[12%] left-[20%] w-[45%] h-[40%] bg-[#064e3b] rounded-[45%_55%_70%_30%] filter blur-[10px] opacity-60" />
                        <div className="absolute top-[15%] left-[22%] w-[40%] h-[35%] bg-[#065f46] rounded-[40%_60%_65%_35%] filter blur-[3px] opacity-90 shadow-inner" />
                        <div className="absolute top-[20%] left-[25%] w-[30%] h-[25%] bg-[#14532d] rounded-[35%_65%_60%_40%] opacity-95" />
                        <div className="absolute top-[25%] left-[30%] w-[15%] h-[10%] bg-[#422006]/30 rounded-full filter blur-[4px]" />

                        {/* Continent 2 */}
                        <div className="absolute bottom-[15%] right-[15%] w-[38%] h-[35%] bg-[#064e3b] rounded-[30%_70%_60%_50%] filter blur-[8px] opacity-60" />
                        <div className="absolute bottom-[18%] right-[18%] w-[33%] h-[30%] bg-[#14532d] rounded-[35%_65%_55%_45%] filter blur-[2px] opacity-95" />

                        {/* 3. Coastal Shallows (Turquoise) */}
                        <div className="absolute top-[14%] left-[21%] w-[42%] h-[37%] border-[8px] border-[#06b6d4]/10 rounded-[45%_55%_70%_30%] filter blur-[6px]" />
                        <div className="absolute bottom-[17%] right-[17%] w-[35%] h-[32%] border-[6px] border-[#0ea5e9]/10 rounded-[30%_70%_60%_50%] filter blur-[5px]" />

                        {/* 4. Specular Water Glint (Sunlight Reflection) */}
                        <div className="absolute top-[10%] left-[10%] w-[40%] h-[30%] bg-[radial-gradient(circle,_rgba(255,255,255,0.15)_0%,_transparent_70%)] filter blur-[10px] mix-blend-screen" />

                        {/* 5. Realistic Cloud Formations (Multi-Scattered Patterns) */}
                        <div className="absolute inset-[-10%] opacity-40 mix-blend-screen animate-pulse-slow pointer-events-none"
                            style={{ backgroundImage: 'radial-gradient(circle at 35% 35%, white 0%, transparent 20%), radial-gradient(circle at 65% 25%, white 0%, transparent 25%), radial-gradient(circle at 20% 70%, white 0%, transparent 15%)', filter: 'blur(20px)' }} />
                        <div className="absolute inset-0 opacity-25 mix-blend-screen bg-[url('https://www.transparenttextures.com/patterns/stardust.png')] filter blur-[0.5px] scale-125" />
                        <div className="absolute top-[-10%] left-[-10%] w-[120%] h-[120%] opacity-15 rotate-12 bg-[url('https://www.transparenttextures.com/patterns/natural-paper.png')] mix-blend-screen" />

                        {/* 6. Polar Ice Sheets */}
                        <div className="absolute top-[-8%] left-[20%] w-[60%] h-[20%] bg-white/95 blur-[12px] rounded-full" />
                        <div className="absolute bottom-[-6%] left-[25%] w-[50%] h-[15%] bg-white/90 blur-[15px] rounded-full" />

                        {/* 7. Rayleigh Scattering (Blue Horizon Edge) */}
                        <div className="absolute inset-0 border-[15px] border-[#60a5fa]/5 rounded-full filter blur-[10px]" />
                    </div>
                );
            case 3: // Glacies (Ice) - HYPER REALISM OVERHAUL
                return (
                    <div className="relative w-full h-full rounded-full bg-cyan-50 shadow-[inset_-30px_-30px_70px_rgba(0,100,200,0.4),inset_15px_15px_50px_rgba(255,255,255,0.8)] overflow-hidden">
                        {/* 1. Deep Subsurface Ice */}
                        <div className="absolute inset-0 bg-gradient-to-br from-[#cffafe] via-[#7dd3fc] to-[#1e40af]" />

                        {/* 2. Crystalline Fractures (Sharp Geometric Patterns) */}
                        <div className="absolute inset-0 opacity-40 mix-blend-overlay bg-[url('https://www.transparenttextures.com/patterns/diamond-upholstery.png')] scale-150 rotate-[-15deg]" />

                        {/* 3. Frost Layers & Glacial Ridges */}
                        <div className="absolute inset-0 opacity-30 mix-blend-color-dodge bg-[url('https://www.transparenttextures.com/patterns/stardust.png')] filter hue-rotate-180" />
                        <div className="absolute top-[20%] left-[15%] w-[50%] h-[30%] bg-white/20 blur-[15px] rotate-12" />
                        <div className="absolute bottom-[30%] right-[10%] w-[40%] h-[20%] bg-blue-900/10 blur-[10px] -rotate-6" />

                        {/* 4. Sharp Subsurface Cracks */}
                        {[
                            { t: '15%', l: '25%', w: '100px', r: '35deg' },
                            { t: '65%', l: '45%', w: '140px', r: '-20deg' },
                            { t: '40%', l: '60%', w: '80px', r: '10deg' }
                        ].map((f, i) => (
                            <div key={i} className="absolute bg-white/40 h-[1px] blur-[0.5px]"
                                style={{ top: f.t, left: f.l, width: f.w, transform: `rotate(${f.r})`, boxShadow: '0 0 4px cyan' }} />
                        ))}

                        {/* 5. Surface Roughness / Snow Cover */}
                        <div className="absolute inset-0 opacity-50 mix-blend-overlay bg-[url('https://www.transparenttextures.com/patterns/black-paper.png')] scale-110" />

                        {/* 6. Specular Ice Glint */}
                        <div className="absolute top-[18%] left-[22%] w-[12%] h-[12%] bg-white rounded-full blur-[10px] opacity-80" />

                        {/* 7. Limb Shadowing */}
                        <div className="absolute inset-0 rounded-full bg-radial-gradient from-transparent via-transparent to-black/40" />
                    </div>
                );
            case 4: // Fulata (Gas Giant) - HYPER REALISM OVERHAUL
                return (
                    <div className="relative w-full h-full rounded-full bg-[#92400e] shadow-[inset_-40px_-40px_100px_rgba(0,0,0,0.8)] overflow-hidden">
                        {/* 1. Base Atmospheric Foundation */}
                        <div className="absolute inset-0 bg-gradient-to-b from-[#fdba74] via-[#92400e] to-[#451a03]" />

                        {/* 2. Turbulent Cloud Bands (Multi-Layered) */}
                        <div className="absolute inset-0 flex flex-col scale-y-[1.15] -rotate-6 opacity-95">
                            <div className="h-[12%] bg-gradient-to-r from-[#fb923c] via-[#f97316] to-[#fb923c] filter blur-[4px]" />
                            <div className="h-[8%] bg-gradient-to-r from-[#7c2d12] to-[#451a03] filter blur-[3px]" />
                            <div className="h-[20%] bg-gradient-to-r from-[#fed7aa] via-[#ffedd5] to-[#fed7aa] filter blur-[6px] opacity-80" />
                            <div className="h-[15%] bg-gradient-to-r from-[#c2410c] via-[#9a3412] to-[#c2410c] filter blur-[5px]" />
                            <div className="h-[25%] bg-gradient-to-r from-[#fcd34d] via-[#fbbf24] to-[#fcd34d] filter blur-[7px] opacity-70" />
                            <div className="h-[10%] bg-gradient-to-r from-[#451a03] to-[#7c2d12] filter blur-[4px]" />
                        </div>

                        {/* 3. Gaseous Vortices & Swirls (Texture-based) */}
                        <div className="absolute inset-0 opacity-30 mix-blend-soft-light bg-[url('https://www.transparenttextures.com/patterns/wood-pattern.png')] filter contrast-150 brightness-75 scale-x-[2]" />
                        <div className="absolute inset-0 opacity-20 mix-blend-overlay animate-pulse-slow bg-[url('https://www.transparenttextures.com/patterns/stardust.png')]" />

                        {/* 4. The Great Red Spot (High Detail Storm) */}
                        <div className="absolute bottom-[28%] right-[18%] w-[28%] h-[20%] bg-gradient-to-br from-[#7f1d1d] via-[#991b1b] to-black rounded-[55%] blur-[1px] rotate-12 shadow-[inset_0_0_20px_rgba(0,0,0,0.5)] border border-red-900/30 overflow-hidden">
                            <div className="absolute inset-0 bg-[url('https://www.transparenttextures.com/patterns/wavecut.png')] opacity-40 mix-blend-multiply rotate-45" />
                        </div>

                        {/* 5. Smaller Storm Eddies */}
                        <div className="absolute top-[35%] left-[30%] w-[10%] h-[7%] bg-white/30 rounded-full blur-[3px]" />
                        <div className="absolute bottom-[45%] left-[45%] w-[7%] h-[5%] bg-black/40 rounded-full blur-[2px]" />

                        {/* 6. Rayleigh Scattering / Atmospheric Limb */}
                        <div className="absolute inset-0 rounded-full bg-radial-gradient from-transparent via-transparent to-black/70" />
                    </div>
                );
            case 5: // Aureus (Golden Rings) - HYPER REALISM OVERHAUL
                return (
                    <div className="relative w-full h-full flex items-center justify-center">
                        {/* 1. Main Metallic Sphere */}
                        <div className="relative w-full h-full rounded-full bg-gradient-to-br from-[#fcd34d] via-[#b45309] to-[#451a03] shadow-[inset_-25px_-25px_60px_rgba(0,0,0,1),inset_10px_10px_30px_rgba(255,255,255,0.5)] z-10 overflow-hidden">
                            {/* Gold Surface Texture (Granulated Metal) */}
                            <div className="absolute inset-0 opacity-50 mix-blend-multiply bg-[url('https://www.transparenttextures.com/patterns/brushed-alum.png')] scale-110" />
                            <div className="absolute inset-0 opacity-30 mix-blend-color-dodge bg-[url('https://www.transparenttextures.com/patterns/stardust.png')]" />

                            {/* Surface Specular Highlight */}
                            <div className="absolute top-[20%] left-[20%] w-[50%] h-[30%] bg-white/20 blur-[15px] rotate-12" />

                            {/* RING SHADOWS - Cast on planet surface */}
                            <div className="absolute top-[48%] left-[-10%] w-[120%] h-[12%] bg-black/70 blur-[5px] rotate-[-12deg]" />
                        </div>

                        {/* 2. Complex Ring System - Layered Depth */}
                        {/* Back Rings */}
                        <div className="absolute w-[220%] h-[20%] opacity-40 mix-blend-screen z-0">
                            {[0, 15, 30].map((offset, i) => (
                                <div key={i} className="absolute inset-0 border-[30px] border-[#fbbf24]/20 rounded-[50%] transform -rotate-12 scale-y-[0.45] blur-[1px]"
                                    style={{ clipPath: 'polygon(0 0, 100% 0, 100% 48%, 0 48%)', top: `${offset}px` }} />
                            ))}
                        </div>

                        {/* Front Rings (Realistic Bands & Cassini Division simulation) */}
                        <div className="absolute w-[220%] h-[20%] z-20 pointer-events-none transform -rotate-12 scale-y-[0.45]">
                            {/* Main Ring Band */}
                            <div className="absolute inset-0 border-[20px] border-[#fef3c7]/60 rounded-[50%] blur-[0.5px]"
                                style={{ clipPath: 'polygon(0 52%, 100% 52%, 100% 100%, 0 100%)' }} />
                            {/* Outer Faint Ring */}
                            <div className="absolute inset-[-10%] border-[8px] border-[#fde68a]/30 rounded-[50%]"
                                style={{ clipPath: 'polygon(0 52%, 100% 52%, 100% 100%, 0 100%)' }} />
                            {/* Inner Dark Band (Cassini-like) */}
                            <div className="absolute inset-[15%] border-[12px] border-[#451a03]/40 rounded-[50%] blur-[1px]"
                                style={{ clipPath: 'polygon(0 52%, 100% 52%, 100% 100%, 0 100%)' }} />
                        </div>

                        {/* Ring Specular Reflections */}
                        <div className="absolute w-[210%] h-[1%] bg-white/20 blur-[10px] z-30 transform -rotate-12 translate-y-8" />
                    </div>
                );
            case 6: // Nebula - HYPER REALISM OVERHAUL
                return (
                    <div className="relative w-full h-full rounded-full bg-transparent overflow-hidden filter blur-[1px]">
                        {/* 1. Deep Space Base */}
                        <div className="absolute inset-0 rounded-full bg-[#020617]" />

                        {/* 2. Volumetric Gas Sheets - Layered Gradients */}
                        <div className="absolute inset-[-25%] opacity-70 mix-blend-screen filter blur-[20px] animate-pulse-slow"
                            style={{ background: 'radial-gradient(circle at 30% 30%, #4c1d95 0%, transparent 60%)' }} />
                        <div className="absolute inset-[-15%] opacity-60 mix-blend-screen filter blur-[25px]"
                            style={{ background: 'radial-gradient(circle at 70% 60%, #9d174d 0%, transparent 55%)' }} />
                        <div className="absolute inset-[-5%] opacity-50 mix-blend-color-dodge filter blur-[15px] animate-bounce-slow"
                            style={{ background: 'radial-gradient(circle at 50% 40%, #075985 0%, transparent 45%)' }} />

                        {/* 3. Dark Interstellar Dust Lanes (Silhouettes) */}
                        <div className="absolute top-[35%] left-[20%] w-[70%] h-[25%] bg-black/50 blur-[8px] rotate-[-18deg]" />
                        <div className="absolute bottom-[25%] right-[25%] w-[50%] h-[20%] bg-black/40 blur-[10px] rotate-[15deg]" />

                        {/* 4. Stellar Birth Clusters (Detailed Star Points) */}
                        {[
                            { t: '30%', l: '40%', s: '4px', glow: '#fff' },
                            { t: '65%', l: '70%', s: '3px', glow: '#60a5fa' },
                            { t: '20%', l: '60%', s: '5px', glow: '#f472b6' },
                            { t: '75%', l: '25%', s: '2px', glow: '#fff' }
                        ].map((s, i) => (
                            <div key={i} className="absolute rounded-full animate-pulse"
                                style={{ top: s.t, left: s.l, width: s.s, height: s.s, background: 'white', boxShadow: `0 0 8px ${s.glow}` }} />
                        ))}

                        {/* 5. Gaseous Turbulence Texture */}
                        <div className="absolute inset-0 opacity-20 mix-blend-overlay bg-[url('https://www.transparenttextures.com/patterns/stardust.png')] scale-150 rotate-90" />

                        {/* 6. Overall Halo Ambient */}
                        <div className="absolute inset-0 bg-radial-gradient from-transparent to-black/90" />
                    </div>
                );
            case 7: // Void (Black Hole) - HYPER REALISM OVERHAUL
                return (
                    <div className="relative w-full h-full flex items-center justify-center">
                        {/* 1. Gravitational Lensing Distortion Field (The large outer glow) */}
                        <div className="absolute w-[280%] h-[280%] rounded-full border-[2px] border-white/5 opacity-10 animate-ping duration-[10s]" />

                        {/* 2. Accretion Disk (Asymmetric Relativistic Beaming) */}
                        {/* The disk is brighter on the side moving towards the viewer */}
                        <div className="absolute w-[220%] h-[220%] rounded-full opacity-90 animate-spin-slow pointer-events-none"
                            style={{
                                background: 'conic-gradient(from -90deg, transparent 0%, #3b82f6 10%, #fff 15%, #a855f7 25%, transparent 40%, #ec4899 70%, #fff 75%, #3b82f6 85%, transparent 100%)',
                                filter: 'blur(10px)',
                                transform: 'rotateX(75deg) rotateY(10deg) scale(1.3)'
                            }}
                        />
                        {/* Inner high-speed flow */}
                        <div className="absolute w-[160%] h-[160%] rounded-full opacity-100 animate-spin"
                            style={{
                                background: 'conic-gradient(from 120deg, transparent 0%, #fff 10%, transparent 20%)',
                                filter: 'blur(20px)',
                                transform: 'rotateX(75deg) rotateY(10deg)',
                                animationDuration: '3s'
                            }}
                        />

                        {/* 3. The Photon Ring (The sharp line of light around the shadow) */}
                        <div className="absolute w-[104%] h-[104%] rounded-full border-[3px] border-white/90 shadow-[0_0_25px_rgba(255,255,255,0.8),inset_0_0_15px_rgba(255,255,255,0.8)] z-20" />

                        {/* 4. Event Horizon (The Shadow) */}
                        <div className="relative w-full h-full rounded-full bg-black shadow-[0_0_60px_#000] z-30" />

                        {/* 5. Relativistic Jets (Polar Outflows) */}
                        <div className="absolute w-[3px] h-[400%] bg-gradient-to-b from-transparent via-[#06b6d4]/40 to-transparent blur-[3px] rotate-[-75deg] z-0" />
                    </div>
                );
            case 8: // Nova (Active Star / SUN) - HYPER REALISM OVERHAUL
                return (
                    <div className="relative w-full h-full rounded-full bg-[#fbbf24] shadow-[0_0_150px_rgba(245,158,11,0.8),inset_-50px_-50px_100px_rgba(120,20,0,1)] z-10 overflow-hidden">
                        {/* 1. Photosphere Base (Radiant Core) */}
                        <div className="absolute inset-0 bg-gradient-to-br from-[#fff7ed] via-[#f59e0b] to-[#7f1d1d]" />

                        {/* 2. Solar Granulation (Convection Cells - Orange Peel effect) */}
                        <div className="absolute inset-0 opacity-100 mix-blend-overlay bg-[url('https://www.transparenttextures.com/patterns/binding-dark.png')] filter contrast-[1.8] scale-[2.2]" />
                        <div className="absolute inset-0 opacity-40 mix-blend-multiply bg-[url('https://www.transparenttextures.com/patterns/stardust.png')]" />

                        {/* 3. Active Plages (Bright Heat Flux) */}
                        <div className="absolute top-[25%] right-[20%] w-[35%] h-[25%] bg-yellow-200/40 rounded-full filter blur-[10px] mix-blend-screen" />
                        <div className="absolute bottom-[35%] left-[15%] w-[30%] h-[30%] bg-white/20 rounded-full filter blur-[15px] mix-blend-screen" />

                        {/* 4. Real Sunspots (Umbra/Penumbra Detail) */}
                        {[
                            { t: '32%', l: '28%', s: '12px' }, { t: '33%', l: '30%', s: '6px' }, // Group 1
                            { t: '60%', l: '65%', s: '10px' }, { t: '58%', l: '62%', s: '4px' }, // Group 2
                            { t: '45%', l: '75%', s: '5px' }
                        ].map((s, i) => (
                            <div key={i} className="absolute rounded-full bg-black/90 blur-[0.5px] border border-orange-950/20"
                                style={{ top: s.t, left: s.l, width: s.s, height: s.s, boxShadow: '0 0 5px rgba(251,191,36,0.3)' }} />
                        ))}

                        {/* 5. Gaseous Turbulence Swirls */}
                        <div className="absolute inset-0 opacity-20 mix-blend-screen bg-[url('https://www.transparenttextures.com/patterns/wavecut.png')] rotate-12 scale-150" />

                        {/* 6. Solar Corona Glow (Edge Bleed) */}
                        <div className="absolute inset-0 rounded-full border-[10px] border-orange-400/10 filter blur-[8px]" />
                        <div className="absolute inset-0 rounded-full bg-radial-gradient from-transparent via-transparent to-black/50 opacity-80" />
                    </div>
                );
            case 9: // Singularity - HYPER REALISM OVERHAUL
                return (
                    <div className="relative w-full h-full flex items-center justify-center">
                        {/* 1. Spacetime Warp Distortion */}
                        <div className="absolute w-[220%] h-[220%] border-[2px] border-white/20 rounded-full animate-ping opacity-20" />
                        <div className="absolute w-[180%] h-[180%] border-[1px] border-cyan-400/30 rounded-full animate-ping delay-100 opacity-20 rotate-45" />

                        {/* 2. The Monolith Core (Perfect Information) */}
                        <div className="relative w-[65%] h-[65%] flex items-center justify-center">
                            {/* Rotating Tesseract Representation */}
                            <div className="absolute inset-0 border-[3px] border-white animate-spin-slow duration-[12s]" style={{ transform: 'rotateX(45deg) rotateY(45deg)' }} />
                            <div className="absolute inset-0 border-[2px] border-cyan-300 opacity-60 animate-spin-slow duration-[8s] reverse" style={{ transform: 'rotateX(-30deg) rotateY(-30deg)' }} />

                            {/* The Infinite Light Source */}
                            <div className="absolute inset-[15%] bg-white shadow-[0_0_120px_white] animate-pulse rounded-full z-20" />

                            {/* Chromatic Aberration Edge */}
                            <div className="absolute inset-0 border-2 border-red-500 opacity-50 translate-x-1 blur-[1px] rounded-full animate-pulse" />
                            <div className="absolute inset-0 border-2 border-cyan-500 opacity-50 -translate-x-1 blur-[1px] rounded-full animate-pulse delay-75" />
                        </div>

                        {/* 3. Reality Threads (Data Streams) */}
                        {[45, -45, 0, 90].map((r, i) => (
                            <div key={i} className="absolute w-[1px] h-[500%] bg-gradient-to-b from-transparent via-white/40 to-transparent opacity-30"
                                style={{ transform: `rotate(${r}deg)` }} />
                        ))}
                    </div>
                );
            default:
                return <div className="w-full h-full rounded-full bg-gray-500" />;
        }
    };


    return (
        <div
            className={`relative ${sizeMap[size]} transition-all ${floating ? 'animate-float' : ''} ${className}`}
            style={style}
        >
            {/* Global Atmosphere Glow - Layered Radial Gradients for natural falloff */}
            {showAtmosphere && (
                <>
                    {/* Outer faint glow */}
                    <div
                        className="absolute inset-[-50%] rounded-full z-0 pointer-events-none opacity-30"
                        style={{
                            background: 'radial-gradient(circle, rgba(255,255,255,0.2) 0%, rgba(255,255,255,0.05) 40%, transparent 70%)',
                            filter: 'blur(40px)',
                            transform: 'translateZ(0)' // Hardware acceleration
                        }}
                    />
                    {/* Inner intense glow */}
                    <div
                        className="absolute inset-[-10%] rounded-full z-0 pointer-events-none opacity-40 mix-blend-screen"
                        style={{
                            background: 'radial-gradient(circle, rgba(255,255,255,0.4) 0%, rgba(255,255,255,0.1) 60%, transparent 100%)',
                            filter: 'blur(20px)',
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
