import React, { useState } from 'react';
import { useApp } from '../AppContext';
import { Navbar } from '../components/Navbar';
import { useNavigate, useLocation } from 'react-router-dom';

// Expandable detail card component
const EarningCard = ({
    icon,
    iconBg,
    iconColor,
    title,
    description,
    details,
    actionLabel,
    actionIcon,
    onAction,
    children,
}: {
    icon: string;
    iconBg: string;
    iconColor: string;
    title: string;
    description: React.ReactNode;
    details: string[];
    actionLabel: string;
    actionIcon: string;
    onAction: () => void;
    children?: React.ReactNode;
}) => {
    const [expanded, setExpanded] = useState(false);

    return (
        <div className="rounded-3xl bg-white dark:bg-white/5 border border-gray-100 dark:border-white/5 shadow-sm overflow-hidden transition-all">
            {/* Clickable main area */}
            <div
                onClick={onAction}
                className="p-6 cursor-pointer hover:bg-gray-50/50 dark:hover:bg-white/[0.02] transition-colors group"
            >
                <div className="flex items-center gap-3 mb-4">
                    <div className={`w-10 h-10 rounded-full ${iconBg} flex items-center justify-center ${iconColor} group-hover:scale-110 transition-transform`}>
                        <span className="material-symbols-outlined">{icon}</span>
                    </div>
                    <h3 className="font-bold">{title}</h3>
                </div>
                <p className="text-sm text-gray-500 leading-relaxed">
                    {description}
                </p>
                <div className="mt-4 flex items-center gap-1 text-[10px] font-black text-purple-500 uppercase tracking-widest opacity-0 group-hover:opacity-100 transition-opacity">
                    <span>{actionLabel}</span>
                    <span className="material-symbols-outlined text-xs">{actionIcon}</span>
                </div>
            </div>

            {/* Extra content (e.g. copy link) */}
            {children}

            {/* Expand toggle button */}
            <button
                onClick={(e) => {
                    e.stopPropagation();
                    setExpanded(!expanded);
                }}
                className="w-full flex items-center justify-center gap-1.5 py-2.5 border-t border-gray-100 dark:border-white/5 text-xs font-bold text-gray-400 hover:text-gray-600 dark:hover:text-gray-300 hover:bg-gray-50 dark:hover:bg-white/[0.03] transition-all"
            >
                <span>{expanded ? 'Hide Details' : 'How to Obtain'}</span>
                <span className="material-symbols-outlined text-sm transition-transform" style={{ transform: expanded ? 'rotate(180deg)' : 'rotate(0deg)' }}>
                    expand_more
                </span>
            </button>

            {/* Expandable details panel */}
            <div
                className="overflow-hidden transition-all duration-300 ease-in-out"
                style={{ maxHeight: expanded ? '400px' : '0px' }}
            >
                <div className="px-6 pb-5 pt-1 space-y-2">
                    {details.map((detail, i) => (
                        <div key={i} className="flex items-start gap-2 text-xs text-gray-500 dark:text-gray-400">
                            <span className="text-purple-500 mt-0.5 shrink-0">•</span>
                            <span className="leading-relaxed">{detail}</span>
                        </div>
                    ))}
                </div>
            </div>
        </div>
    );
};

export const StardustPage = () => {
    const { userPrestige, user } = useApp();
    const navigate = useNavigate();
    const location = useLocation();

    // Check if user came from Prestige page
    const fromPrestige = location.state?.from === 'prestige';

    return (
        <div className="h-screen bg-surface-light dark:bg-surface-dark text-text-main dark:text-gray-100 flex flex-col overflow-hidden">
            <div className="flex-1 overflow-y-auto p-6 sm:p-10 pb-20 scroll-smooth">
                <div className="max-w-2xl mx-auto flex flex-col gap-6 animate-fade-in mt-4">

                    {/* Back Button / Title Header */}
                    <div className="flex items-center gap-4">
                        <button
                            onClick={() => navigate(-1)}
                            className="w-10 h-10 -ml-2 rounded-full flex items-center justify-center hover:bg-gray-100 dark:hover:bg-white/10 transition-colors"
                        >
                            <span className="material-symbols-outlined">arrow_back</span>
                        </button>
                        <h1 className="text-2xl font-black tracking-tight text-white">Stardust Wallet</h1>
                    </div>

                    {/* Stardust Balance Card */}
                    <div className="p-8 rounded-[2.5rem] border-2 border-purple-500/30 bg-gradient-to-br from-purple-500/5 to-pink-500/5 shadow-2xl shadow-purple-500/10 relative overflow-hidden">
                        <div className="absolute -top-32 -right-32 w-64 h-64 bg-purple-500/10 rounded-full blur-3xl animate-pulse" />
                        <div className="relative z-10 flex flex-col items-center text-center gap-4 py-4">
                            <div className="p-4 bg-white/50 dark:bg-black/20 rounded-full shadow-sm ring-1 ring-black/5 dark:ring-white/10 mb-2">
                                <span className="material-symbols-outlined text-4xl text-purple-400 drop-shadow-lg" style={{ fontVariationSettings: "'FILL' 1" }}>auto_awesome</span>
                            </div>

                            <div className="flex flex-col items-center">
                                <h2 className="text-sm font-black text-gray-400 uppercase tracking-widest mb-1">Current Stardust</h2>
                                <div className="flex items-baseline gap-2">
                                    <span className="text-6xl sm:text-7xl font-black text-black dark:text-white tracking-tighter drop-shadow-sm">
                                        {(userPrestige?.current_stardust || 0).toLocaleString()}
                                    </span>
                                </div>
                            </div>

                            <div className="flex items-center gap-2 mt-4 px-4 py-2 bg-white/60 dark:bg-black/20 rounded-xl border border-black/5 dark:border-white/5 backdrop-blur-sm group/info relative">
                                <span className="material-symbols-outlined text-purple-500 text-sm">history</span>
                                <p className="text-xs font-bold text-gray-600 dark:text-gray-400">
                                    Lifetime Earned: <span className="text-black dark:text-white">{(userPrestige?.total_stardust_collected || 0).toLocaleString()}</span>
                                </p>
                                <span className="material-symbols-outlined text-[10px] text-gray-300 cursor-help ml-1">info</span>

                                {/* Tooltip */}
                                <div className="absolute bottom-full left-1/2 -translate-x-1/2 mb-3 w-48 p-3 bg-gray-900 text-white text-[10px] rounded-xl shadow-2xl opacity-0 group-hover/info:opacity-100 pointer-events-none transition-all font-medium leading-relaxed border border-white/10 z-20">
                                    Total amount of Stardust ever collected. Spending on Planet Upgrades will utilize your current balance.
                                    <div className="absolute top-full left-1/2 -translate-x-1/2 border-8 border-transparent border-t-gray-900"></div>
                                </div>
                            </div>

                            <p className="text-[10px] font-bold text-gray-400 dark:text-gray-500 mt-2 flex items-center gap-1.5 opacity-80 uppercase tracking-widest">
                                <span className="w-1 h-3 bg-purple-500 rounded-full"></span>
                                Rare cosmic currency required for planetary evolution
                            </p>
                        </div>
                    </div>

                    {/* Earning Cards Grid */}
                    <div className="grid grid-cols-1 md:grid-cols-2 gap-4 items-start">
                        <EarningCard
                            icon="restart_alt"
                            iconBg="bg-amber-100 dark:bg-amber-900/30"
                            iconColor="text-amber-600 dark:text-amber-400"
                            title="Prestige Reset"
                            description="Reset your progress in a mastered unit to convert knowledge into pure Stardust."
                            actionLabel="Go to Units"
                            actionIcon="arrow_forward"
                            onAction={() => navigate('/practice')}
                            details={[
                                "Requires 100% Mastery in a Unit or Topic",
                                "Performing a Prestige Reset grants large amounts of Stardust based on difficulty",
                                "Resetting allows you to re-master content for even greater rewards",
                                "The higher your current planet level, the more Stardust you gain per reset",
                            ]}
                        />

                        <EarningCard
                            icon="shopping_bag"
                            iconBg="bg-blue-100 dark:bg-blue-900/30"
                            iconColor="text-blue-600 dark:text-blue-400"
                            title="Exchange Points"
                            description="Trade your accumulated NMS Points for Stardust in the cosmic marketplace."
                            actionLabel="Go to Market"
                            actionIcon="storefront"
                            onAction={() => navigate('/prestige', { replace: true })}
                            details={[
                                "Exchange Rate varies based on market conditions and your level",
                                "Use the 'Buy Stardust' panel on the Prestige main screen",
                                "Efficient way to convert daily activity points into progression currency",
                                "Bulk purchases may offer slight bonuses at higher levels",
                            ]}
                        />

                        <EarningCard
                            icon="emoji_events"
                            iconBg="bg-pink-100 dark:bg-pink-900/30"
                            iconColor="text-pink-600 dark:text-pink-400"
                            title="Special Events"
                            description="Participate in limited-time community challenges and seasonal events."
                            actionLabel="View Forum"
                            actionIcon="forum"
                            onAction={() => navigate('/forum')}
                            details={[
                                "Weekly challenges often reward Stardust for completion",
                                "Top leaderboard positions grant Stardust caches",
                                "Seasonal events (like Exam Prep Week) have boosted Stardust drop rates",
                                "Check the Forum announcements for active events",
                            ]}
                        />
                    </div>

                </div>
            </div>
        </div>
    );
};
