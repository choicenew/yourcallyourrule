// 导入导出服务基类，用于处理数据的导入和导出功能

import '../../base/base_entity.dart';
import '../../base/base_service.dart';

/// 导入导出服务基类
/// [T] 是实体类型
/// [ID] 是实体ID类型，默认为String
abstract class ImportExportService<T extends BaseEntity, ID> extends BaseService<T, ID> {
  const ImportExportService(super.repository);

  /// 导出数据到文件
  /// [filePath] 导出文件路径
  /// [entities] 要导出的实体列表，如果为null则导出所有实体
  Future<bool> exportToFile(String filePath, [List<T>? entities]) async {
    try {
      final dataToExport = entities ?? await getAll();
      final exportData = await prepareDataForExport(dataToExport);
      await writeDataToFile(filePath, exportData);
      return true;
    } catch (e) {
      // 处理导出错误
      return false;
    }
  }

  /// 从文件导入数据
  /// [filePath] 导入文件路径
  /// [overwrite] 是否覆盖现有数据
  Future<List<T>> importFromFile(String filePath, {bool overwrite = false}) async {
    try {
      final fileData = await readDataFromFile(filePath);
      final entities = await parseImportData(fileData);
      
      if (overwrite) {
        // 如果选择覆盖，先删除所有现有数据
        final existingEntities = await getAll();
        await deleteAll(existingEntities);
      }
      
      // 保存导入的实体
      return await saveAll(entities);
    } catch (e) {
      // 处理导入错误
      return [];
    }
  }

  /// 准备数据用于导出
  /// 子类可以覆盖此方法以提供特定的导出格式
  Future<String> prepareDataForExport(List<T> entities) async {
    // 默认实现，将实体列表转换为JSON字符串
    final List<Map<String, dynamic>> dataList = entities.map((e) => e.toMap()).toList();
    return dataList.toString();
  }

  /// 解析导入的数据
  /// 子类必须实现此方法以将导入的数据转换为实体列表
  Future<List<T>> parseImportData(String data);

  /// 将数据写入文件
  /// 子类可以覆盖此方法以提供特定的文件写入逻辑
  Future<void> writeDataToFile(String filePath, String data) async {
    // 此方法应由子类实现，因为它涉及平台特定的文件操作
    throw UnimplementedError('writeDataToFile must be implemented by subclasses');
  }

  /// 从文件读取数据
  /// 子类可以覆盖此方法以提供特定的文件读取逻辑
  Future<String> readDataFromFile(String filePath) async {
    // 此方法应由子类实现，因为它涉及平台特定的文件操作
    throw UnimplementedError('readDataFromFile must be implemented by subclasses');
  }

  /// 验证导入的数据
  /// 子类可以覆盖此方法以提供特定的数据验证逻辑
  Future<bool> validateImportData(List<T> entities) async {
    // 默认实现，不进行验证
    return true;
  }
}