import React, { useState, useRef, useEffect } from 'react';
import { ConfirmModal } from './ConfirmModal';

interface Option {
    label: string;
    value: string;
    icon?: string;
}

interface CreatableMultiSelectProps {
    label?: string;
    value: string[];
    onChange: (value: string[]) => void;
    onCreate?: (inputValue: string) => Promise<string | null>;
    onDeleteOption?: (value: string) => Promise<void>; // New prop
    options: Option[];
    placeholder?: string;
    className?: string;
    disabled?: boolean;
    icon?: string;
}

export const CreatableMultiSelect: React.FC<CreatableMultiSelectProps> = ({
    label,
    value = [], // Default to empty array
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

    const handleToggle = (optValue: string) => {
        if (disabled) return;
        const newValue = value.includes(optValue)
            ? value.filter(v => v !== optValue)
            : [...value, optValue];
        onChange(newValue);
        setInputValue("");
        inputRef.current?.focus();
    };

    const handleRemove = (e: React.MouseEvent, optValue: string) => {
        e.stopPropagation();
        if (disabled) return;
        onChange(value.filter(v => v !== optValue));
    };

    const handleCreate = async () => {
        if (!inputValue.trim() || disabled || isCreating) return;

        setIsCreating(true);
        try {
            if (onCreate) {
                const newId = await onCreate(inputValue.trim());
                if (newId) {
                    onChange([...value, newId]);
                    setInputValue("");
                    setIsOpen(true); // Keep open
                    inputRef.current?.focus();
                }
            } else {
                onChange([...value, inputValue.trim()]);
                setInputValue("");
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
            if (value.includes(headerToDelete)) {
                onChange(value.filter(v => v !== headerToDelete));
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
        !options.some(opt => opt.label.toLowerCase() === inputValue.trim().toLowerCase()) &&
        !value.includes(inputValue.trim());

    const selectedOptions = options.filter(opt => value.includes(opt.value));
    const extraValues = value.filter(v => !options.some(opt => opt.value === v));
    const allSelectedDisplay = [
        ...selectedOptions,
        ...extraValues.map(v => ({ label: v, value: v }))
    ];

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
                        if (!disabled) {
                            setIsOpen(true);
                            inputRef.current?.focus();
                        }
                    }}
                    className={`
                        w-full text-left bg-surface-light dark:bg-surface-dark 
                        border border-gray-200 dark:border-gray-800 
                        text-text-main dark:text-white font-bold text-sm 
                        rounded-xl px-4 py-3 flex items-center justify-between
                        transition-all duration-200 min-h-[50px]
                        ${disabled ? 'opacity-50 cursor-not-allowed' : 'cursor-text hover:border-gray-300 dark:hover:border-gray-700'}
                        ${isOpen ? 'ring-2 ring-yellow-400 border-yellow-400' : 'focus-within:ring-2 focus-within:ring-yellow-400 focus-within:border-yellow-400'}
                    `}
                >
                    <div className="flex items-center gap-2 flex-wrap flex-1">
                        {icon && <span className="material-symbols-outlined text-lg text-primary mr-1">{icon}</span>}

                        {allSelectedDisplay.map(opt => (
                            <span
                                key={opt.value}
                                className="inline-flex items-center gap-1 bg-primary/10 text-primary-dark dark:text-primary text-[10px] uppercase font-black px-2 py-1 rounded-md border border-primary/20"
                            >
                                {opt.label}
                                <span
                                    className="material-symbols-outlined text-[12px] cursor-pointer hover:text-red-500"
                                    onClick={(e) => handleRemove(e, opt.value)}
                                >
                                    close
                                </span>
                            </span>
                        ))}

                        <input
                            ref={inputRef}
                            type="text"
                            value={inputValue}
                            onChange={(e) => {
                                setInputValue(e.target.value);
                                setIsOpen(true);
                            }}
                            onKeyDown={(e) => {
                                if (e.key === 'Enter' && inputValue) {
                                    e.preventDefault();
                                    const match = filteredOptions.find(o => o.label.toLowerCase() === inputValue.toLowerCase());
                                    if (match) {
                                        handleToggle(match.value);
                                    } else {
                                        handleCreate();
                                    }
                                } else if (e.key === 'Backspace' && !inputValue && value.length > 0) {
                                    // Remove last tag
                                    const last = value[value.length - 1];
                                    onChange(value.slice(0, -1));
                                }
                            }}
                            placeholder={allSelectedDisplay.length === 0 ? placeholder : ""}
                            disabled={disabled}
                            className="bg-transparent border-none outline-none !outline-none !ring-0 !border-0 shadow-none text-sm font-bold text-text-main dark:text-white placeholder:font-normal placeholder:text-gray-400 min-w-[100px] flex-1"
                            autoComplete="off"
                        />
                    </div>

                    <span
                        className={`material-symbols-outlined text-lg text-gray-400 transition-transform duration-200 cursor-pointer ${isOpen ? 'rotate-180' : ''}`}
                        onClick={(e) => {
                            e.stopPropagation();
                            if (!disabled) setIsOpen(!isOpen);
                        }}
                    >
                        expand_more
                    </span>
                </div>

                {/* Dropdown Menu */}
                {isOpen && (
                    <div className="absolute top-full left-0 right-0 mt-2 bg-white dark:bg-[#2c2c2e] border border-gray-100 dark:border-gray-700 rounded-xl shadow-xl z-50 max-h-60 overflow-y-auto animate-fade-in-up">
                        <div className="py-1">
                            {filteredOptions.length > 0 ? (
                                filteredOptions.map((option) => {
                                    const isSelected = value.includes(option.value);
                                    return (
                                        <div
                                            key={option.value}
                                            className={`
                                                w-full px-4 py-2.5 text-sm font-medium flex items-center gap-3 group
                                                transition-colors cursor-pointer
                                                ${isSelected ? 'text-text-main dark:text-white bg-primary/10' : 'text-gray-600 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-white/5'}
                                            `}
                                            onClick={() => handleToggle(option.value)}
                                        >
                                            <div className={`
                                                w-5 h-5 rounded border flex items-center justify-center transition-colors
                                                ${isSelected ? 'bg-primary border-primary text-black' : 'border-gray-300 dark:border-gray-600 bg-transparent'}
                                            `}>
                                                {isSelected && <span className="material-symbols-outlined text-sm font-bold">check</span>}
                                            </div>

                                            <span className="flex-1">{option.label}</span>

                                            {/* Delete Button */}
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
                                    );
                                })
                            ) : (
                                !showCreateOption && (
                                    <div className="px-4 py-3 text-sm text-gray-400 italic text-center">
                                        No matching options
                                    </div>
                                )
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
