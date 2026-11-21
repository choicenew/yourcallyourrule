package com.pyro.sms_telephony_fallback

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.provider.Telephony
import android.util.Log
import io.flutter.plugin.common.BinaryMessenger

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

            val payload = TelephonySmsPayloadDetails(
                id = "sms_$timestampMs",
                sender = sender,
                body = body,
                timestampMs = timestampMs
            )

            android.os.Handler(android.os.Looper.getMainLooper()).post {
                TelephonyFallbackFlutterApi(msger).onSmsReceived(payload) { result ->
                    if (result.isFailure) {
                        Log.w(TAG, "Failed to deliver SMS to Flutter: ${result.exceptionOrNull()?.message}")
                    }
                }
            }
        } catch (e: Exception) {
            Log.e(TAG, "Error processing SMS_RECEIVED intent: ${e.message}", e)
        }
    }
}
