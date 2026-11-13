package com.pyro.call_redirection

import android.net.Uri
import android.os.SystemClock
import android.telecom.CallRedirectionService
import android.telecom.PhoneAccountHandle
import android.util.Log
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.SupervisorJob
import kotlinx.coroutines.launch
import kotlinx.coroutines.withTimeoutOrNull
import java.util.concurrent.ConcurrentHashMap

class CallRedirectionServiceImpl : CallRedirectionService() {

    companion object {
        private const val TAG = "CallRedirectionService"
        const val CHANNEL = "net.pyro.telephony/call_redirection"
        private const val DEADLINE_MS = 3000L
        @Volatile var messenger: BinaryMessenger? = null

        private val bypassTokens = ConcurrentHashMap<String, Long>()

        fun addBypassToken(phoneNumber: String, durationMs: Long) {
            val clean = phoneNumber.replace(Regex("\\D"), "")
            bypassTokens[clean] = System.currentTimeMillis() + durationMs
            if (phoneNumber != clean) {
                bypassTokens[phoneNumber] = System.currentTimeMillis() + durationMs
            }
        }

        fun isBypassed(phoneNumber: String): Boolean {
            val clean = phoneNumber.replace(Regex("\\D"), "")
            val expiry = bypassTokens[clean] ?: bypassTokens[phoneNumber] ?: return false
            if (System.currentTimeMillis() > expiry) {
                bypassTokens.remove(clean)
                bypassTokens.remove(phoneNumber)
                return false
            }
            return true
        }
    }

    private val serviceScope = CoroutineScope(SupervisorJob() + Dispatchers.IO)

    override fun onPlaceCall(
        handle: Uri,
        initialPhoneAccount: PhoneAccountHandle,
        allowInteractiveResponse: Boolean,
    ) {
        val rawNumber = handle.schemeSpecificPart.orEmpty()
        Log.d(TAG, "onPlaceCall: rawNumber=$rawNumber, allowInteractive=$allowInteractiveResponse")

        // 1. Emergency floor check -> Immediate proceed
        if (isEmergencyNumber(rawNumber)) {
            placeCallUnmodified()
            return
        }

        // 2. Car mode / Non-interactive check -> Immediate proceed
        if (!allowInteractiveResponse) {
            placeCallUnmodified()
            return
        }

        // 3. User "Call Anyway" bypass token check -> Immediate proceed
        if (isBypassed(rawNumber)) {
            Log.d(TAG, "Number $rawNumber is in bypass cache, placing call unmodified")
            placeCallUnmodified()
            return
        }

        serviceScope.launch {
            val startTime = SystemClock.elapsedRealtime()
            val decisionMap = withTimeoutOrNull(DEADLINE_MS) {
                evaluateCallViaFlutter(rawNumber, allowInteractiveResponse)
            }

            val elapsed = SystemClock.elapsedRealtime() - startTime
            Log.d(TAG, "Evaluation elapsed: ${elapsed}ms, decision=$decisionMap")

            val action = decisionMap?.get("action") as? String ?: "proceed"
            val reason = decisionMap?.get("reason") as? String ?: "databaseMatch"

            when (action) {
                "holdAndNotify", "block" -> {
                    Log.w(TAG, "Holding call to $rawNumber ($reason) and showing 'Call Anyway' notification")
                    CallRedirectionNotificationHelper.notifyCallHeld(applicationContext, rawNumber, reason)
                    cancelCall()
                }
                else -> placeCallUnmodified()
            }
        }
    }

    override fun onRedirectionTimeout() {
        Log.w(TAG, "Redirection timeout triggered")
    }

    private val mainHandler = android.os.Handler(android.os.Looper.getMainLooper())

    private suspend fun evaluateCallViaFlutter(rawNumber: String, allowInteractive: Boolean): Map<*, *>? {
        return kotlin.coroutines.suspendCoroutine { continuation ->
            val msger = messenger
            if (msger == null) {
                continuation.resumeWith(Result.success(mapOf("action" to "proceed")))
                return@suspendCoroutine
            }

            val callData = mapOf(
                "id" to "call_${System.currentTimeMillis()}",
                "rawPhoneNumber" to rawNumber,
                "normalizedPhoneNumber" to rawNumber.replace(Regex("\\D"), ""),
                "timestampMs" to System.currentTimeMillis(),
                "isInteractiveAllowed" to allowInteractive,
                "isCarModeActive" to false,
            )

            mainHandler.post {
                MethodChannel(msger, CHANNEL).invokeMethod("evaluateCall", callData, object : MethodChannel.Result {
                    override fun success(result: Any?) {
                        if (result is Map<*, *>) {
                            continuation.resumeWith(Result.success(result))
                        } else {
                            continuation.resumeWith(Result.success(mapOf("action" to "proceed")))
                        }
                    }

                    override fun error(errorCode: String, errorMessage: String?, errorDetails: Any?) {
                        continuation.resumeWith(Result.success(mapOf("action" to "proceed")))
                    }

                    override fun notImplemented() {
                        continuation.resumeWith(Result.success(mapOf("action" to "proceed")))
                    }
                })
            }
        }
    }

    private fun isEmergencyNumber(rawNumber: String): Boolean {
        val clean = rawNumber.replace(Regex("\\D"), "")
        return clean in setOf("110", "119", "120", "122", "911", "112", "999", "000")
    }
}
