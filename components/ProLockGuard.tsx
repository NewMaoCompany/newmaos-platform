import React, { useState } from 'react';
import { useApp } from '../AppContext';
import { ProGateOverlay } from './ProGateOverlay';

interface ProLockGuardProps {
    children: React.ReactNode;
    featureName: string;
}

export const ProLockGuard: React.FC<ProLockGuardProps> = ({ children, featureName }) => {
    const { isPro } = useApp();
    const [showModal, setShowModal] = useState(false);

    if (isPro) {
        return <>{children}</>;
    }

    return (
        <div className="relative group">
            {/* The locked content (visually dimmed, but clicks are intercepted) */}
            <div className="opacity-50 select-none" style={{ pointerEvents: 'none' }}>
                {children}
            </div>
            
            {/* Invisible overlay to catch clicks */}
            <div 
                className="absolute inset-0 z-10 cursor-pointer"
                onClick={(e) => {
                    e.preventDefault();
                    e.stopPropagation();
                    setShowModal(true);
                }}
            />

            {showModal && (
                <ProGateOverlay 
                    featureName={featureName} 
                    onClose={() => setShowModal(false)} 
                />
            )}
        </div>
    );
};
