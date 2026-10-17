// features/notifications/services/notification_history_service.dart

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:yourcallyourrule/data/models/notification_item.dart';

part 'notification_history_service.g.dart';

@Riverpod(keepAlive: true)
NotificationHistoryService notificationHistoryService(Ref ref) {
  return NotificationHistoryService();
}

/// 通知历史服务类
/// 职责：封装所有与通知历史相关的持久化和业务逻辑。
class NotificationHistoryService {
  NotificationHistoryService([this._prefs]);

  SharedPreferences? _prefs;
  static const _storageKey = 'notification_history';
  static const _maxNotifications = 50;

  Future<SharedPreferences> get _effectivePrefs async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!;
  }

  Future<List<NotificationItem>> _load() async {
    try {
      final prefs = await _effectivePrefs;
      final jsonString = prefs.getString(_storageKey);
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
      final prefs = await _effectivePrefs;
      final jsonList = notifications.map((item) => item.toJson()).toList();
      await prefs.setString(_storageKey, jsonEncode(jsonList));
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