// Practice Session Progress Data Structure
// SIMPLIFIED: No more review loops. Session is either in_progress or completed.

export interface FirstAttemptData {
    status: 'not_started' | 'in_progress' | 'completed';
    userAnswers: Record<string, string>;      // questionId -> selectedOptionId
    questionResults: Record<string, 'correct' | 'incorrect'>;
    currentQuestionIndex: number;
    questionIds: string[];                    // Question order snapshot
    completedAt?: string;                     // Completion timestamp
}

export interface SummaryHistoryEntry {
    type: 'first_attempt';
    attemptNumber?: number;
    label: string;                            // Display label e.g. "First Attempt", "Second Attempt"
    timestamp: string;
    score: number;                            // Percentage 0-100
    userAnswers: Record<string, string>;
    questionResults: Record<string, 'correct' | 'incorrect'>;
}

export interface SectionProgressData {
    // First Attempt State
    firstAttempt: FirstAttemptData;

    // History Records (each Start Over creates a new entry)
    summaryHistory: SummaryHistoryEntry[];

    // Incorrect Question IDs from this session (for display only, NOT for re-doing)
    currentIncorrectIds: string[];
}

// Simplified Button state: only 3 states
export type PracticeButtonState =
    | 'NOT_STARTED'           // Show: Start
    | 'IN_PROGRESS'           // Show: Resume
    | 'COMPLETED';            // Show: Start Over + View Summary

// Helper to get button state from progress data
export function getButtonState(data: SectionProgressData | null | undefined): PracticeButtonState {
    if (!data || !data.firstAttempt || data.firstAttempt.status === 'not_started') {
        return 'NOT_STARTED';
    }

    const { firstAttempt } = data;

    if (firstAttempt.status === 'in_progress') {
        return 'IN_PROGRESS';
    }

    if (firstAttempt.status === 'completed') {
        return 'COMPLETED';
    }

    return 'NOT_STARTED';
}

// Helper to check if View Summary should be shown
export function shouldShowViewSummary(data: SectionProgressData | null | undefined): boolean {
    return data?.firstAttempt?.status === 'completed';
}

// Create initial empty progress data
export function createInitialProgressData(questionIds: string[]): SectionProgressData {
    return {
        firstAttempt: {
            status: 'not_started',
            userAnswers: {},
            questionResults: {},
            currentQuestionIndex: 0,
            questionIds,
        },
        summaryHistory: [],
        currentIncorrectIds: [],
    };
}
