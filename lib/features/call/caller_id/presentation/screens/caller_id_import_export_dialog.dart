import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';

Future<String?> showImportExportDialog(BuildContext context) async {
  final result = await showDialog<String?>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('配置管理'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Icon(Icons.upload_file),
            title: Text('导入配置'),
            onTap: () async {
              final result = await FilePicker.platform.pickFiles(
                type: FileType.custom,
                allowedExtensions: ['json'],
              );
              Navigator.pop(context, result?.files.single.path);
            },
          ),
          ListTile(
            leading: Icon(Icons.download), 
            title: Text('导出配置'),
            onTap: () async {
              final directory = await getDownloadsDirectory();
              final path = '${directory?.path}/caller_id_config.json';
              Navigator.pop(context, path);
            },
          )
        ],
      ),
    ),
  );
  return result;
}