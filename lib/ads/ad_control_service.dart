import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yourcallyourrule/ads/ad_state.dart';
import 'package:yourcallyourrule/purchase/purchase_state.dart';

/// 广告控制服务
/// 负责根据购买状态自动控制广告的显示和隐藏
/// 这个服务应该在应用启动时初始化，并监听PurchaseState的变化
class AdControlService extends ChangeNotifier {
  final PurchaseState _purchaseState;
  final AdState _adState;

  AdControlService(this._purchaseState, this._adState) {
    // 初始化时根据购买状态设置广告状态
    _updateAdState();
    
    // 监听购买状态变化
    _purchaseState.addListener(_updateAdState);
  }

  /// 更新广告状态
  /// 根据购买状态自动控制广告的显示和隐藏
  void _updateAdState() {
    if (_purchaseState.isPurchasesEnabled) {
      // 如果用户已购买，禁用广告
      _adState.disableAds();
    } else {
      // 如果用户未购买，启用广告
      _adState.enableAds();
    }
  }

  /// 手动切换广告状态
  /// 这个方法可以在需要手动控制广告状态的地方调用
  void toggleAdState() {
    if (_adState.isAdEnabled) {
      _adState.disableAds();
    } else {
      // 只有在用户未购买时才能启用广告
      if (!_purchaseState.isPurchasesEnabled) {
        _adState.enableAds();
      }
    }
    notifyListeners();
  }

  /// 静态方法，用于在任何地方获取AdControlService实例
  static AdControlService of(BuildContext context) {
    return Provider.of<AdControlService>(context, listen: false);
  }

  @override
  void dispose() {
    // 移除监听器
    _purchaseState.removeListener(_updateAdState);
    super.dispose();
  }
}