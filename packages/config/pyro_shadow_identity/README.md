# Shadow Identity Package

A high-performance, pure Dart package for managing local multi-account systems, often referred to as "Shadow Identities". This package is designed to be easily integrated into any app (Flutter, Server-side, CLI) that requires switching between multiple user contexts with local-first persistence.

## Features

- **Multi-Account Support**: Easily create, switch, and delete multiple identities.
- **Shadow Identity System**: Dedicated local identity management with unique IDs.
- **Persistence Abstracted**: Define your own storage (SharedPreferences, Isar, Hive, etc.) via interfaces.
- **Future-Ready Sync**: Reserved interfaces for cloud synchronization and conflict resolution.
- **Pure Dart**: Zero Flutter dependencies for maximum portability.

## Technical Architecture

### 1. ShadowIdentity Model
The core data structure representing a user's local "shadow".
- `id`: Short unique identifier (e.g., `8F3A2B1C`).
- `name`: Human-readable nickname.
- `metadata`: Flexible key-value store for profile data (gender, settings, etc.).
- `timestamps`: Track creation and last access for aging logic.

### 2. ShadowIdentityManager
The controller class that manages memory state and triggers persistence.
- Handles logic for the "Default Identity" creation.
- Provides a `Stream` for UI updates on any change.
- Orchestrates switching contexts.

### 3. Interfaces
- `IShadowStorage`: Mandatory interface for local persistence.
- `IShadowSyncAdapter`: Optional interface for cloud integration.

## Usage

### 1. Implementation Storage Interface
```dart
class MyStorage implements IShadowStorage {
  // Use SharedPreferences or any DB here
}
```

### 2. Initialize Manager
```dart
final manager = ShadowIdentityManager(
  storage: MyStorage(),
);
await manager.initialize();
```

### 3. Switch Identity
```dart
await manager.switchIdentity('8F3A2B1C');
print('Active User: ${manager.activeIdentity?.name}');
```

## Integration with Online Systems
The `IShadowSyncAdapter` allows you to plug in online authentication or synchronization logic. Future versions will provide default adapters for popular backends like Supabase or Firebase.

---
Created by Antigravity Design Team.
