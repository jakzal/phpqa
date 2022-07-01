# syntax=docker/dockerfile:1.4

ARG PHP_VERSION=8.1
ARG BASE_IMAGE=php:${PHP_VERSION}-cli-buster
ARG TOOLBOX_EXCLUDED_TAGS="exclude-php:${PHP_VERSION}"
ARG TOOLBOX_VERSION="1.63.0"

# PHP with dependencies needed for final image
FROM ${BASE_IMAGE} as php-base
LABEL maintainer="Jakub Zalas <jakub@zalas.pl>"
ARG LIB_DEPS="zlib1g-dev libzip-dev libbz2-dev libicu-dev"
ARG TOOL_DEPS="git graphviz make unzip gpg  dirmngr gpg-agent openssh-client"
RUN  rm /etc/apt/apt.conf.d/docker-clean # enables apt caching
RUN --mount=type=cache,target=/var/cache/apt,target=/var/cache/apt,sharing=locked,id=apt \
    --mount=type=cache,target=/var/lib/apt/lists,target=/var/lib/apt/lists,sharing=locked,id=apt-lists \
    apt-get update \
    && apt-get install -y --no-install-recommends $TOOL_DEPS $LIB_DEPS


# PHP with dependencies needed for building the tools
FROM php-base AS builder-base
ARG BUILD_DEPS="autoconf file g++ gcc libc-dev pkg-config re2c"
RUN --mount=type=cache,target=/var/cache/apt,target=/var/cache/apt,sharing=locked,id=apt \
    --mount=type=cache,target=/var/lib/apt/lists,target=/var/lib/apt/lists,sharing=locked,id=apt-lists \
    apt-get install -y --no-install-recommends $BUILD_DEPS


# Stage containing the AST extension
FROM --platform=${BUILDPLATFORM} alpine AS ast-downloader
WORKDIR /
RUN --mount=type=cache,target=/var/cache/apk,sharing=locked,id=apk \
    apk add --no-cache git
RUN git clone https://github.com/nikic/php-ast.git


# Stage containing the toolbox PHAR
FROM --platform=${BUILDPLATFORM} alpine AS toolbox-downloader
WORKDIR /
ARG TOOLBOX_VERSION
RUN wget https://github.com/jakzal/toolbox/releases/download/v$TOOLBOX_VERSION/toolbox.phar


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


# Stage that builds all other extensions
FROM builder-base AS extensions-builder
RUN docker-php-ext-install bcmath intl zip pcntl bz2


# Final image
FROM php-base as tools

# Extensions .so
COPY --link --from=ast-builder /usr/local/lib/php/extensions /usr/local/lib/php/extensions
COPY --link --from=pcov-builder /usr/local/lib/php/extensions /usr/local/lib/php/extensions
COPY --link --from=extensions-builder /usr/local/lib/php/extensions /usr/local/lib/php/extensions

# Extensions .ini
COPY --link --from=ast-builder /usr/local/etc/php/conf.d /usr/local/etc/php/conf.d
COPY --link --from=pcov-builder /usr/local/etc/php/conf.d  /usr/local/etc/php/conf.d
COPY --link --from=extensions-builder /usr/local/etc/php/conf.d /usr/local/etc/php/conf.d


COPY --link <<EOF /usr/local/etc/php/conf.d/jakzal.ini
date.timezone=Europe/London
memory_limit=-1
phar.readonly=0
pcov.enabled=0
EOF

COPY --link entrypoint.sh /entrypoint.sh
ARG TOOLBOX_TARGET_DIR="/tools"
COPY --link --from=toolbox-downloader --chmod=+x /toolbox.phar ${TOOLBOX_TARGET_DIR}/toolbox
COPY --link --from=composer:2 /usr/bin/composer ${TOOLBOX_TARGET_DIR}/composer

# INSTALLATION_DATE is used to bust the docker layer cache
ARG INSTALLATION_DATE
ARG TOOLBOX_EXCLUDED_TAGS
ARG TOOLBOX_VERSION
ENV TOOLBOX_EXCLUDED_TAGS=${TOOLBOX_EXCLUDED_TAGS}
ENV TOOLBOX_TARGET_DIR="/tools"
ENV TOOLBOX_VERSION=${TOOLBOX_VERSION}
ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_HOME=$TOOLBOX_TARGET_DIR/.composer
ENV PATH="$PATH:$TOOLBOX_TARGET_DIR:${COMPOSER_HOME}/vendor/bin:$TOOLBOX_TARGET_DIR/QualityAnalyzer/bin:$TOOLBOX_TARGET_DIR/DesignPatternDetector/bin:$TOOLBOX_TARGET_DIR/EasyCodingStandard/bin"

RUN --mount=type=secret,id=composer.auth,target=${COMPOSER_HOME}/auth.json \
    --mount=type=cache,id=composer,target=${COMPOSER_HOME}/cache\
    --mount=type=secret,id=phive.auth,target=${TOOLBOX_TARGET_DIR}/.phive/auth.xml \
    php $TOOLBOX_TARGET_DIR/toolbox install

WORKDIR $TOOLBOX_TARGET_DIR
ENTRYPOINT ["/entrypoint.sh"]
CMD php $TOOLBOX_TARGET_DIR/toolbox list-tools
