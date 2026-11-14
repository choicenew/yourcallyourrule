# How to Work with Material and Cupertino Decoupling in Flutter [Full Handbook]

> **Source**: freeCodeCamp.org  
> **Author**: Atuoha Anthony  
> **Published**: August 18, 2026  
> **Topic**: Flutter 3.47+ Standalone `material_ui` and `cupertino_ui` Packages Migration

---

## Executive Summary

Flutter 3.47 (released August 12, 2026) officially decouples the Material and Cupertino design system widget libraries from the core Flutter SDK into standalone packages on pub.dev: `material_ui` and `cupertino_ui`.

* **Packages**: `material_ui` (v1.0.0+) and `cupertino_ui` (v1.0.0+).
* **Automated Fix**: `dart fix --apply --code=migrate_design_widgets`
* **Compatibility Bridge**: `MaterialUiCompatibilityBridge` for legacy dependencies.
* **Deprecation Schedule**:
  * **August 2026 (Flutter 3.47)**: Standalone packages v1.0 released. Legacy imports work without warnings.
  * **November 2026 (Flutter Fall Stable)**: Legacy `package:flutter/material.dart` and `package:flutter/cupertino.dart` imports formally deprecated (analyzer warnings).
  * **2027 Stable Release**: Legacy bundled imports completely removed from core Flutter SDK.

---

## Table of Contents

1. [Architectural Overview: Why Decouple?](#1-architectural-overview-why-decouple)
2. [Setting Up: Adding the Standalone Packages](#2-setting-up-adding-the-standalone-packages)
3. [Automated Migration Guide](#3-automated-migration-guide)
4. [Manual Migration & Special Edge Cases](#4-manual-migration--special-edge-cases)
5. [The `MaterialUiCompatibilityBridge`](#5-the-materialuicompatibilitybridge)
6. [Localizations Changes & Simplification](#6-localizations-changes--simplification)
7. [Side-by-Side Code Comparisons](#7-side-by-side-code-comparisons)
8. [Package Authors Migration Strategy](#8-package-authors-migration-strategy)
9. [Other Notable Changes in Flutter 3.47](#9-other-notable-changes-in-flutter-347)
10. [Deprecation Timeline & Best Practices](#10-deprecation-timeline--best-practices)

---

## 1. Architectural Overview: Why Decouple?

### Old Architecture (Pre-Flutter 3.47)
Previously, Material and Cupertino widgets were bundled inside `package:flutter/material.dart` and `package:flutter/cupertino.dart` within the core Flutter SDK.

* **Drawbacks**:
  * Any Material/Cupertino bug fix or feature update required a full SDK release.
  * Custom design system apps still carried bundled Material/Cupertino overhead.
  * High bar for core SDK contributions slowed down widget iteration.

### New Architecture (Flutter 3.47+)
The core Flutter SDK now contains only rendering, painting, base widgets, foundation, and platform services. `material_ui` and `cupertino_ui` are independent pub.dev packages.

* **Benefits**:
  * Weekly patch and minor releases for design components.
  * Reduced bloat for custom design systems.
  * Independent versioning and faster community iteration.

---

## 2. Setting Up: Adding the Standalone Packages

To add both packages to `pubspec.yaml`:

```bash
flutter pub add material_ui cupertino_ui
```

Your `pubspec.yaml` dependencies block:

```yaml
dependencies:
  flutter:
    sdk: flutter
  material_ui: ^1.0.0
  cupertino_ui: ^1.0.0
```

---

## 3. Automated Migration Guide

### Step 1: Run the Automated Migration Tool
```bash
dart fix --apply --code=migrate_design_widgets
```

### Step 2: Handle Known `pubspec.yaml` Resolution Edge Case
If `pubspec.yaml` was not automatically modified by `dart fix`:

```bash
flutter pub add material_ui cupertino_ui
dart fix --apply
```

### Step 3: Analyze and Verify
```bash
flutter analyze
```

---

## 4. Manual Migration & Special Edge Cases

### Core Engine Imports vs. Design Systems
Imports for core engine subsystems do **not** move:

```dart
// Updated Design System Imports
import 'package:material_ui/material_ui.dart';
import 'package:cupertino_ui/cupertino_ui.dart';

// Unchanged Core Framework Imports
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/gestures.dart';
```

### Conditional Imports
Manually update both branches of conditional imports:

```dart
// Updated Conditional Export
export 'package:material_ui/material_ui.dart'
    if (dart.library.html) 'package:material_ui/material_ui.dart';
```

### Code Generation (`build_runner`)
After migrating imports in source `.dart` files, clean and rebuild generated code:

```bash
dart run build_runner build --delete-conflicting-outputs
```

---

## 5. The `MaterialUiCompatibilityBridge`

When third-party dependencies still import `package:flutter/material.dart`, wrap your app's root with `MaterialUiCompatibilityBridge`:

```dart
import 'package:material_ui/material_ui.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF6750A4)),
      ),
      builder: (BuildContext context, Widget? child) {
        return MaterialUiCompatibilityBridge(child: child!);
      },
      home: const HomeScreen(),
    );
  }
}
```

* Remove `MaterialUiCompatibilityBridge` once all package dependencies adopt `material_ui`.

---

## 6. Localizations Changes & Simplification

`GlobalMaterialLocalizations.delegates` now automatically bundles Material, Cupertino, and Base Widgets delegates:

```dart
import 'package:material_ui/material_ui.dart';

MaterialApp(
  localizationsDelegates: const [
    AppLocalizations.delegate,
    ...GlobalMaterialLocalizations.delegates,
    AlmanacLocalizationsDelegate(),
  ],
  supportedLocales: AppLocalizations.supportedLocales,
  home: const HomeScreen(),
)
```

> Note: `flutter_localizations` in `pubspec.yaml` can be removed for standard `material_ui` apps.

### Critical Edge Case: Async `LocalizationsDelegate` & `dart fix` Limitations

1. **Why `dart fix` Cannot Fix `AppLocalizations.localizationsDelegates`**:
   `dart fix --apply --code=migrate_design_widgets` only updates handwritten source files (`import 'package:flutter/material.dart'`).
   It **does not** patch generated files (`l10n/generated/app_localizations.dart`), nor does it alter `AppLocalizations.localizationsDelegates` references.
   In generated files, `AppLocalizations.localizationsDelegates` still contains SDK-native delegates. Under `material_ui`, referencing `...AppLocalizations.localizationsDelegates` directly creates a scope mismatch.

2. **The Async Delegate Race Condition on Dynamic Locale Change**:
   If custom delegates (such as `AlmanacLocalizationsDelegate`) execute asynchronous asset loading during `load(Locale locale)` (e.g. `await rootBundle.loadString(...)`), dynamic language switches cause `Localizations` to rebuild asynchronously.
   If a child widget calls `AppLocalizations.of(context)` during this async loading window, `Localizations.of<AppLocalizations>(context)` returns `null`.
   Since auto-generated `AppLocalizations.of(context)` executes `Localizations.of<AppLocalizations>(context, AppLocalizations)!` (forced non-null assertion `!`), a `Null check operator used on a null value` error is thrown, causing Flutter release builds to render a grey `ErrorWidget` container.

3. **Recommended Fix Pattern**:
   Do not use `...AppLocalizations.localizationsDelegates` directly. Pass `AppLocalizations.delegate` individually alongside `...GlobalMaterialLocalizations.delegates` from `material_ui`.

---

## 7. Side-by-Side Code Comparisons

### Basic App Setup

#### Before
```dart
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      home: const HomeScreen(),
    );
  }
}
```

#### After
```dart
import 'package:material_ui/material_ui.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      home: const HomeScreen(),
    );
  }
}
```

---

## 8. Package Authors Migration Strategy

Package authors MUST bump major version (e.g., `1.x.x` -> `2.0.0`) when declaring explicit dependencies on `material_ui`:

```yaml
name: my_flutter_package
version: 2.0.0

dependencies:
  flutter:
    sdk: flutter
  material_ui: ^1.0.0
```

---

## 9. Other Notable Changes in Flutter 3.47

1. **Impeller Default on Desktop**: Impeller rendering engine enabled by default on macOS, Windows, and Linux.
2. **Raised Minimum OS Requirements**:
   * iOS minimum: 15.0
   * macOS minimum: 12.0 (Monterey)
3. **iOS UIScene Mandate**: Apps built with Xcode 27 require UIScene lifecycle.
4. **Widget Previews Stable**: `.widget_preview/` root caching directory.
5. **Wasm Optimization**: Improved WebAssembly compilation (`flutter build web --release --wasm`).

---

## 10. Deprecation Timeline & Best Practices

| Milestone | Date | Status |
| :--- | :--- | :--- |
| **Flutter 3.47** | August 2026 | `material_ui` 1.0 released. Both old and new imports compile cleanly. |
| **Fall Stable** | November 2026 | Legacy `package:flutter/material.dart` formally deprecated (analyzer warnings). |
| **Future Release** | 2027 | Legacy imports removed from Flutter SDK. |

### Common Pitfalls to Avoid
1. Do not mix `package:flutter/material.dart` and `package:material_ui/material_ui.dart` in the same file.
2. Remember to include `MaterialUiCompatibilityBridge` if third-party packages throw theme/localization errors.
3. Ensure exact version pinning in CI pipelines for predictable builds.
