import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pyro_tile_hub/pyro_tile_hub.dart';

final expectedCallServiceProvider = ChangeNotifierProvider<ExpectedCallService>((ref) {
  final service = ExpectedCallService();
  service.init();
  return service;
});

/// “期待电话” (Expected Call) 临时放行中枢服务
/// 允许用户在叫外卖、等快递等场景临时豁免拦截未知来电，并与系统下拉快捷磁贴 (Quick Settings Tile) 实时双向联动
class ExpectedCallService extends ChangeNotifier {
  static const String _prefKeyExpectedExpire = 'expected_call_expire_timestamp';

  int? _expireTimestamp;
  Timer? _tickerTimer;

  bool get isActive {
    if (_expireTimestamp == null) return false;
    return DateTime.now().millisecondsSinceEpoch < _expireTimestamp!;
  }

  Duration get remainingDuration {
    if (!isActive || _expireTimestamp == null) return Duration.zero;
    final diffMs = _expireTimestamp! - DateTime.now().millisecondsSinceEpoch;
    return diffMs > 0 ? Duration(milliseconds: diffMs) : Duration.zero;
  }

  Future<void> init() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedExpire = prefs.getInt(_prefKeyExpectedExpire);
      if (savedExpire != null && savedExpire > DateTime.now().millisecondsSinceEpoch) {
        _expireTimestamp = savedExpire;
        _startTicker();
        await TileHub.instance.updateTileState(TileStateType.active, subtitle: _formatRemaining());
      } else {
        await TileHub.instance.updateTileState(TileStateType.inactive, subtitle: '未开启');
      }
    } catch (_) {}
    notifyListeners();
  }

  /// 开启临时放行
  Future<void> enable([Duration duration = const Duration(hours: 1)]) async {
    final expire = DateTime.now().add(duration).millisecondsSinceEpoch;
    _expireTimestamp = expire;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(_prefKeyExpectedExpire, expire);
    } catch (_) {}

    _startTicker();
    await TileHub.instance.updateTileState(TileStateType.active, subtitle: '${duration.inMinutes}分钟');
    debugPrint('[ExpectedCall] 开启期待电话临时放行: ${duration.inMinutes} 分钟');
    notifyListeners();
  }

  /// 关闭临时放行
  Future<void> disable() async {
    _expireTimestamp = null;
    _tickerTimer?.cancel();
    _tickerTimer = null;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_prefKeyExpectedExpire);
    } catch (_) {}

    await TileHub.instance.updateTileState(TileStateType.inactive, subtitle: '未开启');
    debugPrint('[ExpectedCall] 关闭期待电话临时放行');
    notifyListeners();
  }

  /// 切换开关状态 (供 Tile 磁贴点击或 UI 切换)
  Future<void> toggle([Duration defaultDuration = const Duration(hours: 1)]) async {
    if (isActive) {
      await disable();
    } else {
      await enable(defaultDuration);
    }
  }

  void _startTicker() {
    _tickerTimer?.cancel();
    _tickerTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!isActive) {
        disable();
      } else {
        notifyListeners();
      }
    });
  }

  String _formatRemaining() {
    final rem = remainingDuration;
    if (rem.inHours > 0) {
      return '${rem.inHours}小时${rem.inMinutes % 60}分';
    }
    return '${rem.inMinutes}分钟';
  }

  @override
  void dispose() {
    _tickerTimer?.cancel();
    super.dispose();
  }
}

