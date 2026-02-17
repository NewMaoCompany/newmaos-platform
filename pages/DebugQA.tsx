import React, { useState, useEffect, useRef } from 'react';
import { supabase } from '../src/services/supabaseClient';
import { MathRenderer } from '../components/MathRenderer';
import { ErrorBoundary } from '../components/ErrorBoundary';
import { useNavigate } from 'react-router-dom';

export const DebugQA = () => {
    const navigate = useNavigate();
    const [questions, setQuestions] = useState<any[]>([]);
    const [currentIndex, setCurrentIndex] = useState(0);
    const [isRunning, setIsRunning] = useState(false);
    const [logs, setLogs] = useState<string[]>([]);
    const [failures, setFailures] = useState<any[]>([]);
    const [status, setStatus] = useState<'idle' | 'loading' | 'testing' | 'complete'>('idle');

    // Test State
    const [selectedOption, setSelectedOption] = useState<string | null>(null);
    const [isSubmitted, setIsSubmitted] = useState(false);

    useEffect(() => {
        fetchQuestions();
    }, []);

    const fetchQuestions = async () => {
        setStatus('loading');
        const { data, error } = await supabase
            .from('questions')
            .select('*')
            .order('id');

        if (error) {
            console.error(error);
            setLogs(prev => [...prev, `Error fetching questions: ${error.message}`]);
        } else {
            setQuestions(data || []);
            setLogs(prev => [...prev, `Loaded ${data?.length} questions.`]);
            setStatus('idle');
        }
    };

    const startQA = () => {
        if (questions.length === 0) return;
        setIsRunning(true);
        setCurrentIndex(0);
        setFailures([]);
        setLogs(prev => [...prev, 'Starting QA...']);
        setStatus('testing');
    };

    const stopQA = () => {
        setIsRunning(false);
        setStatus('idle');
        setLogs(prev => [...prev, 'QA Stopped by user.']);
    };

    // Automated Step Logic
    useEffect(() => {
        if (!isRunning || status !== 'testing') return;
        if (currentIndex >= questions.length) {
            setIsRunning(false);
            setStatus('complete');
            setLogs(prev => [...prev, 'QA Complete!', `Total Failures: ${failures.length}`]);
            return;
        }

        const question = questions[currentIndex];
        const step = async () => {
            try {
                // Reset state for new question - INSTANTLY SHOW EVERYTHING
                const firstOptionId = question.options?.[0]?.id || 'A';
                setSelectedOption(firstOptionId);
                setIsSubmitted(true); // Immediate reveal

                // Verify Rendering Quality
                // We wait a bit to ensure React has rendered the updates
                await new Promise(r => setTimeout(r, 50));

                const liveView = liveViewRef.current;

                // If liveView is not available (e.g. unmounted), stop safely
                if (!liveView) return;

                const explanationEl = liveView.querySelector('.mt-6'); // The common container for explanation

                // Check 1: Explanation Data Existence
                if (!question.explanation) {
                    setFailures(prev => [...prev, { id: question.id, reason: 'Missing Explanation Data' }]);
                    setLogs(prev => [...prev, `[FAIL] QID: ${question.id} - Missing explanation data`]);
                } else if (!explanationEl || !explanationEl.textContent?.trim()) {
                    setFailures(prev => [...prev, { id: question.id, reason: 'Explanation Render Failed (Empty)' }]);
                    setLogs(prev => [...prev, `[FAIL] QID: ${question.id} - Explanation Empty`]);
                } else {
                    // Check 2: Visual Rendering Errors (Red Text)
                    const katexErrors = liveView.querySelectorAll('.katex-error');
                    if (katexErrors.length > 0) {
                        const errorText = Array.from(katexErrors).map(e => e.getAttribute('title') || e.textContent).join('; ');
                        setFailures(prev => [...prev, { id: question.id, reason: `KaTeX Error: ${errorText}` }]);
                        setLogs(prev => [...prev, `[FAIL] QID: ${question.id} - KaTeX Error`]);
                    }

                    // Check 3: Raw LaTeX Leakage
                    // Strategy: Clone the node, remove all .katex elements, then check text content.
                    const clone = liveView.cloneNode(true) as HTMLElement;
                    const katexElements = clone.querySelectorAll('.katex');
                    katexElements.forEach(el => el.remove());

                    const rawText = clone.textContent || '';
                    const leakedEnvironments = ['\\begin{array}', '\\begin{tabular}', '\\begin{matrix}'];

                    for (const env of leakedEnvironments) {
                        if (rawText.includes(env)) {
                            setFailures(prev => [...prev, { id: question.id, reason: `Raw LaTeX Detected: ${env}` }]);
                            setLogs(prev => [...prev, `[FAIL] QID: ${question.id} - Raw LaTeX Detected`]);
                            break;
                        }
                    }
                }
            } catch (err) {
                console.error("QA Step Error:", err);
                setLogs(prev => [...prev, `[ERROR] Internal QA Error: ${String(err)}`]);
            }

            // User requested "slightly slower"
            await new Promise(r => setTimeout(r, 800));

            setCurrentIndex(prev => prev + 1);
        };

        step();

    }, [currentIndex, isRunning, questions, status]); // Dependency on currentIndex ensures loop

    const currentQuestion = questions[currentIndex];
    const liveViewRef = useRef<HTMLDivElement>(null);

    if (status === 'loading') return <div className="p-10">Loading Questions...</div>;

    return (
        <div className="h-screen bg-gray-50 flex flex-col overflow-hidden">
            {/* Header Control Bar */}
            <div className="bg-white px-6 py-4 border-b border-gray-200 flex-none z-50 shadow-sm flex flex-col sm:flex-row justify-between items-center gap-4">
                <div className="flex items-center gap-6">
                    <button
                        onClick={() => navigate('/settings/creator')}
                        className="p-2 -ml-2 text-gray-400 hover:text-gray-700 hover:bg-gray-100 rounded-lg transition-colors"
                        title="Back to Creator"
                    >
                        <span className="material-symbols-outlined">arrow_back</span>
                    </button>
                    <div>
                        <h1 className="text-xl font-black text-gray-900 tracking-tight flex items-center gap-2">
                            <span className="material-symbols-outlined text-primary">bug_report</span>
                            Debug QA
                        </h1>
                        <div className="flex gap-3 text-xs font-bold uppercase tracking-wider text-gray-400 mt-1">
                            <span>{currentIndex + 1} / {questions.length}</span>
                            <span className="w-px h-3 bg-gray-300"></span>
                            <span className={failures.length > 0 ? "text-red-500" : "text-green-500"}>
                                {failures.length} Issues
                            </span>
                            {currentQuestion && (
                                <>
                                    <span className="w-px h-3 bg-gray-300"></span>
                                    <span className="select-all font-mono text-gray-500">ID: {currentQuestion.id}</span>
                                </>
                            )}
                        </div>
                    </div>
                </div>

                <div className="flex items-center gap-4">
                    {/* Navigation */}
                    <div className="flex items-center bg-gray-100 rounded-lg p-1">
                        <button
                            onClick={() => setCurrentIndex(curr => Math.max(0, curr - 1))}
                            disabled={currentIndex === 0 || isRunning}
                            className="p-2 hover:bg-white hover:shadow-sm rounded-md transition-all disabled:opacity-30 text-gray-600"
                        >
                            <span className="material-symbols-outlined text-[18px]">chevron_left</span>
                        </button>

                        <div className="flex items-center px-2 border-l border-r border-gray-200 mx-1">
                            <span className="text-xs font-bold text-gray-400 mr-2">JUMP TO</span>
                            <input
                                type="number"
                                min={1}
                                max={questions.length}
                                value={currentIndex + 1}
                                onChange={(e) => {
                                    const val = parseInt(e.target.value);
                                    if (!isNaN(val) && val >= 1 && val <= questions.length) {
                                        setCurrentIndex(val - 1);
                                    }
                                }}
                                className="w-16 text-center font-mono font-bold text-sm text-gray-800 bg-transparent focus:outline-none focus:bg-white rounded px-1 transition-colors"
                            />
                        </div>

                        <button
                            onClick={() => setCurrentIndex(curr => Math.min(questions.length - 1, curr + 1))}
                            disabled={currentIndex === questions.length - 1 || isRunning}
                            className="p-2 hover:bg-white hover:shadow-sm rounded-md transition-all disabled:opacity-30 text-gray-600"
                        >
                            <span className="material-symbols-outlined text-[18px]">chevron_right</span>
                        </button>
                    </div>

                    <div className="h-8 w-px bg-gray-200"></div>

                    {/* Actions */}
                    <div className="flex gap-2">
                        <button
                            onClick={() => setIsSubmitted(prev => !prev)}
                            className="px-4 py-2 bg-white border border-gray-200 text-gray-700 font-bold text-sm rounded-xl hover:bg-gray-50 hover:border-gray-300 transition-all active:scale-95"
                        >
                            {isSubmitted ? 'Hide Answer' : 'Show Answer'}
                        </button>
                        {!isRunning ? (
                            <button
                                onClick={startQA}
                                className="px-4 py-2 bg-black text-white font-bold text-sm rounded-xl hover:bg-gray-800 transition-all active:scale-95 flex items-center gap-2 shadow-lg shadow-black/20"
                            >
                                <span className="material-symbols-outlined text-[18px]">play_arrow</span>
                                Run QA
                            </button>
                        ) : (
                            <button
                                onClick={stopQA}
                                className="px-4 py-2 bg-red-500 text-white font-bold text-sm rounded-xl hover:bg-red-600 transition-all active:scale-95 flex items-center gap-2 shadow-lg shadow-red-500/30"
                            >
                                <span className="material-symbols-outlined text-[18px] animate-spin">sync</span>
                                Stop
                            </button>
                        )}
                    </div>
                </div>
            </div>

            {/* Main Content Split View */}
            <main className="flex-1 overflow-hidden w-full relative">
                <div ref={liveViewRef} className="h-full grid grid-cols-2 divide-x divide-gray-200">

                    {/* LEFT PANEL: Question & Options */}
                    <div className="h-full overflow-y-auto p-8 bg-white">
                        {currentQuestion ? (
                            <ErrorBoundary fallback={
                                <div className="p-8 bg-red-50 border border-red-100 rounded-3xl text-center">
                                    <span className="material-symbols-outlined text-4xl text-red-500 mb-2">error</span>
                                    <p className="font-bold text-red-600">Critical Rendering Error</p>
                                    <p className="text-sm text-red-400 mt-1">Question ID: {currentQuestion.id}</p>
                                </div>
                            }>
                                <div className="bg-white rounded-3xl shadow-sm border border-gray-200 overflow-hidden mb-8">
                                    {/* Prompt */}
                                    <div className="p-8 border-b border-gray-100">
                                        <div className="prose max-w-none text-lg text-gray-800">
                                            <ErrorBoundary fallback={<span className="text-red-500 bg-red-50 px-2 py-1 rounded">Error rendering prompt</span>}>
                                                <MathRenderer content={currentQuestion.prompt || ''} />
                                            </ErrorBoundary>
                                        </div>
                                    </div>

                                    {/* Options */}
                                    <div className="p-8 bg-gray-50/50 space-y-3">
                                        {Array.isArray(currentQuestion.options) && currentQuestion.options.map((opt: any) => (
                                            <div
                                                key={opt.id}
                                                onClick={() => !isSubmitted && setSelectedOption(opt.id)}
                                                className={`p-4 rounded-xl border-2 transition-all cursor-pointer group ${isSubmitted
                                                    ? (opt.id === currentQuestion.correctOptionId
                                                        ? 'bg-green-50 border-green-500/50 shadow-sm'
                                                        : (selectedOption === opt.id ? 'bg-red-50 border-red-200' : 'bg-white border-transparent opacity-60'))
                                                    : (selectedOption === opt.id
                                                        ? 'bg-white border-primary shadow-md transform scale-[1.01]'
                                                        : 'bg-white border-transparent hover:border-gray-200 shadow-sm')
                                                    }`}
                                            >
                                                <div className="flex gap-4">
                                                    <div className={`flex items-center justify-center w-8 h-8 rounded-full border-2 text-sm font-black shrink-0 ${isSubmitted
                                                        ? (opt.id === currentQuestion.correctOptionId ? 'bg-green-500 border-green-500 text-white' : 'border-gray-200 text-gray-400')
                                                        : (selectedOption === opt.id ? 'bg-primary border-primary text-black' : 'border-gray-200 text-gray-400 group-hover:border-gray-300')
                                                        }`}>
                                                        {opt.id}
                                                    </div>
                                                    <div className="flex-1 pt-1">
                                                        <div className="font-bold text-gray-900">
                                                            <ErrorBoundary fallback={<span className="text-red-500">Error rendering option</span>}>
                                                                <MathRenderer content={opt.value || opt.text || ''} />
                                                            </ErrorBoundary>
                                                        </div>

                                                        {isSubmitted && opt.explanation && (
                                                            <div className="mt-3 text-sm text-gray-600 bg-black/5 p-3 rounded-lg font-bold">
                                                                <span className="text-xs uppercase tracking-wider text-gray-500 block mb-1 font-normal">Feedback</span>
                                                                <ErrorBoundary fallback={<span className="text-red-500">Error rendering feedback</span>}>
                                                                    <MathRenderer content={opt.explanation} />
                                                                </ErrorBoundary>
                                                            </div>
                                                        )}
                                                    </div>
                                                </div>
                                            </div>
                                        ))}
                                    </div>
                                </div>
                            </ErrorBoundary>
                        ) : (
                            <div className="text-center py-20">
                                <div className="w-16 h-16 bg-gray-100 rounded-full flex items-center justify-center mx-auto mb-4">
                                    <span className="material-symbols-outlined text-gray-400 text-2xl">inbox</span>
                                </div>
                                <h3 className="text-gray-900 font-bold mb-1">No Questions Loaded</h3>
                                <p className="text-gray-500 text-sm">Please check your database connection.</p>
                            </div>
                        )}
                    </div>

                    {/* RIGHT PANEL: Detailed Solution */}
                    <div className="h-full overflow-y-auto bg-gray-50/50 p-8">
                        {currentQuestion && isSubmitted ? (
                            <div className="bg-yellow-50/40 border border-yellow-100 rounded-3xl p-8 shadow-sm">
                                <h4 className="text-sm font-black uppercase tracking-wider text-yellow-600 mb-6 flex items-center gap-2 border-b border-yellow-100 pb-4">
                                    <span className="material-symbols-outlined">lightbulb</span>
                                    Detailed Solution
                                </h4>
                                <div className="text-gray-800 leading-relaxed text-lg">
                                    <ErrorBoundary fallback={<span className="text-red-500">Error rendering explanation</span>}>
                                        <MathRenderer content={currentQuestion.explanation || 'No explanation provided.'} />
                                    </ErrorBoundary>
                                </div>
                            </div>
                        ) : (
                            <div className="h-full flex flex-col items-center justify-center text-gray-300 p-10 select-none">
                                <span className="material-symbols-outlined text-6xl mb-4 text-gray-200">lightbulb</span>
                                <p className="font-bold text-xl text-gray-300">Detailed Solution</p>
                                <p className="text-sm mt-2 max-w-xs text-center">
                                    Submit an answer or click "Show Answer" to view the detailed explanation here.
                                </p>
                            </div>
                        )}
                    </div>

                </div>
            </main>
        </div>
    );
};

export default DebugQA;
