/// 任务优先级定义
enum TaskPriority {
  /// 用户当前直接交互强依赖任务（如可视页漫画解码、高亮保存），优先插队
  immediate(100),

  /// 界面呈现关联计算（如候选集重排、动态探索熵、选词查词）
  userInteractive(50),

  /// 静默后台任务（如网盘快照冷备加解密、CRDT 增量比对、RSS 大 XML 抓取清洗）
  background(10);

  final int weight;
  const TaskPriority(this.weight);
}
