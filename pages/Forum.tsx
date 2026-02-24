import React, { useState, useEffect, useRef, useCallback } from 'react';
import ReactDOM from 'react-dom';
import { useNavigate, useLocation } from 'react-router-dom';
import { Navbar } from '../components/Navbar';
import { useApp } from '../AppContext';
import { supabase } from '../src/services/supabaseClient';
import { MathRenderer } from '../components/MathRenderer';
import { useToast } from '../components/Toast';
import { ProGateOverlay } from '../components/ProGateOverlay';
import api from '../src/services/api';
import { EMOJI_CATEGORIES } from '../src/constants/emojiData';
import { PointsCoin } from '../components/PointsCoin';
import { AddFriendModal } from '../components/AddFriendModal';
import { getUniqueTitleStyle } from '../src/utils/titleStyles';
// --- Types ---
interface Channel {
    id: string;
    name: string;
    description: string;
    category: string;
    slug: string;
    position: number;
    creator_id?: string; // ✅ 添加创建者ID
    member_count?: number; // ✅ 添加成员数量
}

interface Message {
    id: string;
    channel_id: string;
    user_id: string;
    content: string;
    created_at: string;
    reply_to_id?: string | null;
    user?: {
        name: string;
        avatarUrl?: string;
        email?: string;
        is_official?: boolean;
        equipped_title?: {
            name: string;
            category: string;
            threshold?: number;
        } | null;
    };
    is_pinned: boolean;
    metadata?: any;
    replies?: Message[];
    like_count?: number;
    is_liked_by_me?: boolean;
}

interface PresenceUser {
    id: string;
    name: string;
    avatarUrl?: string;
    email?: string;
    onlineAt: string;
    is_official?: boolean; // ✅ 添加官方标识
    equipped_title?: {
        name: string;
        category: string;
        threshold?: number;
    } | null;
}

// Removed old local TITLE_STYLES logic in favor of src/utils/titleStyles.ts

// --- Helper Components ---

const ChannelItem = ({ name, isActive, onClick, rightElement, unreadCount = 0 }: { name: string, isActive: boolean, onClick: () => void, rightElement?: React.ReactNode, unreadCount?: number }) => (
    <button
        onClick={onClick}
        className={`group flex items-center justify-between gap-2 w-full px-3 py-2.5 rounded-xl transition-all mb-1 ${isActive
            ? 'bg-primary/10 text-primary dark:text-white dark:bg-white/10'
            : 'text-text-secondary dark:text-gray-400 hover:bg-gray-100 dark:hover:bg-white/5 hover:text-text-main dark:hover:text-gray-200'
            }`}
    >
        <div className="flex items-center gap-2 overflow-hidden flex-1">
            <div className={`w-4 flex justify-center text-lg transition-colors ${isActive ? 'text-primary dark:text-white' : 'text-gray-300 dark:text-gray-600 group-hover:text-gray-400'}`}>#</div>
            <span className={`text-sm font-medium truncate ${isActive ? 'font-bold' : ''}`}>{name}</span>
        </div>
        <div className="flex items-center gap-2 shrink-0">
            {unreadCount > 0 && !isActive && (
                <div className="min-w-[16px] h-[16px] flex items-center justify-center bg-red-500 text-white text-[9px] font-black rounded-full px-1 shadow-sm ring-1 ring-white dark:ring-surface-dark group-hover:scale-110 transition-transform">
                    {unreadCount > 99 ? '99+' : unreadCount}
                </div>
            )}
            {rightElement}
        </div>
    </button>
);

const SidebarItemSkeleton = () => (
    <div className="flex items-center gap-2 w-full px-3 py-2.5 animate-pulse mb-1">
        <div className="w-4 h-4 rounded-md bg-gray-100 dark:bg-zinc-800 shrink-0"></div>
        <div className="h-3 bg-gray-100 dark:bg-zinc-800 rounded w-2/3"></div>
    </div>
);

const HeaderSkeleton = () => (
    <div className="flex flex-col justify-center animate-pulse">
        <div className="h-4 bg-gray-100 dark:bg-zinc-800 rounded w-24 md:w-32 mb-1.5"></div>
        <div className="h-3 bg-gray-50 dark:bg-zinc-900 rounded w-32 md:w-48"></div>
    </div>
);

const ChatSkeleton = () => (
    <div className="flex-1 overflow-y-auto p-4 md:p-8 space-y-8 custom-scrollbar">
        {[1, 2, 3, 4, 5, 6].map(i => (
            <div key={i} className={`flex items-start gap-4 animate-pulse ${i % 3 === 0 ? 'flex-row-reverse' : ''}`}>
                <div className="w-10 h-10 rounded-full bg-gray-100 dark:bg-zinc-800 shrink-0"></div>
                <div className={`flex flex-col gap-2 flex-1 ${i % 3 === 0 ? 'items-end' : 'items-start'}`}>
                    <div className="flex items-center gap-2">
                        <div className="h-3 bg-gray-100 dark:bg-zinc-800 rounded w-20"></div>
                        <div className="h-3 bg-gray-50 dark:bg-zinc-900 rounded w-12"></div>
                    </div>
                    <div className={`h-16 bg-gray-50 dark:bg-zinc-900 rounded-2xl w-full ${i % 3 === 0 ? 'max-w-md' : 'max-w-lg'}`}></div>
                    <div className="h-2 bg-gray-50 dark:bg-zinc-900 rounded w-16"></div>
                </div>
            </div>
        ))}
    </div>
);

const TitleBadge = ({ title, size = 'sm' }: { title: { name: string, category: string, threshold?: number }, size?: 'xs' | 'sm' | 'md' }) => {
    const isTiny = size === 'xs';
    const style = getUniqueTitleStyle(title.category, title.threshold || 1);

    return (
        <div
            className={`inline-flex items-center bg-gradient-to-br ${style.bg} ${isTiny ? 'px-2 py-0.5 gap-1' : 'px-2.5 py-1 gap-1.5'} rounded-full border ${style.border} shadow-sm ${style.glow} hover:scale-105 hover:-rotate-1 opacity-95 transition-all cursor-default relative overflow-hidden flex-shrink-0 ${style.extraClasses || ''}`}
            style={{
                height: isTiny ? '18px' : '22px'
            }}
        >
            <div className="flex items-center relative z-10 justify-center">
                <span
                    className={`material-symbols-outlined relative z-10 transition-all duration-300 ${style.text}`}
                    style={{
                        fontSize: isTiny ? '12px' : '16px',
                        textShadow: '0 1px 2px rgba(0,0,0,0.1)'
                    }}
                >
                    {style.icon}
                </span>
            </div>
            <span className={`${isTiny ? 'text-[9px]' : 'text-[10px]'} font-black ${style.text} uppercase tracking-wider relative z-10 drop-shadow-sm`}>
                {title.name}
            </span>
        </div>
    );
};

const ThreadedMessageRow = ({ message, onProfileClick, onReplySubmit, onTogglePin, currentUserId, currentUser, onDelete, onRecall, forcedAlign, isDM }: {
    message: Message,
    onProfileClick: (user: any) => void,
    onReplySubmit: (parentId: string, content: string) => Promise<void>,
    onTogglePin?: (messageId: string) => void,
    currentUserId?: string,
    currentUser?: any, // From AppContext for live updates
    onDelete?: (messageId: string) => void,
    onRecall?: (messageId: string) => void,
    forcedAlign?: 'left' | 'right', // New Prop for inheriting alignment
    isDM?: boolean
}) => {
    const [isReplying, setIsReplying] = useState(false);
    const [replyText, setReplyText] = useState('');
    const [isSubmitting, setIsSubmitting] = useState(false);
    const textareaRef = useRef<HTMLTextAreaElement>(null);

    // Like state
    const [likeCount, setLikeCount] = useState(message.like_count || 0);
    const [isLikedByMe, setIsLikedByMe] = useState(message.is_liked_by_me || false);
    const [isLikeProcessing, setIsLikeProcessing] = useState(false);

    // FIX: Sync local state with prop changes (for Real-time updates from other users)
    useEffect(() => {
        setLikeCount(message.like_count || 0);
        setIsLikedByMe(message.is_liked_by_me || false);
    }, [message.like_count, message.is_liked_by_me]);

    const handleToggleLike = async () => {
        if (!currentUserId || isLikeProcessing) return;
        setIsLikeProcessing(true);

        // Optimistic update
        const wasLiked = isLikedByMe;
        setIsLikedByMe(!wasLiked);
        setLikeCount(prev => wasLiked ? Math.max(0, prev - 1) : prev + 1);

        try {
            if (wasLiked) {
                // Unlike
                await supabase
                    .from('message_reactions')
                    .delete()
                    .eq('message_id', message.id)
                    .eq('user_id', currentUserId)
                    .eq('reaction_type', 'like');
            } else {
                // Like
                await supabase
                    .from('message_reactions')
                    .upsert({
                        message_id: message.id,
                        user_id: currentUserId,
                        reaction_type: 'like'
                    }, { onConflict: 'message_id,user_id,reaction_type' });
            }
        } catch (err) {
            // Rollback on error
            setIsLikedByMe(wasLiked);
            setLikeCount(prev => wasLiked ? prev + 1 : Math.max(0, prev - 1));
            console.error('Like toggle error:', err);
        } finally {
            setIsLikeProcessing(false);
        }
    };

    // Mock Avatar color generation based on user ID
    const getAvatarColor = (id: string) => {
        const colors = ['bg-red-500', 'bg-blue-500', 'bg-green-500', 'bg-yellow-500', 'bg-purple-500', 'bg-pink-500'];
        const index = id.charCodeAt(0) % colors.length;
        return colors[index];
    };

    const timeString = new Date(message.created_at).toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });
    const dateString = new Date(message.created_at).toLocaleDateString();

    const isOwnMessage = Boolean(currentUserId && message.user_id && String(currentUserId) === String(message.user_id));

    // Determine Alignment: FORCE > OWN > LEFT
    const effectiveAlign = forcedAlign || (isOwnMessage ? 'right' : 'left');
    const isRightAligned = effectiveAlign === 'right';

    // Quote Stripping Logic: Remove obvious quote blocks if this is a reply (or always, if preferred)
    // The user requested: "no need to put the comment I sent to the right again"
    // We strip lines starting with "> " if they duplicate parent content.
    // For simplicity, we just strip ALL blockquotes in threaded view to keep it clean.
    const cleanContent = message.content.split('\n').filter(line => !line.trim().startsWith('>')).join('\n').trim() || message.content;


    // Dynamic Data Sync: If it's the current user's message, prioritize using the LATEST profile from state
    const username = isOwnMessage && currentUser?.name
        ? currentUser.name
        : (message.user?.name || message.user?.email?.split('@')[0] || 'Unknown User');

    const storedAvatar = isOwnMessage && currentUser?.avatarUrl
        ? currentUser.avatarUrl
        : message.user?.avatarUrl;

    const isOfficial = (message.user?.is_official || message.user?.email === 'newmao6120@gmail.com' || username.includes('NewMaoS.com')) || (isOwnMessage && (currentUser?.is_official || currentUser?.email === 'newmao6120@gmail.com'));
    const equippedTitle = isOwnMessage && currentUser?.equippedTitle
        ? currentUser.equippedTitle
        : message.user?.equipped_title;

    // If stored avatar is from ui-avatars, regenerate from current name to keep initials in sync
    const isGeneratedAvatar = storedAvatar && storedAvatar.includes('ui-avatars.com');
    const avatar = isGeneratedAvatar
        ? `https://ui-avatars.com/api/?name=${encodeURIComponent(username)}&background=f9d406&color=1c1a0d&bold=true&size=80`
        : storedAvatar;

    const handleUserClick = (e?: React.MouseEvent) => {
        e?.stopPropagation(); // Prevent bubbling
        if (message.user_id) {
            onProfileClick({
                id: message.user_id,
                name: username,
                avatarUrl: avatar,
                is_official: isOfficial // ✅ 使用计算后的标识
            });
        }
    };

    const handleSubmitReply = async () => {
        if (!replyText.trim()) return;
        setIsSubmitting(true);
        try {
            await onReplySubmit(message.id, replyText);
            setReplyText('');
            setIsReplying(false);
        } catch (e) {
            console.error(e);
        } finally {
            setIsSubmitting(false);
        }
    };

    const handleKeyDown = (e: React.KeyboardEvent) => {
        if (e.key === 'Enter' && !e.shiftKey) {
            e.preventDefault();
            handleSubmitReply();
        }
    };



    return (
        <div id={`msg-${message.id}`} className={`flex flex-col group ${isRightAligned ? 'items-end' : 'items-start'}`}>
            {/* Main Message Block */}
            <div className={`flex items-start gap-4 relative mb-8 ${message.is_pinned ? 'bg-yellow-50 dark:bg-yellow-900/10 p-2 rounded-lg border-l-2 border-yellow-500' : ''} ${isRightAligned ? 'flex-row-reverse' : ''}`}>

                {/* Avatar Row Wrapper for Centering */}
                <div className="flex items-center min-h-[40px] shrink-0">
                    <div className="cursor-pointer" onClick={handleUserClick}>
                        {avatar ? (
                            <img src={avatar} alt={username} className="w-10 h-10 rounded-full hover:opacity-80 transition-opacity shadow-sm border border-gray-100 dark:border-gray-700" />
                        ) : (
                            <div className={`w-10 h-10 rounded-full flex items-center justify-center text-white font-bold shadow-sm ${getAvatarColor(message.user_id)} hover:brightness-110 transition-all`}>
                                {username.charAt(0).toUpperCase()}
                            </div>
                        )}
                    </div>
                </div>

                {/* Content Column */}
                <div className={`flex-1 min-w-0 flex flex-col ${isRightAligned ? 'items-end' : 'items-start'}`}>
                    {/* Message Body Row Wrapper for Centering with Avatar */}
                    <div className={`flex items-center min-h-[40px] w-full ${isRightAligned ? 'justify-end' : 'justify-start'}`}>
                        {(() => {
                            // Simple heuristic for "Emoji Only" messages to display them larger
                            let isEmoji = false;
                            try {
                                const emojiRegex = /^(\p{Extended_Pictographic}|\p{Emoji_Component}|\s)+$/u;
                                const isPureText = /^[\d\s!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]*$/.test(cleanContent);
                                isEmoji = emojiRegex.test(cleanContent) && !isPureText && cleanContent.length < 10;
                            } catch (e) {
                                isEmoji = false;
                            }

                            return (
                                <div className={`flex flex-col ${isRightAligned ? 'items-end' : 'items-start'}`}>
                                    {/* Name & Title Header - Always visible even for emojis */}
                                    <div className={`flex items-center gap-3.5 mb-1.5 ${isRightAligned ? 'flex-row-reverse' : ''}`}>
                                        <span
                                            className="text-[14px] font-black text-text-main dark:text-white shrink-0 hover:text-primary transition-colors cursor-pointer"
                                            onClick={handleUserClick}
                                        >
                                            {username}
                                        </span>
                                        {equippedTitle && (
                                            <TitleBadge title={equippedTitle} size="xs" />
                                        )}
                                        {isOfficial && (
                                            <span className="text-[8px] bg-primary text-white px-2.5 py-1 rounded-[6px] font-black tracking-widest ring-1 ring-primary/20 shrink-0 shadow-sm">OFFICIAL</span>
                                        )}
                                    </div>
                                    <div className={`flex items-end gap-2 ${isRightAligned ? 'flex-row-reverse' : ''}`}>
                                        <div className={`text-text-main dark:text-gray-200 break-words leading-[1.6] ${isEmoji ? 'text-5xl py-2 bg-transparent border-none shadow-none backdrop-blur-none' : 'text-[15px] font-medium bg-white/50 dark:bg-white/5 px-4 py-2.5 rounded-2xl border border-gray-100/50 dark:border-white/5 shadow-sm backdrop-blur-sm'} ${isRightAligned ? 'text-right' : 'text-left'}`}>
                                            <MathRenderer content={cleanContent} className={isEmoji ? 'max-w-none' : 'prose-sm'} />
                                        </div>
                                        <div className="flex items-center gap-1 opacity-40 select-none text-[10px] font-bold uppercase tracking-tighter shrink-0 mb-2">
                                            {timeString}
                                            {message.is_pinned && (
                                                <span className="material-symbols-outlined text-[12px] text-amber-500">push_pin</span>
                                            )}
                                        </div>
                                    </div>
                                </div>
                            );
                        })()}
                    </div>

                    {/* Action Bar (Like + Reply + Pin + Delete + Recall) */}
                    <div className={`absolute bottom-0 translate-y-full pt-1 ${isRightAligned ? 'right-0 flex-row-reverse' : 'left-0'} opacity-0 group-hover:opacity-100 flex items-center gap-4 transition-all duration-200 pointer-events-none group-hover:pointer-events-auto z-20`}>
                        <span className="text-[10px] text-gray-400 dark:text-gray-500 select-none">{dateString}</span>
                        {/* Like Button - Only in Channels, self-like allowed (no gold via DB trigger) */}
                        {!isDM && (
                            <button
                                onClick={handleToggleLike}
                                disabled={!currentUserId || isLikeProcessing}
                                className={`text-xs font-medium flex items-center gap-1 transition-colors ${isLikedByMe ? 'text-red-500' : 'text-gray-400 hover:text-red-400'} disabled:opacity-50`}
                            >
                                <span className="material-symbols-outlined text-[14px]" style={{ fontVariationSettings: isLikedByMe ? "'FILL' 1" : "'FILL' 0" }}>favorite</span>
                                {likeCount > 0 && <span>{likeCount}</span>}
                            </button>
                        )}
                        <button
                            onClick={() => setIsReplying(!isReplying)}
                            className="text-xs text-gray-400 hover:text-text-main dark:hover:text-gray-300 font-medium flex items-center gap-1 transition-colors"
                        >
                            <span className="material-symbols-outlined text-[14px]">chat_bubble_outline</span>
                            Reply
                        </button>
                        {onTogglePin && (
                            <button
                                onClick={() => onTogglePin(message.id)}
                                className={`text-xs font-medium flex items-center gap-1 transition-colors ${message.is_pinned ? 'text-amber-500 hover:text-red-500' : 'text-gray-400 hover:text-amber-500'}`}
                            >
                                <span className="material-symbols-outlined text-[14px]">push_pin</span>
                                {message.is_pinned ? 'Unpin' : 'Pin'}
                            </button>
                        )}
                        {onDelete && !isOfficial && (
                            <button
                                onClick={() => onDelete(message.id)}
                                className="text-xs text-gray-400 hover:text-red-500 font-medium flex items-center gap-1 transition-colors"
                            >
                                <span className="material-symbols-outlined text-[14px]">delete</span>
                                Delete
                            </button>
                        )}
                        {onRecall && currentUserId && message.user_id === currentUserId && (
                            <button
                                onClick={() => onRecall(message.id)}
                                className="text-xs text-gray-400 hover:text-red-600 font-medium flex items-center gap-1 transition-colors"
                            >
                                <span className="material-symbols-outlined text-[14px]">undo</span>
                                Recall
                            </button>
                        )}
                    </div>
                </div>
            </div>

            {/* Inline Reply Input */}
            {isReplying && (
                <div className={`mt-3 flex gap-2 animate-fade-in relative z-10 w-3/4 ${isRightAligned ? 'mr-14' : 'ml-14'}`}>
                    <div className="flex-1 relative">
                        <textarea
                            ref={textareaRef}
                            value={replyText}
                            onChange={(e) => {
                                setReplyText(e.target.value);
                                e.target.style.height = 'auto';
                                e.target.style.height = Math.min(e.target.scrollHeight, 150) + 'px';
                            }}
                            onKeyDown={handleKeyDown}
                            autoFocus
                            placeholder={`Reply to @${username}...`}
                            disabled={isSubmitting}
                            rows={1}
                            className="w-full bg-gray-50 dark:bg-white/5 border border-gray-200 dark:border-gray-700 text-text-main dark:text-gray-100 placeholder-gray-400 px-3 py-2 rounded-xl resize-none focus:outline-none focus:ring-1 focus:ring-primary/50 text-sm custom-scrollbar"
                            style={{ minHeight: '38px' }}
                        />
                    </div>
                    <button
                        onClick={handleSubmitReply}
                        disabled={!replyText.trim() || isSubmitting}
                        className="bg-primary text-white p-2 rounded-xl hover:brightness-110 disabled:opacity-50 disabled:cursor-not-allowed transition-all shadow-sm flex items-center justify-center shrink-0 h-[38px] w-[38px]"
                    >
                        {isSubmitting ? (
                            <div className="w-4 h-4 border-2 border-white/30 border-t-white rounded-full animate-spin"></div>
                        ) : (
                            <span className="material-symbols-outlined text-[18px]">send</span>
                        )}
                    </button>
                </div>
            )}

            {/* Recursive Nested Replies with inherited ALIGNMENT */}
            {message.replies && message.replies.length > 0 && (
                <div className={`mt-2 space-y-0 w-full ${isRightAligned ? 'pr-4 md:pr-12 md:mr-4 border-r-2 border-primary/20' : 'pl-4 md:pl-12 md:ml-4 border-l-2 border-primary/20'}`}>
                    {message.replies.map(reply => (
                        <ThreadedMessageRow
                            key={reply.id}
                            message={reply}
                            onProfileClick={onProfileClick}
                            onReplySubmit={onReplySubmit}
                            onTogglePin={onTogglePin}
                            currentUserId={currentUserId}
                            currentUser={currentUser}
                            onDelete={onDelete}
                            onRecall={onRecall}
                            forcedAlign={effectiveAlign}
                            isDM={isDM}
                        />
                    ))}
                </div>
            )}
        </div>
    );
};


const CreateChannelModal = ({ isOpen, onClose, category, onCreate }: { isOpen: boolean, onClose: () => void, category: string, onCreate: (name: string, description: string) => Promise<void> }) => {
    const [name, setName] = useState('');
    const [description, setDescription] = useState('');
    const [isSubmitting, setIsSubmitting] = useState(false);

    if (!isOpen) return null;

    const handleSubmit = async (e: React.FormEvent) => {
        e.preventDefault();
        if (!name.trim()) return;

        setIsSubmitting(true);
        await onCreate(name, description);
        setIsSubmitting(false);
        setName('');
        setDescription('');
        onClose();
    };

    return (
        <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/50 backdrop-blur-sm" onClick={onClose}>
            <div className="bg-white dark:bg-zinc-800 rounded-2xl p-6 w-96 shadow-2xl border border-gray-200 dark:border-gray-700 mx-4" onClick={e => e.stopPropagation()}>
                <h2 className="text-xl font-bold mb-4 text-text-main dark:text-white">Create Channel</h2>
                <div className="mb-4">
                    <span className="text-xs font-bold text-gray-500 uppercase tracking-wider">Category</span>
                    <div className="mt-1 px-3 py-2 bg-gray-100 dark:bg-black/20 rounded-lg text-sm font-medium text-gray-700 dark:text-gray-300">
                        {category}
                    </div>
                </div>
                <form onSubmit={handleSubmit}>
                    <div className="mb-4">
                        <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">Channel Name</label>
                        <input
                            type="text"
                            value={name}
                            onChange={e => setName(e.target.value.toLowerCase().replace(/\s+/g, '-').replace(/[^a-z0-9-]/g, ''))}
                            placeholder="e.g. study-groups"
                            className="w-full px-3 py-2 bg-white dark:bg-black/20 border border-gray-200 dark:border-gray-700 rounded-xl focus:ring-2 focus:ring-primary/50 outline-none transition-all text-text-main dark:text-white"
                            autoFocus
                        />
                        <p className="mt-1 text-xs text-gray-400">Lowercase, no spaces</p>
                    </div>
                    <div className="mb-6">
                        <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">Description</label>
                        <input
                            type="text"
                            value={description}
                            onChange={e => setDescription(e.target.value)}
                            placeholder="What's this channel about?"
                            className="w-full px-3 py-2 bg-white dark:bg-black/20 border border-gray-200 dark:border-gray-700 rounded-xl focus:ring-2 focus:ring-primary/50 outline-none transition-all text-text-main dark:text-white"
                        />
                    </div>
                    <div className="flex justify-end gap-3">
                        <button type="button" onClick={onClose} className="px-4 py-2 text-gray-500 hover:bg-gray-100 dark:hover:bg-white/5 rounded-xl transition-colors font-medium">Cancel</button>
                        <button
                            type="submit"
                            disabled={!name.trim() || isSubmitting}
                            className="px-4 py-2 bg-primary text-white rounded-xl hover:brightness-110 transition-all font-bold shadow-lg shadow-primary/20 disabled:opacity-50 disabled:cursor-not-allowed"
                        >
                            {isSubmitting ? 'Creating...' : 'Create Channel'}
                        </button>
                    </div>
                </form>
            </div>
        </div>
    );
};

const ConfirmationModal = ({ isOpen, onClose, onConfirm, title, message }: { isOpen: boolean, onClose: () => void, onConfirm: () => void, title: string, message: string }) => {
    if (!isOpen) return null;

    return (
        <div className="fixed inset-0 z-[60] flex items-center justify-center bg-black/50 backdrop-blur-sm p-4 animate-in fade-in duration-200">
            <div className="bg-white dark:bg-[#1a1b1e] rounded-2xl w-full max-w-sm shadow-2xl scale-100 animate-in zoom-in-95 duration-200 border border-gray-100 dark:border-gray-800">
                <div className="p-6 text-center">
                    <div className="w-12 h-12 rounded-full bg-red-100 dark:bg-red-900/20 text-red-500 dark:text-red-400 flex items-center justify-center mx-auto mb-4">
                        <span className="material-symbols-outlined text-2xl">warning</span>
                    </div>
                    <h3 className="text-lg font-bold text-gray-900 dark:text-white mb-2">{title}</h3>
                    <p className="text-sm text-gray-500 dark:text-gray-400 mb-6">{message}</p>

                    <div className="flex justify-center gap-3">
                        <button
                            onClick={onClose}
                            className="px-4 py-2 text-sm font-medium text-gray-600 dark:text-gray-300 hover:bg-gray-100 dark:hover:bg-white/5 rounded-lg transition-colors"
                        >
                            Cancel
                        </button>
                        <button
                            onClick={() => { onConfirm(); onClose(); }}
                            className="px-6 py-2 text-sm font-medium bg-red-500 hover:bg-red-600 text-white rounded-lg shadow-lg shadow-red-500/30 transition-all transform active:scale-95"
                        >
                            Confirm
                        </button>
                    </div>
                </div>
            </div>
        </div>
    );
};

const ChannelBrowseModal = ({ isOpen, onClose, onJoin, preloadedChannels, currentUserId, joinedChannelIds }: {
    isOpen: boolean,
    onClose: () => void,
    onJoin: (channel: any) => Promise<void>,
    preloadedChannels?: any[],
    currentUserId?: string,
    joinedChannelIds?: Set<string>
}) => {
    const [query, setQuery] = useState('');
    const [results, setResults] = useState<any[]>(preloadedChannels || []);
    const [isSearching, setIsSearching] = useState(false);
    const [hasLoaded, setHasLoaded] = useState(false);

    // Show preloaded channels immediately on open
    useEffect(() => {
        if (isOpen && preloadedChannels && !hasLoaded) {
            setResults(preloadedChannels.slice(0, 50));
        }
    }, [isOpen, preloadedChannels, hasLoaded]);

    useEffect(() => {
        if (!isOpen) { setHasLoaded(false); return; }
        if (!query.trim()) {
            if (preloadedChannels) {
                setResults(preloadedChannels.slice(0, 50));
                setHasLoaded(true);
            }
            return;
        }

        const performSearch = async () => {
            setIsSearching(true);
            try {
                const { data, error } = await supabase
                    .from('forum_channels')
                    .select('*, channel_members(count)')
                    .in('category', ['User', 'Official', 'Custom'])
                    .ilike('name', `%${query}%`)
                    .limit(50);

                if (error) throw error;
                const mapped = (data as any[]).map(c => ({
                    ...c,
                    member_count: c.channel_members?.[0]?.count || 0
                })).sort((a, b) => {
                    const diff = (b.member_count || 0) - (a.member_count || 0);
                    if (diff !== 0) return diff;
                    return new Date(b.created_at).getTime() - new Date(a.created_at).getTime();
                });
                setResults(mapped);
                setHasLoaded(true);
            } catch (e) {
                console.error('Channel search error:', e);
            } finally {
                setIsSearching(false);
            }
        };

        const timeoutId = setTimeout(performSearch, 300);
        return () => clearTimeout(timeoutId);
    }, [query, isOpen, preloadedChannels]);

    if (!isOpen) return null;

    return (
        <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/50 backdrop-blur-sm px-4 pb-4" onClick={onClose}>
            <div className="bg-white dark:bg-zinc-800 rounded-3xl p-6 w-[480px] max-h-[min(600px,calc(100vh-6rem))] shadow-2xl border border-gray-200 dark:border-gray-700 flex flex-col animate-fade-in-up" onClick={e => e.stopPropagation()}>
                <div className="flex items-center justify-between mb-6">
                    <h2 className="text-xl font-black text-text-main dark:text-white flex items-center gap-2">
                        <span className="material-symbols-outlined text-primary">explore</span>
                        Browse Channels
                    </h2>
                    <button onClick={onClose} className="text-gray-400 hover:text-red-500 transition-colors">
                        <span className="material-symbols-outlined">close</span>
                    </button>
                </div>

                <div className="flex flex-col gap-4 mb-6">
                    <div className="relative">
                        <span className="material-symbols-outlined absolute left-3 top-1/2 -translate-y-1/2 text-gray-400">search</span>
                        <input
                            type="text"
                            value={query}
                            onChange={e => setQuery(e.target.value)}
                            placeholder="Search channels..."
                            className="w-full pl-10 pr-4 py-2.5 bg-gray-50 dark:bg-black/20 border border-gray-200 dark:border-gray-700 rounded-xl outline-none focus:ring-2 focus:ring-primary/50 text-sm"
                            autoFocus
                        />
                    </div>
                </div>

                <div className="flex-1 overflow-y-auto custom-scrollbar space-y-3">
                    {isSearching ? (
                        <div className="flex justify-center p-8"><div className="w-8 h-8 border-2 border-primary border-t-transparent rounded-full animate-spin"></div></div>
                    ) : results.length === 0 ? (
                        <div className="text-center py-12">
                            <span className="material-symbols-outlined text-4xl text-gray-300 mb-2">search_off</span>
                            <p className="text-gray-400 text-xs italic">No channels found. Try a different search!</p>
                        </div>
                    ) : (
                        results.map(channel => (
                            <div key={channel.id} className="p-4 rounded-xl border border-gray-100 dark:border-gray-800 hover:border-primary/30 transition-all group bg-gray-50/50 dark:bg-white/5">
                                <div className="flex items-start justify-between gap-4">
                                    <div className="flex-1 min-w-0">
                                        <div className="flex items-center gap-2 mb-1">
                                            <span className="text-primary font-black text-lg">#</span>
                                            <h3 className="font-bold text-sm text-text-main dark:text-white truncate">{channel.name}</h3>
                                            <div className="flex items-center gap-1.5 px-2 py-0.5 bg-gray-100 dark:bg-white/5 rounded-full border border-gray-200 dark:border-white/10 shrink-0">
                                                <span className="material-symbols-outlined text-[10px] text-gray-400">group</span>
                                                <span className="text-[10px] font-bold text-gray-500">{channel.member_count || 0}</span>
                                            </div>
                                            <span className={`text-[9px] px-1.5 py-0.5 rounded uppercase font-black tracking-widest shrink-0 ${channel.category === 'Official'
                                                ? 'bg-primary text-white shadow-sm shadow-primary/20'
                                                : 'bg-gray-200 dark:bg-gray-700 text-gray-500'
                                                }`}>
                                                {channel.category === 'Official' ? 'OFFICIAL' : channel.category}
                                            </span>
                                        </div>
                                        {channel.description && <p className="text-[11px] text-gray-500 line-clamp-2">{channel.description}</p>}
                                    </div>
                                    {channel.creator_id === currentUserId ? (
                                        <div className="px-4 py-2 bg-amber-500 text-white text-[10px] font-black rounded-lg shadow-lg shadow-amber-500/20 shrink-0 uppercase tracking-wider">
                                            Owner
                                        </div>
                                    ) : joinedChannelIds?.has(channel.id) ? (
                                        <div className="px-4 py-2 bg-green-500 text-white text-[10px] font-black rounded-lg shadow-lg shadow-green-500/20 shrink-0 uppercase tracking-wider">
                                            Joined
                                        </div>
                                    ) : (
                                        <button
                                            onClick={() => onJoin(channel)}
                                            className="px-4 py-2 bg-primary text-white text-[10px] font-black rounded-lg hover:brightness-110 shadow-lg shadow-primary/20 transition-all shrink-0 uppercase tracking-wider"
                                        >
                                            Join
                                        </button>
                                    )}
                                </div>
                            </div>
                        ))
                    )}
                </div>
            </div>
        </div>
    );
};

export const Forum = () => {
    const { user, isAuthenticated, isAuthLoading, unreadCounts, clearUnread, userPoints, fetchUserPoints, triggerCoinAnimation, isPro } = useApp();
    const { showToast } = useToast();
    const navigate = useNavigate();
    const location = useLocation();



    // Pending Points State
    const [pendingPoints, setPendingPoints] = useState<{ amount: number; count: number; details: any[] }>({ amount: 0, count: 0, details: [] });
    const [isClaimingPoints, setIsClaimingPoints] = useState(false);
    const [isAddFriendModalOpen, setIsAddFriendModalOpen] = useState(false);


    // Fetch pending points from database
    const fetchPendingPoints = async () => {
        if (!user?.id) return;
        try {
            const { data: pending, error: pendingError } = await supabase
                .from('pending_points')
                .select('amount')
                .eq('user_id', user.id)
                .eq('claimed', false);

            if (pendingError) throw pendingError;

            const totalAmount = pending?.reduce((sum, p) => sum + p.amount, 0) || 0;
            const totalCount = pending?.length || 0;

            const { data: details } = await supabase.rpc('get_pending_points_detail');

            setPendingPoints({
                amount: totalAmount,
                count: totalCount,
                details: details || []
            });
        } catch (error) {
            console.error('Failed to fetch pending points:', error);
        }
    };

    // Claim all pending points
    const handleClaimPoints = async (e: React.MouseEvent) => {
        e.stopPropagation(); // Prevent ensuring profile click
        if (!user?.id || pendingPoints.amount === 0) return;

        setIsClaimingPoints(true);
        try {
            const { data, error } = await supabase.rpc('claim_pending_points');
            if (error) throw error;

            if (data && data[0]) {


                showToast(`+${data[0].claimed_amount} NMS Points claimed!`, 'success');
                fetchPendingPoints();
                if (fetchUserPoints) fetchUserPoints(); // Refresh balance
            }
        } catch (error: any) {
            console.error('Failed to claim points:', error);
            showToast('Failed to claim NMS Points', 'error');
        } finally {
            setIsClaimingPoints(false);
        }
    };

    useEffect(() => {
        if (user?.id) {
            fetchPendingPoints();
            // Polling as a fallback, but we rely on realtime below
            const interval = setInterval(fetchPendingPoints, 60000);
            return () => clearInterval(interval);
        }
    }, [user?.id]);

    // Real-time listener for pending_points (to show Claim button instantly)
    useEffect(() => {
        if (!user?.id) return;

        const sub = supabase.channel(`user-points-${user.id}`)
            .on(
                'postgres_changes',
                {
                    event: '*',
                    schema: 'public',
                    table: 'pending_points',
                    filter: `user_id=eq.${user.id}`
                },
                () => {
                    console.log('[Realtime] Pending points changed, refreshing in 200ms...');
                    setTimeout(() => {
                        fetchPendingPoints(); // Refresh local state when table changes
                    }, 200);
                }
            )
            .subscribe();

        return () => {
            supabase.removeChannel(sub);
        };
    }, [user?.id]);

    const [confirmModal, setConfirmModal] = useState<{ isOpen: boolean, title: string, message: string, onConfirm: () => void }>({ isOpen: false, title: '', message: '', onConfirm: () => { } });
    const [channels, setChannels] = useState<Channel[]>(() => {
        try {
            const cached = localStorage.getItem('forum_channels_cache');
            return cached ? JSON.parse(cached) : [];
        } catch { return []; }
    });
    const [joinedChannelIds, setJoinedChannelIds] = useState<Set<string>>(new Set()); // ✅ 追踪已加入频道的ID
    const [activeChannelId, setActiveChannelId] = useState<string | null>(() => {
        try { return localStorage.getItem('forum_activeChannelId') || null; } catch { return null; }
    });
    const [messages, setMessages] = useState<Message[]>([]);
    const [isLoadingChannels, setIsLoadingChannels] = useState(() => {
        try { return !localStorage.getItem('forum_channels_cache'); } catch { return true; }
    });
    const [isLoadingMessages, setIsLoadingMessages] = useState(() => {
        try {
            return !!(localStorage.getItem('forum_activeChannelId') || localStorage.getItem('forum_activeChatId'));
        } catch {
            return false;
        }
    });
    const [inputText, setInputText] = useState('');
    const [isSidebarOpen, setIsSidebarOpen] = useState(true);
    const [selectedUserProfile, setSelectedUserProfile] = useState<{ id: string; name: string; avatarUrl?: string; is_official?: boolean } | null>(null);
    const [sidebarSearchQuery, setSidebarSearchQuery] = useState('');




    // Deep link handling for notifications
    useEffect(() => {
        const params = new URLSearchParams(location.search);
        const action = params.get('action');
        const targetId = params.get('sender_id') || params.get('friend_id');

        if (targetId && (action === 'friend_request' || action === 'friend_accepted')) {
            const fetchProfile = async () => {
                const { data } = await supabase
                    .from('user_profiles')
                    .select('id, name, avatar_url, email') // Verify column names
                    .eq('id', targetId)
                    .single();

                if (data) {
                    setSelectedUserProfile({
                        id: data.id,
                        name: data.name || 'User',
                        avatarUrl: data.avatar_url
                    });
                }
            };
            fetchProfile();

            if (action === 'friend_request') {
                setActiveSidebarSection('PrivateMessages');
            }
        }

        const chatId = params.get('chat_id');
        const channelId = params.get('channel_id');
        const msgId = params.get('message_id');

        if (chatId) {
            setViewMode('dm');
            setActiveChatId(chatId);
            setActiveChannelId(null);
            if (window.innerWidth < 768) setIsSidebarOpen(false);
        } else if (channelId) {
            setViewMode('channel');
            setActiveChannelId(channelId);
            setActiveChatId(null);
            if (window.innerWidth < 768) setIsSidebarOpen(false);
        }

        // Handle channel_slug deep linking
        const channelSlug = params.get('channel_slug');
        if (channelSlug) {
            // 1. Expand sidebar if it's a course unit (do this even if channel record not found yet)
            if (channelSlug.startsWith('ab-unit-') || channelSlug.startsWith('bc-unit-')) {
                setCollapsedCategories(prev => ({ ...prev, 'Courses': false }));
                setActiveSidebarSection('Courses');
                if (channelSlug.startsWith('ab-unit-')) {
                    setExpandedCourses(prev => ({ ...prev, 'AB': true }));
                } else if (channelSlug.startsWith('bc-unit-')) {
                    setExpandedCourses(prev => ({ ...prev, 'BC': true }));
                }
            }

            // 2. Select the channel if it has loaded
            const targetChannel = channels.find(c => c.slug === channelSlug);
            if (targetChannel) {
                setViewMode('channel');
                setActiveChannelId(targetChannel.id);
                setActiveChatId(null);
                if (window.innerWidth < 768) setIsSidebarOpen(false);
            }
        }

        // Auto-scroll to message if message_id provided
        if (msgId) {
            // Need to wait for messages to load. We'll use a timeout or a 
            // separate effect that watches messages length + msgId.
            setTimeout(() => {
                const el = document.getElementById(`msg-${msgId}`);
                if (el) {
                    el.scrollIntoView({ behavior: 'smooth', block: 'center' });
                    el.classList.add('ring-2', 'ring-primary', 'ring-offset-2', 'dark:ring-offset-zinc-900', 'rounded-lg');
                    setTimeout(() => {
                        el.classList.remove('ring-2', 'ring-primary', 'ring-offset-2');
                    }, 3000);
                }
            }, 1000);
        }
    }, [location.search, channels]);

    // --- DM States ---
    const [viewMode, setViewMode] = useState<'channel' | 'dm'>(() => {
        try { return (localStorage.getItem('forum_viewMode') as 'channel' | 'dm') || 'channel'; } catch { return 'channel'; }
    });
    const [activeChatId, setActiveChatId] = useState<string | null>(() => {
        try { return localStorage.getItem('forum_activeChatId') || null; } catch { return null; }
    });
    const [dmChats, setDmChats] = useState<any[]>(() => {
        try {
            const cached = localStorage.getItem('forum_dm_cache');
            return cached ? JSON.parse(cached) : [];
        } catch { return []; }
    });
    const [isLoadingDMs, setIsLoadingDMs] = useState(() => {
        try { return !localStorage.getItem('forum_dm_cache'); } catch { return true; }
    });



    // Clear unread counts when switching tabs
    useEffect(() => {
        const id = viewMode === 'channel' ? activeChannelId : activeChatId;
        if (id && unreadCounts[id]) {
            clearUnread(id);
        }
    }, [activeChannelId, activeChatId, viewMode, unreadCounts, clearUnread]);

    // Cleanup Ghost Notifications
    useEffect(() => {
        if (isLoadingChannels || isLoadingDMs) return;

        // Build set of valid IDs
        const validIds = new Set<string>();
        channels.forEach(c => validIds.add(c.id));
        dmChats.forEach(dm => {
            if (dm.chat_id) validIds.add(dm.chat_id);
        });

        // Find keys in unreadCounts that are NOT in validIds
        let hasChanges = false;
        Object.keys(unreadCounts).forEach(key => {
            if (!validIds.has(key)) {
                console.log(`🧹 Removing ghost notification for ID: ${key}`);
                clearUnread(key);
                hasChanges = true;
            }
        });

        if (hasChanges) {
            console.log('✨ Cleanup complete: Ghost notifications removed.');
        }

    }, [isLoadingChannels, isLoadingDMs, channels, dmChats, unreadCounts, clearUnread]);

    // Sidebar State — Channels and Private Messages open by default, Courses collapsed
    const [collapsedCategories, setCollapsedCategories] = useState<Record<string, boolean>>({
        'Courses': true,
        'Channels': false,
        'PrivateMessages': false
    });
    // Track which sidebar section is "active/focused" for orange highlight — only ONE at a time
    // Initialized as empty; will be derived from activeChannelId once channels load
    const [activeSidebarSection, setActiveSidebarSection] = useState<string>('');
    const [createModalOpen, setCreateModalOpen] = useState(false);
    const [friendStatus, setFriendStatus] = useState<'none' | 'pending_sent' | 'pending_received' | 'friends'>('none');
    const [friends, setFriends] = useState<string[]>([]); // List of friend IDs
    const [friendProfiles, setFriendProfiles] = useState<any[]>([]);

    useEffect(() => {
        const fetchFriendProfiles = async () => {
            if (friends.length === 0) {
                setFriendProfiles([]);
                return;
            }
            const { data } = await supabase
                .from('user_profiles')
                .select('id, name, avatar_url, email, is_official, equipped_title:titles(name, category, threshold)')
                .in('id', friends);
            if (data) {
                const mapped = data.map((p: any) => ({
                    ...p,
                    equipped_title: p.equipped_title ? (() => {
                        const t = Array.isArray(p.equipped_title) ? p.equipped_title[0] : p.equipped_title;
                        return {
                            name: t.name,
                            category: t.category,
                            threshold: t.threshold
                        };
                    })() : null
                }));
                setFriendProfiles(mapped);
            }
        };
        fetchFriendProfiles();
    }, [friends]);
    const [browseModalOpen, setBrowseModalOpen] = useState(false);
    const [browsableChannels, setBrowsableChannels] = useState<Channel[]>([]);
    const [channelMembers, setChannelMembers] = useState<string[]>([]); // Array of user IDs
    const [createCategory, setCreateCategory] = useState<string>('User');

    // Courses区域状态
    const [topicContent, setTopicContent] = useState<{ id: string, title: string }[]>([]);
    const [expandedCourses, setExpandedCourses] = useState<Record<string, boolean>>({});

    // Input State
    const [showEmojiPicker, setShowEmojiPicker] = useState(false);
    const [isUploading, setIsUploading] = useState(false);
    const fileInputRef = useRef<HTMLInputElement>(null);

    // New interactivity states
    const [showMemberSidebar, setShowMemberSidebar] = useState(false);
    const [isMuted, setIsMuted] = useState(false);
    const [showPinnedPanel, setShowPinnedPanel] = useState(false);
    const [showRestrictionModal, setShowRestrictionModal] = useState(false);

    // Global Search State
    const [searchMode, setSearchMode] = useState<'text' | 'date' | 'user'>('text');
    const [globalSearchQuery, setGlobalSearchQuery] = useState('');
    const [globalSearchResults, setGlobalSearchResults] = useState<Message[]>([]);
    const [isSearchingGlobal, setIsSearchingGlobal] = useState(false);
    const [showSearchResults, setShowSearchResults] = useState(false);
    const [isSearchModeMenuOpen, setIsSearchModeMenuOpen] = useState(false);



    const chatEndRef = useRef<HTMLDivElement>(null);
    const textareaRef = useRef<HTMLTextAreaElement>(null);

    // Search filter dropdown position (for portal rendering)
    const [filterDropdownPos, setFilterDropdownPos] = useState<{ top: number; left: number }>({ top: 0, left: 0 });
    const filterBtnRef = useRef<HTMLButtonElement>(null);

    const openFilterDropdown = useCallback(() => {
        if (filterBtnRef.current) {
            const rect = filterBtnRef.current.getBoundingClientRect();
            setFilterDropdownPos({ top: rect.bottom + 4, left: rect.left });
        }
        setIsSearchModeMenuOpen(v => !v);
    }, []);

    const selectFilterMode = useCallback((mode: 'text' | 'date' | 'user') => {
        setSearchMode(mode);
        setGlobalSearchQuery('');
        setGlobalSearchResults([]);
        setShowSearchResults(false);
        setIsSearchModeMenuOpen(false);
    }, []);

    // Close search mode menu on outside click (non-capture, so portal buttons fire first)
    useEffect(() => {
        if (!isSearchModeMenuOpen) return;
        const handleClickOutside = (e: MouseEvent) => {
            // Don't close if clicking the filter button itself (it toggles)
            if (filterBtnRef.current && filterBtnRef.current.contains(e.target as Node)) return;
            // Don't close if clicking inside the portal dropdown
            const target = e.target as HTMLElement;
            if (target.closest('[data-filter-dropdown]')) return;
            setIsSearchModeMenuOpen(false);
        };
        // Use a small delay so the click that opened the menu doesn't immediately close it
        const timer = setTimeout(() => {
            document.addEventListener('click', handleClickOutside);
        }, 50);
        return () => {
            clearTimeout(timer);
            document.removeEventListener('click', handleClickOutside);
        };
    }, [isSearchModeMenuOpen]);

    const handleGlobalSearch = async () => {
        if (!globalSearchQuery.trim()) {
            showToast('Please enter a search query', 'info');
            return;
        }

        setIsSearchingGlobal(true);
        setShowSearchResults(true);

        try {
            let query = supabase
                .from('forum_messages')
                .select(`
                                                    id,
                                                    channel_id,
                                                    user_id,
                                                    content,
                                                    created_at,
                                                    reply_to_id,
                                                    is_pinned,
                                                    user:user_profiles!user_id(name, avatar_url, is_official, email, equipped_title:titles(name, category, threshold))
                                                    `)
                .order('created_at', { ascending: false });

            if (searchMode === 'text') {
                query = query.ilike('content', `%${globalSearchQuery}%`);
            } else if (searchMode === 'user') {
                const { data: profiles } = await supabase
                    .from('user_profiles')
                    .select('id')
                    .ilike('name', `%${globalSearchQuery}%`);

                if (!profiles || profiles.length === 0) {
                    setGlobalSearchResults([]);
                    return;
                }

                query = query.in('user_id', profiles.map(p => p.id));
            } else if (searchMode === 'date') {
                const date = globalSearchQuery.trim();
                query = query
                    .gte('created_at', `${date}T00:00:00Z`)
                    .lte('created_at', `${date}T23:59:59Z`);
            }

            const { data, error } = await query.limit(50);
            if (error) throw error;

            setGlobalSearchResults((data || []).map((m: any) => ({
                ...m,
                user: {
                    name: m.user?.name || 'User',
                    avatarUrl: m.user?.avatar_url
                }
            })));
        } catch (e) {
            console.error('Global search error:', e);
            showToast('Search failed', 'error');
        } finally {
            setIsSearchingGlobal(false);
        }
    };

    // --- Friend System Logic ---
    const checkFriendStatus = useCallback(async () => {
        if (!user || !selectedUserProfile) return;
        // Don't check for self
        if (user.id === selectedUserProfile.id) {
            setFriendStatus('none');
            return;
        }

        try {
            // Check if ANY request exists between these two users
            // Using OR syntax: (sender=me AND receiver=them) OR (sender=them AND receiver=me)
            const { data: existing, error: fetchError } = await supabase
                .from('friend_requests')
                .select('*')
                .or(`and(sender_id.eq.${user.id},receiver_id.eq.${selectedUserProfile.id}),and(sender_id.eq.${selectedUserProfile.id},receiver_id.eq.${user.id})`)
                .maybeSingle();

            if (fetchError) throw fetchError;

            if (!existing) {
                setFriendStatus('none');
            } else if (existing.status === 'accepted') {
                setFriendStatus('friends');
            } else if (existing.status === 'pending') {
                if (existing.sender_id === user.id) {
                    setFriendStatus('pending_sent');
                } else {
                    setFriendStatus('pending_received');
                }
            } else {
                setFriendStatus('none');
            }
        } catch (err) {
            console.error('Error checking friend status:', err);
        }
    }, [user, selectedUserProfile]);

    useEffect(() => {
        if (selectedUserProfile) {
            checkFriendStatus();
        } else {
            setFriendStatus('none');
        }
    }, [selectedUserProfile, checkFriendStatus]);

    // --- REALTIME SUBSCRIPTION FOR FRIEND REQUESTS ---
    useEffect(() => {
        if (!user) return;

        const friendSub = supabase
            .channel('friend-updates')
            .on('postgres_changes', {
                event: '*',
                schema: 'public',
                table: 'friend_requests',
                filter: `receiver_id=eq.${user.id}` // Incoming requests or updates to my requests
            }, (payload) => {
                console.log('[Realtime] Friend Request Event:', payload);
                fetchFriends(); // Refresh friend list IDs, which triggers profile fetch
                fetchDMs(); // Refresh DMs in case a request was accepted
                if (selectedUserProfile) checkFriendStatus();
            })
            .on('postgres_changes', {
                event: 'UPDATE',
                schema: 'public',
                table: 'friend_requests',
                filter: `sender_id=eq.${user.id}` // My sent requests being accepted/rejected
            }, (payload) => {
                console.log('[Realtime] Friend Request Update:', payload);
                fetchFriends();
                fetchDMs(); // Refresh DMs (Critical for instant chat appearance)
                if (selectedUserProfile) checkFriendStatus();
            })
            .subscribe((status) => {
                console.log('[Realtime] Friend Subscription Status:', status);
            });

        return () => {
            supabase.removeChannel(friendSub);
        };
    }, [user, checkFriendStatus, selectedUserProfile]);

    const handleSendFriendRequest = async () => {
        if (!user || !selectedUserProfile) return;
        try {
            const { error } = await supabase
                .from('friend_requests')
                .insert({
                    sender_id: user.id,
                    receiver_id: selectedUserProfile.id,
                    status: 'pending'
                });
            if (error) throw error;
            setFriendStatus('pending_sent');
            showToast('Friend request sent!', 'success');
        } catch (err: any) {
            console.error('Failed to send friend request:', err);
            showToast(err.message || 'Failed to send request', 'error');
        }
    };

    const handleAcceptFriendRequest = async () => {
        if (!user || !selectedUserProfile) return;
        try {
            // Accept the request where THEY are the sender and I am the receiver
            const { error } = await supabase
                .from('friend_requests')
                .update({ status: 'accepted' })
                .eq('sender_id', selectedUserProfile.id)
                .eq('receiver_id', user.id);
            if (error) throw error;
            setFriendStatus('friends');
            showToast('Friend request accepted!', 'success');
            // Optimistically update friends list
            setFriends(prev => [...prev, selectedUserProfile.id]);
            fetchDMs(); // Refresh list to ensure they appear
        } catch (err: any) {
            console.error('Failed to accept friend request:', err);
            showToast('Failed to accept request', 'error');
        }
    };

    const handleRemoveFriend = async (friendId: string, event: React.MouseEvent) => {
        event.stopPropagation();
        setConfirmModal({
            isOpen: true,
            title: 'Remove Friend?',
            message: 'Are you sure you want to remove this friend?',
            onConfirm: async () => {
                try {
                    const { error } = await supabase
                        .from('friend_requests')
                        .delete()
                        .or(`and(sender_id.eq.${user?.id},receiver_id.eq.${friendId}),and(sender_id.eq.${friendId},receiver_id.eq.${user?.id})`);

                    if (error) throw error;

                    showToast('Friend removed', 'success');

                    // Update local state
                    setFriends(prev => prev.filter(id => id !== friendId));

                    // Refresh DMs (might remove them from list if no chat exists)
                    fetchDMs();

                    // If we are currently viewing their profile, update status
                    if (selectedUserProfile?.id === friendId) {
                        setFriendStatus('none');
                    }
                } catch (error: any) {
                    console.error('Error removing friend:', error);
                    showToast('Failed to remove friend', 'error');
                }
            }
        });
    };

    const handleDeleteChannel = async (channel: Channel, event: React.MouseEvent) => {
        event.stopPropagation();
        const isOwner = channel.creator_id === user?.id;

        if (isOwner) {
            setConfirmModal({
                isOpen: true,
                title: 'Delete Channel?',
                message: `Are you sure you want to permanently delete "${channel.name}"? All messages will be lost.`,
                onConfirm: async () => {
                    try {
                        const { error } = await supabase
                            .from('forum_channels')
                            .delete()
                            .eq('id', channel.id);
                        if (error) throw error;

                        showToast('Channel deleted', 'success');
                        setChannels(prev => {
                            const updated = prev.filter(c => c.id !== channel.id);
                            localStorage.setItem('forum_channels_cache', JSON.stringify(updated));
                            return updated;
                        });
                        setBrowsableChannels(prev => prev.filter(c => c.id !== channel.id));
                        setJoinedChannelIds(prev => {
                            const next = new Set(prev);
                            next.delete(channel.id);
                            return next;
                        });
                        if (activeChannelId === channel.id) setActiveChannelId(null);
                    } catch (err) {
                        console.error('Error deleting channel:', err);
                        showToast('Failed to delete channel', 'error');
                    }
                }
            });
        } else {
            setConfirmModal({
                isOpen: true,
                title: 'Leave Channel?',
                message: `Are you sure you want to leave "${channel.name}"?`,
                onConfirm: async () => {
                    try {
                        const { error } = await supabase
                            .from('channel_members')
                            .delete()
                            .match({ channel_id: channel.id, user_id: user?.id });
                        if (error) throw error;
                        showToast('Left channel', 'success');
                        setChannels(prev => prev.filter(c => c.id !== channel.id));
                        setJoinedChannelIds(prev => {
                            const next = new Set(prev);
                            next.delete(channel.id);
                            return next;
                        });
                        if (activeChannelId === channel.id) setActiveChannelId(null);
                    } catch (err) {
                        console.error('Error leaving channel:', err);
                        showToast('Failed to leave channel', 'error');
                    }
                }
            });
        }
    };

    const handleCloseDM = async (targetUserId: string, event: React.MouseEvent) => {
        event.stopPropagation();
        setConfirmModal({
            isOpen: true,
            title: 'Close Conversation?',
            message: 'Are you sure? History will be preserved if you message them again.',
            onConfirm: async () => {
                try {
                    // Optimistically remove from list
                    setDmChats(prev => prev.filter(c => c.user.id !== targetUserId));

                    // Allow closing even if no chat_id (phantom user)
                    const chat = dmChats.find(c => c.user.id === targetUserId);

                    if (chat?.chat_id && user) {
                        // Remove my participation
                        const { error } = await supabase
                            .from('direct_chat_participants')
                            .delete()
                            .match({ chat_id: chat.chat_id, user_id: user.id });

                        if (error) throw error;
                    }

                    if (viewMode === 'dm' && activeChatId === chat?.chat_id) {
                        setActiveChatId(null);
                        const defaultChannel = channels.find(c => c.category === 'Information');
                        setActiveChannelId(defaultChannel?.id || null);
                        setViewMode('channel');
                    }
                    showToast('Conversation closed', 'success');
                } catch (err) {
                    console.error('Failed to close DM:', err);
                    showToast('Failed to close conversation', 'error');
                }
            }
        });
    };

    // Fetch Channel Members whenever activeChannelId changes
    useEffect(() => {
        if (!activeChannelId) {
            setChannelMembers([]);
            return;
        }

        const fetchMembers = async () => {
            try {
                const { data, error } = await supabase
                    .from('channel_members')
                    .select('user_id')
                    .eq('channel_id', activeChannelId);
                if (error) throw error;
                setChannelMembers(data.map(m => m.user_id));
            } catch (e) {
                console.error('Error fetching channel members:', e);
            }
        };

        fetchMembers();

        // Subscribe to changes in channel_members
        const channel = supabase
            .channel(`members:${activeChannelId}`)
            .on('postgres_changes', {
                event: '*',
                schema: 'public',
                table: 'channel_members',
                filter: `channel_id=eq.${activeChannelId}`
            }, () => fetchMembers())
            .subscribe();

        return () => {
            supabase.removeChannel(channel);
        };
    }, [activeChannelId]);

    const scrollToBottom = (smooth = false) => {
        requestAnimationFrame(() => {
            chatEndRef.current?.scrollIntoView({ behavior: smooth ? 'smooth' : 'auto' });
        });
    };

    // --- In-memory Profile Cache for new messages ---
    const profileCache = useRef<Map<string, any>>(new Map());

    const handleNewMessage = async (newMsg: any, type: 'channel' | 'dm') => {
        // Fetch sender info if not present (Realtime payload only has user_id)
        let userProfile: any = { name: 'Unknown User', avatarUrl: undefined };

        try {
            if (newMsg.user_id) {
                // Check cache first
                if (profileCache.current.has(newMsg.user_id)) {
                    userProfile = profileCache.current.get(newMsg.user_id);
                } else {
                    const { data: u } = await supabase
                        .from('user_profiles')
                        .select('name, avatar_url, is_official, show_name, equipped_title:titles(name, category, threshold)')
                        .eq('id', newMsg.user_id)
                        .single();
                    if (u) {
                        const isVisible = u.show_name ?? true;
                        userProfile = {
                            name: isVisible ? (u.name || 'User') : 'Anonymous',
                            avatarUrl: isVisible ? u.avatar_url : undefined,
                            is_official: isVisible ? (u.is_official || false) : false,
                            equipped_title: isVisible ? u.equipped_title : null,
                            email: 'hidden'
                        };
                        // Save to cache
                        profileCache.current.set(newMsg.user_id, userProfile);
                    }
                }
            }
        } catch (e) {
            console.error('Error fetching user for new message:', e);
        }

        const enrichedMsg: Message = {
            ...newMsg,
            user: userProfile
        };

        // Proactively refresh pending points if this looks like a gift message
        // Added 500ms delay to ensure DB triggers have finished inserting the reward
        if (enrichedMsg.metadata?.giftCode || enrichedMsg.metadata?.giftType) {
            setTimeout(() => {
                fetchPendingPoints();
            }, 500);
        }

        setMessages(prev => {
            // 1. Check if message ID already exists (prevent duplicates from real-time)
            if (prev.some(m => m.id === enrichedMsg.id)) return prev;

            // 2. Optimistic UI replacement: 
            // Look for a temporary message from the same user with the same content
            // and replace it with the real message from the server.
            const tempIndex = prev.findIndex(m =>
                m.id.startsWith('temp-') &&
                m.user_id === enrichedMsg.user_id &&
                m.content === enrichedMsg.content
            );

            if (tempIndex !== -1) {
                const updated = [...prev];
                updated[tempIndex] = enrichedMsg;
                return updated;
            }

            // 3. If no matching temp message, just append
            return [...prev, enrichedMsg];
        });

        if (!enrichedMsg.reply_to_id) {
            scrollToBottom(true);
        }
    };

    // --- Effects ---

    // Persist forum state to localStorage so it survives navigation
    useEffect(() => {
        try {
            if (activeChannelId) localStorage.setItem('forum_activeChannelId', activeChannelId);
            else localStorage.removeItem('forum_activeChannelId');
        } catch { }
    }, [activeChannelId]);

    useEffect(() => {
        try {
            localStorage.setItem('forum_viewMode', viewMode);
        } catch { }
    }, [viewMode]);

    useEffect(() => {
        try {
            if (activeChatId) localStorage.setItem('forum_activeChatId', activeChatId);
            else localStorage.removeItem('forum_activeChatId');
        } catch { }
    }, [activeChatId]);

    // Realtime subscription for DMs and friends
    useEffect(() => {
        let subscription: any;

        const setupRealtime = async () => {
            // Subscribe to DM changes
            subscription = supabase.channel('dm-updates')
                .on(
                    'postgres_changes',
                    { event: '*', schema: 'public', table: 'direct_messages' },
                    () => {
                        if (viewMode === 'dm') scrollToBottom();
                    }
                )
                .subscribe();
        };

        setupRealtime();
        fetchFriends(); // Initial fetch

        return () => {
            if (subscription) supabase.removeChannel(subscription);
        };
    }, [viewMode, user?.id]); // Added user.id to dependencies

    // Fetch user's friends
    const fetchFriends = async () => {
        if (!user) return;
        try {
            const { data, error } = await supabase
                .from('friend_requests')
                .select('sender_id, receiver_id')
                .eq('status', 'accepted')
                .or(`sender_id.eq.${user.id},receiver_id.eq.${user.id}`);

            if (error) throw error;

            // Extract IDs of friends
            const friendIds = data.map((req: any) =>
                req.sender_id === user.id ? req.receiver_id : req.sender_id
            );
            setFriends(friendIds);
        } catch (err) {
            console.error('Error fetching friends:', err);
        }
    };

    // Fetch Channels on Mount
    useEffect(() => {
        const fetchChannels = async () => {
            if (!user?.id) return;
            setIsLoadingChannels(true);
            try {
                // Parallelize system channels, memberships and discovery data
                const [systemRes, membershipsRes, discoveryRes] = await Promise.all([
                    supabase
                        .from('forum_channels')
                        .select('*')
                        .in('category', ['Information', 'Community', 'Courses'])
                        .order('position', { ascending: true }),
                    supabase
                        .from('channel_members')
                        .select('channel_id')
                        .eq('user_id', user.id),
                    supabase
                        .from('forum_channels')
                        .select('*, channel_members(count)')
                        .in('category', ['User', 'Official', 'Custom'])
                ]);

                if (systemRes.error) throw systemRes.error;
                const systemChannels = systemRes.data || [];

                const currentJoinedIds = membershipsRes.data?.map(m => m.channel_id) || [];
                setJoinedChannelIds(new Set(currentJoinedIds));

                // Now fetch user channels based on memberships (this one depends on currentJoinedIds)
                let userChannels: Channel[] = [];
                let userQuery = supabase
                    .from('forum_channels')
                    .select('*')
                    .in('category', ['User', 'Official', 'Custom']);

                if (currentJoinedIds.length > 0) {
                    const quotedJoinedIds = currentJoinedIds.map(id => `"${id}"`).join(',');
                    userQuery = userQuery.or(`creator_id.eq."${user.id}",id.in.(${quotedJoinedIds})`);
                } else {
                    userQuery = userQuery.eq('creator_id', user.id);
                }

                const { data: userChannelData, error: userError } = await userQuery.order('position', { ascending: true });
                if (userError) throw userError;
                userChannels = userChannelData || [];

                const allFetched = [...systemChannels, ...userChannels];
                const allChannels = allFetched.reduce((acc: Channel[], current) => {
                    if (!acc.find(item => item.id === current.id)) {
                        acc.push(current);
                    }
                    return acc;
                }, []);

                setChannels(allChannels);
                localStorage.setItem('forum_channels_cache', JSON.stringify(allChannels));

                if (discoveryRes.data) {
                    const mapped = (discoveryRes.data as any[]).map(c => ({
                        ...c,
                        member_count: c.channel_members?.[0]?.count || 0
                    })).sort((a, b) => {
                        const diff = (b.member_count || 0) - (a.member_count || 0);
                        if (diff !== 0) return diff;
                        return new Date(b.created_at).getTime() - new Date(a.created_at).getTime();
                    });
                    setBrowsableChannels(mapped);
                }

                const resolvedId = (() => {
                    if (activeChannelId && allChannels.some(c => c.id === activeChannelId)) return activeChannelId;
                    const saved = localStorage.getItem('forum_activeChannelId');
                    if (saved && allChannels.some(c => c.id === saved)) return saved;
                    const communityChannel = allChannels.find(c => c.category === 'Community' && c.name.toLowerCase() === 'general');
                    return communityChannel?.id || allChannels[0]?.id || null;
                })();

                if (resolvedId) {
                    setActiveChannelId(resolvedId);
                    const ch = allChannels.find(c => c.id === resolvedId);
                    if (ch) {
                        if (ch.category === 'Information') setActiveSidebarSection('Announcements');
                        else if (ch.category === 'Community') setActiveSidebarSection('Community');
                        else if (ch.category === 'Courses') setActiveSidebarSection('Courses');
                        else if (['User', 'Official', 'Custom'].includes(ch.category)) setActiveSidebarSection('Channels');
                    }
                }

                if (localStorage.getItem('forum_viewMode') === 'dm') {
                    setActiveSidebarSection('PrivateMessages');
                }
            } catch (err) {
                console.error('Error fetching channels:', err);
                showToast('Failed to load channels', 'error');
            } finally {
                setIsLoadingChannels(false);
            }
        };

        fetchChannels();
    }, [user?.id]); // Removed isAuthLoading check for zero-delay fetch

    // Fetch DM Chats
    const fetchDMs = async () => {
        if (!user?.id) return;
        setIsLoadingDMs(true);
        try {
            const [friendRequestsRes, participationsRes] = await Promise.all([
                supabase
                    .from('friend_requests')
                    .select('sender_id, receiver_id')
                    .eq('status', 'accepted')
                    .or(`sender_id.eq.${user.id},receiver_id.eq.${user.id}`),
                supabase
                    .from('direct_chat_participants')
                    .select('chat_id')
                    .eq('user_id', user.id)
            ]);

            const friendIds = friendRequestsRes.data?.map((r: any) =>
                r.sender_id === user.id ? r.receiver_id : r.sender_id
            ) || [];

            const myChatIds = participationsRes.data?.map(p => p.chat_id) || [];
            let existingChatsMap = new Map<string, string>();

            if (myChatIds.length > 0) {
                const { data: chatPartners } = await supabase
                    .from('direct_chat_participants')
                    .select('chat_id, user_id')
                    .in('chat_id', myChatIds)
                    .neq('user_id', user.id);

                chatPartners?.forEach((p: any) => {
                    existingChatsMap.set(p.user_id, p.chat_id);
                });
            }

            if (friendIds.length === 0) {
                setDmChats([]);
                return;
            }

            const { data: profiles } = await supabase
                .from('user_profiles')
                .select('id, name, avatar_url')
                .in('id', friendIds);

            const combined = profiles?.map((profile: any) => ({
                chat_id: existingChatsMap.get(profile.id) || null,
                user: profile
            })) || [];

            setDmChats(combined);
            localStorage.setItem('forum_dm_cache', JSON.stringify(combined));
        } catch (e) {
            console.error('Error fetching DMs:', e);
        } finally {
            setIsLoadingDMs(false);
        }
    };

    useEffect(() => {
        fetchDMs();
    }, [user?.id]); // Aggressive pre-fetch

    // Fetch topic_content for Courses区域
    useEffect(() => {
        const fetchTopics = async () => {
            const { data } = await supabase
                .from('topic_content')
                .select('id, title')
                .order('id');
            if (data) setTopicContent(data);
        };
        fetchTopics();
    }, []);

    // Scroll to bottom when messages change
    useEffect(() => {
        if (!chatEndRef.current || isLoadingMessages || !location.pathname.startsWith('/forum')) return;

        // Only auto-scroll to bottom if we are ALREADY near the bottom
        // Or if it's the initial load
        chatEndRef.current.scrollIntoView({ behavior: 'smooth' });
    }, [messages, activeChannelId, isLoadingMessages, location.pathname]);

    // Force scroll when Forum becomes visible
    useEffect(() => {
        if (location.pathname.startsWith('/forum')) {
            setTimeout(() => scrollToBottom(), 100);
        }
    }, [location.pathname]);

    // Subscribe to Channels and Messages
    useEffect(() => {
        if (!activeChannelId && !activeChatId) {
            setIsLoadingMessages(false);
            return;
        }

        const isChannel = viewMode === 'channel';
        const targetId = isChannel ? activeChannelId : activeChatId;
        const cacheKey = `forum_messages_cache_${targetId}`;

        const fetchMessages = async () => {
            // Aggressive Cache Check for "Zero Delay"
            const cached = localStorage.getItem(cacheKey);
            let hasCachedData = false;
            if (cached) {
                try {
                    const parsed = JSON.parse(cached);
                    if (Array.isArray(parsed) && parsed.length > 0) {
                        setMessages(parsed);
                        setIsLoadingMessages(false); // Instantly show cached messages
                        hasCachedData = true;
                    }
                } catch (e) {
                    console.error('Error parsing message cache:', e);
                }
            }

            // Only show loading if we have NO messages at all (including cache)
            if (!hasCachedData && messages.length === 0) {
                setIsLoadingMessages(true);
            }

            try {
                const table = isChannel ? 'forum_messages' : 'direct_messages';
                const filterCol = isChannel ? 'channel_id' : 'chat_id';

                const { data, error } = await supabase
                    .from(table)
                    .select(`
                        *,
                        user:user_profiles!user_id(name, avatar_url, is_official, show_name, equipped_title:titles(*))
                    `)
                    .eq(filterCol, targetId)
                    .order('created_at', { ascending: false })
                    .limit(50);

                if (error) {
                    // Fallback: fetch messages without join, then separately fetch user profiles
                    console.warn('Forum join query failed, using fallback:', error.message);
                    const { data: rawData, error: rawError } = await supabase
                        .from(table)
                        .select('*')
                        .eq(filterCol, targetId)
                        .order('created_at', { ascending: false })
                        .limit(50);
                    if (rawError) throw rawError;

                    // Collect unique user_ids and fetch their profiles
                    const userIds = [...new Set(rawData.map((m: any) => m.user_id).filter(Boolean))];
                    let profileMap: Record<string, any> = {};
                    if (userIds.length > 0) {
                        const { data: profiles } = await supabase
                            .from('user_profiles')
                            .select('id, name, avatar_url, is_official, show_name, equipped_title:titles(name, category, threshold)')
                            .in('id', userIds);
                        if (profiles) {
                            for (const p of profiles) {
                                profileMap[p.id] = p;
                            }
                        }
                        // If titles join also fails, try without it
                        if (!profiles) {
                            const { data: profiles2 } = await supabase
                                .from('user_profiles')
                                .select('id, name, avatar_url, is_official, show_name')
                                .in('id', userIds);
                            if (profiles2) {
                                for (const p of profiles2) {
                                    profileMap[p.id] = p;
                                }
                            }
                        }
                    }

                    const mapped: Message[] = rawData.reverse().map((m: any) => {
                        const prof = profileMap[m.user_id];
                        const isVisible = prof?.show_name ?? true;
                        return {
                            ...m,
                            user: prof ? {
                                name: isVisible ? (prof.name || 'User') : 'Anonymous',
                                avatarUrl: isVisible ? prof.avatar_url : undefined,
                                is_official: isVisible ? (prof.is_official || false) : false,
                                equipped_title: isVisible ? prof.equipped_title : null,
                                email: 'hidden'
                            } : { name: 'User', avatarUrl: undefined }
                        };
                    });
                    setMessages(mapped);
                    localStorage.setItem(cacheKey, JSON.stringify(mapped));
                } else {
                    const mapped: Message[] = data.reverse().map((m: any) => ({
                        ...m,
                        user: {
                            name: (m.user?.show_name ?? true) ? (m.user?.name || 'User') : 'Anonymous',
                            avatarUrl: (m.user?.show_name ?? true) ? m.user?.avatar_url : undefined,
                            is_official: (m.user?.show_name ?? true) ? (m.user?.is_official || false) : false,
                            equipped_title: (m.user?.show_name ?? true) ? m.user?.equipped_title : null,
                            email: 'hidden'
                        }
                    }));

                    // ============================================================
                    // FETCH LIKE DATA for all messages (Channels & DMs)
                    // ============================================================
                    if (mapped.length > 0) {
                        const messageIds = mapped.map(m => m.id);

                        // Fetch all reactions for these messages
                        const { data: reactions, error: reactError } = await supabase
                            .from('message_reactions')
                            .select('message_id, user_id, reaction_type')
                            .in('message_id', messageIds)
                            .eq('reaction_type', 'like');

                        if (!reactError && reactions) {
                            // Build map: messageId -> { count, isLikedByMe }
                            const likeData = new Map<string, { count: number, isLikedByMe: boolean }>();

                            reactions.forEach((r: any) => {
                                if (!likeData.has(r.message_id)) {
                                    likeData.set(r.message_id, { count: 0, isLikedByMe: false });
                                }
                                const data = likeData.get(r.message_id)!;
                                data.count++;
                                if (r.user_id === user?.id) {
                                    data.isLikedByMe = true;
                                }
                            });

                            // Enrich mapped messages with like data
                            mapped.forEach((m: any) => {
                                const likes = likeData.get(m.id);
                                m.like_count = likes?.count || 0;
                                m.is_liked_by_me = likes?.isLikedByMe || false;
                            });
                        }
                    }

                    setMessages(mapped);
                    localStorage.setItem(cacheKey, JSON.stringify(mapped));
                }

            } catch (err) {
                console.error('Error fetching messages:', err);
            } finally {
                setIsLoadingMessages(false);
                scrollToBottom();
            }
        };

        fetchMessages();

        // ============================================================
        // POLLING FALLBACK: Refresh like counts every 10 seconds
        // This ensures cross-user visibility even if Realtime is not active
        // ============================================================
        const likePollingInterval = setInterval(async () => {
            try {
                const currentMessages = document.querySelectorAll('[id^="msg-"]');
                const messageIds: string[] = [];
                currentMessages.forEach(el => {
                    const id = el.id.replace('msg-', '');
                    if (id) messageIds.push(id);
                });

                if (messageIds.length === 0) return;

                const { data: reactions, error } = await supabase
                    .from('message_reactions')
                    .select('message_id, user_id, reaction_type')
                    .in('message_id', messageIds)
                    .eq('reaction_type', 'like');

                if (error || !reactions) return;

                // Build like map
                const likeMap = new Map<string, { count: number, isLikedByMe: boolean }>();
                messageIds.forEach(id => likeMap.set(id, { count: 0, isLikedByMe: false }));

                reactions.forEach((r: any) => {
                    const entry = likeMap.get(r.message_id);
                    if (entry) {
                        entry.count++;
                        if (r.user_id === user?.id) {
                            entry.isLikedByMe = true;
                        }
                    }
                });

                // Update messages state with fresh like data
                setMessages(prev => prev.map(m => {
                    const likeData = likeMap.get(m.id);
                    if (likeData) {
                        return {
                            ...m,
                            like_count: likeData.count,
                            is_liked_by_me: likeData.isLikedByMe
                        };
                    }
                    return m;
                }));
            } catch (e) {
                // Silent fail for polling
            }
        }, 10000);

        // ============================================================
        // UNIFIED REALTIME SUBSCRIPTION (Messages + Reactions)
        // ============================================================
        console.log(`[Realtime] Subscribing to ${isChannel ? 'channel' : 'dm'}:${targetId}`);

        const channelSub = supabase
            .channel(`forum:${targetId}`)
            // 1. MESSAGES (INSERT)
            .on('postgres_changes', {
                event: 'INSERT',
                schema: 'public',
                table: isChannel ? 'forum_messages' : 'direct_messages',
                filter: `${isChannel ? 'channel_id' : 'chat_id'}=eq.${targetId}`
            }, async (payload) => {
                console.log('[Realtime] New Message:', payload.new);
                handleNewMessage(payload.new, isChannel ? 'channel' : 'dm');
            })
            // 2. MESSAGES (DELETE)
            .on('postgres_changes', {
                event: 'DELETE',
                schema: 'public',
                table: isChannel ? 'forum_messages' : 'direct_messages',
                filter: `${isChannel ? 'channel_id' : 'chat_id'}=eq.${targetId}`
            }, (payload) => {
                console.log('[Realtime] Message Deleted:', payload.old);
                const deletedId = (payload.old as any)?.id;
                if (deletedId) {
                    setMessages(prev => prev.filter(m => m.id !== deletedId));
                }
            })
            // 3. MESSAGES (UPDATE - PINS)
            .on('postgres_changes', {
                event: 'UPDATE',
                schema: 'public',
                table: isChannel ? 'forum_messages' : 'direct_messages',
                filter: `${isChannel ? 'channel_id' : 'chat_id'}=eq.${targetId}`
            }, (payload) => {
                console.log('[Realtime] Message Updated:', payload.new);
                const updated = payload.new as any;
                if (updated?.id) {
                    setMessages(prev => prev.map(m => m.id === updated.id ? { ...m, is_pinned: updated.is_pinned } : m));
                }
            })
            // 4. REACTIONS (INSERT - LIKE)
            .on('postgres_changes', {
                event: 'INSERT',
                schema: 'public',
                table: 'message_reactions'
            }, (payload) => {
                const newReaction = payload.new as any;
                console.log('[Realtime] Like Event (INSERT):', newReaction);

                // Skip events from current user - already handled by optimistic update
                if (newReaction.user_id === user?.id) return;

                if (newReaction.reaction_type === 'like') {
                    setMessages(prev => {
                        const updated = prev.map(m => {
                            if (m.id === newReaction.message_id) {
                                return {
                                    ...m,
                                    like_count: (m.like_count || 0) + 1
                                };
                            }
                            return m;
                        });
                        return updated;
                    });
                }
            })
            // 5. REACTIONS (DELETE - UNLIKE)
            .on('postgres_changes', {
                event: 'DELETE',
                schema: 'public',
                table: 'message_reactions'
            }, (payload) => {
                const deletedReaction = payload.old as any;
                console.log('[Realtime] Like Event (DELETE):', deletedReaction);

                // Skip events from current user - already handled by optimistic update
                if (deletedReaction.user_id === user?.id) return;

                if (deletedReaction.reaction_type === 'like' || !deletedReaction.reaction_type) {
                    if (!deletedReaction.message_id) {
                        console.warn('[Realtime] Missing message_id in DELETE event. Check REPLICA IDENTITY.');
                        return;
                    }
                    setMessages(prev => prev.map(m => {
                        if (m.id === deletedReaction.message_id) {
                            return {
                                ...m,
                                like_count: Math.max(0, (m.like_count || 0) - 1)
                            };
                        }
                        return m;
                    }));
                }
            })
            .subscribe((status) => {
                console.log(`[Realtime] Subscription status for ${targetId}:`, status);
            });

        return () => {
            console.log(`[Realtime] Unsubscribing from ${targetId}`);
            clearInterval(likePollingInterval);
            supabase.removeChannel(channelSub);
        };
    }, [activeChannelId, activeChatId, viewMode]);

    // --- DB-Backed Presence System (Strict Isolation) ---
    const [presenceUsers, setPresenceUsers] = useState<PresenceUser[]>([]);

    useEffect(() => {
        if (!user || !isAuthenticated) return;

        // 1. Heartbeat Function
        const sendHeartbeat = async () => {
            const contextType = viewMode === 'channel' ? 'channel' : 'dm';
            const contextId = viewMode === 'channel' ? activeChannelId : activeChatId;

            if (!contextId) {
                console.log('[Presence] No context ID. Skipping heartbeat.');
                return;
            }

            console.log(`[Presence] Sending heartbeat for user ${user.id} in context ${contextId} (${contextType})`);

            const { error } = await supabase.rpc('update_heartbeat', {
                p_context_id: contextId,
                p_context_type: contextType
            });

            if (error) {
                console.error('[Presence] Heartbeat failed:', error);
                // Don't show toast to avoid overwhelming users with connection errors
            }
        };

        // Initial heartbeat
        sendHeartbeat();
        const heartbeatInterval = setInterval(sendHeartbeat, 30000); // 30s heartbeat

        // 2. Subscription to THIS context (Strict Isolation)
        let contextId = viewMode === 'channel' ? activeChannelId : activeChatId;
        if (!contextId) {
            console.log('[Presence] No context ID. Clearing users.');
            setPresenceUsers([]);
            return () => clearInterval(heartbeatInterval);
        }

        console.log(`[Presence] Initializing tracking for context: ${contextId}`);

        const fetchInitialPresence = async () => {
            // Relaxed filter: 1 hour (3600000ms) to debug clock skew issues
            const { data, error } = await supabase
                .from('user_presence')
                .select(`
                                                    user_id,
                                                    last_seen_at,
                                                    user:user_profiles!user_id(name, avatar_url, is_official, equipped_title:titles(name, category, threshold))
                                                    `)
                .eq('current_context_id', contextId)
                // Relaxed filter: 1 minute (60000ms) - just enough for 2 heartbeats
                .gt('last_seen_at', new Date(Date.now() - 60000).toISOString());

            if (error) {
                console.error('[Presence] Fetch initial error:', error);
                showToast(`Presence Fetch Error: ${error.message}`, 'error');
            }

            if (data) {
                const mapped = data
                    .filter((p: any) => p.user_id !== user?.id) // Filter out self to avoid double counting
                    .map((p: any) => ({
                        id: p.user_id,
                        name: p.user?.name || 'User',
                        avatarUrl: p.user?.avatar_url,
                        onlineAt: p.last_seen_at,
                        is_official: p.user?.is_official,
                        equipped_title: p.user?.equipped_title ? (() => {
                            const t = Array.isArray(p.user.equipped_title) ? p.user.equipped_title[0] : p.user.equipped_title;
                            return {
                                name: t.name,
                                category: t.category,
                                threshold: t.threshold
                            };
                        })() : null
                    }));
                setPresenceUsers(mapped);
            }
        };

        fetchInitialPresence();

        const presenceSub = supabase
            .channel(`db-presence:${contextId}`)
            .on('postgres_changes', {
                event: '*',
                schema: 'public',
                table: 'user_presence',
                filter: `current_context_id=eq.${contextId}`
            }, () => {
                // Refresh on any change in this context
                fetchInitialPresence();
            })
            .subscribe((status) => {
                console.log(`[Presence] Subscription status for ${contextId}:`, status);
                if (status === 'CHANNEL_ERROR') {
                    console.warn('[Presence] Realtime Connection Failed (suppressed toast)');
                }
            });

        return () => {
            console.log('[Presence] Unsubscribing/Cleaning up ...');
            clearInterval(heartbeatInterval);
            supabase.removeChannel(presenceSub);
            setPresenceUsers([]);
        };
    }, [user, isAuthenticated, activeChannelId, activeChatId, viewMode]);

    // --- Actions ---

    const handleStartDM = async (targetUserId: string, targetUser?: { name: string, avatarUrl?: string }) => {
        if (!user) return showToast("Login required", "error");
        if (targetUserId === user.id) return showToast("You cannot DM yourself", "info");

        try {
            console.log('Starting DM with:', targetUserId);
            const { data: chatId, error } = await supabase.rpc('get_or_create_dm', { target_user_id: targetUserId });

            if (error) {
                console.error('RPC Error:', error);
                throw error;
            }

            console.log('DM Created/Found:', chatId);

            // Immediately set state to switch view
            setMessages([]); // Clear stale messages to prevent ghosting
            setActiveChannelId(null);
            setActiveChatId(chatId);
            setViewMode('dm');
            setSelectedUserProfile(null);
            setShowSearchResults(false);

            // Optimistically update dmChats
            if (targetUser && chatId) {
                setDmChats(prev => {
                    const exists = prev.find(c => c.chat_id === chatId || c.user.id === targetUserId);
                    if (exists) {
                        // Update chat_id if missing
                        if (!exists.chat_id) {
                            return prev.map(c => c.user.id === targetUserId ? { ...c, chat_id: chatId } : c);
                        }
                        return prev;
                    }

                    // Normalize avatar URL
                    // The list expects avatar_url (snake_case)
                    // The input targetUser might have avatarUrl (camelCase)
                    const avatarUrl = (targetUser as any).avatar_url || targetUser.avatarUrl;

                    return [...prev, {
                        chat_id: chatId,
                        user: {
                            id: targetUserId,
                            name: targetUser.name,
                            avatar_url: avatarUrl, // Use snake_case for consistency with DB/List
                            avatarUrl: avatarUrl,  // Keep camelCase if some other component needs it
                            email: ''
                        }
                    }];
                });
            }

            // Refresh list in background
            fetchDMs();

            // Conversation started toast removed as per request
        } catch (e: any) {
            console.error('handleStartDM Error:', e);
            showToast(e.message || "Failed to start chat", "error");
        }
    };

    const handleProfileClick = (user: { id: string, name: string, avatarUrl?: string, is_official?: boolean }) => {
        setSelectedUserProfile(user);
    };

    const renderRestrictionModal = () => {
        if (!showRestrictionModal) return null;
        return (
            <div className="fixed inset-0 z-[100] flex items-center justify-center p-4 bg-black/60 backdrop-blur-sm animate-fade-in" onClick={() => setShowRestrictionModal(false)}>
                <div className="bg-white dark:bg-surface-dark w-full max-w-sm rounded-3xl p-6 shadow-2xl border border-gray-200 dark:border-gray-800 relative animate-fade-in-up" onClick={e => e.stopPropagation()}>
                    <button
                        onClick={() => setShowRestrictionModal(false)}
                        className="absolute top-4 right-4 p-1 rounded-full hover:bg-gray-100 dark:hover:bg-white/10 transition-colors text-gray-400"
                    >
                        <span className="material-symbols-outlined text-xl">close</span>
                    </button>

                    <div className="flex flex-col items-center text-center mt-2 mb-6">
                        <div className="w-14 h-14 bg-gray-100 dark:bg-white/10 rounded-2xl flex items-center justify-center text-text-main dark:text-white mb-4">
                            <span className="material-symbols-outlined text-3xl">lock_person</span>
                        </div>
                        <h3 className="text-xl font-black text-text-main dark:text-white">Authorized Account Required</h3>
                        <p className="text-sm text-gray-500 mt-2 px-2">
                            Only authorized accounts can post in this channel.
                        </p>
                    </div>

                    <div className="flex flex-col gap-4 text-center">
                        <div className="bg-gray-50 dark:bg-black/20 p-4 rounded-xl text-sm text-gray-600 dark:text-gray-300">
                            To request authorization, please email:
                            <a href="mailto:newmao6120@gmail.com" className="block mt-2 font-bold text-primary hover:underline">
                                newmao6120@gmail.com
                            </a>
                        </div>
                        <button
                            onClick={() => setShowRestrictionModal(false)}
                            className="w-full py-3.5 bg-black dark:bg-white text-white dark:text-black rounded-xl font-bold shadow-md hover:opacity-90 active:scale-95 transition-all"
                        >
                            Got it
                        </button>
                    </div>
                </div>
            </div>
        );
    };

    const renderProfileModal = () => {
        if (!selectedUserProfile) return null;
        return (
            <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/50 backdrop-blur-sm" onClick={() => setSelectedUserProfile(null)}>
                <div className="bg-white dark:bg-zinc-800 rounded-2xl p-6 w-80 shadow-2xl transform transition-all scale-100 border border-gray-200 dark:border-gray-700 relative" onClick={e => e.stopPropagation()}>
                    <button
                        onClick={() => setSelectedUserProfile(null)}
                        className="absolute top-4 right-4 text-gray-400 hover:text-gray-600 dark:hover:text-gray-200 transition-colors"
                    >
                        <span className="material-symbols-outlined text-xl">close</span>
                    </button>
                    <div className="flex flex-col items-center">
                        <div className="relative mb-4 cursor-pointer hover:opacity-90 transition-opacity" onClick={() => navigate(`/profile/${selectedUserProfile.id}`)}>
                            <img
                                src={selectedUserProfile.avatarUrl || 'https://via.placeholder.com/150'}
                                alt={selectedUserProfile.name}
                                className="w-24 h-24 rounded-full border-4 border-gray-100 dark:border-gray-700 shadow-md object-cover"
                            />
                            <div className="absolute bottom-1 right-1 w-5 h-5 bg-green-500 rounded-full border-4 border-white dark:border-zinc-800"></div>
                        </div>

                        <div className="flex items-center gap-2 mb-6">
                            <h2 className="text-xl font-bold text-text-main dark:text-white hover:underline cursor-pointer" onClick={() => navigate(`/profile/${selectedUserProfile.id}`)}>{selectedUserProfile.name}</h2>
                            {selectedUserProfile.is_official && (
                                <span className="text-[10px] px-2 py-0.5 bg-primary text-white rounded-full font-black tracking-widest shadow-sm shadow-primary/20">OFFICIAL</span>
                            )}
                        </div>

                        <div className="flex flex-col gap-3 w-full">
                            <button
                                onClick={() => navigate(`/profile/${selectedUserProfile.id}`)}
                                className="w-full flex items-center justify-center gap-2 bg-gray-50 dark:bg-white/5 text-text-main dark:text-white py-2.5 rounded-xl font-medium hover:bg-gray-100 dark:hover:bg-white/10 transition-all border border-gray-200 dark:border-gray-700"
                            >
                                <span className="material-symbols-outlined">id_card</span>
                                View Profile
                            </button>

                            {/* Conditional Actions based on Friend Status */}
                            {user?.id !== selectedUserProfile.id && (
                                <>
                                    {friendStatus === 'friends' ? (
                                        // Friend: Show Send Message
                                        <button
                                            onClick={() => handleStartDM(selectedUserProfile.id, selectedUserProfile)}
                                            className="w-full flex items-center justify-center gap-2 bg-primary text-white py-2.5 rounded-xl font-medium hover:brightness-110 transition-all shadow-lg shadow-primary/20"
                                        >
                                            <span className="material-symbols-outlined">chat_bubble</span>
                                            Send Message
                                        </button>
                                    ) : friendStatus === 'pending_sent' ? (
                                        // Pending Sent
                                        <button
                                            disabled
                                            className="w-full flex items-center justify-center gap-2 bg-gray-100 dark:bg-white/5 text-gray-400 py-2.5 rounded-xl font-medium cursor-default"
                                        >
                                            <span className="material-symbols-outlined">schedule</span>
                                            Request Sent
                                        </button>
                                    ) : friendStatus === 'pending_received' ? (
                                        // Pending Received
                                        <button
                                            onClick={handleAcceptFriendRequest}
                                            className="w-full flex items-center justify-center gap-2 bg-green-500 text-white py-2.5 rounded-xl font-medium hover:brightness-110 transition-all shadow-lg shadow-green-500/20"
                                        >
                                            <span className="material-symbols-outlined">person_add</span>
                                            Accept Request
                                        </button>
                                    ) : (
                                        // Not Friends (None) -> Add Friend ONLY (No Send Message)
                                        <button
                                            onClick={handleSendFriendRequest}
                                            className="w-full flex items-center justify-center gap-2 bg-gray-100 dark:bg-white/5 text-text-main dark:text-white py-2.5 rounded-xl font-medium hover:bg-gray-200 dark:hover:bg-white/10 transition-all"
                                        >
                                            <span className="material-symbols-outlined">person_add</span>
                                            Add Friend
                                        </button>
                                    )}
                                </>
                            )}
                        </div>
                    </div>
                </div>
            </div>
        );
    };

    const sendMessageInternal = async (content: string) => {
        if (!content.trim() || (!activeChannelId && !activeChatId) || !user) return;

        const isChannel = viewMode === 'channel';
        const timestamp = new Date().toISOString();
        const tempId = 'temp-' + Date.now();

        // --- Optimistic UI Update ---
        const optimisticMsg: Message = {
            id: tempId,
            channel_id: activeChannelId || '',
            user_id: user.id,
            content: content,
            created_at: timestamp,
            is_pinned: false,
            user: {
                name: user.name || 'User',
                avatarUrl: user.avatarUrl,
                email: user.email,
                is_official: user.isCreator, // Syncing official badge
                equipped_title: user.equippedTitle ? {
                    name: user.equippedTitle.name,
                    category: user.equippedTitle.category,
                    threshold: user.equippedTitle.threshold
                } : null
            }
        };

        setMessages(prev => [...prev, optimisticMsg]);
        scrollToBottom();

        try {
            if (isChannel) {
                const { error } = await supabase
                    .from('forum_messages')
                    .insert({
                        channel_id: activeChannelId,
                        user_id: user.id,
                        content: content
                    });
                if (error) throw error;
            } else {
                const { error } = await supabase
                    .from('direct_messages')
                    .insert({
                        chat_id: activeChatId,
                        user_id: user.id,
                        content: content
                    });
                if (error) throw error;
            }
        } catch (err: any) {
            console.error('Failed to send:', err);

            // Handle specifically the message limit error
            if (err.message && err.message.includes('Non-friends can only send 1')) {
                showToast(err.message, 'error');
            } else {
                console.error("Full error object:", err);
                showToast(`Failed to send: ${err.message || 'Unknown error'}`, 'error');
            }

            // Revert optimistic update
            setMessages(prev => prev.filter(m => m.id !== tempId));
            // Restore text if it was a failed text message
            if (content === inputText) setInputText(content);
        }
    };

    const handleSendMessage = async (e?: React.FormEvent) => {
        e?.preventDefault();
        const content = inputText.trim();
        if (!content) return;

        setInputText('');
        if (textareaRef.current) textareaRef.current.style.height = 'auto';

        await sendMessageInternal(content);
    };

    const handleKeyDown = (e: React.KeyboardEvent) => {
        // IME Composition Check: Don't send if the user is typing Chinese/Japanese/etc.
        if (e.nativeEvent.isComposing) return;

        if (e.key === 'Enter' && !e.shiftKey) {
            e.preventDefault();
            handleSendMessage();
        }
    };

    const handleReply = (msg: Message) => {
        const quote = `> **${msg.user?.name || 'User'}**: ${msg.content.substring(0, 50)}${msg.content.length > 50 ? '...' : ''}\n\n`;
        setInputText(quote);
        if (textareaRef.current) {
            textareaRef.current.focus();
            setTimeout(() => {
                textareaRef.current!.style.height = 'auto'; // Reset height
                textareaRef.current!.style.height = textareaRef.current!.scrollHeight + 'px'; // Expand
            }, 0);
        }
    };

    const groupedChannels = channels
        .filter(channel => {
            const search = sidebarSearchQuery.toLowerCase();
            const nameMatch = channel.name?.toLowerCase().includes(search);
            const catMatch = (channel.category || '').toLowerCase().includes(search);
            return nameMatch || catMatch;
        })
        .reduce((acc, channel) => {
            const cat = channel.category || 'Community';
            if (!acc[cat]) acc[cat] = [];
            acc[cat].push(channel);
            return acc;
        }, {} as Record<string, Channel[]>);

    const activeChannel = channels.find(c => c.id === activeChannelId);
    const activeDmChat = dmChats.find(c => c.chat_id === activeChatId);

    // Get display name and description for header
    const displayChannelName = viewMode === 'channel'
        ? (activeChannel?.category === 'Community' && activeChannel?.name?.toLowerCase() === 'general'
            ? 'General Community'
            : (activeChannel?.name || 'Select a Channel'))
        : (activeDmChat?.user?.name || 'Private Chat');

    const displayChannelDesc = viewMode === 'channel'
        ? (activeChannel?.description || '')
        : 'Private Direct Message';

    const handleFileUpload = async (e: React.ChangeEvent<HTMLInputElement>) => {
        const file = e.target.files?.[0];
        if (!file || !user) return;

        setIsUploading(true);
        try {
            const { url } = await api.upload.uploadImage(file);
            // Append markdown image
            const imageMarkdown = `![Image](${url})`;
            setInputText(prev => prev ? `${prev}\n${imageMarkdown}` : imageMarkdown);
            // Focus back
            textareaRef.current?.focus();
        } catch (err: any) {
            console.error(err);
            showToast(err.message || 'Upload failed', 'error');
        } finally {
            setIsUploading(false);
            if (fileInputRef.current) fileInputRef.current.value = ''; // Reset
        }
    };

    const addEmoji = (emoji: string) => {
        sendMessageInternal(emoji);
        setShowEmojiPicker(false);
        textareaRef.current?.focus();
    };

    // Close pickers on outside click (simple implementation)
    useEffect(() => {
        const handleClickOutside = (e: MouseEvent) => {
            const target = e.target as HTMLElement;
            if (!target.closest('.picker-container') && !target.closest('.picker-popover')) {
                setShowEmojiPicker(false);
            }
        };
        document.addEventListener('mousedown', handleClickOutside);
        return () => document.removeEventListener('mousedown', handleClickOutside);
    }, []);

    // --- Tree Builder ---
    const messageTree = React.useMemo(() => {
        const sortedMessages = [...messages].sort((a, b) =>
            new Date(a.created_at).getTime() - new Date(b.created_at).getTime()
        );

        const map = new Map<string, Message>();
        const roots: Message[] = [];

        // 1. Initialize map
        sortedMessages.forEach(m => {
            map.set(m.id, { ...m, replies: [] });
        });

        // 2. Build tree
        sortedMessages.forEach(m => {
            const node = map.get(m.id)!;
            // Check for reply_to_id.
            // Note: DB logic should ensure reply_to_id is valid.
            // Also logic to prevent cycles if needed, but for now trust DB.
            if (m.reply_to_id && map.has(m.reply_to_id)) {
                map.get(m.reply_to_id)!.replies!.push(node);
            } else {
                roots.push(node);
            }
        });

        return roots;
    }, [messages]);

    // --- Handlers ---

    // Unified handler for both Root messages and Replies
    const handleSendReply = async (parentId: string, content: string) => {
        if (!user) return;

        // --- Optimistic UI Update for Reply ---
        const tempId = 'temp-reply-' + Date.now();
        const optimisticMsg: Message = {
            id: tempId,
            channel_id: activeChannelId!, // activeChannelId is checked in render
            user_id: user.id,
            content: content,
            created_at: new Date().toISOString(),
            is_pinned: false,
            reply_to_id: parentId, // Important: Include this for tree builder
            user: {
                name: user.name || 'User',
                avatarUrl: user.avatarUrl,
                email: user.email
            }
        };

        setMessages(prev => [...prev, optimisticMsg]);
        // Note: We don't scroll to bottom here because the reply is inline.
        // The user is looking at the thread.

        try {
            if (activeChatId) {
                // DM Reply
                const { error } = await supabase
                    .from('direct_messages')
                    .insert({
                        chat_id: activeChatId,
                        user_id: user.id,
                        content: content,
                        reply_to_id: parentId // Needs migration
                    });
                if (error) throw error;
            } else {
                // Channel Reply
                const { error } = await supabase
                    .from('forum_messages') // Existing logic
                    .insert({
                        channel_id: activeChannelId,
                        user_id: user.id,
                        content: content,
                        reply_to_id: parentId
                    });
                if (error) throw error;
            }


        } catch (e) {
            console.error(e);
            showToast('Failed to reply', 'error');
            // Revert optimistic
            setMessages(prev => prev.filter(m => m.id !== tempId));
        }
    };
    const handleCreateChannel = async (name: string, description: string) => {
        if (!user || !createCategory) return;

        try {
            // ✅ 检查普通用户的创建限制（只针对Custom分类）
            if (createCategory === 'Custom' && user.email !== 'newmao6120@gmail.com') {
                const { count, error: countError } = await supabase
                    .from('forum_channels')
                    .select('*', { count: 'exact', head: true })
                    .eq('category', 'Custom')
                    .eq('creator_id', user.id);

                if (countError) throw countError;

                if (count && count >= 1) {
                    showToast('You can only create 1 custom channel. Delete your existing channel to create a new one.', 'error');
                    return;
                }
            }

            // Basic slug generation: name is already sanitized in input
            const slug = `${name}-${Date.now().toString().slice(-4)}`;

            // 1. Create the channel
            const { data, error } = await supabase
                .from('forum_channels')
                .insert({
                    name: name,
                    description: description,
                    category: createCategory,
                    slug: slug,
                    position: 99, // Put at end
                    creator_id: user.id // ✅ 记录创建者
                })
                .select()
                .single();

            if (error) throw error;

            // 2. Automatically add creator as a member
            const { error: memberError } = await supabase
                .from('channel_members')
                .insert({
                    channel_id: data.id,
                    user_id: user.id
                });

            if (memberError) console.error("Failed to add creator as member:", memberError);

            showToast(`Channel #${name} created!`, 'success');

            // Optimistic add
            setChannels(prev => [...prev, data]);
            setActiveChannelId(data.id);
            setCreateModalOpen(false);

        } catch (e: any) {
            console.error(e);
            showToast(e.message || 'Failed to create channel', 'error');
        }
    };



    const handleJoinChannel = async (channel: any) => {
        if (!user) return;

        // Prevent owners from joining their own channels
        if (channel.creator_id === user.id) {
            showToast('You are the owner of this channel', 'info');
            return;
        }

        // ✅ 乐观更新：立刻显示频道
        if (!channels.find(c => c.id === channel.id)) {
            const newChannel = { ...channel };
            setChannels(prev => [...prev, newChannel]);
        }
        setJoinedChannelIds(prev => new Set([...prev, channel.id])); // ✅ 添加到已加入集合
        setActiveChannelId(channel.id);
        setActiveSidebarSection('Channels'); // Ensure the sidebar section expands/highlights
        setBrowseModalOpen(false);

        // 后台异步处理加入逻辑
        try {
            // Check if already a member
            const { data: existing } = await supabase
                .from('channel_members')
                .select('*')
                .eq('channel_id', channel.id)
                .eq('user_id', user.id)
                .single();

            if (!existing) {
                const { error } = await supabase
                    .from('channel_members')
                    .insert({
                        channel_id: channel.id,
                        user_id: user.id
                    });
                if (error) throw error;
            }

            showToast(`Joined #${channel.name}`, 'success');
        } catch (e: any) {
            console.error(e);
            showToast(e.message || 'Failed to join channel', 'error');
        }
    };

    const handleInviteUser = async (targetUserId: string) => {
        if (!user || !activeChannelId) return;

        try {
            const { error } = await supabase
                .from('channel_members')
                .insert({
                    channel_id: activeChannelId,
                    user_id: targetUserId,
                    invited_by: user.id
                });

            if (error) {
                if (error.code === '23505') {
                    showToast('User is already a member', 'info');
                } else {
                    throw error;
                }
            } else {
                showToast('Invite sent!', 'success');
            }
        } catch (e: any) {
            console.error(e);
            showToast(e.message || 'Failed to invite user', 'error');
        }
    };

    const toggleCategory = (cat: string) => {
        setCollapsedCategories(prev => ({
            ...prev,
            [cat]: !prev[cat]
        }));
        // Set highlight on the clicked section header
        setActiveSidebarSection(cat);
    };

    // Pin/Unpin a message
    const handleTogglePin = async (messageId: string) => {
        const msg = messages.find(m => m.id === messageId);
        if (!msg) return;
        const newPinned = !msg.is_pinned;
        try {
            const { error } = await supabase
                .from('forum_messages')
                .update({ is_pinned: newPinned })
                .eq('id', messageId);
            if (error) throw error;
            setMessages(prev => prev.map(m => m.id === messageId ? { ...m, is_pinned: newPinned } : m));
            showToast(newPinned ? 'Message pinned!' : 'Message unpinned', 'success');
        } catch (err) {
            console.error('Failed to toggle pin:', err);
            showToast('Failed to update pin', 'error');
        }
    };

    // Hidden messages (delete for self only — stored in localStorage)
    const [hiddenMessages, setHiddenMessages] = useState<Set<string>>(() => {
        try {
            const saved = localStorage.getItem('forum_hidden_messages');
            return saved ? new Set(JSON.parse(saved)) : new Set();
        } catch { return new Set(); }
    });

    const handleDeleteForSelf = (messageId: string) => {
        setHiddenMessages(prev => {
            const next = new Set(prev);
            next.add(messageId);
            localStorage.setItem('forum_hidden_messages', JSON.stringify([...next]));
            return next;
        });
        showToast('You deleted this message', 'info');
    };

    // Recall message (delete for everyone — only within 5 min of sending)
    const handleRecallMessage = async (messageId: string) => {
        const msg = messages.find(m => m.id === messageId);
        if (!msg) return;
        const msgTime = new Date(msg.created_at).getTime();
        const now = Date.now();
        const fiveMin = 5 * 60 * 1000;
        if (now - msgTime >= fiveMin) {
            showToast('Cannot recall: more than 5 minutes have passed', 'error');
            return;
        }
        if (msg.user_id !== user?.id) {
            showToast('Cannot recall: not your message', 'error');
            return;
        }
        try {
            const { error } = await supabase
                .from('forum_messages')
                .delete()
                .eq('id', messageId);
            if (error) throw error;
            setMessages(prev => prev.filter(m => m.id !== messageId));
            showToast('Message recalled successfully', 'success');
        } catch (err) {
            console.error('Failed to recall message:', err);
            showToast('Failed to recall message', 'error');
        }
    };

    // Muted channels stored in state (per channel)
    const [mutedChannels, setMutedChannels] = useState<Set<string>>(() => {
        try {
            const saved = localStorage.getItem('forum_muted_channels');
            return saved ? new Set(JSON.parse(saved)) : new Set();
        } catch { return new Set(); }
    });

    const isChannelMuted = activeChannelId ? mutedChannels.has(activeChannelId) : false;

    const toggleMuteChannel = () => {
        if (!activeChannelId) return;
        setMutedChannels(prev => {
            const next = new Set(prev);
            if (next.has(activeChannelId!)) {
                next.delete(activeChannelId!);
            } else {
                next.add(activeChannelId!);
            }
            localStorage.setItem('forum_muted_channels', JSON.stringify([...next]));
            return next;
        });
        showToast(isChannelMuted ? 'Channel unmuted' : 'Channel muted', 'info');
    };

    // Muted chats (DMs)
    const [mutedChats, setMutedChats] = useState<Set<string>>(() => {
        try {
            const saved = localStorage.getItem('forum_muted_chats');
            return saved ? new Set(JSON.parse(saved)) : new Set();
        } catch { return new Set(); }
    });

    const isChatMuted = activeChatId ? mutedChats.has(activeChatId) : false;

    const toggleMuteChat = () => {
        if (!activeChatId) return;
        setMutedChats(prev => {
            const next = new Set(prev);
            if (next.has(activeChatId!)) {
                next.delete(activeChatId!);
            } else {
                next.add(activeChatId!);
            }
            localStorage.setItem('forum_muted_chats', JSON.stringify([...next]));
            // Dispatch event for Navbar to pick up
            window.dispatchEvent(new Event('storage'));
            window.dispatchEvent(new Event('forum_muted_chats_updated'));
            return next;
        });
        showToast(isChatMuted ? 'Chat unmuted' : 'Chat muted', 'info');
    };

    // Pinned messages for current channel
    const pinnedMessages = messages.filter(m => m.is_pinned);

    // Collect "Custom" or other channels for the bottom list
    const announcementsChannel = channels.find(c => c.category === 'Information' && c.name.toLowerCase().includes('announcement'));
    const announcementUnread = announcementsChannel ? (unreadCounts[announcementsChannel.id] || 0) : 0;
    const generalChannel = channels.find(c => c.category === 'Community' && c.name.toLowerCase() === 'general');
    const generalUnread = generalChannel ? (unreadCounts[generalChannel.id] || 0) : 0;


    // Calculate unread counts for sidebar sections
    const coursesUnread = (groupedChannels['Courses'] || [])
        .reduce((sum, ch) => sum + (unreadCounts[ch.id] || 0), 0);

    const myChannelsUnread = channels
        .filter(c => ['User', 'Official', 'Custom'].includes(c.category) && String(c.creator_id).toLowerCase() === String(user?.id).toLowerCase())
        .reduce((sum, ch) => sum + (unreadCounts[ch.id] || 0), 0);

    const joinedChannelsUnread = channels
        .filter(c => ['User', 'Official', 'Custom'].includes(c.category) && String(c.creator_id).toLowerCase() !== String(user?.id).toLowerCase() && joinedChannelIds.has(c.id))
        .reduce((sum, ch) => sum + (unreadCounts[ch.id] || 0), 0);

    const channelsTotalUnread = myChannelsUnread + joinedChannelsUnread;

    const dmTotalUnread = dmChats.reduce((sum, chat) => {
        return sum + (chat.chat_id ? (unreadCounts[chat.chat_id] || 0) : 0);
    }, 0);

    return (
        <div className="w-full flex flex-col h-full bg-background-light dark:bg-background-dark text-text-main dark:text-gray-100 font-sans overflow-hidden">
            {/* Pro Gate */}
            {!isPro && <ProGateOverlay featureName="Forum" />}
            {renderProfileModal()}
            <CreateChannelModal
                isOpen={createModalOpen}
                onClose={() => setCreateModalOpen(false)}
                category={createCategory}
                onCreate={handleCreateChannel}
            />

            <ConfirmationModal
                isOpen={confirmModal.isOpen}
                onClose={() => setConfirmModal(prev => ({ ...prev, isOpen: false }))}
                onConfirm={confirmModal.onConfirm}
                title={confirmModal.title}
                message={confirmModal.message}
            />
            <ChannelBrowseModal
                isOpen={browseModalOpen}
                onClose={() => setBrowseModalOpen(false)}
                onJoin={handleJoinChannel}
                preloadedChannels={browsableChannels}
                currentUserId={user?.id}
                joinedChannelIds={joinedChannelIds}
            />
            <AddFriendModal
                isOpen={isAddFriendModalOpen}
                onClose={() => setIsAddFriendModalOpen(false)}
            />
            <Navbar />

            <div className="flex flex-1 min-h-0 relative">

                {/* 1. Sidebar (Channel List) */}
                <div className={`
                    md:relative z-20 h-full w-64 bg-surface-light dark:bg-surface-dark flex flex-col transition-transform duration-200 ease-in-out border-r border-gray-200 dark:border-gray-800
                    ${isSidebarOpen ? 'translate-x-0' : '-translate-x-full md:translate-x-0'}
                `}>
                    {/* Channels Scroll Area */}
                    <div className="flex-1 overflow-y-auto px-3 py-6 pb-6 custom-scrollbar scroll-bounce">

                        {/* === 1. ANNOUNCEMENTS (always render, click activates channel when loaded) === */}
                        <div className="mb-4 px-2">
                            <button
                                onClick={() => {
                                    const ch = channels.find(c => c.category === 'Information' && c.name.toLowerCase().includes('announcement'));
                                    if (ch) { setViewMode('channel'); setActiveChannelId(ch.id); setActiveChatId(null); }
                                    setActiveSidebarSection('Announcements');
                                    if (window.innerWidth < 768) setIsSidebarOpen(false);
                                }}
                                className={`flex items-center gap-2 w-full px-3 py-2.5 rounded-xl transition-all ${activeSidebarSection === 'Announcements'
                                    ? 'bg-primary/10 text-primary font-bold'
                                    : 'text-text-secondary dark:text-gray-400 hover:bg-gray-100 dark:hover:bg-white/5 hover:text-text-main'
                                    }`}
                            >
                                <span className="material-symbols-outlined text-[16px] text-primary">campaign</span>
                                <span className="text-[10px] font-black uppercase tracking-widest text-primary flex-1 text-left">Announcements</span>
                                {announcementUnread > 0 && activeSidebarSection !== 'Announcements' && (
                                    <div className="min-w-[16px] h-[16px] flex items-center justify-center bg-red-500 text-white text-[9px] font-black rounded-full px-1 shadow-sm ring-1 ring-white dark:ring-surface-dark group-hover:scale-110 transition-transform">
                                        {announcementUnread > 99 ? '99+' : announcementUnread}
                                    </div>
                                )}
                            </button>
                        </div>

                        {/* === 2. GENERAL COMMUNITY (always render, click activates channel when loaded) === */}
                        <div className="mb-4 px-2">
                            <button
                                onClick={() => {
                                    const ch = channels.find(c => c.category === 'Community' && c.name.toLowerCase() === 'general');
                                    if (ch) { setViewMode('channel'); setActiveChannelId(ch.id); setActiveChatId(null); }
                                    setActiveSidebarSection('Community');
                                    if (window.innerWidth < 768) setIsSidebarOpen(false);
                                }}
                                className={`flex items-center gap-2 w-full px-3 py-2.5 rounded-xl transition-all ${activeSidebarSection === 'Community'
                                    ? 'bg-primary/10 text-primary font-bold'
                                    : 'text-text-secondary dark:text-gray-400 hover:bg-gray-100 dark:hover:bg-white/5 hover:text-text-main'
                                    }`}
                            >
                                <span className="material-symbols-outlined text-[16px] text-primary">forum</span>
                                <span className="text-[10px] font-black uppercase tracking-widest text-primary flex-1 text-left">General Community</span>
                                {generalUnread > 0 && activeSidebarSection !== 'Community' && (
                                    <div className="min-w-[16px] h-[16px] flex items-center justify-center bg-red-500 text-white text-[9px] font-black rounded-full px-1 shadow-sm ring-1 ring-white dark:ring-surface-dark group-hover:scale-110 transition-transform">
                                        {generalUnread > 99 ? '99+' : generalUnread}
                                    </div>
                                )}
                            </button>
                        </div>

                        {/* === 3. COURSES (yellow header, dropdown with AB/BC) === */}
                        <div className="mb-4 px-2">
                            <div
                                className={`flex items-center justify-between px-3 py-2.5 rounded-xl cursor-pointer select-none group transition-all ${activeSidebarSection === 'Courses' ? 'bg-primary/10' : 'hover:bg-gray-100 dark:hover:bg-white/5'}`}
                                onClick={() => toggleCategory('Courses')}
                            >
                                <div className="flex items-center gap-2 flex-1">
                                    <span className="material-symbols-outlined text-[16px] text-primary">school</span>
                                    <span className="text-[10px] font-black uppercase tracking-widest text-primary">Courses</span>
                                    {coursesUnread > 0 && (collapsedCategories['Courses'] || activeSidebarSection !== 'Courses') && (
                                        <div className="min-w-[16px] h-[16px] flex items-center justify-center bg-red-500 text-white text-[9px] font-black rounded-full px-1 shadow-sm ring-1 ring-white dark:ring-surface-dark transition-transform ml-auto mr-2">
                                            {coursesUnread > 99 ? '99+' : coursesUnread}
                                        </div>
                                    )}
                                </div>
                                <span className={`material-symbols-outlined text-xs text-gray-400 transition-transform ${collapsedCategories['Courses'] ? '-rotate-90' : 'rotate-0'}`}>
                                    expand_more
                                </span>
                            </div>
                            {!collapsedCategories['Courses'] && (
                                <div className="mt-1 pl-2 space-y-0.5">
                                    {isLoadingChannels ? (
                                        [1, 2, 3].map(i => <SidebarItemSkeleton key={i} />)
                                    ) : (
                                        <>
                                            {(groupedChannels['Courses'] || []).map(ch => (
                                                <ChannelItem
                                                    key={ch.id}
                                                    name={ch.name}
                                                    isActive={activeChannelId === ch.id}
                                                    unreadCount={unreadCounts[ch.id] || 0}
                                                    onClick={() => {
                                                        setActiveSidebarSection('Courses');
                                                        setViewMode('channel');
                                                        setActiveChannelId(ch.id);
                                                        setActiveChatId(null);
                                                        if (window.innerWidth < 768) setIsSidebarOpen(false);
                                                    }}
                                                />
                                            ))}
                                            {(groupedChannels['Courses'] || []).length === 0 && (
                                                <p className="text-[10px] text-gray-400 italic px-2 py-2">No courses available</p>
                                            )}
                                        </>
                                    )}
                                </div>
                            )}
                        </div>

                        {/* === 4. CHANNELS (yellow header, dropdown — top 10 by position, My Channels first with create button, browse button) === */}
                        <div className="mb-4 px-2">
                            <div
                                className={`flex items-center justify-between px-3 py-2.5 rounded-xl cursor-pointer select-none group transition-all ${activeSidebarSection === 'Channels' ? 'bg-primary/10' : 'hover:bg-gray-100 dark:hover:bg-white/5'}`}
                                onClick={() => toggleCategory('Channels')}
                            >
                                <div className="flex items-center gap-2 flex-1">
                                    <span className="material-symbols-outlined text-[16px] text-primary">tag</span>
                                    <span className="text-[10px] font-black uppercase tracking-widest text-primary">Channels</span>
                                    {channelsTotalUnread > 0 && (collapsedCategories['Channels'] || activeSidebarSection !== 'Channels') && (
                                        <div className="min-w-[16px] h-[16px] flex items-center justify-center bg-red-500 text-white text-[9px] font-black rounded-full px-1 shadow-sm ring-1 ring-white dark:ring-surface-dark transition-transform ml-auto mr-2">
                                            {channelsTotalUnread > 99 ? '99+' : channelsTotalUnread}
                                        </div>
                                    )}
                                </div>
                                <div className="flex items-center gap-1">
                                    <button
                                        onClick={(e) => { e.stopPropagation(); setBrowseModalOpen(true); }}
                                        className="w-5 h-5 flex items-center justify-center text-gray-400 hover:text-primary transition-all"
                                        title="Browse Channels"
                                    >
                                        <span className="material-symbols-outlined text-[14px]">explore</span>
                                    </button>
                                    <span className={`material-symbols-outlined text-xs text-gray-400 transition-transform ${collapsedCategories['Channels'] ? '-rotate-90' : 'rotate-0'}`}>
                                        expand_more
                                    </span>
                                </div>
                            </div>
                            {!collapsedCategories['Channels'] && (
                                <div className="mt-1 pl-2 space-y-0.5">
                                    {isLoadingChannels ? (
                                        [1, 2, 3, 4].map(i => <SidebarItemSkeleton key={i} />)
                                    ) : (
                                        <>
                                            {/* My Channels */}
                                            <div className="mb-2">
                                                <div className="flex items-center justify-between mb-1 px-1">
                                                    <span className="text-[9px] font-bold text-gray-400 uppercase tracking-widest">My Channels</span>
                                                    <button
                                                        onClick={() => { setCreateCategory('User'); setCreateModalOpen(true); }}
                                                        className="w-5 h-5 flex items-center justify-center text-gray-400 hover:text-primary transition-all"
                                                        title="Create Channel"
                                                    >
                                                        <span className="material-symbols-outlined text-[14px]">add</span>
                                                    </button>
                                                </div>
                                                {channels.filter(c => ['User', 'Official', 'Custom'].includes(c.category) && String(c.creator_id).toLowerCase() === String(user?.id).toLowerCase()).length === 0 ? (
                                                    <p className="text-[10px] text-gray-400 italic px-2 mb-2">No channels created yet</p>
                                                ) : (
                                                    channels.filter(c => ['User', 'Official', 'Custom'].includes(c.category) && String(c.creator_id).toLowerCase() === String(user?.id).toLowerCase()).slice(0, 10).map(channel => (
                                                        <ChannelItem key={channel.id} name={channel.name} isActive={activeChannelId === channel.id}
                                                            unreadCount={unreadCounts[channel.id] || 0}
                                                            onClick={() => { setActiveSidebarSection('Channels'); setViewMode('channel'); setActiveChannelId(channel.id); setActiveChatId(null); if (window.innerWidth < 768) setIsSidebarOpen(false); }}
                                                            rightElement={
                                                                <button
                                                                    onClick={(e) => handleDeleteChannel(channel, e)}
                                                                    className="text-gray-400 hover:text-red-500 transition-colors p-1 rounded-full hover:bg-red-50 dark:hover:bg-red-900/10 opacity-0 group-hover:opacity-100"
                                                                    title="Delete Channel"
                                                                >
                                                                    <span className="material-symbols-outlined text-[14px]">delete</span>
                                                                </button>
                                                            }
                                                        />
                                                    ))
                                                )}
                                            </div>

                                            {/* Joined Channels */}
                                            <div className="mb-2">
                                                <div className="flex items-center justify-between mb-1 px-1 mt-3">
                                                    <span className="text-[9px] font-bold text-gray-400 uppercase tracking-widest">Joined Channels</span>
                                                </div>
                                                {channels.filter(c => ['User', 'Official', 'Custom'].includes(c.category) && String(c.creator_id).toLowerCase() !== String(user?.id).toLowerCase() && joinedChannelIds.has(c.id)).length === 0 ? (
                                                    <p className="text-[10px] text-gray-400 italic px-2">No joined channels yet</p>
                                                ) : (
                                                    channels.filter(c => ['User', 'Official', 'Custom'].includes(c.category) && String(c.creator_id).toLowerCase() !== String(user?.id).toLowerCase() && joinedChannelIds.has(c.id)).map(channel => (
                                                        <ChannelItem key={channel.id} name={channel.name} isActive={activeChannelId === channel.id}
                                                            onClick={() => { setActiveSidebarSection('Channels'); setViewMode('channel'); setActiveChannelId(channel.id); setActiveChatId(null); if (window.innerWidth < 768) setIsSidebarOpen(false); }}
                                                            rightElement={
                                                                <button
                                                                    onClick={(e) => handleDeleteChannel(channel, e)}
                                                                    className="text-gray-400 hover:text-red-500 transition-colors p-1 rounded-full hover:bg-red-50 dark:hover:bg-red-900/10 opacity-0 group-hover:opacity-100"
                                                                    title="Leave Channel"
                                                                >
                                                                    <span className="material-symbols-outlined text-[14px]">logout</span>
                                                                </button>
                                                            }
                                                        />
                                                    ))
                                                )}
                                            </div>
                                        </>
                                    )}
                                </div>
                            )}
                        </div>

                        {/* === 5. FRIEND CHATS (last) === */}
                        {isAuthenticated && (
                            <div className="mb-4 px-2">
                                <div
                                    className={`flex items-center justify-between px-3 py-2.5 rounded-xl cursor-pointer select-none group transition-all ${activeSidebarSection === 'PrivateMessages' ? 'bg-primary/10' : 'hover:bg-gray-100 dark:hover:bg-white/5'}`}
                                    onClick={() => toggleCategory('PrivateMessages')}
                                >
                                    <div className="flex items-center gap-2 flex-1">
                                        <span className="material-symbols-outlined text-[16px] text-primary">chat</span>
                                        <span className="text-[10px] font-black uppercase tracking-widest text-primary">Friend Chats</span>
                                        {dmTotalUnread > 0 && (collapsedCategories['PrivateMessages'] || activeSidebarSection !== 'PrivateMessages') && (
                                            <div className="min-w-[16px] h-[16px] flex items-center justify-center bg-red-500 text-white text-[9px] font-black rounded-full px-1 shadow-sm ring-1 ring-white dark:ring-surface-dark transition-transform ml-auto mr-2">
                                                {dmTotalUnread > 99 ? '99+' : dmTotalUnread}
                                            </div>
                                        )}
                                    </div>
                                    <div className="flex items-center gap-1">
                                        <button
                                            onClick={(e) => {
                                                e.stopPropagation();
                                                setIsAddFriendModalOpen(true);
                                            }}
                                            className="p-1 hover:bg-gray-200 dark:hover:bg-white/10 rounded-lg transition-colors text-gray-400"
                                            title="Add Friend by Email/ID"
                                        >
                                            <span className="material-symbols-outlined text-[16px]">add</span>
                                        </button>
                                        <span className={`material-symbols-outlined text-xs text-gray-400 transition-transform ${collapsedCategories['PrivateMessages'] ? '-rotate-90' : 'rotate-0'}`}>
                                            expand_more
                                        </span>
                                    </div>
                                </div>
                                {!collapsedCategories['PrivateMessages'] && (
                                    <div className="mt-1 pl-2 space-y-0.5">
                                        {isLoadingDMs ? (
                                            [1, 2, 3].map(i => <SidebarItemSkeleton key={i} />)
                                        ) : dmChats.length === 0 ? (
                                            <p className="text-[10px] text-gray-500 italic px-2">No active conversations</p>
                                        ) : (
                                            dmChats.map(dm => (
                                                <button
                                                    key={dm.chat_id || dm.user.id}
                                                    onClick={() => {
                                                        setActiveSidebarSection('PrivateMessages');
                                                        if (dm.chat_id) {
                                                            setViewMode('dm');
                                                            setActiveChatId(dm.chat_id);
                                                            setActiveChannelId(null);
                                                        } else {
                                                            handleStartDM(dm.user.id, dm.user);
                                                        }
                                                        if (window.innerWidth < 768) setIsSidebarOpen(false);
                                                    }}
                                                    className={`group flex items-center gap-2 w-full px-3 py-2.5 rounded-xl transition-all ${dm.chat_id && activeChatId === dm.chat_id ? 'bg-primary/10 text-primary dark:text-white dark:bg-white/10' : 'text-text-secondary dark:text-gray-400 hover:bg-gray-100 dark:hover:bg-white/5'}`}
                                                >
                                                    <div className="relative shrink-0">
                                                        {dm.user?.avatar_url ? <img src={dm.user.avatar_url} className="w-6 h-6 rounded-full" alt="" /> : <div className="w-6 h-6 rounded-full bg-gray-200 dark:bg-zinc-700 flex items-center justify-center text-[10px] font-bold">{dm.user?.name?.charAt(0) || 'U'}</div>}
                                                        {presenceUsers.some(u => u.id === dm.user.id) && (
                                                            <div className="absolute -bottom-0.5 -right-0.5 w-2 h-2 rounded-full border border-white dark:border-black bg-green-500"></div>
                                                        )}
                                                    </div>
                                                    <span className={`text-sm truncate flex-1 text-left ${dm.chat_id && activeChatId === dm.chat_id ? 'font-bold' : 'font-medium'}`}>{dm.user?.name || 'User'}</span>
                                                    {dm.chat_id && unreadCounts[dm.chat_id] > 0 && activeChatId !== dm.chat_id && (
                                                        <div className="min-w-[16px] h-[16px] flex items-center justify-center bg-red-500 text-white text-[9px] font-black rounded-full px-1 shadow-sm ring-1 ring-white dark:ring-surface-dark group-hover:scale-110 transition-transform">
                                                            {unreadCounts[dm.chat_id] > 99 ? '99+' : unreadCounts[dm.chat_id]}
                                                        </div>
                                                    )}

                                                    {/* Delete Friend Button */}
                                                    {/* Action Buttons: Remove Friend (if friend) OR Close Chat (if not friend) */}
                                                    {friends.includes(dm.user.id) && (
                                                        <div
                                                            onClick={(e) => handleRemoveFriend(dm.user.id, e)}
                                                            className="text-gray-400 hover:text-red-500 p-1 rounded-full hover:bg-red-50 dark:hover:bg-red-900/10 opacity-0 group-hover:opacity-100 transition-all cursor-pointer ml-auto"
                                                            title="Remove Friend"
                                                        >
                                                            <span className="material-symbols-outlined text-[16px]">person_remove</span>
                                                        </div>
                                                    )}
                                                </button>
                                            ))
                                        )}
                                    </div>
                                )}
                            </div>
                        )}

                    </div>

                    {/* User Mini Profile - Fixed at bottom */}
                    {isAuthenticated && user && (
                        <div className="p-2 border-t border-gray-100 dark:border-gray-800 bg-white/50 dark:bg-black/20 backdrop-blur-md">
                            <div className="flex items-center gap-2 p-2 rounded-xl border border-gray-100 dark:border-white/5 shadow-sm">
                                <div className="group relative cursor-pointer shrink-0">
                                    <img src={user.avatarUrl} alt="User" className="w-9 h-9 rounded-full hover:opacity-80 transition-opacity border border-gray-200 dark:border-gray-700" />
                                    <div className="absolute bottom-0 right-0 w-3 h-3 bg-green-500 rounded-full border-2 border-white dark:border-zinc-900"></div>
                                </div>
                                <div className="flex-1 min-w-0">
                                    <div className="text-sm font-bold truncate text-text-main dark:text-white">{user.name}</div>
                                </div>
                                <div className="flex items-center gap-1 relative">
                                    {pendingPoints.amount > 0 && (
                                        <div className="group/btn relative">
                                            <button
                                                onClick={(e) => {
                                                    const rect = (e.currentTarget as HTMLElement).getBoundingClientRect();
                                                    const x = rect.left + rect.width / 2;
                                                    const y = rect.top + rect.height / 2;
                                                    triggerCoinAnimation(pendingPoints.amount, x, y);
                                                    handleClaimPoints(e);
                                                }}
                                                disabled={isClaimingPoints}
                                                className="flex items-center gap-1.5 px-3 py-1.5 bg-gradient-to-r from-primary to-amber-400 text-black text-xs font-bold rounded-lg hover:brightness-110 active:scale-95 transition-all shadow-sm animate-pulse-subtle"
                                            >
                                                <PointsCoin size="sm" animate />
                                                <span>Claim {pendingPoints.amount}</span>
                                            </button>

                                            {/* Hover Tooltip */}
                                            <div className="absolute bottom-full right-0 mb-2 hidden group-hover/btn:block z-[60]">
                                                <div className="bg-black/90 text-white text-[10px] rounded-lg px-2 py-1.5 whitespace-nowrap shadow-xl border border-white/10">
                                                    {pendingPoints.details.map((d, i) => (
                                                        <div key={i} className="flex items-center gap-2 py-0.5">
                                                            <span className="font-bold text-amber-400">+{d.total_amount}</span>
                                                            <span className="opacity-75">
                                                                {d.type === 'like_received' ? 'Likes' : d.type === 'comment_received' ? 'Comments' : 'Friends'}
                                                            </span>
                                                        </div>
                                                    ))}
                                                </div>
                                            </div>
                                        </div>
                                    )}
                                </div>
                            </div>
                        </div>
                    )}
                </div>

                {/* 2. Main Chat Area & Member Sidebar */}
                <div className={`flex-1 flex min-h-0 bg-white/50 dark:bg-black/20 relative backdrop-blur-sm overflow-hidden ${isSidebarOpen ? 'ml-64 md:ml-0' : 'ml-0'}`}>
                    {/* Chat Column */}
                    <div className="flex-1 flex flex-col min-h-0 min-w-0 border-r border-gray-200/50 dark:border-gray-800/50 relative">
                        {/* Header */}
                        <div className="min-h-[4rem] px-4 md:px-6 border-b border-gray-200 dark:border-gray-800 flex items-center justify-between shrink-0 bg-white/80 dark:bg-black/40 backdrop-blur-xl z-40 relative">
                            <div className="flex items-center gap-3 overflow-hidden py-2">
                                <button onClick={() => setIsSidebarOpen(!isSidebarOpen)} className="md:hidden text-gray-500 mr-1">
                                    <span className="material-symbols-outlined">menu</span>
                                </button>
                                <span className="text-gray-300 text-2xl font-light">#</span>
                                <div className="flex flex-col justify-center flex-1">
                                    {isLoadingChannels ? (
                                        <HeaderSkeleton />
                                    ) : (
                                        <>
                                            <h3 className="font-bold text-base truncate flex items-center gap-2 text-text-main dark:text-white leading-tight">
                                                {displayChannelName}
                                            </h3>
                                            <span className="text-xs text-text-secondary dark:text-gray-400 hidden sm:block truncate max-w-md mt-0.5">
                                                {displayChannelDesc}
                                            </span>
                                        </>
                                    )}
                                </div>
                            </div>
                            <div className="flex items-center gap-3 md:gap-6">
                                <div className="flex items-center gap-4 text-gray-400">
                                    <button
                                        className={`material-symbols-outlined cursor-pointer hover:text-primary transition-all text-[22px] flex items-center justify-center ${viewMode === 'channel'
                                            ? (isChannelMuted ? 'text-amber-500' : '')
                                            : (isChatMuted ? 'text-amber-500' : '')
                                            }`}
                                        title={
                                            viewMode === 'channel'
                                                ? (isChannelMuted ? "Unmute Channel" : "Mute Channel")
                                                : (isChatMuted ? "Unmute Chat" : "Mute Chat")
                                        }
                                        onClick={viewMode === 'channel' ? toggleMuteChannel : toggleMuteChat}
                                    >
                                        {(viewMode === 'channel' ? isChannelMuted : isChatMuted) ? 'notifications_off' : 'notifications'}
                                    </button>
                                    <button
                                        className={`material-symbols-outlined cursor-pointer hover:text-primary transition-all text-[22px] flex items-center justify-center ${showPinnedPanel ? 'text-amber-500' : ''}`}
                                        title={showPinnedPanel ? "Hide Pinned Messages" : "Show Pinned Messages"}
                                        onClick={() => {
                                            setShowPinnedPanel(prev => !prev);
                                            setShowMemberSidebar(false);
                                        }}
                                    >
                                        push_pin
                                    </button>

                                    {/* ✅ Delete Button - Restricted for System Channels */}
                                    {viewMode === 'channel' && activeChannel?.creator_id === user?.id && !['Information', 'Community', 'Courses'].includes(activeChannel.category) && (
                                        <button
                                            className="material-symbols-outlined cursor-pointer hover:text-red-500 transition-all text-[22px] flex items-center justify-center"
                                            title="Delete Channel"
                                            onClick={(e) => activeChannel && handleDeleteChannel(activeChannel, e)}
                                        >
                                            delete
                                        </button>
                                    )}

                                    <button
                                        className={`material-symbols-outlined cursor-pointer hover:text-primary transition-all text-[22px] flex items-center justify-center ${showMemberSidebar ? 'text-primary' : ''}`}
                                        title="Toggle Member List"
                                        onClick={() => {
                                            setShowMemberSidebar(!showMemberSidebar);
                                            setShowPinnedPanel(false);
                                        }}
                                    >
                                        group
                                    </button>
                                </div>
                            </div>
                        </div>

                        <div className="flex-1 flex min-h-0 relative">
                            <div className="flex-1 flex overflow-hidden relative">
                                {/* Inner Column for Messages + Input */}
                                <div className="flex-1 flex flex-col relative overflow-hidden min-w-0">
                                    {/* Messages Area */}
                                    <div className="flex-1 overflow-y-auto px-4 md:px-6 custom-scrollbar flex flex-col pt-4 pb-4 scroll-bounce">
                                        <div className="scroll-bounce-inner flex flex-col min-h-[101%]">
                                            {isLoadingChannels || isLoadingMessages ? (
                                                <ChatSkeleton />
                                            ) : (!activeChannelId && !activeChatId) ? (
                                                <div className="flex flex-col items-center justify-center flex-1 text-gray-300 dark:text-white/20">
                                                    <span className="material-symbols-outlined text-6xl mb-4">forum</span>
                                                    <p className="font-bold text-lg text-gray-400">Select a channel or conversation to start chatting</p>
                                                </div>
                                            ) : (
                                                <>
                                                    {/* Messages Tree Render */}
                                                    <div className="flex flex-col pb-0 space-y-1">
                                                        {messageTree.length === 0 && !isLoadingMessages && (
                                                            <div className="flex flex-col items-center justify-center py-12 text-gray-400 opacity-60">
                                                                <span className="material-symbols-outlined text-5xl mb-3">chat_bubble_outline</span>
                                                                <p className="text-lg font-medium">No messages yet</p>
                                                                <p className="text-sm">Be the first to start a conversation!</p>
                                                            </div>
                                                        )}
                                                        {messageTree.length === 0 && messages.length > 0 && (
                                                            // Fallback if tree build fails or weird state
                                                            <div className="text-center text-gray-400 my-4">Loading messages...</div>
                                                        )}

                                                        {messageTree.filter(msg => !hiddenMessages.has(msg.id)).map((msg) => (
                                                            <ThreadedMessageRow
                                                                key={msg.id}
                                                                message={msg}
                                                                onProfileClick={handleProfileClick}
                                                                onReplySubmit={handleSendReply}
                                                                onTogglePin={handleTogglePin}
                                                                currentUserId={user?.id}
                                                                currentUser={user}
                                                                onDelete={handleDeleteForSelf}
                                                                onRecall={handleRecallMessage}
                                                                isDM={viewMode === 'dm'}
                                                            />
                                                        ))}
                                                        <div ref={chatEndRef} />
                                                    </div>
                                                </>
                                            )}
                                        </div>
                                    </div>

                                    {/* Root Input Area — Flex layout below chat */}
                                    {(activeChannelId || activeChatId) && (
                                        <div className="px-4 md:px-6 pb-4 pt-2 z-10 sticky bottom-0 bg-white/50 dark:bg-black/20 backdrop-blur-md">
                                            {activeChannel?.category === 'Information' && user?.email !== 'newmao6120@gmail.com' ? (
                                                <div
                                                    className="relative bg-gray-50/50 dark:bg-white/5 rounded-xl px-4 py-3 border border-dashed border-gray-200 dark:border-gray-800 cursor-pointer hover:border-primary/50 transition-colors flex items-center justify-center gap-3 group group-hover:bg-white/10"
                                                    onClick={() => setShowRestrictionModal(true)}
                                                >
                                                    <span className="material-symbols-outlined text-lg text-gray-400 group-hover:text-primary transition-colors">lock_person</span>
                                                    <span className="text-sm font-medium text-gray-400 group-hover:text-gray-300 transition-colors">#{displayChannelName} is restricted to administrators only.</span>
                                                </div>
                                            ) : (
                                                <div className="relative bg-white dark:bg-surface-dark rounded-2xl shadow-lg hover:shadow-xl transition-shadow border border-gray-200/50 dark:border-gray-700/50 ring-0 outline-none focus-within:ring-1 focus-within:ring-amber-200">
                                                    {/* File Upload Button - DM Only */}
                                                    {viewMode === 'dm' && (
                                                        <>
                                                            <div
                                                                className="absolute left-3 top-0 bottom-0 flex items-center justify-center w-8 hover:bg-transparent text-gray-500 cursor-pointer transition-colors"
                                                                onClick={() => fileInputRef.current?.click()}
                                                                title="Upload Image"
                                                            >
                                                                <div className="flex items-center justify-center w-8 h-8 rounded-xl hover:bg-gray-100 dark:hover:bg-white/10 transition-colors">
                                                                    <span className={`material-symbols-outlined text-[20px] ${isUploading ? 'animate-spin' : ''}`}>
                                                                        {isUploading ? 'progress_activity' : 'add'}
                                                                    </span>
                                                                </div>
                                                            </div>
                                                            <input
                                                                type="file"
                                                                ref={fileInputRef}
                                                                className="hidden"
                                                                accept="image/*"
                                                                onChange={handleFileUpload}
                                                            />
                                                        </>
                                                    )}

                                                    <textarea
                                                        ref={textareaRef}
                                                        value={inputText}
                                                        onChange={(e) => {
                                                            setInputText(e.target.value);
                                                            e.target.style.height = 'auto';
                                                            e.target.style.height = Math.min(e.target.scrollHeight, 200) + 'px';
                                                        }}
                                                        onKeyDown={handleKeyDown}
                                                        placeholder=""
                                                        disabled={!isAuthenticated || isUploading}
                                                        rows={1}
                                                        className={`w-full bg-transparent text-text-main dark:text-gray-100 placeholder-gray-400 ${viewMode === 'dm' ? 'pl-24' : 'pl-14'} pr-24 py-4 rounded-2xl resize-none focus:outline-none focus:ring-0 border-0 outline-none ring-0 text-[15px] leading-relaxed max-h-[50vh] [&::-webkit-scrollbar]:hidden`}
                                                        style={{ minHeight: '56px' }}
                                                    />

                                                    {/* Send Button */}
                                                    <button
                                                        onClick={handleSendMessage}
                                                        disabled={!inputText.trim() || isUploading}
                                                        className="absolute right-3 top-1/2 -translate-y-1/2 bg-primary text-white px-4 py-2 rounded-xl hover:shadow-lg hover:shadow-primary/20 hover:scale-105 active:scale-95 disabled:opacity-30 disabled:grayscale disabled:scale-100 disabled:shadow-none transition-all duration-300 flex items-center gap-2 group/send"
                                                    >
                                                        <span className="text-sm font-bold tracking-tight">Send</span>
                                                        <span className="material-symbols-outlined text-[18px] group-hover/send:translate-x-0.5 group-hover/send:-translate-y-0.5 transition-transform">send</span>
                                                    </button>

                                                    {/* Popovers */}
                                                    {showEmojiPicker && (
                                                        <div
                                                            className="picker-popover absolute bottom-full right-0 mb-3 bg-white dark:bg-zinc-800 border border-gray-200 dark:border-gray-700 shadow-xl rounded-xl w-80 h-96 z-50 animate-fade-in-up flex flex-col overflow-hidden"
                                                            onMouseDown={(e) => e.preventDefault()}
                                                        >
                                                            <div className="p-3 border-b border-gray-100 dark:border-zinc-700 bg-gray-50/50 dark:bg-white/5">
                                                                <span className="text-xs font-medium text-gray-500 uppercase tracking-wider">Emoji Picker</span>
                                                            </div>
                                                            <div className="flex-1 overflow-y-auto px-3 pb-3 custom-scrollbar scroll-bounce">
                                                                <div className="scroll-bounce-inner">
                                                                    {EMOJI_CATEGORIES.map((category) => (
                                                                        <div key={category.name} className="mb-4">
                                                                            <h3 className="text-xs font-semibold text-gray-500 dark:text-gray-400 mb-2 px-1 sticky top-0 bg-white/95 dark:bg-zinc-800/95 pt-3 pb-1 z-10 backdrop-blur-sm">
                                                                                {category.name}
                                                                            </h3>
                                                                            <div className="grid grid-cols-7 gap-1">
                                                                                {category.emojis.map((emoji) => (
                                                                                    <button
                                                                                        key={emoji}
                                                                                        className="w-8 h-8 flex items-center justify-center text-xl hover:bg-gray-100 dark:hover:bg-white/10 rounded-lg transition-colors"
                                                                                        onClick={() => addEmoji(emoji)}
                                                                                    >
                                                                                        {emoji}
                                                                                    </button>
                                                                                ))}
                                                                            </div>
                                                                        </div>
                                                                    ))}
                                                                </div>
                                                            </div>
                                                        </div>
                                                    )}

                                                    {/* Emoji Toggle */}
                                                    <div className={`absolute ${viewMode === 'dm' ? 'left-12' : 'left-3'} top-0 bottom-0 flex items-center gap-1 text-gray-400 picker-container`}>
                                                        <button
                                                            className="w-8 h-8 flex items-center justify-center rounded-xl hover:bg-gray-100 dark:hover:bg-white/5 hover:text-yellow-500 transition-all relative"
                                                            onClick={() => {
                                                                setShowEmojiPicker(!showEmojiPicker);
                                                            }}
                                                        >
                                                            <span className="material-symbols-outlined text-[22px]">sentiment_satisfied</span>
                                                        </button>
                                                    </div>
                                                </div>
                                            )}

                                            {!isAuthenticated && (
                                                <div className="mt-2 text-center text-xs text-red-500 font-bold bg-red-50 dark:bg-red-900/10 py-2 rounded-lg">
                                                    You must be logged in to chat.
                                                </div>
                                            )}
                                        </div>
                                    )}
                                </div>

                                {/* Pinned Messages Panel */}
                                {showPinnedPanel && (
                                    <div className="w-80 bg-white/95 dark:bg-zinc-900/95 backdrop-blur-xl animate-fade-in-left border-l border-gray-200 dark:border-gray-800 z-30 shadow-2xl flex flex-col flex-shrink-0">
                                        <div className="h-14 px-4 flex items-center border-b border-gray-100 dark:border-gray-800/50 flex-shrink-0">
                                            <h3 className="text-[10px] font-black text-gray-400 dark:text-gray-500 uppercase tracking-widest flex items-center gap-2">
                                                <span className="material-symbols-outlined text-amber-500 text-[16px]">push_pin</span>
                                                Pinned Messages — {pinnedMessages.length}
                                            </h3>
                                        </div>
                                        <div className="flex-1 overflow-y-auto p-3 space-y-3 custom-scrollbar">
                                            {pinnedMessages.length > 0 ? (
                                                pinnedMessages.map(msg => (
                                                    <div key={msg.id} className="p-3 bg-yellow-50/50 dark:bg-yellow-900/10 rounded-xl border border-yellow-200/50 dark:border-yellow-800/30">
                                                        <div className="flex items-center gap-2 mb-2">
                                                            <div className="w-6 h-6 rounded-full bg-primary/10 flex items-center justify-center text-[10px] font-bold text-primary">
                                                                {msg.user?.name?.charAt(0).toUpperCase() || '?'}
                                                            </div>
                                                            <span className="text-xs font-bold text-text-main dark:text-white">{msg.user?.name || 'Unknown'}</span>
                                                            <span className="text-[10px] text-gray-400 ml-auto">
                                                                {new Date(msg.created_at).toLocaleDateString()}
                                                            </span>
                                                        </div>
                                                        <p className="text-xs text-gray-600 dark:text-gray-400 leading-relaxed line-clamp-4">{msg.content}</p>
                                                        <button
                                                            onClick={() => handleTogglePin(msg.id)}
                                                            className="mt-2 text-[10px] font-bold text-amber-600 hover:text-red-500 transition-colors flex items-center gap-1"
                                                        >
                                                            <span className="material-symbols-outlined text-[12px]">push_pin</span>
                                                            Unpin
                                                        </button>
                                                    </div>
                                                ))
                                            ) : (
                                                <div className="p-8 text-center text-gray-400">
                                                    <span className="material-symbols-outlined text-4xl mb-2 opacity-30">push_pin</span>
                                                    <p className="text-xs italic">No pinned messages yet.</p>
                                                    <p className="text-[10px] mt-1 text-gray-300">Right-click a message to pin it.</p>
                                                </div>
                                            )}
                                        </div>
                                    </div>
                                )}
                            </div>


                            {/* Member Sidebar Panel - Static Layout to push content */}
                            {showMemberSidebar && (
                                <div className="w-64 bg-white/95 dark:bg-zinc-900/95 backdrop-blur-xl animate-fade-in-left border-l border-gray-200 dark:border-gray-800 flex flex-col flex-shrink-0">
                                    <div className="h-14 px-4 flex items-center justify-between border-b border-gray-100 dark:border-gray-800/50 flex-shrink-0">
                                        <h3 className="text-[10px] font-black text-gray-400 dark:text-gray-500 uppercase tracking-widest">
                                            Online — {presenceUsers.length + (user ? 1 : 0)}
                                        </h3>
                                    </div>
                                    <div className="flex-1 overflow-y-auto p-3 pb-20 space-y-2 custom-scrollbar scroll-bounce">
                                        <div className="scroll-bounce-inner flex flex-col min-h-[101%]">

                                            {/* 1. YOU (Self) */}
                                            {user && (
                                                <div className="mb-4">
                                                    <h4 className="px-2 mb-2 text-[10px] font-bold text-gray-400 uppercase tracking-wider">
                                                        You
                                                    </h4>
                                                    <div className="flex items-center gap-3 p-2 rounded-xl bg-primary/10 border border-primary/20 cursor-default">
                                                        <div className="relative">
                                                            <div className="w-8 h-8 rounded-full bg-gray-200 dark:bg-gray-700 overflow-hidden ring-2 ring-white dark:ring-zinc-900 ring-primary">
                                                                {user.avatarUrl ? (
                                                                    <img src={user.avatarUrl} alt={user.name} className="w-full h-full object-cover" />
                                                                ) : (
                                                                    <div className="w-full h-full flex items-center justify-center text-xs font-bold text-gray-500">
                                                                        {user.name?.charAt(0).toUpperCase()}
                                                                    </div>
                                                                )}
                                                            </div>
                                                            <div className="absolute bottom-0 right-0 w-2.5 h-2.5 bg-green-500 rounded-full border-2 border-white dark:border-zinc-900"></div>
                                                        </div>
                                                        <div className="flex-1 min-w-0">
                                                            <div className="flex flex-wrap items-center gap-1.5 min-w-0">
                                                                <p className="text-sm font-bold text-text-main dark:text-white truncate">{user.name} (You)</p>
                                                                {user.equippedTitle && (
                                                                    <TitleBadge title={user.equippedTitle} size="xs" />
                                                                )}
                                                                {activeChannel?.creator_id === user.id && (
                                                                    <span className="text-[8px] bg-amber-500 text-white px-1.5 py-0.5 rounded font-black tracking-widest ring-1 ring-amber-500/20 shrink-0">OWNER</span>
                                                                )}
                                                                {user.isCreator && (
                                                                    <span className="text-[8px] bg-primary text-white px-1.5 py-0.5 rounded font-black tracking-widest ring-1 ring-primary/20 shrink-0">OFFICIAL</span>
                                                                )}
                                                            </div>
                                                            <p className="text-[10px] text-green-600 dark:text-green-400 truncate">Online</p>
                                                        </div>
                                                    </div>
                                                </div>
                                            )}

                                            {/* 2. FRIENDS (Online) */}
                                            {presenceUsers.filter(u => friends.includes(u.id)).length > 0 && (
                                                <div className="mb-4">
                                                    <h4 className="px-2 mb-2 text-[10px] font-bold text-green-500 uppercase tracking-wider flex items-center gap-1">
                                                        <span className="w-1.5 h-1.5 rounded-full bg-green-500"></span>
                                                        Friends — {presenceUsers.filter(u => friends.includes(u.id)).length}
                                                    </h4>
                                                    {presenceUsers.filter(u => friends.includes(u.id)).map((member) => (
                                                        <div
                                                            key={member.id}
                                                            className="flex items-center gap-3 p-2 rounded-xl bg-green-50/50 dark:bg-green-900/10 border border-green-200/50 dark:border-green-800/30 hover:bg-green-100 dark:hover:bg-green-900/20 cursor-pointer group transition-all"
                                                            onClick={() => handleProfileClick(member)}
                                                        >
                                                            <div className="relative">
                                                                <div className="w-8 h-8 rounded-full bg-gray-200 dark:bg-gray-700 overflow-hidden ring-2 ring-white dark:ring-zinc-900">
                                                                    {member.avatarUrl ? (
                                                                        <img src={member.avatarUrl} alt={member.name} className="w-full h-full object-cover" />
                                                                    ) : (
                                                                        <div className="w-full h-full flex items-center justify-center text-xs font-bold text-gray-500">
                                                                            {member.name.charAt(0).toUpperCase()}
                                                                        </div>
                                                                    )}
                                                                </div>
                                                                <div className="absolute bottom-0 right-0 w-2.5 h-2.5 bg-green-500 rounded-full border-2 border-white dark:border-zinc-900"></div>
                                                            </div>
                                                            <div className="flex-1 min-w-0">
                                                                <div className="flex flex-wrap items-center gap-1.5 min-w-0">
                                                                    <p className="text-sm font-bold text-text-main dark:text-zinc-100 truncate group-hover:text-primary transition-colors">{member.name}</p>
                                                                    {member.equipped_title && (
                                                                        <TitleBadge title={member.equipped_title} size="xs" />
                                                                    )}
                                                                    {activeChannel?.creator_id === member.id && (
                                                                        <span className="text-[8px] bg-amber-500 text-white px-1.5 py-0.5 rounded font-black tracking-widest ring-1 ring-amber-500/20 shrink-0">OWNER</span>
                                                                    )}
                                                                    {member.is_official && (
                                                                        <span className="text-[8px] bg-primary text-white px-1.5 py-0.5 rounded font-black tracking-widest ring-1 ring-primary/20 shrink-0">OFFICIAL</span>
                                                                    )}
                                                                </div>
                                                                <p className="text-[10px] text-green-600 dark:text-green-400 truncate">Online</p>
                                                            </div>
                                                        </div>
                                                    ))}
                                                </div>
                                            )}

                                            {/* 3. OTHERS (Online) - Only for Allowed Channels */}
                                            {(() => {
                                                const channelName = activeChannel?.name?.toLowerCase() || '';
                                                const channelCategory = activeChannel?.category || '';

                                                const isAllowedChannel = viewMode === 'channel' && activeChannel && (
                                                    ['Information', 'Courses'].includes(channelCategory) ||
                                                    channelName.includes('general') ||
                                                    channelName.includes('announcement')
                                                );

                                                if (!isAllowedChannel) return null;

                                                const others = presenceUsers.filter(u => !friends.includes(u.id) && u.id !== user?.id);
                                                if (others.length === 0) return null;

                                                return (
                                                    <div className="mb-4">
                                                        <h4 className="px-2 mb-2 text-[10px] font-bold text-gray-400 uppercase tracking-wider">
                                                            Waitlist / Others — {others.length}
                                                        </h4>
                                                        {others.map((member) => (
                                                            <div
                                                                key={member.id}
                                                                className="flex items-center gap-3 p-2 rounded-xl hover:bg-gray-100 dark:hover:bg-white/5 cursor-pointer group transition-all"
                                                                onClick={() => handleProfileClick(member)}
                                                            >
                                                                <div className="relative">
                                                                    <div className="w-8 h-8 rounded-full bg-gray-200 dark:bg-gray-700 overflow-hidden ring-2 ring-white dark:ring-zinc-900 group-hover:ring-primary/50 transition-all">
                                                                        {member.avatarUrl ? (
                                                                            <img src={member.avatarUrl} alt={member.name} className="w-full h-full object-cover" />
                                                                        ) : (
                                                                            <div className="w-full h-full flex items-center justify-center text-xs font-bold text-gray-500">
                                                                                {member.name.charAt(0).toUpperCase()}
                                                                            </div>
                                                                        )}
                                                                    </div>
                                                                    <div className="absolute bottom-0 right-0 w-2.5 h-2.5 bg-green-500 rounded-full border-2 border-white dark:border-zinc-900"></div>
                                                                </div>
                                                                <div className="flex-1 min-w-0">
                                                                    <div className="flex flex-wrap items-center gap-1.5 min-w-0">
                                                                        <p className="text-sm font-medium text-gray-600 dark:text-gray-300 truncate group-hover:text-text-main dark:group-hover:text-white transition-colors">{member.name}</p>
                                                                        {member.equipped_title && (
                                                                            <TitleBadge title={member.equipped_title} size="xs" />
                                                                        )}
                                                                        {activeChannel?.creator_id === member.id && (
                                                                            <span className="text-[8px] bg-amber-500 text-white px-1.5 py-0.5 rounded font-black tracking-widest ring-1 ring-amber-500/20 shrink-0">OWNER</span>
                                                                        )}
                                                                        {member.is_official && (
                                                                            <span className="text-[8px] px-1.5 py-0.5 bg-primary text-white rounded font-black tracking-tighter shrink-0">OFFICIAL</span>
                                                                        )}
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        ))}
                                                    </div>
                                                );
                                            })()}

                                            {/* 4. OFFLINE FRIENDS */}
                                            {friendProfiles.filter(fp => !presenceUsers.find(p => p.id === fp.id)).length > 0 && (
                                                <div className="mb-4">
                                                    <h4 className="px-2 mb-2 text-[10px] font-bold text-gray-400 uppercase tracking-wider">
                                                        Offline Friends — {friendProfiles.filter(fp => !presenceUsers.find(p => p.id === fp.id)).length}
                                                    </h4>
                                                    {friendProfiles.filter(fp => !presenceUsers.find(p => p.id === fp.id)).map((friend) => (
                                                        <div
                                                            key={friend.id}
                                                            className="flex items-center gap-3 p-2 rounded-xl hover:bg-gray-50 dark:hover:bg-white/5 cursor-pointer group opacity-70 hover:opacity-100 transition-all grayscale hover:grayscale-0"
                                                            onClick={() => handleProfileClick({ ...friend, onlineAt: new Date().toISOString() })}
                                                        >
                                                            <div className="relative">
                                                                <div className="w-8 h-8 rounded-full bg-gray-200 dark:bg-gray-700 overflow-hidden ring-2 ring-white dark:ring-zinc-900">
                                                                    {friend.avatar_url ? (
                                                                        <img src={friend.avatar_url} alt={friend.name} className="w-full h-full object-cover" />
                                                                    ) : (
                                                                        <div className="w-full h-full flex items-center justify-center text-xs font-bold text-gray-500">
                                                                            {friend.name?.charAt(0).toUpperCase()}
                                                                        </div>
                                                                    )}
                                                                </div>
                                                            </div>
                                                            <div className="flex-1 min-w-0">
                                                                <div className="flex flex-wrap items-center gap-1.5 min-w-0">
                                                                    <p className="text-sm font-medium text-gray-500 dark:text-gray-400 truncate">{friend.name}</p>
                                                                    {friend.equipped_title && (
                                                                        <TitleBadge title={friend.equipped_title} size="xs" />
                                                                    )}
                                                                </div>
                                                                <p className="text-[10px] text-gray-400 truncate">Offline</p>
                                                            </div>
                                                        </div>
                                                    ))}
                                                </div>
                                            )}

                                            {/* Empty State */}
                                            {presenceUsers.length === 0 && friendProfiles.length === 0 && !user && (
                                                <div className="p-8 text-center text-gray-400">
                                                    <span className="material-symbols-outlined text-4xl mb-2 opacity-30">group_off</span>
                                                    <p className="text-xs italic">No users available.</p>
                                                </div>
                                            )}
                                        </div>
                                    </div>
                                </div>
                            )}

                        </div>
                    </div>

                </div>
            </div>
        </div>

    );
};
