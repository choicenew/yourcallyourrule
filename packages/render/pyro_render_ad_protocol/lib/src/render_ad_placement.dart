/// 全项目通用的广告位空间布局槽位 (绝不绑定任何具体业务页面!)
enum RenderAdPlacement {
  /// 1. 页面底部固定/吸底槽位 (歌词页底部、新闻页底部、小说页底部全盘通用)
  bottomAnchor,

  /// 2. 页面顶部吸顶槽位 (Portal 顶部、页头 Banner 通用)
  topAnchor,

  /// 3. Feed 动态流/列表中间嵌入区 (歌单行内、新闻段落间、漫画瀑布流通用)
  contentInline,

  /// 4. 垂直全屏沉浸翻页区 (全屏试听、全屏视频通用)
  fullScreenModal,

  /// 5. 页面侧边悬浮浮岛区 (播放器侧边、阅读器浮岛)
  floatingOverlay,
}
