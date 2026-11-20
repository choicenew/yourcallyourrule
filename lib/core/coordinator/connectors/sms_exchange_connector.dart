import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_sms_connector/pyro_sms_connector.dart';
import 'package:pyro_sms_hub/pyro_sms_hub.dart';
import 'package:pyro_sms_driver_burst_protection/pyro_sms_driver_burst_protection.dart';
import 'package:pyro_sms_driver_google_safe_browsing/pyro_sms_driver_google_safe_browsing.dart';
import 'package:pyro_sms_driver_phishtank/pyro_sms_driver_phishtank.dart';
import 'package:pyro_sms_driver_virustotal/pyro_sms_driver_virustotal.dart';
import 'package:pyro_sms_driver_regex_rules/pyro_sms_driver_regex_rules.dart';

final smsHubProvider = Provider<SmsHub>((ref) {
  final hub = SmsHub();
  SmsConnectors.mountToHub(hub);
  hub.registerBurstProtection(SmsBurstProtectionDriver());
  hub.registerLinkThreatAdapter(GoogleSafeBrowsingDriver());
  hub.registerLinkThreatAdapter(PhishTankDriver());
  hub.registerLinkThreatAdapter(VirusTotalDriver());
  hub.registerFilter(RegexRulesDriver());
  return hub;
});

