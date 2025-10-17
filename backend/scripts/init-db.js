import fs from 'fs';
import path from 'path';
import url from 'url';
import { pool, pingDatabase } from '../db.js';

const __filename = url.fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

async function run() {
  try {
    await pingDatabase();
    const schemaPath = path.join(__dirname, '..', 'sql', 'schema.sql');
    const sql = fs.readFileSync(schemaPath, 'utf8');

    // Split by ; while keeping statements simple (no procedures in this file)
    const statements = sql
      .split(/;\s*\n/)
      .map(s => s.trim())
      .filter(Boolean);

    for (const stmt of statements) {
      // Skip comments-only lines
      if (/^--/.test(stmt)) continue;
      await pool.query(stmt);
    }
    console.log('Database schema initialized.');
    process.exit(0);
  } catch (err) {
    console.error('Failed to initialize schema:', err.message);
    process.exit(1);
  }
}

run();


