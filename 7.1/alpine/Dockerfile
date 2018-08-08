FROM php:7.1-alpine

LABEL maintainer="Jakub Zalas <jakub@zalas.pl>"

ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_HOME=/tools/.composer
ENV BUILD_DEPS="autoconf file g++ gcc libc-dev make pkgconf re2c unzip"
ENV LIB_DEPS="zlib-dev"
ENV TOOL_DEPS="git graphviz"
ENV PATH="$PATH:/tools/.composer/vendor/bin:/tools/QualityAnalyzer/bin:/tools/DesignPatternDetector/bin:/tools/EasyCodingStandard/bin"
ENV TOOLS_JSON=/tools/tools.json

COPY tools.json ${TOOLS_JSON}
COPY tools.php /usr/local/bin/tools.php
COPY --from=composer:1.7 /usr/bin/composer /usr/bin/composer

RUN apk add --no-cache --virtual .tool-deps $TOOL_DEPS $LIB_DEPS \
 && apk add --no-cache --virtual .build-deps $BUILD_DEPS \
 && git clone https://github.com/nikic/php-ast.git && cd php-ast && phpize && ./configure && make && make install && cd .. && rm -rf php-ast && docker-php-ext-enable ast \
 && docker-php-ext-install zip \
 && echo "date.timezone=Europe/London" >> $PHP_INI_DIR/php.ini \
 && echo "memory_limit=-1" >> $PHP_INI_DIR/php.ini \
 && echo "phar.readonly=0" >> $PHP_INI_DIR/php.ini \
 && php /usr/local/bin/tools.php install \
 && rm -rf ~/.composer/cache \
 && apk del .build-deps

CMD php /usr/local/bin/tools.php list
