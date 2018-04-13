NAME=thenets/changelog
TAG=latest
SHELL=/bin/sh

SECRET=123123123123123123123123123123123123123123123123123123123123123123123123

RUN_PARAMS=-it --rm --name changelog_debug \
	--network=changelog \
	-v $(PWD)/src:/app \
	-p 4000:4000 \
	-e "PORT=4000" \
	-e "ROLLBAR_ACCESS_TOKEN=$(SECRET)" \
	-e "SECRET_KEY_BASE=$(SECRET)" \
	-e "DB_URL=postgresql://postgres:postgres@postgres/postgres" \
	-e "SMTP_SERVER=smtp.gmail.com" \
	-e "SMTP_HOSTNAME=gmail.com" \
	-e "SMTP_USERNAME=thenets.org@gmail.com" \
	-e "SMTP_PASSWORD=123412341234"

build: pre-build docker-build post-build

pre-build:

post-build:

docker-build:
	docker build -t $(NAME):$(TAG) --rm .

run-dependencies:
	docker network create changelog 2> /dev/null || true
	docker rm -f postgres 2> /dev/null || true
	docker run -d --rm --network=changelog --name postgres -v /opt/postgres:/var/lib/postgresql/data -e POSTGRES_PASSWORD=postgres postgres:alpine
	docker rm -f adminer 2> /dev/null || true
	docker run -d --rm --network=changelog -p 8080:8080 --name adminer adminer

build-shell: build shell

build-test: build test

shell: run-dependencies
	docker run $(RUN_PARAMS) --entrypoint=$(SHELL) $(NAME):$(TAG) 

test: run-dependencies
	docker run $(RUN_PARAMS) $(NAME):$(TAG)
