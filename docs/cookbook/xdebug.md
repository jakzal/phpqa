# Xdebug

*Contributed by [dgoosens](https://github.com/dgoosens).*

This procedure is similar to the one explained for [AMPQ](ampq.md).

## Debian Dockerfile

```Dockerfile
FROM jakzal/phpqa:debian AS ext-xdebug

RUN docker-php-source extract
RUN apt-get update
RUN apt-get install -qq -y build-essential autoconf 

RUN pecl install xdebug
RUN docker-php-ext-enable xdebug

RUN ls -al /usr/local/lib/php/extensions/

FROM jakzal/phpqa:debian

COPY --from=ext-xdebug /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
COPY --from=ext-xdebug /usr/local/lib/php/extensions/no-debug-non-zts-20210902/xdebug.so /usr/local/lib/php/extensions/no-debug-non-zts-20210902/xdebug.so
```

## Alpine Dockerfile

```Dockerfile
FROM jakzal/phpqa:alpine AS ext-xdebug

RUN docker-php-source extract
RUN apk -Uu add autoconf build-base
RUN pecl install xdebug
RUN docker-php-ext-enable xdebug

RUN ls -al /usr/local/lib/php/extensions/

FROM jakzal/phpqa:alpine

COPY --from=ext-xdebug /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
COPY --from=ext-xdebug /usr/local/lib/php/extensions/no-debug-non-zts-20210902/xdebug.so /usr/local/lib/php/extensions/no-debug-non-zts-20210902/xdebug.so
```

## About the extension path

Please note that the `no-debug-non-zts-20210902` in the above extension path, that is copied, changes with every release...
This is why the `RUN ls -al /usr/local/lib/php/extensions/` is issued as it will list the content of that directory and inform the user what the exact path should be.

## Note

If you need to include multiple extensions, you will have to bundle the commands together.  
For instance, for [AMPQ](ampq.md) **AND** XDebug, the Debian `Dockerfile` will look like this:

```Dockerfile
FROM jakzal/phpqa:debian AS ext-multi
ENV EXT_AMQP_VERSION=master

RUN docker-php-source extract
RUN apt-get update
RUN apt-get install -qq -y build-essential autoconf 

# xdebug
RUN pecl install xdebug
RUN docker-php-ext-enable xdebug

# ampq
RUN apt-get install -qq -y librabbitmq-dev
RUN git clone --branch $EXT_AMQP_VERSION --depth 1 https://github.com/php-amqp/php-amqp.git /usr/src/php/ext/amqp
RUN cd /usr/src/php/ext/amqp && git submodule update --init
RUN docker-php-ext-install amqp


RUN ls -al /usr/local/lib/php/extensions/

FROM jakzal/phpqa:debian

# xdebug
COPY --from=ext-multi /usr/local/etc/php/conf.d/docker-php-ext-multi.ini /usr/local/etc/php/conf.d/docker-php-ext-multi.ini
COPY --from=ext-multi /usr/local/lib/php/extensions/no-debug-non-zts-20210902/xdebug.so /usr/local/lib/php/extensions/no-debug-non-zts-20210902/xdebug.so

# ampq
COPY --from=ext-amqp /usr/local/etc/php/conf.d/docker-php-ext-amqp.ini /usr/local/etc/php/conf.d/docker-php-ext-amqp.ini
COPY --from=ext-amqp /usr/local/lib/php/extensions/no-debug-non-zts-20210902/amqp.so /usr/local/lib/php/extensions/no-debug-non-zts-20210902/amqp.so
RUN apt-get update
RUN apt-get install -qq -y librabbitmq-dev
```

