# SMS Protection Package Suite — Developer & Architecture Manual

## Executive Summary

The **SMS Protection Package Suite** (`packages/sms/`) consolidates all SMS and messaging threat detection mechanisms referenced across target repositories (`CallShield`, `saracroche-android`, `Silence`, `SpamBlocker`, `SpamBlocker-Extended`, `web26-050-call-blocker`) into standalone, modular, self-registering driver packages following the **Pyro Workspace Package Architecture Protocol**.

---

## Driver Capabilities Matrix

| Capability | Package Name | Driver Implementation |
| :--- | :--- | :--- |
| **1. Google Safe Browsing API v4** | `pyro_sms_driver_google_safe_browsing` | `GoogleSafeBrowsingDriver` |
| **2. PhishTank Crowdsourced Database** | `pyro_sms_driver_phishtank` | `PhishTankDriver` |
| **3. OpenPhish Live Threat Feed** | `pyro_sms_driver_openphish` | `OpenPhishDriver` |
| **4. VirusTotal Multi-Engine Scanner** | `pyro_sms_driver_virustotal` | `VirusTotalDriver` |
| **5. Shortener, TLD & ReDoS Tree** | `pyro_sms_driver_link_resolver` | `LinkResolverDriver`, `ReDosBacktrackingTree` |
| **6. 20-Feature GBT & Naive Bayes ML** | `pyro_sms_driver_ml_classifier` | `GbtFeatureExtractor`, `ComplementNaiveBayesScorer` |
| **7. Unknown Sender Burst Limiter** | `pyro_sms_driver_burst_protection` | `SmsBurstProtectionDriver` |
| **8. Permission-Free Notification Interceptor** | `pyro_sms_driver_notification_listener` | `SmsNotificationListenerDriver` |
| **9. ReDoS-Safe Regex Rules** | `pyro_sms_driver_regex_rules` | `RegexRulesDriver` |
| **10. Localized UI Components** | `pyro_sms_ui` | `SmsScreeningSettingsPage`, `SmsLocalizations` |

---

## Architectural Red Lines

1. **Hub Cleanliness**:
   `SmsHub` is a pure Service Locator and Screening Pipeline orchestrator. It holds no hardcoded driver implementations or leakages.
2. **Protocol Zero Heavy Dependencies**:
   `pyro_sms_protocol` depends ONLY on `flutter` SDK.
3. **Driver Isolation**:
   Drivers depend ONLY on `pyro_sms_protocol` (no Hub dependency!).
4. **UI Localizations Requirement**:
   All UI elements in `pyro_sms_ui` 100% use `SmsLocalizations` (lowerCamelCase keys) without hardcoded string literals.
