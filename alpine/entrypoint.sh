#!/usr/bin/env sh
set -e

(test "$GITHUB_ACTIONS" = "true" || test "$CI" = "true") && test -f composer.json && composer install --no-scripts --no-progress

exec "$@"

