/// 启动管线阶段枚举 (Launch Pipeline Stages)
enum LaunchStage {
  /// 初始化阶段（异步任务并行跑，带超时卡位）
  initializing,

  /// 引导页 / 隐私政策合规阶段
  onboarding,

  /// 开屏 / 冷启动广告瀑布流阶段
  appOpenAd,

  /// 启动完成，平滑交付主 App
  completed,
}

/// 阶段字符串 Token 表达（杜绝硬编码魔术字）
class LaunchStageToken {
  static const String initializing = 'stage_initializing';
  static const String onboarding = 'stage_onboarding';
  static const String appOpenAd = 'stage_app_open_ad';
  static const String completed = 'stage_completed';

  static String fromStage(LaunchStage stage) {
    switch (stage) {
      case LaunchStage.initializing:
        return initializing;
      case LaunchStage.onboarding:
        return onboarding;
      case LaunchStage.appOpenAd:
        return appOpenAd;
      case LaunchStage.completed:
        return completed;
    }
  }
}
