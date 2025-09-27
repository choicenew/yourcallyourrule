import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/provider/providers/notification_providers.dart';
import 'package:yourcallyourrule/data/repositories/config/config_repository.dart';
import 'package:yourcallyourrule/features/caller_id/config/caller_id_config_provider.dart';
import 'package:yourcallyourrule/features/caller_id/services/call_handlers/caller_id_handler.dart';
import 'package:yourcallyourrule/features/caller_id/services/call_handlers/display_mode_handler.dart';
import 'package:yourcallyourrule/features/caller_id/services/call_handlers/notification_handler.dart';
import 'package:yourcallyourrule/features/caller_id/services/call_handlers/overlay_handler.dart';
import 'package:yourcallyourrule/core/provider/providers/caller_id_service_provider.dart';
import 'package:yourcallyourrule/features/language/provider/language_provider.dart';

/// Provider for OverlayHandler.
final overlayHandlerProvider = Provider<OverlayHandler>((ref) {
  // OverlayHandler has a default constructor that creates a SharedPreferencesConfigRepository.
  return OverlayHandler();
});

/// Provider for NotificationHandler.
final notificationHandlerProvider = Provider<NotificationHandler>((ref) {
  final callerIdConfigRepository = ref.watch(callerIdConfigRepositoryProvider);
    // 2. 获取 notificationService 实例
  final notificationService = ref.watch(notificationServiceProvider);
  
  // 3. 将必需的 notificationService 注入
    // 3. 将必需的 notificationService 注入
  return NotificationHandler(
    configRepository: callerIdConfigRepository,
    notificationService: notificationService,
  );
});

/// Provider for DisplayModeHandler.
final displayModeHandlerProvider = Provider<DisplayModeHandler>((ref) {
  final callerIdConfigRepository = ref.watch(callerIdConfigRepositoryProvider);
  final overlayHandler = ref.watch(overlayHandlerProvider);
  final notificationHandler = ref.watch(notificationHandlerProvider);
    // 4. 获取 notificationService 实例 (也可以直接从 provider 获取)
  final notificationService = ref.watch(notificationServiceProvider);

  // 5. 将必需的 notificationService 注入
  return DisplayModeHandler(
    configRepository: callerIdConfigRepository,
    overlayHandler: overlayHandler,
    notificationHandler: notificationHandler,
    notificationService: notificationService,
  );
});

/// Provider for CallHandler.
// 6. 将 Provider 升级为 FutureProvider 以处理异步依赖
final callHandlerProvider = FutureProvider<CallHandler>((ref) async {
  final callerIdService = ref.watch(callerIdServiceProvider);
 // 7. 异步等待新的 localeProvider 加载完成，并获取 Locale 对象
  final locale = await ref.watch(localeProvider.future);
  final displayModeHandler = ref.watch(displayModeHandlerProvider);
  return CallHandler(
    callerIdService: callerIdService,
     locale: locale, // 使用 'locale' 参数，而不是 'localeProvider'
    displayModeHandler: displayModeHandler,
  );
});