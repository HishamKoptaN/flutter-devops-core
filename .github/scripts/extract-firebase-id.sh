#!/bin/bash
# extract-firebase-id.sh - Extract Firebase App ID from firebase_options.dart
FLAVOR="${1:-dev}"
DART_FILE="lib/config/firebase/$FLAVOR/firebase_options.dart"
if [ ! -f "$DART_FILE" ]; then
    exit 1
fi
APP_ID=$(sed -n '/static const FirebaseOptions android/,/);/p' "$DART_FILE" | grep "appId:" | sed "s/.*'\([^']*\)'.*/\1/")
if [ -z "$APP_ID" ]; then
    exit 1
fi
echo "$APP_ID"
