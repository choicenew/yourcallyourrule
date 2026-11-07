import 'priority.dart';

/// 纯函数无状态计算任务契约 (WorkerTask)
///
/// 供微包定义一过性纯计算任务（如 XML 解析、加解密、矩阵余弦相似度重排）。
/// [Input] 与 [Output] 必须为基本类型或可跨 Isolate 传递的纯 DTO。
abstract class WorkerTask<Input, Output> {
  final String taskName;
  final TaskPriority priority;

  const WorkerTask({
    required this.taskName,
    this.priority = TaskPriority.userInteractive,
  });

  /// 顶级或静态纯函数逻辑（必须是可跨 Isolate 调用的独立逻辑）
  Output execute(Input input);
}
