#!/bin/bash
# bash .github/scripts/get-flutter-version.sh
set -e
FLUTTER_VER=$(awk '/environment:/,/dependencies:/' pubspec.yaml | awk '/flutter:/ {print $2}' | tr -cd '0-9.')
FINAL_VER="${FLUTTER_VER:-stable}"
if [ -n "$GITHUB_OUTPUT" ]; then
  echo "$FINAL_VER" >> "$GITHUB_OUTPUT"
fi

if [ -n "$GITHUB_ENV" ]; then
  echo "$FINAL_VER" >> "$GITHUB_ENV"
fi