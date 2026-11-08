// 订阅服务基类，所有订阅服务都应该继承自这个类

import 'dart:convert';

import 'package:http/http.dart' as http;

import '../base/base_service.dart';
import 'import_export_service.dart';

/// 订阅服务基类
/// [T] 是订阅实体类型
/// [ID] 是实体ID类型
abstract class SubscriptionServiceBase<T, ID> extends BaseService<T, ID> {
  final ImportExportService<T, ID>? _importExportService;

  SubscriptionServiceBase(super.repository, [this._importExportService]);

  /// 获取所有启用的订阅
  Future<List<T>> getEnabledSubscriptions();

  /// 启用订阅
  Future<void> enableSubscription(T subscription);

  /// 禁用订阅
  Future<void> disableSubscription(T subscription);

  /// 检查订阅是否需要更新
  Future<bool> checkNeedUpdate(T subscription);

  /// 更新订阅内容
  Future<List<T>> updateSubscription(T subscription);

  /// 从URL获取订阅内容并进行安全解析
  Future<List<T>> fetchAndParseSubscription(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final detectedFormat = _detectDataFormat(response.body, response.headers['content-type']);
        if (_importExportService == null) {
          throw UnimplementedError('子类未注入 ImportExportService 服务');
        }
        return _importExportService!.parseImportData(response.body, format: detectedFormat);
      } else {
        throw Exception('HTTP错误: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }

  /// 导出订阅配置到本地文件
  Future<bool> exportSubscriptionsToFile(String filePath, {List<T>? entities, ExportFormat format = ExportFormat.json}) async {
    if (_importExportService == null) {
      throw UnimplementedError('子类未注入 ImportExportService 服务');
    }
    return _importExportService!.exportToFile(filePath, entities: entities, format: format);
  }

  /// 从本地文件导入订阅配置
  Future<List<T>> importSubscriptionsFromFile(String filePath, {ImportMode mode = ImportMode.merge, ExportFormat? format}) async {
    if (_importExportService == null) {
      throw UnimplementedError('子类未注入 ImportExportService 服务');
    }
    return _importExportService!.importFromFile(filePath, mode: mode, format: format);
  }

  /// 识别数据格式
  ExportFormat _detectDataFormat(String content, String? contentType) {
    if (contentType != null) {
      if (contentType.contains('json')) return ExportFormat.json;
      if (contentType.contains('csv')) return ExportFormat.csv;
      if (contentType.contains('yaml')) return ExportFormat.yaml;
    }

    try {
      jsonDecode(content);
      return ExportFormat.json;
    } catch (_) {
      return ExportFormat.csv;
    }
  }
}
