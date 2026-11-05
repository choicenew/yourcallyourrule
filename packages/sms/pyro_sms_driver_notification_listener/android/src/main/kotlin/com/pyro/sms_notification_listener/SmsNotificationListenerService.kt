package com.pyro.sms_notification_listener

import android.app.Notification
import android.service.notification.NotificationListenerService
import android.service.notification.StatusBarNotification
import android.util.Log
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodChannel
import java.util.concurrent.ConcurrentHashMap

class SmsNotificationListenerService : NotificationListenerService() {

    companion object {
        private const val TAG = "SmsNotificationListener"
        const val CHANNEL = "net.pyro.telephony/sms_notification_listener"
        @Volatile var messenger: BinaryMessenger? = null
        @Volatile var instance: SmsNotificationListenerService? = null

        private val protectedPackagesSet = ConcurrentHashMap.newKeySet<String>()

        fun updateProtectedPackages(packages: Collection<String>) {
            protectedPackagesSet.clear()
            protectedPackagesSet.addAll(packages)
            Log.d(TAG, "Updated protected packages: $protectedPackagesSet")
        }

        fun getProtectedPackages(): Set<String> {
            return protectedPackagesSet.toSet()
        }
    }

    override fun onCreate() {
        super.onCreate()
        instance = this
        Log.d(TAG, "SmsNotificationListenerService created")
    }

    override fun onDestroy() {
        super.onDestroy()
        if (instance == this) instance = null
    }

    override fun onNotificationPosted(sbn: StatusBarNotification?) {
        if (sbn == null) return
        val pkg = sbn.packageName.orEmpty()

        if (protectedPackagesSet.isNotEmpty() && !protectedPackagesSet.contains(pkg)) return

        val extras = sbn.notification?.extras ?: return
        val title = extras.getCharSequence(Notification.EXTRA_TITLE)?.toString().orEmpty()
        val text = extras.getCharSequence(Notification.EXTRA_TEXT)?.toString().orEmpty()

        if (text.isBlank()) return

        Log.d(TAG, "Intercepted notification from $pkg: title=$title, key=${sbn.key}")

        val messenger = messenger ?: return
        val payload = mapOf(
            "id" to sbn.key,
            "sender" to title,
            "body" to text,
            "packageName" to pkg,
            "timestampMs" to sbn.postTime
        )

        android.os.Handler(android.os.Looper.getMainLooper()).post {
            MethodChannel(messenger, CHANNEL).invokeMethod("onNotificationReceived", payload)
        }
    }

    fun cancelNotificationByKey(key: String) {
        try {
            cancelNotification(key)
            Log.d(TAG, "Successfully cancelled notification key: $key")
        } catch (e: Exception) {
            Log.e(TAG, "Failed to cancel notification key $key: ${e.message}")
        }
    }
}

