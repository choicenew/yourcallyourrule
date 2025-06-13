import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:yourcallyourrule/core/services/firebase_crashlytics_service.dart';

/// 增强版日志服务，支持多级别日志和文件输出
/// 集成Firebase Crashlytics进行错误报告
class AppLogger {
  static late final Logger _logger;
  static File? _logFile;
  static final _crashlyticsService = FirebaseCrashlyticsService();

  static void initialize() {
    final List<LogOutput> outputs = [ConsoleOutput()];
    
    if (kDebugMode) {
      _getLogFilePath().then((logFile) {
        if (logFile != null) {
          _logFile = logFile;
          outputs.add(FileOutput(file: _logFile!));
        }
      });
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
  static void verbose(String message) => _logger.t(message);

  /// 记录调试信息
  static void debug(String message) => _logger.d(message);

  /// 记录普通信息
  static void info(String message) => _logger.i(message);

  /// 记录警告信息
  static void warning(String message) => _logger.w(message);

  /// 记录错误信息（含堆栈跟踪）
  static void error(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.e(message, error: error, stackTrace: stackTrace);
    _reportCrash(message, error, stackTrace);
  }

  /// 记录致命错误信息（含堆栈跟踪），并强制崩溃
  static void fatal(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.f(message, error: error, stackTrace: stackTrace);
    _reportCrash(message, error, stackTrace, fatal: true);
  }

  static Future<File?> _getLogFilePath() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final logDir = Directory('${directory.path}/logs');
      if (!logDir.existsSync()) {
        logDir.createSync(recursive: true);
      }
      return File('${logDir.path}/app.log');
    } catch (e) {
      debugPrint('Error getting log file path: $e');
      return null;
    }
  }

  /// 获取日志文件内容
  static Future<String?> getLogContent() async {
    if (_logFile != null && await _logFile!.exists()) {
      return await _logFile!.readAsString();
    }
    return null;
  }

  /// 清空日志文件
  static Future<void> clearLogFile() async {
    if (_logFile != null && await _logFile!.exists()) {
      await _logFile!.delete();
    }
  }

  /// 向Firebase Crashlytics报告错误
  static void _reportCrash(String message, dynamic error, StackTrace? stackTrace, {bool fatal = false}) {
    // 添加自定义日志消息
    _crashlyticsService.log(message);
    
    // 记录错误
    _crashlyticsService.recordError(
      error, 
      stackTrace ?? StackTrace.current,
      fatal: fatal
    );
  }
  
  /// 设置用户标识符
  static Future<void> setUserIdentifier(String identifier) async {
    await _crashlyticsService.setUserIdentifier(identifier);
  }
  
  /// 添加自定义键值对到Crashlytics报告
  static Future<void> setCustomKey(String key, dynamic value) async {
    await _crashlyticsService.setCustomKey(key, value);
  }
}
