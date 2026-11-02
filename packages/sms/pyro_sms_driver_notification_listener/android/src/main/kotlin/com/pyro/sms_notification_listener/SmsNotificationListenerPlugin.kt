package com.pyro.sms_notification_listener

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

class SmsNotificationListenerPlugin: FlutterPlugin, MethodCallHandler {
  private lateinit var channel: MethodChannel

  override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(binding.binaryMessenger, "com.yours.pyro_sms/notification_listener")
    channel.setMethodCallHandler(this)
    SmsNotificationListenerService.messenger = binding.binaryMessenger
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    when (call.method) {
      "cancelNotification" -> {
        val key = call.arguments as? String
        if (key != null) {
          SmsNotificationListenerService.instance?.cancelNotificationByKey(key)
          result.success(true)
        } else {
          result.error("INVALID_KEY", "Notification key is null", null)
        }
      }
      "isListenerPermissionGranted" -> {
        result.success(SmsNotificationListenerService.instance != null)
      }
      else -> result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
    SmsNotificationListenerService.messenger = null
  }
}
