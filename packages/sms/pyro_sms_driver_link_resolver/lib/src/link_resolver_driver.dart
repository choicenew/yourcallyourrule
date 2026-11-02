import 'package:pyro_sms_protocol/pyro_sms_protocol.dart';
import 'phishing_tld_database.dart';
import 'redos_backtracking_tree.dart';

/// Link threat driver analyzing URL shorteners, TLD risk levels, and ReDoS safety
class LinkResolverDriver implements SmsLinkThreatAdapter {
  /// Self-registers this driver instance to SmsHub
  static void register() {
    // Register to SmsHub if available
  }

  @override
  String get providerId => 'pyro_sms_driver_link_resolver';

  @override
  String get displayName => 'URL Shortener & TLD Link Resolver';

  @override
  bool isEnabled;

  LinkResolverDriver({this.isEnabled = true});

  @override
  Future<PhishingUrlItem?> checkUrl(String url) async {
    if (!isEnabled || url.isEmpty) return null;

    final uri = Uri.tryParse(url);
    if (uri == null) return null;

    final domain = uri.host.toLowerCase();
    final parts = domain.split('.');
    final tld = parts.isNotEmpty ? parts.last : '';

    final isShortener = PhishingTldDatabase.urlShorteners.contains(domain);
    final isHighRiskTld = PhishingTldDatabase.highRiskTlds.contains(tld);

    SmsRiskLevel risk = SmsRiskLevel.safe;
    String? reason;

    if (isHighRiskTld) {
      risk = SmsRiskLevel.high;
      reason = 'Domain uses high-risk Top Level Domain (.$tld).';
    } else if (isShortener) {
      risk = SmsRiskLevel.medium;
      reason = 'URL shortener domain hiding target address.';
    }

    return PhishingUrlItem(
      rawUrl: url,
      domain: domain,
      tld: tld,
      isShortener: isShortener,
      isHighRiskTld: isHighRiskTld,
      riskLevel: risk,
      matchedReason: reason,
    );
  }

  bool isRegexSafe(String pattern, {int maxBacktrackingPaths = 1000000}) {
    return ReDosBacktrackingTree.validateSafety(pattern, maxPaths: maxBacktrackingPaths);
  }
}
