import React, { useState, useEffect } from 'react';
import { useApp } from '../AppContext';
import { supabase } from '../src/services/supabaseClient';

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

            // 2. Initial fetch
            const { data } = await supabase
                .from('forum_messages')
                .select('*, user_profiles(name, avatar_url)')
                .eq('question_id', questionId)
                .order('created_at', { ascending: true });

            if (data) setMessages(data);
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
                        .select('*, user_profiles(name, avatar_url)')
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

        try {
            const { error } = await supabase
                .from('forum_messages')
                .insert({
                    content: input.trim(),
                    user_id: user.id,
                    question_id: questionId,
                    channel_id: channelId
                });

            if (error) throw error;
            setInput('');
        } catch (err) {
            console.error('Send comment error:', err);
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
                                    <span className="text-[11px] font-bold text-gray-700 dark:text-gray-200">{msg.user_profiles?.name}</span>
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
