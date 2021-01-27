FROM php:7.3-cli

LABEL maintainer="Jakub Zalas <jakub@zalas.pl>"

ENV BUILD_DEPS="autoconf file g++ gcc libc-dev pkg-config re2c"
ENV LIB_DEPS="zlib1g-dev libzip-dev libbz2-dev"
ENV TOOL_DEPS="git graphviz make unzip"
ENV TOOLBOX_EXCLUDED_TAGS="exclude-php:7.3"
ENV TOOLBOX_TARGET_DIR="/tools"
ENV TOOLBOX_VERSION="1.39.0"
ENV PATH="$PATH:$TOOLBOX_TARGET_DIR:$TOOLBOX_TARGET_DIR/.composer/vendor/bin:/tools/QualityAnalyzer/bin:$TOOLBOX_TARGET_DIR/DesignPatternDetector/bin:$TOOLBOX_TARGET_DIR/EasyCodingStandard/bin"
ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_HOME=$TOOLBOX_TARGET_DIR/.composer

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

RUN apt-get update && apt-get install -y --no-install-recommends $TOOL_DEPS $BUILD_DEPS $LIB_DEPS && rm -rf /var/lib/apt/lists/* \
 && git clone https://github.com/nikic/php-ast.git && cd php-ast && phpize && ./configure && make && make install && cd .. && rm -rf php-ast && docker-php-ext-enable ast \
 && pecl install pcov && docker-php-ext-enable pcov \
 && docker-php-ext-install zip pcntl intl bz2 \
 && echo "date.timezone=Europe/London" >> $PHP_INI_DIR/php.ini \
 && echo "memory_limit=-1" >> $PHP_INI_DIR/php.ini \
 && echo "phar.readonly=0" >> $PHP_INI_DIR/php.ini \
 && echo "pcov.enabled=0" >> $PHP_INI_DIR/php.ini \
 && mkdir -p $TOOLBOX_TARGET_DIR && curl -Ls https://github.com/jakzal/toolbox/releases/download/v$TOOLBOX_VERSION/toolbox.phar -o $TOOLBOX_TARGET_DIR/toolbox && chmod +x $TOOLBOX_TARGET_DIR/toolbox \
 && php $TOOLBOX_TARGET_DIR/toolbox install \
 && rm -rf $COMPOSER_HOME/cache \
 && apt-get purge -y --auto-remove $BUILD_DEPS

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD php $TOOLBOX_TARGET_DIR/toolbox list-tools
