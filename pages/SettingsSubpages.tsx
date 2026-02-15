import React, { useState, useEffect } from 'react';
import { useApp } from '../AppContext';
import { useNavigate, useLocation } from 'react-router-dom';
import { Navbar } from '../components/Navbar';
import { authApi } from '../src/services/api';
import { supabase } from '../src/services/supabaseClient';
import { useToast } from '../components/Toast';
import { Title, UserTitle } from '../types';
import { PointsCoin } from '../components/PointsCoin';


const SubpageLayout = ({ title, children, maxWidth = "max-w-4xl" }: { title: string, children: React.ReactNode, maxWidth?: string }) => {
  const navigate = useNavigate();
  const location = useLocation();
  const fromProfile = location.state?.from?.startsWith('profile');

  const handleBack = () => {
    if (fromProfile) {
      navigate(-1);
    } else {
      navigate('/settings');
    }
  };

  return (
    <div className="h-full bg-background-light dark:bg-background-dark text-text-main dark:text-gray-100 flex flex-col overflow-hidden">
      <Navbar />
      <div className="flex-1 overflow-y-auto overflow-x-hidden p-4 sm:p-6 scroll-smooth">
        <div className={`w-full ${maxWidth} mx-auto flex flex-col gap-6 pt-16 pb-10 animate-fade-in`}>
          <button
            onClick={handleBack}
            className="flex items-center gap-2 text-sm font-bold text-gray-500 hover:text-text-main dark:text-gray-400 dark:hover:text-white transition-colors w-fit"
          >
            <span className="material-symbols-outlined">arrow_back</span>
            {fromProfile ? 'Back to Profile' : 'Back to Settings'}
          </button>

          <div className="flex items-center justify-between">
            <h1 className="text-3xl font-black tracking-tight">{title}</h1>
          </div>

          <div className="bg-white dark:bg-surface-dark rounded-3xl border border-gray-200 dark:border-gray-800 p-6 sm:p-8 shadow-sm">
            {children}
          </div>
        </div>
      </div>
    </div>
  );
};

// Gradient Presets - More Vibrant
const GRADIENTS = [
  { name: 'Sunrise', value: 'linear-gradient(135deg, #FF9A8B 0%, #FF6A88 55%, #FF99AC 100%)' },
  { name: 'Aurora', value: 'linear-gradient(135deg, #43E97B 0%, #38F9D7 100%)' },
  { name: 'Aqua', value: 'linear-gradient(135deg, #21D4FD 0%, #B721FF 100%)' },
  { name: 'Sunset', value: 'linear-gradient(135deg, #FAD961 0%, #F76B1C 100%)' },
  { name: 'Cosmic', value: 'linear-gradient(135deg, #F093FB 0%, #F5576C 100%)' },
  { name: 'Deep Sea', value: 'linear-gradient(135deg, #09203F 0%, #537895 100%)' },
  { name: 'Lavender', value: 'linear-gradient(135deg, #a18cd1 0%, #fbc2eb 100%)' }
];

const TITLE_STYLES: Record<string, { bg: string, border: string, text: string, glow: string, icon: string, extraClasses?: string }> = {
  streak: {
    bg: 'from-orange-400 via-red-500 to-red-600',
    border: 'border-orange-300',
    text: 'text-white',
    glow: 'shadow-orange-500/20',
    icon: 'local_fire_department'
  },
  mastery_unit: {
    bg: 'from-cyan-400 via-blue-500 to-blue-600',
    border: 'border-cyan-300',
    text: 'text-white',
    glow: 'shadow-cyan-500/20',
    icon: 'workspace_premium'
  },
  mastery_course: {
    bg: 'from-fuchsia-400 via-purple-600 to-indigo-700',
    border: 'border-purple-300',
    text: 'text-white',
    glow: 'shadow-purple-500/20',
    icon: 'trophy'
  },
  social: {
    bg: 'from-emerald-400 via-teal-500 to-teal-600',
    border: 'border-emerald-300',
    text: 'text-white',
    glow: 'shadow-emerald-500/20',
    icon: 'diversity_3'
  },
  influence: {
    bg: 'from-yellow-300 via-amber-500 to-orange-600',
    border: 'border-yellow-200',
    text: 'text-[#1c1a0d]',
    glow: 'shadow-amber-500/20',
    icon: 'auto_awesome'
  },
  seniority: {
    bg: 'from-amber-500 via-amber-800 to-stone-900',
    border: 'border-amber-400/50',
    text: 'text-amber-50',
    glow: 'shadow-amber-900/40',
    icon: 'military_tech'
  }
};

const getTitleVisualLevel = (category: string, threshold: number): number => {
  const t = Number(threshold);

  if (category === 'mastery_course') {
    return t === 1 ? 5 : 6; // AB = Level 5, BC = Level 6
  }

  if (category === 'seniority') {
    if (t >= 3650) return 6;
    if (t >= 2555) return 5;
    if (t >= 1460) return 4;
    if (t >= 730) return 3;
    if (t >= 365) return 2;
    return 1;
  } else if (category === 'streak') {
    if (t >= 365) return 6;
    if (t >= 180) return 5;
    if (t >= 100) return 4;
    if (t >= 30) return 3;
    if (t >= 7) return 2;
    return 1;
  } else if (category === 'mastery_unit') {
    if (t >= 10) return 6;
    if (t >= 8) return 5;
    if (t >= 6) return 4;
    if (t >= 4) return 3;
    if (t >= 2) return 2;
    return 1;
  } else if (category === 'social') {
    if (t >= 200) return 6;
    if (t >= 100) return 5;
    if (t >= 50) return 4;
    if (t >= 30) return 3;
    if (t >= 10) return 2;
    return 1;
  } else if (category === 'influence') {
    if (t >= 5000) return 6;
    if (t >= 2500) return 5;
    if (t >= 1000) return 4;
    if (t >= 250) return 3;
    if (t >= 50) return 2;
    return 1;
  }
  return 1;
};

const getTitleTierStyles = (level: number, category: string) => {
  const base = TITLE_STYLES[category] || TITLE_STYLES.streak;

  // L6: Mythic / Divine (Mesh/Liquid Gradient Deviation)
  if (level === 6) {
    const isDark = category !== 'influence';
    return {
      ...base,
      bg: category === 'seniority'
        ? 'from-black via-amber-900 to-black'
        : (isDark ? 'from-black via-primary/40 to-black' : 'from-yellow-200 via-white to-amber-500'),
      border: 'border-white/80 shadow-[0_0_30px_rgba(255,255,255,0.4)] ring-2 ring-primary/60 scale-110',
      text: isDark ? 'text-white' : 'text-black',
      glow: 'shadow-primary/60 animate-pulse-neon',
      extraClasses: 'mesh-liquid overflow-hidden !border-opacity-100 shimmer-sweep'
    };
  }

  // L5: Legendary (Shimmer + Neon Pulse)
  if (level === 5) {
    return {
      ...base,
      border: 'border-white/60 shadow-[0_0_20px_rgba(255,255,255,0.3)]',
      glow: 'shadow-primary/40 animate-pulse',
      extraClasses: 'shimmer-sweep scale-105 overflow-hidden'
    };
  }

  // L4: Epic (Moving Flowing Gradient)
  if (level === 4) {
    return {
      ...base,
      border: 'border-white/40 shadow-[0_0_15px_rgba(255,255,255,0.2)]',
      glow: base.glow.replace('/20', '/60'),
      extraClasses: 'animate-gradient-x'
    };
  }

  // L3: Rare (Vibrant + Inner Glow)
  if (level === 3) {
    return {
      ...base,
      border: 'border-white/30 shadow-[inset_0_0_10px_rgba(255,255,255,0.2)]',
      glow: base.glow.replace('/20', '/40'),
    };
  }

  // L2: Advanced (Glassy Border)
  if (level === 2) {
    return {
      ...base,
      border: 'border-white/20',
      glow: base.glow.replace('/20', '/30'),
    };
  }

  // L1: Starter
  return base;
};

const getIconCount = (level: number) => {
  if (level >= 5) return 3;
  if (level >= 3) return 2;
  return 1;
};

export const ProfileSettings = () => {
  const { user, updateUser, isPro, setShowPaywall, availableTitles } = useApp();
  const { showToast } = useToast();

  // State from User Context & DB (Initialize with User Context Defaults where possible)
  const [name, setName] = useState(user.name || '');
  const [email, setEmail] = useState(user.email || '');
  const [bio, setBio] = useState(user.bio || '');
  const [avatarUrl, setAvatarUrl] = useState(user.avatarUrl || '');
  const [avatarColor, setAvatarColor] = useState(user.avatarColor || 'linear-gradient(135deg, #FFD700 0%, #FF8C00 100%)');
  const [streak, setStreak] = useState(user.streakDays || 0);
  const [stats, setStats] = useState(user.stats || { posts: 0, friends: 0, channels: 0 });
  const [unlockedTitles, setUnlockedTitles] = useState<UserTitle[]>([]);
  const [selectedTitleId, setSelectedTitleId] = useState<string | null>(user.equippedTitleId || null);
  const [lastSelectedTitleId, setLastSelectedTitleId] = useState<string | null>(null);

  // Visibility States
  const [showName, setShowName] = useState(user.showName ?? true);
  const [showEmail, setShowEmail] = useState(user.showEmail ?? false);
  const [showBio, setShowBio] = useState(user.showBio ?? true);

  // UI States
  const [isSaving, setIsSaving] = useState(false);
  const [activeTab, setActiveTab] = useState<'seniority' | 'streak' | 'mastery' | 'social' | 'influence'>('seniority');
  const [isLoadingDetails, setIsLoadingDetails] = useState(true); // Renamed, used only for specific UI hints if needed

  // File Upload State
  const [file, setFile] = useState<File | null>(null);
  const [previewUrl, setPreviewUrl] = useState<string | null>(null);

  // Verification State
  const [showVerifyModal, setShowVerifyModal] = useState(false);
  const [pendingEmail, setPendingEmail] = useState('');
  const [verifyCode, setVerifyCode] = useState(['', '', '', '', '', '']);
  const [isVerifying, setIsVerifying] = useState(false);

  // 1. Fetch Extended Profile Data on Mount (Non-blocking)
  useEffect(() => {
    const fetchDetails = async () => {
      if (!user?.id) return;
      try {
        // Profile data is now primarily handled by the pre-fetch in AppContext
        // We only fetch titles here
        if (user.avatarColor) setAvatarColor(user.avatarColor);
        if (user.bio) setBio(user.bio);
        if (user.streakDays) setStreak(user.streakDays);
        if (user.showName !== undefined) setShowName(user.showName);
        if (user.showEmail !== undefined) setShowEmail(user.showEmail);
        if (user.showBio !== undefined) setShowBio(user.showBio);
        if (user.equippedTitleId) setSelectedTitleId(user.equippedTitleId);

        // Fetch Unlocked Titles
        const { data: titlesData } = await supabase
          .from('user_titles')
          .select('*, title:titles(*)')
          .eq('user_id', user.id);

        if (titlesData) setUnlockedTitles(titlesData as any);

        // All Titles and Stats are now primarily handled by the fetch above or AppContext pre-fetch
        if (user.stats) setStats(user.stats);

      } catch (error) {
        console.error('Error fetching details:', error);
      } finally {
        setIsLoadingDetails(false);
      }
    };
    fetchDetails();
  }, [user.id]);

  // 2. Handle File Preview
  useEffect(() => {
    if (!file) return;
    const objectUrl = URL.createObjectURL(file);
    setPreviewUrl(objectUrl);
    return () => URL.revokeObjectURL(objectUrl);
  }, [file]);

  const handleFileChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    if (e.target.files && e.target.files[0]) {
      setFile(e.target.files[0]);
    }
  };

  // 3. Save Logic
  const handleSave = async () => {
    setIsSaving(true);
    let hasUpdates = false;

    try {
      let finalAvatarUrl = avatarUrl;

      // A. Upload Avatar if changed
      if (file) {
        const fileExt = file.name.split('.').pop();
        const fileName = `${Date.now()}.${fileExt}`;
        const filePath = `${user.id}/${fileName}`;

        const { error: uploadError } = await supabase.storage
          .from('avatars')
          .upload(filePath, file, { upsert: true });

        if (uploadError) throw uploadError;

        const { data: { publicUrl } } = supabase.storage
          .from('avatars')
          .getPublicUrl(filePath);

        finalAvatarUrl = publicUrl;
        hasUpdates = true;
      }

      // B. Consolidate Updates into Context
      // This will handle both local state and database sync automatically
      const selectedTitle = availableTitles.find(t => t.id === selectedTitleId);

      const contextUpdates: any = {
        name,
        avatarUrl: finalAvatarUrl,
        bio,
        avatarColor,
        showName,
        showEmail,
        showBio,
        equippedTitleId: selectedTitleId,
        equippedTitle: selectedTitle || null
      };

      // Handle Auth Name separately if changed
      if (name !== user.name) {
        await supabase.auth.updateUser({ data: { name: name } });
      }

      updateUser(contextUpdates);
      hasUpdates = true;

      // C. Handle Email Change
      if (email !== user.email) {
        setPendingEmail(email);
        setVerifyCode(['', '', '', '', '', '']);
        await authApi.initiateChangeEmail(email);
        setShowVerifyModal(true);
        // We stop here to wait for verification
        setIsSaving(false);
        return;
      }

      showToast('Profile updated successfully!', 'success');

    } catch (error: any) {
      console.error('Update error:', error);
      showToast(error.message || 'Failed to update profile', 'error');
    } finally {
      setIsSaving(false);
    }
  };

  // Helper for Initials
  const getInitials = (n: string) => n.split(' ').map(i => i[0]).join('').substring(0, 2).toUpperCase();

  // Code Input Handlers
  const handleCodeChange = (index: number, value: string) => {
    if (value.length > 1) return;
    const newCode = [...verifyCode];
    newCode[index] = value;
    setVerifyCode(newCode);
    if (value && index < 5) document.getElementById(`verify-input-${index + 1}`)?.focus();
  };

  const handleKeyDown = (index: number, e: React.KeyboardEvent) => {
    if (e.key === 'Backspace' && !verifyCode[index] && index > 0) {
      document.getElementById(`verify-input-${index - 1}`)?.focus();
    }
  };

  const handleVerify = async () => {
    const code = verifyCode.join('');
    if (code.length !== 6) return showToast('Please enter the complete 6-digit code', 'error');
    setIsVerifying(true);
    try {
      const res = await authApi.verifyChangeEmail(pendingEmail, code, user.id);
      if (res.success) {
        updateUser({ email: pendingEmail });
        setShowVerifyModal(false);
        setVerifyCode(['', '', '', '', '', '']);
        showToast('Email verified and updated successfully', 'success');
      }
    } catch (error: any) {
      showToast(error.message || 'Verification failed', 'error');
    } finally {
      setIsVerifying(false);
    }
  };

  // REMOVED BLOCKING LOADING CHECK FOR BETTER UX

  // --- Render Helpers ---

  const Toggle = ({ c, onChange }: { c: boolean, onChange: (v: boolean) => void }) => (
    <label className="relative inline-flex items-center cursor-pointer ml-auto">
      <input type="checkbox" className="sr-only peer" checked={c} onChange={(e) => onChange(e.target.checked)} />
      <div className="w-11 h-6 bg-gray-200 peer-focus:outline-none rounded-full peer dark:bg-gray-700 peer-checked:after:translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-[2px] after:left-[2px] after:bg-white after:border-gray-300 after:border after:rounded-full after:h-5 after:w-5 after:transition-all peer-checked:bg-primary"></div>
    </label>
  );

  return (
    <SubpageLayout title="Edit Profile" maxWidth="max-w-[1400px]">
      <div className="flex flex-col xl:flex-row gap-8 xl:gap-12 relative items-start">

        {/* Left Column: Edit Form */}
        <div className="flex-[3] flex flex-col gap-8 order-2 xl:order-1 w-full bg-white dark:bg-surface-dark rounded-3xl p-8">

          <div className={`grid grid-cols-1 md:grid-cols-2 gap-8 ${!isPro ? 'opacity-50 pointer-events-none' : ''}`}>
            {/* 1. Avatar Section (Left) */}
            <div className="flex flex-col gap-4">
              <label className="text-sm font-bold text-gray-700 dark:text-gray-300 uppercase tracking-wider">Avatar Image</label>
              <div className="flex items-center gap-6">
                <div className="relative group cursor-pointer inline-block">
                  <div
                    className="w-28 h-28 rounded-full relative flex items-center justify-center overflow-hidden border-4 border-white dark:border-surface-dark shadow-lg ring-2 ring-gray-100 dark:ring-gray-700 hover:ring-primary transition-all"
                    onClick={() => document.getElementById('avatar-upload')?.click()}
                    style={{ background: !previewUrl && !avatarUrl ? avatarColor : '#f3f4f6' }}
                  >
                    {previewUrl || (avatarUrl && !isSaving) ? (
                      <img src={previewUrl || avatarUrl} alt="Avatar" className="w-full h-full object-cover" />
                    ) : (
                      <span className="text-3xl font-black text-white drop-shadow-md">{name ? getInitials(name) : '?'}</span>
                    )}

                    {/* Edit Overlay */}
                    <div className="absolute inset-0 bg-black/40 flex items-center justify-center opacity-0 group-hover:opacity-100 transition-opacity rounded-full z-10">
                      <span className="material-symbols-outlined text-white text-2xl">edit</span>
                    </div>
                  </div>
                  <input
                    id="avatar-upload"
                    type="file"
                    accept="image/*"
                    className="hidden"
                    onChange={handleFileChange}
                  />
                </div>
                <div className="flex flex-col gap-2">
                  <button
                    onClick={() => document.getElementById('avatar-upload')?.click()}
                    className="px-5 py-2.5 bg-gray-100 hover:bg-gray-200 dark:bg-white/10 dark:hover:bg-white/20 rounded-xl text-sm font-bold transition-colors w-fit"
                  >
                    Upload New Photo
                  </button>
                  <p className="text-xs text-gray-400 max-w-[160px] leading-relaxed">
                    Recommended: Square JPG/PNG. Max 5MB.
                  </p>
                </div>
              </div>
            </div>

            {/* 2. Avatar Background (Right of Avatar) */}
            <div className="flex flex-col gap-4">
              <label className="text-sm font-bold text-gray-700 dark:text-gray-300 uppercase tracking-wider">Avatar Background</label>
              <div className="flex gap-4 flex-wrap">
                {GRADIENTS.map(g => (
                  <button
                    key={g.name}
                    onClick={() => setAvatarColor(g.value)}
                    className={`w-14 h-14 rounded-full border-2 border-gray-100 dark:border-gray-700 transition-transform hover:scale-110 shadow-sm ${avatarColor === g.value ? 'ring-2 ring-offset-2 ring-primary scale-110 border-transparent' : ''}`}
                    style={{ background: g.value }}
                    title={g.name}
                  />
                ))}

                {/* Custom Color Picker */}
                <div className="relative group">
                  <div
                    className={`w-14 h-14 rounded-full border-2 flex items-center justify-center cursor-pointer transition-all duration-300 hover:scale-110 shadow-sm ${!GRADIENTS.find(g => g.value === avatarColor) && !avatarColor.includes('gradient') ? 'ring-2 ring-offset-2 ring-primary border-transparent' : 'border-gray-200 dark:border-gray-700'}`}
                    style={{ background: !GRADIENTS.find(g => g.value === avatarColor) && !avatarColor.includes('gradient') ? avatarColor : 'transparent' }}
                  >
                    <span className={`material-symbols-outlined text-2xl transition-colors ${!GRADIENTS.find(g => g.value === avatarColor) && !avatarColor.includes('gradient') ? 'text-white drop-shadow-md' : 'text-gray-400'}`}>
                      palette
                    </span>
                  </div>
                  <input
                    type="color"
                    value={!GRADIENTS.find(g => g.value === avatarColor) && !avatarColor.includes('gradient') ? avatarColor : '#000000'}
                    onChange={(e) => setAvatarColor(e.target.value)}
                    className="absolute inset-0 opacity-0 cursor-pointer w-full h-full"
                    title="Custom Color"
                  />
                </div>
              </div>
            </div>
          </div>

          {!isPro && (
            <div className="mt-4 p-4 bg-primary/10 border border-primary/20 rounded-2xl flex flex-col sm:flex-row items-center justify-between gap-4">
              <div className="flex items-center gap-3">
                <span className="material-symbols-outlined text-primary">auto_awesome</span>
                <p className="text-sm font-bold text-primary">Upgrade to Pro to customize your avatar and identity.</p>
              </div>
              <button
                onClick={() => setShowPaywall(true)}
                className="px-6 py-2 bg-primary text-black rounded-xl font-black text-xs hover:brightness-110 active:scale-95 transition-all w-full sm:w-auto"
              >
                Learn More
              </button>
            </div>
          )}

          <div className="w-full h-px bg-gray-100 dark:bg-gray-800"></div>

          {/* 3. Basic Info Section */}
          <div className="space-y-6">
            <h2 className="text-xl font-black flex items-center gap-2">
              <span className="material-symbols-outlined text-primary">person</span>
              Basic Settings
            </h2>

            <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
              <div>
                <div className="flex items-center justify-between h-10 mb-2">
                  <div className="flex flex-col">
                    <label className="block text-sm font-bold text-gray-400 uppercase tracking-wider">Username</label>
                    <div className="flex items-center gap-1 opacity-70">
                      <span className="material-symbols-outlined text-[10px] text-primary">edit_note</span>
                      <span className="text-[9px] font-black uppercase text-primary">1 Opportunity</span>
                    </div>
                  </div>
                  <div className="flex items-center gap-2 bg-gray-50 dark:bg-white/5 px-3 py-1.5 rounded-xl border border-gray-100 dark:border-white/5 h-full">
                    <span className="text-[10px] font-bold text-gray-400 uppercase tracking-tighter shrink-0">{showName ? 'Public' : 'Hidden'}</span>
                    <Toggle c={showName} onChange={setShowName} />
                  </div>
                </div>
                <input
                  type="text"
                  value={name}
                  onChange={(e) => setName(e.target.value)}
                  className="w-full p-4 rounded-2xl border-2 border-gray-100 dark:border-gray-800 bg-white dark:bg-black/20 outline-none focus:border-primary/50 transition-all font-bold"
                  placeholder="Enter your username"
                />
                <p className="mt-2 text-xs text-gray-400 italic">
                  Username can be changed once every 6 months.
                </p>
              </div>

              <div className="flex flex-col gap-2">
                <div className="flex items-center justify-between h-10 mb-2">
                  <div className="flex flex-col">
                    <label className="block text-sm font-bold text-gray-400 uppercase tracking-wider">Email Address</label>
                    <div className="h-3.5" /> {/* Empty spacer to match Username's Opportunity text height */}
                  </div>
                  <div className="flex items-center gap-2 bg-gray-50 dark:bg-white/5 px-3 py-1.5 rounded-xl border border-gray-100 dark:border-white/5 h-full">
                    <span className="text-[10px] font-bold text-gray-400 uppercase tracking-tighter shrink-0">{showEmail ? 'Public' : 'Hidden'}</span>
                    <Toggle c={showEmail} onChange={setShowEmail} />
                  </div>
                </div>
                <input
                  type="email"
                  value={email}
                  onChange={(e) => setEmail(e.target.value)}
                  className="w-full p-4 rounded-2xl border-2 border-gray-100 dark:border-gray-800 bg-white dark:bg-black/20 outline-none focus:border-primary/50 transition-all font-bold"
                  placeholder="Enter your email"
                />
              </div>
            </div>

            <div className="flex flex-col gap-2">
              <div className="flex items-center justify-between">
                <label className="block text-sm font-bold text-gray-700 dark:text-gray-300 uppercase tracking-wider">Personal Bio</label>
                <div className="flex items-center gap-2">
                  <span className="text-xs font-medium text-gray-400">{showBio ? 'Visible' : 'Hidden'}</span>
                  <Toggle c={showBio} onChange={setShowBio} />
                </div>
              </div>
              <textarea
                value={bio}
                onChange={(e) => setBio(e.target.value)}
                maxLength={100}
                className="w-full p-4 rounded-2xl border-2 border-gray-100 dark:border-gray-800 bg-white dark:bg-black/20 outline-none focus:border-primary/50 transition-all font-medium h-24 resize-none"
                placeholder="Tell us about yourself..."
              />
              <p className="text-right text-[10px] text-gray-400 font-bold uppercase tracking-wider">{bio.length}/100</p>
            </div>
          </div>

          <div className="w-full h-px bg-gray-100 dark:bg-gray-800"></div>

          {/* 4. Achievement Titles */}
          <div className={`flex flex-col gap-4 ${!isPro ? 'opacity-50 pointer-events-none' : ''}`}>
            <div className="flex items-center justify-between mb-2">
              <label className="text-sm font-black text-gray-700 dark:text-gray-300 uppercase tracking-widest flex items-center gap-2">
                <span className="material-symbols-outlined text-primary text-xl">military_tech</span>
                Achievement Title
              </label>
              <button
                onClick={() => {
                  if (selectedTitleId === null) {
                    if (lastSelectedTitleId) setSelectedTitleId(lastSelectedTitleId);
                  } else {
                    setLastSelectedTitleId(selectedTitleId);
                    setSelectedTitleId(null);
                  }
                }}
                className={`px-4 py-1.5 rounded-xl text-[10px] font-black uppercase transition-all flex items-center gap-2 border-2 ${selectedTitleId === null
                  ? 'bg-red-50 text-red-600 border-red-200 shadow-sm'
                  : 'bg-white dark:bg-white/5 border-gray-100 dark:border-white/10 text-gray-400 hover:border-red-400/50 hover:text-red-500'
                  }`}
              >
                <span className="material-symbols-outlined text-[14px]">block</span>
                Unequip
              </button>
            </div>

            {/* Category Tabs */}
            <div className="flex gap-2 p-1.5 bg-gray-100/50 dark:bg-white/5 rounded-2xl mb-4 overflow-x-auto no-scrollbar">
              {(['seniority', 'streak', 'mastery', 'social', 'influence'] as const).map(tab => (
                <button
                  key={tab}
                  onClick={() => setActiveTab(tab)}
                  className={`px-4 py-2.5 rounded-xl text-[10px] font-black uppercase tracking-wider transition-all flex-shrink-0 whitespace-nowrap ${activeTab === tab
                    ? 'bg-white dark:bg-zinc-800 text-stone-900 dark:text-white shadow-md'
                    : 'text-gray-500 hover:text-gray-800 dark:hover:text-gray-300'
                    }`}
                >
                  {tab}
                </button>
              ))}
            </div>

            <div className="bg-white/60 dark:bg-black/20 rounded-3xl border border-gray-100 dark:border-white/5 transition-all p-5 flex items-center justify-center py-6 min-h-[120px]">
              <div className="grid grid-cols-4 sm:grid-cols-6 md:grid-cols-6 gap-y-12 gap-x-10 w-full max-w-2xl">
                {availableTitles
                  .filter(t => {
                    if (activeTab === 'mastery') return t.category.startsWith('mastery');
                    return t.category === activeTab;
                  })
                  .map(t => {
                    const isUnlocked = unlockedTitles.some(ut => ut.title_id === t.id);
                    const isEquipped = selectedTitleId === t.id;
                    const level = getTitleVisualLevel(t.category, t.threshold);
                    const style = getTitleTierStyles(level, t.category);

                    return (
                      <div key={t.id} className="flex flex-col items-center group relative hover:z-[110]">
                        <button
                          onClick={() => {
                            if (!isUnlocked) return;
                            if (selectedTitleId === t.id) {
                              setLastSelectedTitleId(t.id);
                              setSelectedTitleId(null);
                            } else {
                              setSelectedTitleId(t.id);
                            }
                          }}
                          disabled={!isUnlocked}
                          className={`w-14 h-14 rounded-full flex items-center justify-center transition-all relative overflow-hidden isolate ${!isUnlocked
                            ? 'grayscale opacity-40 cursor-not-allowed'
                            : isEquipped
                              ? `z-10 shadow-xl scale-125`
                              : `opacity-80 hover:opacity-100 hover:scale-110 shadow-sm`
                            }`}
                          style={{
                            maskImage: 'radial-gradient(circle, #fff 100%, transparent 100%)',
                            WebkitMaskImage: 'radial-gradient(circle, #fff 100%, transparent 100%)',
                            transform: isEquipped ? 'scale(1.25) translateZ(0)' : 'translateZ(0)',
                            backfaceVisibility: 'hidden',
                            clipPath: 'circle(50%)'
                          }}
                        >
                          {/* 1. Background Layer */}
                          <div
                            className={`absolute inset-0 transition-opacity ${!isUnlocked
                              ? 'bg-gray-200/50 shadow-inner'
                              : `bg-gradient-to-br ${style.bg} ${style.extraClasses || ''}`
                              }`}
                            style={{ backgroundSize: level >= 3 ? '200% 200%' : 'auto' }}
                          />

                          {/* 2. Equipped Glow/Pulse */}
                          {isEquipped && (
                            <div className={`absolute inset-0 bg-white/10 animate-pulse z-10 ${style.glow}`} />
                          )}

                          {/* 3. Icon Content */}
                          <div className={`flex items-center relative z-20 ${style.text} ${getIconCount(level) === 1 ? '' : getIconCount(level) === 2 ? '-space-x-0.5' : getIconCount(level) === 3 ? '-space-x-1' : '-space-x-1.5'}`}>
                            {Array.from({ length: getIconCount(level) }).map((_, i) => (
                              <span
                                key={i}
                                className="material-symbols-outlined relative z-10 transition-all duration-300"
                                style={{
                                  fontSize: getIconCount(level) === 1 ? '28px' : getIconCount(level) === 2 ? '24px' : getIconCount(level) === 3 ? '20px' : '18px',
                                  opacity: getIconCount(level) > 1 ? 0.9 + (i * 0.03) : 1,
                                  transform: getIconCount(level) > 1 ? `translateY(${i % 2 === 0 ? '-2px' : '2px'})` : 'none'
                                }}
                              >
                                {style.icon}
                              </span>
                            ))}
                          </div>

                          {/* 4. Border Overlay (To ensure perfect edge) */}
                          <div className={`absolute inset-0 rounded-full border-2 ${isUnlocked
                            ? (isEquipped ? style.border : style.border.replace('border-white/80', 'border-white/30').replace('border-white/60', 'border-white/20'))
                            : 'border-transparent'
                            } z-30 pointer-events-none ${isEquipped ? 'ring-1 ring-white/20' : ''}`} />

                          {/* 5. Lock Overlay */}
                          {!isUnlocked && (
                            <div className="absolute inset-0 flex items-center justify-center bg-black/5 z-40">
                              <span className="material-symbols-outlined text-[8px] opacity-60">lock</span>
                            </div>
                          )}
                        </button>
                        <div className="absolute bottom-full left-1/2 -translate-x-1/2 mb-3 p-3 bg-gray-900 text-white text-[11px] rounded-xl shadow-2xl opacity-0 group-hover:opacity-100 pointer-events-none transition-all font-medium w-40 text-center z-[120] translate-y-2 group-hover:translate-y-0 border border-white/10">
                          <p className="font-bold mb-1 border-b border-white/10 pb-1">{t.name}</p>
                          <p className="opacity-80 leading-relaxed font-normal">{t.description}</p>
                          <div className="absolute top-full left-1/2 -translate-x-1/2 border-8 border-transparent border-t-gray-900"></div>
                        </div>
                      </div>
                    );
                  })}
              </div>
            </div>
          </div>

          {!isPro && (
            <div className="mt-4 p-4 bg-primary/10 border border-primary/20 rounded-2xl flex flex-col sm:flex-row items-center justify-between gap-4">
              <div className="flex items-center gap-3">
                <span className="material-symbols-outlined text-primary">auto_awesome</span>
                <p className="text-sm font-black text-primary uppercase tracking-tight">Upgrade to Pro to unlock achievement titles.</p>
              </div>
              <button
                onClick={() => setShowPaywall(true)}
                className="px-6 py-2 bg-primary text-black rounded-xl font-black text-xs hover:brightness-110 active:scale-95 transition-all w-full sm:w-auto"
              >
                Learn More
              </button>
            </div>
          )}
        </div>

        {/* Right Column: Live Preview (Sticky) */}
        <div className="flex-[2] order-1 xl:order-2 w-full">
          <div className="sticky top-6">
            <div className="bg-gradient-to-br from-gray-200 to-gray-300 dark:from-surface-dark dark:to-black rounded-[2.5rem] p-8 shadow-2xl border border-white dark:border-white/5 relative overflow-hidden ring-1 ring-black/5">

              <div className="flex items-center gap-2 mb-6 opacity-50">
                <span className="w-1.5 h-1.5 rounded-full bg-black dark:bg-white animate-pulse"></span>
                <h3 className="text-xs font-bold uppercase tracking-widest ">Live Preview</h3>
              </div>

              {/* Card Component */}
              <div className="bg-white dark:bg-surface-dark rounded-3xl p-6 shadow-xl w-full border border-gray-100 dark:border-gray-700/50 relative overflow-hidden transition-all duration-300 group hover:shadow-2xl">

                <div
                  className="absolute top-0 left-0 w-full h-32 pointer-events-none transition-all duration-500 ease-in-out"
                  style={{
                    background: avatarColor,
                    maskImage: 'linear-gradient(to bottom, black 60%, transparent 100%)',
                    WebkitMaskImage: 'linear-gradient(to bottom, black 60%, transparent 100%)'
                  }}
                ></div>

                <div className="relative pt-16 flex flex-col items-center text-center gap-4">
                  <div className="relative">
                    <div
                      className="w-28 h-28 rounded-full flex items-center justify-center text-4xl font-black text-white border-[6px] border-white dark:border-surface-dark shadow-[0_20px_50px_rgba(0,0,0,0.15)] overflow-hidden transition-all duration-500 group-hover:scale-105"
                      style={{ background: previewUrl || avatarUrl ? 'white' : avatarColor }}
                    >
                      {previewUrl || avatarUrl ? (
                        <img src={previewUrl || avatarUrl} alt="Avatar" className="w-full h-full object-cover" />
                      ) : (
                        <span className="drop-shadow-[0_2px_4px_rgba(0,0,0,0.3)]">
                          {name && showName ? getInitials(name) : '?'}
                        </span>
                      )}
                    </div>
                    <div className="absolute bottom-2 right-2 w-7 h-7 bg-green-500 border-[4px] border-white dark:border-surface-dark rounded-full shadow-lg z-20"></div>
                  </div>

                  <div className="flex flex-col items-center z-10 w-full overflow-hidden gap-1">
                    <h1 className="text-3xl font-black text-text-main dark:text-white tracking-tight truncate w-full px-4">
                      {showName ? (name || 'Your Name') : 'Unknown User'}
                    </h1>

                    {selectedTitleId && (
                      (() => {
                        const title = availableTitles.find(t => t.id === selectedTitleId);
                        if (!title) return null;
                        const level = getTitleVisualLevel(title.category, title.threshold);
                        const style = getTitleTierStyles(level, title.category);

                        return (
                          <div
                            className={`flex items-center gap-1 bg-gradient-to-br ${style.bg} px-3 py-1.5 rounded-full border ${style.border} shadow-lg ${style.glow} group/title hover:scale-105 transition-all duration-500 overflow-hidden relative ${style.extraClasses || ''}`}
                            style={{ backgroundSize: level >= 4 ? '200% 200%' : 'auto' }}
                          >
                            <div className={`flex items-center relative z-10 ${getIconCount(level) === 1 ? '' : getIconCount(level) === 2 ? '-space-x-0.5' : getIconCount(level) === 3 ? '-space-x-1' : '-space-x-1.5'}`}>
                              {Array.from({ length: getIconCount(level) }).map((_, i) => (
                                <span
                                  key={i}
                                  className={`material-symbols-outlined relative z-10 transition-all duration-300 ${style.text}`}
                                  style={{
                                    fontSize: getIconCount(level) === 1 ? '16px' : getIconCount(level) === 2 ? '14px' : getIconCount(level) === 3 ? '12px' : '11px',
                                    opacity: getIconCount(level) > 1 ? 0.9 + (i * 0.03) : 1,
                                    transform: getIconCount(level) > 1 ? `translateY(${i % 2 === 0 ? '-1px' : '1px'})` : 'none'
                                  }}
                                >
                                  {style.icon}
                                </span>
                              ))}
                            </div>
                            <span className={`text-[10px] font-black ${style.text} ml-1 uppercase tracking-wider relative z-10 ${level >= 5 ? 'drop-shadow-sm' : ''}`}>
                              {title.name}
                            </span>
                          </div>
                        );
                      })()
                    )}

                    {showEmail && (
                      <p className="text-sm text-gray-500 font-medium">{email}</p>
                    )}

                    {/* ID Hidden as per request */}

                    {showBio && bio && (
                      <p className="text-sm text-gray-600 dark:text-gray-300 mt-3 font-medium italic px-4 leading-relaxed">
                        "{bio}"
                      </p>
                    )}
                  </div>
                </div>

                <div className="grid grid-cols-3 gap-2 mt-8 mb-6">
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
              </div>

              {/* Save Changes Button - MOVED UNDER PREVIEW AND STYLED YELLOW */}
              <button
                onClick={handleSave}
                disabled={isSaving}
                className="mt-6 w-full py-4 bg-primary text-black rounded-2xl font-black text-lg shadow-[0_8px_20px_-4px_rgba(249,212,6,0.4)] hover:brightness-105 active:scale-95 transition-all disabled:opacity-50 flex items-center justify-center gap-3 border border-yellow-400/20"
              >
                {isSaving ? (
                  <span className="material-symbols-outlined animate-spin text-sm">progress_activity</span>
                ) : (
                  <>
                    <span className="material-symbols-outlined">verified</span>
                    <span>Save My Profile</span>
                  </>
                )}
              </button>
            </div>
          </div>
        </div>
      </div>

      {showVerifyModal && (
        <div className="fixed inset-0 z-[100] flex items-center justify-center p-6 backdrop-blur-md bg-black/20">
          <div className="bg-white dark:bg-surface-dark rounded-[2rem] p-8 w-full max-w-md shadow-2xl border border-gray-100 dark:border-gray-800 animate-in zoom-in-95 duration-300">
            <div className="flex flex-col items-center text-center gap-4">
              <div className="w-16 h-16 bg-primary/10 rounded-2xl flex items-center justify-center">
                <span className="material-symbols-outlined text-primary text-3xl">mark_email_unread</span>
              </div>
              <h3 className="text-2xl font-black">Verify New Email</h3>
              <p className="text-gray-500 text-sm">
                We've sent a 6-digit code to <span className="font-bold text-text-main dark:text-white">{pendingEmail}</span>.
              </p>
              <div className="flex gap-2 my-4">
                {verifyCode.map((digit, idx) => (
                  <input
                    key={idx}
                    id={`verify-input-${idx}`}
                    type="text"
                    maxLength={1}
                    value={digit}
                    onChange={(e) => handleCodeChange(idx, e.target.value)}
                    onKeyDown={(e) => handleKeyDown(idx, e)}
                    className="w-12 h-14 bg-gray-50 dark:bg-black/20 border-2 border-gray-100 dark:border-gray-800 rounded-xl text-center text-xl font-black outline-none focus:border-primary"
                  />
                ))}
              </div>
              <button
                onClick={handleVerify}
                disabled={isVerifying}
                className="w-full py-4 bg-primary text-black rounded-2xl font-black shadow-xl shadow-primary/20 hover:brightness-110 active:scale-95 transition-all"
              >
                {isVerifying ? <span className="material-symbols-outlined animate-spin text-sm">progress_activity</span> : 'Confirm & Update'}
              </button>
              <button
                onClick={() => setShowVerifyModal(false)}
                className="text-gray-400 text-sm font-bold hover:text-gray-600 transition-colors"
              >
                Cancel
              </button>
            </div>
          </div>
        </div>
      )}
    </SubpageLayout>
  );
};

const PasswordInput = ({
  value,
  onChange,
  placeholder = "Password",
  label = "New Password",
  showValidation = true
}: {
  value: string,
  onChange: (v: string) => void,
  placeholder?: string,
  label?: string,
  showValidation?: boolean
}) => {
  const [isFocused, setIsFocused] = useState(false);
  const [showPassword, setShowPassword] = useState(false);

  const hasMinLength = value.length >= 8;
  const hasUpper = /[A-Z]/.test(value);
  const hasLower = /[a-z]/.test(value);
  const hasNumber = /[0-9]/.test(value);

  const reqs = [
    { label: "8+ characters", met: hasMinLength, id: 'len' },
    { label: "Uppercase", met: hasUpper, id: 'upper' },
    { label: "Lowercase", met: hasLower, id: 'lower' },
    { label: "Number", met: hasNumber, id: 'num' },
  ];

  return (
    <div className="flex flex-col gap-2 group/pw">
      <div className="flex items-center justify-between px-1">
        <label className="text-[10px] font-black text-gray-400 dark:text-gray-500 uppercase tracking-[0.2em]">{label}</label>
        {showValidation && (
          <div className="flex gap-1">
            {reqs.map(r => (
              <div
                key={r.id}
                className={`w-1 h-1 rounded-full transition-all duration-500 ${r.met ? 'bg-primary' : 'bg-gray-200 dark:bg-gray-800'}`}
                title={r.label}
              />
            ))}
          </div>
        )}
      </div>

      <div className="relative flex items-center">
        <div className={`w-full flex items-center gap-3 px-4 py-3 rounded-xl transition-all duration-300 ${isFocused
          ? 'bg-white dark:bg-black shadow-[0_0_20px_rgba(var(--primary-rgb),0.1)] ring-1 ring-primary/20'
          : 'bg-gray-50/30 dark:bg-white/5'
          }`}>

          <input
            type={showPassword ? "text" : "password"}
            value={value}
            onChange={(e) => onChange(e.target.value)}
            onFocus={() => setIsFocused(true)}
            onBlur={() => setIsFocused(false)}
            placeholder={placeholder}
            autoComplete="new-password"
            className="flex-1 bg-transparent border-none outline-none focus:ring-0 font-medium text-base text-text-main dark:text-white placeholder-gray-300 dark:placeholder-gray-600 tracking-tight"
          />

          <button
            type="button"
            onClick={() => setShowPassword(!showPassword)}
            className={`flex items-center justify-center w-8 h-8 rounded-lg transition-all ${showPassword ? 'text-primary' : 'text-gray-400 hover:text-gray-600 dark:hover:text-gray-200'}`}
          >
            <span className="material-symbols-outlined text-[18px]">
              {showPassword ? 'visibility_off' : 'visibility'}
            </span>
          </button>
        </div>
      </div>

      {showValidation && (
        <div className="flex flex-wrap gap-x-4 gap-y-1.5 px-1 mt-1">
          {reqs.map(r => (
            <div key={r.label} className={`flex items-center gap-1.5 text-[10px] font-bold transition-all duration-300 ${r.met ? 'text-primary' : 'text-gray-400'}`}>
              <span className="material-symbols-outlined text-[12px]">
                {r.met ? 'check_circle' : 'radio_button_unchecked'}
              </span>
              {r.label}
            </div>
          ))}
        </div>
      )}
    </div>
  )
};

export const SecuritySettings = () => {
  const { user } = useApp();
  const { showToast } = useToast();

  const [activeTab, setActiveTab] = useState<'update' | 'reset'>('update');
  const [currentPassword, setCurrentPassword] = useState('');
  const [newPassword, setNewPassword] = useState('');
  const [confirmPassword, setConfirmPassword] = useState('');
  const [isUpdating, setIsUpdating] = useState(false);

  const [resetStep, setResetStep] = useState<'send' | 'verify'>('send');
  const [resetCode, setResetCode] = useState(['', '', '', '', '', '']);
  const [resetNewPassword, setResetNewPassword] = useState('');
  const [resetConfirmPassword, setResetConfirmPassword] = useState('');
  const [isSendingCode, setIsSendingCode] = useState(false);
  const [isResetting, setIsResetting] = useState(false);
  const [timer, setTimer] = useState(0);

  useEffect(() => {
    if (timer > 0) {
      const interval = setInterval(() => setTimer(t => t - 1), 1000);
      return () => clearInterval(interval);
    }
  }, [timer]);

  const handleUpdate = async () => {
    if (newPassword !== confirmPassword) {
      showToast("New passwords do not match", 'error');
      return;
    }
    if (!user?.id) return;
    setIsUpdating(true);
    try {
      const res = await authApi.changePassword(user.id, currentPassword, newPassword);
      if (!res.success) throw new Error(res.message);
      showToast("Password updated successfully!", 'success');
      setCurrentPassword('');
      setNewPassword('');
      setConfirmPassword('');
    } catch (error: any) {
      showToast(error.message || "Update failed", 'error');
    } finally {
      setIsUpdating(false);
    }
  };

  const handleSendCode = async () => {
    setIsSendingCode(true);
    try {
      if (!user?.email) throw new Error("No email found");
      await authApi.forgotPassword(user.email);
      showToast("Verification code sent!", 'success');
      setResetStep('verify');
      setTimer(60);
    } catch (error: any) {
      showToast(error.message || "Failed to send code", 'error');
    } finally {
      setIsSendingCode(false);
    }
  };

  const handleReset = async () => {
    if (resetNewPassword !== resetConfirmPassword) {
      showToast("Passwords do not match", 'error');
      return;
    }
    setIsResetting(true);
    try {
      if (!user?.email) throw new Error("No email found");

      const response = await authApi.resetPassword(user.email, resetCode.join(''), resetNewPassword);

      if (response.session) {
        await supabase.auth.setSession(response.session);
      }

      showToast("Password updated successfully!", 'success');
      setResetStep('send');
      setResetCode(['', '', '', '', '', '']);
      setResetNewPassword('');
      setResetConfirmPassword('');
      setActiveTab('update');
      setTimer(0);
    } catch (error: any) {
      showToast(error.message || "Reset failed", 'error');
    } finally {
      setIsResetting(false);
    }
  };

  const handleCodeChange = (index: number, value: string) => {
    if (!/^\d*$/.test(value)) return;
    if (value.length > 1) return;
    const newCode = [...resetCode];
    newCode[index] = value;
    setResetCode(newCode);
    if (value && index < 5) document.getElementById(`reset-code-${index + 1}`)?.focus();
  };

  const handleKeyDown = (index: number, e: React.KeyboardEvent) => {
    if (e.key === 'Backspace' && !resetCode[index] && index > 0) {
      document.getElementById(`reset-code-${index - 1}`)?.focus();
    }
  };

  return (
    <SubpageLayout title="Password & Security">
      <div className="max-w-xl mx-auto w-full py-8">

        {/* Minimalist Tab Switcher */}
        <div className="flex items-center gap-8 border-b border-gray-100 dark:border-white/5 mb-12">
          <button
            onClick={() => setActiveTab('update')}
            className={`relative pb-4 text-sm font-bold transition-all ${activeTab === 'update'
              ? 'text-text-main dark:text-white'
              : 'text-gray-400 hover:text-gray-600 dark:hover:text-gray-200'
              }`}
          >
            Update Password
            {activeTab === 'update' && (
              <div className="absolute bottom-0 left-0 w-full h-0.5 bg-primary animate-in fade-in slide-in-from-left-2 duration-300" />
            )}
          </button>
          <button
            onClick={() => setActiveTab('reset')}
            className={`relative pb-4 text-sm font-bold transition-all ${activeTab === 'reset'
              ? 'text-text-main dark:text-white'
              : 'text-gray-400 hover:text-gray-600 dark:hover:text-gray-200'
              }`}
          >
            Reset via Email
            {activeTab === 'reset' && (
              <div className="absolute bottom-0 left-0 w-full h-0.5 bg-primary animate-in fade-in slide-in-from-left-2 duration-300" />
            )}
          </button>
        </div>

        {activeTab === 'update' && (
          <div className="flex flex-col gap-8 animate-in fade-in slide-in-from-bottom-4 duration-500">
            <div className="flex flex-col gap-2">
              <label className="text-[10px] font-black text-gray-400 dark:text-gray-500 uppercase tracking-[0.2em] px-1">Current Password</label>
              <input
                type="password"
                value={currentPassword}
                onChange={(e) => setCurrentPassword(e.target.value)}
                placeholder="Enter current password"
                className="w-full px-4 py-3 rounded-xl border-none outline-none focus:ring-1 focus:ring-primary/20 bg-gray-50/30 dark:bg-white/5 focus:bg-white dark:focus:bg-black transition-all font-medium text-base text-text-main dark:text-white placeholder-gray-300 dark:placeholder-gray-600 tracking-tight"
              />
              <button
                onClick={() => setActiveTab('reset')}
                className="w-fit mt-1 px-1 text-[10px] font-bold text-primary hover:underline transition-all"
              >
                Forgot password?
              </button>
            </div>

            <PasswordInput
              label="New Password"
              value={newPassword}
              onChange={setNewPassword}
              placeholder="Minimum 8 characters"
            />

            <div className="flex flex-col gap-2">
              <label className="text-[10px] font-black text-gray-400 dark:text-gray-500 uppercase tracking-[0.2em] px-1">Confirm New Password</label>
              <input
                type="password"
                value={confirmPassword}
                onChange={(e) => setConfirmPassword(e.target.value)}
                placeholder="Re-type new password"
                className="w-full px-4 py-3 rounded-xl border-none outline-none focus:ring-1 focus:ring-primary/20 bg-gray-50/30 dark:bg-white/5 focus:bg-white dark:focus:bg-black transition-all font-medium text-base text-text-main dark:text-white placeholder-gray-300 dark:placeholder-gray-600 tracking-tight"
              />
            </div>

            <button
              onClick={handleUpdate}
              disabled={isUpdating || !currentPassword || !newPassword || !confirmPassword}
              className="mt-4 w-full bg-black dark:bg-white text-white dark:text-black py-4 rounded-xl font-bold hover:opacity-90 active:scale-[0.98] transition-all disabled:opacity-50 disabled:cursor-not-allowed shadow-xl shadow-black/10 dark:shadow-white/10"
            >
              {isUpdating ? 'Updating...' : 'Update Password'}
            </button>
          </div>
        )}

        {activeTab === 'reset' && (
          <div className="flex flex-col gap-8 animate-in fade-in slide-in-from-bottom-4 duration-500">
            {resetStep === 'send' ? (
              <div className="flex flex-col items-center text-center gap-6 py-8">
                <div className="w-16 h-16 rounded-full bg-primary/10 flex items-center justify-center">
                  <span className="material-symbols-outlined text-primary text-3xl">mail</span>
                </div>
                <div className="flex flex-col gap-2">
                  <h3 className="text-xl font-bold text-text-main dark:text-white">Verify your identity</h3>
                  <p className="text-gray-400 text-sm max-w-xs">We'll send a 6-digit verification code to your email <span className="text-text-main dark:text-white font-medium">{user.email}</span></p>
                </div>
                <button
                  onClick={handleSendCode}
                  disabled={isSendingCode}
                  className="w-full bg-black dark:bg-white text-white dark:text-black py-4 rounded-xl font-bold hover:opacity-90 active:scale-[0.98] transition-all disabled:opacity-50 shadow-xl"
                >
                  {isSendingCode ? 'Sending...' : 'Send Code'}
                </button>
              </div>
            ) : (
              <div className="flex flex-col gap-10">
                <div className="flex flex-col gap-6">
                  <div className="flex flex-col gap-2">
                    <label className="text-[10px] font-black text-gray-400 dark:text-gray-500 uppercase tracking-[0.2em] px-1 text-center">Verification Code</label>
                    <div className="flex justify-center gap-3">
                      {resetCode.map((digit, idx) => (
                        <input
                          key={idx}
                          id={`reset-code-${idx}`}
                          type="text"
                          value={digit}
                          onChange={(e) => handleCodeChange(idx, e.target.value)}
                          onKeyDown={(e) => handleKeyDown(idx, e)}
                          autoComplete="off"
                          className="w-12 h-14 text-center text-xl font-bold rounded-xl border-none ring-1 ring-black/5 dark:ring-white/5 bg-gray-50/30 dark:bg-white/5 focus:ring-primary focus:bg-white dark:focus:bg-black outline-none transition-all"
                          maxLength={1}
                        />
                      ))}
                    </div>
                    <div className="flex flex-col items-center gap-2">
                      <p className="text-[10px] font-medium text-gray-400">
                        Code expires in 10 minutes
                      </p>
                      {timer > 0 ? (
                        <p className="text-[10px] font-black uppercase tracking-[0.2em] text-gray-300 py-2 text-center select-none">
                          Resend in {timer}s
                        </p>
                      ) : (
                        <button
                          onClick={() => handleSendCode()}
                          className="text-[10px] font-black uppercase tracking-[0.2em] text-gray-400 hover:text-primary transition-colors py-2 text-center"
                        >
                          Resend Code
                        </button>
                      )}
                    </div>
                  </div>

                  <div className="flex flex-col gap-8">
                    <PasswordInput
                      label="New Password"
                      value={resetNewPassword}
                      onChange={setResetNewPassword}
                      placeholder="Minimum 8 characters"
                    />
                    <div className="flex flex-col gap-2">
                      <label className="text-[10px] font-black text-gray-400 dark:text-gray-500 uppercase tracking-[0.2em] px-1">Confirm New Password</label>
                      <input
                        type="password"
                        value={resetConfirmPassword}
                        onChange={(e) => setResetConfirmPassword(e.target.value)}
                        placeholder="Re-type new password"
                        className="w-full px-4 py-3 rounded-xl border-none outline-none focus:ring-1 focus:ring-primary/20 bg-gray-50/30 dark:bg-white/5 focus:bg-white dark:focus:bg-black transition-all font-medium text-base text-text-main dark:text-white placeholder-gray-300 dark:placeholder-gray-600 tracking-tight"
                      />
                    </div>
                  </div>
                </div>

                <button
                  onClick={handleReset}
                  disabled={isResetting || !resetNewPassword || resetCode.some(c => !c)}
                  className="w-full bg-black dark:bg-white text-white dark:text-black py-4 rounded-xl font-bold hover:opacity-90 active:scale-[0.98] transition-all disabled:opacity-50 shadow-xl"
                >
                  {isResetting ? 'Resetting...' : 'Reset Password'}
                </button>
              </div>
            )}
          </div>
        )}
      </div>
    </SubpageLayout>
  );
};

export const SubscriptionSettings = () => {
  const {
    user, isPro, redeemProWithPoints, setShowPaywall,
    notifications, markNotificationRead, userPoints, fetchUserPoints,
    dismissProUpgrade, proUpgradeDismissed
  } = useApp();
  const [isRedeeming, setIsRedeeming] = useState(false);
  const [selectedPreview, setSelectedPreview] = useState<'basic' | 'pro'>(isPro ? 'pro' : 'basic');
  const [redeemError, setRedeemError] = useState<string | null>(null);
  const needsProUpgrade = !isPro && userPoints.balance >= 199 && !proUpgradeDismissed;
  const [ledger, setLedger] = useState<any[]>([]);
  const { showToast } = useToast();

  const PRO_COST = 199;
  const canAfford = userPoints.balance >= PRO_COST;

  const membershipNotifs = notifications.filter(n => n.unread && n.text?.startsWith('[Membership]'));
  const hasMembershipAlert = membershipNotifs.length > 0;

  // Auto-dismiss: When user enters Subscription page, mark [Membership] notifications as read
  // This makes the red dot disappear on Settings menu and notification dropdown
  useEffect(() => {
    if (hasMembershipAlert) {
      membershipNotifs.forEach(n => markNotificationRead(n.id));
    }
  }, [hasMembershipAlert]);

  // Fetch recent ledger
  useEffect(() => {
    const fetchLedger = async () => {
      if (!user.id) return;
      try {
        const { data } = await supabase.rpc('get_points_summary', { p_user_id: user.id });
        if (data?.recent_transactions) {
          setLedger(data.recent_transactions);
        }
      } catch (e) { console.error(e); }
    };
    fetchLedger();
  }, [user.id, userPoints.balance]);

  const handleRedeemPro = async () => {
    setIsRedeeming(true);
    setRedeemError(null);
    const result = await redeemProWithPoints();
    if (result.success) {
      showToast('Successfully upgraded to Pro!', 'success');
      setShowPaywall(true);
    } else if (result.reason === 'insufficient_points') {
      setRedeemError(`Need ${result.shortfall?.toLocaleString()} more points`);
    } else if (result.reason === 'already_redeemed_this_month') {
      setRedeemError('Already redeemed this month');
    } else {
      setRedeemError('Redemption failed. Please try again.');
    }
    setIsRedeeming(false);
  };

  const typeLabels: Record<string, { label: string; icon: string; color: string }> = {
    practice_complete: { label: 'Practice', icon: 'school', color: 'text-blue-400' },
    unit_test_complete: { label: 'Unit Test', icon: 'quiz', color: 'text-green-400' },
    error_correction: { label: 'Correction', icon: 'edit', color: 'text-purple-400' },
    daily_checkin: { label: 'Check-in', icon: 'event_available', color: 'text-amber-400' },
    checkin_bonus: { label: 'Bonus', icon: 'celebration', color: 'text-orange-400' },
    like_received: { label: 'Like', icon: 'thumb_up', color: 'text-pink-400' },
    comment_received: { label: 'Comment', icon: 'chat', color: 'text-cyan-400' },
    follower_gained: { label: 'Follower', icon: 'person_add', color: 'text-indigo-400' },
    friend_added: { label: 'Friend', icon: 'group', color: 'text-teal-400' },
    pro_redeem: { label: 'Pro Redeem', icon: 'stars', color: 'text-red-400' },
    manual_adjustment: { label: 'Adjustment', icon: 'tune', color: 'text-gray-400' },
  };

  return (
    <SubpageLayout title="Subscription">
      <div className="flex flex-col gap-10">

        {/* Dual Plan Grid */}
        <div className="grid grid-cols-1 md:grid-cols-2 gap-8">

          {/* Basic Plan */}
          <div
            onClick={() => setSelectedPreview('basic')}
            className={`relative p-8 rounded-[2.5rem] border-2 transition-all duration-500 flex flex-col cursor-pointer hover:scale-[1.02] ${selectedPreview === 'basic' ? 'border-primary ring-4 ring-primary/10' : 'border-gray-200 dark:border-gray-800'} ${!isPro ? 'bg-white dark:bg-white/5 shadow-xl' : 'bg-gray-50/50 dark:bg-black/20 opacity-60'}`}>
            {!isPro && (
              <div className="absolute top-0 -translate-y-1/2 left-1/2 -translate-x-1/2 px-4 py-1 bg-primary text-black text-[10px] font-black uppercase rounded-full shadow-lg z-10">
                Current Plan
              </div>
            )}

            <div className="mb-8">
              <h3 className="text-xl font-black uppercase tracking-tight mb-1">Basic Plan</h3>
              <div className="flex items-baseline gap-1">
                <span className="text-4xl font-black uppercase italic">Free</span>
                <span className="text-sm font-bold text-gray-400">/ Forever</span>
              </div>
            </div>

            <div className="space-y-4 mb-10 flex-grow">
              <div className="flex items-center gap-3">
                <span className="material-symbols-outlined text-gray-400 text-lg">check_circle</span>
                <span className="text-sm font-bold text-gray-600 dark:text-gray-300">Intelligent Problem Recommendation</span>
              </div>
              <div className="flex items-center gap-3">
                <span className="material-symbols-outlined text-gray-400 text-lg">check_circle</span>
                <span className="text-sm font-bold text-gray-600 dark:text-gray-300">Mastery Dashboard & Settings</span>
              </div>
              <div className="flex items-center gap-3">
                <span className="material-symbols-outlined text-gray-400 text-lg">check_circle</span>
                <span className="text-sm font-bold text-gray-600 dark:text-gray-300">Basic Profile (Username, Bio, Email)</span>
              </div>
            </div>

            <button
              disabled
              className="w-full py-4 rounded-2xl font-black text-sm bg-gray-100 dark:bg-white/5 text-gray-400 cursor-not-allowed"
            >
              {!isPro ? 'Current Plan' : 'Free Forever'}
            </button>
          </div>

          {/* Pro Plan */}
          <div
            onClick={() => {
              setSelectedPreview('pro');
              // Dismiss: Mark all [Membership] notifications as read when clicking the Pro card
              if (hasMembershipAlert) {
                membershipNotifs.forEach(n => markNotificationRead(n.id));
              }
            }}
            className={`relative p-8 rounded-[2.5rem] border-2 transition-all duration-500 flex flex-col group cursor-pointer hover:scale-[1.02] ${selectedPreview === 'pro' ? 'border-primary ring-4 ring-primary/10' : 'border-black/5 dark:border-white/10'} ${isPro ? 'bg-primary/5 shadow-2xl shadow-primary/20' : 'bg-white dark:bg-white/5'}`}>
            {/* Red dot for Pro upgrade nudge */}
            {needsProUpgrade && (
              <div className="absolute top-4 right-4 flex h-3 w-3 z-20">
                <span className="animate-ping absolute inline-flex h-full w-full rounded-full bg-red-400 opacity-75"></span>
                <span className="relative inline-flex rounded-full h-3 w-3 bg-red-500"></span>
              </div>
            )}
            {isPro && (
              <div className="absolute top-0 -translate-y-1/2 left-1/2 -translate-x-1/2 px-4 py-1 bg-primary text-black text-[10px] font-black uppercase rounded-full shadow-lg z-10">
                Current Plan
              </div>
            )}

            <div className="absolute -right-12 -top-12 w-32 h-32 bg-primary/10 rounded-full blur-3xl group-hover:bg-primary/20 transition-all duration-700" />

            <div className="mb-8 relative z-10">
              <div className="flex items-center gap-2 mb-1">
                <h3 className="text-xl font-black uppercase tracking-tight text-primary">Pro Plan</h3>
                <span className="material-symbols-outlined text-primary fill-1 text-xl">verified</span>
              </div>
              <div className="flex items-center gap-2">
                <span className="text-4xl font-black text-primary">{PRO_COST.toLocaleString()}</span>
                <PointsCoin size="md" showGlow={false} />
                <span className="text-sm font-bold text-gray-400">/ month</span>
              </div>
              {isPro && user.subscriptionPeriodEnd && (
                <p className="text-[10px] font-black text-primary uppercase mt-2">
                  Expires on: {new Date(user.subscriptionPeriodEnd).toLocaleDateString()}
                </p>
              )}
            </div>

            <div className="space-y-4 mb-10 flex-grow relative z-10">
              <div className="flex items-center gap-3">
                <span className="material-symbols-outlined text-primary text-lg">check_circle</span>
                <span className="text-sm font-bold">Comprehensive Performance Analysis</span>
              </div>
              <div className="flex items-center gap-3">
                <span className="material-symbols-outlined text-primary text-lg">check_circle</span>
                <span className="text-sm font-bold">Full Community Forum Access</span>
              </div>
              <div className="flex items-center gap-3">
                <span className="material-symbols-outlined text-primary text-lg">check_circle</span>
                <span className="text-sm font-bold">Custom Practice Sessions & Insights</span>
              </div>
              <div className="flex items-center gap-3">
                <span className="material-symbols-outlined text-primary text-lg">check_circle</span>
                <span className="text-sm font-bold">Exclusive Achievement Titles</span>
              </div>
              <div className="flex items-center gap-3">
                <span className="material-symbols-outlined text-primary text-lg">check_circle</span>
                <span className="text-sm font-bold">Premium Avatar Customization</span>
              </div>
              <div className="flex items-center gap-3">
                <span className="material-symbols-outlined text-primary text-lg">check_circle</span>
                <span className="text-sm font-bold">Priority Community Feedback</span>
              </div>
            </div>

            <button
              onClick={handleRedeemPro}
              disabled={isRedeeming || !canAfford || (isPro)}
              className={`w-full py-4 rounded-2xl font-black text-sm transition-all relative z-10 ${isPro ? 'bg-primary/10 text-primary border border-primary/30 cursor-default' : canAfford ? 'bg-primary text-black hover:scale-[1.02] active:scale-95 shadow-xl shadow-primary/20' : 'bg-gray-100 dark:bg-white/5 text-gray-400 cursor-not-allowed'}`}
            >
              {isRedeeming ? (
                <span className="flex items-center justify-center gap-2">
                  <span className="w-4 h-4 border-2 border-black border-t-transparent rounded-full animate-spin"></span>
                  Processing...
                </span>
              ) : isPro ? (
                'Already Pro Member'
              ) : canAfford ? (
                'Upgrade Now'
              ) : (
                `Need ${(PRO_COST - userPoints.balance).toLocaleString()} more pts`
              )}
            </button>
          </div>
        </div>

        {/* Non-Profit Declaration */}
        <div className="p-8 rounded-[2.5rem] bg-gray-50 dark:bg-white/5 border border-gray-100 dark:border-white/5 text-left transition-all hover:scale-[1.01]">
          <h4 className="text-sm font-black uppercase tracking-widest text-gray-400 mb-3">Non-Profit Declaration</h4>
          <p className="text-xs text-gray-500 font-medium leading-relaxed max-w-2xl text-left">
            NewMaoS is a strictly non-profit educational platform. All premium features and exclusive items can only be unlocked through diligent study and earning performance points.
            <br className="mb-2" />
            This system is designed purely as an encouragement for students to excel in their learning journey. Points cannot be purchased with real money; they are a reward for dedication and growth.
          </p>
        </div>

      </div>
    </SubpageLayout>
  );
};