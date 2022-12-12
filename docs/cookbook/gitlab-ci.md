# Gitlab CI

*Contributed by [RVxLab](https://github.com/RVxLab).*

The example below demonstrates how phpqa can be used in the Gitlab CI.

```yaml
# .gitlab-ci.yml
image: php:8.2-fpm-alpine3.15

stages:
    - style

php-cs-fixer:
    stage: style
    image: jakzal/phpqa:php8.2-alpine
    script:
        - php-cs-fixer fix --dry-run --stop-on-violation

phpstan:
    stage: style
    image: jakzal/phpqa:php8.2-alpine
    script:
      - phpstan analyze
```

