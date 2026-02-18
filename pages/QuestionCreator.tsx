import React, { useState, useMemo, useEffect, useRef } from 'react';
import { useApp } from '../AppContext';
import { useToast } from '../components/Toast';
import { questionsApi, sectionsApi } from '../src/services/api';
import { supabase } from '../src/services/supabaseClient';
import { MathRenderer } from '../components/MathRenderer';
import { Navbar } from '../components/Navbar';
import { CustomSelect } from '../components/CustomSelect';
import { CustomMultiSelect } from '../components/CustomMultiSelect';
import { CreatableSelect } from '../components/CreatableSelect';
import { CreatableMultiSelect } from '../components/CreatableMultiSelect';
import { Question, CourseType, QuestionCourseType } from '../types';
import { COURSE_TOPICS, SKILL_TAGS, ERROR_TAGS, COURSE_CONTENT_DATA } from '../constants';

// --- Types ---

interface FormOptionState {
    id?: string;
    label: string;
    value: string;
    errorTagId?: string;
    type: 'text' | 'image';
    explanation: string;
    explanationType: 'text' | 'image';
}

interface FormState extends Omit<Question, 'id' | 'options' | 'correctOptionId' | 'course'> {
    id?: string;
    course: QuestionCourseType;
    options: FormOptionState[];
    correctOptionLabel: string;
    topicId: string;
    primarySkillId: string;
    supportingSkillIds: string[];
    promptType: 'text' | 'image';
    promptImage?: string | null;

    // Metadata
    source: string;
    sourceYear?: number;
    notes?: string;
    status: 'draft' | 'published';
    weightPrimary: number;
    weightSupporting: number;
    errorPatternIds: string[];
    explanationType: 'text' | 'image';
}

// --- Components ---

const InputTypeToggle = ({ type, onChange }: { type: 'text' | 'image', onChange: (t: 'text' | 'image') => void }) => (
    <div className="flex bg-gray-100 dark:bg-white/5 p-1 rounded-lg shrink-0 scale-75 origin-right">
        <button
            type="button"
            onClick={() => onChange('text')}
            className={`px-3 py-1.5 text-xs font-bold rounded-md transition-all flex items-center gap-1 ${type === 'text' ? 'bg-white dark:bg-gray-700 shadow-sm text-black dark:text-white' : 'text-gray-500'}`}
        >
            <span className="material-symbols-outlined text-[14px]">text_fields</span>
            Text
        </button>
        <button
            type="button"
            onClick={() => onChange('image')}
            className={`px-3 py-1.5 text-xs font-bold rounded-md transition-all flex items-center gap-1 ${type === 'image' ? 'bg-white dark:bg-gray-700 shadow-sm text-black dark:text-white' : 'text-gray-500'}`}
        >
            <span className="material-symbols-outlined text-[14px]">image</span>
            Image
        </button>
    </div>
);

const ToastNotification = ({ message, type = 'success', onClose }: { message: string | null; type?: 'success' | 'error'; onClose: () => void }) => {
    useEffect(() => {
        if (message) {
            const timer = setTimeout(onClose, 4000);
            return () => clearTimeout(timer);
        }
    }, [message, onClose]);

    if (!message) return null;

    const isError = type === 'error';
    const colorClasses = isError
        ? { border: 'border-red-100', bar: 'bg-red-500', bg: 'bg-red-50', text: 'text-red-600', icon: 'error' }
        : { border: 'border-green-100', bar: 'bg-green-500', bg: 'bg-green-50', text: 'text-green-600', icon: 'check_circle' };

    return (
        <div className="fixed top-24 right-10 z-[200] animate-fade-in-up">
            <div className={`bg-white/95 backdrop-blur-md shadow-2xl rounded-2xl p-4 pr-12 border ${colorClasses.border} flex items-center gap-3 min-w-[300px] max-w-[400px] relative overflow-hidden`}>
                <div className={`absolute left-0 top-0 bottom-0 w-1.5 ${colorClasses.bar}`} />
                <div className={`p-2 ${colorClasses.bg} rounded-full ${colorClasses.text}`}>
                    <span className="material-symbols-outlined">{colorClasses.icon}</span>
                </div>
                <div className="flex-1">
                    <h4 className="text-sm font-bold text-gray-900">{isError ? 'Error' : 'Success'}</h4>
                    <p className="text-xs text-gray-500">{message}</p>
                </div>
                <button
                    onClick={onClose}
                    className="absolute top-2 right-2 p-1 text-gray-400 hover:text-gray-600 rounded-full hover:bg-gray-100 transition-colors"
                >
                    <span className="material-symbols-outlined text-sm">close</span>
                </button>
            </div>
        </div>
    );
};

// ... (skipping ImageUploader/Component updates, jumping to Logic in QuestionCreator)


// --- Math Toolbar & Validation ---

const validateMathContent = (content: string): string[] => {
    if (!content) return [];
    const errors: string[] = [];

    // Regex to find LaTeX-like commands NOT inside $...$ or $$...$$
    // This is a heuristic. logic: match backslash word, check if likely math.
    // Simplifying: check for specific common problematic commands that are definitely math
    // e.g. \frac, \int, \sum, \sqrt, \sin, \cos
    // If they appear in a context that doesn't look like math mode.
    // Hard to do perfectly with regex, but we can catch obvious cases.

    // Strategy: Split by $ delimiters. Even indices are "text mode", Odd are "math mode".
    // (Assuming balanced $).
    const segments = content.split('$');
    let unbalanced = false;
    if ((content.match(/\$/g) || []).length % 2 !== 0) {
        unbalanced = true;
        errors.push("Found unbalanced '$' delimiters. Please check your math formatting.");
    }

    segments.forEach((seg, idx) => {
        // Even index = Text Mode (unless we have unbalanced $)
        if (idx % 2 === 0 && !unbalanced) {
            // Check for math keywords in text mode
            const suspicious = seg.match(/\\(frac|int|sum|sqrt|lim|theta|pi|infty)/g);
            if (suspicious) {
                errors.push(`Found math command(s) "${suspicious.join(', ')}" outside of '$' delimiters. Wrap them like $...$`);
            }
        }
    });

    return errors;
};

// Enhanced MathToolbar with Image Support
const MathToolbar = ({
    onInsert,
    onImageUpload,
    textareaRef
}: {
    onInsert: (text: string, cursorOffset?: number) => void;
    onImageUpload?: (file: File) => void;
    textareaRef?: React.RefObject<HTMLTextAreaElement>;
}) => {
    const fileInputRef = useRef<HTMLInputElement>(null);

    const handleInsert = (text: string, cursorBack: number = 0) => {
        // If ref provided, we could do smart insertion (not implemented fully here due to controlled state)
        // For now, we rely on the parent handler or simpler append/insert logic if passed
        onInsert(text, cursorBack);
    };

    const handleFileChange = (e: React.ChangeEvent<HTMLInputElement>) => {
        if (e.target.files && e.target.files[0] && onImageUpload) {
            onImageUpload(e.target.files[0]);
        }
        if (e.target.value) e.target.value = '';
    };

    return (
        <div className="flex flex-wrap items-center gap-1 p-2 bg-gray-50 border-b border-gray-100 rounded-t-xl">
            <span className="text-[10px] font-bold text-gray-400 uppercase tracking-wider mr-2">Math Tools:</span>

            <button
                type="button"
                onClick={() => handleInsert('$$', 1)}
                className="px-2 py-1 bg-white border border-gray-200 rounded text-xs font-mono font-bold hover:bg-yellow-50 hover:border-yellow-300 transition-colors"
                title="Inline Math"
            >
                $x$
            </button>
            <button
                type="button"
                onClick={() => handleInsert('$$$$', 2)}
                className="px-2 py-1 bg-white border border-gray-200 rounded text-xs font-mono font-bold hover:bg-yellow-50 hover:border-yellow-300 transition-colors"
                title="Block Math"
            >
                $$x$$
            </button>
            <div className="w-px h-4 bg-gray-300 mx-1"></div>
            <button
                type="button"
                onClick={() => handleInsert('\\frac{}{}', 3)}
                className="px-2 py-1 bg-white border border-gray-200 rounded text-xs font-math hover:bg-yellow-50 hover:border-yellow-300 transition-colors"
            >
                \frac
            </button>
            <button
                type="button"
                onClick={() => handleInsert('\\sqrt{}', 1)}
                className="px-2 py-1 bg-white border border-gray-200 rounded text-xs font-math hover:bg-yellow-50 hover:border-yellow-300 transition-colors"
            >
                \sqrt
            </button>
            <button
                type="button"
                onClick={() => handleInsert('\\int ', 0)}
                className="px-2 py-1 bg-white border border-gray-200 rounded text-xs font-math hover:bg-yellow-50 hover:border-yellow-300 transition-colors"
            >
                \int
            </button>
            <button
                type="button"
                onClick={() => handleInsert('\\sum ', 0)}
                className="px-2 py-1 bg-white border border-gray-200 rounded text-xs font-math hover:bg-yellow-50 hover:border-yellow-300 transition-colors"
            >
                \sum
            </button>
            <button
                type="button"
                onClick={() => handleInsert('\\lim_{x \\to 0} ', 0)}
                className="px-2 py-1 bg-white border border-gray-200 rounded text-xs font-math hover:bg-yellow-50 hover:border-yellow-300 transition-colors"
            >
                \lim
            </button>
            <div className="w-px h-4 bg-gray-300 mx-1"></div>
            <button
                type="button"
                onClick={() => fileInputRef.current?.click()}
                className="px-2 py-1 bg-white border border-gray-200 rounded text-xs font-bold hover:bg-yellow-50 hover:border-yellow-300 transition-colors flex items-center gap-1"
                title="Insert Image"
            >
                <span className="material-symbols-outlined text-[14px]">image</span>
            </button>
            <input
                ref={fileInputRef}
                type="file"
                className="hidden"
                accept="image/*"
                onChange={handleFileChange}
            />
            <div className="flex-1"></div>
            <a
                href="https://katex.org/docs/supported.html"
                target="_blank"
                rel="noreferrer"
                className="text-[10px] text-blue-500 hover:underline flex items-center gap-1"
            >
                <span className="material-symbols-outlined text-[10px]">help</span>
                Reference
            </a>
        </div>
    );
};

const ImageUploader = ({
    value,
    onChange,
    placeholder = "Click or Drag to Upload Image",
    className = "",
    heightClass = "h-48"
}: {
    value: string;
    onChange: (val: string) => void;
    placeholder?: string;
    className?: string;
    heightClass?: string;
}) => {
    const [isUploading, setIsUploading] = useState(false);
    const [isDragging, setIsDragging] = useState(false);
    const { showToast } = useToast();

    // Parse value into array of URLs — only include valid image URLs
    const isValidImageUrl = (s: string) => {
        const t = s.trim();
        return t.startsWith('http') || t.startsWith('data:image') || t.startsWith('blob:');
    };
    const images: string[] = React.useMemo(() => {
        if (!value) return [];
        try {
            const parsed = JSON.parse(value);
            if (Array.isArray(parsed)) return parsed.filter(isValidImageUrl);
            if (isValidImageUrl(value)) return [value];
            return [];
        } catch {
            if (isValidImageUrl(value)) return [value];
            return [];
        }
    }, [value]);

    const uploadImages = async (files: File[]) => {
        setIsUploading(true);
        try {
            // Use client-side upload to match MathToolbar logic
            // This avoids backend proxy complexity and manual token parsing issues
            const uploadedUrls: string[] = [];

            for (const file of files) {
                // Generate unique path
                const fileExt = file.name.split('.').pop() || 'png';
                const fileName = `${Date.now()}_${Math.random().toString(36).substring(7)}.${fileExt}`;
                const filePath = `mixed_content/${fileName}`; // Use same folder as MathToolbar

                // Upload to Supabase Storage
                const { error: uploadError } = await supabase.storage
                    .from('images')
                    .upload(filePath, file);

                if (uploadError) {
                    console.error(`Failed to upload ${file.name}`, uploadError);
                    showToast(`Failed to upload ${file.name}: ${uploadError.message}`, 'error');
                    continue;
                }

                // Get Public URL
                const { data } = supabase.storage
                    .from('images')
                    .getPublicUrl(filePath);

                if (data.publicUrl) {
                    uploadedUrls.push(data.publicUrl);
                }
            }

            if (uploadedUrls.length > 0) {
                const newImages = [...images, ...uploadedUrls];
                // Store as JSON if multiple
                if (newImages.length === 1) {
                    onChange(newImages[0]);
                } else {
                    onChange(JSON.stringify(newImages));
                }
                showToast('Image uploaded successfully!', 'success');
            }

        } catch (e: any) {
            console.error('Image upload failed:', e);
            showToast(`Image upload failed: ${e.message}`, 'error');
        } finally {
            setIsUploading(false);
        }
    };

    const processFiles = (files: FileList | File[]) => {
        const imageFiles = Array.from(files).filter(f => f.type.startsWith('image/'));
        if (imageFiles.length === 0) return;
        uploadImages(imageFiles);
    };

    const handleFile = (e: React.ChangeEvent<HTMLInputElement>) => {
        e.preventDefault();
        e.stopPropagation();
        if (e.target.files && e.target.files.length > 0) {
            processFiles(e.target.files);
            e.target.value = '';
        }
    };

    // Drag and Drop Handlers
    const handleDragOver = (e: React.DragEvent) => {
        e.preventDefault();
        e.stopPropagation();
        setIsDragging(true);
    };

    const handleDragLeave = (e: React.DragEvent) => {
        e.preventDefault();
        e.stopPropagation();
        setIsDragging(false);
    };

    const handleDrop = (e: React.DragEvent) => {
        e.preventDefault();
        e.stopPropagation();
        setIsDragging(false);

        if (e.dataTransfer.files && e.dataTransfer.files.length > 0) {
            processFiles(e.dataTransfer.files);
        }
    };

    const removeImage = (index: number) => {
        const newImages = [...images];
        newImages.splice(index, 1);
        if (newImages.length === 0) {
            onChange('');
        } else if (newImages.length === 1) {
            onChange(newImages[0]);
        } else {
            onChange(JSON.stringify(newImages));
        }
    };

    const fileInputRef = React.useRef<HTMLInputElement>(null);

    const handleClick = (e: React.MouseEvent) => {
        e.preventDefault();
        e.stopPropagation();
        fileInputRef.current?.click();
    };

    return (
        <div className={`flex flex-col gap-2 ${className}`}>
            {/* Image Grid */}
            {images.length > 0 && (
                <div className={`grid grid-cols-2 sm:grid-cols-3 gap-2 mb-2`}>
                    {images.map((url, idx) => (
                        <div key={idx} className="relative group aspect-square rounded-xl overflow-hidden border border-gray-200 bg-gray-50">
                            <img src={url} alt={`Uploaded ${idx}`} className="w-full h-full object-cover" />
                            <button
                                onClick={(e) => { e.stopPropagation(); removeImage(idx); }}
                                className="absolute top-1 right-1 bg-red-500 text-white p-1 rounded-full opacity-0 group-hover:opacity-100 transition-opacity"
                            >
                                <span className="material-symbols-outlined text-[10px]">close</span>
                            </button>
                        </div>
                    ))}
                </div>
            )}

            {/* Drop Zone */}
            <div
                onClick={handleClick}
                onDragOver={handleDragOver}
                onDragLeave={handleDragLeave}
                onDrop={handleDrop}
                className={`flex flex-col items-center justify-center border-2 border-dashed rounded-xl cursor-pointer transition-all duration-200 text-gray-400 ${isDragging
                    ? 'border-yellow-400 bg-yellow-50 scale-[1.02] shadow-sm'
                    : 'border-gray-200 hover:bg-gray-50'
                    } ${heightClass}`}
            >
                {isUploading ? (
                    <span className="material-symbols-outlined animate-spin text-yellow-500">progress_activity</span>
                ) : (
                    <span className={`material-symbols-outlined text-2xl transition-colors ${isDragging ? 'text-yellow-500' : ''}`}>
                        {isDragging ? 'upload_file' : 'add_photo_alternate'}
                    </span>
                )}
                <span className={`text-xs font-bold uppercase mt-2 transition-colors ${isDragging ? 'text-yellow-600' : ''}`}>
                    {isDragging ? 'Drop Images Here' : (images.length > 0 ? "Add More Images" : placeholder)}
                </span>
            </div>
            <input
                ref={fileInputRef}
                type="file"
                className="hidden"
                accept="image/*"
                multiple
                onChange={handleFile}
            />
        </div>
    );
};

// --- Constants ---

const STATUS_OPTIONS = [
    { label: 'Draft', value: 'draft', color: 'text-gray-500', icon: 'edit_note' },
    { label: 'Published', value: 'published', color: 'text-green-600', icon: 'public' }
];

const COURSE_OPTIONS = [
    { label: 'Both (AB & BC)', value: 'Both' },
    { label: 'AB Only', value: 'AB' },
    { label: 'BC Only', value: 'BC' }
];

const TYPE_OPTIONS = [
    { label: 'Multiple Choice (MCQ)', value: 'MCQ' },
    { label: 'Free Response (FRQ)', value: 'FRQ' }
];

const DIFFICULTY_OPTIONS = [
    { label: 'Level 1 (Easy)', value: 1, color: 'text-green-600' },
    { label: 'Level 2 (Medium)', value: 2, color: 'text-blue-600' },
    { label: 'Level 3 (Hard)', value: 3, color: 'text-yellow-600' },
    { label: 'Level 4 (Expert)', value: 4, color: 'text-orange-600' },
    { label: 'Level 5 (Master)', value: 5, color: 'text-red-600' }
];

const CALCULATOR_OPTIONS = [
    { label: 'Not Allowed', value: 0, icon: 'do_not_disturb' }, // logical false
    { label: 'Allowed', value: 1, icon: 'calculate' }           // logical true
];

// --- Left Sidebar ---

const NavigationSidebar = ({
    activeCourse,
    setActiveCourse,
    topicContent,
    selectedTopicId,
    selectedSubTopicId,
    onSelect
}: {
    // ... existing NavigationSidebar code ...
    // (I will assume I don't need to replace NavigationSidebar if I start replacing from QuestionCreator)
    // Wait, replace_file_content replaces a chunk. I need to be careful with line numbers.
    // I'll insert constants at the top first, then replacing the Grid.

    // Actually, I should insert constants after imports.
    // And then replace the grid.

    // Let's do constants first.
    activeCourse: CourseType;
    setActiveCourse: (c: CourseType) => void;
    topicContent: Record<string, any>;
    selectedTopicId: string;
    selectedSubTopicId: string;
    onSelect: (topicId: string, subTopicId: string | null, sectionTitle: string) => void;
}) => {
    // ...

    const units = COURSE_TOPICS[activeCourse];
    const [expandedUnits, setExpandedUnits] = useState<Record<string, boolean>>({});

    // Auto-expand the unit that contains the selected subtopic
    useEffect(() => {
        if (selectedTopicId) {
            setExpandedUnits(prev => ({ ...prev, [selectedTopicId]: true }));
        }
    }, [selectedTopicId]);

    const toggleUnit = (unitId: string) => {
        setExpandedUnits(prev => {
            const isCurrentlyExpanded = prev[unitId];
            // If currently expanded, toggle off. If not, set ONLY this unit to true (closing others)
            return isCurrentlyExpanded ? {} : { [unitId]: true };
        });
    };

    return (
        <div className="w-80 border-r border-gray-200 h-full bg-white flex flex-col flex-shrink-0">
            {/* Header: Select Course */}
            <div className="p-4 border-b border-gray-100">
                <p className="text-[10px] font-bold text-gray-400 uppercase tracking-wider mb-2">Select Course</p>
                <div className="flex bg-gray-100 p-1 rounded-lg">
                    {(['AB', 'BC'] as CourseType[]).map(course => (
                        <button
                            key={course}
                            onClick={() => setActiveCourse(course)}
                            className={`flex-1 py-1.5 text-xs font-bold rounded-md transition-all ${activeCourse === course
                                ? 'bg-white text-black shadow-sm'
                                : 'text-gray-500 hover:text-black'
                                }`}
                        >
                            AP Calculus {course}
                        </button>
                    ))}
                </div>
            </div>

            {/* Units List */}
            <div className="flex-1 overflow-y-auto custom-scrollbar p-2 pb-20 space-y-2 scroll-bounce">
                <div className="scroll-bounce-inner min-h-[101%]">
                    {units.map((unit) => {
                        // Use static data PRIORITY to ensure chapters always load (Context might have empty dynamic lists)
                        const content = topicContent[unit.id];
                        const staticData = COURSE_CONTENT_DATA[unit.id];
                        const isExpanded = expandedUnits[unit.id];
                        // Force static subtopics to guarantee structure
                        const subs = staticData?.subTopics || content?.subTopics || [];

                        return (
                            <div key={unit.id} className="select-none">
                                <button
                                    onClick={() => {
                                        toggleUnit(unit.id);
                                        // If clicking the currently selected unit (with no subtopic selected), deselect it (Toggle off)
                                        if (selectedTopicId === unit.id && !selectedSubTopicId) {
                                            onSelect('', null, '');
                                        } else {
                                            // Otherwise select it
                                            onSelect(unit.id, null as any, content?.title || unit.subject);
                                        }
                                    }}
                                    className={`w-full text-left px-3 py-3 rounded-lg flex items-center gap-2 group transition-colors ${isExpanded ? 'bg-yellow-50' : 'hover:bg-gray-50'}`}
                                >
                                    <span className={`material-symbols-outlined text-[18px] ${isExpanded ? 'text-yellow-600' : 'text-gray-400'}`}>folder</span>
                                    <span className="text-xs font-bold text-gray-800 flex-1 leading-snug">
                                        {content?.title || unit.subject}
                                    </span>
                                    <span className={`material-symbols-outlined text-[14px] text-gray-400 transition-transform ${isExpanded ? 'rotate-90' : ''}`}>chevron_right</span>
                                </button>

                                {isExpanded && (
                                    <div className="mt-1 ml-4 pl-2 border-l-2 border-gray-100 space-y-1">
                                        {/* Unit Test */}
                                        <button
                                            onClick={() => onSelect(unit.id, 'unit_test', 'Unit Test')}
                                            className={`w-full text-left px-3 py-2 rounded-md text-[11px] font-medium flex items-center gap-2 transition-all ${selectedTopicId === unit.id && selectedSubTopicId === 'unit_test'
                                                ? 'bg-black text-white shadow-md'
                                                : 'text-gray-500 hover:bg-gray-50'
                                                }`}
                                        >
                                            <span className="material-symbols-outlined text-[14px]">assignment</span>
                                            Unit Test
                                        </button>

                                        {/* Chapters */}
                                        {/* Chapters */}
                                        {(() => {
                                            const BC_ONLY_IDS = [
                                                '6.11', '6.12', '6.13', '7.5', '7.9', '8.13',
                                                '9.1', '9.2', '9.3', '9.4', '9.5', '9.6', '9.7', '9.8', '9.9',
                                                '10.1', '10.2', '10.3', '10.4', '10.5', '10.6', '10.7', '10.8', '10.9', '10.10', '10.11', '10.12', '10.13', '10.14', '10.15'
                                            ];

                                            const filteredSubs = subs.filter((s: any) => {
                                                if (s.id === 'unit_test' || s.id === 'overview') return false;
                                                if (activeCourse === 'AB' && BC_ONLY_IDS.includes(s.id)) return false;
                                                if (!s.courseScope || s.courseScope === 'both') return true;
                                                if (activeCourse === 'AB') return s.courseScope !== 'bc_only';
                                                if (activeCourse === 'BC') return s.courseScope !== 'ab_only';
                                                return true;
                                            });

                                            if (filteredSubs.length === 0) return <div className="px-3 py-2 text-[10px] text-gray-400 italic">No chapters loaded</div>;

                                            return filteredSubs.map((sub: any, index: number) => {
                                                const isSelected = selectedTopicId === unit.id && selectedSubTopicId === sub.id;
                                                // Robust numbering fix
                                                const cleanTitle = sub.title.replace(/^\d+\.\d+\s*/, '');
                                                const unitPrefix = sub.title.match(/^\d+/)?.[0] || '';
                                                const displayTitle = unitPrefix ? `${unitPrefix}.${index + 1} ${cleanTitle}` : sub.title;

                                                return (
                                                    <button
                                                        key={sub.id}
                                                        onClick={() => onSelect(unit.id, sub.id, sub.title)}
                                                        className={`w-full text-left px-3 py-2 rounded-md transition-all ${isSelected
                                                            ? 'bg-black text-white shadow-md'
                                                            : 'text-gray-500 hover:bg-gray-50'
                                                            }`}
                                                    >
                                                        <div className="text-[11px] font-medium leading-tight break-words">
                                                            {displayTitle}
                                                        </div>
                                                    </button>
                                                );
                                            });
                                        })()}
                                    </div>
                                )}
                            </div>
                        );
                    })}
                </div>
            </div>

            {/* Footer: Debug QA */}
            <div className="p-4 border-t border-gray-100 mt-auto">
                <a
                    href="#/debug-qa"
                    target="_blank"
                    className="flex items-center gap-2 text-xs font-bold text-gray-400 hover:text-primary transition-colors px-2 py-2 rounded-lg hover:bg-gray-50 group"
                >
                    <span className="material-symbols-outlined text-[16px] group-hover:animate-spin">build</span>
                    Debug QA Tool
                </a>
            </div>
        </div>
    );
};

// --- Question List Column ---

const QuestionListSidebar = ({
    questions,
    selectedTopicId,
    selectedSubTopicId,
    onSelectQuestion,
    onDeleteQuestion,
    activeQuestionId
}: {
    questions: Question[];
    selectedTopicId: string;
    selectedSubTopicId: string | null;
    onSelectQuestion: (q: Question) => void;
    onDeleteQuestion: (qId: string) => void;
    activeQuestionId?: string;
}) => {
    const { user } = useApp();
    const [deleteTargetId, setDeleteTargetId] = useState<string | null>(null);
    const [draggingId, setDraggingId] = useState<string | null>(null);
    const [localOrder, setLocalOrder] = useState<string[]>([]);
    const [searchQuery, setSearchQuery] = useState('');
    const [searchScope, setSearchScope] = useState<'course' | 'unit' | 'section'>('unit');

    // Auto-switch search scope based on selection
    useEffect(() => {
        if (selectedSubTopicId) {
            setSearchScope('section');
        } else if (selectedTopicId) {
            setSearchScope('unit');
        } else {
            setSearchScope('course');
        }
    }, [selectedTopicId, selectedSubTopicId]);

    const filtered = useMemo(() => {
        // Helper to strip course prefix (AB_, BC_, Both_, or ABBC_)
        const getBase = (id: string) => id.replace(/^(AB_|BC_|Both_|ABBC_)/, '');
        const selectedBase = getBase(selectedTopicId);
        const hasSearch = !!searchQuery.trim();
        const term = searchQuery.toLowerCase().trim();
        const isShortQuery = term.length < 2 && /^\d+$/.test(term); // Strict mode for single digits

        // Pass 1: Filter Logic based on Scope
        let candidates = questions.filter(q => {
            if (searchScope === 'course') {
                return true;
            } else if (searchScope === 'unit') {
                const qBase = getBase(q.topic);
                return q.topic === selectedTopicId ||
                    (qBase === selectedBase && (q.course === 'Both' || q.course === user.currentCourse || !q.course)) ||
                    (q as any).topicId === selectedTopicId;
            } else {
                // Section Scope
                const qBase = getBase(q.topic);
                const isTopicMatch = q.topic === selectedTopicId ||
                    (qBase === selectedBase && (q.course === 'Both' || q.course === user.currentCourse || !q.course)) ||
                    (q as any).topicId === selectedTopicId;

                if (!isTopicMatch) return false;
                if (!selectedSubTopicId) return true;

                if (selectedSubTopicId === 'unit_test') {
                    return q.sectionId === 'unit_test' || q.sectionId?.endsWith('_unit_test') ||
                        q.subTopicId === 'unit_test' || q.subTopicId?.endsWith('_unit_test');
                }
                return q.sectionId === selectedSubTopicId || q.subTopicId === selectedSubTopicId;
            }
        });

        // Pass 2: Search Filtering & Ranking
        if (hasSearch) {
            // Filter first
            candidates = candidates.filter(q => {
                const titleMatch = q.title && q.title.toLowerCase().includes(term);
                const idMatch = q.id && q.id.toLowerCase().includes(term);
                const subTopicMatch = q.subTopicId && q.subTopicId.toLowerCase().includes(term); // Treat subtopic like title

                // For short numeric queries (e.g. "4"), avoid searching prompt/text to prevent noise
                // Otherwise search prompt
                const promptMatch = !isShortQuery && q.prompt && q.prompt.toLowerCase().includes(term);

                return titleMatch || idMatch || subTopicMatch || promptMatch;
            });

            // Scoring Function
            const getScore = (q: Question) => {
                let score = 0;
                const title = (q.title || '').toLowerCase();
                const id = (q.id || '').toLowerCase();
                const subTopic = (q.subTopicId || '').toLowerCase();

                // Title Matches (Highest Priority)
                if (title === term) score += 100;
                else if (title.startsWith(term)) score += 80;
                else if (title.endsWith(term)) score += 75; // "Unit1-Q4" ends with 4
                else if (title.includes(term)) score += 60;

                // SubTopic Matches (High Priority for grouping)
                if (subTopic === term) score += 90;
                else if (subTopic.includes(term)) score += 55;

                // ID Matches (Medium Priority)
                if (id === term) score += 70;
                else if (id.startsWith(term)) score += 50;
                else if (id.includes(term)) score += 40;

                return score;
            };

            // Sort by Score DESC
            return candidates.sort((a, b) => getScore(b) - getScore(a));
        }

        return candidates;
    }, [questions, selectedSubTopicId, selectedTopicId, searchQuery, searchScope]);

    // Load order from local storage
    useEffect(() => {
        const key = `q_order_${selectedTopicId}_${selectedSubTopicId || 'all'}`;
        try {
            const saved = localStorage.getItem(key);
            if (saved) {
                setLocalOrder(JSON.parse(saved));
            } else {
                setLocalOrder([]);
            }
        } catch (e) {
            console.error("Failed to load order", e);
        }
    }, [selectedTopicId, selectedSubTopicId]);

    // Compute display questions
    const displayQuestions = useMemo(() => {
        // Helper to extract P-number or Q-number for sorting
        // Prioritizes: Title -> Prompt (Image filename like 2.3-P4) -> ID
        const getQuestionNumber = (q: Question): number => {
            const textToSearch = `${q.title || ''} ${q.prompt || ''} ${q.id || ''}`;

            // Match P1, P2, P10... or Q1, Q2...
            // Look for patterns like "-P4", " P4", "Q4", "Question 4"
            // We want specific delimiters to avoid matching random text
            const pMatch = textToSearch.match(/(?:^|[\s\-_.\/\\])P(\d+)(?:[\s\-_.\/\\]|$)/i);
            if (pMatch) return parseInt(pMatch[1]);

            const qMatch = textToSearch.match(/(?:^|[\s\-_.\/\\])Q(\d+)(?:[\s\-_.\/\\]|$)/i);
            if (qMatch) return parseInt(qMatch[1]);

            return 999999; // No number found, push to end
        };

        // If Searching, ignore manual order (results are ranked by relevance)
        if (searchQuery.trim()) return filtered;

        // If NO manual order is set (or empty), use Auto-Sort by P-Number
        if (localOrder.length === 0) {
            return [...filtered].sort((a, b) => {
                const numA = getQuestionNumber(a);
                const numB = getQuestionNumber(b);

                if (numA !== numB) {
                    return numA - numB;
                }
                // Fallback to creation order (if available) or ID to be stable
                return (a.id || '').localeCompare(b.id || '');
            });
        }

        const orderMap = new Map<string, number>(localOrder.map((id, i) => [id, i]));

        // Items in order array are sorted by index
        // Items NOT in order array (new ones) are appended at the end (idx = Infinity)
        // or we can fallback to filtered order for them
        return [...filtered].sort((a, b) => {
            const idxA = orderMap.has(a.id) ? orderMap.get(a.id)! : 9999999;
            const idxB = orderMap.has(b.id) ? orderMap.get(b.id)! : 9999999;

            if (idxA === idxB) {
                // If both are new (not in manual order), sort them by P-number too!
                const numA = getQuestionNumber(a);
                const numB = getQuestionNumber(b);
                return numA - numB;
            }
            return idxA - idxB;
        });
    }, [filtered, localOrder, searchQuery]);

    const handleDeleteClick = (e: React.MouseEvent, qId: string) => {
        e.stopPropagation();
        setDeleteTargetId(qId);
    };

    const handleConfirmDelete = () => {
        if (deleteTargetId) {
            onDeleteQuestion(deleteTargetId);
            setDeleteTargetId(null);
        }
    };

    // Drag Handlers
    const handleDragStart = (e: React.DragEvent, id: string) => {
        e.dataTransfer.effectAllowed = "move";
        setDraggingId(id);
        // Ghost image customization if needed
    };

    const handleDragOver = (e: React.DragEvent, targetId: string) => {
        e.preventDefault();
        e.dataTransfer.dropEffect = "move";

        if (!draggingId || draggingId === targetId) return;

        // Sorting is disabled during search
        if (searchQuery.trim()) return;

        // Reorder locally for visual feedback
        const currentList = displayQuestions.map(q => q.id);
        const fromIndex = currentList.indexOf(draggingId);
        const toIndex = currentList.indexOf(targetId);

        if (fromIndex === -1 || toIndex === -1) return;

        const newList = [...currentList];
        newList.splice(fromIndex, 1);
        newList.splice(toIndex, 0, draggingId);

        setLocalOrder(newList);
    };

    const handleDrop = (e: React.DragEvent) => {
        e.preventDefault();
        setDraggingId(null);

        // Save to LocalStorage
        const key = `q_order_${selectedTopicId}_${selectedSubTopicId || 'all'}`;
        // Ensure we save the specific current order of ALL filtered IDs
        const currentOrderIds = displayQuestions.map(q => q.id);
        localStorage.setItem(key, JSON.stringify(currentOrderIds));
    };

    return (
        <>
            {/* Custom Delete Confirmation Modal */}
            {deleteTargetId && (
                <div className="fixed inset-0 z-[100] flex items-center justify-center p-4 bg-black/40 backdrop-blur-sm animate-fade-in">
                    <div className="bg-white rounded-2xl shadow-2xl max-w-sm w-full p-6 border border-gray-100 animate-fade-in-up">
                        <div className="flex flex-col items-center text-center gap-4 mb-6">
                            <div className="w-14 h-14 bg-red-50 rounded-full flex items-center justify-center">
                                <span className="material-symbols-outlined text-3xl text-red-500">delete_forever</span>
                            </div>
                            <h3 className="text-xl font-bold text-gray-900">Delete Question?</h3>
                            <p className="text-gray-500 text-sm">
                                Are you sure you want to delete this question? This action cannot be undone.
                            </p>
                        </div>
                        <div className="flex gap-3">
                            <button
                                onClick={() => setDeleteTargetId(null)}
                                className="flex-1 py-3 rounded-xl font-bold text-gray-600 hover:bg-gray-100 transition-colors"
                            >
                                Cancel
                            </button>
                            <button
                                onClick={handleConfirmDelete}
                                className="flex-1 py-3 rounded-xl font-bold bg-red-500 text-white hover:bg-red-600 transition-colors"
                            >
                                Delete
                            </button>
                        </div>
                    </div>
                </div>
            )}

            <div className="w-[22%] min-w-[240px] max-w-[360px] border-r border-gray-200 h-full bg-white flex flex-col flex-shrink-0">
                <div className="p-4 border-b border-gray-100">
                    <div className="flex items-center justify-between mb-3">
                        <p className="text-[12px] font-bold text-gray-900">Questions ({displayQuestions.length})</p>

                        <div className="flex bg-gray-100 rounded-lg p-0.5">
                            <button
                                onClick={() => setSearchScope('course')}
                                className={`px-2 py-0.5 text-[10px] font-bold rounded-md transition-all ${searchScope === 'course' ? 'bg-white shadow text-black' : 'text-gray-400 hover:text-gray-600'}`}
                                title="Search Entire Course"
                            >
                                ALL
                            </button>
                            <button
                                onClick={() => setSearchScope('unit')}
                                className={`px-2 py-0.5 text-[10px] font-bold rounded-md transition-all ${searchScope === 'unit' ? 'bg-white shadow text-black' : 'text-gray-400 hover:text-gray-600'}`}
                                title="Search Current Unit"
                            >
                                UNIT
                            </button>
                            <button
                                onClick={() => setSearchScope('section')}
                                className={`px-2 py-0.5 text-[10px] font-bold rounded-md transition-all ${searchScope === 'section' ? 'bg-white shadow text-black' : 'text-gray-400 hover:text-gray-600'}`}
                                title="Search This Section Only"
                            >
                                SEC
                            </button>
                        </div>
                    </div>
                    <div className="relative">
                        <span className="material-symbols-outlined absolute left-2 top-2 text-gray-400 text-sm">search</span>
                        <input
                            type="text"
                            value={searchQuery}
                            onChange={(e) => setSearchQuery(e.target.value)}
                            placeholder={`Search ${searchScope === 'course' ? 'everything' : searchScope === 'unit' ? 'unit' : 'section'}...`}
                            className="w-full pl-8 pr-3 py-1.5 bg-gray-50 border border-gray-200 rounded-lg text-xs outline-none focus:border-yellow-400 transition-all"
                        />
                    </div>
                </div>

                <div className="flex-1 overflow-y-auto custom-scrollbar p-3 pb-20 space-y-3 bg-gray-50/50 scroll-bounce">
                    <div className="scroll-bounce-inner min-h-[101%]">
                        {displayQuestions.map((q, index) => {
                            const isActive = activeQuestionId === q.id;
                            const isDragging = draggingId === q.id;

                            return (
                                <div
                                    key={q.id}
                                    draggable
                                    onDragStart={(e) => handleDragStart(e, q.id)}
                                    onDragOver={(e) => handleDragOver(e, q.id)}
                                    onDrop={handleDrop}
                                    onClick={() => onSelectQuestion(q)}
                                    className={`p-3 rounded-xl border cursor-pointer transition-all group relative ${isActive
                                        ? 'bg-white border-yellow-400 shadow-md ring-1 ring-yellow-400/20'
                                        : 'bg-white border-gray-100 shadow-sm hover:border-gray-300'
                                        } ${isDragging ? 'opacity-50 scale-95 font-mono' : ''}`}
                                >
                                    {/* Drag Handle Hint (Optional, handled by whole card) */}
                                    <div className="absolute top-2 left-1/2 -translate-x-1/2 w-8 h-1 bg-gray-100 rounded-full opacity-0 group-hover:opacity-100 transition-opacity"></div>

                                    {/* Delete Button */}
                                    <button
                                        onClick={(e) => handleDeleteClick(e, q.id)}
                                        className="absolute top-2 right-2 p-1.5 rounded-lg text-gray-300 hover:text-red-500 hover:bg-red-50 opacity-0 group-hover:opacity-100 transition-all"
                                        title="Delete Question"
                                    >
                                        <span className="material-symbols-outlined text-sm">delete</span>
                                    </button>

                                    <div className="flex justify-between items-start mb-2 pr-6">
                                        <span className="text-[10px] font-bold text-gray-400">{q.subTopicId}</span>
                                        <div className="flex gap-1">
                                            <span className="px-1.5 py-0.5 bg-blue-50 text-blue-600 text-[9px] font-bold rounded">BOTH</span>
                                            <span className="px-1.5 py-0.5 bg-gray-100 text-gray-600 text-[9px] font-bold rounded">{q.type}</span>
                                        </div>
                                    </div>
                                    <div className="text-sm font-bold text-gray-800 mb-1 break-words">
                                        {q.title || <span className="text-gray-400 italic">(No Title)</span>}
                                    </div>
                                    <div className="flex justify-between items-center mt-1">
                                        <div className="text-[10px] text-gray-400 font-mono">
                                            ID: {q.id ? q.id.slice(0, 5) : 'NEW'}...
                                        </div>
                                        <span className={`text-[9px] font-black px-1.5 py-0.5 rounded uppercase ${(q.status || '').toLowerCase() === 'published' ? 'bg-green-100 text-green-700' : 'bg-gray-100 text-gray-500'
                                            }`}>
                                            {(q.status || 'draft').toUpperCase()}
                                        </span>
                                    </div>
                                </div>
                            );
                        })}

                        {displayQuestions.length === 0 && selectedSubTopicId && (
                            <div className="text-center py-10 text-gray-400 text-xs">
                                No questions in this section yet.
                            </div>
                        )}
                    </div>
                </div>
            </div>
        </>
    );
};

// --- Right Main Area ---

export const QuestionCreator = () => {
    const {
        questions, addQuestion, updateQuestion, deleteQuestion, topicContent, sections, updateSection, fetchSections, fetchQuestions, topicContent: rawTopicContent, user
    } = useApp();

    // -- State --
    const [activeCourse, setActiveCourse] = useState<CourseType>('AB');
    const [selectedTopicId, setSelectedTopicId] = useState<string>(''); // Start empty per user request
    const [selectedSubTopicId, setSelectedSubTopicId] = useState<string | null>(null);   // Start empty

    const [viewMode, setViewMode] = useState<'settings' | 'editor'>('settings');
    const prevSelectionRef = useRef({ topicId: selectedTopicId, subTopicId: selectedSubTopicId });

    // Editor State
    const defaultForm: FormState = useMemo(() => ({
        course: 'Both',
        topic: 'Limits',
        subTopicId: selectedSubTopicId,
        topicId: selectedTopicId,
        title: '',
        type: 'MCQ',
        calculatorAllowed: false,
        difficulty: 3,
        targetTimeSeconds: 120,
        skillTags: [],
        errorTags: [],
        prompt: '',
        promptImage: null,
        latex: '',
        options: [
            { label: 'A', value: '', type: 'text', explanation: '', explanationType: 'text' },
            { label: 'B', value: '', type: 'text', explanation: '', explanationType: 'text' },
            { label: 'C', value: '', type: 'text', explanation: '', explanationType: 'text' },
            { label: 'D', value: '', type: 'text', explanation: '', explanationType: 'text' }
        ],
        correctOptionLabel: 'A',
        explanation: '',
        recommendationReasons: [],
        primarySkillId: '',
        supportingSkillIds: [],
        promptType: 'text',
        source: 'self',
        status: 'published',
        version: 1,
        weightPrimary: 0.8,
        weightSupporting: 0.2,
        explanationType: 'text',
        errorPatternIds: []
    }), [selectedSubTopicId, selectedTopicId]);

    const [formData, setFormData] = useState<FormState>(defaultForm);
    const [isSaving, setIsSaving] = useState(false);

    // Preview States
    const [promptPreview, setPromptPreview] = useState(false);
    const [explanationPreview, setExplanationPreview] = useState(false);
    const [optionPreviews, setOptionPreviews] = useState<Record<number, boolean>>({});
    const [optionExplPreviews, setOptionExplPreviews] = useState<Record<number, boolean>>({});

    // Chapter Settings State
    const [sectionSettings, setSectionSettings] = useState<any>(null);
    const [saveStatus, setSaveStatus] = useState<'idle' | 'saving' | 'success' | 'error'>('idle');

    // Global toast notifications
    const { showToast } = useToast();

    // Initial load
    useEffect(() => {
        fetchSections();
        fetchQuestions(); // Ensure questions are loaded for display
    }, []);

    // Sync section settings when selection changes
    useEffect(() => {
        if (!selectedTopicId) return;

        // Find existing data
        const topicSecs = sections[selectedTopicId] || [];
        // Handle unit_test ID mapping: 'unit_test' -> '[TopicID]_unit_test'
        const effectiveSubTopicId = selectedSubTopicId === 'unit_test' ? `${selectedTopicId}_unit_test` : selectedSubTopicId;

        // Try precise match first (e.g. BC_Series_unit_test), fallback to direct match (in case legacy)
        const sec = topicSecs.find((s: any) => s.id === effectiveSubTopicId || s.id === selectedSubTopicId);

        if (sec) {
            setSectionSettings({
                ...sec,
                id: sec.id, // Use actual DB ID
                availability: {
                    lesson: !!(sec.hasLesson || sec.has_lesson),
                    practice: sec.hasPractice !== false && sec.has_practice !== false
                }
            });
        } else {
            // Find specific section in static data
            const unit = topicContent[selectedTopicId] || COURSE_CONTENT_DATA[selectedTopicId]; // Ensure fallback here too!

            if (!selectedSubTopicId) {
                // Unit Settings
                setSectionSettings({
                    id: null,
                    title: unit?.title || 'Unit Settings',
                    description: unit?.description || 'Unit Description',
                    estimated_minutes: 0,
                    type: 'UNIT',
                    availability: { lesson: true, practice: true }
                });
                setViewMode('settings');
                return;
            }

            const staticSec = (unit?.subTopics?.find((s: any) => s.id === selectedSubTopicId) ||
                (selectedSubTopicId === 'unit_test' ? unit?.unitTest : null)) as any;

            setSectionSettings({
                id: effectiveSubTopicId, // Use the correct ID for saving
                title: staticSec?.title || (selectedSubTopicId === 'unit_test' ? 'Unit Test' : ''),
                description: staticSec?.description || '',
                description_2: staticSec?.description_2 || '',
                estimated_minutes: staticSec?.estimatedMinutes || 10,
                availability: {
                    lesson: !!(staticSec?.hasLesson || staticSec?.has_lesson),
                    practice: staticSec?.hasPractice !== false
                }
            });
        }

        // Reset view to settings ONLY when switching chapters (not on data refresh)
        if (prevSelectionRef.current.topicId !== selectedTopicId || prevSelectionRef.current.subTopicId !== selectedSubTopicId) {
            setViewMode('settings');
            setFormData(prev => ({ ...defaultForm, topicId: selectedTopicId, subTopicId: selectedSubTopicId }));

            // Update ref
            prevSelectionRef.current = { topicId: selectedTopicId, subTopicId: selectedSubTopicId };
        }

    }, [selectedTopicId, selectedSubTopicId, sections, topicContent, defaultForm]);

    // Handlers
    const handleNavSelect = (topicId: string, subTopicId: string | null) => {
        setSelectedTopicId(topicId);
        setSelectedSubTopicId(subTopicId as any); // Cast for safety if needed
    };

    const handleSelectQuestion = async (q: Question) => {
        // Derive correct label from ID or fallback to index
        const correctOptIdx = q.options.findIndex(o => o.id === q.correctOptionId);
        const correctOpt = correctOptIdx !== -1 ? q.options[correctOptIdx] : null;
        const derivedLabel = correctOpt
            ? (correctOpt.label || (['A', 'B', 'C', 'D'].includes(correctOpt.id) ? correctOpt.id : String.fromCharCode(65 + correctOptIdx)))
            : 'A';

        // ROBUST MAPPING: Ensure skills and error tags are mapped even if relational fields are missing
        const skillTags = q.skillTags || [];
        const errorTags = q.errorTags || [];

        // Fix: Backend returns snake_case 'primary_skill_id', frontend expects camelCase
        const primarySkillId = q.primarySkillId || (q as any).primary_skill_id || (skillTags.length > 0 ? skillTags[0] : '');

        // FIX: Ensure Primary Skill is in the dropdown list options
        if (primarySkillId && !fetchedSkills.find(s => s.value === primarySkillId)) {
            const newOpt = { label: primarySkillId, value: primarySkillId };
            setFetchedSkills(prev => [...prev, newOpt]);
        }

        const supportingSkillIds = q.supportingSkillIds && q.supportingSkillIds.length > 0
            ? q.supportingSkillIds
            : (skillTags.length > 1 ? skillTags.slice(1) : []);
        const errorPatternIds = q.errorPatternIds && q.errorPatternIds.length > 0
            ? q.errorPatternIds
            : errorTags;

        // SYNC SELECTION: Ensure unit/chapter context is updated
        const targetTopicId = (q as any).topicId || q.topic;
        const targetSectionId = (q as any).sectionId || q.subTopicId;

        if (targetTopicId) setSelectedTopicId(targetTopicId);
        if (targetSectionId) setSelectedSubTopicId(targetSectionId);

        // PRE-EMPT HOOK: Prevent the selection useEffect from resetting viewMode to 'settings'
        if (targetTopicId || targetSectionId) {
            prevSelectionRef.current = {
                topicId: targetTopicId || selectedTopicId,
                subTopicId: targetSectionId || (selectedSubTopicId as any)
            };
        }

        // Parse prompt if it is a JSON string or object (legacy format)
        let displayPrompt = q.prompt || '';
        let displayImage = null;

        if (typeof displayPrompt === 'object') {
            const castedPrompt = displayPrompt as any;
            displayPrompt = castedPrompt.text || '';
            displayImage = castedPrompt.image || null;
        } else if (typeof displayPrompt === 'string') {
            const trimmed = displayPrompt.trim();
            if (trimmed.startsWith('{')) {
                try {
                    const parsed = JSON.parse(displayPrompt);
                    if (parsed.text || parsed.image) {
                        displayPrompt = parsed.text || '';
                        displayImage = parsed.image || null;
                    }
                } catch (e) { /* Ignore */ }
            } else if (trimmed.startsWith('[')) {
                // Handle JSON Array ["text", "image"]
                try {
                    const parsed = JSON.parse(displayPrompt);
                    if (Array.isArray(parsed)) {
                        // Assumption: First non-url item is text, first url-like item is image
                        // Or just Item 0 is text, Item 1 is image?
                        // Let's iterate and classify.
                        const textParts: string[] = [];
                        let foundImage = null;

                        parsed.forEach(p => {
                            const str = String(p);
                            if (!foundImage && (str.startsWith('http') || str.startsWith('data:image') || str.startsWith('/storage'))) {
                                foundImage = str;
                            } else {
                                // Check for Markdown image inside the text part
                                const imgRegex = /!\[(.*?)\]\((.*?)\)/;
                                const match = str.match(imgRegex);
                                if (match && !foundImage) {
                                    foundImage = match[2];
                                    textParts.push(str.replace(imgRegex, '').trim());
                                } else {
                                    textParts.push(str);
                                }
                            }
                        });
                        displayPrompt = textParts.join('\n\n');
                        displayImage = foundImage || displayImage; // Prioritize found image
                    }
                } catch (e) { /* Ignore */ }
            } else {
                // LEGACY STRING FORMAT (Markdown or Raw URL)

                // 1. Extract ![...](url) pattern
                const imgRegex = /!\[(.*?)\]\((.*?)\)/;
                const match = displayPrompt.match(imgRegex);
                if (match) {
                    displayImage = match[2];
                    displayPrompt = displayPrompt.replace(imgRegex, '').trim();
                }

                // 2. Check for Raw URL if no image yet
                // If the entire prompt is just a URL, or contains one at the end?
                // User screenshot shows a raw URL.
                if (!displayImage) {
                    // Simple check: if prompt looks like a URL
                    if (displayPrompt.trim().startsWith('http') || displayPrompt.trim().startsWith('https://xzpjln')) {
                        displayImage = displayPrompt.trim();
                        displayPrompt = ''; // Clear text if it's just a URL
                    }
                }
            }
        }
        // Direct DB Fetch to ensure Title is loaded (Bypasses potential API issues)
        let freshTitle = q.title;
        if (!freshTitle) {
            try {
                const { data } = await supabase
                    .from('questions')
                    .select('title')
                    .eq('id', q.id)
                    .single();
                if (data?.title) {
                    freshTitle = data.title;
                    console.log('Fetched fresh title from DB:', freshTitle);
                }
            } catch (err) {
                console.warn('Failed to fetch fresh title', err);
            }
        }

        setFormData({
            ...defaultForm,
            ...q,
            status: 'published', // Force published status as per user request
            title: freshTitle || '', // Use the fresh DB title
            prompt: displayPrompt, // Use parsed prompt text
            promptImage: displayImage, // Separate image
            correctOptionLabel: derivedLabel,
            primarySkillId,
            supportingSkillIds,
            errorPatternIds,
            // Map legacy fields — merge microExplanations into option.explanation
            options: q.options.map((o: any, oIdx: number) => {
                const label = o.label || String.fromCharCode(65 + oIdx);
                const optId = o.id || label;
                return {
                    ...o,
                    label,
                    type: o.type || 'text',
                    value: o.value || o.text || '', // Fix: fallback to o.text if value is missing
                    explanation: o.explanation || q.microExplanations?.[optId] || q.microExplanations?.[label] || ''
                };
            })
        });
        setViewMode('editor');
    };

    const handleCreateQuestion = () => {
        setFormData({ ...defaultForm, topicId: selectedTopicId, subTopicId: selectedSubTopicId });
        setViewMode('editor');
    };

    // --- Dynamic Skills & Error Tags ---
    const [fetchedSkills, setFetchedSkills] = useState<{ label: string, value: string }[]>([]);
    const [fetchedErrors, setFetchedErrors] = useState<{ label: string, value: string }[]>([]);
    const [isResetting, setIsResetting] = useState(false);

    useEffect(() => {
        const fetchMetadata = async () => {
            // Fetch Skills
            const { data: skillsData } = await supabase.from('skills').select('id, name');
            if (skillsData) {
                const mapped = skillsData.map(s => ({ label: s.name, value: s.id }));
                setFetchedSkills(mapped);
            } else {
                // Fallback to constants if DB empty?
                // User wants to CLEAR DB, so if empty, show empty.
                // But initially might be empty.
                // We merge constants if we want, but let's stick to DB as source of truth if connected.
                if (SKILL_TAGS.length > 0 && (!skillsData || skillsData.length === 0)) {
                    // map constants effectively? No, keep it clean.
                }
            }
            // Fetch Errors
            const { data: errorsData } = await supabase.from('error_tags').select('id, name');
            if (errorsData) {
                setFetchedErrors(errorsData.map(e => ({ label: e.name, value: e.id })));
            }
        };
        fetchMetadata();
    }, [isResetting]); // Refetch when resetting

    const handleCreateSkill = async (name: string): Promise<string | null> => {
        const id = name.toLowerCase().replace(/[^a-z0-9]/g, '_');
        const unit = selectedTopicId || 'General';

        // Optimistic update
        const newOpt = { label: name, value: id };
        setFetchedSkills(prev => [...prev, newOpt]);

        const { error } = await supabase.from('skills').insert({ id, name, unit }).select().single();
        if (error) {
            // If conflict (exists), return the ID.
            if (error.code === '23505') return id;
            showToast(`Failed to create skill: ${error.message}`, 'error');
            setFetchedSkills(prev => prev.filter(p => p.value !== id)); // Revert
            return null;
        }
        return id;
    };

    const handleCreateError = async (name: string): Promise<string | null> => {
        const id = 'ERR_' + name.toUpperCase().replace(/[^A-Z0-9]/g, '_').substring(0, 20);

        const newOpt = { label: name, value: id };
        setFetchedErrors(prev => [...prev, newOpt]);

        const { error } = await supabase.from('error_tags').insert({ id, name }).select().single();
        if (error) {
            if (error.code === '23505') return id;
            showToast(`Failed to create error tag: ${error.message}`, 'error');
            setFetchedErrors(prev => prev.filter(p => p.value !== id));
            return null;
        }
        return id;
    };

    const handleDeleteSkillValue = async (id: string): Promise<void> => {
        const { error } = await supabase.from('skills').delete().eq('id', id);
        if (error) {
            showToast(`Failed to delete skill: ${error.message}`, 'error');
            throw error;
        }
        setFetchedSkills(prev => prev.filter(s => s.value !== id));
    };

    const handleDeleteErrorValue = async (id: string): Promise<void> => {
        const { error } = await supabase.from('error_tags').delete().eq('id', id);
        if (error) {
            showToast(`Failed to delete error tag: ${error.message}`, 'error');
            throw error;
        }
        setFetchedErrors(prev => prev.filter(e => e.value !== id));
    };


    const handleSaveQuestion = async () => {
        // Validation for required fields
        const errors: string[] = [];

        // DRAFTING MODE: Minimal validation
        if (formData.status === 'draft') {
            if (!formData.title?.trim()) errors.push('Question Name');
        } else {
            // PUBLISHED MODE: Full Validation
            if (!formData.title?.trim()) errors.push('Question Name');
            if (!selectedTopicId) errors.push('Topic (Unit)');
            if (!selectedSubTopicId) errors.push('Chapter (Section)');
            if (!formData.primarySkillId) errors.push('Primary Skill');
            if (!formData.prompt?.trim()) errors.push('Question Prompt');

            if (formData.type === 'MCQ') {
                // Check that at least the correct option has content
                const correctOpt = formData.options.find(o => o.label === formData.correctOptionLabel);
                if (!correctOpt?.value?.trim()) errors.push('Correct Answer Option (Option ' + formData.correctOptionLabel + ')');

                // Check explanations for all options with content
                formData.options.forEach(opt => {
                    if (opt.value?.trim() && !opt.explanation?.trim()) {
                        errors.push(`Explanation for Option ${opt.label}`);
                    }
                });
            }

            if (!formData.explanation?.trim()) errors.push('General Explanation / Solution');
        }


        // --- Math Validation ---
        const mathErrors: string[] = [];

        // Check Prompt
        if (formData.promptType === 'text') {
            const promptErrors = validateMathContent(formData.prompt);
            if (promptErrors.length > 0) {
                mathErrors.push(`Prompt: ${promptErrors[0]}`); // Show first error
            }
        }

        // Check Options
        formData.options.forEach(opt => {
            if (opt.value) {
                const optErrors = validateMathContent(opt.value);
                if (optErrors.length > 0) {
                    mathErrors.push(`Option ${opt.label}: ${optErrors[0]}`);
                }
            }
        });

        if (mathErrors.length > 0) {
            console.warn("Math formatting issues detected (ignoring per user preference):", mathErrors);
        }

        if (errors.length > 0) {
            showToast(`Missing required fields: ${errors.join(', ')}`, 'error');
            return;
        }

        setIsSaving(true);
        try {
            // Combine Prompt Text and Image into JSON Array ["text", "image"]
            // This is the format requested by the user for strict separation.
            const promptArray = [];
            if (formData.prompt) promptArray.push(formData.prompt);
            if (formData.promptImage) promptArray.push(formData.promptImage);

            // Use the raw array directly (Supabase handles JSON/Array serialization)
            const combinedPrompt = promptArray.length > 0 ? promptArray : [""];

            // Dynamic Topic ID Calculation
            let calculatedTopicId = selectedTopicId;

            // 1. Try Reverse Lookup (Search content for subtopic)
            if (selectedSubTopicId) {
                const parentUnitEntry = Object.entries(COURSE_CONTENT_DATA).find(([_, content]) => {
                    return content.subTopics.some(sub => sub.id === selectedSubTopicId);
                });
                if (parentUnitEntry) {
                    calculatedTopicId = parentUnitEntry[0];
                }
            }

            // 2. HARD FALLBACK: Prefix Matching (If lookup failed and ID still looks like a subtopic "X.Y")
            // This prevents "1.5" being sent as topic
            if ((calculatedTopicId === selectedSubTopicId || /^\d+\./.test(calculatedTopicId) || calculatedTopicId === 'unit_test') && selectedSubTopicId) {
                // Remove any course prefix if present in subtopic id (e.g. AB_1.5)
                const coreId = selectedSubTopicId.replace(/^(AB_|BC_|Both_|ABBC_)/, '');

                if (coreId.startsWith('1.')) calculatedTopicId = 'ABBC_Limits';
                else if (coreId.startsWith('2.')) calculatedTopicId = 'ABBC_Derivatives';
                else if (coreId.startsWith('3.')) calculatedTopicId = 'ABBC_Composite';
                else if (coreId.startsWith('4.')) calculatedTopicId = 'ABBC_Applications';
                else if (coreId.startsWith('5.')) calculatedTopicId = 'ABBC_Analytical';
                else if (coreId.startsWith('6.')) calculatedTopicId = 'ABBC_Integration';
                else if (coreId.startsWith('7.')) calculatedTopicId = 'ABBC_DiffEq';
                else if (coreId.startsWith('8.')) calculatedTopicId = 'ABBC_AppIntegration';
                else if (coreId.startsWith('9.')) calculatedTopicId = 'BC_Unit9';
                else if (coreId.startsWith('10.')) calculatedTopicId = 'BC_Series';
            }

            // 3. DB Compatibility
            // The User's DB screenshot shows 'Both_Limits' etc.
            // But constants.ts uses 'ABBC_Limits'.
            // Validating against the DB schema: we must translate ABBC_ -> Both_
            if (calculatedTopicId.startsWith('ABBC_')) {
                calculatedTopicId = calculatedTopicId.replace('ABBC_', 'Both_');
            }

            // Legacy/Fallback Logic
            if (formData.course === 'Both' && (calculatedTopicId.startsWith('AB_') || calculatedTopicId.startsWith('BC_'))) {
                const suffix = calculatedTopicId.replace(/^(AB_|BC_)/, '');
                // If we have a Both_ version, use it
                // (We assume Both_ is the standard for shared content in this DB)
                calculatedTopicId = `Both_${suffix}`;
            }

            console.log('Saving Question (Final):', { selectedTopicId, selectedSubTopicId, calculatedTopicId });

            // Build microExplanations from option explanations for DB storage
            const microExplanations: Record<string, string> = {};
            formData.options.forEach(opt => {
                const key = opt.id || opt.label;
                if (key && opt.explanation) {
                    microExplanations[key] = opt.explanation;
                }
            });

            const payload = {
                ...formData,
                prompt: combinedPrompt, // Use the JSON Array format
                topic: calculatedTopicId,       // e.g. 'Both_Limits'
                topicId: calculatedTopicId,
                subTopicId: selectedSubTopicId,
                sectionId: selectedSubTopicId,
                correctOptionId: formData.correctOptionLabel, // Simplify for now
                microExplanations,
                // Ensure numeric types
                difficulty: Number(formData.difficulty) as unknown as 1 | 2 | 3 | 4 | 5,
                targetTimeSeconds: Number(formData.targetTimeSeconds),
                weightPrimary: Number(formData.weightPrimary) || 1.0,
                weightSupporting: Number(formData.weightSupporting) || 0.5,
                sourceYear: formData.sourceYear ? Number(formData.sourceYear) : undefined
            } as any;

            if (formData.id) {
                await updateQuestion(payload);
                showToast('Question updated successfully!');
            } else {
                await addQuestion({ ...payload, options: formData.options });
                showToast('Question saved successfully!');
            }
            // Stay in editor mode with fresh form for adding more questions
            setFormData({ ...defaultForm, topicId: selectedTopicId, subTopicId: selectedSubTopicId });
            // viewMode stays as 'editor' - don't jump to settings

            // IMMEDIATE UPDATE: Fetch questions so the sidebar list updates instantly
            await fetchQuestions();
            fetchSections(); // Refresh counts
        } catch (e: any) {
            console.error(e);
            const msg = e.response?.data?.error || e.message || 'Failed to save question.';
            showToast(msg, 'error');
        } finally {
            setIsSaving(false);
        }
    };

    const handleDeleteQuestion = async () => {
        if (!formData.id) {
            showToast('Cannot delete an unsaved question.', 'error');
            return;
        }
        if (!confirm('Are you sure you want to delete this question? This action cannot be undone.')) {
            return;
        }
        setIsSaving(true);
        try {
            // Use AppContext deleteQuestion which has proper auth handling
            await deleteQuestion(formData.id);
            showToast('Question deleted successfully!');
            setFormData({ ...defaultForm, topicId: selectedTopicId, subTopicId: selectedSubTopicId });
            setViewMode('settings');
            fetchSections();
            fetchQuestions(); // Refresh question list
        } catch (e: any) {
            console.error(e);
            showToast(e.message || 'Failed to delete question.', 'error');
        } finally {
            setIsSaving(false);
        }
    };

    // Delete from sidebar list (takes ID directly)
    const handleDeleteFromList = async (questionId: string) => {
        try {
            // Use AppContext deleteQuestion which has proper auth handling
            await deleteQuestion(questionId);
            showToast('Question deleted successfully!');
            // If deleting the currently edited question, reset editor
            if (formData.id === questionId) {
                setFormData({ ...defaultForm, topicId: selectedTopicId, subTopicId: selectedSubTopicId });
                setViewMode('settings');
            }
            fetchSections();
            fetchQuestions(); // Refresh question list
        } catch (e) {
            console.error(e);
            showToast('Failed to delete question.', 'error');
        }
    };

    const handleSaveSettings = async () => {
        if (!selectedTopicId) return;

        try {
            // Case 1: Saving Unit Level Settings (Overview)
            if (!selectedSubTopicId) {
                const payload = {
                    title: sectionSettings.title,
                    description: sectionSettings.description,
                    estimated_minutes: 0,
                    topic_id: selectedTopicId,
                    id: 'overview',
                    // Default fields required by DB schema but not used for unit container
                    is_unit_test: false,
                    has_lesson: false,
                    has_practice: false,
                    sort_order: -1
                };

                // Try update first
                try {
                    await updateSection(selectedTopicId, 'overview', payload);
                } catch (err) {
                    console.log('Update failed, trying create...', err);
                    // Fallback to Create if update fails (404)
                    await sectionsApi.createSection(payload);
                }
            } else {
                // Case 2: Chapter Settings
                // Use correct ID map for unit tests, or fallback to selected
                const targetSubTopicId = selectedSubTopicId === 'unit_test' ? `${selectedTopicId}_unit_test` : selectedSubTopicId;

                await updateSection(selectedTopicId, targetSubTopicId, {
                    title: sectionSettings.title,
                    description: sectionSettings.description,
                    description_2: sectionSettings.description_2,
                    estimated_minutes: Number(sectionSettings.estimated_minutes),
                    has_lesson: sectionSettings.availability.lesson,
                    has_practice: sectionSettings.availability.practice
                });
            }
            // Update UI status
            setSaveStatus('success');
            setTimeout(() => setSaveStatus('idle'), 2000);

            showToast('Settings saved successfully!');
            fetchSections();
        } catch (e: any) {
            console.error(e);
            setSaveStatus('error');
            setTimeout(() => setSaveStatus('idle'), 3000);
            showToast(e.message || 'Failed to save settings.', 'error');
        }
    };

    return (
        <div className="h-full flex flex-col bg-white overflow-hidden">
            <Navbar />
            {/* Toast is now handled globally by ToastProvider */}

            <div className="flex-1 flex h-full">

                {/* 1. Navigation Sidebar */}
                <NavigationSidebar
                    activeCourse={activeCourse}
                    setActiveCourse={(c) => {
                        setActiveCourse(c);
                        setSelectedTopicId('');
                        setSelectedSubTopicId(null);
                    }}
                    topicContent={topicContent}
                    selectedTopicId={selectedTopicId}
                    selectedSubTopicId={selectedSubTopicId}
                    onSelect={handleNavSelect}
                />

                {/* 2. Questions List Sidebar */}
                <QuestionListSidebar
                    questions={questions}
                    selectedTopicId={selectedTopicId}
                    selectedSubTopicId={selectedSubTopicId}
                    activeQuestionId={formData.id}
                    onSelectQuestion={handleSelectQuestion}
                    onDeleteQuestion={handleDeleteFromList}
                />

                {/* 3. Main Content Area */}
                <div className="flex-1 h-full overflow-y-auto bg-gray-50 p-8 pb-32 custom-scrollbar scroll-bounce">
                    <div className="scroll-bounce-inner min-h-[101%]">
                        {viewMode === 'settings' && sectionSettings && (
                            <div className="max-w-3xl mx-auto">
                                <div className="flex items-center gap-4 mb-8">
                                    <div className="p-3 bg-black rounded-xl text-white">
                                        <span className="material-symbols-outlined">settings_suggest</span>
                                    </div>
                                    <div>
                                        <h1 className="text-2xl font-black text-gray-900">{sectionSettings.type === 'UNIT' ? 'Unit Settings' : 'Chapter Settings'}</h1>
                                        <p className="text-gray-500">Configure metadata for this section.</p>
                                    </div>
                                </div>

                                <div className="bg-white rounded-3xl p-8 shadow-sm border border-gray-100 space-y-6">
                                    <div>
                                        <label className="text-xs font-bold text-gray-400 uppercase tracking-wider mb-2 block">Title</label>
                                        <input
                                            value={sectionSettings.title}
                                            onChange={e => setSectionSettings({ ...sectionSettings, title: e.target.value })}
                                            className="w-full p-4 bg-gray-50 rounded-xl font-bold text-lg border-none focus:ring-2 focus:ring-yellow-400"
                                        />
                                    </div>

                                    <div>
                                        <label className="text-xs font-bold text-gray-400 uppercase tracking-wider mb-2 block">Description (Short / Subtitle)</label>
                                        <input
                                            value={sectionSettings.description}
                                            onChange={e => setSectionSettings({ ...sectionSettings, description: e.target.value })}
                                            className="w-full p-4 bg-gray-50 rounded-xl font-medium border-none focus:ring-2 focus:ring-yellow-400"
                                            placeholder="e.g. Avg vs Instant Rate"
                                        />
                                    </div>

                                    <div>
                                        <label className="text-xs font-bold text-gray-400 uppercase tracking-wider mb-2 block">Detailed Description (For Card)</label>
                                        <textarea
                                            value={sectionSettings.description_2 || ''}
                                            onChange={e => setSectionSettings({ ...sectionSettings, description_2: e.target.value })}
                                            className="w-full p-4 bg-gray-50 rounded-xl font-medium min-h-[100px] border-none focus:ring-2 focus:ring-yellow-400 resize-none"
                                            placeholder="Enter a more detailed description..."
                                        />
                                    </div>

                                    {sectionSettings.type !== 'UNIT' && (
                                        <div className="grid grid-cols-2 gap-8">
                                            <div>
                                            </div>
                                            <div>
                                                <label className="text-xs font-bold text-gray-400 uppercase tracking-wider mb-2 block">Availability (Check to Enable)</label>
                                                <div className="flex flex-wrap gap-4">
                                                    <div
                                                        className="flex-1 min-w-[140px] p-4 bg-purple-50 border border-purple-200 rounded-xl flex items-center justify-between gap-3 cursor-pointer hover:bg-purple-100 transition-colors"
                                                        onClick={() => setSectionSettings({ ...sectionSettings, availability: { ...sectionSettings.availability, lesson: !sectionSettings.availability.lesson } })}
                                                    >
                                                        <span className="font-bold text-gray-800 whitespace-nowrap">Lesson</span>
                                                        <input
                                                            type="checkbox"
                                                            checked={sectionSettings.availability.lesson}
                                                            onChange={() => { }}
                                                            className="w-5 h-5 accent-purple-600 cursor-pointer shrink-0"
                                                        />
                                                    </div>

                                                    <div
                                                        className="flex-1 min-w-[140px] p-4 bg-yellow-50 border border-yellow-200 rounded-xl flex items-center justify-between gap-3 cursor-pointer hover:bg-yellow-100 transition-colors"
                                                        onClick={() => setSectionSettings({ ...sectionSettings, availability: { ...sectionSettings.availability, practice: !sectionSettings.availability.practice } })}
                                                    >
                                                        <span className="font-bold text-gray-800 whitespace-nowrap">Practice</span>
                                                        <input
                                                            type="checkbox"
                                                            checked={sectionSettings.availability.practice}
                                                            onChange={() => { }}
                                                            className="w-5 h-5 accent-blue-600 cursor-pointer shrink-0"
                                                        />
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    )}

                                    <div className="pt-8 flex gap-4">
                                        <button
                                            onClick={handleSaveSettings}
                                            disabled={saveStatus === 'saving'}
                                            className={`
                                                px-6 py-4 font-bold rounded-xl transition-all flex items-center justify-center gap-2 whitespace-nowrap min-w-fit
                                                ${saveStatus === 'success'
                                                    ? 'bg-green-500 text-white shadow-lg shadow-green-500/30'
                                                    : saveStatus === 'error'
                                                        ? 'bg-red-500 text-white'
                                                        : 'bg-gray-100 hover:bg-gray-200 text-black'
                                                }
                                            `}
                                        >
                                            {saveStatus === 'saving' ? (
                                                <>
                                                    <span className="material-symbols-outlined animate-spin shrink-0">refresh</span>
                                                    <span>Saving...</span>
                                                </>
                                            ) : saveStatus === 'success' ? (
                                                <>
                                                    <span className="material-symbols-outlined shrink-0">check_circle</span>
                                                    <span>Saved!</span>
                                                </>
                                            ) : (
                                                <>
                                                    <span className="material-symbols-outlined shrink-0">save</span>
                                                    <span>Save Settings</span>
                                                </>
                                            )}
                                        </button>
                                        <button onClick={handleCreateQuestion} className="flex-1 px-4 py-4 bg-black text-white font-bold rounded-xl hover:scale-[1.02] transition-transform flex items-center justify-center gap-2 shadow-xl text-center leading-tight min-w-fit">
                                            <span className="material-symbols-outlined shrink-0">add_circle</span>
                                            <span>Create Question for this Section</span>
                                        </button>
                                    </div>
                                </div>
                            </div>
                        )}

                        {viewMode === 'editor' && (
                            <div className="max-w-4xl mx-auto pb-20">
                                {/* Editor Header */}
                                <div className="flex flex-wrap items-center justify-between gap-4 mb-8">
                                    <div>
                                        <div className={`inline-block px-3 py-1 text-[10px] font-black uppercase tracking-wider rounded-md mb-2 ${formData.status === 'published'
                                            ? 'bg-green-100 text-green-700'
                                            : 'bg-yellow-100 text-yellow-800'
                                            }`}>
                                            {formData.status === 'published' ? 'Published' : 'Drafting'}
                                        </div>
                                        <h1 className="text-3xl font-black text-gray-900">{formData.title || 'Question Editor'}</h1>
                                    </div>
                                    <div className="flex gap-3">
                                        <button
                                            onClick={() => setViewMode('settings')}
                                            className="px-6 py-2.5 font-bold text-gray-500 hover:bg-gray-100 rounded-xl transition-colors whitespace-nowrap shrink-0"
                                        >
                                            Cancel
                                        </button>
                                        {formData.id && (
                                            <button
                                                onClick={handleDeleteQuestion}
                                                disabled={isSaving}
                                                className="px-6 py-2.5 bg-red-50 hover:bg-red-100 text-red-600 font-bold rounded-xl transition-all flex items-center gap-2 disabled:opacity-50 whitespace-nowrap shrink-0"
                                            >
                                                <span className="material-symbols-outlined text-lg">delete</span>
                                                Delete
                                            </button>
                                        )}
                                        <button
                                            onClick={handleSaveQuestion}
                                            disabled={isSaving}
                                            className="px-8 py-2.5 bg-yellow-400 hover:bg-yellow-500 text-black font-black rounded-xl shadow-lg shadow-yellow-400/20 transition-all flex items-center gap-2 disabled:opacity-50 whitespace-nowrap shrink-0"
                                        >
                                            {isSaving ? 'Saving...' : 'Save'}
                                        </button>
                                    </div>
                                </div>

                                {/* Metadata Grid */}
                                <div className="mb-8">
                                    <div className="flex items-center justify-between mb-4">
                                        <h3 className="text-xs font-bold text-gray-400 uppercase tracking-wider">Classification & Metadata</h3>

                                    </div>

                                    {/* Row 1: Name & Status */}
                                    <div className="grid grid-cols-1 xl:grid-cols-4 gap-4 mb-6">
                                        <div className="md:col-span-3 space-y-1">
                                            <label className="block text-[10px] font-bold text-gray-500 uppercase tracking-wider mb-2">Question Name <span className="text-red-500">*</span></label>
                                            <input
                                                type="text"
                                                value={formData.title || ''}
                                                onChange={e => setFormData({ ...formData, title: e.target.value })}
                                                placeholder="e.g. Limit Laws Practice 1"
                                                className="w-full px-4 py-3 bg-white border border-gray-200 rounded-xl text-sm font-bold text-text-main focus:border-yellow-400 focus:ring-1 focus:ring-yellow-400 outline-none transition-all placeholder:font-medium"
                                            />
                                        </div>
                                        <div className="space-y-1">
                                            <CustomSelect
                                                label="Status"
                                                value={formData.status}
                                                onChange={(val) => setFormData({ ...formData, status: val })}
                                                options={STATUS_OPTIONS}
                                                icon="label"
                                            />
                                        </div>
                                    </div>

                                    {/* Row 2: Target Course & Question Type */}
                                    <div className="grid grid-cols-1 xl:grid-cols-2 gap-4 mb-4">
                                        <div className="space-y-1">
                                            <CustomSelect
                                                label="Target Course"
                                                value={formData.course}
                                                onChange={(val) => setFormData({ ...formData, course: val })}
                                                options={COURSE_OPTIONS}
                                                icon="school"
                                            />
                                        </div>
                                        <div className="space-y-1">
                                            <CustomSelect
                                                label="Question Type"
                                                value={formData.type}
                                                onChange={(val) => setFormData({ ...formData, type: val })}
                                                options={TYPE_OPTIONS}
                                                icon="quiz"
                                            />
                                        </div>
                                    </div>

                                    {/* Row 3: Calculator & Difficulty */}
                                    <div className="grid grid-cols-1 xl:grid-cols-2 gap-4 mb-4">
                                        <div className="space-y-1">
                                            <CustomSelect
                                                label="Calculator Policy"
                                                value={formData.calculatorAllowed ? 1 : 0}
                                                onChange={(val) => setFormData({ ...formData, calculatorAllowed: val === 1 })}
                                                options={CALCULATOR_OPTIONS}
                                                icon="calculate"
                                            />
                                        </div>
                                        <div className="space-y-1">
                                            <CustomSelect
                                                label="Difficulty Level"
                                                value={formData.difficulty}
                                                onChange={(val) => setFormData({ ...formData, difficulty: Number(val) as import('../types').DifficultyLevel })}
                                                options={DIFFICULTY_OPTIONS}
                                                icon="signal_cellular_alt"
                                            />
                                        </div>
                                    </div>

                                    {/* Row 3.5: Estimated Time (New per User Request) */}
                                    <div className="grid grid-cols-1 xl:grid-cols-2 gap-4 mb-4">
                                        <div className="space-y-1">
                                            <label className="text-[10px] font-bold text-gray-500 uppercase tracking-wider">Estimated Time (Min)</label>
                                            <input
                                                type="number"
                                                step="0.5"
                                                min="0.5"
                                                value={(formData.targetTimeSeconds || 120) / 60}
                                                onChange={e => setFormData({ ...formData, targetTimeSeconds: parseFloat(e.target.value) * 60 })}
                                                className="w-full p-4 bg-white border border-gray-200 rounded-xl text-sm font-bold outline-none focus:border-yellow-400 focus:ring-1 focus:ring-yellow-400 transition-all"
                                                placeholder="e.g. 2"
                                            />
                                        </div>
                                    </div>

                                    {/* Row 4: Skills & Weights */}
                                    <div className="grid grid-cols-1 2xl:grid-cols-2 gap-4 mb-4">
                                        <div className="space-y-1">
                                            <div className="flex justify-between">
                                                <label className="text-[10px] font-bold text-gray-500 uppercase tracking-wider text-red-500">Primary Skill *</label>
                                                <label className="text-[10px] font-bold text-gray-400 uppercase tracking-wider">Weight</label>
                                            </div>
                                            <div className="flex gap-2">
                                                <div className="relative flex-1">
                                                    <CreatableSelect
                                                        placeholder="Select or Create Primary Skill..."
                                                        value={formData.primarySkillId}
                                                        onChange={val => setFormData({ ...formData, primarySkillId: val })}
                                                        onCreate={handleCreateSkill}
                                                        onDeleteOption={handleDeleteSkillValue}
                                                        options={fetchedSkills}
                                                    />
                                                </div>
                                                <input
                                                    type="number"
                                                    step="0.1"
                                                    min="0"
                                                    max="1"
                                                    value={formData.weightPrimary || 1.0}
                                                    onChange={e => setFormData({ ...formData, weightPrimary: parseFloat(e.target.value) })}
                                                    className="w-20 p-3 bg-white border border-gray-200 rounded-xl text-sm font-bold text-center outline-none focus:border-yellow-400 focus:ring-1 focus:ring-yellow-400"
                                                />
                                            </div>
                                        </div>
                                        <div className="space-y-1">
                                            <div className="flex justify-between">
                                                <label className="text-[10px] font-bold text-gray-500 uppercase tracking-wider">Supporting Skills</label>
                                                <label className="text-[10px] font-bold text-gray-400 uppercase tracking-wider">Weight</label>
                                            </div>
                                            <div className="flex gap-2">
                                                <div className="relative flex-1">
                                                    <CreatableMultiSelect
                                                        placeholder="Select or Create Supporting Skills..."
                                                        value={formData.supportingSkillIds}
                                                        onChange={val => setFormData({ ...formData, supportingSkillIds: val })}
                                                        onCreate={handleCreateSkill}
                                                        onDeleteOption={handleDeleteSkillValue}
                                                        options={fetchedSkills}
                                                    />
                                                </div>
                                                <input
                                                    type="number"
                                                    step="0.1"
                                                    min="0"
                                                    max="1"
                                                    value={formData.weightSupporting}
                                                    onChange={e => setFormData({ ...formData, weightSupporting: parseFloat(e.target.value) })}
                                                    className="w-20 p-3 bg-white border border-gray-200 rounded-xl text-sm font-bold text-center outline-none focus:border-yellow-400 focus:ring-1 focus:ring-yellow-400"
                                                />
                                            </div>
                                        </div>
                                    </div>

                                    {/* Row 5: Topic, Chapter */}
                                    <div className="grid grid-cols-1 xl:grid-cols-2 gap-4 mb-4">
                                        <div className="space-y-1">
                                            <label className="text-[10px] font-bold text-gray-500 uppercase tracking-wider text-red-500">Topic (Unit) *</label>
                                            <div className="p-3 bg-gray-50 border border-gray-200 rounded-xl text-sm font-bold text-gray-500 cursor-not-allowed flex items-center justify-between">
                                                <span className="truncate">{topicContent[selectedTopicId]?.title}</span>
                                                <span className="material-symbols-outlined text-sm opacity-50">lock</span>
                                            </div>
                                        </div>
                                        <div className="space-y-1">
                                            <label className="text-[10px] font-bold text-gray-500 uppercase tracking-wider text-red-500">Chapter (Section) *</label>
                                            <div className="p-3 bg-gray-50 border border-gray-200 rounded-xl text-sm font-bold text-gray-500 cursor-not-allowed flex items-center justify-between">
                                                <span className="truncate">
                                                    {(() => {
                                                        if (!selectedSubTopicId) return 'Not Selected';
                                                        if (selectedSubTopicId === 'unit_test') return 'Unit Test';

                                                        // Try to find the title in dynamic sections first
                                                        const topicSecs = sections[selectedTopicId] || [];
                                                        const sec = topicSecs.find((s: any) => s.id === selectedSubTopicId);
                                                        if (sec?.title) return sec.title;

                                                        // Fallback to static data
                                                        const unit = topicContent[selectedTopicId] || COURSE_CONTENT_DATA[selectedTopicId];
                                                        const staticSec = unit?.subTopics?.find((s: any) => s.id === selectedSubTopicId);
                                                        return staticSec?.title || selectedSubTopicId;
                                                    })()}
                                                </span>
                                                <span className="material-symbols-outlined text-sm opacity-50">lock</span>
                                            </div>
                                        </div>
                                    </div>

                                    {/* Row 6: Source & Error Patterns */}
                                    <div className="grid grid-cols-1 2xl:grid-cols-2 gap-4 mb-4">
                                        <div className="space-y-1">
                                            <label className="text-[10px] font-bold text-gray-500 uppercase tracking-wider">Source</label>
                                            <input
                                                type="text"
                                                value={formData.source || ''}
                                                onChange={e => setFormData({ ...formData, source: e.target.value })}
                                                placeholder="e.g. Textbook, Past Paper, Self"
                                                className="w-full p-3 bg-white border border-gray-200 rounded-xl text-sm font-bold outline-none focus:border-yellow-400 focus:ring-1 focus:ring-yellow-400 transition-all"
                                            />
                                        </div>
                                        <div className="space-y-1">
                                            <label className="text-[10px] font-bold text-gray-500 uppercase tracking-wider">Common Error Patterns</label>
                                            <div className="relative">
                                                <CreatableMultiSelect
                                                    placeholder="Select or Create Error Patterns..."
                                                    value={formData.errorPatternIds || []}
                                                    onChange={val => setFormData({ ...formData, errorPatternIds: val })}
                                                    onCreate={handleCreateError}
                                                    onDeleteOption={handleDeleteErrorValue}
                                                    options={fetchedErrors}
                                                />
                                            </div>
                                        </div>
                                    </div>

                                    {/* Row 7: Notes */}
                                    <div className="mb-4">
                                        <label className="text-[10px] font-bold text-gray-500 uppercase tracking-wider">Notes (Internal)</label>
                                        <textarea
                                            value={formData.notes || ''}
                                            onChange={e => setFormData({ ...formData, notes: e.target.value })}
                                            placeholder="Internal notes about this question..."
                                            className="w-full p-3 bg-white border border-gray-200 rounded-xl text-sm font-bold outline-none focus:border-yellow-400 focus:ring-1 focus:ring-yellow-400 transition-all resize-y min-h-[60px]"
                                        />
                                    </div>
                                </div>

                                {/* Prompt */}
                                <div className="mb-8">
                                    <div className="flex justify-between mb-2">
                                        <h3 className="text-xs font-bold text-gray-400 uppercase tracking-wider">Question Prompt (Text / Image) <span className="text-red-500">*</span></h3>
                                        <div className="flex bg-gray-100 p-1 rounded-lg gap-1">
                                            <button
                                                onClick={() => setFormData({ ...formData, promptType: 'text' })}
                                                className={`text-[10px] font-bold px-3 py-1.5 rounded-md transition-all ${formData.promptType === 'text' ? 'bg-white shadow text-black' : 'text-gray-500 hover:text-gray-700'}`}
                                            >
                                                Tt Text
                                            </button>
                                            <button
                                                onClick={() => {
                                                    setFormData({ ...formData, promptType: 'image' as const });
                                                    setPromptPreview(false);
                                                }}
                                                className={`text-[10px] font-bold px-3 py-1.5 rounded-md transition-all ${formData.promptType === 'image' ? 'bg-white shadow text-black' : 'text-gray-500 hover:text-gray-700'}`}
                                            >
                                                Image
                                            </button>
                                            {formData.promptType === 'text' && (
                                                <>
                                                    <div className="w-px bg-gray-300 my-1 mx-1"></div>
                                                    <button
                                                        onClick={() => setPromptPreview(!promptPreview)}
                                                        className={`text-[10px] font-bold px-3 py-1.5 rounded-md transition-all flex items-center gap-1 ${promptPreview ? 'bg-black text-white' : 'text-gray-500 hover:text-gray-700'}`}
                                                    >
                                                        <span className="material-symbols-outlined text-[14px]">{promptPreview ? 'visibility_off' : 'visibility'}</span>
                                                        {promptPreview ? 'Edit' : 'Preview'}
                                                    </button>
                                                </>
                                            )}
                                        </div>
                                    </div>
                                    <div className={`
                                    bg-white border rounded-2xl p-1 shadow-sm overflow-hidden group transition-all
                                    ${formData.promptType === 'text' && !promptPreview ? 'focus-within:border-yellow-400 focus-within:ring-2 focus-within:ring-yellow-400' : ''}
                                    ${'border-gray-200 hover:border-gray-300'}
                                `}>

                                        {formData.promptType === 'text' ? (
                                            promptPreview ? (
                                                <div className="font-math p-6 min-h-[160px] cursor-pointer hover:bg-gray-50 transition-colors" onClick={() => setPromptPreview(false)}>
                                                    <MathRenderer content={JSON.stringify([formData.prompt, formData.promptImage].filter(Boolean))} />
                                                    <div className="mt-4 text-xs text-center text-gray-400 font-medium">Click to edit</div>
                                                </div>
                                            ) : (
                                                <div className="flex flex-col">
                                                    <MathToolbar
                                                        onInsert={(text, cursorBack) => {
                                                            const el = document.getElementById('prompt-textarea') as HTMLTextAreaElement;
                                                            if (el) {
                                                                const start = el.selectionStart;
                                                                const end = el.selectionEnd;
                                                                const val = formData.prompt;
                                                                const before = val.substring(0, start);
                                                                const after = val.substring(end);
                                                                const newVal = before + text + after;
                                                                setFormData({ ...formData, prompt: newVal });
                                                                // Defer focus restoration
                                                                setTimeout(() => {
                                                                    el.focus();
                                                                    el.setSelectionRange(start + text.length - cursorBack, start + text.length - cursorBack);
                                                                }, 0);
                                                            } else {
                                                                // Fallback if ref missing
                                                                setFormData({ ...formData, prompt: formData.prompt + text });
                                                            }
                                                        }}
                                                        onImageUpload={async (file) => {
                                                            try {
                                                                const fileExt = file.name.split('.').pop();
                                                                const fileName = `${Date.now()}_${Math.random().toString(36).substring(7)}.${fileExt}`;
                                                                const filePath = `mixed_content/${fileName}`;

                                                                showToast('Uploading image...', 'info');

                                                                const { error: uploadError } = await supabase.storage
                                                                    .from('images')
                                                                    .upload(filePath, file);

                                                                if (uploadError) throw uploadError;

                                                                const { data } = supabase.storage
                                                                    .from('images')
                                                                    .getPublicUrl(filePath);

                                                                // Update promptImage state directly
                                                                setFormData(prev => ({
                                                                    ...prev,
                                                                    promptImage: data.publicUrl,
                                                                    promptType: 'image' // Switch to image tab so user sees it
                                                                }));

                                                                showToast('Image uploaded! Switched to Image tab.', 'success');
                                                            } catch (err: any) {
                                                                console.error('Toolbar upload failed:', err);
                                                                showToast(`Upload failed: ${err.message}`, 'error');
                                                            }
                                                        }}
                                                    />
                                                    <textarea
                                                        id="prompt-textarea"
                                                        value={formData.prompt}
                                                        onChange={e => setFormData({ ...formData, prompt: e.target.value })}
                                                        placeholder="Enter prompt... Use the toolbar or drop images to insert."
                                                        className="w-full p-6 min-h-[160px] outline-none text-base font-medium text-text-main resize-none bg-transparent border-none focus:ring-0 focus:border-none focus:outline-none placeholder:text-gray-400 font-mono"
                                                        onDragOver={(e) => {
                                                            e.preventDefault();
                                                            e.stopPropagation();
                                                        }}
                                                        onDrop={async (e) => {
                                                            e.preventDefault();
                                                            e.stopPropagation();

                                                            const files = Array.from(e.dataTransfer.files).filter(f => f.type.startsWith('image/'));
                                                            if (files.length === 0) return;

                                                            // Only take the first image for now since we have a single promptImage field
                                                            // Or if multiple, maybe just take the last one? Ideally warn user.
                                                            const file = files[0];

                                                            showToast(`Uploading image...`, 'info');

                                                            try {
                                                                const fileExt = file.name.split('.').pop();
                                                                const fileName = `${Date.now()}_${Math.random().toString(36).substring(7)}.${fileExt}`;
                                                                const filePath = `mixed_content/${fileName}`;

                                                                const { error: uploadError } = await supabase.storage
                                                                    .from('images')
                                                                    .upload(filePath, file);

                                                                if (uploadError) throw uploadError;

                                                                const { data } = supabase.storage
                                                                    .from('images')
                                                                    .getPublicUrl(filePath);

                                                                // Update promptImage state directly and switch tab
                                                                setFormData(prev => ({
                                                                    ...prev,
                                                                    promptImage: data.publicUrl,
                                                                    promptType: 'image'
                                                                }));

                                                                showToast('Image uploaded! Switched to Image tab.', 'success');

                                                            } catch (err: any) {
                                                                console.error('Drop upload failed:', err);
                                                                showToast(`Upload failed: ${err.message}`, 'error');
                                                            }
                                                        }}
                                                    />
                                                    <div className="px-4 pb-2 text-[10px] text-gray-400">
                                                        <span className="font-bold text-yellow-600">TIP:</span> Wrap math in <code className="bg-gray-100 px-1 rounded">$</code> (inline) or <code className="bg-gray-100 px-1 rounded">$$</code> (block). Example: <code className="bg-gray-100 px-1 rounded">{'$\\frac{1}{2}$'}</code>
                                                    </div>
                                                </div>
                                            )
                                        ) : (
                                            <div className="p-4">
                                                <ImageUploader value={formData.promptImage || ''} onChange={v => setFormData({ ...formData, promptImage: v })} />
                                            </div>
                                        )}
                                    </div>
                                </div>

                                {/* Options */}
                                {formData.type === 'MCQ' && (
                                    <div>
                                        <h3 className="text-xs font-bold text-gray-400 uppercase tracking-wider mb-4">Answer Options <span className="text-red-500">*</span></h3>
                                        <div className="space-y-4">
                                            {formData.options.map((opt, idx) => (
                                                <div key={idx} className="bg-white border border-gray-200 rounded-2xl p-6 shadow-sm focus-within:border-yellow-400 focus-within:ring-1 focus-within:ring-yellow-400 transition-all">
                                                    <div className="flex gap-4 mb-4">
                                                        <button
                                                            onClick={() => setFormData({ ...formData, correctOptionLabel: opt.label || String.fromCharCode(65 + idx) })}
                                                            className={`w-12 h-12 rounded-full flex items-center justify-center font-black text-xl flex-shrink-0 transition-all ${formData.correctOptionLabel === (opt.label || String.fromCharCode(65 + idx)) ? 'bg-green-500 text-white shadow-lg shadow-green-500/30' : 'bg-gray-100 text-gray-500 hover:bg-gray-200'}`}
                                                        >
                                                            {opt.label || String.fromCharCode(65 + idx)}
                                                        </button>
                                                        <div className="flex-1 space-y-4">
                                                            {/* Option Content Header */}
                                                            <div className="flex flex-wrap justify-between items-center bg-gray-50 rounded-lg p-1.5 border border-gray-100 gap-2">
                                                                <span className="text-[10px] font-bold text-gray-400 px-2 uppercase tracking-wider whitespace-nowrap">Option {opt.label || String.fromCharCode(65 + idx)} Content</span>
                                                                <div className="flex gap-1 shrink-0">
                                                                    <button onClick={() => {
                                                                        const ops = [...formData.options]; ops[idx].type = 'text'; setFormData({ ...formData, options: ops });
                                                                    }} className={`text-[10px] font-bold px-2.5 py-1 rounded-md transition-all whitespace-nowrap ${opt.type === 'text' ? 'bg-white shadow-sm text-black' : 'text-gray-400 hover:text-gray-600'}`}>Text</button>
                                                                    <button onClick={() => {
                                                                        const ops = [...formData.options];
                                                                        ops[idx].type = 'image';
                                                                        setFormData({ ...formData, options: ops });
                                                                        setOptionPreviews(prev => ({ ...prev, [idx]: false }));
                                                                    }} className={`text-[10px] font-bold px-2.5 py-1 rounded-md transition-all whitespace-nowrap ${opt.type === 'image' ? 'bg-white shadow-sm text-black' : 'text-gray-400 hover:text-gray-600'}`}>Image</button>

                                                                    {opt.type === 'text' && (
                                                                        <>
                                                                            <div className="w-px bg-gray-300 my-1 mx-1"></div>
                                                                            <button
                                                                                onClick={() => setOptionPreviews(prev => ({ ...prev, [idx]: !prev[idx] }))}
                                                                                className={`text-[10px] font-bold px-2.5 py-1 rounded-md transition-all flex items-center gap-1 whitespace-nowrap ${optionPreviews[idx] ? 'bg-black text-white' : 'text-gray-400 hover:text-gray-600'}`}
                                                                            >
                                                                                <span className="material-symbols-outlined text-[14px]">{optionPreviews[idx] ? 'visibility_off' : 'visibility'}</span>
                                                                                {optionPreviews[idx] ? 'Edit' : 'Preview'}
                                                                            </button>
                                                                        </>
                                                                    )}
                                                                </div>
                                                            </div>

                                                            {/* Option Input */}
                                                            {opt.type === 'text' ? (
                                                                optionPreviews[idx] ? (
                                                                    <div
                                                                        className="font-math w-full p-4 bg-gray-50 rounded-xl border border-transparent hover:bg-white hover:border-gray-200 transition-all cursor-pointer min-h-[58px] flex items-center"
                                                                        onClick={() => setOptionPreviews(prev => ({ ...prev, [idx]: false }))}
                                                                    >
                                                                        <MathRenderer content={opt.value} />
                                                                    </div>
                                                                ) : (
                                                                    <input
                                                                        value={opt.value}
                                                                        onChange={e => {
                                                                            const ops = [...formData.options];
                                                                            ops[idx].value = e.target.value;
                                                                            setFormData({ ...formData, options: ops });
                                                                        }}
                                                                        placeholder={`Enter Option ${opt.label || String.fromCharCode(65 + idx)} content...`}
                                                                        className="w-full p-4 bg-gray-50 rounded-xl text-base font-bold outline-none border border-transparent focus:bg-white focus:border-yellow-400 transition-all font-mono"
                                                                    />
                                                                )
                                                            ) : (
                                                                <ImageUploader value={opt.value} onChange={v => {
                                                                    const ops = [...formData.options];
                                                                    ops[idx].value = v;
                                                                    setFormData({ ...formData, options: ops });
                                                                }} heightClass="h-32" />
                                                            )}

                                                            {/* Explanation */}
                                                            <div>
                                                                <div className="flex justify-between items-center mb-2">
                                                                    <label className="block text-[10px] font-bold text-gray-400 uppercase tracking-wider whitespace-nowrap">Explanation <span className="text-red-500">*</span></label>
                                                                    <div className="flex items-center gap-1 shrink-0">
                                                                        <InputTypeToggle
                                                                            type={opt.explanationType || 'text'}
                                                                            onChange={(t) => {
                                                                                const ops = [...formData.options];
                                                                                ops[idx].explanationType = t;
                                                                                setFormData({ ...formData, options: ops });
                                                                                // Reset preview when switching type
                                                                                setOptionExplPreviews(prev => ({ ...prev, [idx]: false }));
                                                                            }}
                                                                        />
                                                                        {(opt.explanationType || 'text') === 'text' && (
                                                                            <>
                                                                                <div className="w-px bg-gray-300 my-1 mx-1 h-5"></div>
                                                                                <button
                                                                                    onClick={() => setOptionExplPreviews(prev => ({ ...prev, [idx]: !prev[idx] }))}
                                                                                    className={`text-[10px] font-bold px-3 py-1 rounded-md transition-all flex items-center gap-1 ${optionExplPreviews[idx] ? 'bg-black text-white' : 'text-gray-400 hover:text-gray-600'}`}
                                                                                >
                                                                                    <span className="material-symbols-outlined text-[14px]">{optionExplPreviews[idx] ? 'visibility_off' : 'visibility'}</span>
                                                                                    {optionExplPreviews[idx] ? 'Edit' : 'Preview'}
                                                                                </button>
                                                                            </>
                                                                        )}
                                                                    </div>
                                                                </div>

                                                                {opt.explanationType === 'image' ? (
                                                                    <ImageUploader
                                                                        value={opt.explanation || ''}
                                                                        onChange={v => {
                                                                            const ops = [...formData.options];
                                                                            ops[idx].explanation = v;
                                                                            setFormData({ ...formData, options: ops });
                                                                        }}
                                                                        heightClass="h-24"
                                                                        placeholder="Upload Explanation Image"
                                                                    />
                                                                ) : (
                                                                    <div className="bg-white border border-gray-200 rounded-xl overflow-hidden transition-all focus-within:border-yellow-400 focus-within:ring-1 focus-within:ring-yellow-400">
                                                                        {optionExplPreviews[idx] ? (
                                                                            <div
                                                                                className="font-math w-full p-3 bg-gray-50 rounded-xl cursor-pointer hover:bg-white transition-all min-h-[80px]"
                                                                                onClick={() => setOptionExplPreviews(prev => ({ ...prev, [idx]: false }))}
                                                                            >
                                                                                <MathRenderer content={opt.explanation || ''} />
                                                                                <div className="mt-2 text-xs text-center text-gray-400 font-medium">Click to edit</div>
                                                                            </div>
                                                                        ) : (
                                                                            <textarea
                                                                                value={opt.explanation || ''}
                                                                                onChange={e => {
                                                                                    const ops = [...formData.options];
                                                                                    ops[idx].explanation = e.target.value;
                                                                                    setFormData({ ...formData, options: ops });
                                                                                }}
                                                                                placeholder={`Explain why Option ${opt.label || String.fromCharCode(65 + idx)} is ${formData.correctOptionLabel === (opt.label || String.fromCharCode(65 + idx)) ? 'correct' : 'incorrect'}...`}
                                                                                className="w-full p-3 text-sm font-medium outline-none transition-all resize-y min-h-[80px] border-none focus:ring-0 font-mono"
                                                                            />
                                                                        )}
                                                                    </div>
                                                                )}
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            ))}
                                        </div>
                                    </div>
                                )}

                                {/* General Explanation / Solution (For both MCQ and FRQ) */}
                                <div className="mb-8 mt-12">
                                    <div className="flex items-center justify-between mb-2">
                                        <h3 className="text-xs font-bold text-gray-400 uppercase tracking-wider">
                                            {formData.type === 'MCQ' ? 'General Solution / Logic' : 'Suggested Solution / Marking Guide'} <span className="text-red-500">*</span>
                                        </h3>
                                        <InputTypeToggle
                                            type={formData.explanationType || 'text'}
                                            onChange={(type) => {
                                                setFormData({ ...formData, explanationType: type });
                                                setExplanationPreview(false);
                                            }}
                                        />
                                        {formData.explanationType === 'text' && (
                                            <button
                                                onClick={() => setExplanationPreview(!explanationPreview)}
                                                className={`ml-2 text-[10px] font-bold px-3 py-1.5 rounded-md transition-all flex items-center gap-1 ${explanationPreview ? 'bg-black text-white' : 'bg-gray-100 text-gray-500 hover:text-gray-700'}`}
                                            >
                                                <span className="material-symbols-outlined text-[14px]">{explanationPreview ? 'visibility_off' : 'visibility'}</span>
                                                {explanationPreview ? 'Edit' : 'Preview'}
                                            </button>
                                        )}
                                    </div>

                                    {formData.explanationType === 'image' ? (
                                        <ImageUploader
                                            value={formData.explanation}
                                            onChange={v => setFormData({ ...formData, explanation: v })}
                                            heightClass="h-48"
                                            placeholder="Click to Upload Solution Image"
                                        />
                                    ) : (
                                        <div className="bg-white border border-gray-200 rounded-2xl p-1 shadow-sm overflow-hidden group hover:border-gray-300 transition-all focus-within:border-yellow-400 focus-within:ring-1 focus-within:ring-yellow-400">
                                            {explanationPreview ? (
                                                <div className="font-math p-6 min-h-[120px] cursor-pointer hover:bg-gray-50 transition-colors" onClick={() => setExplanationPreview(false)}>
                                                    <MathRenderer content={formData.explanation || ''} />
                                                    <div className="mt-4 text-xs text-center text-gray-400 font-medium">Click to edit</div>
                                                </div>
                                            ) : (
                                                <textarea
                                                    value={formData.explanation || ''}
                                                    onChange={e => setFormData({ ...formData, explanation: e.target.value })}
                                                    placeholder={formData.type === 'MCQ'
                                                        ? "Explain the overall logic for the correct answer..."
                                                        : "Provide the grading rubric, key points, or full solution..."}
                                                    className="w-full p-6 min-h-[120px] outline-none text-sm font-medium text-text-main resize-none bg-transparent border-none focus:ring-0 focus:border-none focus:outline-none font-mono"
                                                />
                                            )}
                                        </div>
                                    )}
                                </div>
                            </div>
                        )}
                    </div>
                </div>
            </div>
        </div>
    );
};