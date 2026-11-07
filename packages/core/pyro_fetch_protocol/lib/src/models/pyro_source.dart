/// 描述任意一个"数据源"的元数据
/// 仅仅是一个配置描述，用于路由和展示，不包含具体业务数据。
class PyroSource {
  final String id;
  final String name;
  final String? icon;

  /// 协议标识符，执行者根据此字段路由到正确的执行器
  /// 例如：'hetu'、'legado'、'cloud_drive'
  final String protocol;

  /// 该源支持的内容类型，例如 'wallpaper'、'book'、'manga'
  final String contentType;

  final bool isEnabled;
  final bool supportsExplore;
  final bool supportsSearch;

  /// 外部传入的原始配置（JSON 字符串、脚本路径等），由具体执行器解释
  final String rawDefinition;

  /// 任意键值对扩展字段，供具体执行器使用
  final Map<String, dynamic> metadata;

  /// 数据源具备的角色分类：'metadata', 'stream', 'hybrid'
  final List<String> sourceRoles;

  const PyroSource({
    required this.id,
    required this.name,
    required this.protocol,
    required this.contentType,
    required this.rawDefinition,
    this.icon,
    this.isEnabled = true,
    this.supportsExplore = true,
    this.supportsSearch = true,
    this.metadata = const {},
    this.sourceRoles = const ['metadata', 'stream'],
  });

  /// 获取该数据源生效的角色清单
  List<String> get roles {
    if (sourceRoles.isNotEmpty) return sourceRoles;
    final metaRoles = metadata['sourceRoles'] as List?;
    if (metaRoles != null) {
      return metaRoles.map((e) => e.toString()).toList();
    }
    return const ['metadata', 'stream'];
  }

  /// 是否具备元数据/列表提供能力
  bool get isMetadataSource => roles.contains('metadata') || roles.contains('hybrid');

  /// 是否具备物理音视频流/内容解析能力
  bool get isStreamSource => roles.contains('stream') || roles.contains('hybrid');

  /// 零信任风控判断：未显式声明 isNsfw: false 时，全自动默认认定为最高风险 true
  bool get isNsfw => (metadata['isNsfw'] as bool?) ?? true;

  /// 风险等级 Getter（未声明默认为 'unsafe'）
  String get riskLevel =>
      metadata['riskLevel']?.toString() ?? (isNsfw ? 'unsafe' : 'safe');

  /// 基准 URL Getter（支持 baseUrl 或 homepage 补全）
  String? get baseUrl =>
      metadata['baseUrl']?.toString() ?? metadata['homepage']?.toString();

  /// 默认目标语言 Getter (支持 defaultLanguage, default_language, language)
  String get targetLanguage =>
      metadata['defaultLanguage']?.toString() ??
      metadata['default_language']?.toString() ??
      metadata['language']?.toString() ??
      'en';
}
