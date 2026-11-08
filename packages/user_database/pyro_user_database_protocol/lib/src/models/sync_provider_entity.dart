import 'package:flutter/widgets.dart';

/// 纯抽象 Sync Provider 实体契约 (0 集中式 enum，跨 Package 0 类型冲突，0 字符串)
abstract class SyncProviderEntity {
  /// 强类型 Class Token 标识 (由实体子类本身充当)
  Type get entityToken => runtimeType;

  /// 🌐 传入 BuildContext 延迟获取多语言文本 (零子类 import，零 switch)
  String Function(BuildContext context) get titleBuilder;

  IconData get icon;
  Color get themeColor;

  /// 实体自带的测试网络连通性能力
  Future<bool> testConnection();
}
