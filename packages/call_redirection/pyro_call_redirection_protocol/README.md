# pyro_call_redirection_protocol

`pyro_call_redirection_protocol` is the abstract contract and zero-dependency data model layer for the **Call Redirection Package Suite**.

## 📌 Features & Purpose

- **Zero Heavy Dependencies**: Depends exclusively on the Flutter SDK.
- **Data Models**:
  - `OutgoingCallEntity`: Immutable representation of an outbound call attempt (raw number, normalized number, timestamp, car mode state, interactive response state).
  - `RedirectionDecision`: Immutable evaluation result (action, hold reason, description, evaluation time in ms).
- **Enums**:
  - `RedirectionAction`: `proceed`, `holdAndNotify`, `block`.
  - `RedirectionHoldReason`: `wangiriScam`, `premiumRateNumber`, `userBlocklist`, `databaseMatch`, `emergencyOverride`.
- **Adapter Contract**: `ICallRedirectionAdapter` defining the required interface for all concrete redirection driver implementations.

## 🚀 Quick Start

```dart
import 'package:pyro_call_redirection_protocol/pyro_call_redirection_protocol.dart';

// Create an outbound call entity
final call = OutgoingCallEntity(
  id: 'call_101',
  rawPhoneNumber: '+18885550199',
  normalizedPhoneNumber: '18885550199',
  timestampMs: DateTime.now().millisecondsSinceEpoch,
  isInteractiveAllowed: true,
  isCarModeActive: false,
);

// Check decision
const decision = RedirectionDecision(
  action: RedirectionAction.holdAndNotify,
  reason: RedirectionHoldReason.wangiriScam,
  description: 'Wangiri callback scam detected.',
);
```
