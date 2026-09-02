import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dlibphonenumber/locale.dart' as dlibphone;
import 'package:sim_reader/sim_reader.dart';

import 'package:yourcallyourrule/common/utils/phone_utils.dart';
import 'package:yourcallyourrule/core/entities/rule/regex_rule.dart';
import 'package:yourcallyourrule/core/provider/providers/label_service_provider.dart';
import 'package:yourcallyourrule/core/value_objects/phone_number.dart' as vo;
import 'package:yourcallyourrule/core/value_objects/rule_action.dart';
import 'package:yourcallyourrule/features/call/call_filter/call_filter_service.dart';
import 'package:yourcallyourrule/features/call/call_filter/providers/call_filter_provider.dart';
import 'package:yourcallyourrule/features/call/time_interceptor/service/time_interceptor_service.dart';
import 'package:yourcallyourrule/features/caller_id/providers/caller_id_service_provider.dart';
import 'package:yourcallyourrule/features/caller_id/services/call_handlers/display_mode_handler.dart';
import 'package:yourcallyourrule/features/caller_id/services/call_handlers/kit_live_activity_handler.dart';
import 'package:yourcallyourrule/features/caller_id/services/call_handlers/notification_handler.dart';
import 'package:yourcallyourrule/features/caller_id/services/call_handlers/overlay_handler.dart';
import 'package:yourcallyourrule/features/contacts/provider/contact_service_provider.dart';
import 'package:yourcallyourrule/features/language/provider/language_provider.dart';
import 'package:yourcallyourrule/features/local_filter/services/local_count_filter_service.dart';
import 'package:yourcallyourrule/features/remote_filter/services/remote_number_filter_service.dart';
import 'package:yourcallyourrule/features/sync_country/provider/country_selection_provider.dart';
import 'package:yourcallyourrule/features/verification/models/verification_state.dart';

/// Verification 业务逻辑管理 Notifier
class VerificationNotifier extends Notifier<VerificationState> {
  StreamSubscription? _legacyPluginSub;
  StreamSubscription? _pluginSub;

  @override
  VerificationState build() {
    _initSubscriptions();
    ref.onDispose(() {
      _legacyPluginSub?.cancel();
      _pluginSub?.cancel();
    });
    return const VerificationState();
  }

  void _initSubscriptions() {
    final callerIdService = ref.read(callerIdServiceProvider);
    _legacyPluginSub = callerIdService.legacyPluginDataStream.listen((data) {
      state = state.copyWith(legacyPluginData: data);
    });
    _pluginSub = callerIdService.pluginDataStream.listen((data) {
      state = state.copyWith(pluginSourceData: data);
    });
  }

  /// 初始化国家代码与号码（支持单卡/双卡、多选同步国家及物理设备区域排序）
  Future<void> initLocaleAndNumber({String? initialNumber}) async {
    final candidates = <String>[];

    // 1. 优先读取 SIM 卡国家（支持单卡与双卡）
    try {
      final simInfoList = await SimReader.getAllSimInfo();
      for (final sim in simInfoList) {
        final code = sim.countryCode?.trim().toUpperCase();
        if (code != null && code.isNotEmpty && !candidates.contains(code)) {
          candidates.add(code);
        }
      }
    } catch (_) {}

    // 2. 读取用户在「同步国家」中配置的多选国家列表
    try {
      final selectedCountries = await ref.read(selectedCountriesProvider.future);
      for (final code in selectedCountries) {
        final upper = code.trim().toUpperCase();
        if (upper.isNotEmpty && !candidates.contains(upper)) {
          candidates.add(upper);
        }
      }
    } catch (_) {}

    // 3. 读取设备的物理系统地区（作为兜底）
    try {
      final platformCountry = PlatformDispatcher.instance.locale.countryCode?.trim().toUpperCase();
      if (platformCountry != null && platformCountry.isNotEmpty && !candidates.contains(platformCountry)) {
        candidates.add(platformCountry);
      }
    } catch (_) {}

    final defaultCountry = candidates.isNotEmpty ? candidates.first : '';

    state = state.copyWith(
      candidateCountries: candidates,
      countryCode: defaultCountry,
    );

    if (initialNumber != null && initialNumber.trim().isNotEmpty) {
      final trimmed = initialNumber.trim();
      final isIntl = trimmed.startsWith('+') || trimmed.startsWith('00');
      state = state.copyWith(
        phoneNumber: trimmed,
        isInternational: isIntl,
      );

      if (isIntl) {
        await detectCountryCode(trimmed);
      }
      await verifyNumber(trimmed);
    }
  }

  /// 自动从输入的号码中检测国家代码（如果有 + 国际区号）
  Future<void> detectCountryCode(String phoneNumber) async {
    try {
      final result = await PhoneUtils.parsePhoneNumber(phoneNumber);
      final code = result['countryCode'];
      if (code != null && code.isNotEmpty) {
        state = state.copyWith(
          countryCode: code.toUpperCase(),
          isInternational: true,
        );
      }
    } catch (_) {}
  }

  /// 用户在顶部 Chip 中快速切换候选国家
  void selectCountry(String code) {
    final upper = code.trim().toUpperCase();
    if (upper.isNotEmpty && upper != state.countryCode) {
      state = state.copyWith(countryCode: upper);
      verifyNumber(state.phoneNumber);
    }
  }

  void updateCountryCode(String code) {
    state = state.copyWith(countryCode: code.trim().toUpperCase());
  }

  void updatePhoneNumber(String number) {
    final trimmed = number.trim();
    final isIntl = trimmed.startsWith('+') || trimmed.startsWith('00');
    state = state.copyWith(
      phoneNumber: trimmed,
      isInternational: isIntl,
    );
  }

  /// 执行综合号码验证业务逻辑
  Future<void> verifyNumber(String phoneNumberStr) async {
    final target = phoneNumberStr.trim();
    if (target.isEmpty) return;

    final isIntl = target.startsWith('+') || target.startsWith('00');

    state = state.copyWith(
      isLoading: true,
      phoneNumber: target,
      isInternational: isIntl,
      errorMessage: null,
    );

    try {
      final callFilterService = ref.read(callFilterServiceProvider);
      final timeInterceptorService = ref.read(timeInterceptorServiceProvider);
      final localCountFilterService = ref.read(localCountFilterServiceProvider);
      final remoteNumberFilterService = ref.read(remoteNumberFilterServiceProvider);
      final callerIdService = ref.read(callerIdServiceProvider);
      final contactService = ref.read(contactServiceProvider);
      final labelService = ref.read(labelServiceProvider);

      final callFilterConfig = await ref.read(callFilterConfigProvider.future);
      final number = vo.PhoneNumber.fromString(target);
      final currentLocale = await ref.read(localeProvider.future);
      final countryCode = state.countryCode;

      final dlibLocale = dlibphone.Locale(
        language: currentLocale.languageCode,
        country: countryCode,
      );

      final callerIdData = await callerIdService.getCallerId(number.value, dlibLocale);
      final rules = await callFilterService.verifyAllRules(number);

      dynamic matchedContact;
      try {
        matchedContact = await contactService.findContactByPhoneNumber(number);
      } catch (_) {
        matchedContact = null;
      }

      dynamic matchedLabel;
      try {
        matchedLabel = await labelService.getLabelByPhoneNumberString(number.value);
      } catch (_) {
        matchedLabel = null;
      }

      bool timeRuleHit = false;
      try {
        timeRuleHit = await timeInterceptorService.shouldIntercept(number.value);
      } catch (_) {}

      bool localCountBlocked = false;
      try {
        localCountBlocked = !await localCountFilterService.shouldAcceptCall(number.value);
      } catch (_) {}

      bool remoteNumberBlocked = false;
      try {
        remoteNumberBlocked = !await remoteNumberFilterService.shouldAcceptCall(number.value);
      } catch (_) {}

      final rulesMap = <String, bool>{
        'Allowed': rules.any((rule) => rule.action.type == RuleActionType.allow),
        'Blocked': rules.any((rule) => rule.action.type == RuleActionType.block),
        'Silenced': rules.any((rule) => rule.action.type == RuleActionType.silence),
        'None Action': rules.any((rule) => rule.action.type == RuleActionType.none),
        'Global Reject': callFilterConfig.rejectAllNumbers,
        'Blacklist': rules.any((rule) => rule.action.type == RuleActionType.block),
        'Whitelist': rules.any((rule) => rule.action.type == RuleActionType.allow),
        'Regex': rules.any((rule) => rule is RegexRule),
        'Time Rules': timeRuleHit,
        'Local Count Filter': localCountBlocked,
        'Remote Number Filter': remoteNumberBlocked,
      };

      state = state.copyWith(
        isLoading: false,
        hasVerified: true,
        callerIdData: callerIdData,
        matchedContact: matchedContact,
        matchedLabel: matchedLabel,
        rulesResults: rulesMap,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  /// 1. 触发悬浮窗实机效果测试 (Overlay)
  Future<void> testOverlay() async {
    if (state.callerIdData != null) {
      final overlayHandler = ref.read(overlayHandlerProvider);
      await overlayHandler.showCallerIdOverlay(
        state.callerIdData!,
        null,
        null,
      );
    }
  }

  /// 关闭悬浮窗 (Close Overlay)
  Future<void> closeOverlay() async {
    final overlayHandler = ref.read(overlayHandlerProvider);
    overlayHandler.closeOverlay();
  }

  /// 2. 触发 Live Activity / 灵动岛效果测试
  Future<void> testLiveActivity() async {
    if (state.callerIdData != null) {
      final liveActivityHandler = await ref.read(kitLiveActivityHandlerProvider.future);
      await liveActivityHandler.showCallerIdActivity(
        callerIdData: state.callerIdData!,
        simInfo: null,
        stirInfo: null,
      );
    }
  }

  /// 3. 触发系统本地通知效果测试 (Notification)
  Future<void> testNotification() async {
    if (state.callerIdData != null) {
      final notificationHandler = await ref.read(notificationHandlerProvider.future);
      await notificationHandler.showCallerIdNotification(
        callerIdData: state.callerIdData!,
        simInfo: null,
        stirInfo: null,
      );
    }
  }

  /// 4. 触发当前配置模式测试 (Configured Display Mode)
  Future<void> testDefaultDisplayMode() async {
    if (state.callerIdData != null) {
      final displayHandler = await ref.read(displayModeHandlerProvider.future);
      await displayHandler.showCallerIdInfo(
        state.callerIdData!,
        null,
        null,
      );
    }
  }
}

/// Verification Provider
final verificationProvider =
    NotifierProvider.autoDispose<VerificationNotifier, VerificationState>(() {
  return VerificationNotifier();
});
