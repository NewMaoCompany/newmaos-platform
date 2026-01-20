import React, { useState, useRef, useEffect } from 'react';
import { ConfirmModal } from './ConfirmModal';

interface Option {
    label: string;
    value: string;
    icon?: string;
    color?: string;
}

interface CreatableSelectProps {
    label?: string;
    value: string;
    onChange: (value: string) => void;
    onCreate?: (inputValue: string) => Promise<string | null>; // Returns the new ID
    onDeleteOption?: (value: string) => Promise<void>; // New prop for deleting option
    options: Option[];
    placeholder?: string;
    className?: string;
    disabled?: boolean;
    icon?: string;
}

export const CreatableSelect: React.FC<CreatableSelectProps> = ({
    label,
    value,
    onChange,
    onCreate,
    onDeleteOption,
    options,
    placeholder = "Select or Type to Create...",
    className = "",
    disabled = false,
    icon
}) => {
    const [isOpen, setIsOpen] = useState(false);
    const [inputValue, setInputValue] = useState("");
    const [isCreating, setIsCreating] = useState(false);

    // Deletion State
    const [headerToDelete, setHeaderToDelete] = useState<string | null>(null); // Store ID to delete
    const [showDeleteModal, setShowDeleteModal] = useState(false);

    const containerRef = useRef<HTMLDivElement>(null);
    const inputRef = useRef<HTMLInputElement>(null);

    // Sync input with selected value label if not open
    useEffect(() => {
        if (!isOpen) {
            const selectedOption = options.find(opt => opt.value === value);
            setInputValue(selectedOption ? selectedOption.label : "");
        }
    }, [value, options, isOpen]);

    // Close when clicking outside
    useEffect(() => {
        const handleClickOutside = (event: MouseEvent) => {
            if (containerRef.current && !containerRef.current.contains(event.target as Node)) {
                setIsOpen(false);
            }
        };
        document.addEventListener('mousedown', handleClickOutside);
        return () => document.removeEventListener('mousedown', handleClickOutside);
    }, []);

    const handleSelect = (val: string) => {
        if (!disabled) {
            onChange(val);
            setIsOpen(false);
        }
    };

    const handleCreate = async () => {
        if (!inputValue.trim() || disabled || isCreating) return;

        setIsCreating(true);
        try {
            if (onCreate) {
                const newId = await onCreate(inputValue.trim());
                if (newId) {
                    onChange(newId);
                    setIsOpen(false);
                }
            } else {
                // Default behavior: just use the value as ID? 
                // Usually we need an ID. If onCreate is not provided, we assume value=label
                onChange(inputValue.trim());
                setIsOpen(false);
            }
        } catch (e) {
            console.error("Failed to create option", e);
        } finally {
            setIsCreating(false);
        }
    };

    const requestDelete = (e: React.MouseEvent, id: string) => {
        e.stopPropagation();
        if (!onDeleteOption) return;
        setHeaderToDelete(id);
        setShowDeleteModal(true);
    };

    const confirmDelete = async () => {
        if (!headerToDelete || !onDeleteOption) return;

        try {
            await onDeleteOption(headerToDelete);
            if (value === headerToDelete) {
                onChange('');
                setInputValue('');
            }
        } catch (error) {
            console.error(error);
        } finally {
            setShowDeleteModal(false);
            setHeaderToDelete(null);
        }
    };

    const filteredOptions = options.filter(opt =>
        opt.label.toLowerCase().includes(inputValue.toLowerCase())
    );

    const showCreateOption = inputValue.trim() &&
        !options.some(opt => opt.label.toLowerCase() === inputValue.trim().toLowerCase());

    return (
        <div className={`flex flex-col gap-1.5 ${className}`} ref={containerRef}>
            {label && (
                <label className="text-[10px] font-black tracking-widest text-text-secondary dark:text-gray-500 uppercase ml-1">
                    {label}
                </label>
            )}

            <div className="relative">
                <div
                    onClick={() => {
                        if (!disabled && !isOpen) {
                            setIsOpen(true);
                            setInputValue(""); // Clear on open to allow searching
                            setTimeout(() => inputRef.current?.focus(), 0);
                        } else if (!disabled && isOpen) {
                            // Focus input if clicked anywhere in box
                            inputRef.current?.focus();
                        }
                    }}
                    className={`
                        w-full text-left bg-surface-light dark:bg-surface-dark 
                        border border-gray-200 dark:border-gray-800 
                        text-text-main dark:text-white font-bold text-sm 
                        rounded-xl px-4 py-3 flex items-center justify-between
                        transition-all duration-200
                        ${disabled ? 'opacity-50 cursor-not-allowed' : 'cursor-text hover:border-gray-300 dark:hover:border-gray-700'}
                        ${isOpen ? 'ring-2 ring-yellow-400 border-yellow-400' : 'focus-within:ring-2 focus-within:ring-yellow-400 focus-within:border-yellow-400'}
                    `}
                >
                    <div className="flex items-center gap-2 flex-1 overflow-hidden">
                        {icon && <span className="material-symbols-outlined text-lg text-primary">{icon}</span>}

                        <input
                            ref={inputRef}
                            type="text"
                            value={inputValue} // Should control this
                            onChange={(e) => {
                                setInputValue(e.target.value);
                                if (!isOpen) setIsOpen(true);
                            }}
                            onFocus={() => {
                                if (!isOpen) {
                                    setIsOpen(true);
                                    setInputValue("");
                                }
                            }}
                            placeholder={placeholder}
                            disabled={disabled}
                            className={`bg-transparent border-none outline-none !outline-none !ring-0 !border-0 shadow-none w-full text-sm font-bold text-text-main dark:text-white placeholder:font-normal placeholder:text-gray-400`}
                            autoComplete="off"
                        />
                    </div>

                    <span
                        className={`material-symbols-outlined text-lg text-gray-400 transition-transform duration-200 cursor-pointer ${isOpen ? 'rotate-180' : ''}`}
                        onClick={(e) => {
                            e.stopPropagation();
                            if (!disabled) {
                                setIsOpen(!isOpen);
                                if (!isOpen) {
                                    setTimeout(() => inputRef.current?.focus(), 0);
                                }
                            }
                        }}
                    >
                        expand_more
                    </span>
                </div>

                {/* Dropdown Menu */}
                {isOpen && (
                    <div className="absolute top-full left-0 right-0 mt-2 bg-white dark:bg-[#2c2c2e] border border-gray-100 dark:border-gray-700 rounded-xl shadow-xl z-50 max-h-60 overflow-y-auto animate-fade-in-up">
                        <div className="py-1">
                            {filteredOptions.map((option) => (
                                <div
                                    key={option.value}
                                    className={`
                                        w-full px-4 py-2.5 text-sm font-bold flex items-center gap-2 group
                                        transition-colors cursor-pointer
                                        ${value === option.value
                                            ? 'bg-primary/10 text-primary'
                                            : 'text-text-main dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-white/5'}
                                    `}
                                    onClick={() => handleSelect(option.value)}
                                >
                                    {option.icon && (
                                        <span className={`material-symbols-outlined text-lg ${option.color || (value === option.value ? 'text-primary' : 'text-gray-400')}`}>
                                            {option.icon}
                                        </span>
                                    )}
                                    <span className={`flex-1 ${option.color}`}>{option.label}</span>

                                    {/* Action Buttons */}
                                    <div className="flex items-center gap-1">
                                        {value === option.value && (
                                            <span className="material-symbols-outlined text-base text-primary mr-2">check</span>
                                        )}
                                        {onDeleteOption && (
                                            <button
                                                onClick={(e) => requestDelete(e, option.value)}
                                                className="p-1 rounded-full text-gray-400 hover:text-red-500 hover:bg-red-50 transition-colors opacity-0 group-hover:opacity-100"
                                                title="Delete this tag"
                                            >
                                                <span className="material-symbols-outlined text-sm">delete</span>
                                            </button>
                                        )}
                                    </div>
                                </div>
                            ))}

                            {filteredOptions.length === 0 && !showCreateOption && (
                                <div className="px-4 py-3 text-sm text-gray-400 italic text-center">
                                    No options found
                                </div>
                            )}

                            {showCreateOption && (
                                <button
                                    type="button"
                                    onClick={handleCreate}
                                    disabled={isCreating}
                                    className="w-full text-left px-4 py-2.5 text-sm font-bold text-primary hover:bg-primary/5 flex items-center gap-2 border-t border-gray-100 dark:border-gray-700"
                                >
                                    <span className="material-symbols-outlined text-lg">add_circle</span>
                                    {isCreating ? 'Creating...' : `Create "${inputValue}"`}
                                </button>
                            )}
                        </div>
                    </div>
                )}
            </div>

            {/* Custom Confirm Modal */}
            <ConfirmModal
                isOpen={showDeleteModal}
                title="Delete Tag"
                message="Are you sure you want to permanently delete this tag? This action cannot be undone."
                onConfirm={confirmDelete}
                onCancel={() => setShowDeleteModal(false)}
                confirmText="Delete"
                isDestructive
            />
        </div>
    );
};
