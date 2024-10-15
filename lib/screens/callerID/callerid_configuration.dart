import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../generated/l10n.dart';
import 'callerid_style_provider.dart';

// 配置管理器类
class ConfigurationManager {
  // 提取公共的配置处理函数
  static Map<String, dynamic> _getConfigMap(
      CallerIdStyleProvider styleProvider) {
    return {
      'backgroundColorStart': styleProvider.backgroundColorStart.value,
      'backgroundColorEnd': styleProvider.backgroundColorEnd.value,
      'textNameColor': styleProvider.textNameColor.value,
      'textNumberColor': styleProvider.textNumberColor.value,
      'textLocationColor': styleProvider.textLocationColor.value,
      'textCarrierColor': styleProvider.textCarrierColor.value,
      'textCountryNameColor': styleProvider.textCountryNameColor.value,
      'textLabelsColor': styleProvider.textLabelsColor.value,
      'textCountColor': styleProvider.textCountColor.value,
      'textNumberTypeColor': styleProvider.textNumberTypeColor.value,
      'nameFontSize': styleProvider.nameFontSize,
      'numberFontSize': styleProvider.numberFontSize,
      'locationFontSize': styleProvider.locationFontSize,
      'carrierFontSize': styleProvider.carrierFontSize,
      'countryNameFontSize': styleProvider.countryNameFontSize,
      'labelsFontSize': styleProvider.labelsFontSize,
      'countFontSize': styleProvider.countFontSize,
      'numberTypeFontSize': styleProvider.numberTypeFontSize,
      'avatarSize': styleProvider.avatarSize,
      'iconSize': styleProvider.iconSize,
      'windowWidth': styleProvider.windowWidth,
      'windowHeight': styleProvider.windowHeight,
      'avatarPosition': {
        'dx': styleProvider.avatarPosition.dx,
        'dy': styleProvider.avatarPosition.dy,
      },
      'namePosition': {
        'dx': styleProvider.namePosition.dx,
        'dy': styleProvider.namePosition.dy,
      },
      'carrierPosition': {
        'dx': styleProvider.carrierPosition.dx,
        'dy': styleProvider.carrierPosition.dy,
      },
      'countryNamePosition': {
        'dx': styleProvider.countryNamePosition.dx,
        'dy': styleProvider.countryNamePosition.dy,
      },
      'labelsPosition': {
        'dx': styleProvider.labelsPosition.dx,
        'dy': styleProvider.labelsPosition.dy,
      },
      'countPosition': {
        'dx': styleProvider.countPosition.dx,
        'dy': styleProvider.countPosition.dy,
      },
      'numberTypePosition': {
        'dx': styleProvider.numberTypePosition.dx,
        'dy': styleProvider.numberTypePosition.dy,
      },
      'numberPosition': {
        'dx': styleProvider.numberPosition.dx,
        'dy': styleProvider.numberPosition.dy,
      },
      'locationPosition': {
        'dx': styleProvider.locationPosition.dx,
        'dy': styleProvider.locationPosition.dy,
      },
      //新增加的sim卡 calltype 和stir 位置
      'callTypePosition': {
        'dx': styleProvider.callTypePosition.dx,
        'dy': styleProvider.callTypePosition.dy,
      },
      'simCardPosition': {
        'dx': styleProvider.simCardPosition.dx,
        'dy': styleProvider.simCardPosition.dy,
      },
      'stirPosition': {
        'dx': styleProvider.stirPosition.dx,
        'dy': styleProvider.stirPosition.dy,
      },
    };
  }

  // 公共方法，用于获取配置 Map
  static Map<String, dynamic> getConfigMap(
      CallerIdStyleProvider styleProvider) {
    return _getConfigMap(styleProvider);
  }

// 更新配置的公共函数
  static void _updateConfigFromMap(
      Map<String, dynamic> config, CallerIdStyleProvider styleProvider) {
    styleProvider
        .setBackgroundColorStart(Color(config['backgroundColorStart']));
    styleProvider.setBackgroundColorEnd(Color(config['backgroundColorEnd']));
    styleProvider.setTextNameColor(Color(config['textNameColor']));
    styleProvider.setTextNumberColor(Color(config['textNumberColor']));
    styleProvider.setTextLocationColor(Color(config['textLocationColor']));
    styleProvider.setTextCarrierColor(Color(config['textCarrierColor']));
    styleProvider
        .setTextCountryNameColor(Color(config['textCountryNameColor']));
    styleProvider.setTextLabelsColor(Color(config['textLabelsColor']));
    styleProvider.setTextCountColor(Color(config['textCountColor']));
    styleProvider.setTextNumberTypeColor(Color(config['textNumberTypeColor']));
    styleProvider.setNameFontSize(config['nameFontSize']);
    styleProvider.setNumberFontSize(config['numberFontSize']);
    styleProvider.setLocationFontSize(config['locationFontSize']);
    styleProvider.setCarrierFontSize(config['carrierFontSize']);
    styleProvider.setCountryNameFontSize(config['countryNameFontSize']);
    styleProvider.setLabelsFontSize(config['labelsFontSize']);
    styleProvider.setCountFontSize(config['countFontSize']);
    styleProvider.setNumberTypeFontSize(config['numberTypeFontSize']);
    styleProvider.setAvatarSize(config['avatarSize']);
    styleProvider.setIconSize(config['iconSize']);
    styleProvider.setWindowSize(config['windowWidth'], config['windowHeight']);
    styleProvider.updateAvatarPosition(
        Offset(config['avatarPosition']['dx'], config['avatarPosition']['dy']));
    styleProvider.updateNamePosition(
        Offset(config['namePosition']['dx'], config['namePosition']['dy']));
    styleProvider.updateCarrierPosition(Offset(
        config['carrierPosition']['dx'], config['carrierPosition']['dy']));
    styleProvider.updateCountryNamePosition(Offset(
        config['countryNamePosition']['dx'],
        config['countryNamePosition']['dy']));
    styleProvider.updateLabelsPosition(
        Offset(config['labelsPosition']['dx'], config['labelsPosition']['dy']));
    styleProvider.updateCountPosition(
        Offset(config['countPosition']['dx'], config['countPosition']['dy']));
    styleProvider.updateNumberTypePosition(Offset(
        config['numberTypePosition']['dx'],
        config['numberTypePosition']['dy']));
    styleProvider.updateNumberPosition(
        Offset(config['numberPosition']['dx'], config['numberPosition']['dy']));
    styleProvider.updateLocationPosition(Offset(
        config['locationPosition']['dx'], config['locationPosition']['dy']));
    //新增加的sim 卡 calltype 和stir 位置
    styleProvider.updateCallTypePosition(Offset(
        config['callTypePosition']['dx'], config['callTypePosition']['dy']));
    styleProvider.updateSimCardPosition(Offset(
        config['simCardPosition']['dx'], config['simCardPosition']['dy']));
    styleProvider.updateStirPosition(
        Offset(config['stirPosition']['dx'], config['stirPosition']['dy']));
  }

  // 更新配置的公共函数 (使用高效的类型转换)
  static void updateConfigFromMap(
      Map<String, dynamic> config, CallerIdStyleProvider styleProvider) {
    // 颜色设置
    styleProvider
        .setBackgroundColorStart(Color(config['backgroundColorStart']));
    styleProvider.setBackgroundColorEnd(Color(config['backgroundColorEnd']));
    styleProvider.setTextNameColor(Color(config['textNameColor']));
    styleProvider.setTextNumberColor(Color(config['textNumberColor']));
    styleProvider.setTextLocationColor(Color(config['textLocationColor']));
    styleProvider.setTextCarrierColor(Color(config['textCarrierColor']));
    styleProvider
        .setTextCountryNameColor(Color(config['textCountryNameColor']));
    styleProvider.setTextLabelsColor(Color(config['textLabelsColor']));
    styleProvider.setTextCountColor(Color(config['textCountColor']));
    styleProvider.setTextNumberTypeColor(Color(config['textNumberTypeColor']));

    // 直接进行类型转换
    styleProvider.setNameFontSize(config['nameFontSize'].toDouble());
    styleProvider.setNumberFontSize(config['numberFontSize'].toDouble());
    styleProvider.setLocationFontSize(config['locationFontSize'].toDouble());
    styleProvider.setCarrierFontSize(config['carrierFontSize'].toDouble());
    styleProvider
        .setCountryNameFontSize(config['countryNameFontSize'].toDouble());
    styleProvider.setLabelsFontSize(config['labelsFontSize'].toDouble());
    styleProvider.setCountFontSize(config['countFontSize'].toDouble());
    styleProvider
        .setNumberTypeFontSize(config['numberTypeFontSize'].toDouble());

    styleProvider.setAvatarSize(config['avatarSize'].toDouble());
    styleProvider.setIconSize(config['iconSize'].toDouble());
    styleProvider.setWindowSize(
        config['windowWidth'].toDouble(), config['windowHeight'].toDouble());

    // Offset 类型也直接进行类型转换
    styleProvider.updateAvatarPosition(Offset(
      config['avatarPosition']['dx'].toDouble(),
      config['avatarPosition']['dy'].toDouble(),
    ));
    styleProvider.updateNamePosition(Offset(
      config['namePosition']['dx'].toDouble(),
      config['namePosition']['dy'].toDouble(),
    ));
    styleProvider.updateCarrierPosition(Offset(
      config['carrierPosition']['dx'].toDouble(),
      config['carrierPosition']['dy'].toDouble(),
    ));
    styleProvider.updateCountryNamePosition(Offset(
      config['countryNamePosition']['dx'].toDouble(),
      config['countryNamePosition']['dy'].toDouble(),
    ));
    styleProvider.updateLabelsPosition(Offset(
      config['labelsPosition']['dx'].toDouble(),
      config['labelsPosition']['dy'].toDouble(),
    ));
    styleProvider.updateCountPosition(Offset(
      config['countPosition']['dx'].toDouble(),
      config['countPosition']['dy'].toDouble(),
    ));
    styleProvider.updateNumberTypePosition(Offset(
      config['numberTypePosition']['dx'].toDouble(),
      config['numberTypePosition']['dy'].toDouble(),
    ));
    styleProvider.updateNumberPosition(Offset(
      config['numberPosition']['dx'].toDouble(),
      config['numberPosition']['dy'].toDouble(),
    ));
    styleProvider.updateLocationPosition(Offset(
      config['locationPosition']['dx'].toDouble(),
      config['locationPosition']['dy'].toDouble(),
    ));
    //新增加的sim 卡 calltype 和stir 位置
    styleProvider.updateCallTypePosition(Offset(
      config['callTypePosition']['dx'].toDouble(),
      config['callTypePosition']['dy'].toDouble(),
    ));
    styleProvider.updateSimCardPosition(Offset(
      config['simCardPosition']['dx'].toDouble(),
      config['simCardPosition']['dy'].toDouble(),
    ));
    styleProvider.updateStirPosition(Offset(
      config['stirPosition']['dx'].toDouble(),
      config['stirPosition']['dy'].toDouble(),
    ));
  }

  // 保存配置到 SharedPreferences
  static Future<void> toSharedPreferences(
      CallerIdStyleProvider styleProvider) async {
    final asyncPrefs = SharedPreferencesAsync();
    final config = _getConfigMap(styleProvider);
    await asyncPrefs.setString('caller_id_config', json.encode(config));
  }

  // 从 SharedPreferences 加载配置
  static Future<CallerIdStyleProvider> fromSharedPreferences() async {
    final asyncPrefs = SharedPreferencesAsync();
    final styleProvider = CallerIdStyleProvider();

    try {
      final config =
          json.decode(await asyncPrefs.getString('caller_id_config') ?? '{}');
      _updateConfigFromMap(config, styleProvider);
    } catch (e) {
     // print('从 SharedPreferences 加载配置出错: $e');
    }

    return styleProvider;
  }

// 保存配置
  static Future<void> saveConfiguration(
      CallerIdStyleProvider styleProvider) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/caller_id_config.json');
    final config = _getConfigMap(styleProvider);
    await file.writeAsString(json.encode(config));
  }

// 加载配置
  static Future<void> loadConfiguration(
      CallerIdStyleProvider styleProvider) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/caller_id_config.json');
      final jsonString = await file.readAsString();
      final config = json.decode(jsonString);
      _updateConfigFromMap(config, styleProvider);
    } catch (e) {
     // print('加载配置出错: $e');
    }
  }

// 导出配置
  static Future<void> exportConfiguration(
      CallerIdStyleProvider styleProvider) async {
    final config = _getConfigMap(styleProvider);
    final jsonString = json.encode(config);

    // 选择保存路径
    String? selectedDirectory = await FilePicker.platform.getDirectoryPath();

    if (selectedDirectory != null) {
      final file = File('$selectedDirectory/caller_id_config.json');
      await file.writeAsString(jsonString);
    }
  }

// 从 JSON 字符串导入配置
  static void _importConfigurationFromJson(
      String jsonString, CallerIdStyleProvider styleProvider) {
    final config = json.decode(jsonString);
    _updateConfigFromMap(config, styleProvider);
  }

// ... 其他函数 (例如 _showImportDialog, _showPasteDialog)
// 显示导入对话框
  static void importConfiguration(
      BuildContext context, CallerIdStyleProvider styleProvider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(S.of(context).importConfiguration),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () async {
                // 从文件导入
                FilePickerResult? result = await FilePicker.platform.pickFiles(
                  type: FileType.custom,
                  allowedExtensions: ['json'],
                );
                if (result != null) {
                  File file = File(result.files.single.path!);
                  final jsonString = await file.readAsString();
                  _importConfigurationFromJson(jsonString, styleProvider);
                  Navigator.of(context).pop();
                }
              },
              child: Text(S.of(context).importFromFile),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // 粘贴文本导入
                _showPasteDialog(context, styleProvider);
              },
              child: Text(S.of(context).pasteJson),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(S.of(context).cancel),
          ),
        ],
      ),
    );
  }

// 显示粘贴对话框
  static void _showPasteDialog(
      BuildContext context, CallerIdStyleProvider styleProvider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(S.of(context).pasteJsonConfiguration),
        content: TextField(
          decoration: InputDecoration(hintText: S.of(context).pasteJsonHere),
          maxLines: null,
          onChanged: (text) {
            _importConfigurationFromJson(text, styleProvider);
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(S.of(context).cancel),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(S.of(context).configurationImported)),
              );
            },
            child: Text(S.of(context).import),
          ),
        ],
      ),
    );
  }
}
