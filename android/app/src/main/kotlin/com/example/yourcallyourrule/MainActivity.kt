package com.yours.yourcallyourrule

import android.Manifest
import android.app.Activity
import android.app.AlertDialog
import android.app.NotificationManager
import android.app.role.RoleManager
import android.content.BroadcastReceiver
import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.content.ServiceConnection
import android.content.pm.PackageManager
import android.os.Build
import android.os.Bundle
import android.os.IBinder
import android.provider.Settings
import android.provider.Telephony
import android.service.notification.StatusBarNotification
import android.telecom.TelecomManager
import android.telephony.PhoneStateListener
import android.telephony.SmsManager
import android.telephony.SubscriptionManager
import android.telephony.TelephonyCallback
import android.telephony.TelephonyManager
import android.util.Log
import android.widget.Toast
import androidx.annotation.RequiresApi
import androidx.appcompat.app.AppCompatActivity
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugins.GeneratedPluginRegistrant
//import io.flutter.plugins.googlemobileads.GoogleMobileAdsPlugin;
//import io.flutter.plugins.googlemobileads.GoogleMobileAdsPlugin.NativeAdFactory;
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.Job


class MainActivity : FlutterActivity() {
    private val smsChannel = "com.yours.yourcallyourrule/sms_filter"
    private val callerIdChannel = "com.yours.yourcallyourrule/caller_id"
    private val endCallChannel = "com.yours.yourcallyourrule/end_call"


    private val smsReceivePermissionRequestCode = 123
    private val notificationPermissionRequestCode = 456
    private val requestPermissionsCode = 1001 // 合并权限请求代码
    private val requestSetDefaultCallScreeningAppCode = 2002

    private var smsReceiver: BroadcastReceiver? = null

    private lateinit var notificationManager: NotificationManager
    private lateinit var telephonyManager: TelephonyManager
    private lateinit var telecomManager: TelecomManager

    // 需要请求的权限数组
    private val requiredPermissions = arrayOf(
        Manifest.permission.ANSWER_PHONE_CALLS,
        Manifest.permission.READ_PHONE_STATE,
        Manifest.permission.RECEIVE_SMS,
        Manifest.permission.READ_CONTACTS, // 添加联系人权限
        Manifest.permission.READ_CALL_LOG,  // 通话记录权限
    )

    @RequiresApi(Build.VERSION_CODES.Q)
    private inner class CustomTelephonyCallback : TelephonyCallback(),
        TelephonyCallback.CallStateListener {
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


    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        GeneratedPluginRegistrant.registerWith(flutterEngine)

        setupSmsChannel(flutterEngine)
        setupCallerIdChannel(flutterEngine)
        //setupEndCallChannel(flutterEngine)
        // ... 其他 Channel ... 
        flutterEngine.plugins.add(CallScreeningPlugin())


    }


    private fun setupSmsChannel(flutterEngine: FlutterEngine) {
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            smsChannel
        ).setMethodCallHandler { call, result ->
            when (call.method) {
                "registerSmsListener" -> {
                    if (hasSmsReceivePermission()) {
                        registerSmsListener()
                        result.success(null)

                    } else {
                        requestSmsReceivePermission()
                        result.error(
                            "PERMISSION_NOT_GRANTED",
                            "SMS receive permission not granted",
                            null
                        )
                    }
                }

                "getDefaultSmsPackage" -> {
                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.KITKAT) {
                        val packageName = getDefaultSmsPackage() // 首先获取包名
                        result.success(packageName) // 将包名作为参数传递给 result.success()
                        Log.d("setupSmsChannel", "setupSmsChannel: ${call.method}, packageName: $packageName")
                    } else {
                        result.error(
                            "UNSUPPORTED_VERSION",
                            "This feature is not supported on this Android version.",
                            null
                        )
                    }
                }



                "unregisterSmsListener" -> {
                    unregisterSmsListener()
                    result.success(null)
                }

                "setSmsNotificationState" -> {
                    val phoneNumber = call.argument<String>("phoneNumber")
                    val messageContent = call.argument<String>("messageContent")
                    val shouldNotify = call.argument<Boolean>("shouldNotify")
                    if (phoneNumber != null && shouldNotify != null) {
                        setSmsNotificationState(phoneNumber, messageContent, shouldNotify, result)
                        result.success(null)
                    } else {
                        result.error(
                            "INVALID_ARGUMENTS",
                            "Invalid arguments for setSmsNotificationState",
                            null
                        )
                    }
                }

                "setSmsNotificationChannelImportance" -> {
                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                        val packageName = call.argument<String>("packageName")
                        val importance = call.argument<Int>("importance")
                        if (packageName != null && importance != null) {
                            setSmsNotificationChannelImportance(packageName, importance)
                            result.success(null)
                        } else {
                            result.error(
                                "INVALID_ARGUMENTS",
                                "Invalid arguments for setSmsNotificationChannelImportance.",
                                null
                            )
                        }
                    } else {
                        result.error(
                            "UNSUPPORTED_VERSION",
                            "This feature is not supported on this Android version.",
                            null
                        )
                    }
                }

                else -> result.notImplemented()
            }
        }
    }

    // Caller ID Channel 设置来电显示相关方法通道，处理初始化、来电、通话结束等事件。
    private fun setupCallerIdChannel(flutterEngine: FlutterEngine) {
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            callerIdChannel
        ).setMethodCallHandler { call, result ->
            Log.d("CallerIdChannel", "Received method call: ${call.method}") // 添加日志
            when (call.method) {
                "initialize" -> {
                    try {
                        initializeCallerId()
                        result.success("Caller ID initialized successfully!")
                        Log.d("Android端的CallerIdChannel", "Caller ID initialized successfully!") // 添加日志
                    } catch (e: Exception) {
                        Log.e("CallerIdChannel", "Error during initialization", e) // 添加错误日志
                        result.error(
                            "INITIALIZATION_ERROR",
                            "Error during initialization: ${e.message}",
                            null
                        )
                    }
                }

                "onIncomingCall" -> {
                    val incomingNumber = call.argument<String>("phoneNumber")
                    if (incomingNumber != null) {
                        Log.d("CallerIdChannel", "Incoming call: $incomingNumber") // 添加日志
                        handleIncomingCall(incomingNumber)
                        result.success(null)
                    } else {
                        Log.e("CallerIdChannel", "Missing 'phoneNumber' argument") // 添加错误日志
                        result.error("INVALID_ARGUMENT", "Missing 'phoneNumber' argument", null)
                    }
                }

                "onOutgoingCall" -> {
                    val outgoingNumber = call.argument<String>("phoneNumber")
                    if (outgoingNumber != null) {
                        Log.d("CallerIdChannel", "Outgoing call: $outgoingNumber") // 添加日志
                        handleOutgoingCall(outgoingNumber)
                        result.success(null)
                    } else {
                        Log.e("CallerIdChannel", "Missing 'phoneNumber' argument") // 添加错误日志
                        result.error("INVALID_ARGUMENT", "Missing 'phoneNumber' argument", null)
                    }
                }

               //被动接收通话结束的通知onCallEnded 和 handleCallEnded() 是一对，用于处理通话结束事件
                "onCallEnded" -> {
                    Log.d("CallerIdChannel", "Call ended") // 添加日志
                    handleCallEnded()
                    result.success(null)
                }

                //主动发起结束通话的请求endCall 和 endCurrentCall() 是一对，用于处理结束通话请求
                "endCall" -> {
                    if (hasCallPhonePermission()) {
                        Log.d("CallerIdChannel", "Ending call") // 添加日志
                        flutterEngine.dartExecutor.binaryMessenger.let { messenger ->
                            MethodChannel(
                                messenger,
                                callerIdChannel
                            ).invokeMethod("endCallFromNative", null)
                        }
                        result.success(null)
                    } else {
                        Log.e("CallerIdChannel", "Call phone permission not granted") // 添加错误日志
                        result.error(
                            "PERMISSION_NOT_GRANTED",
                            "Call phone permission not granted",
                            null
                        )
                    }
                }

                else -> result.notImplemented()
            }
        }
    }
/* 
    //设置结束通话相关方法通道。
private fun setupEndCallChannel(flutterEngine: FlutterEngine) {
    MethodChannel(
        flutterEngine.dartExecutor.binaryMessenger,
        endCallChannel
    ).setMethodCallHandler { call, result ->
        when (call.method) {
            "endCurrentCall" -> {
                Log.d("FlutterCall", "收到来自 Flutter 的结束通话请求")
                val intent = Intent(this, MyCallScreeningService::class.java).apply {
                    action = "END_CALL"
                }
                startService(intent)
                result.success(null)
            }
            "answerThenHangup" -> {
                Log.d("FlutterCall", "收到来自 Flutter 的接听后挂断请求")
                val intent = Intent(this, MyCallScreeningService::class.java).apply {
                    action = "ANSWER_THEN_HANGUP"
                }
                startService(intent)
                result.success(null)
            }
            "silenceNoAnswer" -> {
                Log.d("FlutterCall", "收到来自 Flutter 的静默无应答请求")
                val intent = Intent(this, MyCallScreeningService::class.java).apply {
                    action = "SILENCE_NO_ANSWER"
                }
                startService(intent)
                result.success(null)
            }
            else -> {
                Log.w("FlutterCall", "收到来自 Flutter 的未知方法调用: ${call.method}")
                result.notImplemented()
            }
        }
    }
}
*/
    @RequiresApi(Build.VERSION_CODES.P)
    private fun endCurrentCall() {
        val telecomManager = getSystemService(TELECOM_SERVICE) as TelecomManager
        try {
            telecomManager.endCall()
            Log.d("MainActivity", "Call ended successfully")
        } catch (e: SecurityException) {
            Log.e("MainActivity", "Security exception when trying to end call", e)
        }
    }

    private fun handleIncomingCall(incomingNumber: String) {
        flutterEngine?.dartExecutor?.binaryMessenger?.let { binaryMessenger ->
          Log.d("MainActivity", "onIncomingCall",)
            MethodChannel(binaryMessenger, callerIdChannel).invokeMethod(
                "onIncomingCall",
                mapOf("phoneNumber" to incomingNumber)
            )
        }
    }

//当 Android 端检测到通话结束时，通过 callerIdChannel 向 Flutter 端发送名为 onCallEnded 的消息
    private fun handleCallEnded() {
        flutterEngine?.dartExecutor?.binaryMessenger?.let { binaryMessenger ->
            MethodChannel(binaryMessenger, callerIdChannel).invokeMethod(
                "onCallEnded",
                null
            )
        }
    }


    private fun handleOutgoingCall(outgoingNumber: String) {
        flutterEngine?.dartExecutor?.binaryMessenger?.let { binaryMessenger ->
            MethodChannel(binaryMessenger, callerIdChannel).invokeMethod(
                "onOutgoingCall",
                mapOf("phoneNumber" to outgoingNumber)
            )
        }
    }

    // 启动 CallScreeningService
    private fun startCallScreeningService() {
        val intent = Intent(this, MyCallScreeningService::class.java)
        startService(intent)
    }

    //初始化
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // 初始化系统服务
        notificationManager = getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
        telephonyManager = getSystemService(Context.TELEPHONY_SERVICE) as TelephonyManager
        telecomManager = getSystemService(Context.TELECOM_SERVICE) as TelecomManager

        // 请求权限
        requestAppPermissions()
    }

    // 请求应用所需的所有权限
    private fun requestAppPermissions() {
        // 检查是否已获得所有权限
        if (hasAllPermissions()) {
            initializeAfterPermissions()
        } else {
            // 还没有获得所有权限，请求权限
            ActivityCompat.requestPermissions(this, requiredPermissions, requestPermissionsCode)
        }
    }

    // 检查是否已获得所有需要的权限
    private fun hasAllPermissions(): Boolean {
        return requiredPermissions.all {
            ContextCompat.checkSelfPermission(this, it) == PackageManager.PERMISSION_GRANTED
        }
    }

    // 处理权限请求结果
    override fun onRequestPermissionsResult(
        requestCode: Int,
        permissions: Array<out String>,
        grantResults: IntArray
    ) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)

        if (requestCode == requestPermissionsCode) {
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

registerSmsListener()
        // 初始化其他功能
        if (hasSmsReceivePermission()) {
            registerSmsListener()
        }
        // ... 其他初始化逻辑 ...
        flutterEngine?.dartExecutor?.binaryMessenger?.let { messenger ->
            MethodChannel(messenger, smsChannel).invokeMethod(
                "onSmsInitializationComplete",
                null
            ) // 通知 Flutter 端 smsChannel 初始化完成
            MethodChannel(
                messenger,
                callerIdChannel
            ).invokeMethod("onCallerIdInitializationComplete", null) // 通知 Flutter 端初始化已完成
            /* 
            MethodChannel(messenger, endCallChannel).invokeMethod(
                "onEndCallInitializationComplete",
                null
            ) // 通知 Flutter 端初始化已完成
            */
        }
        initializeCallerId()
    }

    // 初始化来电显示功能
    private fun initializeCallerId() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            // Android Q 及以上版本，使用 CallScreeningService
            val roleManager = getSystemService(RoleManager::class.java)
            if (roleManager?.isRoleHeld(RoleManager.ROLE_CALL_SCREENING) == true) {
                // 应用已经是默认来电显示应用
                Log.d("MainActivity", "已经是默认来电显示应用")
                startCallScreeningService()
            } else {
                // 应用还不是默认来电显示应用，引导用户设置
                setDefaultCallerIdApp()
            }
        } else {
            // Android Q 以下版本，使用 PhoneStateListener
            val telephonyManager =
                context.getSystemService(Context.TELEPHONY_SERVICE) as TelephonyManager
            telephonyManager.listen(phoneStateListener, PhoneStateListener.LISTEN_CALL_STATE)
        }
    }

    // 引导用户将应用设置为默认来电显示应用
    private fun setDefaultCallerIdApp() {
        val sharedPref = getPreferences(Context.MODE_PRIVATE)
        val isDefaultCallerIdSet = sharedPref.getBoolean("is_default_caller_id_set", false)

        if (!isDefaultCallerIdSet) {
            val roleManager = getSystemService(Context.ROLE_SERVICE) as RoleManager
            if (!roleManager.isRoleHeld(RoleManager.ROLE_CALL_SCREENING)) {
                val intent = roleManager.createRequestRoleIntent(RoleManager.ROLE_CALL_SCREENING)
                startActivityForResult(intent, requestSetDefaultCallScreeningAppCode)
            }
        }
    }

    private fun bindCallScreeningService(activity: AppCompatActivity) {
        val myCallServiceIntent = Intent(activity, MyCallScreeningService::class.java)
        val myServiceConnection: ServiceConnection = object : ServiceConnection {
            override fun onServiceConnected(componentName: ComponentName, iBinder: IBinder) {
                // 在服务连接成功时执行操作
                Log.e("MainActivity", "MyCallScreeningService 服务连接成功")
            }

            override fun onServiceDisconnected(componentName: ComponentName) {
                // 在服务断开连接时执行操作
                Log.e("MainActivity", "MyCallScreeningService 服务断开连接")
            }

            override fun onBindingDied(name: ComponentName) {
                // 在绑定失败时执行操作
                Log.e("MainActivity", "MyCallScreeningService 绑定失败")
            }
        }

        activity.bindService(
            myCallServiceIntent,
            myServiceConnection,
            AppCompatActivity.BIND_AUTO_CREATE
        )
    }


    private fun unbindCallScreeningService(
        activity: AppCompatActivity,
        myServiceConnection: ServiceConnection
    ) {
        activity.unbindService(myServiceConnection)
    }


    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if (requestCode == notificationPermissionRequestCode) {
            val granted = notificationManager.isNotificationPolicyAccessGranted
            flutterEngine?.dartExecutor?.binaryMessenger?.let { binaryMessenger ->
                MethodChannel(binaryMessenger, smsChannel).invokeMethod(
                    "onNotificationPolicyAccessResult",
                    mapOf("granted" to granted)
                )
            }
        } else if (requestCode == requestSetDefaultCallScreeningAppCode) {
            if (resultCode == Activity.RESULT_OK) {
                // 用户成功将应用设置为默认来电显示应用
                Toast.makeText(this, "已成功设置为默认来电显示应用", Toast.LENGTH_SHORT).show()

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
            .setTitle("跳过设置？")
            .setMessage("您确定要跳过设置默认来电显示应用吗？这可能会影响部分功能的使用。")
            .setPositiveButton("确定跳过") { _, _ ->
                val sharedPref = getPreferences(Context.MODE_PRIVATE)
                with(sharedPref.edit()) {
                    putBoolean("is_default_caller_id_set", true)
                    apply()
                }
            }
            .setNegativeButton("返回设置") { _, _ ->
                setDefaultCallerIdApp()
            }
            .show()
    }


    // 跳转到引导页
    private fun navigateToOnboarding() {
        startActivity(FlutterActivity.createDefaultIntent(this))
        // 可选：结束 MainActivity，防止用户返回
        // finish() 
    }

    //  existing SMS-related methods
    private fun hasSmsReceivePermission(): Boolean =
        ContextCompat.checkSelfPermission(
            this,
            Manifest.permission.RECEIVE_SMS
        ) == PackageManager.PERMISSION_GRANTED

    private fun requestSmsReceivePermission() {
        ActivityCompat.requestPermissions(
            this,
            arrayOf(Manifest.permission.RECEIVE_SMS),
            smsReceivePermissionRequestCode
        )
    }
/*
    private fun registerSmsListener() {
        smsReceiver = object : BroadcastReceiver() {
            override fun onReceive(context: Context, intent: Intent) {
                Log.d("android 端的smslistener 已经SmsReceiver", "onReceive called") // 打印广播接收器是否被调用
                if (Telephony.Sms.Intents.SMS_RECEIVED_ACTION == intent.action) {
                    for (sms in Telephony.Sms.Intents.getMessagesFromIntent(intent)) {
                        val sender = sms.originatingAddress
                        val messageBody = sms.messageBody
                        Log.d("安卓端SmsReceiver", "Received SMS from $sender: $messageBody")
                        Log.d("MainActivity", "安卓端sms注册服务")

                        flutterEngine?.dartExecutor?.binaryMessenger?.let { binaryMessenger ->
                            MethodChannel(binaryMessenger, smsChannel).invokeMethod(
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
        val intentFilter = IntentFilter(Telephony.Sms.Intents.SMS_RECEIVED_ACTION)
        registerReceiver(smsReceiver, intentFilter)
    }
*/

    private fun registerSmsListener() {
        smsReceiver = SmsReceiver() // 使用独立的 SmsReceiver 类创建实例
        val intentFilter = IntentFilter(Telephony.Sms.Intents.SMS_RECEIVED_ACTION)
        registerReceiver(smsReceiver, intentFilter) 
    }


    private fun unregisterSmsListener() {
        smsReceiver?.let {
            unregisterReceiver(it)
            smsReceiver = null
        }
    }

    private fun setSmsNotificationState(
        phoneNumber: String,
        messageContent: String?,
        shouldNotify: Boolean,
        result: Result
    ) {
        if (!notificationManager.isNotificationPolicyAccessGranted) {
            requestNotificationPolicyAccess(result)
        } else {
            updateSmsNotificationState(phoneNumber, messageContent, shouldNotify)
            result.success(null)
        }
    }

    private fun updateSmsNotificationState(
        phoneNumber: String,
        messageContent: String?,
        shouldNotify: Boolean
    ) {
        val smsPackageName = Telephony.Sms.getDefaultSmsPackage(this)
        smsPackageName?.let { packageName ->
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                val channel =
                    notificationManager.getNotificationChannel(getSmsChannelId(packageName))
                channel?.let {
                    if (shouldNotify) {
                        it.importance = NotificationManager.IMPORTANCE_DEFAULT
                    } else {
                        it.importance = NotificationManager.IMPORTANCE_LOW
                    }
                    notificationManager.createNotificationChannel(it)
                }
            } else {
                val importance = if (shouldNotify) {
                    NotificationManager.IMPORTANCE_DEFAULT
                } else {
                    NotificationManager.IMPORTANCE_LOW
                }
                notificationManager.setNotificationPolicy(
                    NotificationManager.Policy(importance, 0, 0)
                )
            }
        }
    }

    private fun getSmsChannelId(packageName: String): String {
        val activeNotifications: Array<StatusBarNotification> =
            notificationManager.activeNotifications
        for (notification in activeNotifications) {
            if (notification.packageName == packageName) {
                return notification.notification.channelId
            }
        }
        return "default_channel_id" // fallback
    }


    // 获取默认短信应用的包名
    @RequiresApi(Build.VERSION_CODES.KITKAT)
    private fun getDefaultSmsPackage(): String? {
        Log.d("MainActivity", "Getting default SMS package name...")

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            // API 31 及以上版本
            Log.d("MainActivity", "Using API 31+ logic.")

            val subscriptionManager =
                getSystemService(Context.TELEPHONY_SUBSCRIPTION_SERVICE) as SubscriptionManager
            val defaultSmsSubscriptionId = SubscriptionManager.getDefaultSmsSubscriptionId()
            Log.d(
                "MainActivity",
                "Default SMS subscription ID: $defaultSmsSubscriptionId"
            ) // 打印订阅 ID

            val smsManager = context.getSystemService(SmsManager::class.java)
                .createForSubscriptionId(defaultSmsSubscriptionId)
            Log.d("MainActivity", "Created SmsManager instance.") // 确认 SmsManager 实例创建成功

            val packageName = Telephony.Sms.getDefaultSmsPackage(this)
            Log.d("MainActivity", "Default SMS package name (API 31+): $packageName")
            return packageName
        } else {
            // API 19 - 30 版本
            Log.d("MainActivity", "Using API 19-30 logic.")

            val packageName = Telephony.Sms.getDefaultSmsPackage(this)
            if (packageName != null) {
                Log.d("MainActivity", "Default SMS package name (API 19-30): $packageName")
                return packageName
            } else {
                Log.d("MainActivity", "Falling back to PackageManager to find default SMS app.")

                val intent = Intent(Intent.ACTION_MAIN)
                intent.addCategory(Intent.CATEGORY_APP_MESSAGING)
                Log.d("MainActivity", "Intent created: $intent") // 打印 Intent 信息

                val resolveInfo =
                    packageManager.resolveActivity(intent, PackageManager.MATCH_DEFAULT_ONLY)
                Log.d("MainActivity", "ResolveInfo: $resolveInfo") // 打印 ResolveInfo 信息

                val packageNameFromPackageManager = resolveInfo?.activityInfo?.packageName
                Log.d(
                    "MainActivity",
                    "Default SMS package name (PackageManager): $packageNameFromPackageManager"
                )
                return packageNameFromPackageManager
            }
        }
    }

    // 设置短信通知通道的重要性
    @RequiresApi(Build.VERSION_CODES.O)
    private fun setSmsNotificationChannelImportance(packageName: String, importance: Int) {
        val notificationManager =
            getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
        val channels = notificationManager.getNotificationChannels()
        for (channel in channels) {
            // 解析通知通道 ID 中的包名
            val channelPackageName = channel.id.split(":").firstOrNull()

            if (channelPackageName == packageName && channel.importance != importance) {
                channel.importance = importance
                notificationManager.createNotificationChannel(channel)
                break
            }
        }
    }


    private fun hasRequiredCallPermissions(): Boolean {
        return hasCallPhonePermission() &&
                hasReadPhoneStatePermission() &&
                (Build.VERSION.SDK_INT < Build.VERSION_CODES.O || hasReadPhoneNumbersPermission())
    }

    private fun hasReadPhoneStatePermission(): Boolean {
        return ContextCompat.checkSelfPermission(
            this,
            Manifest.permission.READ_PHONE_STATE
        ) == PackageManager.PERMISSION_GRANTED
    }

    private fun hasReadPhoneNumbersPermission(): Boolean {
        return ContextCompat.checkSelfPermission(
            this,
            Manifest.permission.READ_PHONE_NUMBERS
        ) == PackageManager.PERMISSION_GRANTED
    }

    // Call Permission Handling
    private fun hasCallPhonePermission(): Boolean {
        return ContextCompat.checkSelfPermission(
            this,
            Manifest.permission.CALL_PHONE
        ) == PackageManager.PERMISSION_GRANTED
    }

    private fun requestNotificationPolicyAccess(result: Result) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            if (notificationManager.isNotificationPolicyAccessGranted) {
                result.success(true)
                return
            }
            try {
                val intent = Intent(Settings.ACTION_NOTIFICATION_POLICY_ACCESS_SETTINGS)
                startActivityForResult(intent, notificationPermissionRequestCode)
            } catch (e: Exception) {
                Log.e("MainActivity", "Cannot open notification settings", e)
                result.error(
                    "CANNOT_OPEN_SETTINGS",
                    "Unable to open notification settings",
                    e.message
                )
            }
        } else {
            result.success(true)
        }
    }

    override fun onDestroy() {
        super.onDestroy()
        unregisterSmsListener()
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            telephonyManager.unregisterTelephonyCallback(CustomTelephonyCallback())
        } else {
            telephonyManager.listen(phoneStateListener, PhoneStateListener.LISTEN_NONE)
        }
    }
}