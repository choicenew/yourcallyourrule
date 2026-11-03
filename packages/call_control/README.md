# Pyro Call Control Package Suite (`packages/call_control`)

The `packages/call_control` suite provides a complete, decoupled, and self-registering execution architecture for incoming/outgoing call interception actions (Reject, Silence, Answer-then-Hangup, Voicemail) built according to the **Pyro Workspace Package Architecture Protocol**.

It decouples call screening decisions from physical hardware execution (Telecom CallResponse, AudioManager microphone mute background protection, and InCall disconnect coordination) into isolated micro-packages.

---

## 📁 Package Topology

```text
packages/call_control/
├── pyro_call_control_protocol/  # Abstract contracts, zero-dependency models, enums & executor adapters
├── pyro_call_control_hub/       # Action dispatch hub (CallControlHub.instance) & configuration
├── pyro_call_control_driver/    # Android Telecom & AudioManager driver with microsecond mic mute protection
├── pyro_call_control_connector/ # Facade assembly connector (CallControlConnectors.ensureMounted())
└── pyro_call_control_ui/        # Settings screen & action configuration widgets
```

---

## 🚀 Quick Integration & Auto-Registration SOP

```dart
import 'package:flutter/material.dart';
import 'package:pyro_call_control_connector/pyro_call_control_connector.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Mount Call Control suite and auto-register driver
  CallControlConnectors.ensureMounted();

  runApp(const MyApp());
}
```

---

## 🔒 Background Privacy Protection (Microphone Mute Guard)

When executing `ANSWER_THEN_HANGUP` (Answer call and hang up after 1s delay to destroy autodialers and charge spam callers):
1. Microsecond before answering: Calls `AudioManager.isMicrophoneMute = true` to physically disable the microphone.
2. Answers call & delays (e.g. 1000ms).
3. Immediately calls `disconnect()`.
4. Restores `AudioManager.isMicrophoneMute = false`.

---

## 📄 License

Proprietary / All Rights Reserved - Pyro Magma Workspace
