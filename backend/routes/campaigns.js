import { Router } from 'express';
import { pool } from '../db.js';
import { requireAuth } from '../middleware/auth.js';

const router = Router();

router.get('/', requireAuth, async (req, res, next) => {
  try {
    const [rows] = await pool.query('SELECT * FROM campaigns ORDER BY id DESC');
    res.json(rows);
  } catch (err) { next(err); }
});

router.post('/', requireAuth, async (req, res, next) => {
  try {
    const { name, budget, status, start_date, end_date } = req.body;
    const [result] = await pool.query(
      'INSERT INTO campaigns (name, budget, status, start_date, end_date) VALUES (?, ?, ?, ?, ?)',
      [name, budget || 0, status || 'active', start_date || null, end_date || null]
    );
    const [rows] = await pool.query('SELECT * FROM campaigns WHERE id = ?', [result.insertId]);
    res.status(201).json(rows[0]);
  } catch (err) { next(err); }
});

router.put('/:id', requireAuth, async (req, res, next) => {
  try {
    const { id } = req.params;
    const { name, budget, status, start_date, end_date } = req.body;
    await pool.query(
      'UPDATE campaigns SET name = ?, budget = ?, status = ?, start_date = ?, end_date = ? WHERE id = ?',
      [name, budget, status, start_date, end_date, id]
    );
    const [rows] = await pool.query('SELECT * FROM campaigns WHERE id = ?', [id]);
    res.json(rows[0]);
  } catch (err) { next(err); }
});

router.delete('/:id', requireAuth, async (req, res, next) => {
  try {
    const { id } = req.params;
    await pool.query('DELETE FROM campaigns WHERE id = ?', [id]);
    res.status(204).end();
  } catch (err) { next(err); }
});

export default router;


