FROM php:7.3-cli

LABEL maintainer="Jakub Zalas <jakub@zalas.pl>"

ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_HOME=/tools/.composer
ENV BUILD_DEPS="autoconf file g++ gcc libc-dev make pkg-config re2c"
ENV LIB_DEPS="zlib1g-dev"
ENV TOOL_DEPS="git graphviz unzip"
ENV PATH="$PATH:/tools/.composer/vendor/bin:/tools/QualityAnalyzer/bin:/tools/DesignPatternDetector/bin:/tools/EasyCodingStandard/bin"
ENV TOOLS_JSON=/tools/tools.json

COPY tools.json ${TOOLS_JSON}
COPY tools.php /usr/local/bin/tools.php
COPY --from=composer:1.7 /usr/bin/composer /usr/bin/composer

RUN apt-get update && apt-get install -y --no-install-recommends $TOOL_DEPS $BUILD_DEPS $LIB_DEPS && rm -rf /var/lib/apt/lists/* \
 && git clone https://github.com/nikic/php-ast.git && cd php-ast && phpize && ./configure && make && make install && cd .. && rm -rf php-ast && docker-php-ext-enable ast \
 && docker-php-ext-install zip pcntl \
 && echo "date.timezone=Europe/London" >> $PHP_INI_DIR/php.ini \
 && echo "memory_limit=-1" >> $PHP_INI_DIR/php.ini \
 && echo "phar.readonly=0" >> $PHP_INI_DIR/php.ini \
 && php /usr/local/bin/tools.php install \
 && rm -rf ~/.composer/cache \
 && apt-get purge -y --auto-remove $BUILD_DEPS

CMD php /usr/local/bin/tools.php list
