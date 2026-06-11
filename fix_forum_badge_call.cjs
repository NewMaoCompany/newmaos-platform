const fs = require('fs');
let content = fs.readFileSync('/Users/zhuchen/Downloads/newmaos---ap-calculus-mastery/pages/Forum.tsx', 'utf8');

content = content.replace(
    'const { user, isAuthenticated, isAuthLoading, unreadCounts, clearUnread, userPoints, fetchUserPoints, triggerCoinAnimation, isPro, markBadgeAsRead, sendGlobalBroadcast } = useApp();',
    'const { user, isAuthenticated, isAuthLoading, unreadCounts, clearUnread, userPoints, fetchUserPoints, triggerCoinAnimation, isPro, markBadgeAsRead, sendGlobalBroadcast, fetchBadgeStatus } = useApp();'
);

content = content.replace(
    /fetchFriends\(\);\s*\/\/\s*Trigger global refresh/g,
    'fetchFriends(); fetchBadgeStatus(); // Trigger global refresh'
);

content = content.replace(
    /setPendingRequests\(prev => prev\.filter\(p => p\.id !== req\.id\)\);/g,
    'setPendingRequests(prev => prev.filter(p => p.id !== req.id)); fetchBadgeStatus();'
);

fs.writeFileSync('/Users/zhuchen/Downloads/newmaos---ap-calculus-mastery/pages/Forum.tsx', content);
