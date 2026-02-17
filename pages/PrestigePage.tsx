import React, { useState, useMemo } from 'react';
import { useNavigate } from 'react-router-dom';
import { useApp } from '../AppContext';
import { Navbar } from '../components/Navbar'; // Or custom header

// Reuse the generator logic or import it if I extracted it. 
// For now duplicating for speed/independence then can refactor.
const getPlanetStyle = (level: number) => {
    const gradients = [
        'linear-gradient(135deg, #e0e0e0 0%, #a0a0a0 100%)', // 1
        'linear-gradient(135deg, #ff9a9e 0%, #fecfef 99%, #fecfef 100%)', // 2
        'linear-gradient(135deg, #4facfe 0%, #00f2fe 100%)', // 3
        'linear-gradient(135deg, #43e97b 0%, #38f9d7 100%)', // 4
        'linear-gradient(135deg, #fa709a 0%, #fee140 100%)', // 5
        'linear-gradient(135deg, #667eea 0%, #764ba2 100%)', // 6
        'linear-gradient(135deg, #89f7fe 0%, #66a6ff 100%)', // 7
        'linear-gradient(135deg, #c471f5 0%, #fa71cd 100%)', // 8
        'linear-gradient(135deg, #f093fb 0%, #f5576c 100%)', // 9
        'linear-gradient(135deg, #30cfd0 0%, #330867 100%)', // 10
    ];
    return {
        background: gradients[(level - 1) % gradients.length],
        boxShadow: `0 0 ${40 + level * 5}px rgba(255,255,255,0.3)`
    };
};

const getPlanetName = (level: number) => {
    const names = [
        'Celestia', 'Ignis', 'Terra', 'Glacies', 'Fulata',
        'Aureus', 'Nebula', 'Void', 'Nova', 'Singularity'
    ];
    return names[(level - 1) % names.length] || 'Unknown';
};

export const PrestigePage = () => {
    const { user, userPoints, userPrestige, purchaseStardust, injectStardust } = useApp();
    const navigate = useNavigate();
    const [isBuying, setIsBuying] = useState(false);
    const [buyAmount, setBuyAmount] = useState(10); // Coins to spend

    // Fallback if null
    const level = userPrestige?.planet_level || 1;
    const stars = userPrestige?.star_level || 0;
    const currentStardust = userPrestige?.current_stardust || 0;

    // Config (Match RPC)
    const baseCost = 100 * level; // Cost for ONE star
    // Currently we have 0-3 stars.
    // If stars < 3, cost is baseCost.
    // Logic: 0->1 costs X, 1->2 costs X...
    // Current stardust is "accumulated for current level"?
    // The RPC simply deducts. 
    // Let's assume the UI shows "Stardust: [Current] / [Required for Next Star]"
    // But wait, the RPC `inject_stardust` checks `amount_to_inject`.
    // It seems the user holds stardust in a "Bank" inside `user_prestige.current_stardust`?
    // Reviewing RPC:
    // `current_stardust` in DB IS the balance?
    // "SELECT current_stardust ... FROM user_prestige"
    // "IF current_stardust < amount_to_inject THEN error"
    // "UPDATE ... current_stardust = current_stardust - v_req_stardust, star_level++"
    // YES. `current_stardust` IS the balance of Available Stardust.
    // AND `v_req_stardust` is calculated as `100 * planet`.

    // So UI:
    // Available Stardust: X
    // Cost for Next Star: Y
    // Button: "Inject Y Stardust" (Enabled if X >= Y)

    const nextStarCost = 100 * level;
    const canUpgrade = currentStardust >= nextStarCost;

    const handleBuy = async () => {
        setIsBuying(true);
        await purchaseStardust(buyAmount);
        setIsBuying(false);
    };

    const handleInject = async () => {
        // We inject exactly the cost
        await injectStardust(nextStarCost);
    };

    const style = useMemo(() => getPlanetStyle(level), [level]);
    const name = useMemo(() => getPlanetName(level), [level]);

    return (
        <div className="min-h-screen bg-black text-white font-sans flex flex-col items-center relative overflow-hidden">
            {/* Starry Background */}
            <div className="absolute inset-0 bg-[url('/noise.png')] opacity-10 pointer-events-none"></div>

            {/* Header */}
            <header className="w-full max-w-5xl mx-auto p-6 z-10 flex justify-between items-center">
                <button onClick={() => navigate(-1)} className="flex items-center gap-2 text-gray-400 hover:text-white transition-colors">
                    <span className="material-symbols-outlined">arrow_back</span>
                    <span>Back</span>
                </button>
                <div className="flex items-center gap-4 bg-white/10 px-4 py-2 rounded-full backdrop-blur-md border border-white/5">
                    <span className="text-amber-400 font-bold flex items-center gap-1">
                        <span className="material-symbols-outlined text-sm">monetization_on</span>
                        {userPoints.balance} Coins
                    </span>
                    <span className="h-4 w-px bg-white/20"></span>
                    <span className="text-purple-300 font-bold flex items-center gap-1">
                        <span className="material-symbols-outlined text-sm">auto_awesome</span>
                        {currentStardust} Stardust
                    </span>
                </div>
            </header>

            {/* Main Content */}
            <main className="flex-grow flex flex-col items-center justify-center w-full max-w-4xl px-4 gap-12 z-10">

                {/* Planet */}
                <div className="relative group">
                    <div
                        className="w-64 h-64 sm:w-80 sm:h-80 md:w-96 md:h-96 rounded-full shadow-[0_0_100px_rgba(255,255,255,0.2)] animate-float"
                        style={style}
                    >
                        <div className="absolute inset-0 rounded-full bg-gradient-to-tr from-black/0 via-white/10 to-white/30 opacity-60"></div>
                    </div>
                    {/* Level Badge */}
                    <div className="absolute -bottom-6 left-1/2 -translate-x-1/2 bg-white/10 backdrop-blur-md px-6 py-2 rounded-full border border-white/20">
                        <h1 className="text-2xl font-black tracking-widest uppercase">{name} <span className="text-sm text-gray-400 ml-2">Lvl {level}</span></h1>
                    </div>
                </div>

                {/* Progress / Stars */}
                <div className="flex flex-col items-center gap-4">
                    <div className="flex gap-4">
                        {[1, 2, 3].map((s) => (
                            <div key={s} className={`w-8 h-8 rounded-full flex items-center justify-center border-2 transition-all ${s <= stars ? 'bg-amber-400 border-amber-400 text-black shadow-[0_0_20px_rgba(251,191,36,0.5)]' : 'border-gray-600 text-gray-600'}`}>
                                <span className="material-symbols-outlined text-lg" style={{ fontVariationSettings: "'FILL' 1" }}>star</span>
                            </div>
                        ))}
                    </div>
                    <p className="text-gray-400 font-medium">
                        {stars < 3 ? `Upgrade to ${stars + 1} Star${stars + 1 > 1 ? 's' : ''}` : `Next Planet Awaits`}
                    </p>
                </div>

                {/* Controls */}
                <div className="w-full max-w-md flex flex-col gap-6">

                    {/* Inject Button */}
                    <button
                        onClick={handleInject}
                        disabled={!canUpgrade}
                        className={`w-full py-4 rounded-2xl font-black text-lg flex items-center justify-center gap-3 transition-all relative overflow-hidden group
                            ${canUpgrade
                                ? 'bg-gradient-to-r from-purple-500 to-pink-500 hover:from-purple-400 hover:to-pink-400 text-white shadow-lg hover:shadow-purple-500/50'
                                : 'bg-gray-800 text-gray-500 cursor-not-allowed opacity-50'}`}
                    >
                        <span className="material-symbols-outlined relative z-10">publish</span>
                        <span className="relative z-10">
                            {canUpgrade ? `Inject ${nextStarCost} Stardust` : `Need ${nextStarCost} Stardust`}
                        </span>
                    </button>

                    {/* Buy Stardust */}
                    <div className="bg-white/5 p-6 rounded-3xl border border-white/10 backdrop-blur-sm">
                        <div className="flex justify-between items-center mb-4">
                            <span className="font-bold text-gray-300">Get Stardust</span>
                            <span className="text-xs text-gray-500 bg-black/30 px-2 py-1 rounded">1 Coin = 10 Stardust</span>
                        </div>
                        <div className="flex gap-4">
                            <div className="flex-1 bg-black/20 rounded-xl px-4 flex items-center border border-white/5">
                                <span className="text-amber-400 mr-2">N</span>
                                <input
                                    type="number"
                                    min="1"
                                    max={userPoints.balance}
                                    value={buyAmount}
                                    onChange={(e) => setBuyAmount(Math.max(1, parseInt(e.target.value) || 0))}
                                    className="bg-transparent w-full outline-none font-bold text-white text-right"
                                />
                            </div>
                            <button
                                onClick={handleBuy}
                                disabled={isBuying || userPoints.balance < buyAmount}
                                className="bg-white text-black px-6 py-3 rounded-xl font-bold hover:bg-gray-200 disabled:opacity-50 disabled:cursor-not-allowed transition-colors"
                            >
                                Buy
                            </button>
                        </div>
                        <p className="text-right text-xs text-gray-500 mt-2">
                            +{buyAmount * 10} Stardust
                        </p>
                    </div>
                </div>

            </main>
        </div>
    );
};
