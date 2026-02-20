import React from 'react';
import { useNavigate } from 'react-router-dom';

interface ProGateOverlayProps {
    featureName: string;
}

/**
 * A full-page overlay that blocks access to Pro-only features.
 * Shows a blurred background hint with a centered "Pro Only" card.
 */
export const ProGateOverlay: React.FC<ProGateOverlayProps> = ({ featureName }) => {
    const navigate = useNavigate();

    return (
        <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/40 backdrop-blur-md">
            <div className="max-w-md w-[90vw] p-10 rounded-[2.5rem] bg-white dark:bg-gray-900 shadow-2xl text-center">
                {/* Lock Icon */}
                <div className="w-20 h-20 mx-auto mb-6 rounded-full bg-gradient-to-br from-amber-400 to-orange-500 flex items-center justify-center shadow-lg shadow-amber-500/30">
                    <span className="material-symbols-outlined text-[40px] text-white">lock</span>
                </div>

                {/* Title */}
                <h2 className="text-2xl font-black tracking-tight mb-3 text-gray-900 dark:text-white">
                    Pro Feature
                </h2>

                {/* Description */}
                <p className="text-sm text-gray-500 dark:text-gray-400 font-medium leading-relaxed mb-8">
                    <strong>{featureName}</strong> is an exclusive feature available to Pro members.
                    Upgrade your plan to unlock full access.
                </p>

                {/* CTA Buttons */}
                <button
                    onClick={() => navigate('/settings/subscription')}
                    className="w-full py-4 rounded-2xl font-black text-sm uppercase tracking-widest bg-gradient-to-r from-amber-400 to-orange-500 text-white shadow-xl shadow-amber-500/20 hover:scale-[1.02] active:scale-95 transition-all mb-3"
                >
                    Learn More
                </button>

                <button
                    onClick={() => navigate(-1)}
                    className="w-full py-3 rounded-xl font-bold text-xs uppercase tracking-widest text-gray-400 hover:text-gray-600 dark:hover:text-gray-300 transition-colors"
                >
                    Go Back
                </button>
            </div>
        </div>
    );
};
