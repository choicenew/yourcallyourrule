import '../models/isar_media_schema.dart';

/// 泛化大一统媒体本地 CRUD 数据源引擎
class IsarMediaDatasource {
  final Map<String, IsarMediaObject> _dbStore = {};

  /// 插入或更新泛化媒体记录 (支持音乐/图书/漫画/小说/视频/论文)
  Future<void> saveMedia(IsarMediaObject media) async {
    _dbStore[media.id] = media;
  }

  /// 批量保存媒体记录
  Future<void> saveMediaList(List<IsarMediaObject> mediaList) async {
    for (var m in mediaList) {
      _dbStore[m.id] = m;
    }
  }

  /// 获取全量媒体记录
  Future<List<IsarMediaObject>> getAllMedia() async {
    return _dbStore.values.toList();
  }

  /// 根据媒体类型（如 'music', 'manga', 'novel', 'video'）精准筛选
  Future<List<IsarMediaObject>> getMediaByType(String type) async {
    return _dbStore.values.where((m) => m.type.toLowerCase() == type.toLowerCase()).toList();
  }

  /// 全属性跨多模态模糊搜索（匹配标题、作者/歌手/导演、标签、专辑）
  Future<List<IsarMediaObject>> searchMedia(String query) async {
    final q = query.trim().toLowerCase();
    if (q.isEmpty) return getAllMedia();

    return _dbStore.values.where((m) {
      final titleMatch = m.title.toLowerCase().contains(q);
      final creatorMatch = m.creators.values.any((v) => v.toLowerCase().contains(q));
      final tagMatch = m.tags.any((t) => t.toLowerCase().contains(q));
      final albumMatch = m.album != null && m.album!.toLowerCase().contains(q);
      return titleMatch || creatorMatch || tagMatch || albumMatch;
    }).toList();
  }

  /// 删除指定媒体记录
  Future<bool> deleteMedia(String id) async {
    return _dbStore.remove(id) != null;
  }
}
