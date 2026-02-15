import React, { useState } from 'react';
import api from '../src/services/api';
import { useToast } from './Toast';

interface AddFriendModalProps {
    isOpen: boolean;
    onClose: () => void;
}

export const AddFriendModal: React.FC<AddFriendModalProps> = ({ isOpen, onClose }) => {
    const [identifier, setIdentifier] = useState('');
    const [isSubmitting, setIsSubmitting] = useState(false);
    const { showToast } = useToast();

    if (!isOpen) return null;

    const handleSubmit = async (e: React.FormEvent) => {
        e.preventDefault();
        const trimmedIdentifier = identifier.trim();
        if (!trimmedIdentifier) return;

        // Validation: Must be Email or UUID
        const isEmail = /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(trimmedIdentifier);
        const isUUID = /^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$/.test(trimmedIdentifier);

        if (!isEmail && !isUUID) {
            showToast('Please enter a valid Email address or User ID', 'error');
            return;
        }

        setIsSubmitting(true);
        try {
            await api.users.sendFriendRequest(trimmedIdentifier);
            showToast('Friend request sent successfully!', 'success');
            setIdentifier('');
            onClose();
        } catch (err: any) {
            console.error('Failed to send friend request:', err);
            showToast(err.message || 'Failed to send request', 'error');
        } finally {
            setIsSubmitting(false);
        }
    };

    return (
        <div className="fixed inset-0 z-[60] flex items-center justify-center bg-black/50 backdrop-blur-sm p-4 animate-in fade-in duration-200" onClick={onClose}>
            <div className="bg-white dark:bg-[#1a1b1e] rounded-2xl w-full max-w-sm shadow-2xl scale-100 animate-in zoom-in-95 duration-200 border border-gray-100 dark:border-gray-800" onClick={e => e.stopPropagation()}>
                <div className="p-6">
                    <h3 className="text-lg font-bold text-gray-900 dark:text-white mb-2">Add Friend</h3>
                    <p className="text-sm text-gray-500 dark:text-gray-400 mb-6">Enter a user's Email or ID to send a friend request.</p>

                    <form onSubmit={handleSubmit}>
                        <div className="mb-4">
                            <input
                                type="text"
                                value={identifier}
                                onChange={(e) => setIdentifier(e.target.value)}
                                placeholder="Email or User ID"
                                className="w-full px-4 py-3 bg-gray-50 dark:bg-white/5 border border-gray-200 dark:border-gray-700 rounded-xl focus:ring-2 focus:ring-primary/50 outline-none transition-all text-text-main dark:text-white"
                                autoFocus
                            />
                        </div>

                        <div className="flex justify-end gap-3">
                            <button
                                type="button"
                                onClick={onClose}
                                className="px-4 py-2 text-sm font-medium text-gray-600 dark:text-gray-300 hover:bg-gray-100 dark:hover:bg-white/5 rounded-lg transition-colors"
                            >
                                Cancel
                            </button>
                            <button
                                type="submit"
                                disabled={!identifier.trim() || isSubmitting}
                                className="px-6 py-2 text-sm font-medium bg-primary hover:brightness-110 text-white rounded-lg shadow-lg shadow-primary/30 transition-all transform active:scale-95 disabled:opacity-50 disabled:cursor-not-allowed flex items-center gap-2"
                            >
                                {isSubmitting && <div className="w-3 h-3 border-2 border-white/30 border-t-white rounded-full animate-spin" />}
                                Send Request
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    );
};
