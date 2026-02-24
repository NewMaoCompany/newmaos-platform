/**
 * Batch upload Unit images to Supabase Storage and update question prompts.
 *
 * Usage:  node scripts/upload_unit_images.mjs <folder>
 * Example: node scripts/upload_unit_images.mjs "Unit2"
 */

import { createClient } from '@supabase/supabase-js';
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

// --- Config ---
const SUPABASE_URL = 'https://xzpjlnkirboevkjzitcx.supabase.co';
const SUPABASE_ANON_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inh6cGpsbmtpcmJvZXZranppdGN4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Njg1Mjc1NjYsImV4cCI6MjA4NDEwMzU2Nn0.rbHJO4vJ3fW86MweT3MgmFTeb_esWlDGZMdqMksHBkI';

const supabase = createClient(SUPABASE_URL, SUPABASE_ANON_KEY);

const FOLDER_NAME = process.argv[2] || 'Unit2';
const IMAGE_DIR = path.resolve(__dirname, '..', FOLDER_NAME);
const STORAGE_BUCKET = 'images';
const STORAGE_PATH = 'mixed_content';

// --- Filename → Question Title mapping ---
function filenameToTitle(filename) {
    const base = filename.replace(/\.png$/i, '');

    // Pattern: "X.Y-PZ" → title "X.Y-PZ"
    if (/^\d+\.\d+-P\d+$/.test(base)) return base;

    // Pattern: "X.Y-UT-QZ" → title "X.Y-UT-QZ" (unit test, e.g. 1.0-UT-Q3)
    if (/^\d+\.\d+-UT-Q\d+$/.test(base)) return base;

    // Pattern: "U2-UT-Q14" → title "2.0-UT-Q14" (Unit test shorthand)
    const utMatch = base.match(/^U(\d+)-UT-Q(\d+)$/);
    if (utMatch) return `${utMatch[1]}.0-UT-Q${utMatch[2]}`;

    // Pattern: "U1C9Q1_description" → title "1.9-P1"
    const ucqMatch = base.match(/^U(\d+)C(\d+)Q(\d+)/);
    if (ucqMatch) return `${ucqMatch[1]}.${ucqMatch[2]}-P${ucqMatch[3]}`;

    console.warn(`⚠️  Cannot map filename: ${filename}`);
    return null;
}

async function main() {
    if (!fs.existsSync(IMAGE_DIR)) {
        console.error(`❌ Directory not found: ${IMAGE_DIR}`);
        process.exit(1);
    }

    const files = fs.readdirSync(IMAGE_DIR).filter(f => f.endsWith('.png'));
    console.log(`📁 Found ${files.length} images in ${FOLDER_NAME}/\n`);

    let success = 0, skip = 0, fail = 0;

    for (const filename of files) {
        const title = filenameToTitle(filename);
        if (!title) { fail++; continue; }

        console.log(`--- ${filename} → "${title}" ---`);

        const { data: question, error: qErr } = await supabase
            .from('questions').select('id, title, prompt').eq('title', title).single();

        if (qErr || !question) {
            console.error(`  ❌ Not found: "${title}" (${qErr?.message || 'no data'})`);
            fail++; continue;
        }

        // Parse prompt
        let promptArray = [];
        const raw = question.prompt;
        if (Array.isArray(raw)) promptArray = [...raw];
        else if (typeof raw === 'string') {
            const t = raw.trim();
            if (t.startsWith('[')) { try { promptArray = JSON.parse(t); } catch { promptArray = [raw]; } }
            else promptArray = [raw];
        } else if (raw) promptArray = [String(raw)];

        if (promptArray.some(p => typeof p === 'string' && (p.startsWith('http') || p.startsWith('data:image')))) {
            console.log(`  ⏭️  Already has image, skipping.`);
            skip++; continue;
        }

        // Upload
        const fileBuffer = fs.readFileSync(path.join(IMAGE_DIR, filename));
        const storagePath = `${STORAGE_PATH}/${Date.now()}_${filename.replace(/\s+/g, '_')}`;

        const { error: upErr } = await supabase.storage
            .from(STORAGE_BUCKET).upload(storagePath, fileBuffer, { contentType: 'image/png', upsert: true });

        if (upErr) { console.error(`  ❌ Upload failed: ${upErr.message}`); fail++; continue; }

        const { data: { publicUrl } } = supabase.storage.from(STORAGE_BUCKET).getPublicUrl(storagePath);
        promptArray.push(publicUrl);

        const { error: updErr } = await supabase.from('questions')
            .update({ prompt: promptArray, prompt_type: 'image' }).eq('id', question.id);

        if (updErr) { console.error(`  ❌ DB update failed: ${updErr.message}`); fail++; continue; }

        console.log(`  ✅ Done (${publicUrl.substring(0, 60)}...)`);
        success++;
    }

    console.log(`\n✅ ${success} | ⏭️ ${skip} | ❌ ${fail}\n`);
}

main().catch(console.error);
