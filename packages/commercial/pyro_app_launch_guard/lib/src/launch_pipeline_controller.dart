import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:pyro_ads_hub/pyro_ads_hub.dart';
import 'launch_stage.dart';
import 'launch_config.dart';

/// 启动管线调度控制器 (Launch Pipeline Controller)
class LaunchPipelineController extends ValueNotifier<LaunchStage> {
  final LaunchConfig config;
  final List<Future<void> Function()> initializers;
  final Future<void> Function(LaunchConfig config)? onShowAppOpenAd;

  LaunchPipelineController({
    this.config = const LaunchConfig(),
    this.initializers = const [],
    this.onShowAppOpenAd,
  }) : super(LaunchStage.initializing);

  bool _hasStarted = false;

  /// 启动完整管线
  Future<void> startPipeline() async {
    if (_hasStarted) return;
    _hasStarted = true;

    // Stage 1: 并行初始化阶段
    value = LaunchStage.initializing;
    await _runInitializers();

    // Stage 2: 引导页 / 隐私合规阶段
    value = LaunchStage.onboarding;
    final needOnboarding = await _checkNeedsOnboarding();
    if (needOnboarding) {
      // 保持在 onboarding 阶段，等待 UI 调用 completeOnboarding()
      return;
    }

    // Stage 3: 开屏广告阶段
    await _executeAppOpenAdStage();
  }

  /// 跑初始化任务（带超时熔断保护）
  Future<void> _runInitializers() async {
    if (initializers.isEmpty) return;

    try {
      final futures = initializers.map((fn) => fn()).toList();
      await Future.wait(futures).timeout(config.initTimeout);
    } catch (e, stack) {
      debugPrint('[LaunchPipelineController] Initializer exception/timeout: $e\n$stack');
      // 触发超时或异常，强制放行兜底
    }
  }

  /// 检查是否需要展示引导页
  Future<bool> _checkNeedsOnboarding() async {
    if (config.shouldShowOnboardingCheck == null) return false;
    try {
      return await config.shouldShowOnboardingCheck!();
    } catch (e) {
      debugPrint('[LaunchPipelineController] Onboarding check failed: $e');
      return false;
    }
  }

  /// 引导页播放完毕回调 (明确 await 磁吸落盘写盘完成，彻底防止划掉强杀丢失数据)
  Future<void> completeOnboarding() async {
    if (value != LaunchStage.onboarding) return;

    if (config.onOnboardingCompletedSaveCallback != null) {
      try {
        await config.onOnboardingCompletedSaveCallback!();
      } catch (e, stack) {
        debugPrint('[LaunchPipelineController] Save onboarding state failed: $e\n$stack');
      }
    }

    await _executeAppOpenAdStage();
  }

  /// 执行开屏广告阶段
  Future<void> _executeAppOpenAdStage() async {
    value = LaunchStage.appOpenAd;

    if (!config.enableAppOpenAd) {
      _finishPipeline();
      return;
    }

    try {
      if (onShowAppOpenAd != null) {
        await onShowAppOpenAd!(config).timeout(config.adTimeout);
      } else {
        await AdsAppOpen.show(config.initialAdTier).timeout(config.adTimeout);
      }
    } catch (e) {
      debugPrint('[LaunchPipelineController] AppOpenAd failed or timed out: $e');
    } finally {
      _finishPipeline();
    }
  }

  /// 终结管线，平滑交付
  void _finishPipeline() {
    value = LaunchStage.completed;
  }

  /// 手动跳过广告或强行完成
  void skipToComplete() {
    _finishPipeline();
  }
}
