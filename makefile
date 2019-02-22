all: build-network build

build-network:
	docker network create --driver=overlay traefik-net

build:
	docker stack deploy -c docker-compose.yml proxy

refresh: destroy build

destroy:
	docker stack rm proxy
	sleep 2

destroy-all: destroy
	docker network rm traefik-net
