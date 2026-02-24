import React from 'react';
import { createPortal } from 'react-dom';

interface CreatorGiftModalProps {
    isOpen: boolean;
    onClose: () => void;
    amount: string;
}

export const CreatorGiftModal: React.FC<CreatorGiftModalProps> = ({ isOpen, onClose, amount }) => {
    const [isVisible, setIsVisible] = React.useState(false);
    const [isClosing, setIsClosing] = React.useState(false);

    React.useEffect(() => {
        if (isOpen) {
            setIsVisible(true);
            setIsClosing(false);
        }
    }, [isOpen]);

    const handleDismiss = () => {
        setIsClosing(true);
        setTimeout(() => {
            setIsVisible(false);
            setIsClosing(false);
            onClose();
        }, 1200); // Wait for modal-out animation
    };

    if (!isVisible) return null;

    return createPortal(
        <div className={`fixed inset-0 z-[100000] flex items-center justify-center p-4 ${isClosing ? 'pointer-events-none' : ''}`}>
            {/* Backdrop */}
            <div
                className={`absolute inset-0 bg-black/60 backdrop-blur-sm transition-all duration-300 ${isClosing ? 'animate-fade-out' : 'animate-fade-in'}`}
                onClick={handleDismiss}
            />

            {/* Modal Content */}
            <div className={`relative w-full max-w-sm overflow-hidden bg-white/95 dark:bg-surface-dark/95 border border-white/20 dark:border-white/10 rounded-[2rem] shadow-2xl backdrop-blur-xl transition-all duration-300 ${isClosing ? 'animate-modal-out' : 'animate-modal-in'}`}>
                {/* Shine effect */}
                <div className="absolute inset-0 bg-gradient-to-tr from-transparent via-white/40 to-transparent dark:via-white/10 opacity-50 -translate-x-full animate-[shimmer-sweep_3s_infinite]" />

                <div className="px-6 py-8 text-center relative z-10 flex flex-col items-center">

                    {/* Icon Area */}
                    <div className="w-20 h-20 mb-6 rounded-full bg-gradient-to-br from-yellow-300 to-yellow-600 shadow-[0_0_30px_rgba(249,212,6,0.5)] flex items-center justify-center animate-bounce">
                        <span className="material-symbols-outlined text-4xl text-white">
                            redeem
                        </span>
                    </div>

                    <h2 className="text-2xl font-black mb-2 tracking-tight text-gray-900 dark:text-white">
                        Creator Reward
                    </h2>

                    <p className="text-[15px] font-medium text-gray-600 dark:text-gray-300 leading-relaxed mb-6">
                        Congratulations! You have received a massive bonus of <strong className="text-primary">{amount}</strong> Coins. Enjoy your premium experience.
                    </p>

                    <button
                        onClick={handleDismiss}
                        className="w-full h-12 rounded-full bg-primary hover:bg-primary-hover text-black font-bold text-lg shadow-[0_4px_14px_rgba(249,212,6,0.39)] hover:shadow-[0_6px_20px_rgba(249,212,6,0.4)] hover:-translate-y-0.5 transition-all outline-none"
                    >
                        Claim Reward
                    </button>
                </div>
            </div>
        </div>,
        document.body
    );
};
