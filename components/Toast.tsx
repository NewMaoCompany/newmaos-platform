import React, { createContext, useContext, useState, useCallback, ReactNode } from 'react';

type ToastType = 'success' | 'error' | 'info' | 'warning';

interface Toast {
    id: number;
    message: string;
    type: ToastType;
}

interface ToastContextType {
    showToast: (message: string, type?: ToastType) => void;
}

const ToastContext = createContext<ToastContextType | undefined>(undefined);

export const useToast = () => {
    const context = useContext(ToastContext);
    if (!context) {
        throw new Error('useToast must be used within a ToastProvider');
    }
    return context;
};

export const ToastProvider = ({ children }: { children: ReactNode }) => {
    const [toasts, setToasts] = useState<Toast[]>([]);

    const showToast = useCallback((message: string, type: ToastType = 'info') => {
        const id = Date.now();
        setToasts(prev => [...prev, { id, message, type }]);

        // Auto-dismiss after 4 seconds
        setTimeout(() => {
            setToasts(prev => prev.filter(t => t.id !== id));
        }, 4000);
    }, []);

    const dismissToast = (id: number) => {
        setToasts(prev => prev.filter(t => t.id !== id));
    };

    const getIcon = (type: ToastType) => {
        switch (type) {
            case 'success': return 'check_circle';
            case 'error': return 'error';
            case 'warning': return 'warning';
            default: return 'info';
        }
    };

    const getStyles = (type: ToastType) => {
        switch (type) {
            case 'success':
                return 'bg-green-50 border-green-200 text-green-800 dark:bg-green-900/30 dark:border-green-700 dark:text-green-300';
            case 'error':
                return 'bg-red-50 border-red-200 text-red-800 dark:bg-red-900/30 dark:border-red-700 dark:text-red-300';
            case 'warning':
                return 'bg-amber-50 border-amber-200 text-amber-800 dark:bg-amber-900/30 dark:border-amber-700 dark:text-amber-300';
            default:
                return 'bg-blue-50 border-blue-200 text-blue-800 dark:bg-blue-900/30 dark:border-blue-700 dark:text-blue-300';
        }
    };

    const getIconColor = (type: ToastType) => {
        switch (type) {
            case 'success': return 'text-green-500';
            case 'error': return 'text-red-500';
            case 'warning': return 'text-amber-500';
            default: return 'text-blue-500';
        }
    };

    return (
        <ToastContext.Provider value={{ showToast }}>
            {children}

            {/* Toast Container */}
            <div className="fixed top-4 right-4 z-[9999] flex flex-col gap-3 pointer-events-none">
                {toasts.map(toast => (
                    <div
                        key={toast.id}
                        className="pointer-events-auto flex items-center gap-3 px-4 py-3 rounded-xl border-2 shadow-lg min-w-[280px] max-w-[400px] animate-slide-in-right bg-white"
                        style={{ borderColor: toast.type === 'success' ? '#22c55e' : toast.type === 'error' ? '#ef4444' : toast.type === 'warning' ? '#f59e0b' : '#3b82f6' }}
                    >
                        <div className={`p-2 rounded-full ${toast.type === 'success' ? 'bg-green-50' : toast.type === 'error' ? 'bg-red-50' : toast.type === 'warning' ? 'bg-amber-50' : 'bg-blue-50'}`}>
                            <span className={`material-symbols-outlined text-xl ${getIconColor(toast.type)}`}>
                                {getIcon(toast.type)}
                            </span>
                        </div>
                        <p className="flex-1 text-sm font-medium text-gray-800">{toast.message}</p>
                        <button
                            onClick={() => dismissToast(toast.id)}
                            className="text-gray-400 hover:text-gray-600 transition-colors"
                        >
                            <span className="material-symbols-outlined text-lg">close</span>
                        </button>
                    </div>
                ))}
            </div>
        </ToastContext.Provider>
    );
};
