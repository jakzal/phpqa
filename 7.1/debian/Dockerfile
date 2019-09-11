ARG BASE_IMAGE=php:7.1-cli
ARG BUILD_DEPS="autoconf file g++ gcc libc-dev pkg-config re2c zlib1g-dev"
ARG LIB_DEPS="zlib1g libzip-dev"
ARG TOOL_DEPS="git graphviz make unzip"
ARG TOOLBOX_EXCLUDED_TAGS="exclude-php:7.1"
ARG TOOLBOX_TARGET_DIR="/tools"
ARG TOOLBOX_VERSION="1.9.1"
ARG TOOLBOX_PATH="$TOOLBOX_TARGET_DIR:$TOOLBOX_TARGET_DIR/.composer/vendor/bin:$TOOLBOX_TARGET_DIR/QualityAnalyzer/bin:$TOOLBOX_TARGET_DIR/DesignPatternDetector/bin:$TOOLBOX_TARGET_DIR/EasyCodingStandard/bin"
ARG COMPOSER_ALLOW_SUPERUSER=1
ARG COMPOSER_HOME=${TOOLBOX_TARGET_DIR}/.composer
FROM composer:1.9 AS composer

FROM ${BASE_IMAGE} AS builder
ARG BUILD_DEPS
ARG LIB_DEPS
ARG TOOL_DEPS
ARG COMPOSER_ALLOW_SUPERUSER
ARG COMPOSER_HOME
ARG TOOLBOX_EXCLUDED_TAGS
ARG TOOLBOX_TARGET_DIR
ARG TOOLBOX_VERSION
ARG TOOLBOX_PATH
ENV PATH="$PATH:$TOOLBOX_PATH"
COPY --from=composer /usr/bin/composer /usr/bin/composer
RUN apt-get update && apt-get install -y --no-install-recommends $TOOL_DEPS $LIB_DEPS $BUILD_DEPS && rm -rf /var/lib/apt/lists/* \
   && echo "date.timezone=Europe/London" >> $PHP_INI_DIR/php.ini && echo "memory_limit=-1" >> $PHP_INI_DIR/php.ini && echo "phar.readonly=0" >> $PHP_INI_DIR/php.ini \
   && git clone https://github.com/nikic/php-ast.git && cd php-ast && phpize && ./configure && make && make install && cd .. && rm -rf php-ast && docker-php-ext-enable ast \
   && docker-php-ext-install zip pcntl \
   && mkdir -p /modules && cp $(php -r "echo ini_get('extension_dir');")/*.so /modules \
   && mkdir -p $TOOLBOX_TARGET_DIR && curl -Ls https://github.com/jakzal/toolbox/releases/download/v$TOOLBOX_VERSION/toolbox.phar -o $TOOLBOX_TARGET_DIR/toolbox && chmod +x $TOOLBOX_TARGET_DIR/toolbox \
   && php $TOOLBOX_TARGET_DIR/toolbox install

FROM ${BASE_IMAGE}
LABEL maintainer="Jakub Zalas <jakub@zalas.pl>"
ARG LIB_DEPS
ARG TOOL_DEPS
ARG COMPOSER_ALLOW_SUPERUSER
ARG COMPOSER_HOME
ARG TOOLBOX_EXCLUDED_TAGS
ARG TOOLBOX_PATH
ARG TOOLBOX_TARGET_DIR
ENV COMPOSER_ALLOW_SUPERUSER=${COMPOSER_ALLOW_SUPERUSER}
ENV COMPOSER_HOME=${COMPOSER_HOME}
ENV PATH="$PATH:$TOOLBOX_PATH"
ENV TOOLBOX_EXCLUDED_TAGS=${TOOLBOX_EXCLUDED_TAGS}
ENV TOOLBOX_TARGET_DIR=${TOOLBOX_TARGET_DIR}
COPY --from=composer /usr/bin/composer /usr/bin/composer
COPY --from=builder ${TOOLBOX_TARGET_DIR} ${TOOLBOX_TARGET_DIR}
COPY --from=builder /modules /modules
RUN apt-get update && apt-get install -y --no-install-recommends $TOOL_DEPS $LIB_DEPS && rm -rf /var/lib/apt/lists/* \
   && echo "date.timezone=Europe/London" >> $PHP_INI_DIR/php.ini && echo "memory_limit=-1" >> $PHP_INI_DIR/php.ini >> $PHP_INI_DIR/php.ini \
   && cp /modules/*.so $(php -r "echo ini_get('extension_dir');")/
RUN docker-php-ext-enable ast pcntl zip
CMD php $TOOLBOX_TARGET_DIR/toolbox list-tools
