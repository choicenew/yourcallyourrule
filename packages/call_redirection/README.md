# Pyro Call Redirection Package Suite (`packages/call_redirection`)

The `packages/call_redirection` suite provides a complete, decoupled, and self-registering pre-dial protection architecture built according to the **Pyro Workspace Package Architecture Protocol**.

It consolidates outbound call interception, 3-second Telecom deadline timeout guards, emergency number floor protection, car-mode ghost call defense, and "Call Anyway" bypass token management into isolated micro-packages.

---

## 📁 Package Topology

```text
packages/call_redirection/
├── pyro_call_redirection_protocol/  # Pure abstract contracts, data models, enums & adapters
├── pyro_call_redirection_driver/    # Android CallRedirectionService driver, 3s deadline & emergency floor
├── pyro_call_redirection_hub/       # Service locator singleton (CallRedirectionHub.instance) & pipeline
└── pyro_call_redirection_ui/        # Settings screen, held call log sheet & bypass controls
```

---

## 🚀 Quick Integration & Auto-Registration SOP

```dart
import 'package:flutter/material.dart';
import 'package:pyro_call_redirection_hub/pyro_call_redirection_hub.dart';
import 'package:pyro_call_redirection_driver/pyro_call_redirection_driver.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Mount Call Redirection suite and register driver
  CallRedirectionConnectors.ensureMounted(
    driverRegistrars: [
      (hub) {
        hub.registerRedirectionDriver(CallRedirectionDriver());
      },
    ],
  );

  runApp(const MyApp());
}
```

---

## 📄 License

MIT License - Pyro Magma Workspace
