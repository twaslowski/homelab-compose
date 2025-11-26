# Homelab Docker-Compose Setup

This repository contains Docker Compose configurations for various self-hosted applications, all routed through
a Cloudflare tunnel for secure external access.

## Getting Started

1. Create a Cloudflare Tunnel
2. Verify Cloudflare tunnel is running: `docker ps | grep cloudflared`
3. Verify Cloudflare DNS records: `nslookup memos.yourdomain.com`
4. Check tunnel configuration in Cloudflare dashboard

## Adding services

Example template for new service:

1. **Start the service**: `docker compose -f docker-compose.newapp.yml up -d`
2. **Configure Cloudflare tunnel**: Add new public hostname
3. **Add database init script**: `init-db/XX-init-newapp.sh` (if needed)
4. **Update `.env`**: Add application-specific variables
5. **Create new compose file**: `docker-compose.newapp.yml`

## 📝 Adding New Applications

1. **Review Cloudflare Access policies** - Add authentication for sensitive services
2. **Keep images updated**: `docker compose pull && docker compose up -d`
3. **Restrict Postgres port** - Only exposed on `127.0.0.1:5432` by default
4. **Rotate credentials regularly**
5. **Use strong passwords** - Generate with: `openssl rand -base64 32`
6. **Never commit `.env` files** - Already configured in `.gitignore`
