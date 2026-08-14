# Implementation Plan - Migration to Advanced Call Log Plugin

This plan outlines the steps to migrate the project from the `call_log` plugin to the `advanced_call_log` plugin. This is intended to fix the native crash and debugger disconnection issues occurring during the pre-warming of the Flutter engine in the `Application` class.

## Proposed Changes

### Dependencies

#### [MODIFY] [pubspec.yaml](file:///C:/Users/Ngokel/Desktop/en/test/github/yourcallyourrulemixhistory/pubspec.yaml)
- Replace `call_log: ^6.0.1` with a local path dependency to `advanced_call_log`.

### Call History Feature

#### [MODIFY] [system_call_log_service.dart](file:///C:/Users/Ngokel/Desktop/en/test/github/yourcallyourrulemixhistory/lib/features/call/call_history/services/system_call_log_service.dart)
- Update the import from `package:call_log/call_log.dart` to `package:advanced_call_log/advanced_call_log.dart`.
- In `syncSystemCallLogs`, replace the usage of `entry.id` with a generated UUID, as the new plugin does not return a database ID.
- Ensure mapping of `CallType` remains correct (the enum definitions are compatible).

## Verification Plan

### Automated Tests
- Since this involves native interaction, I will rely on the app build and execution.
- I will run `flutter pub get` to ensure the new dependency is correctly resolved.

### Manual Verification
- Run the app on the Android emulator.
- Observe the Logcat for the `init. Messanger` log (which should be gone) and the `Connection closed` error (which should be resolved).
- Test the "Sync System Call Logs" feature in the app to ensure call history is still correctly fetched and saved to the local database.
