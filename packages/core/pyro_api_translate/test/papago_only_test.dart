import 'package:flutter_test/flutter_test.dart';
import 'package:pyro_api_translate/src/providers/papago_provider.dart';

void main() {
  test('Sole Focus: Papago Live Network Test', () async {
    final provider = PapagoProvider();
    print('\n==================== PAPAGO SOLE TEST ====================');
    final sw = Stopwatch()..start();
    try {
      final res = await provider.translate('Hello world', targetLanguage: 'zh');
      sw.stop();
      print('✅ PAPAGO PASS (${sw.elapsedMilliseconds}ms) -> RESULT: "$res"');
    } catch (e) {
      sw.stop();
      print('❌ PAPAGO FAIL (${sw.elapsedMilliseconds}ms) -> ERROR: $e');
    }
    print('=========================================================\n');
  });
}
