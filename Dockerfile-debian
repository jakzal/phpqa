FROM php:7.3-cli

LABEL maintainer="Jakub Zalas <jakub@zalas.pl>"

ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_HOME=/tools/.composer
ENV BUILD_DEPS="autoconf file g++ gcc libc-dev make pkg-config re2c"
ENV LIB_DEPS="zlib1g-dev libzip-dev"
ENV TOOL_DEPS="git graphviz unzip"
ENV TOOLBOX_EXCLUDED_TAGS="exclude-php:7.3"
ENV TOOLBOX_TARGET_DIR="/tools"
ENV PATH="$PATH:$TOOLBOX_TARGET_DIR:/tools/.composer/vendor/bin:/tools/QualityAnalyzer/bin:/tools/DesignPatternDetector/bin:/tools/EasyCodingStandard/bin"

COPY --from=composer:1.8 /usr/bin/composer /usr/bin/composer

RUN apt-get update && apt-get install -y --no-install-recommends $TOOL_DEPS $BUILD_DEPS $LIB_DEPS && rm -rf /var/lib/apt/lists/* \
 && git clone https://github.com/nikic/php-ast.git && cd php-ast && phpize && ./configure && make && make install && cd .. && rm -rf php-ast && docker-php-ext-enable ast \
 && docker-php-ext-install zip pcntl \
 && echo "date.timezone=Europe/London" >> $PHP_INI_DIR/php.ini \
 && echo "memory_limit=-1" >> $PHP_INI_DIR/php.ini \
 && echo "phar.readonly=0" >> $PHP_INI_DIR/php.ini \
 && mkdir /tools && curl -Ls https://github.com/jakzal/toolbox/releases/download/v1.0.0/toolbox.phar -o /tools/toolbox && chmod +x /tools/toolbox \
 && php /tools/toolbox install \
 && rm -rf ~/.composer/cache \
 && apt-get purge -y --auto-remove $BUILD_DEPS

CMD php /tools/toolbox list-tools
