import React, { useState } from 'react';
import { useApp } from '../AppContext';
import { Navbar } from '../components/Navbar';
import { useNavigate, useLocation } from 'react-router-dom';
import { useToast } from '../components/Toast';

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
    const { userPrestige, user, purchaseStardust } = useApp();
    const navigate = useNavigate();
    const location = useLocation();
    const { showToast } = useToast();

    // Exchange Modal State
    const [showExchange, setShowExchange] = useState(false);
    const [exchangeAmount, setExchangeAmount] = useState('100');
    const [isExchanging, setIsExchanging] = useState(false);

    // Check if user came from Prestige page
    const fromPrestige = location.state?.from === 'prestige';

    const handleExchange = async () => {
        const amount = parseInt(exchangeAmount, 10);
        if (isNaN(amount) || amount <= 0) {
            showToast('Please enter a valid amount', 'error');
            return;
        }
        if (amount > (user?.coins_balance || 0)) {
            showToast('Insufficient NMS Points (Coins)', 'error');
            return;
        }

        setIsExchanging(true);
        try {
            const { success, message } = await purchaseStardust(amount);
            if (success) {
                showToast('Exchange successful!', 'success');
                setShowExchange(false);
            } else {
                showToast(message || 'Exchange failed', 'error');
            }
        } catch (e: any) {
            showToast('Error during exchange', 'error');
        } finally {
            setIsExchanging(false);
        }
    };

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

                    {/* Earning Cards */}
                    <div className="grid grid-cols-1 gap-4 items-start">
                        <EarningCard
                            icon="shopping_bag"
                            iconBg="bg-blue-100 dark:bg-blue-900/30"
                            iconColor="text-blue-600 dark:text-blue-400"
                            title="Exchange Points"
                            description="Trade your accumulated NMS Points for Stardust in the cosmic marketplace."
                            actionLabel="Exchange Now"
                            actionIcon="swap_horiz"
                            onAction={() => setShowExchange(true)}
                            details={[
                                "Exchange Rate varies based on market conditions and your level",
                                "Efficient way to convert daily activity points into progression currency",
                                "Bulk purchases may offer slight bonuses at higher levels",
                            ]}
                        />
                    </div>

                </div>
            </div>

            {/* Exchange Modal */}
            {showExchange && (
                <div className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/60 backdrop-blur-sm animate-fade-in">
                    <div className="bg-white dark:bg-zinc-900 rounded-3xl w-full max-w-sm overflow-hidden shadow-2xl border border-gray-100 dark:border-white/10" onClick={e => e.stopPropagation()}>
                        <div className="p-6 border-b border-gray-100 dark:border-white/5">
                            <div className="flex items-center justify-between mb-2">
                                <h3 className="text-lg font-black text-text-main dark:text-white">Exchange Points</h3>
                                <button onClick={() => setShowExchange(false)} className="text-gray-400 hover:text-text-main dark:hover:text-white">
                                    <span className="material-symbols-outlined">close</span>
                                </button>
                            </div>
                            <p className="text-xs text-gray-500">Trade your NMS Points (Coins) for pure Stardust.</p>
                        </div>
                        <div className="p-6 space-y-4">
                            <div className="bg-gray-50 dark:bg-black/20 rounded-xl p-4 flex items-center justify-between border border-gray-100 dark:border-white/5">
                                <div className="flex items-center gap-2">
                                    <span className="material-symbols-outlined text-amber-500 text-xl">monetization_on</span>
                                    <span className="text-sm font-bold text-gray-600 dark:text-gray-300">Your Points</span>
                                </div>
                                <span className="text-lg font-black text-text-main dark:text-white">{(user?.coins_balance || 0).toLocaleString()}</span>
                            </div>
                            
                            <div>
                                <label className="block text-xs font-bold text-gray-400 uppercase tracking-widest mb-2">Amount to Exchange</label>
                                <div className="relative">
                                    <input 
                                        type="number" 
                                        value={exchangeAmount}
                                        onChange={e => setExchangeAmount(e.target.value)}
                                        className="w-full bg-gray-50 dark:bg-black/20 border border-gray-200 dark:border-white/10 rounded-xl px-4 py-3 text-lg font-black text-text-main dark:text-white focus:outline-none focus:ring-2 focus:ring-blue-500"
                                        placeholder="0"
                                        min="1"
                                    />
                                    <button 
                                        onClick={() => setExchangeAmount(String(user?.coins_balance || 0))}
                                        className="absolute right-3 top-1/2 -translate-y-1/2 text-[10px] font-bold bg-blue-100 dark:bg-blue-900/30 text-blue-600 dark:text-blue-400 px-2 py-1 rounded-md"
                                    >
                                        MAX
                                    </button>
                                </div>
                            </div>

                            <button 
                                onClick={handleExchange}
                                disabled={isExchanging}
                                className="w-full mt-2 bg-blue-600 hover:bg-blue-500 text-white font-bold py-3.5 rounded-xl transition-all disabled:opacity-50 flex justify-center items-center gap-2"
                            >
                                {isExchanging ? (
                                    <span className="material-symbols-outlined animate-spin">refresh</span>
                                ) : (
                                    <>
                                        <span className="material-symbols-outlined text-sm">swap_horiz</span>
                                        Confirm Exchange
                                    </>
                                )}
                            </button>
                        </div>
                    </div>
                </div>
            )}
        </div>
    );
};
