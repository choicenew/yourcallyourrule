package com.pyro.sms_telephony_fallback

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.provider.Telephony
import android.util.Log
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodChannel

class SmsFallbackReceiver : BroadcastReceiver() {

    companion object {
        private const val TAG = "SmsFallbackReceiver"
        const val CHANNEL = "net.pyro.telephony/sms_fallback"
        @Volatile var messenger: BinaryMessenger? = null
    }

    override fun onReceive(context: Context, intent: Intent) {
        if (intent.action != Telephony.Sms.Intents.SMS_RECEIVED_ACTION) return

        try {
            val messages = Telephony.Sms.Intents.getMessagesFromIntent(intent)
            if (messages.isNullOrEmpty()) return

            val msger = messenger ?: return

            var sender = ""
            val bodyBuilder = StringBuilder()
            var timestampMs = System.currentTimeMillis()

            for (sms in messages) {
                if (sms != null) {
                    sender = sms.displayOriginatingAddress.orEmpty()
                    bodyBuilder.append(sms.displayMessageBody.orEmpty())
                    timestampMs = sms.timestampMillis
                }
            }

            val body = bodyBuilder.toString()
            if (body.isBlank()) return

            Log.d(TAG, "Intercepted SMS from $sender: body=$body")

            val payload = mapOf(
                "id" to "sms_$timestampMs",
                "sender" to sender,
                "body" to body,
                "timestampMs" to timestampMs
            )

            android.os.Handler(android.os.Looper.getMainLooper()).post {
                MethodChannel(msger, CHANNEL).invokeMethod("onSmsReceived", payload)
            }
        } catch (e: Exception) {
            Log.e(TAG, "Error processing SMS_RECEIVED intent: ${e.message}", e)
        }
    }
}
