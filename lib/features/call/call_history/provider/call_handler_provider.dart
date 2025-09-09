import 'package:flutter_riverpod/flutter_riverpod.dart';
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
  return NotificationHandler(configRepository: callerIdConfigRepository);
});

/// Provider for DisplayModeHandler.
final displayModeHandlerProvider = Provider<DisplayModeHandler>((ref) {
  final callerIdConfigRepository = ref.watch(callerIdConfigRepositoryProvider);
  final overlayHandler = ref.watch(overlayHandlerProvider);
  final notificationHandler = ref.watch(notificationHandlerProvider);
  return DisplayModeHandler(
    configRepository: callerIdConfigRepository,
    overlayHandler: overlayHandler,
    notificationHandler: notificationHandler,
  );
});

/// Provider for CallHandler.
final callHandlerProvider = Provider<CallHandler>((ref) {
  final callerIdService = ref.watch(callerIdServiceProvider);
  final localeProvider = ref.watch(legacyLocaleProvider);
  final displayModeHandler = ref.watch(displayModeHandlerProvider);
  return CallHandler(
    callerIdService: callerIdService,
    localeProvider: localeProvider,
    displayModeHandler: displayModeHandler,
  );
});