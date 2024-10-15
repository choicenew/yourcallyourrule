import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// 设置默认的外部存储目录
Future<void> setDefaultExternalStorageDirectory() async {
  final result = await FilePicker.platform.getDirectoryPath();
  if (result != null) {
    final asyncPrefs = SharedPreferencesAsync();
    await asyncPrefs.setString('defaultExternalStorageDirectory', result);
  }
}

// 获取默认的外部存储目录
Future<String> getDefaultExternalStorageDirectory() async {
  final asyncPrefs = SharedPreferencesAsync();
  final userSelectedDirectory =
      await asyncPrefs.getString('defaultExternalStorageDirectory');

  if (userSelectedDirectory != null) {
    return userSelectedDirectory;
  }

  // 如果用户没有选择目录，则使用应用私有目录下的默认路径
  final appDocumentsDirectory = await getApplicationDocumentsDirectory();
  final defaultBackupDirectory =
      Directory(join(appDocumentsDirectory.path, 'backup'));
  if (!defaultBackupDirectory.existsSync()) {
    defaultBackupDirectory.createSync(recursive: true);
  }
  return defaultBackupDirectory.path;
}
