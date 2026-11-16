import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_sim_hub/pyro_sim_hub.dart';

import 'package:yourcallyourrule/features/phone_subscription/utils/phone_utils.dart';
import 'package:yourcallyourrule/features/phone_coordinator/services/call_coordinator_service.dart';
import 'package:yourcallyourrule/features/country_database/provider/country_selection_provider.dart';
import 'package:yourcallyourrule/features/verification/models/verification_state.dart';

/// Verification 业务逻辑管理 Notifier
class VerificationNotifier extends Notifier<VerificationState> {
  StreamSubscription? _pluginSub;

  @override
  VerificationState build() {
    _initSubscriptions();
    ref.onDispose(() {
      _pluginSub?.cancel();
    });
    return const VerificationState();
  }

  void _initSubscriptions() {
    final coordinator = ref.read(callCoordinatorServiceProvider);
    _pluginSub = coordinator.pluginDataStream.listen((data) {
      state = state.copyWith(pluginSourceData: data);
    });
  }

  /// 初始化国家代码与号码（支持单/双卡、多选同步国家及物理设备区域排序）
  Future<void> initLocaleAndNumber({String? initialNumber}) async {
    final candidates = <String>[];

    // 1. 优先读取 SIM 卡国家（支持单卡与双卡）
    try {
      final simInfoList = await SimHub.instance.getActiveSimCards();
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
      await updatePhoneNumber(initialNumber);
      await verifyNumber(state.phoneNumber);
    }
  }

  /// 自动从输入的号码中检测国家代码
  /// 直接调用 PhoneUtils，不拷贝或重写任何格式判断
  Future<void> detectCountryCode(String phoneNumber) async {
    final trimmed = phoneNumber.trim();
    if (trimmed.isEmpty) return;

    try {
      // 1. 直接使用 PhoneUtils 自动化解析
      final parsed = await PhoneUtils.parsePhoneNumberEntity(trimmed);
      if (parsed.isValid && parsed.countryCode.isNotEmpty) {
        state = state.copyWith(
          countryCode: parsed.countryCode.toUpperCase(),
        );
        return;
      }

      // 2. 降级：若 PhoneUtils 解析失败，使用选中的 countryCode 进行 ISO 解析
      if (state.countryCode.isNotEmpty) {
        final fallbackParsed = await PhoneUtils.parsePhoneNumberWithIsoEntity(trimmed, state.countryCode);
        if (fallbackParsed.isValid && fallbackParsed.countryCode.isNotEmpty) {
          state = state.copyWith(
            countryCode: fallbackParsed.countryCode.toUpperCase(),
          );
        }
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

  /// 统一的号码处理入口：更新文本并触发全自动 Phone Utility 解析
  Future<void> updatePhoneNumber(String number) async {
    final trimmed = number.trim();
    state = state.copyWith(phoneNumber: trimmed);

    if (trimmed.isNotEmpty) {
      await detectCountryCode(trimmed);
    }
  }

  /// 执行综合号码验证业务逻辑（收敛至 CallCoordinatorService 进行 Dry-Run 空跑诊断）
  Future<void> verifyNumber(String phoneNumberStr) async {
    final target = phoneNumberStr.trim();
    if (target.isEmpty) return;

    state = state.copyWith(
      isLoading: true,
      errorMessage: null,
    );

    try {
      final coordinator = ref.read(callCoordinatorServiceProvider);
      final report = await coordinator.dryRunEvaluate(target, countryIso: state.countryCode);

      state = state.copyWith(
        isLoading: false,
        hasVerified: true,
        callerIdData: report.callerIdData,
        matchedContact: report.matchedContact,
        matchedLabel: report.matchedLabel,
        rulesResults: report.rulesResults,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        hasVerified: true, // 降级容错：即便中间链路抛错，依然保证 hasVerified 为 true 渲染卡片
        errorMessage: e.toString(),
      );
    }
  }

  /// 1. 触发悬浮窗实机效果测试 (Overlay)
  Future<void> testOverlay() async {
    if (state.callerIdData != null) {
      final coordinator = ref.read(callCoordinatorServiceProvider);
      await coordinator.simulateOverlay(state.callerIdData!);
    }
  }

  /// 关闭悬浮窗 (Close Overlay)
  Future<void> closeOverlay() async {
    final coordinator = ref.read(callCoordinatorServiceProvider);
    await coordinator.closeOverlay();
  }

  /// 2. 触发 Live Activity / 灵动岛效果测试
  Future<void> testLiveActivity() async {
    if (state.callerIdData != null) {
      final coordinator = ref.read(callCoordinatorServiceProvider);
      await coordinator.simulateLiveActivity(state.callerIdData!);
    }
  }

  /// 3. 触发系统本地通知效果测试 (Notification)
  Future<void> testNotification() async {
    if (state.callerIdData != null) {
      final coordinator = ref.read(callCoordinatorServiceProvider);
      await coordinator.simulateNotification(state.callerIdData!);
    }
  }

  /// 4. 触发当前配置模式测试 (Configured Display Mode)
  Future<void> testDefaultDisplayMode() async {
    if (state.callerIdData != null) {
      final coordinator = ref.read(callCoordinatorServiceProvider);
      await coordinator.simulateDefaultDisplayMode(state.callerIdData!);
    }
  }
}

/// Verification Provider
final verificationProvider =
    NotifierProvider.autoDispose<VerificationNotifier, VerificationState>(() {
  return VerificationNotifier();
});
