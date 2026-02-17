import express from 'express';
import cors from 'cors';
import dotenv from 'dotenv';

// Load environment variables
dotenv.config();

import authRoutes from './routes/auth';
import usersRoutes from './routes/users';
import questionsRoutes from './routes/questions';
import practiceRoutes from './routes/practice';
import progressRoutes from './routes/progress';
import contentRoutes from './routes/content';
import notificationsRoutes from './routes/notifications';
import sectionsRoutes from './routes/sections';
import uploadRoutes from './routes/upload';
import { initEmailScheduler } from './services/emailScheduler';

// Initialize Cron Jobs
initEmailScheduler();

const app = express();
const PORT = process.env.PORT || 4000;

// Middleware
app.use(cors({
    origin: (origin: string | undefined, callback: (err: Error | null, allow?: boolean) => void) => {
        // Allow requests with no origin
        if (!origin) return callback(null, true);

        const allowedHosts = [
            /^http:\/\/localhost(:\d+)?$/,
            /^http:\/\/127\.0\.0\.1(:\d+)?$/,
            /^http:\/\/192\.168\.\d+\.\d+(:\d+)?$/,
            /^http:\/\/10\.\d+\.\d+\.\d+(:\d+)?$/,
            /^https:\/\/newmaos\.com$/,
            /^https:\/\/www\.newmaos\.com$/,
            /^https:\/\/newmaos\.vercel\.app$/
        ];

        const isAllowed = allowedHosts.some(regex => regex.test(origin));

        if (isAllowed) {
            callback(null, true);
        } else {
            callback(new Error('Not allowed by CORS'));
        }
    },
    credentials: true
}));
app.use(express.json({ limit: '10mb' }));

// Request logging middleware
app.use((req, res, next) => {
    console.log(`📥 ${req.method} ${req.path}`);
    next();
});

// Health check
app.get('/api/health', (req, res) => {
    res.json({ status: 'ok', timestamp: new Date().toISOString() });
});

// Routes
app.use('/api/auth', authRoutes);
app.use('/api/users', usersRoutes);
app.use('/api/questions', questionsRoutes);
app.use('/api/practice', practiceRoutes);
app.use('/api/progress', progressRoutes);
app.use('/api/content', contentRoutes);
app.use('/api/notifications', notificationsRoutes);
app.use('/api/sections', sectionsRoutes);
app.use('/api/upload', uploadRoutes);

// Error handling middleware
app.use((err: Error, req: express.Request, res: express.Response, next: express.NextFunction) => {
    console.error('Server error:', err);
    res.status(500).json({ error: 'Internal server error' });
});

// 404 handler
app.use((req, res) => {
    res.status(404).json({ error: 'Not found' });
});

app.listen(Number(PORT), '0.0.0.0', () => {
    console.log(`🚀 Server running on http://0.0.0.0:${PORT}`);
    console.log(`📋 API endpoints available at http://0.0.0.0:${PORT}/api`);
});

export default app;
