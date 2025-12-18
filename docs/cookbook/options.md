# Options

*Contributed by [alexislefebvre](https://github.com/alexislefebvre).*

For tools that don’t require Composer dependencies, e.g. `php-cs-fixer`,
you can skip the automatic `composer install` <sup>(1)</sup>
by defining the value `SKIP_COMPOSER_INSTALL` to `true` (it’s a string).

<sup>(1)</sup> it’s configured in the [`Dockerfile`](https://github.com/jakzal/phpqa/blob/master/Dockerfile).
