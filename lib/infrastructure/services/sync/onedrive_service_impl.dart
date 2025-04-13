import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;

import '../../base_service_impl.dart';

/// OneDrive同步服务实现
/// 负责与OneDrive进行数据同步
class OneDriveServiceImpl extends BaseServiceImpl {
  static const _apiBaseUrl = 'https://graph.microsoft.com/v1.0';
  static const _appFolderName = 'YourCallYourRule';
  
  String? _accessToken;
  String? _appFolderId;
  bool _isAuthenticated = false;
  
  /// 初始化服务
  Future<void> initialize(String accessToken) async {
    try {
      _accessToken = accessToken;
      _appFolderId = await _getOrCreateAppFolder();
      _isAuthenticated = true;
      
      logOperation('OneDrive服务初始化完成');
    } catch (e) {
      logOperation('OneDrive服务初始化失败', details: e.toString());
      rethrow;
    }
  }
  
  /// 获取或创建应用文件夹
  Future<String?> _getOrCreateAppFolder() async {
    if (_accessToken == null) {
      throw Exception('未提供访问令牌');
    }
    
    try {
      // 查找已存在的文件夹
      final response = await http.get(
        Uri.parse('$_apiBaseUrl/me/drive/root/children?\$filter=name eq \'$_appFolderName\' and folder ne null'),
        headers: _getAuthHeaders(),
      );
      
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final items = data['value'] as List<dynamic>;
      
      if (items.isNotEmpty) {
        return items.first['id'] as String;
      }
      
      // 创建新文件夹
      final createResponse = await http.post(
        Uri.parse('$_apiBaseUrl/me/drive/root/children'),
        headers: {
          ..._getAuthHeaders(),
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'name': _appFolderName,
          'folder': {},
        }),
      );
      
      if (createResponse.statusCode == 201) {
        final folderData = jsonDecode(createResponse.body) as Map<String, dynamic>;
        return folderData['id'] as String;
      }
      
      throw Exception('创建文件夹失败: ${createResponse.statusCode}');
    } catch (e) {
      logOperation('获取或创建应用文件夹失败', details: e.toString());
      return null;
    }
  }
  
  /// 获取认证头
  Map<String, String> _getAuthHeaders() {
    return {
      'Authorization': 'Bearer $_accessToken',
    };
  }
  
  /// 上传文件
  Future<String?> uploadFile(File file, {String? name}) async {
    if (!_isAuthenticated || _appFolderId == null) {
      throw Exception('未初始化OneDrive服务或应用文件夹不存在');
    }
    
    try {
      final fileName = name ?? path.basename(file.path);
      
      // 对于小文件（小于4MB），可以直接上传
      if (await file.length() < 4 * 1024 * 1024) {
        final response = await http.put(
          Uri.parse('$_apiBaseUrl/me/drive/items/$_appFolderId:/$fileName:/content'),
          headers: _getAuthHeaders(),
          body: await file.readAsBytes(),
        );
        
        if (response.statusCode == 200 || response.statusCode == 201) {
          final data = jsonDecode(response.body) as Map<String, dynamic>;
          logOperation('文件上传成功', details: fileName);
          return data['id'] as String;
        }
        
        throw Exception('上传文件失败: ${response.statusCode}');
      }
      
      // 对于大文件，需要使用上传会话
      // 实际应用中，应该实现分块上传
      logOperation('文件过大，需要使用上传会话', details: fileName);
      return null;
    } catch (e) {
      logOperation('文件上传失败', details: e.toString());
      return null;
    }
  }
  
  /// 下载文件
  Future<File?> downloadFile(String fileId, String localPath) async {
    if (!_isAuthenticated) {
      throw Exception('未初始化OneDrive服务');
    }
    
    try {
      // 获取下载URL
      final response = await http.get(
        Uri.parse('$_apiBaseUrl/me/drive/items/$fileId'),
        headers: _getAuthHeaders(),
      );
      
      if (response.statusCode != 200) {
        throw Exception('获取文件信息失败: ${response.statusCode}');
      }
      
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final downloadUrl = data['@microsoft.graph.downloadUrl'] as String;
      
      // 下载文件内容
      final downloadResponse = await http.get(Uri.parse(downloadUrl));
      
      if (downloadResponse.statusCode != 200) {
        throw Exception('下载文件内容失败: ${downloadResponse.statusCode}');
      }
      
      // 保存到本地
      final localFile = File(localPath);
      await localFile.writeAsBytes(downloadResponse.bodyBytes);
      
      logOperation('文件下载成功', details: data['name'] as String);
      return localFile;
    } catch (e) {
      logOperation('文件下载失败', details: e.toString());
      return null;
    }
  }
  
  /// 列出文件
  Future<List<Map<String, dynamic>>> listFiles() async {
    if (!_isAuthenticated || _appFolderId == null) {
      throw Exception('未初始化OneDrive服务或应用文件夹不存在');
    }
    
    try {
      final response = await http.get(
        Uri.parse('$_apiBaseUrl/me/drive/items/$_appFolderId/children'),
        headers: _getAuthHeaders(),
      );
      
      if (response.statusCode != 200) {
        throw Exception('列出文件失败: ${response.statusCode}');
      }
      
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final items = data['value'] as List<dynamic>;
      
      logOperation('列出文件成功', details: '共 ${items.length} 个文件');
      return items.cast<Map<String, dynamic>>();
    } catch (e) {
      logOperation('列出文件失败', details: e.toString());
      return [];
    }
  }
  
  /// 删除文件
  Future<bool> deleteFile(String fileId) async {
    if (!_isAuthenticated) {
      throw Exception('未初始化OneDrive服务');
    }
    
    try {
      final response = await http.delete(
        Uri.parse('$_apiBaseUrl/me/drive/items/$fileId'),
        headers: _getAuthHeaders(),
      );
      
      if (response.statusCode != 204) {
        throw Exception('删除文件失败: ${response.statusCode}');
      }
      
      logOperation('文件删除成功', details: 'ID: $fileId');
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