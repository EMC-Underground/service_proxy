all: build-network build

check-vars:
ifndef DNS_SUFFIX
	$(error env var DNS_SUFFIX is not set)
endif

check-network:
^I@docker network inspect traefik-net &> /dev/null && ([ $$? -eq 0 ] && export NETWORK_EXISTS="true") || export NETWORK_EXISTS="false"

build-network: check-network
ifndef NETWORK_EXISTS
^I@-docker network create --driver=overlay traefik-net
endif

build: check-vars
	cat traefik.toml.tmpl | python variables_injector.py > traefik.toml
	docker stack deploy -c docker-compose.yml proxy

refresh: destroy build

destroy:
	docker stack rm proxy
	sleep 2

destroy-all: destroy
	docker network rm traefik-net
