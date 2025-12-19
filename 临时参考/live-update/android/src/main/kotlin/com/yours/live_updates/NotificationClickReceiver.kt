package com.yours.live_updates

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent

class NotificationClickReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context, intent: Intent) {
           // ▼▼▼▼▼ 添加这些日志 ▼▼▼▼▼
    android.util.Log.e("PLUGIN_DEBUG", "!!!!!!!!!! NotificationClickReceiver ON_RECEIVE TRIGGERED !!!!!!!!!!")
        val payload = intent.getStringExtra("payload")
            android.util.Log.e("PLUGIN_DEBUG", "Payload received inside Receiver: '$payload'")
    // ▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲
        // 通过静态方法将 payload 发送回 Flutter (Stream 方式)
        LiveUpdatesPlugin.sendPayload(payload)

        // 通过 MethodChannel 直接调用 Dart 回调 (Callback 方式)
        LiveUpdatesPlugin.onNotificationTapped(payload)

        // 照常启动 App
        val launchIntent = context.packageManager.getLaunchIntentForPackage(context.packageName)
        if (launchIntent != null) {
            launchIntent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TOP)
            launchIntent.putExtra("payload", payload)
            context.startActivity(launchIntent)
        }
    }
}

