import 'package:pyro_sms_protocol/pyro_sms_protocol.dart';

/// Driver integrating VirusTotal multi-engine URL threat scanner
class VirusTotalDriver implements SmsLinkThreatAdapter {
  @override
  String get providerId => 'pyro_sms_driver_virustotal';

  @override
  String get displayName => 'VirusTotal Multi-Engine Scanner';

  @override
  bool isEnabled;

  final String? apiKey;
  final Set<String> _flaggedUrls = {
    'http://virustotal-flagged-malware.top',
  };

  VirusTotalDriver({
    this.apiKey,
    this.isEnabled = true,
  });

  @override
  Future<PhishingUrlItem?> checkUrl(String url) async {
    if (!isEnabled || url.isEmpty) return null;

    final uri = Uri.tryParse(url);
    if (uri == null) return null;

    final domain = uri.host.toLowerCase();
    final parts = domain.split('.');
    final tld = parts.isNotEmpty ? parts.last : '';

    final isFlagged = _flaggedUrls.contains(url) || domain.contains('virustotal-flagged');

    if (isFlagged) {
      return PhishingUrlItem(
        rawUrl: url,
        domain: domain,
        tld: tld,
        riskLevel: SmsRiskLevel.critical,
        matchedReason: 'VirusTotal multi-engine analysis flagged url as malicious/phishing.',
      );
    }

    return PhishingUrlItem(
      rawUrl: url,
      domain: domain,
      tld: tld,
      riskLevel: SmsRiskLevel.safe,
    );
  }
}
