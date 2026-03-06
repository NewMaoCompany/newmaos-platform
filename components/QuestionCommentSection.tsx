import React, { useState, useEffect } from 'react';
import { useApp } from '../AppContext';
import { supabase } from '../src/services/supabaseClient';
import { forumApi } from '../src/services/api';

interface QuestionCommentSectionProps {
    questionId: string;
    channelSlug?: string | null;
}

export const QuestionCommentSection = ({ questionId, channelSlug }: QuestionCommentSectionProps) => {
    const { user } = useApp();
    const [messages, setMessages] = useState<any[]>([]);
    const [input, setInput] = useState('');
    const [isLoading, setIsLoading] = useState(false);
    const [channelId, setChannelId] = useState<string | null>(null);

    useEffect(() => {
        if (!questionId) return;

        const loadData = async () => {
            // 1. Resolve channel ID from slug if slug provided
            if (channelSlug) {
                const { data: channel } = await supabase
                    .from('forum_channels')
                    .select('id')
                    .eq('slug', channelSlug)
                    .single();
                if (channel) setChannelId(channel.id);
            }

            // 2. Initial fetch - try with FK join first, fallback to no-join if 400
            let msgData: any[] | null = null;
            const { data: joinData, error: joinError } = await supabase
                .from('forum_messages')
                .select('*, user_profiles!forum_messages_user_id_fkey(name, avatar_url)')
                .eq('question_id', questionId)
                .order('created_at', { ascending: true });

            if (joinError) {
                console.warn('FK join query failed, falling back to no-join:', joinError.message);
                const { data: plainData } = await supabase
                    .from('forum_messages')
                    .select('*')
                    .eq('question_id', questionId)
                    .order('created_at', { ascending: true });
                msgData = plainData;
            } else {
                msgData = joinData;
            }

            if (msgData) setMessages(msgData);
        };

        loadData();

        // 3. Realtime subscription
        const subscription = supabase
            .channel(`question-comments-${questionId}`)
            .on('postgres_changes', {
                event: 'INSERT',
                schema: 'public',
                table: 'forum_messages',
                filter: `question_id=eq.${questionId}`
            }, (payload) => {
                const fetchNewMsg = async () => {
                    const { data } = await supabase
                        .from('forum_messages')
                        .select('*')
                        .eq('id', payload.new.id)
                        .single();
                    if (data) setMessages(prev => {
                        if (prev.find(m => m.id === data.id)) return prev;
                        return [...prev, data];
                    });
                }
                fetchNewMsg();
            })
            .subscribe();

        return () => {
            supabase.removeChannel(subscription);
        };
    }, [questionId, channelSlug]);

    const handleSend = async () => {
        if (!input.trim() || !user || isLoading) return;
        setIsLoading(true);
        const messageContent = input.trim();

        try {
            console.log('--- FORUM SUBMIT START ---');

            // Strategy 1: Try backend API first
            let success = false;
            if (forumApi && forumApi.postForumMessage) {
                try {
                    const res = await forumApi.postForumMessage(questionId, messageContent, channelId);
                    console.log('Forum response (API):', res);
                    success = true;
                    // Manually add message to UI since backend doesn't return full message object
                    // and Realtime subscription might fail due to FK join issues
                    setMessages(prev => [...prev, {
                        id: `temp-${Date.now()}`,
                        content: messageContent,
                        user_id: user.id,
                        question_id: questionId,
                        channel_id: channelId,
                        created_at: new Date().toISOString(),
                        user_profiles: { name: user.name || 'You', avatar_url: user.avatarUrl || null }
                    }]);
                } catch (apiErr: any) {
                    console.warn('Backend API forum failed, falling back to direct Supabase:', apiErr.message);
                }
            }

            // Strategy 2: Fallback to direct Supabase insert (bypasses Express backend issues)
            if (!success) {
                console.log('Using direct Supabase insert fallback...');
                const { data: insertedData, error: insertError } = await supabase
                    .from('forum_messages')
                    .insert({
                        content: messageContent,
                        user_id: user.id,
                        question_id: questionId,
                        channel_id: channelId || null
                    })
                    .select('*')
                    .single();

                if (insertError) {
                    console.error('Direct Supabase insert also failed:', insertError);
                    throw new Error(insertError.message || 'Failed to save message');
                }

                console.log('Forum response (direct Supabase):', insertedData);
                // Manually add to messages since realtime might have a delay
                if (insertedData) {
                    setMessages(prev => {
                        if (prev.find(m => m.id === insertedData.id)) return prev;
                        return [...prev, {
                            ...insertedData,
                            user_profiles: { name: user.name || 'You', avatar_url: user.avatarUrl || null }
                        }];
                    });
                }
            }

            setInput('');
        } catch (err: any) {
            console.error('Send comment error detailed:', err);
            alert(`Error: ${err.message || 'Unknown error'}`);
        } finally {
            setIsLoading(false);
        }
    };

    return (
        <div className="mt-4 border-t border-gray-100 dark:border-gray-800 pt-4">
            <h4 className="text-[11px] font-black tracking-widest uppercase text-gray-400 dark:text-gray-500 mb-3 flex items-center gap-2">
                <span className="material-symbols-outlined text-[14px]">forum</span>
                Discussion
            </h4>

            <div className={`mb-4 h-[400px] overflow-y-auto pr-2 custom-scrollbar transition-all ${messages.length === 0 ? 'flex flex-col items-center justify-center' : 'space-y-4'}`}>
                {messages.length === 0 ? (
                    <div className="text-center flex flex-col items-center gap-2 opacity-50">
                        <span className="material-symbols-outlined text-4xl text-gray-200 dark:text-gray-800">chat_bubble</span>
                        <p className="text-[11px] text-gray-400 italic">No discussions yet. Be the first to start!</p>
                    </div>
                ) : (
                    messages.map(msg => (
                        <div key={msg.id} className="flex gap-3 group animate-fade-in">
                            <img
                                src={msg.user_profiles?.avatar_url || `https://api.dicebear.com/7.x/avataaars/svg?seed=${msg.user_id}`}
                                className="w-8 h-8 rounded-full border border-gray-100 dark:border-gray-800 bg-white"
                                alt="avatar"
                            />
                            <div className="flex-1">
                                <div className="flex items-center gap-2 mb-0.5">
                                    <span className="text-[11px] font-bold text-gray-700 dark:text-gray-200">{msg.user_profiles?.name || 'User'}</span>
                                    <span className="text-[9px] text-gray-400">{new Date(msg.created_at).toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' })}</span>
                                </div>
                                <div className="bg-gray-50 dark:bg-white/5 px-3 py-2 rounded-2xl inline-block max-w-full">
                                    <p className="text-[11px] text-gray-600 dark:text-gray-400 leading-relaxed whitespace-pre-wrap">{msg.content}</p>
                                </div>
                            </div>
                        </div>
                    ))
                )}
            </div>

            <div className="flex gap-2 items-center bg-gray-50 dark:bg-white/5 rounded-2xl px-3 py-2 border border-gray-100 dark:border-gray-800/50">
                <input
                    type="text"
                    value={input}
                    onChange={(e) => setInput(e.target.value)}
                    onKeyDown={(e) => e.key === 'Enter' && handleSend()}
                    placeholder="Write a comment..."
                    className="flex-1 text-[11px] bg-transparent border-none focus:outline-none focus:ring-0 dark:text-gray-200 py-1"
                />
                <button
                    onClick={handleSend}
                    disabled={isLoading || !input.trim()}
                    className="p-1.5 bg-primary text-white rounded-xl disabled:opacity-30 transition-all hover:scale-105 active:scale-95 flex items-center justify-center shrink-0"
                >
                    <span className="material-symbols-outlined text-[16px]">send</span>
                </button>
            </div>
        </div>
    );
}
