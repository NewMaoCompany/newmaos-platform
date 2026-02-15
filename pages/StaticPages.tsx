import React, { useState, useEffect } from 'react';
import { Navbar } from '../components/Navbar';
import { useNavigate, Link, useSearchParams } from 'react-router-dom';
import { useApp } from '../AppContext';
import { authApi } from '../src/services/api';
import { supabase } from '../src/services/supabaseClient';

const SimpleLayout = ({ title, children, showNavbar = true }: { title: string, children: React.ReactNode, showNavbar?: boolean }) => {
    const navigate = useNavigate();

    // Scroll to top when page loads
    useEffect(() => {
        window.scrollTo(0, 0);
    }, []);

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
            <p className="text-sm text-gray-500">Last Updated: January 16, 2026</p>

            <section>
                <h2 className="text-2xl font-bold text-text-main dark:text-white mb-3">1. Introduction</h2>
                <p>NewMaoS Learning, Inc. ("NewMaoS," "we," "our," or "us") is committed to protecting your privacy. This Privacy Policy explains how we collect, use, disclose, and safeguard your information when you use our AP Calculus learning platform at newmaos.com (the "Service"). Please read this policy carefully. By using our Service, you consent to the data practices described in this policy.</p>
            </section>

            <section>
                <h2 className="text-2xl font-bold text-text-main dark:text-white mb-3">2. Information We Collect</h2>
                <h3 className="text-lg font-semibold mt-4 mb-2">2.1 Personal Information</h3>
                <p>When you create an account, we collect:</p>
                <ul className="list-disc pl-5 mt-2 space-y-1">
                    <li>Name or username</li>
                    <li>Email address</li>
                    <li>Password (encrypted)</li>
                    <li>Course preferences (AP Calculus AB/BC)</li>
                </ul>

                <h3 className="text-lg font-semibold mt-4 mb-2">2.2 Usage Data</h3>
                <p>We automatically collect information about how you interact with our Service:</p>
                <ul className="list-disc pl-5 mt-2 space-y-1">
                    <li>Practice session data and performance metrics</li>
                    <li>Learning progress and unit mastery scores</li>
                    <li>Time spent on the platform</li>
                    <li>Device information and browser type</li>
                    <li>IP address and approximate location</li>
                </ul>
            </section>

            <section>
                <h2 className="text-2xl font-bold text-text-main dark:text-white mb-3">3. How We Use Your Information</h2>
                <p>We use the information we collect to:</p>
                <ul className="list-disc pl-5 mt-2 space-y-1">
                    <li>Provide, maintain, and improve our educational services</li>
                    <li>Personalize your learning experience and recommend content</li>
                    <li>Track your progress and generate performance analytics</li>
                    <li>Communicate with you about updates, features, and support</li>
                    <li>Ensure account security and prevent fraud</li>
                    <li>Comply with legal obligations</li>
                </ul>
            </section>

            <section>
                <h2 className="text-2xl font-bold text-text-main dark:text-white mb-3">4. Cookies and Tracking Technologies</h2>
                <p>We use cookies and similar technologies to enhance your experience. These include:</p>
                <ul className="list-disc pl-5 mt-2 space-y-1">
                    <li><strong>Essential Cookies:</strong> Required for the Service to function properly</li>
                    <li><strong>Analytics Cookies:</strong> Help us understand how users interact with our platform</li>
                    <li><strong>Preference Cookies:</strong> Remember your settings and preferences</li>
                </ul>
                <p className="mt-2">You can control cookies through your browser settings, but disabling them may affect Service functionality.</p>
            </section>

            <section>
                <h2 className="text-2xl font-bold text-text-main dark:text-white mb-3">5. Data Sharing and Disclosure</h2>
                <p>We do not sell your personal information. We may share your data with:</p>
                <ul className="list-disc pl-5 mt-2 space-y-1">
                    <li><strong>Service Providers:</strong> Third parties that help us operate our platform (e.g., hosting, analytics)</li>
                    <li><strong>Legal Requirements:</strong> When required by law or to protect our rights</li>
                    <li><strong>Business Transfers:</strong> In connection with a merger, acquisition, or sale of assets</li>
                </ul>
            </section>

            <section>
                <h2 className="text-2xl font-bold text-text-main dark:text-white mb-3">6. Children's Privacy</h2>
                <p>Our Service is designed for students preparing for AP Calculus exams, who may include minors. We comply with the Children's Online Privacy Protection Act (COPPA). If you are under 13, you must have parental consent to use our Service. Parents may contact us at privacy@newmaos.com to review, delete, or manage their child's information.</p>
            </section>

            <section>
                <h2 className="text-2xl font-bold text-text-main dark:text-white mb-3">7. Data Security</h2>
                <p>We implement industry-standard security measures to protect your information, including encryption, secure servers, and regular security audits. However, no method of transmission over the Internet is 100% secure, and we cannot guarantee absolute security.</p>
            </section>

            <section>
                <h2 className="text-2xl font-bold text-text-main dark:text-white mb-3">8. Your Rights</h2>
                <p>Depending on your location, you may have the right to:</p>
                <ul className="list-disc pl-5 mt-2 space-y-1">
                    <li>Access and receive a copy of your personal data</li>
                    <li>Correct inaccurate or incomplete information</li>
                    <li>Delete your account and associated data</li>
                    <li>Opt out of marketing communications</li>
                    <li>Data portability (receive your data in a structured format)</li>
                </ul>
                <p className="mt-2">To exercise these rights, contact us at privacy@newmaos.com.</p>
            </section>

            <section>
                <h2 className="text-2xl font-bold text-text-main dark:text-white mb-3">9. Changes to This Policy</h2>
                <p>We may update this Privacy Policy from time to time. We will notify you of any material changes by posting the new policy on this page and updating the "Last Updated" date. Your continued use of the Service after changes constitutes acceptance of the revised policy.</p>
            </section>

            <section>
                <h2 className="text-2xl font-bold text-text-main dark:text-white mb-3">10. Contact Us</h2>
                <p>If you have questions about this Privacy Policy, please contact us:</p>
                <ul className="list-none mt-2 space-y-1">
                    <li><strong>Email:</strong> privacy@newmaos.com</li>
                    <li><strong>Website:</strong> newmaos.com/support</li>
                </ul>
            </section>
        </div>
    </SimpleLayout>
);

export const Terms = () => (
    <SimpleLayout title="Terms of Service">
        <div className="space-y-8">
            <p className="text-sm text-gray-500">Last Updated: January 16, 2026</p>
            <section>
                <h2 className="text-2xl font-bold text-text-main dark:text-white mb-3">1. Agreement to Terms</h2>
                <p>These Terms of Service constitute a legally binding agreement between you and NewMaoS Learning, Inc. By using our AP Calculus learning platform at newmaos.com, you agree to be bound by these Terms.</p>
            </section>
            <section>
                <h2 className="text-2xl font-bold text-text-main dark:text-white mb-3">2. Eligibility</h2>
                <p>You must be at least 13 years old to use this Service. If you are under 18, you represent that you have parental consent.</p>
            </section>
            <section>
                <h2 className="text-2xl font-bold text-text-main dark:text-white mb-3">3. Account Registration</h2>
                <p>You agree to provide accurate information, maintain account security, and accept responsibility for all activities under your account.</p>
            </section>
            <section>
                <h2 className="text-2xl font-bold text-text-main dark:text-white mb-3">4. Intellectual Property</h2>
                <p>The Service and all its contents are owned by NewMaoS and protected by copyright laws. You are granted a limited license for personal, non-commercial educational use only.</p>
            </section>
            <section>
                <h2 className="text-2xl font-bold text-text-main dark:text-white mb-3">5. Prohibited Activities</h2>
                <p>You may not: copy or distribute the Service; reverse engineer the software; share credentials; use bots or scrapers; disrupt the Service; upload malware; harass users; or use the Service to cheat on exams.</p>
            </section>
            <section>
                <h2 className="text-2xl font-bold text-text-main dark:text-white mb-3">6. Disclaimer of Warranties</h2>
                <p className="uppercase text-sm">THE SERVICE IS PROVIDED AS IS WITHOUT WARRANTIES. WE DO NOT GUARANTEE ANY SPECIFIC EXAM SCORES OR ACADEMIC OUTCOMES.</p>
            </section>
            <section>
                <h2 className="text-2xl font-bold text-text-main dark:text-white mb-3">7. Limitation of Liability</h2>
                <p className="uppercase text-sm">NEWMAOS SHALL NOT BE LIABLE FOR ANY INDIRECT OR CONSEQUENTIAL DAMAGES ARISING FROM YOUR USE OF THE SERVICE.</p>
            </section>
            <section>
                <h2 className="text-2xl font-bold text-text-main dark:text-white mb-3">8. Termination</h2>
                <p>We may terminate your account at any time for breach of these Terms. You may delete your account through Settings.</p>
            </section>
            <section>
                <h2 className="text-2xl font-bold text-text-main dark:text-white mb-3">9. Governing Law</h2>
                <p>These Terms are governed by the laws of the State of Delaware, United States.</p>
            </section>
            <section>
                <h2 className="text-2xl font-bold text-text-main dark:text-white mb-3">10. Contact Us</h2>
                <p>Questions? Contact us at legal@newmaos.com</p>
            </section>
        </div>
    </SimpleLayout>
);

export const Support = () => (
    <SimpleLayout title="Support Center">
        <div className="space-y-8">
            <p className="text-lg">Need help? Our support team is here to assist you with any questions about your AP Calculus learning journey.</p>

            <div className="grid grid-cols-1 md:grid-cols-3 gap-6 mt-8 not-prose">
                <div className="bg-surface-light dark:bg-surface-dark p-6 rounded-2xl border border-gray-200 dark:border-gray-800">
                    <span className="material-symbols-outlined text-4xl text-primary mb-4">mail</span>
                    <h3 className="text-xl font-bold mb-2">Email Support</h3>
                    <p className="text-gray-500 mb-4">Send us a detailed message and we'll respond within 24 hours.</p>
                    <a href="mailto:support@newmaos.com" className="text-primary font-bold hover:underline">support@newmaos.com</a>
                </div>
                <div className="bg-surface-light dark:bg-surface-dark p-6 rounded-2xl border border-gray-200 dark:border-gray-800">
                    <span className="material-symbols-outlined text-4xl text-primary mb-4">bug_report</span>
                    <h3 className="text-xl font-bold mb-2">Report a Bug</h3>
                    <p className="text-gray-500 mb-4">Found an issue? Help us improve by reporting it.</p>
                    <a href="mailto:bugs@newmaos.com" className="text-primary font-bold hover:underline">bugs@newmaos.com</a>
                </div>
                <div className="bg-surface-light dark:bg-surface-dark p-6 rounded-2xl border border-gray-200 dark:border-gray-800">
                    <span className="material-symbols-outlined text-4xl text-primary mb-4">lightbulb</span>
                    <h3 className="text-xl font-bold mb-2">Feature Requests</h3>
                    <p className="text-gray-500 mb-4">Have an idea to make NewMaoS better?</p>
                    <a href="mailto:feedback@newmaos.com" className="text-primary font-bold hover:underline">feedback@newmaos.com</a>
                </div>
            </div>

            <section className="mt-8">
                <h2 className="text-2xl font-bold text-text-main dark:text-white mb-6">Frequently Asked Questions</h2>
                <div className="space-y-6">
                    <div className="border-b border-gray-200 dark:border-gray-700 pb-4">
                        <h3 className="font-bold text-lg mb-2">How do I reset my password?</h3>
                        <p className="text-gray-500">Go to the login page and click "Forgot Password." Enter your email address and we'll send you a link to reset your password.</p>
                    </div>
                    <div className="border-b border-gray-200 dark:border-gray-700 pb-4">
                        <h3 className="font-bold text-lg mb-2">Can I switch between AP Calculus AB and BC?</h3>
                        <p className="text-gray-500">Yes! You can toggle between courses anytime in the Settings page or from your Dashboard. Your progress is saved separately for each course.</p>
                    </div>
                    <div className="border-b border-gray-200 dark:border-gray-700 pb-4">
                        <h3 className="font-bold text-lg mb-2">Is my progress saved automatically?</h3>
                        <p className="text-gray-500">Yes, all your practice sessions, scores, and progress are automatically saved to your account. You can pick up right where you left off on any device.</p>
                    </div>
                    <div className="border-b border-gray-200 dark:border-gray-700 pb-4">
                        <h3 className="font-bold text-lg mb-2">How is my mastery score calculated?</h3>
                        <p className="text-gray-500">Your mastery score is based on your accuracy and consistency across practice problems in each unit. The more you practice correctly, the higher your mastery.</p>
                    </div>
                    <div className="border-b border-gray-200 dark:border-gray-700 pb-4">
                        <h3 className="font-bold text-lg mb-2">Can I delete my account?</h3>
                        <p className="text-gray-500">Yes, you can delete your account from the Settings page. Please note that this action is permanent and all your data will be removed.</p>
                    </div>
                    <div className="border-b border-gray-200 dark:border-gray-700 pb-4">
                        <h3 className="font-bold text-lg mb-2">Is NewMaoS free to use?</h3>
                        <p className="text-gray-500">Yes, NewMaoS is currently free for all students. We believe quality AP Calculus prep should be accessible to everyone.</p>
                    </div>
                    <div className="pb-4">
                        <h3 className="font-bold text-lg mb-2">What browsers are supported?</h3>
                        <p className="text-gray-500">NewMaoS works best on modern browsers including Chrome, Firefox, Safari, and Edge. For the best experience, keep your browser updated to the latest version.</p>
                    </div>
                </div>
            </section>

            <section className="mt-8 p-6 bg-primary/10 rounded-2xl">
                <h2 className="text-xl font-bold text-text-main dark:text-white mb-2">Still need help?</h2>
                <p className="text-gray-600 dark:text-gray-300 mb-4">Our team typically responds within 24 hours on business days.</p>
                <a href="mailto:support@newmaos.com" className="inline-flex items-center gap-2 bg-primary text-black font-bold px-6 py-3 rounded-xl hover:opacity-90 transition-opacity">
                    <span className="material-symbols-outlined">send</span>
                    Contact Support
                </a>
            </section>
        </div>
    </SimpleLayout>
);

export const Signup = () => {
    const { login } = useApp();
    const navigate = useNavigate();
    const [searchParams] = useSearchParams();
    const [name, setName] = useState('');
    const [email, setEmail] = useState('');
    const [password, setPassword] = useState('');
    const [isLoading, setIsLoading] = useState(false);
    // Referral code from URL param
    const refCode = searchParams.get('ref') || '';
    // Verification state
    const [verificationCode, setVerificationCode] = useState(['', '', '', '', '', '']);
    const [step, setStep] = useState<'details' | 'verify' | 'success'>('details');
    const [error, setError] = useState('');

    // Inline toast state (standalone page, not wrapped in ToastProvider)
    const [toast, setToast] = useState<{ message: string; type: 'success' | 'error' | 'info' } | null>(null);
    const showInlineToast = (message: string, type: 'success' | 'error' | 'info' = 'info') => {
        setToast({ message, type });
        setTimeout(() => setToast(null), 4000);
    };

    // Password validation
    const passwordChecks = {
        minLength: password.length >= 8,
        hasUppercase: /[A-Z]/.test(password),
        hasLowercase: /[a-z]/.test(password),
        hasNumber: /[0-9]/.test(password)
    };
    const isPasswordValid = Object.values(passwordChecks).every(Boolean);

    // Username validation (basic profanity filter)
    const profanityList = ['fuck', 'shit', 'ass', 'damn', 'bitch', 'crap', 'dick', 'pussy', 'cock', 'cunt'];
    const isUsernameClean = !profanityList.some(word => name.toLowerCase().includes(word));
    const isUsernameValid = name.length >= 2 && name.length <= 20 && /^[a-zA-Z0-9_]+$/.test(name) && isUsernameClean;

    const usernameChecks = {
        validLength: name.length >= 2 && name.length <= 20,
        validChars: /^[a-zA-Z0-9_]*$/.test(name) || name.length === 0,
        noProf: isUsernameClean
    };

    const canSubmit = isPasswordValid && isUsernameValid && email.includes('@');

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
                    await supabase.auth.setSession(loginRes.session);
                    localStorage.setItem('auth_token', loginRes.session.access_token);

                    // Process referral if ref code exists
                    if (refCode) {
                        try {
                            const { data: refResult, error: refError } = await supabase.rpc('process_referral', {
                                p_referral_code: refCode
                            });
                            if (refError) {
                                console.error('Referral RPC error:', refError);
                            } else {
                                console.log('Referral result:', refResult);
                            }
                        } catch (refErr) {
                            console.error('Referral processing error:', refErr);
                        }
                    }

                    login(email, name, loginRes.session.user.id);
                    navigate('/dashboard');
                } else {
                    navigate('/login');
                }
            } catch {
                // If auto-login fails, send to login page
                showInlineToast('Verification successful! Redirecting to sign in...', 'success');
                setTimeout(() => navigate('/login'), 1500);
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
                                <div className="relative group">
                                    <input
                                        id="name"
                                        type="text"
                                        value={name}
                                        onChange={(e) => setName(e.target.value)}
                                        placeholder="math_master99"
                                        className="block w-full rounded-xl border-neutral-200 bg-white pl-11 pr-4 py-3.5 text-base text-[#1c1a0d] placeholder:text-neutral-400 focus:border-primary focus:ring-4 focus:ring-primary/10 outline-none transition-all duration-200 dark:bg-black/20 dark:border-neutral-700 dark:text-white dark:focus:border-primary"
                                        required
                                    />
                                    <div className="absolute left-4 top-1/2 -translate-y-1/2 text-neutral-400 pointer-events-none transition-colors group-focus-within:text-primary">
                                        <span className="material-symbols-outlined text-[20px]">badge</span>
                                    </div>
                                </div>
                                {name.length > 0 && (
                                    <div className="mt-2 space-y-1 text-xs">
                                        <div className={`flex items-center gap-1.5 ${usernameChecks.validLength ? 'text-green-600' : 'text-gray-400'}`}>
                                            <span className="material-symbols-outlined text-sm">{usernameChecks.validLength ? 'check_circle' : 'circle'}</span>
                                            2-20 characters
                                        </div>
                                        <div className={`flex items-center gap-1.5 ${usernameChecks.validChars ? 'text-green-600' : 'text-red-500'}`}>
                                            <span className="material-symbols-outlined text-sm">{usernameChecks.validChars ? 'check_circle' : 'cancel'}</span>
                                            Letters, numbers, underscore only
                                        </div>
                                        <div className={`flex items-center gap-1.5 ${usernameChecks.noProf ? 'text-green-600' : 'text-red-500'}`}>
                                            <span className="material-symbols-outlined text-sm">{usernameChecks.noProf ? 'check_circle' : 'cancel'}</span>
                                            Appropriate language
                                        </div>
                                    </div>
                                )}
                            </div>

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
                                        placeholder="name@example.com"
                                        className="block w-full rounded-xl border-neutral-200 bg-white pl-11 pr-4 py-3.5 text-base text-[#1c1a0d] placeholder:text-neutral-400 focus:border-primary focus:ring-4 focus:ring-primary/10 outline-none transition-all duration-200 dark:bg-black/20 dark:border-neutral-700 dark:text-white dark:focus:border-primary"
                                        required
                                    />
                                    <div className="absolute left-4 top-1/2 -translate-y-1/2 text-neutral-400 pointer-events-none transition-colors group-focus-within:text-primary">
                                        <span className="material-symbols-outlined text-[20px]">mail</span>
                                    </div>
                                </div>
                            </div>

                            <div className="space-y-1.5">
                                <label className="block text-sm font-semibold text-[#1c1a0d] dark:text-neutral-200 ml-1" htmlFor="password">
                                    Password
                                </label>
                                <div className="relative group">
                                    <input
                                        id="password"
                                        type="password"
                                        value={password}
                                        onChange={(e) => setPassword(e.target.value)}
                                        placeholder="Create a password"
                                        className="block w-full rounded-xl border-neutral-200 bg-white pl-11 pr-4 py-3.5 text-base text-[#1c1a0d] placeholder:text-neutral-400 focus:border-primary focus:ring-4 focus:ring-primary/10 outline-none transition-all duration-200 dark:bg-black/20 dark:border-neutral-700 dark:text-white dark:focus:border-primary"
                                        required
                                    />
                                    <div className="absolute left-4 top-1/2 -translate-y-1/2 text-neutral-400 pointer-events-none transition-colors group-focus-within:text-primary">
                                        <span className="material-symbols-outlined text-[20px]">lock</span>
                                    </div>
                                </div>
                                {password.length > 0 && (
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

                            <div className="pt-2">
                                <button
                                    type="submit"
                                    disabled={isLoading || !canSubmit}
                                    className="relative w-full overflow-hidden rounded-xl bg-black dark:bg-white px-5 py-3.5 text-base font-bold text-white dark:text-black shadow-sm transition-all duration-200 hover:opacity-90 hover:shadow-md hover:-translate-y-0.5 active:translate-y-0 active:scale-[0.99] focus:outline-none disabled:opacity-50 disabled:cursor-not-allowed flex justify-center items-center gap-2"
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
                            <button
                                type="button"
                                onClick={() => navigate('/dashboard')}
                                className="text-xs text-gray-400 hover:text-gray-600 dark:hover:text-gray-300 transition-colors"
                            >
                                Create Account Later →
                            </button>
                        </div>
                    </>
                )}

                {step === 'verify' && (
                    <div className="animate-fade-in text-center">
                        <button
                            onClick={() => setStep('details')}
                            className="absolute top-6 left-6 flex items-center gap-1 text-xs font-bold text-gray-500 hover:text-black dark:hover:text-white transition-colors"
                        >
                            <span className="material-symbols-outlined text-sm">arrow_back</span>
                            Back
                        </button>

                        <div className="w-16 h-16 bg-primary/10 text-primary rounded-2xl flex items-center justify-center mb-6 mx-auto mt-4">
                            <span className="material-symbols-outlined text-3xl">lock</span>
                        </div>

                        <h2 className="text-xl font-black text-[#1c1a0d] dark:text-white mb-2">Enter Verification Code</h2>
                        <p className="text-sm text-gray-500 mb-2">
                            We've sent a 6-digit code to <span className="font-bold text-text-main dark:text-white">{email}</span>
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

                        <form onSubmit={handleVerify}>
                            <div className="flex justify-center gap-2 mb-8">
                                {verificationCode.map((digit, index) => (
                                    <input
                                        key={index}
                                        id={`code-${index}`}
                                        type="text"
                                        maxLength={1}
                                        value={digit}
                                        onChange={(e) => handleCodeChange(index, e.target.value)}
                                        onKeyDown={(e) => handleKeyDown(index, e)}
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
                                        "Verify Account"
                                    )}
                                </button>

                                <button
                                    type="button"
                                    onClick={async () => {
                                        setIsLoading(true);
                                        try {
                                            await authApi.resendVerification(email);
                                            showInlineToast('New verification code sent!', 'success');
                                        } catch (err: any) {
                                            setError(err.message || 'Failed to resend code.');
                                        } finally {
                                            setIsLoading(false);
                                        }
                                    }}
                                    disabled={isLoading}
                                    className="w-full rounded-xl bg-white dark:bg-white/5 border border-gray-200 dark:border-gray-700 px-5 py-3.5 text-base font-bold text-text-main dark:text-white hover:bg-gray-50 dark:hover:bg-white/10 transition-all"
                                >
                                    Resend Code
                                </button>
                            </div>
                        </form>
                    </div>
                )}

            </div>

            {/* Inline Toast Notification */}
            {toast && (
                <div className="fixed top-4 left-4 z-[9999] animate-slide-in-left">
                    <div
                        className={`flex items-center gap-3 px-5 py-3.5 rounded-xl border-2 shadow-lg min-w-[280px] max-w-[400px] bg-white dark:bg-gray-900 ${toast.type === 'success' ? 'border-green-400' : toast.type === 'error' ? 'border-red-400' : 'border-blue-400'
                            }`}
                    >
                        <div className={`p-1.5 rounded-full ${toast.type === 'success' ? 'bg-green-100 dark:bg-green-900/40' : toast.type === 'error' ? 'bg-red-100 dark:bg-red-900/40' : 'bg-blue-100 dark:bg-blue-900/40'
                            }`}>
                            <span className={`material-symbols-outlined text-xl ${toast.type === 'success' ? 'text-green-500' : toast.type === 'error' ? 'text-red-500' : 'text-blue-500'
                                }`}>
                                {toast.type === 'success' ? 'check_circle' : toast.type === 'error' ? 'error' : 'info'}
                            </span>
                        </div>
                        <p className="flex-1 text-sm font-medium text-gray-800 dark:text-gray-200">{toast.message}</p>
                        <button
                            onClick={() => setToast(null)}
                            className="text-gray-400 hover:text-gray-600 dark:hover:text-gray-300 transition-colors"
                        >
                            <span className="material-symbols-outlined text-lg">close</span>
                        </button>
                    </div>
                </div>
            )}

            <footer className="mt-12 text-center relative z-10">
                <p className="text-xs font-medium text-neutral-400 dark:text-neutral-600">
                    © 2026 NewMaoS. Designed for Excellence.
                </p>
            </footer>
        </div>
    );
};