import { createClient } from '@supabase/supabase-js';
import * as fs from 'fs';
import * as path from 'path';
import * as dotenv from 'dotenv';

dotenv.config({ path: path.join(process.cwd(), '.env.local') });

const supabaseUrl = process.env.VITE_SUPABASE_URL!;
const supabaseKey = process.env.VITE_SUPABASE_ANON_KEY!;
const supabase = createClient(supabaseUrl, supabaseKey);

async function exportEverything() {
    console.log('🔍 开始导出Supabase完整schema...\n');

    const outputDir = path.join(process.cwd(), 'database', 'schema');
    if (!fs.existsSync(outputDir)) {
        fs.mkdirSync(outputDir, { recursive: true });
    }

    const result: any = {
        exportedAt: new Date().toISOString(),
        database: {
            url: supabaseUrl,
            schema: 'public'
        },
        tables: {},
        views: {},
        functions: {},
        triggers: {},
        policies: {},
        enums: {}
    };

    try {
        // 1. 获取所有表
        console.log('📋 1. 获取所有表...');
        const tables = await getAllTables();
        result.tables = tables;
        console.log(`   ✅ 找到 ${Object.keys(tables).length} 个表\n`);

        // 2. 获取所有视图
        console.log('👁️  2. 获取所有视图...');
        const views = await getAllViews();
        result.views = views;
        console.log(`   ✅ 找到 ${Object.keys(views).length} 个视图\n`);

        // 3. 获取所有函数
        console.log('⚙️  3. 获取所有函数...');
        const functions = await getAllFunctions();
        result.functions = functions;
        console.log(`   ✅ 找到 ${Object.keys(functions).length} 个函数\n`);

        // 4. 获取所有枚举类型
        console.log('🔢 4. 获取所有枚举类型...');
        const enums = await getAllEnums();
        result.enums = enums;
        console.log(`   ✅ 找到 ${Object.keys(enums).length} 个枚举\n`);

        // 5. 尝试获取RLS策略信息
        console.log('🔒 5. 获取RLS策略...');
        const policies = await getAllPolicies();
        result.policies = policies;
        console.log(`   ✅ 找到 ${Object.keys(policies).length} 个策略\n`);

        // 保存完整结果
        const fullPath = path.join(outputDir, 'full-database-export.json');
        fs.writeFileSync(fullPath, JSON.stringify(result, null, 2), 'utf-8');
        console.log(`\n💾 完整导出已保存: ${fullPath}`);

        // 生成SQL文件
        generateSQLDumps(result, outputDir);

        // 生成文档
        generateCompleteDocs(result, outputDir);

        // 打印统计
        printStatistics(result);

    } catch (error) {
        console.error('❌ 导出失败:', error);
        throw error;
    }
}

async function getAllTables(): Promise<any> {
    const query = `
    SELECT 
      t.table_name,
      obj_description((quote_ident(t.table_schema) || '.' || quote_ident(t.table_name))::regclass) as table_comment
    FROM information_schema.tables t
    WHERE t.table_schema = 'public'
      AND t.table_type = 'BASE TABLE'
    ORDER BY t.table_name;
  `;

    const { data, error } = await supabase.rpc('exec_sql' as any, { sql: query });

    if (error) {
        // 如果没有exec_sql RPC，尝试直接查询已知表
        return await discoverTables();
    }

    const tables: any = {};
    if (data) {
        for (const row of data) {
            const tableName = row.table_name;
            const columns = await getTableColumns(tableName);
            const constraints = await getTableConstraints(tableName);

            tables[tableName] = {
                name: tableName,
                comment: row.table_comment,
                columns,
                constraints,
                rowCount: await getRowCount(tableName)
            };
        }
    }

    return tables;
}

async function discoverTables(): Promise<any> {
    // 尝试查询常见表
    const potentialTables = [
        'courses', 'topics', 'sub_topics', 'sections', 'questions', 'options',
        'skills', 'error_tags', 'question_skills', 'question_errors',
        'profiles', 'user_preferences', 'user_progress', 'user_section_progress',
        'session_history', 'session_question_history', 'question_attempts',
        'user_activities', 'user_stats', 'recommendations', 'user_insights',
        'forum_channels', 'forum_messages', 'forum_members', 'forum_reactions',
        'direct_messages', 'dm_participants', 'dm_messages',
        'daily_stats', 'weekly_summaries'
    ];

    const tables: any = {};

    for (const tableName of potentialTables) {
        try {
            const { count } = await supabase
                .from(tableName)
                .select('*', { count: 'exact', head: true });

            if (count !== null) {
                const { data: sample } = await supabase
                    .from(tableName)
                    .select('*')
                    .limit(1);

                const columns = sample && sample.length > 0
                    ? Object.keys(sample[0]).map(key => ({
                        name: key,
                        type: inferType(sample[0][key]),
                        nullable: sample[0][key] === null
                    }))
                    : [];

                tables[tableName] = {
                    name: tableName,
                    columns,
                    rowCount: count,
                    sampleData: sample && sample.length > 0 ? sample[0] : null
                };

                console.log(`   ✓ ${tableName} (${count} rows)`);
            }
        } catch (err) {
            // 表不存在，跳过
        }
    }

    return tables;
}

async function getTableColumns(tableName: string): Promise<any[]> {
    const { data: sample } = await supabase
        .from(tableName)
        .select('*')
        .limit(1);

    if (sample && sample.length > 0) {
        return Object.keys(sample[0]).map(key => ({
            name: key,
            type: inferType(sample[0][key]),
            nullable: sample[0][key] === null
        }));
    }

    return [];
}

async function getTableConstraints(tableName: string): Promise<any[]> {
    // 由于anon key限制，这里返回空数组
    // 完整的约束信息需要service_role key
    return [];
}

async function getRowCount(tableName: string): Promise<number> {
    const { count } = await supabase
        .from(tableName)
        .select('*', { count: 'exact', head: true });
    return count || 0;
}

async function getAllViews(): Promise<any> {
    // Views通常需要更高权限才能查询
    // 尝试查询已知的views
    const knownViews = ['questions_with_skills', 'user_progress_summary'];
    const views: any = {};

    for (const viewName of knownViews) {
        try {
            const { data, error } = await supabase
                .from(viewName)
                .select('*')
                .limit(1);

            if (!error && data) {
                views[viewName] = {
                    name: viewName,
                    columns: data.length > 0 ? Object.keys(data[0]) : [],
                    definition: '(需要service_role权限查看完整定义)'
                };
            }
        } catch (err) {
            // View不存在
        }
    }

    return views;
}

async function getAllFunctions(): Promise<any> {
    // 尝试调用已知的RPC函数来收集它们
    const knownFunctions = [
        'get_user_stats',
        'get_radar_data',
        'get_daily_stats',
        'get_accuracy_history',
        'get_recent_activities',
        'submit_answer',
        'complete_session',
        'get_recommendations'
    ];

    const functions: any = {};

    for (const funcName of knownFunctions) {
        try {
            // 尝试调用（可能会失败，但能确认函数存在）
            const { error } = await supabase.rpc(funcName as any, {});

            functions[funcName] = {
                name: funcName,
                exists: !error || error.message.includes('required'),
                signature: '(需要查看migrations了解完整签名)'
            };

            if (!error || error.message.includes('required')) {
                console.log(`   ✓ ${funcName}`);
            }
        } catch (err) {
            // 函数不存在或无权限
        }
    }

    return functions;
}

async function getAllEnums(): Promise<any> {
    // Enums需要service_role权限
    return {};
}

async function getAllPolicies(): Promise<any> {
    // RLS policies需要service_role权限
    return {};
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

function generateSQLDumps(result: any, outputDir: string) {
    console.log('\n📝 生成SQL文件...');

    let sql = `-- Supabase Schema Export\n`;
    sql += `-- Generated: ${new Date().toISOString()}\n`;
    sql += `-- Database: ${result.database.url}\n\n`;

    sql += `-- ==============================================\n`;
    sql += `-- TABLES (${Object.keys(result.tables).length})\n`;
    sql += `-- ==============================================\n\n`;

    for (const [tableName, table] of Object.entries(result.tables) as [string, any][]) {
        sql += `-- Table: ${tableName}\n`;
        sql += `-- Rows: ${table.rowCount}\n`;
        if (table.columns && table.columns.length > 0) {
            sql += `-- Columns (${table.columns.length}):\n`;
            table.columns.forEach((col: any) => {
                sql += `--   ${col.name}: ${col.type}${col.nullable ? ' (nullable)' : ''}\n`;
            });
        }
        sql += `\n`;
    }

    if (Object.keys(result.functions).length > 0) {
        sql += `\n-- ==============================================\n`;
        sql += `-- FUNCTIONS (${Object.keys(result.functions).length})\n`;
        sql += `-- ==============================================\n\n`;

        for (const [funcName, func] of Object.entries(result.functions) as [string, any][]) {
            sql += `-- Function: ${funcName}\n`;
            sql += `-- ${func.signature}\n\n`;
        }
    }

    const sqlPath = path.join(outputDir, 'schema-overview.sql');
    fs.writeFileSync(sqlPath, sql, 'utf-8');
    console.log(`   ✅ ${sqlPath}`);
}

function generateCompleteDocs(result: any, outputDir: string) {
    console.log('\n📚 生成完整文档...');

    let md = `# Supabase Complete Database Export\n\n`;
    md += `**导出时间**: ${new Date(result.exportedAt).toLocaleString('zh-CN')}\n`;
    md += `**数据库**: ${result.database.url}\n`;
    md += `**Schema**: ${result.database.schema}\n\n`;

    md += `## 📊 总览\n\n`;
    md += `| 类型 | 数量 |\n`;
    md += `|------|------|\n`;
    md += `| Tables | ${Object.keys(result.tables).length} |\n`;
    md += `| Views | ${Object.keys(result.views).length} |\n`;
    md += `| Functions (RPCs) | ${Object.keys(result.functions).length} |\n`;
    md += `| Enums | ${Object.keys(result.enums).length} |\n`;
    md += `| RLS Policies | ${Object.keys(result.policies).length} |\n\n`;

    md += `## 📋 Tables\n\n`;
    for (const [tableName, table] of Object.entries(result.tables) as [string, any][]) {
        md += `### \`${tableName}\`\n\n`;
        md += `**行数**: ${table.rowCount}\n\n`;

        if (table.columns && table.columns.length > 0) {
            md += `| 列名 | 类型 | 可空 |\n`;
            md += `|------|------|------|\n`;
            table.columns.forEach((col: any) => {
                md += `| \`${col.name}\` | ${col.type} | ${col.nullable ? '✓' : ''} |\n`;
            });
            md += `\n`;
        }
    }

    if (Object.keys(result.functions).length > 0) {
        md += `## ⚙️ Functions (RPCs)\n\n`;
        for (const [funcName, func] of Object.entries(result.functions) as [string, any][]) {
            md += `### \`${funcName}\`\n\n`;
            md += `${func.signature}\n\n`;
        }
    }

    const docPath = path.join(outputDir, 'full-database-reference.md');
    fs.writeFileSync(docPath, md, 'utf-8');
    console.log(`   ✅ ${docPath}`);
}

function printStatistics(result: any) {
    console.log('\n' + '='.repeat(50));
    console.log('📈 导出统计');
    console.log('='.repeat(50));
    console.log(`Tables: ${Object.keys(result.tables).length}`);
    console.log(`Views: ${Object.keys(result.views).length}`);
    console.log(`Functions: ${Object.keys(result.functions).length}`);
    console.log(`Enums: ${Object.keys(result.enums).length}`);
    console.log(`Policies: ${Object.keys(result.policies).length}`);

    const totalRows = Object.values(result.tables).reduce((sum: number, t: any) => sum + (t.rowCount || 0), 0);
    console.log(`Total rows: ${totalRows}`);
    console.log('='.repeat(50));
}

exportEverything().catch(console.error);
