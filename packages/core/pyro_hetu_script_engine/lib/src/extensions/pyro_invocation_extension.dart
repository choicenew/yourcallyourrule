import 'package:flutter/foundation.dart';
import 'package:hetu_script/hetu_script.dart';

/// 针对 [Hetu] 的安全调用与环境交互扩展维护工具
extension PyroHetuInvocationExtension on Hetu {
  /// 安全调用函数，支持忽略未定义方法 [ignoreUndefined] 与命名空间过滤
  dynamic safeInvoke(
    String funcName, {
    String? moduleName,
    String? namespace,
    List<dynamic> positionalArgs = const [],
    Map<String, dynamic> namedArgs = const {},
    bool ignoreUndefined = true,
  }) {
    try {
      return invoke(
        funcName,
        module: moduleName,
        namespace: namespace,
        positionalArgs: positionalArgs,
        namedArgs: namedArgs,
        ignoreUndefined: ignoreUndefined,
      );
    } catch (e, stack) {
      debugPrint('[PyroHetuEngine] safeInvoke error on $funcName: $e\n$stack');
      return null;
    }
  }

  /// 异步安全调用函数，自动处理 Future 返回值并 await
  Future<dynamic> invokeAsync(
    String funcName, {
    String? moduleName,
    String? namespace,
    List<dynamic> positionalArgs = const [],
    Map<String, dynamic> namedArgs = const {},
    bool ignoreUndefined = true,
  }) async {
    final result = safeInvoke(
      funcName,
      moduleName: moduleName,
      namespace: namespace,
      positionalArgs: positionalArgs,
      namedArgs: namedArgs,
      ignoreUndefined: ignoreUndefined,
    );
    if (result is Future) {
      return await result;
    }
    return result;
  }

  /// 向河图命名空间注入全局变量/常量
  void defineValue(
    String id,
    dynamic value, {
    bool isMutable = false,
    bool override = true,
    String? module,
  }) {
    define(
      id,
      value,
      isMutable: isMutable,
      override: override,
      throws: false,
      module: module,
    );
  }

  /// 获取河图命名空间中的变量
  dynamic fetchValue(
    String id, {
    String? namespace,
    String? module,
  }) {
    return fetch(
      id,
      namespace: namespace,
      module: module,
      ignoreUndefined: true,
    );
  }

  /// 为河图命名空间中的变量重新赋值
  void assignValue(
    String id,
    dynamic value, {
    String? namespace,
    String? module,
    bool defineIfAbsent = false,
  }) {
    assign(
      id,
      value,
      namespace: namespace,
      module: module,
      defineIfAbsent: defineIfAbsent,
    );
  }
}
