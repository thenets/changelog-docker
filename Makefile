NAME = thenets/changelog
TAG = latest
SHELL = /bin/sh

build: pre-build docker-build post-build

pre-build:

post-build:

docker-build:
	docker build -t $(NAME):$(TAG) --rm .

shell:
	docker run -it --rm -p 4000:4000 $(NAME):$(TAG) $(SHELL)

build-shell: build shell

build-test: build test

test:
	docker run -it --rm --name debug -p 4000:4000 $(NAME):$(TAG)
