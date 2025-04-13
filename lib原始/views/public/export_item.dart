import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

import 'dart:core';


import '../../generated/l10n.dart';
import '../../services/snackbar_service.dart';

import '../../utils/ad_manager.dart';
import '../../widgets/adwidgets/native_ads.dart';
import '../../widgets/google_ad.dart';
import '../subpage_style.dart';



class ExportScreenWidget<T> extends StatefulWidget {
  final Future<List<T>> Function() getEntries;
  final Widget Function(BuildContext, List<T>) buildSelectDialog;
  final Future<void> Function(List<T>, String) exportToCsv;
  final Future<void> Function(List<T>, String) exportToJson;

  const ExportScreenWidget({
    super.key,
    required this.getEntries,
    required this.buildSelectDialog,
    required this.exportToCsv,
    required this.exportToJson,
  });

  @override
  ExportScreenWidgetState<T> createState() => ExportScreenWidgetState<T>();
}

class ExportScreenWidgetState<T> extends State<ExportScreenWidget<T>> {
  String? _filePath;
  List<T>? _selectedEntries;  // 初始化为空列表
  String _selectedType = 'csv'; // Default export format (CSV)
  

  @override
  Widget build(BuildContext context) {
    const textFieldHeight = 68.0;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              _buildSelectEntriesButton(textFieldHeight),
              const SizedBox(height: 16.0),
              _buildExportFilePathButton(textFieldHeight),
              const SizedBox(height: 16.0),
              if (_filePath != null) _buildFilePathDisplay(),
              const SizedBox(height: 16.0),
              _buildExportFormatDropdown(textFieldHeight),
              const SizedBox(height: 16.0),
               
          nativeAdWidgetMedium(adWidth: 320, adHeight: 320), // 将广告 Widget 移到这里
          const SizedBox(height: 16.0),
          const GoogleAdWidget(adInfo: AdManager.bannerAd), // 将广告 Widget 移到这里
         
            ],
          ),
        ),
      ),
      floatingActionButton: _buildExportButton(),
    );
  }

//item 选择器
  Widget _buildSelectEntriesButton(double height) {
    return GestureDetector(
      child: Container(
        height: height,
        decoration: inputBoxDecoration,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left:16),
              child: Text(
                S.of(context).selectEntriesToExport,
                style: inputTextStyle,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 16.0),
              child: Icon(Icons.folder, color: Colors.blue),
            ),
          ],
        ),
      ),
      onTap: () async {
        final entries = await widget.getEntries();
        _selectedEntries = await showDialog<List<T>>(
          context: context,
          builder: (BuildContext context) => widget.buildSelectDialog(context, entries),
        );
        setState(() {});
      },
    );
  }

//路径选择器
  Widget _buildExportFilePathButton(double height) {
    return GestureDetector(
      child: Container(
        height: height,
        decoration: inputBoxDecoration,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left:16),
              child: Text(
                S.of(context).selectingExportFolder,
                style: inputTextStyle,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 16.0),
              child: Icon(Icons.folder, color: Colors.blue),
            ),
          ],
        ),
      ),
                      // 设置点击区域为整个容器区域
      onTap: () async {
        String? selectedDirectory = await FilePicker.platform.getDirectoryPath();
        if (selectedDirectory != null) {
          setState(() {
            _filePath = selectedDirectory;
          });
        }
      },
    );
  }

  Widget _buildFilePathDisplay() {
    return Padding(
      padding: const EdgeInsets.only(left:16),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal, // 设置水平滚动
        child: Text(_filePath!// 使用感叹号(!)断言 filePath 不为 null
          //overflow: TextOverflow.ellipsis, // 设置文本溢出时使用省略号
          //maxLines: 1, // 设置最大行数为 1
        ),
      ),
    );
  }

  Widget _buildExportFormatDropdown(double height) {
    return Container(
      height: height,
      decoration: inputBoxDecoration,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left:16),
            child: Text(
              S.of(context).exportFormat,
              style: inputTextStyle,
            ),
          ),
          DropdownButton<String>(
            value: _selectedType,
            items: const [
              DropdownMenuItem(value: 'csv', child: Text('CSV')),
              DropdownMenuItem(value: 'json', child: Text('JSON')),
            ],
            onChanged: (value) {
              setState(() {
                _selectedType = value!;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildExportButton() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0, right: 16.0),
      child: ElevatedButton(
        onPressed: _exportEntries,
        style: addButtonStyle,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check),
            const SizedBox(width: 8.0),
            Text(S.of(context).export),
          ],
        ),
      ),
    );
  }

  void _exportEntries() async {
    if (_filePath == null || _filePath!.isEmpty) {
      showErrorSnackBar(context, S.of(context).pleaseSelectAnExportFolder);
      return;
    }

    if (_selectedEntries == null || _selectedEntries!.isEmpty) {
      showErrorSnackBar(context, S.of(context).pleaseSelectEntriesToExport);
      return;
    }

    try {
      switch (_selectedType) {
        case 'csv':
          await widget.exportToCsv(_selectedEntries!, _filePath!);
          break;
        case 'json':
          await widget.exportToJson(_selectedEntries!, _filePath!);
          break;
      }
      showSuccessSnackBar(context, S.of(context).exportSuccessful);
    } catch (e) {
      //print('Error exporting: $e');
      showErrorSnackBar(context, S.of(context).exportFailed);
    }
  }
}