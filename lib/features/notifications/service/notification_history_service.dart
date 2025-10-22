// features/notifications/services/notification_history_service.dart

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:yourcallyourrule/data/models/notification_item.dart';


part 'notification_history_service.g.dart';

@Riverpod(keepAlive: true)
Future<SharedPreferences> sharedPreferences(Ref ref) {
  return SharedPreferences.getInstance();
}

@Riverpod(keepAlive: true)
NotificationHistoryService notificationHistoryService(Ref ref) {
  final sharedPreferences = ref.watch(sharedPreferencesProvider).value;
  if (sharedPreferences == null) {
    throw Exception('SharedPreferences not yet available');
  }
  return NotificationHistoryService(sharedPreferences);
}

/// 通知历史服务类
/// 职责：封装所有与通知历史相关的持久化和业务逻辑。
class NotificationHistoryService {
  NotificationHistoryService(this._prefs);

  final SharedPreferences _prefs;
  static const _storageKey = 'notification_history';
  static const _maxNotifications = 50;

  Future<List<NotificationItem>> _load() async {
    try {
      final jsonString = _prefs.getString(_storageKey);
      if (jsonString != null) {
        final jsonList = jsonDecode(jsonString) as List;
        return jsonList.map((item) => NotificationItem.fromJson(item)).toList();
      }
      return [];
    } catch (e) { 
      debugPrint('Error loading notification history: $e');
      return []; 
    }
  }
  
  Future<List<NotificationItem>> loadNotifications() async {
    return _load();
  }

  Future<void> _save(List<NotificationItem> notifications) async {
    try {
      final jsonList = notifications.map((item) => item.toJson()).toList();
      await _prefs.setString(_storageKey, jsonEncode(jsonList));
    } catch (e) {
      debugPrint('Error saving notification history: $e');
    }
  }

  Future<void> addNotification({
    required String title, required String body, required String type, Map<String, dynamic>? payload,
  }) async {
    final current = await _load();
    final newNotification = NotificationItem(
      id: const Uuid().v4(), title: title, body: body, type: type,
      timestamp: DateTime.now(), payload: payload,
    );
    var updatedList = [newNotification, ...current];
    if (updatedList.length > _maxNotifications) {
      updatedList = updatedList.sublist(0, _maxNotifications);
    }
    await _save(updatedList);
  }

  Future<void> removeNotification(String id) async {
    final current = await _load();
    final updatedList = current.where((n) => n.id != id).toList();
    await _save(updatedList);
  }

  Future<void> removeNotificationsByType(String type) async {
    final current = await _load();
    final updatedList = current.where((n) => n.type != type).toList();
    await _save(updatedList);
  }

  Future<void> clearAllNotifications() async {
    await _save([]);
  }
}