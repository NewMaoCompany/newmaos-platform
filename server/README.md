# NewMaoS Backend Server

Express.js backend server for the AP Calculus Mastery application.

## Prerequisites

- Node.js 18+ installed
- A Supabase project (free tier works)

## Quick Start

### 1. Set up Supabase

1. Create a new project at [supabase.com](https://supabase.com)
2. Go to Settings > API to get your credentials
3. Go to SQL Editor and run the schema from `../database/schema.sql`

### 2. Configure Environment

```bash
# Copy the example env file
cp .env.example .env

# Edit .env with your Supabase credentials
```

Your `.env` file should look like:
```
PORT=4005
SUPABASE_URL=https://your-project.supabase.co
SUPABASE_ANON_KEY=eyJhbGciOiJI...
SUPABASE_SERVICE_KEY=eyJhbGciOiJI...
```

### 3. Install & Run

```bash
# Install dependencies
npm install

# Start development server (with hot reload)
npm run dev

# Or build and run production
npm run build
npm start
```

The server will start at `http://localhost:4005`

## API Endpoints

### Health Check
- `GET /api/health` - Server status

### Authentication
- `POST /api/auth/register` - Register new user
- `POST /api/auth/login` - Login
- `POST /api/auth/logout` - Logout
- `POST /api/auth/forgot-password` - Request password reset
- `POST /api/auth/reset-password` - Reset password
- `POST /api/auth/verify-creator` - Verify creator access

### Users
- `GET /api/users/me` - Get current user profile
- `PUT /api/users/me` - Update profile
- `PUT /api/users/preferences` - Update preferences
- `GET /api/users/full` - Get all user data (profile, progress, activities)

### Questions
- `GET /api/questions` - Get questions (with filters)
- `POST /api/questions` - Create question (creator only)
- `PUT /api/questions/:id` - Update question
- `DELETE /api/questions/:id` - Delete question

### Practice
- `POST /api/practice/complete` - Record practice session
- `GET /api/practice/recommendation` - Get AI recommendation

### Progress
- `GET /api/progress/mastery` - Get topic mastery (radar data)
- `GET /api/progress/activities` - Get activity history
- `GET /api/progress/line-data` - Get performance trend
- `GET /api/progress/courses` - Get course progress

### Content
- `GET /api/content/topics` - Get topic content
- `PUT /api/content/topics/:unitId` - Update unit
- `PUT /api/content/topics/:unitId/subtopics/:subTopicId` - Update subtopic
- `POST /api/content/seed` - Seed initial content

### Notifications
- `GET /api/notifications` - Get notifications
- `PUT /api/notifications/:id/read` - Mark as read
- `PUT /api/notifications/read-all` - Mark all as read

## Development

```bash
# Run with hot reload
npm run dev

# Type check
npx tsc --noEmit
```

## Testing

```bash
# Test health endpoint
curl http://localhost:4005/api/health

# Test with auth token
curl -H "Authorization: Bearer YOUR_TOKEN" http://localhost:4005/api/users/me
```
