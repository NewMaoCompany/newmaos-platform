import React, { useState, useMemo, useEffect, useRef } from 'react';
import { useApp } from '../AppContext';
import { Navbar } from '../components/Navbar';
import { Question, CourseType, DifficultyLevel, QuestionCourseType } from '../types';
import { COURSE_TOPICS, SKILL_TAGS, ERROR_TAGS } from '../constants';

// --- Types for Form State ---
interface FormOptionState {
    id?: string;
    label: string;
    value: string;
    errorTagId?: string;
    type: 'text' | 'image';
}

interface FormState extends Omit<Question, 'id' | 'options' | 'correctOptionId' | 'course'> {
    id?: string;
    course: QuestionCourseType;
    options: FormOptionState[];
    correctOptionLabel: string;
}

// --- Custom Components ---

const ImageUploader = ({
    value,
    onChange,
    placeholder = "Click to Upload Image",
    className = "",
    heightClass = "h-64"
}: {
    value: string;
    onChange: (val: string) => void;
    placeholder?: string;
    className?: string;
    heightClass?: string;
}) => {
    const fileInputRef = useRef<HTMLInputElement>(null);

    const handleFile = (e: React.ChangeEvent<HTMLInputElement>) => {
        const file = e.target.files?.[0];
        if (file) {
            const reader = new FileReader();
            reader.onloadend = () => {
                onChange(reader.result as string);
            };
            reader.readAsDataURL(file);
        }
    };

    if (value) {
        return (
            <div className={`relative group overflow-hidden rounded-xl border border-gray-200 dark:border-gray-700 bg-gray-50 dark:bg-black/20 ${className} ${heightClass}`}>
                <img src={value} alt="Uploaded Content" className="w-full h-full object-cover" />
                <div className="absolute inset-0 bg-black/40 flex items-center justify-center opacity-0 group-hover:opacity-100 transition-opacity backdrop-blur-sm">
                    <button
                        type="button"
                        onClick={(e) => { e.stopPropagation(); onChange(''); }}
                        className="flex items-center gap-2 bg-red-500 text-white px-4 py-2 rounded-full font-bold shadow-lg hover:bg-red-600 transition-transform hover:scale-105"
                    >
                        <span className="material-symbols-outlined">delete</span>
                        Remove
                    </button>
                </div>
            </div>
        );
    }

    return (
        <div
            onClick={() => fileInputRef.current?.click()}
            className={`flex flex-col items-center justify-center border-2 border-dashed border-gray-300 dark:border-gray-700 rounded-xl cursor-pointer hover:border-primary hover:bg-gray-50 dark:hover:bg-white/5 transition-all text-gray-400 hover:text-primary group ${className} ${heightClass}`}
        >
            <div className="w-12 h-12 bg-gray-100 dark:bg-white/10 rounded-full flex items-center justify-center mb-3 group-hover:scale-110 transition-transform">
                <span className="material-symbols-outlined text-2xl group-hover:text-primary transition-colors">add_photo_alternate</span>
            </div>
            <span className="text-xs font-bold uppercase tracking-wider">{placeholder}</span>
            <input
                type="file"
                ref={fileInputRef}
                className="hidden"
                accept="image/*"
                onChange={handleFile}
            />
        </div>
    );
};

const CustomSelect = ({ value, onChange, options, placeholder = "Select...", className = "" }: {
    value: string;
    onChange: (value: string) => void;
    options: { value: string; label: string }[];
    placeholder?: string;
    className?: string;
}) => {
    const [isOpen, setIsOpen] = useState(false);
    const ref = useRef<HTMLDivElement>(null);

    useEffect(() => {
        const handleClickOutside = (event: MouseEvent) => {
            if (ref.current && !ref.current.contains(event.target as Node)) {
                setIsOpen(false);
            }
        };
        document.addEventListener('mousedown', handleClickOutside);
        return () => document.removeEventListener('mousedown', handleClickOutside);
    }, []);

    const selectedOption = options.find(o => o.value === value);

    return (
        <div className={`relative w-full ${className}`} ref={ref}>
            <button
                type="button"
                onClick={() => setIsOpen(!isOpen)}
                className={`w-full text-left p-2 bg-gray-50 dark:bg-white/5 border border-gray-200 dark:border-gray-700 rounded-lg text-sm font-bold outline-none focus:border-primary flex items-center justify-between transition-all ${isOpen ? 'ring-2 ring-primary/50 border-primary' : ''}`}
            >
                <span className={`truncate ${!selectedOption ? 'text-gray-400' : 'text-text-main dark:text-white'}`}>
                    {selectedOption ? selectedOption.label : placeholder}
                </span>
                <span className={`material-symbols-outlined text-gray-400 text-[18px] transition-transform duration-200 ${isOpen ? 'rotate-180' : ''}`}>
                    expand_more
                </span>
            </button>
            {isOpen && (
                <div className="absolute top-full left-0 mt-1 w-full bg-white dark:bg-[#2c2c2e] border border-gray-200 dark:border-gray-700 rounded-xl shadow-xl z-50 max-h-60 overflow-y-auto animate-fade-in-up origin-top">
                    {options.map((opt) => (
                        <button
                            key={opt.value}
                            type="button"
                            onClick={() => { onChange(opt.value); setIsOpen(false); }}
                            className={`w-full text-left px-3 py-2.5 text-xs font-bold hover:bg-gray-50 dark:hover:bg-white/5 flex items-center gap-2 transition-colors border-b border-gray-50 dark:border-white/5 last:border-0 ${opt.value === value ? 'text-primary bg-primary/5' : 'text-text-main dark:text-gray-300'}`}
                        >
                            <span className="w-4 flex items-center justify-center">
                                {opt.value === value && <span className="material-symbols-outlined text-[14px]">check</span>}
                            </span>
                            <span>{opt.label}</span>
                        </button>
                    ))}
                </div>
            )}
        </div>
    );
};

// --- Topic Settings Component ---
const TopicSettings = ({
    unitId,
    id,
    onAddQuestion
}: {
    unitId: string;
    id: string;
    onAddQuestion: () => void;
}) => {
    const { topicContent, updateTopic } = useApp();

    // Find content: Unit, SubTopic, or Unit Test
    const content = useMemo(() => {
        if (!unitId || !topicContent[unitId]) return null;
        const unit = topicContent[unitId];

        if (id === 'unit_test') {
            // Construct a unified shape for the editor
            return {
                title: unit.unitTest?.title || 'Unit Test',
                description: unit.unitTest?.description || `Comprehensive assessment covering all topics in ${unit.title}.`,
                estimatedMinutes: unit.unitTest?.estimatedMinutes || 45,
                isUnitTest: true
            };
        }

        // Check if ID is the Unit itself
        if (id === unitId) return unit;

        // Check if ID is a SubTopic
        return unit.subTopics.find(s => s.id === id);
    }, [topicContent, unitId, id]);

    const [localTitle, setLocalTitle] = useState('');
    const [localDesc, setLocalDesc] = useState('');
    // Use number | string to allow empty input for better UX
    const [localTime, setLocalTime] = useState<number | string>(0);
    const [localHasLesson, setLocalHasLesson] = useState(true);
    const [localHasPractice, setLocalHasPractice] = useState(true);

    const [isSaved, setIsSaved] = useState(false);

    useEffect(() => {
        if (content) {
            setLocalTitle(content.title);
            setLocalDesc(content.description);
            // Check for properties specific to SubTopics or Unit Tests
            if ('estimatedMinutes' in content) {
                setLocalTime((content as any).estimatedMinutes);
            }
            if ('hasLesson' in content) {
                setLocalHasLesson((content as any).hasLesson !== false);
            }
            if ('hasPractice' in content) {
                setLocalHasPractice((content as any).hasPractice !== false);
            }
        }
    }, [content, id]);

    const handleSave = () => {
        const updates: any = { title: localTitle, description: localDesc };

        const isTimeRelevant = 'estimatedMinutes' in (content || {});

        if (isTimeRelevant) {
            // Convert empty string back to 0
            updates.estimatedMinutes = localTime === '' ? 0 : Number(localTime);
        }

        // Availability flags only relevant for SubTopics, not Unit Test or Unit itself
        if (id !== 'unit_test' && id !== unitId && isTimeRelevant) {
            updates.hasLesson = localHasLesson;
            updates.hasPractice = localHasPractice;
        }

        // Use the updated updateTopic signature
        const subId = (id === 'unit_test' || id !== unitId) ? id : null;
        updateTopic(unitId, subId, updates);

        setIsSaved(true);
        setTimeout(() => setIsSaved(false), 2000);
    };

    if (!content) return <div>Topic not found</div>;

    const showTimeSettings = 'estimatedMinutes' in content;
    const showAvailabilitySettings = id !== 'unit_test' && id !== unitId && showTimeSettings;

    return (
        <div className="max-w-4xl mx-auto p-8 animate-fade-in">
            <div className="flex items-center gap-3 mb-6">
                <div className="w-12 h-12 bg-black dark:bg-white text-white dark:text-black rounded-2xl flex items-center justify-center shadow-lg">
                    <span className="material-symbols-outlined text-2xl">settings_applications</span>
                </div>
                <div>
                    <h2 className="text-2xl font-black text-text-main dark:text-white">
                        {id === 'unit_test' ? 'Unit Test Settings' : 'Chapter Settings'}
                    </h2>
                    <p className="text-sm text-gray-500">Configure metadata for this section.</p>
                </div>
            </div>

            <div className="bg-white dark:bg-surface-dark border border-gray-200 dark:border-gray-800 rounded-3xl p-8 shadow-sm space-y-6">
                <div className="space-y-2">
                    <label className="text-xs font-bold uppercase text-gray-400 tracking-wider">Title</label>
                    <input
                        type="text"
                        value={localTitle}
                        onChange={(e) => setLocalTitle(e.target.value)}
                        className="w-full p-4 rounded-xl border border-gray-200 dark:border-gray-700 bg-gray-50 dark:bg-white/5 outline-none focus:ring-2 focus:ring-primary/50 text-lg font-bold"
                    />
                </div>
                <div className="space-y-2">
                    <label className="text-xs font-bold uppercase text-gray-400 tracking-wider">Description</label>
                    <textarea
                        value={localDesc}
                        onChange={(e) => setLocalDesc(e.target.value)}
                        className="w-full p-4 rounded-xl border border-gray-200 dark:border-gray-700 bg-gray-50 dark:bg-white/5 outline-none focus:ring-2 focus:ring-primary/50 text-sm font-medium h-32 resize-none"
                    />
                </div>

                {showTimeSettings && (
                    <div className="grid grid-cols-1 md:grid-cols-2 gap-6 pt-4 border-t border-gray-100 dark:border-gray-800">
                        {/* Time Input - Manual only, strictly controlled to match screenshot style */}
                        <div className={`space-y-2 ${!showAvailabilitySettings ? 'md:col-span-2' : ''}`}>
                            <label className="text-xs font-bold uppercase text-gray-400 tracking-wider">Estimated Time (Min)</label>
                            <div className={`border border-primary/50 ring-2 ring-primary/10 rounded-xl overflow-hidden`}>
                                <input
                                    type="number"
                                    value={localTime}
                                    onChange={(e) => setLocalTime(e.target.value === '' ? '' : parseInt(e.target.value))}
                                    className="w-full p-4 bg-gray-50 dark:bg-white/5 outline-none text-sm font-bold appearance-none m-0"
                                    placeholder="Enter minutes (e.g. 45)"
                                />
                            </div>
                        </div>

                        {showAvailabilitySettings && (
                            <div className="space-y-2">
                                <label className="text-xs font-bold uppercase text-gray-400 tracking-wider">Availability</label>
                                <div className="flex gap-4">
                                    <label className={`flex-1 p-4 rounded-xl border cursor-pointer flex items-center justify-between transition-colors ${localHasLesson ? 'border-primary bg-primary/5' : 'border-gray-200 dark:border-gray-700 bg-gray-50 dark:bg-white/5'}`}>
                                        <span className="text-sm font-bold">Lesson</span>
                                        <input type="checkbox" checked={localHasLesson} onChange={e => setLocalHasLesson(e.target.checked)} className="w-5 h-5 accent-primary" />
                                    </label>
                                    <label className={`flex-1 p-4 rounded-xl border cursor-pointer flex items-center justify-between transition-colors ${localHasPractice ? 'border-primary bg-primary/5' : 'border-gray-200 dark:border-gray-700 bg-gray-50 dark:bg-white/5'}`}>
                                        <span className="text-sm font-bold">Practice</span>
                                        <input type="checkbox" checked={localHasPractice} onChange={e => setLocalHasPractice(e.target.checked)} className="w-5 h-5 accent-primary" />
                                    </label>
                                </div>
                            </div>
                        )}
                    </div>
                )}

                <div className="flex gap-4 pt-4">
                    <button
                        onClick={handleSave}
                        className="flex-1 py-4 bg-gray-100 dark:bg-white/10 hover:bg-gray-200 dark:hover:bg-white/20 text-text-main dark:text-white rounded-xl font-bold transition-all flex items-center justify-center gap-2"
                    >
                        {isSaved ? <span className="material-symbols-outlined">check</span> : <span className="material-symbols-outlined">save</span>}
                        {isSaved ? 'Saved' : 'Save Settings'}
                    </button>
                    <button
                        onClick={onAddQuestion}
                        className="flex-[2] py-4 bg-primary text-text-main rounded-xl font-bold shadow-lg hover:brightness-105 active:scale-[0.98] transition-all flex items-center justify-center gap-2"
                    >
                        <span className="material-symbols-outlined">add_circle</span>
                        Create Question for this Section
                    </button>
                </div>
            </div>
        </div>
    );
};

export const QuestionCreator = () => {
    const { questions, addQuestion, updateQuestion, deleteQuestion, topicContent } = useApp();

    // --- Layout State ---
    const [selectedCourse, setSelectedCourse] = useState<CourseType>('AB');
    const [selectedUnitId, setSelectedUnitId] = useState<string | null>(null);
    const [selectedSubTopicId, setSelectedSubTopicId] = useState<string | null>(null);
    const [filterDifficulty, setFilterDifficulty] = useState<number | null>(null);
    const [filterSearch, setFilterSearch] = useState('');

    // --- Editor State ---
    const [isEditing, setIsEditing] = useState(false);
    const [isSaving, setIsSaving] = useState(false);
    const [showDeleteConfirm, setShowDeleteConfirm] = useState(false);

    // --- Navigation Guard State ---
    const [showNavConfirm, setShowNavConfirm] = useState(false);
    const [pendingNavTarget, setPendingNavTarget] = useState<{ unitId: string | null, subTopicId: string | null } | null>(null);

    // --- Initial Form State ---
    const defaultForm: FormState = {
        course: 'Both',
        topic: '',
        subTopicId: '',
        type: 'MCQ',
        calculatorAllowed: false,
        difficulty: 3,
        targetTimeSeconds: 90,
        tolerance: 0.01,
        skillTags: [],
        errorTags: [],
        prompt: '',
        latex: '',
        options: [
            { label: 'A', value: '', errorTagId: '', type: 'text' },
            { label: 'B', value: '', errorTagId: '', type: 'text' },
            { label: 'C', value: '', errorTagId: '', type: 'text' },
            { label: 'D', value: '', errorTagId: '', type: 'text' },
        ],
        correctOptionLabel: 'A',
        explanation: '',
        microExplanations: {},
        recommendationReasons: []
    };

    const [formData, setFormData] = useState<FormState>(defaultForm);

    // --- Derived Data ---
    const courseUnits = COURSE_TOPICS[selectedCourse];

    const filteredQuestions = useMemo(() => {
        let matches = questions.filter(q => {
            if (selectedCourse === 'AB') return q.course === 'AB' || q.course === 'Both';
            if (selectedCourse === 'BC') return q.course === 'BC' || q.course === 'Both';
            return false;
        });

        if (selectedUnitId) {
            const cleanTopic = selectedUnitId.includes('_') ? selectedUnitId.split('_')[1] : selectedUnitId;
            matches = matches.filter(q => q.topic === cleanTopic || q.topic === selectedUnitId);
        }
        if (selectedSubTopicId) {
            matches = matches.filter(q => q.subTopicId === selectedSubTopicId);
        }
        if (filterDifficulty) {
            matches = matches.filter(q => q.difficulty === filterDifficulty);
        }

        if (filterSearch) {
            const searchTerms = filterSearch.toLowerCase().trim().split(' ').filter(t => t.length > 0);
            matches = matches.filter(q => {
                const corpus = [
                    q.prompt,
                    q.latex,
                    q.explanation,
                    q.id,
                    q.topic,
                    ...q.options.map(o => o.value),
                    ...q.options.map(o => o.label)
                ].join(' ').toLowerCase();
                return searchTerms.every(term => corpus.includes(term));
            });
        }
        return matches.reverse();
    }, [questions, selectedCourse, selectedUnitId, selectedSubTopicId, filterDifficulty, filterSearch]);

    // --- Handlers ---

    const handleCreateNew = () => {
        let initialTopic = '';
        if (selectedUnitId) {
            initialTopic = selectedUnitId.includes('_') ? selectedUnitId.split('_')[1] : selectedUnitId;
        }
        let defaultCourse: QuestionCourseType = 'Both';
        if (selectedCourse === 'AB') defaultCourse = 'Both';
        if (selectedUnitId?.includes('Unit9') || selectedUnitId?.includes('Series')) defaultCourse = 'BC';

        setFormData({
            ...defaultForm,
            course: defaultCourse,
            topic: initialTopic,
            subTopicId: selectedSubTopicId || ''
        });
        setIsEditing(true);
    };

    const handleSelectQuestion = (q: Question) => {
        let correctLabel = q.correctOptionId;
        if (q.type === 'MCQ') {
            const opt = q.options.find(o => o.id === q.correctOptionId);
            if (opt) correctLabel = opt.label;
        }
        setFormData({
            ...q,
            correctOptionLabel: correctLabel,
            options: q.options.map(o => ({
                ...o,
                errorTagId: o.errorTagId || '',
                type: (o.value.startsWith('data:image') || o.value.startsWith('http')) ? 'image' : 'text'
            }))
        });
        setIsEditing(true);
    };

    const performSave = (): boolean => {
        if (!formData.prompt || !formData.topic) {
            alert("Cannot save: Missing required fields (Prompt Image, Topic).");
            return false;
        }
        let finalCorrectId = formData.correctOptionLabel;
        if (formData.type === 'MCQ') {
            const match = formData.options.find(o => o.label === formData.correctOptionLabel);
            if (match && match.id) finalCorrectId = match.id;
        }

        const cleanOptions = formData.options.map(o => ({
            ...o,
            errorTagId: o.errorTagId === '' ? undefined : o.errorTagId
        }));

        const payload = {
            ...formData,
            id: formData.id,
            options: cleanOptions as any,
            correctOptionId: finalCorrectId
        } as Question;

        if (formData.id) {
            updateQuestion(payload);
        } else {
            addQuestion({ ...formData, correctOptionId: formData.correctOptionLabel });
        }
        return true;
    };

    const handleSave = () => {
        setIsSaving(true);
        setTimeout(() => {
            if (performSave()) { }
            setIsSaving(false);
        }, 500);
    };

    const handleCancel = () => {
        // If coming from settings, go back to settings view
        if (selectedSubTopicId || selectedUnitId) {
            setIsEditing(false);
        } else {
            setIsEditing(false);
            setFormData(defaultForm);
        }
    };

    const handleDelete = () => {
        if (formData.id) {
            deleteQuestion(formData.id);
            setShowDeleteConfirm(false);
            setIsEditing(false);
        }
    };

    const requestNavigation = (newUnitId: string | null, newSubTopicId: string | null) => {
        if (isEditing && formData.prompt) {
            setPendingNavTarget({ unitId: newUnitId, subTopicId: newSubTopicId });
            setShowNavConfirm(true);
        } else {
            // Direct navigation
            setSelectedUnitId(newUnitId);
            setSelectedSubTopicId(newSubTopicId);
            setIsEditing(false); // Reset editing state to show Topic Settings
        }
    };

    const confirmNavigationAndSave = () => {
        setIsSaving(true);
        setTimeout(() => {
            performSave();
            setIsSaving(false);
            if (pendingNavTarget) {
                setSelectedUnitId(pendingNavTarget.unitId);
                setSelectedSubTopicId(pendingNavTarget.subTopicId);
            }
            setIsEditing(false);
            setShowNavConfirm(false);
            setPendingNavTarget(null);
        }, 500);
    };

    const toggleTag = (arrayName: 'skillTags', value: string) => {
        setFormData(prev => {
            const arr = prev[arrayName] || [];
            if (arr.includes(value)) {
                return { ...prev, [arrayName]: arr.filter(v => v !== value) };
            } else {
                return { ...prev, [arrayName]: [...arr, value] };
            }
        });
    };

    return (
        <div className="min-h-screen bg-background-light dark:bg-background-dark text-text-main dark:text-gray-100 flex flex-col overflow-hidden">
            <Navbar />

            <div className="flex-grow flex h-[calc(100vh-64px)] overflow-hidden">

                {/* --- COL 1: COURSE STRUCTURE --- */}
                <aside className="w-80 bg-white dark:bg-surface-dark border-r border-gray-200 dark:border-gray-800 flex flex-col shrink-0 z-20">
                    <div className="p-4 border-b border-gray-200 dark:border-gray-800">
                        <h2 className="text-xs font-bold uppercase text-gray-400 mb-2">Select Course</h2>
                        <div className="flex bg-gray-100 dark:bg-white/5 p-1 rounded-lg">
                            <button onClick={() => setSelectedCourse('AB')} className={`flex-1 py-2 text-xs font-bold rounded-md transition-all ${selectedCourse === 'AB' ? 'bg-white dark:bg-gray-700 shadow-sm text-black dark:text-white' : 'text-gray-500'}`}>AP Calculus AB</button>
                            <button onClick={() => setSelectedCourse('BC')} className={`flex-1 py-2 text-xs font-bold rounded-md transition-all ${selectedCourse === 'BC' ? 'bg-white dark:bg-gray-700 shadow-sm text-black dark:text-white' : 'text-gray-500'}`}>AP Calculus BC</button>
                        </div>
                    </div>
                    <div className="flex-grow overflow-y-auto p-2">
                        {courseUnits.map(unit => {
                            const isSelected = selectedUnitId === unit.id;
                            const content = topicContent[unit.id]; // Dynamic Data
                            return (
                                <div key={unit.id} className="mb-1">
                                    <div
                                        onClick={() => requestNavigation(isSelected ? null : unit.id, null)}
                                        className={`flex items-center gap-2 p-3 rounded-lg cursor-pointer text-sm font-medium transition-colors ${isSelected ? 'bg-primary/10 text-text-main dark:text-white' : 'hover:bg-gray-50 dark:hover:bg-white/5 text-gray-600 dark:text-gray-400'}`}
                                    >
                                        <span className={`material-symbols-outlined shrink-0 text-[18px] ${isSelected ? 'text-primary' : 'text-gray-400'}`}>folder</span>
                                        <span className="font-bold text-xs leading-tight">{content?.title || unit.subject}</span>
                                    </div>
                                    {isSelected && content && (
                                        <div className="ml-3 mt-1 space-y-0.5 border-l-2 border-gray-100 dark:border-gray-800 pl-2">
                                            <div onClick={() => requestNavigation(selectedUnitId, 'unit_test')} className={`p-2 rounded text-[11px] cursor-pointer transition-all leading-tight flex items-center gap-2 ${selectedSubTopicId === 'unit_test' ? 'bg-black text-white dark:bg-white dark:text-black font-bold shadow-sm' : 'text-gray-500 hover:text-black dark:hover:text-white hover:bg-gray-50 dark:hover:bg-white/5'}`}>
                                                <span className="material-symbols-outlined text-[14px]">quiz</span>Unit Test
                                            </div>
                                            {content.subTopics.map(sub => (
                                                <div key={sub.id} onClick={() => requestNavigation(selectedUnitId, selectedSubTopicId === sub.id ? null : sub.id)} className={`p-2 rounded text-[11px] cursor-pointer transition-all leading-tight ${selectedSubTopicId === sub.id ? 'bg-black text-white dark:bg-white dark:text-black font-bold shadow-sm' : 'text-gray-500 hover:text-black dark:hover:text-white hover:bg-gray-50 dark:hover:bg-white/5'}`}>
                                                    {sub.title}
                                                </div>
                                            ))}
                                        </div>
                                    )}
                                </div>
                            );
                        })}
                    </div>
                </aside>

                {/* --- COL 2: QUESTION LIST --- */}
                <div className="w-72 bg-gray-50 dark:bg-black/20 border-r border-gray-200 dark:border-gray-800 flex flex-col shrink-0 z-10">
                    <div className="p-4 border-b border-gray-200 dark:border-gray-800 bg-white dark:bg-surface-dark">
                        <div className="flex justify-between items-center mb-3">
                            <h3 className="font-bold text-sm">Questions</h3>
                        </div>
                        <div className="relative">
                            <input
                                type="text"
                                placeholder="Deep search prompts, content, options..."
                                value={filterSearch}
                                onChange={(e) => setFilterSearch(e.target.value)}
                                className="w-full p-2 pl-8 bg-gray-100 dark:bg-white/5 rounded-lg text-xs outline-none border border-transparent focus:border-primary/50 transition-all"
                            />
                            <span className="material-symbols-outlined absolute left-2 top-1/2 -translate-y-1/2 text-[16px] text-gray-400">search</span>
                        </div>
                    </div>
                    <div className="flex-grow overflow-y-auto p-3 space-y-3">
                        {filteredQuestions.map(q => (
                            <div key={q.id} onClick={() => handleSelectQuestion(q)} className={`p-3 bg-white dark:bg-surface-dark rounded-xl border shadow-sm cursor-pointer hover:border-primary/50 transition-all group ${formData.id === q.id ? 'border-primary ring-1 ring-primary' : 'border-gray-200 dark:border-gray-800'}`}>
                                <div className="flex justify-between items-start mb-1">
                                    <span className={`text-[10px] font-bold truncate max-w-[120px] ${q.subTopicId === 'unit_test' ? 'text-primary' : 'text-gray-400'}`}>{q.subTopicId === 'unit_test' ? 'Unit Test' : (q.subTopicId || q.topic)}</span>
                                    <div className="flex items-center gap-1">
                                        <span className={`text-[9px] px-1 py-0.5 rounded font-black uppercase ${q.course === 'Both' ? 'bg-indigo-100 text-indigo-700' : 'bg-gray-100 text-gray-500'}`}>{q.course}</span>
                                        <span className={`text-[10px] px-1.5 py-0.5 rounded font-bold ${q.type === 'MCQ' ? 'bg-blue-50 text-blue-600' : 'bg-purple-50 text-purple-600'}`}>{q.type}</span>
                                    </div>
                                </div>
                                <div className="text-xs font-medium text-text-main dark:text-gray-200 line-clamp-2 mb-2">
                                    {q.prompt.startsWith('data:image') ? '[Image Question]' : q.prompt}
                                </div>
                            </div>
                        ))}
                    </div>
                </div>

                {/* --- COL 3: WORKSPACE --- */}
                <main className="flex-grow bg-white dark:bg-surface-dark overflow-y-auto">

                    {/* VIEW: QUESTION EDITOR */}
                    {isEditing ? (
                        <div className="max-w-4xl mx-auto p-8 pb-20">
                            {/* ... (Existing Editor JSX, same as before) ... */}
                            <div className="flex justify-between items-start mb-8 pb-6 border-b border-gray-100 dark:border-gray-800">
                                <div>
                                    <div className="flex items-center gap-2 mb-2">
                                        <span className={`px-2 py-0.5 rounded text-[10px] font-black uppercase ${formData.id ? 'bg-green-100 text-green-700' : 'bg-yellow-100 text-yellow-700'}`}>
                                            {formData.id ? 'Editing' : 'Drafting'}
                                        </span>
                                    </div>
                                    <h1 className="text-2xl font-black text-text-main dark:text-white">Question Editor</h1>
                                </div>
                                <div className="flex gap-3">
                                    {formData.id && (
                                        <button type="button" onClick={() => setShowDeleteConfirm(true)} className="px-4 py-2 text-red-500 hover:bg-red-50 dark:hover:bg-red-900/10 rounded-lg text-sm font-bold">Delete</button>
                                    )}
                                    <button type="button" onClick={handleCancel} className="px-4 py-2 bg-gray-100 hover:bg-gray-200 dark:bg-white/10 dark:hover:bg-white/20 text-text-main dark:text-white rounded-lg text-sm font-bold transition-all">Cancel</button>
                                    <button type="button" onClick={handleSave} disabled={isSaving} className="px-6 py-2 bg-primary hover:bg-primary-hover text-text-main rounded-lg text-sm font-bold shadow-md flex items-center gap-2">
                                        {isSaving && <span className="material-symbols-outlined text-sm animate-spin">progress_activity</span>} Save
                                    </button>
                                </div>
                            </div>

                            <section className="mb-8">
                                <h3 className="text-sm font-bold uppercase text-gray-400 mb-4 tracking-wider">Classification & Metadata</h3>
                                <div className="grid grid-cols-1 md:grid-cols-4 gap-6 mb-4">
                                    <div className="space-y-1">
                                        <label className="text-xs font-bold text-gray-500">Target Course(s)</label>
                                        <CustomSelect
                                            value={formData.course}
                                            onChange={(val: any) => setFormData({ ...formData, course: val })}
                                            options={[
                                                { value: "Both", label: "Both (AB & BC)" },
                                                { value: "AB", label: "AB Only" },
                                                { value: "BC", label: "BC Only" }
                                            ]}
                                        />
                                    </div>
                                    <div className="space-y-1">
                                        <label className="text-xs font-bold text-gray-500">Question Type</label>
                                        <CustomSelect
                                            value={formData.type}
                                            onChange={(val: any) => setFormData({ ...formData, type: val })}
                                            options={[
                                                { value: "MCQ", label: "Multiple Choice" },
                                                { value: "Numeric", label: "Numeric Entry" },
                                                { value: "FRQ", label: "Free Response" }
                                            ]}
                                        />
                                    </div>
                                    <div className="space-y-1">
                                        <label className="text-xs font-bold text-gray-500">Calculator</label>
                                        <CustomSelect
                                            value={formData.calculatorAllowed ? "Yes" : "No"}
                                            onChange={(val: any) => setFormData({ ...formData, calculatorAllowed: val === "Yes" })}
                                            options={[
                                                { value: "No", label: "Not Allowed" },
                                                { value: "Yes", label: "Allowed" }
                                            ]}
                                        />
                                    </div>
                                    <div className="space-y-1">
                                        <label className="text-xs font-bold text-gray-500">Difficulty (1-5)</label>
                                        <CustomSelect
                                            value={String(formData.difficulty)}
                                            onChange={(val: any) => setFormData({ ...formData, difficulty: Number(val) as DifficultyLevel })}
                                            options={[
                                                { value: "1", label: "1 - Easy" },
                                                { value: "2", label: "2 - Below Average" },
                                                { value: "3", label: "3 - Medium" },
                                                { value: "4", label: "4 - Above Average" },
                                                { value: "5", label: "5 - Hard" }
                                            ]}
                                        />
                                    </div>
                                </div>
                            </section>

                            {/* Prompt Section */}
                            <section className="mb-8">
                                <h3 className="text-sm font-bold uppercase text-gray-400 mb-4 tracking-wider">Question Prompt</h3>
                                <textarea
                                    value={formData.prompt}
                                    onChange={(e) => setFormData({ ...formData, prompt: e.target.value })}
                                    placeholder="Enter the question prompt here..."
                                    className="w-full p-4 bg-gray-50 dark:bg-white/5 border border-gray-200 dark:border-gray-700 rounded-xl text-sm min-h-[120px] outline-none focus:border-primary transition-all"
                                />
                            </section>

                            {/* Options Section for MCQ */}
                            {formData.type === 'MCQ' && (
                                <section className="mb-8">
                                    <h3 className="text-sm font-bold uppercase text-gray-400 mb-4 tracking-wider">Answer Options</h3>
                                    <div className="space-y-3">
                                        {formData.options.map((opt, idx) => (
                                            <div key={idx} className="flex items-center gap-3">
                                                <button
                                                    type="button"
                                                    onClick={() => setFormData({ ...formData, correctOptionLabel: opt.label })}
                                                    className={`w-8 h-8 rounded-full flex items-center justify-center text-xs font-black transition-all ${formData.correctOptionLabel === opt.label ? 'bg-green-500 text-white' : 'bg-gray-100 dark:bg-white/10 text-gray-500'}`}
                                                >
                                                    {opt.label}
                                                </button>
                                                <input
                                                    type="text"
                                                    value={opt.value}
                                                    onChange={(e) => {
                                                        const newOptions = [...formData.options];
                                                        newOptions[idx] = { ...newOptions[idx], value: e.target.value };
                                                        setFormData({ ...formData, options: newOptions });
                                                    }}
                                                    placeholder={`Option ${opt.label}`}
                                                    className="flex-grow p-2 bg-gray-50 dark:bg-white/5 border border-gray-200 dark:border-gray-700 rounded-lg text-sm outline-none focus:border-primary transition-all"
                                                />
                                            </div>
                                        ))}
                                    </div>
                                </section>
                            )}

                            {/* Explanation Section */}
                            <section className="mb-8">
                                <h3 className="text-sm font-bold uppercase text-gray-400 mb-4 tracking-wider">Explanation</h3>
                                <textarea
                                    value={formData.explanation}
                                    onChange={(e) => setFormData({ ...formData, explanation: e.target.value })}
                                    placeholder="Explain the solution step by step..."
                                    className="w-full p-4 bg-gray-50 dark:bg-white/5 border border-gray-200 dark:border-gray-700 rounded-xl text-sm min-h-[100px] outline-none focus:border-primary transition-all"
                                />
                            </section>
                        </div>
                    ) : (
                        /* VIEW: TOPIC SETTINGS */
                        selectedSubTopicId && (
                            <TopicSettings
                                unitId={selectedUnitId}
                                id={selectedSubTopicId}
                                onAddQuestion={handleCreateNew}
                            />
                        )
                    )}
                </main>
            </div>

            {/* Delete Confirmation Modal */}
            {showDeleteConfirm && (
                <div className="fixed inset-0 bg-black/50 flex items-center justify-center z-50 backdrop-blur-sm animate-fade-in">
                    <div className="bg-white dark:bg-surface-dark rounded-2xl p-6 max-w-sm w-full mx-4 shadow-2xl">
                        <h3 className="text-lg font-black text-text-main dark:text-white mb-2">Delete Question?</h3>
                        <p className="text-sm text-gray-500 mb-6">This action cannot be undone.</p>
                        <div className="flex gap-3 justify-end">
                            <button onClick={() => setShowDeleteConfirm(false)} className="px-4 py-2 bg-gray-100 dark:bg-white/10 text-text-main dark:text-white rounded-lg text-sm font-bold">Cancel</button>
                            <button onClick={handleDelete} className="px-4 py-2 bg-red-500 text-white rounded-lg text-sm font-bold hover:bg-red-600">Delete</button>
                        </div>
                    </div>
                </div>
            )}
        </div>
    );
};

export default QuestionCreator;