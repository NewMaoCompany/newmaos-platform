import React, { useState, useRef, useEffect } from 'react';

interface Option {
    label: string;
    value: string | number;
    icon?: string; // Material symbol name
    color?: string; // e.g., 'text-red-500'
}

interface CustomSelectProps {
    label?: string;
    value: string | number;
    onChange: (value: any) => void;
    options: Option[];
    placeholder?: string;
    className?: string;
    disabled?: boolean;
    icon?: string; // Icon for the select field itself
}

export const CustomSelect: React.FC<CustomSelectProps> = ({
    label,
    value,
    onChange,
    options,
    placeholder = "Select...",
    className = "",
    disabled = false,
    icon
}) => {
    const [isOpen, setIsOpen] = useState(false);
    const containerRef = useRef<HTMLDivElement>(null);

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

    const selectedOption = options.find(opt => opt.value === value);

    const handleSelect = (val: string | number) => {
        if (!disabled) {
            onChange(val);
            setIsOpen(false);
        }
    };

    return (
        <div className={`flex flex-col gap-1.5 ${className}`} ref={containerRef}>
            {label && (
                <label className="text-[10px] font-black tracking-widest text-text-secondary dark:text-gray-500 uppercase ml-1">
                    {label}
                </label>
            )}

            <div className="relative">
                <button
                    type="button"
                    onClick={() => !disabled && setIsOpen(!isOpen)}
                    className={`
                        w-full text-left bg-surface-light dark:bg-surface-dark 
                        border border-gray-200 dark:border-gray-800 
                        text-text-main dark:text-white font-bold text-sm 
                        rounded-xl px-4 py-3 flex items-center justify-between
                        transition-all duration-200
                        ${disabled ? 'opacity-50 cursor-not-allowed' : 'cursor-pointer hover:border-gray-300 dark:hover:border-gray-700'}
                        ${isOpen ? 'ring-2 ring-yellow-400 border-yellow-400' : 'focus:ring-2 focus:ring-yellow-400 focus:border-yellow-400'}
                    `}
                >
                    <div className="flex items-center gap-2 truncate">
                        {icon && <span className="material-symbols-outlined text-lg text-primary">{icon}</span>}

                        {selectedOption ? (
                            <span className="flex items-center gap-2">
                                {selectedOption.icon && (
                                    <span className={`material-symbols-outlined text-lg ${selectedOption.color || 'text-gray-400'}`}>
                                        {selectedOption.icon}
                                    </span>
                                )}
                                <span className={selectedOption.color || ''}>
                                    {selectedOption.label}
                                </span>
                            </span>
                        ) : (
                            <span className="text-gray-400 font-normal">{placeholder}</span>
                        )}
                    </div>

                    <span
                        className={`material-symbols-outlined text-lg text-gray-400 transition-transform duration-200 ${isOpen ? 'rotate-180' : ''}`}
                    >
                        expand_more
                    </span>
                </button>

                {/* Dropdown Menu */}
                {isOpen && (
                    <div className="absolute top-full left-0 right-0 mt-2 bg-white dark:bg-[#2c2c2e] border border-gray-100 dark:border-gray-700 rounded-xl shadow-xl z-50 max-h-60 overflow-y-auto scroll-bounce animate-fade-in-up">
                        <div className="py-1">
                            {options.map((option) => (
                                <button
                                    key={option.value}
                                    type="button"
                                    onClick={() => handleSelect(option.value)}
                                    className={`
                                        w-full text-left px-4 py-2.5 text-sm font-bold flex items-center gap-2
                                        transition-colors
                                        ${value === option.value
                                            ? 'bg-primary/10 text-primary'
                                            : 'text-text-main dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-white/5'}
                                    `}
                                >
                                    {option.icon && (
                                        <span className={`material-symbols-outlined text-lg ${option.color || (value === option.value ? 'text-primary' : 'text-gray-400')}`}>
                                            {option.icon}
                                        </span>
                                    )}
                                    <span className={option.color}>{option.label}</span>

                                    {value === option.value && (
                                        <span className="material-symbols-outlined text-base ml-auto text-primary">check</span>
                                    )}
                                </button>
                            ))}
                        </div>
                    </div>
                )}
            </div>
        </div>
    );
};
