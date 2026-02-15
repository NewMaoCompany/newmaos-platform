import { createClient } from '@supabase/supabase-js';
import * as fs from 'fs';
import * as path from 'path';
import * as dotenv from 'dotenv';

dotenv.config({ path: path.join(process.cwd(), '.env.local') });

const supabaseUrl = process.env.VITE_SUPABASE_URL!;
const supabaseKey = process.env.VITE_SUPABASE_ANON_KEY!;
const supabase = createClient(supabaseUrl, supabaseKey);

async function exportAllTables() {
    console.log('🔍 导出所有Supabase表...\n');

    // 从Supabase Dashboard截图中看到的完整表列表
    const allTables = [
        // 从截图中读取的完整列表
        'activities',
        'attempts_errors',
        'attempts_lessons',
        'direct_chat_participants',
        'direct_chats',
        'direct_messages',
        'error_tags',
        'forum_channels',
        'forum_members',
        'forum_messages',
        'notifications',
        'question_attempts',
        'question_qna_patterns',
        'question_skills',
        'question_violations',
        'questions',
        'recommendations',
        'sections',
        'session_history',
        'session_question_history',
        'skills',
        'topic_content',
        'unit_mastery',
        'user_profiles',
        'user_question_state',
        'user_section_progress',
        'user_skill_mastery',
        'user_stats',
        'verification_codes'
    ];

    const result: any = {
        exportedAt: new Date().toISOString(),
        totalTables: allTables.length,
        tables: {}
    };

    console.log(`📊 尝试导出 ${allTables.length} 个表...\n`);

    for (const tableName of allTables) {
        try {
            const { count } = await supabase
                .from(tableName)
                .select('*', { count: 'exact', head: true });

            const { data: sample } = await supabase
                .from(tableName)
                .select('*')
                .limit(1);

            const columns = sample && sample.length > 0
                ? Object.keys(sample[0]).map(key => ({
                    name: key,
                    type: inferType(sample[0][key]),
                    nullable: sample[0][key] === null,
                    sample: truncate(sample[0][key])
                }))
                : [];

            result.tables[tableName] = {
                name: tableName,
                rowCount: count || 0,
                columnCount: columns.length,
                columns,
                isEmpty: (count === 0),
                sampleData: sample && sample.length > 0 ? sample[0] : null
            };

            const status = count === 0 ? '(空)' : `${count} rows`;
            console.log(`✅ ${tableName.padEnd(30)} ${columns.length.toString().padStart(2)} cols  ${status}`);

        } catch (error: any) {
            console.log(`❌ ${tableName.padEnd(30)} 无法访问`);
            result.tables[tableName] = {
                name: tableName,
                error: error.message,
                accessible: false
            };
        }
    }

    // 保存结果
    const outputDir = path.join(process.cwd(), 'database', 'schema');
    const outputPath = path.join(outputDir, 'all-tables-export.json');
    fs.writeFileSync(outputPath, JSON.stringify(result, null, 2), 'utf-8');

    console.log(`\n💾 已保存: ${outputPath}`);

    // 生成文档
    generateTablesDocs(result, outputDir);

    // 统计
    const accessible = Object.values(result.tables).filter((t: any) => t.accessible !== false).length;
    const withData = Object.values(result.tables).filter((t: any) => !t.isEmpty && t.accessible !== false).length;
    const totalRows = Object.values(result.tables)
        .filter((t: any) => t.rowCount)
        .reduce((sum: number, t: any) => sum + t.rowCount, 0);

    console.log('\n' + '='.repeat(60));
    console.log('📈 最终统计');
    console.log('='.repeat(60));
    console.log(`总表数: ${allTables.length}`);
    console.log(`可访问: ${accessible}`);
    console.log(`有数据: ${withData}`);
    console.log(`总行数: ${totalRows}`);
    console.log('='.repeat(60));
}

function inferType(value: any): string {
    if (value === null) return 'null';
    if (Array.isArray(value)) return 'array';
    if (typeof value === 'object') return 'jsonb';
    if (typeof value === 'string') {
        if (/^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i.test(value)) {
            return 'uuid';
        }
        if (/^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}/.test(value)) {
            return 'timestamp';
        }
        return 'text';
    }
    if (typeof value === 'number') {
        return Number.isInteger(value) ? 'integer' : 'numeric';
    }
    if (typeof value === 'boolean') return 'boolean';
    return 'unknown';
}

function truncate(value: any): any {
    if (value === null) return null;
    if (typeof value === 'string' && value.length > 100) {
        return value.substring(0, 100) + '...';
    }
    if (Array.isArray(value) && value.length > 3) {
        return [...value.slice(0, 3), `... +${value.length - 3} more`];
    }
    return value;
}

function generateTablesDocs(result: any, outputDir: string) {
    let md = `# Supabase所有表导出\n\n`;
    md += `**导出时间**: ${new Date(result.exportedAt).toLocaleString('zh-CN')}\n`;
    md += `**总表数**: ${result.totalTables}\n\n`;

    md += `## 📋 完整表列表\n\n`;
    md += `| # | 表名 | 列数 | 行数 | 状态 |\n`;
    md += `|---|------|------|------|------|\n`;

    let index = 1;
    for (const [tableName, table] of Object.entries(result.tables) as [string, any][]) {
        if (table.accessible === false) {
            md += `| ${index} | \`${tableName}\` | - | - | ❌ 无法访问 |\n`;
        } else {
            const cols = table.columnCount || 0;
            const rows = table.rowCount || 0;
            const status = rows === 0 ? '空' : '✓';
            md += `| ${index} | \`${tableName}\` | ${cols} | ${rows} | ${status} |\n`;
        }
        index++;
    }

    md += `\n## 📊 按类别分组\n\n`;

    const categories: any = {
        '核心内容': ['sections', 'questions', 'topic_content'],
        '元数据': ['skills', 'error_tags', 'question_skills', 'question_violations', 'question_qna_patterns'],
        '用户与进度': ['user_profiles', 'user_section_progress', 'user_question_state', 'user_skill_mastery', 'user_stats', 'unit_mastery'],
        '会话历史': ['session_history', 'session_question_history', 'question_attempts'],
        '练习尝试': ['attempts_lessons', 'attempts_errors'],
        '推荐系统': ['recommendations'],
        '论坛': ['forum_channels', 'forum_messages', 'forum_members'],
        '私信': ['direct_chats', 'direct_messages', 'direct_chat_participants'],
        '通知': ['notifications'],
        '其他': ['activities', 'verification_codes']
    };

    for (const [category, tables] of Object.entries(categories)) {
        const existing = tables.filter((t: string) => result.tables[t]);
        if (existing.length > 0) {
            md += `### ${category}\n\n`;
            existing.forEach((t: string) => {
                const info = result.tables[t];
                if (info.accessible !== false) {
                    md += `- \`${t}\` (${info.columnCount} cols, ${info.rowCount} rows)\n`;
                }
            });
            md += `\n`;
        }
    }

    md += `## 📝 表结构详情\n\n`;

    for (const [tableName, table] of Object.entries(result.tables) as [string, any][]) {
        if (table.accessible === false) continue;

        md += `### \`${tableName}\`\n\n`;
        md += `**行数**: ${table.rowCount}  \n`;
        md += `**列数**: ${table.columnCount}\n\n`;

        if (table.columns && table.columns.length > 0) {
            md += `| 列名 | 类型 | 可空 | 示例 |\n`;
            md += `|------|------|------|------|\n`;

            table.columns.forEach((col: any) => {
                const nullable = col.nullable ? '✓' : '';
                let sampleStr = '';
                if (col.sample === null) {
                    sampleStr = 'null';
                } else if (typeof col.sample === 'object') {
                    sampleStr = JSON.stringify(col.sample).substring(0, 40);
                } else {
                    sampleStr = String(col.sample).substring(0, 40);
                }
                md += `| \`${col.name}\` | ${col.type} | ${nullable} | ${sampleStr} |\n`;
            });
            md += `\n`;
        } else {
            md += `*表为空，无法推断结构*\n\n`;
        }
    }

    const docPath = path.join(outputDir, 'all-tables-reference.md');
    fs.writeFileSync(docPath, md, 'utf-8');
    console.log(`📖 文档已生成: ${docPath}`);
}

exportAllTables().catch(console.error);
