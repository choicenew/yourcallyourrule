import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/ads/ad_state.dart';
import 'package:yourcallyourrule/purchase/purchase_state.dart';

/// 广告控制服务 - Riverpod 版本
/// 负责根据购买状态自动控制广告的显示和隐藏
/// 这个服务应该在应用启动时初始化，并监听PurchaseState的变化
class AdControlService {
  final Ref _ref;
  final AdState _adState;
  final PurchaseState _purchaseState;

  AdControlService({
    required Ref ref,
    required AdState adState,
    required PurchaseState purchaseState,
  })
      : _ref = ref,
        _adState = adState,
        _purchaseState = purchaseState {
    // 初始化时根据购买状态设置广告状态
    _updateAdState();
    
    // 监听购买状态变化
    // 在 Riverpod 中，我们不需要显式添加监听器，因为我们使用 ref.watch 来自动响应状态变化
  }

  /// 更新广告状态
  /// 根据购买状态自动控制广告的显示和隐藏
  void _updateAdState() {
    if (_purchaseState.isPurchasedOrHasTempAccess()) {
      // 如果用户已购买或有临时访问权限，禁用广告
      _adState.disableAds();
    } else {
      // 如果用户未购买且没有临时访问权限，启用广告
      _adState.enableAds();
    }
  }

  // 检查广告是否应该显示
  bool shouldShowAds() {
    // 如果用户已购买或有临时访问权限，则不显示广告
    if (_purchaseState.isPurchasedOrHasTempAccess()) {
      return false;
    }
    // 否则根据广告状态决定是否显示广告
    return _adState.isAdEnabled;
  }

  // 禁用广告
  void disableAds() {
    _adState.disableAds();
  }

  // 启用广告
  void enableAds() {
    // 只有在用户未购买且没有临时访问权限时才能启用广告
    if (!_purchaseState.isPurchasedOrHasTempAccess()) {
      _adState.enableAds();
    }
  }

  // 切换广告状态
  void toggleAdState() {
    if (_adState.isAdEnabled) {
      disableAds();
    } else {
      enableAds();
    }
  }
}

/// 创建 AdControlService 的 Provider
final adControlServiceProvider = Provider<AdControlService>((ref) {
  // 使用 ref 获取其他 Provider
  final adState = ref.watch(adStateProvider.notifier);
  final purchaseState = ref.watch(purchaseStateProvider.notifier);
  return AdControlService(
    ref: ref,
    adState: adState,
    purchaseState: purchaseState,
  );
});
