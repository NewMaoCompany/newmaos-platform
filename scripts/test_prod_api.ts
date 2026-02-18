
async function testApi() {
    try {
        const url = 'https://newmaos-api.vercel.app/api/questions?limit=20';
        console.log(`Fetching from: ${url}`);
        const response = await fetch(url);

        if (!response.ok) {
            console.error(`HTTP error! status: ${response.status}`);
            return;
        }

        const questions = await response.json();

        console.log(`Found ${questions.length} questions.`);
        questions.forEach((q: any) => {
            console.log(`ID: ${q.id.substring(0, 8)}... | Title: ${q.title || 'NULL'} | Status: ${q.status || 'NULL'}`);
        });
    } catch (error: any) {
        console.error('Error fetching questions:', error.message);
    }
}

testApi();
