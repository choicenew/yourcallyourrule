import 'package:flutter/foundation.dart';
import 'package:hetu_script/hetu_script.dart';

/// 统一将河图内部日志路由到 Flutter [debugPrint] 的实现，规避原生 print
class PyroHetuLogger extends HTLogger {
  final bool enableDebug;

  const PyroHetuLogger({this.enableDebug = true});

  @override
  void log(String message, {MessageSeverity severity = MessageSeverity.none}) {
    if (severity == MessageSeverity.debug && !enableDebug) {
      return;
    }
    final prefix = switch (severity) {
      MessageSeverity.debug => '[Hetu:DEBUG]',
      MessageSeverity.info => '[Hetu:INFO]',
      MessageSeverity.warning => '[Hetu:WARN]',
      MessageSeverity.error => '[Hetu:ERROR]',
      _ => '[Hetu]',
    };
    debugPrint('$prefix $message');
  }
}

/// 针对 [HetuConfig] 的扩展维护工具
extension PyroHetuConfigExtension on HetuConfig {
  /// 创建适合 Pyro 运行时的默认配置
  static HetuConfig createDefault({
    bool? debugMode,
    bool doStaticAnalysis = false,
  }) {
    final isDebug = debugMode ?? kDebugMode;
    return HetuConfig(
      debugMode: isDebug,
      doStaticAnalysis: doStaticAnalysis,
      showHetuStackTrace: isDebug,
      showDartStackTrace: isDebug,
      stackTraceDisplayCountLimit: 10,
      processError: true,
    );
  }
}
