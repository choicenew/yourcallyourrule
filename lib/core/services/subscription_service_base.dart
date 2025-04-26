// 订阅服务基类，所有订阅服务都应该继承自这个类

import 'dart:convert';

import 'package:http/http.dart' as http;

import '../base/base_entity.dart';
import '../base/base_service.dart';
import 'import_export_service.dart';

/// 订阅服务基类
/// [T] 是订阅实体类型
/// [ID] 是实体ID类型
abstract class SubscriptionServiceBase<T extends BaseEntity, ID> extends BaseService<T, ID> {
  final ImportExportService<T, ID>? _importExportService;

  SubscriptionServiceBase(super.repository, [this._importExportService]);

  /// 获取所有启用的订阅
  Future<List<T>> getEnabledSubscriptions();

  /// 启用订阅
  Future<void> enableSubscription(T subscription);

  /// 禁用订阅
  Future<void> disableSubscription(T subscription);

  /// 添加订阅
  Future<T> addSubscription(String name, String url, {bool isEnabled = true});

  /// 更新订阅
  Future<T> updateSubscription(T subscription);

  /// 删除订阅
  Future<bool> deleteSubscription(ID id);

  /// 从URL下载订阅内容
  Future<String> downloadFromUrl(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw Exception('下载失败: HTTP状态码 ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('下载失败: $e');
    }
  }

  /// 从URL导入订阅
  Future<List<T>> importFromUrl(String url, {ExportFormat? format}) async {
    if (_importExportService == null) {
      throw UnimplementedError('导入导出服务未实现');
    }
    
    final data = await downloadFromUrl(url);
    final detectedFormat = format ?? _detectFormatFromData(data);
    
    return _importExportService!.parseImportData(data, format: detectedFormat);
  }

  /// 导出订阅到文件
  Future<bool> exportToFile(String filePath, {List<T>? entities, ExportFormat format = ExportFormat.json}) async {
    if (_importExportService == null) {
      throw UnimplementedError('导入导出服务未实现');
    }
    
    return _importExportService.exportToFile(filePath, entities: entities, format: format);
  }

  /// 从文件导入订阅
  Future<List<T>> importFromFile(String filePath, {ImportMode mode = ImportMode.merge, ExportFormat? format}) async {
    if (_importExportService == null) {
      throw UnimplementedError('导入导出服务未实现');
    }
    
    return _importExportService!.importFromFile(filePath, mode: mode, format: format);
  }

  /// 检测数据格式
  ExportFormat _detectFormatFromData(String data) {
    data = data.trim();
    
    // 尝试解析为JSON
    try {
      jsonDecode(data);
      return ExportFormat.json;
    } catch (_) {}
    
    // 尝试解析为YAML
    try {
      if (data.contains(':') && (data.contains('- ') || data.contains('  '))) {
        return ExportFormat.yaml;
      }
    } catch (_) {}
    
    // 尝试解析为CSV
    try {
      if (data.contains(',') && data.contains('\n')) {
        return ExportFormat.csv;
      }
    } catch (_) {}
    
    // 默认为JSON
    return ExportFormat.json;
  }

  /// 更新订阅最后更新时间
  Future<void> updateLastUpdated(ID id, DateTime time);

  /// 获取所有待更新的订阅
  Future<List<T>> getPendingUpdateSubscriptions();

  /// 清除过期订阅
  Future<int> clearExpiredSubscriptions();
}