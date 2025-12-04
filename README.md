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

## Recovering Services

`kubectl exec memos-pg-1 -c postgres -- pg_dump --data-only <schema> > data.sql`
can be used to dump data from the Postgres database used by Memos.

Restore like this:

```
docker cp data.sql <docker-memos-pg>:/data.sql
docker exec -it <docker-memos-pg> psql -U memos -d memos -f /data.sql
```