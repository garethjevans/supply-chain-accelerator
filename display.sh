#!/bin/bash

set -euo pipefail

ytt --ignore-unknown-comments --file ./config 
