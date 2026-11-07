/// 探索页分类/过滤器配置
/// 用于构建 UI 上的“发现/探索”页面的 Tabs 或下拉菜单。
/// 这是一个纯 UI 结构的描述，与具体业务数据（壁纸/小说）无关。
class PyroExploreFilter {
  /// 分类唯一 ID，传入 explore() 时使用
  final String id;

  /// 显示名称，例如"热门推荐"、"最新上传"
  final String title;

  /// 图标 URL（可选）
  final String? icon;

  /// 子分类（可选，支持级联分类）
  final List<PyroExploreFilter> children;

  const PyroExploreFilter({
    required this.id,
    required this.title,
    this.icon,
    this.children = const [],
  });
}
