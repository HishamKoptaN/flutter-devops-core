#!/bin/bash
set -e
LOCAL_VERSION=$(grep "version:" pubspec.yaml | awk '{print $2}' | tr -d '"' | tr -d "'")
echo "Local App Version in pubspec: $LOCAL_VERSION"
FLAVOR_ARG=""
if [ -n "$1" ]; then
  FLAVOR_ARG="--flavor=$1"
fi
LATEST_RELEASE=$(shorebird releases list $FLAVOR_ARG | grep -v "Release Version" | grep -E '^[0-9]' | head -n 1 | awk '{print $1}' || true)

echo "Latest Shorebird Release: $LATEST_RELEASE"
if [ "$LOCAL_VERSION" == "$LATEST_RELEASE" ]; then
  echo "Action required: PATCH (Local version matches Shorebird latest release)"
  BUILD_TYPE="patch"
else
  echo "Action required: RELEASE (Local version is new or different)"
  BUILD_TYPE="release"
fi
if [ -n "$GITHUB_OUTPUT" ]; then
  echo "build_type=$BUILD_TYPE" >> "$GITHUB_OUTPUT"
  echo "local_version=$LOCAL_VERSION" >> "$GITHUB_OUTPUT"
fi