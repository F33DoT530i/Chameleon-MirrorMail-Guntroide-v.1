# Deployment Guide

This guide explains how to deploy Chameleon MirrorMail Guntroide from the packaged release.

## 📦 Release Package Contents

The release package includes:

### Files
- `.dockerignore` - Docker build exclusions
- `.gitignore` - Git exclusions (if you want to modify and version control)
- `LICENSE` - Software license
- `README.md` - Project documentation
- `docker-compose.yml` - Docker Compose configuration
- `package.json` - Node.js project configuration

### Directories
- `.github/` - GitHub Actions CI/CD workflows
- `client/` - React frontend application (includes production build in `client/dist/`)
- `server/` - Express.js backend API
- `releases/` - Release notes and documentation

## 🚀 Deployment Options

### Option 1: Docker Deployment (Recommended)

This is the easiest and most reliable deployment method.

#### Prerequisites
- Docker Engine 20.x or higher
- Docker Compose 2.x or higher

#### Steps

1. **Extract the release package**
   ```bash
   tar -xzf chameleon-mirrormail-v1.0.0.tar.gz
   cd chameleon-mirrormail-v1.0.0
   ```

2. **Configure environment variables (optional)**
   
   Edit `docker-compose.yml` to customize settings like:
   - Database credentials
   - JWT secret
   - CORS origin
   - Ports

3. **Start all services**
   ```bash
   docker-compose up -d
   ```

4. **Verify services are running**
   ```bash
   docker-compose ps
   docker-compose logs -f
   ```

5. **Access the application**
   - Frontend: http://localhost
   - Backend API: http://localhost:3000
   - PostgreSQL: localhost:5432

#### Management Commands

```bash
# View logs
docker-compose logs -f

# Stop services
docker-compose down

# Restart services
docker-compose restart

# Rebuild images
docker-compose build --no-cache
docker-compose up -d
```

### Option 2: Manual Deployment

For development or custom deployments without Docker.

#### Prerequisites
- Node.js 20.x or higher
- PostgreSQL 16 or higher
- npm

#### Steps

1. **Extract the release package**
   ```bash
   tar -xzf chameleon-mirrormail-v1.0.0.tar.gz
   cd chameleon-mirrormail-v1.0.0
   ```

2. **Install dependencies**
   ```bash
   npm install
   ```

3. **Set up the database**
   
   Create a PostgreSQL database:
   ```bash
   createdb chameleon_db
   psql -d chameleon_db -f server/database/init.sql
   ```

4. **Configure the server**
   
   Copy and edit the server environment file:
   ```bash
   cp server/.env.example server/.env
   ```
   
   Edit `server/.env` with your configuration:
   ```
   PORT=3000
   NODE_ENV=production
   DB_HOST=localhost
   DB_PORT=5432
   DB_NAME=chameleon_db
   DB_USER=postgres
   DB_PASSWORD=your_password
   JWT_SECRET=your_secret_key_here
   JWT_EXPIRE=7d
   CORS_ORIGIN=http://localhost:5173
   ```

5. **Configure the client**
   
   Copy and edit the client environment file:
   ```bash
   cp client/.env.example client/.env
   ```
   
   Edit `client/.env`:
   ```
   VITE_API_URL=http://localhost:3000
   ```

6. **Start the services**
   
   Option A: Run both services together:
   ```bash
   npm run dev
   ```
   
   Option B: Run them separately:
   ```bash
   # Terminal 1 - Server
   npm run dev:server
   
   # Terminal 2 - Client
   npm run dev:client
   ```

7. **Access the application**
   - Frontend: http://localhost:5173
   - Backend API: http://localhost:3000

### Option 3: Production Build Deployment

Deploy the pre-built client assets to a web server.

#### Using nginx

1. **Install nginx**
   ```bash
   sudo apt-get install nginx
   ```

2. **Copy client build**
   ```bash
   sudo cp -r client/dist/* /var/www/html/
   ```

3. **Configure nginx**
   
   Create `/etc/nginx/sites-available/chameleon`:
   ```nginx
   server {
       listen 80;
       server_name your-domain.com;
       
       root /var/www/html;
       index index.html;
       
       location / {
           try_files $uri $uri/ /index.html;
       }
       
       location /api {
           proxy_pass http://localhost:3000;
           proxy_http_version 1.1;
           proxy_set_header Upgrade $http_upgrade;
           proxy_set_header Connection 'upgrade';
           proxy_set_header Host $host;
           proxy_cache_bypass $http_upgrade;
       }
   }
   ```

4. **Enable the site**
   ```bash
   sudo ln -s /etc/nginx/sites-available/chameleon /etc/nginx/sites-enabled/
   sudo nginx -t
   sudo systemctl restart nginx
   ```

5. **Start the backend**
   ```bash
   cd server
   npm install --production
   npm start
   ```

## 🔒 Security Considerations

### Before Deploying to Production

1. **Change default credentials**
   - Update database passwords in `docker-compose.yml`
   - Generate a strong JWT secret

2. **Configure CORS**
   - Set `CORS_ORIGIN` to your actual frontend domain

3. **Use HTTPS**
   - Set up SSL/TLS certificates (Let's Encrypt recommended)
   - Configure nginx or use a reverse proxy

4. **Environment variables**
   - Never commit `.env` files
   - Use secure methods to manage secrets (e.g., Docker secrets, HashiCorp Vault)

5. **Database security**
   - Use strong passwords
   - Limit database access to necessary hosts
   - Regular backups

6. **Updates**
   - Keep Docker images updated
   - Monitor for security vulnerabilities
   - Apply patches promptly

## 📊 Monitoring and Maintenance

### Logs

**Docker deployment:**
```bash
# View all logs
docker-compose logs -f

# View specific service logs
docker-compose logs -f server
docker-compose logs -f client
docker-compose logs -f db
```

**Manual deployment:**
- Server logs: Check console output or configure logging to file
- Client logs: Browser console
- Database logs: Check PostgreSQL log files

### Backups

**Database backup:**
```bash
# With Docker
docker-compose exec db pg_dump -U postgres chameleon_db > backup.sql

# Without Docker
pg_dump -U postgres chameleon_db > backup.sql
```

**Database restore:**
```bash
# With Docker
docker-compose exec -T db psql -U postgres chameleon_db < backup.sql

# Without Docker
psql -U postgres chameleon_db < backup.sql
```

## 🐛 Troubleshooting

### Services won't start

1. Check logs: `docker-compose logs`
2. Verify ports are not in use: `netstat -tuln | grep -E '80|3000|5432'`
3. Ensure Docker has enough resources

### Database connection errors

1. Verify database is running: `docker-compose ps`
2. Check database credentials in environment variables
3. Test connection: `docker-compose exec db psql -U postgres -d chameleon_db`

### Cannot access frontend

1. Check if client container is running
2. Verify port 80 is not blocked by firewall
3. Check browser console for errors

### API requests failing

1. Verify backend is running
2. Check CORS configuration
3. Verify API URL in client `.env`
4. Check network connectivity

## 📞 Support

For additional help:
- Check the main [README.md](README.md) for detailed documentation
- Review [GitHub Issues](https://github.com/F33DoT530i/Chameleon-MirrorMail-Guntroide-v.1/issues)
- Consult release notes in `releases/` directory

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
