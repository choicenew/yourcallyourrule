import 'package:material_ui/material_ui.dart';
import '../models/matrix_app_item.dart';
import '../models/user_ad_state.dart';
import '../models/house_ad_slot.dart';
import '../engine/matrix_ad_arbitrator.dart';
import '../engine/house_ad_scheduler.dart';
import '../widgets/house_ad_adaptive_card.dart';

/// VIP 页面跳转委托
typedef HouseAdVipNavigator = void Function(BuildContext context, String? vipRoute);

/// 应用商店导流跳转委托
typedef HouseAdStoreLauncher = void Function(BuildContext context, String packageName);

/// 通用自家广告与矩阵交叉推广总管 (House Ads Manager)
class HouseAdsManager {
  static HouseAdsManager? _instance;

  MatrixAdArbitrator? _arbitrator;
  HouseAdScheduler? _scheduler;
  HouseAdStringResolver? _stringResolver;
  HouseAdVipNavigator? _onNavigateVip;
  HouseAdStoreLauncher? _onLaunchStore;
  GlobalKey<NavigatorState>? _navigatorKey;

  UserAdState _currentUserState = UserAdState.active;

  HouseAdsManager._();

  static HouseAdsManager get instance {
    _instance ??= HouseAdsManager._();
    return _instance!;
  }

  MatrixAdArbitrator? get arbitrator => _arbitrator;
  HouseAdScheduler? get scheduler => _scheduler;
  HouseAdStringResolver? get stringResolver => _stringResolver;
  UserAdState get currentUserState => _currentUserState;

  /// 全局初始化中台
  void init({
    required String currentPackageName,
    required List<MatrixAppItem> matrixApps,
    HouseAdStringResolver? stringResolver,
    HouseAdVipNavigator? onNavigateVip,
    HouseAdStoreLauncher? onLaunchStore,
    GlobalKey<NavigatorState>? navigatorKey,
  }) {
    _arbitrator = MatrixAdArbitrator(
      currentPackageName: currentPackageName,
      matrixApps: matrixApps,
    );
    _scheduler = HouseAdScheduler(arbitrator: _arbitrator!);
    _stringResolver = stringResolver;
    _onNavigateVip = onNavigateVip;
    _onLaunchStore = onLaunchStore;
    _navigatorKey = navigatorKey;
  }

  /// 动态更新用户广告状态 (newUser / active / churnRisk)
  void updateUserAdState(UserAdState newState) {
    _currentUserState = newState;
  }

  /// 响应并执行广告点击动作
  void handleAdAction(BuildContext context, HouseAdDecision decision) {
    if (decision.isPrimary) {
      // 1. 本 App VIP 促销点击
      final route = decision.item.vipRoute;
      if (_onNavigateVip != null) {
        _onNavigateVip!(context, route);
      } else if (route != null) {
        Navigator.of(context).pushNamed(route);
      }
    } else {
      // 2. 兄弟 App 导流点击
      final pkg = decision.item.packageName;
      if (_onLaunchStore != null) {
        _onLaunchStore!(context, pkg);
      } else {
        debugPrint('[HouseAdsManager] Request launch store for package: $pkg');
      }
    }
  }

  /// 唤起插屏模态弹窗
  void showInterstitialModal([BuildContext? context]) {
    final ctx = context ?? _navigatorKey?.currentContext;
    if (ctx == null) return;

    final decision = _scheduler?.selectNextAd(userState: _currentUserState);
    if (decision == null) return;

    showDialog(
      context: ctx,
      builder: (dialogCtx) => HouseAdAdaptiveCard(
        decision: decision,
        slotType: HouseAdSlotType.interstitial,
        stringResolver: _stringResolver,
        onAction: (c, d) {
          Navigator.of(dialogCtx).pop();
          handleAdAction(c, d);
        },
      ),
    );
  }
}
