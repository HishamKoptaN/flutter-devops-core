#!/bin/bash
set -e

# الانتقال إلى مجلد ios
cd "$(dirname "$0")"

echo "=== تنظيف وبناء أرشيف Xcode ==="
xcodebuild -workspace Runner.xcworkspace \
           -scheme Runner \
           -configuration Release \
           -sdk iphoneos \
           -archivePath "$PWD/build/Runner.xcarchive" \
           clean archive

echo "=== تصدير ملف IPA ==="
xcodebuild -exportArchive \
           -archivePath "$PWD/build/Runner.xcarchive" \
           -exportOptionsPlist ExportOptions.plist \
           -exportPath "$PWD/build/output"

echo "=== رفع التطبيق إلى TestFlight باستخدام xcrun altool ==="
xcrun altool --upload-app \
             --type ios \
             --file "build/output/Runner.ipa" \
             --apiKey "${APP_STORE_CONNECT_API_KEY_ID}" \
             --apiIssuer "${APP_STORE_CONNECT_ISSUER_ID}"

echo "=== تم رفع التطبيق بنجاح دون الحاجة لـ Fastlane أو Ruby! ==="
