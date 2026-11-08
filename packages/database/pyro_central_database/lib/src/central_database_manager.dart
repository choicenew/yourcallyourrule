import 'package:pyro_central_database_protocol/pyro_central_database_protocol.dart';
import 'package:pyro_cloudflare/pyro_cloudflare.dart';
import 'package:pyro_supabase/pyro_supabase.dart';

/// 基于 Cloudflare D1 的系统中央数据库物理适配器
class CloudflareCentralDbAdapter implements CentralDatabaseAdapter {
  final CloudflareConfig config;
  final CloudflareD1Client _d1Client;

  CloudflareCentralDbAdapter({required this.config})
      : _d1Client = CloudflareD1Client(config: config);

  @override
  String get moduleId => 'cloudflare_d1_central';

  @override
  Future<bool> initialize() async => config.isValid;

  @override
  Future<List<CentralPublicEntity>> fetchPublicEntities(String domain) async {
    if (!config.isValid) return [];
    final res = await _d1Client.query(
      'SELECT id, domain, entity_key, payload, version, updated_at FROM central_public_entities WHERE domain = ?',
      [domain],
    );
    if (res.success) {
      return res.rows.map((row) {
        return CentralPublicEntity(
          id: row['id'] as String? ?? '',
          domain: row['domain'] as String? ?? domain,
          entityKey: row['entity_key'] as String? ?? '',
          payload: (row['payload'] as Map<String, dynamic>?) ?? {},
          version: (row['version'] as num?)?.toInt() ?? 1,
          updatedAt: row['updated_at'] as String? ?? '',
        );
      }).toList();
    }
    return [];
  }

  @override
  Future<CentralPublicEntity?> getPublicEntity(String domain, String entityKey) async {
    final list = await fetchPublicEntities(domain);
    try {
      return list.firstWhere((e) => e.entityKey == entityKey);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<bool> publishPublicEntity(CentralPublicEntity entity) async {
    if (!config.isValid) return false;
    final res = await _d1Client.query(
      'INSERT INTO central_public_entities (id, domain, entity_key, payload, version, updated_at) VALUES (?, ?, ?, ?, ?, ?) '
      'ON CONFLICT(domain, entity_key) DO UPDATE SET payload=excluded.payload, version=excluded.version, updated_at=excluded.updated_at',
      [
        entity.id,
        entity.domain,
        entity.entityKey,
        entity.payload,
        entity.version,
        entity.updatedAt,
      ],
    );
    return res.success;
  }
}

/// 基于 Supabase Postgres 的系统中央数据库物理适配器
class SupabaseCentralDbAdapter implements CentralDatabaseAdapter {
  final SupabaseConfig config;
  final SupabaseDatabaseClient _dbClient;

  SupabaseCentralDbAdapter({required this.config})
      : _dbClient = SupabaseDatabaseClient(config: config);

  @override
  String get moduleId => 'supabase_central';

  @override
  Future<bool> initialize() async => config.isValid;

  @override
  Future<List<CentralPublicEntity>> fetchPublicEntities(String domain) async {
    if (!config.isValid) return [];
    final rows = await _dbClient.select('central_public_entities', filters: {'domain': 'eq.$domain'});
    return rows.map((r) => CentralPublicEntity.fromJson(r)).toList();
  }

  @override
  Future<CentralPublicEntity?> getPublicEntity(String domain, String entityKey) async {
    if (!config.isValid) return null;
    final rows = await _dbClient.select('central_public_entities', filters: {
      'domain': 'eq.$domain',
      'entity_key': 'eq.$entityKey',
    });
    if (rows.isNotEmpty) {
      return CentralPublicEntity.fromJson(rows.first);
    }
    return null;
  }

  @override
  Future<bool> publishPublicEntity(CentralPublicEntity entity) async {
    if (!config.isValid) return false;
    return await _dbClient.upsert('central_public_entities', [entity.toJson()], onConflict: 'domain,entity_key');
  }
}
