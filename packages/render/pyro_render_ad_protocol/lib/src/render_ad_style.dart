/// 全仓库 Render 通用的广告样式规格枚举 (工业级全规格覆盖)
enum RenderAdStyleSpec {
  /// 1. 标准横条 Banner (如 320x50 / 60px 吸底吸顶条)
  bannerStandard,

  /// 2. 迷你卡片 / 标签 (Mini Chip / 紧凑小卡片)
  smallChip,

  /// 3. 中等自适应卡片 (Medium Card / 16:9 图文列表 / 3:4 漫画海报)
  mediumCard,

  /// 4. 大号自适应卡片 (Large Card / 300x250 矩形大图 / 焦点大卡)
  largeCard,

  /// 5. 全屏沉浸型卡片 (FullScreen / 100% 屏高 PageView)
  fullScreen,
}
