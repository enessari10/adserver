import { pool, pingDatabase } from '../db.js'

async function run(){
  await pingDatabase()
  const [cols] = await pool.query("SHOW COLUMNS FROM ads LIKE 'platform'")
  if (cols.length === 0) {
    await pool.query('ALTER TABLE ads ADD COLUMN platform VARCHAR(100) NULL')
    console.log('Added platform column to ads')
  } else {
    console.log('platform column already exists')
  }

  const [roleCol] = await pool.query("SHOW COLUMNS FROM users LIKE 'role'")
  if (roleCol.length === 0) {
    await pool.query("ALTER TABLE users ADD COLUMN role ENUM('admin','user') NOT NULL DEFAULT 'user'")
    console.log('Added role column to users')
  } else {
    console.log('users.role already exists')
  }
  process.exit(0)
}

run().catch(err=>{ console.error(err); process.exit(1) })


