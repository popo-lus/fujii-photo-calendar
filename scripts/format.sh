#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/../app"
if command -v fvm >/dev/null 2>&1; then
  fvm dart format lib test
  fvm flutter analyze
else
  dart format lib test
  flutter analyze
fi
