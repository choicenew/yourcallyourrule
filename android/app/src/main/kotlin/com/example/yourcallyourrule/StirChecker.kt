package com.yours.yourcallyourrule

import android.content.Context
import android.telecom.Call
import android.telecom.Connection
import android.os.Build
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.os.Looper
import android.util.Log


class StirChecker(private val context: Context, private val callDetails: Call.Details?) {

    private val stirChannel = "com.yours.yourcallyourrule/stir_check" // 独立的 Channel
    private val flutterEngine: FlutterEngine?
        get() = (context.applicationContext as? MyApplication)?.flutterEngine
    private val handler = android.os.Handler(Looper.getMainLooper())

    fun sendStirResultToFlutter() {
    Log.d("StirChecker", "sendStirResultToFlutter called") // 添加日志

    if (Build.VERSION.SDK_INT < Build.VERSION_CODES.R || callDetails == null) {
        Log.d("StirChecker", "Android version too low or callDetails is null") // 添加日志
        return 
    }

        val stirStatus = callDetails.callerNumberVerificationStatus
        val isVerified = stirStatus == Connection.VERIFICATION_STATUS_PASSED
        val isNotVerified = stirStatus == Connection.VERIFICATION_STATUS_NOT_VERIFIED
        val isFailed = stirStatus == Connection.VERIFICATION_STATUS_FAILED
        val phoneNumber = callDetails.handle?.schemeSpecificPart  // 获取电话号码

        handler.post {
            flutterEngine?.dartExecutor?.binaryMessenger?.let { binaryMessenger ->
                MethodChannel(binaryMessenger, stirChannel).invokeMethod(
                    "onStirResult",
                    mapOf(
                        "isVerified" to isVerified,
                        "isNotVerified" to isNotVerified,
                        "isFailed" to isFailed,
                        "phoneNumber" to phoneNumber // 添加电话号码到 map 中
                    ),
                    object : MethodChannel.Result {
                        override fun success(result: Any?) {
                            Log.d("StirChecker", "Successfully sent STIR result to Flutter")
                        }

                        override fun error(errorCode: String, errorMessage: String?, errorDetails: Any?) {
                            Log.e("StirChecker", "Error sending STIR result to Flutter: $errorMessage")
                        }

                        override fun notImplemented() {
                            Log.e("StirChecker", "onStirResult not implemented in Flutter")
                        }
                    }
                )
            } ?: Log.e("StirChecker", "FlutterEngine or BinaryMessenger is null")
        }
    }

    fun initialize() {
        // 在 Service 创建完成后，通知 Flutter 端 stirChannel 已准备好
        flutterEngine?.dartExecutor?.binaryMessenger?.let { messenger ->
            MethodChannel(messenger, stirChannel).invokeMethod("onStirInitializationComplete", null)
        }
    }
}