import fs from 'fs';
import path from 'path';

function findSqlFiles(dir, fileList = []) {
    const files = fs.readdirSync(dir);
    for (const file of files) {
        const filePath = path.join(dir, file);
        if (fs.statSync(filePath).isDirectory()) {
            findSqlFiles(filePath, fileList);
        } else if (filePath.endsWith('.sql')) {
            fileList.push(filePath);
        }
    }
    return fileList;
}

const sqlFiles = findSqlFiles('./database/');
const skills = new Set();
const errors = new Set();

sqlFiles.forEach(file => {
    const content = fs.readFileSync(file, 'utf-8');

    // Naively extract anything that looks like an ID/Name from INSERT statements
    // We'll look for lines with something like ('some_id', 'Some Name',
    const lines = content.split('\n');
    let inSkills = false;
    let inErrors = false;

    for (let line of lines) {
        if (line.toLowerCase().includes('insert into public.skills')) { inSkills = true; inErrors = false; continue; }
        if (line.toLowerCase().includes('insert into public.error_tags')) { inErrors = true; inSkills = false; continue; }
        if (line.includes('ON CONFLICT') || line.includes(';')) { inSkills = false; inErrors = false; }

        if ((inSkills || inErrors) && line.trim().startsWith('(')) {
            // ('id', 'Name', ...
            const match = line.match(/\('([^']+)',\s*'([^']+)'/);
            if (match) {
                if (inSkills) skills.add({ id: match[1], name: match[2] });
                if (inErrors) errors.add({ id: match[1], name: match[2] });
            }
        }
    }
});

fs.writeFileSync('extracted_tags.json', JSON.stringify({
    skills: Array.from(skills),
    errors: Array.from(errors)
}, null, 2));

console.log(`Extracted ${skills.size} skills and ${errors.size} errors.`);
