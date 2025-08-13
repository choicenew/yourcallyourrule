import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:uuid/uuid.dart';
import 'package:yourcallyourrule/core/entities/plugin/plugin_data.dart';
import 'package:yourcallyourrule/core/entities/remote/remote_number_entry.dart';
import 'package:yourcallyourrule/core/entities/label/label_phone_entry.dart';
import 'package:yourcallyourrule/core/value_objects/phone_number.dart';
import 'package:yourcallyourrule/core/value_objects/rule_priority.dart';
import 'package:yourcallyourrule/core/value_objects/rule_action.dart';
import 'package:yourcallyourrule/features/remote_filter/services/remote_number_service.dart';

/// 插件数据同步服务类，负责将插件数据和标签电话条目同步到远程号码服务
/// 监听插件数据流和标签电话条目流，并将数据转换为远程号码条目
class PluginToRemoteSyncService {
  final RemoteNumberService _remoteNumberService;
  StreamSubscription<dynamic>? _dataSubscription;

  PluginToRemoteSyncService(this._remoteNumberService);

  /// 开始监听插件数据流并同步到远程号码服务
  void startSync(Stream<PluginData> pluginDataStream, [Stream<LabelPhoneEntry>? labelPhoneEntryStream]) {
    _dataSubscription?.cancel();
    
    // 合并两个数据流，使用merge操作符
    if (labelPhoneEntryStream != null) {
      final mergedStream = pluginDataStream.map((data) => {'type': 'plugin', 'data': data})
        .mergeWith([labelPhoneEntryStream.map((data) => {'type': 'label', 'data': data})]);
      
      _dataSubscription = mergedStream.listen((event) {
        if (event['type'] == 'plugin') {
          _handleData(event['data'] as PluginData, null);
        } else if (event['type'] == 'label') {
          _handleData(null, event['data'] as LabelPhoneEntry);
        }
      });
    } else {
      // 只有插件数据流
      _dataSubscription = pluginDataStream.listen((data) => _handleData(data, null));
    }
  }

  /// 统一处理数据并转换为远程号码条目
  /// 可以处理PluginData或LabelPhoneEntry
  Future<void> _handleData(PluginData? pluginData, LabelPhoneEntry? labelPhoneEntry) async {
    // 确定要处理的电话号码
    PhoneNumber? phoneNumber;
    if (pluginData != null && pluginData.phoneNumber != null) {
      phoneNumber = PhoneNumber.fromString(pluginData.phoneNumber!);
    } else if (labelPhoneEntry != null) {
      phoneNumber = labelPhoneEntry.phoneNumber;
    } else {
      return; // 没有有效的电话号码，直接返回
    }
    
    final existingEntry = await _remoteNumberService.getRemoteNumberByPhoneNumber(phoneNumber);
    
    if (existingEntry != null) {
      // 更新现有条目
      final updatedEntry = RemoteNumberEntry(
        id: existingEntry.id,
        phoneNumber: phoneNumber,
        name: _determineName(pluginData, labelPhoneEntry, existingEntry),
        label: _determineLabel(pluginData, existingEntry),
        priority: existingEntry.priority,
        count: pluginData?.count ?? existingEntry.count,
        action: _determineAction(pluginData, labelPhoneEntry, existingEntry),
        isEnabled: existingEntry.isEnabled,
      );
      await _remoteNumberService.updateRemoteNumber(updatedEntry);
    } else {
      // 创建新条目
      final newEntry = RemoteNumberEntry(
        id: const Uuid().v4(),
        phoneNumber: phoneNumber,
        name: pluginData?.name ?? labelPhoneEntry?.name ?? '',
        label: pluginData?.predefinedLabel ?? '',
        priority: const RulePriority(0),
        count: pluginData?.count ?? 0,
        action: _determineAction(pluginData, labelPhoneEntry, null),
        isEnabled: true,
      );
      await _remoteNumberService.addRemoteNumber(newEntry);
    }
  }
  
  /// 确定名称
  String _determineName(PluginData? pluginData, LabelPhoneEntry? labelPhoneEntry, RemoteNumberEntry existingEntry) {
    if (pluginData?.name != null && pluginData!.name!.isNotEmpty) {
      return pluginData.name!;
    } else if (labelPhoneEntry != null && labelPhoneEntry.name.isNotEmpty) {
      return labelPhoneEntry.name;
    }
    return existingEntry.name;
  }
  
  /// 确定标签
  String _determineLabel(PluginData? pluginData, RemoteNumberEntry existingEntry) {
    if (pluginData?.predefinedLabel != null && pluginData!.predefinedLabel!.isNotEmpty) {
      return pluginData.predefinedLabel!;
    }
    
    return existingEntry.label;
   }
   
   /// 确定动作
   RuleAction _determineAction(PluginData? pluginData, LabelPhoneEntry? labelPhoneEntry, RemoteNumberEntry? existingEntry) {
     // 优先使用插件数据中的动作
     if (pluginData != null && pluginData.action != RuleAction.none) {
       return pluginData.action;
     }
     
     // 其次使用标签电话条目中的动作
     if (labelPhoneEntry != null && labelPhoneEntry.action != RuleAction.none) {
       return labelPhoneEntry.action;
     }
     
     // 最后使用现有条目中的动作或默认值
     return existingEntry?.action ?? RuleAction.none;
   }

  /// 停止同步服务
  void dispose() {
    _dataSubscription?.cancel();
    _dataSubscription = null;
  }
}