#!/bin/bash
set -e
RAW_VER=$(grep -A 5 "environment:" pubspec.yaml | grep "flutter:" || true)
FLUTTER_VER=$(echo "$RAW_VER" | sed -E 's/.*flutter:[[:space:]]*"?\'?//; s/["'\''^>=].*//' | tr -d '[:space:]')

# في حال عدم العثور على إصدار نستخدم stable
FINAL_VER="${FLUTTER_VER:-stable}"

echo "Extracted Flutter Version: $FINAL_VER"

# حفظ النتيجة في GITHUB_OUTPUT و GITHUB_ENV للتوافقيّة
if [ -n "$GITHUB_OUTPUT" ]; then
  echo "version=$FINAL_VER" >> "$GITHUB_OUTPUT"
fi

if [ -n "$GITHUB_ENV" ]; then
  echo "FLUTTER_VERSION=$FINAL_VER" >> "$GITHUB_ENV"
fi