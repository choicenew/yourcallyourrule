import 'package:pyro_sms_protocol/pyro_sms_protocol.dart';
import 'package:pyro_sms_hub/pyro_sms_hub.dart';
import 'package:pyro_sms_subscription/pyro_sms_subscription.dart';

/// Driver integrating OpenPhish live threat feed via real feed repository
class OpenPhishDriver implements SmsLinkThreatAdapter {
  /// Registers this driver to the provided SmsHub
  static void register(SmsHub hub, {FeedRepository? feedRepository}) {
    hub.registerLinkThreatAdapter(OpenPhishDriver(feedRepository: feedRepository));
  }

  @override
  String get providerId => 'pyro_sms_driver_openphish';

  @override
  String get displayName => 'OpenPhish Threat Feed';

  @override
  bool isEnabled;

  final FeedRepository _feedRepository;

  OpenPhishDriver({
    this.isEnabled = true,
    FeedRepository? feedRepository,
  }) : _feedRepository = feedRepository ?? FeedRepository();

  @override
  Future<PhishingUrlItem?> checkUrl(String url) async {
    if (!isEnabled || url.isEmpty) return null;

    final uri = Uri.tryParse(url);
    if (uri == null) return null;

    final domain = uri.host.toLowerCase();
    final parts = domain.split('.');
    final tld = parts.isNotEmpty ? parts.last : '';

    final openPhishDomains = _feedRepository.getFeedDomains('openphish');
    final inOpenPhish = openPhishDomains.contains(domain);

    if (inOpenPhish) {
      return PhishingUrlItem(
        rawUrl: url,
        domain: domain,
        tld: tld,
        inOpenPhishFeed: true,
        riskLevel: SmsRiskLevel.critical,
        matchedReason: 'Domain matched in OpenPhish live phishing threat feed.',
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
