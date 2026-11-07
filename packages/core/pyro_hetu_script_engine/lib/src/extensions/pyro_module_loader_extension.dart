import 'package:flutter/foundation.dart';
import 'package:hetu_script/hetu_script.dart';

import '../sdk/pyro_sdk_precompiled_modules.dart';

/// 模块描述配置项
class PyroModuleEntry {
  final String moduleName;
  final String assetPath;
  final bool isGlobal;

  const PyroModuleEntry({
    required this.moduleName,
    required this.assetPath,
    this.isGlobal = false,
  });
}

/// 针对 [Hetu] 的模块与字节码加载扩展维护工具 (纯二进制字节码装载，0-eval，0 毫秒启动)
extension PyroHetuModuleLoaderExtension on Hetu {
  /// 预设的标准库模块列表
  static const List<PyroModuleEntry> standardModules = [
    PyroModuleEntry(
      moduleName: 'base32',
      assetPath: 'module:base32',
    ),
    PyroModuleEntry(
      moduleName: 'base64',
      assetPath: 'module:base64',
    ),
    PyroModuleEntry(
      moduleName: 'crypto',
      assetPath: 'module:crypto',
    ),
    PyroModuleEntry(
      moduleName: 'datetime',
      assetPath: 'module:datetime',
    ),
    PyroModuleEntry(
      moduleName: 'http',
      assetPath: 'module:http',
    ),
    PyroModuleEntry(
      moduleName: 'regex',
      assetPath: 'module:regex',
    ),
    PyroModuleEntry(
      moduleName: 'timer',
      assetPath: 'module:timer',
    ),
    PyroModuleEntry(
      moduleName: 'util',
      assetPath: 'module:util',
    ),
    PyroModuleEntry(
      moduleName: 'future',
      assetPath: 'module:future',
    ),
    PyroModuleEntry(
      moduleName: 'utf8',
      assetPath: 'module:utf8',
    ),
  ];

  /// 预设的宿主 SDK 模块列表
  static const List<PyroModuleEntry> sdkModules = [
    PyroModuleEntry(
      moduleName: 'host_webview',
      assetPath: 'module:webview',
    ),
    PyroModuleEntry(
      moduleName: 'host_user',
      assetPath: 'module:user',
    ),
    PyroModuleEntry(
      moduleName: 'host_config',
      assetPath: 'module:config',
    ),
    PyroModuleEntry(
      moduleName: 'host_storage',
      assetPath: 'module:storage',
    ),
  ];

  /// 加载单个预编译字节码模块 (纯内存 0-eval)
  Future<void> loadPyroAssetModule(
    String assetPath, {
    String? moduleName,
    bool isGlobal = false,
  }) async {
    final moduleIdentity = moduleName ?? assetPath;
    try {
      final bytes = PyroSdkPrecompiledModules.bytecodes[assetPath] ??
          PyroSdkPrecompiledModules.bytecodes['module:$assetPath'];

      if (bytes != null && bytes.isNotEmpty) {
        loadBytecode(
          bytes: bytes,
          module: moduleIdentity,
          globallyImport: isGlobal,
        );
      } else {
        debugPrint("[PyroHetuEngine] ⚠️ 预编译字节码字典中未找到模块: '$assetPath'");
      }
    } catch (e) {
      debugPrint(
        "[PyroHetuEngine] Failed to load bytecode module '$moduleIdentity' from '$assetPath': $e",
      );
    }
  }

  /// 批量装载全量 Pyro 预编译二进制字节码 (0 毫秒启动，零 eval，零 AST 编译开销)
  Future<void> loadAllPyroBuiltinModules() async {
    // 1. 预先向 VM interpreter 的 cachedModules 注入所有预编译字节码 (0 毫秒完成)
    for (final entry in PyroSdkPrecompiledModules.bytecodes.entries) {
      final moduleUri = entry.key;
      final bytes = entry.value;

      if (!interpreter.cachedModules.containsKey(moduleUri)) {
        loadBytecode(
          bytes: bytes,
          module: moduleUri,
          globallyImport: false,
        );
      }
    }

    // 2. 按照拓扑依赖关系，评估装载 21 个核心独立预编译模块并全局导入
    final loadOrder = [
      'module:base32',
      'module:base64',
      'module:crypto',
      'module:datetime',
      'module:future',
      'module:regex',
      'module:timer',
      'module:utf8',
      'module:util',
      'module:battery',
      'module:device',
      'module:html',
      'module:native_context',
      'module:storage',
      'module:config',
      'module:translation',
      'module:usage',
      'module:user',
      'module:weather',
      'module:webview',
      'module:http',
    ];

    for (final moduleUri in loadOrder) {
      final bytes = PyroSdkPrecompiledModules.bytecodes[moduleUri];
      if (bytes != null) {
        loadBytecode(
          bytes: bytes,
          module: moduleUri,
          globallyImport: true,
        );
      }
    }
  }
}
