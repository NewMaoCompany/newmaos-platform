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

    // Added avatar_color and bio to state type
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
    } | null>(null);

    const [stats, setStats] = useState({ posts: 0, friends: 0, channels: 0 });
    const [prestige, setPrestige] = useState<any>(null);
    const [friendStatus, setFriendStatus] = useState<'none' | 'friends' | 'pending_sent' | 'pending_received'>('none');
    const [isLoading, setIsLoading] = useState(true);

    const fetchProfileData = async () => {
        if (!userId) return;

        try {
            // 1. Fetch Profile Basics - MINIMAL SAFE SET
            // ONLY select columns that are guaranteed to exist in the oldest schema version
            const { data: minimalData, error: minimalError } = await supabase
                .from('user_profiles')
                .select('id, name, avatar_url')
                .eq('id', userId)
                .single();

            if (minimalError) throw minimalError;

            // 1b. Try to fetch ALL optional/newer columns (graceful fallback)
            let fullProfile = { ...minimalData };

            try {
                // Attempt to fetch Everything else
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

            // 2. Fetch Stats (using new RPC)
            const { data: statsData, error: statsError } = await supabase.rpc('get_user_stats', { target_user_id: userId });
            if (!statsError && statsData) {
                setStats(statsData);
            }

            // 3. Trigger Login Streak Check (If Owner)
            if (currentUser && currentUser.id === userId) {
                const { data: stringData } = await supabase.rpc('handle_daily_login', {
                    user_uuid: currentUser.id,
                    p_timezone: Intl.DateTimeFormat().resolvedOptions().timeZone
                });
                if (stringData && stringData.streak) {
                    setProfile(prev => prev ? ({ ...prev, streak_days: stringData.streak, last_login_at: new Date().toISOString() }) : null);
                }
            }

            // 4. Check Friend Status (if viewing another user)
            if (currentUser && currentUser.id !== userId) {
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
            }

            // 5. Fetch Prestige Data
            const { data: prestigeData } = await supabase
                .from('user_prestige')
                .select('*')
                .eq('user_id', userId)
                .maybeSingle();

            if (prestigeData) {
                setPrestige(prestigeData);
            }
            // 3b. [CRITICAL] Override with LOCAL Context data if viewing OWN PROFILE (Instant Update)
            if (currentUser && currentUser.id === userId) {
                setProfile(prev => {
                    if (!prev) return null;
                    return {
                        ...prev,
                        // Prioritize local state over DB fetch for instant feedback
                        // This ensures "Dynamic" feel even if DB sync is slow or fails
                        avatar_color: currentUser.avatarColor || prev.avatar_color,
                        bio: currentUser.bio || prev.bio,
                        show_prestige: currentUser.showPrestige !== undefined ? currentUser.showPrestige : prev.show_prestige,
                        selected_prestige_level: currentUser.selectedPrestigeLevel !== undefined ? currentUser.selectedPrestigeLevel : prev.selected_prestige_level,
                        equipped_title_id: currentUser.equippedTitleId || prev.equipped_title_id,
                        // Ensure avatar URL is consistent if changed
                        avatar_url: currentUser.avatarUrl || prev.avatar_url,
                    };
                });
            }
        } catch (err) {
            console.error('Error fetching profile:', err);
            showToast('Failed to load profile', 'error');
        } finally {
            setIsLoading(false);
        }
    };

    const location = useLocation(); // Add this hook

    useEffect(() => {
        fetchProfileData();
    }, [userId, currentUser?.id, location.key]); // Refetch when location key changes (navigation)

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

        // Streak is broken if the last login was more than 1 day before today
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

            // Capture button position for animation target
            const btnRect = e?.currentTarget.getBoundingClientRect();
            const targetX = btnRect ? btnRect.left + btnRect.width / 2 : window.innerWidth / 2;
            const targetY = btnRect ? btnRect.top + btnRect.height / 2 : window.innerHeight / 2;

            const { data, error } = await supabase.rpc('use_monthly_repair', { user_uuid: currentUser.id });
            if (error) throw error;
            if (data.success) {
                // Trigger spend animation (Wallet -> Repair Button)
                triggerCoinAnimation(100, targetX, targetY, 'spend');

                showToast(`Streak repaired! New streak: ${data.new_streak}`, 'success');
                fetchProfileData();
                fetchUserPoints(); // Refresh points balance
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

    if (isLoading) {
        return (
            <div className="flex items-center justify-center h-screen bg-background-light dark:bg-background-dark">
                <div className="w-8 h-8 border-4 border-primary border-t-transparent rounded-full animate-spin"></div>
            </div>
        );
    }

    if (!profile) return null;

    const isOwner = currentUser?.id === profile.id;

    return (
        <div className="flex flex-col h-screen bg-background-light dark:bg-background-dark text-text-main dark:text-gray-100 font-sans">
            <Navbar />

            <div className="flex-1 overflow-y-auto px-4 py-8 scroll-bounce">
                <div className="max-w-2xl mx-auto">
                    <button
                        onClick={() => navigate(-1)}
                        className="flex items-center gap-2 text-gray-500 hover:text-text-main dark:hover:text-white mb-8 transition-colors group"
                    >
                        <span className="material-symbols-outlined group-hover:-translate-x-1 transition-transform">arrow_back</span>
                        Back
                    </button>

                    {/* Profile Card - Matched to Settings Live Preview */}
                    <div className="bg-white dark:bg-surface-dark rounded-[2.5rem] p-8 shadow-2xl border border-white dark:border-white/5 relative overflow-hidden ring-1 ring-black/5 group">
                        {/* Background Decoration */}
                        <div
                            className="absolute top-0 left-0 w-full h-32 pointer-events-none transition-all duration-500 ease-in-out"
                            style={{
                                background: profile.avatar_color || 'linear-gradient(135deg, #FF9A8B 0%, #FF6A88 55%, #FF99AC 100%)',
                                maskImage: 'linear-gradient(to bottom, black 60%, transparent 100%)',
                                WebkitMaskImage: 'linear-gradient(to bottom, black 60%, transparent 100%)'
                            }}
                        ></div>

                        <div className="relative pt-16 flex flex-col items-center text-center gap-4">
                            {/* Avatar */}
                            <div className="relative">
                                <div
                                    className="relative w-28 h-28 rounded-full flex items-center justify-center text-4xl font-black text-white border-[6px] border-white dark:border-surface-dark shadow-[0_20px_50px_rgba(0,0,0,0.15)] overflow-hidden transition-all duration-500 group-hover:scale-105"
                                    style={{ background: profile.avatar_url ? 'white' : (profile.avatar_color || 'linear-gradient(135deg, #FF9A8B 0%, #FF6A88 55%, #FF99AC 100%)') }}
                                >
                                    {profile.avatar_url ? (
                                        <img src={profile.avatar_url} alt={profile.name} className="absolute inset-0 w-full h-full object-cover z-0" />
                                    ) : (
                                        <span className="drop-shadow-[0_2px_4px_rgba(0,0,0,0.3)] relative z-0">
                                            {profile.name?.charAt(0).toUpperCase()}
                                        </span>
                                    )}
                                    {prestige?.planet_level && <AvatarAura level={profile.selected_prestige_level || prestige.planet_level} />}
                                </div>
                                <div className="absolute bottom-2 right-2 w-7 h-7 bg-green-500 border-[4px] border-white dark:border-surface-dark rounded-full shadow-lg z-20"></div>
                            </div>

                            {/* Info Section */}
                            <div className="flex flex-col items-center z-10 w-full overflow-visible gap-1">
                                <h1 className="text-3xl font-black text-text-main dark:text-white tracking-tight break-words max-w-full px-4">
                                    {profile.name}
                                </h1>

                                {profile.equipped_title && (
                                    (() => {
                                        const style = getUniqueTitleStyle(profile.equipped_title.category, profile.equipped_title.threshold);
                                        return (
                                            <div
                                                className={`flex items-center gap-1.5 bg-gradient-to-br ${style.bg} px-3 py-1.5 rounded-full border ${style.border} shadow-lg ${style.glow} group/title hover:scale-105 transition-all duration-300 overflow-hidden relative ${style.extraClasses || ''}`}
                                            >
                                                <div className={`flex items-center relative z-10 justify-center`}>
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
                                    })()
                                )}

                                {/* Prestige Status Widget */}
                                {prestige && profile.show_prestige !== false && (
                                    <div className="mt-2 transform hover:scale-[1.02] transition-transform duration-300 relative z-20 w-full flex justify-center overflow-visible">
                                        <PrestigeWidget
                                            compact={true}
                                            // Use selected level if set, otherwise fallback to current actual level
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

                                {/* Email (Owner Only or if available) */}
                                {isOwner && currentUser?.email && (
                                    <p className="text-sm text-gray-500 font-medium px-4 truncate w-full">{currentUser.email}</p>
                                )}

                                {/* Bio (Moved below widget) */}
                                {profile.bio && (
                                    <p className="text-sm text-gray-600 dark:text-gray-300 mt-3 font-medium italic px-4 leading-relaxed">
                                        "{profile.bio}"
                                    </p>
                                )}
                            </div>

                            {/* Stats Grid */}
                            <div className="grid grid-cols-3 gap-2 mt-4 mb-2 w-full max-w-md">
                                <div className="flex flex-col items-center p-2 rounded-xl">
                                    <span className="text-xl font-black text-text-main dark:text-white">{stats.posts}</span>
                                    <span className="text-[10px] font-bold text-gray-400 tracking-wider uppercase">Posts</span>
                                </div>
                                <div className="flex flex-col items-center p-2 rounded-xl">
                                    <span className="text-xl font-black text-text-main dark:text-white">{stats.friends}</span>
                                    <span className="text-[10px] font-bold text-gray-400 tracking-wider uppercase">Friends</span>
                                </div>
                                <div className="flex flex-col items-center p-2 rounded-xl">
                                    <span className="text-xl font-black text-text-main dark:text-white">{stats.channels}</span>
                                    <span className="text-[10px] font-bold text-gray-400 tracking-wider uppercase">Channel Follower</span>
                                </div>
                            </div>

                            {/* Actions */}
                            <div className="flex flex-wrap gap-3 justify-center w-full mt-4">
                                {!isOwner && (
                                    <>
                                        {friendStatus === 'none' && (
                                            <button onClick={handleAddFriend} className="px-6 py-3 rounded-xl bg-primary text-[#1c1a0d] font-bold shadow-lg shadow-primary/20 hover:brightness-105 active:scale-95 transition-all flex items-center justify-center gap-2 text-sm">
                                                <span className="material-symbols-outlined text-lg">person_add</span>
                                                Add Friend
                                            </button>
                                        )}
                                        {friendStatus === 'pending_sent' && (
                                            <button disabled className="px-6 py-3 rounded-xl bg-gray-100 dark:bg-gray-800 text-gray-400 font-bold cursor-not-allowed flex items-center justify-center gap-2 border border-gray-200 dark:border-gray-700 text-sm">
                                                <span className="material-symbols-outlined text-lg">hourglass_empty</span>
                                                Request Sent
                                            </button>
                                        )}
                                        {friendStatus === 'friends' && (
                                            <button onClick={handleStartDM} className="px-6 py-3 rounded-xl bg-black dark:bg-white text-white dark:text-black font-bold shadow-lg hover:opacity-90 active:scale-95 transition-all flex items-center justify-center gap-2 text-sm">
                                                <span className="material-symbols-outlined text-lg">chat</span>
                                                Message
                                            </button>
                                        )}
                                    </>
                                )}
                                {isOwner && (
                                    <button onClick={() => navigate('/settings/profile', { state: { from: `profile/${userId}` } })} className="px-6 py-3 rounded-xl bg-gray-100 dark:bg-gray-800 text-text-main dark:text-white font-bold hover:bg-gray-200 dark:hover:bg-gray-700 transition-all flex items-center justify-center gap-2 border border-gray-200 dark:border-gray-700 text-sm">
                                        <span className="material-symbols-outlined text-lg">edit</span>
                                        Edit Profile
                                    </button>
                                )}
                            </div>
                        </div>

                        {/* Streak Banner */}
                        <div className="px-8 pb-8">
                            <div className="w-full h-px bg-gray-100 dark:bg-gray-800 mb-6"></div>
                            <div className="flex items-center justify-between mb-4">
                                <div className="flex items-center gap-2">
                                    <span className={`material-symbols-outlined ${isStreakValid ? 'text-orange-500' : 'text-blue-400'} text-lg`}>
                                        {isStreakValid ? 'local_fire_department' : 'ac_unit'}
                                    </span>
                                    <span className="text-xs font-bold text-text-main dark:text-white uppercase tracking-wider">Login Streak</span>
                                </div>
                                {isOwner && !isStreakValid && (
                                    <button onClick={handleMonthlyRepair} className="text-xs font-bold text-primary hover:text-primary-dark transition-colors flex items-center gap-1 bg-primary/10 px-3 py-1 rounded-full animate-pulse shadow-sm">
                                        <span className="material-symbols-outlined text-sm">build</span>
                                        Repair (<PointsCoin size="sm" /> 100)
                                    </button>
                                )}
                            </div>
                            <div className={`bg-gradient-to-r ${isStreakValid
                                ? 'from-orange-50 to-orange-100/50 dark:from-orange-900/10 dark:to-orange-900/5 border-orange-100 dark:border-orange-900/20'
                                : 'from-blue-50 to-blue-100/50 dark:from-blue-900/10 dark:to-blue-900/5 border-blue-100 dark:border-blue-900/20'} border rounded-2xl p-4 sm:p-6 flex items-center gap-6 shadow-sm transition-all duration-700`}>
                                <div className={`bg-white dark:bg-white/10 w-16 h-16 rounded-2xl flex items-center justify-center shadow-sm text-3xl shrink-0 ${isStreakValid ? 'animate-bounce-slow' : 'opacity-50 grayscale rotate-12'}`}>
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
                                        <div key={i} className={`w-2 h-8 rounded-full ${isStreakValid && i < (displayStreak % 7 || 7) ? 'bg-orange-500' : 'bg-gray-200 dark:bg-gray-700'}`}></div>
                                    ))}
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div >
    );
};
