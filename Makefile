default: build

build:
	docker build -t jakzal/phpqa:latest .
.PHONY: build

build-alpine:
	docker build -f Dockerfile-alpine -t jakzal/phpqa:alpine .
.PHONY: build-alpine

