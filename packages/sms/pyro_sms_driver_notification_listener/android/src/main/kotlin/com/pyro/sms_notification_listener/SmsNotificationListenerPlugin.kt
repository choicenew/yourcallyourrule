package com.pyro.sms_notification_listener

import android.content.Context
import android.content.Intent
import android.provider.Settings
import androidx.core.app.NotificationManagerCompat
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

class SmsNotificationListenerPlugin: FlutterPlugin, MethodCallHandler {
  private lateinit var channel: MethodChannel
  private var context: Context? = null

  override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    context = binding.applicationContext
    channel = MethodChannel(binding.binaryMessenger, "net.pyro.telephony/sms_notification_listener")
    channel.setMethodCallHandler(this)
    SmsNotificationListenerService.messenger = binding.binaryMessenger
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    val ctx = context
    if (ctx == null) {
        result.error("NO_CONTEXT", "Application context is null", null)
        return
    }

    when (call.method) {
      "cancelNotification" -> {
        val args = call.arguments as? Map<*,*>
        val key = args?.get("key") as? String
        if (key != null) {
          SmsNotificationListenerService.instance?.cancelNotificationByKey(key)
          result.success(true)
        } else {
          result.error("INVALID_KEY", "Notification key is null", null)
        }
      }
      "isPermissionGranted", "isListenerPermissionGranted" -> {
          val granted = NotificationManagerCompat.getEnabledListenerPackages(ctx).contains(ctx.packageName)
          result.success(granted)
      }
      "requestPermission" -> {
          val intent = Intent(Settings.ACTION_NOTIFICATION_LISTENER_SETTINGS)
          intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
          ctx.startActivity(intent)
          result.success(null)
      }
      "saveEvidence" -> {
          val args = call.arguments as? Map<*, *>
          val key = args?.get("key") as? String ?: args?.get("id") as? String ?: ""
          val pkg = args?.get("packageName") as? String ?: ""
          val sender = args?.get("sender") as? String ?: ""
          val body = args?.get("body") as? String ?: ""
          
          val prefs = ctx.getSharedPreferences("pyro_sms_evidence", Context.MODE_PRIVATE)
          val now = System.currentTimeMillis()
          prefs.edit()
            .putString("evidence_$now", "$pkg|$sender|$body")
            .apply()
            
          result.success(mapOf("saved" to true, "key" to key, "timestampMs" to now))
      }
      "setProtectedPackages" -> {
          val args = call.arguments as? Map<*, *>
          val pkgs = (args?.get("packages") as? List<*>)?.mapNotNull { it?.toString() }
              ?: (call.arguments as? List<*>)?.mapNotNull { it?.toString() }

          if (pkgs != null && pkgs.isNotEmpty()) {
              SmsNotificationListenerService.updateProtectedPackages(pkgs)
          }
          result.success(true)
      }
      else -> result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
    SmsNotificationListenerService.messenger = null
    context = null
  }
}


