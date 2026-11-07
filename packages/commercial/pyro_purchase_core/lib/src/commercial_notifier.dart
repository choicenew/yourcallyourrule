import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_purchase_protocol/pyro_purchase_protocol.dart';
import 'data/commercial_local_data_source.dart';

part 'commercial_notifier.g.dart';

/// 遵照 Riverpod 3 标准规范的商业变现与特权状态控制器 (AsyncNotifier)
/// 异步控制模式彻底解决冷启动非 VIP 闪烁 Bug，保证状态响应一致性
@Riverpod(keepAlive: true)
class CommercialNotifier extends _$CommercialNotifier {
  @override
  Future<CommercialState> build() async {
    final dataSource = ref.watch(commercialLocalDataSourceProvider);
    return await dataSource.loadCommercialState();
  }

  /// 便捷属性读取（用于非 Widget 上下文下的安全读取，如 Engine 同步触发）
  bool get isPurchased => state.value?.isPurchased ?? false;
  bool get isVip => isPurchased;
  bool get hasTempPurchase => state.value?.isAdFree ?? false;
  DateTime? get tempPurchaseExpiryDate => state.value?.tempExpiryDate;

  /// 更新真金白银付费开通状态
  Future<void> updatePurchasedStatus(bool isPurchased) async {
    final dataSource = ref.read(commercialLocalDataSourceProvider);
    await dataSource.savePurchasedStatus(isPurchased);

    final current = state.value ?? const CommercialState();
    state = AsyncValue.data(current.copyWith(isPurchased: isPurchased));
  }

  /// 授予/展期临时免广告/特权（如看激励视频获得的 VIP）
  Future<void> grantTempAdFree(DateTime expiryDate) async {
    final dataSource = ref.read(commercialLocalDataSourceProvider);
    await dataSource.saveTempAdFreeStatus(true, expiryDate);

    final current = state.value ?? const CommercialState();
    state = AsyncValue.data(current.copyWith(
      isAdFree: true,
      tempExpiryDate: expiryDate,
    ));
  }

  /// 兼容旧方法名 updatePurchaseState
  Future<void> updatePurchaseState(bool isPurchased) => updatePurchasedStatus(isPurchased);

  /// 兼容旧方法名 updateTempPurchaseState
  Future<void> updateTempPurchaseState(bool hasTempPurchase, DateTime expiryDate) async {
    final dataSource = ref.read(commercialLocalDataSourceProvider);
    await dataSource.saveTempAdFreeStatus(hasTempPurchase, expiryDate);

    final current = state.value ?? const CommercialState();
    state = AsyncValue.data(current.copyWith(
      isAdFree: hasTempPurchase,
      tempExpiryDate: expiryDate,
    ));
  }
}

/// 别名定义：对齐标准的 Provider 命名规则
const commercialNotifierProvider = commercialProvider;

/// 向后平滑兼容：将 PurchaseState 重定向为 CommercialNotifier 别名
@Deprecated('使用 CommercialNotifier 替代')
typedef PurchaseState = CommercialNotifier;

/// 向后平滑兼容：将 purchaseStateProvider 重定向为 commercialNotifierProvider
@Deprecated('使用 commercialNotifierProvider 替代')
final purchaseStateProvider = commercialNotifierProvider;
