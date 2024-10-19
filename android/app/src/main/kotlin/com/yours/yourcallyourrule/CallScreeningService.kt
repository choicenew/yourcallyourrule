package com.yours.yourcallyourrule

import android.annotation.SuppressLint
import android.content.Context
import android.os.Build
import android.os.Looper
import android.telecom.Call
import android.telecom.CallScreeningService
import android.util.Log
import androidx.annotation.RequiresApi
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.SupervisorJob
import kotlinx.coroutines.cancel
import kotlinx.coroutines.launch
import kotlinx.coroutines.suspendCancellableCoroutine
import kotlinx.coroutines.withTimeout
import kotlin.coroutines.resume


@RequiresApi(Build.VERSION_CODES.N)
class MyCallScreeningService : CallScreeningService() {
    private val endCallChannel = "com.yours.yourcallyourrule/end_call"
    private val shouldAcceptCallChannel = "com.yours.yourcallyourrule/should_accept_call" // 新的 Channel 用于 shouldAcceptCall
    private val callerIdChannel = "com.yours.yourcallyourrule/caller_id"

    private val flutterEngine: FlutterEngine?
        get() = (applicationContext as? MyApplication)?.flutterEngine

    private var currentCallDetails: Call.Details? = null

    private val serviceScope = CoroutineScope(SupervisorJob() + Dispatchers.IO)
    private val handler = android.os.Handler(Looper.getMainLooper()) // 添加 Handler 对象



    override fun onScreenCall(callDetails: Call.Details) {
        currentCallDetails = callDetails
        val incomingNumber = callDetails.handle?.schemeSpecificPart
       // Log.d("CallScreeningService", "Android端onScreenCall triggered. Incoming number: $incomingNumber")
   // val phoneNumber = callDetails.handle?.schemeSpecificPart
  //  Log.d("CallScreeningService", "Android端onScreenCall triggered. phone number来电去电: $phoneNumber")
    
//尝试添加stir 检查服务
    val stirChecker = StirChecker(this@MyCallScreeningService, callDetails)
    
    stirChecker.sendStirResultToFlutter() 

//stir检查服务到此
    // 初始化 SimChecker

    val simChecker = SimChecker(this@MyCallScreeningService, callDetails)

    simChecker.sendSimInfoToFlutter()
//SimChecker检查服务到此

        // Send the incoming call information to Flutter
        incomingNumber?.let { 
            flutterEngine?.dartExecutor?.binaryMessenger?.let { binaryMessenger ->
           //     Log.d("CallScreeningService", "Android端Attempting to send onIncomingCall to Flutter")
                MethodChannel(binaryMessenger, callerIdChannel).invokeMethod(
                    "onIncomingCall",
                    mapOf("phoneNumber" to it),
                    object : MethodChannel.Result {
                        override fun success(result: Any?) {
           //                 Log.d("CallScreeningService", "Android端Successfully sent onIncomingCall to Flutter")
                        }
                        override fun error(errorCode: String, errorMessage: String?, errorDetails: Any?) {
           //                 Log.e("CallScreeningService", "Android端Error sending onIncomingCall to Flutter: $errorMessage")
                        }
                        override fun notImplemented() {
             //               Log.e("CallScreeningService", "Android端onIncomingCall not implemented in Flutter")
                        }
                    }
                )
            } //?: Log.e("CallScreeningService", "FlutterEngine or BinaryMessenger is null")
        } //?: Log.e("CallScreeningService", "Incoming number is null")

        serviceScope.launch {
            val callAction = getCallAction(incomingNumber)
            respondToCall(callDetails, buildCallResponse(callAction))
        }
    }


    private suspend fun getCallAction(incomingNumber: String?): CallAction {
        return withTimeout(5000) {  // 添加超时机制
            incomingNumber?.let { number ->
            suspendCancellableCoroutine { continuation ->
              // 使用 handler.post() 将 MethodChannel 的调用发送到主线程
              handler.post {
                flutterEngine?.dartExecutor?.binaryMessenger?.let { binaryMessenger ->
                    MethodChannel(binaryMessenger, shouldAcceptCallChannel).invokeMethod(
                        "shouldAcceptCall",
                        number,
                            object : MethodChannel.Result {
                                override fun success(result: Any?) {
                                    when (result) {
                                        is Boolean -> {
                                            if (result) continuation.resume(CallAction.ACCEPT) 
                                            // 如果 shouldAccept 为 false,不要直接拒绝,而是获取 Flutter 端的拦截指令
                                        else {
                                            //Log.d("MyCallScreeningService", "shouldAcceptCallChannel 返回 false，准备获取拦截指令")
                                            getInterceptActionFromFlutter(number) { action ->
                                                continuation.resume(action) // 在回调中 resume
                                            }
                                        }
                                    //    Log.d("MyCallScreeningService", "shouldAcceptCallChannel 返回结果: $result") // 添加日志
                                    }
                                    is String -> {
                                        when (result.lowercase()) {
                                            "silence" -> continuation.resume(CallAction.SILENCE)
                                            "reject" -> continuation.resume(CallAction.REJECT)
                                            else -> continuation.resume(CallAction.ACCEPT)
                                        }
                                    }
                                    else -> continuation.resume(CallAction.ACCEPT)
                                }
                            }

                            override fun error(errorCode: String, errorMessage: String?, errorDetails: Any?) {
                              //  Log.e("CallScreeningService", "Error: $errorMessage")
                                continuation.resume(CallAction.ACCEPT)
                            }

                            override fun notImplemented() {
                                continuation.resume(CallAction.ACCEPT)
                                 }
                                }
                            )
                        } ?: continuation.resume(CallAction.ACCEPT)
                    }
                }
            } ?: CallAction.ACCEPT
        }
    }

    private fun getInterceptActionFromFlutter(number: String, callback: (CallAction) -> Unit) {
        flutterEngine?.dartExecutor?.binaryMessenger?.let { binaryMessenger ->
            MethodChannel(binaryMessenger, endCallChannel).invokeMethod(
                "interceptAction",
                number,
                object : MethodChannel.Result {
                    override fun success(result: Any?) {
                        if (result is String) {
                            when (result) {
                                "endCall" -> callback(CallAction.REJECT)
                                "answerThenHangup" -> callback(CallAction.ANSWER_THEN_HANGUP)
                                "silenceNoAnswer" -> callback(CallAction.SILENCE)
                                else -> callback(CallAction.ACCEPT)
                            }
                        } else {
                            callback(CallAction.ACCEPT)
                        }
                    }

                    override fun error(errorCode: String, errorMessage: String?, errorDetails: Any?) {
                        // 处理错误情况
                      //  Log.e("MyCallScreeningService", "获取拦截指令时出错：$errorMessage")
                        callback(CallAction.ACCEPT)
                    }

                    override fun notImplemented() {
                        // 处理方法未实现的情况
                      //  Log.w("MyCallScreeningService", "Flutter 端未实现 interceptAction 方法")
                        callback(CallAction.ACCEPT)
                    }
                }
            )
        } ?: callback(CallAction.ACCEPT)
    }



    @SuppressLint("MissingPermission")
    private fun buildCallResponse(callAction: CallAction): CallResponse {
        return CallResponse.Builder().apply {
            when (callAction) {
                 CallAction.REJECT -> {
                    setDisallowCall(true)
                    setRejectCall(true)
                    setSkipCallLog(false)
                    setSkipNotification(false)
                }
                CallAction.SILENCE -> {
                    setDisallowCall(false)
                    setRejectCall(false)
                    setSilenceCall(true)
                    setSkipCallLog(false)
                    setSkipNotification(false)
                }
                CallAction.ACCEPT -> {
                    // Do nothing, allow the call
                }
                CallAction.ANSWER_THEN_HANGUP -> {
                    setDisallowCall(false)
                    setRejectCall(false)
                    setSkipCallLog(false)
                    setSkipNotification(false)
                    
                    // 设置要接听和挂断的电话号码
                    val number = currentCallDetails?.handle?.schemeSpecificPart
                    if (number != null) {
                        setCallToAnswerAndHangup(number)
                    }
                }
        }
    }.build()
}

    private fun setCallToAnswerAndHangup(number: String) {
        val prefs = getSharedPreferences("call_pref", Context.MODE_PRIVATE)
        prefs.edit().apply {
            putString("number_to_answer", number)
            putString("number_to_hangup", number)
            putLong("timestamp", System.currentTimeMillis())
            apply()
        }

        // 设置一个延迟任务来清除这个标记
        handler.postDelayed({
            clearAnswerAndHangupFlags()
        }, 10000) // 30秒后清除标记
    }

    private fun clearAnswerAndHangupFlags() {
        val prefs = getSharedPreferences("call_pref", Context.MODE_PRIVATE)
        prefs.edit().apply {
            remove("number_to_answer")
            remove("number_to_hangup")
            remove("timestamp")
            apply()
        }
    }



    override fun onCreate() { 
        super.onCreate()
        // 在 Service 创建完成后，通知 Flutter 端 shouldAcceptCallChannel 已准备好
        flutterEngine?.dartExecutor?.binaryMessenger?.let { messenger ->
            MethodChannel(messenger, shouldAcceptCallChannel).invokeMethod("onShouldAcceptCallInitializationComplete", null)
            MethodChannel(messenger, endCallChannel).invokeMethod("onEndCallInitializationComplete", null) // 通知 Flutter 端初始化已完成
        }

//尝试添加Stir检查服务
    val stirChecker = StirChecker(this, null) // 初始化时不需要 CallDetails
    stirChecker.initialize()
    //stir 检查服务到此
    // 初始化 SimChecker
    val simChecker = SimChecker(this, null) // 这里传入 null 作为 callDetails 参数，因为 onCreate() 时还没有来电信息
    simChecker.initialize()
    //simchecker检查服务到此

    }

    private fun endCurrentCall() {
        currentCallDetails?.let { details ->
            val response = CallResponse.Builder()
                .setDisallowCall(true)
                .setRejectCall(true)
                .setSkipCallLog(false)  // You may want to log rejected calls
                .setSkipNotification(false)  // You may want to show a notification for rejected calls
                .build()
            respondToCall(details, response)
        }
    }


    private fun silenceNoAnswer() {
        currentCallDetails?.let { details ->
            val response = CallResponse.Builder()
                .setDisallowCall(false)
                .setRejectCall(false)
                .setSilenceCall(true)
                .setSkipCallLog(false)
                .setSkipNotification(false)
                .build()
            respondToCall(details, response)
        }
    }

    override fun onDestroy() {
        super.onDestroy()
        serviceScope.cancel() // 取消 serviceScope
    }


    private enum class CallAction {
    ACCEPT, REJECT, SILENCE, ANSWER_THEN_HANGUP
}
}
