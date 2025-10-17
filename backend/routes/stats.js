import { Router } from 'express';
import { pool } from '../db.js';

const router = Router();

// Public endpoints to receive tracking events (no auth)
const PIXEL_GIF = Buffer.from(
  'R0lGODlhAQABAPAAAAAAAAAAACH5BAEAAAAALAAAAAABAAEAAAICRAEAOw==',
  'base64'
);
router.post('/impression', async (req, res, next) => {
  try {
    const { ad_id, campaign_id, request_id, user_agent, referer } = req.body;
    await pool.query(
      'INSERT INTO impressions (ad_id, campaign_id, request_id, user_agent, referer) VALUES (?, ?, ?, ?, ?)',
      [ad_id || null, campaign_id || null, request_id || null, user_agent || null, referer || null]
    );
    res.status(201).json({ status: 'ok' });
  } catch (err) { next(err); }
});

router.post('/click', async (req, res, next) => {
  try {
    const { ad_id, campaign_id, request_id, user_agent, referer } = req.body;
    await pool.query(
      'INSERT INTO clicks (ad_id, campaign_id, request_id, user_agent, referer) VALUES (?, ?, ?, ?, ?)',
      [ad_id || null, campaign_id || null, request_id || null, user_agent || null, referer || null]
    );
    res.status(201).json({ status: 'ok' });
  } catch (err) { next(err); }
});

// Pixel fallback for impressions
router.get('/impression.gif', async (req, res, next) => {
  try {
    const { ad_id, campaign_id, request_id } = req.query;
    const referer = req.get('referer') || req.query.referer || null;
    const user_agent = req.get('user-agent') || null;
    await pool.query(
      'INSERT INTO impressions (ad_id, campaign_id, request_id, user_agent, referer) VALUES (?, ?, ?, ?, ?)',
      [ad_id || null, campaign_id || null, request_id || null, user_agent, referer]
    );
  } catch (err) { /* swallow */ }
  res.set('Content-Type', 'image/gif');
  res.set('Cache-Control', 'no-cache, no-store, must-revalidate');
  res.send(PIXEL_GIF);
});

// Pixel fallback for clicks
router.get('/click.gif', async (req, res, next) => {
  try {
    const { ad_id, campaign_id, request_id } = req.query;
    const referer = req.get('referer') || req.query.referer || null;
    const user_agent = req.get('user-agent') || null;
    await pool.query(
      'INSERT INTO clicks (ad_id, campaign_id, request_id, user_agent, referer) VALUES (?, ?, ?, ?, ?)',
      [ad_id || null, campaign_id || null, request_id || null, user_agent, referer]
    );
  } catch (err) { /* swallow */ }
  res.set('Content-Type', 'image/gif');
  res.set('Cache-Control', 'no-cache, no-store, must-revalidate');
  res.send(PIXEL_GIF);
});
// Aggregated reporting (auth required)
router.get('/report', async (req, res, next) => {
  try {
    const { from, to, groupBy = 'day' } = req.query;
    const dateExpr = groupBy === 'hour' ? 'DATE_FORMAT(created_at, "%d/%m/%Y %H:00")' : 'DATE_FORMAT(created_at, "%d/%m/%Y")';
    const [imp] = await pool.query(
      `SELECT ${dateExpr} as ts, ad_id, campaign_id, COUNT(*) as impressions
       FROM impressions
       WHERE (? IS NULL OR created_at >= ?) AND (? IS NULL OR created_at <= ?)
       GROUP BY ts, ad_id, campaign_id
       ORDER BY ts DESC`
    , [from || null, from || null, to || null, to || null]);

    const [clk] = await pool.query(
      `SELECT ${dateExpr} as ts, ad_id, campaign_id, COUNT(*) as clicks
       FROM clicks
       WHERE (? IS NULL OR created_at >= ?) AND (? IS NULL OR created_at <= ?)
       GROUP BY ts, ad_id, campaign_id
       ORDER BY ts DESC`
    , [from || null, from || null, to || null, to || null]);

    res.json({ impressions: imp, clicks: clk });
  } catch (err) { next(err); }
});

// Campaign-level aggregated reporting
router.get('/report/campaigns', async (req, res, next) => {
  try {
    const { from, to, groupBy = 'day' } = req.query;
    const dateExpr = groupBy === 'hour' ? 'DATE_FORMAT(created_at, "%d/%m/%Y %H:00")' : 'DATE_FORMAT(created_at, "%d/%m/%Y")';

    const [imp] = await pool.query(
      `SELECT ${dateExpr} as ts, i.campaign_id, c.name as campaign_name, COUNT(*) as impressions
       FROM impressions i
       LEFT JOIN campaigns c ON c.id = i.campaign_id
       WHERE (? IS NULL OR i.created_at >= ?) AND (? IS NULL OR i.created_at <= ?)
       GROUP BY ts, i.campaign_id, c.name
       ORDER BY ts DESC`
      , [from || null, from || null, to || null, to || null]);

    const [clk] = await pool.query(
      `SELECT ${dateExpr} as ts, k.campaign_id, c.name as campaign_name, COUNT(*) as clicks
       FROM clicks k
       LEFT JOIN campaigns c ON c.id = k.campaign_id
       WHERE (? IS NULL OR k.created_at >= ?) AND (? IS NULL OR k.created_at <= ?)
       GROUP BY ts, k.campaign_id, c.name
       ORDER BY ts DESC`
      , [from || null, from || null, to || null, to || null]);

    res.json({ impressions: imp, clicks: clk });
  } catch (err) { next(err); }
});

// Ad-level aggregated reporting
router.get('/report/ads', async (req, res, next) => {
  try {
    const { from, to, groupBy = 'day' } = req.query;
    const dateExpr = groupBy === 'hour' ? 'DATE_FORMAT(created_at, "%d/%m/%Y %H:00")' : 'DATE_FORMAT(created_at, "%d/%m/%Y")';

    const [imp] = await pool.query(
      `SELECT ${dateExpr} as ts, i.ad_id, i.campaign_id, a.title as ad_title, a.platform as platform, COUNT(*) as impressions
       FROM impressions i
       LEFT JOIN ads a ON a.id = i.ad_id
       WHERE (? IS NULL OR i.created_at >= ?) AND (? IS NULL OR i.created_at <= ?)
       GROUP BY ts, i.ad_id, i.campaign_id, a.title, a.platform
       ORDER BY ts DESC`
      , [from || null, from || null, to || null, to || null]);

    const [clk] = await pool.query(
      `SELECT ${dateExpr} as ts, k.ad_id, k.campaign_id, a.title as ad_title, a.platform as platform, COUNT(*) as clicks
       FROM clicks k
       LEFT JOIN ads a ON a.id = k.ad_id
       WHERE (? IS NULL OR k.created_at >= ?) AND (? IS NULL OR k.created_at <= ?)
       GROUP BY ts, k.ad_id, k.campaign_id, a.title, a.platform
       ORDER BY ts DESC`
      , [from || null, from || null, to || null, to || null]);

    res.json({ impressions: imp, clicks: clk });
  } catch (err) { next(err); }
});

export default router;


