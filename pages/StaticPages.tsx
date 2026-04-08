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
            <p className="text-sm text-gray-500">Last Updated: March 31, 2026</p>

            <section>
                <h2 className="text-2xl font-bold text-text-main dark:text-white mb-3">1. Introduction</h2>
                <p>NewMaoS Learning, Inc. ("NewMaoS," "we," "our," or "us") is committed to protecting your privacy and the privacy of students who use our platform. This Privacy Policy explains how we collect, use, disclose, and safeguard your information when you use our AP Calculus learning platform at newmaos.com (the "Service"). Please read this policy carefully. By using our Service, you consent to the data practices described in this policy.</p>
                <p className="mt-2 font-semibold">This policy is designed to comply with the Family Educational Rights and Privacy Act (FERPA), the Children's Online Privacy Protection Act (COPPA), the Student Online Personal Protection Act (SOPPA), and applicable state student privacy laws.</p>
            </section>

            <section>
                <h2 className="text-2xl font-bold text-text-main dark:text-white mb-3">2. Information We Collect</h2>
                <h3 className="text-lg font-semibold mt-4 mb-2">2.1 Personal Information</h3>
                <p>When you create an account, we collect:</p>
                <ul className="list-disc pl-5 mt-2 space-y-1">
                    <li>Username (not required to be a real name)</li>
                    <li>Email address</li>
                    <li>Password (hashed and encrypted — we never store plain text passwords)</li>
                    <li>Course preferences (AP Calculus AB/BC)</li>
                </ul>

                <h3 className="text-lg font-semibold mt-4 mb-2">2.2 Education Records / Usage Data</h3>
                <p>We automatically collect information about how you interact with our Service to provide personalized learning:</p>
                <ul className="list-disc pl-5 mt-2 space-y-1">
                    <li>Practice session data and performance metrics</li>
                    <li>Learning progress, unit mastery scores, and error patterns</li>
                    <li>Time spent on the platform</li>
                </ul>
                <p className="mt-2 text-sm text-gray-500">We do <strong>NOT</strong> collect social security numbers, financial information, biometric data, geolocation, social media profiles, or any information not directly related to the educational purpose of the Service.</p>

                <h3 className="text-lg font-semibold mt-4 mb-2">2.3 Automatically Collected Information</h3>
                <ul className="list-disc pl-5 mt-2 space-y-1">
                    <li>Device type and browser type (for compatibility purposes only)</li>
                    <li>IP address (used solely for security and abuse prevention, not for tracking or profiling)</li>
                </ul>
            </section>

            <section>
                <h2 className="text-2xl font-bold text-text-main dark:text-white mb-3">3. How We Use Your Information</h2>
                <p>We use the information we collect <strong>strictly for educational purposes</strong>:</p>
                <ul className="list-disc pl-5 mt-2 space-y-1">
                    <li>Provide, maintain, and improve our educational services</li>
                    <li>Personalize your learning experience and recommend content</li>
                    <li>Track your progress and generate performance analytics</li>
                    <li>Communicate with you about account-related updates and support</li>
                    <li>Ensure account security and prevent fraud or abuse</li>
                    <li>Comply with legal obligations</li>
                </ul>
                <p className="mt-3 font-semibold text-text-main dark:text-white">We do NOT:</p>
                <ul className="list-disc pl-5 mt-1 space-y-1">
                    <li>Use student data for advertising or marketing purposes</li>
                    <li>Sell, rent, or trade any personal information or student data to any third party</li>
                    <li>Build non-educational profiles of students</li>
                    <li>Use student data for targeted advertising of any kind</li>
                </ul>
            </section>

            <section>
                <h2 className="text-2xl font-bold text-text-main dark:text-white mb-3">4. Cookies and Tracking Technologies</h2>
                <p>We use only essential cookies required for the Service to function properly:</p>
                <ul className="list-disc pl-5 mt-2 space-y-1">
                    <li><strong>Authentication Cookies:</strong> Required to maintain your logged-in session</li>
                    <li><strong>Preference Cookies:</strong> Remember your settings (dark mode, course selection)</li>
                </ul>
                <p className="mt-2">We do NOT use third-party advertising cookies, behavioral tracking pixels, or analytics services that profile individual users. We do NOT participate in any cross-site tracking.</p>
            </section>

            <section>
                <h2 className="text-2xl font-bold text-text-main dark:text-white mb-3">5. Data Sharing and Disclosure</h2>
                <p><strong>We do not sell, rent, or share your personal information with any third party for commercial purposes.</strong></p>
                <p className="mt-2">We may share data only in the following limited circumstances:</p>
                <ul className="list-disc pl-5 mt-2 space-y-1">
                    <li><strong>Infrastructure Providers:</strong> We use Supabase (database hosting) and Vercel (web hosting) to operate our platform. These providers process data on our behalf under strict data processing agreements and are prohibited from using student data for their own purposes.</li>
                    <li><strong>Legal Requirements:</strong> When required by law, subpoena, or court order</li>
                    <li><strong>Safety:</strong> When we believe disclosure is necessary to prevent harm to a user or others</li>
                </ul>
                <p className="mt-2">In the event of a merger, acquisition, or sale of assets, student data protections will continue to apply under identical terms, and users will be notified of any ownership change.</p>
            </section>

            <section>
                <h2 className="text-2xl font-bold text-text-main dark:text-white mb-3">6. FERPA Compliance (For Schools & Districts)</h2>
                <p>When NewMaoS is used by a school or school district, we act as a "school official" under FERPA, meaning we are under the direct control of the school with respect to the use and maintenance of education records. We commit to the following:</p>
                <ul className="list-disc pl-5 mt-2 space-y-1">
                    <li>Student education records are used solely for the educational purpose for which we were engaged</li>
                    <li>We do not re-disclose student education records to other parties without proper authorization</li>
                    <li>Schools maintain ownership and control of all student education records</li>
                    <li>Schools and eligible students may request access to, correction of, or deletion of student records at any time</li>
                    <li>We will cooperate with school investigations and audits regarding student data</li>
                    <li>Upon termination of our agreement with a school, we will delete or return all student records upon request</li>
                </ul>
                <p className="mt-2">School administrators may contact us at <strong>privacy@newmaos.com</strong> to sign a Data Privacy Agreement (DPA), request a data inventory, or exercise any rights under FERPA.</p>
            </section>

            <section>
                <h2 className="text-2xl font-bold text-text-main dark:text-white mb-3">7. Children's Privacy (COPPA Compliance)</h2>
                <p>Our Service is designed for students preparing for AP Calculus exams, typically ages 15–18. We recognize that some users may be under 13.</p>
                <ul className="list-disc pl-5 mt-2 space-y-1">
                    <li>Users under 13 must have verifiable parental consent before creating an account</li>
                    <li>We collect only the minimum information necessary for the Service to function</li>
                    <li>We do not condition participation on providing more information than is reasonably necessary</li>
                    <li>Parents may contact us at <strong>privacy@newmaos.com</strong> to review, delete, or manage their child's information at any time</li>
                    <li>Parents may refuse further data collection and request deletion of existing data</li>
                </ul>
            </section>

            <section>
                <h2 className="text-2xl font-bold text-text-main dark:text-white mb-3">8. Data Security</h2>
                <p>We implement industry-standard security measures to protect your information:</p>
                <ul className="list-disc pl-5 mt-2 space-y-1">
                    <li>All data is transmitted over encrypted connections (TLS/SSL)</li>
                    <li>Passwords are hashed using bcrypt and are never stored in plain text</li>
                    <li>Database access is restricted with row-level security policies</li>
                    <li>Regular security reviews and monitoring</li>
                    <li>Access to student data is limited to authorized personnel on a need-to-know basis</li>
                </ul>
                <p className="mt-2">In the event of a data breach affecting student records, we will notify affected schools, parents, and users within 72 hours, as required by applicable law.</p>
            </section>

            <section>
                <h2 className="text-2xl font-bold text-text-main dark:text-white mb-3">9. Data Retention and Deletion</h2>
                <ul className="list-disc pl-5 mt-2 space-y-1">
                    <li>Student data is retained only as long as the account is active and the educational relationship exists</li>
                    <li>Users may delete their account and all associated data at any time through Settings</li>
                    <li>Schools may request bulk deletion of student data upon termination of their use of the Service</li>
                    <li>Deleted data is permanently removed from our systems within 30 days</li>
                </ul>
            </section>

            <section>
                <h2 className="text-2xl font-bold text-text-main dark:text-white mb-3">10. Your Rights</h2>
                <p>Depending on your location and applicable law, you have the right to:</p>
                <ul className="list-disc pl-5 mt-2 space-y-1">
                    <li>Access and receive a copy of your personal data</li>
                    <li>Correct inaccurate or incomplete information</li>
                    <li>Delete your account and all associated data</li>
                    <li>Opt out of non-essential communications</li>
                    <li>Data portability (receive your data in a structured format)</li>
                    <li>Withdraw consent for optional data processing</li>
                </ul>
                <p className="mt-2">To exercise these rights, contact us at <strong>privacy@newmaos.com</strong>. We will respond to requests within 30 days.</p>
            </section>

            <section>
                <h2 className="text-2xl font-bold text-text-main dark:text-white mb-3">11. Changes to This Policy</h2>
                <p>We may update this Privacy Policy from time to time. We will notify you of any material changes by posting the new policy on this page and updating the "Last Updated" date. If changes materially affect how we handle student data, we will provide 30 days' notice before the changes take effect. Your continued use of the Service after changes constitutes acceptance of the revised policy.</p>
            </section>

            <section>
                <h2 className="text-2xl font-bold text-text-main dark:text-white mb-3">12. Contact Us</h2>
                <p>If you have questions about this Privacy Policy, need to sign a Data Privacy Agreement (DPA), or wish to exercise any of your rights, please contact us:</p>
                <ul className="list-none mt-2 space-y-1">
                    <li><strong>Privacy Officer Email:</strong> privacy@newmaos.com</li>
                    <li><strong>General Support:</strong> support@newmaos.com</li>
                    <li><strong>Website:</strong> newmaos.com/support</li>
                </ul>
                <p className="mt-3 text-sm text-gray-500">For school district IT administrators: We are happy to provide additional documentation, complete vendor assessment questionnaires, or sign your district's standard DPA. Please contact privacy@newmaos.com and we will respond within 2 business days.</p>
            </section>
        </div>
    </SimpleLayout>
);

export const Terms = () => (
    <SimpleLayout title="Terms of Service">
        <div className="space-y-8">
            <p className="text-sm text-gray-500">Last Updated: March 31, 2026</p>
            <section>
                <h2 className="text-2xl font-bold text-text-main dark:text-white mb-3">1. Agreement to Terms</h2>
                <p>These Terms of Service ("Terms") constitute a legally binding agreement between you and NewMaoS Learning, Inc. ("NewMaoS," "we," "our," or "us"). By accessing or using our AP Calculus learning platform at newmaos.com (the "Service"), you agree to be bound by these Terms and our <a href="#/privacy" className="text-primary hover:underline font-semibold">Privacy Policy</a>.</p>
            </section>
            <section>
                <h2 className="text-2xl font-bold text-text-main dark:text-white mb-3">2. Eligibility</h2>
                <p>You must be at least 13 years old to create an account. If you are under 18, you represent that you have parental or guardian consent to use the Service. If you are under 13, you must have verifiable parental consent before creating an account, in compliance with COPPA.</p>
            </section>
            <section>
                <h2 className="text-2xl font-bold text-text-main dark:text-white mb-3">3. Account Registration</h2>
                <p>You agree to provide accurate information during registration, maintain the security of your account credentials, and accept responsibility for all activities under your account. You must notify us immediately of any unauthorized use of your account.</p>
            </section>
            <section>
                <h2 className="text-2xl font-bold text-text-main dark:text-white mb-3">4. Intellectual Property</h2>
                <p>The Service and all its contents—including questions, explanations, review books, and software—are owned by NewMaoS and protected by copyright laws. You are granted a limited, non-exclusive, non-transferable license for personal, non-commercial educational use only. You may not reproduce, distribute, or create derivative works from our content without written permission.</p>
            </section>
            <section>
                <h2 className="text-2xl font-bold text-text-main dark:text-white mb-3">5. Student Data Protection</h2>
                <p>We are committed to protecting student data. In connection with the Service:</p>
                <ul className="list-disc pl-5 mt-2 space-y-1">
                    <li>We do not sell, rent, or trade student data to any third party</li>
                    <li>We do not use student data for advertising or non-educational purposes</li>
                    <li>We comply with FERPA, COPPA, and applicable state student privacy laws</li>
                    <li>Student education records remain the property of the student and/or their school</li>
                    <li>Students and parents may request access to, correction of, or deletion of their data at any time</li>
                </ul>
                <p className="mt-2">For more details, see our <a href="#/privacy" className="text-primary hover:underline font-semibold">Privacy Policy</a>.</p>
            </section>
            <section>
                <h2 className="text-2xl font-bold text-text-main dark:text-white mb-3">6. Prohibited Activities</h2>
                <p>You may not:</p>
                <ul className="list-disc pl-5 mt-2 space-y-1">
                    <li>Copy, distribute, or reproduce the Service or its content</li>
                    <li>Reverse engineer, decompile, or attempt to extract source code</li>
                    <li>Share account credentials with others</li>
                    <li>Use bots, scrapers, or automated tools to access the Service</li>
                    <li>Disrupt or interfere with the Service or its infrastructure</li>
                    <li>Upload malware or malicious content</li>
                    <li>Harass, bully, or threaten other users</li>
                    <li>Use the Service to facilitate academic dishonesty</li>
                </ul>
            </section>
            <section>
                <h2 className="text-2xl font-bold text-text-main dark:text-white mb-3">7. Virtual Currency (NMS Points / Coins)</h2>
                <p>The Service may include a virtual currency system ("Coins" or "NMS Points") used to unlock features within the platform. Virtual currency has no real-world monetary value, is non-transferable, and cannot be exchanged for cash. We reserve the right to modify the virtual economy at any time.</p>
            </section>
            <section>
                <h2 className="text-2xl font-bold text-text-main dark:text-white mb-3">8. Disclaimer of Warranties</h2>
                <p className="uppercase text-sm">THE SERVICE IS PROVIDED "AS IS" WITHOUT WARRANTIES OF ANY KIND, EXPRESS OR IMPLIED. WE DO NOT GUARANTEE ANY SPECIFIC EXAM SCORES, ACADEMIC OUTCOMES, OR UNINTERRUPTED SERVICE AVAILABILITY.</p>
            </section>
            <section>
                <h2 className="text-2xl font-bold text-text-main dark:text-white mb-3">9. Limitation of Liability</h2>
                <p className="uppercase text-sm">TO THE MAXIMUM EXTENT PERMITTED BY LAW, NEWMAOS SHALL NOT BE LIABLE FOR ANY INDIRECT, INCIDENTAL, SPECIAL, OR CONSEQUENTIAL DAMAGES ARISING FROM YOUR USE OF OR INABILITY TO USE THE SERVICE.</p>
            </section>
            <section>
                <h2 className="text-2xl font-bold text-text-main dark:text-white mb-3">10. Termination</h2>
                <p>We may suspend or terminate your account at any time for breach of these Terms. You may delete your account at any time through Settings. Upon account deletion, we will remove your personal data in accordance with our Privacy Policy.</p>
            </section>
            <section>
                <h2 className="text-2xl font-bold text-text-main dark:text-white mb-3">11. Changes to Terms</h2>
                <p>We may update these Terms from time to time. Material changes will be communicated by posting the updated Terms on this page and updating the "Last Updated" date. Your continued use of the Service after changes take effect constitutes acceptance of the revised Terms.</p>
            </section>
            <section>
                <h2 className="text-2xl font-bold text-text-main dark:text-white mb-3">12. Governing Law</h2>
                <p>These Terms are governed by the laws of the State of Delaware, United States, without regard to its conflict of law provisions.</p>
            </section>
            <section>
                <h2 className="text-2xl font-bold text-text-main dark:text-white mb-3">13. Contact Us</h2>
                <p>Questions about these Terms? Contact us:</p>
                <ul className="list-none mt-2 space-y-1">
                    <li><strong>Email:</strong> legal@newmaos.com</li>
                    <li><strong>Privacy inquiries:</strong> privacy@newmaos.com</li>
                    <li><strong>Website:</strong> newmaos.com/support</li>
                </ul>
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
    const [hasAgreed, setHasAgreed] = useState(() => localStorage.getItem('privacy_agreed_2026') === 'true');
    const [showConsentModal, setShowConsentModal] = useState(false);
    const [acceptedCheckbox, setAcceptedCheckbox] = useState(false);
    const [isScrolledToBottom, setIsScrolledToBottom] = useState(false);
    const scrollRef = React.useRef<HTMLDivElement>(null);

    // Auto-show consent modal removed so users can see privacy links before attempting to signup.

    const handlePrivacyScroll = () => {
        if (scrollRef.current) {
            const { scrollTop, scrollHeight, clientHeight } = scrollRef.current;
            if (scrollHeight - scrollTop <= clientHeight + 10) {
                setIsScrolledToBottom(true);
            }
        }
    };

    const handleConfirmConsent = () => {
        if (acceptedCheckbox && isScrolledToBottom) {
            localStorage.setItem('privacy_agreed_2026', 'true');
            setHasAgreed(true);
            setShowConsentModal(false);
            showInlineToast('Privacy & Terms accepted.', 'success');
        }
    };

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

        // 1. Mandatory Consent Check
        if (!hasAgreed) {
            return;
        }

        setIsLoading(true);
        setError('');

        try {
            // Call registration API
            const response = await authApi.register(email, password, name);
            // Always move to verify step for new registration flow
            setIsLoading(false);
            setStep('verify');
        } catch (err: any) {
            setError(translateError(err.message) || 'Registration failed. Please try again.');
            setIsLoading(false);
        }
    };

    // Helper to translate backend errors if they come in Chinese (duplicated from Login)
    const translateError = (msg: string) => {
        if (!msg) return '';
        if (msg.includes('密码') || msg.includes('邮箱') || msg.includes('错误') || msg.includes('用户')) {
            if (msg.includes('验证') || msg.includes('verify')) return 'Please verify your email.';
            if (msg.includes('exists') || msg.includes('User already registered')) return 'Email already registered.';
            return 'Incorrect email or password.';
        }
        return msg;
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
                            // Wait briefly for session to fully propagate to Supabase
                            await new Promise(resolve => setTimeout(resolve, 500));

                            // Verify session is active before calling RPC
                            const { data: sessionData } = await supabase.auth.getSession();
                            console.log('Referral: Session active:', !!sessionData?.session, 'RefCode:', refCode);

                            if (sessionData?.session) {
                                const { data: refResult, error: refError } = await supabase.rpc('process_referral', {
                                    p_referral_code: refCode
                                });
                                if (refError) {
                                    console.error('Referral RPC error:', refError);
                                } else {
                                    console.log('Referral result:', refResult);
                                    if (refResult?.success) {
                                        console.log('✅ Referral processed successfully! Referrer will receive 100 NMS Points.');
                                    } else {
                                        console.warn('Referral not processed:', refResult?.error);
                                    }
                                }
                            } else {
                                console.error('Referral: No active session after setSession');
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
            setError(translateError(err.message) || 'Verification failed. Please check the code.');
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
                                        onChange={(e) => setName(e.target.value.replace(/\s+/g, ''))}
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

                            <label className="flex items-start gap-3 mt-4 mb-2 p-3 rounded-2xl bg-gray-50 dark:bg-[#1a1c23] border border-gray-100 dark:border-gray-800 transition-colors cursor-pointer">
                                <div className="flex-shrink-0 mt-0.5">
                                    <input
                                        type="checkbox"
                                        checked={hasAgreed}
                                        onChange={(e) => {
                                            setHasAgreed(e.target.checked);
                                            if (e.target.checked) {
                                                localStorage.setItem('privacy_agreed_2026', 'true');
                                            } else {
                                                localStorage.removeItem('privacy_agreed_2026');
                                            }
                                        }}
                                        className="w-5 h-5 rounded hover:ring-2 hover:ring-primary/50 text-primary bg-white dark:bg-gray-800 border-gray-300 dark:border-gray-600 focus:ring-primary focus:ring-offset-0 transition-all cursor-pointer"
                                    />
                                </div>
                                <span className="text-xs text-left text-gray-500 dark:text-gray-400 font-medium leading-relaxed">
                                    I acknowledge and agree to the <Link to="/privacy" className="text-primary hover:underline font-bold" onClick={(e) => e.stopPropagation()}>Privacy Policy</Link> and <Link to="/terms" className="text-primary hover:underline font-bold" onClick={(e) => e.stopPropagation()}>Terms of Service</Link>, including all standard data protection policies for educational tools.
                                </span>
                            </label>

                            <div className="pt-2">
                                <button
                                    type="submit"
                                    disabled={isLoading || !canSubmit || !hasAgreed}
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

            {/* --- Mandatory Privacy Consent Modal --- */}
            {showConsentModal && (
                <div className="fixed inset-0 z-[100] flex items-center justify-center p-4 bg-black/60 backdrop-blur-md animate-fade-in">
                    <div className="bg-surface-light dark:bg-surface-dark w-full max-w-2xl rounded-[32px] p-6 md:p-8 shadow-2xl border border-white/10 relative flex flex-col max-h-[90vh] animate-fade-in-up">
                        <button
                            onClick={() => setShowConsentModal(false)}
                            className="absolute top-6 right-6 p-2 rounded-full hover:bg-black/5 dark:hover:bg-white/10 transition-colors text-gray-400 hover:text-gray-800 dark:hover:text-white"
                        >
                            <span className="material-symbols-outlined">close</span>
                        </button>
                        <div className="flex flex-col items-center text-center mb-6 shrink-0">
                            <div className="w-12 h-12 bg-primary rounded-xl flex items-center justify-center text-text-main shadow-glow mb-4 rotate-3">
                                <span className="material-symbols-outlined text-3xl">verified_user</span>
                            </div>
                            <h3 className="text-2xl font-black text-text-main dark:text-white mb-1">Privacy & Terms</h3>
                            <p className="text-sm text-gray-500 dark:text-gray-400 leading-relaxed">
                                Please read and scroll to the bottom to acknowledge our policies.
                            </p>
                        </div>

                        {/* Scrollable Policy Content */}
                        <div 
                            ref={scrollRef}
                            onScroll={handlePrivacyScroll}
                            className="flex-1 overflow-y-auto pr-2 mb-6 bg-gray-50 dark:bg-black/20 rounded-2xl p-6 border border-gray-100 dark:border-white/5 custom-scrollbar text-left text-neutral-800 dark:text-neutral-200"
                        >
                            <div className="prose prose-sm dark:prose-invert max-w-none">
                                <h4 className="text-lg font-bold mb-4">Privacy Policy</h4>
                                <p className="mb-4">Last Updated: March 31, 2026</p>
                                
                                <h5 className="font-bold mt-4 mb-2">1. Introduction</h5>
                                <p>NewMaoS Learning, Inc. ("NewMaoS," "we," "our," or "us") is committed to protecting your privacy and the privacy of students who use our platform. By using our Service, you consent to the data practices described in this policy.</p>
                                <p className="mt-2 font-semibold">This policy is designed to comply with FERPA, COPPA, SOPPA, and applicable state student privacy laws.</p>

                                <h5 className="font-bold mt-4 mb-2">2. Information We Collect</h5>
                                <p>We collect Username, Email, and Hashed Passwords. We automatically collect performance metrics, unit mastery scores, and error patterns strictly for educational personalized learning.</p>
                                <p className="mt-2 text-xs text-gray-500">We do NOT collect SSNs, financial info, biometric data, or geolocation.</p>

                                <h5 className="font-bold mt-4 mb-2">3. How We Use Information</h5>
                                <p>We use information strictly for educational purposes: providing services, personalizing learning, and generating analytics.</p>
                                <ul className="list-disc pl-4 space-y-1 mt-2">
                                    <li>We do NOT sell student data to third parties.</li>
                                    <li>We do NOT use student data for targeted advertising.</li>
                                    <li>We do NOT build non-educational profiles.</li>
                                </ul>

                                <h5 className="font-bold mt-4 mb-2">4. Data Security</h5>
                                <p>Standard encryption (TLS/SSL) and bcrypt hashing are used. Database access is restricted with row-level security.</p>
                                
                                <h5 className="font-bold mt-8 mb-4 border-t pt-4">Terms of Service</h5>
                                <h5 className="font-bold mt-4 mb-2">1. Agreement to Terms</h5>
                                <p>By using the Service, you agree to be bound by these Terms and our Privacy Policy. You must be at least 13 years old to create an account.</p>
                                
                                <h5 className="font-bold mt-4 mb-2">2. Intellectual Property</h5>
                                <p>All content including questions and unit review books are owned by NewMaoS. You are granted a limited license for personal, non-commercial educational use.</p>

                                <h5 className="font-bold mt-4 mb-2">3. Prohibited Activities</h5>
                                <p>You may not copy content, reverse engineer software, share accounts, or use the Service for academic dishonesty.</p>
                                
                                <h5 className="font-bold mt-4 mb-2">4. Termination</h5>
                                <p>We may suspend or terminate accounts for breach of Terms. You may delete your account at any time in Settings.</p>
                                
                                <div className="mt-10 pt-4 border-t text-center text-xs text-gray-400">
                                    End of Policies. Please acknowledge agreement below.
                                </div>
                            </div>
                        </div>

                        {/* Agreement Controls */}
                        <div className="shrink-0 space-y-4">
                            <label className={`flex items-center gap-3 p-4 rounded-2xl border-2 transition-all cursor-pointer ${
                                isScrolledToBottom 
                                    ? acceptedCheckbox ? 'border-primary bg-primary/5' : 'border-gray-200 dark:border-gray-700 hover:border-primary/50' 
                                    : 'border-gray-100 dark:border-white/5 opacity-50 cursor-not-allowed'
                            }`}>
                                <input
                                    type="checkbox"
                                    checked={acceptedCheckbox}
                                    disabled={!isScrolledToBottom}
                                    onChange={(e) => setAcceptedCheckbox(e.target.checked)}
                                    className="w-5 h-5 rounded border-gray-300 text-primary focus:ring-primary accent-primary"
                                />
                                <div className="flex flex-col">
                                    <span className="text-sm font-black text-text-main dark:text-white">I agree to the Privacy Policy and Terms</span>
                                    {!isScrolledToBottom && (
                                        <span className="text-[10px] text-primary font-bold uppercase tracking-widest mt-0.5">Please scroll to the bottom</span>
                                    )}
                                </div>
                            </label>

                            <button
                                onClick={handleConfirmConsent}
                                disabled={!acceptedCheckbox || !isScrolledToBottom}
                                className="w-full py-4 bg-primary text-[#1c1a0d] rounded-2xl font-black shadow-lg hover:brightness-105 hover:shadow-xl active:scale-[0.98] transition-all text-lg disabled:opacity-50 disabled:grayscale disabled:cursor-not-allowed"
                            >
                                {isScrolledToBottom ? 'Confirm & Start Creating Account' : 'Please Review Above'}
                            </button>
                        </div>
                    </div>
                </div>
            )}

            <footer className="mt-12 text-center relative z-10">
                <div className="flex justify-center gap-4 mb-3">
                    <Link to="/privacy" className="text-xs font-medium text-neutral-400 hover:text-neutral-600 dark:text-neutral-500 dark:hover:text-neutral-300 transition-colors">Privacy Policy</Link>
                    <span className="text-neutral-300 dark:text-neutral-700">·</span>
                    <Link to="/terms" className="text-xs font-medium text-neutral-400 hover:text-neutral-600 dark:text-neutral-500 dark:hover:text-neutral-300 transition-colors">Terms of Service</Link>
                    <span className="text-neutral-300 dark:text-neutral-700">·</span>
                    <Link to="/support" className="text-xs font-medium text-neutral-400 hover:text-neutral-600 dark:text-neutral-500 dark:hover:text-neutral-300 transition-colors">Support</Link>
                </div>
                <p className="text-xs font-medium text-neutral-400 dark:text-neutral-600">
                    © 2026 NewMaoS Learning, Inc. All rights reserved.
                </p>
            </footer>
        </div>
    );
};