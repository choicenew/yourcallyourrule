import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

/// 增强版日志服务，支持多级别日志和文件输出
class AppLogger {
  static late final Logger _logger;
  static File? _logFile;

  static void initialize() {
    final List<LogOutput> outputs = [ConsoleOutput()];
    
    if (kDebugMode) {
      final logDir = Directory('logs');
      if (!logDir.existsSync()) {
        logDir.createSync(recursive: true);
      }
      _logFile = File('${logDir.path}/app.log');
      outputs.add(FileOutput(file: _logFile!));
    }

    _logger = Logger(
      filter: ProductionFilter(),
      printer: PrettyPrinter(
        methodCount: 0,
        errorMethodCount: 5,
        colors: false,
      ),
      output: MultiOutput(outputs),
    );
  }

  /// 记录详细调试信息 
  static void verbose(String message) => _logger.v(message);

  /// 记录调试信息
  static void debug(String message) => _logger.d(message);

  /// 记录普通信息
  static void info(String message) => _logger.i(message);

  /// 记录警告信息
  static void warning(String message) => _logger.w(message);

  /// 记录错误信息（含堆栈跟踪）
  static void error(String message, [dynamic error, StackTrace? stackTrace]) =>
      _logger.e(message, error: error, stackTrace: stackTrace);

  /// 记录严重错误并上报
  static void fatal(String message, {required dynamic error}) {
    _logger.f(message, error: error);
    // 生产环境上报逻辑
    if (!kDebugMode) {
      _reportCrash(error);
    }
  }

  static void _reportCrash(dynamic error) {
    // 实际集成Sentry/Firebase Crashlytics
  }
}
