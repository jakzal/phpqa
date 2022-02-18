# Debugger & Code Coverage

*Contributed by [jakzal](https://github.com/jakzal).*

The [pcov](https://github.com/krakjoe/pcov) code coverage extension,
as well as the [php-dbg debugger](http://php.net/manual/en/debugger-about.php),
are provided on the image out of the box.

pcov is disabled by default so it doesn't affect performance when it's not needed,
and doesn't break interoperability with other coverage extensions.
It can be enabled by setting `pcov.enabled=1`:

```
phpqa php -d pcov.enabled=1 ./vendor/bin/phpunit --coverage-text
```

Infection users will need to define initial php options:

```
phpqa /tools/infection run --initial-tests-php-options='-dpcov.enabled=1'
```
