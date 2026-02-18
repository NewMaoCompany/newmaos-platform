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
            case 1: // Ignis (Volcanic) - HIGH DETAIL UPGRADE
                return (
                    <div className="relative w-full h-full rounded-full bg-black shadow-[inset_-25px_-25px_60px_rgba(0,0,0,0.9),inset_10px_10px_20px_rgba(255,69,0,0.4)] overflow-hidden">
                        {/* Solid Scorched Base */}
                        <div className="absolute inset-0 bg-gradient-to-br from-[#1a0505] via-[#2d0a05] to-black" />

                        {/* High Detail Magma Noise Surface */}
                        <div className="absolute inset-0 opacity-60 mix-blend-screen bg-[url('https://www.transparenttextures.com/patterns/stardust.png')] filter contrast-200 saturate-200" />

                        {/* Molten Cracks and Veins (CSS Math) */}
                        <div className="absolute inset-0 opacity-80 mix-blend-color-dodge"
                            style={{ background: 'radial-gradient(circle at 40% 40%, rgba(255,69,0,0.6) 0%, transparent 60%), radial-gradient(circle at 70% 80%, rgba(255,140,0,0.4) 0%, transparent 50%)' }} />

                        {/* Basalt Tectonic Plates (Detailed Dark Masses) */}
                        {[
                            { t: '15%', l: '10%', s: '40%', r: '45%_55%_65%_35%', b: 'blur(5px)' },
                            { t: '50%', l: '60%', s: '35%', r: '60%_40%_30%_70%', b: 'blur(8px)' },
                            { t: '70%', l: '20%', s: '25%', r: '30%_70%_50%_50%', b: 'blur(4px)' }
                        ].map((p, i) => (
                            <div key={i} className="absolute bg-[#0a0505]/90"
                                style={{ top: p.t, left: p.l, width: p.s, height: p.s, borderRadius: p.r, filter: p.b }} />
                        ))}

                        {/* Volcanic Craters with Lava Rim */}
                        {[
                            { t: '30%', l: '40%', s: '12%', op: 0.8 }, { t: '65%', l: '70%', s: '8%', op: 0.6 },
                            { t: '20%', l: '75%', s: '15%', op: 0.7 }, { t: '80%', l: '35%', s: '10%', op: 0.5 }
                        ].map((c, i) => (
                            <div key={i} className="absolute rounded-full bg-black shadow-[inset_2px_2px_5px_rgba(0,0,0,1),1px_1px_1px_rgba(255,69,0,0.5)] border border-red-900/30"
                                style={{ top: c.t, left: c.l, width: c.s, height: c.s, opacity: c.op }} />
                        ))}

                        {/* Heat Haze / Micro-Detail Overlay */}
                        <div className="absolute inset-0 opacity-30 bg-[url('https://www.transparenttextures.com/patterns/carbon-fibre.png')] mix-blend-multiply" />
                    </div>
                );
            case 2: // Terra (Earth-like) - HIGH DETAIL UPGRADE
                return (
                    <div className="relative w-full h-full rounded-full bg-[#1e3a8a] shadow-[inset_-25px_-25px_60px_rgba(0,0,0,0.9),inset_10px_10px_30px_rgba(147,197,253,0.3)] overflow-hidden">
                        {/* Deep Ocean Surface with Micro-Detail */}
                        <div className="absolute inset-0 bg-radial-gradient from-blue-500/10 to-blue-950/90" />

                        {/* Landmasses (Layered for Depth) */}
                        <div className="absolute top-[10%] left-[25%] w-[45%] h-[35%] bg-emerald-900/40 rounded-[45%_55%_65%_35%] filter blur-[8px]" />
                        <div className="absolute top-[12%] left-[27%] w-[40%] h-[30%] bg-emerald-800/80 rounded-[40%_60%_70%_30%] filter blur-[3px]" />
                        <div className="absolute bottom-[20%] right-[15%] w-[35%] h-[30%] bg-emerald-800/80 rounded-[30%_70%_60%_40%] filter blur-[4px]" />

                        {/* Mountain Ridges and Arid Zones */}
                        <div className="absolute top-[25%] left-[35%] w-[15%] h-[5%] bg-amber-900/30 rounded-full filter blur-[2px]" />
                        <div className="absolute bottom-[25%] right-[25%] w-[10%] h-[10%] bg-amber-900/40 rounded-full filter blur-[3px]" />

                        {/* Specular Highlights on Water */}
                        <div className="absolute top-[15%] left-[15%] w-[30%] h-[20%] bg-white/5 rounded-full filter blur-[10px]" />

                        {/* Dynamic Multi-Layer Clouds */}
                        <div className="absolute inset-0 opacity-40 mix-blend-screen animate-pulse-slow"
                            style={{ backgroundImage: 'radial-gradient(circle at 40% 40%, white 0%, transparent 15%), radial-gradient(circle at 70% 30%, white 0%, transparent 20%)', filter: 'blur(12px)' }} />
                        <div className="absolute top-0 left-0 w-full h-full opacity-30 mix-blend-screen bg-[url('https://www.transparenttextures.com/patterns/stardust.png')] filter blur-[1px]" />

                        {/* Polar Ice Caps */}
                        <div className="absolute top-[-5%] left-[25%] w-[50%] h-[15%] bg-white/80 blur-[8px] rounded-full" />
                        <div className="absolute bottom-[-5%] left-[30%] w-[40%] h-[12%] bg-white/60 blur-[10px] rounded-full" />
                    </div>
                );
            case 3: // Glacies (Ice) - HIGH DETAIL UPGRADE
                return (
                    <div className="relative w-full h-full rounded-full bg-cyan-100 shadow-[inset_-25px_-25px_50px_rgba(0,100,200,0.5),inset_10px_10px_30px_rgba(255,255,255,0.6)] overflow-hidden">
                        {/* Deep Frost Base */}
                        <div className="absolute inset-0 bg-gradient-to-br from-[#dbeafe] via-[#bfdbfe] to-[#3b82f6]" />

                        {/* Subsurface Scattering (Internal Glow) */}
                        <div className="absolute inset-0 bg-radial-gradient from-cyan-300/30 to-blue-600/60 mix-blend-overlay" />

                        {/* Ice Sheet Fractures (Sharp Lines) */}
                        {[
                            { t: '10%', l: '20%', w: '120px', h: '1px', r: '45deg', o: 0.6 },
                            { t: '60%', l: '50%', w: '150px', h: '2px', r: '-30deg', o: 0.5 },
                            { t: '30%', l: '60%', w: '80px', h: '1px', r: '15deg', o: 0.4 },
                            { t: '80%', l: '10%', w: '100px', h: '1px', r: '-10deg', o: 0.5 }
                        ].map((f, i) => (
                            <div key={i} className="absolute bg-white/60 blur-[0.5px] shadow-[0_0_5px_cyan]"
                                style={{ top: f.t, left: f.l, width: f.w, height: f.h, transform: `rotate(${f.r})`, opacity: f.o }} />
                        ))}

                        {/* Frozen Terrain Details (Texture) */}
                        <div className="absolute inset-0 opacity-40 mix-blend-overlay bg-[url('https://www.transparenttextures.com/patterns/diamond-upholstery.png')] scale-150" />
                        <div className="absolute inset-0 opacity-20 mix-blend-color-dodge bg-[url('https://www.transparenttextures.com/patterns/stardust.png')] filter hue-rotate-180" />

                        {/* Glacial Ridges (Shadows) */}
                        <div className="absolute top-[30%] left-[20%] w-[40%] h-[15%] bg-blue-900/10 blur-[4px] -rotate-12" />
                        <div className="absolute bottom-[20%] right-[30%] w-[35%] h-[20%] bg-blue-900/10 blur-[5px] rotate-6" />

                        {/* Specular Ice Glint */}
                        <div className="absolute top-[15%] left-[20%] w-[15%] h-[15%] bg-white rounded-full blur-[12px] opacity-90" />
                    </div>
                );
            case 4: // Fulata (Gas Giant) - HIGH DETAIL UPGRADE
                return (
                    <div className="relative w-full h-full rounded-full bg-[#d97706] shadow-[inset_-30px_-30px_60px_rgba(0,0,0,0.5)] overflow-hidden">
                        {/* Atmospheric Bands - Complex Gradients & Noise */}
                        <div className="absolute inset-0 flex flex-col opacity-90 scale-y-110 -rotate-12">
                            <div className="flex-[0.8] bg-gradient-to-r from-[#fdba74] to-[#fbbf24] filter blur-[3px]" />
                            <div className="flex-[0.6] bg-gradient-to-r from-[#d97706] via-[#b45309] to-[#d97706] filter blur-[4px]" />
                            <div className="flex-[1.2] bg-gradient-to-r from-[#fff7ed] via-[#ffedd5] to-[#fed7aa] filter blur-[5px]" />
                            <div className="flex-[0.9] bg-gradient-to-r from-[#9a3412] via-[#c2410c] to-[#9a3412] filter blur-[3px]" />
                            <div className="flex-[1.1] bg-gradient-to-r from-[#fb923c] to-[#fdba74] filter blur-[6px]" />
                            <div className="flex-[0.7] bg-gradient-to-r from-[#7c2d12] to-[#9a3412] filter blur-[4px]" />
                        </div>

                        {/* Gaseous Turbulence Swirls */}
                        <div className="absolute inset-0 opacity-10 mix-blend-overlay bg-[url('https://www.transparenttextures.com/patterns/wood-pattern.png')] filter contrast-125" />
                        <div className="absolute inset-0 opacity-20 mix-blend-soft-light bg-[url('https://www.transparenttextures.com/patterns/stardust.png')] animate-spin-slow duration-[120s]" />

                        {/* Great Red Spot - Storm Eye */}
                        <div className="absolute bottom-[25%] right-[20%] w-[25%] h-[18%] bg-gradient-to-br from-[#991b1b] to-[#7f1d1d] rounded-[50%] blur-[2px] shadow-[inset_0_0_15px_rgba(0,0,0,0.4)] opacity-90 border border-red-900/20 rotate-12 mix-blend-multiply" />

                        {/* Smaller Storm Eddies */}
                        <div className="absolute top-[35%] left-[25%] w-[8%] h-[6%] bg-white/30 rounded-full blur-[2px]" />
                        <div className="absolute bottom-[40%] right-[40%] w-[6%] h-[4%] bg-[#7f1d1d]/40 rounded-full blur-[1px]" />

                        {/* Limb Darkening */}
                        <div className="absolute inset-0 rounded-full bg-radial-gradient from-transparent via-transparent to-black/60 opacity-80" />
                    </div>
                );
            case 5: // Aureus (Golden Rings) - HIGH DETAIL UPGRADE
                return (
                    <div className="relative w-full h-full flex items-center justify-center">
                        {/* Main Body - Metallic Gold Sphere */}
                        <div className="relative w-full h-full rounded-full bg-gradient-to-br from-[#FFD700] via-[#B8860B] to-[#5c3a00] shadow-[inset_-15px_-15px_30px_rgba(0,0,0,0.8),inset_10px_10px_20px_rgba(255,255,255,0.4)] z-10 overflow-hidden">
                            {/* Brushed Metal Texture */}
                            <div className="absolute inset-0 opacity-40 mix-blend-multiply bg-[url('https://www.transparenttextures.com/patterns/brushed-alum.png')]" />

                            {/* Gold Flecks for Sparkle */}
                            <div className="absolute inset-0 opacity-30 mix-blend-color-dodge bg-[url('https://www.transparenttextures.com/patterns/stardust.png')]" />

                            {/* Specular Highlight Streak */}
                            <div className="absolute top-[20%] left-[20%] w-[60%] h-[30%] bg-gradient-to-br from-white/40 to-transparent blur-[15px] rotate-12" />

                            {/* Shadow cast by rings on surface */}
                            <div className="absolute top-[45%] left-[-10%] w-[120%] h-[15%] bg-black/60 blur-[4px] rotate-[-12deg]" />
                        </div>

                        {/* Ring System - BACK (Behind Planet) */}
                        <div className="absolute w-[200%] h-[20%] border-[40px] border-[#DAA520]/20 rounded-[50%] transform -rotate-12 scale-y-50 z-0 blur-[1px]"
                            style={{ clipPath: 'polygon(0 0, 100% 0, 100% 45%, 0 45%)' }} />

                        {/* Ring System - FRONT (Over Planet) */}
                        <div className="absolute w-[200%] h-[20%] border-[4px] border-[#FFF8DC]/60 rounded-[50%] transform -rotate-12 scale-y-50 z-20"
                            style={{ clipPath: 'polygon(0 55%, 100% 55%, 100% 100%, 0 100%)' }} />

                        {/* Complex Multi-Ring Structure */}
                        <div className="absolute w-[190%] h-[18%] border-[8px] border-[#B8860B]/40 rounded-[50%] transform -rotate-12 scale-y-50 z-20"
                            style={{ clipPath: 'polygon(0 55%, 100% 55%, 100% 100%, 0 100%)' }} />
                        <div className="absolute w-[210%] h-[22%] border-[15px] border-[#FFD700]/10 rounded-[50%] transform -rotate-12 scale-y-50 z-0"
                            style={{ clipPath: 'polygon(0 0, 100% 0, 100% 100%, 0 100%)', filter: 'blur(2px)' }} />
                    </div>
                );
            case 6: // Nebula - HIGH DETAIL UPGRADE
                return (
                    <div className="relative w-full h-full rounded-full bg-transparent overflow-hidden filter blur-[2px]">
                        {/* Deep Space Background within Halo */}
                        <div className="absolute inset-0 rounded-full bg-[#1e1b4b]" />

                        {/* Volumetric Gas Clouds - Layer 1 (Purple) */}
                        <div className="absolute inset-[-20%] bg-[radial-gradient(circle_at_30%_30%,_#7c3aed_0%,_transparent_60%)] opacity-60 mix-blend-screen filter blur-[10px] animate-pulse-slow" />

                        {/* Volumetric Gas Clouds - Layer 2 (Pink/Red) */}
                        <div className="absolute inset-[-10%] bg-[radial-gradient(circle_at_70%_60%,_#db2777_0%,_transparent_50%)] opacity-50 mix-blend-screen filter blur-[15px]" />

                        {/* Volumetric Gas Clouds - Layer 3 (Blue/Teal) */}
                        <div className="absolute inset-[10%] bg-[radial-gradient(circle_at_50%_80%,_#0ea5e9_0%,_transparent_40%)] opacity-40 mix-blend-color-dodge filter blur-[8px]" />

                        {/* Dark Dust Lanes (Silhouettes) */}
                        <div className="absolute top-[40%] left-[20%] w-[60%] h-[20%] bg-black/40 blur-[5px] rotate-[-15deg]" />
                        <div className="absolute bottom-[30%] right-[30%] w-[40%] h-[15%] bg-black/30 blur-[6px] rotate-[10deg]" />

                        {/* Starbirth Clusters (Bright Points) */}
                        {[
                            { t: '35%', l: '40%', s: '3px', b: '2px' }, { t: '38%', l: '42%', s: '2px', b: '1px' },
                            { t: '60%', l: '65%', s: '4px', b: '3px' }, { t: '20%', l: '70%', s: '2px', b: '1px' },
                            { t: '75%', l: '30%', s: '3px', b: '2px' }, { t: '50%', l: '50%', s: '5px', b: '4px' }
                        ].map((s, i) => (
                            <div key={i} className="absolute bg-white rounded-full animate-pulse"
                                style={{ top: s.t, left: s.l, width: s.s, height: s.s, boxShadow: `0 0 ${s.b} #fff` }} />
                        ))}

                        {/* Overall Glow */}
                        <div className="absolute inset-0 bg-radial-gradient from-transparent to-black/80" />
                    </div>
                );
            case 7: // Void (Black Hole) - HIGH DETAIL UPGRADE
                return (
                    <div className="relative w-full h-full flex items-center justify-center">
                        {/* Gravitational Lensing Distortion Field */}
                        <div className="absolute w-[250%] h-[250%] rounded-full border-[20px] border-white/5 opacity-20 blur-[20px]" />

                        {/* Accretion Disk - Relativistic Beaming (Asymmetric brightness) */}
                        <div
                            className="absolute w-[180%] h-[180%] rounded-full animate-spin-slow"
                            style={{
                                background: 'conic-gradient(from 0deg, transparent 0%, #a855f7 10%, #fff 15%, transparent 20%, #d946ef 45%, #ec4899 50%, transparent 60%)',
                                filter: 'blur(8px)',
                                transform: 'rotateX(60deg) scale(1.2)'
                            }}
                        />
                        {/* Inner Accretion Flow - High Speed */}
                        <div
                            className="absolute w-[140%] h-[140%] rounded-full animate-spin"
                            style={{
                                background: 'conic-gradient(from 180deg, transparent 0%, #f472b6 20%, white 25%, transparent 35%)',
                                filter: 'blur(15px)',
                                animationDuration: '4s'
                            }}
                        />

                        {/* Photon Ring (The sharp light circle) */}
                        <div className="absolute w-[105%] h-[105%] rounded-full border-[3px] border-white shadow-[0_0_20px_white,inset_0_0_20px_white] z-20" />

                        {/* Event Horizon - Pure Void */}
                        <div className="relative w-full h-full rounded-full bg-black shadow-[0_0_50px_#000] z-30" />

                        {/* Hawking Radiation Jets */}
                        <div className="absolute w-[2px] h-[300%] bg-gradient-to-b from-transparent via-cyan-400 to-transparent opacity-80 blur-[2px] rotate-12 z-0" />
                    </div>
                );
            case 8: // Nova (Active Star) - HIGH DETAIL UPGRADE
                return (
                    <div className="relative w-full h-full rounded-full bg-[#fcd34d] shadow-[0_0_100px_rgba(245,158,11,0.8),inset_-30px_-30px_60px_rgba(0,0,0,0.6)] z-10 overflow-hidden">
                        {/* Solar Surface Granulation (High Contrast) */}
                        <div className="absolute inset-0 bg-gradient-to-br from-yellow-400 via-orange-500 to-red-600" />
                        <div className="absolute inset-0 opacity-60 mix-blend-overlay bg-[url('https://www.transparenttextures.com/patterns/stardust.png')] filter contrast-200 contrast-150 scale-125" />

                        {/* Conic Swirl Flow (Realistic Star Rotation) */}
                        <div className="absolute inset-0 opacity-50 animate-spin-slow"
                            style={{
                                background: 'conic-gradient(from 0deg, #f59e0b, #fbbf24, #ef4444, #f59e0b)',
                                filter: 'blur(15px)'
                            }}
                        />

                        {/* High Detail Sunspots (Clustered) */}
                        {[
                            { t: '30%', l: '35%', s: '6%', op: 0.9 }, { t: '32%', l: '38%', s: '3%', op: 0.8 },
                            { t: '55%', l: '65%', s: '10%', op: 0.7 }, { t: '58%', l: '62%', s: '5%', op: 0.6 },
                            { t: '20%', l: '60%', s: '4%', op: 0.5 }
                        ].map((s, i) => (
                            <div key={i} className="absolute rounded-full bg-black/70 blur-[1px] mix-blend-multiply"
                                style={{ top: s.t, left: s.l, width: s.s, height: s.s, opacity: s.op }} />
                        ))}

                        {/* Solar Flare Prominences (Edge Activity) */}
                        <div className="absolute -top-[10%] left-[25%] w-[30%] h-[20%] bg-orange-600/40 blur-[15px] animate-pulse" />
                        <div className="absolute bottom-[10%] -right-[10%] w-[20%] h-[30%] bg-red-600/30 blur-[20px] animate-pulse delay-500" />

                        {/* Intense Central Core */}
                        <div className="absolute inset-0 bg-radial-gradient from-white/30 to-transparent blur-[30px]" />
                    </div>
                );
            case 9: // Singularity - HIGH DETAIL UPGRADE
                return (
                    <div className="relative w-full h-full flex items-center justify-center">
                        {/* Reality Collapse - Screen Glitch Background */}
                        <div className="absolute w-[250%] h-[250%] border border-white/10 rounded-full animate-ping opacity-10" />
                        <div className="absolute w-[200%] h-[200%] border border-white/20 rounded-full animate-ping delay-75 opacity-20 rotate-45" />

                        {/* Core Singularity - The White Hole / Hyper-Dense Point */}
                        <div className="relative w-[60%] h-[60%] flex items-center justify-center">
                            {/* Unstable Geometry - Rotating Tesseracts */}
                            <div className="absolute inset-0 border-[2px] border-white/80 animate-spin-slow duration-[10s]" style={{ transform: 'rotateX(45deg) rotateY(45deg)' }} />
                            <div className="absolute inset-0 border-[2px] border-white/60 animate-spin-slow duration-[15s] reverse" style={{ transform: 'rotateX(-45deg) rotateY(-45deg)' }} />
                            <div className="absolute inset-[10%] bg-white shadow-[0_0_100px_white] animate-pulse rounded-full z-20" />

                            {/* Chromatic Aberration Echoes */}
                            <div className="absolute inset-0 border border-cyan-400 opacity-60 animate-ping delay-100 mix-blend-screen" />
                            <div className="absolute inset-0 border border-red-500 opacity-60 animate-ping delay-200 mix-blend-screen" />

                            {/* Data Streams / Matrix Lines */}
                            <div className="absolute w-[1px] h-[400%] bg-gradient-to-b from-transparent via-white to-transparent opacity-50 rotate-45" />
                            <div className="absolute w-[1px] h-[400%] bg-gradient-to-b from-transparent via-white to-transparent opacity-50 -rotate-45" />
                        </div>
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
