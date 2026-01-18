# Chameleon-MirrorMail-Guntroide-v.1

Personal Private Shadow Email Service - A full-stack application built with modern web technologies.

## 🏗️ Architecture

### Front-End
- **React** - Modern UI library for building reusable components
- **Vite** - Fast build tool and development server
- **Tailwind CSS** - Utility-first CSS framework for rapid styling
- **Context API** - Built-in React state management
- **React Testing Library** - Testing utilities for React components

### Back-End
- **Node.js** with **Express.js** - RESTful API server
- **PostgreSQL** - Robust relational database
- **JWT** - Secure stateless authentication
- **bcryptjs** - Password hashing
- **Helmet** - Security middleware
- **CORS** - Cross-origin resource sharing
- **Rate Limiting** - API abuse prevention
- **Mocha & Supertest** - Testing framework

### DevOps
- **Docker** & **Docker Compose** - Containerization
- **GitHub Actions** - CI/CD pipeline
- **ESLint** & **Prettier** - Code quality and formatting

## 🚀 Quick Start

> **📦 For Production Deployment:** If you have downloaded a release package, see the [DEPLOYMENT.md](DEPLOYMENT.md) guide for detailed deployment instructions.

### Prerequisites
- Node.js 20.x or higher
- PostgreSQL 16 or higher (or use Docker)
- npm or yarn

### Installation

1. **Clone the repository**
```bash
git clone https://github.com/F33DoT530i/Chameleon-MirrorMail-Guntroide-v.1.git
cd Chameleon-MirrorMail-Guntroide-v.1
```

2. **Install dependencies**
```bash
npm install
```

3. **Set up environment variables**

For the server:
```bash
cp server/.env.example server/.env
# Edit server/.env with your configuration
```

For the client:
```bash
cp client/.env.example client/.env
# Edit client/.env with your API URL
```

4. **Set up the database**

If using Docker (recommended):
```bash
docker-compose up -d db
```

Or manually create a PostgreSQL database and run:
```bash
psql -U postgres -d chameleon_db -f server/database/init.sql
```

5. **Run the development servers**

Run both client and server:
```bash
npm run dev
```

Or run them separately:
```bash
# Terminal 1 - Server
npm run dev:server

# Terminal 2 - Client
npm run dev:client
```

The client will be available at `http://localhost:5173`
The server will be available at `http://localhost:3000`

## 🐳 Docker Deployment

### Using Docker Compose

1. **Build and start all services**
```bash
docker-compose up -d
```

2. **View logs**
```bash
docker-compose logs -f
```

3. **Stop services**
```bash
docker-compose down
```

The application will be available at `http://localhost`

## 📝 Available Scripts

### Root Level
- `npm run dev` - Run both client and server in development mode
- `npm run build` - Build both client and server for production
- `npm run test` - Run tests for both workspaces
- `npm run lint` - Lint all code
- `npm run lint:fix` - Fix linting issues

### Client Scripts
- `npm run dev --workspace=client` - Start Vite dev server
- `npm run build --workspace=client` - Build for production
- `npm run test --workspace=client` - Run Vitest tests
- `npm run lint --workspace=client` - Lint client code

### Server Scripts
- `npm run dev --workspace=server` - Start with nodemon
- `npm run start --workspace=server` - Start production server
- `npm run test --workspace=server` - Run Mocha tests
- `npm run lint --workspace=server` - Lint server code

## 🔐 Environment Variables

### Server (.env)
```
PORT=3000
NODE_ENV=development
DB_HOST=localhost
DB_PORT=5432
DB_NAME=chameleon_db
DB_USER=postgres
DB_PASSWORD=your_password
JWT_SECRET=your_secret_key
JWT_EXPIRE=7d
CORS_ORIGIN=http://localhost:5173
```

### Client (.env)
```
VITE_API_URL=http://localhost:3000
```

## 📚 API Documentation

### Authentication Endpoints

#### Register User
```
POST /api/auth/register
Content-Type: application/json

{
  "email": "user@example.com",
  "password": "securepassword",
  "name": "John Doe"
}
```

#### Login
```
POST /api/auth/login
Content-Type: application/json

{
  "email": "user@example.com",
  "password": "securepassword"
}
```

#### Get Current User
```
GET /api/auth/me
Authorization: Bearer <token>
```

### Health Check
```
GET /health
```

## 🧪 Testing

### Run All Tests
```bash
npm test
```

### Run Client Tests
```bash
npm run test:client
```

### Run Server Tests
```bash
npm run test:server
```

## 🔧 Development

### Code Formatting
The project uses ESLint and Prettier for code consistency.

```bash
# Check for issues
npm run lint

# Auto-fix issues
npm run lint:fix
```

## 🏗️ Project Structure

```
Chameleon-MirrorMail-Guntroide-v.1/
├── .github/
│   └── workflows/
│       └── ci.yml           # GitHub Actions CI/CD
├── client/                   # React front-end
│   ├── src/
│   │   ├── components/       # React components
│   │   ├── context/          # Context API providers
│   │   ├── test/             # Test files
│   │   ├── App.jsx           # Main app component
│   │   └── main.jsx          # Entry point
│   ├── Dockerfile            # Client Docker config
│   ├── package.json          # Client dependencies
│   └── vite.config.js        # Vite configuration
├── server/                   # Express back-end
│   ├── src/
│   │   ├── config/           # Configuration files
│   │   ├── controllers/      # Route controllers
│   │   ├── middleware/       # Express middleware
│   │   ├── routes/           # API routes
│   │   └── index.js          # Server entry point
│   ├── database/
│   │   └── init.sql          # Database schema
│   ├── test/                 # Test files
│   ├── Dockerfile            # Server Docker config
│   └── package.json          # Server dependencies
├── docker-compose.yml        # Docker Compose config
├── package.json              # Root package.json (workspaces)
└── README.md                 # This file
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🔒 Security

- Passwords are hashed using bcryptjs
- JWT tokens for secure authentication
- Helmet.js for setting secure HTTP headers
- Rate limiting to prevent abuse
- CORS configuration for cross-origin requests
- Environment variables for sensitive data

## 🐛 Known Issues

- None at this time

## 📞 Support

For support, please open an issue in the GitHub repository.

