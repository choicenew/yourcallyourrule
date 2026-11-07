import '../models/matrix_app_item.dart';

/// 渲染模式：主 App 内购还是兄弟 App 交叉导流
enum HouseAdRenderMode {
  /// 主 App VIP / 内购特权促销
  primaryIap,

  /// 兄弟 App Google Play 交叉导流
  crossPromotion,
}

/// 判定后的广告决策单元
class HouseAdDecision {
  final MatrixAppItem item;
  final HouseAdRenderMode mode;
  final bool isPrimary;

  const HouseAdDecision({
    required this.item,
    required this.mode,
    required this.isPrimary,
  });
}

/// 矩阵广告仲裁器 (Matrix Ad Arbitrator)
/// 负责根据当前宿主 App 包名进行自动自洽分流。
class MatrixAdArbitrator {
  final String currentPackageName;
  final List<MatrixAppItem> allApps;

  MatrixAppItem? _primaryApp;
  final List<MatrixAppItem> _crossPromoApps = [];

  MatrixAdArbitrator({
    required this.currentPackageName,
    required List<MatrixAppItem> matrixApps,
  }) : allApps = List.unmodifiable(matrixApps) {
    _arbitrate();
  }

  void _arbitrate() {
    _crossPromoApps.clear();
    for (final app in allApps) {
      if (app.packageName == currentPackageName) {
        _primaryApp = app;
      } else {
        _crossPromoApps.add(app);
      }
    }
  }

  /// 当前主 App 实体 (用于生成 VIP / 内购广告)
  MatrixAppItem? get primaryApp => _primaryApp;

  /// 兄弟 App 导流列表 (剔除了当前 App 自身)
  List<MatrixAppItem> get crossPromoApps => _crossPromoApps;

  /// 生成决策单元
  HouseAdDecision createDecision(MatrixAppItem item) {
    final isPrimary = item.packageName == currentPackageName;
    return HouseAdDecision(
      item: item,
      mode: isPrimary ? HouseAdRenderMode.primaryIap : HouseAdRenderMode.crossPromotion,
      isPrimary: isPrimary,
    );
  }
}
