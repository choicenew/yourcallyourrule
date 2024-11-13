package com.yours.yourcallyourrule

import android.app.Activity
import android.app.AlertDialog
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.os.Bundle
import android.telecom.TelecomManager
import android.telephony.TelephonyManager
import android.util.Log
import android.widget.Toast
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.embedding.engine.dart.DartExecutor
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant;

class MainActivity : FlutterActivity() {

       super.configureFlutterEngine(flutterEngine)
        GeneratedPluginRegistrant.registerWith(flutterEngine)


    
    private lateinit var telephonyManager: TelephonyManager
    private lateinit var telecomManager: TelecomManager

    private lateinit var smsChannelHandler: SmsChannelHandler
    private lateinit var callerIdChannelHandler: CallerIdChannelHandler
  //  private lateinit var endCallChannelHandler: EndCallChannelHandler
    private val permissionsHelper = PermissionsHelper(this) // 创建 PermissionsHelper 实例

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
           // 获取缓存的引擎实例
        val cachedEngine = FlutterEngineCache.getInstance().get("my_engine_id")!!
                // 使用缓存的引擎实例来配置 Flutter
        cachedEngine.dartExecutor.executeDartEntrypoint(DartExecutor.DartEntrypoint.createDefault())



        // 初始化方法通道处理器
        smsChannelHandler = SmsChannelHandler(this, flutterEngine)
        smsChannelHandler.setupSmsChannel() //ChannelHandler 的 setup 方法

        callerIdChannelHandler = CallerIdChannelHandler(this, flutterEngine)
        callerIdChannelHandler.setupCallerIdChannel() //ChannelHandler 的 setup 方法

      //  endCallChannelHandler = EndCallChannelHandler(this, flutterEngine)
     //   endCallChannelHandler.setupEndCallChannel() //ChannelHandler 的 setup 方法
        // ... 其他 ChannelHandler 的 setup 方法 ...


        flutterEngine.plugins.add(CallScreeningPlugin())
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // 初始化系统服务
        telephonyManager = getSystemService(Context.TELEPHONY_SERVICE) as TelephonyManager
        telecomManager = getSystemService(Context.TELECOM_SERVICE) as TelecomManager

        // 请求权限
        requestAppPermissions()
    }

// 请求应用所需的所有权限
private fun requestAppPermissions() {
    val permissionsHelper = PermissionsHelper(this) 
    // 检查是否已获得所有权限
    if (permissionsHelper.hasAllPermissions()) {
        initializeAfterPermissions()
    } else {
        // 还没有获得所有权限，请求权限
        permissionsHelper.requestAppPermissions(this, permissionsHelper.requestPermissionsCode)
    }
}

    // 处理权限请求结果
    override fun onRequestPermissionsResult(
        requestCode: Int,
        permissions: Array<out String>,
        grantResults: IntArray
    ) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)

        if (requestCode == permissionsHelper.requestPermissionsCode) {
            if (grantResults.isNotEmpty() && grantResults.all { it == PackageManager.PERMISSION_GRANTED }) {
                // 所有权限已授予
                initializeAfterPermissions()
            } else {
                // 权限不足，跳转到引导页
                navigateToOnboarding()
            }
        }
    }

    // 初始化应用并继续执行
    private fun initializeAfterPermissions() {
        // ... 其他初始化逻辑 ...

        // 通知 Flutter 端初始化完成
        flutterEngine?.dartExecutor?.binaryMessenger?.let { messenger ->
            MethodChannel(messenger, smsChannelHandler.smsChannel).invokeMethod(
                "onSmsInitializationComplete", null
            )// 通知 Flutter 端 smsChannel 初始化完成
       //     Log.d("MainActivity", "onSmsInitializationComplete method invoked") // 打印方法调用信息 // 打印 smsChannel 初始化结果
            MethodChannel(messenger, callerIdChannelHandler.callerIdChannel).invokeMethod(
                "onCallerIdInitializationComplete", null
            ) // 通知 Flutter 端callerid 初始化已完成
           // Log.d("MainActivity", "onCallerIdInitializationComplete method invoked") // 打印方法调用信息 // 打印 callerid 初始化结果
            /*
              MethodChannel(messenger, endCallChannelHandler.endCallChannel).invokeMethod(
                "onEndCallInitializationComplete", null
            ) // 通知 Flutter 端endcaller 初始化已完成     
        */
        }

        // 初始化来电显示功能
        callerIdChannelHandler.initializeCallerId()

        // 初始化短信监听器
        if (permissionsHelper.hasSmsReceivePermission()) {
            smsChannelHandler.registerSmsListener()
        }
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)

        if (requestCode == smsChannelHandler.notificationPermissionRequestCode) {
            val granted = smsChannelHandler.isNotificationPolicyAccessGranted()
            flutterEngine?.dartExecutor?.binaryMessenger?.let { binaryMessenger ->
                MethodChannel(binaryMessenger, smsChannelHandler.smsChannel).invokeMethod(
                    "onNotificationPolicyAccessResult", mapOf("granted" to granted)
                )
            }
        } else if (requestCode == callerIdChannelHandler.requestSetDefaultCallScreeningAppCode) {
            if (resultCode == Activity.RESULT_OK) {
                // 用户成功将应用设置为默认来电显示应用
                Toast.makeText(this, "The Default Caller ID & Spam App", Toast.LENGTH_SHORT).show()

                // 保存设置状态
                val sharedPref = getPreferences(Context.MODE_PRIVATE)
                with(sharedPref.edit()) {
                    putBoolean("is_default_caller_id_set", true)
                    apply()
                }
            } else {
                // 用户取消了设置，询问是否跳过
                showSkipConfirmationDialog()
            }
        }
         // ... 处理其他 Activity 结果 ...
    }

    private fun showSkipConfirmationDialog() {
        AlertDialog.Builder(this)
            .setTitle("Skip Setup?")
            .setMessage("Are you sure you want to skip setting the default caller ID app? This may affect the use of some features.")
            .setPositiveButton("Skip") { _, _ ->
                val sharedPref = getPreferences(Context.MODE_PRIVATE)
                with(sharedPref.edit()) {
                    putBoolean("is_default_caller_id_set", true)
                    apply()
                }
            }
            .setNegativeButton("Go Back to Setup") { _, _ ->
                callerIdChannelHandler.setDefaultCallerIdApp()
            }
            .show()
    }

    // 跳转到引导页
    private fun navigateToOnboarding() {
        startActivity(createDefaultIntent(this))
    }

    override fun onDestroy() {
        super.onDestroy()
        smsChannelHandler.unregisterSmsListener()
        callerIdChannelHandler.unregisterCallListeners()
    }
}
