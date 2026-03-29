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

    const [isPurchased, setIsPurchased] = useState(false);
    const [isDownloading, setIsDownloading] = useState(false);
    const [hasAnyPurchase, setHasAnyPurchase] = useState<boolean | null>(null); // null means loading
    const [showPurchaseModal, setShowPurchaseModal] = useState(false);
    const [purchaseError, setPurchaseError] = useState('');
    const [iframeLoaded, setIframeLoaded] = useState(false);

    // Resolve book data
    const course = (courseType?.toUpperCase() || 'BC') as 'AB' | 'BC';
    const unitNum = parseInt(unitNumber || '1', 10);
    const books = TEXTBOOK_DATA[course] || [];
    const book: TextbookInfo | undefined = books.find(b => b.unitNumber === unitNum);

    const purchaseKey = `book_purchased_${course}_${unitNum}`;

    useEffect(() => {
        const purchased = localStorage.getItem(purchaseKey);
        setIsPurchased(!!purchased);
    }, [purchaseKey]);

    // Check if user has ever purchased a book (to handle "First Book Free")
    useEffect(() => {
        const checkFirstBook = async () => {
            if (!user?.id) return;
            try {
                const { supabase } = await import('../src/services/supabaseClient');
                const { data, error } = await supabase
                    .from('points_ledger')
                    .select('id')
                    .eq('user_id', user.id)
                    .eq('type', 'book_download')
                    .limit(1);
                
                if (!error) {
                    setHasAnyPurchase(data && data.length > 0);
                }
            } catch (err) {
                console.error('Error checking first book status:', err);
                setHasAnyPurchase(false); // Default to free if check fails
            }
        };
        checkFirstBook();
    }, [user?.id]);

    const isFirstBookFree = hasAnyPurchase === false;
    const currentCost = isFirstBookFree ? 0 : (book?.downloadCost || 19);

    const handleDownload = useCallback(async (e: React.MouseEvent) => {
        if (!book || !book.available) return;

        if (isPurchased) {
            // Already purchased — free download
            triggerDownload();
            return;
        }

        // Show purchase confirmation modal
        setPurchaseError('');
        setShowPurchaseModal(true);
    }, [book, isPurchased]);

    const confirmPurchase = async (e: React.MouseEvent) => {
        if (!book || !isAuthenticated) return;
        setIsDownloading(true);
        setPurchaseError('');

        const cost = currentCost;

        if (userPoints.balance < cost) {
            setPurchaseError(`Insufficient coins! You need ${cost} coins but only have ${userPoints.balance}.`);
            setIsDownloading(false);
            return;
        }

        try {
            const { supabase } = await import('../src/services/supabaseClient');
            
            // Insert a record into points_ledger
            // If it's the first book, amount is 0
            const { error: insertError } = await supabase
                .from('points_ledger')
                .insert({
                    user_id: user.id,
                    amount: -cost,
                    type: 'book_download',
                    description: isFirstBookFree 
                        ? `FREE First Book: ${course} Unit ${unitNum} - ${book.title}`
                        : `Purchased: ${course} Unit ${unitNum} - ${book.title}`,
                    source_id: `book_${course}_${unitNum}`
                });

            if (insertError) {
                console.error('Purchase insert error:', insertError);
            }

            // Trigger spend animation only if cost > 0
            if (cost > 0) {
                const btnRect = (e.target as HTMLElement).getBoundingClientRect();
                triggerCoinAnimation(cost, btnRect.left + btnRect.width / 2, btnRect.top + btnRect.height / 2, 'spend');
            }

            // Mark as purchased
            localStorage.setItem(purchaseKey, new Date().toISOString());
            setIsPurchased(true);
            setShowPurchaseModal(false);
            setHasAnyPurchase(true);

            // Refresh points balance
            await fetchUserPoints();

            // Success feedback
            setIsDownloading(false);
        } catch (err) {
            console.error('Purchase error:', err);
            setPurchaseError('Purchase failed. Please try again.');
            setIsDownloading(false);
        }
    };

    const handleUnlock = () => {
        if (!isAuthenticated) return;
        setShowPurchaseModal(true);
    };

    const triggerDownload = () => {
        if (!book) return;
        const link = document.createElement('a');
        link.href = book.pdfUrl;
        link.download = `AP_Calculus_${course}_Unit_${unitNum}_Review_Book.pdf`;
        document.body.appendChild(link);
        link.click();
        document.body.removeChild(link);
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

                        {/* Download Logic (Always Visible After Unit Purchase) */}
                        {book.available && isPurchased && (
                            <div className="flex items-center gap-3">
                                <button
                                    onClick={handleDownload}
                                    disabled={isDownloading}
                                    className="h-11 px-5 rounded-xl bg-green-50 dark:bg-green-900/20 border border-green-200 dark:border-green-800 text-green-700 dark:text-green-400 font-bold text-sm flex items-center gap-2 hover:bg-green-100 dark:hover:bg-green-900/30 transition-all shadow-sm"
                                >
                                    <span className="material-symbols-outlined text-[18px]">download</span>
                                    <span>Download PDF</span>
                                </button>
                                <button
                                    onClick={() => window.open(book.pdfUrl, '_blank')}
                                    className="h-11 px-5 rounded-xl bg-blue-50 dark:bg-blue-900/20 border border-blue-200 dark:border-blue-800 text-blue-700 dark:text-blue-400 font-bold text-sm flex items-center gap-2 hover:bg-blue-100 dark:hover:bg-blue-900/30 transition-all shadow-sm"
                                >
                                    <span className="material-symbols-outlined text-[18px]">add_to_drive</span>
                                    <span className="hidden sm:inline">Open to Save</span>
                                </button>
                            </div>
                        )}
                    </div>
                </div>

                {/* CONTENT AREA: Iframe (if purchased) OR Lock Screen (if not) */}
                <div id="viewer-container" className="flex-1 min-h-0 bg-gray-100 dark:bg-[#1a1c23] rounded-3xl border border-gray-200 dark:border-gray-800 overflow-hidden relative shadow-inner">
                    {!book.available ? (
                        <div className="flex flex-col items-center justify-center h-full gap-6 p-8">
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
                    ) : isPurchased ? (
                        <>
                            {!iframeLoaded && (
                                <div className="absolute inset-0 flex flex-col items-center justify-center gap-4 z-10 bg-gray-100 dark:bg-[#1a1c23]">
                                    <div className="w-10 h-10 border-4 border-primary border-t-transparent rounded-full animate-spin"></div>
                                    <span className="text-sm font-bold text-gray-500 uppercase tracking-wider">Opening Textbook...</span>
                                </div>
                            )}
                            <div className="relative w-full h-full">
                                <iframe
                                    id="pdf-viewer"
                                    src={`${book.pdfUrl}?v=nocache#toolbar=1&navpanes=0&scrollbar=1&view=FitH`}
                                    className={`w-full h-full border-0 transition-opacity duration-500 rounded-3xl ${iframeLoaded ? 'opacity-100' : 'opacity-0'}`}
                                    title={`${book.title} - Review Book`}
                                    onLoad={() => setIframeLoaded(true)}
                                />
                                <div 
                                    className="absolute top-0 right-0 w-[160px] h-[55px] z-50 pointer-events-auto bg-transparent cursor-default"
                                    title="Navigation buttons are disabled in free mode"
                                    onClick={(e) => e.stopPropagation()}
                                    onContextMenu={(e) => e.preventDefault()}
                                />
                            </div>
                        </>
                    ) : (
                        /* PREMIUM LOCKED UI */
                        <div className="flex flex-col items-center justify-center h-full p-8 text-center bg-gradient-to-b from-white to-gray-50 dark:from-[#1a1c23] dark:to-[#14161d]">
                            <div className="relative mb-8">
                                <div 
                                    className="w-40 h-56 rounded-2xl flex flex-col items-center justify-center text-white shadow-2xl relative overflow-hidden transform -rotate-1 hover:rotate-0 transition-transform duration-500"
                                    style={{ background: `linear-gradient(135deg, ${book.coverColor}, ${book.coverColor}dd)` }}
                                >
                                    <span className="material-symbols-outlined text-7xl mb-4 drop-shadow-lg opacity-90">{book.icon}</span>
                                    <div className="absolute top-0 left-0 w-full h-1 bg-white/20" />
                                    <div className="absolute bottom-0 left-0 right-0 bg-black/40 py-2.5 backdrop-blur-md">
                                        <p className="text-[10px] font-black uppercase tracking-[0.2em]">AP CALC REVIEW</p>
                                    </div>
                                    <div className="absolute inset-0 bg-gradient-to-tr from-white/10 to-transparent pointer-events-none" />
                                </div>
                                <div className="absolute -bottom-4 -right-4 w-12 h-12 bg-yellow-400 dark:bg-yellow-500 rounded-full flex items-center justify-center shadow-lg border-4 border-white dark:border-[#1a1c23] animate-bounce">
                                    <span className="material-symbols-outlined text-gray-900 font-bold">lock</span>
                                </div>
                            </div>

                            <h2 className="text-3xl font-black text-text-main dark:text-white mb-3">Unit {book.unitNumber}: {book.title}</h2>
                            <p className="text-gray-500 dark:text-gray-400 font-bold max-w-md mb-10 leading-relaxed uppercase tracking-wide text-xs">
                                Full review textbook includes summarized concepts, <br/>essential formulas, and practice strategies.
                            </p>

                            <button
                                onClick={handleUnlock}
                                disabled={isDownloading || hasAnyPurchase === null}
                                className={`group relative px-10 py-5 rounded-2xl font-black text-lg shadow-xl transition-all hover:scale-105 active:scale-95 ${
                                    isFirstBookFree 
                                    ? 'bg-green-500 hover:bg-green-600 text-white shadow-green-500/20' 
                                    : 'bg-primary hover:bg-primary-dark text-text-main shadow-primary/20'
                                }`}
                            >
                                <div className="flex items-center gap-3">
                                    {isFirstBookFree ? (
                                        <>
                                            <span className="material-symbols-outlined">redeem</span>
                                            <span>CLAIM FREE FIRST BOOK</span>
                                        </>
                                    ) : (
                                        <>
                                            <PointsCoin size="md" />
                                            <span>UNLOCK FOR {book.downloadCost} COINS</span>
                                        </>
                                    )}
                                </div>
                                {isFirstBookFree && (
                                    <span className="absolute -top-3 -right-3 bg-yellow-400 text-gray-900 text-[10px] font-black px-2 py-1 rounded-full border-2 border-white dark:border-[#1a1c23] shadow-md">
                                        NEW USER DEAL
                                    </span>
                                )}
                            </button>
                            
                            {!isFirstBookFree && (
                                <p className="mt-6 text-sm font-bold text-gray-400 flex items-center gap-2">
                                    <span className="material-symbols-outlined text-sm">verified_user</span>
                                    ONE-TIME PURCHASE • PERMANENT ACCESS
                                </p>
                            )}
                        </div>
                    )}
                </div>
            </main>

            {/* Purchase Confirmation Modal */}
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

                            <h3 className="text-xl font-black text-text-main dark:text-white mb-1">Download Book</h3>
                            <p className="text-sm text-gray-500 dark:text-gray-400 mb-5">
                                Unit {book.unitNumber}: {book.title}
                            </p>

                            {/* Cost Display */}
                            <div className="w-full bg-gray-50 dark:bg-white/5 rounded-2xl p-4 mb-5 flex items-center justify-between">
                                <span className="text-sm font-bold text-gray-600 dark:text-gray-300">{isFirstBookFree ? 'Offer' : 'Unlock Cost'}</span>
                                <div className="flex items-center gap-2">
                                    <PointsCoin size="md" />
                                    <span className="text-2xl font-black text-text-main dark:text-white">{currentCost}</span>
                                </div>
                            </div>

                            {/* Balance Display */}
                            <div className="w-full flex items-center justify-between text-sm mb-5 px-1">
                                <span className="text-gray-400">Your Balance</span>
                                <span className={`font-bold ${userPoints.balance >= currentCost ? 'text-green-500' : 'text-red-500'}`}>
                                    {userPoints.balance} coins
                                </span>
                            </div>

                            {purchaseError && (
                                <div className="w-full bg-red-50 dark:bg-red-900/20 text-red-600 dark:text-red-400 text-xs font-bold px-4 py-3 rounded-xl mb-4">
                                    {purchaseError}
                                </div>
                            )}

                            <div className="flex flex-col gap-3 w-full">
                                <button
                                    onClick={confirmPurchase}
                                    disabled={isDownloading || userPoints.balance < currentCost}
                                    className={`w-full py-4 rounded-xl font-black text-base flex items-center justify-center gap-2 transition-all ${
                                        userPoints.balance >= currentCost
                                            ? 'bg-primary text-text-main shadow-lg hover:brightness-105 active:scale-[0.98]'
                                            : 'bg-gray-200 dark:bg-gray-700 text-gray-400 cursor-not-allowed'
                                    }`}
                                >
                                    {isDownloading ? (
                                        <span className="w-5 h-5 border-2 border-current border-t-transparent rounded-full animate-spin"></span>
                                    ) : (
                                        <>
                                            <span className="material-symbols-outlined text-[20px]">{isFirstBookFree ? 'redeem' : 'lock_open'}</span>
                                            {isFirstBookFree ? 'Claim Free Book' : 'Confirm & Unlock'}
                                        </>
                                    )}
                                </button>
                                <button
                                    onClick={() => setShowPurchaseModal(false)}
                                    className="w-full py-3 text-sm font-bold text-gray-400 hover:text-text-main dark:hover:text-white transition-colors"
                                >
                                    Cancel
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            )}
        </div>
    );
};
