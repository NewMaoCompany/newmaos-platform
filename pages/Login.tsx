import React, { useState, useEffect } from 'react';
import { useApp } from '../AppContext';
import { useNavigate, Link, useSearchParams } from 'react-router-dom';
import { authApi } from '../src/services/api';
import { supabase } from '../src/services/supabaseClient';
import { useToast } from '../components/Toast';

export const Login = () => {
    const { login } = useApp();
    const navigate = useNavigate();
    const [searchParams] = useSearchParams();
    const { showToast } = useToast();

    // Login State
    const [email, setEmail] = useState('');
    const [password, setPassword] = useState('');
    const [isLoading, setIsLoading] = useState(false);
    const [error, setError] = useState('');
    const [needsVerification, setNeedsVerification] = useState(false); // Email not verified
    const [showVerifiedBanner, setShowVerifiedBanner] = useState(false);

    // Check for verified=true parameter from email verification
    useEffect(() => {
        if (searchParams.get('verified') === 'true') {
            setShowVerifiedBanner(true);
            // Clear the URL parameter
            window.history.replaceState({}, '', window.location.pathname);
        }
    }, [searchParams]);

    // Forgot Password Flow State
    const [view, setView] = useState<'login' | 'forgot-email' | 'forgot-verify' | 'forgot-update'>('login');
    const [resetEmail, setResetEmail] = useState('');
    const [resetCode, setResetCode] = useState(['', '', '', '', '', '']);
    const [newPassword, setNewPassword] = useState('');

    // Password Validation
    const passwordChecks = {
        minLength: newPassword.length >= 8,
        hasUppercase: /[A-Z]/.test(newPassword),
        hasLowercase: /[a-z]/.test(newPassword),
        hasNumber: /[0-9]/.test(newPassword)
    };
    const isPasswordValid = Object.values(passwordChecks).every(Boolean);

    // --- Handlers ---

    const handleResetCodeChange = (index: number, value: string) => {
        if (value.length > 1) return;
        const newCode = [...resetCode];
        newCode[index] = value;
        setResetCode(newCode);
        if (value && index < 5) {
            document.getElementById(`reset-code-${index + 1}`)?.focus();
        }
    };

    const handleResetKeyDown = (index: number, e: React.KeyboardEvent) => {
        if (e.key === 'Backspace' && !resetCode[index] && index > 0) {
            document.getElementById(`reset-code-${index - 1}`)?.focus();
        }
    };

    const handleLoginSubmit = async (e: React.FormEvent) => {
        e.preventDefault();
        setIsLoading(true);
        setError('');
        setNeedsVerification(false);

        try {
            // Call real API
            const response = await authApi.login(email, password);

            if (response.session) {
                // Set session in Supabase client to enable persistence and auto-refresh
                await supabase.auth.setSession(response.session);
                // Keep this for legacy fallback in api.ts
                localStorage.setItem('auth_token', response.session.access_token);
            }

            // Update local state - use profile name if available, otherwise use email
            const username = response.profile?.name || response.user?.user_metadata?.name;
            login(email, username, response.session?.user?.id);
            navigate('/dashboard');
        } catch (err: any) {
            const errorMessage = err.message || '';

            // Check if the error is about email not being confirmed
            if (errorMessage.toLowerCase().includes('email not confirmed') ||
                errorMessage.toLowerCase().includes('email is not confirmed')) {
                setNeedsVerification(true);
                setError('Please verify your email before signing in.');
            } else {
                // Default error message for invalid credentials
                setError('Incorrect email or password');
            }
        } finally {
            setIsLoading(false);
        }
    };

    const handleResendVerification = async () => {
        setIsLoading(true);
        try {
            await authApi.resendVerification(email);
            showToast('Verification email sent! Check your inbox.', 'success');
        } catch (err: any) {
            setError(err.message || 'Failed to resend verification email.');
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
            showToast(`Verification code sent to ${resetEmail}`, 'success');
            setView('forgot-verify');
        } catch (err: any) {
            setError(err.message || 'Failed to send verification code.');
        } finally {
            setIsLoading(false);
        }
    };

    const handleVerifyCode = async (e: React.FormEvent) => {
        e.preventDefault();
        setIsLoading(true);
        setError('');

        try {
            await authApi.verifyResetCode(resetEmail, resetCode.join(''));
            setView('forgot-update');
        } catch (err: any) {
            setError(err.message || 'Invalid code. Please try again.');
        } finally {
            setIsLoading(false);
        }
    };

    const handleResetPassword = async (e: React.FormEvent) => {
        e.preventDefault();
        if (!isPasswordValid) return;

        setIsLoading(true);
        setError('');

        try {
            const response = await authApi.resetPassword(resetEmail, resetCode.join(''), newPassword);

            // Auto-login handling
            if (response.session) {
                // Set session in Supabase client
                await supabase.auth.setSession(response.session);
                localStorage.setItem('auth_token', response.session.access_token);
                // Use profile name if available, otherwise email prefix
                const name = response.profile?.name || response.user?.user_metadata?.name || resetEmail.split('@')[0];
                login(resetEmail, name, response.session.user.id); // Determine name from response if possible
                showToast('Password updated! Logging you in...', 'success');
                navigate('/dashboard');
            } else {
                showToast('Password updated! Please sign in.', 'success');
                setView('login');
                setPassword('');
            }
        } catch (err: any) {
            setError(err.message || 'Failed to update password.');
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

                        {/* Verified Success Banner */}
                        {showVerifiedBanner && (
                            <div className="p-4 bg-green-50 dark:bg-green-900/20 border border-green-200 dark:border-green-800 rounded-xl text-sm text-green-700 dark:text-green-400 mb-4 flex items-center gap-3">
                                <span className="material-symbols-outlined text-xl">check_circle</span>
                                <div>
                                    <p className="font-bold">Email verified successfully!</p>
                                    <p className="text-green-600 dark:text-green-500 text-xs">You can now sign in to your account.</p>
                                </div>
                            </div>
                        )}

                        {/* Error Message */}
                        {error && (
                            <div className="p-3 bg-red-50 dark:bg-red-900/20 border border-red-200 dark:border-red-800 rounded-xl text-sm text-red-600 dark:text-red-400">
                                <p>{error}</p>
                                {needsVerification && (
                                    <button
                                        type="button"
                                        onClick={handleResendVerification}
                                        disabled={isLoading}
                                        className="mt-2 text-sm font-bold text-blue-600 dark:text-blue-400 hover:underline flex items-center gap-1"
                                    >
                                        {isLoading ? (
                                            <span className="material-symbols-outlined animate-spin text-xs">progress_activity</span>
                                        ) : (
                                            <span className="material-symbols-outlined text-xs">refresh</span>
                                        )}
                                        {isLoading ? 'Sending...' : 'Resend verification email'}
                                    </button>
                                )}
                            </div>
                        )}

                        <form className="flex flex-col gap-5 w-full" onSubmit={handleLoginSubmit}>
                            <div className="space-y-1.5">
                                <label className="block text-sm font-semibold text-[#1c1a0d] dark:text-neutral-200 ml-1" htmlFor="email">
                                    Email Address
                                </label>
                                <div className="relative group">
                                    <input
                                        id="email"
                                        type="email"
                                        value={email}
                                        onChange={(e) => setEmail(e.target.value)}
                                        placeholder="you@example.com"
                                        className="block w-full rounded-xl border-neutral-200 bg-white pl-11 pr-4 py-3.5 text-base text-[#1c1a0d] placeholder:text-neutral-400 focus:border-primary focus:ring-4 focus:ring-primary/10 outline-none transition-all duration-200 dark:bg-black/20 dark:border-neutral-700 dark:text-white dark:focus:border-primary"
                                        required
                                    />
                                    <div className="absolute left-4 top-1/2 -translate-y-1/2 text-neutral-400 pointer-events-none transition-colors group-focus-within:text-primary">
                                        <span className="material-symbols-outlined text-[20px]">mail</span>
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
                                        className="block w-full rounded-xl border-neutral-200 bg-white pl-11 pr-4 py-3.5 text-base text-[#1c1a0d] placeholder:text-neutral-400 focus:border-primary focus:ring-4 focus:ring-primary/10 outline-none transition-all duration-200 dark:bg-black/20 dark:border-neutral-700 dark:text-white dark:focus:border-primary"
                                        required
                                    />
                                    <div className="absolute left-4 top-1/2 -translate-y-1/2 text-neutral-400 pointer-events-none transition-colors group-focus-within:text-primary">
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
                            Back to Sign In
                        </button>

                        <div className="mb-8">
                            <div className="w-12 h-12 bg-yellow-100 dark:bg-yellow-900/20 text-yellow-700 dark:text-primary rounded-xl flex items-center justify-center mb-4">
                                <span className="material-symbols-outlined text-2xl">lock_reset</span>
                            </div>
                            <h2 className="text-2xl font-black text-[#1c1a0d] dark:text-white">Forgot Password?</h2>
                            <p className="text-sm text-gray-500 mt-2">Enter your email address and we'll send you a code to reset your password.</p>
                        </div>

                        {error && (
                            <div className="p-3 bg-red-50 dark:bg-red-900/20 border border-red-200 dark:border-red-800 rounded-xl text-sm text-red-600 dark:text-red-400 mb-6">
                                {error}
                            </div>
                        )}

                        <form onSubmit={handleSendResetCode} className="flex flex-col gap-6">
                            <div className="space-y-1.5">
                                <label className="block text-sm font-semibold text-[#1c1a0d] dark:text-neutral-200 ml-1" htmlFor="resetEmail">
                                    Email Address
                                </label>
                                <div className="relative group">
                                    <input
                                        id="resetEmail"
                                        type="email"
                                        value={resetEmail}
                                        onChange={(e) => setResetEmail(e.target.value)}
                                        placeholder="name@example.com"
                                        className="block w-full rounded-xl border-neutral-200 bg-white pl-11 pr-4 py-3.5 text-base text-[#1c1a0d] outline-none focus:border-primary focus:ring-4 focus:ring-primary/10 transition-all dark:bg-black/20 dark:border-neutral-700 dark:text-white"
                                        required
                                        autoFocus
                                    />
                                    <div className="absolute left-4 top-1/2 -translate-y-1/2 text-neutral-400 pointer-events-none transition-colors group-focus-within:text-primary">
                                        <span className="material-symbols-outlined text-[20px]">mail</span>
                                    </div>
                                </div>
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

                {/* --- VIEW: FORGOT PASSWORD (STEP 2: VERIFY CODE) --- */}
                {view === 'forgot-verify' && (
                    <div className="animate-fade-in text-center">
                        <button
                            onClick={() => setView('forgot-email')}
                            className="absolute top-8 left-8 flex items-center gap-1 text-xs font-bold text-gray-500 hover:text-black dark:hover:text-white transition-colors"
                        >
                            <span className="material-symbols-outlined text-sm">arrow_back</span>
                            Back
                        </button>

                        <div className="w-16 h-16 bg-primary/10 text-primary rounded-2xl flex items-center justify-center mb-6 mx-auto mt-4">
                            <span className="material-symbols-outlined text-3xl">lock</span>
                        </div>

                        <h2 className="text-xl font-black text-[#1c1a0d] dark:text-white mb-2">Enter Verification Code</h2>
                        <p className="text-sm text-gray-500 mb-2">
                            We've sent a 6-digit code to <span className="font-bold text-[#1c1a0d] dark:text-white">{resetEmail}</span>
                        </p>
                        <p className="text-xs text-amber-600 dark:text-amber-400 mb-6 flex items-center justify-center gap-1">
                            <span className="material-symbols-outlined text-sm">schedule</span>
                            Code expires in 10 minutes
                        </p>

                        {error && (
                            <div className="p-3 bg-red-50 dark:bg-red-900/20 border border-red-200 dark:border-red-800 rounded-xl text-sm text-red-600 dark:text-red-400 mb-6 mx-auto">
                                {error}
                            </div>
                        )}

                        <form onSubmit={handleVerifyCode}>
                            <div className="flex justify-center gap-2 mb-8">
                                {resetCode.map((digit, index) => (
                                    <input
                                        key={index}
                                        id={`reset-code-${index}`}
                                        type="text"
                                        maxLength={1}
                                        value={digit}
                                        onChange={(e) => handleResetCodeChange(index, e.target.value)}
                                        onKeyDown={(e) => handleResetKeyDown(index, e)}
                                        className="w-12 h-14 text-center text-2xl font-bold rounded-xl border-2 border-neutral-100 bg-white focus:border-primary focus:ring-4 focus:ring-primary/10 outline-none transition-all dark:bg-black/20 dark:border-neutral-700 dark:text-white"
                                    />
                                ))}
                            </div>

                            <div className="flex flex-col gap-3">
                                <button
                                    type="submit"
                                    disabled={isLoading}
                                    className="w-full rounded-xl bg-primary px-5 py-3.5 text-base font-bold text-[#1c1a0d] shadow-sm hover:brightness-105 active:scale-[0.99] transition-all disabled:opacity-70 disabled:cursor-not-allowed flex justify-center items-center gap-2"
                                >
                                    {isLoading ? (
                                        <>
                                            <span className="material-symbols-outlined animate-spin text-sm">progress_activity</span>
                                            Verifying...
                                        </>
                                    ) : (
                                        "Verify Code"
                                    )}
                                </button>

                                <button
                                    type="button"
                                    onClick={async () => {
                                        setIsLoading(true);
                                        setError('');
                                        try {
                                            await authApi.forgotPassword(resetEmail);
                                            showToast(`Resent code to ${resetEmail}`, 'success');
                                        } catch (err: any) {
                                            setError(err.message || 'Failed to resend code.');
                                        } finally {
                                            setIsLoading(false);
                                        }
                                    }}
                                    disabled={isLoading}
                                    className="w-full rounded-xl bg-white dark:bg-white/5 border border-gray-200 dark:border-gray-700 px-5 py-3.5 text-base font-bold text-[#1c1a0d] dark:text-white hover:bg-gray-50 dark:hover:bg-white/10 transition-all"
                                >
                                    Resend Code
                                </button>
                            </div>
                        </form>
                    </div>
                )}

                {/* --- VIEW: FORGOT PASSWORD (STEP 3: UPDATE PASSWORD) --- */}
                {view === 'forgot-update' && (
                    <div className="animate-fade-in">
                        <button
                            onClick={() => setView('login')}
                            className="absolute top-8 left-8 flex items-center gap-1 text-xs font-bold text-gray-500 hover:text-black dark:hover:text-white transition-colors"
                        >
                            <span className="material-symbols-outlined text-sm">arrow_back</span>
                            Back
                        </button>
                        <div className="mb-8">
                            <div className="w-12 h-12 bg-green-100 dark:bg-green-900/20 text-green-700 dark:text-green-500 rounded-xl flex items-center justify-center mb-4">
                                <span className="material-symbols-outlined text-2xl">lock_reset</span>
                            </div>
                            <h2 className="text-2xl font-black text-[#1c1a0d] dark:text-white">New Password</h2>
                            <p className="text-sm text-gray-500 mt-2">Create a new secure password for your account.</p>
                        </div>

                        {error && (
                            <div className="p-3 bg-red-50 dark:bg-red-900/20 border border-red-200 dark:border-red-800 rounded-xl text-sm text-red-600 dark:text-red-400 mb-6">
                                {error}
                            </div>
                        )}

                        <form onSubmit={handleResetPassword} className="flex flex-col gap-6">
                            <div className="space-y-1.5">
                                <label className="block text-sm font-semibold text-[#1c1a0d] dark:text-neutral-200 ml-1" htmlFor="newPassword">
                                    New Password
                                </label>
                                <div className="relative group">
                                    <input
                                        id="newPassword"
                                        type="password"
                                        value={newPassword}
                                        onChange={(e) => setNewPassword(e.target.value)}
                                        placeholder="Enter new password"
                                        className="block w-full rounded-xl border-neutral-200 bg-white pl-11 pr-4 py-3.5 text-base text-[#1c1a0d] outline-none focus:border-primary focus:ring-4 focus:ring-primary/10 transition-all dark:bg-black/20 dark:border-neutral-700 dark:text-white"
                                        required
                                        autoFocus
                                    />
                                    <div className="absolute left-4 top-1/2 -translate-y-1/2 text-neutral-400 pointer-events-none transition-colors group-focus-within:text-primary">
                                        <span className="material-symbols-outlined text-[20px]">lock</span>
                                    </div>
                                </div>
                                {newPassword.length > 0 && (
                                    <div className="mt-2 grid grid-cols-2 gap-1 text-xs">
                                        <div className={`flex items-center gap-1.5 ${passwordChecks.minLength ? 'text-green-600' : 'text-gray-400'}`}>
                                            <span className="material-symbols-outlined text-sm">{passwordChecks.minLength ? 'check_circle' : 'circle'}</span>
                                            8+ characters
                                        </div>
                                        <div className={`flex items-center gap-1.5 ${passwordChecks.hasUppercase ? 'text-green-600' : 'text-gray-400'}`}>
                                            <span className="material-symbols-outlined text-sm">{passwordChecks.hasUppercase ? 'check_circle' : 'circle'}</span>
                                            Uppercase
                                        </div>
                                        <div className={`flex items-center gap-1.5 ${passwordChecks.hasLowercase ? 'text-green-600' : 'text-gray-400'}`}>
                                            <span className="material-symbols-outlined text-sm">{passwordChecks.hasLowercase ? 'check_circle' : 'circle'}</span>
                                            Lowercase
                                        </div>
                                        <div className={`flex items-center gap-1.5 ${passwordChecks.hasNumber ? 'text-green-600' : 'text-gray-400'}`}>
                                            <span className="material-symbols-outlined text-sm">{passwordChecks.hasNumber ? 'check_circle' : 'circle'}</span>
                                            Number
                                        </div>
                                    </div>
                                )}
                            </div>
                            <button
                                type="submit"
                                disabled={isLoading || !isPasswordValid}
                                className="w-full rounded-xl bg-black dark:bg-white px-5 py-3.5 text-base font-bold text-white dark:text-black shadow-sm hover:opacity-90 active:scale-[0.99] transition-all flex justify-center items-center gap-2 disabled:opacity-70 disabled:cursor-not-allowed"
                            >
                                {isLoading ? <span className="material-symbols-outlined animate-spin">progress_activity</span> : 'Update Password'}
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