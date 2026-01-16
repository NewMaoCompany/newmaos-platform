/* eslint-disable @typescript-eslint/no-explicit-any */
import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { supabase } from '../src/services/supabaseClient';

export const ResetPassword = () => {
    const navigate = useNavigate();
    const [password, setPassword] = useState('');
    const [confirmPassword, setConfirmPassword] = useState('');
    const [isLoading, setIsLoading] = useState(false);
    const [error, setError] = useState('');
    const [message, setMessage] = useState('');

    useEffect(() => {
        // Listen for the password recovery event
        const { data: authListener } = supabase.auth.onAuthStateChange(async (event, session) => {
            if (event === 'PASSWORD_RECOVERY') {
                // User is signed in with a temporary session
                // We show the form to update password
                console.log('Recovery session active', session);
            }
        });

        return () => {
            authListener.subscription.unsubscribe();
        };
    }, []);

    const handleUpdatePassword = async (e: React.FormEvent) => {
        e.preventDefault();
        setIsLoading(true);
        setError('');
        setMessage('');

        if (password !== confirmPassword) {
            setError("Passwords don't match");
            setIsLoading(false);
            return;
        }

        try {
            const { error } = await supabase.auth.updateUser({
                password: password
            });

            if (error) throw error;

            setMessage('Password updated successfully! Redirecting to login...');
            setTimeout(() => {
                navigate('/login');
            }, 2000);
        } catch (err: any) {
            setError(err.message || 'Failed to update password');
        } finally {
            setIsLoading(false);
        }
    };

    return (
        <div className="flex min-h-screen w-full flex-col items-center justify-center p-4 bg-background-light dark:bg-background-dark">
            <div className="w-full max-w-md bg-white dark:bg-surface-dark rounded-3xl shadow-soft p-8 border border-neutral-100 dark:border-neutral-800 animate-fade-in-up">
                <div className="text-center mb-8">
                    <div className="w-12 h-12 bg-blue-100 dark:bg-blue-900/20 text-blue-700 dark:text-blue-500 rounded-xl flex items-center justify-center mb-4 mx-auto">
                        <span className="material-symbols-outlined text-2xl">lock_reset</span>
                    </div>
                    <h2 className="text-2xl font-bold text-[#1c1a0d] dark:text-white">Reset Password</h2>
                    <p className="text-sm text-gray-500 mt-2">Enter your new password below.</p>
                </div>

                {error && (
                    <div className="p-3 bg-red-50 text-red-600 rounded-xl text-sm mb-4 border border-red-200">
                        {error}
                    </div>
                )}

                {message && (
                    <div className="p-3 bg-green-50 text-green-600 rounded-xl text-sm mb-4 border border-green-200">
                        {message}
                    </div>
                )}

                <form onSubmit={handleUpdatePassword} className="space-y-4">
                    <div className="space-y-1.5">
                        <label className="block text-sm font-semibold ml-1">New Password</label>
                        <input
                            type="password"
                            value={password}
                            onChange={(e) => setPassword(e.target.value)}
                            className="block w-full rounded-xl border-neutral-200 bg-white px-4 py-3 placeholder-neutral-400 focus:border-primary focus:ring-4 focus:ring-primary/10 outline-none transition-all dark:bg-black/20 dark:border-neutral-700"
                            placeholder="Enter new password"
                            required
                        />
                    </div>
                    <div className="space-y-1.5">
                        <label className="block text-sm font-semibold ml-1">Confirm Password</label>
                        <input
                            type="password"
                            value={confirmPassword}
                            onChange={(e) => setConfirmPassword(e.target.value)}
                            className="block w-full rounded-xl border-neutral-200 bg-white px-4 py-3 placeholder-neutral-400 focus:border-primary focus:ring-4 focus:ring-primary/10 outline-none transition-all dark:bg-black/20 dark:border-neutral-700"
                            placeholder="Confirm new password"
                            required
                        />
                    </div>

                    <button
                        type="submit"
                        disabled={isLoading}
                        className="w-full rounded-xl bg-primary px-5 py-3.5 text-base font-bold text-[#1c1a0d] hover:brightness-105 active:scale-[0.99] transition-all disabled:opacity-70"
                    >
                        {isLoading ? 'Updating...' : 'Update Password'}
                    </button>
                </form>
            </div>
        </div>
    );
};
