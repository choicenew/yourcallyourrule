package com.yours.yourcallyourrule

import android.annotation.SuppressLint
import android.content.Context
import android.os.Build
import android.telecom.Call
import android.telephony.*
import android.util.Log
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.os.Handler
import android.os.Looper
import androidx.annotation.RequiresApi

class SimChecker(private val context: Context, private val callDetails: Call.Details?) {
    private val simChannel = "com.yours.yourcallyourrule/sim_check"
    private val flutterEngine: FlutterEngine?
        get() = (context.applicationContext as? MyApplication)?.flutterEngine
    private val handler = Handler(Looper.getMainLooper())

    private var phoneStateListeners: MutableMap<Int, PhoneStateListener> = mutableMapOf()
    private var telephonyCallbacks: MutableMap<Int, TelephonyCallback> = mutableMapOf()
    private val subscriptionManager = context.getSystemService(Context.TELEPHONY_SUBSCRIPTION_SERVICE) as SubscriptionManager

    @SuppressLint("MissingPermission", "HardwareIds")
    fun sendSimInfoToFlutter() {
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.LOLLIPOP_MR1 || callDetails == null) {
          //  Log.w("SimChecker", "Android version is below 22 or callDetails is null, skipping SIM check.")
            return
        }

        val telephonyManager = context.getSystemService(Context.TELEPHONY_SERVICE) as TelephonyManager
        val incomingNumber = callDetails.handle?.schemeSpecificPart

        val activeSubscriptionInfoList = subscriptionManager.activeSubscriptionInfoList

        // 遍历 SIM 卡信息列表，并注册监听器
        if (activeSubscriptionInfoList != null) {
            for (subscriptionInfo in activeSubscriptionInfoList) {
                val subscriptionId = subscriptionInfo.subscriptionId
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
                    registerTelephonyCallbackForSubscription(subscriptionId, telephonyManager, incomingNumber)
                } else {
                    registerPhoneStateListenerForSubscription(subscriptionId, telephonyManager)
                }
            }
        }
    }

    @RequiresApi(Build.VERSION_CODES.M)
    private fun registerPhoneStateListenerForSubscription(subscriptionId: Int, telephonyManager: TelephonyManager) {
        val phoneStateListener = object : PhoneStateListener() {
            @SuppressLint("MissingPermission")
            override fun onCallStateChanged(state: Int, incomingNumber: String) {
                if (state == TelephonyManager.CALL_STATE_RINGING || state == TelephonyManager.CALL_STATE_OFFHOOK) {
                    val callType = if (state == TelephonyManager.CALL_STATE_RINGING) "incoming" else "outgoing" // 判断通话类型                   
                   
                    // 获取 SIM 卡信息
                    val subscriptionInfo = subscriptionManager.getActiveSubscriptionInfo(subscriptionId)
                    val simInfo = subscriptionInfo?.let {
                        val simPhoneNumber = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
                            subscriptionManager.getPhoneNumber(it.subscriptionId)
                        } else {
                            it.number
                        }
                        mapOf(
                            "carrierName" to it.carrierName,
                            "displayName" to it.displayName,
                            "iccId" to it.iccId,
                            "countryIso" to it.countryIso,
                            "incomingPhoneNumber" to incomingNumber,
                            "simSlotIndex" to it.simSlotIndex,
                            "subscriptionId" to it.subscriptionId,
                            "mccString" to it.mccString,
                            "mncString" to it.mncString,
                            "simPhoneNumber" to simPhoneNumber,
                            "callType" to callType // 添加 callType 字段                            
                        )
                    } ?: mapOf<String, Any?>()

                    // 发送 SIM 卡信息到 Flutter
                    sendSimInfoToFlutter(simInfo)
                }
            }
        }
        phoneStateListeners[subscriptionId] = phoneStateListener

        // 创建与特定 SIM 卡关联的 TelephonyManager 实例
        val simTelephonyManager = telephonyManager.createForSubscriptionId(subscriptionId)

        // 注册 PhoneStateListener
        simTelephonyManager.listen(phoneStateListener, PhoneStateListener.LISTEN_CALL_STATE)
    }

    @RequiresApi(Build.VERSION_CODES.S)
    private fun registerTelephonyCallbackForSubscription(subscriptionId: Int, telephonyManager: TelephonyManager, incomingNumber: String?) {
        val telephonyCallback = object : TelephonyCallback(), TelephonyCallback.CallStateListener {
            @SuppressLint("MissingPermission")
            override fun onCallStateChanged(state: Int) {
                if ((state == TelephonyManager.CALL_STATE_RINGING || state == TelephonyManager.CALL_STATE_OFFHOOK) && incomingNumber != null) {
                    val callType = if (state == TelephonyManager.CALL_STATE_RINGING) "incoming" else "outgoing" // 判断通话类型

                    // 获取 SIM 卡信息
                    val subscriptionInfo = subscriptionManager.getActiveSubscriptionInfo(subscriptionId)
                    val simInfo = subscriptionInfo?.let {
                        val simPhoneNumber = subscriptionManager.getPhoneNumber(it.subscriptionId)
                        mapOf(
                            "carrierName" to it.carrierName,
                            "displayName" to it.displayName,
                            "iccId" to it.iccId,
                            "countryIso" to it.countryIso,
                            "incomingPhoneNumber" to incomingNumber,
                            "simSlotIndex" to it.simSlotIndex,
                            "subscriptionId" to it.subscriptionId,
                            "mccString" to it.mccString,
                            "mncString" to it.mncString,
                            "simPhoneNumber" to simPhoneNumber,
                            "callType" to callType // 添加 callType 字段                            
                        )
                    } ?: mapOf<String, Any?>()

                    // 发送 SIM 卡信息到 Flutter
                    sendSimInfoToFlutter(simInfo)
                }
            }
        }
        telephonyCallbacks[subscriptionId] = telephonyCallback

        // 注册 TelephonyCallback
        telephonyManager.createForSubscriptionId(subscriptionId).registerTelephonyCallback(
            context.mainExecutor,
            telephonyCallback
        )
    }

    private fun sendSimInfoToFlutter(simInfo: Map<String, Any?>) {
        handler.post {
            flutterEngine?.dartExecutor?.binaryMessenger?.let { binaryMessenger ->
                MethodChannel(binaryMessenger, simChannel).invokeMethod(
                    "onSimInfo",
                    simInfo,
                    object : MethodChannel.Result {
                        override fun success(result: Any?) {
                         //   Log.d("SimChecker", "Successfully sent SIM info to Flutter: $simInfo")
                        }

                        override fun error(errorCode: String, errorMessage: String?, errorDetails: Any?) {
                          //  Log.e("SimChecker", "Error sending SIM info to Flutter: $errorMessage")
                        }

                        override fun notImplemented() {
                           // Log.e("SimChecker", "onSimInfo not implemented in Flutter")
                        }
                    }
                )
            } //?: Log.e("SimChecker", "FlutterEngine or BinaryMessenger is null")
        }
    }

    fun unregisterListeners(telephonyManager: TelephonyManager) {
        for ((subscriptionId, listener) in phoneStateListeners) {
            val simTelephonyManager = telephonyManager.createForSubscriptionId(subscriptionId)
            simTelephonyManager.listen(listener, PhoneStateListener.LISTEN_NONE)
        }
        phoneStateListeners.clear()

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            for ((subscriptionId, callback) in telephonyCallbacks) {
                telephonyManager.createForSubscriptionId(subscriptionId).unregisterTelephonyCallback(callback)
            }
            telephonyCallbacks.clear()
        }
    }

    fun initialize() {
        // 在 Service 创建完成后，通知 Flutter 端 simChannel 已准备好
        flutterEngine?.dartExecutor?.binaryMessenger?.let { messenger ->
            MethodChannel(messenger, simChannel).invokeMethod("onSimInitializationComplete", null)
        }
    }
}