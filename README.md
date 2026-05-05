# 🧠 Flutter DevOps Core

A production-grade **Layered DevOps Framework** for Flutter applications with multi-platform support, automated CI/CD, and zero-duplication architecture.

---

## 🎯 Overview

This framework provides a **scalable, reusable, and maintainable** DevOps pipeline structure for Flutter projects. Built on **layered architecture principles** to eliminate duplication and ensure clean separation of concerns.

### ✨ Key Features

- 🚀 **Zero Build Duplication** - Each artifact built once, reused everywhere
- 🧩 **Layered Architecture** - Clear separation of responsibilities
- 🔁 **100% Reusable Workflows** - Composable pipeline components
- 🌍 **Multi-Platform Support** - Android, iOS, Windows, macOS, Web
- ⚡ **Shorebird Integration** - Modern OTA updates
- 📦 **Automated Distribution** - Firebase, GitHub Releases, Stores
- 🎛️ **Environment Management** - Dev/Prod configurations

---

## 🏗️ Architecture Overview

```
Core Layer
   ↓
Deploy Layer (Shorebird)
   ↓
Build Layer (fallback)
   ↓
Packaging Layer
   ↓
Distribution Layer
```

---

## 🔵 1. Core Layer (Foundation)

**Purpose**: Orchestration and pipeline coordination

**Responsibilities**:
- Platform detection (android/ios/windows/...)
- Version management
- Variable passing (flavor/env)
- Pipeline orchestration

**Files**: `00-core-*.yml`, `00-setup.yml`

**Outputs**: `platforms_available`, `version`, `flavor`

---

## 🟣 2. Deploy Layer (Shorebird)

**Purpose**: Build + deploy via Shorebird OTA system

**Responsibilities**:
- Execute `shorebird release` / `shorebird patch`
- Release vs Patch detection
- Artifact generation (AAB/APK/binaries)

**Files**: `20-shorebird-*.yml`, `10-deploy-shorebird-android.yml`


---

## 🟢 3. Build Layer

**Purpose**: Build platforms not covered by Shorebird

**Responsibilities**:
- Build iOS/macOS/Web/Windows
- Fallback when Shorebird not used
- Artifact generation

**Files**: `31-build-layer.yml`, `10-build-*.yml`, `20-build-android.yml`

**Outputs**: `.app/.exe/web build/APK`

---

## 🟡 4. Packaging Layer

**Purpose**: Convert builds to distributable packages

**Responsibilities**:
- Installer creation (Windows)
- Distribution preparation
- Metadata updates (version/name/publisher)

**Files**: `20-prepare-installer.yml`, `30-build-installer.yml`, `30-package-windows.yml`

**Outputs**: `installer.exe`, ready for distribution

---

## 🔴 5. Distribution Layer

**Purpose**: Deploy applications to users/stores

**Responsibilities**:
- Firebase App Distribution
- GitHub Releases
- Windows installer upload
- APK/EXE distribution

**Files**: `32-distribution-layer.yml`, `30-deploy-*.yml`, `40-distribute-*.yml`

**Outputs**: Deployed application to users

---

## ⚪ 6. Environment Layer

**Purpose**: Environment management (dev/prod)

**Responsibilities**:
- Environment detection
- Config passing to workflows
- Environment-specific behavior

**Files**: `50-env-*.yml`

**Outputs**: `ENV = dev/prod`

---

## 🌐 7. Special/Web Pipelines

**Purpose**: Standalone or special flows

**Files**: `build-deploy-web.yml`

---

## ⚠️ Golden Rule

### ❌ Wrong:
```txt
Build Android 3 times
```

### ✅ Right:
```txt
Shorebird = Single source of truth
↓
Reuse artifacts
↓
Distribution
```

---

## 🛠️ Development Setup

### Prerequisites
- Flutter SDK
- GitHub repository
- Shorebird CLI (for OTA updates)
- Firebase project (for app distribution)

### VS Code Configuration
The project includes optimized **file nesting patterns** for clean workflow organization:

```json
"explorer.fileNesting.enabled": true,
"explorer.fileNesting.patterns": {
  // 🔵 CORE LAYER
  "00-core-main.yml": "00-core-*.yml,00-setup.yml",
  // 🟣 DEPLOY LAYER (SHOREBIRD)
  "20-shorebird.yml": "20-shorebird-*.yml,10-deploy-shorebird-android.yml",
  // 🟢 BUILD LAYER
  "31-build-layer.yml": "10-build-*.yml,20-build-*.yml",
  // 🟡 PACKAGING LAYER
  "30-build-installer.yml": "20-prepare-installer.yml,30-package-*.yml",
  // 🔴 DISTRIBUTION LAYER
  "32-distribution-layer.yml": "30-deploy-*.yml,30-upload-*.yml,40-distribute-*.yml",
  // ⚪ ENVIRONMENT LAYER
  "50-env-dev.yml": "50-env-*.yml"
}
```

---

## 🚀 Usage

### 1. Fork/Clone
```bash
git clone https://github.com/YOUR_USERNAME/flutter_devops_core.git
cd flutter_devops_core
```

### 2. Configure
- Update Firebase configuration
- Set up Shorebird keys
- Configure environment variables

### 3. Customize
- Modify app metadata in workflows
- Adjust platform support as needed
- Update environment configurations

---

## 📊 Benefits

- 🚀 **No Duplication** - Each artifact built once
- 🧩 **Modular** - Each layer independent
- 🔁 **Reusable** - 100% composable workflows
- ⚡ **Scalable** - Works for any Flutter project
- 🧠 **Framework-Ready** - Can be adapted for any organization

---

## 🤝 Contributing

This framework is designed to be **community-driven**. Contributions welcome for:

- New platform support
- Optimization improvements
- Documentation enhancements
- Use case examples

---

## 📄 License

MIT License - Feel free to use this framework in your projects!

---

## 🔗 Related Resources

- [Shorebird Documentation](https://shorebird.dev)
- [Flutter CI/CD Best Practices](https://docs.flutter.dev/deployment/cd)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)

---

**Built with ❤️ for the Flutter DevOps community**
