PHP_VERSIONS := 7.1 7.2 7.3
PHP_VERSION ?= $(lastword $(sort $(PHP_VERSIONS)))

default: build

build: build-latest build-alpine
.PHONY: build

build-latest: BUILD_TAG ?= jakzal/phpqa:latest
build-latest: $(PHP_VERSION)/debian/Dockerfile
	cd $(PHP_VERSION)/debian && docker build -t $(BUILD_TAG) .
.PHONY: build-latest

build-alpine: BUILD_TAG ?= jakzal/phpqa:alpine
build-alpine: $(PHP_VERSION)/alpine/Dockerfile
	cd $(PHP_VERSION)/alpine && docker build -t $(BUILD_TAG) .
.PHONY: build-alpine

NIGHTLY_TAG := jakzal/phpqa-nightly:$(shell date +%y%m%d)
build-nightly-latest: $(PHP_VERSION)/debian/Dockerfile
	cd $(PHP_VERSION)/debian && docker build -t $(NIGHTLY_TAG) .
	@docker login -u jakzal -p ${DOCKER_HUB_PASSWORD}
	docker push $(NIGHTLY_TAG)
.PHONY: build-nightly-latest

NIGHTLY_ALPINE_TAG := jakzal/phpqa-nightly:$(shell date +%y%m%d)-alpine
build-nightly-alpine: $(PHP_VERSION)/alpine/Dockerfile
	cd $(PHP_VERSION)/alpine && docker build -t $(NIGHTLY_ALPINE_TAG) .
	@docker login -u jakzal -p ${DOCKER_HUB_PASSWORD}
	docker push $(NIGHTLY_ALPINE_TAG)
.PHONY: build-nightly-alpine

generate: generate-alpine generate-debian
.PHONY: generate

generate-alpine generate-debian: Dockerfile-alpine Dockerfile-debian
	for php_version in $(PHP_VERSIONS); do \
		mkdir -p $$php_version/$(subst generate-,,$@) && \
		cp tools.json tools.php $$php_version/$(subst generate-,,$@) && \
		cat "Dockerfile-$(subst generate-,,$@)" | sed -e 's#\(FROM php:\)[^\-]*\(-.*\)#\1'$$php_version'\2#g' > $$php_version/$(subst generate-,,$@)/Dockerfile; \
	done
.PHONY: generate-alpine generate-debian

$(PHP_VERSIONS:%=%/alpine/Dockerfile): generate-alpine
$(PHP_VERSIONS:%=%/debian/Dockerfile): generate-debian
$(PHP_VERSIONS:%=%/alpine): generate-alpine
$(PHP_VERSIONS:%=%/debian): generate-debian
$(PHP_VERSIONS): generate
