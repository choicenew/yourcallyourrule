import 'package:flutter/foundation.dart';
import 'feed_downloader.dart';

/// Central repository managing SMS threat feed subscriptions, parsing, and local storage
class FeedRepository {
  static final FeedRepository instance = FeedRepository._internal();
  FeedRepository._internal();

  final FeedDownloader _downloader = FeedDownloader();
  final Map<String, Set<String>> _feedDomainStore = {};

  static const String openPhishFeedUrl =
      'https://raw.githubusercontent.com/openphish/public_feed/refs/heads/main/feed.txt';

  /// Syncs and parses the official OpenPhish live feed.txt
  Future<Set<String>> syncOpenPhishFeed({String? customFeedContent}) async {
    final String content = customFeedContent ?? await _downloader.downloadTextFeed(openPhishFeedUrl);
    final Set<String> domains = {};

    if (content.isNotEmpty) {
      final lines = content.split('\n');
      for (var line in lines) {
        line = line.trim();
        if (line.isEmpty || line.startsWith('#')) continue;

        final uri = Uri.tryParse(line.startsWith('http') ? line : 'http://$line');
        if (uri != null && uri.host.isNotEmpty) {
          domains.add(uri.host.toLowerCase());
        }
      }
    }

    _feedDomainStore['openphish'] = domains;
    debugPrint('[FeedRepository] Parsed ${domains.length} real domains from OpenPhish feed.');
    return domains;
  }

  Set<String> getFeedDomains(String feedKey) {
    return _feedDomainStore[feedKey] ?? const {};
  }
}
