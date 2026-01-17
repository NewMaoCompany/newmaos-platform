import express from 'express';
import cors from 'cors';
import dotenv from 'dotenv';

// Load environment variables
dotenv.config();

// Import routes
import authRoutes from './routes/auth';
import usersRoutes from './routes/users';
import questionsRoutes from './routes/questions';
import practiceRoutes from './routes/practice';
import progressRoutes from './routes/progress';
import contentRoutes from './routes/content';
import notificationsRoutes from './routes/notifications';
import sectionsRoutes from './routes/sections';
import { initEmailScheduler } from './services/emailScheduler';

// Initialize Cron Jobs
initEmailScheduler();

const app = express();
const PORT = process.env.PORT || 4000;

// Middleware
app.use(cors({
    origin: [
        'http://localhost:3000',
        'http://localhost:3001',
        'http://localhost:5173',
        'https://newmaos.com',
        'https://www.newmaos.com',
        'https://newmaos.vercel.app'
    ],
    credentials: true
}));
app.use(express.json({ limit: '10mb' }));

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

// Error handling middleware
app.use((err: Error, req: express.Request, res: express.Response, next: express.NextFunction) => {
    console.error('Server error:', err);
    res.status(500).json({ error: 'Internal server error' });
});

// 404 handler
app.use((req, res) => {
    res.status(404).json({ error: 'Not found' });
});

app.listen(PORT, () => {
    console.log(`🚀 Server running on http://localhost:${PORT}`);
    console.log(`📋 API endpoints available at http://localhost:${PORT}/api`);
});

export default app;
