import React, { useState, useEffect } from 'react';
import { useApp } from '../AppContext';
import { Navbar } from '../components/Navbar';
import { PointsCoin } from '../components/PointsCoin';
import { useNavigate, useLocation } from 'react-router-dom';
import { supabase } from '../src/services/supabaseClient';

// Expandable detail card component
const EarningCard = ({
    icon,
    iconBg,
    iconColor,
    title,
    description,
    details,
    actionLabel,
    actionIcon,
    onAction,
    children,
}: {
    icon: string;
    iconBg: string;
    iconColor: string;
    title: string;
    description: React.ReactNode;
    details: string[];
    actionLabel: string;
    actionIcon: string;
    onAction: () => void;
    children?: React.ReactNode;
}) => {
    const [expanded, setExpanded] = useState(false);

    return (
        <div className="rounded-3xl bg-white dark:bg-white/5 border border-gray-100 dark:border-white/5 shadow-sm overflow-hidden transition-all">
            {/* Clickable main area */}
            <div
                onClick={onAction}
                className="p-6 cursor-pointer hover:bg-gray-50/50 dark:hover:bg-white/[0.02] transition-colors group"
            >
                <div className="flex items-center gap-3 mb-4">
                    <div className={`w-10 h-10 rounded-full ${iconBg} flex items-center justify-center ${iconColor} group-hover:scale-110 transition-transform`}>
                        <span className="material-symbols-outlined">{icon}</span>
                    </div>
                    <h3 className="font-bold">{title}</h3>
                </div>
                <p className="text-sm text-gray-500 leading-relaxed">
                    {description}
                </p>
                <div className="mt-4 flex items-center gap-1 text-[10px] font-black text-primary uppercase tracking-widest opacity-0 group-hover:opacity-100 transition-opacity">
                    <span>{actionLabel}</span>
                    <span className="material-symbols-outlined text-xs">{actionIcon}</span>
                </div>
            </div>

            {/* Extra content (e.g. copy link) */}
            {children}

            {/* Expand toggle button */}
            <button
                onClick={(e) => {
                    e.stopPropagation();
                    setExpanded(!expanded);
                }}
                className="w-full flex items-center justify-center gap-1.5 py-2.5 border-t border-gray-100 dark:border-white/5 text-xs font-bold text-gray-400 hover:text-gray-600 dark:hover:text-gray-300 hover:bg-gray-50 dark:hover:bg-white/[0.03] transition-all"
            >
                <span>{expanded ? 'Hide Details' : 'How to Earn'}</span>
                <span className="material-symbols-outlined text-sm transition-transform" style={{ transform: expanded ? 'rotate(180deg)' : 'rotate(0deg)' }}>
                    expand_more
                </span>
            </button>

            {/* Expandable details panel */}
            <div
                className="overflow-hidden transition-all duration-300 ease-in-out"
                style={{ maxHeight: expanded ? '400px' : '0px' }}
            >
                <div className="px-6 pb-5 pt-1 space-y-2">
                    {details.map((detail, i) => (
                        <div key={i} className="flex items-start gap-2 text-xs text-gray-500 dark:text-gray-400">
                            <span className="text-primary mt-0.5 shrink-0">•</span>
                            <span className="leading-relaxed">{detail}</span>
                        </div>
                    ))}
                </div>
            </div>
        </div>
    );
};

export const PointsPage = () => {
    const { userPoints, user } = useApp();
    const navigate = useNavigate();
    const [referralCode, setReferralCode] = useState<string | null>(null);
    const [copied, setCopied] = useState(false);

    // Fetch user's referral code
    useEffect(() => {
        const fetchReferralCode = async () => {
            if (!user?.id) return;
            const { data } = await supabase
                .from('user_profiles')
                .select('referral_code')
                .eq('id', user?.id)
                .single();
            if (data?.referral_code) {
                setReferralCode(data.referral_code);
            }
        };
        fetchReferralCode();
    }, [user?.id]);

    const referralLink = referralCode ? `https://newmaos.com/signup?ref=${referralCode}` : '';

    const handleCopyLink = async () => {
        if (!referralLink) return;
        try {
            await navigator.clipboard.writeText(referralLink);
            setCopied(true);
            setTimeout(() => setCopied(false), 2000);
        } catch {
            // Fallback
            const textarea = document.createElement('textarea');
            textarea.value = referralLink;
            document.body.appendChild(textarea);
            textarea.select();
            document.execCommand('copy');
            document.body.removeChild(textarea);
            setCopied(true);
            setTimeout(() => setCopied(false), 2000);
        }
    };

    const location = useLocation();
    const searchParams = new URLSearchParams(location.search);
    const fromPractice = searchParams.get('from') === 'practice';

    return (
        <div className="h-screen bg-surface-light dark:bg-surface-dark text-text-main dark:text-gray-100 flex flex-col overflow-hidden">
            <div className="flex-1 overflow-y-auto p-6 sm:p-10 pb-20 scroll-smooth">
                <div className="max-w-2xl mx-auto flex flex-col gap-6 animate-fade-in mt-4">

                    {/* Back Button / Title Header */}
                    <div className="flex items-center gap-4">
                        <button
                            onClick={() => navigate(-1)}
                            className="w-10 h-10 -ml-2 rounded-full flex items-center justify-center hover:bg-gray-100 dark:hover:bg-white/10 transition-colors"
                        >
                            <span className="material-symbols-outlined">arrow_back</span>
                        </button>
                        <h1 className="text-2xl font-black tracking-tight">NMS Points Wallet</h1>
                    </div>

                    {/* Points Balance Card */}
                    <div className="p-8 rounded-[2.5rem] border-2 border-primary/30 bg-gradient-to-br from-primary/5 to-amber-500/5 shadow-2xl shadow-primary/10 relative overflow-hidden">
                        <div className="absolute -top-32 -right-32 w-64 h-64 bg-primary/10 rounded-full blur-3xl animate-pulse" />
                        <div className="relative z-10 flex flex-col items-center text-center gap-4 py-4">
                            <div className="p-4 bg-white/50 dark:bg-black/20 rounded-full shadow-sm ring-1 ring-black/5 dark:ring-white/10 mb-2">
                                <PointsCoin size="xl" animate />
                            </div>

                            <div className="flex flex-col items-center">
                                <h2 className="text-sm font-black text-gray-400 uppercase tracking-widest mb-1">Current Balance</h2>
                                <div className="flex items-baseline gap-2">
                                    <span className="text-6xl sm:text-7xl font-black text-black dark:text-white tracking-tighter drop-shadow-sm">
                                        {userPoints.balance.toLocaleString()}
                                    </span>
                                </div>
                            </div>

                            <div className="flex items-center gap-2 mt-4 px-4 py-2 bg-white/60 dark:bg-black/20 rounded-xl border border-black/5 dark:border-white/5 backdrop-blur-sm group/info relative">
                                <span className="material-symbols-outlined text-amber-500 text-sm">history</span>
                                <p className="text-xs font-bold text-gray-600 dark:text-gray-400">
                                    Lifetime Earned: <span className="text-black dark:text-white">{userPoints.lifetimeEarned.toLocaleString()}</span>
                                </p>
                                <span className="material-symbols-outlined text-[10px] text-gray-300 cursor-help ml-1">info</span>

                                {/* Tooltip */}
                                <div className="absolute bottom-full left-1/2 -translate-x-1/2 mb-3 w-48 p-3 bg-gray-900 text-white text-[10px] rounded-xl shadow-2xl opacity-0 group-hover/info:opacity-100 pointer-events-none transition-all font-medium leading-relaxed border border-white/10 z-20">
                                    Total amount of NMS Points ever earned by this account. Spending points on Pro will not decrease this value.
                                    <div className="absolute top-full left-1/2 -translate-x-1/2 border-8 border-transparent border-t-gray-900"></div>
                                </div>
                            </div>

                            <p className="text-[10px] font-bold text-gray-400 dark:text-gray-500 mt-2 flex items-center gap-1.5 opacity-80 uppercase tracking-widest">
                                <span className="w-1 h-3 bg-primary rounded-full"></span>
                                Earn NMS Points by practicing, checking in daily, or engaging with our community
                            </p>
                        </div>
                    </div>

                    {/* Earning Cards Grid */}
                    <div className="grid grid-cols-1 md:grid-cols-2 gap-4 items-start">
                        <EarningCard
                            icon="check_circle"
                            iconBg="bg-green-100 dark:bg-green-900/30"
                            iconColor="text-green-600 dark:text-green-400"
                            title="Daily Check-in"
                            description="Earn NMS Points every day you log in. Keep your streak alive for massive bonus multipliers!"
                            actionLabel="View Progress"
                            actionIcon="arrow_forward"
                            onAction={() => navigate('/checkin')}
                            details={[
                                "Day 1 check-in: earn 10 NMS Points",
                                "Day 2 check-in: earn 20 NMS Points",
                                "Day 3 check-in: earn 30 NMS Points",
                                "Day 4 and beyond: earn 50 NMS Points per day",
                                "Complete a 7-day streak: bonus +100 NMS Points",
                                "If your streak breaks, the daily reward resets back to Day 1",
                            ]}
                        />

                        <EarningCard
                            icon="school"
                            iconBg="bg-blue-100 dark:bg-blue-900/30"
                            iconColor="text-blue-600 dark:text-blue-400"
                            title="Practice"
                            description="Complete practice sessions and master units to earn NMS Points based on your accuracy and difficulty."
                            actionLabel="Go to Practice"
                            actionIcon="arrow_forward"
                            onAction={() => navigate('/practice')}
                            details={[
                                "Earn 5 NMS Points for each correct answer in a practice session",
                                "Accuracy bonus: achieve 80%+ accuracy to get a 2x point multiplier",
                                "Complete an entire Unit Test: earn 50 NMS Points",
                                "Achieve first-time Unit Mastery (100%): earn 200 NMS Points",
                                "Higher difficulty questions give slightly more points",
                            ]}
                        />

                        <EarningCard
                            icon="forum"
                            iconBg="bg-purple-100 dark:bg-purple-900/30"
                            iconColor="text-purple-600 dark:text-purple-400"
                            title="Community Engagement"
                            description="Gain NMS Points by sharing insights in the forum, replying to classmates, or creating new study channels."
                            actionLabel="Join Forum"
                            actionIcon="arrow_forward"
                            onAction={() => navigate('/forum')}
                            details={[
                                'Receive a "like" on your forum message: earn 5 NMS Points',
                                "Receive a reply to your message: earn 10 NMS Points",
                                "Add a new friend on the platform: earn 10 NMS Points (both users)",
                                "Points from community engagement appear as a 'Claim Gold' button in the Forum",
                                "Note: self-likes do not generate NMS Points (to prevent farming)",
                            ]}
                        />

                        <EarningCard
                            icon="group_add"
                            iconBg="bg-amber-100 dark:bg-amber-900/30"
                            iconColor="text-amber-600 dark:text-amber-400"
                            title="Invite Friends"
                            description={<>Earn <span className="text-primary font-bold">100 NMS Points</span> for every new user you invite to join our educational community!</>}
                            actionLabel="Copy Invite Link"
                            actionIcon="content_copy"
                            onAction={handleCopyLink}
                            details={[
                                "Share your unique referral link with friends, classmates, or study partners",
                                "When they sign up using your link and verify their email, you automatically earn 100 NMS Points",
                                "There is no limit on how many friends you can invite — invite more, earn more!",
                                "Referral points appear as a 'Claim Gold' button in the Forum page",
                                "Your unique referral code is shown below — copy and share it!",
                            ]}
                        >
                            {/* Referral Link Copy Section */}
                            <div className="px-6 pb-4">
                                <div className="flex items-center gap-2 p-3 rounded-xl bg-gray-50 dark:bg-white/5 border border-gray-100 dark:border-white/10">
                                    <span className="material-symbols-outlined text-sm text-gray-400">link</span>
                                    <span className="flex-1 text-xs font-mono text-gray-500 dark:text-gray-400 truncate">
                                        {referralCode ? `newmaos.com/signup?ref=${referralCode}` : 'Loading...'}
                                    </span>
                                    <button
                                        onClick={(e) => {
                                            e.stopPropagation();
                                            handleCopyLink();
                                        }}
                                        disabled={!referralCode}
                                        className={`px-3 py-1.5 rounded-lg text-xs font-bold transition-all ${copied
                                            ? 'bg-green-100 dark:bg-green-900/30 text-green-600'
                                            : 'bg-primary/10 text-primary hover:bg-primary/20'
                                            } disabled:opacity-50`}
                                    >
                                        {copied ? '✓ Copied!' : 'Copy'}
                                    </button>
                                </div>
                            </div>
                        </EarningCard>
                    </div>

                </div>
            </div>
        </div>
    );
};
