package com.yours.yourcallyourrule

import android.app.Activity
import android.content.Context
import android.content.Intent
import android.os.Build
import android.telecom.TelecomManager
import android.util.Log
import androidx.annotation.RequiresApi
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class EndCallChannelHandler(private val activity: Activity, private val flutterEngine: FlutterEngine) {

    val endCallChannel = "com.yours.yourcallyourrule/end_call"

/*
    init {
        setupEndCallChannel()
    }
*/

    //设置结束通话相关方法通道。
    fun setupEndCallChannel() {
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            endCallChannel
        ).setMethodCallHandler { call, result ->
            when (call.method) {
                "endCurrentCall" -> {
                    Log.d("FlutterCall", "收到来自 Flutter 的结束通话请求")
                    val intent = Intent(activity, MyCallScreeningService::class.java).apply {
                        action = "END_CALL"
                    }
                    activity.startService(intent)
                    result.success(null)
                }
                "answerThenHangup" -> {
                    Log.d("FlutterCall", "收到来自 Flutter 的接听后挂断请求")
                    val intent = Intent(activity, MyCallScreeningService::class.java).apply {
                        action = "ANSWER_THEN_HANGUP"
                    }
                    activity.startService(intent)
                    result.success(null)
                }
                "silenceNoAnswer" -> {
                    Log.d("FlutterCall", "收到来自 Flutter 的静默无应答请求")
                    val intent = Intent(activity, MyCallScreeningService::class.java).apply {
                        action = "SILENCE_NO_ANSWER"
                    }
                    activity.startService(intent)
                    result.success(null)
                }
                else -> {
                    Log.w("FlutterCall", "收到来自 Flutter 的未知方法调用: ${call.method}")
                    result.notImplemented()
                }
            }
        }
    }

    @RequiresApi(Build.VERSION_CODES.P)
    private fun endCurrentCall() {
        val telecomManager = activity.getSystemService(Context.TELECOM_SERVICE) as TelecomManager
        try {
            telecomManager.endCall()
            Log.d("MainActivity", "Call ended successfully")
        } catch (e: SecurityException) {
            Log.e("MainActivity", "Security exception when trying to end call", e)
        }
    }



}