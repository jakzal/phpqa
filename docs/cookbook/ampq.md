# AMPQ

*Contributed by [dgoosens](https://github.com/dgoosens).*

Some extension do take a little time before they are ready for the latest and greatest version of PHP.
If you really need those extensions and can not wait, you will have to compile them yourself.

This can easily be done with PHPQA as well.

*The procedure below uses a [Docker MultiStage Build](https://docs.docker.com/develop/develop-images/multistage-build/) and the resulting build will therefore barely be any bigger than the original PHPQA.*

As instructed in the [Customising the image recipe](customising-the-image.md), one has to create a new `Dockerfile` to customize it.

## Debian Dockerfile

```Dockerfile
FROM jakzal/phpqa:debian AS ext-amqp
ENV EXT_AMQP_VERSION=master

RUN docker-php-source extract
RUN apt-get update
RUN apt-get install -qq -y build-essential autoconf librabbitmq-dev
RUN git clone --branch $EXT_AMQP_VERSION --depth 1 https://github.com/php-amqp/php-amqp.git /usr/src/php/ext/amqp
RUN cd /usr/src/php/ext/amqp && git submodule update --init
RUN docker-php-ext-install amqp

RUN ls -al /usr/local/lib/php/extensions/

FROM jakzal/phpqa:debian

COPY --from=ext-amqp /usr/local/etc/php/conf.d/docker-php-ext-amqp.ini /usr/local/etc/php/conf.d/docker-php-ext-amqp.ini
COPY --from=ext-amqp /usr/local/lib/php/extensions/no-debug-non-zts-20210902/amqp.so /usr/local/lib/php/extensions/no-debug-non-zts-20210902/amqp.so

RUN apt-get update
RUN apt-get install -qq -y librabbitmq-dev
```

## Alpine Dockerfile

```Dockerfile
FROM jakzal/phpqa:alpine AS ext-amqp
ENV EXT_AMQP_VERSION=master

RUN docker-php-source extract
RUN apk -Uu add rabbitmq-c-dev
RUN git clone --branch $EXT_AMQP_VERSION --depth 1 https://github.com/php-amqp/php-amqp.git /usr/src/php/ext/amqp
RUN cd /usr/src/php/ext/amqp && git submodule update --init
RUN docker-php-ext-install amqp

RUN ls -al /usr/local/lib/php/extensions/

FROM jakzal/phpqa:alpine

COPY --from=ext-amqp /usr/local/etc/php/conf.d/docker-php-ext-amqp.ini /usr/local/etc/php/conf.d/docker-php-ext-amqp.ini
COPY --from=ext-amqp /usr/local/lib/php/extensions/no-debug-non-zts-20210902/amqp.so /usr/local/lib/php/extensions/no-debug-non-zts-20210902/amqp.so

RUN apk -Uu add rabbitmq-c-dev
```

## About the extension path

Please note that the `no-debug-non-zts-20210902` in the above extension path, that is copied, changes with every release...
This is why the `RUN ls -al /usr/local/lib/php/extensions/` is issued as it will list the content of that directory and inform the user what the exact path should be.

## Source

Highly inspired by this [blog post](https://exploit.cz/how-to-compile-amqp-extension-for-php-8-0-via-multistage-dockerfile/) by Patrick from [exploit.cz](https://exploit.cz/)