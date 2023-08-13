# syntax=docker/dockerfile:1.4

ARG PHP_VERSION=8.2
ARG TOOLBOX_EXCLUDED_TAGS="exclude-php:${PHP_VERSION}"
ARG TOOLBOX_VERSION="1.77.1"
ARG FLAVOUR="alpine"


# Debian PHP with dependencies needed for final image
FROM php:${PHP_VERSION}-cli-buster AS php-base-debian
ARG DEBIAN_LIB_DEPS="zlib1g-dev libzip-dev libbz2-dev libicu-dev"
ARG DEBIAN_TOOL_DEPS="git graphviz make unzip gpg dirmngr gpg-agent openssh-client"
ARG TARGETARCH
RUN  rm /etc/apt/apt.conf.d/docker-clean # enables apt caching
RUN --mount=type=cache,target=/var/cache/apt,target=/var/cache/apt,sharing=locked,id=apt-${TARGETARCH} \
    --mount=type=cache,target=/var/lib/apt/lists,target=/var/lib/apt/lists,sharing=locked,id=apt-lists-${TARGETARCH} \
    apt-get update \
    && apt-get install -y --no-install-recommends ${DEBIAN_TOOL_DEPS} ${DEBIAN_LIB_DEPS}


# Alpine PHP with dependencies needed for final image
FROM php:${PHP_VERSION}-alpine as php-base-alpine
ARG ALPINE_LIB_DEPS="zlib-dev libzip-dev bzip2-dev icu-dev"
ARG ALPINE_TOOL_DEPS="git graphviz ttf-freefont make unzip gpgme gnupg-dirmngr openssh-client"
ARG TARGETARCH
RUN --mount=type=cache,target=/var/cache/apk,sharing=locked,id=apk-${TARGETARCH} \
    apk add --no-cache ${ALPINE_TOOL_DEPS} ${ALPINE_LIB_DEPS}


# PHP with dependencies needed for final image
FROM php-base-${FLAVOUR} AS php-base


# Debian PHP with dependencies needed for building the tools
FROM php-base-debian AS builder-base-debian
ARG TARGETARCH
RUN --mount=type=cache,target=/var/cache/apt,target=/var/cache/apt,sharing=locked,id=apt-${TARGETARCH} \
    --mount=type=cache,target=/var/lib/apt/lists,target=/var/lib/apt/lists,sharing=locked,id=apt-lists-${TARGETARCH} \
    apt-get install -y --no-install-recommends ${PHPIZE_DEPS}


# Alpine PHP with dependencies needed for building the tools
FROM php-base-alpine AS builder-base-alpine
ARG TARGETARCH
RUN --mount=type=cache,target=/var/cache/apk,sharing=locked,id=apk-${TARGETARCH} \
    apk add --no-cache ${PHPIZE_DEPS}


# PHP with dependencies needed for building the tools
FROM builder-base-${FLAVOUR} as builder-base
RUN docker-php-source extract


# Stage containing the AST extension source
FROM --platform=${BUILDPLATFORM} alpine AS ast-downloader
ARG TARGETARCH
WORKDIR /
RUN --mount=type=cache,target=/var/cache/apk,sharing=locked,id=apk-${TARGETARCH} \
    apk add --no-cache git
RUN git clone https://github.com/nikic/php-ast.git


# Stage that builds the AST extension from downloaded src
FROM builder-base AS ast-builder
WORKDIR /build
COPY --from=ast-downloader /php-ast .
RUN phpize  \
    && ./configure  \
    && make  \
    && make install
RUN docker-php-ext-enable ast


# Stage that builds the pcov extension from PECL
FROM builder-base AS pcov-builder
RUN pecl install pcov && docker-php-ext-enable pcov


# Stage that builds bcmath
FROM builder-base AS bcmath-builder
RUN docker-php-ext-install bcmath


# Stage that builds intl
FROM builder-base AS intl-builder
RUN docker-php-ext-install intl


# Stage that builds zip
FROM builder-base AS zip-builder
RUN docker-php-ext-install zip


# Stage that builds pcntl
FROM builder-base AS pcntl-builder
RUN docker-php-ext-install pcntl


# Stage that builds bz2
FROM builder-base AS bz2-builder
RUN docker-php-ext-install bz2


# Stage with PHP extensions, all validated
FROM php-base AS all-extensions

COPY --link --from=ast-builder /usr/local/lib/php/extensions /usr/local/lib/php/extensions
COPY --link --from=ast-builder /usr/local/etc/php/conf.d /usr/local/etc/php/conf.d
COPY --link --from=pcov-builder /usr/local/lib/php/extensions /usr/local/lib/php/extensions
COPY --link --from=pcov-builder /usr/local/etc/php/conf.d  /usr/local/etc/php/conf.d
COPY --link --from=bcmath-builder /usr/local/lib/php/extensions /usr/local/lib/php/extensions
COPY --link --from=bcmath-builder /usr/local/etc/php/conf.d  /usr/local/etc/php/conf.d
COPY --link --from=intl-builder /usr/local/lib/php/extensions /usr/local/lib/php/extensions
COPY --link --from=intl-builder /usr/local/etc/php/conf.d  /usr/local/etc/php/conf.d
COPY --link --from=zip-builder /usr/local/lib/php/extensions /usr/local/lib/php/extensions
COPY --link --from=zip-builder /usr/local/etc/php/conf.d  /usr/local/etc/php/conf.d
COPY --link --from=pcntl-builder /usr/local/lib/php/extensions /usr/local/lib/php/extensions
COPY --link --from=pcntl-builder /usr/local/etc/php/conf.d  /usr/local/etc/php/conf.d
COPY --link --from=bz2-builder /usr/local/lib/php/extensions /usr/local/lib/php/extensions
COPY --link --from=bz2-builder /usr/local/etc/php/conf.d  /usr/local/etc/php/conf.d

# Validate the extension configuration
RUN php --re ast
RUN php --re pcov
RUN php --re bcmath
RUN php --re intl
RUN php --re zip
RUN php --re pcntl
RUN php --re bz2


# Stage containing the downloaded toolbox PHAR
FROM --platform=${BUILDPLATFORM} alpine AS toolbox-downloader
WORKDIR /
ARG TOOLBOX_VERSION
RUN wget https://github.com/jakzal/toolbox/releases/download/v${TOOLBOX_VERSION}/toolbox.phar


# PHP with all extensions needed, correctly configured
FROM php-base as php-configured

# Install extensions + extension config
COPY --link --from=all-extensions /usr/local/lib/php/extensions /usr/local/lib/php/extensions
COPY --link --from=all-extensions /usr/local/etc/php/conf.d /usr/local/etc/php/conf.d

# Base php.ini
COPY --link <<EOF /usr/local/etc/php/conf.d/phpqa.ini
date.timezone=Europe/London
memory_limit=-1
phar.readonly=0
pcov.enabled=0
EOF

COPY --link <<EOF /usr/local/etc/php/conf.d/opcache.ini
zend_extension=opcache.so
opcache.enable=1
opcache.enable_cli=1
EOF

# Validate the PHP configuration
RUN php --ini | grep phpqa.ini
RUN php --rz "Zend OPcache"

ARG TOOLBOX_TARGET_DIR="/tools"
ENV TOOLBOX_TARGET_DIR="${TOOLBOX_TARGET_DIR}"
WORKDIR ${TOOLBOX_TARGET_DIR}
ENV PATH="${PATH}:${TOOLBOX_TARGET_DIR}"

# Configure Composer
COPY --link --from=composer:2 /usr/bin/composer ./composer
ENV COMPOSER_HOME=${TOOLBOX_TARGET_DIR}/.composer
ENV PATH="${PATH}:${COMPOSER_HOME}/vendor/bin"
ENV COMPOSER_ALLOW_SUPERUSER 1
RUN composer --version

# Configure Toolbox
COPY --link --from=toolbox-downloader --chmod=+x /toolbox.phar ./toolbox
ARG TOOLBOX_EXCLUDED_TAGS
ENV TOOLBOX_EXCLUDED_TAGS=${TOOLBOX_EXCLUDED_TAGS}
ARG TOOLBOX_VERSION
ENV TOOLBOX_VERSION=${TOOLBOX_VERSION}
ENV PATH="${PATH}:${TOOLBOX_TARGET_DIR}/QualityAnalyzer/bin"
RUN php toolbox --version


# The stage that does 'toolbox install' - separated out to isolate the cachebusting better
FROM php-configured AS toolbox-installer

ARG INSTALLATION_DATE

RUN --mount=type=secret,id=composer.auth,target=${COMPOSER_HOME}/auth.json \
    --mount=type=cache,id=composer,target=${COMPOSER_HOME}/cache\
    --mount=type=secret,id=phive.auth,target=${TOOLBOX_TARGET_DIR}/.phive/auth.xml \
    php toolbox install
RUN php toolbox test
RUN chmod 644 ${COMPOSER_HOME}/config.json


# Final result with entrypoint configured
FROM php-configured AS final

LABEL maintainer="Jakub Zalas <jakub@zalas.pl>"

COPY --link --from=toolbox-installer ${TOOLBOX_TARGET_DIR} .

COPY --link --chmod=755 <<EOF /entrypoint.sh
#!/usr/bin/env sh
set -e

(test "\$GITHUB_ACTIONS" = "true" || test "\$CI" = "true") && test -f composer.json && composer install --no-scripts --no-progress

exec "\$@"
EOF
ENTRYPOINT ["/entrypoint.sh"]
CMD php toolbox list-tools
