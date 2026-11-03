# Pyro SMS Protection Package Suite (`packages/sms`)

The `packages/sms` suite provides a complete, decoupled, and self-registering SMS/messaging protection architecture built according to the **Pyro Workspace Package Architecture Protocol**.

It consolidates all SMS link detection, threat feeds, and spam classification capabilities (Google Safe Browsing, PhishTank, OpenPhish, VirusTotal, Link Resolver & TLD analyzer, ReDoS safety guard, 20-feature GBT & Complement Naive Bayes ML scoring, SMS burst protection, and NotificationListener permission-free screening) into independent driver micro-packages.

---

## 📁 Package Topology & Architecture

```text
packages/sms/
├── pyro_sms_protocol/                      # Abstract contracts, data models, enums & adapters (0 heavy deps)
├── pyro_sms_hub/                           # Service locator singleton (SmsHub.instance) & screening pipeline
├── pyro_sms_driver_google_safe_browsing/  # Google Safe Browsing API v4 URL threat detection driver
├── pyro_sms_driver_phishtank/             # PhishTank verified phishing database driver
├── pyro_sms_driver_openphish/             # OpenPhish live phishing threat feed driver
├── pyro_sms_driver_virustotal/            # VirusTotal multi-engine URL security scanner driver
├── pyro_sms_driver_link_resolver/         # URL shortener resolver, high-risk TLD & ReDoS safety guard driver
├── pyro_sms_driver_ml_classifier/         # 20-Feature GBT & Complement Naive Bayes ML spam classifier driver
├── pyro_sms_driver_burst_protection/      # Unknown sender SMS burst frequency protection driver
├── pyro_sms_driver_notification_listener/ # Android NotificationListener permission-free interceptor & evidence logger
├── pyro_sms_driver_regex_rules/           # ReDoS-safe Regex and Keyword rule engine driver
└── pyro_sms_ui/                            # Settings screens, protected app selector, evidence sheet (100% L10n)
```

---

## 🚀 Quick Integration & Driver Auto-Registration

```dart
import 'package:flutter/material.dart';
import 'package:pyro_sms_hub/pyro_sms_hub.dart';
import 'package:pyro_sms_driver_google_safe_browsing/pyro_sms_driver_google_safe_browsing.dart';
import 'package:pyro_sms_driver_phishtank/pyro_sms_driver_phishtank.dart';
import 'package:pyro_sms_driver_openphish/pyro_sms_driver_openphish.dart';
import 'package:pyro_sms_driver_virustotal/pyro_sms_driver_virustotal.dart';
import 'package:pyro_sms_driver_link_resolver/pyro_sms_driver_link_resolver.dart';
import 'package:pyro_sms_driver_ml_classifier/pyro_sms_driver_ml_classifier.dart';
import 'package:pyro_sms_driver_burst_protection/pyro_sms_driver_burst_protection.dart';
import 'package:pyro_sms_driver_notification_listener/pyro_sms_driver_notification_listener.dart';
import 'package:pyro_sms_driver_regex_rules/pyro_sms_driver_regex_rules.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Mount SMS drivers onto SmsHub
  SmsConnectors.ensureMounted(
    driverRegistrars: [
      (hub) {
        hub.registerLinkThreatAdapter(GoogleSafeBrowsingDriver());
        hub.registerLinkThreatAdapter(PhishTankDriver());
        hub.registerLinkThreatAdapter(OpenPhishDriver());
        hub.registerLinkThreatAdapter(VirusTotalDriver());
        hub.registerLinkThreatAdapter(LinkResolverDriver());
        hub.registerMlScorer(ComplementNaiveBayesScorer());
        hub.registerBurstProtection(SmsBurstProtectionDriver());
        hub.registerNotificationListener(SmsNotificationListenerDriver());
        hub.registerFilter(RegexRulesDriver());
      },
    ],
  );

  runApp(const MyApp());
}
```

---

## 📄 License

Proprietary / All Rights Reserved - Pyro Magma Workspace
