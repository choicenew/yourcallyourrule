# pyro_call_redirection_hub

`pyro_call_redirection_hub` is the Service Locator singleton and evaluation pipeline orchestrator for the **Call Redirection Package Suite**.

## 📌 Features & Purpose

- **Service Locator (`CallRedirectionHub.instance`)**: Maintains the active `ICallRedirectionAdapter` driver registration without hardcoding concrete driver implementations.
- **Evaluation Pipeline (`CallRedirectionPipeline`)**: Evaluates outbound call attempts through the registered driver and provides safe fallback (`RedirectionAction.proceed`) if no driver is mounted or an exception occurs.

## 🚀 Quick Start

```dart
import 'package:pyro_call_redirection_hub/pyro_call_redirection_hub.dart';
import 'package:pyro_call_redirection_protocol/pyro_call_redirection_protocol.dart';

void main() async {
  final call = OutgoingCallEntity(
    id: '1',
    rawPhoneNumber: '+18885550199',
    normalizedPhoneNumber: '18885550199',
    timestampMs: DateTime.now().millisecondsSinceEpoch,
  );

  // Evaluate outbound call through pipeline
  final decision = await CallRedirectionHub.instance.pipeline.evaluate(call);
  print('Action: ${decision.action}, Reason: ${decision.reason}');
}
```
