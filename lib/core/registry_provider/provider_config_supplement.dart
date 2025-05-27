import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:yourcallyourrule/core/provider/basic_provider/call_log_repository_provider.dart';
import 'package:yourcallyourrule/data/database/database_service.dart';
import 'package:yourcallyourrule/features/call/call_history/services/call_log_recorder.dart';
import 'package:yourcallyourrule/features/call/call_history/services/call_log_service.dart';

/// 这个文件展示如何在 provider_config.dart 中添加 CallLogRecorder
/// 实际使用时，应该将这些代码集成到 provider_config.dart 文件中

/// 获取应用提供者列表，包含 CallLogRecorder
List<SingleChildStatelessWidget> getAppProvidersWithCallLogRecorder() {
  // 初始化核心服务（从原始 provider_config.dart 复制）
  final databaseService = DatabaseService();
  final callLogRepository = CallLogRepositoryImpl(databaseService);
  // 初始化 CallLogService（从原始 provider_config.dart 复制）
  // final callLogService = CallLogService(callLogRepository);
   final callLogService = CallLogService(callLogRepository);
  // 初始化 CallLogRecorder（新增）
  final callLogRecorder = CallLogRecorder(callLogService);
  
  // 其他服务初始化（从原始 provider_config.dart 复制）
  // ...
  
  // 返回提供者列表
  return [
    // 原有的提供者（从原始 provider_config.dart 复制）
    // ...
    
    // 添加 CallLogRecorder 提供者（新增）
    Provider<CallLogRecorder>.value(value: callLogRecorder),
    
    // 其他提供者（从原始 provider_config.dart 复制）
    // ...
  ];
}

/// 如何在代码中获取 CallLogRecorder 实例
/// 示例代码
void exampleUsage() {
  // 使用 Provider.of 获取实例
  // final callLogRecorder = Provider.of<CallLogRecorder>(context, listen: false);
  
  // 使用 Consumer 获取实例
  // Consumer<CallLogRecorder>(
  //   builder: (context, callLogRecorder, child) {
  //     // 使用 callLogRecorder
  //     return Container();
  //   },
  // );
}