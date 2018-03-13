# Static Analysis Tools for PHP

Docker image providing static analysis tools for PHP.

[![Build Status](https://travis-ci.org/jakzal/phpqa.svg?branch=master)](https://travis-ci.org/jakzal/phpqa)

## Available tools

* composer - [Dependency Manager for PHP](https://getcomposer.org/)
* box - [An application for building and managing Phars](https://box-project.github.io/box2/)
* analyze - [Visualizes metrics and source code](https://github.com/Qafoo/QualityAnalyzer)
* churn - [Discovers good candidates for refactoring](https://github.com/bmitch/churn-php)
* dephpend - [Detect flaws in your architecture](https://dephpend.com/)
* deprecation-detector - [Finds usages of deprecated code](https://github.com/sensiolabs-de/deprecation-detector)
* deptrac - [Enforces dependency rules](https://github.com/sensiolabs-de/deptrac)
* design-pattern - [Detects design patterns](https://github.com/Halleck45/DesignPatternDetector)
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
* phploc - [A tool for quickly measuring the size of a PHP project](https://github.com/sebastianbergmann/phploc)
* phpmd - [A tool for finding problems in PHP code](https://phpmd.org/)
* phpmetrics - [Static Analysis Tool](http://www.phpmetrics.org/)
* phpmnd - [Helps to detect magic numbers](https://github.com/povils/phpmnd)
* phpstan - [Static Analysis Tool](https://github.com/phpstan/phpstan)
* psalm - [Finds errors in PHP applications](https://getpsalm.org/)
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
the project directory on the container:

```bash
docker run -it --rm -v $(pwd):/project -w /project jakzal/phpqa phpstan analyse src
```

You'll probably want to tweak this command for your needs and create an alias for convenience:

```bash
alias phpqa="docker run -it --rm -v $(pwd):/project -w /project jakzal/phpqa:alpine"
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
docker run -it --rm -v $(pwd):/project -w /project foo/phpqa phpmetrics .
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
