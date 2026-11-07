/// 所有参与同步的业务包需要实现的基础接口。
/// 只关心本地数据存取与序列化，不涉及具体的同步协议或传输细节。
abstract class SyncDataAdapter<T> {
  /// 模块唯一标识符。
  String get moduleId;

  /// 全量读取本地所有数据。
  Future<List<T>> readAll();

  /// 使用新的全量数据覆盖本地数据。
  Future<void> overwriteAll(List<dynamic> items);

  /// 监听本地数据的变更流，在数据发生新增、修改时吐出最新的数据实体。
  Stream<T> watchChanges();

  /// 更新或插入单条数据（通常在同步协议接收到远程变更后调用以更新本地数据库）。
  Future<void> upsert(T item);

  /// 将数据实体序列化为 JSON 映射。
  Map<String, dynamic> toJson(T item);

  /// 从 JSON 映射反序列化为数据实体。
  T fromJson(Map<String, dynamic> json);
}
