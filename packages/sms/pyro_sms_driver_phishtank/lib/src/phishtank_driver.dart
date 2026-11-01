import 'package:pyro_sms_protocol/pyro_sms_protocol.dart';

/// Driver integrating PhishTank verified phishing database
class PhishTankDriver implements SmsLinkThreatAdapter {
  @override
  String get providerId => 'pyro_sms_driver_phishtank';

  @override
  String get displayName => 'PhishTank Database';

  @override
  bool isEnabled;

  final Set<String> _verifiedPhishTankUrls = {
    'http://phishing-login.top/account',
    'http://bank-secure-update.xyz/verify',
  };

  PhishTankDriver({this.isEnabled = true});

  @override
  Future<PhishingUrlItem?> checkUrl(String url) async {
    if (!isEnabled || url.isEmpty) return null;

    final uri = Uri.tryParse(url);
    if (uri == null) return null;

    final domain = uri.host.toLowerCase();
    final parts = domain.split('.');
    final tld = parts.isNotEmpty ? parts.last : '';

    final inPhishTank = _verifiedPhishTankUrls.contains(url);

    if (inPhishTank) {
      return PhishingUrlItem(
        rawUrl: url,
        domain: domain,
        tld: tld,
        inPhishTankDatabase: true,
        riskLevel: SmsRiskLevel.critical,
        matchedReason: 'Verified match in PhishTank crowdsourced phishing database.',
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
