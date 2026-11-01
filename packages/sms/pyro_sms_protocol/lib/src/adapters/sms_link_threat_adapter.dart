import '../models/phishing_url_item.dart';

/// Abstract adapter for specialized link threat detectors (e.g. Google Safe Browsing, PhishTank, OpenPhish, VirusTotal, LinkResolver)
abstract class SmsLinkThreatAdapter {
  String get providerId;
  String get displayName;
  bool get isEnabled;

  /// Inspect a single URL or domain and return threat analysis
  Future<PhishingUrlItem?> checkUrl(String url);
}
