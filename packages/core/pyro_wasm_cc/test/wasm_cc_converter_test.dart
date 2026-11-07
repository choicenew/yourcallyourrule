import 'package:flutter_test/flutter_test.dart';
import 'package:pyro_wasm_cc/pyro_wasm_cc.dart';

void main() {
  group('WasmCcConverter 繁简无损转换测试', () {
    test('简体转繁体测试', () {
      final s = '华人爱读书';
      final t = WasmCcConverter.convert(s, CcConversionMode.simplifiedToTraditional);
      expect(t, equals('華人愛讀書'));
    });

    test('繁体转简体测试', () {
      final t = '華人愛讀書';
      final s = WasmCcConverter.convert(t, CcConversionMode.traditionalToSimplified);
      expect(s, equals('华人爱读书'));
    });
  });
}
