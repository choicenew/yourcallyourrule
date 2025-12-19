import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import './models/custom_view_data.dart';
import './models/live_update_progress_data.dart';

typedef NotificationTapCallback = void Function(String? payload);

class LiveUpdates {
  static const MethodChannel _channel = MethodChannel('live_updates');
  static const EventChannel _payloadChannel = EventChannel('live_updates/payload');

  static Stream<String?>? _notificationPayloadStream;

  static NotificationTapCallback? _onNotificationTapped;

  static Future<void> initialize({
    NotificationTapCallback? onNotificationTapped,
  }) async {
    _onNotificationTapped = onNotificationTapped;
    _channel.setMethodCallHandler(_handleMethod);
  }

  static Future<dynamic> _handleMethod(MethodCall call) async {
    switch (call.method) {
      case 'onNotificationTapped':
        final payload = call.arguments as String?;
        _onNotificationTapped?.call(payload);
        break;
      default:
        throw UnsupportedError('Unknown method ${call.method}');
    }
  }

  static Stream<String?> get notificationPayloadStream {
    _notificationPayloadStream ??= _payloadChannel.receiveBroadcastStream().cast<String?>();
    return _notificationPayloadStream!;
  }

  /// [核心方法 1] - 显示一个完全由XML布局定义的、高度自定义的通知。
  static Future<void> showLayoutNotification({
    required int notificationId,
    required String layoutName,
    // [最终的、绝对的修正] 恢复到您原始的、正确的 viewData 结构！！！
    // Key 是 XML 里的 View ID，Value 是数据。
    Map<String, CustomViewData> viewData = const {},
    bool ongoing = true,
    String? payload,
    String? smallIconName,
    String? title,
  }) async {
    final Map<String, Map<String, dynamic>> viewDataMaps =
        viewData.map((key, value) => MapEntry(key, value.toMap()));

    await _channel.invokeMethod('showLayoutNotification', {
      'notificationId': notificationId,
      'layoutName': layoutName,
      'viewData': viewDataMaps, // 直接传递 viewData
      'ongoing': ongoing,
      'payload': payload,
      'smallIconName': smallIconName,
      'title': title,
    });
  }

  /// [核心方法 2] - (这个方法是正确的，保持不变)
  static Future<void> showNotification({
    required int notificationId,
    required String title,
    required String text,
    String style = 'bigText',
    bool ongoing = true,
    String? payload,
    int? progress,
    int? progressMax,
    bool? progressIndeterminate,
    List<LiveUpdateSegment>? progressSegments,
    List<LiveUpdatePoint>? progressPoints,
    Uint8List? progressTrackerIcon,
  }) async {
    await _channel.invokeMethod('showNotification', {
      'notificationId': notificationId,
      'title': title,
      'text': text,
      'style': style,
      'ongoing': ongoing,
      'payload': payload,
      'progress': progress,
      'progressMax': progressMax,
      'progressIndeterminate': progressIndeterminate,
      'progressSegments': progressSegments?.map((s) => s.toMap()).toList(),
      'progressPoints': progressPoints?.map((p) => p.toMap()).toList(),
      'progressTrackerIcon': progressTrackerIcon,
    });
  }

  /// 取消一个通知
  static Future<void> cancelNotification(int notificationId) async {
    await _channel.invokeMethod('cancelNotification', {
      'notificationId': notificationId,
    });
  }
}