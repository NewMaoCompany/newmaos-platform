const fs = require('fs');
const content = fs.readFileSync('/tmp/original.tsx', 'utf8');
let divCount = 0;
const lines = content.split('\n');
for (let i = 0; i < lines.length; i++) {
    const line = lines[i];
    const opens = (line.match(/<div(\s|>)/g) || []).length;
    const closes = (line.match(/<\/div>/g) || []).length;
    divCount += opens - closes;
}
console.log('Total unclosed divs in original:', divCount);
