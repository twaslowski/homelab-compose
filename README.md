# homelab-compose

This is an iteration of my previous Kubernetes-based homelab setup.
It contains many of the same services, but with drastically reduced overhead.

## Architecture

The previous homelab had the advantage of using the `strrl/cloudflare-tunnel-ingress-controller`, which made it
possible to easily expose services via Cloudflare Tunnels by adding an `Ingress` resource.

This iteration sacrifices part of that luxury, however, it maintains a relative ease of configuration via Terraform.
Terraform creates:

- A Cloudflare Tunnel
- The corresponding tunnel configuration (stored in Cloudflare)
- CNAME records in Cloudflare DNS pointing to that tunnel

The `tunnel_token` has to be passed to the `cloudflared` container via environment variable,
which then connects to Cloudflare's network and routes traffic according to the upstream configuration.

### Trade-Offs

docker-compose has several key benefits over Kubernetes for this use case:

- **Simplicity**: docker-compose is generally simpler to set up and manage for small-scale deployments.
  It requires less overhead compared to Kubernetes, which can be complex and resource-intensive.
- **Resource Efficiency**: docker-compose has a lower resource footprint, making it more suitable for
  environments with limited resources.
- **File-system integration**: For services that store files, such as paperless-ngx or memos,
  docker-compose allows for easier integration with the host file system via bind mounts.
  No more worrying about storage classes, replication and whatnot.
  This can simplify backup and recovery processes.

## Running

* First, make sure to create a `.env` file with the required environment variables.
  You can use the provided `.env.example` as a starting point.
* Then, deploy Terraform. You'll need a Cloudflare account with API access and a domain managed by Cloudflare.
  This will give you fully-configured tunnel and a tunnel token.
  Copy the token into the `.env` file.
* Launch `cloudflared` by running `task start:cloudflared`.
* Start all other services.

## Todos

Migrate services:

- [ ] Memos
  - [x] Set up docker-compose.yml
  - [x] Migrate data from cloudnative-pg to local Postgres
  - [ ] systemd service
  - [ ] Backup strategy
- [ ] paperless-ngx
  - [ ] Set up docker-compose.yml
  - [ ] Migrate data from cloudnative-pg to local Postgres
  - [ ] systemd service
  - [ ] Backup strategy
- [ ] Vaultwarden
  - [ ] Set up docker-compose.yml
  - [ ] Migrate data from cloudnative-pg to local Postgres
  - [ ] systemd service
  - [ ] Backup strategy
- [ ] Tandoor
  - [ ] Set up docker-compose.yml
  - [ ] Migrate data from cloudnative-pg to local Postgres
  - [ ] systemd service
  - [ ] Backup strategy

## Runbook

This section is mainly for me, as I figure out how to recover my cloudnative-pg databases into local Postgres
containers.

`kubectl exec memos-pg-1 -c postgres -- pg_dump --data-only <schema> > data.sql`
can be used to dump data from the Postgres database used by Memos.

Restore like this:

```bash
docker cp data.sql <docker-memos-pg>:/data.sql
docker exec -it <docker-memos-pg> psql -U memos -d memos -f /data.sql
```

Copying dumps, .env files etc.:

```bash
scp <file> user@host:/home/user/projects/homelab-compose/...
```