import '../models/central_public_entity.dart';

/// 中央数据库适配器 Token 集合 (强类型 0 字符串魔数)
abstract final class CentralDbAdapterToken {
  static const String cloudflareD1 = 'cloudflare_d1_central';
  static const String supabase = 'supabase_central';
}

/// 中央数据库抽象适配器接口 (CentralDatabaseAdapter)
/// 负责开发者/系统中央公共数据的查询、写入与发布
abstract class CentralDatabaseAdapter {
  /// 适配器唯一标识 (如 'cloudflare_d1_central', 'supabase_central')
  String get moduleId;

  /// 按业务域查询全量系统公共条目
  Future<List<CentralPublicEntity>> fetchPublicEntities(String domain);

  /// 读取单条系统公共条目
  Future<CentralPublicEntity?> getPublicEntity(String domain, String entityKey);

  /// 开发者发布/更新单条系统公共条目
  Future<bool> publishPublicEntity(CentralPublicEntity entity);

  /// 检查物理连接可用性
  Future<bool> initialize();
}
