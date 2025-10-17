import { Router } from 'express';
import jwt from 'jsonwebtoken';
import bcrypt from 'bcryptjs';
import { pool } from '../db.js';
import { requireAuth } from '../middleware/auth.js';

const router = Router();

// NOTE: Minimal stub; will be expanded
router.post('/register', async (req, res, next) => {
  try {
    const { email, password, name } = req.body;
    if (!email || !password) return res.status(400).json({ message: 'email and password required' });
    const [existing] = await pool.query('SELECT id FROM users WHERE email = ?', [email]);
    if (existing.length) return res.status(409).json({ message: 'email already exists' });
    const hash = await bcrypt.hash(password, 10);
    const [result] = await pool.query(
      'INSERT INTO users (email, password_hash, name, role) VALUES (?, ?, ?, ?)',
      [email, hash, name || null, 'user']
    );
    res.status(201).json({ id: result.insertId, email, name: name || null });
  } catch (err) { next(err); }
});

router.post('/login', async (req, res, next) => {
  try {
    const { email, password } = req.body;
    const [rows] = await pool.query('SELECT id, password_hash, name, role FROM users WHERE email = ?', [email]);
    if (!rows.length) return res.status(401).json({ message: 'invalid credentials' });
    const user = rows[0];
    const ok = await bcrypt.compare(password, user.password_hash);
    if (!ok) return res.status(401).json({ message: 'invalid credentials' });
    const token = jwt.sign({ sub: user.id, email, role: user.role }, process.env.JWT_SECRET || 'dev_secret', { expiresIn: '7d' });
    res.json({ token, user: { id: user.id, email, name: user.name, role: user.role } });
  } catch (err) { next(err); }
});

export default router;

// Profile endpoints
router.get('/me', requireAuth, async (req, res, next) => {
  try {
    const userId = req.user?.sub;
    const [rows] = await pool.query('SELECT id, email, name, created_at FROM users WHERE id = ?', [userId]);
    if (!rows.length) return res.status(404).json({ message: 'user not found' });
    res.json(rows[0]);
  } catch (err) { next(err); }
});

router.put('/me', requireAuth, async (req, res, next) => {
  try {
    const userId = req.user?.sub;
    const { name, password } = req.body || {};
    if (password) {
      const hash = await bcrypt.hash(password, 10);
      await pool.query('UPDATE users SET name = COALESCE(?, name), password_hash = ? WHERE id = ?', [name || null, hash, userId]);
    } else {
      await pool.query('UPDATE users SET name = COALESCE(?, name) WHERE id = ?', [name || null, userId]);
    }
    const [rows] = await pool.query('SELECT id, email, name, created_at FROM users WHERE id = ?', [userId]);
    res.json(rows[0]);
  } catch (err) { next(err); }
});


