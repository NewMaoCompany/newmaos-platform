/**
 * Batch upload Unit1 images to Supabase Storage and update question prompts.
 *
 * Usage:  node scripts/upload_unit1_images.mjs
 *
 * What it does:
 * 1. Reads all .png files from "Unit1 image/" folder
 * 2. Maps each filename to a question title in the DB
 * 3. Uploads the image to Supabase Storage bucket "images" under "mixed_content/"
 * 4. Gets the public URL
 * 5. Reads the current prompt array from the question
 * 6. Appends the image URL (only if not already present)
 * 7. Updates the question's prompt in the DB
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

const IMAGE_DIR = path.resolve(__dirname, '..', 'Unit1 image');
const STORAGE_BUCKET = 'images';
const STORAGE_PATH = 'mixed_content';

// --- Filename → Question Title mapping ---
function filenameToTitle(filename) {
    // Remove .png extension
    const base = filename.replace(/\.png$/i, '');

    // Pattern 1: "1.3-P1" → title "1.3-P1"  (direct match)
    if (/^\d+\.\d+-P\d+$/.test(base)) {
        return base;
    }

    // Pattern 2: "1.0-UT-Q3" → title "1.0-UT-Q3"  (unit test)
    if (/^\d+\.\d+-UT-Q\d+$/.test(base)) {
        return base;
    }

    // Pattern 3: "U1C9Q1_description" → title "1.9-P1"
    // U1 = Unit 1, C9 = Chapter 9 → "1.9", Q1 → "P1"
    const ucqMatch = base.match(/^U(\d+)C(\d+)Q(\d+)/);
    if (ucqMatch) {
        const unit = ucqMatch[1];
        const chapter = ucqMatch[2];
        const question = ucqMatch[3];
        return `${unit}.${chapter}-P${question}`;
    }

    // Pattern 4: "1.10-P1" → title "1.10-P1"  (double digit chapter)
    if (/^\d+\.\d{2}-P\d+$/.test(base)) {
        return base;
    }

    console.warn(`⚠️  Cannot map filename: ${filename}`);
    return null;
}

// --- Main ---
async function main() {
    // First, sign in as admin user to have proper permissions for storage upload
    console.log('🔑 Signing in as admin...');
    const { data: authData, error: authError } = await supabase.auth.signInWithPassword({
        email: 'newmao6120@gmail.com',
        password: process.env.ADMIN_PASSWORD || ''
    });

    if (authError) {
        console.log('⚠️  Auth failed, proceeding without auth (may fail on storage upload):', authError.message);
        console.log('   Set ADMIN_PASSWORD env var to sign in.');
    } else {
        console.log('✅ Signed in as:', authData.user?.email);
    }

    // Read all PNG files
    const files = fs.readdirSync(IMAGE_DIR).filter(f => f.endsWith('.png'));
    console.log(`\n📁 Found ${files.length} image files in Unit1 image/\n`);

    let successCount = 0;
    let skipCount = 0;
    let failCount = 0;

    for (const filename of files) {
        const title = filenameToTitle(filename);
        if (!title) {
            failCount++;
            continue;
        }

        console.log(`\n--- Processing: ${filename} → title "${title}" ---`);

        // 1. Find question by title
        const { data: question, error: qError } = await supabase
            .from('questions')
            .select('id, title, prompt')
            .eq('title', title)
            .single();

        if (qError || !question) {
            console.error(`  ❌ Question not found for title "${title}":`, qError?.message || 'No data');
            failCount++;
            continue;
        }

        console.log(`  ✅ Found question: ${question.id} (title: ${question.title})`);

        // 2. Parse existing prompt
        let promptArray = [];
        const rawPrompt = question.prompt;

        if (Array.isArray(rawPrompt)) {
            promptArray = [...rawPrompt];
        } else if (typeof rawPrompt === 'string') {
            const trimmed = rawPrompt.trim();
            if (trimmed.startsWith('[')) {
                try { promptArray = JSON.parse(trimmed); } catch { promptArray = [rawPrompt]; }
            } else {
                promptArray = [rawPrompt];
            }
        } else if (rawPrompt) {
            promptArray = [String(rawPrompt)];
        }

        // Check if image already exists in prompt
        const hasImage = promptArray.some(p => typeof p === 'string' && (p.startsWith('http') || p.startsWith('data:image')));
        if (hasImage) {
            console.log(`  ⏭️  Prompt already has an image, skipping to avoid overwrite.`);
            skipCount++;
            continue;
        }

        // 3. Upload image to Storage
        const filePath = path.join(IMAGE_DIR, filename);
        const fileBuffer = fs.readFileSync(filePath);
        const storagePath = `${STORAGE_PATH}/${Date.now()}_${filename.replace(/\s+/g, '_')}`;

        const { error: uploadError } = await supabase.storage
            .from(STORAGE_BUCKET)
            .upload(storagePath, fileBuffer, {
                contentType: 'image/png',
                upsert: true
            });

        if (uploadError) {
            console.error(`  ❌ Upload failed:`, uploadError.message);
            failCount++;
            continue;
        }

        // 4. Get public URL
        const { data: { publicUrl } } = supabase.storage
            .from(STORAGE_BUCKET)
            .getPublicUrl(storagePath);

        console.log(`  📤 Uploaded to: ${publicUrl}`);

        // 5. Append image URL to prompt array
        promptArray.push(publicUrl);

        // 6. Update question in DB
        const { error: updateError } = await supabase
            .from('questions')
            .update({ prompt: promptArray, prompt_type: 'image' })
            .eq('id', question.id);

        if (updateError) {
            console.error(`  ❌ DB update failed:`, updateError.message);
            failCount++;
            continue;
        }

        console.log(`  ✅ Updated prompt: [text, ${publicUrl.substring(0, 60)}...]`);
        successCount++;
    }

    console.log(`\n========================================`);
    console.log(`📊 Results:`);
    console.log(`  ✅ Success: ${successCount}`);
    console.log(`  ⏭️  Skipped: ${skipCount}`);
    console.log(`  ❌ Failed: ${failCount}`);
    console.log(`========================================\n`);
}

main().catch(console.error);
