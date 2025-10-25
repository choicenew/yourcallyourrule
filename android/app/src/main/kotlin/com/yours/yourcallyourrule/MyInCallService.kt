package com.yours.yourcallyourrule

import android.annotation.SuppressLint
import android.content.Context
import android.os.Build
import android.telecom.Call
import android.telecom.InCallService
import android.telephony.SubscriptionInfo
import android.telephony.SubscriptionManager
import android.telephony.TelephonyManager
import android.util.Log
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import org.json.JSONException
import org.json.JSONObject

class MyInCallService : InCallService() {

    private val inCallChannel = "com.yours.yourcallyourrule/in_call"
    companion object {
        private const val TAG = "MyInCallService"
    }

    private val flutterEngine: FlutterEngine?
        get() = (applicationContext as? MyApplication)?.flutterEngine

    // 🔥🔥🔥 核心功能：监听电话状态，必须保留！🔥🔥🔥
    // 这个 Callback 负责监听电话从响铃到接听，再到挂断的所有状态变化。
    private val callCallback = object : Call.Callback() {
        override fun onStateChanged(call: Call, state: Int) {
            super.onStateChanged(call, state)
            val phoneNumber = call.details.handle?.schemeSpecificPart
            var stateStr = "UNKNOWN"

            when (state) {
                Call.STATE_ACTIVE -> {
                    stateStr = "ACTIVE"
                    Log.d(TAG, "电话 [$phoneNumber] 状态变为 ACTIVE (已接听)")
                                       // --- 🔴 修改点 1: 获取接听时间戳 ---
                    val startTimeMillis = System.currentTimeMillis()
                    // 向 Flutter 发送接听事件，并附带开始时间
                     sendCallStateToFlutter("onCallAnswered", phoneNumber, startTimeMillis)
                }
                Call.STATE_RINGING -> stateStr = "RINGING"
                Call.STATE_DIALING -> stateStr = "DIALING"
                Call.STATE_CONNECTING -> stateStr = "CONNECTING"
                Call.STATE_DISCONNECTED -> stateStr = "DISCONNECTED"
                Call.STATE_HOLDING -> stateStr = "HOLDING"
            }
            Log.d(TAG, "电话 [$phoneNumber] 状态改变为: $stateStr")
        }

        // 同样是核心功能，处理通话异常结束的情况，也必须保留
        override fun onCallDestroyed(call: Call) {
            super.onCallDestroyed(call)
            val phoneNumber = call.details.handle?.schemeSpecificPart
            Log.d(TAG, "电话 [$phoneNumber] 已被销毁")
                 // --- 🔴 修改点 2: 获取异常结束时的时间戳 ---
            val endTimeMillis = System.currentTimeMillis()
            // 同样向 Flutter 发送挂断事件，并附带结束时间
             // 发送挂断事件和时间戳
            sendCallStateToFlutter("onCallRemoved", phoneNumber, endTimeMillis)
        }
    }

    override fun onCallAdded(call: Call) {
        super.onCallAdded(call)
        val phoneNumber = call.details.handle?.schemeSpecificPart
        Log.d(TAG, "onCallAdded: phoneNumber = $phoneNumber")

        // 🔥🔥🔥 核心功能：注册回调，开始监听，必须保留！🔥🔥🔥
        try {
            call.registerCallback(callCallback)
        } catch (e: Exception) {
            Log.e(TAG, "注册 Call.Callback 失败: ${e.message}")
        }

        // ------------------- SIM 卡信息获取的冗余逻辑 (已注释) -------------------
        // 根据我们最终确定的架构，获取 SIM 信息的职责由 MyCallScreeningService + SimChecker 承担。
        // MyInCallService 在电话被放行后才启动，此时 SIM 信息应该已经被 Flutter 获取到了。
        // 因此，这里的逻辑是重复且不必要的，予以注释。
        /*
        val simInfoJson = getSimInfoJsonForCall(this, phoneNumber, call)

        flutterEngine?.dartExecutor?.binaryMessenger?.let { messenger ->
            MethodChannel(messenger, inCallChannel).invokeMethod(
                "onCallAdded",
                mapOf(
                    "phoneNumber" to phoneNumber,
                    "simInfo" to simInfoJson
                )
            )
        }
        */
        // ------------------------- 冗余逻辑结束 -------------------------

       
        // 🔥🔥🔥 核心修改：判断是来电还是去电 🔥🔥🔥
        // Call.STATE_DIALING 表示正在拨号，这是一个明确的去电信号
        if (call.state == Call.STATE_DIALING) {
            Log.d(TAG, "检测到去电呼叫 (Dialing): $phoneNumber")
            val eventTimestamp = System.currentTimeMillis()
            // 发送一个专门的 onOutgoingCall 事件，附带时间戳
            sendCallStateToFlutter("onOutgoingCall", phoneNumber, eventTimestamp)
        } else {
            // 对于其他状态（如来电响铃），我们发送 onCallAdded
            sendCallStateToFlutter("onCallAdded", phoneNumber, null)
        }
    }

    override fun onCallRemoved(call: Call) {
        super.onCallRemoved(call)
        val phoneNumber = call.details.handle?.schemeSpecificPart
        Log.d(TAG, "onCallRemoved: phoneNumber = $phoneNumber")

        // 🔥🔥🔥 核心功能：注销回调，结束监听，必须保留！🔥🔥🔥
        try {
            call.unregisterCallback(callCallback)
        } catch (e: Exception) {
            Log.e(TAG, "注销 Call.Callback 失败: ${e.message}")
        }

                // --- 🔴 修改点 3: 获取正常挂断时的时间戳 ---
        val endTimeMillis = System.currentTimeMillis()
        // 发送挂断通知，并附带结束时间
        sendCallStateToFlutter("onCallRemoved", phoneNumber)
    }

    // 🔥🔥🔥 核心功能：与 Flutter 通信的辅助函数，必须保留！🔥🔥🔥
     // --- 🔴 修改点 4: 修改函数签名，增加一个可选的时间戳参数 ---
    private fun sendCallStateToFlutter(method: String, phoneNumber: String?, timestampMillis: Long? = null) {
        flutterEngine?.dartExecutor?.binaryMessenger?.let { messenger ->
            try {
                                 // 将所有信息打包到一个 map 中
                val arguments = mutableMapOf<String, Any?>()
                arguments["phoneNumber"] = phoneNumber
                // 只有当时间戳不为 null 时才添加到 map 中
                timestampMillis?.let {
                    arguments["timestamp"] = it
                }

                MethodChannel(messenger, inCallChannel).invokeMethod(method, arguments)
            } catch (e: Exception) {
                Log.e(TAG, "发送 Flutter 消息失败 ($method): ${e.message}")
            }
        }
    }

    /*
    // --- 以下是与 SIM 卡信息获取相关的完整冗余逻辑 ---
    // --- 根据最终架构，这整个代码块都不应该在 MyInCallService 中被调用，所以全部注释掉 ---

    // 获取 SIM 卡信息并转换为 JSON 字符串
    @SuppressLint("MissingPermission")
    private fun getSimInfoJsonForCall(context: Context, phoneNumber: String?, call: Call): String? {
        if (phoneNumber == null) {
            Log.w(TAG, "getSimInfoJsonForCall: phoneNumber is null")
            return null
        }

        val telephonyManager = context.getSystemService(Context.TELEPHONY_SERVICE) as TelephonyManager?
        val subscriptionManager = context.getSystemService(SubscriptionManager::class.java)

        if (telephonyManager == null || subscriptionManager == null) {
            Log.e(TAG, "getSimInfoJsonForCall: telephonyManager 或 subscriptionManager 为 null")
            return null
        }

        // 尝试通过 SIM 卡槽索引获取信息
        val simSlotIndex = getSimSlotIndexFromCall(call)
        if (simSlotIndex != -1) {
            try {
                val subscriptionInfo = subscriptionManager.getActiveSubscriptionInfoForSimSlotIndex(simSlotIndex)
                if (subscriptionInfo != null) {
                    return getSimInfoJson(context, subscriptionInfo, subscriptionManager)
                }
            } catch (e: SecurityException) {
                Log.w(TAG, "getSimInfoJsonForCall: 无法获取 SIM 卡信息 (SIM 卡槽索引): ${e.message}")
            } catch (e: NullPointerException) {
                Log.w(TAG, "getSimInfoJsonForCall: NullPointerException 获取 SIM 卡信息 (SIM 卡槽索引): ${e.message}")
            }
        }

        // 如果通过 SIM 卡槽索引未找到，尝试通过号码查找
        try {
            val subscriptions = subscriptionManager.activeSubscriptionInfoList
            if (subscriptions != null && subscriptions.isNotEmpty()) {
                for (subscriptionInfo in subscriptions) {
                    try {
                        val simNumber = subscriptionManager.getPhoneNumber(subscriptionInfo.subscriptionId)
                        if (simNumber == phoneNumber) {
                            return getSimInfoJson(context, subscriptionInfo, subscriptionManager)
                        }
                    } catch (e: SecurityException) {
                        Log.w(TAG, "getSimInfoJsonForCall: 无法获取 SIM 卡信息 (根据号码查找): ${e.message}")
                    } catch (e: NullPointerException) {
                        Log.w(TAG, "getSimInfoJsonForCall: NullPointerException 获取 SIM 卡信息 (根据号码查找): ${e.message}")
                    }
                }
            }
        } catch (e: SecurityException) {
            Log.w(TAG, "getSimInfoJsonForCall: 无法获取 SIM 卡信息 (获取 subscriptionInfoList): ${e.message}")
        }
        return null
    }

    // 从 Call 对象中获取 SIM 卡槽索引，使用反射处理兼容性问题
    private fun getSimSlotIndexFromCall(call: Call): Int {
        return try {
            val getSimSlotIndexMethod = Call::class.java.getMethod("getSimSlotIndex")
            getSimSlotIndexMethod.invoke(call) as Int
        } catch (e: Exception) {
            Log.w(TAG, "获取 simSlotIndex 失败: ${e.message}")
            -1 // 如果获取失败，返回 -1
        }
    }

    // 获取 SIM 卡信息的 JSON 字符串
    @SuppressLint("MissingPermission")
    private fun getSimInfoJson(context: Context, subscriptionInfo: SubscriptionInfo, subscriptionManager: SubscriptionManager): String {
        val simInfo = JSONObject()
        try {
            simInfo.put("slotIndex", subscriptionInfo.simSlotIndex)
            simInfo.put("carrierName", subscriptionInfo.carrierName)
            simInfo.put("countryIso", subscriptionInfo.countryIso)
            simInfo.put("mcc", subscriptionInfo.mccString)
            simInfo.put("mnc", subscriptionInfo.mncString)

            // 获取 SIM 卡号码，兼容 Android R 及以上版本
            val simNumber = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
                try {
                    subscriptionManager.getPhoneNumber(subscriptionInfo.subscriptionId)
                } catch (e: SecurityException) {
                    Log.w(TAG, "获取 SIM 卡号码失败 (R 及以上): ${e.message}")
                    null
                }
            } else {
                subscriptionInfo.number
            }

            if (simNumber != null) {
                simInfo.put("simNumber", simNumber)
            } else {
                Log.w(TAG, "无法获取 SIM 卡号码.")
            }
        } catch (e: JSONException) {
            Log.e(TAG, "创建 JSON 对象时出错: ${e.message}")
        }
        return simInfo.toString()
    }
    */
}