import React, { useMemo } from 'react';
import { useNavigate } from 'react-router-dom';
import { useApp } from '../AppContext';

// Simple procedural planet generator based on level
const getPlanetStyle = (level: number) => {
    // 10 Unique CSS Gradients for Planets
    const gradients = [
        'linear-gradient(135deg, #e0e0e0 0%, #a0a0a0 100%)', // 1. Moon/Celestia (Gray/White)
        'linear-gradient(135deg, #ff9a9e 0%, #fecfef 99%, #fecfef 100%)', // 2. Ignis (Red/Pink)
        'linear-gradient(135deg, #4facfe 0%, #00f2fe 100%)', // 3. Terra (Blue/Cyan)
        'linear-gradient(135deg, #43e97b 0%, #38f9d7 100%)', // 4. Glacies (Green/Aqua)
        'linear-gradient(135deg, #fa709a 0%, #fee140 100%)', // 5. Fulata (Yellow/orange)
        'linear-gradient(135deg, #667eea 0%, #764ba2 100%)', // 6. Aureus (Purple/Blue)
        'linear-gradient(135deg, #89f7fe 0%, #66a6ff 100%)', // 7. Nebula
        'linear-gradient(135deg, #c471f5 0%, #fa71cd 100%)', // 8. Void
        'linear-gradient(135deg, #f093fb 0%, #f5576c 100%)', // 9. Nova
        'linear-gradient(135deg, #30cfd0 0%, #330867 100%)', // 10. Singularity
    ];
    return {
        background: gradients[(level - 1) % gradients.length],
        boxShadow: `0 0 ${10 + level * 2}px rgba(0,0,0,0.2)`
    };
};

const getPlanetName = (level: number) => {
    const names = [
        'Celestia', 'Ignis', 'Terra', 'Glacies', 'Fulata',
        'Aureus', 'Nebula', 'Void', 'Nova', 'Singularity'
    ];
    return names[(level - 1) % names.length] || 'Unknown';
};

export const PrestigeWidget = ({ compact = false }: { compact?: boolean }) => {
    const { userPrestige } = useApp();
    const navigate = useNavigate();

    // Default if null (e.g. loading or new user)
    const level = userPrestige?.planet_level || 1;
    const stars = userPrestige?.star_level || 0;
    const style = useMemo(() => getPlanetStyle(level), [level]);
    const name = useMemo(() => getPlanetName(level), [level]);

    // Calculate progress for 3 segments
    // If 1 star, segment 1 full. If 2 stars, segments 1 & 2 full.
    // Progress within current star? We only track integer stars (0-3).
    // So if stars=1, 1 segment full.
    // If stars=0, 0 segments full.

    // Height match: PointsBadge is padding 3px top/bottom + approx 24px icon = ~32px. 
    // Let's force h-[34px] or similar.

    if (compact) {
        return (
            <div
                onClick={() => navigate('/prestige')}
                className="cursor-pointer group relative flex flex-row items-center gap-3 pl-1.5 pr-4 py-1 rounded-[999px] transition-all min-w-[130px] h-[36px] justify-between"
                style={{
                    background: 'rgba(255, 255, 255, 0.75)',
                    backdropFilter: 'blur(12px)',
                    WebkitBackdropFilter: 'blur(12px)',
                    border: '1px solid rgba(249, 212, 6, 0.45)', // Golden border
                    boxShadow: '0 4px 15px -1px rgba(0, 0, 0, 0.05), 0 2px 6px -1px rgba(0, 0, 0, 0.04), inset 0 1px 0 rgba(255, 255, 255, 0.5)'
                }}
            >
                {/* Hover Effect Layer (Pseudo-element simulation via inner div or just direct styles if possible, but keeping inline for exact match) */}
                <div className="absolute inset-0 rounded-[999px] transition-all opacity-0 group-hover:opacity-100 pointer-events-none"
                    style={{
                        background: 'rgba(255, 255, 255, 0.95)',
                        borderColor: 'rgba(249, 212, 6, 0.7)',
                        boxShadow: '0 12px 25px -5px rgba(249, 212, 6, 0.25), 0 4px 10px -2px rgba(0, 0, 0, 0.08)'
                    }}
                />

                {/* Planet Visual (Z-index to sit above hover layer) */}
                <div
                    className="w-7 h-7 rounded-full relative shrink-0 shadow-sm ml-0.5 z-10"
                    style={style}
                >
                    <div className="absolute inset-0 rounded-full bg-gradient-to-tr from-black/0 via-white/20 to-white/40 opacity-50"></div>
                </div>

                <div className="flex flex-col flex-grow gap-0.5 justify-center mr-1 z-10">
                    <div className="flex justify-between items-end leading-none">
                        <span className="text-[10px] font-black text-gray-900 uppercase tracking-wider relative top-[1px]">
                            {name}
                        </span>
                    </div>

                    {/* Progress Bar Container - 3 Segments with Stars on Top */}
                    <div className="flex gap-1 w-full mt-1 relative">
                        {[1, 2, 3].map(s => (
                            <div key={s} className="h-1.5 flex-1 bg-gray-200/50 rounded-full overflow-visible relative">
                                <div
                                    className={`h-full w-full rounded-full transition-all duration-500 ${s <= stars ? 'bg-gradient-to-r from-amber-300 to-amber-500' : 'opacity-0'}`}
                                ></div>
                                {/* Star Icon - Centered on segment */}
                                <div className="absolute -top-[5px] left-1/2 -translate-x-1/2 flex items-center justify-center pointer-events-none">
                                    <span
                                        className={`material-symbols-outlined text-[8px] drop-shadow-sm ${s <= stars ? 'text-amber-500 fill-current' : 'text-gray-300'}`}
                                        style={{ fontVariationSettings: "'FILL' 1" }}
                                    >
                                        star
                                    </span>
                                </div>
                            </div>
                        ))}
                    </div>
                </div>
            </div>
        );
    }

    // Default Dashboard Mode (Revert to original if needed or keep new design? User said "put this button into top bar" so maybe Dashboard one is gone? 
    // Actually in previous step I removed it from Dashboard body.
    // So this component is mainly used in Navbar now.
    // I will keep the non-compact version just in case, or make it same.

    return (
        <div
            onClick={() => navigate('/prestige')}
            className="cursor-pointer group relative flex flex-row items-center gap-4 p-4 rounded-2xl bg-white/50 dark:bg-black/20 hover:bg-white/80 dark:hover:bg-white/10 transition-all border border-black/5 dark:border-white/5 backdrop-blur-sm w-full sm:w-auto min-w-[280px]"
        >
            {/* ... (Legacy/Full version kept for reference or reuse) ... */}
            <div
                className="w-10 h-10 rounded-full relative shrink-0 group-hover:scale-110 transition-transform duration-500 shadow-sm"
                style={style}
            >
                <div className="absolute inset-0 rounded-full bg-gradient-to-tr from-black/0 via-white/20 to-white/40 opacity-50"></div>
            </div>

            <div className="flex flex-col flex-grow gap-1">
                <div className="flex justify-between items-center">
                    <span className="text-xs font-bold text-text-main dark:text-white uppercase tracking-widest">
                        {name}
                    </span>
                    <div className="flex gap-0.5">
                        {[1, 2, 3].map((s) => (
                            <span
                                key={s}
                                className={`material-symbols-outlined text-[10px] ${s <= stars ? 'text-amber-400 fill-current' : 'text-gray-300 dark:text-gray-600'}`}
                                style={{ fontVariationSettings: "'FILL' 1" }}
                            >
                                star
                            </span>
                        ))}
                    </div>
                </div>

                <div className="h-2 w-full bg-gray-200 dark:bg-white/10 rounded-full overflow-hidden">
                    <div
                        className="h-full bg-gradient-to-r from-blue-400 to-purple-500 transition-all duration-700 ease-out"
                        style={{ width: `${(stars / 3) * 100}%` }}
                    ></div>
                </div>
            </div>
            <span className="material-symbols-outlined text-gray-300 group-hover:translate-x-1 group-hover:text-primary transition-all text-sm">
                chevron_right
            </span>
        </div>
    );
};
