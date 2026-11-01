import 'dart:math';
import 'package:pyro_sms_protocol/pyro_sms_protocol.dart';

/// Feature extractor that builds a 20-dimensional feature vector for GBT spam models
class GbtFeatureExtractor {
  static List<double> extract20Features(SmsMessageEntity message) {
    final body = message.body;
    final sender = message.sender;
    final length = body.length.toDouble();

    // Feature 1: Body character length
    final f1 = length;

    // Feature 2: Digit ratio in sender
    final senderDigits = sender.replaceAll(RegExp(r'\D'), '').length;
    final f2 = sender.isNotEmpty ? senderDigits / sender.length : 0.0;

    // Feature 3: Uppercase letter ratio
    final uppercaseCount = body.replaceAll(RegExp(r'[^A-Z]'), '').length;
    final f3 = length > 0 ? uppercaseCount / length : 0.0;

    // Feature 4: Contains URL count
    final urlMatches = RegExp(r'https?://').allMatches(body).length.toDouble();
    final f4 = urlMatches;

    // Feature 5: Contains currency/financial symbols ($, €, ¥, £, 元)
    final f5 = RegExp(r'[$€¥£元]').hasMatch(body) ? 1.0 : 0.0;

    // Feature 6: Contains urgency keywords (urgent, immediate, verify, win, prize, claim, 立即, 绝密, 汇款)
    final urgencyRegex = RegExp(
      r'(urgent|immediate|verify|win|prize|claim|winner|suspended|bank|account|密码|验证码|立即|汇款|博彩|中奖)',
      caseSensitive: false,
    );
    final f6 = urgencyRegex.hasMatch(body) ? 1.0 : 0.0;

    // Feature 7: Hour of day sin encoding
    final hour = message.timestamp.hour;
    final f7 = sin(2 * pi * hour / 24.0);

    // Feature 8: Hour of day cos encoding
    final f8 = cos(2 * pi * hour / 24.0);

    // Feature 9: Exclamation & Question mark count
    final punctuationCount = body.replaceAll(RegExp(r'[^!?！？]'), '').length.toDouble();
    final f9 = punctuationCount;

    // Feature 10: Toll-free sender prefix (800, 888, 877, 866, 855, 400, 800)
    final f10 = RegExp(r'^(800|888|877|866|855|400)').hasMatch(sender) ? 1.0 : 0.0;

    // Features 11 to 20: Additional normalized acoustic/textual statistics
    final f11 = body.split(RegExp(r'\s+')).length.toDouble();
    final f12 = sender.length.toDouble();
    final f13 = body.contains('http') ? 1.0 : 0.0;
    final f14 = body.replaceAll(RegExp(r'\D'), '').length.toDouble();
    final f15 = (f14 > 0 && length > 0) ? f14 / length : 0.0;
    final f16 = body.contains('bit.ly') || body.contains('t.co') ? 1.0 : 0.0;
    final f17 = message.packageName != null ? 1.0 : 0.0;
    final f18 = message.timestamp.weekday.toDouble();
    final f19 = f3 > 0.3 ? 1.0 : 0.0;
    final f20 = f5 + f6 > 0 ? 1.0 : 0.0;

    return [
      f1, f2, f3, f4, f5, f6, f7, f8, f9, f10,
      f11, f12, f13, f14, f15, f16, f17, f18, f19, f20
    ];
  }
}
