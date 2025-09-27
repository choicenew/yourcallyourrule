// 这里【不需要】任何 riverpod_annotation 的导入和 part 文件！
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 确保导入了正确的 state provider
import 'package:yourcallyourrule/ads/ad_state.dart';
import 'package:yourcallyourrule/purchase/purchase_state.dart';

/// 广告控制服务 - 最终的 Riverpod 版本
///
/// 这是一个纯粹的 Dart 服务类。它不是一个 Notifier，也不管理任何自己的状态。
/// 它的职责是作为协调者，监听外部状态（购买状态），并据此调用其他 Notifier 的方法（广告状态）。
class AdControlService {
  final Ref _ref;

  // 构造函数只接收 Ref，这是它与 Riverpod 系统交互的唯一方式。
  AdControlService(this._ref) {
    // 【核心响应式逻辑】
    // 在服务实例被创建时，立即启动一个监听器。
    // `ref.listen` 会观察 `purchaseStateProvider` 的状态值 (PurchaseStateModel)。
    // 每当购买状态发生变化，下面的回调函数就会被自动触发。
    _ref.listen<PurchaseStateModel>(purchaseStateProvider, (previousState, newState) {
      // 当监听到变化时，调用内部方法来更新广告状态。
      _updateAdStateBasedOnPurchase(newState);
    });
    
    // 【初始化逻辑】
    // 在服务首次创建时，也需要根据当前的购买状态立即执行一次更新，
    // 以确保应用启动时的广告状态是正确的。
    _updateAdStateBasedOnPurchase(_ref.read(purchaseStateProvider));
  }

  /// 私有方法：根据购买状态，自动更新 AdState
  void _updateAdStateBasedOnPurchase(PurchaseStateModel purchaseState) {
    // 【正确用法】: 使用 ref.read(provider.notifier) 来获取 Notifier 实例，以便调用其方法。
    final adStateNotifier = _ref.read(adStateProvider.notifier);

    if (purchaseState.isPurchasedOrHasTempAccess()) {
      // 如果用户已购买或有临时权限，则调用 adStateNotifier 的方法来禁用广告。
      adStateNotifier.disableAds();
    } else {
      // 否则，调用 adStateNotifier 的方法来启用广告。
      adStateNotifier.enableAds();
    }
  }

  // ##########################################################################
  // ## 您原有的、被我错误删除的公共方法 - 现已完整恢复
  // ##########################################################################

  /// 检查广告是否应该显示
  /// (此方法完整保留，与您原来的逻辑完全一致)
  bool shouldShowAds() {
    // 首先，读取当前的购买状态
    final purchaseState = _ref.read(purchaseStateProvider);
    // 然后，读取当前的广告启用状态
    final adState = _ref.read(adStateProvider);

    // 如果用户已购买或有临时访问权限，则不显示广告
    if (purchaseState.isPurchasedOrHasTempAccess()) {
      return false;
    }
    // 否则根据广告状态决定是否显示广告
    return adState; // adState 本身就是 bool 值
  }

  /// 禁用广告
  /// (此方法完整保留)
  void disableAds() {
    _ref.read(adStateProvider.notifier).disableAds();
  }

  /// 启用广告
  /// (此方法完整保留，与您原来的逻辑完全一致)
  void enableAds() {
    // 读取当前购买状态
    final purchaseState = _ref.read(purchaseStateProvider);
    // 只有在用户未购买且没有临时访问权限时才能启用广告
    if (!purchaseState.isPurchasedOrHasTempAccess()) {
      _ref.read(adStateProvider.notifier).enableAds();
    }
  }

  /// 切换广告状态
  /// (此方法完整保留，与您原来的逻辑完全一致)
  void toggleAdState() {
    // 读取当前广告启用状态
    final isAdEnabled = _ref.read(adStateProvider);
    if (isAdEnabled) {
      disableAds();
    } else {
      enableAds();
    }
  }
}

// ##########################################################################
// ## 服务提供者 (Provider 定义) - 无需修改
// ##########################################################################

/// 这个 Provider 的作用是创建并提供一个 `AdControlService` 的单例。
/// 它是一个简单的 `Provider`，不是 `NotifierProvider`。
final adControlServiceProvider = Provider.autoDispose<AdControlService>((ref) {
  // `autoDispose` 在这里是安全的，因为如果服务不再被任何地方需要，
  // 重新需要时会创建一个新的实例并重新启动监听。
  // 如果您希望服务永不销毁，可以移除 `.autoDispose`。
  return AdControlService(ref);
});
