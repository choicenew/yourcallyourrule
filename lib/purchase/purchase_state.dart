import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yourcallyourrule/core/provider/providers/config_repository_provider.dart';
// 关键：导入包含 `configRepositoryProvider` 的文件

import 'package:yourcallyourrule/data/repositories/config/config_repository.dart';

// 链接到将要生成的代码文件
part 'purchase_state.g.dart';

// PurchaseStateModel 状态类定义完美，无需任何改动。
class PurchaseStateModel {
  final bool isPurchasesEnabled;
  final bool hasTempPurchase;
  final DateTime? tempPurchaseExpiryDate;

  const PurchaseStateModel({
    this.isPurchasesEnabled = false,
    this.hasTempPurchase = false,
    this.tempPurchaseExpiryDate,
  });

  // 创建状态的副本并更新特定字段
  PurchaseStateModel copyWith({
    bool? isPurchasesEnabled,
    bool? hasTempPurchase,
    DateTime? tempPurchaseExpiryDate,
  }) {
    return PurchaseStateModel(
      isPurchasesEnabled: isPurchasesEnabled ?? this.isPurchasesEnabled,
      hasTempPurchase: hasTempPurchase ?? this.hasTempPurchase,
      tempPurchaseExpiryDate: tempPurchaseExpiryDate ?? this.tempPurchaseExpiryDate,
    );
  }

  // 判断是否已购买或有临时访问权限
  bool isPurchasedOrHasTempAccess() {
    return isPurchasesEnabled || hasTempPurchase;
  }
}


/// 使用 @riverpod 注解，将旧的 StateNotifier 迁移为现代的 Notifier。
/// 这个 Notifier 负责管理和持久化应用的所有购买相关状态。
///
/// keepAlive: true 确保状态在整个应用生命周期内保持活动，
/// 不会因为用户导航离开相关页面而被重置。
@Riverpod(keepAlive: true)
class PurchaseState extends _$PurchaseState {
  
  // 将依赖声明为私有字段，确保其在 Notifier 内部的封装性。
  late final ConfigRepository _configRepository;

  /// `build` 方法是 Notifier 的初始化核心。
  /// 它在 Provider 第一次被读取时执行，用于设置初始状态和依赖。
  @override
  PurchaseStateModel build() {
    // 【最佳实践】: 使用 ref.read 从您已经定义的 `configRepositoryProvider` 中获取依赖。
    // 这完美地实现了依赖注入，使得 PurchaseState 不再关心 ConfigRepository 的具体实现
    // (是 SharedPreferences 还是未来的其他实现)，也极大地简化了测试。
    _configRepository = ref.read(configRepositoryProvider);

    // 在 Provider 初始化时，立即异步加载持久化的状态。
    // 这样可以确保用户一打开应用，就能看到正确的会员状态。
    loadState();

    // `build` 必须同步返回一个初始状态。
    // 在 `loadState` 的 Future 完成之前，UI 将使用这个默认的、非会员的状态。
    return const PurchaseStateModel();
  }
  
  // --- 公共 Getter ---  // 获取当前购买状态
  // 这些 Getter 提供了对当前状态的便捷访问，UI 可以通过
  // `ref.watch(purchaseStateProvider).isPurchasesEnabled` 来安全地读取。
  bool get isPurchasesEnabled => state.isPurchasesEnabled;
  bool get hasTempPurchase => state.hasTempPurchase;
  DateTime? get tempPurchaseExpiryDate => state.tempPurchaseExpiryDate;
  // 判断是否已购买或有临时访问权限
  bool isPurchasedOrHasTempAccess() => state.isPurchasedOrHasTempAccess();

  // --- 内部使用的常量 ---  // 配置键名
  static const String _isPurchasesEnabledKey = 'config_isPurchasesEnabled';
  static const String _hasTempPurchaseKey = 'config_hasTempPurchase';
  static const String _tempPurchaseExpiryDateKey = 'config_tempPurchaseExpiryDate';

  /// 从持久化存储（由 ConfigRepository 提供）中加载状态。
  Future<void> loadState() async {
    final isPurchasedConfig = await _configRepository.getConfig(_isPurchasesEnabledKey);
    final isPurchasesEnabled = isPurchasedConfig?['value'] as bool? ?? false;
    
    final hasTempConfig = await _configRepository.getConfig(_hasTempPurchaseKey);
    final hasTempPurchase = hasTempConfig?['value'] as bool? ?? false;
    
    final expiryConfig = await _configRepository.getConfig(_tempPurchaseExpiryDateKey);
    final expiryTimestamp = expiryConfig?['value'] as int?;
    DateTime? tempPurchaseExpiryDate;
    if (expiryTimestamp != null) {
      tempPurchaseExpiryDate = DateTime.fromMillisecondsSinceEpoch(expiryTimestamp);
    }
    
    // `state` 是 Notifier 基类提供的属性。给它赋一个新值会自动通知所有监听者进行重建。
    state = PurchaseStateModel(
      isPurchasesEnabled: isPurchasesEnabled,
      hasTempPurchase: hasTempPurchase,
      tempPurchaseExpiryDate: tempPurchaseExpiryDate,
    );
  }

  /// 更新永久购买状态，并将其保存到持久化存储。
  Future<void> updatePurchaseState(bool isPurchased) async {
    state = state.copyWith(isPurchasesEnabled: isPurchased);
    await _configRepository.saveConfig(_isPurchasesEnabledKey, {'value': isPurchased});
  }

  /// 更新临时会员状态，并将其和过期时间保存到持久化存储。
  Future<void> updateTempPurchaseState(bool hasTempPurchase, DateTime expiryDate) async {
    state = state.copyWith(
      hasTempPurchase: hasTempPurchase,
      tempPurchaseExpiryDate: expiryDate,
    );
    await _configRepository.saveConfig(_hasTempPurchaseKey, {'value': hasTempPurchase});
    await _configRepository.saveConfig(_tempPurchaseExpiryDateKey, {'value': expiryDate.millisecondsSinceEpoch});
  }
}

// 您之前手写的 `final purchaseStateProvider = ...` 已不再需要，
// `@Riverpod` 注解会为您自动生成一个名为 `purchaseStateProvider` 的全局 Provider。