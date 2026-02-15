import React, { useState, useRef, useEffect } from 'react';

interface Option {
    label: string;
    value: string;
    icon?: string;
}

interface CustomMultiSelectProps {
    label?: string;
    value: string[];
    onChange: (value: string[]) => void;
    options: Option[];
    placeholder?: string;
    className?: string;
    disabled?: boolean;
    icon?: string;
}

export const CustomMultiSelect: React.FC<CustomMultiSelectProps> = ({
    label,
    value = [], // Default to empty array
    onChange,
    options,
    placeholder = "Select options...",
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

    const handleToggle = (optValue: string) => {
        if (disabled) return;
        const newValue = value.includes(optValue)
            ? value.filter(v => v !== optValue)
            : [...value, optValue];
        onChange(newValue);
    };

    const handleRemove = (e: React.MouseEvent, optValue: string) => {
        e.stopPropagation();
        if (disabled) return;
        onChange(value.filter(v => v !== optValue));
    };

    const selectedOptions = options.filter(opt => value.includes(opt.value));

    return (
        <div className={`flex flex-col gap-1.5 ${className}`} ref={containerRef}>
            {label && (
                <label className="text-[10px] font-black tracking-widest text-gray-500 uppercase ml-1">
                    {label}
                </label>
            )}

            <div className="relative">
                <button
                    type="button"
                    onClick={() => !disabled && setIsOpen(!isOpen)}
                    className={`
                        w-full text-left bg-white border border-gray-200 
                        text-gray-900 font-bold text-sm 
                        rounded-xl px-4 py-3 flex items-center justify-between
                        transition-all duration-200 min-h-[50px]
                        ${disabled ? 'opacity-50 cursor-not-allowed' : 'cursor-pointer hover:border-gray-300'}
                        ${isOpen ? 'ring-2 ring-yellow-400 border-yellow-400' : 'focus:ring-2 focus:ring-yellow-400 focus:border-yellow-400'}
                    `}
                >
                    <div className="flex items-center gap-2 flex-wrap">
                        {icon && <span className="material-symbols-outlined text-lg text-yellow-500 mr-1">{icon}</span>}

                        {selectedOptions.length > 0 ? (
                            selectedOptions.map(opt => (
                                <span
                                    key={opt.value}
                                    className="inline-flex items-center gap-1 bg-yellow-50 text-yellow-800 text-[10px] uppercase font-black px-2 py-0.5 rounded-md border border-yellow-200"
                                >
                                    {opt.label}
                                    <span
                                        className="material-symbols-outlined text-[10px] cursor-pointer hover:text-red-500"
                                        onClick={(e) => handleRemove(e, opt.value)}
                                    >
                                        close
                                    </span>
                                </span>
                            ))
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
                    <div className="absolute top-full left-0 right-0 mt-2 bg-white border border-gray-100 rounded-xl shadow-xl z-50 max-h-60 overflow-y-auto w-full animate-fade-in-up scroll-bounce">
                        <div className="py-1">
                            {options.map((option) => {
                                const isSelected = value.includes(option.value);
                                return (
                                    <button
                                        key={option.value}
                                        type="button"
                                        onClick={() => handleToggle(option.value)}
                                        className={`
                                            w-full text-left px-4 py-2.5 text-sm font-medium flex items-center gap-3
                                            transition-colors hover:bg-gray-50
                                            ${isSelected ? 'text-gray-900 bg-yellow-50/50' : 'text-gray-600'}
                                        `}
                                    >
                                        <div className={`
                                            w-5 h-5 rounded border flex items-center justify-center transition-colors
                                            ${isSelected ? 'bg-yellow-400 border-yellow-400 text-black' : 'border-gray-300 bg-white'}
                                        `}>
                                            {isSelected && <span className="material-symbols-outlined text-sm font-bold">check</span>}
                                        </div>

                                        <span>{option.label}</span>
                                    </button>
                                );
                            })}
                        </div>
                    </div>
                )}
            </div>
        </div>
    );
};
