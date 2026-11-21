package com.pyro.sms_notification_listener

import android.content.Context
import android.content.Intent
import android.provider.Settings
import androidx.core.app.NotificationManagerCompat
import io.flutter.embedding.engine.plugins.FlutterPlugin

class SmsNotificationListenerPlugin: FlutterPlugin, SmsNotificationListenerHostApi {
  private var context: Context? = null

  override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    context = binding.applicationContext
    SmsNotificationListenerHostApi.setUp(binding.binaryMessenger, this)
    SmsNotificationListenerService.messenger = binding.binaryMessenger
  }

  override fun isPermissionGranted(): Boolean {
    val ctx = context ?: return false
    return NotificationManagerCompat.getEnabledListenerPackages(ctx).contains(ctx.packageName)
  }

  override fun requestPermission() {
    val ctx = context ?: return
    val intent = Intent(Settings.ACTION_NOTIFICATION_LISTENER_SETTINGS)
    intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
    ctx.startActivity(intent)
  }

  override fun cancelNotification(key: String): Boolean {
    SmsNotificationListenerService.instance?.cancelNotificationByKey(key)
    return true
  }

  override fun saveEvidence(evidence: SmsEvidencePayloadDetails): Boolean {
    val ctx = context ?: return false
    val prefs = ctx.getSharedPreferences("pyro_sms_evidence", Context.MODE_PRIVATE)
    val now = evidence.timestampMs ?: System.currentTimeMillis()
    val pkg = evidence.packageName.orEmpty()
    val sender = evidence.sender.orEmpty()
    val body = evidence.body.orEmpty()
    prefs.edit()
      .putString("evidence_$now", "$pkg|$sender|$body")
      .apply()
    return true
  }

  override fun setProtectedPackages(packages: List<String>): Boolean {
    if (packages.isNotEmpty()) {
      SmsNotificationListenerService.updateProtectedPackages(packages)
    }
    return true
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    SmsNotificationListenerHostApi.setUp(binding.binaryMessenger, null)
    SmsNotificationListenerService.messenger = null
    context = null
  }
}
