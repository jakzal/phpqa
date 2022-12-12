# Bitbucket Pipelines

*Contributed by [jakzal](https://github.com/jakzal).*

Here is an example configuration of a bitbucket pipeline using the phpqa image:

```yaml
# bitbucket-pipelines.yml
image: jakzal/phpqa:php8.2-alpine
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
