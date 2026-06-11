const fs = require('fs');
const content = fs.readFileSync('/Users/zhuchen/Downloads/newmaos---ap-calculus-mastery/pages/Forum.tsx', 'utf8');
const lines = content.split('\n');
console.log('Lines 4170-4185:');
for (let i = 4170; i < 4185; i++) {
    console.log(`${i + 1}: ${lines[i]}`);
}
