import 'dart:core';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';


import '../../generated/l10n.dart';
import '../../new_set_icons.dart';


import '../subpage_style.dart';





// 提取的公共 Widget 代码 (函数式)
Widget buildAddImportItem(
    TextEditingController urlController,
    String? filePath,
    Function(String?) onFilePathChanged) {
  const textFieldHeight = 50.0;

  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: urlController,
                decoration: inputDecoration.copyWith(
                  labelText: S.current.link,
                  labelStyle: inputTextStyle,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, top: 8.0),
                child: Text(
                  S.current.chooseOnlyLinkOrFile,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16.0),

        GestureDetector(
          child: Container(
            height: textFieldHeight,
            decoration: inputBoxDecoration,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left:16),
                  child: Text(
                    S.current.openLocalFolder,
                    style: inputTextStyle,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 16.0),
                  child: Icon(NewSet.folder_pen, color: Colors.blue),
                ),
              ],
            ),
          ),
          onTap: () async {
            FilePickerResult? result = await FilePicker.platform.pickFiles(
              type: FileType.any,
            );

            if (result != null && result.files.isNotEmpty) {
              final file = result.files.single;
              onFilePathChanged(file.path);
            }
          },
        ),
        const SizedBox(height: 16.0),
        if (filePath != null)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Expanded(
                child: Text(
                  filePath,
                ),
              ),
            ),
          ),
 
    

    /*
        const SizedBox(height: 16.0),
        nativeAdWidgetMedium(adWidth: 320, adHeight: 320),
        const SizedBox(height: 16.0),
        const GoogleAdWidget(adInfo: AdManager.bannerAd),
        const SizedBox(height: 16.0),
      */
      ],
    ),
  );
}


/*
// 在 _build 方法中使用 buildAddImportItem
Widget _build(BuildContext context) {
  return Scaffold(
    body: SingleChildScrollView(
      child: buildAddImportItem(_urlController, filePath, (path) {
        setState(() {
          filePath = path;
        });
      }),
    ),




    
  );
}
*/



/*
Widget _build(BuildContext context) {
  return Scaffold(
    body: SingleChildScrollView(
      child: Column(
        children: [
          buildAddImportItem(_urlController, filePath, (path) {
            setState(() {
              filePath = path;
            });
          }),
          nativeAdWidgetMedium(adWidth: 320, adHeight: 320), // 将广告 Widget 移到这里
          const SizedBox(height: 16.0),
          const GoogleAdWidget(adInfo: AdManager.bannerAd), // 将广告 Widget 移到这里
          const SizedBox(height: 16.0),
        ],
      ),
    ),
    */