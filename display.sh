#!/bin/bash

set -euo pipefail

ytt \
  --ignore-unknown-comments \
  --file ./ \
  --data-values-file values.yaml
