import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:dlibphonenumber/dlibphonenumber.dart';

import 'package:yourcallyourrule/common/utils/avatar_utils.dart';
import 'package:yourcallyourrule/core/entities/call/sim_info.dart';
import 'package:yourcallyourrule/core/entities/call/stir_info.dart';
import 'package:yourcallyourrule/core/entities/caller_id_data.dart';
import 'package:yourcallyourrule/core/router/app_router.dart';
import 'package:yourcallyourrule/features/call/call_overlay/core/extensions/phone_number_type_extension.dart';
import 'package:yourcallyourrule/features/call_policy/evaluators/fraud_detection_service.dart';
import 'package:yourcallyourrule/features/caller_identity/config/caller_identity_config_provider.dart';
import 'package:yourcallyourrule/features/caller_identity/config/caller_identity_config_repository.dart';
import 'package:yourcallyourrule/features/notifications/providers/notification_providers.dart';
import 'package:yourcallyourrule/features/notifications/config/notification_config.dart';
import 'package:yourcallyourrule/features/notifications/service/notification_asset_service.dart';
import 'package:yourcallyourrule/features/notifications/service/notification_service.dart';
import 'package:yourcallyourrule/features/notifications/service/notification_service_contract.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

part 'notification_handler.g.dart';

@Riverpod(keepAlive: true)
Future<NotificationHandler> notificationHandler(Ref ref) async {
  final notificationService = ref.watch(notificationServiceProvider);
  final configRepository = ref.watch(callerIdConfigRepositoryProvider); 
  final assetService = ref.watch(notificationAssetServiceProvider);

  final handler = NotificationHandler(
    notificationService: notificationService,
    configRepository: configRepository,
    assetService: assetService,
  );

  await handler.initialize();
  return handler;
}

class NotificationHandler {
  final NotificationServiceContract _notificationService;
  final CallerIdConfigRepository _configRepository;
  final NotificationAssetService _assetService;

  NotificationHandler({
    required NotificationServiceContract notificationService,
    required CallerIdConfigRepository configRepository,
    required NotificationAssetService assetService,
  })  : _notificationService = notificationService,
        _configRepository = configRepository,
        _assetService = assetService;

  Future<void> initialize() async {}

  Future<void> showBlockedCallNotification(String phoneNumber) async {
    try {
      final useLocalNotification = await _configRepository.getUseLocalNotification();
      if (!useLocalNotification) return;
      
      final context = AppRouter.navigatorKey.currentContext;
      if (context == null) return;
      final cancelNotification = await _configRepository.getCancelLocalNotification();
      final cancelDelay = await _configRepository.getNotificationAutoCancelDelay();

      final l10n = AppLocalizations.of(context);
      final String title = l10n.blockedCallTitle;
      final String body = l10n.blockedCallBody(phoneNumber);

      await _notificationService.showNotification(
        config: NotificationService.blockedCallConfig(context),
        title: title,
        body: body,
        notificationId: phoneNumber.hashCode,
        payload: {'type': 'call_history'},
        autoCancel: cancelNotification,
        autoCancelDelay: cancelDelay,
      );
    } catch (e, stack) {
      debugPrint("Error in showBlockedCallNotification: $e\n$stack");
    }
  }

  Future<void> showStirCallNotification(String phoneNumber, bool isVerified, bool isNotVerified, bool isFailed) async {
    try {
      final useStirNotification = await _configRepository.getUseStirNotification();
      if (!useStirNotification) return;

      final context = AppRouter.navigatorKey.currentContext;
      if (context == null) return;

      final cancelNotification = await _configRepository.getCancelLocalNotification();
      final cancelDelay = await _configRepository.getNotificationAutoCancelDelay();
      final l10n = AppLocalizations.of(context);
    
      String stirResultMessage;
      if (isVerified) { stirResultMessage = l10n.stirVerified; }
      else if (isNotVerified) { stirResultMessage = l10n.stirNotVerified; }
      else if (isFailed) { stirResultMessage = l10n.stirFailed; }
      else { stirResultMessage = l10n.stirUnknown; }

      final String title = l10n.stirVerificationTitle;
      final String body = l10n.stirVerificationBody(stirResultMessage, phoneNumber);

      await _notificationService.showNotification(
        config: NotificationService.stirResultConfig(context),
        title: title,
        body: body,
        notificationId: phoneNumber.hashCode,
        payload: {'type': 'call_history'},
        autoCancel: cancelNotification,
        autoCancelDelay: cancelDelay,
      );
    } catch (e, stack) {
      debugPrint("Error in showStirCallNotification: $e\n$stack");
    }
  }

  Future<void> showCallerIdNotification({
    required CallerIdData callerIdData,
    required SimInfo? simInfo,
    required StirInfo? stirInfo,
    bool forceShow = false,
  }) async {
    try {
      final useLocalNotification = await _configRepository.getUseLocalNotification();
      if (!useLocalNotification && !forceShow) return;

      final context = AppRouter.navigatorKey.currentContext;
      if (context == null) return;
      
      final cancelNotification = await _configRepository.getCancelLocalNotification();
      final cancelDelay = await _configRepository.getNotificationAutoCancelDelay();
      final l10n = AppLocalizations.of(context);

      final isFraudCall = FraudDetectionService.checkForFraudLabels(callerIdData);
      final String name = callerIdData.name ?? 'Unknown';
      final String number = callerIdData.phoneNumber.value;
      
      String finalTitle;
      NotificationConfig notificationConfig;

      final List<String> bodyParts = [];
      if (name.isNotEmpty && name != 'Unknown') bodyParts.add(name);
      if (callerIdData.labels != null && callerIdData.labels!.isNotEmpty) bodyParts.add(callerIdData.labels!.map((l) => l.label).join(', '));
      if (callerIdData.count > 0) bodyParts.add(l10n.callerIdMarkedByCount(callerIdData.count));
      if (simInfo?.displayName != null && simInfo!.displayName!.isNotEmpty) bodyParts.add(simInfo.displayName!);
      final locationInfo = [callerIdData.carrier, callerIdData.region, callerIdData.countryName].where((s) => s != null && s.isNotEmpty).join(', ');
      if (locationInfo.isNotEmpty) bodyParts.add(locationInfo);
      if (callerIdData.numberType != PhoneNumberType.unknown) bodyParts.add(callerIdData.numberType.translated(context));
      if (stirInfo != null && stirInfo.isVerified) bodyParts.add(l10n.stirVerified);

      String finalBody = bodyParts.join(' - ');

      if (isFraudCall) {
        final String fraudTitle = l10n.fraudAlertTitle;
        finalTitle = "⚠️ $fraudTitle ($number)${simInfo == null ? '' : '-SIM${simInfo.simSlotIndex! + 1}'}";
        notificationConfig = NotificationService.fraudAlertConfig(context);
        await FraudDetectionService.triggerFraudAlert(callerIdData.phoneNumber.value);
      } else {
        final String callerIdTitle = l10n.callerIdNotificationTitle;
        finalTitle = "$callerIdTitle ($number)";
        notificationConfig = NotificationService.defaultConfig(context); 
      }

      String? avatarResourcePath;
      final String? labelText = (callerIdData.labels != null && callerIdData.labels!.isNotEmpty) ? callerIdData.labels!.first.label : null;
      if (callerIdData.avatar != null && callerIdData.avatar!.isNotEmpty) {
        avatarResourcePath = callerIdData.avatar;
      } else if (labelText != null && labelText.isNotEmpty) {
        avatarResourcePath = AvatarUtils.getSafeAvatarPath(labelText);
      }
      String? avatarFilePath;
      if (avatarResourcePath != null) {
        try {
          avatarFilePath = await _assetService.prepareAsset(assetOrUrl: avatarResourcePath);
        } catch (_) {}
      }
      
      final notificationStyle = NotificationStyle(
        largeIconPath: avatarFilePath,
        color: isFraudCall ? null : AvatarUtils.getColorFromName(name),
        useBigTextStyle: true,
      );
      
      await _notificationService.showNotification(
        config: notificationConfig,
        title: finalTitle,
        body: finalBody,
        notificationId: callerIdData.phoneNumber.value.hashCode,
        payload: {'type': 'call_history'},
        autoCancel: cancelNotification,
        autoCancelDelay: cancelDelay,
        style: notificationStyle,
      );
    } catch (e, stack) {
      debugPrint("Error in showCallerIdNotification: $e\n$stack");
    }
  }
}
