package com.pyro.call_screening

import android.os.Build
import android.telecom.Call
import android.telecom.CallScreeningService
import android.telecom.Connection
import android.util.Log

class CallScreeningServiceImpl : CallScreeningService() {
    companion object {
        private const val TAG = "CallScreeningServiceImpl"
    }

    override fun onScreenCall(callDetails: Call.Details) {
        val handle = callDetails.handle
        val rawNumber = handle?.schemeSpecificPart ?: ""
        
        // Extract STIR/SHAKEN caller authentication status (StirChecker absorption)
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

        val builder = CallResponse.Builder()
        // Dumb driver pass-through: allow call through by default
        builder.setDisallowCall(false)
        builder.setSilenceCall(false)
        respondToCall(callDetails, builder.build())
    }
}
