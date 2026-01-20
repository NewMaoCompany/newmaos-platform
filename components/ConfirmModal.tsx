import React, { useEffect } from 'react';

interface ConfirmModalProps {
    isOpen: boolean;
    title: string;
    message: string;
    onConfirm: () => void;
    onCancel: () => void;
    confirmText?: string;
    cancelText?: string;
    isDestructive?: boolean;
}

export const ConfirmModal: React.FC<ConfirmModalProps> = ({
    isOpen,
    title,
    message,
    onConfirm,
    onCancel,
    confirmText = "Confirm",
    cancelText = "Cancel",
    isDestructive = false
}) => {
    // Prevent scrolling when modal is open
    useEffect(() => {
        if (isOpen) {
            document.body.style.overflow = 'hidden';
        } else {
            document.body.style.overflow = 'unset';
        }
        return () => {
            document.body.style.overflow = 'unset';
        };
    }, [isOpen]);

    if (!isOpen) return null;

    return (
        <div className="fixed inset-0 z-[9999] flex items-center justify-center p-4">
            {/* Backdrop */}
            <div
                className="absolute inset-0 bg-black/40 backdrop-blur-sm transition-opacity"
                onClick={onCancel}
            />

            {/* Modal */}
            <div className="relative bg-white dark:bg-[#2c2c2e] rounded-2xl shadow-2xl max-w-sm w-full p-6 animate-fade-in-up border border-gray-100 dark:border-gray-700">
                <div className={`w-12 h-12 rounded-full flex items-center justify-center mb-4 ${isDestructive ? 'bg-red-50 text-red-500' : 'bg-primary/10 text-primary'}`}>
                    <span className="material-symbols-outlined text-2xl">
                        {isDestructive ? 'warning' : 'info'}
                    </span>
                </div>

                <h3 className="text-lg font-black text-text-main dark:text-white mb-2">
                    {title}
                </h3>

                <p className="text-sm text-gray-500 dark:text-gray-400 mb-6 leading-relaxed font-medium">
                    {message}
                </p>

                <div className="flex gap-3">
                    <button
                        onClick={onCancel}
                        className="flex-1 px-4 py-2.5 rounded-xl border border-gray-200 dark:border-gray-700 text-gray-600 dark:text-gray-300 font-bold text-sm hover:bg-gray-50 dark:hover:bg-white/5 transition-colors"
                    >
                        {cancelText}
                    </button>
                    <button
                        onClick={onConfirm}
                        className={`flex-1 px-4 py-2.5 rounded-xl font-bold text-sm shadow-lg shadow-gray-200 dark:shadow-none transition-transform active:scale-95 ${isDestructive
                                ? 'bg-red-500 hover:bg-red-600 text-white shadow-red-200'
                                : 'bg-primary hover:bg-primary-dark text-black shadow-yellow-200'
                            }`}
                    >
                        {confirmText}
                    </button>
                </div>
            </div>
        </div>
    );
};
