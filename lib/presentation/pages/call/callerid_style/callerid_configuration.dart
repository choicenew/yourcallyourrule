import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../generated/l10n.dart';
import '../../../../application/usecases/caller_id_style/caller_id_style_provider.dart';

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
      'textStirColor': styleProvider.textStirColor.value,
      'textSimCardColor': styleProvider.textSimCardColor.value,
      'textIconLabelColor': styleProvider.textIconLabelColor.value,
      'textIconLocationColor': styleProvider.textIconLocationColor.value,
      'textIconCallTypeColor': styleProvider.textIconCallTypeColor.value,
      'avatarBorderColor': styleProvider.avatarBorderColor.value,
      'nameFontSize': styleProvider.nameFontSize,
      'numberFontSize': styleProvider.numberFontSize,
      'locationFontSize': styleProvider.locationFontSize,
      'carrierFontSize': styleProvider.carrierFontSize,
      'countryNameFontSize': styleProvider.countryNameFontSize,
      'labelsFontSize': styleProvider.labelsFontSize,
      'countFontSize': styleProvider.countFontSize,
      'numberTypeFontSize': styleProvider.numberTypeFontSize,
      'stirFontSize': styleProvider.stirFontSize,
      'simCardFontSize': styleProvider.simCardFontSize,
      'avatarSize': styleProvider.avatarSize,
      'avatarBorderSize': styleProvider.avatarBorderSize,
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
    
    // 添加新的颜色设置
    if (config.containsKey('textStirColor')) {
      styleProvider.setTextStirColor(Color(config['textStirColor']));
    }
    if (config.containsKey('textSimCardColor')) {
      styleProvider.setTextSimCardColor(Color(config['textSimCardColor']));
    }
    if (config.containsKey('textIconLabelColor')) {
      styleProvider.setTextIconLabelColor(Color(config['textIconLabelColor']));
    }
    if (config.containsKey('textIconLocationColor')) {
      styleProvider.setTextIconLocationColor(Color(config['textIconLocationColor']));
    }
    if (config.containsKey('textIconCallTypeColor')) {
      styleProvider.setTextIconCallTypeColor(Color(config['textIconCallTypeColor']));
    }
    if (config.containsKey('avatarBorderColor')) {
      styleProvider.setAvatarBorderColor(Color(config['avatarBorderColor']));
    }

    // 字体大小设置
    styleProvider.setNameFontSize((config['nameFontSize'] as num).toDouble());
    styleProvider.setNumberFontSize((config['numberFontSize'] as num).toDouble());
    styleProvider.setLocationFontSize((config['locationFontSize'] as num).toDouble());
    styleProvider.setCarrierFontSize((config['carrierFontSize'] as num).toDouble());
    styleProvider
        .setCountryNameFontSize((config['countryNameFontSize'] as num).toDouble());
    styleProvider.setLabelsFontSize((config['labelsFontSize'] as num).toDouble());
    styleProvider.setCountFontSize((config['countFontSize'] as num).toDouble());
    styleProvider
        .setNumberTypeFontSize((config['numberTypeFontSize'] as num).toDouble());
    
    // 添加新的字体大小设置
    if (config.containsKey('stirFontSize')) {
      styleProvider.setStirFontSize((config['stirFontSize'] as num).toDouble());
    }
    if (config.containsKey('simCardFontSize')) {
      styleProvider.setSimCardFontSize((config['simCardFontSize'] as num).toDouble());
    }

    // 尺寸设置
    styleProvider.setAvatarSize((config['avatarSize'] as num).toDouble());
    if (config.containsKey('avatarBorderSize')) {
      styleProvider.setAvatarBorderSize((config['avatarBorderSize'] as num).toDouble());
    }
    styleProvider.setIconSize((config['iconSize'] as num).toDouble());
    styleProvider.setWindowSize(
        (config['windowWidth'] as num).toDouble(), (config['windowHeight'] as num).toDouble());

    // 位置设置
    styleProvider.updateAvatarPosition(Offset(
      (config['avatarPosition']['dx'] as num).toDouble(),
      (config['avatarPosition']['dy'] as num).toDouble(),
    ));
    styleProvider.updateNamePosition(Offset(
      (config['namePosition']['dx'] as num).toDouble(),
      (config['namePosition']['dy'] as num).toDouble(),
    ));
    styleProvider.updateCarrierPosition(Offset(
      (config['carrierPosition']['dx'] as num).toDouble(),
      (config['carrierPosition']['dy'] as num).toDouble(),
    ));
    styleProvider.updateCountryNamePosition(Offset(
      (config['countryNamePosition']['dx'] as num).toDouble(),
      (config['countryNamePosition']['dy'] as num).toDouble(),
    ));
    styleProvider.updateLabelsPosition(Offset(
      (config['labelsPosition']['dx'] as num).toDouble(),
      (config['labelsPosition']['dy'] as num).toDouble(),
    ));
    styleProvider.updateCountPosition(Offset(
      (config['countPosition']['dx'] as num).toDouble(),
      (config['countPosition']['dy'] as num).toDouble(),
    ));
    styleProvider.updateNumberTypePosition(Offset(
      (config['numberTypePosition']['dx'] as num).toDouble(),
      (config['numberTypePosition']['dy'] as num).toDouble(),
    ));
    styleProvider.updateNumberPosition(Offset(
      (config['numberPosition']['dx'] as num).toDouble(),
      (config['numberPosition']['dy'] as num).toDouble(),
    ));
    styleProvider.updateLocationPosition(Offset(
      (config['locationPosition']['dx'] as num).toDouble(),
      (config['locationPosition']['dy'] as num).toDouble(),
    ));
    
    // 添加新的位置设置
    if (config.containsKey('callTypePosition')) {
      styleProvider.updateCallTypePosition(Offset(
        (config['callTypePosition']['dx'] as num).toDouble(),
        (config['callTypePosition']['dy'] as num).toDouble(),
      ));
    }
    if (config.containsKey('simCardPosition')) {
      styleProvider.updateSimCardPosition(Offset(
        (config['simCardPosition']['dx'] as num).toDouble(),
        (config['simCardPosition']['dy'] as num).toDouble(),
      ));
    }
    if (config.containsKey('stirPosition')) {
      styleProvider.updateStirPosition(Offset(
        (config['stirPosition']['dx'] as num).toDouble(),
        (config['stirPosition']['dy'] as num).toDouble(),
      ));
    }
  }

  // 保存配置到 SharedPreferences
  static Future<void> toSharedPreferences(
      CallerIdStyleProvider styleProvider) async {
    final prefs = await SharedPreferences.getInstance();
    final config = _getConfigMap(styleProvider);
    await prefs.setString('caller_id_config', json.encode(config));
  }

  // 从 SharedPreferences 加载配置
  static Future<void> fromSharedPreferences(CallerIdStyleProvider styleProvider) async {
    final prefs = await SharedPreferences.getInstance();

    try {
      final configStr = prefs.getString('caller_id_config');
      if (configStr != null && configStr.isNotEmpty) {
        final config = json.decode(configStr);
        updateConfigFromMap(config, styleProvider);
      }
    } catch (e) {
      // 处理错误
    }
  }

  // 保存配置到文件
  static Future<void> saveConfiguration(
      CallerIdStyleProvider styleProvider) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/caller_id_config.json');
    final config = _getConfigMap(styleProvider);
    await file.writeAsString(json.encode(config));
  }

  // 从文件加载配置
  static Future<void> loadConfiguration(
      CallerIdStyleProvider styleProvider) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/caller_id_config.json');
      final jsonString = await file.readAsString();
      final config = json.decode(jsonString);
      updateConfigFromMap(config, styleProvider);
    } catch (e) {
      // 处理错误
    }
  }

  // 导出配置到用户选择的位置
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

  // 从 JSON 字符串导入配置
  static void _importConfigurationFromJson(
      String jsonString, CallerIdStyleProvider styleProvider) {
    final config = json.decode(jsonString);
    updateConfigFromMap(config, styleProvider);
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
            try {
              _importConfigurationFromJson(text, styleProvider);
            } catch (e) {
              // 处理JSON解析错误
            }
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

// SharedPreferences 异步包装类 (兼容性代码)
class SharedPreferencesAsync {
  Future<String?> getString(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  Future<void> setString(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }
}