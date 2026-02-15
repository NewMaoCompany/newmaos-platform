import React from 'react';
import ReactMarkdown from 'react-markdown';
import remarkMath from 'remark-math';
import rehypeKatex from 'rehype-katex';
import 'katex/dist/katex.min.css';

interface MathRendererProps {
    content: string;
    block?: boolean;
    className?: string;
}

export const MathRenderer: React.FC<MathRendererProps> = ({ content, block = false, className = '' }) => {
    if (!content) return null;

    // Check for Mixed Content (JSON Array)
    // This allows combining text and images: ["Problem text...", "https://image.url", "More text..."]
    let mixedContent: string[] | null = null;
    if (content.trim().startsWith('{')) {
        try {
            const parsed = JSON.parse(content);
            // Handle { text: "...", image: "..." } object
            if (parsed.text || parsed.image) {
                mixedContent = [];
                if (parsed.text) mixedContent.push(parsed.text);
                if (parsed.image) mixedContent.push(parsed.image);
            }
        } catch (e) {
            // Ignore
        }
    }

    if (content.trim().startsWith('[') && content.trim().endsWith(']')) {
        try {
            const parsed = JSON.parse(content);
            if (Array.isArray(parsed)) {
                mixedContent = parsed.map(p => String(p));
            }
        } catch (e) {
            // Fallback: If JSON.parse fails (likely due to LaTeX backslashes \lim not being escaped as \\lim),
            // we try to Regex parse the common pattern ["Text", "URL"]
            // Pattern: Starts with [" , captures content until ", " , captures URL until "]
            // We use a non-greedy match for the first part
            const match = content.match(/^\s*\[\s*"(.*)",\s*"(.*)"\s*\]\s*$/s);
            if (match) {
                // We successfully extracted the two parts.
                // We need to manually unescape quotes \" -> " if they exist
                const textPart = match[1].replace(/\\"/g, '"');
                const urlPart = match[2].replace(/\\"/g, '"');
                mixedContent = [textPart, urlPart];
            }
        }
    }

    if (mixedContent) {
        return (
            <div className={`markdown-body text-inherit ${className}`}>
                {mixedContent.map((item, idx) => {
                    const isImage = item.trim().startsWith('http') || item.trim().startsWith('data:image') || item.trim().startsWith('/');
                    if (isImage) {
                        return (
                            <div key={idx} className="flex justify-center my-4">
                                <img
                                    src={item}
                                    alt={`Content ${idx + 1}`}
                                    className="max-w-full rounded-lg border border-gray-200 dark:border-gray-700 shadow-sm"
                                    style={{ maxHeight: '400px' }}
                                />
                            </div>
                        );
                    }
                    // Render text segment recursively (but avoiding infinite loop since item is not array)
                    // We can reuse the same styles by rendering a mini MathRenderer or just the markdown logic here.
                    // To avoid overhead, we'll just map to the renderer logic below.
                    return <MathRenderer key={idx} content={item} block={block} />;
                })}
            </div>
        );
    }

    // Check for Single Image URL (Legacy Support)
    // If the content is just a URL, render it as an image.
    const isSingleImage = content.trim().startsWith('http') ||
        content.trim().startsWith('data:image') ||
        (content.trim().startsWith('/') && !content.trim().startsWith('/ ')); // Avoid false positives if any

    if (isSingleImage) {
        return (
            <div className={`flex justify-center my-4 ${className}`}>
                <img
                    src={content.trim()}
                    alt="Content"
                    className="max-w-full rounded-lg border border-gray-200 dark:border-gray-700 shadow-sm"
                    style={{ maxHeight: '400px' }}
                />
            </div>
        );
    }

    // Heuristics for legacy support or convenience:
    // If 'block' is true and content doesn't start with $$ or $, wrap it in $$
    // This maintains backward compatibility with the previous component usage
    // where <MathRenderer content="x^2" block /> expected math rendering.
    let processedContent = content;
    if (block) {
        const trimmed = content.trim();
        if (!trimmed.startsWith('$') && !trimmed.startsWith('\\[')) {
            processedContent = `$$${trimmed}$$`;
        }
    }

    return (
        <div className={`markdown-body text-inherit ${className}`}>
            <style>{`
                /* Force inline rendering for standard katex elements */
                .katex { 
                    display: inline-block !important; 
                    line-height: 1.2;
                    white-space: nowrap; /* Prevent breaking formula in half */
                }
                /* Allow display math to be block */
                .katex-display .katex { 
                    display: flex !important; 
                    white-space: normal;
                }
                .katex-display {
                    display: flex !important;
                    margin: 0.5em 0 !important;
                    overflow-x: auto;
                    overflow-y: hidden;
                }
                /* Ensure p tags don't break flow inside list items if empty */
                .markdown-body p:empty { display: none; }
            `}</style>
            <ReactMarkdown
                remarkPlugins={[remarkMath]}
                rehypePlugins={[rehypeKatex]}
                components={{
                    // Use standard paragraph behavior but ensure margin handling
                    p: ({ node, ...props }) => <p className="mb-2 last:mb-0" {...props} />,
                    // Explicit image handling
                    img: ({ node, ...props }) => (
                        <span className="flex justify-center my-4">
                            <img
                                {...props}
                                className="max-w-full rounded-lg border border-gray-200 dark:border-gray-700 shadow-sm"
                                style={{ maxHeight: '400px' }}
                            />
                        </span>
                    )
                }}
            >
                {processedContent}
            </ReactMarkdown>
        </div>
    );
};

