package com.pyro.call_control

import android.Manifest
import android.content.Context
import android.content.pm.PackageManager
import android.os.Build
import android.telecom.TelecomManager
import android.util.Log
import androidx.core.content.ContextCompat
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
            "isPermissionGranted" -> {
                val ctx = applicationContext
                if (ctx != null && Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                    val granted = ContextCompat.checkSelfPermission(
                        ctx,
                        Manifest.permission.ANSWER_PHONE_CALLS
                    ) == PackageManager.PERMISSION_GRANTED
                    result.success(granted)
                } else {
                    result.success(true)
                }
            }
            "executeAction" -> {
                val actionType = call.argument<String>("actionType") ?: "allow"
                val phoneNumber = call.argument<String>("phoneNumber") ?: ""
                val delayHangupMs = (call.argument<Number>("delayHangupMs")?.toLong()) ?: 1000L
                val enableMicMuteProtection = call.argument<Boolean>("enableMicMuteProtection") ?: true
                val ctx = applicationContext

                if (actionType.equals("answerThenHangup", ignoreCase = true)) {
                    PendingActionRegistry.registerPendingAnswerHangup(
                        phoneNumber = phoneNumber,
                        delayMs = delayHangupMs,
                        enableMicMuteProtection = enableMicMuteProtection
                    )

                    if (ctx != null) {
                        val telecomManager = ctx.getSystemService(Context.TELECOM_SERVICE) as? TelecomManager
                        AnswerHangupCoordinator.scheduleAnswerThenHangup(
                            context = ctx,
                            delayMs = delayHangupMs,
                            enableMicMuteProtection = enableMicMuteProtection,
                            onAnswerAction = {
                                try {
                                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                                        telecomManager?.acceptRingingCall()
                                        Log.i("CallControlPlugin", "Native acceptRingingCall executed via TelecomManager.")
                                    }
                                } catch (e: SecurityException) {
                                    Log.e("CallControlPlugin", "Permission denied for TelecomManager.acceptRingingCall()", e)
                                } catch (e: Exception) {
                                    Log.e("CallControlPlugin", "Failed to accept ringing call: ${e.message}", e)
                                }
                            },
                            onHangupAction = {
                                try {
                                    val success = telecomManager?.endCall() ?: false
                                    Log.i("CallControlPlugin", "Native hangup execution via TelecomManager: success=$success")
                                } catch (e: SecurityException) {
                                    Log.e("CallControlPlugin", "Permission denied for TelecomManager.endCall()", e)
                                } catch (e: Exception) {
                                    Log.e("CallControlPlugin", "Failed to end call: ${e.message}", e)
                                }
                            }
                        )
                    }
                } else if (actionType.equals("reject", ignoreCase = true)) {
                    if (ctx != null) {
                        try {
                            val telecomManager = ctx.getSystemService(Context.TELECOM_SERVICE) as? TelecomManager
                            telecomManager?.endCall()
                            Log.i("CallControlPlugin", "Native direct REJECT execution via TelecomManager.")
                        } catch (e: Exception) {
                            Log.e("CallControlPlugin", "Direct reject failed: ${e.message}")
                        }
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
