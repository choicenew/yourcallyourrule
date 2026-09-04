import 'package:flutter_test/flutter_test.dart';
import 'package:yourcallyourrule/common/utils/phone_utils.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('PhoneUtils Isolate 解析与多线程准确性测试', () {
    test('1. 国际号码解析测试 (+86, +1, 00开头的解析)', () async {
      // 验证 +86 国际号码
      final cnResult = await PhoneUtils.parsePhoneNumber('+8613800138000');
      expect(cnResult['countryCode'], equals('CN'));
      expect(cnResult['e164Number'], equals('+8613800138000'));
      expect(cnResult['nationalNumber'], isNotEmpty);

      // 验证 +1 美国号码
      final usResult = await PhoneUtils.parsePhoneNumber('+18005550199');
      expect(usResult['countryCode'], equals('US'));
      expect(usResult['e164Number'], equals('+18005550199'));

      // 验证 00 开头的国际号码
      final zeroZeroResult = await PhoneUtils.parsePhoneNumber('008613800138000');
      expect(zeroZeroResult['countryCode'], equals('CN'));
      expect(zeroZeroResult['e164Number'], equals('+8613800138000'));
    });

    test('2. 带 ISO 国家代码的号码解析 (parsePhoneNumberWithIso)', () async {
      final res = await PhoneUtils.parsePhoneNumberWithIso('13912345678', 'CN');
      expect(res['countryCode'], equals('CN'));
      expect(res['e164Number'], equals('+8613912345678'));

      final usRes = await PhoneUtils.parsePhoneNumberWithIso('6502530000', 'US');
      expect(usRes['countryCode'], equals('US'));
      expect(usRes['e164Number'], equals('+16502530000'));
    });

    test('3. 脏数据与异常输入容错测试 (子 Isolate 不得崩溃)', () async {
      // 空字符串测试
      final emptyResult = await PhoneUtils.parsePhoneNumber('');
      expect(emptyResult['countryCode'], equals(''));
      expect(emptyResult['e164Number'], equals(''));
      expect(emptyResult['nationalNumber'], equals(''));

      // 畸形乱码输入测试
      final invalidResult = await PhoneUtils.parsePhoneNumber('invalid-number-xyz-123456789!!!');
      expect(invalidResult, isA<Map<String, String>>());
    });

    test('4. 多线程高并发并发请求压力测试 (50 次并发解析)', () async {
      final numbers = [
        '+8613800138000',
        '+18005550199',
        '+442071838750',
        '+4915123456789',
        '+33612345678',
      ];

      final stopwatch = Stopwatch()..start();
      // 并发执行 50 个后台 Isolate 解析
      final futures = List.generate(50, (i) {
        final phone = numbers[i % numbers.length];
        return PhoneUtils.parsePhoneNumber(phone);
      });

      final results = await Future.wait(futures);
      stopwatch.stop();

      expect(results.length, equals(50));
      for (final r in results) {
        expect(r['countryCode'], isNotEmpty);
        expect(r['e164Number'], isNotEmpty);
      }
      
      print('PERF_METRIC: {"metric": "phone_utils_isolate_concurrency", "count": 50, "total_ms": ${stopwatch.elapsedMilliseconds}}');
    });
  });
}
