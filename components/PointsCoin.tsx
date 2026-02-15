import React from 'react';

interface PointsCoinProps {
    size?: 'sm' | 'md' | 'lg' | 'xl';
    showGlow?: boolean;
    className?: string;
    animate?: boolean;
}

const SIZES: Record<string, { w: number; font: number }> = {
    sm: { w: 18, font: 10 },
    md: { w: 24, font: 14 },
    lg: { w: 40, font: 22 },
    xl: { w: 64, font: 36 },
};

/**
 * Golden gem coin with embossed "N".
 * Radial gradient + shimmer sweep + debossed letter via text-shadow.
 */
export const PointsCoin: React.FC<PointsCoinProps> = ({
    size = 'md',
    className = '',
    animate = false,
}) => {
    const s = SIZES[size];

    return (
        <span
            className={`points-coin points-coin--${size} ${animate ? 'points-coin-pop' : ''} ${className}`}
            style={{ width: s.w, height: s.w, fontSize: s.font }}
            aria-hidden="true"
        >
            N
        </span>
    );
};

/**
 * AnimatedNumber component that increments/decrements a value gradually.
 */
const AnimatedNumber: React.FC<{ value: number; duration?: number }> = ({ value, duration = 800 }) => {
    const [displayValue, setDisplayValue] = React.useState(value);

    React.useEffect(() => {
        if (displayValue === value) return;

        const start = Date.now();
        const initialValue = displayValue;
        const diff = value - initialValue;

        const animate = () => {
            const elapsed = Date.now() - start;
            const progress = Math.min(elapsed / duration, 1);

            // Easing function (outQuart)
            const easedProgress = 1 - Math.pow(1 - progress, 4);

            const nextValue = Math.round(initialValue + diff * easedProgress);
            setDisplayValue(nextValue);

            if (progress < 1) {
                requestAnimationFrame(animate);
            }
        };

        requestAnimationFrame(animate);
    }, [value]);

    const formatted = displayValue >= 10000
        ? `${(displayValue / 1000).toFixed(1)}k`
        : displayValue.toLocaleString();

    return <span>{formatted}</span>;
}

interface PointsBalanceBadgeProps {
    balance: number;
    onClick?: () => void;
    className?: string;
    bumping?: boolean;
}

export const PointsBalanceBadge = React.forwardRef<HTMLButtonElement, PointsBalanceBadgeProps>(
    ({ balance, onClick, className = '', bumping = false }, ref) => {
        const [isBumpActive, setIsBumpActive] = React.useState(false);

        // Trigger bump animation when bumping prop changes to true OR balance increases
        React.useEffect(() => {
            if (bumping) {
                setIsBumpActive(true);
                const timer = setTimeout(() => setIsBumpActive(false), 500);
                return () => clearTimeout(timer);
            }
        }, [bumping, balance]);

        return (
            <button
                ref={ref}
                onClick={onClick}
                className={`points-balance-badge ${isBumpActive ? 'points-bump-active' : ''} ${className}`}
                title={`${balance.toLocaleString()} Points`}
            >
                <PointsCoin size="md" />
                <span className="points-balance-number">
                    <AnimatedNumber value={balance} />
                </span>
                <div className="points-badge-divider" />
                <span className="material-symbols-outlined points-badge-action-icon text-amber-600/50">account_balance_wallet</span>
            </button>
        );
    },
);
