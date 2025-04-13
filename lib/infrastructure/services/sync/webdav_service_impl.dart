import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:xml/xml.dart';

import '../../base_service_impl.dart';

/// WebDAV同步服务实现
/// 负责与WebDAV服务器进行数据同步
class WebDavServiceImpl extends BaseServiceImpl {
  final String _baseUrl;
  final String _username;
  final String _password;
  final String _appFolderName = 'YourCallYourRule';
  
  String? _appFolderPath;
  bool _isAuthenticated = false;
  
  WebDavServiceImpl(this._baseUrl, this._username, this._password);
  
  /// 初始化服务
  Future<void> initialize() async {
    try {
      // 验证凭据
      final response = await http.propfind(
        Uri.parse(_baseUrl),
        headers: _getAuthHeaders(),
      );
      
      if (response.statusCode != 207) {
        throw Exception('WebDAV服务器连接失败: ${response.statusCode}');
      }
      
      _isAuthenticated = true;
      _appFolderPath = await _getOrCreateAppFolder();
      
      logOperation('WebDAV服务初始化完成');
    } catch (e) {
      logOperation('WebDAV服务初始化失败', details: e.toString());
      rethrow;
    }
  }
  
  /// 获取认证头
  Map<String, String> _getAuthHeaders() {
    final credentials = base64Encode(utf8.encode('$_username:$_password'));
    return {
      'Authorization': 'Basic $credentials',
      'Content-Type': 'application/xml',
      'Depth': '1',
    };
  }
  
  /// 获取或创建应用文件夹
  Future<String?> _getOrCreateAppFolder() async {
    if (!_isAuthenticated) {
      throw Exception('未初始化WebDAV服务');
    }
    
    final folderPath = '$_baseUrl/$_appFolderName';
    
    try {
      // 检查文件夹是否存在
      final response = await http.propfind(
        Uri.parse(folderPath),
        headers: _getAuthHeaders(),
      );
      
      if (response.statusCode == 207) {
        return folderPath;
      }
      
      // 创建文件夹
      final createResponse = await http.mkcol(
        Uri.parse(folderPath),
        headers: _getAuthHeaders(),
      );
      
      if (createResponse.statusCode == 201) {
        return folderPath;
      }
      
      throw Exception('创建文件夹失败: ${createResponse.statusCode}');
    } catch (e) {
      logOperation('获取或创建应用文件夹失败', details: e.toString());
      return null;
    }
  }
  
  /// 上传文件
  Future<bool> uploadFile(File file, {String? name}) async {
    if (!_isAuthenticated || _appFolderPath == null) {
      throw Exception('未初始化WebDAV服务或应用文件夹不存在');
    }
    
    try {
      final fileName = name ?? path.basename(file.path);
      final filePath = '$_appFolderPath/$fileName';
      
      final response = await http.put(
        Uri.parse(filePath),
        headers: {
          'Authorization': _getAuthHeaders()['Authorization']!,
          'Content-Type': 'application/octet-stream',
        },
        body: await file.readAsBytes(),
      );
      
      if (response.statusCode == 201 || response.statusCode == 204) {
        logOperation('文件上传成功', details: fileName);
        return true;
      }
      
      throw Exception('上传文件失败: ${response.statusCode}');
    } catch (e) {
      logOperation('文件上传失败', details: e.toString());
      return false;
    }
  }
  
  /// 下载文件
  Future<File?> downloadFile(String fileName, String localPath) async {
    if (!_isAuthenticated || _appFolderPath == null) {
      throw Exception('未初始化WebDAV服务或应用文件夹不存在');
    }
    
    try {
      final filePath = '$_appFolderPath/$fileName';
      
      final response = await http.get(
        Uri.parse(filePath),
        headers: {
          'Authorization': _getAuthHeaders()['Authorization']!,
        },
      );
      
      if (response.statusCode != 200) {
        throw Exception('下载文件失败: ${response.statusCode}');
      }
      
      // 保存到本地
      final localFile = File(localPath);
      await localFile.writeAsBytes(response.bodyBytes);
      
      logOperation('文件下载成功', details: fileName);
      return localFile;
    } catch (e) {
      logOperation('文件下载失败', details: e.toString());
      return null;
    }
  }
  
  /// 列出文件
  Future<List<String>> listFiles() async {
    if (!_isAuthenticated || _appFolderPath == null) {
      throw Exception('未初始化WebDAV服务或应用文件夹不存在');
    }
    
    try {
      final response = await http.propfind(
        Uri.parse(_appFolderPath!),
        headers: _getAuthHeaders(),
      );
      
      if (response.statusCode != 207) {
        throw Exception('列出文件失败: ${response.statusCode}');
      }
      
      // 解析XML响应
      final document = XmlDocument.parse(response.body);
      final responses = document.findAllElements('response');
      
      final files = <String>[];
      for (final response in responses) {
        final href = response.findElements('href').first.text;
        final isCollection = response.findAllElements('collection').isNotEmpty;
        
        if (!isCollection && href != _appFolderPath) {
          final fileName = path.basename(href);
          files.add(fileName);
        }
      }
      
      logOperation('列出文件成功', details: '共 ${files.length} 个文件');
      return files;
    } catch (e) {
      logOperation('列出文件失败', details: e.toString());
      return [];
    }
  }
  
  /// 删除文件
  Future<bool> deleteFile(String fileName) async {
    if (!_isAuthenticated || _appFolderPath == null) {
      throw Exception('未初始化WebDAV服务或应用文件夹不存在');
    }
    
    try {
      final filePath = '$_appFolderPath/$fileName';
      
      final response = await http.delete(
        Uri.parse(filePath),
        headers: {
          'Authorization': _getAuthHeaders()['Authorization']!,
        },
      );
      
      if (response.statusCode != 204) {
        throw Exception('删除文件失败: ${response.statusCode}');
      }
      
      logOperation('文件删除成功', details: fileName);
      return true;
    } catch (e) {
      logOperation('文件删除失败', details: e.toString());
      return false;
    }
  }
  
  /// 检查是否已认证
  bool isAuthenticated() {
    return _isAuthenticated;
  }
}

/// 为http客户端添加WebDAV方法
extension WebDavMethods on http.Client {
  Future<http.Response> propfind(Uri url, {Map<String, String>? headers, Object? body}) {
    return send(http.Request('PROPFIND', url)
      ..headers.addAll(headers ?? {})
      ..body = body?.toString() ?? '');
  }
  
  Future<http.Response> mkcol(Uri url, {Map<String, String>? headers}) {
    return send(http.Request('MKCOL', url)
      ..headers.addAll(headers ?? {}));
  }
}

/// 为http添加WebDAV方法
extension WebDavMethodsHttp on http {
  static Future<http.Response> propfind(Uri url, {Map<String, String>? headers, Object? body}) {
    return http.Client().propfind(url, headers: headers, body: body);
  }
  
  static Future<http.Response> mkcol(Uri url, {Map<String, String>? headers}) {
    return http.Client().mkcol(url, headers: headers);
  }
}