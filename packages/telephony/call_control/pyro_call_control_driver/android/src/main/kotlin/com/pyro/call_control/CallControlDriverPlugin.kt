package com.pyro.call_control

import android.content.Context
import io.flutter.embedding.engine.plugins.FlutterPlugin

class CallControlDriverPlugin : FlutterPlugin, CallControlHostApi {
    private var applicationContext: Context? = null

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        applicationContext = binding.applicationContext
        CallControlHostApi.setUp(binding.binaryMessenger, this)
    }

    override fun executeAction(request: CallControlActionRequest): CallControlActionResult {
        val actionType = request.actionType
        val phoneNumber = request.phoneNumber
        val delayHangupMs = request.delayHangupMs
        val enableMicMuteProtection = request.enableMicMuteProtection
        val ctx = applicationContext

        if (actionType.equals("answerThenHangup", ignoreCase = true)) {
            // Register task in zero-disk-IO memory registry with 10s TTL
            PendingActionRegistry.registerPendingAnswerHangup(
                phoneNumber = phoneNumber,
                delayMs = delayHangupMs,
                enableMicMuteProtection = enableMicMuteProtection
            )

            if (ctx != null) {
                AnswerHangupCoordinator.scheduleAnswerThenHangup(
                    context = ctx,
                    delayMs = delayHangupMs,
                    enableMicMuteProtection = enableMicMuteProtection,
                    onHangupAction = {
                        // Native hangup callback hook
                    }
                )
            }
        }

        return CallControlActionResult(
            success = true,
            actionType = actionType,
            message = "Registered & executed action: $actionType via native CallControlDriverPlugin",
            executedAtMs = System.currentTimeMillis()
        )
    }

    override fun setMicrophoneMuted(muted: Boolean): Boolean {
        val ctx = applicationContext
        return if (ctx != null) {
            AnswerHangupCoordinator.setMicrophoneMuted(ctx, muted)
        } else {
            false
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        CallControlHostApi.setUp(binding.binaryMessenger, null)
        applicationContext = null
    }
}
