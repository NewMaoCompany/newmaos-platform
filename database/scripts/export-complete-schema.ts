import { createClient } from '@supabase/supabase-js';
import * as fs from 'fs';
import * as path from 'path';
import * as dotenv from 'dotenv';

// 加载环境变量
dotenv.config({ path: path.join(process.cwd(), '.env.local') });

const supabaseUrl = process.env.VITE_SUPABASE_URL!;
const supabaseKey = process.env.VITE_SUPABASE_ANON_KEY!;

const supabase = createClient(supabaseUrl, supabaseKey);

async function getAllTables() {
    console.log('🔍 正在获取所有表名...\n');

    // 从AppContext和代码中收集的所有可能的表名
    const potentialTables = [
        // Core content tables
        'courses', 'topics', 'sub_topics', 'sections',
        'questions', 'options',

        // Metadata and relationships
        'skills', 'error_tags',
        'question_skills', 'question_errors',

        // User and progress
        'profiles', 'user_preferences',
        'user_progress', 'user_section_progress',
        'session_history', 'session_question_history',
        'user_activities', 'user_stats',

        // Recommendations and insights
        'recommendations', 'user_insights',

        // Forum and social
        'forum_channels', 'forum_messages', 'forum_members',
        'forum_reactions', 'forum_threads',
        'direct_messages', 'dm_participants', 'dm_messages',

        // Analytics
        'daily_stats', 'weekly_summaries'
    ];

    const existingTables: string[] = [];
    const tableSchemas: any = {};

    for (const tableName of potentialTables) {
        try {
            // 尝试查询表的第一行
            const { data, error, count } = await supabase
                .from(tableName)
                .select('*', { count: 'exact', head: false })
                .limit(1);

            if (!error) {
                existingTables.push(tableName);

                if (data && data.length > 0) {
                    const sampleRow = data[0];
                    const columns = Object.keys(sampleRow).map(key => ({
                        name: key,
                        type: inferType(sampleRow[key]),
                        nullable: sampleRow[key] === null,
                        sample: truncateSample(sampleRow[key])
                    }));
                    tableSchemas[tableName] = {
                        columns,
                        rowCount: count || 0,
                        isEmpty: false
                    };
                    console.log(`✅ ${tableName}: ${columns.length} columns, ${count || 0} rows`);
                } else {
                    tableSchemas[tableName] = {
                        columns: [],
                        rowCount: 0,
                        isEmpty: true
                    };
                    console.log(`✅ ${tableName}: (empty table)`);
                }
            }
        } catch (err) {
            // 表不存在或无权限，跳过
        }
    }

    return { existingTables, tableSchemas };
}

function inferType(value: any): string {
    if (value === null) return 'null';
    if (Array.isArray(value)) return 'array';
    if (typeof value === 'object') return 'jsonb';
    if (typeof value === 'string') {
        // 检测UUID
        if (/^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i.test(value)) {
            return 'uuid';
        }
        // 检测时间戳
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

function truncateSample(value: any): any {
    if (value === null) return null;
    if (typeof value === 'string' && value.length > 100) {
        return value.substring(0, 100) + '...';
    }
    if (Array.isArray(value) && value.length > 3) {
        return [...value.slice(0, 3), '...'];
    }
    if (typeof value === 'object') {
        const keys = Object.keys(value);
        if (keys.length > 5) {
            const truncated: any = {};
            keys.slice(0, 5).forEach(k => truncated[k] = value[k]);
            truncated['...'] = `... and ${keys.length - 5} more`;
            return truncated;
        }
    }
    return value;
}

async function exportCompleteSchema() {
    const { existingTables, tableSchemas } = await getAllTables();

    console.log(`\n📊 统计:`);
    console.log(`   - 找到 ${existingTables.length} 个表`);
    console.log(`   - 有数据的表: ${Object.values(tableSchemas).filter((s: any) => !s.isEmpty).length}`);

    // 保存JSON
    const outputDir = path.join(process.cwd(), 'database', 'schema');
    if (!fs.existsSync(outputDir)) {
        fs.mkdirSync(outputDir, { recursive: true });
    }

    const fullSchema = {
        exportedAt: new Date().toISOString(),
        tables: existingTables,
        schemas: tableSchemas,
        statistics: {
            totalTables: existingTables.length,
            tablesWithData: Object.values(tableSchemas).filter((s: any) => !s.isEmpty).length,
            emptyTables: Object.values(tableSchemas).filter((s: any) => s.isEmpty).length,
            totalColumns: Object.values(tableSchemas).reduce((sum: number, s: any) => sum + s.columns.length, 0)
        }
    };

    const schemaPath = path.join(outputDir, 'complete-schema.json');
    fs.writeFileSync(schemaPath, JSON.stringify(fullSchema, null, 2), 'utf-8');
    console.log(`\n💾 完整schema已保存: ${schemaPath}`);

    // 生成详细的Markdown文档
    generateDetailedDocs(fullSchema, outputDir);
}

function generateDetailedDocs(schema: any, outputDir: string) {
    let md = `# Supabase Database Complete Schema\n\n`;
    md += `**导出时间**: ${new Date(schema.exportedAt).toLocaleString('zh-CN')}\n\n`;

    md += `## 📊 数据库统计\n\n`;
    md += `| 指标 | 数量 |\n`;
    md += `|------|------|\n`;
    md += `| 总表数 | ${schema.statistics.totalTables} |\n`;
    md += `| 有数据的表 | ${schema.statistics.tablesWithData} |\n`;
    md += `| 空表 | ${schema.statistics.emptyTables} |\n`;
    md += `| 总列数 | ${schema.statistics.totalColumns} |\n\n`;

    md += `## 📋 表分类\n\n`;

    const categories = {
        'Core Content': ['courses', 'topics', 'sub_topics', 'sections', 'questions', 'options'],
        'Metadata': ['skills', 'error_tags', 'question_skills', 'question_errors'],
        'User & Progress': ['profiles', 'user_preferences', 'user_progress', 'user_section_progress', 'session_history', 'session_question_history', 'user_activities', 'user_stats'],
        'Recommendations': ['recommendations', 'user_insights'],
        'Forum': ['forum_channels', 'forum_messages', 'forum_members', 'forum_reactions', 'forum_threads'],
        'Direct Messages': ['direct_messages', 'dm_participants', 'dm_messages'],
        'Analytics': ['daily_stats', 'weekly_summaries']
    };

    for (const [category, tables] of Object.entries(categories)) {
        const existingInCategory = tables.filter(t => schema.tables.includes(t));
        if (existingInCategory.length > 0) {
            md += `### ${category}\n\n`;
            existingInCategory.forEach(t => {
                const info = schema.schemas[t];
                const status = info.isEmpty ? '(空)' : `${info.rowCount} rows`;
                md += `- \`${t}\` - ${info.columns.length} columns ${status}\n`;
            });
            md += `\n`;
        }
    }

    md += `## 📝 表结构详情\n\n`;

    for (const tableName of schema.tables) {
        const tableInfo = schema.schemas[tableName];
        md += `### \`${tableName}\`\n\n`;

        if (tableInfo.isEmpty) {
            md += `*⚠️ 表为空，无法从数据推断结构*\n\n`;
            continue;
        }

        md += `**行数**: ${tableInfo.rowCount}\n\n`;
        md += `| 列名 | 类型 | 可空 | 示例值 |\n`;
        md += `|------|------|------|--------|\n`;

        tableInfo.columns.forEach((col: any) => {
            const nullable = col.nullable ? '✓' : '';
            let sampleStr = '';
            if (col.sample === null) {
                sampleStr = 'null';
            } else if (typeof col.sample === 'object') {
                sampleStr = JSON.stringify(col.sample).substring(0, 50);
            } else {
                sampleStr = String(col.sample).substring(0, 50);
            }
            md += `| \`${col.name}\` | ${col.type} | ${nullable} | ${sampleStr} |\n`;
        });

        md += `\n`;
    }

    const docPath = path.join(outputDir, 'complete-schema-reference.md');
    fs.writeFileSync(docPath, md, 'utf-8');
    console.log(`📖 完整文档已生成: ${docPath}`);
}

exportCompleteSchema().catch(console.error);
