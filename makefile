all: build-network build

check-vars:
ifndef DNS_SUFFIX
	$(error env var DNS_SUFFIX is not set)
endif

build-network:
	@-docker network create --driver=overlay traefik-net

build: check-vars
	docker stack deploy -c docker-compose.yml proxy

refresh: destroy build

destroy:
	docker stack rm proxy
	sleep 2

destroy-all: destroy
	docker network rm traefik-net
