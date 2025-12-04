# Homelab Docker-Compose Setup

This repository contains Docker Compose configurations for various self-hosted applications, all routed through
a Cloudflare tunnel for secure external access.

## Recovering Services

`kubectl exec memos-pg-1 -c postgres -- pg_dump --data-only <schema> > data.sql`
can be used to dump data from the Postgres database used by Memos.

Restore like this:
```
docker cp data.sql <docker-memos-pg>:/data.sql
docker exec -it <docker-memos-pg> psql -U memos -d memos -f /data.sql
```