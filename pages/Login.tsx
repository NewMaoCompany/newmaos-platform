import React, { useState } from 'react';
import { useApp } from '../AppContext';
import { useNavigate, Link } from 'react-router-dom';
import { authApi } from '../src/services/api';

export const Login = () => {
    const { login } = useApp();
    const navigate = useNavigate();

    // Login State
    const [identifier, setIdentifier] = useState(''); // Can be email or username
    const [password, setPassword] = useState('');
    const [isLoading, setIsLoading] = useState(false);
    const [error, setError] = useState('');

    // Forgot Password Flow State
    const [view, setView] = useState<'login' | 'forgot-email' | 'forgot-reset'>('login');
    const [resetEmail, setResetEmail] = useState('');
    const [resetCode, setResetCode] = useState('');
    const [newPassword, setNewPassword] = useState('');

    // --- Handlers ---

    const handleLoginSubmit = async (e: React.FormEvent) => {
        e.preventDefault();
        setIsLoading(true);
        setError('');

        try {
            // Call real API
            const response = await authApi.login(identifier, password);

            if (response.session) {
                // Store token for API calls
                localStorage.setItem('auth_token', response.session.access_token);
            }

            // Update local state
            login(identifier);
            navigate('/dashboard');
        } catch (err: any) {
            setError(err.message || 'Login failed. Please check your credentials.');
        } finally {
            setIsLoading(false);
        }
    };

    const handleSendResetCode = async (e: React.FormEvent) => {
        e.preventDefault();
        setIsLoading(true);
        setError('');

        try {
            await authApi.forgotPassword(resetEmail);
            alert(`Password reset email sent to ${resetEmail}. Check your inbox!`);
            setView('forgot-reset');
        } catch (err: any) {
            setError(err.message || 'Failed to send reset email.');
        } finally {
            setIsLoading(false);
        }
    };

    const handleResetPassword = async (e: React.FormEvent) => {
        e.preventDefault();
        setIsLoading(true);
        setError('');

        try {
            await authApi.resetPassword(newPassword, resetCode);
            alert('Password successfully reset! Please login.');
            setIdentifier(resetEmail);
            setPassword('');
            setView('login');
        } catch (err: any) {
            setError(err.message || 'Failed to reset password.');
        } finally {
            setIsLoading(false);
        }
    };

    return (
        <div className="relative flex min-h-screen w-full flex-col items-center justify-center p-4 sm:p-6 lg:p-8 overflow-hidden bg-background-light dark:bg-background-dark">
            {/* Background Shapes */}
            <div className="absolute inset-0 w-full h-full overflow-hidden pointer-events-none z-0">
                <div className="absolute -top-[10%] -right-[5%] w-[600px] h-[600px] rounded-full bg-primary/5 blur-[100px] dark:bg-primary/10"></div>
                <div className="absolute -bottom-[10%] -left-[5%] w-[500px] h-[500px] rounded-full bg-orange-200/20 blur-[100px] dark:bg-orange-900/10"></div>
            </div>

            {/* Card Container */}
            <div className="relative z-10 w-full max-w-[420px] flex flex-col bg-surface-light dark:bg-surface-dark rounded-3xl shadow-soft border border-neutral-100 dark:border-neutral-800 p-8 sm:p-10 transition-all duration-300 animate-fade-in-up">

                {/* --- VIEW: LOGIN --- */}
                {view === 'login' && (
                    <>
                        <div className="flex flex-col items-center gap-3 mb-10 text-center">
                            <div className="flex items-center justify-center w-14 h-14 rounded-2xl bg-primary shadow-glow text-[#1c1a0d] mb-2 transform transition-transform hover:scale-105 duration-300">
                                <span className="material-symbols-outlined text-[32px]">functions</span>
                            </div>
                            <div className="flex flex-col gap-1">
                                <h1 className="text-3xl font-bold tracking-tight text-[#1c1a0d] dark:text-white">NewMaoS</h1>
                                <p className="text-sm font-medium text-neutral-500 dark:text-neutral-400">AP Calculus Mastery</p>
                            </div>
                        </div>

                        {/* Error Message */}
                        {error && (
                            <div className="p-3 bg-red-50 dark:bg-red-900/20 border border-red-200 dark:border-red-800 rounded-xl text-sm text-red-600 dark:text-red-400">
                                {error}
                            </div>
                        )}

                        <form className="flex flex-col gap-5 w-full" onSubmit={handleLoginSubmit}>
                            <div className="space-y-1.5">
                                <label className="block text-sm font-semibold text-[#1c1a0d] dark:text-neutral-200 ml-1" htmlFor="identifier">
                                    Email or Username
                                </label>
                                <div className="relative group">
                                    <input
                                        id="identifier"
                                        type="text"
                                        value={identifier}
                                        onChange={(e) => setIdentifier(e.target.value)}
                                        placeholder="math_whiz or user@example.com"
                                        className="block w-full rounded-xl border-neutral-200 bg-white px-4 py-3.5 text-base text-[#1c1a0d] placeholder:text-neutral-400 focus:border-primary focus:ring-4 focus:ring-primary/10 outline-none transition-all duration-200 dark:bg-black/20 dark:border-neutral-700 dark:text-white dark:focus:border-primary"
                                        required
                                    />
                                    <div className="absolute right-4 top-1/2 -translate-y-1/2 text-neutral-400 pointer-events-none transition-colors group-focus-within:text-primary">
                                        <span className="material-symbols-outlined text-[20px]">person</span>
                                    </div>
                                </div>
                            </div>

                            <div className="space-y-1.5">
                                <div className="flex justify-between items-center ml-1">
                                    <label className="block text-sm font-semibold text-[#1c1a0d] dark:text-neutral-200" htmlFor="password">
                                        Password
                                    </label>
                                </div>
                                <div className="relative group">
                                    <input
                                        id="password"
                                        type="password"
                                        value={password}
                                        onChange={(e) => setPassword(e.target.value)}
                                        placeholder="Enter your password"
                                        className="block w-full rounded-xl border-neutral-200 bg-white px-4 py-3.5 text-base text-[#1c1a0d] placeholder:text-neutral-400 focus:border-primary focus:ring-4 focus:ring-primary/10 outline-none transition-all duration-200 dark:bg-black/20 dark:border-neutral-700 dark:text-white dark:focus:border-primary"
                                        required
                                    />
                                    <div className="absolute right-4 top-1/2 -translate-y-1/2 text-neutral-400 pointer-events-none transition-colors group-focus-within:text-primary">
                                        <span className="material-symbols-outlined text-[20px]">lock</span>
                                    </div>
                                </div>
                                <div className="flex justify-end mt-1">
                                    <button
                                        type="button"
                                        onClick={() => setView('forgot-email')}
                                        className="text-xs font-medium text-neutral-500 hover:text-[#1c1a0d] dark:text-neutral-400 dark:hover:text-white transition-colors"
                                    >
                                        Forgot Password?
                                    </button>
                                </div>
                            </div>

                            <div className="pt-2">
                                <button
                                    type="submit"
                                    disabled={isLoading}
                                    className="relative w-full overflow-hidden rounded-xl bg-primary px-5 py-3.5 text-base font-bold text-[#1c1a0d] shadow-sm transition-all duration-200 hover:bg-[#eaca05] hover:shadow-md hover:-translate-y-0.5 active:translate-y-0 active:scale-[0.99] focus:outline-none disabled:opacity-70 disabled:cursor-not-allowed flex justify-center items-center gap-2"
                                >
                                    {isLoading ? (
                                        <>
                                            <span className="material-symbols-outlined animate-spin text-sm">progress_activity</span>
                                            Signing In...
                                        </>
                                    ) : "Sign In"}
                                </button>
                            </div>
                        </form>

                        <div className="mt-8 flex flex-col items-center gap-4">
                            <div className="flex items-center justify-center gap-1.5 text-sm text-neutral-500 dark:text-neutral-400">
                                <span>Don't have an account?</span>
                                <Link to="/signup" className="font-bold text-[#1c1a0d] dark:text-primary hover:underline underline-offset-4 decoration-2 decoration-primary/50 transition-all">Sign Up</Link>
                            </div>

                            <button
                                onClick={() => navigate('/dashboard')}
                                className="text-xs font-medium text-neutral-400 hover:text-[#1c1a0d] dark:text-neutral-500 dark:hover:text-white transition-colors border-b border-transparent hover:border-neutral-300 dark:hover:border-neutral-500 pb-0.5"
                            >
                                Sign in later
                            </button>
                        </div>
                    </>
                )}

                {/* --- VIEW: FORGOT PASSWORD (STEP 1: EMAIL) --- */}
                {view === 'forgot-email' && (
                    <div className="animate-fade-in">
                        <button
                            onClick={() => setView('login')}
                            className="flex items-center gap-1 text-xs font-bold text-gray-500 hover:text-black dark:hover:text-white mb-6 transition-colors"
                        >
                            <span className="material-symbols-outlined text-sm">arrow_back</span>
                            Back to Login
                        </button>

                        <div className="mb-8">
                            <div className="w-12 h-12 bg-yellow-100 dark:bg-yellow-900/20 text-yellow-700 dark:text-primary rounded-xl flex items-center justify-center mb-4">
                                <span className="material-symbols-outlined text-2xl">lock_reset</span>
                            </div>
                            <h2 className="text-2xl font-black text-[#1c1a0d] dark:text-white">Forgot Password?</h2>
                            <p className="text-sm text-gray-500 mt-2">Enter your email address and we'll send you a code to reset your password.</p>
                        </div>

                        <form onSubmit={handleSendResetCode} className="flex flex-col gap-6">
                            <div className="space-y-1.5">
                                <label className="block text-sm font-semibold text-[#1c1a0d] dark:text-neutral-200 ml-1" htmlFor="resetEmail">
                                    Email Address
                                </label>
                                <input
                                    id="resetEmail"
                                    type="email"
                                    value={resetEmail}
                                    onChange={(e) => setResetEmail(e.target.value)}
                                    placeholder="name@example.com"
                                    className="block w-full rounded-xl border-neutral-200 bg-white px-4 py-3.5 text-base text-[#1c1a0d] outline-none focus:border-primary focus:ring-4 focus:ring-primary/10 transition-all dark:bg-black/20 dark:border-neutral-700 dark:text-white"
                                    required
                                    autoFocus
                                />
                            </div>
                            <button
                                type="submit"
                                disabled={isLoading}
                                className="w-full rounded-xl bg-black dark:bg-white px-5 py-3.5 text-base font-bold text-white dark:text-black shadow-sm hover:opacity-90 active:scale-[0.99] transition-all flex justify-center items-center gap-2"
                            >
                                {isLoading ? <span className="material-symbols-outlined animate-spin">progress_activity</span> : 'Send Reset Code'}
                            </button>
                        </form>
                    </div>
                )}

                {/* --- VIEW: FORGOT PASSWORD (STEP 2: RESET) --- */}
                {view === 'forgot-reset' && (
                    <div className="animate-fade-in">
                        <div className="mb-8 text-center">
                            <div className="w-12 h-12 bg-green-100 dark:bg-green-900/20 text-green-700 dark:text-green-500 rounded-xl flex items-center justify-center mb-4 mx-auto">
                                <span className="material-symbols-outlined text-2xl">mark_email_read</span>
                            </div>
                            <h2 className="text-xl font-black text-[#1c1a0d] dark:text-white">Code Sent</h2>
                            <p className="text-sm text-gray-500 mt-1">We sent a code to <span className="font-bold text-text-main dark:text-gray-300">{resetEmail}</span></p>
                        </div>

                        <form onSubmit={handleResetPassword} className="flex flex-col gap-5">
                            <div className="space-y-1.5">
                                <label className="block text-sm font-semibold text-[#1c1a0d] dark:text-neutral-200 ml-1" htmlFor="resetCode">
                                    Verification Code
                                </label>
                                <input
                                    id="resetCode"
                                    type="text"
                                    value={resetCode}
                                    onChange={(e) => setResetCode(e.target.value)}
                                    placeholder="123456"
                                    maxLength={6}
                                    className="block w-full rounded-xl border-neutral-200 bg-white px-4 py-3.5 text-center text-xl tracking-widest font-mono text-[#1c1a0d] outline-none focus:border-primary focus:ring-4 focus:ring-primary/10 transition-all dark:bg-black/20 dark:border-neutral-700 dark:text-white"
                                    required
                                />
                            </div>
                            <div className="space-y-1.5">
                                <label className="block text-sm font-semibold text-[#1c1a0d] dark:text-neutral-200 ml-1" htmlFor="newPassword">
                                    New Password
                                </label>
                                <input
                                    id="newPassword"
                                    type="password"
                                    value={newPassword}
                                    onChange={(e) => setNewPassword(e.target.value)}
                                    placeholder="Enter new password"
                                    className="block w-full rounded-xl border-neutral-200 bg-white px-4 py-3.5 text-base text-[#1c1a0d] outline-none focus:border-primary focus:ring-4 focus:ring-primary/10 transition-all dark:bg-black/20 dark:border-neutral-700 dark:text-white"
                                    required
                                />
                            </div>
                            <button
                                type="submit"
                                disabled={isLoading}
                                className="w-full rounded-xl bg-primary px-5 py-3.5 text-base font-bold text-[#1c1a0d] shadow-sm hover:brightness-105 active:scale-[0.99] transition-all flex justify-center items-center gap-2"
                            >
                                {isLoading ? <span className="material-symbols-outlined animate-spin">progress_activity</span> : 'Reset Password'}
                            </button>
                            <button
                                type="button"
                                onClick={() => setView('forgot-email')}
                                className="text-xs text-center text-gray-400 hover:text-black dark:hover:text-white"
                            >
                                Use a different email
                            </button>
                        </form>
                    </div>
                )}

            </div>

            <footer className="mt-12 text-center">
                <p className="text-xs font-medium text-neutral-400 dark:text-neutral-600">
                    © 2026 NewMaoS. Designed for Excellence.
                </p>
            </footer>
        </div>
    );
};