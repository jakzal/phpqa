PHP_VERSIONS := 7.4 8.0 8.1
PHP_VERSION ?= $(lastword $(sort $(PHP_VERSIONS)))
COMPOSER_AUTHDIR ?= $(shell composer config --global home)
ifneq ("", "$(COMPOSER_AUTHDIR)")
 COMPOSER_SECRET ?= --secret=id=composer.auth,src=$(COMPOSER_AUTHDIR)/auth.json
endif

default: build

build: build-debian build-alpine
.PHONY: build

build-debian: BUILD_TAG ?= jakzal/phpqa:latest
build-debian:
	docker buildx build --load -t $(BUILD_TAG) $(COMPOSER_SECRET) --build-arg PHP_VERSION=$(PHP_VERSION) --build-arg FLAVOUR=debian .
.PHONY: build-debian

build-alpine: BUILD_TAG ?= jakzal/phpqa:alpine
build-alpine:
	docker buildx build --load -t $(BUILD_TAG) $(COMPOSER_SECRET) --build-arg PHP_VERSION=$(PHP_VERSION) --build-arg FLAVOUR=alpine .
.PHONY: build-alpine

NIGHTLY_TAG := jakzal/phpqa-nightly:$(shell date +%y%m%d)
build-nightly-debian:
	docker buildx build --load -t $(NIGHTLY_TAG) $(COMPOSER_SECRET) --build-arg PHP_VERSION=$(PHP_VERSION) --build-arg FLAVOUR=debian .
	@echo ${DOCKER_HUB_PASSWORD} | docker login -u jakzal --password-stdin
	docker push $(NIGHTLY_TAG)
.PHONY: build-nightly-debian

NIGHTLY_ALPINE_TAG := jakzal/phpqa-nightly:$(shell date +%y%m%d)-alpine
build-nightly-alpine:
	docker buildx build --load -t $(NIGHTLY_ALPINE_TAG) $(COMPOSER_SECRET) --build-arg PHP_VERSION=$(PHP_VERSION) --build-arg FLAVOUR=alpine .
	@echo ${DOCKER_HUB_PASSWORD} | docker login -u jakzal --password-stdin
	docker push $(NIGHTLY_ALPINE_TAG)
.PHONY: build-nightly-alpine

clean:
	@rm devkit
.PHONY: clean

devkit:
	curl -s https://api.github.com/repos/jakzal/toolbox/releases/latest | grep "browser_download_url.*devkit.phar" | cut -d '"' -f 4 | xargs curl -Ls -o devkit && chmod +x devkit

update-readme-tools: devkit
	./devkit update:readme --readme README.md
.PHONY: update-readme-tools

readme-release:
	@cat README.md | grep 'jakzal/phpqa/blob/v' | sed -e 's/^[^`]*`\([^`\-]*\).*/\1/' | head -n 1
.PHONY: readme-release

next-patch-release: NEXT_PATCH_RELEASE ?=
next-patch-release:
ifeq ($(NEXT_PATCH_RELEASE),)
	@$(MAKE) readme-release | awk -F. -v OFS=. '{$$NF++;print}'
else
	@echo $(NEXT_PATCH_RELEASE)
endif
.PHONY: next-patch-release

release: NEXT_RELEASE ?=
release:
	$(eval LATEST_RELEASE=$(shell $(MAKE) next-patch-release NEXT_PATCH_RELEASE=$(NEXT_RELEASE)))
	@$(MAKE) update-readme-release LATEST_RELEASE=$(LATEST_RELEASE)
	git add README.md
	git commit -m 'Release v$(LATEST_RELEASE)'
	git tag -a v$(LATEST_RELEASE) -m 'Tag v$(LATEST_RELEASE)'
	git push origin master
	hub release create -m '$(LATEST_RELEASE)' -m '' -m ':robot: Automagically created release.' v$(LATEST_RELEASE)
.PHONY: release

update-readme-release: LATEST_RELEASE ?= 0.0.0
update-readme-release:
	$(eval LATEST_RELEASE_MINOR=$(shell echo $(LATEST_RELEASE) | cut -f1,2 -d.))
	$(eval README_RELEASE=$(shell $(MAKE) readme-release))
	$(eval README_RELEASE_MINOR=$(shell echo $(README_RELEASE) | cut -f1,2 -d.))
	sed -i.bkp -e 's/$(README_RELEASE)/$(LATEST_RELEASE)/g' README.md
	sed -i.bkp -e 's/$(README_RELEASE_MINOR)/$(LATEST_RELEASE_MINOR)/g' README.md
	@rm README.md.bkp
.PHONY: update-readme-release

update-toolbox-version:
	$(eval LATEST_TOOLBOX_VERSION=$(shell curl -H'Authorization: token '$(GITHUB_TOKEN) -Ls 'https://api.github.com/repos/jakzal/toolbox/releases/latest' | jq -r .tag_name | cut -c 2-))
	$(eval CURRENT_TOOLBOX_VERSION=$(shell cat Dockerfile | grep 'TOOLBOX_VERSION=' | head -n 1 | sed -e 's/.*"\(.*\)"/\1/'))
	@[ "$(LATEST_TOOLBOX_VERSION)" != "" ] || (echo "Failed to check the latest toolbox release" && exit 1)
	[ "$(CURRENT_TOOLBOX_VERSION)" = "$(LATEST_TOOLBOX_VERSION)" ] || ( \
	  sed -e 's/$(CURRENT_TOOLBOX_VERSION)/$(LATEST_TOOLBOX_VERSION)/g' -i'.bkp' Dockerfile \
	  && rm -f Dockerfile.bkp \
	)
.PHONY: update-toolbox-version

update-toolbox-pr: update-toolbox-version
	$(eval VERSION_CHANGE=$(shell git diff --name-only */Dockerfile | head -n 1 | xargs git diff | grep TOOLBOX_VERSION | sed -e 's/.*"\(.*\)"/\1/g' | xargs echo | sed -e 's/ / -> /'))
	[ "$(VERSION_CHANGE)" = "" ] || \
	( \
	    $(eval PR_MESSAGE=$(shell curl -H'Authorization: token '$(GITHUB_TOKEN) -Ls 'https://api.github.com/repos/jakzal/toolbox/releases/latest' | jq -r .body | awk 'BEGIN { RS="\n";} { gsub(/\r/, ""); gsub(/#/, "\\#"); gsub(/"/, "\\\\\\\""); print "-m \""$$0"\""}')) \
	    git checkout -b toolbox-update && \
	    git add */Dockerfile && \
	    git commit -m "Update toolbox $(VERSION_CHANGE)" -m "" $(PR_MESSAGE) && \
	    git push origin toolbox-update && \
	    hub pull-request -h toolbox-update -a jakzal -m 'Update toolbox $(VERSION_CHANGE)' -m '' -m ':robot: This pull request was automagically sent from a Github action.' -m '' $(PR_MESSAGE) \
	)
.PHONY: update-toolbox-pr
