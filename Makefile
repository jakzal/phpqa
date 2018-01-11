default: build

build: build-latest build-alpine
.PHONY: build

build-latest:
	docker build -t jakzal/phpqa:latest .
.PHONY: build-latest

build-alpine:
	docker build -f Dockerfile-alpine -t jakzal/phpqa:alpine .
.PHONY: build-alpine

