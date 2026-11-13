package com.pyro.call_control

import android.content.Context
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

class CallControlDriverPlugin : FlutterPlugin, MethodCallHandler {
    private lateinit var channel: MethodChannel
    private var applicationContext: Context? = null

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        applicationContext = binding.applicationContext
        channel = MethodChannel(binding.binaryMessenger, "net.pyro.telephony/call_control")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            "executeAction" -> {
                val actionType = call.argument<String>("actionType") ?: "allow"
                val phoneNumber = call.argument<String>("phoneNumber") ?: ""
                val delayHangupMs = (call.argument<Number>("delayHangupMs")?.toLong()) ?: 1000L
                val enableMicMuteProtection = call.argument<Boolean>("enableMicMuteProtection") ?: true
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

                val resMap = mapOf(
                    "success" to true,
                    "actionType" to actionType,
                    "message" to "Registered & executed action: $actionType via native CallControlDriverPlugin",
                    "executedAtMs" to System.currentTimeMillis()
                )
                result.success(resMap)
            }
            "setMicrophoneMuted" -> {
                val muted = call.argument<Boolean>("muted") ?: false
                val ctx = applicationContext
                if (ctx != null) {
                    val success = AnswerHangupCoordinator.setMicrophoneMuted(ctx, muted)
                    result.success(success)
                } else {
                    result.success(false)
                }
            }
            else -> {
                result.notImplemented()
            }
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
        applicationContext = null
    }
}
