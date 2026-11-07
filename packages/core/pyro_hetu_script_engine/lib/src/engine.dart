import 'package:hetu_script/hetu_script.dart';

// Delegates
import '../delegates/delegates.dart';
// Services
import 'services/device_service.dart';
import 'services/weather_service.dart';
// Extensions
import 'extensions/extensions.dart';

export 'extensions/extensions.dart';

/// Pyro 脚本引擎 Facade 门面，基于 [Hetu] 扩展体系构建
class PyroHetuEngine {
  late final Hetu hetu;
  bool _isInitialized = false;

  final WebViewDelegate webViewDelegate;
  final UserDelegate userDelegate;
  final ConfigDelegate configDelegate;
  final StorageDelegate storageDelegate;
  late final DeviceService deviceService;
  late final WeatherService weatherService;
  final WeatherDelegate? weatherDelegate;
  final TranslationDelegate translationDelegate;

  PyroHetuEngine({
    required this.webViewDelegate,
    required this.userDelegate,
    required this.configDelegate,
    required this.storageDelegate,
    required this.translationDelegate,
    this.weatherDelegate,
    HetuConfig? config,
    HTLogger? logger,
  }) {
    hetu = Hetu(
      config: config ?? PyroHetuConfigExtension.createDefault(),
      logger: logger ?? const PyroHetuLogger(),
    );
    deviceService = DeviceService();
    weatherService = WeatherService();
  }

  /// 初始化 Pyro 引擎及其绑定和内置模块
  Future<void> init() async {
    if (_isInitialized) return;

    // 1. 注册 Pyro 全部 Std 与 SDK 扩展绑定
    hetu.initPyroBindings(
      webViewDelegate: webViewDelegate,
      userDelegate: userDelegate,
      configDelegate: configDelegate,
      storageDelegate: storageDelegate,
      translationDelegate: translationDelegate,
      deviceService: deviceService,
      weatherService: weatherService,
      weatherDelegate: weatherDelegate,
    );

    // 2. 批量加载 Pyro 内置标准库与 SDK 模块
    await hetu.loadAllPyroBuiltinModules();

    _isInitialized = true;
  }

  /// 评估执行一段河图脚本代码
  dynamic eval(
    String code, {
    String? moduleName,
    bool globallyImport = false,
  }) {
    return hetu.eval(
      code,
      module: moduleName,
      globallyImport: globallyImport,
    );
  }

  /// 调用指定函数
  dynamic invoke(
    String funcName, {
    String? moduleName,
    String? namespace,
    List<dynamic> positionalArgs = const [],
    Map<String, dynamic> namedArgs = const {},
    bool ignoreUndefined = false,
  }) {
    return hetu.invoke(
      funcName,
      module: moduleName,
      namespace: namespace,
      positionalArgs: positionalArgs,
      namedArgs: namedArgs,
      ignoreUndefined: ignoreUndefined,
    );
  }

  /// 安全调用指定函数（未定义方法不抛出异常）
  dynamic safeInvoke(
    String funcName, {
    String? moduleName,
    String? namespace,
    List<dynamic> positionalArgs = const [],
    Map<String, dynamic> namedArgs = const {},
    bool ignoreUndefined = true,
  }) {
    return hetu.safeInvoke(
      funcName,
      moduleName: moduleName,
      namespace: namespace,
      positionalArgs: positionalArgs,
      namedArgs: namedArgs,
      ignoreUndefined: ignoreUndefined,
    );
  }

  /// 异步安全调用指定函数，自动 await 异步结果
  Future<dynamic> invokeAsync(
    String funcName, {
    String? moduleName,
    String? namespace,
    List<dynamic> positionalArgs = const [],
    Map<String, dynamic> namedArgs = const {},
    bool ignoreUndefined = true,
  }) async {
    return await hetu.invokeAsync(
      funcName,
      moduleName: moduleName,
      namespace: namespace,
      positionalArgs: positionalArgs,
      namedArgs: namedArgs,
      ignoreUndefined: ignoreUndefined,
    );
  }

  /// 定义环境全局变量/常量
  void define(
    String id,
    dynamic value, {
    bool isMutable = false,
    bool override = true,
    String? module,
  }) {
    hetu.defineValue(
      id,
      value,
      isMutable: isMutable,
      override: override,
      module: module,
    );
  }

  /// 获取环境中的变量
  dynamic fetch(
    String id, {
    String? namespace,
    String? module,
  }) {
    return hetu.fetchValue(
      id,
      namespace: namespace,
      module: module,
    );
  }

  /// 为环境中的变量重新赋值
  void assign(
    String id,
    dynamic value, {
    String? namespace,
    String? module,
    bool defineIfAbsent = false,
  }) {
    hetu.assignValue(
      id,
      value,
      namespace: namespace,
      module: module,
      defineIfAbsent: defineIfAbsent,
    );
  }

  /// 手动加载并导入一个模块脚本
  Future<void> loadModule(
    String moduleName,
    String assetPath, {
    bool isGlobal = false,
  }) async {
    await hetu.loadPyroAssetModule(
      assetPath,
      moduleName: moduleName,
      isGlobal: isGlobal,
    );
  }
}

