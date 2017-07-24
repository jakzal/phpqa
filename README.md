# Static Analysis Tools for PHP

Docker image providing static analysis tools for PHP.

[![Build Status](https://travis-ci.org/jakzal/phpqa.svg?branch=master)](https://travis-ci.org/jakzal/phpqa)

## Available tools

* composer - [Dependency Manager for PHP](https://getcomposer.org/)
* box - [An application for building and managing Phars](https://box-project.github.io/box2/)
* php-cs-fixer - [PHP Coding Standards Fixer](http://cs.sensiolabs.org/)
* phpcf - [Finds usage of deprecated features](http://wapmorgan.github.io/PhpCodeFixer/)
* phpca - [Finds usage of non-built-in extensions](https://github.com/wapmorgan/PhpCodeAnalyzer)
* phpdoc-to-typehint - [Automatically adds type hints and return types based on PHPDocs](https://github.com/dunglas/phpdoc-to-typehint)
* php-formatter - [Custom coding standards fixer](https://github.com/mmoreram/php-formatter)
* phpmetrics - [Static Analysis Tool](http://www.phpmetrics.org/)
* phpstan - [Static Analysis Tool](https://github.com/phpstan/phpstan)
* phan - [Static Analysis Tool](https://github.com/etsy/phan)
* dephpend - [Detect flaws in your architecture](https://dephpend.com/)
* psalm - [Finds errors in PHP applications](https://getpsalm.org/)
* phpDocumentor - [Documentation generator](https://www.phpdoc.org/)
* phpcpd - [Copy/Paste Detector](https://github.com/sebastianbergmann/phpcpd)
* phploc - [A tool for quickly measuring the size of a PHP project](https://github.com/sebastianbergmann/phploc)
* phpmd - [A tool for finding problems in PHP code](https://phpmd.org/)
* phpmnd - [Helps to detect magic numbers](https://github.com/povils/phpmnd)
* pdepend - [Static Analysis Tool](https://pdepend.org/)
* phpcs - [Detects coding standard violations](https://github.com/squizlabs/PHP_CodeSniffer)
* phpcbf - [Automatically corrects coding standard violations](https://github.com/squizlabs/PHP_CodeSniffer)
* phpcb - [PHP Code Browser](https://github.com/mayflower/PHP_CodeBrowser)
* phpa - [Checks for weak assumptions](https://github.com/rskuipers/php-assumptions)
* deprecation-detector - [Finds usages of deprecated code](https://github.com/sensiolabs-de/deprecation-detector)
* deptrac - [Enforces dependency rules](https://github.com/sensiolabs-de/deptrac)
* phpda - [Generates dependency graphs](https://mamuz.github.io/PhpDependencyAnalysis/)
* php-coupling-detector - [Detects code coupling issues](https://akeneo.github.io/php-coupling-detector/)
* analyze - [Visualizes metrics and source code](https://github.com/Qafoo/QualityAnalyzer)
* design-pattern - [Dettects design patterns](https://github.com/Halleck45/DesignPatternDetector)
* parallel-lint - [Checks PHP file syntax](https://github.com/JakubOnderka/PHP-Parallel-Lint)
* php-semver-checker - [Suggests a next version according to semantic versioning ](https://github.com/tomzx/php-semver-checker)

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

## Building the image

```bash
git clone https://github.com/jakzal/phpqa.git
cd phpqa
make build
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

## Contributing

Please read the [Contributing guide](CONTRIBUTING.md) to learn about contributing to this project.
Please note that this project is released with a [Contributor Code of Conduct](CODE_OF_CONDUCT.md).
By participating in this project you agree to abide by its terms.
