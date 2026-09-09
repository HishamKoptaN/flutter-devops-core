#!/bin/bash
set -e
# bash .github/scripts/check-build-type.sh android prod
PLATFORM="${1:-android}"
FLAVOR="${2:-prod}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if [ -f "$SCRIPT_DIR/get-flutter-version.sh" ]; then
  source "$SCRIPT_DIR/get-flutter-version.sh"
fi
LOCAL_FLUTTER="${FINAL_VER:-$FLUTTER_VER}"
LOCAL_APP_VER=$(grep -i 'version:' pubspec.yaml | head -n 1 | awk -F':' '{print $2}' | tr -d ' "' | tr -d "'" | tr -d '\r')
FLAVOR_ARG=""
if [ -n "$FLAVOR" ]; then
  FLAVOR_ARG="--flavor=$FLAVOR"
fi
LATEST_LINE=$(shorebird releases list $FLAVOR_ARG | grep -i "${PLATFORM}:" | head -n 1 || true)
REMOTE_APP_VER=$(echo "$LATEST_LINE" | awk '{print $2}')
REMOTE_FLUTTER_VER=$(echo "$LATEST_LINE" | awk '{print $NF}')
if [ -n "$REMOTE_APP_VER" ] && [ "$LOCAL_APP_VER" == "$REMOTE_APP_VER" ] && [ "$LOCAL_FLUTTER" == "$REMOTE_FLUTTER_VER" ]; then
  echo "Action required: PATCH (App version & Flutter version match the latest $PLATFORM release)"
  BUILD_TYPE="patch"
else
  echo "Action required: RELEASE (Mismatch detected in App Version or Flutter Version for $PLATFORM)"
  BUILD_TYPE="release"
fi
if [ -n "$GITHUB_OUTPUT" ]; then
  echo "build_type=$BUILD_TYPE" >> "$GITHUB_OUTPUT"
  echo "local_version=$LOCAL_APP_VER" >> "$GITHUB_OUTPUT"
  echo "local_flutter=$LOCAL_FLUTTER" >> "$GITHUB_OUTPUT"
fi