import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/data/repositories/config/config_repository.dart';

// 定义 PurchaseState 的状态类
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

// 使用 StateNotifier 替代 ChangeNotifier
class PurchaseState extends StateNotifier<PurchaseStateModel> {
  final ConfigRepository _configRepository;
  
  PurchaseState({ConfigRepository? configRepository})
      : _configRepository = configRepository ?? SharedPreferencesConfigRepository(),
        super(const PurchaseStateModel());

  // 获取当前购买状态
  bool get isPurchasesEnabled => state.isPurchasesEnabled;
  bool get hasTempPurchase => state.hasTempPurchase;
  DateTime? get tempPurchaseExpiryDate => state.tempPurchaseExpiryDate;

  // 判断是否已购买或有临时访问权限
  bool isPurchasedOrHasTempAccess() {
    return state.isPurchasedOrHasTempAccess();
  }

  // 加载状态
  Future<void> loadState() async {
    final isPurchasedConfig = await _configRepository.getConfig('isPurchasesEnabled');
    final isPurchasesEnabled = isPurchasedConfig?['value'] as bool? ?? false;
    
    final hasTempConfig = await _configRepository.getConfig('hasTempPurchase');
    final hasTempPurchase = hasTempConfig?['value'] as bool? ?? false;
    
    final expiryConfig = await _configRepository.getConfig('tempPurchaseExpiryDate');
    final expiryTimestamp = expiryConfig?['value'] as int?;
    DateTime? tempPurchaseExpiryDate;
    if (expiryTimestamp != null) {
      tempPurchaseExpiryDate = DateTime.fromMillisecondsSinceEpoch(expiryTimestamp);
    }

    // 更新状态
    state = PurchaseStateModel(
      isPurchasesEnabled: isPurchasesEnabled,
      hasTempPurchase: hasTempPurchase,
      tempPurchaseExpiryDate: tempPurchaseExpiryDate,
    );
  }

  // 更新购买状态
  Future<void> updatePurchaseState(bool isPurchased) async {
    state = state.copyWith(isPurchasesEnabled: isPurchased);
    await _configRepository.saveConfig('isPurchasesEnabled', {'value': isPurchased});
  }

  // 更新临时购买状态
  Future<void> updateTempPurchaseState(bool hasTempPurchase, DateTime expiryDate) async {
    state = state.copyWith(
      hasTempPurchase: hasTempPurchase,
      tempPurchaseExpiryDate: expiryDate,
    );
    await _configRepository.saveConfig('hasTempPurchase', {'value': hasTempPurchase});
    await _configRepository.saveConfig('tempPurchaseExpiryDate', {'value': expiryDate.millisecondsSinceEpoch});
  }
}

// 创建 PurchaseState 的 Provider
final purchaseStateProvider = StateNotifierProvider<PurchaseState, PurchaseStateModel>((ref) {
  return PurchaseState();
});