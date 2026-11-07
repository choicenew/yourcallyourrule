import 'package:material_ui/material_ui.dart';
import '../models/ad_enums.dart';
import '../models/ad_reward_item.dart';

/// 广告渠道微驱动统一抽象契约 (Ad Network Driver Adapter Contract)
abstract class NetworkAdapter {
  String get providerId;
  String get providerName;

  /// 初始化广告渠道 SDK
  Future<void> initialize(Map<String, dynamic> config);

  /// 构建 Banner 横幅 Widget
  Widget buildBanner(String placementId);

  /// 构建 Native 原生广告 Widget
  Widget buildNative(String placementId, NativeStyle style);

  /// 加载插屏广告
  Future<void> loadInterstitial(String placementId);

  /// 展示插屏广告
  Future<void> showInterstitial();

  /// 加载激励视频
  Future<void> loadRewarded(String placementId);

  /// 展示激励视频并执行奖励回调
  Future<void> showRewarded(Function(MagmaRewardItem item) onReward);

  /// 加载开屏/应用打开广告
  Future<void> loadAppOpen(String placementId) async {}

  /// 展示开屏/应用打开广告
  Future<void> showAppOpen() async {}

  /// 测试 ID 提取方法
  String? getTestBannerId() => null;
  String? getTestNativeId() => null;
  String? getTestInterstitialId() => null;
  String? getTestRewardedId() => null;
}
