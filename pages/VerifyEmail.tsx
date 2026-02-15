import React, { useState, useEffect } from 'react';
import { useNavigate, useSearchParams } from 'react-router-dom';
import { useApp } from '../AppContext';
import { authApi } from '../src/services/api';

export const VerifyEmail = () => {
    const [searchParams] = useSearchParams();
    const navigate = useNavigate();
    const { login } = useApp();
    const [status, setStatus] = useState<'verifying' | 'success' | 'error'>('verifying');
    const [errorMessage, setErrorMessage] = useState('');

    useEffect(() => {
        const email = searchParams.get('email');
        const code = searchParams.get('code');

        if (!email || !code) {
            setStatus('error');
            setErrorMessage('Invalid verification link. Please check your email and try again.');
            return;
        }

        // Verify email and auto-login
        const verifyAndLogin = async () => {
            try {
                // Step 1: Verify email
                await authApi.verifyEmail(email, code);
                setStatus('success');

                // Step 2: Auto-login after a short delay to show success
                setTimeout(async () => {
                    try {
                        // We need the password to login, but we don't have it from the link
                        // So we'll redirect to login page with a success message
                        // OR we can use a special "verified" token flow
                        // For now, redirect to login with success indicator
                        navigate('/login?verified=true');
                    } catch {
                        navigate('/login?verified=true');
                    }
                }, 2000);

            } catch (err: any) {
                setStatus('error');
                setErrorMessage(translateError(err.message) || 'Verification failed. The link may have expired.');
            }
        };

        // Helper to translate backend errors if they come in Chinese
        const translateError = (msg: string) => {
            if (!msg) return '';
            if (msg.includes('密码') || msg.includes('邮箱') || msg.includes('错误') || msg.includes('用户')) {
                if (msg.includes('验证') || msg.includes('verify')) return 'Please verify your email.';
                return 'Verification failed.';
            }
            return msg;
        };

        verifyAndLogin();
    }, [searchParams, navigate, login]);

    return (
        <div className="min-h-screen flex items-center justify-center bg-background-light dark:bg-background-dark p-4">
            {/* Background decorations */}
            <div className="absolute inset-0 overflow-hidden pointer-events-none">
                <div className="absolute -top-[10%] -left-[5%] w-[600px] h-[600px] rounded-full bg-primary/5 blur-[100px] dark:bg-primary/10"></div>
                <div className="absolute -bottom-[10%] -right-[5%] w-[500px] h-[500px] rounded-full bg-blue-200/20 blur-[100px] dark:bg-blue-900/10"></div>
            </div>

            <div className="relative z-10 w-full max-w-md bg-surface-light dark:bg-surface-dark rounded-3xl shadow-soft border border-neutral-100 dark:border-neutral-800 p-8 text-center animate-fade-in">
                {status === 'verifying' && (
                    <>
                        <div className="w-20 h-20 mx-auto mb-6 flex items-center justify-center">
                            <div className="w-16 h-16 border-4 border-primary border-t-transparent rounded-full animate-spin"></div>
                        </div>
                        <h1 className="text-2xl font-black text-text-main dark:text-white mb-2">
                            Verifying Your Email
                        </h1>
                        <p className="text-gray-500 dark:text-gray-400">
                            Please wait while we confirm your email address...
                        </p>
                    </>
                )}

                {status === 'success' && (
                    <>
                        <div className="w-20 h-20 mx-auto mb-6 bg-green-100 dark:bg-green-900/30 rounded-full flex items-center justify-center">
                            <span className="material-symbols-outlined text-5xl text-green-600 dark:text-green-400">
                                check_circle
                            </span>
                        </div>
                        <h1 className="text-2xl font-black text-text-main dark:text-white mb-2">
                            Email Verified!
                        </h1>
                        <p className="text-gray-500 dark:text-gray-400 mb-6">
                            Your email has been verified successfully. Redirecting to sign in...
                        </p>
                        <div className="flex items-center justify-center gap-2 text-sm text-primary font-medium">
                            <span className="material-symbols-outlined animate-spin text-sm">progress_activity</span>
                            Redirecting...
                        </div>
                    </>
                )}

                {status === 'error' && (
                    <>
                        <div className="w-20 h-20 mx-auto mb-6 bg-red-100 dark:bg-red-900/30 rounded-full flex items-center justify-center">
                            <span className="material-symbols-outlined text-5xl text-red-600 dark:text-red-400">
                                error
                            </span>
                        </div>
                        <h1 className="text-2xl font-black text-text-main dark:text-white mb-2">
                            Verification Failed
                        </h1>
                        <p className="text-red-600 dark:text-red-400 mb-6">
                            {errorMessage}
                        </p>
                        <button
                            onClick={() => navigate('/signup')}
                            className="w-full py-3.5 bg-primary rounded-xl font-bold text-text-main shadow-md hover:brightness-105 active:scale-95 transition-all"
                        >
                            Try Again
                        </button>
                    </>
                )}
            </div>
        </div>
    );
};
