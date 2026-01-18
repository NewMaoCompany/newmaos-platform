import React, { useState, useRef, useEffect } from 'react';
import ReactCrop, { Crop, PixelCrop, centerCrop, makeAspectCrop } from 'react-image-crop';
import 'react-image-crop/dist/ReactCrop.css';

interface ImageCropModalProps {
    src: string | null;
    isOpen: boolean;
    onClose: () => void;
    onComplete: (blob: Blob) => void;
}

function centerAspectCrop(mediaWidth: number, mediaHeight: number, aspect?: number) {
    return centerCrop(
        makeAspectCrop(
            {
                unit: '%',
                width: 90,
            },
            aspect || 16 / 9,
            mediaWidth,
            mediaHeight,
        ),
        mediaWidth,
        mediaHeight,
    );
}

export const ImageCropModal: React.FC<ImageCropModalProps> = ({ src, isOpen, onClose, onComplete }) => {
    const [crop, setCrop] = useState<Crop>();
    const [completedCrop, setCompletedCrop] = useState<PixelCrop>();
    const [aspect, setAspect] = useState<number | undefined>(undefined);
    const imgRef = useRef<HTMLImageElement>(null);

    const onImageLoad = (e: React.SyntheticEvent<HTMLImageElement>) => {
        if (aspect) {
            const { width, height } = e.currentTarget;
            setCrop(centerAspectCrop(width, height, aspect));
        } else {
            const { width, height } = e.currentTarget;
            setCrop(centerCrop(
                makeAspectCrop({ unit: '%', width: 90 }, 16 / 9, width, height),
                width, height
            ));
        }
    };

    const getCroppedImg = async () => {
        if (!completedCrop || !imgRef.current) return;

        const image = imgRef.current;
        const canvas = document.createElement('canvas');
        const ctx = canvas.getContext('2d');
        if (!ctx) return;

        const scaleX = image.naturalWidth / image.width;
        const scaleY = image.naturalHeight / image.height;
        const pixelRatio = window.devicePixelRatio;

        canvas.width = Math.floor(completedCrop.width * scaleX * pixelRatio);
        canvas.height = Math.floor(completedCrop.height * scaleY * pixelRatio);

        ctx.scale(pixelRatio, pixelRatio);
        ctx.imageSmoothingQuality = 'high';

        const cropX = completedCrop.x * scaleX;
        const cropY = completedCrop.y * scaleY;
        const cropWidth = completedCrop.width * scaleX;
        const cropHeight = completedCrop.height * scaleY;

        ctx.translate(-cropX, -cropY);
        ctx.drawImage(
            image,
            0,
            0,
            image.naturalWidth,
            image.naturalHeight,
            0,
            0,
            image.naturalWidth,
            image.naturalHeight,
        );

        canvas.toBlob((blob) => {
            if (blob) onComplete(blob);
        }, 'image/png');
    };

    if (!isOpen || !src) return null;

    return (
        <div className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/60 backdrop-blur-sm animate-fade-in">
            <div className="bg-white dark:bg-gray-900 rounded-2xl shadow-2xl w-full max-w-4xl overflow-hidden flex flex-col max-h-[90vh]">
                {/* Header */}
                <div className="p-4 border-b border-gray-100 dark:border-gray-800 flex justify-between items-center bg-gray-50/50 dark:bg-white/5">
                    <h3 className="font-bold text-gray-800 dark:text-gray-200">Crop Image</h3>
                    <button onClick={onClose} className="text-gray-400 hover:text-gray-600 dark:hover:text-gray-200 transition-colors">
                        <span className="material-symbols-outlined">close</span>
                    </button>
                </div>

                {/* Toolbar */}
                <div className="p-3 border-b border-gray-100 dark:border-gray-800 flex gap-2 overflow-x-auto bg-gray-50/30 dark:bg-black/20">
                    <button
                        onClick={() => setAspect(undefined)}
                        className={`px-3 py-1 text-xs font-bold rounded-lg transition-all ${!aspect ? 'bg-primary text-white' : 'bg-gray-200 dark:bg-white/5 text-gray-600 dark:text-gray-400'}`}
                    >
                        Free
                    </button>
                    <button
                        onClick={() => setAspect(1)}
                        className={`px-3 py-1 text-xs font-bold rounded-lg transition-all ${aspect === 1 ? 'bg-primary text-white' : 'bg-gray-200 dark:bg-white/5 text-gray-600 dark:text-gray-400'}`}
                    >
                        Square (1:1)
                    </button>
                    <button
                        onClick={() => setAspect(16 / 9)}
                        className={`px-3 py-1 text-xs font-bold rounded-lg transition-all ${aspect === 16 / 9 ? 'bg-primary text-white' : 'bg-gray-200 dark:bg-white/5 text-gray-600 dark:text-gray-400'}`}
                    >
                        16:9
                    </button>
                    <button
                        onClick={() => setAspect(4 / 3)}
                        className={`px-3 py-1 text-xs font-bold rounded-lg transition-all ${aspect === 4 / 3 ? 'bg-primary text-white' : 'bg-gray-200 dark:bg-white/5 text-gray-600 dark:text-gray-400'}`}
                    >
                        4:3
                    </button>
                </div>

                {/* Body */}
                <div className="flex-1 overflow-auto p-6 flex justify-center bg-checkered min-h-[300px]">
                    <ReactCrop
                        crop={crop}
                        onChange={(_, percentCrop) => setCrop(percentCrop)}
                        onComplete={(c) => setCompletedCrop(c)}
                        aspect={aspect}
                        className="max-h-[60vh]"
                    >
                        <img
                            ref={imgRef}
                            alt="Crop me"
                            src={src}
                            onLoad={onImageLoad}
                            className="max-w-full max-h-[60vh] object-contain rounded-lg shadow-sm"
                        />
                    </ReactCrop>
                </div>

                {/* Footer */}
                <div className="p-4 border-t border-gray-100 dark:border-gray-800 flex justify-end gap-3 bg-gray-50/50 dark:bg-white/5">
                    <button
                        onClick={onClose}
                        className="px-5 py-2.5 rounded-xl font-bold text-gray-500 hover:bg-gray-100 dark:hover:bg-white/10 transition-all text-sm"
                    >
                        Cancel
                    </button>
                    <button
                        onClick={getCroppedImg}
                        className="px-6 py-2.5 rounded-xl font-bold bg-primary text-white shadow-lg shadow-primary/30 hover:shadow-primary/50 hover:scale-105 active:scale-95 transition-all text-sm flex items-center gap-2"
                    >
                        <span className="material-symbols-outlined text-lg">crop</span>
                        Crop & Upload
                    </button>
                </div>
            </div>
        </div>
    );
};
