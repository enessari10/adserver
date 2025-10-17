import express from 'express';
import cors from 'cors';
import helmet from 'helmet';
import morgan from 'morgan';
import dotenv from 'dotenv';
import path from 'path';
import url from 'url';

import { pingDatabase } from './db.js';
import authRoutes from './routes/auth.js';
import adsRoutes from './routes/ads.js';
import campaignsRoutes from './routes/campaigns.js';
import statsRoutes from './routes/stats.js';

dotenv.config();

const app = express();
const __filename = url.fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

// Secure headers + relaxed CSP for images so external creatives can load
const defaultDirectives = helmet.contentSecurityPolicy.getDefaultDirectives();
const directives = {
  ...defaultDirectives,
  // Allow any http/https image sources and data URIs
  "img-src": ["'self'", "data:", "https:", "http:", "levelupagency.com.tr", "*.levelupagency.com.tr"],
};
app.use(helmet({
  contentSecurityPolicy: { directives },
  crossOriginResourcePolicy: { policy: 'cross-origin' },
  crossOriginEmbedderPolicy: false,
}));
app.use(cors({ origin: '*'}));
app.use(express.json());
app.use(morgan('dev'));

app.get('/health', async (req, res) => {
  try {
    await pingDatabase();
    res.json({ status: 'ok' });
  } catch (err) {
    res.status(500).json({ status: 'error', message: err.message });
  }
});

app.use('/api/auth', authRoutes);
app.use('/api/ads', adsRoutes);
app.use('/api/campaigns', campaignsRoutes);
app.use('/api/stats', statsRoutes);

// Serve public assets like adtag.js
const publicDir = path.resolve(__dirname, '..', 'public');
app.use(express.static(publicDir));

// Serve frontend build (single port)
const frontendDist = path.resolve(__dirname, '..', 'frontend', 'dist');
app.use(express.static(frontendDist));

// SPA fallback: send index.html for non-API routes
app.get('*', (req, res, next) => {
  if (req.path.startsWith('/api/')) return next();
  res.sendFile(path.join(frontendDist, 'index.html'));
});

// Global error handler
// eslint-disable-next-line no-unused-vars
app.use((err, req, res, next) => {
  console.error(err);
  res.status(err.status || 500).json({ message: err.message || 'Internal Server Error' });
});

const PORT = process.env.PORT || 4000;
app.listen(PORT, () => {
  console.log(`Backend listening on http://localhost:${PORT}`);
});


