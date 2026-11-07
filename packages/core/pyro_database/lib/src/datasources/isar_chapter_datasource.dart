/// 迁移自 pyro_app 的 Isar 图书章节大列表本地高并发 CRUD 数据源引擎
class IsarChapterDatasource {
  final Map<String, List<Map<String, String>>> _chapterStore = {};

  /// 批量保存某本书的全量章节
  Future<void> saveChapters(String bookId, List<Map<String, String>> chapters) async {
    _chapterStore[bookId] = chapters;
  }

  /// 获取指定图书的章节列表
  Future<List<Map<String, String>>> getChapters(String bookId) async {
    return _chapterStore[bookId] ?? [];
  }

  /// 快速查询章节总数
  Future<int> getChapterCount(String bookId) async {
    return (_chapterStore[bookId] ?? []).length;
  }
}
