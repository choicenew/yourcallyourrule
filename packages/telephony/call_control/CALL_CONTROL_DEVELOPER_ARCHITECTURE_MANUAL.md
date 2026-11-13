# Call Control Package Suite — Developer & Architecture Manual

## Executive Summary

The **Call Control Package Suite** (`packages/call_control/`) encapsulates incoming and outgoing call action execution (Reject, Silence, Answer-then-Hangup, Voicemail) into a standalone, modular, self-registering package suite following the **Pyro Workspace Package Architecture Protocol**.

It decouples decision-making (Call Screening) from execution (Call Control), ensuring zero privacy leaks via microsecond-level microphone mute protection during `ANSWER_THEN_HANGUP` actions.

---

## Architecture Topology & Layering

```text
┌────────────────────────────────────────────────────────────────────────┐
│                        Host Application / UI                           │
│                 (pyro_call_control_ui / App Entry)                     │
└────────┬───────────────────────┬───────────────────────┬───────────────┘
         │                       │                       │
         ▼                       ▼                       ▼
pyro_call_control_hub      pyro_call_control_      pyro_call_control_
(Action Dispatcher &       driver (Native Bridge & protocol
 Configuration)            AudioManager Guard)     (Abstract Contracts &
         │                       │                 Zero-Dep Models)
         └───────────────────────┴─────────────────┘
```

---

## Capability Matrix & Micro-Package Mapping

| Capability | Purpose | Package | Implementation Class |
| :--- | :--- | :--- | :--- |
| **1. Abstract Contracts & Enums** | Core domain models, enums (`CallActionType`), and execution adapter contracts | `pyro_call_control_protocol` | `CallActionType`, `CallActionContext`, `CallExecutionResult`, `ICallActionExecutor` |
| **2. Action Dispatcher Hub** | IoC singleton, configuration management, and execution pipeline | `pyro_call_control_hub` | `CallControlHub` |
| **3. Native Call Control Driver** | Telecom CallResponse mapping, InCallService coordination, and AudioManager mic mute guard | `pyro_call_control_driver` | `CallControlDriver`, `CallControlDriverPlugin`, `AnswerHangupCoordinator`, `CallResponseFactory` |
| **4. Assembly Connector** | Facade static registration entrypoint | `pyro_call_control_connector` | `CallControlConnectors` |
| **5. User Settings UI** | Action tuning, hangup delay slider, and mic mute protection toggle | `pyro_call_control_ui` | `CallControlSettingsPage`, `CallActionConfigTile` |

---

## Key Protocols & Rules

1. **Protocol Layer Red Line**:
   `pyro_call_control_protocol` MUST ONLY depend on Flutter SDK. No 3rd-party dependencies or UI code allowed.
2. **Driver Isolation**:
   `pyro_call_control_driver` MUST ONLY depend on `pyro_call_control_protocol` and `pyro_call_control_hub`.
3. **Privacy First (Microphone Mute Guard)**:
   Any `answerThenHangup` execution MUST invoke `AudioManager.isMicrophoneMute = true` before call pickup and restore it to `false` after disconnect to prevent ambient background audio / voice theft by spammers.
