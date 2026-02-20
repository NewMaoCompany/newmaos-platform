import React, { useMemo } from 'react';
import { useNavigate } from 'react-router-dom';
import { useApp } from '../AppContext';
import { PlanetVisual, getPlanetName } from './SpaceVisuals';
import { PointsCoin } from './PointsCoin';

export const PrestigeWidget = ({
    compact = false,
    wide = false,
    prestigeData = null,
    isReadOnly = false,
    showStardust = true,
    className = ""
}: {
    compact?: boolean,
    wide?: boolean,
    prestigeData?: any,
    isReadOnly?: boolean,
    showStardust?: boolean,
    className?: string
}) => {
    const { userPrestige: currentUserPrestige } = useApp();
    const navigate = useNavigate();

    // Use passed data or fall back to current user
    const p = prestigeData || currentUserPrestige;
    const rawLevel = p?.planet_level || 1;
    const level = Math.min(5, rawLevel);
    const stars = rawLevel >= 5 ? Math.min(3, p?.star_level || 0) : (p?.star_level || 0);
    const stardust = p?.current_stardust || 0;
    const name = useMemo(() => getPlanetName(level), [level]);

    const isInteractionAllowed = !isReadOnly;

    if (compact || wide) {
        const defaultScale = "scale-[0.6] sm:scale-[0.75] md:scale-100";
        const combinedClasses = className || defaultScale;

        return (
            <div
                className={`group relative flex flex-row items-center transition-all duration-300 origin-center ${combinedClasses} ${wide ? 'w-full' : 'max-w-fit'}`}
                style={{
                    background: 'rgba(255, 255, 255, 0.95)',
                    backdropFilter: 'blur(30px)',
                    WebkitBackdropFilter: 'blur(30px)',
                    borderRadius: '999px',
                    border: '1.5px solid rgba(255, 255, 255, 0.8)',
                    boxShadow: '0 12px 40px -10px rgba(0,0,0,0.08), 0 0 20px rgba(255,255,255,1) inset'
                }}
            >
                {/* 1. Prestige Area (Left) */}
                <div
                    onClick={() => isInteractionAllowed && navigate('/prestige')}
                    className={`flex-1 flex flex-row items-center gap-6 sm:gap-8 pl-10 sm:pl-16 ${!showStardust ? 'pr-10 sm:pr-16' : 'pr-4 sm:pr-8'} min-h-[110px] sm:min-h-[130px] rounded-l-[999px] ${!showStardust ? 'rounded-r-[999px]' : ''} ${isInteractionAllowed ? 'cursor-pointer active:scale-[0.99]' : 'cursor-default'} transition-all duration-300 group/left`}
                >
                    <div className="relative shrink-0 flex items-center justify-center">
                        <div className="absolute inset-0 bg-primary/10 blur-2xl rounded-full animate-pulse scale-150" />
                        <div className="relative z-10 scale-[1.3] group-hover/left:scale-[1.35] transition-transform duration-700">
                            <PlanetVisual level={level} size="md" />
                        </div>
                    </div>

                    <div className="flex flex-col gap-2.5 flex-1 min-w-[120px] max-w-[320px]">
                        <div className="flex flex-row flex-wrap items-center gap-2 sm:gap-3">
                            <h3 className="text-2xl font-black text-slate-800 tracking-[0.15em] uppercase whitespace-nowrap drop-shadow-sm select-none">
                                {name}
                            </h3>
                            <div className="flex flex-row items-center bg-slate-800/5 px-2.5 py-1 rounded-full border border-slate-800/10 shadow-sm shrink-0">
                                <span className="text-[10px] font-black text-slate-500 uppercase tracking-widest whitespace-nowrap">
                                    Lv.{level}
                                </span>
                            </div>
                        </div>

                        {/* Custom Planet Specific Progress Bar */}
                        <div className="relative w-full h-[6px] flex items-center group/bar cursor-default isolate overflow-visible mt-2 mb-2">
                            <div className="absolute left-[7px] right-[7px] top-0 bottom-0 bg-slate-100 rounded-full shadow-inner" />
                            {(() => {
                                const activeNodes = level === 5 ? [1, 2, 3] : [1, 2, 3, 4];
                                const maxIndex = activeNodes.length - 1;
                                const fillPercentage = stars > 0 ? ((Math.min(activeNodes.length, stars) - 1) / maxIndex) * 100 : 0;

                                return (
                                    <>
                                        <div className="absolute left-[7px] right-[7px] top-0 bottom-0">
                                            <div
                                                className="absolute left-0 top-0 bottom-0 bg-gradient-to-r from-primary/80 via-primary to-primary shadow-[0_0_15px_rgba(255,191,0,0.4)] rounded-full transition-all duration-1000 ease-out z-10"
                                                style={{ width: `${fillPercentage}%` }}
                                            >
                                                <div className="absolute inset-0 bg-white/20 animate-pulse rounded-full" />
                                            </div>
                                        </div>

                                        <div className="absolute inset-0 flex justify-between items-center z-20">
                                            {activeNodes.map((s) => (
                                                <div
                                                    key={s}
                                                    className={`w-3.5 h-3.5 flex items-center justify-center rounded-full border-2 transition-all duration-500 ${stars >= s
                                                        ? 'bg-primary border-white scale-110 shadow-lg'
                                                        : 'bg-white border-slate-200 scale-90 opacity-60'
                                                        } relative shrink-0`}
                                                >
                                                    {stars === s && (
                                                        <div className="absolute inset-0 bg-white animate-ping rounded-full opacity-75 z-10" />
                                                    )}
                                                </div>
                                            ))}
                                        </div>
                                    </>
                                );
                            })()}
                        </div>
                    </div>
                </div>

                {showStardust && (
                    <>
                        {/* Vertical Divider */}
                        <div className="h-12 w-[1.5px] bg-slate-200/60 shrink-0" />

                        {/* 2. Stardust Wallet Zone (Right) */}
                        <div
                            onClick={() => isInteractionAllowed && navigate('/stardust')}
                            className={`relative flex flex-row items-center rounded-r-[999px] min-h-[110px] pl-10 pr-8 gap-2 ${isInteractionAllowed ? 'cursor-pointer active:scale-[0.98]' : 'cursor-default'} transition-all duration-300 shrink-0 group/right`}
                        >
                            <div className="relative">
                                <PointsCoin type="stardust" size="sm" className="group-hover/right:rotate-[15deg] transition-transform duration-500 scale-[0.85]" />
                                <div className="absolute inset-0 bg-purple-400/5 blur-sm rounded-full -z-10 animate-pulse" />
                            </div>
                            <span className="text-[15px] font-black text-slate-800 tabular-nums">
                                {stardust.toLocaleString()}
                            </span>

                            {/* Right Highlight Overlay */}
                            {isInteractionAllowed && (
                                <div className="absolute inset-0 rounded-r-[999px] transition-all opacity-0 group-hover/right:opacity-100 pointer-events-none"
                                    style={{ background: 'rgba(0, 0, 0, 0.01)' }}
                                />
                            )}
                        </div>
                    </>
                )}
            </div>
        );
    }

    return null;
};
