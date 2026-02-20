import React from 'react';

interface AvatarAuraProps {
    level: number;
}

/**
 * A highly polished, extremely gorgeous thematic aura overlay for avatars.
 * It is strictly constrained by `inset-0 rounded-full overflow-hidden` to ensure
 * it NEVER exceeds the button/avatar size bounds.
 */
export const AvatarAura: React.FC<AvatarAuraProps> = ({ level }) => {
    // Map level 1-10 to the 5 distinct planet visuals (modulo 5)
    // 1: Celestia (Moon/Silver), 2: Ignis (Fire), 3: Terra (Earth), 4: Glacies (Ice), 5: Fulata (Cosmic)
    const planetTheme = ((level - 1) % 5) + 1;

    // Helper functions for complex inner layered effects
    const renderCelestiaAura = () => (
        <div className="absolute inset-0 w-full h-full rounded-full mix-blend-screen pointer-events-none z-10">
            {/* Inner shimmer ring */}
            <div className="absolute inset-0 rounded-full border-[1.5px] border-white/60 shadow-[inset_0_0_12px_rgba(255,255,255,0.8)] animate-pulse" style={{ animationDuration: '3s' }} />
            {/* Subtle rotating sheen */}
            <div className="absolute inset-[-50%] bg-[conic-gradient(transparent_0deg,rgba(255,255,255,0.4)_90deg,transparent_180deg)] animate-[spin_30s_linear_infinite] opacity-60 rounded-full" />
            <div className="absolute inset-0 bg-[radial-gradient(circle_at_top_right,rgba(255,255,255,0.6)_0%,transparent_50%)]" />
        </div>
    );

    const renderIgnisAura = () => (
        <div className="absolute inset-0 w-full h-full rounded-full mix-blend-color-dodge pointer-events-none z-10">
            {/* Scorching inner ring */}
            <div className="absolute inset-0 rounded-full border-[2px] border-[#fb923c]/80 shadow-[inset_0_0_15px_rgba(239,68,68,0.9)] animate-pulse" style={{ animationDuration: '2s' }} />
            {/* Rotating fire vortex */}
            <div className="absolute inset-[-50%] bg-[conic-gradient(transparent_0deg,rgba(249,115,22,0.6)_120deg,transparent_360deg)] animate-[spin_20s_linear_infinite] opacity-80 rounded-full" />
            <div className="absolute inset-0 bg-[radial-gradient(circle_at_bottom,rgba(220,38,38,0.7)_0%,transparent_60%)] animate-pulse" />
        </div>
    );

    const renderTerraAura = () => (
        <div className="absolute inset-0 w-full h-full rounded-full mix-blend-screen pointer-events-none z-10">
            {/* Bioluminescent inner ring */}
            <div className="absolute inset-0 rounded-full border-[1.5px] border-[#34d399]/70 shadow-[inset_0_0_15px_rgba(16,185,129,0.8)] animate-pulse" style={{ animationDuration: '4s' }} />
            {/* Swirling atmosphere */}
            <div className="absolute inset-[-50%] bg-[conic-gradient(transparent_0deg,rgba(56,189,248,0.5)_180deg,transparent_360deg)] animate-[spin_40s_linear_infinite] opacity-70 rounded-full" />
            <div className="absolute inset-0 bg-[radial-gradient(circle_at_top_left,rgba(74,222,128,0.6)_0%,transparent_60%)]" />
        </div>
    );

    const renderGlaciesAura = () => (
        <div className="absolute inset-0 w-full h-full rounded-full mix-blend-color-dodge pointer-events-none z-10">
            {/* Crystalline frost inner edge */}
            <div className="absolute inset-0 rounded-full border-[2px] border-[#a5f3fc]/90 shadow-[inset_0_0_20px_rgba(34,211,238,0.9)]" />
            <div className="absolute inset-0 rounded-full shadow-[inset_0_0_5px_rgba(255,255,255,1)] animate-pulse" style={{ animationDuration: '1.5s' }} />
            {/* Frozen core */}
            <div className="absolute inset-[-50%] bg-[conic-gradient(transparent_0deg,rgba(165,243,252,0.7)_60deg,transparent_120deg,rgba(165,243,252,0.7)_240deg,transparent_300deg)] animate-[spin_35s_linear_infinite] opacity-80 rounded-full" />
            <div className="absolute inset-0 bg-[radial-gradient(circle_at_center,transparent_30%,rgba(6,182,212,0.4)_100%)]" />
        </div>
    );

    const renderFulataAura = () => (
        <div className="absolute inset-0 w-full h-full rounded-full mix-blend-hard-light pointer-events-none z-10">
            {/* Cosmic plasma border */}
            <div className="absolute inset-0 rounded-full border-[2px] border-[#c084fc]/70 shadow-[inset_0_0_18px_rgba(168,85,247,0.8)] animate-pulse" style={{ animationDuration: '3s' }} />
            {/* Twin galaxy swirl */}
            <div className="absolute inset-[-50%] bg-[conic-gradient(transparent_0deg,rgba(217,119,6,0.6)_90deg,transparent_180deg,rgba(147,51,234,0.6)_270deg,transparent_360deg)] animate-[spin_25s_linear_infinite] opacity-90 rounded-full" />
            {/* Core brilliance */}
            <div className="absolute inset-0 bg-[radial-gradient(circle_at_bottom_right,rgba(251,191,36,0.5)_0%,transparent_50%)]" />
            <div className="absolute inset-0 bg-[radial-gradient(circle_at_top_left,rgba(139,92,246,0.5)_0%,transparent_50%)]" />
        </div>
    );

    return (
        <div className="absolute inset-0 w-full h-full rounded-full overflow-hidden pointer-events-none">
            {planetTheme === 1 && renderCelestiaAura()}
            {planetTheme === 2 && renderIgnisAura()}
            {planetTheme === 3 && renderTerraAura()}
            {planetTheme === 4 && renderGlaciesAura()}
            {planetTheme === 5 && renderFulataAura()}
        </div>
    );
};
