#!/usr/bin/env sh
set -e

[[ "$GITHUB_ACTIONS" == "true" && -f composer.json ]] && composer install --no-scripts --no-progress

exec "$@"

