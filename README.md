### Create Overlay Network
```shell
docker -H=<swarm_fqdn> network create --driver=overlay traefik-net
```

### Deploy Traefik
```shell
docker -H=<swarm_fqdn> stack deploy -c docker-compose.yml proxy
```

### Services that want DNS services
*All service that would like a DNS entry need to include the `traefik-net` network*

Services must also include the following four labels:

```Dockerfile
services:
  <service_name>:
    deploy:
      labels:
        - "traefik.frontend.rule=Host:<dns_prefix>.<dns_suffix>"
        - "traefik.port=<port_service_uses"
        - "traefik.docker.network=traefik-net"
        - "traefik.enable=true"
```
