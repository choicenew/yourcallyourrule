package com.yours.yourcallyourrule // 替换成你的包名

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.provider.Telephony
import android.util.Log
import io.flutter.plugin.common.MethodChannel

class SmsReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context, intent: Intent) {
       // Log.d("SmsReceiver", "onReceive called")
        if (Telephony.Sms.Intents.SMS_RECEIVED_ACTION == intent.action) {
            for (sms in Telephony.Sms.Intents.getMessagesFromIntent(intent)) {
                val sender = sms.originatingAddress
                val messageBody = sms.messageBody
              //  Log.d("安卓端SmsReceiver", "Received SMS from $sender: $messageBody")
             //   Log.d("MainActivity", "安卓端sms注册服务")

                // 获取 FlutterEngine 实例 
                val flutterEngine = (context.applicationContext as? MyApplication)?.flutterEngine 
//Log.d("SmsReceiver", "flutterEngine: $flutterEngine") // 打印 flutterEngine

                flutterEngine?.dartExecutor?.binaryMessenger?.let { binaryMessenger ->
                    MethodChannel(binaryMessenger, "com.yours.yourcallyourrule/sms_filter").invokeMethod( 
                        "onReceivedSms",
                        mapOf(
                            "phoneNumber" to sender,
                            "messageContent" to messageBody
                        )
                    )
                }
            }
        }
    }
}