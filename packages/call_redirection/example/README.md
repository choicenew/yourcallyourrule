# call_redirection_example

`call_redirection_example` is a standalone, isolated runner application for testing and debugging the **Call Redirection Package Suite** (`packages/call_redirection`) independently without polluting or running the main host app.

## 📌 Features & Purpose

- **Isolated Outbound Pre-Dial Simulator**: Allows entering test phone numbers and evaluating them in real-time through `CallRedirectionHub.instance.pipeline`.
- **UI Inspection**: Directly launches `CallRedirectionSettingsPage` and `HeldCallLogSheet`.
- **Zero Host App Pollution**: Runs completely independently with its own `pubspec.yaml` and Android host.

## 🚀 How to Run

```bash
cd packages/call_redirection/example
flutter run
```
