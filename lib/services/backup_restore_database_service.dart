import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:file_picker/file_picker.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../utils/get_default_external_dir.dart';

class BackupRestoreService {
  /// 备份用户数据
  Future<void> backup() async {
    // 获取应用所有数据库路径
    final databasePaths = await getDatabasePaths();

    // 获取临时目录
    final tempDirectory = await getTemporaryDirectory();

    // 将所有数据库导出为 JSON 文件
    final jsonFiles = await Future.wait(databasePaths.map((databasePath) async {
      final database = await openDatabase(databasePath);
      final json = await exportDatabaseToJson(database);
      final jsonFile =
          File(join(tempDirectory.path, '${basename(databasePath)}.json'));
      await jsonFile.writeAsString(json);
      await database.close(); // 关闭数据库连接
      return jsonFile;
    }));

    // 将 JSON 文件打包成 ZIP 文件
    final zipFile = File(join(tempDirectory.path, 'backup.zip'));
    final encoder = ZipFileEncoder();
    // 将所有文件添加到 ZIP 文件中，保持文件名不变
    // 启动编码过程并将它链接到输出文件：
    encoder.create(zipFile.path); // 这是关键的一行
    // 将所有文件添加到 ZIP 文件中，保持文件名不变
    for (var file in jsonFiles) {
      encoder.addFile(file);
    }
    encoder.close();

    // 获取设备名称
    final deviceName = await getDeviceName();
    // 生成备份文件名
    final backupFileName =
        '${deviceName}_${DateTime.now().millisecondsSinceEpoch}.zip';

    // 选择备份路径
    final backupDirectory = await getDefaultExternalStorageDirectory();
    // Create "backup" subdirectory if it doesn't exist
    final backupSubDirectory = Directory(join(backupDirectory, 'backup'));
    await backupSubDirectory.create(recursive: true);

    // 复制 ZIP 文件到备份目录
    try {
      await zipFile.copy(join(backupSubDirectory.path, backupFileName));
    } catch (error) {
      // Handle file copy or write error
      //  print('Error copying file: $error');
    }
  }

  // 获取设备名称
  /*
  Future<String> getDeviceName() async {
    final plugin = DeviceName();
    final deviceName = await plugin.getName();
    return deviceName ?? 'Unknown'; // 如果获取不到设备名称，则返回 'Unknown'
  }
*/

  Future<String> getDeviceName() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      return androidInfo.model; // 返回设备型号，如果获取不到则返回 'Unknown'
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      return iosInfo.name; // 返回设备名称，如果获取不到则返回 'Unknown'
    } else {
      return 'Unknown'; // 其他平台返回 'Unknown'
    }
  }

  // 导出单个数据库为 JSON
  Future<String> exportDatabaseToJson(Database database) async {
    // 获取数据库中的所有表名
    final tables = await database
        .query('sqlite_master', where: 'type = ?', whereArgs: ['table']);
    final tableNames = tables.map((table) => table['name'] as String).toList();

    // 创建一个包含当前数据库所有表数据的 Map
    final Map<String, List<Map<String, dynamic>>> databaseData = {};

    // 遍历当前数据库的所有表，获取表中的数据
    for (final tableName in tableNames) {
      final tableData = await database.query(tableName);
      databaseData[tableName] = tableData;
    }

    // 将数据库数据转换为 JSON 字符串
    final jsonData = json.encode(databaseData);

    return jsonData;
  }

  // 获取安卓设备下的所有数据库路径
  Future<List<String>> getDatabasePaths() async {
    final databasesPath = await getDatabasesPath();
    final dbDir = Directory(databasesPath);
    final dbFiles = await dbDir.list().toList();
    final dbPaths = dbFiles
        .where((file) => file is File && file.path.endsWith('.db'))
        .map((file) => file.path)
        .toList();
    return dbPaths;
  }

  Future<void> importDatabaseFromJson(
      String databasePath, String jsonString) async {
    // Open the database
    final database = await openDatabase(databasePath);

    // Parse the JSON string into a Dart object
    final jsonData = jsonDecode(jsonString);

    // Iterate through each table in the JSON data
    await database.transaction((txn) async {
      for (final tableName in jsonData.keys) {
        final tableData = jsonData[tableName];

        // Insert records into the table using batch insert with ConflictAlgorithm.replace
        for (final record in tableData) {
          await txn.insert(tableName, record,
              conflictAlgorithm: ConflictAlgorithm.replace);
        }
      }
    });
  }

// 还原
  Future<void> restore() async {
    // 获取备份目录
    final defaultDirectory = await getDefaultExternalStorageDirectory();
    final backupDirectoryPath = join(defaultDirectory, 'backup');
    final backupDirectoryExists = await Directory(backupDirectoryPath).exists();

    if (backupDirectoryExists) {
      // 列出所有备份文件
      final backupFiles = await Directory(backupDirectoryPath)
          .list()
          .where((file) => file.path.endsWith('.zip'))
          .toList();

      // 如果没有任何备份文件，则提示用户
      if (backupFiles.isEmpty) {
        // Inform user if no backup files found
        return;
      }

      // 选择要恢复的备份文件
      final FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['zip'],
      );

      if (result != null) {
        // User picked a file
        // Process the selected file...
        final File file = File(result.files.single.path!);
        // 调用解压缩和处理 ZIP 文件的函数
        await handleZipFile(file);
      } else {
        // Inform user if no file selected
        // print('No file selected');
        return;
      }
    } else {
      // Inform user if backup directory doesn't exist
      //print('Backup directory does not exist');
      return;
    }

    // 清理临时目录
    final tempDirectory = await getTemporaryDirectory();
    await tempDirectory.delete(recursive: true);
  }

// 解压缩并处理 ZIP 文件
  Future<void> handleZipFile(File zipFile) async {
    // 获取临时目录,for future
    final tempDirectory = await getTemporaryDirectory();

    // 解压 ZIP 文件
    final bytes = await zipFile.readAsBytes();
    final decoder = ZipDecoder();
    final zipArchive = decoder.decodeBytes(bytes);

    for (final zipFileEntry in zipArchive) {
      // Check if the entry is a file and ends with .json
      if (zipFileEntry.isFile && zipFileEntry.name.endsWith('.json')) {
        final json = utf8.decode(zipFileEntry.content as List<int>);
        // 从文件名中提取数据库名称
        //final databaseName = zipFileEntry.name.split('/').last.replaceAll('.json', '');
        // 使用固定的数据库名称
        final databaseName = 'call_rule_database';
        // 构建数据库路径
        final databasePath = join(await getDatabasesPath(), '$databaseName.db');

        // 确保 importDatabaseFromJson 函数定义正确
        try {
          await importDatabaseFromJson(databasePath, json);
        } catch (error) {
          // Handle error during database restoration
          // print('Error restoring database $databaseName: $error');
        }
      }
    }
    // 删除临时目录中的所有文件
    await tempDirectory.delete(recursive: true);
  }
}
