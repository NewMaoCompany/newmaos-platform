import { createClient } from '@supabase/supabase-js';
import * as fs from 'fs';
import * as path from 'path';
import * as dotenv from 'dotenv';

// 加载环境变量
dotenv.config({ path: path.join(process.cwd(), '.env.local') });

const supabaseUrl = process.env.VITE_SUPABASE_URL!;
const supabaseKey = process.env.VITE_SUPABASE_ANON_KEY!;

const supabase = createClient(supabaseUrl, supabaseKey);

async function exportSchema() {
    console.log('🔍 正在导出Supabase schema...\n');

    // 1. 获取所有表
    const { data: tables, error: tablesError } = await supabase.rpc('get_tables_info' as any);

    // 如果RPC不存在，使用直接查询
    const tablesQuery = await supabase.from('information_schema.tables' as any).select('*');

    // 使用原始SQL查询
    const queries = {
        tables: `
      SELECT table_name, table_type
      FROM information_schema.tables
      WHERE table_schema = 'public'
      ORDER BY table_name;
    `,
        columns: `
      SELECT 
        table_name,
        column_name,
        data_type,
        character_maximum_length,
        is_nullable,
        column_default,
        ordinal_position
      FROM information_schema.columns
      WHERE table_schema = 'public'
      ORDER BY table_name, ordinal_position;
    `,
        foreignKeys: `
      SELECT
        tc.table_name,
        kcu.column_name,
        ccu.table_name AS foreign_table_name,
        ccu.column_name AS foreign_column_name,
        tc.constraint_name
      FROM information_schema.table_constraints AS tc
      JOIN information_schema.key_column_usage AS kcu
        ON tc.constraint_name = kcu.constraint_name
      JOIN information_schema.constraint_column_usage AS ccu
        ON ccu.constraint_name = tc.constraint_name
      WHERE tc.constraint_type = 'FOREIGN KEY'
        AND tc.table_schema = 'public';
    `,
        primaryKeys: `
      SELECT
        tc.table_name,
        kcu.column_name,
        tc.constraint_name
      FROM information_schema.table_constraints AS tc
      JOIN information_schema.key_column_usage AS kcu
        ON tc.constraint_name = kcu.constraint_name
      WHERE tc.constraint_type = 'PRIMARY KEY'
        AND tc.table_schema = 'public';
    `
    };

    const schema: any = {
        tables: [],
        columns: {},
        foreignKeys: [],
        primaryKeys: {},
        functions: []
    };

    // 执行查询并导出结果
    try {
        // 尝试获取所有表名
        const allTables = [
            'courses', 'topics', 'sub_topics', 'questions', 'options',
            'skills', 'error_tags', 'question_skills', 'question_errors',
            'profiles', 'user_progress', 'user_section_progress',
            'session_history', 'session_question_history',
            'user_activities', 'recommendations',
            'forum_channels', 'forum_messages', 'forum_members',
            'direct_messages', 'dm_participants'
        ];

        console.log('📊 正在导出表结构...\n');

        for (const tableName of allTables) {
            try {
                // 获取表的第一行数据来推断结构
                const { data, error } = await supabase
                    .from(tableName)
                    .select('*')
                    .limit(1);

                if (!error && data && data.length > 0) {
                    const sampleRow = data[0];
                    const columns = Object.keys(sampleRow).map(key => ({
                        name: key,
                        type: typeof sampleRow[key],
                        sample: sampleRow[key]
                    }));

                    schema.tables.push(tableName);
                    schema.columns[tableName] = columns;
                    console.log(`✅ ${tableName}: ${columns.length} columns`);
                } else if (!error) {
                    // 表存在但为空
                    schema.tables.push(tableName);
                    schema.columns[tableName] = [];
                    console.log(`✅ ${tableName}: (empty table)`);
                }
            } catch (err) {
                console.log(`⏭️  ${tableName}: 表不存在或无权限`);
            }
        }

        // 保存到文件
        const outputDir = path.join(process.cwd(), 'database', 'schema');
        if (!fs.existsSync(outputDir)) {
            fs.mkdirSync(outputDir, { recursive: true });
        }

        const schemaPath = path.join(outputDir, 'exported-schema.json');
        fs.writeFileSync(schemaPath, JSON.stringify(schema, null, 2), 'utf-8');

        console.log(`\n💾 Schema已保存到: ${schemaPath}`);
        console.log(`\n📈 统计:`);
        console.log(`   - 表数量: ${schema.tables.length}`);
        console.log(`   - 总列数: ${Object.values(schema.columns).flat().length}`);

        // 生成Markdown文档
        generateMarkdownDocs(schema, outputDir);

    } catch (error) {
        console.error('❌ 导出失败:', error);
        throw error;
    }
}

function generateMarkdownDocs(schema: any, outputDir: string) {
    let markdown = `# Supabase Database Schema\n\n`;
    markdown += `导出时间: ${new Date().toISOString()}\n\n`;
    markdown += `## 数据库统计\n\n`;
    markdown += `- **表数量**: ${schema.tables.length}\n`;
    markdown += `- **总列数**: ${Object.values(schema.columns).reduce((sum: number, cols: any) => sum + cols.length, 0)}\n\n`;

    markdown += `## 表列表\n\n`;
    schema.tables.forEach((table: string) => {
        markdown += `- \`${table}\`\n`;
    });

    markdown += `\n## 表结构详情\n\n`;

    for (const [tableName, columns] of Object.entries(schema.columns) as [string, any[]][]) {
        markdown += `### \`${tableName}\`\n\n`;

        if (columns.length === 0) {
            markdown += `*表为空，无法推断结构*\n\n`;
            continue;
        }

        markdown += `| 列名 | 类型推断 | 示例值 |\n`;
        markdown += `|------|----------|--------|\n`;

        columns.forEach(col => {
            const sampleValue = col.sample === null ? 'null' :
                typeof col.sample === 'object' ? JSON.stringify(col.sample).substring(0, 50) :
                    String(col.sample).substring(0, 50);
            markdown += `| \`${col.name}\` | ${col.type} | ${sampleValue} |\n`;
        });

        markdown += `\n`;
    }

    const docPath = path.join(outputDir, 'schema-reference.md');
    fs.writeFileSync(docPath, markdown, 'utf-8');
    console.log(`📝 文档已生成: ${docPath}`);
}

// 运行导出
exportSchema().catch(console.error);
