ARG PHP_VERSION=8.0
ARG BASE_IMAGE=php:${PHP_VERSION}-alpine
ARG TOOLBOX_EXCLUDED_TAGS="exclude-php:${PHP_VERSION}"
ARG TOOLBOX_VERSION="1.47.1"

FROM ${BASE_IMAGE} as phpbase

LABEL maintainer="Jakub Zalas <jakub@zalas.pl>"
ARG BUILD_DEPS="autoconf file g++ gcc libc-dev pkgconf re2c"
ARG LIB_DEPS="zlib-dev libzip-dev bzip2-dev icu-dev"
ARG TOOL_DEPS="git graphviz ttf-freefont make unzip gpgme"

RUN apk add --no-cache --virtual .tool-deps $TOOL_DEPS $LIB_DEPS \
 && apk add --no-cache --virtual .build-deps $BUILD_DEPS \
 && git clone https://github.com/nikic/php-ast.git && cd php-ast && phpize && ./configure && make && make install && cd .. && rm -rf php-ast && docker-php-ext-enable ast \
 && pecl install pcov && docker-php-ext-enable pcov \
 && docker-php-ext-configure intl \
 && docker-php-ext-install zip pcntl bz2 intl \
 && echo "date.timezone=Europe/London" >> $PHP_INI_DIR/php.ini \
 && echo "memory_limit=-1" >> $PHP_INI_DIR/php.ini \
 && echo "phar.readonly=0" >> $PHP_INI_DIR/php.ini \
 && echo "pcov.enabled=0" >> $PHP_INI_DIR/php.ini \
 && apk del .build-deps

FROM phpbase as toolbox

ARG TOOLBOX_VERSION

RUN curl -Ls https://github.com/jakzal/toolbox/releases/download/v$TOOLBOX_VERSION/toolbox.phar -o /toolbox \
 && chmod +x /toolbox

FROM phpbase as tools

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

COPY --from=toolbox /toolbox $TOOLBOX_TARGET_DIR/toolbox
COPY --from=composer:2 /usr/bin/composer $TOOLBOX_TARGET_DIR/composer
COPY entrypoint.sh /entrypoint.sh

RUN php $TOOLBOX_TARGET_DIR/toolbox install \
 && rm -rf $COMPOSER_HOME/cache

WORKDIR $TOOLBOX_TARGET_DIR
ENTRYPOINT ["/entrypoint.sh"]
CMD php $TOOLBOX_TARGET_DIR/toolbox list-tools

