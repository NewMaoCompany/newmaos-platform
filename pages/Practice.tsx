import React, { useState, useEffect, useRef } from 'react';
import { useApp } from '../AppContext';
import { useNavigate, useLocation } from 'react-router-dom';
import { COURSE_CONTENT_DATA } from '../constants';
import { SessionMode, Question } from '../types';
import { Navbar } from '../components/Navbar';

// Markdown-ish renderer for the lesson content
const ContentRenderer = ({ content }: { content: string }) => {
    if (!content) return <div className="text-gray-400 italic">No lesson content available for this topic yet.</div>;

    // Basic splitting by double newline for paragraphs
    const blocks = content.split('\n');
    return (
        <div className="space-y-4 text-text-main dark:text-gray-200">
            {blocks.map((block, idx) => {
                if (block.startsWith('### ')) {
                    return <h3 key={idx} className="text-xl font-bold text-primary mt-6 mb-2">{block.replace('### ', '')}</h3>
                }
                if (block.startsWith('**') && block.endsWith('**')) {
                    return <strong key={idx} className="block font-bold">{block.replace(/\*\*/g, '')}</strong>
                }
                if (block.trim().startsWith('* ')) {
                    return <li key={idx} className="ml-4 list-disc">{block.replace('* ', '')}</li>
                }
                if (block.includes('$')) {
                    // Very crude "math" detection for this demo
                    return <div key={idx} className="font-math text-lg bg-gray-50 dark:bg-white/5 p-3 rounded-lg border-l-4 border-primary my-2">{block.replace(/\$/g, '')}</div>
                }
                if (block.trim() === '') return null;
                return <p key={idx} className="leading-relaxed">{block}</p>
            })}
        </div>
    )
}

export const Practice = () => {
  const { user, completePractice, questions: allQuestions } = useApp();
  const navigate = useNavigate();
  const location = useLocation();
  const topicParam = location.state?.topic || 'General'; // This might be "AB_Limits" or just "Limits"
  const subTopicId = location.state?.subTopicId;
  const sessionMode: SessionMode = location.state?.mode || 'Adaptive';

  // Derived Clean Topic - available to all functions in component
  const cleanTopic = topicParam.includes('_') ? topicParam.split('_')[1] : topicParam;

  // If subTopicId exists AND it is NOT 'unit_test', we start in 'Lesson' view, otherwise 'Practice'
  const [viewState, setViewState] = useState<'lesson' | 'practice'>(
      subTopicId && subTopicId !== 'unit_test' ? 'lesson' : 'practice'
  );
  const [subTopicData, setSubTopicData] = useState<any>(null);

  // State for Sidebar Tools
  const [activeTool, setActiveTool] = useState<'none' | 'formula' | 'calculator' | 'scratchpad'>('none');
  
  // --- Scratchpad State & Logic ---
  const canvasRef = useRef<HTMLCanvasElement>(null);
  const [isDrawing, setIsDrawing] = useState(false);
  const [penColor, setPenColor] = useState('#f9d406'); // Default primary color
  
  // --- Calculator State ---
  const [calcDisplay, setCalcDisplay] = useState('0');

  // State for Modals
  const [showExitConfirm, setShowExitConfirm] = useState(false);
  const [showReportModal, setShowReportModal] = useState(false);
  const [isSaving, setIsSaving] = useState(false);
  const [isReporting, setIsReporting] = useState(false);
  const [reportReason, setReportReason] = useState('content_error');

  // Filter questions based on topic/course dynamically
  const [questions, setQuestions] = useState<Question[]>([]);
  
  // Helper to determine display title
  const getTopicDisplayTitle = () => {
      // Special case for Unit Test
      if (subTopicId === 'unit_test') {
          return 'Unit Test';
      }
      
      // If valid unit in content data, use its title
      if (COURSE_CONTENT_DATA[topicParam]) {
          return COURSE_CONTENT_DATA[topicParam].title;
      }
      // Fallback to clean name
      return cleanTopic;
  };

  useEffect(() => {
    let filtered = [];
    
    // Base Filter: Match Course Context (AB sees 'AB'|'Both', BC sees 'BC'|'Both')
    // and Match Topic string
    const baseQuestions = allQuestions.filter(q => {
        const isCourseMatch = q.course === user.currentCourse || q.course === 'Both';
        const isTopicMatch = q.topic === cleanTopic;
        return isCourseMatch && isTopicMatch;
    });

    // 1. Filter by SubTopic if provided (Strict Subdivision)
    if (subTopicId) {
        if (subTopicId === 'unit_test') {
            // Filter questions explicitly tagged as 'unit_test'
            // OR include all questions from the unit if we want the test to be comprehensive?
            // The requirement was: "add questions directly under the Unit column, it should be classified into unit test"
            // This implies a specific classification.
            // Let's filter for questions that are specifically 'unit_test' OR have no subTopicId set (legacy behavior for "Unit level" questions)
            filtered = baseQuestions.filter(q => q.subTopicId === 'unit_test' || !q.subTopicId);
        } else {
            // First try to match questions specifically tagged with this subTopicId
            filtered = baseQuestions.filter(q => q.subTopicId === subTopicId);
            
            // Find the lesson content
            if (topicParam && COURSE_CONTENT_DATA[topicParam]) {
                const sub = COURSE_CONTENT_DATA[topicParam].subTopics.find(s => s.id === subTopicId);
                setSubTopicData(sub);
            }
        }
    } 
    // 2. Otherwise filter by Unit Topic (General Practice)
    else {
        filtered = baseQuestions;
    }

    // --- APPLY MODE LOGIC (Only if not in strict subtopic mode, or randomize order within subtopic) ---
    if (sessionMode === 'Random') {
        filtered = [...filtered].sort(() => Math.random() - 0.5);
    } else if (sessionMode === 'Review') {
        filtered = [...filtered].reverse();
    }

    setQuestions(filtered);
  }, [topicParam, subTopicId, user.currentCourse, sessionMode, allQuestions, cleanTopic]);

  const [currentQuestionIndex, setCurrentQuestionIndex] = useState(0);
  const [selectedAnswer, setSelectedAnswer] = useState<string | null>(null);
  const [isSubmitted, setIsSubmitted] = useState(false);
  const [feedback, setFeedback] = useState<'correct' | 'incorrect' | null>(null);
  const [sessionResults, setSessionResults] = useState({ correct: 0, total: 0 });

  const question = questions[currentQuestionIndex];
  const progress = questions.length > 0 ? ((currentQuestionIndex) / questions.length) * 100 : 0;

  // --- Scratchpad Canvas Setup ---
  useEffect(() => {
    if (activeTool === 'scratchpad' && canvasRef.current) {
        const canvas = canvasRef.current;
        const ctx = canvas.getContext('2d');
        
        // Set canvas size to full window
        const resize = () => {
            canvas.width = window.innerWidth;
            canvas.height = window.innerHeight;
            // Restore context settings after resize
            if (ctx) {
                ctx.strokeStyle = penColor;
                ctx.lineWidth = 3;
                ctx.lineCap = 'round';
                ctx.lineJoin = 'round';
            }
        };
        
        resize();
        window.addEventListener('resize', resize);
        return () => window.removeEventListener('resize', resize);
    }
  }, [activeTool, penColor]);

  // Update pen color when state changes
  useEffect(() => {
      if (canvasRef.current) {
          const ctx = canvasRef.current.getContext('2d');
          if (ctx) ctx.strokeStyle = penColor;
      }
  }, [penColor]);

  const startDrawing = (e: React.MouseEvent | React.TouchEvent) => {
      setIsDrawing(true);
      draw(e);
  };
  
  const stopDrawing = () => {
      setIsDrawing(false);
      if (canvasRef.current) {
          const ctx = canvasRef.current.getContext('2d');
          ctx?.beginPath(); 
      }
  };

  const draw = (e: React.MouseEvent | React.TouchEvent) => {
      if (!isDrawing || !canvasRef.current) return;
      const canvas = canvasRef.current;
      const ctx = canvas.getContext('2d');
      if (!ctx) return;

      let clientX, clientY;
      if ('touches' in e) {
          clientX = e.touches[0].clientX;
          clientY = e.touches[0].clientY;
      } else {
          clientX = (e as React.MouseEvent).clientX;
          clientY = (e as React.MouseEvent).clientY;
      }

      ctx.lineTo(clientX, clientY);
      ctx.stroke();
      ctx.beginPath();
      ctx.moveTo(clientX, clientY);
  };
  
  const clearCanvas = () => {
      if(canvasRef.current) {
          const ctx = canvasRef.current.getContext('2d');
          ctx?.clearRect(0, 0, canvasRef.current.width, canvasRef.current.height);
      }
  };

  // --- Calculator Logic ---
  const handleCalcInput = (val: string) => {
      if (val === 'C') {
          setCalcDisplay('0');
      } else if (val === '=') {
          try {
              // Safe math evaluation for the demo
              const expr = calcDisplay
                .replace(/×/g, '*')
                .replace(/÷/g, '/')
                .replace(/π/g, 'Math.PI')
                .replace(/e/g, 'Math.E');
                
              // eslint-disable-next-line no-new-func
              const result = new Function('return ' + expr)();
              
              // Format result to avoid long decimals
              const formatted = String(Math.round(result * 100000000) / 100000000);
              setCalcDisplay(formatted);
          } catch (e) {
              setCalcDisplay('Error');
          }
      } else if (['sin', 'cos', 'tan', 'ln'].includes(val)) {
          // Placeholder for advanced functions in this demo context
          setCalcDisplay('Feature in Pro'); 
          setTimeout(() => setCalcDisplay(calcDisplay), 800);
      } else {
          setCalcDisplay(prev => prev === '0' && val !== '.' ? val : prev + val);
      }
  };

  const handleSubmit = () => {
    if (!selectedAnswer) return;
    
    setIsSubmitted(true);
    const isCorrect = selectedAnswer === question.correctOptionId;
    
    if (isCorrect) {
      setFeedback('correct');
      setSessionResults(prev => ({ ...prev, correct: prev.correct + 1 }));
    } else {
      setFeedback('incorrect');
    }
  };

  const handleNext = () => {
    if (currentQuestionIndex < questions.length - 1) {
      setCurrentQuestionIndex(prev => prev + 1);
      setSelectedAnswer(null);
      setIsSubmitted(false);
      setFeedback(null);
    } else {
      finishSession();
    }
  };

  const finishSession = () => {
    completePractice({
        correct: sessionResults.correct,
        total: questions.length,
        // Use cleanTopic to ensure stats update correctly
        topic: question?.topic || cleanTopic
    });
    // Return to hub or topic detail? 
    // If we came from a specific unit, return to that unit page.
    if (subTopicId) {
        navigate(`/practice/unit/${topicParam}`);
    } else {
        navigate('/practice');
    }
  };

  const handleExitRequest = () => {
      setShowExitConfirm(true);
  };

  const handleConfirmExit = () => {
      // Logic for instant exit without simulated delay
      const attempted = currentQuestionIndex + (isSubmitted ? 1 : 0);
      
      // Save if user has attempted at least one question
      if (attempted > 0 && viewState === 'practice' && questions.length > 0) {
            completePractice({
              correct: sessionResults.correct,
              total: attempted,
              // CRITICAL: Ensure we pass the clean topic name (e.g. "Limits") 
              // so it matches the keys in radarData, otherwise stats won't update.
              topic: question?.topic || cleanTopic
          });
      }
      
      if (subTopicId) {
          navigate(`/practice/unit/${topicParam}`);
      } else {
          navigate('/practice');
      }
  };

  const handleReportSubmit = () => {
      setIsReporting(true);
      setTimeout(() => {
          setIsReporting(false);
          setShowReportModal(false);
          alert("Thank you for your report. We will review this question shortly.");
      }, 800);
  };

  const renderMath = (latex?: string) => {
    if (!latex) return null;
    
    // Improved "Generic" renderer that attempts to display any LaTeX reasonably well in HTML
    
    // Check for specific demo patterns first (Hardcoded for perfect presentation of demo content)
    if (latex.includes("\\frac") && latex.includes("sin")) {
         return (
             <div className="text-3xl md:text-4xl font-math text-text-main dark:text-white flex items-center gap-2">
                <span className="italic">f</span>(x) = 
                <div className="inline-flex flex-col items-center justify-center align-middle mx-2">
                    <div className="border-b border-text-main dark:border-white pb-1 mb-1 px-1">sin(5<span className="italic">x</span>)</div>
                    <div><span className="italic">x</span></div>
                </div>
            </div>
        );
    } 
    
    // Generic Fraction Renderer: Matches \frac{...}{...}
    // Note: This is a simple regex parser for visual feedback, not a full LaTeX engine.
    const fracMatch = latex.match(/\\frac\{(.+?)\}\{(.+?)\}/);
    if (fracMatch) {
        const numerator = fracMatch[1].replace(/\\/g, '');
        const denominator = fracMatch[2].replace(/\\/g, '');
        return (
            <div className="text-3xl md:text-4xl font-math text-text-main dark:text-white flex items-center gap-2">
                <div className="inline-flex flex-col items-center justify-center align-middle mx-2">
                    <div className="border-b border-text-main dark:border-white pb-1 mb-1 px-1">{numerator}</div>
                    <div>{denominator}</div>
                </div>
            </div>
        );
    }

    // Generic display for other LaTeX (Integrals, Sums) if not matched above
    // Replaces common latex symbols with unicode chars for better raw display
    const formatted = latex
        .replace(/\\sum/g, '∑')
        .replace(/\\int/g, '∫')
        .replace(/\\infty/g, '∞')
        .replace(/\\pi/g, 'π')
        .replace(/\\approx/g, '≈')
        .replace(/\\neq/g, '≠')
        .replace(/\\le/g, '≤')
        .replace(/\\ge/g, '≥')
        .replace(/\\to/g, '→')
        .replace(/\\/g, '') // remove remaining backslashes
        .replace(/_\{(.+?)\}\^\{(.+?)\}/g, ' ($1 to $2) ') // crude bounds handling
        .replace(/\^\{(.+?)\}/g, ' sup($1) ')
        .replace(/\^2/g, '²')
        .replace(/\^3/g, '³');

    return (
        <div className="text-2xl md:text-4xl font-math text-text-main dark:text-white text-center leading-relaxed">
            {formatted}
        </div>
    )
  };

  const getModeLabel = (mode: SessionMode) => {
      switch(mode) {
          case 'Adaptive': return 'Adaptive Session';
          case 'Random': return 'Randomized Drill';
          case 'Review': return 'Weakness Review';
          default: return 'Practice Session';
      }
  };

  // --- RENDER LESSON VIEW ---
  if (viewState === 'lesson' && subTopicData) {
      return (
        <div className="bg-background-light dark:bg-background-dark min-h-screen flex flex-col antialiased animate-fade-in">
             <header className="sticky top-0 z-50 flex items-center justify-between border-b border-gray-200 dark:border-gray-800 bg-surface-light/80 dark:bg-surface-dark/80 backdrop-blur-md px-6 py-3 h-16">
                 <div className="flex items-center gap-4">
                    <button onClick={handleExitRequest} className="p-2 rounded-full hover:bg-gray-100 dark:hover:bg-white/10 transition-colors">
                        <span className="material-symbols-outlined text-text-main dark:text-white">arrow_back</span>
                    </button>
                    <h1 className="text-lg font-bold text-text-main dark:text-white truncate">{subTopicData.title}</h1>
                 </div>
                 <div className="px-3 py-1 bg-primary/10 text-yellow-700 dark:text-primary rounded text-xs font-bold uppercase tracking-wider">
                     Lesson Mode
                 </div>
             </header>

             <main className="flex-grow flex flex-col items-center py-8 px-4 sm:px-6">
                 <div className="max-w-3xl w-full bg-surface-light dark:bg-surface-dark p-6 rounded-3xl shadow-sm border border-gray-100 dark:border-gray-800">
                     <div className="prose dark:prose-invert max-w-none">
                         <h2 className="text-2xl font-black mb-4">{subTopicData.title}</h2>
                         <ContentRenderer content={subTopicData.content} />
                     </div>
                     <div className="mt-6 pt-4 border-t border-gray-100 dark:border-gray-800 flex justify-end">
                         <button 
                            onClick={() => setViewState('practice')}
                            className="bg-primary text-black px-8 py-3 rounded-xl font-bold flex items-center gap-3 hover:shadow-lg hover:scale-[1.02] transition-all"
                         >
                             <span>Start Practice Questions</span>
                             <span className="material-symbols-outlined">arrow_forward</span>
                         </button>
                     </div>
                 </div>
             </main>

             {/* Reuse Exit Modal for Lesson view */}
             {showExitConfirm && (
                <div className="fixed inset-0 z-[100] flex items-center justify-center p-4 bg-black/50 backdrop-blur-sm animate-fade-in">
                    <div className="bg-white dark:bg-surface-dark rounded-2xl shadow-2xl max-w-sm w-full p-6 border border-gray-100 dark:border-gray-800">
                        <div className="flex flex-col items-center text-center gap-4 mb-6">
                            <h3 className="text-xl font-bold text-text-main dark:text-white">Exit Lesson?</h3>
                            <p className="text-gray-500 dark:text-gray-400 text-sm">
                                You can return to this lesson later.
                            </p>
                        </div>
                        <div className="flex gap-3">
                            <button onClick={() => setShowExitConfirm(false)} className="flex-1 py-3 rounded-xl font-bold text-gray-600 dark:text-gray-300 hover:bg-gray-100 dark:hover:bg-white/10">Cancel</button>
                            <button onClick={handleConfirmExit} className="flex-1 py-3 rounded-xl font-bold bg-primary text-text-main">Exit</button>
                        </div>
                    </div>
                </div>
            )}
        </div>
      )
  }

  // --- RENDER EMPTY STATE (NO QUESTIONS FOUND) ---
  if (!question) {
      return (
        <div className="min-h-screen flex flex-col bg-background-light dark:bg-background-dark text-text-main dark:text-white">
            <Navbar />
            <div className="flex-grow flex flex-col items-center justify-center p-6 text-center animate-fade-in">
                <div className="w-20 h-20 bg-gray-100 dark:bg-white/5 rounded-full flex items-center justify-center mb-6">
                    <span className="material-symbols-outlined text-4xl text-gray-400">quiz</span>
                </div>
                <h2 className="text-2xl font-bold mb-2">No Questions Available</h2>
                <p className="text-gray-500 mb-8 max-w-md">
                    {subTopicId === 'unit_test' 
                        ? `No Unit Test questions found for ${getTopicDisplayTitle()}.`
                        : `We are currently building the problem set for ${subTopicData ? subTopicData.title : 'this topic'}.`
                    }
                    <br/><span className="text-sm mt-2 block opacity-70">Hint: Add questions in the Creator Area!</span>
                </p>
                <div className="flex gap-4">
                    <button 
                        onClick={() => navigate(-1)} 
                        className="px-6 py-3 bg-gray-100 dark:bg-white/10 hover:bg-gray-200 dark:hover:bg-white/20 text-text-main dark:text-white rounded-xl font-bold transition-colors"
                    >
                        Go Back
                    </button>
                    {/* Fallback to general practice if possible */}
                    <button 
                        onClick={() => {
                             // Try generic limits pool for demo purposes if stuck
                             navigate('/practice');
                        }}
                        className="px-6 py-3 bg-primary text-black rounded-xl font-bold hover:shadow-lg transition-all"
                    >
                        Return to Hub
                    </button>
                </div>
            </div>
        </div>
      );
  }

  // --- RENDER PRACTICE VIEW ---
  return (
    <div className="bg-background-light dark:bg-background-dark text-text-main font-display min-h-screen flex flex-col overflow-x-hidden antialiased animate-fade-in">
      
      {/* Scratchpad Overlay */}
      {activeTool === 'scratchpad' && (
          <div className="fixed inset-0 z-[60] cursor-crosshair animate-fade-in">
              <canvas 
                ref={canvasRef}
                className="w-full h-full touch-none"
                onMouseDown={startDrawing}
                onMouseMove={draw}
                onMouseUp={stopDrawing}
                onMouseLeave={stopDrawing}
                onTouchStart={startDrawing}
                onTouchMove={draw}
                onTouchEnd={stopDrawing}
              />
              
              {/* Scratchpad Controls */}
              <div className="absolute bottom-10 left-1/2 -translate-x-1/2 bg-white dark:bg-surface-dark border border-gray-200 dark:border-gray-800 rounded-full shadow-2xl p-2 flex items-center gap-4">
                  <div className="flex items-center gap-2 px-2">
                      <button onClick={() => setPenColor('#f9d406')} className={`w-6 h-6 rounded-full bg-[#f9d406] ring-2 ${penColor === '#f9d406' ? 'ring-black dark:ring-white scale-110' : 'ring-transparent'}`}></button>
                      <button onClick={() => setPenColor('#ef4444')} className={`w-6 h-6 rounded-full bg-red-500 ring-2 ${penColor === '#ef4444' ? 'ring-black dark:ring-white scale-110' : 'ring-transparent'}`}></button>
                      <button onClick={() => setPenColor('#000000')} className={`w-6 h-6 rounded-full bg-black ring-2 ${penColor === '#000000' ? 'ring-gray-300 dark:ring-white scale-110' : 'ring-transparent'}`}></button>
                  </div>
                  <div className="h-6 w-px bg-gray-200 dark:bg-gray-700"></div>
                  <button onClick={clearCanvas} className="p-2 hover:bg-gray-100 dark:hover:bg-white/10 rounded-full text-gray-600 dark:text-gray-300" title="Clear All">
                      <span className="material-symbols-outlined">delete</span>
                  </button>
                  <button onClick={() => setActiveTool('none')} className="px-4 py-2 bg-black dark:bg-white text-white dark:text-black rounded-full text-sm font-bold shadow-sm">
                      Done
                  </button>
              </div>
          </div>
      )}

      <header className="sticky top-0 z-50 flex items-center justify-between border-b border-border-light dark:border-gray-800 bg-surface-light/80 dark:bg-surface-dark/80 backdrop-blur-md px-6 py-3 lg:px-12 h-16">
        <div className="flex items-center gap-4">
          <div className="size-8 flex items-center justify-center text-text-main dark:text-white bg-primary rounded-lg">
            <span className="material-symbols-outlined text-xl font-bold">functions</span>
          </div>
          <h1 className="text-text-main dark:text-white text-lg font-bold tracking-tight">NewMaoS</h1>
        </div>
        <div className="flex items-center gap-6">
          <button onClick={handleExitRequest} className="group flex items-center gap-2 text-sm font-medium text-text-muted hover:text-text-main dark:text-gray-400 dark:hover:text-white transition-colors">
            <span className="material-symbols-outlined text-lg">arrow_back</span>
            <span>Exit Session</span>
          </button>
          <div className="h-6 w-px bg-gray-200 dark:bg-gray-800 mx-2"></div>
          <div 
             className="bg-center bg-no-repeat bg-cover rounded-full size-9 ring-2 ring-transparent group-hover:ring-primary transition-all cursor-pointer" 
             style={{ backgroundImage: `url(${user.avatarUrl})` }}
          ></div>
        </div>
      </header>

      <main className="flex-grow flex justify-center py-8 px-4 sm:px-6 lg:px-8 relative">
        <div className="w-full max-w-[1280px] flex gap-8">
          
          <div className="flex-1 flex flex-col gap-6">
            <div className="flex flex-col md:flex-row md:items-end justify-between gap-4 px-1">
              <div className="flex flex-col gap-1">
                <div className="flex items-center gap-2 text-sm font-medium text-text-muted text-gray-500">
                  <span>Calculus {user.currentCourse}</span>
                  <span className="text-gray-300">/</span>
                  <span className="font-bold text-primary">{subTopicData ? subTopicData.title : (sessionMode === 'Adaptive' ? getTopicDisplayTitle() : getModeLabel(sessionMode))}</span>
                  <span className="text-gray-300">/</span>
                  <span>{question.topic}</span>
                </div>
                <h2 className="text-2xl font-bold text-text-main dark:text-white tracking-tight">Practice Session</h2>
              </div>
              <div className="w-full md:w-1/3 flex flex-col gap-2">
                <div className="flex justify-between text-xs font-semibold uppercase tracking-wider text-text-muted">
                  <span>Question {currentQuestionIndex + 1} of {questions.length}</span>
                  <span>{Math.round(progress)}%</span>
                </div>
                <div className="h-1.5 w-full rounded-full bg-gray-200 dark:bg-gray-800 overflow-hidden">
                  <div className="h-full bg-primary rounded-full transition-all duration-500" style={{ width: `${progress}%` }}></div>
                </div>
              </div>
            </div>

            <div className="grid grid-cols-1 lg:grid-cols-12 gap-6 lg:gap-8 items-start relative">
              
              {/* Tool Overlay Panel (Calculator / Formula) */}
              {(activeTool === 'formula' || activeTool === 'calculator') && (
                  <div className="absolute top-0 left-0 right-0 z-20 bg-white dark:bg-surface-dark border border-gray-200 dark:border-gray-800 rounded-2xl shadow-xl animate-fade-in-up overflow-hidden ring-1 ring-black/5">
                      <div className="flex justify-between items-center p-4 bg-gray-50 dark:bg-black/20 border-b border-gray-100 dark:border-gray-800">
                          <h3 className="font-bold text-lg flex items-center gap-2">
                              <span className="material-symbols-outlined">{activeTool === 'formula' ? 'function' : 'calculate'}</span>
                              {activeTool === 'formula' ? 'Reference Sheet' : 'Scientific Calculator'}
                          </h3>
                          <button onClick={() => setActiveTool('none')} className="text-gray-500 hover:text-black dark:hover:text-white">
                              <span className="material-symbols-outlined">close</span>
                          </button>
                      </div>
                      <div className="p-6">
                          {activeTool === 'formula' ? (
                             <div className="grid grid-cols-1 md:grid-cols-2 gap-8 text-sm max-h-[400px] overflow-y-auto pr-2">
                                <div>
                                    <h4 className="font-bold mb-3 text-primary border-b border-gray-200 dark:border-gray-700 pb-1">Derivatives</h4>
                                    <ul className="space-y-2 text-gray-600 dark:text-gray-300 font-math">
                                        <li className="flex justify-between"><span>d/dx(xⁿ)</span> <span>nxⁿ⁻¹</span></li>
                                        <li className="flex justify-between"><span>d/dx(sin x)</span> <span>cos x</span></li>
                                        <li className="flex justify-between"><span>d/dx(cos x)</span> <span>-sin x</span></li>
                                        <li className="flex justify-between"><span>d/dx(eˣ)</span> <span>eˣ</span></li>
                                        <li className="flex justify-between"><span>d/dx(ln x)</span> <span>1/x</span></li>
                                        <li className="flex justify-between"><span>d/dx(uv)</span> <span>u'v + uv'</span></li>
                                    </ul>
                                </div>
                                <div>
                                    <h4 className="font-bold mb-3 text-primary border-b border-gray-200 dark:border-gray-700 pb-1">Integrals</h4>
                                    <ul className="space-y-2 text-gray-600 dark:text-gray-300 font-math">
                                        <li className="flex justify-between"><span>∫ xⁿ dx</span> <span>xⁿ⁺¹/(n+1)</span></li>
                                        <li className="flex justify-between"><span>∫ 1/x dx</span> <span>ln|x|</span></li>
                                        <li className="flex justify-between"><span>∫ eˣ dx</span> <span>eˣ</span></li>
                                        <li className="flex justify-between"><span>∫ sin x dx</span> <span>-cos x</span></li>
                                        <li className="flex justify-between"><span>∫ cos x dx</span> <span>sin x</span></li>
                                    </ul>
                                </div>
                             </div>
                          ) : (
                             <div className="max-w-xs mx-auto">
                                <div className="bg-gray-100 dark:bg-black/40 p-4 rounded-xl mb-4 text-right font-mono text-2xl tracking-widest min-h-[64px] flex items-center justify-end overflow-x-auto">
                                    {calcDisplay}
                                </div>
                                <div className="grid grid-cols-4 gap-3">
                                    {['C', '(', ')', '÷'].map(b => (
                                        <button key={b} onClick={() => handleCalcInput(b)} className="p-3 bg-gray-200 dark:bg-white/5 rounded-lg font-bold hover:bg-gray-300 dark:hover:bg-white/10">{b}</button>
                                    ))}
                                    {['7', '8', '9', '×'].map(b => (
                                        <button key={b} onClick={() => handleCalcInput(b)} className={`p-3 rounded-lg font-bold ${['×'].includes(b) ? 'bg-gray-200 dark:bg-white/5' : 'bg-white dark:bg-white/10 border border-gray-200 dark:border-gray-700'}`}>{b}</button>
                                    ))}
                                    {['4', '5', '6', '-'].map(b => (
                                        <button key={b} onClick={() => handleCalcInput(b)} className={`p-3 rounded-lg font-bold ${['-'].includes(b) ? 'bg-gray-200 dark:bg-white/5' : 'bg-white dark:bg-white/10 border border-gray-200 dark:border-gray-700'}`}>{b}</button>
                                    ))}
                                    {['1', '2', '3', '+'].map(b => (
                                        <button key={b} onClick={() => handleCalcInput(b)} className={`p-3 rounded-lg font-bold ${['+'].includes(b) ? 'bg-gray-200 dark:bg-white/5' : 'bg-white dark:bg-white/10 border border-gray-200 dark:border-gray-700'}`}>{b}</button>
                                    ))}
                                    {['0', '.', 'π', '='].map(b => (
                                        <button key={b} onClick={() => handleCalcInput(b)} className={`p-3 rounded-lg font-bold ${b === '=' ? 'bg-primary text-black' : 'bg-white dark:bg-white/10 border border-gray-200 dark:border-gray-700'}`}>{b}</button>
                                    ))}
                                </div>
                             </div>
                          )}
                      </div>
                  </div>
              )}

              <div className="lg:col-span-7 flex flex-col min-h-[350px]">
                <div className="bg-surface-light dark:bg-surface-dark border border-gray-200 dark:border-gray-800 rounded-2xl p-8 shadow-apple flex flex-col gap-6 relative overflow-hidden">
                   <div className="flex justify-end items-start">
                    <button 
                        onClick={() => setShowReportModal(true)}
                        className="text-text-muted hover:text-red-500 transition-colors" 
                        title="Report Issue"
                    >
                      <span className="material-symbols-outlined text-xl text-gray-400 hover:text-red-500 transition-colors">flag</span>
                    </button>
                  </div>

                  <div className="flex-grow flex flex-col gap-6">
                    <p className="text-lg md:text-xl text-text-main dark:text-gray-100 font-medium leading-relaxed">
                      {question.prompt}
                    </p>
                    
                    <div className="flex justify-center py-8">
                      {renderMath(question.latex)}
                    </div>
                  </div>
                </div>
              </div>

              <div className="lg:col-span-5 flex flex-col gap-6">
                 <div className="bg-surface-light dark:bg-surface-dark border border-gray-200 dark:border-gray-800 rounded-2xl p-6 md:p-8 shadow-apple flex flex-col gap-6">
                    <div>
                        <h3 className="text-text-main dark:text-white text-lg font-bold mb-1">
                            {isSubmitted ? (feedback === 'correct' ? 'Correct!' : 'Incorrect') : 'Select your answer'}
                        </h3>
                        <p className={`text-sm ${isSubmitted ? (feedback === 'correct' ? 'text-green-600' : 'text-red-500') : 'text-gray-500'}`}>
                            {isSubmitted ? (feedback === 'correct' ? 'Great job! See explanation below.' : 'Try to review the concept.') : 'Choose the best option below.'}
                        </p>
                    </div>

                    <div className="flex flex-col gap-3 mt-4">
                        {question.options.map((opt) => {
                            const isSelected = selectedAnswer === opt.id;
                            const isCorrect = question.correctOptionId === opt.id;
                            
                            let borderClass = 'border-gray-200 dark:border-gray-700';
                            let bgClass = 'bg-background-light dark:bg-background-dark';
                            
                            if (isSubmitted) {
                                if (isCorrect) {
                                    borderClass = 'border-green-500 bg-green-50 dark:bg-green-900/20';
                                } else if (isSelected && !isCorrect) {
                                    borderClass = 'border-red-500 bg-red-50 dark:bg-red-900/20';
                                }
                            } else if (isSelected) {
                                borderClass = 'border-primary';
                                bgClass = 'bg-white dark:bg-surface-dark ring-1 ring-primary';
                            }

                            return (
                                <label key={opt.id} className={`group relative flex cursor-pointer rounded-xl border ${borderClass} ${bgClass} p-4 transition-all duration-200 ${!isSubmitted && 'hover:border-primary/50'}`}>
                                    <input 
                                        type="radio" 
                                        name="answer" 
                                        className="peer sr-only" 
                                        value={opt.id} 
                                        checked={isSelected}
                                        onChange={() => !isSubmitted && setSelectedAnswer(opt.id)}
                                        disabled={isSubmitted}
                                    />
                                    <div className="flex items-center gap-4 relative z-10 w-full">
                                        <div className={`flex h-8 w-8 items-center justify-center rounded-full border text-sm font-bold transition-colors ${isSelected || (isSubmitted && isCorrect) ? 'bg-primary border-primary text-black' : 'bg-white dark:bg-white/10 border-gray-200 dark:border-gray-700 text-gray-500'}`}>
                                            {opt.label}
                                        </div>
                                        <div className="font-math text-lg text-text-main dark:text-gray-200">
                                            {opt.value}
                                        </div>
                                        {isSubmitted && isCorrect && <span className="material-symbols-outlined ml-auto text-green-600">check_circle</span>}
                                        {isSubmitted && isSelected && !isCorrect && <span className="material-symbols-outlined ml-auto text-red-500">cancel</span>}
                                    </div>
                                </label>
                            );
                        })}
                    </div>

                    {isSubmitted && (
                        <div className="text-sm text-gray-600 dark:text-gray-300 bg-gray-50 dark:bg-white/5 p-4 rounded-lg animate-fade-in">
                            <span className="font-bold">Explanation:</span> {question.explanation}
                        </div>
                    )}

                    <div className="pt-6 mt-4">
                        {!isSubmitted ? (
                            <button 
                                onClick={handleSubmit}
                                disabled={!selectedAnswer}
                                className="w-full flex items-center justify-center gap-2 rounded-xl bg-primary hover:bg-primary-hover py-3.5 px-4 text-text-main font-bold shadow-sm transition-all active:scale-[0.98] disabled:opacity-50 disabled:cursor-not-allowed"
                            >
                                <span>Submit Answer</span>
                                <span className="material-symbols-outlined text-lg">arrow_forward</span>
                            </button>
                        ) : (
                             <button 
                                onClick={handleNext}
                                className="w-full flex items-center justify-center gap-2 rounded-xl bg-black dark:bg-white hover:bg-gray-800 dark:hover:bg-gray-200 py-3.5 px-4 text-white dark:text-black font-bold shadow-sm transition-all active:scale-[0.98]"
                            >
                                <span>{currentQuestionIndex < questions.length - 1 ? 'Next Question' : 'Finish Practice'}</span>
                                <span className="material-symbols-outlined text-lg">arrow_forward</span>
                            </button>
                        )}
                    </div>
                 </div>
              </div>
            </div>
          </div>

          {/* Sidebar Tools */}
          <div className="hidden lg:flex flex-col gap-4 w-16 pt-32 sticky top-0 h-screen">
            <div className="flex flex-col items-center gap-4 bg-surface-light dark:bg-surface-dark border border-gray-200 dark:border-gray-800 rounded-full py-6 px-2 shadow-float">
                <button 
                    onClick={() => setActiveTool(activeTool === 'scratchpad' ? 'none' : 'scratchpad')}
                    className={`group relative flex items-center justify-center size-10 rounded-full transition-all ${activeTool === 'scratchpad' ? 'text-primary bg-black/5 dark:bg-white/10' : 'text-gray-500 hover:text-text-main hover:bg-gray-100 dark:hover:bg-white/10'}`}
                >
                    <span className="material-symbols-outlined">draw</span>
                    <div className="absolute right-14 top-1/2 -translate-y-1/2 px-2 py-1 bg-black text-white text-xs rounded opacity-0 group-hover:opacity-100 transition-opacity whitespace-nowrap pointer-events-none">Scratchpad</div>
                </button>
                <button 
                    onClick={() => setActiveTool(activeTool === 'formula' ? 'none' : 'formula')}
                    className={`group relative flex items-center justify-center size-10 rounded-full transition-all ${activeTool === 'formula' ? 'text-primary bg-black/5 dark:bg-white/10' : 'text-gray-500 hover:text-text-main hover:bg-gray-100 dark:hover:bg-white/10'}`}
                >
                    <span className="material-symbols-outlined">function</span>
                    <div className="absolute right-14 top-1/2 -translate-y-1/2 px-2 py-1 bg-black text-white text-xs rounded opacity-0 group-hover:opacity-100 transition-opacity whitespace-nowrap pointer-events-none">Formulas</div>
                </button>
                 <button 
                    onClick={() => setActiveTool(activeTool === 'calculator' ? 'none' : 'calculator')}
                    className={`group relative flex items-center justify-center size-10 rounded-full transition-all ${activeTool === 'calculator' ? 'text-primary bg-black/5 dark:bg-white/10' : 'text-gray-500 hover:text-text-main hover:bg-gray-100 dark:hover:bg-white/10'}`}
                >
                    <span className="material-symbols-outlined">calculate</span>
                    <div className="absolute right-14 top-1/2 -translate-y-1/2 px-2 py-1 bg-black text-white text-xs rounded opacity-0 group-hover:opacity-100 transition-opacity whitespace-nowrap pointer-events-none">Calculator</div>
                </button>
            </div>
          </div>

        </div>
      </main>

      {/* Exit Confirmation Modal */}
      {showExitConfirm && (
        <div className="fixed inset-0 z-[100] flex items-center justify-center p-4 bg-black/50 backdrop-blur-sm animate-fade-in">
            <div className="bg-white dark:bg-surface-dark rounded-2xl shadow-2xl max-w-sm w-full p-6 border border-gray-100 dark:border-gray-800 transform transition-all scale-100">
                <div className="flex flex-col items-center text-center gap-4 mb-6">
                    <div className="w-12 h-12 bg-yellow-100 dark:bg-yellow-900/20 text-yellow-600 dark:text-yellow-500 rounded-full flex items-center justify-center">
                        <span className="material-symbols-outlined text-2xl">save</span>
                    </div>
                    <div>
                        <h3 className="text-xl font-bold text-text-main dark:text-white">Exit Session?</h3>
                        <p className="text-gray-500 dark:text-gray-400 text-sm mt-2">
                            Are you sure you want to leave? Your progress ({sessionResults.correct} correct) will be automatically saved.
                        </p>
                    </div>
                </div>
                <div className="flex gap-3">
                    <button 
                        onClick={() => setShowExitConfirm(false)}
                        disabled={isSaving}
                        className="flex-1 py-3 rounded-xl font-bold text-gray-600 dark:text-gray-300 hover:bg-gray-100 dark:hover:bg-white/10 transition-colors disabled:opacity-50"
                    >
                        Cancel
                    </button>
                    <button 
                        onClick={handleConfirmExit}
                        disabled={isSaving}
                        className="flex-1 py-3 rounded-xl font-bold bg-primary text-text-main hover:brightness-105 transition-all flex items-center justify-center gap-2 shadow-sm disabled:opacity-70"
                    >
                        {isSaving ? (
                            <>
                                <span className="material-symbols-outlined animate-spin text-lg">progress_activity</span>
                                Saving...
                            </>
                        ) : (
                            'Exit & Save'
                        )}
                    </button>
                </div>
            </div>
        </div>
      )}

      {/* Report Modal */}
      {showReportModal && (
        <div className="fixed inset-0 z-[100] flex items-center justify-center p-4 bg-black/50 backdrop-blur-sm animate-fade-in">
            <div className="bg-white dark:bg-surface-dark rounded-2xl shadow-2xl max-w-md w-full p-6 border border-gray-100 dark:border-gray-800 transform transition-all scale-100">
                <div className="flex justify-between items-center mb-4">
                    <h3 className="text-xl font-bold text-text-main dark:text-white flex items-center gap-2">
                        <span className="material-symbols-outlined text-red-500">flag</span>
                        Report Issue
                    </h3>
                    <button onClick={() => setShowReportModal(false)} className="text-gray-400 hover:text-text-main dark:hover:text-white">
                        <span className="material-symbols-outlined">close</span>
                    </button>
                </div>
                
                <div className="flex flex-col gap-4">
                    <div className="flex flex-col gap-2">
                        <label className="text-sm font-bold text-gray-700 dark:text-gray-300">Issue Type</label>
                        <select 
                            value={reportReason} 
                            onChange={(e) => setReportReason(e.target.value)}
                            className="w-full p-3 rounded-xl border border-gray-200 dark:border-gray-700 bg-transparent outline-none focus:ring-2 focus:ring-primary/50 text-sm"
                        >
                            <option value="content_error">Content Error (Question/Answer)</option>
                            <option value="formatting">Formatting/Display Issue</option>
                            <option value="explanation">Explanation is confusing</option>
                            <option value="other">Other</option>
                        </select>
                    </div>
                    <div className="flex flex-col gap-2">
                         <label className="text-sm font-bold text-gray-700 dark:text-gray-300">Details (Optional)</label>
                         <textarea 
                            placeholder="Please describe the issue..."
                            className="w-full p-3 rounded-xl border border-gray-200 dark:border-gray-700 bg-transparent outline-none focus:ring-2 focus:ring-primary/50 text-sm h-24 resize-none"
                         ></textarea>
                    </div>
                </div>

                <div className="flex gap-3 mt-6">
                    <button 
                        onClick={() => setShowReportModal(false)}
                        disabled={isReporting}
                        className="flex-1 py-3 rounded-xl font-bold text-gray-600 dark:text-gray-300 hover:bg-gray-100 dark:hover:bg-white/10 transition-colors disabled:opacity-50"
                    >
                        Cancel
                    </button>
                    <button 
                        onClick={handleReportSubmit}
                        disabled={isReporting}
                        className="flex-1 py-3 rounded-xl font-bold bg-black dark:bg-white text-white dark:text-black hover:opacity-90 transition-all flex items-center justify-center gap-2 shadow-sm disabled:opacity-70"
                    >
                        {isReporting ? (
                            <>
                                <span className="material-symbols-outlined animate-spin text-lg">progress_activity</span>
                                Sending...
                            </>
                        ) : (
                            'Submit Report'
                        )}
                    </button>
                </div>
            </div>
        </div>
      )}
    </div>
  );
};