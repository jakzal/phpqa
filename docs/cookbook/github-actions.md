# GitHub actions

*Contributed by [jakzal](https://github.com/jakzal).*

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
        uses: docker://jakzal/phpqa:php8.2-alpine
        with:
          args: phpstan analyze src/ -l 1
      - name: PHP-CS-Fixer
        uses: docker://jakzal/phpqa:php8.2-alpine
        with:
          args: php-cs-fixer --dry-run --allow-risky=yes --no-interaction --ansi fix
      - name: Deptrac
        uses: docker://jakzal/phpqa:php8.2-alpine
        with:
          args: deptrac --no-interaction --ansi --formatter-graphviz-display=0
```
