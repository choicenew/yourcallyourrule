package com.yours.yourcallyourrule

import android.Manifest
import android.app.Activity
import android.app.NotificationManager
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.content.pm.PackageManager
import android.os.Build
import android.provider.Settings
import android.provider.Telephony
import android.service.notification.StatusBarNotification
import android.util.Log

import androidx.core.app.ActivityCompat
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.Result


class SmsChannelHandler(private val activity: Activity, private val flutterEngine: FlutterEngine) {

    val smsChannel = "com.yours.yourcallyourrule/sms_filter"
    private val smsReceivePermissionRequestCode = 123
    val notificationPermissionRequestCode = 456

    private val permissionsHelper = PermissionsHelper(activity) // 创建 PermissionsHelper 实例
    private var smsReceiver: BroadcastReceiver? = null



/*
    init {
        setupSmsChannel()
    }
*/
    fun setupSmsChannel() {
       //  Log.d("SmsChannelHandler", "Setting up SMS channel") // 添加日志输出
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            smsChannel
        ).setMethodCallHandler { call, result ->
    //   Log.d("SmsChannelHandler", "Received method call: ${call.method}") // 添加日志
            when (call.method) {
                "initialize" -> {
                    if (permissionsHelper.hasSmsReceivePermission()) {
                        registerSmsListener()
                        result.success(null)
                      //  Log.d("SmsChannelHandler", "Sms listener initialized successfully") // 添加日志
                    } else {
                         requestSmsReceivePermission() // 在这里也可以直接调用
                        result.error(
                            "PERMISSION_NOT_GRANTED",
                            "SMS receive permission not granted",
                            null
                        )
                    }
                }
                "getDefaultSmsPackage" -> {
                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.KITKAT) {
                        result.success(getDefaultSmsPackage())  // 将包名作为参数传递给 result.success()
                       // Log.d("setupSmsChannel", "setupSmsChannel: ${call.method}, packageName: ${getDefaultSmsPackage()}")
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

    private fun requestSmsReceivePermission() {
        ActivityCompat.requestPermissions(
            activity,
            arrayOf(Manifest.permission.RECEIVE_SMS),
            smsReceivePermissionRequestCode
        )
    }

    fun registerSmsListener(): Boolean {
        smsReceiver = SmsReceiver()
        val intentFilter = IntentFilter(Telephony.Sms.Intents.SMS_RECEIVED_ACTION)
        activity.registerReceiver(smsReceiver, intentFilter)
       // Log.e("android 端registerSmsListener", " 注册成功")
        return true
    }

    fun unregisterSmsListener() {
        smsReceiver?.let {
            activity.unregisterReceiver(it)
            smsReceiver = null
        }
    }

    private fun setSmsNotificationState(
        phoneNumber: String,
        messageContent: String?,
        shouldNotify: Boolean,
        result: Result
    ) {
        if (!isNotificationPolicyAccessGranted()) {
            requestNotificationPolicyAccess(result)
        } else {
            updateSmsNotificationState(phoneNumber, messageContent, shouldNotify)
            result.success(null)
        }
    }

    fun isNotificationPolicyAccessGranted(): Boolean {
        val notificationManager = activity.getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            notificationManager.isNotificationPolicyAccessGranted
        } else {
            true
        }
    }

    private fun requestNotificationPolicyAccess(result: Result) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            val notificationManager = activity.getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
            if (notificationManager.isNotificationPolicyAccessGranted) {
                result.success(true)
                return
            }
            try {
                val intent = Intent(Settings.ACTION_NOTIFICATION_POLICY_ACCESS_SETTINGS)
                activity.startActivityForResult(intent, notificationPermissionRequestCode)
            } catch (e: Exception) {
               // Log.e("MainActivity", "Cannot open notification settings", e)
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

    private fun updateSmsNotificationState(
        phoneNumber: String,
        messageContent: String?,
        shouldNotify: Boolean
    ) {
        val smsPackageName = Telephony.Sms.getDefaultSmsPackage(activity)
        smsPackageName?.let { packageName ->
            val notificationManager = activity.getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                val channel = notificationManager.getNotificationChannel(getSmsChannelId(packageName))
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
                notificationManager.setNotificationPolicy(NotificationManager.Policy(importance, 0, 0))
            }
        }
    }

    private fun getSmsChannelId(packageName: String): String {
        val notificationManager = activity.getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
        val activeNotifications: Array<StatusBarNotification> = notificationManager.activeNotifications
        for (notification in activeNotifications) {
            if (notification.packageName == packageName) {
                return notification.notification.channelId
            }
        }
        return "default_channel_id"
    }

   // 获取默认短信应用的包名
    private fun getDefaultSmsPackage(): String? {
        Log.d("MainActivity", "Getting default SMS package name...")

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            // API 31 及以上版本
        //    Log.d("MainActivity", "Using API 31+ logic.")

            val subscriptionManager = activity.getSystemService(Context.TELEPHONY_SUBSCRIPTION_SERVICE) as android.telephony.SubscriptionManager
            val defaultSmsSubscriptionId = android.telephony.SubscriptionManager.getDefaultSmsSubscriptionId()
         //   Log.d("MainActivity", "Default SMS subscription ID: $defaultSmsSubscriptionId")

            val smsManager = activity.getSystemService(android.telephony.SmsManager::class.java)
                .createForSubscriptionId(defaultSmsSubscriptionId)
        //    Log.d("MainActivity", "Created SmsManager instance.")

            val packageName = Telephony.Sms.getDefaultSmsPackage(activity)
         //   Log.d("MainActivity", "Default SMS package name (API 31+): $packageName")
            return packageName
        } else {
            // API 19 - 30 版本
         //   Log.d("MainActivity", "Using API 19-30 logic.")

            val packageName = Telephony.Sms.getDefaultSmsPackage(activity)
            if (packageName != null) {
          //      Log.d("MainActivity", "Default SMS package name (API 19-30): $packageName")
                return packageName
            } else {
              //  Log.d("MainActivity", "Falling back to PackageManager to find default SMS app.")

                val intent = Intent(Intent.ACTION_MAIN)
                intent.addCategory(Intent.CATEGORY_APP_MESSAGING)
              //  Log.d("MainActivity", "Intent created: $intent")

                val resolveInfo = activity.packageManager.resolveActivity(intent, PackageManager.MATCH_DEFAULT_ONLY)
             //   Log.d("MainActivity", "ResolveInfo: $resolveInfo")

                val packageNameFromPackageManager = resolveInfo?.activityInfo?.packageName
              //  Log.d("MainActivity", "Default SMS package name (PackageManager): $packageNameFromPackageManager")
                return packageNameFromPackageManager
            }
        }
    }

    // 设置短信通知通道的重要性
    private fun setSmsNotificationChannelImportance(packageName: String, importance: Int) {
        val notificationManager = activity.getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
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
}