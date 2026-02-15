import React, { useState, useEffect, useCallback, useRef } from 'react';
import { PointsCoin } from './PointsCoin';
import { useApp } from '../AppContext';
import '../src/styles/coin-animation.css';

interface FlyingCoinData {
    id: number;
    startX: number;
    startY: number;
    targetX: number;
    targetY: number;
    burstX: number;
    burstY: number;
    burstRotate: number;
    delay: number;
}

interface FloatingTextData {
    id: number;
    x: number;
    y: number;
    text: string;
}

/**
 * Global component that listens for 'coin-collect' events and renders flying coin animations.
 * Coins fly from source to wallet badge, with staggered ding sounds.
 */
export const CoinCollector: React.FC = () => {
    const { pointsBalanceRef, user } = useApp();
    const [coins, setCoins] = useState<FlyingCoinData[]>([]);
    const [texts, setTexts] = useState<FloatingTextData[]>([]);
    const audioContextRef = useRef<AudioContext | null>(null);

    // Lazy-initialise a single shared AudioContext
    const getAudioContext = useCallback(() => {
        if (!audioContextRef.current || audioContextRef.current.state === 'closed') {
            audioContextRef.current = new (window.AudioContext || (window as any).webkitAudioContext)();
        }
        // Resume if suspended (Chrome autoplay policy)
        if (audioContextRef.current.state === 'suspended') {
            audioContextRef.current.resume();
        }
        return audioContextRef.current;
    }, []);

    // Listen for audio-unlock events (dispatched during user gestures before async work)
    useEffect(() => {
        const handleUnlock = () => {
            try {
                getAudioContext(); // Pre-warm the AudioContext during user gesture
            } catch { }
        };
        window.addEventListener('audio-unlock', handleUnlock);
        return () => window.removeEventListener('audio-unlock', handleUnlock);
    }, [getAudioContext]);

    // Web Audio API coin ding — rising pitch per index for a cascading feel
    const playDing = useCallback((delay: number = 0, index: number = 0, mode: 'earn' | 'spend' = 'earn') => {
        const { preferences } = user;
        setTimeout(() => {
            if (preferences && preferences.soundEffects === false) return;
            try {
                const ctx = getAudioContext();
                const osc = ctx.createOscillator();
                const gain = ctx.createGain();

                osc.type = 'sine';

                if (mode === 'spend') {
                    // Falling pitch for spending (High -> Low)
                    const baseFreq = 800 - index * 30;
                    osc.frequency.setValueAtTime(baseFreq * 1.5, ctx.currentTime);
                    osc.frequency.exponentialRampToValueAtTime(baseFreq, ctx.currentTime + 0.1);

                    gain.gain.setValueAtTime(0, ctx.currentTime);
                    gain.gain.linearRampToValueAtTime(0.05, ctx.currentTime + 0.01);
                    gain.gain.exponentialRampToValueAtTime(0.001, ctx.currentTime + 0.2);
                } else {
                    // Rising pitch for earning (Low -> High)
                    const baseFreq = 1047 + index * 60;
                    osc.frequency.setValueAtTime(baseFreq, ctx.currentTime);
                    osc.frequency.exponentialRampToValueAtTime(baseFreq * 1.3, ctx.currentTime + 0.08);

                    gain.gain.setValueAtTime(0, ctx.currentTime);
                    gain.gain.linearRampToValueAtTime(0.08, ctx.currentTime + 0.01);
                    gain.gain.exponentialRampToValueAtTime(0.001, ctx.currentTime + 0.25);
                }

                osc.connect(gain);
                gain.connect(ctx.destination);

                osc.start(ctx.currentTime);
                osc.stop(ctx.currentTime + 0.25);
            } catch (err) {
                // Silently fail — no audio is not critical
            }
        }, delay);
    }, [getAudioContext]);

    useEffect(() => {
        const handleCoinEvent = (e: any) => {
            const { amount, x, y, mode = 'earn' } = e.detail;

            // Get Navbar wallet badge position
            if (!pointsBalanceRef.current) return;
            const walletRect = pointsBalanceRef.current.getBoundingClientRect();
            const walletX = walletRect.left + walletRect.width / 2;
            const walletY = walletRect.top + walletRect.height / 2;

            // Determine Source and Target based on mode
            let startX, startY, targetX, targetY;

            if (mode === 'spend') {
                // Spend: Wallet -> Event Location (e.g. Button)
                startX = walletX;
                startY = walletY;
                targetX = x; // Destination is where the click happened
                targetY = y;
            } else {
                // Earn: Event Location -> Wallet
                startX = x;
                startY = y;
                targetX = walletX;
                targetY = walletY;
            }

            // Generate coins — proportional to amount but capped at 25 for perf (was 15)
            const coinCount = Math.min(Math.max(Math.ceil(amount / 20), 5), 25);
            const newCoins: FlyingCoinData[] = [];

            for (let i = 0; i < coinCount; i++) {
                const delay = i * 80; // Staggered 80ms apart
                const burstAngle = (Math.PI * 2 * i) / coinCount + (Math.random() - 0.5) * 0.4;
                const burstDist = 35 + Math.random() * 45;

                newCoins.push({
                    id: Date.now() + i,
                    startX,
                    startY,
                    targetX,
                    targetY,
                    burstX: Math.cos(burstAngle) * burstDist,
                    burstY: Math.sin(burstAngle) * burstDist,
                    burstRotate: Math.random() * 360,
                    delay,
                });

                // Play ding when coin arrives at target (~burst 350ms + fly 550ms)
                playDing(delay + 900, i, mode);
            }

            setCoins(prev => [...prev, ...newCoins]);

            // Trigger visual feedback (Text/Bump) when animation "Arrives"
            // For 'spend', we show text at the destination (button)
            // For 'earn', we show text at the wallet
            setTimeout(() => {
                if (mode === 'earn') {
                    pointsBalanceRef.current?.classList.add('points-bump-active');
                }

                // Add floating text
                const textId = Date.now();
                setTexts(prev => [...prev, {
                    id: textId,
                    x: targetX,
                    y: targetY, // Float up from target
                    text: mode === 'spend' ? `-${amount}` : `+${amount}`
                }]);

                // Remove text after animation
                setTimeout(() => {
                    setTexts(prev => prev.filter(t => t.id !== textId));
                    if (mode === 'earn') {
                        pointsBalanceRef.current?.classList.remove('points-bump-active');
                    }
                }, 2000);

            }, 900);

            // Remove coins after animations complete
            const totalDuration = coinCount * 80 + 1200;
            setTimeout(() => {
                setCoins(prev => prev.filter(c => !newCoins.find(nc => nc.id === c.id)));
            }, totalDuration);
        };

        window.addEventListener('coin-collect', handleCoinEvent);
        return () => window.removeEventListener('coin-collect', handleCoinEvent);
    }, [pointsBalanceRef, playDing]);

    return (
        <div className="coin-container fixed inset-0 pointer-events-none z-[9999]">
            {coins.map(coin => (
                <div
                    key={coin.id}
                    className="flying-coin"
                    style={{
                        left: coin.startX,
                        top: coin.startY,
                        '--burst-x': `${coin.burstX}px`,
                        '--burst-y': `${coin.burstY}px`,
                        '--burst-rotate': `${coin.burstRotate}deg`,
                        '--target-x': `${coin.targetX - coin.startX}px`,
                        '--target-y': `${coin.targetY - coin.startY}px`,
                        animation: `
                            coin-burst 0.35s ease-out forwards ${coin.delay}ms,
                            coin-fly-to-target 0.55s cubic-bezier(0.45, 0, 0.55, 1) forwards ${coin.delay + 350}ms
                        `
                    } as React.CSSProperties}
                >
                    <PointsCoin size="md" className="coin-shimmer" />
                </div>
            ))}

            {/* Render Floating Texts */}
            {texts.map(text => (
                <div
                    key={text.id}
                    className="floating-points-text"
                    style={{
                        left: text.x,
                        top: text.y
                    }}
                >
                    {text.text}
                </div>
            ))}
        </div>
    );
};
