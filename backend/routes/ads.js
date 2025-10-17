import { Router } from 'express';
import { pool } from '../db.js';
import { requireAuth } from '../middleware/auth.js';

const router = Router();

router.get('/', requireAuth, async (req, res, next) => {
  try {
    const [rows] = await pool.query('SELECT * FROM ads ORDER BY id DESC');
    res.json(rows);
  } catch (err) { next(err); }
});

router.post('/', requireAuth, async (req, res, next) => {
  try {
    const { campaign_id, title, image_url, target_url, status, platform } = req.body;
    const [result] = await pool.query(
      'INSERT INTO ads (campaign_id, title, image_url, target_url, status, platform) VALUES (?, ?, ?, ?, ?, ?)',
      [campaign_id, title, image_url, target_url, status || 'active', platform || null]
    );
    const [rows] = await pool.query('SELECT * FROM ads WHERE id = ?', [result.insertId]);
    res.status(201).json(rows[0]);
  } catch (err) { next(err); }
});

router.put('/:id', requireAuth, async (req, res, next) => {
  try {
    const { id } = req.params;
    const { campaign_id, title, image_url, target_url, status, platform } = req.body;
    await pool.query(
      'UPDATE ads SET campaign_id = ?, title = ?, image_url = ?, target_url = ?, status = ?, platform = ? WHERE id = ?',
      [campaign_id, title, image_url, target_url, status, platform || null, id]
    );
    const [rows] = await pool.query('SELECT * FROM ads WHERE id = ?', [id]);
    res.json(rows[0]);
  } catch (err) { next(err); }
});

router.delete('/:id', requireAuth, async (req, res, next) => {
  try {
    const { id } = req.params;
    await pool.query('DELETE FROM ads WHERE id = ?', [id]);
    res.status(204).end();
  } catch (err) { next(err); }
});

export default router;


