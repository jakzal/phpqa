# Customising the image

*Contributed by [jakzal](https://github.com/jakzal).*

It's often needed to customise the image with project specific extensions.
To achieve that simply create a new image based on `jakzal/phpqa`:

```
FROM jakzal/phpqa:alpine

RUN apk add --no-cache libxml2-dev \
 && docker-php-ext-install soap
```

Next, build it:

```
docker build -t foo/phpqa .
```

Finally, use your customised image instead of the default one:

```
docker run --init -it --rm -v "$(pwd):/project" -w /project foo/phpqa phpmetrics .
```

## Adding PHPStan extensions

A number of PHPStan extensions is available on the image in `/tools/.composer/vendor-bin/phpstan/vendor` out of the box.
You can find them with the command below:

```
phpqa find /tools/.composer/vendor-bin/phpstan/vendor/ -iname 'rules.neon' -or -iname 'extension.neon'
```

Use the composer-bin-plugin to install any additional PHPStan extensions in the `phpstan` namespace:

```
FROM jakzal/phpqa:alpine

RUN composer global bin phpstan require phpstan/phpstan-phpunit
```

You'll be able to include them in your PHPStan configuration from the `/tools/.composer/vendor-bin/phpstan/vendor` path:

```yaml
includes:
    - /tools/.composer/vendor-bin/phpstan/vendor/phpstan/phpstan-phpunit/extension.neon
```