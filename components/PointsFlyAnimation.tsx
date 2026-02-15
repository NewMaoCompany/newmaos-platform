import React, { useEffect, useState, useCallback } from 'react';
import ReactDOM from 'react-dom';
import { PointsCoin } from './PointsCoin';

interface FlyParticle {
    id: number;
    startX: number;
    startY: number;
    endX: number;
    endY: number;
}

interface PointsFlyAnimationProps {
    count: number;
    sourceRect: DOMRect | null;
    targetRef: React.RefObject<HTMLElement>;
    onComplete?: () => void;
}

/**
 * Renders flying coin particles from a source position to a target (e.g., Navbar points badge).
 * Usage: Set `count > 0` and provide `sourceRect` to trigger the animation.
 */
export const PointsFlyAnimation: React.FC<PointsFlyAnimationProps> = ({
    count,
    sourceRect,
    targetRef,
    onComplete
}) => {
    const [particles, setParticles] = useState<FlyParticle[]>([]);

    useEffect(() => {
        if (count <= 0 || !sourceRect || !targetRef.current) return;

        const targetRect = targetRef.current.getBoundingClientRect();
        const centerX = sourceRect.left + sourceRect.width / 2;
        const centerY = sourceRect.top + sourceRect.height / 2;
        const endX = targetRect.left + targetRect.width / 2;
        const endY = targetRect.top + targetRect.height / 2;

        // Create particles with slight random offsets
        const maxParticles = Math.min(count, 10);
        const newParticles: FlyParticle[] = [];
        for (let i = 0; i < maxParticles; i++) {
            newParticles.push({
                id: Date.now() + i,
                startX: centerX + (Math.random() - 0.5) * 40,
                startY: centerY + (Math.random() - 0.5) * 40,
                endX,
                endY,
            });
        }
        setParticles(newParticles);

        // Cleanup after animation
        const timer = setTimeout(() => {
            setParticles([]);
            onComplete?.();
        }, 1200);

        return () => clearTimeout(timer);
    }, [count, sourceRect]);

    if (particles.length === 0) return null;

    return ReactDOM.createPortal(
        <>
            {particles.map((p) => (
                <div
                    key={p.id}
                    className="points-fly-particle"
                    style={{
                        left: p.startX,
                        top: p.startY,
                        '--fly-end-x': `${p.endX - p.startX}px`,
                        '--fly-end-y': `${p.endY - p.startY}px`,
                    } as React.CSSProperties}
                >
                    <PointsCoin size="sm" showGlow={false} />
                </div>
            ))}
        </>,
        document.body
    );
};

/**
 * Hook for triggering fly animation imperatively.
 */
export const usePointsFly = (targetRef: React.RefObject<HTMLElement>) => {
    const [flyState, setFlyState] = useState<{ count: number; rect: DOMRect | null }>({
        count: 0,
        rect: null,
    });

    const triggerFly = useCallback((count: number, sourceElement: HTMLElement | null) => {
        if (!sourceElement) return;
        const rect = sourceElement.getBoundingClientRect();
        setFlyState({ count, rect });
    }, []);

    const resetFly = useCallback(() => {
        setFlyState({ count: 0, rect: null });
    }, []);

    const FlyComponent = () => (
        <PointsFlyAnimation
            count={flyState.count}
            sourceRect={flyState.rect}
            targetRef={targetRef}
            onComplete={resetFly}
        />
    );

    return { triggerFly, FlyComponent };
};
