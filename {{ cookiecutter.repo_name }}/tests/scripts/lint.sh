#!/usr/bin/env bash

set -e
set -x

pyright
ruff check src
ruff format src --check
