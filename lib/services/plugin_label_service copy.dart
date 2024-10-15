import 'dart:async';

import 'package:dlibphonenumber/dlibphonenumber.dart';

//import 'dart:js';

import 'package:sqflite/sqflite.dart' as localLabel;
import 'package:sqflite/sqflite.dart';


import 'label_service.dart';
import 'plugin_manager_service.dart';


class PluginLabelService {
  final Database database;

  PluginLabelService(this.database);

  Future<Map<String, String>?> getLabelByPhoneNumber(String phoneNumber) async {
    // 1. 解析电话号码
    PhoneNumberUtil phoneNumberUtil = PhoneNumberUtil.instance;
    PhoneNumber parsedPhoneNumber = phoneNumberUtil.parse(phoneNumber, null);

    // 2. 格式化为 E.164 格式和本地格式的号码
    final e164Number = PhoneNumberUtil.instance
        .format(parsedPhoneNumber, PhoneNumberFormat.e164);
    final nationalNumber = PhoneNumberUtil.instance
        .format(parsedPhoneNumber, PhoneNumberFormat.national);

    // 创建 PluginManager 的实例
    final pluginService = PluginService(database);
    // 调用所有已启用插件的函数查询
    final Map<String, dynamic>? labelData =
        await pluginService.callPlugins(phoneNumber, nationalNumber, e164Number);

// 等待 labelData 解析完成后，提取所需信息
    final sourceLabel = labelData?['sourceLabel'];
    final source = labelData?['source'];
    final count = labelData?['count'];
    final predefinedLabel = labelData?['predefinedLabel'];

    /*
    // 查询黑白名单中的标签

    // 打开数据库
    final _databaseName = "number_control_list.db";

    final _database = await blacklistWhitelist.openDatabase(_databaseName);


    // 创建 listService 实例
    final blacklistService = BlacklistService(_database);
    final whitelistService = WhitelistService(_database);
    // 通过电话号码获取标签

    final blacklistLabel =
        await blacklistService.getLabelByPhoneNumber(phoneNumber);
    final whitelistLabel =
        await whitelistService.getLabelByPhoneNumber(phoneNumber);
   */

    // 查询本地label service的标签

    // 打开数据库
    final _labelServiceDatabaseName = "call_rule_database.db";

    final _labelServiceDatabase =
        await localLabel.openDatabase(_labelServiceDatabaseName);

    // 创建 listService 实例
    final labelService = LabelService(_labelServiceDatabase);

    // 通过电话号码获取标签

    final existingLabel =
        await labelService.getLabelByPhoneNumber(phoneNumber);

// 如果数据库中没有标签，则插入标签；否则更新标签信息

    if (existingLabel == null) {
      await _labelServiceDatabase.insert('labels', {
        'phoneNumber': phoneNumber,
        'label': predefinedLabel,
      });
    } else {
      await _labelServiceDatabase.update(
        'labels',
        {
          'label': predefinedLabel,
        },
        where: 'phoneNumber = ?',
        whereArgs: [phoneNumber],
      );
    }

    /* 合并所有标签数据
    final labelExists = blacklistLabel != null ||
        whitelistLabel != null ||
        existingLabel != null;
    // 如果数据库中没有标签，则插入标签
    if (!labelExists) {
      await database.insert('labels', {
        'phoneNumber': phoneNumber,
        'label': predefinedLabel,
      });
    } else {
      // 数据库中有标签，则更新标签信息
      await database.update(
          'labels',
          {
            'label': predefinedLabel,
          },
          where: 'phoneNumber = ?',
          whereArgs: [phoneNumber]);
    }

    */
    //返回标签数据
    return {
      'sourceLabel': sourceLabel,
      'source': source,
      'count': count,
      'predefinedLabel':
          predefinedLabel, // Added this to include all relevant data
    };
  }
}
