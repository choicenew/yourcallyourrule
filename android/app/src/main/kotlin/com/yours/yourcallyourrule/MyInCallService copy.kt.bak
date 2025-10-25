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

    override fun onCallAdded(call: Call) {
        super.onCallAdded(call)

        val phoneNumber = call.details.handle?.schemeSpecificPart
      //  Log.d(TAG, "onCallAdded: phoneNumber = $phoneNumber") // 添加日志：电话号码        
       
        val simInfoJson = getSimInfoJsonForCall(this, phoneNumber, call)
        //Log.d(TAG, "onCallAdded: simInfoJson = $simInfoJson") // 添加日志：SIM 卡信息 JSON 字符串

        // 发送来电/去电号码和 SIM 卡信息给 Flutter
        flutterEngine?.dartExecutor?.binaryMessenger?.let { messenger ->
            MethodChannel(messenger, inCallChannel).invokeMethod(
                "onCallAdded",
                mapOf(
                    "phoneNumber" to phoneNumber,
                    "simInfo" to simInfoJson
                )
            )
        }
    }

    override fun onCallRemoved(call: Call) {
        super.onCallRemoved(call)

        val phoneNumber = call.details.handle?.schemeSpecificPart

        // 发送通话结束事件给 Flutter
        flutterEngine?.dartExecutor?.binaryMessenger?.let { messenger ->
            MethodChannel(messenger, inCallChannel).invokeMethod(
                "onCallRemoved",
                mapOf("phoneNumber" to phoneNumber)
            )
        }
    }

    // 根据电话号码和 Call 对象获取 SIM 卡信息并转换为 JSON 字符串
    @SuppressLint("MissingPermission")
    private fun getSimInfoJsonForCall(context: Context, phoneNumber: String?, call: Call): String? {
        if (phoneNumber == null) {
            Log.w(TAG, "getSimInfoJsonForCall: phoneNumber is null") // 添加日志：号码为空            
            return null
        }

        val telephonyManager = context.getSystemService(Context.TELEPHONY_SERVICE) as TelephonyManager?
        val subscriptionManager = context.getSystemService(SubscriptionManager::class.java)

        if (telephonyManager != null && subscriptionManager != null) {
          //   Log.e(TAG, "getSimInfoJsonForCall: telephonyManager or subscriptionManager is null") // 添加日志：服务为空
            // 尝试根据 SIM 卡槽索引获取 SIM 卡信息
            val simSlotIndex = getSimSlotIndexFromCall(call)
            if (simSlotIndex != -1) {
                val subscriptionInfo = subscriptionManager.getActiveSubscriptionInfoForSimSlotIndex(simSlotIndex)
        //    Log.d(TAG, "getSimInfoJsonForCall: subscriptionInfo (from slot) = $subscriptionInfo") // 添加日志：根据槽索引获取的 subscriptionInfo
                if (subscriptionInfo != null) {
                    return getSimInfoJson(context, subscriptionInfo, subscriptionManager) // 传递 subscriptionManager
                }
            }

            // 如果根据 SIM 卡槽索引没有找到，则根据号码查找
            val subscriptions = subscriptionManager.activeSubscriptionInfoList
      //  Log.d(TAG, "getSimInfoJsonForCall: subscriptions = $subscriptions") // 添加日志：所有 subscriptionInfo 列表
            if (subscriptions != null && subscriptions.isNotEmpty()) {
                for (subscriptionInfo in subscriptions) {
                    val simNumber = subscriptionManager.getPhoneNumber(subscriptionInfo.subscriptionId)
                    if (simNumber == phoneNumber) {
              //      Log.d(TAG, "getSimInfoJsonForCall: Found matching SIM card!") // 添加日志：找到匹配的 SIM 卡                        
                        return getSimInfoJson(context, subscriptionInfo, subscriptionManager) // 传递 subscriptionManager
                    }
                }
            }
        }

        return null
    }

    // 从 Call 对象中获取 SIM 卡槽索引
    private fun getSimSlotIndexFromCall(call: Call): Int {
        try {
            // 反射获取 getSimSlotIndex() 方法
            val getSimSlotIndexMethod = Call::class.java.getMethod("getSimSlotIndex")
            return getSimSlotIndexMethod.invoke(call) as Int
        } catch (e: Exception) {
         //   Log.w(TAG, "Error getting sim slot index from call: ${e.message}")
            return -1
        }
    }

    // 获取 SIM 卡信息并转换为 JSON 字符串
    @SuppressLint("MissingPermission")
    private fun getSimInfoJson(context: Context, subscriptionInfo: SubscriptionInfo, subscriptionManager: SubscriptionManager): String {
        val simInfo = JSONObject()
        try {
            simInfo.put("slotIndex", subscriptionInfo.simSlotIndex)
            simInfo.put("carrierName", subscriptionInfo.carrierName)
            simInfo.put("countryIso", subscriptionInfo.countryIso)
            simInfo.put("mcc", subscriptionInfo.mccString)
            simInfo.put("mnc", subscriptionInfo.mncString)

            // 获取 SIM 卡号码
            val simNumber = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
                // Android 11 及更高版本使用 SubscriptionManager.getPhoneNumber()
                subscriptionManager.getPhoneNumber(subscriptionInfo.subscriptionId)
            } else {
                // Android 11 以下版本使用 SubscriptionInfo.getNumber()
                subscriptionInfo.number
            }

            if (simNumber != null) {
                simInfo.put("simNumber", simNumber)
            } else {
          //      Log.w(TAG, "Unable to get SIM number.")
            }

        } catch (e: JSONException) {
          //  Log.e(TAG, "Error creating JSON object: ${e.message}")
        }
        return simInfo.toString()
    }
}