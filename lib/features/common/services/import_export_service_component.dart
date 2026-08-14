import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:yourcallyourrule/core/base/base_entity.dart';
import 'package:yourcallyourrule/core/services/import_export_service.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

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
      final result = await FilePicker.pickFiles(
        dialogTitle: AppLocalizations.of(context)!.importEntity(entityTypeName),
        type: FileType.custom,
        allowedExtensions: ['json'],
      );
      
      if (result != null && result.files.single.path != null) {
        final entities = await importExportService.importFromFile(result.files.single.path!);
        
        // 调用回调函数处理导入的实体
        await onEntitiesImported(entities);
        
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(AppLocalizations.of(context)!.entityImportSuccess(entityTypeName, entities.length)),
          backgroundColor: Colors.green,
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(AppLocalizations.of(context)!.entityImportFailed(entityTypeName, e.toString())),
        backgroundColor: Colors.red,
      ));
    }
  }

  /// 导出规则
  Future<void> exportToFile(BuildContext context) async {
    try {
      // 获取要导出的实体
      final entities = await getEntitiesToExport();
      
      // 准备导出数据字节
      final bytes = await importExportService.prepareExportBytes(entities);

      final result = await FilePicker.saveFile(
        dialogTitle: AppLocalizations.of(context)!.exportEntity(entityTypeName),
        fileName: '${entityTypeName.toLowerCase().replaceAll(' ', '_')}_export.json',
        bytes: bytes,
      );
      
      if (result != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(AppLocalizations.of(context)!.entityExportSuccess(entityTypeName)),
          backgroundColor: Colors.green,
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(AppLocalizations.of(context)!.entityExportFailed(entityTypeName, e.toString())),
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
          label: Text(AppLocalizations.of(context)!.import),
          onPressed: () => importFromFile(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
          ),
        ),
        const SizedBox(width: 16),
        ElevatedButton.icon(
          icon: const Icon(Icons.file_download),
          label: Text(AppLocalizations.of(context)!.export),
          onPressed: () => exportToFile(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
          ),
        ),
      ],
    );
  }
  
  /// 显示导入导出对话框
  void showImportExportDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.importExportTitle),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(AppLocalizations.of(context)!.importExportDescription(entityTypeName)),
            const SizedBox(height: 16),
            buildImportExportButtons(context),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppLocalizations.of(context)!.closeButton),
          ),
        ],
      ),
    );
  }
}