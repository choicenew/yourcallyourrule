package com.yours.live_updates

import android.app.Notification
import android.app.Service
import android.content.Intent
import android.os.IBinder
import androidx.core.app.NotificationCompat

/**
 * Foreground service for supporting CallStyle notifications
 * This service is required for Android to allow CallStyle notifications
 */
class NotificationForegroundService : Service() {
    companion object {
        const val NOTIFICATION_ID = 9999
    }

    override fun onBind(intent: Intent?): IBinder? {
        return null
    }

    override fun onCreate() {
        super.onCreate()
    }

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        val title = intent?.getStringExtra("title") ?: "Call in progress"
        val text = intent?.getStringExtra("text") ?: "Tap to return to call"
        startForeground(title, text)
        return START_STICKY
    }

    private fun startForeground(title: String, text: String) {
        val notification = NotificationCompat.Builder(this, LiveUpdateManager.CHANNEL_ID)
            .setContentTitle(title)
            .setContentText(text)
            .setSmallIcon(android.R.drawable.ic_dialog_info)
            .setPriority(NotificationCompat.PRIORITY_HIGH)
            .setCategory(NotificationCompat.CATEGORY_CALL)
            .build()

        startForeground(NOTIFICATION_ID, notification)
    }
}