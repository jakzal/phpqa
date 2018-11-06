# Static Analysis Tools for PHP

Docker image providing static analysis tools for PHP.

[![Build Status](https://travis-ci.org/jakzal/phpqa.svg?branch=master)](https://travis-ci.org/jakzal/phpqa) [![Docker Build](https://img.shields.io/docker/build/jakzal/phpqa.svg)](https://hub.docker.com/r/jakzal/phpqa/)

## Supported platforms and PHP versions

Docker hub repository: https://hub.docker.com/r/jakzal/phpqa/

Nightly builds: https://hub.docker.com/r/jakzal/phpqa-nightly/

### Debian

* `1.14.1`, `1.14`, `latest` ([7.2/debian/Dockerfile](https://github.com/jakzal/phpqa/blob/v1.14.1/7.2/debian/Dockerfile))
* `1.14.1-php7.1`, `1.14-php7.1`, `php7.1` ([7.1/debian/Dockerfile](https://github.com/jakzal/phpqa/blob/v1.14.1/7.1/debian/Dockerfile))
* `1.14.1-php7.2`, `1.14-php7.2`, `php7.2` ([7.2/debian/Dockerfile](https://github.com/jakzal/phpqa/blob/v1.14.1/7.2/debian/Dockerfile))

### Alpine

* `1.14.1-alpine`, `1.14-alpine`, `alpine` ([7.2/alpine/Dockerfile](https://github.com/jakzal/phpqa/blob/v1.14.1/7.2/alpine/Dockerfile))
* `1.14.1-php7.1-alpine`, `1.14-php7.1-alpine`, `php7.1-alpine` ([7.1/alpine/Dockerfile](https://github.com/jakzal/phpqa/blob/v1.14.1/7.1/alpine/Dockerfile))
* `1.14.1-php7.2-alpine`, `1.14-php7.2-alpine`, `php7.2-alpine` ([7.2/alpine/Dockerfile](https://github.com/jakzal/phpqa/blob/v1.14.1/7.2/alpine/Dockerfile))

## Available tools

* composer - [Dependency Manager for PHP](https://getcomposer.org/)
* composer-bin-plugin - [Composer plugin to install bin vendors in isolated locations](https://github.com/bamarni/composer-bin-plugin)
* box - [An application for building and managing Phars](https://box-project.github.io/box2/)
* analyze - [Visualizes metrics and source code](https://github.com/Qafoo/QualityAnalyzer)
* behat - [Helps to test business expectations](http://behat.org/)
* churn - [Discovers good candidates for refactoring](https://github.com/bmitch/churn-php)
* dephpend - [Detect flaws in your architecture](https://dephpend.com/)
* deprecation-detector - [Finds usages of deprecated code](https://github.com/sensiolabs-de/deprecation-detector)
* deptrac - [Enforces dependency rules](https://github.com/sensiolabs-de/deptrac)
* design-pattern - [Detects design patterns](https://github.com/Halleck45/DesignPatternDetector)
* diffFilter - [Applies QA tools to run on a single pull request](https://github.com/exussum12/coverageChecker)
* ecs - [EasyCodingStandard sets up and runs coding standard checks with 0-knowledge of PHP-CS-Fixer and PHP_CodeSniffer](https://github.com/Symplify/EasyCodingStandard)
* infection - [AST based PHP Mutation Testing Framework](https://infection.github.io/)
* parallel-lint - [Checks PHP file syntax](https://github.com/JakubOnderka/PHP-Parallel-Lint)
* pdepend - [Static Analysis Tool](https://pdepend.org/)
* phan - [Static Analysis Tool](https://github.com/phan/phan)
* php-coupling-detector - [Detects code coupling issues](https://akeneo.github.io/php-coupling-detector/)
* php-cs-fixer - [PHP Coding Standards Fixer](http://cs.sensiolabs.org/)
* php-formatter - [Custom coding standards fixer](https://github.com/mmoreram/php-formatter)
* php-semver-checker - [Suggests a next version according to semantic versioning](https://github.com/tomzx/php-semver-checker)
* phpDocumentor - [Documentation generator](https://www.phpdoc.org/)
* phpbench - [PHP Benchmarking framework](https://github.com/phpbench/phpbench)
* phpa - [Checks for weak assumptions](https://github.com/rskuipers/php-assumptions)
* phpca - [Finds usage of non-built-in extensions](https://github.com/wapmorgan/PhpCodeAnalyzer)
* phpcb - [PHP Code Browser](https://github.com/mayflower/PHP_CodeBrowser)
* phpcbf - [Automatically corrects coding standard violations](https://github.com/squizlabs/PHP_CodeSniffer)
* phpcf - [Finds usage of deprecated features](http://wapmorgan.github.io/PhpCodeFixer/)
* phpcov - [a command-line frontend for the PHP_CodeCoverage library](https://github.com/sebastianbergmann/phpcov)
* phpcpd - [Copy/Paste Detector](https://github.com/sebastianbergmann/phpcpd)
* phpcs - [Detects coding standard violations](https://github.com/squizlabs/PHP_CodeSniffer)
* phpda - [Generates dependency graphs](https://mamuz.github.io/PhpDependencyAnalysis/)
* phpdoc-to-typehint - [Automatically adds type hints and return types based on PHPDocs](https://github.com/dunglas/phpdoc-to-typehint)
* phplint - [A tool that can speed up linting of php files by running several lint processes at once](https://github.com/overtrue/phplint)
* phploc - [A tool for quickly measuring the size of a PHP project](https://github.com/sebastianbergmann/phploc)
* phpmd - [A tool for finding problems in PHP code](https://phpmd.org/)
* phpmetrics - [Static Analysis Tool](http://www.phpmetrics.org/)
* phpmnd - [Helps to detect magic numbers](https://github.com/povils/phpmnd)
* phpspec - [SpecBDD Framework](http://www.phpspec.net/)
* phpstan - [Static Analysis Tool](https://github.com/phpstan/phpstan)
* phpstan-deprecation-rules - [PHPStan rules for detecting usage of deprecated classes, methods, properties, constants and traits](https://github.com/phpstan/phpstan-deprecation-rules)
* phpstan-strict-rules - [Extra strict and opinionated rules for PHPStan](https://github.com/phpstan/phpstan-strict-rules)
* phpstan-doctrine - [Doctrine extensions for PHPStan](https://github.com/phpstan/phpstan-doctrine)
* phpstan-phpunit - [PHPUnit extensions and rules for PHPStan](https://github.com/phpstan/phpstan-phpunit)
* phpstan-symfony - [Symfony extension for PHPStan](https://github.com/phpstan/phpstan-symfony)
* phpstan-beberlei-assert - [PHPStan extension for beberlei/assert](https://github.com/phpstan/phpstan-beberlei-assert)
* phpstan-webmozart-assert - [PHPStan extension for webmozart/assert](https://github.com/phpstan/phpstan-webmozart-assert)
* phpstan-exception-rules - [PHPStan rules for checked and unchecked exceptions](https://github.com/pepakriz/phpstan-exception-rules)
* phpunit - [The PHP testing framework](https://phpunit.de/)
* psalm - [Finds errors in PHP applications](https://getpsalm.org/)
* psecio-parse - [Parse scanner is a static scanning tool to review your PHP code for potential security-related issues](https://github.com/psecio/parse)
* security-checker - [Checks composer dependencies for known security vulnerabilities](https://github.com/sensiolabs/security-checker)
* testability - [Analyses and reports testability issues of a php codebase](https://github.com/edsonmedina/php_testability)

## Running tools

Pull the image:

```bash
docker pull jakzal/phpqa
```

The default command will list available tools:

```bash
docker run -it --rm jakzal/phpqa
```

To run the selected tool inside the container, you'll need to mount
the project directory on the container with `-v $(pwd):/project`.
Some tools like to write to the `/tmp` directory (like PHPStan, or Behat in some cases), therefore it's often useful
to share it between docker runs, i.e. with `-v $(pwd)/tmp-phpqa:/tmp`.
If you want to be able to interrupt the selected tool if it takes too much time to complete, you can use the
`--init` option. Please refer to the [docker run documentation](https://docs.docker.com/engine/reference/commandline/run/) for more information.

```bash
docker run --init -it --rm -v $(pwd):/project -v $(pwd)/tmp-phpqa:/tmp -w /project jakzal/phpqa phpstan analyse src
```

You'll probably want to tweak this command for your needs and create an alias for convenience:

```bash
alias phpqa='docker run --init -it --rm -v $(pwd):/project -v $(pwd)/tmp-phpqa:/tmp -w /project jakzal/phpqa:alpine'
```

Add it to your `~/.bashrc` so it's defined every time you start a new terminal session.

Now the command becomes a lot simpler:

```bash
phpqa phpstan analyse src
```

## Building the image

```bash
git clone https://github.com/jakzal/phpqa.git
cd phpqa
make build-latest
```

To build the alpine version:

```
make build-alpine
```

## Customising the image

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
docker run --init -it --rm -v $(pwd):/project -w /project foo/phpqa phpmetrics .
```

### Adding PHPStan extensions

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

## Debugger & Code Coverage

The [php-dbg debugger](http://php.net/manual/en/debugger-about.php) is provided by default. No additional extensions (like XDebug) are required to calculate code coverage:

```
phpqa phpdbg -qrr ./vendor/bin/phpunit --coverage-text
```

## Contributing

Please read the [Contributing guide](CONTRIBUTING.md) to learn about contributing to this project.
Please note that this project is released with a [Contributor Code of Conduct](CODE_OF_CONDUCT.md).
By participating in this project you agree to abide by its terms.
