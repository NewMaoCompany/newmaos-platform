import React, { useState } from 'react';
import { Navbar } from '../components/Navbar';
import { useNavigate, Link } from 'react-router-dom';
import { useApp } from '../AppContext';
import { authApi } from '../src/services/api';

const SimpleLayout = ({ title, children, showNavbar = true }: { title: string, children: React.ReactNode, showNavbar?: boolean }) => {
    const navigate = useNavigate();
    return (
        <div className="min-h-screen bg-background-light dark:bg-background-dark text-text-main dark:text-gray-100 flex flex-col">
            {showNavbar && <Navbar />}
            <div className="flex-grow max-w-4xl mx-auto px-6 py-10 w-full animate-fade-in">
                {showNavbar && (
                    <button
                        onClick={() => navigate(-1)}
                        className="flex items-center gap-2 text-sm font-bold text-gray-500 hover:text-text-main dark:text-gray-400 dark:hover:text-white transition-colors mb-6"
                    >
                        <span className="material-symbols-outlined">arrow_back</span>
                        Back
                    </button>
                )}
                <h1 className="text-4xl font-black mb-8">{title}</h1>
                <div className="prose dark:prose-invert max-w-none text-text-secondary dark:text-gray-300">
                    {children}
                </div>
            </div>
        </div>
    );
};

export const Privacy = () => (
    <SimpleLayout title="Privacy Policy">
        <div className="space-y-8">
            <section>
                <h2 className="text-2xl font-bold text-text-main dark:text-white mb-3">1. Introduction</h2>
                <p>Welcome to NewMaoS ("we," "our," or "us"). We are committed to protecting your privacy. This Privacy Policy explains how we collect, use, disclose, and safeguard your information when you visit our application.</p>
            </section>
            <section>
                <h2 className="text-2xl font-bold text-text-main dark:text-white mb-3">2. Data Collection</h2>
                <p>We may collect information about you in a variety of ways. The information we may collect via the Application depends on the content and materials you use, and includes: Personal Data and Usage Data.</p>
            </section>
        </div>
    </SimpleLayout>
);

export const Terms = () => (
    <SimpleLayout title="Terms of Service">
        <div className="space-y-8">
            <section>
                <h2 className="text-2xl font-bold text-text-main dark:text-white mb-3">1. Agreement to Terms</h2>
                <p>These Terms of Use constitute a legally binding agreement made between you, whether personally or on behalf of an entity (“you”) and NewMaoS (“we,” “us” or “our”), concerning your access to and use of the NewMaoS application.</p>
            </section>
            <section>
                <h2 className="text-2xl font-bold text-text-main dark:text-white mb-3">2. Intellectual Property Rights</h2>
                <p>Unless otherwise indicated, the Site is our proprietary property and all source code, databases, functionality, software, website designs, audio, video, text, photographs, and graphics on the Site (collectively, the “Content”) and the trademarks, service marks, and logos contained therein (the “Marks”) are owned or controlled by us or licensed to us.</p>
            </section>
        </div>
    </SimpleLayout>
);

export const Support = () => (
    <SimpleLayout title="Support Center">
        <div className="space-y-8">
            <p className="text-lg">Need help? Our support team is available 24/7 to assist you with any issues related to your AP Calculus prep.</p>

            <div className="grid grid-cols-1 md:grid-cols-2 gap-6 mt-8 not-prose">
                <div className="bg-surface-light dark:bg-surface-dark p-6 rounded-2xl border border-gray-200 dark:border-gray-800">
                    <span className="material-symbols-outlined text-4xl text-primary mb-4">mail</span>
                    <h3 className="text-xl font-bold mb-2">Email Us</h3>
                    <p className="text-gray-500 mb-4">Send us a detailed message and we'll get back to you within 24 hours.</p>
                    <a href="mailto:support@newmaos.com" className="text-primary font-bold hover:underline">support@newmaos.com</a>
                </div>
                <div className="bg-surface-light dark:bg-surface-dark p-6 rounded-2xl border border-gray-200 dark:border-gray-800">
                    <span className="material-symbols-outlined text-4xl text-primary mb-4">chat</span>
                    <h3 className="text-xl font-bold mb-2">Live Chat</h3>
                    <p className="text-gray-500 mb-4">Chat with our AI assistant or a human agent for immediate help.</p>
                    <button className="text-primary font-bold hover:underline">Start Chat</button>
                </div>
            </div>

            <section className="mt-8">
                <h2 className="text-2xl font-bold text-text-main dark:text-white mb-3">Frequently Asked Questions</h2>
                <ul className="list-disc pl-5 space-y-2">
                    <li><strong>How do I reset my password?</strong> Go to the login page and click "Forgot Password".</li>
                    <li><strong>Can I switch between AB and BC?</strong> Yes, you can toggle courses in the Settings or Dashboard.</li>
                    <li><strong>Is my progress saved automatically?</strong> Yes, all practice sessions are auto-saved.</li>
                </ul>
            </section>
        </div>
    </SimpleLayout>
);

export const Signup = () => {
    const { login } = useApp();
    const navigate = useNavigate();
    const [name, setName] = useState('');
    const [email, setEmail] = useState('');
    const [password, setPassword] = useState('');
    const [isLoading, setIsLoading] = useState(false);
    // Verification state
    const [verificationCode, setVerificationCode] = useState(['', '', '', '', '', '']);
    const [step, setStep] = useState<'details' | 'verify' | 'success'>('details');
    const [error, setError] = useState('');

    const handleSignupSubmit = async (e: React.FormEvent) => {
        e.preventDefault();
        setIsLoading(true);
        setError('');

        try {
            // Call registration API
            const response = await authApi.register(email, password, name);
            // Always move to verify step for new registration flow
            setStep('verify');
        } catch (err: any) {
            setError(err.message || 'Registration failed. Please try again.');
        } finally {
            setIsLoading(false);
        }
    };

    const handleCodeChange = (index: number, value: string) => {
        if (value.length > 1) return; // Allow only 1 char
        const newCode = [...verificationCode];
        newCode[index] = value;
        setVerificationCode(newCode);

        // Auto-focus next input
        if (value && index < 5) {
            const nextInput = document.getElementById(`code-${index + 1}`);
            nextInput?.focus();
        }
    };

    const handleKeyDown = (index: number, e: React.KeyboardEvent) => {
        if (e.key === 'Backspace' && !verificationCode[index] && index > 0) {
            const prevInput = document.getElementById(`code-${index - 1}`);
            prevInput?.focus();
        }
    };

    const handleVerify = async (e: React.FormEvent) => {
        e.preventDefault();
        const code = verificationCode.join('');
        if (code.length !== 6) {
            setError('Please enter the complete 6-digit code');
            return;
        }

        setIsLoading(true);
        setError('');

        try {
            await authApi.verifyEmail(email, code);

            // After verification, we need to login to get the session
            // Since backend verify doesn't return session, we do a silent login
            // OR we ask user to login. 
            // Let's try auto-login if we have password in state (we do!)
            try {
                const loginRes = await authApi.login(email, password);
                if (loginRes.session) {
                    localStorage.setItem('auth_token', loginRes.session.access_token);
                    login(email, name);
                    navigate('/dashboard');
                } else {
                    navigate('/login');
                }
            } catch {
                // If auto-login fails, send to login page
                alert('Verification successful! Please sign in.');
                navigate('/login');
            }
        } catch (err: any) {
            setError(err.message || 'Verification failed. Please check the code.');
        } finally {
            setIsLoading(false);
        }
    };

    return (
        <div className="relative flex min-h-screen w-full flex-col items-center justify-center p-4 sm:p-6 lg:p-8 overflow-hidden bg-background-light dark:bg-background-dark">
            <div className="absolute inset-0 w-full h-full overflow-hidden pointer-events-none z-0">
                <div className="absolute -top-[10%] -left-[5%] w-[600px] h-[600px] rounded-full bg-primary/5 blur-[100px] dark:bg-primary/10"></div>
                <div className="absolute -bottom-[10%] -right-[5%] w-[500px] h-[500px] rounded-full bg-blue-200/20 blur-[100px] dark:bg-blue-900/10"></div>
            </div>

            <div className="relative z-10 w-full max-w-[420px] flex flex-col bg-surface-light dark:bg-surface-dark rounded-3xl shadow-soft border border-neutral-100 dark:border-neutral-800 p-8 sm:p-10 animate-fade-in-up">

                {step === 'details' && (
                    <>
                        <div className="flex flex-col items-center gap-3 mb-8 text-center">
                            <div className="flex items-center justify-center w-12 h-12 rounded-xl bg-primary/20 text-yellow-700 dark:text-primary mb-2">
                                <span className="material-symbols-outlined text-[24px]">person_add</span>
                            </div>
                            <div className="flex flex-col gap-1">
                                <h1 className="text-2xl font-bold tracking-tight text-[#1c1a0d] dark:text-white">Create Account</h1>
                                <p className="text-sm font-medium text-neutral-500 dark:text-neutral-400">Join NewMaoS to start learning</p>
                            </div>
                        </div>

                        {error && (
                            <div className="p-3 bg-red-50 dark:bg-red-900/20 border border-red-200 dark:border-red-800 rounded-xl text-sm text-red-600 dark:text-red-400 mb-4">
                                {error}
                            </div>
                        )}

                        <form className="flex flex-col gap-5 w-full" onSubmit={handleSignupSubmit}>
                            <div className="space-y-1.5">
                                <label className="block text-sm font-semibold text-[#1c1a0d] dark:text-neutral-200 ml-1" htmlFor="name">
                                    Username
                                </label>
                                <input
                                    id="name"
                                    type="text"
                                    value={name}
                                    onChange={(e) => setName(e.target.value)}
                                    placeholder="math_master99"
                                    className="block w-full rounded-xl border-neutral-200 bg-white px-4 py-3.5 text-base text-[#1c1a0d] placeholder:text-neutral-400 focus:border-primary focus:ring-4 focus:ring-primary/10 outline-none transition-all duration-200 dark:bg-black/20 dark:border-neutral-700 dark:text-white dark:focus:border-primary"
                                    required
                                />
                            </div>

                            <div className="space-y-1.5">
                                <label className="block text-sm font-semibold text-[#1c1a0d] dark:text-neutral-200 ml-1" htmlFor="email">
                                    Email Address
                                </label>
                                <input
                                    id="email"
                                    type="email"
                                    value={email}
                                    onChange={(e) => setEmail(e.target.value)}
                                    placeholder="name@example.com"
                                    className="block w-full rounded-xl border-neutral-200 bg-white px-4 py-3.5 text-base text-[#1c1a0d] placeholder:text-neutral-400 focus:border-primary focus:ring-4 focus:ring-primary/10 outline-none transition-all duration-200 dark:bg-black/20 dark:border-neutral-700 dark:text-white dark:focus:border-primary"
                                    required
                                />
                            </div>

                            <div className="space-y-1.5">
                                <label className="block text-sm font-semibold text-[#1c1a0d] dark:text-neutral-200 ml-1" htmlFor="password">
                                    Password
                                </label>
                                <input
                                    id="password"
                                    type="password"
                                    value={password}
                                    onChange={(e) => setPassword(e.target.value)}
                                    placeholder="Create a password"
                                    className="block w-full rounded-xl border-neutral-200 bg-white px-4 py-3.5 text-base text-[#1c1a0d] placeholder:text-neutral-400 focus:border-primary focus:ring-4 focus:ring-primary/10 outline-none transition-all duration-200 dark:bg-black/20 dark:border-neutral-700 dark:text-white dark:focus:border-primary"
                                    required
                                />
                            </div>

                            <div className="pt-2">
                                <button
                                    type="submit"
                                    disabled={isLoading}
                                    className="relative w-full overflow-hidden rounded-xl bg-black dark:bg-white px-5 py-3.5 text-base font-bold text-white dark:text-black shadow-sm transition-all duration-200 hover:opacity-90 hover:shadow-md hover:-translate-y-0.5 active:translate-y-0 active:scale-[0.99] focus:outline-none disabled:opacity-70 disabled:cursor-not-allowed flex justify-center items-center gap-2"
                                >
                                    {isLoading ? (
                                        <>
                                            <span className="material-symbols-outlined animate-spin text-sm">progress_activity</span>
                                            Sending Code...
                                        </>
                                    ) : "Verify Email"}
                                </button>
                            </div>
                        </form>

                        <div className="mt-8 flex flex-col items-center gap-4">
                            <div className="flex items-center justify-center gap-1.5 text-sm text-neutral-500 dark:text-neutral-400">
                                <span>Already have an account?</span>
                                <Link to="/login" className="font-bold text-[#1c1a0d] dark:text-primary hover:underline underline-offset-4 decoration-2 decoration-primary/50 transition-all">Sign In</Link>
                            </div>
                        </div>
                    </>
                )}

                {step === 'verify' && (
                    <div className="animate-fade-in text-center">
                        <div className="w-20 h-20 bg-green-100 dark:bg-green-900/30 rounded-full flex items-center justify-center mb-6 mx-auto">
                            <span className="material-symbols-outlined text-5xl text-green-600 dark:text-green-400">
                                mark_email_read
                            </span>
                        </div>

                        <h2 className="text-2xl font-black text-[#1c1a0d] dark:text-white mb-3">Check Your Email!</h2>
                        <p className="text-gray-500 dark:text-gray-400 mb-2">
                            We've sent a verification link to:
                        </p>
                        <p className="text-lg font-bold text-text-main dark:text-white mb-6">
                            {email}
                        </p>

                        <div className="bg-gray-50 dark:bg-white/5 rounded-xl p-4 mb-6">
                            <p className="text-sm text-gray-500 dark:text-gray-400">
                                Click the button in the email to verify your account and get started with NewMaoS.
                            </p>
                        </div>

                        <div className="flex flex-col gap-3">
                            <button
                                type="button"
                                onClick={async () => {
                                    setIsLoading(true);
                                    try {
                                        await authApi.resendVerification(email);
                                        alert('New verification email sent!');
                                    } catch (err: any) {
                                        setError(err.message || 'Failed to resend email.');
                                    } finally {
                                        setIsLoading(false);
                                    }
                                }}
                                disabled={isLoading}
                                className="w-full rounded-xl bg-white dark:bg-white/5 border border-gray-200 dark:border-gray-700 px-5 py-3.5 text-base font-bold text-text-main dark:text-white hover:bg-gray-50 dark:hover:bg-white/10 transition-all flex justify-center items-center gap-2"
                            >
                                {isLoading ? (
                                    <>
                                        <span className="material-symbols-outlined animate-spin text-sm">progress_activity</span>
                                        Sending...
                                    </>
                                ) : (
                                    <>
                                        <span className="material-symbols-outlined text-sm">refresh</span>
                                        Resend Email
                                    </>
                                )}
                            </button>

                            <button
                                type="button"
                                onClick={() => setStep('details')}
                                className="text-sm text-gray-500 hover:text-text-main dark:hover:text-white transition-colors"
                            >
                                ← Use a different email
                            </button>
                        </div>
                    </div>
                )}

            </div>

            <footer className="mt-12 text-center relative z-10">
                <p className="text-xs font-medium text-neutral-400 dark:text-neutral-600">
                    © 2026 NewMaoS. Designed for Excellence.
                </p>
            </footer>
        </div>
    );
};