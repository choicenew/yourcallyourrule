import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yourcallyourrule/core/router/app_router.dart';

part 'live_activity_notification_manager.g.dart';

@Riverpod(keepAlive: true)
LiveActivityNotificationManager liveActivityNotificationManager(Ref ref) {
  return LiveActivityNotificationManager();
}

class LiveActivityNotificationManager {
  /// 初始化已废弃。为防止与 ADV_CALL_LOG 原生插件抢占主线程引发 tombstoned，
  /// 本类的启动期 deepLinks 监听彻底移除！
  /// 所有的监听与释放均已移交至 KitLiveActivityHandler 按需处理。
  Future<void> initialize() async {
    debugPrint('LiveActivityNotificationManager: (Deprecated) initialize skipped to prevent Native lock.');
  }

  /// 废弃
  void startListening() {
    debugPrint('LiveActivityNotificationManager: (Deprecated) startListening disabled.');
  }

  /// 废弃
  void dispose() {
    debugPrint('LiveActivityNotificationManager: (Deprecated) dispose disabled.');
  }

  /// 处理通知点击事件
  void handleNotificationTapped(String? payload) {
    debugPrint(
      'LiveActivityNotificationManager: Notification tapped with payload: $payload',
    );

    if (payload == null || payload.isEmpty) {
      debugPrint('LiveActivityNotificationManager: Payload is null or empty, ignoring.');
      return;
    }

    if (AppRouter.navigatorKey.currentContext == null) {
      debugPrint(
        'LiveActivityNotificationManager: Navigation context is null, scheduling retry...',
      );
      WidgetsBinding.instance.addPostFrameCallback((_) {
        handleNavigation(payload);
      });
    } else {
      handleNavigation(payload);
    }
  }

  /// 执行页面跳转
  void handleNavigation(String payload) {
    final context = AppRouter.navigatorKey.currentContext;
    if (context == null) {
      debugPrint(
        'LiveActivityNotificationManager: Navigation context is still null after retry.',
      );
      return;
    }

    debugPrint(
      'LiveActivityNotificationManager: Navigating with payload: $payload',
    );

    try {
      if (payload.contains('call_history') ||
          payload.contains('fraud_alert') ||
          payload.contains('blocked_call') ||
          payload.contains('stir_result')) {
        GoRouter.of(context).goNamed(AppRouter.callHistory);
      } else if (payload.contains('deletion_proposal')) {
        GoRouter.of(context).goNamed(AppRouter.deletionProposal);
      } else {
        debugPrint(
          'LiveActivityNotificationManager: Unknown payload: $payload',
        );
      }
    } catch (e) {
      debugPrint('LiveActivityNotificationManager: Navigation error: $e');
    }
  }
}
