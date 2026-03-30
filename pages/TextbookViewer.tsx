import React, { useState, useEffect, useCallback } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import { useApp } from '../AppContext';
import { TEXTBOOK_DATA, TextbookInfo } from '../constants';
import { PointsCoin } from '../components/PointsCoin';
import { Navbar } from '../components/Navbar';

export const TextbookViewer = () => {
    const { courseType, unitNumber } = useParams<{ courseType: string; unitNumber: string }>();
    const navigate = useNavigate();
    const { user, userPoints, isAuthenticated, triggerCoinAnimation, fetchUserPoints } = useApp();

    const [isUnlocked, setIsUnlocked] = useState(false);
    const [isProcessing, setIsProcessing] = useState(false);
    const [purchasedBookCount, setPurchasedBookCount] = useState<number | null>(null); // null = loading
    const [showPurchaseModal, setShowPurchaseModal] = useState(false);
    const [purchaseError, setPurchaseError] = useState('');
    const [iframeLoaded, setIframeLoaded] = useState(false);

    // Resolve book data
    const course = (courseType?.toUpperCase() || 'BC') as 'AB' | 'BC';
    const unitNum = parseInt(unitNumber || '1', 10);
    const books = TEXTBOOK_DATA[course] || [];
    const book: TextbookInfo | undefined = books.find(b => b.unitNumber === unitNum);

    const unlockKey = `book_unlocked_${course}_${unitNum}`;
    const UNLOCK_COST = 19;

    // Check if THIS book is already unlocked (localStorage)
    useEffect(() => {
        const unlocked = localStorage.getItem(unlockKey);
        setIsUnlocked(!!unlocked);
    }, [unlockKey]);

    // Check how many books user has already purchased/claimed (to determine first-book-free)
    useEffect(() => {
        const checkPurchaseCount = async () => {
            if (!user?.id) return;
            try {
                const { supabase } = await import('../src/services/supabaseClient');
                const { data, error } = await supabase
                    .from('points_ledger')
                    .select('id')
                    .eq('user_id', user.id)
                    .eq('type', 'book_download');
                
                if (!error) {
                    setPurchasedBookCount(data?.length || 0);
                }
            } catch (err) {
                console.error('Error checking purchase count:', err);
                setPurchasedBookCount(0);
            }
        };
        checkPurchaseCount();
    }, [user?.id]);

    const isFirstBookFree = purchasedBookCount === 0;
    const currentCost = isFirstBookFree ? 0 : UNLOCK_COST;

    // Determine if this book should be freely accessible
    // A book is accessible if: already unlocked OR it's loading state
    const canView = isUnlocked;

    // When user clicks on a locked book, show purchase modal OR auto-unlock first free book
    const handleUnlockClick = useCallback(() => {
        if (canView) return; // Already accessible
        if (!isAuthenticated) return;

        if (isFirstBookFree) {
            // Auto-claim first free book
            claimBook();
        } else {
            // Show purchase modal
            setPurchaseError('');
            setShowPurchaseModal(true);
        }
    }, [canView, isAuthenticated, isFirstBookFree]);

    const claimBook = async () => {
        if (!book || !user?.id) return;
        setIsProcessing(true);
        setPurchaseError('');

        const cost = currentCost;

        if (cost > 0 && userPoints.balance < cost) {
            setPurchaseError(`金币不足！需要 ${cost} 金币，你只有 ${userPoints.balance} 金币。`);
            setIsProcessing(false);
            return;
        }

        try {
            const { supabase } = await import('../src/services/supabaseClient');
            
            // Insert a record into points_ledger
            const { error: insertError } = await supabase
                .from('points_ledger')
                .insert({
                    user_id: user.id,
                    amount: -cost,
                    type: 'book_download',
                    description: cost === 0 
                        ? `FREE First Book: ${course} Unit ${unitNum} - ${book.title}`
                        : `Unlocked: ${course} Unit ${unitNum} - ${book.title} (${UNLOCK_COST} Coins)`,
                    source_id: `book_${course}_${unitNum}`
                });

            if (insertError) {
                console.error('Purchase insert error:', insertError);
                setPurchaseError('解锁失败，请重试。');
                setIsProcessing(false);
                return;
            }

            // Trigger spend animation only if cost > 0
            if (cost > 0) {
                triggerCoinAnimation(cost, window.innerWidth / 2, window.innerHeight / 2, 'spend');
            }

            // Mark as unlocked
            localStorage.setItem(unlockKey, new Date().toISOString());
            setIsUnlocked(true);
            setShowPurchaseModal(false);
            setPurchasedBookCount((prev) => (prev ?? 0) + 1);

            // Refresh points balance
            await fetchUserPoints();
            setIsProcessing(false);
        } catch (err) {
            console.error('Purchase error:', err);
            setPurchaseError('解锁失败，请重试。');
            setIsProcessing(false);
        }
    };

    if (!book) {
        return (
            <div className="h-full w-full flex flex-col items-center justify-center bg-background-light dark:bg-background-dark text-text-main dark:text-white">
                <span className="material-symbols-outlined text-6xl text-gray-300 mb-4">menu_book</span>
                <h2 className="text-2xl font-black mb-2">Book Not Found</h2>
                <p className="text-gray-500 mb-6">The requested textbook could not be found.</p>
                <button onClick={() => navigate(-1)} className="px-6 py-3 bg-primary text-text-main font-bold rounded-xl shadow-md hover:brightness-105 transition-all">
                    Go Back
                </button>
            </div>
        );
    }

    return (
        <div className="h-full bg-background-light dark:bg-background-dark text-text-main dark:text-gray-100 flex flex-col overflow-hidden">
            <Navbar />
            
            <main className="flex-grow w-full max-w-7xl mx-auto px-6 py-8 flex flex-col overflow-hidden">
                {/* Header Section */}
                <div className="flex flex-col sm:flex-row sm:items-end justify-between gap-4 mb-6 shrink-0">
                    <div>
                        <button
                            onClick={() => navigate('/practice')}
                            className="flex items-center gap-2 text-sm font-bold text-gray-500 hover:text-text-main dark:text-gray-400 dark:hover:text-white transition-colors mb-6"
                        >
                            <span className="material-symbols-outlined">arrow_back</span>
                            Back to Practice Hub
                        </button>
                        
                        <div className="flex items-center gap-3 mb-2">
                            <div
                                className="w-10 h-10 rounded-xl flex items-center justify-center text-white text-lg shadow-sm"
                                style={{ background: book.coverColor }}
                            >
                                <span className="material-symbols-outlined">{book.icon}</span>
                            </div>
                            <span className="text-sm font-bold uppercase tracking-wider text-gray-500">Unit {book.unitNumber} Textbook</span>
                        </div>
                        <h1 className="text-3xl md:text-4xl font-black tracking-tight">{book.title}</h1>
                        <p className="text-sm font-bold text-gray-400 uppercase tracking-wider mt-2">
                            {course} • {book.subtitle} • ~{book.pageCount} pages
                        </p>
                    </div>

                    <div className="flex items-center gap-3">
                        {/* Fullscreen toggle */}
                        <button
                            onClick={() => {
                                const container = document.getElementById('viewer-container');
                                if (container) {
                                    if (document.fullscreenElement) {
                                        document.exitFullscreen();
                                    } else {
                                        container.requestFullscreen?.();
                                    }
                                }
                            }}
                            className="w-11 h-11 flex items-center justify-center rounded-xl bg-gray-100 dark:bg-white/5 border border-gray-200 dark:border-gray-800 hover:bg-gray-200 dark:hover:bg-white/10 transition-all shadow-sm"
                            title="Fullscreen"
                        >
                            <span className="material-symbols-outlined text-lg text-gray-600 dark:text-gray-300">fullscreen</span>
                        </button>

                        {/* Unlock status badge (no download/save buttons) */}
                        {book.available && canView && (
                            <div className="h-11 px-5 rounded-xl font-bold text-sm flex items-center gap-2 bg-green-50 dark:bg-green-900/20 border border-green-200 dark:border-green-800 text-green-700 dark:text-green-400">
                                <span className="material-symbols-outlined text-[18px]">lock_open</span>
                                <span>已解锁</span>
                            </div>
                        )}
                    </div>
                </div>

                {/* PDF Viewer OR Lock Screen */}
                <div id="viewer-container" className="flex-1 min-h-0 bg-gray-100 dark:bg-[#1a1c23] rounded-3xl border border-gray-200 dark:border-gray-800 overflow-hidden relative shadow-inner">
                    {book.available ? (
                        canView ? (
                            /* UNLOCKED: Show PDF with full native controls */
                            <>
                                {!iframeLoaded && (
                                    <div className="absolute inset-0 flex flex-col items-center justify-center gap-4 z-10 bg-gray-100 dark:bg-[#1a1c23]">
                                        <div className="w-10 h-10 border-4 border-primary border-t-transparent rounded-full animate-spin"></div>
                                        <span className="text-sm font-bold text-gray-500 uppercase tracking-wider">Opening Textbook...</span>
                                    </div>
                                )}
                                <iframe
                                    id="pdf-viewer"
                                    src={`${book.pdfUrl}?v=nocache#toolbar=1&navpanes=0&scrollbar=1&view=FitH`}
                                    className={`w-full h-full border-0 transition-opacity duration-500 rounded-3xl ${iframeLoaded ? 'opacity-100' : 'opacity-0'}`}
                                    title={`${book.title} - Review Book`}
                                    onLoad={() => setIframeLoaded(true)}
                                />
                                {/* NO overlay - native PDF controls fully accessible */}
                            </>
                        ) : (
                            /* LOCKED: Show unlock prompt */
                            <div className="flex flex-col items-center justify-center h-full gap-6 p-8">
                                <div
                                    className="w-28 h-36 rounded-2xl flex items-center justify-center shadow-lg relative overflow-hidden"
                                    style={{ background: `linear-gradient(135deg, ${book.coverColor}22, ${book.coverColor}44)` }}
                                >
                                    <span className="material-symbols-outlined text-5xl" style={{ color: book.coverColor }}>menu_book</span>
                                    <div className="absolute inset-0 flex items-center justify-center bg-black/40 backdrop-blur-sm">
                                        <span className="material-symbols-outlined text-4xl text-white/80">lock</span>
                                    </div>
                                </div>
                                <div className="text-center max-w-md">
                                    <h3 className="text-2xl font-black text-text-main dark:text-white mb-2">
                                        {purchasedBookCount === null ? '加载中...' : (isFirstBookFree ? '🎉 第一本书免费！' : '解锁此教材')}
                                    </h3>
                                    <p className="text-gray-500 dark:text-gray-400 font-medium mb-6">
                                        {isFirstBookFree 
                                            ? `点击下方按钮免费领取 Unit ${book.unitNumber}: ${book.title}，即可开始阅读。`
                                            : `解锁 Unit ${book.unitNumber}: ${book.title} 需要 ${UNLOCK_COST} 金币。`
                                        }
                                    </p>
                                    
                                    {/* Cost info */}
                                    {!isFirstBookFree && (
                                        <div className="flex items-center justify-center gap-3 mb-4">
                                            <div className="flex items-center gap-2 bg-gray-50 dark:bg-white/5 rounded-2xl px-5 py-3">
                                                <PointsCoin size="md" />
                                                <span className="text-2xl font-black text-text-main dark:text-white">{UNLOCK_COST}</span>
                                                <span className="text-sm text-gray-500">金币</span>
                                            </div>
                                            <span className="text-sm text-gray-400">
                                                余额: <span className={`font-bold ${userPoints.balance >= UNLOCK_COST ? 'text-green-500' : 'text-red-500'}`}>
                                                    {userPoints.balance}
                                                </span>
                                            </span>
                                        </div>
                                    )}

                                    <button
                                        onClick={handleUnlockClick}
                                        disabled={isProcessing || purchasedBookCount === null || (!isFirstBookFree && userPoints.balance < UNLOCK_COST)}
                                        className={`px-8 py-4 rounded-2xl font-black text-base flex items-center justify-center gap-2 mx-auto transition-all ${
                                            (purchasedBookCount === null || (!isFirstBookFree && userPoints.balance < UNLOCK_COST))
                                                ? 'bg-gray-200 dark:bg-gray-700 text-gray-400 cursor-not-allowed'
                                                : 'bg-primary text-text-main shadow-lg hover:brightness-105 active:scale-[0.98]'
                                        }`}
                                    >
                                        {isProcessing ? (
                                            <span className="w-5 h-5 border-2 border-current border-t-transparent rounded-full animate-spin"></span>
                                        ) : (
                                            <>
                                                <span className="material-symbols-outlined text-[20px]">{isFirstBookFree ? 'redeem' : 'lock_open'}</span>
                                                {isFirstBookFree ? '免费领取' : '解锁阅读'}
                                            </>
                                        )}
                                    </button>
                                </div>
                            </div>
                        )
                    ) : (
                        <div className="flex flex-col items-center justify-center h-full gap-6">
                            <div
                                className="w-24 h-32 rounded-2xl flex items-center justify-center shadow-lg relative overflow-hidden"
                                style={{ background: `linear-gradient(135deg, ${book.coverColor}22, ${book.coverColor}44)` }}
                            >
                                <span className="material-symbols-outlined text-5xl" style={{ color: book.coverColor }}>menu_book</span>
                                <div className="absolute inset-0 flex items-center justify-center bg-black/40 backdrop-blur-sm">
                                    <span className="material-symbols-outlined text-4xl text-white/80">lock</span>
                                </div>
                            </div>
                            <div className="text-center">
                                <h3 className="text-2xl font-black text-text-main dark:text-white mb-2 uppercase tracking-tight">Coming Soon</h3>
                                <p className="text-gray-500 dark:text-gray-400 max-w-sm mx-auto font-medium">
                                    Unit {book.unitNumber}: {book.title} is currently under review. It will be available shortly!
                                </p>
                            </div>
                        </div>
                    )}
                </div>
            </main>

            {/* Purchase Confirmation Modal (only for non-first books) */}
            {showPurchaseModal && (
                <div className="fixed inset-0 z-[200] flex items-center justify-center p-4 bg-black/60 backdrop-blur-sm animate-fade-in">
                    <div className="bg-surface-light dark:bg-surface-dark w-full max-w-sm rounded-3xl p-6 shadow-2xl border border-white/20 relative animate-fade-in-up">
                        <button
                            onClick={() => setShowPurchaseModal(false)}
                            className="absolute top-4 right-4 p-1 rounded-full hover:bg-gray-100 dark:hover:bg-white/10 transition-colors text-gray-400"
                        >
                            <span className="material-symbols-outlined text-xl">close</span>
                        </button>

                        <div className="flex flex-col items-center text-center">
                            {/* Book Preview */}
                            <div
                                className="w-20 h-28 rounded-2xl flex items-center justify-center text-white shadow-lg mb-5 relative overflow-hidden"
                                style={{ background: `linear-gradient(135deg, ${book.coverColor}, ${book.coverColor}cc)` }}
                            >
                                <span className="material-symbols-outlined text-4xl opacity-90">{book.icon}</span>
                                <div className="absolute bottom-0 left-0 right-0 bg-black/30 py-1 text-[9px] font-bold uppercase tracking-wider">
                                    Unit {book.unitNumber}
                                </div>
                            </div>

                            <h3 className="text-xl font-black text-text-main dark:text-white mb-1">解锁教材</h3>
                            <p className="text-sm text-gray-500 dark:text-gray-400 mb-5">
                                Unit {book.unitNumber}: {book.title}
                            </p>

                            {/* Cost Display */}
                            <div className="w-full bg-gray-50 dark:bg-white/5 rounded-2xl p-4 mb-5 flex items-center justify-between">
                                <span className="text-sm font-bold text-gray-600 dark:text-gray-300">解锁费用</span>
                                <div className="flex items-center gap-2">
                                    <PointsCoin size="md" />
                                    <span className="text-2xl font-black text-text-main dark:text-white">{UNLOCK_COST}</span>
                                </div>
                            </div>

                            {/* Balance Display */}
                            <div className="w-full flex items-center justify-between text-sm mb-5 px-1">
                                <span className="text-gray-400">你的余额</span>
                                <span className={`font-bold ${userPoints.balance >= UNLOCK_COST ? 'text-green-500' : 'text-red-500'}`}>
                                    {userPoints.balance} 金币
                                </span>
                            </div>

                            {purchaseError && (
                                <div className="w-full bg-red-50 dark:bg-red-900/20 text-red-600 dark:text-red-400 text-xs font-bold px-4 py-3 rounded-xl mb-4">
                                    {purchaseError}
                                </div>
                            )}

                            <div className="flex flex-col gap-3 w-full">
                                <button
                                    onClick={() => claimBook()}
                                    disabled={isProcessing || userPoints.balance < UNLOCK_COST}
                                    className={`w-full py-4 rounded-xl font-black text-base flex items-center justify-center gap-2 transition-all ${
                                        userPoints.balance >= UNLOCK_COST
                                            ? 'bg-primary text-text-main shadow-lg hover:brightness-105 active:scale-[0.98]'
                                            : 'bg-gray-200 dark:bg-gray-700 text-gray-400 cursor-not-allowed'
                                    }`}
                                >
                                    {isProcessing ? (
                                        <span className="w-5 h-5 border-2 border-current border-t-transparent rounded-full animate-spin"></span>
                                    ) : (
                                        <>
                                            <span className="material-symbols-outlined text-[20px]">lock_open</span>
                                            确认解锁
                                        </>
                                    )}
                                </button>
                                <button
                                    onClick={() => setShowPurchaseModal(false)}
                                    className="w-full py-3 text-sm font-bold text-gray-400 hover:text-text-main dark:hover:text-white transition-colors"
                                >
                                    取消
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            )}
        </div>
    );
};
