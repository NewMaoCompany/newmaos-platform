#!/bin/bash
# Fix the problematic line 1224 and insert currentSnapshot definition

cd /Users/zhuchen/Downloads/newmaos---ap-calculus-mastery

# First, create a backup
cp pages/Practice.tsx pages/Practice.tsx.backup

# Remove the problematic line 1224
sed -i '' '1224d' pages/Practice.tsx

# Now insert the correct multi-line code at line 1224
sed -i '' '1223a\
            const attemptLabel = currentAttemptNumber === 1 ? '"'"'First Attempt'"'"' : `${getOrdinal(currentAttemptNumber)} Attempt`;\
\
            // Now create current snapshot with correct label\
            const currentSnapshot = {\
                type: '"'"'review'"'"' as const,\
                attemptNumber: currentAttemptNumber,\
                round: reviewRound,\
                label: `Review ${attemptLabel} #${reviewsForCurrentAttempt + 1}`,\
                timestamp: new Date().toISOString(),\
                // Clamp score to 100% and ensure it'"'"'s based on the questions in THIS session\
                score: questions.length > 0 ? Math.min(100, Math.round((finalCorrectCount / questions.length) * 100)) : 0,\
                userAnswers: finalAnswers,\
                questionResults: finalResults\
            };
' pages/Practice.tsx

echo "Fixed line 1224 and inserted currentSnapshot definition"
