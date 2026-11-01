import 'package:pyro_sms_protocol/pyro_sms_protocol.dart';
import 'package:pyro_sms_hub/pyro_sms_hub.dart';
import 'bloom_filter.dart';
import 'aho_corasick_automaton.dart';

/// Ultra-high performance driver using Bloom Filter & AC Automaton for 100,000+ keyword searching
class KeywordBloomFilterDriver implements SmsFilterAdapter {
  /// Self-registers this driver instance to SmsHub
  static void register({List<String> customKeywords = const []}) {
    SmsHub.instance.registerFilter(
      KeywordBloomFilterDriver(keywords: customKeywords),
    );
  }

  @override
  String get providerId => 'pyro_sms_driver_keyword_bloom_filter';

  @override
  String get displayName => 'Bloom Filter & AC Automaton Keyword Matcher';

  @override
  bool isEnabled;

  final BloomFilter _bloomFilter = BloomFilter();
  final AhoCorasickAutomaton _acAutomaton = AhoCorasickAutomaton();

  KeywordBloomFilterDriver({
    this.isEnabled = true,
    List<String> keywords = const [],
  }) {
    if (keywords.isNotEmpty) {
      loadKeywords(keywords);
    } else {
      loadKeywords([
        'casino', 'lottery', 'winner', 'urgent bank', 'verification code',
        '博彩', '中奖', '特大喜讯', '退税', '汇款到',
      ]);
    }
  }

  void loadKeywords(List<String> keywords) {
    for (final kw in keywords) {
      if (kw.trim().isEmpty) continue;
      final lower = kw.trim().toLowerCase();
      _bloomFilter.add(lower);
      _acAutomaton.addKeyword(lower);
    }
    _acAutomaton.build();
  }

  @override
  Future<SmsScreeningResult?> screenMessage(SmsMessageEntity message) async {
    if (!isEnabled) return null;

    final lowerBody = message.body.toLowerCase();

    bool bloomHit = false;
    final words = lowerBody.split(RegExp(r'\W+'));
    for (final word in words) {
      if (word.length > 2 && _bloomFilter.mightContain(word)) {
        bloomHit = true;
        break;
      }
    }

    if (!bloomHit) {
      return null;
    }

    final matchedKeywords = _acAutomaton.search(lowerBody);

    if (matchedKeywords.isNotEmpty) {
      return SmsScreeningResult(
        recommendedAction: SmsFilterAction.cancelNotification,
        riskLevel: SmsRiskLevel.high,
        category: SmsCategory.scam,
        spamScore: 0.9,
        mechanismsTriggered: [SmsDetectionMechanism.regexRules],
        reasoning: 'Matched high-risk keywords via AC Automaton: ${matchedKeywords.join(", ")}',
      );
    }

    return null;
  }
}
