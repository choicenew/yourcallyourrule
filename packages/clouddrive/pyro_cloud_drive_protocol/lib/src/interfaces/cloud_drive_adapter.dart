import 'package:flutter/widgets.dart';
import '../models/cloud_file_item.dart';

/// 统一网盘驱动抽象接口。
/// 所有具体网盘驱动（WebDAV, OneDrive, GoogleDrive 等）必须实现此接口。
abstract class CloudDriveAdapter {
  /// 🌟 100% 使用 Dart 强类型 Class Token 作为身份 Token，绝无魔鬼字符串！
  Type get driverToken => runtimeType;

  /// 🌟 多态获取多语言标题（由各网盘微包内部自治实现，UI 0 switch、0 显式子类 import）
  String getTitle(BuildContext context);

  /// 检查当前是否已连接/认证成功
  Future<bool> isConnected();

  /// 使用传入凭证建立连接/授权
  Future<bool> connect(Map<String, dynamic> credentials);

  /// 断开连接并释放凭证
  Future<bool> disconnect();

  /// 列出远端目录下的所有文件/文件夹
  Future<List<CloudFileItem>> listFiles(String remoteDirectory);

  /// 上传本地文件到远端路径
  Future<bool> uploadFile(String localPath, String remotePath);

  /// 从远端路径下载文件到本地路径
  Future<bool> downloadFile(String remotePath, String localPath);

  /// 读取远端文件内容（字符串或二进制数据）
  Future<dynamic> readFile(String remotePath);

  /// 向远端路径写入数据（字符串或字节列表）
  Future<bool> writeFile(String remotePath, dynamic data);

  /// 检查远端文件或目录是否存在
  Future<bool> fileExists(String remotePath);

  /// 删除远端文件或目录
  Future<bool> deleteFile(String remotePath);

  /// 获取远端文件的 MD5 / SHA256 哈希或唯一标识 ETag
  Future<String?> getRemoteFileHash(String remotePath);

  /// 获取远端文件的直链或临时下载链接（如支持）
  Future<String?> getDownloadUrl(String remotePath);
}
