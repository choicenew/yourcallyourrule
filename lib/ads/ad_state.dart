import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yourcallyourrule/purchase/purchase_state.dart';

part 'ad_state.g.dart';

// 使用 @Riverpod 注解，并设置为 keepAlive
@Riverpod(keepAlive: true)
class AdState extends _$AdState {
  // 初始状态根据购买状态自动绑定
  @override
  bool build() {
    // 【模块自包含逻辑】：监听购买状态变化，一旦购买状态更新（如异步加载完成或购买成功），自动关闭/启用广告
    ref.listen<PurchaseStateModel>(purchaseStateProvider, (previous, next) {
      state = !next.isPurchasedOrHasTempAccess();
    });

    // 观察当前购买状态，若已购买或拥有临时权限，默认关闭广告；否则开启广告
    final purchaseState = ref.watch(purchaseStateProvider);
    return !purchaseState.isPurchasedOrHasTempAccess();
  }

  // 获取当前广告状态
  bool get isAdEnabled => state;

  // 禁用广告
  void disableAds() {
    state = false;
  }

  // 启用广告
  void enableAds() {
    state = true;
  }
}