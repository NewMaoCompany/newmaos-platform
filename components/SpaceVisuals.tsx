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
            case 1: // Ignis (Volcanic) - HIGH DETAIL
                return (
                    <div className="relative w-full h-full rounded-full bg-black shadow-inner overflow-hidden">
                        {/* Solid Core */}
                        <div className="absolute inset-0 bg-gradient-to-br from-red-950 via-orange-950 to-black" />

                        {/* Magma Base & Cracks */}
                        <div className="absolute inset-0 bg-[radial-gradient(circle_at_30%_30%,_#7f1d1d_0%,_transparent_60%)] opacity-100" />

                        {/* Glowing Lava Veins - CSS Complex Gradients */}
                        <div className="absolute inset-0 opacity-90 mix-blend-screen"
                            style={{
                                background: `
                                    radial-gradient(circle at 20% 80%, #ff4500 0%, transparent 20%),
                                    radial-gradient(circle at 80% 20%, #ff8c00 0%, transparent 25%),
                                    conic-gradient(from 45deg, transparent 0%, #ff4500 10%, transparent 20%)
                                `
                            }}
                        />

                        {/* Identifying Features: Dark Basalt Plates */}
                        <div className="absolute top-[20%] left-[10%] w-[30%] h-[20%] bg-black/60 rounded-full filter blur-[4px]" />
                        <div className="absolute bottom-[30%] right-[20%] w-[25%] h-[25%] bg-black/60 rounded-full filter blur-[5px]" />

                        {/* Ash Clouds / Smoke */}
                        <div className="absolute inset-0 bg-[url('https://www.transparenttextures.com/patterns/carbon-fibre.png')] opacity-30 mix-blend-multiply" />
                    </div>
                );
            case 2: // Terra (Earth-like) - HIGH DETAIL
                return (
                    <div className="relative w-full h-full rounded-full bg-[#1e40af] shadow-[inset_-10px_-10px_30px_rgba(0,0,0,0.8)] overflow-hidden">
                        {/* Deep Ocean Gradient */}
                        <div className="absolute inset-0 bg-radial-gradient from-blue-400/20 to-blue-950/80" />

                        {/* Continents - Green/Brown Landmasses */}
                        <div className="absolute top-[15%] left-[20%] w-[25%] h-[20%] bg-emerald-700/80 rounded-[40%_60%_30%_70%] filter blur-[3px]" />
                        <div className="absolute top-[40%] right-[15%] w-[35%] h-[30%] bg-emerald-800/80 rounded-[30%_70%_60%_40%] filter blur-[4px]" />
                        <div className="absolute bottom-[10%] left-[30%] w-[20%] h-[15%] bg-amber-900/40 rounded-full filter blur-[2px]" />

                        {/* Dynamic Clouds  */}
                        <div className="absolute inset-0 opacity-60 mix-blend-screen"
                            style={{
                                backgroundImage: 'radial-gradient(circle at 50% 50%, white 0%, transparent 5%), radial-gradient(circle at 20% 30%, white 0%, transparent 8%)',
                                filter: 'blur(5px)',
                                transform: 'scale(1.2) rotate(-10deg)'
                            }}
                        />
                        <div className="absolute top-[30%] w-full h-[15%] bg-white/20 blur-[8px] transform -rotate-12 translate-x-4" />
                    </div>
                );
            case 3: // Glacies (Ice) - HIGH DETAIL
                return (
                    <div className="relative w-full h-full rounded-full bg-cyan-50 shadow-[inset_-20px_-20px_40px_rgba(0,100,255,0.3)] overflow-hidden">
                        {/* Subsurface Scattering Glow */}
                        <div className="absolute inset-0 bg-gradient-to-br from-cyan-200/50 via-blue-100/20 to-blue-300/40" />

                        {/* Ice Textures / Facets */}
                        <div className="absolute inset-0 opacity-40 mix-blend-overlay bg-[url('https://www.transparenttextures.com/patterns/diamond-upholstery.png')]" />

                        {/* Cracks and Rifts */}
                        <div className="absolute top-0 left-0 w-[150%] h-[1px] bg-white/80 rotate-45 transform origin-top-left shadow-[0_0_5px_cyan]" />
                        <div className="absolute bottom-0 right-0 w-[150%] h-[1px] bg-white/60 -rotate-45 transform origin-bottom-right" />

                        {/* Specular Highlights */}
                        <div className="absolute top-[20%] right-[20%] w-[10%] h-[10%] bg-white rounded-full filter blur-[10px] opacity-80" />
                    </div>
                );
            case 4: // Fulata (Gas Giant) - HIGH DETAIL
                return (
                    <div className="relative w-full h-full rounded-full bg-[#d97706] shadow-inner overflow-hidden">
                        {/* Atmospheric Bands - Jupiter Style */}
                        <div className="absolute inset-0 flex flex-col opacity-90">
                            <div className="flex-1 bg-gradient-to-r from-orange-300 to-amber-200 filter blur-[2px]" />
                            <div className="flex-1 bg-gradient-to-r from-orange-400 to-red-300 filter blur-[3px]" />
                            <div className="flex-1 bg-gradient-to-r from-amber-600 to-orange-500 filter blur-[2px]" />
                            <div className="flex-[1.5] bg-gradient-to-r from-orange-200 to-amber-100 filter blur-[4px]" />
                            <div className="flex-1 bg-gradient-to-r from-red-400 to-orange-400 filter blur-[3px]" />
                        </div>

                        {/* The Great Storm Spot */}
                        <div className="absolute bottom-[35%] right-[20%] w-[18%] h-[12%] bg-red-700/60 rounded-full shadow-[inset_0_0_10px_rgba(0,0,0,0.3)] filter blur-[1px] mix-blend-multiply border border-red-800/20" />

                        {/* Turbulent Swirls overlay */}
                        <div className="absolute inset-0 opacity-20 mix-blend-overlay bg-[url('https://www.transparenttextures.com/patterns/wood-pattern.png')]" />
                    </div>
                );
            case 5: // Aureus (Golden Rings) - HIGH DETAIL
                return (
                    <div className="relative w-full h-full flex items-center justify-center">
                        {/* Main Body - Metallic Gold */}
                        <div className="relative w-full h-full rounded-full bg-gradient-to-br from-[#FFD700] via-[#B8860B] to-[#8B4500] shadow-[inset_-10px_-10px_20px_rgba(0,0,0,0.5),0_0_20px_rgba(255,215,0,0.3)] z-10 overflow-hidden">
                            {/* Metallic Sheen */}
                            <div className="absolute top-0 left-0 w-full h-full bg-gradient-to-tr from-transparent via-white/40 to-transparent opacity-50" />
                        </div>

                        {/* Ring System */}
                        <div className="absolute w-[180%] h-[60%] border-[25px] border-[#DAA520]/20 rounded-[50%] transform -rotate-12 scale-x-110 blur-[1px] z-0" />
                        <div className="absolute w-[170%] h-[55%] border-[2px] border-[#FFF8DC]/40 rounded-[50%] transform -rotate-12 scale-x-110 z-20" />
                        {/* Shadow of planet on ring */}
                        <div className="absolute w-[180%] h-[60%] border-[25px] border-black/80 rounded-[50%] transform -rotate-12 scale-x-110 blur-[5px] z-0 clip-path-polygon"
                            style={{ clipPath: 'polygon(40% 0, 60% 0, 60% 100%, 40% 100%)', opacity: 0.5 }} />
                    </div>
                );
            case 6: // Nebula - HIGH DETAIL
                return (
                    <div className="relative w-full h-full rounded-full bg-[#2e1065] shadow-inner overflow-hidden">
                        {/* Internal Volumetric Clouds */}
                        <div className="absolute inset-0 bg-[radial-gradient(circle_at_30%_30%,_#8b5cf6_0%,_transparent_60%)] opacity-80 filter blur-[10px]" />
                        <div className="absolute inset-0 bg-[radial-gradient(circle_at_70%_70%,_#ec4899_0%,_transparent_60%)] opacity-70 filter blur-[15px]" />

                        {/* Starbirth Clusters */}
                        <div className="absolute top-[40%] left-[40%] w-[4px] h-[4px] bg-white rounded-full shadow-[0_0_10px_white]" />
                        <div className="absolute top-[60%] right-[30%] w-[3px] h-[3px] bg-white rounded-full shadow-[0_0_8px_white]" />

                        {/* Gaseous Texture */}
                        <div className="absolute inset-0 opacity-40 mix-blend-color-dodge bg-[url('https://www.transparenttextures.com/patterns/stardust.png')]" />
                    </div>
                );
            case 7: // Void (Black Hole) - HIGH DETAIL
                return (
                    <div className="relative w-full h-full flex items-center justify-center">
                        {/* Accretion Disk - Swirling gradient */}
                        <div
                            className="absolute w-[160%] h-[160%] rounded-full opacity-80 animate-spin-slow"
                            style={{
                                background: 'conic-gradient(from 0deg, transparent 0%, #d97706 10%, #fbbf24 20%, transparent 30%, #d97706 50%, #fbbf24 60%, transparent 70%)',
                                filter: 'blur(8px)'
                            }}
                        />
                        {/* Photon Ring */}
                        <div className="absolute w-[105%] h-[105%] rounded-full border-[2px] border-white/50 shadow-[0_0_15px_white] z-10" />

                        {/* Event Horizon - Pure Void */}
                        <div className="relative w-full h-full rounded-full bg-black shadow-[0_0_30px_#000] z-20" />
                    </div>
                );
            case 8: // Nova (Active Star) - HIGH DETAIL
                return (
                    <div className="relative w-full h-full rounded-full bg-[#f59e0b] shadow-[0_0_60px_rgba(245,158,11,0.8)] z-10 overflow-hidden">
                        {/* Sun Surface - Granulation Texture */}
                        <div className="absolute inset-0 opacity-80 mix-blend-overlay bg-[url('https://www.transparenttextures.com/patterns/stardust.png')] filter contrast-125" />

                        {/* Dynamic Surface Flow - CSS Conic Gradient */}
                        <div className="absolute inset-0 opacity-60 animate-spin-slower"
                            style={{
                                background: 'conic-gradient(from 0deg, #f59e0b, #d97706, #b45309, #d97706, #f59e0b)',
                                filter: 'blur(10px)'
                            }}
                        />

                        {/* Sunspots - Realistic Dark Patches */}
                        <div className="absolute top-[35%] left-[25%] w-[8%] h-[6%] bg-black/70 rounded-full filter blur-[1px] rotate-12" />
                        <div className="absolute top-[38%] left-[28%] w-[4%] h-[3%] bg-black/80 rounded-full filter blur-[0.5px]" />
                        <div className="absolute bottom-[25%] right-[30%] w-[12%] h-[8%] bg-black/60 rounded-full filter blur-[2px] -rotate-6" />

                        {/* Solar Flares / Prominences (Edge Effects) */}
                        <div className="absolute -top-[5%] left-[20%] w-[20%] h-[10%] bg-orange-500/50 rounded-full filter blur-[8px] animate-pulse" />
                        <div className="absolute top-[40%] -right-[5%] w-[10%] h-[20%] bg-red-500/50 rounded-full filter blur-[8px] animate-pulse delay-75" />

                        {/* Corona Glow */}
                        <div className="absolute inset-0 rounded-full shadow-[inset_0_0_20px_rgba(255,255,0,0.5)]" />

                        {/* Intense Center */}
                        <div className="absolute inset-[15%] rounded-full bg-radial-gradient from-yellow-100/50 to-transparent blur-[15px]" />
                    </div>
                );
            case 9: // Singularity - HIGH DETAIL
                return (
                    <div className="relative w-full h-full flex items-center justify-center">
                        {/* Reality Distortion Grid */}
                        <div className="absolute w-[200%] h-[200%] border border-white/10 rounded-full animate-ping opacity-10" />
                        <div className="absolute w-[150%] h-[150%] border border-white/20 rounded-full animate-ping delay-75 opacity-20" />

                        {/* The Core - Glitchy Cube/Sphere */}
                        <div className="relative w-[60%] h-[60%] bg-black border border-white shadow-[0_0_50px_white] flex items-center justify-center rotate-45">
                            <div className="absolute inset-0 bg-white/20 animate-pulse" />
                            <div className="w-[80%] h-[80%] bg-white/80 border border-black" />
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
