# Static Analysis Tools for PHP

Docker image providing static analysis tools for PHP.
The list of available tools and the installer are actually managed in the [`jakzal/toolbox` repository](https://github.com/jakzal/toolbox).

[![Build Status](https://github.com/jakzal/phpqa/workflows/Build/badge.svg)](https://github.com/jakzal/phpqa/actions) [![Docker Pulls](https://img.shields.io/docker/pulls/jakzal/phpqa)](https://hub.docker.com/r/jakzal/phpqa/)

## Supported platforms and PHP versions

Docker hub repository: https://hub.docker.com/r/jakzal/phpqa/

Nightly builds: https://hub.docker.com/r/jakzal/phpqa-nightly/

### Debian

* `latest`, `debian` ([debian/Dockerfile](https://github.com/jakzal/phpqa/blob/master/debian/Dockerfile))
* `1.60.3`, `1.60`, `1.60.3-debian`, `1.60-debian` ([debian/Dockerfile](https://github.com/jakzal/phpqa/blob/v1.60.3/debian/Dockerfile))
* `1.60.3-php7.3`, `1.60-php7.3`, `php7.3-debian`, `php7.3` ([debian/Dockerfile](https://github.com/jakzal/phpqa/blob/v1.60.3/debian/Dockerfile))
* `1.60.3-php7.4`, `1.60-php7.4`, `php7.4-debian`, `php7.4` ([debian/Dockerfile](https://github.com/jakzal/phpqa/blob/v1.60.3/debian/Dockerfile))
* `1.60.3-php8.0`, `1.60-php8.0`, `php8.0-debian`, `php8.0` ([debian/Dockerfile](https://github.com/jakzal/phpqa/blob/v1.60.3/debian/Dockerfile))

### Alpine

* `alpine` ([alpine/Dockerfile](https://github.com/jakzal/phpqa/blob/master/alpine/Dockerfile))
* `1.60.3-alpine`, `1.60-alpine`, ([alpine/Dockerfile](https://github.com/jakzal/phpqa/blob/v1.60.3/alpine/Dockerfile))
* `1.60.3-php7.3-alpine`, `1.60-php7.3-alpine`, `php7.3-alpine` ([alpine/Dockerfile](https://github.com/jakzal/phpqa/blob/v1.60.3/alpine/Dockerfile))
* `1.60.3-php7.4-alpine`, `1.60-php7.4-alpine`, `php7.4-alpine` ([alpine/Dockerfile](https://github.com/jakzal/phpqa/blob/v1.60.3/alpine/Dockerfile))
* `1.60.3-php8.0-alpine`, `1.60-php8.0-alpine`, `php8.0-alpine` ([alpine/Dockerfile](https://github.com/jakzal/phpqa/blob/v1.60.3/alpine/Dockerfile))

### Legacy

These are the latest tags for PHP versions that are no longer supported:

* `1.44.0-php7.2`, `1.44-php7.2`, `php7.2` ([7.2/debian/Dockerfile](https://github.com/jakzal/phpqa/blob/v1.44.0/7.2/debian/Dockerfile))
* `1.44.0-php7.2-alpine`, `1.44-php7.2-alpine`, `php7.2-alpine` ([7.2/alpine/Dockerfile](https://github.com/jakzal/phpqa/blob/v1.44.0/7.2/alpine/Dockerfile))
* `1.26.0-php7.1`, `1.26-php7.1`, `php7.1` ([7.1/debian/Dockerfile](https://github.com/jakzal/phpqa/blob/v1.26.0/7.1/debian/Dockerfile))
* `1.26.0-php7.1-alpine`, `1.26-php7.1-alpine`, `php7.1-alpine` ([7.1/alpine/Dockerfile](https://github.com/jakzal/phpqa/blob/v1.26.0/7.1/alpine/Dockerfile))

## Available tools

| Name | Description | PHP 7.3 | PHP 7.4 | PHP 8.0
| :--- | :---------- | :------ | :------ | :------
| analyze | [Visualizes metrics and source code](https://github.com/Qafoo/QualityAnalyzer) | &#x2705; | &#x2705; | &#x274C; |
| behat | [Helps to test business expectations](http://behat.org/) | &#x2705; | &#x2705; | &#x2705; |
| box | [Fast, zero config application bundler with PHARs](https://github.com/humbug/box) | &#x2705; | &#x2705; | &#x2705; |
| box-legacy | [Legacy version of box](https://box-project.github.io/box2/) | &#x2705; | &#x2705; | &#x2705; |
| churn | [Discovers good candidates for refactoring](https://github.com/bmitch/churn-php) | &#x2705; | &#x2705; | &#x2705; |
| codeception | [Codeception is a BDD-styled PHP testing framework](https://codeception.com/) | &#x2705; | &#x2705; | &#x2705; |
| composer | [Dependency Manager for PHP](https://getcomposer.org/) | &#x2705; | &#x2705; | &#x2705; |
| composer-bin-plugin | [Composer plugin to install bin vendors in isolated locations](https://github.com/bamarni/composer-bin-plugin) | &#x2705; | &#x2705; | &#x2705; |
| composer-normalize | [Composer plugin to normalize composer.json files](https://github.com/ergebnis/composer-normalize) | &#x2705; | &#x2705; | &#x2705; |
| composer-require-checker | [Verify that no unknown symbols are used in the sources of a package.](https://github.com/maglnet/ComposerRequireChecker) | &#x274C; | &#x2705; | &#x2705; |
| composer-require-checker-v2 | [Verify that no unknown symbols are used in the sources of a package.](https://github.com/maglnet/ComposerRequireChecker) | &#x2705; | &#x274C; | &#x274C; |
| composer-unused | [Show unused packages by scanning your code](https://github.com/icanhazstring/composer-unused) | &#x2705; | &#x2705; | &#x2705; |
| dephpend | [Detect flaws in your architecture](https://dephpend.com/) | &#x2705; | &#x2705; | &#x2705; |
| deprecation-detector | [Finds usages of deprecated code](https://github.com/sensiolabs-de/deprecation-detector) | &#x2705; | &#x2705; | &#x2705; |
| deptrac | [Enforces dependency rules between software layers](https://github.com/qossmic/deptrac) | &#x274C; | &#x2705; | &#x2705; |
| diffFilter | [Applies QA tools to run on a single pull request](https://github.com/exussum12/coverageChecker) | &#x2705; | &#x2705; | &#x274C; |
| ecs | [Sets up and runs coding standard checks](https://github.com/Symplify/EasyCodingStandard) | &#x2705; | &#x2705; | &#x2705; |
| infection | [AST based PHP Mutation Testing Framework](https://infection.github.io/) | &#x274C; | &#x2705; | &#x2705; |
| larastan | [PHPStan extension for Laravel](https://github.com/nunomaduro/larastan) | &#x2705; | &#x2705; | &#x2705; |
| local-php-security-checker | [Checks composer dependencies for known security vulnerabilities](https://github.com/fabpot/local-php-security-checker) | &#x2705; | &#x2705; | &#x2705; |
| parallel-lint | [Checks PHP file syntax](https://github.com/JakubOnderka/PHP-Parallel-Lint) | &#x2705; | &#x2705; | &#x274C; |
| paratest | [Parallel testing for PHPUnit](https://github.com/paratestphp/paratest) | &#x2705; | &#x2705; | &#x274C; |
| pdepend | [Static Analysis Tool](https://pdepend.org/) | &#x2705; | &#x2705; | &#x2705; |
| phan | [Static Analysis Tool](https://github.com/phan/phan) | &#x2705; | &#x2705; | &#x2705; |
| phive | [PHAR Installation and Verification Environment](https://phar.io/) | &#x2705; | &#x2705; | &#x2705; |
| php-coupling-detector | [Detects code coupling issues](https://akeneo.github.io/php-coupling-detector/) | &#x2705; | &#x2705; | &#x2705; |
| php-cs-fixer | [PHP Coding Standards Fixer](http://cs.symfony.com/) | &#x2705; | &#x2705; | &#x2705; |
| php-formatter | [Custom coding standards fixer](https://github.com/mmoreram/php-formatter) | &#x2705; | &#x2705; | &#x274C; |
| php-fuzzer | [A fuzzer for PHP, which can be used to find bugs in libraries by feeding them 'random' inputs](https://github.com/nikic/PHP-Fuzzer) | &#x274C; | &#x2705; | &#x2705; |
| php-semver-checker | [Suggests a next version according to semantic versioning](https://github.com/tomzx/php-semver-checker) | &#x2705; | &#x2705; | &#x2705; |
| phpa | [Checks for weak assumptions](https://github.com/rskuipers/php-assumptions) | &#x2705; | &#x2705; | &#x2705; |
| phpat | [Easy to use architecture testing tool](https://github.com/carlosas/phpat) | &#x2705; | &#x2705; | &#x274C; |
| phpbench | [PHP Benchmarking framework](https://github.com/phpbench/phpbench) | &#x2705; | &#x2705; | &#x274C; |
| phpca | [Finds usage of non-built-in extensions](https://github.com/wapmorgan/PhpCodeAnalyzer) | &#x2705; | &#x2705; | &#x2705; |
| phpcb | [PHP Code Browser](https://github.com/mayflower/PHP_CodeBrowser) | &#x2705; | &#x2705; | &#x2705; |
| phpcbf | [Automatically corrects coding standard violations](https://github.com/squizlabs/PHP_CodeSniffer) | &#x2705; | &#x2705; | &#x2705; |
| phpcodesniffer-composer-install | [Easy installation of PHP_CodeSniffer coding standards (rulesets).](https://github.com/Dealerdirect/phpcodesniffer-composer-installer) | &#x2705; | &#x2705; | &#x2705; |
| phpcov | [a command-line frontend for the PHP_CodeCoverage library](https://github.com/sebastianbergmann/phpcov) | &#x2705; | &#x2705; | &#x2705; |
| phpcpd | [Copy/Paste Detector](https://github.com/sebastianbergmann/phpcpd) | &#x2705; | &#x2705; | &#x2705; |
| phpcs | [Detects coding standard violations](https://github.com/squizlabs/PHP_CodeSniffer) | &#x2705; | &#x2705; | &#x2705; |
| phpcs-security-audit | [Finds vulnerabilities and weaknesses related to security in PHP code](https://github.com/FloeDesignTechnologies/phpcs-security-audit) | &#x2705; | &#x2705; | &#x2705; |
| phpda | [Generates dependency graphs](https://mamuz.github.io/PhpDependencyAnalysis/) | &#x2705; | &#x2705; | &#x2705; |
| phpdd | [Finds usage of deprecated features](http://wapmorgan.github.io/PhpDeprecationDetector) | &#x2705; | &#x2705; | &#x2705; |
| phpdoc-to-typehint | [Automatically adds type hints and return types based on PHPDocs](https://github.com/dunglas/phpdoc-to-typehint) | &#x2705; | &#x2705; | &#x2705; |
| phpDocumentor | [Documentation generator](https://www.phpdoc.org/) | &#x2705; | &#x2705; | &#x2705; |
| phpinsights | [Analyses code quality, style, architecture and complexity](https://phpinsights.com/) | &#x2705; | &#x2705; | &#x274C; |
| phplint | [Lints php files in parallel](https://github.com/overtrue/phplint) | &#x2705; | &#x2705; | &#x2705; |
| phploc | [A tool for quickly measuring the size of a PHP project](https://github.com/sebastianbergmann/phploc) | &#x2705; | &#x2705; | &#x2705; |
| phpmd | [A tool for finding problems in PHP code](https://phpmd.org/) | &#x2705; | &#x2705; | &#x2705; |
| phpmetrics | [Static Analysis Tool](http://www.phpmetrics.org/) | &#x2705; | &#x2705; | &#x2705; |
| phpmnd | [Helps to detect magic numbers](https://github.com/povils/phpmnd) | &#x2705; | &#x2705; | &#x2705; |
| phpspec | [SpecBDD Framework](http://www.phpspec.net/) | &#x2705; | &#x2705; | &#x2705; |
| phpstan | [Static Analysis Tool](https://github.com/phpstan/phpstan) | &#x2705; | &#x2705; | &#x2705; |
| phpstan-beberlei-assert | [PHPStan extension for beberlei/assert](https://github.com/phpstan/phpstan-beberlei-assert) | &#x2705; | &#x2705; | &#x2705; |
| phpstan-deprecation-rules | [PHPStan rules for detecting deprecated code](https://github.com/phpstan/phpstan-deprecation-rules) | &#x2705; | &#x2705; | &#x2705; |
| phpstan-doctrine | [Doctrine extensions for PHPStan](https://github.com/phpstan/phpstan-doctrine) | &#x2705; | &#x2705; | &#x2705; |
| phpstan-ergebnis-rules | [Additional rules for PHPstan](https://github.com/ergebnis/phpstan-rules) | &#x2705; | &#x2705; | &#x2705; |
| phpstan-exception-rules | [PHPStan rules for checked and unchecked exceptions](https://github.com/pepakriz/phpstan-exception-rules) | &#x2705; | &#x2705; | &#x2705; |
| phpstan-larastan | [Separate installation of phpstan for larastan](https://github.com/phpstan/phpstan) | &#x2705; | &#x2705; | &#x2705; |
| phpstan-phpunit | [PHPUnit extensions and rules for PHPStan](https://github.com/phpstan/phpstan-phpunit) | &#x2705; | &#x2705; | &#x2705; |
| phpstan-strict-rules | [Extra strict and opinionated rules for PHPStan](https://github.com/phpstan/phpstan-strict-rules) | &#x2705; | &#x2705; | &#x2705; |
| phpstan-symfony | [Symfony extension for PHPStan](https://github.com/phpstan/phpstan-symfony) | &#x2705; | &#x2705; | &#x2705; |
| phpstan-webmozart-assert | [PHPStan extension for webmozart/assert](https://github.com/phpstan/phpstan-webmozart-assert) | &#x2705; | &#x2705; | &#x2705; |
| phpunit | [The PHP testing framework](https://phpunit.de/) | &#x2705; | &#x2705; | &#x2705; |
| phpunit-5 | [The PHP testing framework (5.x version)](https://phpunit.de/) | &#x2705; | &#x2705; | &#x274C; |
| phpunit-7 | [The PHP testing framework (7.x version)](https://phpunit.de/) | &#x2705; | &#x2705; | &#x274C; |
| phpunit-8 | [The PHP testing framework (8.x version)](https://phpunit.de/) | &#x2705; | &#x2705; | &#x2705; |
| psalm | [Finds errors in PHP applications](https://psalm.dev/) | &#x2705; | &#x2705; | &#x2705; |
| psalm-plugin-doctrine | [Stubs to let Psalm understand Doctrine better](https://github.com/weirdan/doctrine-psalm-plugin) | &#x2705; | &#x2705; | &#x2705; |
| psalm-plugin-phpunit | [Psalm plugin for PHPUnit](https://github.com/psalm/psalm-plugin-phpunit) | &#x2705; | &#x2705; | &#x2705; |
| psalm-plugin-symfony | [Psalm Plugin for Symfony](https://github.com/psalm/psalm-plugin-symfony) | &#x2705; | &#x2705; | &#x2705; |
| psecio-parse | [Scans code for potential security-related issues](https://github.com/psecio/parse) | &#x2705; | &#x2705; | &#x2705; |
| rector | [Tool for instant code upgrades and refactoring](https://github.com/rectorphp/rector) | &#x2705; | &#x2705; | &#x2705; |
| roave-backward-compatibility-check | [Tool to compare two revisions of a class API to check for BC breaks](https://github.com/Roave/BackwardCompatibilityCheck) | &#x274C; | &#x2705; | &#x274C; |
| simple-phpunit | [Provides utilities to report legacy tests and usage of deprecated code](https://symfony.com/doc/current/components/phpunit_bridge.html) | &#x2705; | &#x2705; | &#x2705; |
| twig-lint | [Standalone twig linter](https://github.com/asm89/twig-lint) | &#x2705; | &#x2705; | &#x2705; |
| twigcs | [The missing checkstyle for twig!](https://github.com/friendsoftwig/twigcs) | &#x2705; | &#x2705; | &#x2705; |
| yaml-lint | [Compact command line utility for checking YAML file syntax](https://github.com/j13k/yaml-lint) | &#x2705; | &#x2705; | &#x2705; |

## More tools

Some tools are not included in the docker image, to use them refer to their documentation:

* exakat - [a real time PHP static analyser](https://www.exakat.io)

### Removed tools

| Name | Summary |
| :--- | :------ |
| composer-normalize | [Composer plugin to normalize composer.json files](https://github.com/localheinz/composer-normalize) |
| design-pattern | [Detects design patterns](https://github.com/Halleck45/DesignPatternDetector) |
| phpcf | [Finds usage of deprecated features](http://wapmorgan.github.io/PhpCodeFixer/) |
| phpstan-localheinz-rules | [Additional rules for PHPstan](https://github.com/localheinz/phpstan-rules) |
| security-checker | [Checks composer dependencies for known security vulnerabilities](https://github.com/sensiolabs/security-checker) |
| testability | [Analyses and reports testability issues of a php codebase](https://github.com/edsonmedina/php_testability) |

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
the project directory on the container with `-v "$(pwd):/project"`.
Some tools like to write to the `/tmp` directory (like PHPStan, or Behat in some cases), therefore it's often useful
to share it between docker runs, i.e. with `-v "$(pwd)/tmp-phpqa:/tmp"`.
If you want to be able to interrupt the selected tool if it takes too much time to complete, you can use the
`--init` option. Please refer to the [docker run documentation](https://docs.docker.com/engine/reference/commandline/run/) for more information.

```bash
docker run --init -it --rm -v "$(pwd):/project" -v "$(pwd)/tmp-phpqa:/tmp" -w /project jakzal/phpqa phpstan analyse src
```

You might want to tweak this command to your needs and create an alias for convenience:

```bash
alias phpqa='docker run --init -it --rm -v "$(pwd):/project" -v "$(pwd)/tmp-phpqa:/tmp" -w /project jakzal/phpqa:alpine'
```

Add it to your `~/.bashrc` so it's defined every time you start a new terminal session.

Now the command becomes a lot simpler:

```bash
phpqa phpstan analyse src
```

## GitHub actions

The image can be used with GitHub actions.
Below is an example for several static analysis tools.

```yaml
# .github/workflows/static-code-analysis.yml
name: Static code analysis

on: [pull_request]

jobs:
  static-code-analysis:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@master
      - name: PHPStan
        uses: docker://jakzal/phpqa:php8.0-alpine
        with:
          args: phpstan analyze src/ -l 1
      - name: PHP-CS-Fixer
        uses: docker://jakzal/phpqa:php8.0-alpine
        with:
          args: php-cs-fixer --dry-run --allow-risky=yes --no-interaction --ansi fix
      - name: Deptrac
        uses: docker://jakzal/phpqa:php8.0-alpine
        with:
          args: deptrac --no-interaction --ansi --formatter-graphviz-display=0
```

## Bitbucket Pipelines

Here is an example configuration of a bitbucket pipeline using the phpqa image:

```yaml
# bitbucket-pipelines.yml
image: jakzal/phpqa:php8.0-alpine
pipelines:
  default:
    - step:
        name: Static analysis
        caches:
          - composer
        script:
          - composer install --no-scripts --no-progress
          - phpstan analyze src/ -l 1
          - php-cs-fixer --dry-run --allow-risky=yes --no-interaction --ansi fix
          - deptrac --no-interaction --ansi --formatter-graphviz-display=0
```

Unfortunately, bitbucket overrides the docker entrypoint so composer needs to be
explicitly invoked as in the above example.

## Starter-kits / Templates

### [`ro0NL/php-package-starter-kit`](https://github.com/ro0NL/php-package-starter-kit)

A template repository for agnostic PHP libraries. It utilizes the PHPQA image into a `Makefile` and configures some
tools by default.

### [`ro0NL/symfony-docker`](https://github.com/ro0NL/symfony-docker)

A template repository for Docker based [Symfony](https://symfony.com) applications. It utilizes the PHPQA image into
a `Dockerfile` and integrates in the composed landscape.

## Building the image

```bash
git clone https://github.com/jakzal/phpqa.git
cd phpqa
make build-debian
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
docker run --init -it --rm -v "$(pwd):/project" -w /project foo/phpqa phpmetrics .
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

## Contributing

Please read the [Contributing guide](CONTRIBUTING.md) to learn about contributing to this project.
Please note that this project is released with a [Contributor Code of Conduct](CODE_OF_CONDUCT.md).
By participating in this project you agree to abide by its terms.
