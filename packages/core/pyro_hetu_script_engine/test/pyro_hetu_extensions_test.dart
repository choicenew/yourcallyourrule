import 'package:flutter_test/flutter_test.dart';
import 'package:hetu_script/hetu_script.dart';
import 'package:pyro_hetu_script_engine/pyro_hetu_script_engine.dart';

void main() {
  group('PyroHetuExtension Tests', () {
    test('PyroHetuConfigExtension and PyroHetuLogger work properly', () {
      final config = PyroHetuConfigExtension.createDefault(debugMode: true);
      expect(config.debugMode, isTrue);
      expect(config.processError, isTrue);

      final hetu = Hetu(config: config, logger: const PyroHetuLogger());
      hetu.init();

      final res = hetu.eval('1 + 2');
      expect(res, 3);
    });

    test('PyroHetuInvocationExtension safeInvoke, define and fetch work', () {
      final hetu = Hetu(config: PyroHetuConfigExtension.createDefault());
      hetu.init();

      // 测试安全调用不存在的方法（不抛出异常）
      final missingRes = hetu.safeInvoke('nonExistentFunc', ignoreUndefined: true);
      expect(missingRes, isNull);

      // 测试变量定义与获取
      hetu.defineValue('testVal', 42);
      final fetchedVal = hetu.fetchValue('testVal');
      expect(fetchedVal, 42);

      // 测试变量重新赋值
      hetu.assignValue('testVal', 100);
      final updatedVal = hetu.fetchValue('testVal');
      expect(updatedVal, 100);
    });

    test('PyroHetuInvocationExtension async invocation works', () async {
      final hetu = Hetu(config: PyroHetuConfigExtension.createDefault());
      hetu.init(
        externalFunctions: {
          'fetchRemoteData': () async {
            await Future.delayed(const Duration(milliseconds: 10));
            return 'async_result_ok';
          },
        },
      );

      final code = '''
        external function fetchRemoteData
        function testAsync() {
          return fetchRemoteData()
        }
      ''';
      hetu.eval(code);

      final result = await hetu.invokeAsync('testAsync');
      expect(result, 'async_result_ok');
    });

    test('PyroHetuStructExtension converts to Dart Map correctly', () {
      final hetu = Hetu(config: PyroHetuConfigExtension.createDefault());
      hetu.init();

      final result = hetu.eval('''
        var data = {
          title: "WallPaper",
          views: 999,
          active: true
        }
        data
      ''');

      expect(result, isA<HTStruct>());
      final struct = result as HTStruct;

      final dartMap = struct.toDartMap();
      expect(dartMap['title'], 'WallPaper');
      expect(dartMap['views'], 999);
      expect(dartMap['active'], isTrue);

      expect(struct.getField<String>('title'), 'WallPaper');
      expect(struct.getField<int>('views'), 999);
      expect(struct.getField<int>('unknownKey'), isNull);
    });

    test('PyroHetuEngine Facade exposes all extension capabilities', () async {
      final engine = PyroHetuEngine(
        webViewDelegate: _DummyWebViewDelegate(),
        userDelegate: _DummyUserDelegate(),
        configDelegate: _DummyConfigDelegate(),
        storageDelegate: _DummyStorageDelegate(),
        translationDelegate: _DummyTranslationDelegate(),
      );

      // 验证未初始化即可执行基础 eval
      engine.define('auraVersion', '2.0.0');
      expect(engine.fetch('auraVersion'), '2.0.0');

      engine.assign('auraVersion', '2.1.0');
      expect(engine.fetch('auraVersion'), '2.1.0');

      // 验证 safeInvoke 未定义方法安全返回 null
      final safeRes = engine.safeInvoke('notDefinedFunction');
      expect(safeRes, isNull);
    });
  });
}

class _DummyWebViewDelegate implements WebViewDelegate {
  @override
  Future<String> fetch(String url, {List<String>? purgeRules, String? waitFor, Map<String, String>? headers, bool allowNavigation = false}) async => '';
  @override
  Future<String> openAndGetCookies(String url, {String? userAgent}) async => '';
  @override
  String? getUserAgent() => '';
}

class _DummyUserDelegate implements UserDelegate {
  @override
  Future<Map<String, int>> getWeights({String? type}) async => {};
  @override
  Future<List<String>> getLastTags({String? type}) async => [];
  @override
  Future<List<Map<String, dynamic>>> getHistory({String? type}) async => [];
  @override
  Future<List<Map<String, dynamic>>> getCollections({String? type}) async => [];
}

class _DummyConfigDelegate implements ConfigDelegate {
  @override
  Future<dynamic> getValue(String key) async => null;
  @override
  Future<void> setValue(String key, dynamic value) async {}
  @override
  Future<void> updateConfig(Map<String, dynamic> config) async {}
}

class _DummyStorageDelegate implements StorageDelegate {
  @override
  Future<String?> getValue(String key) async => null;
  @override
  Future<bool> setValue(String key, String value) async => true;
}

class _DummyTranslationDelegate implements TranslationDelegate {
  @override
  Future<String> translate(String text, {String targetLang = 'en', String sourceLang = 'auto'}) async => text;
}
