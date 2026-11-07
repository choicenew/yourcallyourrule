import 'package:pyro_media_models/pyro_media_models.dart';
import '../models/pyro_source.dart';
import '../models/pyro_explore_filter.dart';

/// 全网统一数据源执行器抽象契约 (已完成大一统 MediaEntity 强类型升维)
abstract class SourceExecutor {

  // ──────────────────────────────────────────────
  // 1. 搜索能力 (强类型 MediaEntity 贯通，0 散 Map)
  // ──────────────────────────────────────────────

  /// 关键词搜索：直接返回强类型的 MediaEntity 实体列表
  Future<List<MediaEntity>> search(
    PyroSource source,
    String query,
    int page, {
    Map<String, dynamic> options = const {},
  });

  // ──────────────────────────────────────────────
  // 2. 探索/发现能力
  // ──────────────────────────────────────────────

  /// 获取该源支持的探索分类列表
  Future<List<PyroExploreFilter>> getExploreConfig(PyroSource source);

  /// 根据分类 ID 拉取探索页数据：直接返回强类型的 MediaEntity 实体列表
  Future<List<MediaEntity>> explore(
    PyroSource source,
    String filterId,
    int page, {
    Map<String, dynamic> options = const {},
  });

  // ──────────────────────────────────────────────
  // 3. 详情能力
  // ──────────────────────────────────────────────

  /// 获取指定内容的完整详情：直接返回强类型的 MediaEntity 实体对象
  Future<MediaEntity?> getDetail(
    PyroSource source,
    String id, {
    Map<String, dynamic> options = const {},
  });

  // ──────────────────────────────────────────────
  // 4. 元数据能力（可选覆盖）
  // ──────────────────────────────────────────────

  /// 验证此源是否可用
  Future<int> verifySource(PyroSource source) async => 0;

  /// 预热数据源（例如将脚本编译并加载进 VM）。可选覆盖。
  Future<void> preheatSource(PyroSource source) async {}

  // ──────────────────────────────────────────────
  // 5. 创作者能力 (Universal Author Capability)
  // ──────────────────────────────────────────────

  /// 获取创作者基本档案 (头像、Banner、简介、外链、统计等)
  Future<Map<String, dynamic>?> getAuthorProfile(
    PyroSource source,
    String authorKey, {
    Map<String, dynamic> options = const {},
  }) async => null;

  /// 获取创作者名下的全部作品列表 (分页)：直接返回强类型的 MediaEntity 实体列表
  Future<List<MediaEntity>> getAuthorWorks(
    PyroSource source,
    String authorKey,
    int page, {
    Map<String, dynamic> options = const {},
  }) async => search(source, 'author:$authorKey', page, options: options);

  // ──────────────────────────────────────────────
  // 6. 动态配置 Schema (Settings UI Schema)
  // ──────────────────────────────────────────────

  /// 获取数据源支持的动态配置项 Schema 列表
  Future<List<Map<String, dynamic>>> getConfigSchema(PyroSource source) async => [];
}
