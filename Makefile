default: build

build: build-latest build-alpine
.PHONY: build

build-latest: BUILD_TAG ?= jakzal/phpqa:latest
build-latest:
	docker build -t $(BUILD_TAG) .
.PHONY: build-latest

build-alpine: BUILD_TAG ?= jakzal/phpqa:alpine
build-alpine:
	docker build -f Dockerfile-alpine -t $(BUILD_TAG) .
.PHONY: build-alpine

NIGHTLY_TAG := jakzal/phpqa-nightly:$(shell date +%y%m%d)
build-nightly-latest:
	docker build -t $(NIGHTLY_TAG) .
	@docker login -u jakzal -p ${DOCKER_HUB_PASSWORD}
	docker push $(NIGHTLY_TAG)
.PHONY: build-nightly-latest

NIGHTLY_ALPINE_TAG := jakzal/phpqa-nightly:$(shell date +%y%m%d)-alpine
build-nightly-alpine:
	docker build -f Dockerfile-alpine -t $(NIGHTLY_ALPINE_TAG) .
	@docker login -u jakzal -p ${DOCKER_HUB_PASSWORD}
	docker push $(NIGHTLY_ALPINE_TAG)
.PHONY: build-nightly-alpine
