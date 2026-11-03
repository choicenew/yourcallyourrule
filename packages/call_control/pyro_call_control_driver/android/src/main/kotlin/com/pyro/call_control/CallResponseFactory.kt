package com.pyro.call_control

import android.os.Build
import android.telecom.CallScreeningService

/**
 * Factory for creating Android Telecom CallResponse objects based on CallActionType.
 */
object CallResponseFactory {

    fun buildResponse(actionType: String): CallScreeningService.CallResponse {
        val builder = CallScreeningService.CallResponse.Builder()

        when (actionType.lowercase()) {
            "reject", "block", "disallow" -> {
                builder.setDisallowCall(true)
                builder.setRejectCall(true)
                builder.setSkipCallLog(false)
                builder.setSkipNotification(true)
            }
            "silence" -> {
                builder.setDisallowCall(false)
                builder.setSilenceCall(true)
            }
            "answerthenhangup" -> {
                // For answerThenHangup, CallScreeningService must allow the call so that InCallService / Telecom can pick up,
                // while AnswerHangupCoordinator enforces microsecond mic mute and disconnects after delay.
                builder.setDisallowCall(false)
                builder.setSilenceCall(true)
            }
            "voicemail" -> {
                builder.setDisallowCall(true)
                builder.setRejectCall(false)
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
                    builder.setSilenceCall(true)
                }
            }
            "allow" -> {
                builder.setDisallowCall(false)
                builder.setSilenceCall(false)
            }
            else -> {
                builder.setDisallowCall(false)
            }
        }

        return builder.build()
    }
}
