import dotenv from 'dotenv';
import mysql from 'mysql2/promise';

dotenv.config();

const {
  DB_HOST = '127.0.0.1',
  DB_PORT = '3306',
  DB_USER = 'root',
  DB_PASSWORD = '',
  DB_NAME = 'adserver'
} = process.env;

const normalizedHost = (DB_HOST || '127.0.0.1').replace(/\/+$/, '');

export const pool = mysql.createPool({
  host: normalizedHost,
  port: Number(DB_PORT),
  user: DB_USER,
  password: DB_PASSWORD,
  database: DB_NAME,
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0,
});

export async function pingDatabase() {
  const connection = await pool.getConnection();
  try {
    await connection.ping();
  } finally {
    connection.release();
  }
}


