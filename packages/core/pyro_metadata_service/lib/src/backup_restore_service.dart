import 'dart:convert';

/// 迁移自 openreads 的全量阅读资产 JSON/CSV 备份与恢复导出器
class BackupRestoreService {
  /// 将书架、打卡记录、评分一键导出为标准 JSON 备份字符串
  static String exportBackupJson({
    required List<Map<String, dynamic>> books,
    required List<Map<String, dynamic>> readingHistory,
  }) {
    final payload = {
      'version': '1.0.0',
      'exportedAt': DateTime.now().toIso8601String(),
      'books': books,
      'readingHistory': readingHistory,
    };
    return const JsonEncoder.withIndent('  ').convert(payload);
  }

  /// 从 JSON 备份恢复数据
  static Map<String, dynamic>? importBackupJson(String jsonString) {
    try {
      final data = jsonDecode(jsonString);
      if (data is Map && data['books'] != null) {
        return {
          'version': data['version']?.toString() ?? '1.0.0',
          'books': (data['books'] as List).cast<Map<String, dynamic>>(),
          'readingHistory': (data['readingHistory'] as List?)?.cast<Map<String, dynamic>>() ?? [],
        };
      }
    } catch (_) {}
    return null;
  }
}
