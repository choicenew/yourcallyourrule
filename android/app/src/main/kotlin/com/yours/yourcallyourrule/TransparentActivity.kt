package com.yours.yourcallyourrule

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import android.util.Log
import io.flutter.plugin.common.MethodChannel

class TransparentActivity : Activity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        Log.d("TransparentActivity", "Activity created. Attempting to show overlay.")

        // 获取 Flutter 引擎实例
        val app = application as MyApplication
        val flutterEngine = app.flutterEngine

        // 通过 MethodChannel 通知 Flutter 显示去电悬浮窗
        // 我们依然使用之前定义的 'callerIdChannel' 和一个新的方法 'showOutgoingCallOverlay'
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "com.yours.yourcallyourrule/caller_id")
            .invokeMethod("showOutgoingCallOverlay", null)

        // 【关键】: 执行完任务后，立刻销毁自己，避免用户看到
        finish()
    }
}