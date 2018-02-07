NAME=thenets/changelog
TAG=latest
SHELL=/bin/sh

RUN_PARAMS=-it --rm -p 4000:4000 --network=changelog --name changelog_debug -e "PORT=4000" -e "ROLLBAR_ACCESS_TOKEN=123123123123123123" -e "DB_URL=postgresql://postgres:postgres@postgres/postgres"

build: pre-build docker-build post-build

pre-build:

post-build:

docker-build:
	docker build -t $(NAME):$(TAG) --rm .

run-dependencies:
	docker network create changelog 2> /dev/null || true
	docker rm -f postgres 2> /dev/null || true
	docker run -d --rm --network=changelog --name postgres -e POSTGRES_PASSWORD=postgres postgres:alpine

build-shell: build shell

build-test: build test

shell: run-dependencies
	docker run $(RUN_PARAMS) --entrypoint=$(SHELL) $(NAME):$(TAG) 

test: run-dependencies
	docker run $(RUN_PARAMS) $(NAME):$(TAG)
