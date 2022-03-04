#!/usr/bin/env sh
set -e

adduser -u "$(id -u)" -h /home/phpqa phpqa || true
