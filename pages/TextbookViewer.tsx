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

        const cost = book.downloadCost;

        if (userPoints.balance < cost) {
            setPurchaseError(`Insufficient coins! You need ${cost} coins but only have ${userPoints.balance}.`);
            setIsDownloading(false);
            return;
        }

        try {
            // Use the Supabase RPC for spending (award_points with negative description trick)
            // Since award_points checks amount > 0, we use purchase_stardust pattern
            // For now: localStorage-based tracking + visual deduction
            const { supabase } = await import('../src/services/supabaseClient');
            
            // Insert a deduction record into points_ledger
            const { error: insertError } = await supabase
                .from('points_ledger')
                .insert({
                    user_id: user.id,
                    amount: -cost,
                    type: 'book_download',
                    description: `Downloaded: ${course} Unit ${unitNum} - ${book.title}`,
                    source_id: `book_${course}_${unitNum}`
                });

            if (insertError) {
                console.error('Purchase insert error:', insertError);
                // Fallback: use localStorage only
            }

            // Trigger spend animation
            const btnRect = (e.target as HTMLElement).getBoundingClientRect();
            triggerCoinAnimation(cost, btnRect.left + btnRect.width / 2, btnRect.top + btnRect.height / 2, 'spend');

            // Mark as purchased
            localStorage.setItem(purchaseKey, new Date().toISOString());
            setIsPurchased(true);
            setShowPurchaseModal(false);

            // Refresh points balance
            await fetchUserPoints();

            // Auto-trigger download
            setTimeout(() => {
                triggerDownload();
                setIsDownloading(false);
            }, 1200);
        } catch (err) {
            console.error('Purchase error:', err);
            setPurchaseError('Purchase failed. Please try again.');
            setIsDownloading(false);
        }
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
                        {/* Download Button */}
                        {book.available && (
                            <button
                                onClick={handleDownload}
                                disabled={isDownloading}
                                className={`h-11 px-6 rounded-2xl font-bold text-sm flex items-center gap-2.5 transition-all shadow-sm ${
                                    isPurchased
                                        ? 'bg-green-50 dark:bg-green-900/20 border border-green-200 dark:border-green-800 text-green-700 dark:text-green-400 hover:bg-green-100 dark:hover:bg-green-900/30'
                                        : 'bg-gray-900 dark:bg-white text-white dark:text-gray-900 hover:-translate-y-0.5 shadow-md hover:shadow-lg'
                                } ${isDownloading ? 'opacity-60 cursor-not-allowed' : ''}`}
                            >
                                {isDownloading ? (
                                    <span className="w-5 h-5 border-2 border-current border-t-transparent rounded-full animate-spin"></span>
                                ) : isPurchased ? (
                                    <>
                                        <span className="material-symbols-outlined text-[18px]">download</span>
                                        <span>Download PDF</span>
                                    </>
                                ) : (
                                    <>
                                        <span className="-mr-1"><PointsCoin size="sm" /></span>
                                        <span className="font-black text-[15px]">{book.downloadCost}</span>
                                        <span className="ml-1 opacity-90 border-l border-white/20 dark:border-black/10 pl-3">Unlock Download</span>
                                    </>
                                )}
                            </button>
                        )}
                    </div>
                </div>

                {/* PDF Viewer - Flex-1 to take remaining height */}
                <div className="flex-1 min-h-0 bg-gray-100 dark:bg-[#1a1c23] rounded-3xl border border-gray-200 dark:border-gray-800 overflow-hidden relative shadow-inner">
                    {book.available ? (
                        <>
                            {!iframeLoaded && (
                                <div className="absolute inset-0 flex flex-col items-center justify-center gap-4 z-10">
                                    <div className="w-10 h-10 border-4 border-primary border-t-transparent rounded-full animate-spin"></div>
                                    <span className="text-sm font-bold text-gray-500 uppercase tracking-wider">Loading TextBook...</span>
                                </div>
                            )}
                            <iframe
                                id="pdf-viewer"
                                src={`${book.pdfUrl}#toolbar=1&navpanes=0&scrollbar=1&view=FitH`}
                                className={`w-full h-full border-0 transition-opacity duration-500 rounded-3xl ${iframeLoaded ? 'opacity-100' : 'opacity-0'}`}
                                title={`${book.title} - Review Book`}
                                onLoad={() => setIframeLoaded(true)}
                            />
                        </>
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
                                <h3 className="text-2xl font-black text-text-main dark:text-white mb-2">Coming Soon</h3>
                                <p className="text-gray-500 dark:text-gray-400 max-w-md">
                                    Unit {book.unitNumber}: {book.title} review book is currently being prepared. Check back later!
                                </p>
                            </div>
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
                                <span className="text-sm font-bold text-gray-600 dark:text-gray-300">Download Cost</span>
                                <div className="flex items-center gap-2">
                                    <PointsCoin size="md" />
                                    <span className="text-2xl font-black text-text-main dark:text-white">{book.downloadCost}</span>
                                </div>
                            </div>

                            {/* Balance Display */}
                            <div className="w-full flex items-center justify-between text-sm mb-5 px-1">
                                <span className="text-gray-400">Your Balance</span>
                                <span className={`font-bold ${userPoints.balance >= book.downloadCost ? 'text-green-500' : 'text-red-500'}`}>
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
                                    disabled={isDownloading || userPoints.balance < book.downloadCost}
                                    className={`w-full py-3.5 rounded-xl font-bold flex items-center justify-center gap-2 transition-all ${
                                        userPoints.balance >= book.downloadCost
                                            ? 'bg-primary text-text-main shadow-md hover:brightness-105 active:scale-95'
                                            : 'bg-gray-200 dark:bg-gray-700 text-gray-400 cursor-not-allowed'
                                    }`}
                                >
                                    {isDownloading ? (
                                        <span className="w-5 h-5 border-2 border-current border-t-transparent rounded-full animate-spin"></span>
                                    ) : (
                                        <>
                                            <span className="material-symbols-outlined text-[18px]">download</span>
                                            Confirm Purchase & Download
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
