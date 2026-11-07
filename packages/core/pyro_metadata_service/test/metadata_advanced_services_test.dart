import 'package:flutter_test/flutter_test.dart';
import 'package:pyro_metadata_service/pyro_metadata_service.dart';

void main() {
  group('BackupRestoreService 与 SmartShelfAutoTagger 测试', () {
    test('JSON 备份导出与导入恢复测试', () {
      final books = [
        {'id': 'b1', 'title': '三体'}
      ];
      final jsonStr = BackupRestoreService.exportBackupJson(books: books, readingHistory: []);
      expect(jsonStr, contains('三体'));

      final restored = BackupRestoreService.importBackupJson(jsonStr);
      expect(restored, isNotNull);
      expect(restored!['books'].first['title'], equals('三体'));
    });

    test('图书智能打标与自动分类测试', () {
      final tags = SmartShelfAutoTagger.autoTagBook(
        title: '三体：死神永生',
        description: '银河系赛博朋克与宇宙社会学',
      );
      expect(tags, contains('科幻'));
    });
  });
}
