package com.pyro.stir

import android.os.Build
import android.telecom.Call
import android.telecom.Connection
import java.util.concurrent.ConcurrentHashMap

object StirCheckerImpl {

    private val stirCache = ConcurrentHashMap<String, Map<String, Any?>>()

    fun parseStirResult(callDetails: Call.Details?): Map<String, Any?> {
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.R || callDetails == null) {
            val fallback = mapOf(
                "isVerified" to false,
                "isFailed" to false,
                "status" to "NOT_AVAILABLE",
                "phoneNumber" to (callDetails?.handle?.schemeSpecificPart ?: "")
            )
            return fallback
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

        val resMap = mapOf(
            "isVerified" to isVerified,
            "isFailed" to isFailed,
            "status" to statusStr,
            "phoneNumber" to phoneNumber
        )

        if (phoneNumber.isNotEmpty()) {
            stirCache[phoneNumber] = resMap
            val clean = phoneNumber.replace(Regex("\\D"), "")
            if (clean.isNotEmpty()) stirCache[clean] = resMap
        }

        return resMap
    }

    fun getLatestStirResult(phoneNumber: String): Map<String, Any?> {
        val clean = phoneNumber.replace(Regex("\\D"), "")
        val cached = stirCache[phoneNumber] ?: stirCache[clean]
        if (cached != null) return cached

        return mapOf(
            "isVerified" to false,
            "isFailed" to false,
            "status" to "NOT_AVAILABLE",
            "phoneNumber" to phoneNumber
        )
    }
}
