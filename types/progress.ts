// Practice Session Progress Data Structure
// Used for tracking first attempt and review states

export interface FirstAttemptData {
    status: 'not_started' | 'in_progress' | 'completed';
    userAnswers: Record<string, string>;      // questionId -> selectedOptionId
    questionResults: Record<string, 'correct' | 'incorrect'>;
    currentQuestionIndex: number;
    questionIds: string[];                    // Question order snapshot
    completedAt?: string;                     // Completion timestamp
}

export interface ReviewData {
    status: 'not_started' | 'in_progress' | 'completed';
    round: number;                            // Current review round number
    targetQuestionIds: string[];              // Snapshot of incorrect question IDs for this round
    userAnswers: Record<string, string>;
    questionResults: Record<string, 'correct' | 'incorrect'>;
    currentQuestionIndex: number;
}

export interface SummaryHistoryEntry {
    type: 'first_attempt' | 'review';
    round?: number;                           // Review round number
    label: string;                            // Display label e.g. "Initial Attempt", "Review #1"
    timestamp: string;
    score: number;                            // Percentage 0-100
    userAnswers: Record<string, string>;
    questionResults: Record<string, 'correct' | 'incorrect'>;
}

export interface SectionProgressData {
    // First Attempt State
    firstAttempt: FirstAttemptData;

    // Review State
    review: ReviewData;

    // History Records
    summaryHistory: SummaryHistoryEntry[];

    // Current Incorrect Question IDs (tracks remaining errors)
    currentIncorrectIds: string[];
}

// Button state enum for TopicDetail
export type PracticeButtonState =
    | 'NOT_STARTED'           // Show: Start
    | 'FIRST_ATTEMPT_IN_PROGRESS'  // Show: Resume
    | 'FIRST_ATTEMPT_COMPLETED'    // Show: Review Errors + View Summary
    | 'REVIEW_IN_PROGRESS'    // Show: Resume Review + View Summary
    | 'STILL_HAS_ERRORS'      // Show: Review Errors + View Summary
    | 'COMPLETED';            // Show: Start Over + View Summary

// Helper to get button state from progress data
export function getButtonState(data: SectionProgressData | null | undefined): PracticeButtonState {
    if (!data || !data.firstAttempt || data.firstAttempt.status === 'not_started') {
        return 'NOT_STARTED';
    }

    const { firstAttempt, review, currentIncorrectIds } = data;

    // 1. First attempt not completed
    if (firstAttempt.status === 'in_progress') {
        return 'FIRST_ATTEMPT_IN_PROGRESS';
    }

    // 2. First attempt completed
    if (firstAttempt.status === 'completed') {
        // 2a. Review in progress
        if (review?.status === 'in_progress') {
            return 'REVIEW_IN_PROGRESS';
        }

        // 2b. Still has errors
        if (currentIncorrectIds && currentIncorrectIds.length > 0) {
            return 'STILL_HAS_ERRORS';
        }

        // 2c. No errors - completed
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
        review: {
            status: 'not_started',
            round: 0,
            targetQuestionIds: [],
            userAnswers: {},
            questionResults: {},
            currentQuestionIndex: 0,
        },
        summaryHistory: [],
        currentIncorrectIds: [],
    };
}
