import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:live_updates/live_updates.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yourcallyourrule/core/router/app_router.dart';

part 'live_activity_notification_manager.g.dart';

@Riverpod(keepAlive: true)
LiveActivityNotificationManager liveActivityNotificationManager(Ref ref) {
  return LiveActivityNotificationManager();
}

class LiveActivityNotificationManager {
  Future<void> initialize() async {
    debugPrint('LiveActivityNotificationManager: Initializing...');
    // Initialize the plugin and set up the tap callback
    await LiveUpdates.initialize(onNotificationTapped: _onNotificationTapped);
    debugPrint('LiveActivityNotificationManager: Initialized');
  }

  void _onNotificationTapped(String? payload) {
    debugPrint(
      'LiveActivityNotificationManager: Notification tapped with payload: $payload',
    );

    if (payload == null) {
      debugPrint('LiveActivityNotificationManager: Payload is null, ignoring.');
      return;
    }

    // 尝试获取上下文，如果为空则稍后重试
    if (AppRouter.navigatorKey.currentContext == null) {
      debugPrint(
        'LiveActivityNotificationManager: Navigation context is null, scheduling retry...',
      );
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _handleNavigation(payload);
      });
    } else {
      _handleNavigation(payload);
    }
  }

  void _handleNavigation(String payload) {
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
      if (payload == 'call_history' ||
          payload == 'fraud_alert' ||
          payload == 'blocked_call' ||
          payload == 'stir_result') {
        GoRouter.of(context).goNamed(AppRouter.callHistory);
      } else if (payload == 'deletion_proposal') {
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
