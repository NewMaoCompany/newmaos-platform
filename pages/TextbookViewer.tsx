import React, { useState, useEffect, useCallback } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import { useApp } from '../AppContext';
import { TEXTBOOK_DATA, TextbookInfo } from '../constants';
import { PointsCoin } from '../components/PointsCoin';

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
        <div className="h-full w-full flex flex-col bg-background-light dark:bg-background-dark text-text-main dark:text-gray-100 overflow-hidden">
            {/* Top Toolbar */}
            <div className="h-16 min-h-[64px] flex items-center justify-between px-4 sm:px-6 border-b border-gray-200 dark:border-gray-800 bg-surface-light/80 dark:bg-surface-dark/80 backdrop-blur-md z-20 shrink-0">
                <div className="flex items-center gap-3">
                    <button
                        onClick={() => navigate(-1)}
                        className="w-9 h-9 flex items-center justify-center rounded-xl bg-gray-100 dark:bg-white/10 hover:bg-gray-200 dark:hover:bg-white/20 transition-colors"
                    >
                        <span className="material-symbols-outlined text-lg">arrow_back</span>
                    </button>
                    <div className="flex items-center gap-2">
                        <div
                            className="w-8 h-8 rounded-lg flex items-center justify-center text-white text-sm"
                            style={{ background: book.coverColor }}
                        >
                            <span className="material-symbols-outlined text-[18px]">{book.icon}</span>
                        </div>
                        <div className="flex flex-col">
                            <span className="text-sm font-bold text-text-main dark:text-white leading-tight truncate max-w-[200px] sm:max-w-none">
                                Unit {book.unitNumber}: {book.title}
                            </span>
                            <span className="text-[10px] font-bold text-gray-400 uppercase tracking-wider">
                                {course} • {book.subtitle} • ~{book.pageCount} pages
                            </span>
                        </div>
                    </div>
                </div>

                <div className="flex items-center gap-2">
                    {/* Fullscreen toggle */}
                    <button
                        onClick={() => {
                            const iframe = document.getElementById('pdf-viewer') as HTMLIFrameElement;
                            if (iframe) {
                                if (document.fullscreenElement) {
                                    document.exitFullscreen();
                                } else {
                                    iframe.requestFullscreen?.();
                                }
                            }
                        }}
                        className="w-9 h-9 flex items-center justify-center rounded-xl bg-gray-100 dark:bg-white/10 hover:bg-gray-200 dark:hover:bg-white/20 transition-colors"
                        title="Fullscreen"
                    >
                        <span className="material-symbols-outlined text-lg">fullscreen</span>
                    </button>

                    {/* Download Button */}
                    {book.available && (
                        <button
                            onClick={handleDownload}
                            disabled={isDownloading}
                            className={`h-9 px-4 rounded-xl font-bold text-sm flex items-center gap-2 transition-all shadow-sm ${
                                isPurchased
                                    ? 'bg-green-50 dark:bg-green-900/20 text-green-600 dark:text-green-400 hover:bg-green-100 dark:hover:bg-green-900/30'
                                    : 'bg-primary text-text-main hover:brightness-105'
                            } ${isDownloading ? 'opacity-60 cursor-not-allowed' : ''}`}
                        >
                            {isDownloading ? (
                                <span className="w-4 h-4 border-2 border-current border-t-transparent rounded-full animate-spin"></span>
                            ) : isPurchased ? (
                                <>
                                    <span className="material-symbols-outlined text-[16px]">download</span>
                                    <span className="hidden sm:inline">Download</span>
                                </>
                            ) : (
                                <>
                                    <PointsCoin size="sm" />
                                    <span>{book.downloadCost}</span>
                                    <span className="hidden sm:inline">Download</span>
                                </>
                            )}
                        </button>
                    )}
                </div>
            </div>

            {/* PDF Viewer */}
            <div className="flex-1 relative bg-gray-100 dark:bg-gray-900 overflow-hidden">
                {book.available ? (
                    <>
                        {!iframeLoaded && (
                            <div className="absolute inset-0 flex flex-col items-center justify-center gap-4 z-10">
                                <div className="w-10 h-10 border-4 border-primary border-t-transparent rounded-full animate-spin"></div>
                                <span className="text-sm font-medium text-gray-500">Loading PDF...</span>
                            </div>
                        )}
                        <iframe
                            id="pdf-viewer"
                            src={`${book.pdfUrl}#toolbar=1&navpanes=0&scrollbar=1&view=FitH`}
                            className={`w-full h-full border-0 transition-opacity duration-500 ${iframeLoaded ? 'opacity-100' : 'opacity-0'}`}
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
                        <button
                            onClick={() => navigate(-1)}
                            className="px-6 py-3 bg-gray-100 dark:bg-white/10 text-text-main dark:text-white font-bold rounded-xl hover:bg-gray-200 dark:hover:bg-white/20 transition-colors flex items-center gap-2"
                        >
                            <span className="material-symbols-outlined text-lg">arrow_back</span>
                            Go Back
                        </button>
                    </div>
                )}
            </div>

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
