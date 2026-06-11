const fs = require('fs');
let content = fs.readFileSync('/Users/zhuchen/Downloads/newmaos---ap-calculus-mastery/pages/Forum.tsx', 'utf8');

const oldCode = `    const fetchFriends = async () => {
        if (!user) return;
        try {
            const [friendsRes, pendingRes] = await Promise.all([
                supabase
                    .from('friend_requests')
                    .select('sender_id, receiver_id')
                    .eq('status', 'accepted')
                    .or(\`sender_id.eq.\${user.id},receiver_id.eq.\${user.id}\`),
                supabase
                    .from('friend_requests')
                    .select('id, sender_id, created_at, sender:user_profiles!sender_id(name, avatar_url, is_official, equipped_title:titles(name, category, threshold))')
                    .eq('receiver_id', user.id)
                    .eq('status', 'pending')
                    .order('created_at', { ascending: false })
            ]);

            if (friendsRes.error) throw friendsRes.error;
            if (pendingRes.error) throw pendingRes.error;

            // Extract IDs of friends
            const friendIds = friendsRes.data.map((req: any) =>
                req.sender_id === user.id ? req.receiver_id : req.sender_id
            );
            setFriends(friendIds);

            const formattedRequests = pendingRes.data.map((req: any) => ({
                id: req.id,
                sender_id: req.sender_id,
                created_at: req.created_at,
                user: req.sender
            }));
            setPendingRequests(formattedRequests);
        } catch (err) {
            console.error('Error fetching friends:', err);
        }
    };`;

const newCode = `    const fetchFriends = async () => {
        if (!user) return;
        try {
            const [friendsRes, pendingRes] = await Promise.all([
                supabase
                    .from('friend_requests')
                    .select('sender_id, receiver_id')
                    .eq('status', 'accepted')
                    .or(\`sender_id.eq.\${user.id},receiver_id.eq.\${user.id}\`),
                supabase
                    .from('friend_requests')
                    .select('id, sender_id, created_at')
                    .eq('receiver_id', user.id)
                    .eq('status', 'pending')
                    .order('created_at', { ascending: false })
            ]);

            if (friendsRes.error) throw friendsRes.error;
            if (pendingRes.error) throw pendingRes.error;

            // Extract IDs of friends
            const friendIds = friendsRes.data.map((req: any) =>
                req.sender_id === user.id ? req.receiver_id : req.sender_id
            );
            setFriends(friendIds);

            const pendingData = pendingRes.data || [];
            if (pendingData.length === 0) {
                setPendingRequests([]);
                return;
            }

            const senderIds = pendingData.map(req => req.sender_id);
            const { data: profiles, error: profileError } = await supabase
                .from('user_profiles')
                .select('id, name, avatar_url, is_official, equipped_title:titles(name, category, threshold)')
                .in('id', senderIds);
                
            if (profileError) throw profileError;

            const profileMap = new Map();
            profiles?.forEach(p => profileMap.set(p.id, p));

            const formattedRequests = pendingData.map(req => ({
                id: req.id,
                sender_id: req.sender_id,
                created_at: req.created_at,
                user: profileMap.get(req.sender_id)
            }));
            setPendingRequests(formattedRequests);
        } catch (err) {
            console.error('Error fetching friends:', err);
        }
    };`;

content = content.replace(oldCode, newCode);
fs.writeFileSync('/Users/zhuchen/Downloads/newmaos---ap-calculus-mastery/pages/Forum.tsx', content);
console.log('Fixed fetchFriends query error.');
