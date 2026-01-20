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
    // The following states are likely intended for a different component (e.g., QuestionCreator)
    // but are placed here based on the provided instruction snippet's context.
    // If this is incorrect, please provide the full context of the component where these states should reside.
    const [showDeleteConfirm, setShowDeleteConfirm] = useState(false);
    const [promptPreview, setPromptPreview] = useState(false);
    const [explanationPreview, setExplanationPreview] = useState(false);
    const [optionPreviews, setOptionPreviews] = useState<Record<number, boolean>>({});
    // const navigate = useNavigate(); // This line is commented out as useNavigate is not imported and likely belongs elsewhere.

    // Parse value into array of URLs
    const images: string[] = React.useMemo(() => {
        if (!value) return [];
        try {
            const parsed = JSON.parse(value);
            if (Array.isArray(parsed)) return parsed;
            return [value];
        } catch {
            return [value];
        }
    }, [value]);

    const uploadImages = async (files: File[]) => {
        setIsUploading(true);
        try {
            // Get auth token from Supabase session - prefer sb-* prefixed keys
            let token: string | null = null;
            for (let i = 0; i < localStorage.length; i++) {
                const key = localStorage.key(i);
                if (key && key.startsWith('sb-') && key.endsWith('-auth-token')) {
                    try {
                        const session = localStorage.getItem(key);
                        if (session) {
                            const parsed = JSON.parse(session);
                            if (parsed.access_token) {
                                token = parsed.access_token;
                                break;
                            }
                        }
                    } catch { continue; }
                }
            }

            if (!token) {
                console.error('No auth token found for image upload');
                alert('Please log in to upload images');
                return;
            }

            const uploadedUrls: string[] = [];

            // Upload sequentially
            for (const file of files) {
                const formData = new FormData();
                formData.append('image', file, 'upload.jpg');
                const apiBase = import.meta.env.VITE_API_URL || 'http://localhost:4000/api';

                const res = await fetch(`${apiBase}/upload/image`, {
                    method: 'POST',
                    headers: { 'Authorization': `Bearer ${token}` },
                    body: formData
                });

                if (!res.ok) {
                    console.error(`Failed to upload ${file.name}`);
                    continue;
                }
                const data = await res.json();
                uploadedUrls.push(data.url);
            }

            if (uploadedUrls.length > 0) {
                const newImages = [...images, ...uploadedUrls];
                // Store as JSON if multiple or strict consistency desired
                // Given existing single-string usage, we adapt:
                if (newImages.length === 1) {
                    onChange(newImages[0]);
                } else {
                    onChange(JSON.stringify(newImages));
                }
            }

        } catch (e) {
            console.error('Image upload failed:', e);
            alert('Image upload failed. Please try again.');
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
            <div className="flex-1 overflow-y-auto custom-scrollbar p-2 pb-20 space-y-2">
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
                                    // Also Select the Unit itself for "Unit Settings"
                                    onSelect(unit.id, null as any, content?.title || unit.subject);
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
                                    {subs.length > 0 ? (
                                        subs.map((sub: any) => {
                                            const isSelected = selectedTopicId === unit.id && selectedSubTopicId === sub.id;
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
                                                        {sub.title}
                                                    </div>
                                                </button>
                                            );
                                        })
                                    ) : (
                                        <div className="px-3 py-2 text-[10px] text-gray-400 italic">No chapters loaded</div>
                                    )}
                                </div>
                            )}
                        </div>
                    );
                })}
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
    const [deleteTargetId, setDeleteTargetId] = useState<string | null>(null);
    const [draggingId, setDraggingId] = useState<string | null>(null);
    const [localOrder, setLocalOrder] = useState<string[]>([]);

    const filtered = useMemo(() => {
        // Helper to strip course prefix (AB_, BC_, Both_, or ABBC_)
        const getBase = (id: string) => id.replace(/^(AB_|BC_|Both_|ABBC_)/, '');
        const selectedBase = getBase(selectedTopicId);

        return questions.filter(q => {
            // 1. Check Topic Match
            // Exact match OR Base match if question is shared
            const qBase = getBase(q.topic);
            const isTopicMatch = q.topic === selectedTopicId ||
                (q.course === 'Both' && qBase === selectedBase) ||
                (q as any).topicId === selectedTopicId; // Legacy fallback

            if (!isTopicMatch) return false;

            // 2. Check SubTopic Match (if selected)
            if (selectedSubTopicId) {
                // Special handling for Unit Tests which might have prefixes in DB (e.g. ABBC_Limits_unit_test)
                if (selectedSubTopicId === 'unit_test') {
                    return q.sectionId === 'unit_test' || q.sectionId?.endsWith('_unit_test') ||
                        q.subTopicId === 'unit_test' || q.subTopicId?.endsWith('_unit_test');
                }
                return q.sectionId === selectedSubTopicId || q.subTopicId === selectedSubTopicId;
            }

            return true;
        });
    }, [questions, selectedSubTopicId, selectedTopicId]);

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
        if (localOrder.length === 0) return filtered;

        const orderMap = new Map<string, number>(localOrder.map((id, i) => [id, i]));

        // Items in order array are sorted by index
        // Items NOT in order array (new ones) are appended at the end (idx = Infinity)
        // or we can fallback to filtered order for them
        return [...filtered].sort((a, b) => {
            const idxA = orderMap.has(a.id) ? orderMap.get(a.id)! : 9999999;
            const idxB = orderMap.has(b.id) ? orderMap.get(b.id)! : 9999999;

            if (idxA === idxB) return 0; // Maintain relative order if both new
            return idxA - idxB;
        });
    }, [filtered, localOrder]);

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

            <div className="w-80 border-r border-gray-200 h-full bg-white flex flex-col flex-shrink-0">
                <div className="p-4 border-b border-gray-100">
                    <p className="text-[12px] font-bold text-gray-900 mb-2">Questions ({displayQuestions.length})</p>
                    <div className="relative">
                        <span className="material-symbols-outlined absolute left-2 top-2 text-gray-400 text-sm">search</span>
                        <input
                            type="text"
                            placeholder="Deep search..."
                            className="w-full pl-8 pr-3 py-1.5 bg-gray-50 border border-gray-200 rounded-lg text-xs outline-none focus:border-yellow-400 transition-all"
                        />
                    </div>
                </div>

                <div className="flex-1 overflow-y-auto custom-scrollbar p-3 pb-20 space-y-3 bg-gray-50/50">
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
                                    } ${isDragging ? 'opacity-50 scale-95' : ''}`}
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
                                <div className="text-sm font-bold text-gray-800 line-clamp-2 mb-1">
                                    {q.title || `Question ${q.id.substr(0, 8)}`}
                                </div>
                                <div className="flex justify-between items-center mt-1">
                                    <div className="text-[10px] text-gray-400 font-mono">
                                        ID: {q.id ? q.id.slice(0, 5) : 'NEW'}...
                                    </div>
                                    <span className={`text-[9px] font-black px-1.5 py-0.5 rounded uppercase ${q.status === 'published' ? 'bg-green-100 text-green-700' : 'bg-gray-100 text-gray-500'
                                        }`}>
                                        {q.status === 'published' ? 'PUBLISHED' : 'DRAFT'}
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
        </>
    );
};

// --- Right Main Area ---

export const QuestionCreator = () => {
    const {
        questions, addQuestion, updateQuestion, deleteQuestion, topicContent, sections, updateSection, fetchSections, fetchQuestions, topicContent: rawTopicContent
    } = useApp();

    // -- State --
    const [activeCourse, setActiveCourse] = useState<CourseType>('AB');
    const [selectedTopicId, setSelectedTopicId] = useState<string>('ABBC_Limits'); // Default Unified ID
    const [selectedSubTopicId, setSelectedSubTopicId] = useState<string | null>('1.1');   // Default

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
        latex: '',
        options: [
            { label: 'A', value: '', type: 'image', explanation: '', explanationType: 'image' },
            { label: 'B', value: '', type: 'image', explanation: '', explanationType: 'image' },
            { label: 'C', value: '', type: 'image', explanation: '', explanationType: 'image' },
            { label: 'D', value: '', type: 'image', explanation: '', explanationType: 'image' }
        ],
        correctOptionLabel: 'A',
        explanation: '',
        recommendationReasons: [],
        primarySkillId: '',
        supportingSkillIds: [],
        promptType: 'image',
        source: 'self',
        status: 'published',
        version: 1,
        weightPrimary: 0.8,
        weightSupporting: 0.2,
        explanationType: 'image',
        errorPatternIds: []
    }), [selectedSubTopicId, selectedTopicId]);

    const [formData, setFormData] = useState<FormState>(defaultForm);
    const [isSaving, setIsSaving] = useState(false);

    // Preview States
    const [promptPreview, setPromptPreview] = useState(false);
    const [explanationPreview, setExplanationPreview] = useState(false);
    const [optionPreviews, setOptionPreviews] = useState<Record<number, boolean>>({});

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
        const sec = topicSecs.find((s: any) => s.id === selectedSubTopicId);

        if (sec) {
            setSectionSettings({
                ...sec,
                availability: {
                    lesson: sec.hasLesson !== false && sec.has_lesson !== false,
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
                id: selectedSubTopicId,
                title: staticSec?.title || '',
                description: staticSec?.description || '',
                description2: staticSec?.description2 || '',
                estimated_minutes: staticSec?.estimatedMinutes || 10,
                availability: {
                    lesson: staticSec?.hasLesson !== false,
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

    const handleSelectQuestion = (q: Question) => {
        // Derive correct label from ID
        const correctOpt = q.options.find(o => o.id === q.correctOptionId);
        const derivedLabel = correctOpt ? correctOpt.label : 'A';

        setFormData({
            ...defaultForm,
            ...q,
            correctOptionLabel: derivedLabel,
            // Map legacy fields
            options: q.options.map((o: any) => ({ ...o, type: o.type || 'text', explanation: o.explanation || '' }))
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

    const handleDeleteAllMetadata = async () => {
        if (!window.confirm("ARE YOU SURE? This will DELETE ALL SKILLS and ERROR TAGS from the database immediately. This cannot be undone.")) return;

        setIsResetting(true);
        try {
            await supabase.from('question_skills').delete().neq('question_id', '00000000-0000-0000-0000-000000000000');
            await supabase.from('question_error_patterns').delete().neq('question_id', '00000000-0000-0000-0000-000000000000');
            await supabase.from('user_skill_mastery').delete().neq('user_id', '00000000-0000-0000-0000-000000000000');
            await supabase.from('skills').delete().neq('id', '_');
            await supabase.from('error_tags').delete().neq('id', '_');

            showToast("All metadata deleted successfully from Supabase.", "success");
            setFetchedSkills([]);
            setFetchedErrors([]);
        } catch (e: any) {
            console.error(e);
            showToast(`Delete failed: ${e.message}`, 'error');
        } finally {
            setIsResetting(false);
        }
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

        if (errors.length > 0) {
            showToast(`Missing required fields: ${errors.join(', ')}`, 'error');
            return;
        }

        setIsSaving(true);
        try {
            // Dynamic Topic ID Calculation to handle shared/course-specific topics
            // 1. Get base topic (e.g. 'Limits' from 'AB_Limits')
            const baseTopicId = selectedTopicId.replace(/^(AB_|BC_|Both_)/, '');
            // 2. Determine correct prefix based on chosen course
            let prefix = 'AB_';
            if (formData.course === 'BC') prefix = 'BC_';
            else if (formData.course === 'Both') prefix = 'Both_';

            const calculatedTopicId = `${prefix}${baseTopicId}`;

            const payload = {
                ...formData,
                // Ensure correct topic identifiers for filtering
                topic: calculatedTopicId,       // e.g. 'Both_Limits' if course is Both
                topicId: calculatedTopicId,     // Redundant but explicit
                subTopicId: selectedSubTopicId,
                sectionId: selectedSubTopicId,
                correctOptionId: formData.correctOptionLabel, // Simplify for now
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
        } catch (e) {
            console.error(e);
            showToast('Failed to delete question.', 'error');
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
                await updateSection(selectedTopicId, selectedSubTopicId, {
                    title: sectionSettings.title,
                    description: sectionSettings.description,
                    description2: sectionSettings.description2,
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
        } catch (e) {
            console.error(e);
            setSaveStatus('error');
            setTimeout(() => setSaveStatus('idle'), 3000);
            showToast('Failed to save settings.', 'error');
        }
    };

    return (
        <div className="h-screen flex flex-col bg-white overflow-hidden">
            <Navbar />
            {/* Toast is now handled globally by ToastProvider */}

            <div className="flex-1 flex h-full">

                {/* 1. Navigation Sidebar */}
                <NavigationSidebar
                    activeCourse={activeCourse}
                    setActiveCourse={setActiveCourse}
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
                <div className="flex-1 h-full overflow-y-auto bg-gray-50 p-8 custom-scrollbar">

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
                                        value={sectionSettings.description2 || ''}
                                        onChange={e => setSectionSettings({ ...sectionSettings, description2: e.target.value })}
                                        className="w-full p-4 bg-gray-50 rounded-xl font-medium min-h-[100px] border-none focus:ring-2 focus:ring-yellow-400 resize-none"
                                        placeholder="Enter a more detailed description..."
                                    />
                                </div>

                                {sectionSettings.type !== 'UNIT' && (
                                    <div className="grid grid-cols-2 gap-8">
                                        <div>
                                            {/* Estimated Time Removed per User Request (Now calculated dynamically) */}
                                            {/* <label className="text-xs font-bold text-gray-400 uppercase tracking-wider mb-2 block">Estimated Time (Min)</label>
                                            <input ... /> */}
                                        </div>
                                        <div>
                                            <label className="text-xs font-bold text-gray-400 uppercase tracking-wider mb-2 block">Availability (Check to Enable)</label>
                                            <div className="flex gap-4">
                                                <div
                                                    className="flex-1 p-4 bg-yellow-50 border border-yellow-200 rounded-xl flex items-center justify-between cursor-pointer hover:bg-yellow-100 transition-colors"
                                                    onClick={() => setSectionSettings({ ...sectionSettings, availability: { ...sectionSettings.availability, lesson: !sectionSettings.availability.lesson } })}
                                                >
                                                    <span className="font-bold text-gray-800">Lesson</span>
                                                    <input
                                                        type="checkbox"
                                                        checked={sectionSettings.availability.lesson}
                                                        onChange={() => { }} // Handled by parent div
                                                        className="w-5 h-5 accent-black cursor-pointer"
                                                    />
                                                </div>
                                                <div
                                                    className="flex-1 p-4 bg-yellow-50 border border-yellow-200 rounded-xl flex items-center justify-between cursor-pointer hover:bg-yellow-100 transition-colors"
                                                    onClick={() => setSectionSettings({ ...sectionSettings, availability: { ...sectionSettings.availability, practice: !sectionSettings.availability.practice } })}
                                                >
                                                    <span className="font-bold text-gray-800">Practice</span>
                                                    <input
                                                        type="checkbox"
                                                        checked={sectionSettings.availability.practice}
                                                        onChange={() => { }} // Handled by parent div
                                                        className="w-5 h-5 accent-blue-600 cursor-pointer"
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
                                            px-8 py-4 font-bold rounded-xl transition-all flex items-center gap-2
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
                                                <span className="material-symbols-outlined animate-spin">refresh</span>
                                                Saving...
                                            </>
                                        ) : saveStatus === 'success' ? (
                                            <>
                                                <span className="material-symbols-outlined">check_circle</span>
                                                Saved!
                                            </>
                                        ) : (
                                            <>
                                                <span className="material-symbols-outlined">save</span>
                                                Save Settings
                                            </>
                                        )}
                                    </button>
                                    <button onClick={handleCreateQuestion} className="flex-1 px-8 py-4 bg-black text-white font-bold rounded-xl hover:scale-[1.02] transition-transform flex items-center justify-center gap-2 shadow-xl">
                                        <span className="material-symbols-outlined">add_circle</span>
                                        Create Question for this Section
                                    </button>
                                </div>
                            </div>
                        </div>
                    )}

                    {viewMode === 'editor' && (
                        <div className="max-w-4xl mx-auto pb-20">
                            {/* Editor Header */}
                            <div className="flex items-center justify-between mb-8">
                                <div>
                                    <div className={`inline-block px-3 py-1 text-[10px] font-black uppercase tracking-wider rounded-md mb-2 ${formData.status === 'published'
                                        ? 'bg-green-100 text-green-700'
                                        : 'bg-yellow-100 text-yellow-800'
                                        }`}>
                                        {formData.status === 'published' ? 'Published' : 'Drafting'}
                                    </div>
                                    <h1 className="text-3xl font-black text-gray-900">Question Editor</h1>
                                </div>
                                <div className="flex gap-3">
                                    <button
                                        onClick={() => setViewMode('settings')}
                                        className="px-6 py-2.5 font-bold text-gray-500 hover:bg-gray-100 rounded-xl transition-colors"
                                    >
                                        Cancel
                                    </button>
                                    {formData.id && (
                                        <button
                                            onClick={handleDeleteQuestion}
                                            disabled={isSaving}
                                            className="px-6 py-2.5 bg-red-50 hover:bg-red-100 text-red-600 font-bold rounded-xl transition-all flex items-center gap-2 disabled:opacity-50"
                                        >
                                            <span className="material-symbols-outlined text-lg">delete</span>
                                            Delete
                                        </button>
                                    )}
                                    <button
                                        onClick={handleSaveQuestion}
                                        disabled={isSaving}
                                        className="px-8 py-2.5 bg-yellow-400 hover:bg-yellow-500 text-black font-black rounded-xl shadow-lg shadow-yellow-400/20 transition-all flex items-center gap-2 disabled:opacity-50"
                                    >
                                        {isSaving ? 'Saving...' : 'Save'}
                                    </button>
                                </div>
                            </div>

                            {/* Metadata Grid */}
                            <div className="mb-8">
                                <div className="flex items-center justify-between mb-4">
                                    <h3 className="text-xs font-bold text-gray-400 uppercase tracking-wider">Classification & Metadata</h3>

                                    {/* RESET BUTTON for User Request */}
                                    <button
                                        onClick={handleDeleteAllMetadata}
                                        className="text-[10px] text-red-400 hover:text-red-600 underline font-medium"
                                        title="Clears all Skills and Error Tags from DB"
                                    >
                                        [DEV] Clear Supabase Metadata
                                    </button>
                                </div>

                                {/* Row 1: Name & Status */}
                                <div className="grid grid-cols-1 md:grid-cols-4 gap-4 mb-6">
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
                                <div className="grid grid-cols-1 md:grid-cols-2 gap-4 mb-4">
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
                                <div className="grid grid-cols-1 md:grid-cols-2 gap-4 mb-4">
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
                                <div className="grid grid-cols-1 md:grid-cols-2 gap-4 mb-4">
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
                                <div className="grid grid-cols-1 md:grid-cols-2 gap-4 mb-4">
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
                                <div className="grid grid-cols-1 md:grid-cols-2 gap-4 mb-4">
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
                                            <span className="truncate">{selectedSubTopicId}</span>
                                            <span className="material-symbols-outlined text-sm opacity-50">lock</span>
                                        </div>
                                    </div>
                                </div>

                                {/* Row 6: Source & Error Patterns */}
                                <div className="grid grid-cols-1 md:grid-cols-2 gap-4 mb-4">
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
                                            onClick={() => setFormData({ ...formData, promptType: 'image' })}
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
                                            <div className="p-6 min-h-[160px] cursor-pointer hover:bg-gray-50 transition-colors" onClick={() => setPromptPreview(false)}>
                                                <MathRenderer content={formData.prompt} />
                                                <div className="mt-4 text-xs text-center text-gray-400 font-medium">Click to edit</div>
                                            </div>
                                        ) : (
                                            <textarea
                                                value={formData.prompt}
                                                onChange={e => setFormData({ ...formData, prompt: e.target.value })}
                                                placeholder="Enter the question prompt here... (Supports LaTeX: $x^2$ or $$x^2$$)"
                                                className="w-full p-6 min-h-[160px] outline-none text-base font-medium text-text-main resize-none bg-transparent border-none focus:ring-0 focus:border-none focus:outline-none placeholder:text-gray-400 font-mono"
                                            />
                                        )
                                    ) : (
                                        <div className="p-4">
                                            <ImageUploader value={formData.prompt} onChange={v => setFormData({ ...formData, prompt: v })} />
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
                                                        onClick={() => setFormData({ ...formData, correctOptionLabel: opt.label })}
                                                        className={`w-12 h-12 rounded-full flex items-center justify-center font-black text-xl flex-shrink-0 ${formData.correctOptionLabel === opt.label ? 'bg-green-500 text-white shadow-lg shadow-green-500/30' : 'bg-gray-100 text-gray-400 hover:bg-gray-200'}`}
                                                    >
                                                        {opt.label}
                                                    </button>
                                                    <div className="flex-1 space-y-4">
                                                        {/* Option Content Header */}
                                                        <div className="flex justify-between items-center bg-gray-50 rounded-lg p-1.5 border border-gray-100">
                                                            <span className="text-[10px] font-bold text-gray-400 px-2 uppercase tracking-wider">Option Content</span>
                                                            <div className="flex gap-1">
                                                                <button onClick={() => {
                                                                    const ops = [...formData.options]; ops[idx].type = 'text'; setFormData({ ...formData, options: ops });
                                                                }} className={`text-[10px] font-bold px-3 py-1 rounded-md transition-all ${opt.type === 'text' ? 'bg-white shadow-sm text-black' : 'text-gray-400 hover:text-gray-600'}`}>Text</button>
                                                                <button onClick={() => {
                                                                    const ops = [...formData.options]; ops[idx].type = 'image'; setFormData({ ...formData, options: ops });
                                                                }} className={`text-[10px] font-bold px-3 py-1 rounded-md transition-all ${opt.type === 'image' ? 'bg-white shadow-sm text-black' : 'text-gray-400 hover:text-gray-600'}`}>Image</button>

                                                                {opt.type === 'text' && (
                                                                    <>
                                                                        <div className="w-px bg-gray-300 my-1 mx-1"></div>
                                                                        <button
                                                                            onClick={() => setOptionPreviews(prev => ({ ...prev, [idx]: !prev[idx] }))}
                                                                            className={`text-[10px] font-bold px-3 py-1 rounded-md transition-all flex items-center gap-1 ${optionPreviews[idx] ? 'bg-black text-white' : 'text-gray-400 hover:text-gray-600'}`}
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
                                                                    className="w-full p-4 bg-gray-50 rounded-xl border border-transparent hover:bg-white hover:border-gray-200 transition-all cursor-pointer min-h-[58px] flex items-center"
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
                                                                    placeholder={`Enter Option ${opt.label} content...`}
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
                                                        {/* Explanation */}
                                                        <div>
                                                            <div className="flex justify-between items-center mb-2">
                                                                <label className="block text-[10px] font-bold text-gray-400 uppercase tracking-wider">Explanation (Correct/Incorrect Reason) <span className="text-red-500">*</span></label>
                                                                <InputTypeToggle
                                                                    type={opt.explanationType || 'image'}
                                                                    onChange={(t) => {
                                                                        const ops = [...formData.options];
                                                                        ops[idx].explanationType = t;
                                                                        setFormData({ ...formData, options: ops });
                                                                    }}
                                                                />
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
                                                                <textarea
                                                                    value={opt.explanation || ''}
                                                                    onChange={e => {
                                                                        const ops = [...formData.options];
                                                                        ops[idx].explanation = e.target.value;
                                                                        setFormData({ ...formData, options: ops });
                                                                    }}
                                                                    placeholder={`Explain why Option ${opt.label} is ${formData.correctOptionLabel === opt.label ? 'correct' : 'incorrect'}...`}
                                                                    className="w-full p-3 bg-white border border-gray-200 rounded-xl text-sm font-medium outline-none focus:border-yellow-400 focus:ring-1 focus:ring-yellow-400 transition-all resize-y min-h-[80px]"
                                                                />
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
                                        type={formData.explanationType || 'image'}
                                        onChange={(type) => setFormData({ ...formData, explanationType: type })}
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
                                            <div className="p-6 min-h-[120px] cursor-pointer hover:bg-gray-50 transition-colors" onClick={() => setExplanationPreview(false)}>
                                                <MathRenderer content={formData.explanation || ''} block />
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
    );
};