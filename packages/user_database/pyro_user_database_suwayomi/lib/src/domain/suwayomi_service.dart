abstract class SuwayomiService {
  /// 连接到 Suwayomi 服务器
  Future<bool> connect({
    required String host,
    required int port,
    String? token,
  });

  /// 检查连接状态
  Future<bool> isConnected();

  /// 获取服务器上的库列表
  Future<List<Map<String, dynamic>>> getLibrary();

  /// 同步本地进度到服务器
  Future<void> syncProgress(String mangaId, int chapterIndex);

  /// 释放资源
  void dispose();
}
