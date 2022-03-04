#!/usr/bin/env sh
set -e

useradd -d /home/phpqa -u "$(id -u)" user || true
