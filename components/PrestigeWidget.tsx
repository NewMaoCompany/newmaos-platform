import React, { useMemo } from 'react';
import { useNavigate } from 'react-router-dom';
import { useApp } from '../AppContext';
import { PlanetVisual, getPlanetName } from './SpaceVisuals';
import { PointsCoin } from './PointsCoin';

export const PrestigeWidget = ({ compact = false, prestigeData = null, isReadOnly = false }: { compact?: boolean, prestigeData?: any, isReadOnly?: boolean }) => {
    const { userPrestige: currentUserPrestige } = useApp();
    const navigate = useNavigate();

    // Use passed data or fall back to current user
    const p = prestigeData || currentUserPrestige;
    const level = p?.planet_level || 1;
    const stars = p?.star_level || 0;
    const stardust = p?.current_stardust || 0;
    const name = useMemo(() => getPlanetName(level), [level]);

    if (compact) {
        return (
            <div
                onClick={() => !isReadOnly && navigate('/prestige')}
                className={`group relative flex flex-row items-center gap-2 pl-3 pr-4 py-2 rounded-[999px] min-w-[240px] h-[48px] ${!isReadOnly ? 'cursor-pointer' : 'cursor-default'}`}
                style={{
                    background: 'rgba(255, 255, 255, 0.85)',
                    backdropFilter: 'blur(16px)',
                    WebkitBackdropFilter: 'blur(16px)',
                    border: '1px solid rgba(249, 212, 6, 0.4)',
                    boxShadow: '0 4px 20px -5px rgba(0, 0, 0, 0.1), inset 0 1px 0 rgba(255, 255, 255, 0.5)'
                }}
            >
                {/* Hover Effect Layer - Only if not ReadOnly */}
                {!isReadOnly && (
                    <div className="absolute inset-0 rounded-[999px] transition-all opacity-0 group-hover:opacity-100 pointer-events-none"
                        style={{
                            background: 'rgba(255, 255, 255, 0.98)',
                            borderColor: 'rgba(249, 212, 6, 0.8)',
                            boxShadow: '0 12px 30px -5px rgba(249, 212, 6, 0.3)'
                        }}
                    />
                )}

                <div className="shrink-0 z-10 flex items-center justify-center w-10 h-10 rounded-full overflow-visible relative group-hover:scale-110 transition-transform duration-300">
                    <PlanetVisual level={level} size="sm" showAtmosphere={true} floating={false} />
                </div>

                {/* Content Container */}
                <div className="flex flex-col flex-grow gap-1 justify-center z-10 min-w-0">
                    <div className="flex justify-between items-center leading-none">
                        <span className="text-[11px] font-black text-gray-900 uppercase tracking-tight truncate max-w-[100px]">
                            {name}
                        </span>
                    </div>

                    {/* Improved 4-Vertex Progress System */}
                    <div className="relative w-[75px] h-1.5 bg-gray-200/50 rounded-full flex items-center justify-between px-[1.5px]">
                        {/* Fill Line */}
                        <div
                            className="absolute left-0 top-0 h-full bg-gradient-to-r from-amber-400 via-amber-200 to-amber-500 rounded-full transition-all duration-700 ease-out shadow-[0_0_8px_rgba(251,191,36,0.5)]"
                            style={{ width: `${Math.min(100, Math.max(0, (stars / 4) * 100))}%` }}
                        />

                        {/* 4 Dots */}
                        {[1, 2, 3, 4].map(i => (
                            <div
                                key={i}
                                className={`w-2 h-2 rounded-full transition-all duration-500 z-10 ${i <= stars ? 'bg-amber-500 scale-110 shadow-[0_0_6px_rgba(245,158,11,0.6)]' : 'bg-gray-300 scale-90'
                                    }`}
                            />
                        ))}
                    </div>
                </div>

                {/* Divider */}
                <div className="h-6 w-px bg-gray-300/50 z-10 mx-1" />

                {/* Stardust Section */}
                <div className="flex items-center gap-2 z-10 pr-1 shrink-0">
                    <PointsCoin type="stardust" size="sm" className="group-hover:rotate-[15deg] transition-transform" />
                    <span className="text-[13px] font-black text-slate-800 tabular-nums tracking-tight">
                        {stardust.toLocaleString()}
                    </span>
                </div>
            </div>
        );
    }

    return null;
};
