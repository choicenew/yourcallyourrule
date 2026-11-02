package com.pyro.call_redirection

import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.content.Context
import android.content.Intent
import android.os.Build
import androidx.core.app.NotificationCompat

/**
 * Posts high-priority notification with "Call Anyway" action when an outbound call is held.
 */
object CallRedirectionNotificationHelper {
    private const val CHANNEL_ID = "pyro_call_redirection_channel"
    private const val CHANNEL_NAME = "Outbound Call Shield"

    private void ensureChannel(Context context) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val manager = context.getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
            val channel = NotificationChannel(
                CHANNEL_ID,
                CHANNEL_NAME,
                NotificationManager.IMPORTANCE_HIGH
            ).apply {
                description = "Notifications for held high-risk or premium rate outbound calls"
                enableVibration(true)
            }
            manager.createNotificationChannel(channel)
        }
    }

    fun notifyCallHeld(context: Context, rawNumber: String, reason: String) {
        ensureChannel(context)
        val notificationManager = context.getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager

        // Build "Call Anyway" PendingIntent
        val callAnywayIntent = Intent(context, CallAnywayReceiver::class.java).apply {
            action = CallAnywayReceiver.ACTION_CALL_ANYWAY
            putExtra(CallAnywayReceiver.EXTRA_PHONE_NUMBER, rawNumber)
        }

        val pendingIntentFlags = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
        } else {
            PendingIntent.FLAG_UPDATE_CURRENT
        }

        val callAnywayPendingIntent = PendingIntent.getBroadcast(
            context,
            rawNumber.hashCode(),
            callAnywayIntent,
            pendingIntentFlags
        )

        val builder = NotificationCompat.Builder(context, CHANNEL_ID)
            .setSmallIcon(android.R.drawable.ic_dialog_alert)
            .setContentTitle("Outbound Call Held ($reason)")
            .setContentText("Held call to $rawNumber. Tap 'Call anyway' to dial directly.")
            .setPriority(NotificationCompat.PRIORITY_HIGH)
            .setAutoCancel(true)
            .addAction(
                android.R.drawable.ic_menu_call,
                "Call Anyway",
                callAnywayPendingIntent
            )

        notificationManager.notify(rawNumber.hashCode(), builder.build())
    }

    fun cancelNotification(context: Context, id: Int) {
        val manager = context.getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
        manager.cancel(id)
    }
}
