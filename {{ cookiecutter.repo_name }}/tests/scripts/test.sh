#!/usr/bin/env bash

set -e
set -x

coverage run --source=src -m pytest -s
coverage report --show-missing
coverage html --title "${@-coverage}"
