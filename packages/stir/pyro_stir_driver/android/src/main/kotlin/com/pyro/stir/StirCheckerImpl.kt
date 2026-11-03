package com.pyro.stir

import android.os.Build
import android.telecom.Call
import android.telecom.Connection

object StirCheckerImpl {

    fun parseStirResult(callDetails: Call.Details?): Map<String, Any?> {
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.R || callDetails == null) {
            return mapOf(
                "isVerified" to false,
                "isFailed" to false,
                "status" to "NOT_AVAILABLE",
                "phoneNumber" to (callDetails?.handle?.schemeSpecificPart ?: "")
            )
        }

        val statusInt = callDetails.callerNumberVerificationStatus
        val isVerified = statusInt == Connection.VERIFICATION_STATUS_PASSED
        val isFailed = statusInt == Connection.VERIFICATION_STATUS_FAILED
        val phoneNumber = callDetails.handle?.schemeSpecificPart ?: ""

        val statusStr = when (statusInt) {
            Connection.VERIFICATION_STATUS_PASSED -> "PASSED"
            Connection.VERIFICATION_STATUS_FAILED -> "FAILED"
            Connection.VERIFICATION_STATUS_NOT_VERIFIED -> "NOT_VERIFIED"
            else -> "UNKNOWN"
        }

        return mapOf(
            "isVerified" to isVerified,
            "isFailed" to isFailed,
            "status" to statusStr,
            "phoneNumber" to phoneNumber
        )
    }
}
