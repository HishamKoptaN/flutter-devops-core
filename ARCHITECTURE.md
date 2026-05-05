# 🧠 Flutter DevOps Architecture (3-Layer System)

## 🎯 Overview

Production-grade **Layered DevOps Engine** built on lifecycle principles with smart decision-making and zero duplication.

---

## 🟦 Layer 1: Setup Layer (Initialization)

**Purpose**: Prepare environment and gather context

**Responsibilities**:
- Environment detection (dev/prod)
- Version management
- Platform discovery
- Dependencies setup
- Shorebird/Flutter initialization

**Files**:
```yaml
00-core-main.yml          # Main orchestrator
00-core-check-platforms.yml # Platform detection
00-core-get-version.yml   # Version extraction
00-setup.yml             # Core setup
50-env-dev.yml           # Dev environment
50-env-prod.yml          # Prod environment
```

**Outputs**:
```txt
env, version, platforms_available
```

---

## 🟨 Layer 2: Decision + Build Layer (Smart Execution)

**Purpose**: Intelligent build vs patch decisions

**Core Logic**:
```bash
# Smart Decision Engine
if (release_exists && native_changes_unpatchable) {
  use_release = true
} else if (release_exists) {
  use_patch = true
} else {
  use_release = true  # First time
}
```

**Responsibilities**:
- Release vs Patch detection
- Artifact generation
- Build optimization
- Platform-specific builds

**Files**:
```yaml
20-shorebird.yml              # Main decision engine
20-shorebird-android.yml       # Android patch/release
20-shorebird-android-core.yml  # Android core logic
20-shorebird-ios.yml           # iOS patch/release
20-shorebird-linux.yml         # Linux release only
20-shorebird-macos.yml          # macOS patch/release
20-shorebird-windows.yml        # Windows patch/release

10-deploy-shorebird-android.yml # Android deployment

31-build-layer.yml             # Fallback builds
10-build-ios.yml               # iOS builds
10-build-macos.yml             # macOS builds
10-build-web.yml               # Web builds
10-build-windows-exe.yml       # Windows builds
20-build-android.yml            # Android builds
10-build-firebase-apk.yml      # Firebase APK builds
```

**Outputs**:
```txt
artifacts (apk/aab/exe/app), version_changed, release_version
```

---

## 🟥 Layer 3: Distribution Layer (Smart Distribution)

**Purpose**: Distribute only what was built

**Core Principle**:
```yaml
# Smart Distribution
android:
  if: needs.build.outputs.android_built == 'true'
  uses: 40-distribute-android.yml

windows:
  if: needs.build.outputs.windows_built == 'true'  
  uses: 40-distribute-windows.yml
```

**Responsibilities**:
- Firebase App Distribution
- GitHub Releases
- Installer distribution
- Platform-specific deployment

**Files**:
```yaml
32-distribution-layer.yml      # Main distributor

30-shorebird-layer.yml           # Deploy orchestrator
30-deploy-check.yml           # Platform detection
30-deploy-android.yml        # Android deploy
30-deploy-ios.yml            # iOS deploy
30-deploy-linux.yml          # Linux deploy
30-deploy-macos.yml          # macOS deploy
30-deploy-windows.yml        # Windows deploy

30-deploy-installer.yml        # Installer deploy
30-deploy-release.yml         # Release deploy
30-upload-windows-release.yml  # Windows upload

40-distribute-android.yml       # Android distribution
40-distribute-windows.yml       # Windows distribution
```

**Outputs**:
```txt
apps distributed, releases published
```

---

## 🟪 Optional Layer 4: Packaging Layer

**Purpose**: Convert builds to distributable packages

**Files**:
```yaml
20-prepare-installer.yml  # Installer prep
30-build-installer.yml    # Installer build
30-package-windows.yml    # Windows packaging
```

---

## 🔥 Pipeline Flow

```txt
🟦 Setup Layer
   ↓ (env, version, platforms)
🟨 Decision + Build Layer
   ↓ (artifacts, build_status)
🟥 Distribution Layer
   ↓ (distributed apps)
```

---

## ⚠️ Golden Rule

### ❌ Wrong:
```txt
Build Android 3 times
Duplicate artifacts
Inefficient resource usage
```

### ✅ Right:
```txt
Build once → Reuse artifacts → Smart distribution
Zero duplication
Optimized resource usage
```

---

## 💡 Smart Behavior Examples

### Decision Layer Output:
```txt
android_built=true
ios_built=false
windows_built=true
version_changed=true
```

### Distribution Layer Logic:
```yaml
android:
  if: needs.build.outputs.android_built == 'true'
  # Deploy to Firebase + GitHub

ios:
  if: needs.build.outputs.ios_built == 'false'
  # Skip deployment

windows:
  if: needs.build.outputs.windows_built == 'true'
  # Deploy installer to GitHub
```

---

## 🎯 VS Code File Nesting

```json
{
  "explorer.fileNesting.patterns": {
    // 🟦 SETUP LAYER
    "00-core-main.yml": "00-core-*.yml,00-setup.yml,50-env-*.yml",
    
    // 🟨 DECISION + BUILD LAYER
    "20-shorebird.yml": "20-shorebird-*.yml,10-deploy-shorebird-android.yml,31-build-layer.yml,10-build-*.yml,20-build-*.yml",
    
    // 🟥 DISTRIBUTION LAYER
    "32-distribution-layer.yml": "30-deploy-*.yml,40-distribute-*.yml,30-upload-*.yml",
    
    // 🟪 PACKAGING LAYER
    "30-build-installer.yml": "20-prepare-installer.yml,30-package-*.yml",
    
    // 🌐 WEB PIPELINE
    "build-deploy-web.yml": "build-deploy-web.yml"
  }
}
```

---

## 🚀 Benefits

- 🧠 **Smart Decision Making**: Automatic patch vs release
- 🔄 **Zero Duplication**: Each artifact built once
- 📦 **Modular Design**: Each layer independent
- ⚡ **Optimized Performance**: Efficient resource usage
- 🎯 **Scalable**: Works for any Flutter project
- 🔧 **Maintainable**: Clean separation of concerns

---

## 💎 Conclusion

This is not just a collection of workflows...
This is a **DevOps Engine** that:

1. **Thinks** - Makes intelligent decisions
2. **Optimizes** - Eliminates duplication
3. **Scales** - Works for any project size
4. **Maintains** - Clean, organized codebase

**Built for production, designed for excellence.** 🏆
