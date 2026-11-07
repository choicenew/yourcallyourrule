/// 翻译策略模式枚举
enum TranslationPolicy {
  smartAuto,       // 智能自动降级
  preferOnlineApi, // 优先在线 API
  edgeAiOnly,      // 仅限端侧 AI
  onlineApiOnly,   // 仅限在线 API
}
