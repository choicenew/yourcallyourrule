package com.yours.yourcallyourrule

import android.app.Activity
import android.app.role.RoleManager
import android.content.Context
import android.content.Intent
import android.os.Build
import android.telephony.PhoneStateListener
import android.telephony.TelephonyCallback
import android.telephony.TelephonyManager
import android.util.Log
import androidx.annotation.RequiresApi
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class CallerIdChannelHandler(private val activity: Activity, private val flutterEngine: FlutterEngine) {
  
        val callerIdChannel = "com.yours.yourcallyourrule/caller_id"
        val requestSetDefaultCallScreeningAppCode = 2002


   // private var phoneStateListener: PhoneStateListener? = null
   // private var customTelephonyCallback: CustomTelephonyCallback? = null
    private val permissionsHelper = PermissionsHelper(activity) // 创建 PermissionsHelper 实例

/*
    init {
        setupCallerIdChannel()
    }
*/
    // Caller ID Channel 设置来电显示相关方法通道，处理初始化、来电、通话结束等事件。
fun setupCallerIdChannel() {
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            callerIdChannel
        ).setMethodCallHandler { call, result ->
           // Log.d("安卓CallerIdChannel", "Received method call: ${call.method}")
            when (call.method) {
                "initialize" -> {
                    try {
                        initializeCallerId()
                        result.success("android端Caller ID initialized successfully!")
                     //   Log.d("Android端的CallerIdChannel", "Caller ID initialized successfully!")
                    } catch (e: Exception) {
                      //  Log.e("CallerIdChannel", "Error during initialization", e)
                        result.error("INITIALIZATION_ERROR", "Error during initialization: ${e.message}", null)
                    }
                }
                "onIncomingCall" -> {
                    val incomingNumber = call.argument<String>("phoneNumber")
                    if (incomingNumber != null) {
                       // Log.d("CallerIdChannel", "Incoming call: $incomingNumber")
                        handleIncomingCall(incomingNumber)
                        result.success(null)
                    } else {
                       // Log.e("CallerIdChannel", "Missing 'phoneNumber' argument")
                        result.error("INVALID_ARGUMENT", "Missing 'phoneNumber' argument", null)
                    }
                }
                "onOutgoingCall" -> {
                    val outgoingNumber = call.argument<String>("phoneNumber")
                    if (outgoingNumber != null) {
                       // Log.d("CallerIdChannel", "Outgoing call: $outgoingNumber")
                        handleOutgoingCall(outgoingNumber)
                        result.success(null)
                    } else {
                        //Log.e("CallerIdChannel", "Missing 'phoneNumber' argument")
                        result.error("INVALID_ARGUMENT", "Missing 'phoneNumber' argument", null)
                    }
                }
                 //被动接收通话结束的通知onCallEnded 和 handleCallEnded() 是一对，用于处理通话结束事件
                "onCallEnded" -> {
                  //  Log.d("CallerIdChannel", "Call ended")
                    handleCallEnded()
                    result.success(null)
                }
                //主动发起结束通话的请求endCall 和 endCurrentCall() 是一对，用于处理结束通话请求
                "endCall" -> {
                    if (permissionsHelper.hasCallPhonePermission()) {
                        Log.d("CallerIdChannel", "Ending call")
                        flutterEngine.dartExecutor.binaryMessenger.let { messenger ->
                            MethodChannel(messenger, callerIdChannel).invokeMethod("endCallFromNative", null)
                        }
                        result.success(null)
                    } else {
                        Log.e("CallerIdChannel", "Call phone permission not granted")
                        result.error("PERMISSION_NOT_GRANTED", "Call phone permission not granted", null)
                    }
                }
                else -> result.notImplemented()
            }
        }
    }

    fun initializeCallerId() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
             // Android Q 及以上版本，使用 CallScreeningService
            val roleManager = activity.getSystemService(RoleManager::class.java)
            if (roleManager?.isRoleHeld(RoleManager.ROLE_CALL_SCREENING) == true) {
                   // 应用已经是默认来电显示应用
             //   Log.d("MainActivity", "已经是默认来电显示应用")
                startCallScreeningService()
            } else {
                      // 应用还不是默认来电显示应用，引导用户设置
                setDefaultCallerIdApp()
            }
        } else {
            val telephonyManager = activity.getSystemService(Context.TELEPHONY_SERVICE) as TelephonyManager

            telephonyManager.listen(phoneStateListener, PhoneStateListener.LISTEN_CALL_STATE)
        }
    }





    // 引导用户将应用设置为默认来电显示应用
    fun setDefaultCallerIdApp() {
        val sharedPref = activity.getPreferences(Context.MODE_PRIVATE)
        val isDefaultCallerIdSet = sharedPref.getBoolean("is_default_caller_id_set", false)

        if (!isDefaultCallerIdSet) {
            val roleManager = activity.getSystemService(Context.ROLE_SERVICE) as RoleManager
            if (!roleManager.isRoleHeld(RoleManager.ROLE_CALL_SCREENING)) {
                val intent = roleManager.createRequestRoleIntent(RoleManager.ROLE_CALL_SCREENING)
                activity.startActivityForResult(intent, requestSetDefaultCallScreeningAppCode)
            }
        }
    }

    // 启动 CallScreeningService
    private fun startCallScreeningService() {
        val intent = Intent(activity, MyCallScreeningService::class.java)
        activity.startService(intent)
       // Log.e("android 端startCallScreeningService", " 注册")
    }

//当 Android 端检测到通话结束时，通过 callerIdChannel 向 Flutter 端发送名为 onCallEnded 的消息
    private fun handleIncomingCall(incomingNumber: String) {
        flutterEngine.dartExecutor.binaryMessenger.let { binaryMessenger ->
         //   Log.d("MainActivity", "onIncomingCall")
            MethodChannel(binaryMessenger, callerIdChannel).invokeMethod(
                "onIncomingCall", mapOf("phoneNumber" to incomingNumber)
            )
        }
    }

    private fun handleCallEnded() {
        flutterEngine.dartExecutor.binaryMessenger.let { binaryMessenger ->
            MethodChannel(binaryMessenger, callerIdChannel).invokeMethod("onCallEnded", null)
        }
    }

    private fun handleOutgoingCall(outgoingNumber: String) {
        flutterEngine.dartExecutor.binaryMessenger.let { binaryMessenger ->
            MethodChannel(binaryMessenger, callerIdChannel).invokeMethod(
                "onOutgoingCall", mapOf("phoneNumber" to outgoingNumber)
            )
        }
    }



    fun unregisterCallListeners() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            val telephonyManager = activity.getSystemService(Context.TELEPHONY_SERVICE) as TelephonyManager
            telephonyManager.unregisterTelephonyCallback(CustomTelephonyCallback())
        } else {
            phoneStateListener.let {
                val telephonyManager = activity.getSystemService(Context.TELEPHONY_SERVICE) as TelephonyManager
                telephonyManager.listen(phoneStateListener, PhoneStateListener.LISTEN_NONE)
            }
        }
    }


    @RequiresApi(Build.VERSION_CODES.S)
   private inner class CustomTelephonyCallback : TelephonyCallback(), TelephonyCallback.CallStateListener {
        override fun onCallStateChanged(state: Int) {
            when (state) {
                TelephonyManager.CALL_STATE_RINGING -> {
                     //  不需要 retrieveIncomingNumber()，因为它由 MyCallScreeningService 处理
                }
                TelephonyManager.CALL_STATE_OFFHOOK -> {
                     // Handle off-hook state (if needed)
                }
                TelephonyManager.CALL_STATE_IDLE -> {
                    handleCallEnded()
                }
            }
        }
    }

    // Android Q 以下版本使用的来电监听器
    private val phoneStateListener = object : PhoneStateListener() {
        @Deprecated("Deprecated in Java")
        override fun onCallStateChanged(state: Int, phoneNumber: String?) {
            super.onCallStateChanged(state, phoneNumber)
            when (state) {
                TelephonyManager.CALL_STATE_RINGING -> {
                    phoneNumber?.let { handleIncomingCall(it) }
                }

                TelephonyManager.CALL_STATE_IDLE -> {
                    handleCallEnded()
                }

                TelephonyManager.CALL_STATE_OFFHOOK -> {
                    // Handle off-hook state if needed
                }
            }
        }
    }


    //结束
}