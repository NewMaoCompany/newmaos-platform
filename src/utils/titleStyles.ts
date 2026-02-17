import { Title } from '../../types';

export interface TitleStyle {
    icon: string;
    bg: string; // Gradient background
    border: string;
    text: string;
    glow: string;
    animation?: string;
    extraClasses?: string;
}

// Deterministic mapping of specific titles to unique icons
// We map based on Category + Threshold to ensure every single title has a distinct visual identity.
const TITLE_DEFINITIONS: Record<string, Record<number, string>> = {
    streak: {
        7: 'local_fire_department',      // Week Streak
        30: 'whatshot',                  // Month Streak
        100: 'mode_heat',                // 100 Day Streak
        180: 'volcano',                  // 6 Months
        365: 'solar_power',              // Year Streak
    },
    mastery_unit: {
        2: 'school',                     // Novice
        4: 'book_2',                     // Scholar
        6: 'menu_book',                  // Researcher
        8: 'library_books',              // Master
        10: 'auto_stories',              // Grandmaster
    },
    mastery_course: {
        1: 'functions',                  // AB Calculus (Calculus Symbol)
        2: 'calculate',                  // BC Calculus (More advanced symbol)
    },
    social: {
        10: 'person_add',                // Friendly
        30: 'group',                     // Popular
        50: 'diversity_3',               // Connector
        100: 'diversity_1',              // Influencer
        200: 'groups',                   // Community Leader
    },
    influence: {
        50: 'thumb_up',                  // Helper
        250: 'volunteer_activism',       // Supporter
        1000: 'favorite',                // Beloved
        2500: 'loyalty',                 // Devoted
        5000: 'verified',                // Icon
    },
    seniority: {
        7: 'new_releases',               // Newcomer (1 Week)
        30: 'light_mode',                // Rising (1 Month)
        180: 'upcoming',                 // Determined (6 Months)
        365: 'history',                  // Veteran (1 Year)
        730: 'hourglass_top',            // Established (2 Years)
        1460: 'calendar_month',          // Ancient (4 Years)
        2555: 'schedule',                // Timeless (7 Years)
        3650: 'update',                  // Eternal (10 Years)
    }
};

// Fallback icons if exact threshold match isn't found
const CATEGORY_FALLBACK_ICONS: Record<string, string> = {
    streak: 'fire_hydrant',
    mastery_unit: 'import_contacts',
    mastery_course: 'function',
    social: 'emoji_people',
    influence: 'star',
    seniority: 'watch_later'
};

const getTitleVisualLevel = (category: string, threshold: number): number => {
    const t = Number(threshold);

    if (category === 'mastery_course') {
        return t === 1 ? 5 : 6; // AB = Level 5, BC = Level 6
    }

    if (category === 'seniority') {
        if (t >= 3650) return 6;
        if (t >= 2555) return 5;
        if (t >= 1460) return 4;
        if (t >= 730) return 3;
        if (t >= 365) return 2;
        return 1;
    } else if (category === 'streak') {
        if (t >= 365) return 6;
        if (t >= 180) return 5;
        if (t >= 100) return 4;
        if (t >= 30) return 3;
        if (t >= 7) return 2;
        return 1;
    } else if (category === 'mastery_unit') {
        if (t >= 10) return 6;
        if (t >= 8) return 5;
        if (t >= 6) return 4;
        if (t >= 4) return 3;
        if (t >= 2) return 2;
        return 1;
    } else if (category === 'social') {
        if (t >= 200) return 6;
        if (t >= 100) return 5;
        if (t >= 50) return 4;
        if (t >= 30) return 3;
        if (t >= 10) return 2;
        return 1;
    } else if (category === 'influence') {
        if (t >= 5000) return 6;
        if (t >= 2500) return 5;
        if (t >= 1000) return 4;
        if (t >= 250) return 3;
        if (t >= 50) return 2;
        return 1;
    }
    return 1;
};

export const getUniqueTitleStyle = (category: string, threshold: number): TitleStyle => {
    const level = getTitleVisualLevel(category, threshold);

    // 1. Determine Icon
    let icon = CATEGORY_FALLBACK_ICONS[category] || 'badge';
    if (TITLE_DEFINITIONS[category] && TITLE_DEFINITIONS[category][threshold]) {
        icon = TITLE_DEFINITIONS[category][threshold];
    }

    // 2. Base Styles per Category
    let baseStyle: Partial<TitleStyle> = {
        bg: 'bg-gray-500',
        border: 'border-gray-400',
        text: 'text-white',
        glow: 'shadow-gray-500/20'
    };

    switch (category) {
        case 'streak':
            baseStyle = {
                bg: 'from-orange-400 via-red-500 to-red-600',
                border: 'border-orange-300',
                text: 'text-white',
                glow: 'shadow-orange-500/20'
            };
            break;
        case 'mastery_unit':
            baseStyle = {
                bg: 'from-cyan-400 via-blue-500 to-blue-600',
                border: 'border-cyan-300',
                text: 'text-white',
                glow: 'shadow-cyan-500/20'
            };
            break;
        case 'mastery_course':
            baseStyle = {
                bg: 'from-fuchsia-400 via-purple-600 to-indigo-700',
                border: 'border-purple-300',
                text: 'text-white',
                glow: 'shadow-purple-500/20'
            };
            break;
        case 'social':
            baseStyle = {
                bg: 'from-emerald-400 via-teal-500 to-teal-600',
                border: 'border-emerald-300',
                text: 'text-white',
                glow: 'shadow-emerald-500/20'
            };
            break;
        case 'influence':
            baseStyle = {
                bg: 'from-yellow-300 via-amber-500 to-orange-600',
                border: 'border-yellow-200',
                text: 'text-[#1c1a0d]',
                glow: 'shadow-amber-500/20'
            };
            break;
        case 'seniority':
            baseStyle = {
                bg: 'from-amber-600 via-amber-800 to-stone-900',
                border: 'border-amber-400/50',
                text: 'text-amber-50',
                glow: 'shadow-amber-900/40'
            };
            break;
    }

    // 3. Level-Specific Overrides (The "Premium" Feel)
    if (level === 6) { // Mythic/Divine
        return {
            icon,
            bg: category === 'seniority'
                ? 'from-black via-amber-900 to-black'
                : (category === 'influence' ? 'from-yellow-200 via-white to-amber-500' : 'from-black via-primary/40 to-black'),
            border: `border-white/80 shadow-[0_0_30px_rgba(255,255,255,0.4)] ring-2 ring-primary/60 scale-110`,
            text: category === 'influence' ? 'text-black' : 'text-white',
            glow: 'shadow-primary/60 animate-pulse-neon',
            animation: 'animate-pulse-slow',
            extraClasses: 'mesh-liquid overflow-hidden !border-opacity-100 shimmer-sweep'
        };
    }

    if (level === 5) { // Legendary
        return {
            icon,
            bg: baseStyle.bg!,
            border: 'border-white/60 shadow-[0_0_20px_rgba(255,255,255,0.3)] ring-1 ring-white/40',
            text: baseStyle.text!,
            glow: 'shadow-primary/40 animate-pulse',
            animation: 'animate-pulse',
            extraClasses: 'shimmer-sweep scale-105 overflow-hidden'
        };
    }

    if (level === 4) { // Epic
        return {
            icon,
            bg: baseStyle.bg!,
            border: 'border-white/40 ring-1 ring-white/20 shadow-[0_0_15px_rgba(255,255,255,0.2)]',
            text: baseStyle.text!,
            glow: baseStyle.glow!.replace('/20', '/60'),
            extraClasses: 'animate-gradient-x'
        };
    }

    if (level === 3) { // Rare
        return {
            icon,
            bg: baseStyle.bg!,
            border: 'border-white/30 shadow-[inset_0_0_10px_rgba(255,255,255,0.2)]',
            text: baseStyle.text!,
            glow: baseStyle.glow!.replace('/20', '/40'),
        };
    }

    if (level === 2) { // Advanced
        return {
            icon,
            bg: baseStyle.bg!,
            border: 'border-white/20',
            text: baseStyle.text!,
            glow: baseStyle.glow!.replace('/20', '/30'),
        };
    }

    // Level 1: Starter
    return {
        icon,
        bg: baseStyle.bg!,
        border: baseStyle.border!,
        text: baseStyle.text!,
        glow: baseStyle.glow!,
    };
};
