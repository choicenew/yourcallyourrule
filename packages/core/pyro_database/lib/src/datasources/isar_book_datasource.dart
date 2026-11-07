import '../models/isar_book_schema.dart';

/// 迁移自 pyro_app 的 Isar 图书元数据本地 CRUD 数据源引擎
class IsarBookDatasource {
  final Map<String, IsarBookObject> _dbStore = {};

  /// 插入或更新图书记录
  Future<void> saveBook(IsarBookObject book) async {
    _dbStore[book.id] = book;
  }

  /// 获取全量书架图书列表
  Future<List<IsarBookObject>> getAllBooks() async {
    return _dbStore.values.toList();
  }

  /// 按书名或作者离线模糊搜索
  Future<List<IsarBookObject>> searchBooks(String query) async {
    final q = query.trim().toLowerCase();
    if (q.isEmpty) return getAllBooks();

    return _dbStore.values.where((b) {
      return b.title.toLowerCase().contains(q) ||
          (b.author != null && b.author!.toLowerCase().contains(q));
    }).toList();
  }

  /// 删除指定图书
  Future<bool> deleteBook(String id) async {
    return _dbStore.remove(id) != null;
  }
}
