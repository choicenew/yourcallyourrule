import 'package:material_ui/material_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yourcallyourrule/features/common/router/app_router.dart';

part 'live_activity_notification_manager.g.dart';

@Riverpod(keepAlive: true)
LiveActivityNotificationManager liveActivityNotificationManager(Ref ref) {
  return LiveActivityNotificationManager();
}

class LiveActivityNotificationManager {
  Future<void> initialize() async {
    debugPrint('LiveActivityNotificationManager: (Deprecated) initialize skipped to prevent Native lock.');
  }

  void startListening() {
    debugPrint('LiveActivityNotificationManager: (Deprecated) startListening disabled.');
  }

  void dispose() {
    debugPrint('LiveActivityNotificationManager: (Deprecated) dispose disabled.');
  }

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
