package com.pyro.call_redirection

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.net.Uri
import android.util.Log

/**
 * BroadcastReceiver triggered when the user taps "Call Anyway" in the notification.
 * Adds a 15-minute temporary bypass token and re-initiates the outbound call.
 */
class CallAnywayReceiver : BroadcastReceiver() {
    companion object {
        const val ACTION_CALL_ANYWAY = "com.pyro.call_redirection.ACTION_CALL_ANYWAY"
        const val EXTRA_PHONE_NUMBER = "extra_phone_number"
        private const val TAG = "CallAnywayReceiver"
    }

    override fun onReceive(context: Context, intent: Intent) {
        if (intent.action != ACTION_CALL_ANYWAY) return

        val phoneNumber = intent.getStringExtra(EXTRA_PHONE_NUMBER).orEmpty()
        if (phoneNumber.isBlank()) return

        Log.d(TAG, "User tapped 'Call Anyway' for number: $phoneNumber")

        // 1. Add 15-minute temporary bypass token
        CallRedirectionServiceImpl.addBypassToken(phoneNumber, 15 * 60 * 1000L)

        // 2. Dismiss notification
        CallRedirectionNotificationHelper.cancelNotification(context, phoneNumber.hashCode())

        // 3. Re-dial outbound call
        try {
            val callIntent = Intent(Intent.ACTION_CALL, Uri.parse("tel:${Uri.encode(phoneNumber)}")).apply {
                flags = Intent.FLAG_ACTIVITY_NEW_TASK
            }
            context.startActivity(callIntent)
        } catch (e: Exception) {
            Log.e(TAG, "Failed to re-dial $phoneNumber via ACTION_CALL: ${e.message}")
            // Fallback to dialer pad
            val dialIntent = Intent(Intent.ACTION_DIAL, Uri.parse("tel:${Uri.encode(phoneNumber)}")).apply {
                flags = Intent.FLAG_ACTIVITY_NEW_TASK
            }
            context.startActivity(dialIntent)
        }
    }
}
