package com.pyro.call_screening

import android.os.Build
import android.os.Handler
import android.os.Looper
import android.telecom.Call
import android.telecom.CallScreeningService
import android.telecom.Connection
import android.util.Log
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.*

class CallScreeningServiceImpl : CallScreeningService() {
    companion object {
        private const val TAG = "CallScreeningServiceImpl"
        const val CHANNEL = "net.pyro.telephony/call_screening"
        private const val DEADLINE_MS = 3000L
        @Volatile var messenger: io.flutter.plugin.common.BinaryMessenger? = null
    }

    private val serviceScope = CoroutineScope(SupervisorJob() + Dispatchers.IO)
    private val handler = Handler(Looper.getMainLooper())

    override fun onScreenCall(callDetails: Call.Details) {
        val handle = callDetails.handle
        val rawNumber = handle?.schemeSpecificPart ?: ""
        
        // Extract STIR/SHAKEN caller authentication status
        var stirStatus = "NOT_AVAILABLE"
        var isVerified = false
        var isFailed = false

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
            val statusInt = callDetails.callerNumberVerificationStatus
            isVerified = statusInt == Connection.VERIFICATION_STATUS_PASSED
            isFailed = statusInt == Connection.VERIFICATION_STATUS_FAILED
            stirStatus = when (statusInt) {
                Connection.VERIFICATION_STATUS_PASSED -> "PASSED"
                Connection.VERIFICATION_STATUS_FAILED -> "FAILED"
                Connection.VERIFICATION_STATUS_NOT_VERIFIED -> "NOT_VERIFIED"
                else -> "UNKNOWN"
            }
        }

        Log.i(TAG, "onScreenCall received: number=$rawNumber, STIR status=$stirStatus, isVerified=$isVerified")

        serviceScope.launch {
            val startTime = System.currentTimeMillis()
            
            // Suspend and await Dart layer decision with timeout
            val decisionMap = withTimeoutOrNull(DEADLINE_MS) {
                evaluateCallViaFlutter(rawNumber, callDetails)
            }

            val elapsed = System.currentTimeMillis() - startTime
            Log.d(TAG, "Evaluation elapsed: ${elapsed}ms, decision=$decisionMap")

            val action = decisionMap?.get("action") as? String ?: "allow"
            val reason = decisionMap?.get("reason") as? String ?: "default_pass"
            
            val builder = CallResponse.Builder()
            
            when (action) {
                "reject", "block", "disallow" -> {
                    Log.i(TAG, "Action REJECT triggered for $rawNumber (reason: $reason)")
                    builder.setDisallowCall(true)
                    builder.setRejectCall(true)
                    builder.setSkipCallLog(false)
                    builder.setSkipNotification(false)
                }
                "silence" -> {
                    Log.i(TAG, "Action SILENCE triggered for $rawNumber (reason: $reason)")
                    builder.setDisallowCall(false)
                    builder.setSilenceCall(true)
                }
                "answerThenHangup" -> {
                    // Answer-then-hangup handled asynchronously in CallControl, allow ring first
                    Log.i(TAG, "Action ANSWER_THEN_HANGUP triggered for $rawNumber (reason: $reason)")
                    builder.setDisallowCall(false)
                    builder.setSilenceCall(true) // Silence ringtone immediately
                }
                else -> {
                    Log.i(TAG, "Action ALLOW triggered for $rawNumber")
                    builder.setDisallowCall(false)
                    builder.setSilenceCall(false)
                }
            }
            
            respondToCall(callDetails, builder.build())
        }
    }

    private suspend fun evaluateCallViaFlutter(rawNumber: String, callDetails: Call.Details): Map<*, *>? {
        return suspendCancellableCoroutine { continuation ->
            val msger = messenger
            if (msger == null) {
                Log.e(TAG, "BinaryMessenger is NULL, cannot communicate with Dart layer.")
                if (continuation.isActive) continuation.resumeWith(Result.success(mapOf("action" to "allow")))
                return@suspendCancellableCoroutine
            }

            val callData = mapOf(
                "callId" to "call_${System.currentTimeMillis()}",
                "phoneNumber" to rawNumber,
                "normalizedNumber" to rawNumber.replace(Regex("\\D"), ""),
                "timestampMs" to System.currentTimeMillis()
            )

            handler.post {
                MethodChannel(msger, CHANNEL).invokeMethod("evaluateCall", callData, object : MethodChannel.Result {
                    override fun success(result: Any?) {
                        if (continuation.isActive) {
                            if (result is Map<*, *>) {
                                continuation.resumeWith(Result.success(result))
                            } else if (result is String) {
                                continuation.resumeWith(Result.success(mapOf("action" to result)))
                            } else {
                                continuation.resumeWith(Result.success(mapOf("action" to "allow")))
                            }
                        }
                    }

                    override fun error(errorCode: String, errorMessage: String?, errorDetails: Any?) {
                        Log.e(TAG, "Flutter evaluateCall error: $errorMessage")
                        if (continuation.isActive) continuation.resumeWith(Result.success(mapOf("action" to "allow")))
                    }

                    override fun notImplemented() {
                        Log.e(TAG, "Flutter evaluateCall NOT IMPLEMENTED")
                        if (continuation.isActive) continuation.resumeWith(Result.success(mapOf("action" to "allow")))
                    }
                })
            }
        }
    }

    override fun onDestroy() {
        super.onDestroy()
        serviceScope.cancel()
    }
}
