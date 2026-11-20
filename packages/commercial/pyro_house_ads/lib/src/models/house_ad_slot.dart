/// 广告位插槽形态枚举
enum HouseAdSlotType {
  /// 底部/顶部锚定自适应横幅 (如 320x50 ~ 412x60)
  anchoredBanner,

  /// 大矩形横幅 (300x250)
  mrec,

  /// 小尺寸原生卡片 (列表单行嵌入)
  nativeSmall,

  /// 中尺寸原生卡片 (双列瀑布流)
  nativeMedium,

  /// 大尺寸原生卡片 (全宽沉浸大卡)
  nativeLarge,

  /// 插屏 / 居中模态弹窗
  interstitial,
}
