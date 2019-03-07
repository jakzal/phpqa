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
		cat "Dockerfile-$(subst generate-,,$@)" \
		  | sed -e 's#\(FROM php:\)[^\-]*\(-.*\)#\1'$$php_version'\2#g' \
		  | sed -e 's#\(exclude-php:\)[0-9.]*\(.*\)#\1'$$php_version'\2#g' \
		  > $$php_version/$(subst generate-,,$@)/Dockerfile; \
	done
.PHONY: generate-alpine generate-debian

$(PHP_VERSIONS:%=%/alpine/Dockerfile): generate-alpine
$(PHP_VERSIONS:%=%/debian/Dockerfile): generate-debian
$(PHP_VERSIONS:%=%/alpine): generate-alpine
$(PHP_VERSIONS:%=%/debian): generate-debian
$(PHP_VERSIONS): generate

clean:
	@rm devkit
.PHONY: clean

devkit:
	curl -s https://api.github.com/repos/jakzal/toolbox/releases/latest | grep "browser_download_url.*devkit.phar" | cut -d '"' -f 4 | xargs curl -Ls -o devkit && chmod +x devkit

update-readme-tools: devkit
	./devkit update:readme --readme README.md
.PHONY: update-readme-tools

update-readme-release: LATEST_RELEASE ?= 0.0.0
update-readme-release:
	$(eval LATEST_RELEASE_MINOR=$(shell echo $(LATEST_RELEASE) | cut -f1,2 -d.))
	$(eval README_RELEASE=$(shell cat README.md | grep 'jakzal/phpqa/blob/v' | sed -e 's/^[^`]*`\([^`\-]*\).*/\1/' | head -n 1))
	$(eval README_RELEASE_MINOR=$(shell echo $(README_RELEASE) | cut -f1,2 -d.))
	sed -i.bkp -e 's/$(README_RELEASE)/$(LATEST_RELEASE)/g' README.md
	sed -i.bkp -e 's/$(README_RELEASE_MINOR)/$(LATEST_RELEASE_MINOR)/g' README.md
	@rm README.md.bkp
.PHONY: update-readme-release

update-toolbox-version:
	$(eval LATEST_TOOLBOX_VERSION=$(shell curl -H'Authorization: token '$(GITHUB_TOKEN) -Ls 'https://api.github.com/repos/jakzal/toolbox/releases/latest' | jq -r .tag_name | cut -c 2-))
	$(eval CURRENT_TOOLBOX_VERSION=$(shell cat Dockerfile-alpine | grep 'TOOLBOX_VERSION=' | sed -e 's/.*"\(.*\)"/\1/'))
	@[ "$(LATEST_TOOLBOX_VERSION)" != "" ] || (echo "Failed to check the latest toolbox release" && exit 1)
	[ "$(CURRENT_TOOLBOX_VERSION)" = "$(LATEST_TOOLBOX_VERSION)" ] || ( \
	  sed -e 's/$(CURRENT_TOOLBOX_VERSION)/$(LATEST_TOOLBOX_VERSION)/g' -i'.bkp' Dockerfile-alpine Dockerfile-debian \
	  && rm -f Dockerfile-alpine.bkp Dockerfile-docker.bkp \
	)
.PHONY: update-toolbox-version

update-toolbox-pr: update-toolbox-version generate
	$(eval VERSION_CHANGE=$(shell git diff --name-only Dockerfile-* */*/Dockerfile | head -n 1 | xargs git diff | grep TOOLBOX_VERSION | sed -e 's/.*"\(.*\)"/\1/g' | xargs echo | sed -e 's/ / -> /'))
	[ "$(VERSION_CHANGE)" = "" ] || \
	( \
	    $(eval PR_MESSAGE=$(shell curl -H'Authorization: token '$(GITHUB_TOKEN) -Ls 'https://api.github.com/repos/jakzal/toolbox/releases/latest' | jq -r .body | awk 'BEGIN { RS="\n";} { gsub(/\r/, ""); gsub(/\(/, "\\("); gsub(/\)/, "\\)"); gsub(/#/, "\\#"); gsub(/"/, "\\\\\\\""); print "-m \""$$0"\""}')) \
	    git checkout -b toolbox-update && \
	    git add Dockerfile-* */*/Dockerfile && \
	    git commit -m "Update toolbox $(VERSION_CHANGE)" -m "" $(PR_MESSAGE) && \
	    git push origin toolbox-update && \
	    hub pull-request -h toolbox-update -a jakzal -m 'Update toolbox $(VERSION_CHANGE)' -m '' -m ':robot: This pull request was automagically sent from [Travis CI]('$(TRAVIS_BUILD_WEB_URL)'). '$(PR_MESSAGE) \
	)
.PHONY: update-toolbox-pr
