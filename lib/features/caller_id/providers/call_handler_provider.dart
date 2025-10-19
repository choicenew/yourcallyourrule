// lib/core/provider/providers/handler_providers.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';


import 'package:yourcallyourrule/features/caller_id/config/caller_id_config_provider.dart'; // for callerIdConfigRepositoryProvider
import 'package:yourcallyourrule/core/provider/providers/notification_providers.dart'; // for notificationServiceProvider
import 'package:yourcallyourrule/core/provider/providers/caller_id_service_provider.dart'; // for callerIdServiceProvider
import 'package:yourcallyourrule/features/caller_id/services/call_handlers/live_activity_handler.dart';
import 'package:yourcallyourrule/features/language/provider/language_provider.dart';
import 'package:yourcallyourrule/data/repositories/config/config_repository.dart'; // 引入底层仓库

// --- 引入所有需要的 Handler ---
import 'package:yourcallyourrule/features/caller_id/services/call_handlers/overlay_handler.dart';
import 'package:yourcallyourrule/features/caller_id/services/call_handlers/notification_handler.dart';
import 'package:yourcallyourrule/features/caller_id/services/call_handlers/display_mode_handler.dart';
import 'package:yourcallyourrule/features/caller_id/services/call_handlers/caller_id_handler.dart';

// --- 新增：引入 Live Activity 相关的 Service 和 Handler ---
import 'package:yourcallyourrule/features/call/live_activities/services/live_notification_config_service.dart';



// --- 新增：为 LiveNotificationConfigService 创建一个 Provider ---
// 它的作用和你的 callerIdConfigServiceProvider 完全一样，只是服务于新的 LiveNotificationConfigService。
final liveNotificationConfigServiceProvider = Provider<LiveNotificationConfigService>((ref) {
  // LiveNotificationConfigService 需要一个底层的 ConfigRepository。
  // 我们假设 SharedPreferencesConfigRepository 是你的实现。
  // 注意：这里我们直接创建一个新的实例，因为你的 CallerIdMonitorService 也是这样做的，保持一致。
  final configRepository = SharedPreferencesConfigRepository();
  return LiveNotificationConfigService(configRepository);
});

// --- 新增：为 LiveActivityHandler 创建一个 FutureProvider ---
// 因为它的 initialize 方法是异步的，所以必须使用 FutureProvider。
// 这完全模仿了你的 notificationHandlerProvider 的 @riverpod 版本的模式。
final liveActivityHandlerProvider = FutureProvider<LiveActivityHandler>((ref) async {
  final configService = ref.watch(liveNotificationConfigServiceProvider);
  
  final handler = LiveActivityHandler(configService: configService);
  await handler.initialize(); // 等待异步初始化完成
  return handler;
});


/// Provider for OverlayHandler.
final overlayHandlerProvider = Provider<OverlayHandler>((ref) {
  // OverlayHandler 没有复杂的依赖，可以直接创建。
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
// --- 修改：将其从 Provider 升级为 FutureProvider ---
// 因为它现在依赖于一个异步的 liveActivityHandlerProvider。
final displayModeHandlerProvider = FutureProvider<DisplayModeHandler>((ref) async { // <-- 变为 async
  final callerIdConfigRepository = ref.watch(callerIdConfigRepositoryProvider);
  final overlayHandler = ref.watch(overlayHandlerProvider);
  final notificationHandler = ref.watch(notificationHandlerProvider);
    // 4. 获取 notificationService 实例 (也可以直接从 provider 获取)
  final notificationService = ref.watch(notificationServiceProvider);
  
  // --- 新增：异步等待 liveActivityHandlerProvider 初始化完成 ---
  final liveActivityHandler = await ref.watch(liveActivityHandlerProvider.future); // <-- 使用 .future

  // 将所有依赖，包括新的 liveActivityHandler，注入到 DisplayModeHandler 中。
  return DisplayModeHandler(
    configRepository: callerIdConfigRepository,
    overlayHandler: overlayHandler,
    notificationHandler: notificationHandler,
    notificationService: notificationService,
    liveActivityHandler: liveActivityHandler, // <-- 注入新的 Handler
  );
});

/// Provider for CallHandler.
// 6. 将 Provider 升级为 FutureProvider 以处理异步依赖
final callHandlerProvider = FutureProvider<CallHandler>((ref) async {
  final callerIdService = ref.watch(callerIdServiceProvider);
 // 7. 异步等待新的 localeProvider 加载完成，并获取 Locale 对象
  final locale = await ref.watch(localeProvider.future);
  
  // --- 修改：现在需要异步等待 displayModeHandlerProvider ---
  final displayModeHandler = await ref.watch(displayModeHandlerProvider.future); // <-- 修改为 .future

  return CallHandler(
    callerIdService: callerIdService,
     locale: locale, // 使用 'locale' 参数，而不是 'localeProvider'
    displayModeHandler: displayModeHandler,
  );
});