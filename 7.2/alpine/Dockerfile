# install noverify
FROM alpine as vkcom-noverify
RUN set -xe && \
    apk add --no-cache \
        git \
        go \
        musl-dev && \
    go get -u github.com/VKCOM/noverify && \
    cd /root/go/src/github.com/VKCOM/noverify && \
    go build && \
    git clone https://github.com/JetBrains/phpstorm-stubs.git --depth 1 /usr/src/phpstorm-stubs

# phpqa dockerfile for php:7.2.10-alpine
FROM php:7.2.10-alpine

LABEL maintainer="Jakub Zalas <jakub@zalas.pl>"

ENV BUILD_DEPS="autoconf file g++ gcc libc-dev pkgconf re2c"
ENV LIB_DEPS="zlib-dev libzip-dev"
ENV TOOL_DEPS="git graphviz make unzip"
ENV TOOLBOX_EXCLUDED_TAGS="exclude-php:7.2"
ENV TOOLBOX_TARGET_DIR="/tools"
ENV TOOLBOX_VERSION="1.12.0"
ENV PATH="$PATH:$TOOLBOX_TARGET_DIR:$TOOLBOX_TARGET_DIR/.composer/vendor/bin:$TOOLBOX_TARGET_DIR/QualityAnalyzer/bin:$TOOLBOX_TARGET_DIR/DesignPatternDetector/bin:$TOOLBOX_TARGET_DIR/EasyCodingStandard/bin"
ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_HOME=$TOOLBOX_TARGET_DIR/.composer

COPY --from=composer:1.9 /usr/bin/composer /usr/bin/composer

RUN apk add --no-cache --virtual .tool-deps $TOOL_DEPS $LIB_DEPS \
 && apk add --no-cache --virtual .build-deps $BUILD_DEPS \
 && git clone https://github.com/nikic/php-ast.git && cd php-ast && phpize && ./configure && make && make install && cd .. && rm -rf php-ast && docker-php-ext-enable ast \
 && docker-php-ext-install zip pcntl \
 && echo "date.timezone=Europe/London" >> $PHP_INI_DIR/php.ini \
 && echo "memory_limit=-1" >> $PHP_INI_DIR/php.ini \
 && echo "phar.readonly=0" >> $PHP_INI_DIR/php.ini \
 && mkdir -p $TOOLBOX_TARGET_DIR && curl -Ls https://github.com/jakzal/toolbox/releases/download/v$TOOLBOX_VERSION/toolbox.phar -o $TOOLBOX_TARGET_DIR/toolbox && chmod +x $TOOLBOX_TARGET_DIR/toolbox \
 && php $TOOLBOX_TARGET_DIR/toolbox install \
 && rm -rf $COMPOSER_HOME/cache \
 && apk del .build-deps

CMD php $TOOLBOX_TARGET_DIR/toolbox list-tools

# Add tools
COPY --from=vkcom-noverify /root/go/src/github.com/VKCOM/noverify/noverify /usr/local/bin/
COPY --from=vkcom-noverify /usr/src/phpstorm-stubs /usr/src/phpstorm-stubs

RUN wget -O phpunit-5 https://phar.phpunit.de/phpunit-5.phar \
   && chmod +x phpunit-5 \
   && mv phpunit-5 $TOOLBOX_TARGET_DIR/
RUN wget -O yaml-lint https://github.com/j13k/yaml-lint/releases/download/1.1.3/yaml-lint.phar \
    && chmod +x yaml-lint \
    && mv yaml-lint $TOOLBOX_TARGET_DIR/.composer/vendor/bin

RUN wget -O twig-lint https://asm89.github.io/d/twig-lint.phar \
    && chmod +x twig-lint \
    && mv twig-lint $TOOLBOX_TARGET_DIR/.composer/vendor/bin

RUN docker-php-ext-install pdo pdo_mysql calendar bcmath
RUN apk add --no-cache --virtual .build-deps libxml2-dev \
 && docker-php-ext-install soap \
 && apk del .build-deps

RUN apk add --update icu \
 && apk add --no-cache --virtual .build-deps \
   zlib-dev \
   icu-dev \
 && docker-php-ext-configure intl \
 && docker-php-ext-install intl \
 && docker-php-ext-enable intl \
 && apk del .build-deps
