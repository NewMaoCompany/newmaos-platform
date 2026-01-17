import React, { useState, useMemo, useEffect, useRef } from 'react';
import { useApp } from '../AppContext';
import { Navbar } from '../components/Navbar';
import { Question, CourseType, DifficultyLevel, QuestionCourseType } from '../types';
import { COURSE_TOPICS, SKILL_TAGS, ERROR_TAGS, COURSE_CONTENT_DATA } from '../constants';

// --- Types for Form State ---
interface FormOptionState {
    id?: string;
    label: string;
    value: string;
    errorTagId?: string;
    type: 'text' | 'image';
    explanation: string;  // Per-option explanation
}

interface FormState extends Omit<Question, 'id' | 'options' | 'correctOptionId' | 'course'> {
    id?: string;
    course: QuestionCourseType;
    options: FormOptionState[];
    correctOptionLabel: string;
    topicId: string;  // FK to topic_content.id
    primarySkillId: string;  // Required primary skill
    supportingSkillIds: string[];  // Optional supporting skills
    promptType: 'text' | 'image';
}

const InputTypeToggle = ({ type, onChange }: { type: 'text' | 'image', onChange: (t: 'text' | 'image') => void }) => (
    <div className="flex bg-gray-100 dark:bg-white/5 p-1 rounded-lg shrink-0">
        <button
            type="button"
            onClick={() => onChange('text')}
            className={`px-3 py-1.5 text-xs font-bold rounded-md transition-all flex items-center gap-1 ${type === 'text' ? 'bg-white dark:bg-gray-700 shadow-sm text-black dark:text-white' : 'text-gray-500 hover:text-gray-700 dark:hover:text-gray-300'}`}
        >
            <span className="material-symbols-outlined text-[14px]">text_fields</span>
            Text
        </button>
        <button
            type="button"
            onClick={() => onChange('image')}
            className={`px-3 py-1.5 text-xs font-bold rounded-md transition-all flex items-center gap-1 ${type === 'image' ? 'bg-white dark:bg-gray-700 shadow-sm text-black dark:text-white' : 'text-gray-500 hover:text-gray-700 dark:hover:text-gray-300'}`}
        >
            <span className="material-symbols-outlined text-[14px]">image</span>
            Image
        </button>
    </div>
);

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
                className={`w-full text-left p-2 bg-gray-50 dark:bg-white/5 border border-gray-200 dark:border-gray-700 rounded-lg text-sm font-bold outline-none flex items-center justify-between transition-all ${isOpen ? 'ring-2 ring-yellow-400/50 border-yellow-400' : 'focus:border-yellow-400 focus:ring-2 focus:ring-yellow-400/20'}`}
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
                            className={`w-full text-left px-3 py-2.5 text-xs font-bold hover:bg-gray-50 dark:hover:bg-white/5 flex items-center gap-2 transition-colors border-b border-gray-50 dark:border-white/5 last:border-0 ${opt.value === value ? 'text-yellow-600 bg-yellow-50 dark:bg-yellow-400/10 dark:text-yellow-400' : 'text-text-main dark:text-gray-300'}`}
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
    const { topicContent, updateSection, getSectionsForTopic } = useApp();

    // Find content: Unit, SubTopic, or Unit Test (from sections table with fallback)
    const content = useMemo(() => {
        if (!unitId || !topicContent[unitId]) return null;
        const unit = topicContent[unitId];

        if (id === 'unit_test') {
            // Look for unit_test in sections first
            const sections = getSectionsForTopic(unitId);
            const unitTestSection = sections.find((s: any) => s.id === 'unit_test');
            if (unitTestSection) {
                return {
                    title: unitTestSection.title,
                    description: unitTestSection.description,
                    estimatedMinutes: unitTestSection.estimated_minutes || unitTestSection.estimatedMinutes || 45,
                    isUnitTest: true
                };
            }
            // Fallback to topicContent
            return {
                title: unit.unitTest?.title || 'Unit Test',
                description: unit.unitTest?.description || `Comprehensive assessment covering all topics in ${unit.title}.`,
                estimatedMinutes: unit.unitTest?.estimatedMinutes || 45,
                isUnitTest: true
            };
        }

        // Check if ID is the Unit itself
        if (id === unitId) return unit;

        // Check if ID is a SubTopic - use sections from DB with fallback
        const sections = getSectionsForTopic(unitId);
        const section = sections.find((s: any) => s.id === id);
        if (section) {
            return {
                id: section.id,
                title: section.title,
                description: section.description,
                estimatedMinutes: section.estimated_minutes || section.estimatedMinutes || 15,
                hasLesson: section.has_lesson !== false,
                hasPractice: section.has_practice !== false
            };
        }
        return null;
    }, [topicContent, unitId, id, getSectionsForTopic]);

    const [localTitle, setLocalTitle] = useState('');
    const [localDesc, setLocalDesc] = useState('');
    // Use number | string to allow empty input for better UX
    const [localTime, setLocalTime] = useState<number | string>(0);
    const [localHasLesson, setLocalHasLesson] = useState(true);
    const [localHasPractice, setLocalHasPractice] = useState(true);
    const [isTimeFocused, setIsTimeFocused] = useState(false); // Track focus for styling
    const [isSaving, setIsSaving] = useState(false);
    const [isSaved, setIsSaved] = useState(false); // Success indicator for main form
    const [showDeleteConfirm, setShowDeleteConfirm] = useState(false);

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

    const handleSave = async () => {
        setIsSaving(true);
        try {
            const updates: any = {
                title: localTitle,
                description: localDesc,
                estimated_minutes: localTime === '' ? 0 : Number(localTime)
            };

            // Availability flags only relevant for SubTopics, not Unit Test or Unit itself
            if (id !== 'unit_test' && id !== unitId) {
                updates.has_lesson = localHasLesson;
                updates.has_practice = localHasPractice;
            }

            // Call the new updateSection API to persist to Supabase
            await updateSection(unitId, id, updates);

            setIsSaved(true);
            setTimeout(() => setIsSaved(false), 2000);
        } catch (error) {
            console.error('Failed to save section:', error);
            alert('Failed to save. Please try again.');
        } finally {
            setIsSaving(false);
        }
    };

    if (!content) return <div>Topic not found</div>;

    const showTimeSettings = 'estimatedMinutes' in content;
    const showAvailabilitySettings = id !== 'unit_test' && id !== unitId && showTimeSettings;

    return (
        <div className="max-w-4xl mx-auto p-8 animate-fade-in">
            {/* Inline style to hide number spinners */}
            <style>{`
                input[type=number]::-webkit-inner-spin-button, 
                input[type=number]::-webkit-outer-spin-button { 
                    -webkit-appearance: none; 
                    margin: 0; 
                }
                input[type=number] {
                    -moz-appearance: textfield;
                }
            `}</style>

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

            <div className="bg-white dark:bg-surface-dark border border-gray-100 dark:border-gray-800 rounded-3xl p-8 shadow-sm space-y-6">
                <div className="space-y-2">
                    <label className="text-xs font-bold uppercase text-gray-400 tracking-wider">Title</label>
                    <input
                        type="text"
                        value={localTitle}
                        onChange={(e) => setLocalTitle(e.target.value)}
                        className="w-full p-4 rounded-xl border border-transparent bg-gray-50 dark:bg-white/5 outline-none focus:bg-white dark:focus:bg-black/20 focus:border-yellow-400 focus:ring-4 focus:ring-yellow-400/10 text-lg font-bold transition-all shadow-sm"
                    />
                </div>
                <div className="space-y-2">
                    <label className="text-xs font-bold uppercase text-gray-400 tracking-wider">Description</label>
                    <textarea
                        value={localDesc}
                        onChange={(e) => setLocalDesc(e.target.value)}
                        className="w-full p-4 rounded-xl border border-transparent bg-gray-50 dark:bg-white/5 outline-none focus:bg-white dark:focus:bg-black/20 focus:border-yellow-400 focus:ring-4 focus:ring-yellow-400/10 text-sm font-medium h-32 resize-none transition-all shadow-sm"
                    />
                </div>

                {showTimeSettings && (
                    <div className="grid grid-cols-1 md:grid-cols-2 gap-6 pt-4 border-t border-gray-100 dark:border-gray-800">
                        {/* Time Input - Manual only, strictly controlled to match screenshot style */}
                        <div className={`space-y-2 ${!showAvailabilitySettings ? 'md:col-span-2' : ''}`}>
                            <label className="text-xs font-bold uppercase text-gray-400 tracking-wider">Estimated Time (Min)</label>
                            <div className={`border-2 transition-all duration-300 rounded-xl overflow-hidden bg-white dark:bg-black/20 ${isTimeFocused || localTime ? 'border-yellow-400 ring-4 ring-yellow-400/10' : 'border-transparent bg-gray-50'}`}>
                                <input
                                    type="number"
                                    value={localTime}
                                    onFocus={() => setIsTimeFocused(true)}
                                    onBlur={() => setIsTimeFocused(false)}
                                    onChange={(e) => setLocalTime(e.target.value === '' ? '' : parseInt(e.target.value))}
                                    className="w-full p-4 bg-transparent outline-none border-none focus:border-none focus:ring-0 shadow-none text-sm font-bold appearance-none m-0 text-gray-900 dark:text-white placeholder-gray-400"
                                    placeholder="Enter minutes (e.g. 45)"
                                />
                            </div>
                        </div>

                        {showAvailabilitySettings && (
                            <div className="space-y-2">
                                <label className="text-xs font-bold uppercase text-gray-400 tracking-wider">Availability</label>
                                <div className="flex gap-4">
                                    <label className={`flex-1 p-4 rounded-xl border-2 cursor-pointer flex items-center justify-between transition-all shadow-sm group hover:scale-[1.02] ${localHasLesson ? 'border-yellow-400 bg-yellow-50 dark:bg-yellow-400/10 shadow-yellow-100 dark:shadow-none' : 'border-transparent bg-gray-50 dark:bg-white/5'}`}>
                                        <span className={`text-sm font-bold ${localHasLesson ? 'text-gray-900 dark:text-yellow-100' : 'text-gray-500'}`}>Lesson</span>
                                        <div className={`w-6 h-6 rounded flex items-center justify-center transition-colors ${localHasLesson ? 'bg-blue-600' : 'bg-gray-200 dark:bg-gray-700 group-hover:bg-gray-300'}`}>
                                            {localHasLesson && <span className="material-symbols-outlined text-white text-[16px] font-bold">check</span>}
                                        </div>
                                        <input type="checkbox" checked={localHasLesson} onChange={e => setLocalHasLesson(e.target.checked)} className="hidden" />
                                    </label>
                                    <label className={`flex-1 p-4 rounded-xl border-2 cursor-pointer flex items-center justify-between transition-all shadow-sm group hover:scale-[1.02] ${localHasPractice ? 'border-yellow-400 bg-yellow-50 dark:bg-yellow-400/10 shadow-yellow-100 dark:shadow-none' : 'border-transparent bg-gray-50 dark:bg-white/5'}`}>
                                        <span className={`text-sm font-bold ${localHasPractice ? 'text-gray-900 dark:text-yellow-100' : 'text-gray-500'}`}>Practice</span>
                                        <div className={`w-6 h-6 rounded flex items-center justify-center transition-colors ${localHasPractice ? 'bg-blue-600' : 'bg-gray-200 dark:bg-gray-700 group-hover:bg-gray-300'}`}>
                                            {localHasPractice && <span className="material-symbols-outlined text-white text-[16px] font-bold">check</span>}
                                        </div>
                                        <input type="checkbox" checked={localHasPractice} onChange={e => setLocalHasPractice(e.target.checked)} className="hidden" />
                                    </label>
                                </div>
                            </div>
                        )}
                    </div>
                )}

                <div className="flex gap-4 pt-4">
                    <button
                        onClick={handleSave}
                        className="flex-1 py-4 bg-gray-100 dark:bg-white/10 hover:bg-gray-200 dark:hover:bg-white/20 text-text-main dark:text-white rounded-xl font-bold transition-all flex items-center justify-center gap-2 border border-transparent active:scale-[0.98]"
                    >
                        {isSaved ? <span className="material-symbols-outlined text-green-500">check_circle</span> : <span className="material-symbols-outlined">save</span>}
                        {isSaved ? 'Saved' : 'Save Settings'}
                    </button>
                    <button
                        onClick={onAddQuestion}
                        className="flex-[2] py-4 bg-black dark:bg-white text-white dark:text-black hover:bg-gray-800 dark:hover:bg-gray-200 rounded-xl font-bold shadow-xl hover:shadow-2xl active:scale-[0.98] transition-all flex items-center justify-center gap-2"
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
    const { questions, addQuestion, updateQuestion, deleteQuestion, topicContent, skills } = useApp();

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
        topicId: '',
        subTopicId: '',
        type: 'MCQ',
        calculatorAllowed: false,
        difficulty: 3,
        targetTimeSeconds: 90,
        tolerance: 0.01,
        skillTags: [],
        errorTags: [],
        prompt: '',
        promptType: 'text',
        latex: '',
        options: [
            { label: 'A', value: '', errorTagId: '', type: 'text', explanation: '' },
            { label: 'B', value: '', errorTagId: '', type: 'text', explanation: '' },
            { label: 'C', value: '', errorTagId: '', type: 'text', explanation: '' },
            { label: 'D', value: '', errorTagId: '', type: 'text', explanation: '' },
        ],
        correctOptionLabel: 'A',
        explanation: '',
        microExplanations: {},
        recommendationReasons: [],
        primarySkillId: '',
        supportingSkillIds: []
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
            })),
            promptType: (q.prompt.startsWith('data:image') || q.prompt.startsWith('http')) ? 'image' : 'text'
        });
        setIsEditing(true);
    };

    const performSave = async (): Promise<boolean> => {
        // Strong validation
        const errors: string[] = [];
        if (!formData.prompt) errors.push('题干 (Prompt)');
        if (!formData.topicId) errors.push('Topic (单元)');
        if (!formData.subTopicId) errors.push('Chapter (小节)');
        if (!formData.primarySkillId) errors.push('Primary Skill (主技能)');
        if (!formData.correctOptionLabel) errors.push('Correct Option (正确答案)');

        if (errors.length > 0) {
            alert(`Cannot save: Missing required fields:\n• ${errors.join('\n• ')}`);
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
            correctOptionId: finalCorrectId,
            topicId: formData.topicId,
            primarySkillId: formData.primarySkillId,
            supportingSkillIds: formData.supportingSkillIds
        } as Question;

        let success = false;
        if (formData.id) {
            success = await updateQuestion(payload);
        } else {
            success = await addQuestion({ ...formData, correctOptionId: formData.correctOptionLabel });
        }
        return success;
    };

    const handleSave = async () => {
        setIsSaving(true);
        try {
            const success = await performSave();
            if (success) {
                // Show success state briefly
                // Note: We don't have a separate state for "success toast" yet, but we can reuse a button effect or just rely on the fact that isSaving stops.
                // For now, let's create a local success state for the button.
                setIsEditing(false); // Close editor on success? Or maybe just show success. 
                // Let's keep it open but show feedback.
                // Actually, previous behavior was keeping it open?
                // Step 2957 code: `if (performSave()) { }` - it did nothing on success except stop spinning.

                // Let's improve: Show success and maybe close if it was a create? 
                // For now, just stop spinning.
                alert('Saved successfully!'); // Explicit feedback
            }
        } catch (e) {
            console.error(e);
        } finally {
            setIsSaving(false);
        }
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

    const confirmNavigationAndSave = async () => {
        setIsSaving(true);
        try {
            const success = await performSave();
            if (success) {
                if (pendingNavTarget) {
                    setSelectedUnitId(pendingNavTarget.unitId);
                    setSelectedSubTopicId(pendingNavTarget.subTopicId);
                }
                setIsEditing(false);
                setShowNavConfirm(false);
                setPendingNavTarget(null);
            }
        } finally {
            setIsSaving(false);
        }
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
                                            {/* Use COURSE_CONTENT_DATA as fallback when DB subTopics is empty */}
                                            {(content.subTopics && content.subTopics.length > 0 ? content.subTopics : COURSE_CONTENT_DATA[unit.id]?.subTopics || []).map(sub => (
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
                                className="w-full p-2 pl-8 bg-gray-100 dark:bg-white/5 rounded-lg text-xs outline-none border border-transparent focus:border-yellow-400 transition-all"
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
                                </div>

                                {/* NEW: Topic, Chapter, and Skills Section */}
                                <div className="grid grid-cols-1 md:grid-cols-3 gap-6 mt-4">
                                    <div className="space-y-1">
                                        <label className="text-xs font-bold text-gray-500">Topic (Unit) <span className="text-red-500">*</span></label>
                                        <CustomSelect
                                            value={formData.topicId}
                                            onChange={(val: any) => {
                                                setFormData({ ...formData, topicId: val, subTopicId: '' });
                                            }}
                                            placeholder="Select Topic..."
                                            options={Object.entries(topicContent).map(([id, unit]: [string, any]) => ({
                                                value: id,
                                                label: unit.title
                                            }))}
                                        />
                                    </div>
                                    <div className="space-y-1">
                                        <label className="text-xs font-bold text-gray-500">Chapter (Section) <span className="text-red-500">*</span></label>
                                        <CustomSelect
                                            value={formData.subTopicId}
                                            onChange={(val: any) => setFormData({ ...formData, subTopicId: val })}
                                            placeholder="Select Chapter..."
                                            options={
                                                formData.topicId
                                                    ? ((topicContent[formData.topicId]?.subTopics?.length > 0
                                                        ? topicContent[formData.topicId].subTopics
                                                        : COURSE_CONTENT_DATA[formData.topicId]?.subTopics) || []).map((sub: any) => ({
                                                            value: sub.id,
                                                            label: sub.title || sub.id
                                                        }))
                                                    : []
                                            }
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

                                {/* Skills Section */}
                                <div className="grid grid-cols-1 md:grid-cols-2 gap-6 mt-4">
                                    <div className="space-y-1">
                                        <label className="text-xs font-bold text-gray-500">Primary Skill <span className="text-red-500">*</span></label>
                                        <CustomSelect
                                            value={formData.primarySkillId}
                                            onChange={(val: any) => setFormData({ ...formData, primarySkillId: val })}
                                            placeholder="Select Primary Skill..."
                                            options={skills.map(s => ({
                                                value: s.id,
                                                label: `${s.unit} - ${s.name}`
                                            }))}
                                        />
                                    </div>
                                    <div className="space-y-1">
                                        <label className="text-xs font-bold text-gray-500">Supporting Skills (Optional)</label>
                                        <div className="flex flex-wrap gap-2 p-2 bg-gray-50 dark:bg-white/5 border border-gray-200 dark:border-gray-700 rounded-xl min-h-[40px]">
                                            {formData.supportingSkillIds.map(skillId => {
                                                const skill = skills.find(s => s.id === skillId);
                                                return skill ? (
                                                    <span key={skillId} className="inline-flex items-center gap-1 px-2 py-1 bg-blue-100 text-blue-700 rounded-full text-xs font-medium">
                                                        {skill.name}
                                                        <button
                                                            type="button"
                                                            onClick={() => setFormData({ ...formData, supportingSkillIds: formData.supportingSkillIds.filter(id => id !== skillId) })}
                                                            className="hover:text-red-500"
                                                        >×</button>
                                                    </span>
                                                ) : null;
                                            })}
                                            <select
                                                value=""
                                                onChange={(e) => {
                                                    if (e.target.value && !formData.supportingSkillIds.includes(e.target.value) && e.target.value !== formData.primarySkillId) {
                                                        setFormData({ ...formData, supportingSkillIds: [...formData.supportingSkillIds, e.target.value] });
                                                    }
                                                }}
                                                className="flex-grow min-w-[150px] bg-transparent text-xs outline-none"
                                            >
                                                <option value="">+ Add supporting skill...</option>
                                                {skills.filter(s => s.id !== formData.primarySkillId && !formData.supportingSkillIds.includes(s.id)).map(s => (
                                                    <option key={s.id} value={s.id}>{s.unit} - {s.name}</option>
                                                ))}
                                            </select>
                                        </div>
                                    </div>
                                </div>
                            </section>

                            {/* Prompt Section */}
                            <section className="mb-8">
                                <div className="flex justify-between items-center mb-4">
                                    <h3 className="text-sm font-bold uppercase text-gray-400 tracking-wider">Question Prompt</h3>
                                    <InputTypeToggle
                                        type={formData.promptType}
                                        onChange={(t) => setFormData({ ...formData, promptType: t, prompt: '' })}
                                    />
                                </div>
                                {formData.promptType === 'image' ? (
                                    <ImageUploader
                                        value={formData.prompt}
                                        onChange={(val) => setFormData({ ...formData, prompt: val })}
                                        placeholder="Upload Question Image"
                                        heightClass="h-64"
                                    />
                                ) : (
                                    <textarea
                                        value={formData.prompt}
                                        onChange={(e) => setFormData({ ...formData, prompt: e.target.value })}
                                        placeholder="Enter the question prompt here..."
                                        className="w-full p-4 bg-gray-50 dark:bg-white/5 border border-gray-200 dark:border-gray-700 rounded-xl text-sm min-h-[120px] outline-none focus:border-yellow-400 focus:ring-1 focus:ring-yellow-400/20 transition-all font-medium"
                                    />
                                )}
                            </section>

                            <section className="mb-8">
                                <h3 className="text-sm font-bold uppercase text-gray-400 mb-4 tracking-wider">Answer Options</h3>
                                <div className="space-y-4">
                                    {formData.options.map((opt, idx) => (
                                        <div key={idx} className="p-4 bg-gray-50 dark:bg-white/5 rounded-xl border border-gray-200 dark:border-gray-700">
                                            <div className="flex items-start gap-3 mb-3">
                                                <button
                                                    type="button"
                                                    onClick={() => setFormData({ ...formData, correctOptionLabel: opt.label })}
                                                    className={`w-10 h-10 rounded-full flex items-center justify-center text-sm font-black transition-all shrink-0 mt-1 ${formData.correctOptionLabel === opt.label ? 'bg-green-500 text-white ring-2 ring-green-300' : 'bg-gray-100 dark:bg-white/10 text-gray-500'}`}
                                                >
                                                    {opt.label}
                                                </button>

                                                <div className="flex-grow space-y-2">
                                                    <div className="flex justify-end">
                                                        <InputTypeToggle
                                                            type={opt.type}
                                                            onChange={(t) => {
                                                                const newOptions = [...formData.options];
                                                                newOptions[idx] = { ...newOptions[idx], type: t, value: '' };
                                                                setFormData({ ...formData, options: newOptions });
                                                            }}
                                                        />
                                                    </div>

                                                    {opt.type === 'image' ? (
                                                        <ImageUploader
                                                            value={opt.value}
                                                            onChange={(val) => {
                                                                const newOptions = [...formData.options];
                                                                newOptions[idx] = { ...newOptions[idx], value: val };
                                                                setFormData({ ...formData, options: newOptions });
                                                            }}
                                                            placeholder={`Upload Image for Option ${opt.label}`}
                                                            heightClass="h-40"
                                                        />
                                                    ) : (
                                                        <input
                                                            type="text"
                                                            value={opt.value}
                                                            onChange={(e) => {
                                                                const newOptions = [...formData.options];
                                                                newOptions[idx] = { ...newOptions[idx], value: e.target.value };
                                                                setFormData({ ...formData, options: newOptions });
                                                            }}
                                                            placeholder={`Option ${opt.label} content...`}
                                                            className="w-full p-3 bg-white dark:bg-black/20 border border-gray-200 dark:border-gray-600 rounded-lg text-sm outline-none focus:border-yellow-400/50 focus:ring-1 focus:ring-yellow-400/20 transition-all font-medium"
                                                        />
                                                    )}
                                                </div>

                                                {formData.correctOptionLabel === opt.label && (
                                                    <span className="text-green-500 text-xs font-bold mt-3 shrink-0">✓ Correct</span>
                                                )}
                                            </div>
                                            <div className="ml-13">
                                                <label className="text-[10px] font-bold text-gray-400 uppercase mb-1 block">Explanation for {opt.label}</label>
                                                <textarea
                                                    value={opt.explanation || ''}
                                                    onChange={(e) => {
                                                        const newOptions = [...formData.options];
                                                        newOptions[idx] = { ...newOptions[idx], explanation: e.target.value };
                                                        setFormData({ ...formData, options: newOptions });
                                                    }}
                                                    placeholder={formData.correctOptionLabel === opt.label ? 'Explain why this is the correct answer...' : 'Explain why this option is incorrect...'}
                                                    className="w-full p-2 bg-white dark:bg-black/20 border border-gray-200 dark:border-gray-600 rounded-lg text-xs min-h-[60px] outline-none focus:border-yellow-400/50 focus:ring-1 focus:ring-yellow-400/20 transition-all"
                                                />
                                            </div>
                                        </div>
                                    ))}
                                </div>
                            </section>

                            {/* Explanation Section */}
                            <section className="mb-8">
                                <h3 className="text-sm font-bold uppercase text-gray-400 mb-4 tracking-wider">Explanation</h3>
                                <textarea
                                    value={formData.explanation}
                                    onChange={(e) => setFormData({ ...formData, explanation: e.target.value })}
                                    placeholder="Explain the solution step by step..."
                                    className="w-full p-4 bg-gray-50 dark:bg-white/5 border border-gray-200 dark:border-gray-700 rounded-xl text-sm min-h-[100px] outline-none focus:border-yellow-400 focus:ring-1 focus:ring-yellow-400/20 transition-all"
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