import React, { Component, ErrorInfo, ReactNode } from 'react';

interface Props {
    children?: ReactNode;
    fallback?: ReactNode;
}

interface State {
    hasError: boolean;
    error: Error | null;
    errorInfo: ErrorInfo | null;
}

export class ErrorBoundary extends Component<Props, State> {
    public state: State = {
        hasError: false,
        error: null,
        errorInfo: null
    };

    public static getDerivedStateFromError(error: Error): State {
        return { hasError: true, error, errorInfo: null };
    }

    public componentDidCatch(error: Error, errorInfo: ErrorInfo) {
        console.error('Uncaught error:', error, errorInfo);
        this.setState({ errorInfo });
    }

    public render() {
        if (this.state.hasError) {
            if (this.props.fallback) {
                return this.props.fallback;
            }

            return (
                <div className="min-h-screen flex items-center justify-center bg-gray-50 p-6">
                    <div className="bg-white rounded-xl shadow-xl border border-red-100 p-8 max-w-3xl w-full">
                        <h2 className="text-2xl font-bold text-red-600 mb-4 flex items-center gap-2">
                            <span className="material-symbols-outlined text-3xl">error</span>
                            Something went wrong
                        </h2>
                        <p className="text-gray-600 mb-6">
                            An unexpected error occurred in the application. Please report this to the developer.
                        </p>

                        <div className="bg-gray-900 rounded-lg p-4 overflow-auto max-h-[60vh]">
                            <h3 className="text-red-400 font-mono text-sm font-bold mb-2">Error Message:</h3>
                            <pre className="text-white font-mono text-sm mb-4 whitespace-pre-wrap">
                                {this.state.error?.toString()}
                            </pre>

                            {this.state.errorInfo && (
                                <>
                                    <h3 className="text-gray-400 font-mono text-sm font-bold mb-2">Stack Trace:</h3>
                                    <pre className="text-gray-500 font-mono text-xs whitespace-pre-wrap">
                                        {this.state.errorInfo.componentStack}
                                    </pre>
                                </>
                            )}
                        </div>

                        <div className="mt-6 flex justify-end gap-3">
                            <button
                                onClick={() => window.location.reload()}
                                className="px-4 py-2 bg-gray-200 hover:bg-gray-300 rounded-lg font-bold text-gray-700 transition"
                            >
                                Reload Page
                            </button>
                            <button
                                onClick={() => {
                                    localStorage.clear();
                                    window.location.reload();
                                }}
                                className="px-4 py-2 bg-red-500 hover:bg-red-600 rounded-lg font-bold text-white transition"
                            >
                                Clear Data & Reload (Fix Crash)
                            </button>
                        </div>
                    </div>
                </div>
            );
        }

        return this.props.children;
    }
}
