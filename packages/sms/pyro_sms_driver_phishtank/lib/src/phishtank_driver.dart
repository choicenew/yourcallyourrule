import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pyro_sms_protocol/pyro_sms_protocol.dart';

/// Driver integrating PhishTank verified REST HTTP phishing database
class PhishTankDriver implements SmsLinkThreatAdapter {
  @override
  String get providerId => 'pyro_sms_driver_phishtank';

  @override
  String get displayName => 'PhishTank Database';

  @override
  bool isEnabled;

  final String? appKey;
  final http.Client _client;

  PhishTankDriver({
    this.appKey,
    this.isEnabled = true,
    http.Client? client,
  }) : _client = client ?? http.Client();

  @override
  Future<PhishingUrlItem?> checkUrl(String url) async {
    if (!isEnabled || url.isEmpty) return null;

    final uri = Uri.tryParse(url);
    if (uri == null) return null;

    final domain = uri.host.toLowerCase();
    final parts = domain.split('.');
    final tld = parts.isNotEmpty ? parts.last : '';

    try {
      final requestUri = Uri.parse('https://checkurl.phishtank.com/checkurl/');
      final requestBody = {
        'url': url,
        'format': 'json',
        if (appKey != null && appKey!.isNotEmpty) 'app_key': appKey!,
      };

      final response = await _client.post(
        requestUri,
        body: requestBody,
      ).timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        final results = data['results'] as Map<String, dynamic>?;

        if (results != null) {
          final inDatabase = results['in_database'] as bool? ?? false;
          final valid = results['valid'] as bool? ?? false;

          if (inDatabase && valid) {
            return PhishingUrlItem(
              rawUrl: url,
              domain: domain,
              tld: tld,
              inPhishTankDatabase: true,
              riskLevel: SmsRiskLevel.critical,
              matchedReason: 'Verified match in PhishTank REST crowdsourced phishing database.',
            );
          }
        }
      }
    } catch (_) {
      // Graceful network timeout handling
    }

    return PhishingUrlItem(
      rawUrl: url,
      domain: domain,
      tld: tld,
      riskLevel: SmsRiskLevel.safe,
    );
  }
}
