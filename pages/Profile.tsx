import React, { useEffect, useState } from 'react';
import { useParams, useNavigate, useLocation } from 'react-router-dom';
import { useApp } from '../AppContext';
import { useToast } from '../components/Toast';
import { supabase } from '../src/services/supabaseClient';
import { Navbar } from '../components/Navbar';
import { PointsCoin } from '../components/PointsCoin';
import { PrestigeWidget } from '../components/PrestigeWidget';
import { getUniqueTitleStyle } from '../src/utils/titleStyles';
import { AvatarAura } from '../components/AvatarAura';

export const Profile = () => {
    const { userId } = useParams<{ userId: string }>();
    const navigate = useNavigate();
    const { user: currentUser, fetchUserPoints, triggerCoinAnimation } = useApp();
    const { showToast } = useToast();

    const [profile, setProfile] = useState<{
        id: string;
        name: string;
        avatar_url?: string;
        avatar_color?: string;
        bio?: string;
        streak_days?: number;
        last_login_at?: string;
        equipped_title_id?: string;
        equipped_title?: any;
        show_prestige?: boolean;
        selected_prestige_level?: number;
        is_official?: boolean;
    } | null>(null);

    const [stats, setStats] = useState({ posts: 0, friends: 0, channels: 0 });
    const [prestige, setPrestige] = useState<any>(null);
    const [friendStatus, setFriendStatus] = useState<'none' | 'friends' | 'pending_sent' | 'pending_received'>('none');
    const [isLoading, setIsLoading] = useState(true);
    const [error, setError] = useState<string | null>(null);

    const fetchProfileData = async () => {
        if (!userId) {
            setError('Invalid user ID');
            setIsLoading(false);
            return;
        }

        try {
            // 1. Fetch Profile Basics - MINIMAL SAFE SET
            const { data: minimalData, error: minimalError } = await supabase
                .from('user_profiles')
                .select('id, name, avatar_url, is_official')
                .eq('id', userId)
                .single();

            if (minimalError) {
                console.error('Profile fetch error:', minimalError);
                setError('User not found');
                setIsLoading(false);
                return;
            }

            if (!minimalData) {
                setError('User not found');
                setIsLoading(false);
                return;
            }

            // 1b. Try to fetch ALL optional/newer columns (graceful fallback)
            let fullProfile = { ...minimalData };

            try {
                const { data: extraData } = await supabase
                    .from('user_profiles')
                    .select('bio, avatar_color, streak_days, last_login_at, equipped_title_id, show_prestige, selected_prestige_level, equipped_title:titles(*)')
                    .eq('id', userId)
                    .maybeSingle();

                if (extraData) {
                    fullProfile = { ...fullProfile, ...extraData };
                }
            } catch (e) {
                console.warn('Secondary profile data failed to load', e);
            }

            setProfile(fullProfile);

            // 2. Fetch Stats (using new RPC) — wrapped in try/catch for safety
            try {
                const { data: statsData, error: statsError } = await supabase.rpc('get_user_stats', { target_user_id: userId });
                if (!statsError && statsData) {
                    setStats({
                        posts: statsData.posts ?? 0,
                        friends: statsData.friends ?? 0,
                        channels: statsData.channels ?? 0
                    });
                }
            } catch (e) {
                console.warn('Stats RPC failed:', e);
            }

            // 3. Trigger Login Streak Check (If Owner)
            if (currentUser && currentUser.id === userId) {
                try {
                    const { data: stringData } = await supabase.rpc('handle_daily_login', {
                        user_uuid: currentUser.id,
                        p_timezone: Intl.DateTimeFormat().resolvedOptions().timeZone
                    });
                    if (stringData && stringData.streak) {
                        setProfile(prev => prev ? ({ ...prev, streak_days: stringData.streak, last_login_at: new Date().toISOString() }) : null);
                    }
                } catch (e) {
                    console.warn('Daily login check failed:', e);
                }
            }

            // 4. Check Friend Status (if viewing another user)
            if (currentUser && currentUser.id !== userId) {
                try {
                    const { data: friendData } = await supabase
                        .from('friend_requests')
                        .select('status, sender_id')
                        .or(`and(sender_id.eq.${currentUser.id},receiver_id.eq.${userId}),and(sender_id.eq.${userId},receiver_id.eq.${currentUser.id})`)
                        .maybeSingle();

                    if (friendData) {
                        if (friendData.status === 'accepted') {
                            setFriendStatus('friends');
                        } else if (friendData.sender_id === currentUser.id) {
                            setFriendStatus('pending_sent');
                        } else {
                            setFriendStatus('pending_received');
                        }
                    } else {
                        setFriendStatus('none');
                    }
                } catch (e) {
                    console.warn('Friend status check failed:', e);
                }
            }

            // 5. Fetch Prestige Data
            try {
                const { data: prestigeData } = await supabase
                    .from('user_prestige')
                    .select('*')
                    .eq('user_id', userId)
                    .maybeSingle();

                if (prestigeData) {
                    setPrestige(prestigeData);
                }
            } catch (e) {
                console.warn('Prestige data fetch failed:', e);
            }

            // 3b. [CRITICAL] Override with LOCAL Context data if viewing OWN PROFILE (Instant Update)
            if (currentUser && currentUser.id === userId) {
                setProfile(prev => {
                    if (!prev) return null;
                    return {
                        ...prev,
                        avatar_color: currentUser.avatarColor || prev.avatar_color,
                        bio: currentUser.bio || prev.bio,
                        show_prestige: currentUser.showPrestige !== undefined ? currentUser.showPrestige : prev.show_prestige,
                        selected_prestige_level: currentUser.selectedPrestigeLevel !== undefined ? currentUser.selectedPrestigeLevel : prev.selected_prestige_level,
                        equipped_title_id: currentUser.equippedTitleId || prev.equipped_title_id,
                        avatar_url: currentUser.avatarUrl || prev.avatar_url,
                    };
                });
            }
        } catch (err) {
            console.error('Error fetching profile:', err);
            setError('Failed to load profile');
        } finally {
            setIsLoading(false);
        }
    };

    const location = useLocation();

    useEffect(() => {
        setIsLoading(true);
        setError(null);
        fetchProfileData();
    }, [userId, currentUser?.id, location.key]);

    const handleStartDM = async () => {
        if (!currentUser) return showToast("Login required", "error");

        try {
            const { data: chatId, error } = await supabase.rpc('get_or_create_dm', { target_user_id: userId });
            if (error) throw error;
            navigate('/forum');
        } catch (e) {
            console.error(e);
            showToast("Failed to start chat", "error");
        }
    };

    const handleAddFriend = async () => {
        if (!currentUser) return showToast("Login required", "error");

        try {
            const { error } = await supabase
                .from('friend_requests')
                .insert({ sender_id: currentUser.id, receiver_id: userId });

            if (error) throw error;
            showToast('Friend request sent!', 'success');
            setFriendStatus('pending_sent');
        } catch (err: any) {
            showToast(err.message || 'Failed to send request', 'error');
        }
    };

    const checkIsStreakValid = () => {
        if (!profile?.last_login_at) return true;
        const lastDate = new Date(profile.last_login_at);
        const now = new Date();
        const lastMidnight = new Date(lastDate.getFullYear(), lastDate.getMonth(), lastDate.getDate());
        const nowMidnight = new Date(now.getFullYear(), now.getMonth(), now.getDate());
        const diffDays = Math.floor((nowMidnight.getTime() - lastMidnight.getTime()) / (1000 * 60 * 60 * 24));
        return diffDays <= 1;
    };

    const isStreakValid = checkIsStreakValid();
    const displayStreak = isStreakValid ? (profile?.streak_days || 0) : 0;

    const handleMonthlyRepair = async (e?: React.MouseEvent) => {
        try {
            if (userId !== currentUser?.id) return;

            const btnRect = e?.currentTarget.getBoundingClientRect();
            const targetX = btnRect ? btnRect.left + btnRect.width / 2 : window.innerWidth / 2;
            const targetY = btnRect ? btnRect.top + btnRect.height / 2 : window.innerHeight / 2;

            const { data, error } = await supabase.rpc('use_monthly_repair', { user_uuid: currentUser.id });
            if (error) throw error;
            if (data.success) {
                triggerCoinAnimation(100, targetX, targetY, 'spend');
                showToast(`Streak repaired! New streak: ${data.new_streak}`, 'success');
                fetchProfileData();
                fetchUserPoints();
            } else if (data.reason === 'insufficient_points') {
                showToast('Insufficient NMS Points to repair streak.', 'error');
            } else {
                showToast(data.message || 'Repair failed', 'error');
            }
        } catch (e) {
            console.error(e);
            showToast('Failed to repair streak', 'error');
        }
    };

    // --- Loading State ---
    if (isLoading) {
        return (
            <div className="flex flex-col h-screen bg-background-light dark:bg-background-dark text-text-main dark:text-gray-100 font-sans">
                <Navbar />
                <div className="flex-1 flex items-center justify-center">
                    <div className="flex flex-col items-center gap-4">
                        <div className="w-10 h-10 border-4 border-primary border-t-transparent rounded-full animate-spin"></div>
                        <p className="text-sm text-gray-400 font-medium animate-pulse">Loading profile...</p>
                    </div>
                </div>
            </div>
        );
    }

    // --- Error State ---
    if (error || !profile) {
        return (
            <div className="flex flex-col h-screen bg-background-light dark:bg-background-dark text-text-main dark:text-gray-100 font-sans">
                <Navbar />
                <div className="flex-1 flex items-center justify-center">
                    <div className="flex flex-col items-center gap-6 text-center px-8">
                        <div className="w-20 h-20 bg-gray-100 dark:bg-white/5 rounded-3xl flex items-center justify-center">
                            <span className="material-symbols-outlined text-4xl text-gray-300 dark:text-gray-600">person_off</span>
                        </div>
                        <div>
                            <h2 className="text-2xl font-black text-text-main dark:text-white mb-2">{error || 'Profile Not Found'}</h2>
                            <p className="text-gray-500 text-sm">This user doesn't exist or their profile is unavailable.</p>
                        </div>
                        <button
                            onClick={() => navigate(-1)}
                            className="px-6 py-3 bg-primary text-black rounded-2xl font-bold shadow-lg shadow-primary/20 hover:brightness-105 active:scale-95 transition-all flex items-center gap-2"
                        >
                            <span className="material-symbols-outlined">arrow_back</span>
                            Go Back
                        </button>
                    </div>
                </div>
            </div>
        );
    }

    const isOwner = currentUser?.id === profile.id;
    const displayName = profile.name || 'Anonymous User';
    const bgColor = profile.avatar_color || 'linear-gradient(135deg, #667eea 0%, #764ba2 100%)';
    const isOfficial = profile.is_official || false;

    return (
        <div className="flex flex-col h-screen bg-background-light dark:bg-background-dark text-text-main dark:text-gray-100 font-sans">
            <Navbar />

            <div className="flex-1 overflow-y-auto scroll-bounce">
                {/* Hero Banner — full-width gradient header */}
                <div className="relative w-full h-48 md:h-56 overflow-hidden">
                    <div
                        className="absolute inset-0 transition-all duration-700"
                        style={{ background: bgColor }}
                    ></div>
                    {/* Decorative overlay pattern */}
                    <div className="absolute inset-0 bg-[radial-gradient(circle_at_30%_50%,rgba(255,255,255,0.15)_0%,transparent_60%)]"></div>
                    <div className="absolute inset-0 bg-[radial-gradient(circle_at_80%_20%,rgba(255,255,255,0.1)_0%,transparent_40%)]"></div>
                    <div className="absolute bottom-0 left-0 right-0 h-24 bg-gradient-to-t from-background-light dark:from-background-dark to-transparent"></div>

                    {/* Back Button */}
                    <button
                        onClick={() => navigate(-1)}
                        className="absolute top-4 left-4 z-10 flex items-center gap-1.5 px-4 py-2 bg-black/20 backdrop-blur-xl text-white rounded-2xl font-bold text-sm hover:bg-black/30 active:scale-95 transition-all border border-white/10"
                    >
                        <span className="material-symbols-outlined text-lg">arrow_back</span>
                        Back
                    </button>

                    {/* Settings Gear for Owner */}
                    {isOwner && (
                        <button
                            onClick={() => navigate('/settings/profile', { state: { from: `profile/${userId}` } })}
                            className="absolute top-4 right-4 z-10 flex items-center gap-1.5 px-4 py-2 bg-black/20 backdrop-blur-xl text-white rounded-2xl font-bold text-sm hover:bg-black/30 active:scale-95 transition-all border border-white/10"
                        >
                            <span className="material-symbols-outlined text-lg">edit</span>
                            Edit
                        </button>
                    )}
                </div>

                {/* Profile Content Card */}
                <div className="max-w-2xl mx-auto px-4 -mt-20 relative z-10 pb-12">
                    <div className="bg-white dark:bg-surface-dark rounded-[2rem] shadow-2xl border border-gray-100 dark:border-white/5 overflow-hidden">
                        {/* Avatar + Name Section */}
                        <div className="flex flex-col items-center pt-0 pb-6 px-6 relative">
                            {/* Avatar */}
                            <div className="relative -mt-16 mb-4">
                                <div
                                    className="relative w-32 h-32 rounded-full flex items-center justify-center text-4xl font-black text-white border-[6px] border-white dark:border-surface-dark shadow-[0_20px_60px_rgba(0,0,0,0.15)] overflow-hidden transition-all duration-500 hover:scale-105"
                                    style={{ background: profile.avatar_url ? '#f3f4f6' : bgColor }}
                                >
                                    {profile.avatar_url ? (
                                        <img src={profile.avatar_url} alt={displayName} className="absolute inset-0 w-full h-full object-cover z-0" />
                                    ) : (
                                        <span className="drop-shadow-[0_2px_4px_rgba(0,0,0,0.3)] relative z-0 select-none">
                                            {(displayName.charAt(0) || 'U').toUpperCase()}
                                        </span>
                                    )}
                                    {prestige?.planet_level && <AvatarAura level={profile.selected_prestige_level || prestige.planet_level} />}
                                </div>
                                {/* Online Indicator */}
                                <div className="absolute bottom-2 right-2 w-7 h-7 bg-green-500 border-[4px] border-white dark:border-surface-dark rounded-full shadow-lg z-20"></div>
                            </div>

                            {/* Name + Badges */}
                            <div className="flex flex-col items-center gap-2 w-full">
                                <div className="flex items-center gap-2 flex-wrap justify-center">
                                    <h1 className="text-2xl md:text-3xl font-black text-text-main dark:text-white tracking-tight">
                                        {displayName}
                                    </h1>
                                    {isOfficial && (
                                        <span className="text-[9px] px-2.5 py-1 bg-primary text-black rounded-full font-black tracking-widest shadow-sm shadow-primary/20 uppercase">
                                            Official
                                        </span>
                                    )}
                                </div>

                                {/* Equipped Title Badge */}
                                {profile.equipped_title && (() => {
                                    const style = getUniqueTitleStyle(profile.equipped_title.category, profile.equipped_title.threshold);
                                    return (
                                        <div
                                            className={`flex items-center gap-1.5 bg-gradient-to-br ${style.bg} px-3.5 py-1.5 rounded-full border ${style.border} shadow-lg ${style.glow} hover:scale-105 transition-all duration-300 overflow-hidden relative ${style.extraClasses || ''}`}
                                        >
                                            <div className="flex items-center relative z-10 justify-center">
                                                <span
                                                    className={`material-symbols-outlined relative z-10 transition-all duration-300 ${style.text}`}
                                                    style={{ fontSize: '16px' }}
                                                >
                                                    {style.icon}
                                                </span>
                                            </div>
                                            <span className={`text-[10px] font-black ${style.text} uppercase tracking-wider relative z-10 drop-shadow-sm`}>
                                                {profile.equipped_title.name}
                                            </span>
                                        </div>
                                    );
                                })()}

                                {/* Prestige Widget */}
                                {prestige && profile.show_prestige !== false && (
                                    <div className="mt-1 transform hover:scale-[1.02] transition-transform duration-300 relative z-20 w-full flex justify-center overflow-visible">
                                        <PrestigeWidget
                                            compact={true}
                                            prestigeData={(profile.selected_prestige_level && profile.selected_prestige_level !== prestige.planet_level)
                                                ? { ...prestige, planet_level: profile.selected_prestige_level, star_level: 4, current_stardust: 0 }
                                                : prestige
                                            }
                                            isReadOnly={true}
                                            showStardust={false}
                                            className="scale-[0.55] sm:scale-[0.65] md:scale-[0.75] lg:scale-[0.8]"
                                        />
                                    </div>
                                )}

                                {/* Email (Owner Only) */}
                                {isOwner && currentUser?.email && (
                                    <p className="text-sm text-gray-400 font-medium truncate max-w-[280px]">{currentUser.email}</p>
                                )}

                                {/* Bio */}
                                {profile.bio && (
                                    <p className="text-sm text-gray-500 dark:text-gray-400 mt-1 font-medium italic px-6 leading-relaxed text-center max-w-md">
                                        "{profile.bio}"
                                    </p>
                                )}
                            </div>
                        </div>

                        {/* Divider */}
                        <div className="mx-6 h-px bg-gray-100 dark:bg-gray-800"></div>

                        {/* Stats Row */}
                        <div className="grid grid-cols-3 divide-x divide-gray-100 dark:divide-gray-800">
                            <div className="flex flex-col items-center py-5 hover:bg-gray-50/50 dark:hover:bg-white/[0.02] transition-colors">
                                <span className="text-2xl font-black text-text-main dark:text-white">{stats.posts}</span>
                                <span className="text-[10px] font-bold text-gray-400 tracking-wider uppercase mt-0.5">Posts</span>
                            </div>
                            <div className="flex flex-col items-center py-5 hover:bg-gray-50/50 dark:hover:bg-white/[0.02] transition-colors">
                                <span className="text-2xl font-black text-text-main dark:text-white">{stats.friends}</span>
                                <span className="text-[10px] font-bold text-gray-400 tracking-wider uppercase mt-0.5">Friends</span>
                            </div>
                            <div className="flex flex-col items-center py-5 hover:bg-gray-50/50 dark:hover:bg-white/[0.02] transition-colors">
                                <span className="text-2xl font-black text-text-main dark:text-white">{stats.channels}</span>
                                <span className="text-[10px] font-bold text-gray-400 tracking-wider uppercase mt-0.5">Channels</span>
                            </div>
                        </div>

                        {/* Divider */}
                        <div className="mx-6 h-px bg-gray-100 dark:bg-gray-800"></div>

                        {/* Action Buttons */}
                        <div className="p-6 flex flex-wrap gap-3 justify-center">
                            {!isOwner && (
                                <>
                                    {friendStatus === 'none' && (
                                        <button
                                            onClick={handleAddFriend}
                                            className="px-6 py-3 rounded-2xl bg-primary text-black font-bold shadow-lg shadow-primary/20 hover:brightness-105 active:scale-95 transition-all flex items-center gap-2 text-sm"
                                        >
                                            <span className="material-symbols-outlined text-lg">person_add</span>
                                            Add Friend
                                        </button>
                                    )}
                                    {friendStatus === 'pending_sent' && (
                                        <button
                                            disabled
                                            className="px-6 py-3 rounded-2xl bg-gray-100 dark:bg-gray-800 text-gray-400 font-bold cursor-not-allowed flex items-center gap-2 border border-gray-200 dark:border-gray-700 text-sm"
                                        >
                                            <span className="material-symbols-outlined text-lg">hourglass_empty</span>
                                            Request Sent
                                        </button>
                                    )}
                                    {friendStatus === 'pending_received' && (
                                        <button
                                            onClick={async () => {
                                                try {
                                                    const { error } = await supabase
                                                        .from('friend_requests')
                                                        .update({ status: 'accepted' })
                                                        .or(`and(sender_id.eq.${userId},receiver_id.eq.${currentUser?.id})`)
                                                        .eq('status', 'pending');
                                                    if (error) throw error;
                                                    setFriendStatus('friends');
                                                    showToast('Friend request accepted!', 'success');
                                                } catch (e: any) {
                                                    showToast(e.message || 'Failed', 'error');
                                                }
                                            }}
                                            className="px-6 py-3 rounded-2xl bg-green-500 text-white font-bold shadow-lg shadow-green-500/20 hover:brightness-105 active:scale-95 transition-all flex items-center gap-2 text-sm"
                                        >
                                            <span className="material-symbols-outlined text-lg">check_circle</span>
                                            Accept Request
                                        </button>
                                    )}
                                    {friendStatus === 'friends' && (
                                        <button
                                            onClick={handleStartDM}
                                            className="px-6 py-3 rounded-2xl bg-black dark:bg-white text-white dark:text-black font-bold shadow-lg hover:opacity-90 active:scale-95 transition-all flex items-center gap-2 text-sm"
                                        >
                                            <span className="material-symbols-outlined text-lg">chat</span>
                                            Message
                                        </button>
                                    )}
                                </>
                            )}
                            {isOwner && (
                                <button
                                    onClick={() => navigate('/settings/profile', { state: { from: `profile/${userId}` } })}
                                    className="px-6 py-3 rounded-2xl bg-gray-100 dark:bg-gray-800 text-text-main dark:text-white font-bold hover:bg-gray-200 dark:hover:bg-gray-700 transition-all flex items-center gap-2 border border-gray-200 dark:border-gray-700 text-sm"
                                >
                                    <span className="material-symbols-outlined text-lg">edit</span>
                                    Edit Profile
                                </button>
                            )}
                        </div>
                    </div>

                    {/* Streak Card */}
                    <div className="mt-6 bg-white dark:bg-surface-dark rounded-[2rem] shadow-xl border border-gray-100 dark:border-white/5 overflow-hidden p-6">
                        <div className="flex items-center justify-between mb-5">
                            <div className="flex items-center gap-2.5">
                                <div className={`w-9 h-9 rounded-xl flex items-center justify-center ${isStreakValid ? 'bg-orange-100 dark:bg-orange-900/20' : 'bg-blue-100 dark:bg-blue-900/20'}`}>
                                    <span className={`material-symbols-outlined ${isStreakValid ? 'text-orange-500' : 'text-blue-400'}`}>
                                        {isStreakValid ? 'local_fire_department' : 'ac_unit'}
                                    </span>
                                </div>
                                <span className="text-sm font-black text-text-main dark:text-white uppercase tracking-wider">Login Streak</span>
                            </div>
                            {isOwner && !isStreakValid && (
                                <button
                                    onClick={handleMonthlyRepair}
                                    className="text-xs font-bold text-primary hover:text-primary-dark transition-colors flex items-center gap-1 bg-primary/10 px-3 py-1.5 rounded-full shadow-sm hover:bg-primary/20"
                                >
                                    <span className="material-symbols-outlined text-sm">build</span>
                                    Repair (<PointsCoin size="sm" /> 100)
                                </button>
                            )}
                        </div>
                        <div className={`bg-gradient-to-r ${isStreakValid
                            ? 'from-orange-50 to-amber-50/50 dark:from-orange-900/10 dark:to-orange-900/5 border-orange-100 dark:border-orange-900/20'
                            : 'from-blue-50 to-cyan-50/50 dark:from-blue-900/10 dark:to-blue-900/5 border-blue-100 dark:border-blue-900/20'} border rounded-2xl p-5 flex items-center gap-6 transition-all duration-700`}>
                            <div className={`bg-white dark:bg-white/10 w-16 h-16 rounded-2xl flex items-center justify-center shadow-sm text-3xl shrink-0 ${isStreakValid ? '' : 'opacity-50 grayscale rotate-12'}`}>
                                {isStreakValid ? '🔥' : '❄️'}
                            </div>
                            <div className="flex flex-col">
                                <div className="flex items-baseline gap-2">
                                    <span className={`text-3xl font-black ${isStreakValid ? 'text-text-main dark:text-white' : 'text-gray-400'} leading-none`}>{displayStreak}</span>
                                    <span className="text-xl font-bold text-gray-400">days</span>
                                </div>
                                <span className={`text-xs font-bold ${isStreakValid ? 'text-orange-500' : 'text-blue-500'} uppercase tracking-wide mt-1`}>
                                    {isStreakValid ? 'Current Streak' : 'Streak Broken'}
                                </span>
                            </div>
                            <div className="ml-auto hidden sm:flex gap-1.5 opacity-50">
                                {[...Array(7)].map((_, i) => (
                                    <div key={i} className={`w-2 h-8 rounded-full transition-all ${isStreakValid && i < (displayStreak % 7 || 7) ? 'bg-orange-500' : 'bg-gray-200 dark:bg-gray-700'}`}></div>
                                ))}
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    );
};
