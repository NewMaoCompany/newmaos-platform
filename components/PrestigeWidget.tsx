import React, { useMemo } from 'react';
import { useNavigate } from 'react-router-dom';
import { useApp } from '../AppContext';
import { PlanetVisual, getPlanetName } from './SpaceVisuals';
import { PointsCoin } from './PointsCoin';

export const PrestigeWidget = ({ compact = false }: { compact?: boolean }) => {
    const { userPrestige } = useApp();
    const navigate = useNavigate();

    // Default if null (e.g. loading or new user)
    const level = userPrestige?.planet_level || 1;
    const stars = userPrestige?.star_level || 0;
    const stardust = userPrestige?.current_stardust || 0;
    const name = useMemo(() => getPlanetName(level), [level]);

    if (compact) {
        return (
            <div
                onClick={() => navigate('/prestige')}
                className="cursor-pointer group relative flex flex-row items-center gap-2 pl-1.5 pr-3 py-1 rounded-[999px] min-w-[210px] h-[36px]"
                style={{
                    background: 'rgba(255, 255, 255, 0.75)',
                    backdropFilter: 'blur(12px)',
                    WebkitBackdropFilter: 'blur(12px)',
                    border: '1px solid rgba(249, 212, 6, 0.45)', // Golden border
                    boxShadow: '0 4px 15px -1px rgba(0, 0, 0, 0.05), 0 2px 6px -1px rgba(0, 0, 0, 0.04), inset 0 1px 0 rgba(255, 255, 255, 0.5)'
                }}
            >
                {/* Hover Effect Layer */}
                <div className="absolute inset-0 rounded-[999px] transition-all opacity-0 group-hover:opacity-100 pointer-events-none"
                    style={{
                        background: 'rgba(255, 255, 255, 0.95)',
                        borderColor: 'rgba(249, 212, 6, 0.7)',
                        boxShadow: '0 12px 25px -5px rgba(249, 212, 6, 0.25), 0 4px 10px -2px rgba(0, 0, 0, 0.08)'
                    }}
                />

                <div className="ml-0.5 z-10 flex items-center justify-center w-8 h-8 rounded-full overflow-visible relative group-hover:drop-shadow-[0_0_8px_rgba(249,212,6,0.6)] transition-all">
                    <PlanetVisual level={level} size="sm" showAtmosphere={true} floating={false} />
                </div>

                {/* Content Container (Z-index to sit above hover layer) */}
                <div className="flex flex-col flex-grow gap-0.5 justify-center z-10 min-w-0">
                    <div className="flex justify-between items-end leading-none">
                        <span className="text-[9px] font-black text-gray-900 uppercase tracking-wider relative top-[1px] truncate">
                            {name}
                        </span>
                    </div>

                    {/* 4-Vertex Progress System */}
                    <div className="relative w-[70px] h-0.5 bg-gray-200/50 rounded-full flex items-center justify-between mt-1">
                        {/* Fill Line */}
                        <div
                            className="absolute left-0 top-0 h-full bg-gradient-to-r from-amber-300 to-amber-500 rounded-full transition-all duration-500"
                            style={{ width: `${stars > 0 ? ((Math.min(4, stars) - 1) / 3) * 100 : 0}%` }}
                        />

                        {/* 4 Dots */}
                        {[1, 2, 3, 4].map(i => (
                            <div
                                key={i}
                                className={`w-1.5 h-1.5 rounded-full transition-all duration-300 z-10 ${i <= stars ? 'bg-amber-500 scale-110' : 'bg-gray-300 scale-90'
                                    }`}
                            />
                        ))}
                    </div>
                </div>

                {/* Divider */}
                <div className="h-4 w-px bg-gray-200 dark:bg-gray-700 z-10 mx-1" />

                {/* Stardust Section */}
                <div className="flex items-center gap-1.5 z-10 pr-1">
                    <PointsCoin type="stardust" size="sm" className="group-hover:scale-110 transition-transform" />
                    <span className="text-[11px] font-bold text-gray-700 dark:text-gray-200 tabular-nums">
                        {stardust.toLocaleString()}
                    </span>
                </div>
            </div>
        );
    }

    return null;
};
