import 'dart:math';
import '../models/matrix_app_item.dart';
import '../models/user_ad_state.dart';
import 'matrix_ad_arbitrator.dart';

/// 自家广告调度与轮播引擎
class HouseAdScheduler {
  final MatrixAdArbitrator arbitrator;
  final Random _random;
  String? _lastShownPackage;

  HouseAdScheduler({
    required this.arbitrator,
    Random? random,
  }) : _random = random ?? Random();

  /// 根据用户生命周期状态（newUser / active / churnRisk）抽取下一个最佳展示广告
  HouseAdDecision selectNextAd({
    UserAdState userState = UserAdState.active,
    int? primaryIapWeightOverride,
  }) {
    final primary = arbitrator.primaryApp;
    final crossApps = arbitrator.crossPromoApps;

    // 1. 如果没有兄弟 App，只能出主 App VIP
    if (crossApps.isEmpty && primary != null) {
      return arbitrator.createDecision(primary);
    }

    // 2. 如果没有主 App，只能在兄弟 App 中随机
    if (primary == null && crossApps.isNotEmpty) {
      final selected = _selectWeighted(crossApps);
      return arbitrator.createDecision(selected);
    }

    // 3. 两者兼有：根据用户状态计算 VIP vs 交叉导流的分配比例
    int primaryWeight = primaryIapWeightOverride ?? primary!.weight;
    switch (userState) {
      case UserAdState.newUser:
        // 新用户偏向展示本 App VIP 建立品牌认知
        primaryWeight = (primaryWeight * 1.5).toInt();
        break;
      case UserAdState.active:
        // 正常按配置权重轮播
        break;
      case UserAdState.churnRisk:
        // 流失风险用户优先挽留促销 (高权重 VIP)
        primaryWeight = (primaryWeight * 2.0).toInt();
        break;
    }

    // 汇总所有候选池 (主 App + 兄弟 Apps)
    final candidatePool = <_WeightedCandidate>[
      _WeightedCandidate(app: primary!, weight: primaryWeight, isPrimary: true),
      ...crossApps.map((app) => _WeightedCandidate(app: app, weight: app.weight, isPrimary: false)),
    ];

    // 轮播权重抽取 (尽量避开上一次刚展示过的 Package)
    final selectedApp = _pickCandidate(candidatePool);
    _lastShownPackage = selectedApp.packageName;

    return arbitrator.createDecision(selectedApp);
  }

  MatrixAppItem _selectWeighted(List<MatrixAppItem> apps) {
    if (apps.length == 1) return apps.first;

    // 过滤掉上次展示的 (如果还有其他选项)
    final pool = apps.where((a) => a.packageName != _lastShownPackage).toList();
    final effectiveList = pool.isNotEmpty ? pool : apps;

    final totalWeight = effectiveList.fold<int>(0, (sum, a) => sum + a.weight);
    if (totalWeight <= 0) return effectiveList.first;

    int randomValue = _random.nextInt(totalWeight);
    for (final app in effectiveList) {
      if (randomValue < app.weight) {
        return app;
      }
      randomValue -= app.weight;
    }
    return effectiveList.last;
  }

  MatrixAppItem _pickCandidate(List<_WeightedCandidate> candidates) {
    final pool = candidates.where((c) => c.app.packageName != _lastShownPackage).toList();
    final effective = pool.isNotEmpty ? pool : candidates;

    final totalWeight = effective.fold<int>(0, (sum, c) => sum + c.weight);
    if (totalWeight <= 0) return effective.first.app;

    int randomValue = _random.nextInt(totalWeight);
    for (final candidate in effective) {
      if (randomValue < candidate.weight) {
        return candidate.app;
      }
      randomValue -= candidate.weight;
    }
    return effective.last.app;
  }
}

class _WeightedCandidate {
  final MatrixAppItem app;
  final int weight;
  final bool isPrimary;

  _WeightedCandidate({
    required this.app,
    required this.weight,
    required this.isPrimary,
  });
}
