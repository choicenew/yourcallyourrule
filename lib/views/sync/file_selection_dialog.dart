import 'dart:async';

import 'package:flutter/material.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:webdav_client/webdav_client.dart' as webdav;

import '../../generated/l10n.dart';

class FileSelectionDialog {
  static Future<dynamic> showFileSelectionDialog(
    List<dynamic> files,
    String dialogTitle,
    BuildContext context,
  ) async {
    return await showDialog(
      context: context,
      builder: (context) {
        return _buildFileSelectionDialog(files, dialogTitle, context);
      },
    );
  }

  static Widget _buildFileSelectionDialog(
    List<dynamic> files,
    String dialogTitle,
    BuildContext context,
  ) {
    return AlertDialog(
      title: Text(dialogTitle),
      content: SizedBox(
        height: 500, // 设置一个合适的高度，例如 200
        width: double.maxFinite,
        child: ListView.builder(
          shrinkWrap: true, // 确保 ListView 只占用所需的空间
          itemCount: files.length,
          itemBuilder: (context, index) {
            final dynamic file = files[index];
            return ListTile(
              title: Text(file.name ?? ''),
              subtitle: _buildSubtitle(file),
              onTap: () {
                Navigator.pop(context, file);
              },
            );
          },
        ),
      ),
      actions: [
        TextButton(
          child: Text(S.of(context).cancel),
          onPressed: () {
            Navigator.pop(context, null);
          },
        ),
      ],
    );
  }

  static Widget? _buildSubtitle(dynamic file) {
    if (file is drive.File) {
      return Text(file.modifiedTime.toString());
    } else if (file is webdav.File) {
      return Text(file.mTime.toString());
    }
    return null;
  }
}