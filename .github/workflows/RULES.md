# CI/CD Rules

## Rule: Shorebird is Mandatory for APK Builds

**Status:** REQUIRED  
**Applies to:** All Android APK artifact builds

### Description
All Android APK builds MUST use Shorebird. Direct `flutter build apk` commands are NOT allowed in this project.

### Why Shorebird is Required
- The project uses Shorebird for code push functionality
- Shorebird requires releases to be built through `shorebird release` command
- Using plain Flutter build bypasses Shorebird and breaks the update mechanism

### Correct Implementation
```yaml
# ✅ CORRECT - Uses Shorebird
- name: Build APK with Shorebird
  env:
    SHOREBIRD_TOKEN: ${{ secrets.SHOREBIRD_TOKEN }}
  run: |
    shorebird release android --flavor=${{ inputs.flavor }} --artifact=apk --dart-define=ENV=${{ inputs.flavor }} '--' --no-tree-shake-icons
```

### Forbidden Implementation
```yaml
# ❌ WRONG - Uses plain Flutter
- name: Build APK
  run: |
    flutter build apk --release --flavor=${{ inputs.flavor }}
```

### AAB Builds Exception
AAB builds MAY use plain Flutter as they are not distributed through Shorebird:
```yaml
# ✅ AAB can use Flutter directly
flutter build appbundle --release --flavor=${{ inputs.flavor }}
```

### Environment Requirements
- `SHOREBIRD_TOKEN` secret must be available
- Shorebird CLI must be installed via `shorebirdtech/setup-shorebird@v1`

### Files Affected
- `10-build-android-artifacts.yml` - APK build step

---

*Last updated: May 2026*
