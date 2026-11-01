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

class CallRedirectionServiceImpl : CallRedirectionService() {

    companion object {
        private const val TAG = "CallRedirectionService"
        private const val CHANNEL = "com.yours.yourcallyourrule/call_redirection"
        private const val DEADLINE_MS = 3000L
        @Volatile var messenger: BinaryMessenger? = null
    }

    private val serviceScope = CoroutineScope(SupervisorJob() + Dispatchers.IO)

    override fun onPlaceCall(
        handle: Uri,
        initialPhoneAccount: PhoneAccountHandle,
        allowInteractiveResponse: Boolean,
    ) {
        val rawNumber = handle.schemeSpecificPart.orEmpty()
        Log.d(TAG, "onPlaceCall: rawNumber=$rawNumber, allowInteractive=$allowInteractiveResponse")

        if (isEmergencyNumber(rawNumber)) {
            placeCallUnmodified()
            return
        }

        if (!allowInteractiveResponse) {
            placeCallUnmodified()
            return
        }

        serviceScope.launch {
            val startTime = SystemClock.elapsedRealtime()
            val result = withTimeoutOrNull(DEADLINE_MS) {
                evaluateCallViaFlutter(rawNumber, allowInteractiveResponse)
            }

            val elapsed = SystemClock.elapsedRealtime() - startTime
            Log.d(TAG, "Evaluation elapsed: ${elapsed}ms, result=$result")

            when (result) {
                "holdAndNotify", "block" -> cancelCall()
                else -> placeCallUnmodified()
            }
        }
    }

    override fun onRedirectionTimeout() {
        Log.w(TAG, "Redirection timeout triggered")
    }

    private suspend fun evaluateCallViaFlutter(rawNumber: String, allowInteractive: Boolean): String {
        return kotlin.coroutines.suspendCoroutine { continuation ->
            val msger = messenger
            if (msger == null) {
                continuation.resumeWith(Result.success("proceed"))
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

            MethodChannel(msger, CHANNEL).invokeMethod("evaluateCall", callData, object : MethodChannel.Result {
                override fun success(result: Any?) {
                    if (result is Map<*, *>) {
                        val action = result["action"] as? String ?: "proceed"
                        continuation.resumeWith(Result.success(action))
                    } else {
                        continuation.resumeWith(Result.success("proceed"))
                    }
                }

                override fun error(errorCode: String, errorMessage: String?, errorDetails: Any?) {
                    continuation.resumeWith(Result.success("proceed"))
                }

                override fun notImplemented() {
                    continuation.resumeWith(Result.success("proceed"))
                }
            })
        }
    }

    private fun isEmergencyNumber(rawNumber: String): Boolean {
        val clean = rawNumber.replace(Regex("\\D"), "")
        return clean in setOf("110", "119", "120", "122", "911", "112", "999", "000")
    }
}
