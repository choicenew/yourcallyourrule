import 'package:flutter_test/flutter_test.dart';
import 'package:hetu_script/hetu_script.dart';
import 'package:pyro_hetu_script_engine/pyro_hetu_script_engine.dart';

void main() {
  test('HttpClient binding operates correctly in Hetu script', () async {
    final hetu = Hetu(config: PyroHetuConfigExtension.createDefault());
    hetu.init(
      useDefaultModuleAndBinding: true,
      externalClasses: [
        ...hetu.getPyroStandardClasses(),
      ],
    );

    // 验证 HttpBaseOptions 等标准绑定能够成功实例化
    final res = hetu.eval('''
      external class HttpBaseOptions {
        construct()
      }
      var options = HttpBaseOptions()
      options
    ''');
    expect(res, isNotNull);
  });
}
