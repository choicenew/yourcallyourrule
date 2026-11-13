# Call Redirection Package Suite — Developer & Architecture Manual

## Executive Summary

The **Call Redirection Package Suite** (`packages/call_redirection/`) encapsulates outbound call pre-dial protection mechanisms (Wangiri callback scam defense, 3-second deadline timeout guard, emergency number floor protection, and car-mode ghost call defense) into a standalone, modular, self-registering package suite following the **Pyro Workspace Package Architecture Protocol**.

---

## Architecture Topology & Layering

```text
┌────────────────────────────────────────────────────────────────────────┐
│                        Host Application / UI                           │
│               (pyro_call_redirection_ui / App Entry)                   │
└────────┬───────────────────────┬───────────────────────┬───────────────┘
         │                       │                       │
         ▼                       ▼                       ▼
pyro_call_redirection_hub  pyro_call_redirection_   pyro_call_redirection_
(Service Locator &          driver (Native Bridge)  protocol
 Pre-Dial Pipeline)              │                  (Abstract Contracts &
         │                       │                  Zero-Dep Models)
         └───────────────────────┴───────────────────────┘
```

---

## Capability Matrix & Micro-Package Mapping

| Capability | Target Repo Source | Package | Implementation Class |
| :--- | :--- | :--- | :--- |
| **1. Abstract Contracts & Enums** | Pyro Architecture Protocol | `pyro_call_redirection_protocol` | `OutgoingCallEntity`, `RedirectionDecision`, `ICallRedirectionAdapter` |
| **2. 3s Timeout & Deadline Guard** | `CallShield` (`DEADLINE_MS = 3000`) | `pyro_call_redirection_driver` | `CallRedirectionDriver` |
| **3. Emergency Number Floor** | `CallShield` (`EmergencyNumberFloor`) | `pyro_call_redirection_driver` | `EmergencyNumberFloor` |
| **4. Car Mode & Interactive Guard** | `CallShield` (`allowInteractiveResponse`) | `pyro_call_redirection_driver` | `CarModeGuard` |
| **5. Pipeline Orchestration & Self-Reg** | Pyro Architecture Protocol | `pyro_call_redirection_hub` | `CallRedirectionHub`, `CallRedirectionPipeline`, `CallRedirectionConnectors` |
| **6. Settings UI & Held Call Sheet** | Pyro UI Protocol | `pyro_call_redirection_ui` | `CallRedirectionSettingsPage`, `HeldCallLogSheet` |

---

## Key Protocols & Rules

1. **Protocol Layer Red Line**:
   `pyro_call_redirection_protocol` MUST ONLY depend on Flutter SDK. No 3rd-party dependencies or UI code allowed.
2. **Driver Isolation**:
   `pyro_call_redirection_driver` MUST ONLY depend on `pyro_call_redirection_protocol`.
3. **Hub Locator Pattern**:
   `CallRedirectionHub.instance` maintains adapter registrations and evaluates outbound call requests within < 3 seconds.
