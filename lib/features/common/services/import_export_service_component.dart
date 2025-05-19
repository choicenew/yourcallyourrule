import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:yourcallyourrule/core/base/base_entity.dart';
import 'package:yourcallyourrule/core/services/import_export_service.dart';

/// 通用导入导出服务组件
/// 提供通用的导入导出功能，可以在不同的规则管理页面中复用
class ImportExportServiceComponent<T extends BaseEntity, ID> {
  final ImportExportService<T, ID> importExportService;
  final String entityTypeName;
  final Function(List<T>) onEntitiesImported;
  final Future<List<T>> Function() getEntitiesToExport;

  ImportExportServiceComponent({
    required this.importExportService,
    required this.entityTypeName,
    required this.onEntitiesImported,
    required this.getEntitiesToExport,
  });

  /// 导入规则
  Future<void> importFromFile(BuildContext context) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        dialogTitle: '导入${entityTypeName}',
        type: FileType.custom,
        allowedExtensions: ['json'],
      );
      
      if (result != null && result.files.single.path != null) {
        final entities = await importExportService.importFromFile(result.files.single.path!);
        
        // 调用回调函数处理导入的实体
        await onEntitiesImported(entities);
        
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('${entityTypeName}导入成功，共导入${entities.length}条记录'),
          backgroundColor: Colors.green,
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('导入${entityTypeName}失败: $e'),
        backgroundColor: Colors.red,
      ));
    }
  }

  /// 导出规则
  Future<void> exportToFile(BuildContext context) async {
    try {
      final result = await FilePicker.platform.saveFile(
        dialogTitle: '导出${entityTypeName}',
        fileName: '${entityTypeName.toLowerCase().replaceAll(' ', '_')}_export.json',
      );
      
      if (result != null) {
        // 获取要导出的实体
        final entities = await getEntitiesToExport();
        
        // 导出实体
        final success = await importExportService.exportToFile(result, entities: entities);
        
        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('${entityTypeName}导出成功'),
            backgroundColor: Colors.green,
          ));
        } else {
          throw Exception('导出失败');
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('导出${entityTypeName}失败: $e'),
        backgroundColor: Colors.red,
      ));
    }
  }

  /// 构建导入导出按钮组
  Widget buildImportExportButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton.icon(
          icon: const Icon(Icons.file_upload),
          label: const Text('导入'),
          onPressed: () => importFromFile(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
          ),
        ),
        const SizedBox(width: 16),
        ElevatedButton.icon(
          icon: const Icon(Icons.file_download),
          label: const Text('导出'),
          onPressed: () => exportToFile(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
          ),
        ),
      ],
    );
  }
}