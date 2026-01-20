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
        <div className={`markdown-body font-math text-inherit ${className}`}>
            <ReactMarkdown
                remarkPlugins={[remarkMath]}
                rehypePlugins={[rehypeKatex]}
                components={{
                    // Override paragraph to prevent excessive margins in sensitive UI areas,
                    // but allow it for general text.
                    p: ({ node, ...props }) => <p className="mb-2 last:mb-0" {...props} />
                }}
            >
                {processedContent}
            </ReactMarkdown>
        </div>
    );
};
