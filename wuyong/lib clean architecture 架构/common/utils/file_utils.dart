import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

import '../error/exceptions.dart';

/// 文件操作工具类
class FileUtils {
  const FileUtils._();

  /// 获取应用文档目录
  static Future<Directory> getDocumentsDirectory() async {
    try {
      return await getApplicationDocumentsDirectory();
    } catch (e) {
      throw CacheException('无法获取应用文档目录: $e');
    }
  }

  /// 获取应用临时目录
  static Future<Directory> getTemporaryDirectory() async {
    try {
      return await getTemporaryDirectory();
    } catch (e) {
      throw CacheException('无法获取应用临时目录: $e');
    }
  }

  /// 读取文本文件
  static Future<String> readTextFile(String filePath) async {
    try {
      final file = File(filePath);
      if (!await file.exists()) {
        throw NotFoundException('文件不存在: $filePath');
      }
      return await file.readAsString();
    } catch (e) {
      if (e is NotFoundException) rethrow;
      throw CacheException('读取文件失败: $e');
    }
  }

  /// 写入文本文件
  static Future<void> writeTextFile(String filePath, String content) async {
    try {
      final file = File(filePath);
      await file.writeAsString(content);
    } catch (e) {
      throw CacheException('写入文件失败: $e');
    }
  }

  /// 读取JSON文件
  static Future<Map<String, dynamic>> readJsonFile(String filePath) async {
    try {
      final content = await readTextFile(filePath);
      return json.decode(content) as Map<String, dynamic>;
    } catch (e) {
      if (e is NotFoundException) rethrow;
      throw CacheException('读取JSON文件失败: $e');
    }
  }

  /// 写入JSON文件
  static Future<void> writeJsonFile(String filePath, dynamic data) async {
    try {
      final content = json.encode(data);
      await writeTextFile(filePath, content);
    } catch (e) {
      throw CacheException('写入JSON文件失败: $e');
    }
  }

  /// 检查文件是否存在
  static Future<bool> fileExists(String filePath) async {
    try {
      final file = File(filePath);
      return await file.exists();
    } catch (e) {
      return false;
    }
  }

  /// 删除文件
  static Future<void> deleteFile(String filePath) async {
    try {
      final file = File(filePath);
      if (await file.exists()) {
        await file.delete();
      }
    } catch (e) {
      throw CacheException('删除文件失败: $e');
    }
  }

  /// 创建目录
  static Future<Directory> createDirectory(String dirPath) async {
    try {
      final directory = Directory(dirPath);
      return await directory.create(recursive: true);
    } catch (e) {
      throw CacheException('创建目录失败: $e');
    }
  }

  /// 列出目录中的文件
  static Future<List<FileSystemEntity>> listDirectory(String dirPath) async {
    try {
      final directory = Directory(dirPath);
      if (!await directory.exists()) {
        throw NotFoundException('目录不存在: $dirPath');
      }
      return await directory.list().toList();
    } catch (e) {
      if (e is NotFoundException) rethrow;
      throw CacheException('列出目录失败: $e');
    }
  }

  /// 导出数据到文件
  static Future<String> exportDataToFile(Map<String, dynamic> data, String fileName) async {
    try {
      final directory = await getDocumentsDirectory();
      final filePath = '${directory.path}/$fileName';
      await writeJsonFile(filePath, data);
      return filePath;
    } catch (e) {
      throw CacheException('导出数据失败: $e');
    }
  }

  /// 从文件导入数据
  static Future<Map<String, dynamic>> importDataFromFile(String filePath) async {
    try {
      return await readJsonFile(filePath);
    } catch (e) {
      if (e is NotFoundException) rethrow;
      throw CacheException('导入数据失败: $e');
    }
  }
}