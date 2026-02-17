import React, { useMemo } from 'react';
import { useNavigate } from 'react-router-dom';
import { useApp } from '../AppContext';
import { PlanetVisual, getPlanetName } from './SpaceVisuals';

export const PrestigeWidget = ({ compact = false }: { compact?: boolean }) => {
    const { userPrestige } = useApp();
    const navigate = useNavigate();

    // Default if null (e.g. loading or new user)
    const level = userPrestige?.planet_level || 1;
    const stars = userPrestige?.star_level || 0;
    const name = useMemo(() => getPlanetName(level), [level]);

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
                {/* Hover Effect Layer */}
                <div className="absolute inset-0 rounded-[999px] transition-all opacity-0 group-hover:opacity-100 pointer-events-none"
                    style={{
                        background: 'rgba(255, 255, 255, 0.95)',
                        borderColor: 'rgba(249, 212, 6, 0.7)',
                        boxShadow: '0 12px 25px -5px rgba(249, 212, 6, 0.25), 0 4px 10px -2px rgba(0, 0, 0, 0.08)'
                    }}
                />

                <div className="ml-1 z-10 scale-90">
                    <PlanetVisual level={level} size="sm" showAtmosphere={false} />
                </div>

                {/* Content Container (Z-index to sit above hover layer) */}
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

    return null;
};
