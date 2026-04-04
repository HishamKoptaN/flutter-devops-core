#!/bin/bash
# extract-firebase-id.sh - Extract Firebase App ID from Dart config files

FLAVOR="${1:-dev}"
DART_FILE="lib/config/firebase/$FLAVOR/firebase_options.dart"

if [ ! -f "$DART_FILE" ]; then
    echo "⚠️ Dart config file not found: $DART_FILE" >&2
    exit 1
fi

# Extract Android appId from commented code
APP_ID=$(grep -oE "//\s*appId:\s*'[^']+'" "$DART_FILE" | grep "android:" | head -1 | sed "s/.*'\([^']*\)'.*/\1/")

if [ -z "$APP_ID" ]; then
    echo "❌ Could not find Android appId in $DART_FILE" >&2
    exit 1
fi

echo "$APP_ID"
