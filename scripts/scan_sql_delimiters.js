import fs from 'fs';

const filePath = 'database/fix_fractions.sql';
const content = fs.readFileSync(filePath, 'utf8');

// Simple regex to capture content inside single quotes
// This is not perfect for nested quotes but sufficient for this file's structure
const stringRegex = /'((?:''|[^'])*)'/g;

let match;
const issues = [];

// Keywords that suggest LaTeX math but often appear outside $...$ by mistake
// We exclude common text words, focus on clear math commands
const mathKeywords = [
    '\\frac', '\\int', '\\sum', '\\lim', '\\sqrt', '\\to', '\\infty',
    '\\left', '\\right', '\\sin', '\\cos', '\\tan', '\\ln', '\\log'
];

// Helper to remove math blocks
function removeMath(text) {
    // Remove $$...$$ (handle multiline)
    let noDisplay = text.replace(/\$\$[\s\S]*?\$\$/g, '___MATH___');
    // Remove $...$
    return noDisplay.replace(/\$[^\$]*?\$/g, '__math__');
}

// Map line numbers roughly
const lines = content.split('\n');

while ((match = stringRegex.exec(content)) !== null) {
    const rawString = match[1];
    const cleanString = removeMath(rawString);

    mathKeywords.forEach(keyword => {
        if (cleanString.includes(keyword)) {
            // Find line number
            const codeUpToMatch = content.substring(0, match.index);
            const lineNum = codeUpToMatch.split('\n').length;

            // Avoid duplicate reports for same string/line
            const alreadyReported = issues.some(i => i.line === lineNum && i.keyword === keyword);
            if (!alreadyReported) {
                issues.push({
                    line: lineNum,
                    keyword: keyword,
                    snippet: rawString.replace(/\n/g, ' ').substring(0, 100) + '...'
                });
            }
        }
    });
}

if (issues.length > 0) {
    console.log(`Found ${issues.length} potential missing delimiter issues:`);
    issues.forEach(i => {
        console.log(`[Line ${i.line}] Found '${i.keyword}' outside math delimiters.`);
        console.log(`   Context: ${i.snippet}\n`);
    });
} else {
    console.log("No obvious missing delimiters found in SQL strings.");
}
