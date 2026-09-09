#!/bin/bash
set -e
FLUTTER_VER=$(awk '/environment:/,/dependencies:/' pubspec.yaml | awk '/flutter:/ {print $2}' | tr -cd '0-9.')
FINAL_VER="${FLUTTER_VER:-stable}"
echo "Extracted Flutter Version: $FINAL_VER"
if [ -n "$GITHUB_OUTPUT" ]; then
  echo "version=$FINAL_VER" >> "$GITHUB_OUTPUT"
fi

if [ -n "$GITHUB_ENV" ]; then
  echo "FLUTTER_VERSION=$FINAL_VER" >> "$GITHUB_ENV"
fi