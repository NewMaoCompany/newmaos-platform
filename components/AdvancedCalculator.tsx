import React, { useRef } from 'react';

export const AdvancedCalculator = ({
    onInput, // Kept for compatibility but unused
    display, // Kept for compatibility but unused
    calculatorAllowed,
    position,
    onClose,
    onPositionChange
}: {
    onInput: (val: string) => void,
    display: string,
    calculatorAllowed?: boolean,
    position: { x: number, y: number },
    onClose: () => void,
    onPositionChange: (pos: { x: number, y: number }) => void
}) => {
    const isDragging = useRef(false);
    const dragOffset = useRef({ x: 0, y: 0 });

    // Drag handlers
    const handleMouseDown = (e: React.MouseEvent) => {
        isDragging.current = true;
        dragOffset.current = {
            x: e.clientX - position.x,
            y: e.clientY - position.y
        };
        document.addEventListener('mousemove', handleMouseMove);
        document.addEventListener('mouseup', handleMouseUp);

        const iframe = document.getElementById('desmos-iframe');
        if (iframe) iframe.style.pointerEvents = 'none';
    };

    const handleMouseMove = (e: MouseEvent) => {
        if (!isDragging.current) return;
        onPositionChange({
            x: e.clientX - dragOffset.current.x,
            y: e.clientY - dragOffset.current.y
        });
    };

    const handleMouseUp = () => {
        isDragging.current = false;
        document.removeEventListener('mousemove', handleMouseMove);
        document.removeEventListener('mouseup', handleMouseUp);

        const iframe = document.getElementById('desmos-iframe');
        if (iframe) iframe.style.pointerEvents = 'auto';
    };

    return (
        <div
            className="fixed z-50 bg-white dark:bg-zinc-900 rounded-2xl shadow-2xl border border-gray-200 dark:border-gray-800 overflow-hidden flex flex-col select-none"
            style={{
                left: position.x,
                top: position.y,
                width: '400px',
                height: '600px'
            }}
        >
            {/* Header / Drag Handle */}
            <div
                className="h-12 bg-white/80 dark:bg-black/80 backdrop-blur-md border-b border-gray-200 dark:border-gray-800 flex items-center justify-between px-4 cursor-move active:cursor-grabbing shrink-0 z-10"
                onMouseDown={handleMouseDown}
            >
                <div className="flex items-center gap-3">
                    <div className="w-7 h-7 rounded-full bg-gradient-to-br from-green-500 to-emerald-600 flex items-center justify-center shadow-sm text-white">
                        <span className="material-symbols-outlined text-[18px]">calculate</span>
                    </div>
                    <span className="text-sm font-bold text-gray-800 dark:text-gray-200">Scientific Calculator</span>
                </div>

                <button
                    onClick={onClose}
                    className="w-8 h-8 flex items-center justify-center rounded-full text-gray-400 hover:bg-red-50 hover:text-red-500 dark:hover:bg-red-900/20 dark:hover:text-red-400 transition-colors"
                >
                    <span className="material-symbols-outlined text-xl">close</span>
                </button>
            </div>

            {/* Desmos Scientific Calculator */}
            <div className="flex-1 bg-white relative">
                <iframe
                    id="desmos-iframe"
                    src="https://www.desmos.com/scientific?embed"
                    width="100%"
                    height="100%"
                    className="border-0 absolute inset-0 w-full h-full"
                    allowFullScreen
                    title="Desmos Scientific Calculator"
                ></iframe>
            </div>
        </div>
    );
};
